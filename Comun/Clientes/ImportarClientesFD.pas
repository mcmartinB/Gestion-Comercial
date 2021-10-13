unit ImportarClientesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFDImportarClientes = class(TForm)
    btnImportar: TButton;
    btnAceptar: TButton;
    qryClientes: TQuery;
    btnCancelar: TButton;
    bgrdRejillaFlotante: TBGrid;
    lblNombre7: TLabel;
    cliente_c: TBEdit;
    btnCliente: TBGridButton;
    txtCliente: TStaticText;
    dbgrdSuministros: TDBGrid;
    qrySuministros: TQuery;
    dsSuministros: TDataSource;
    mmoIzq: TMemo;
    mmoDer: TMemo;
    dbgrdEnvases: TDBGrid;
    qryEnvases_: TQuery;
    dsEnvases: TDataSource;
    procedure btnImportarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cliente_cChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnClienteClick(Sender: TObject);
  private
    { Private declarations }
    bAlta: boolean;
    sCliente: string;
    sBDRemota: string;

    procedure PutBaseDatosRemota( const BDRemota: string );
    procedure ParamToEdit( const ACliente: string; const AAlta: boolean );
    function  EditToVar: Boolean;
    procedure VarToParam( var VCliente: string; var VAlta: boolean );
    procedure PreparaEntorno;
    function  ImportarCliente: boolean;
    procedure LoadQuerys;
    function  CambioDeEstado( const ANew: Boolean ): Boolean;
    procedure LoadMemos;


  public
    { Public declarations }
  end;

  function ImportarCliente( const AOwner: TComponent;  const BDRemota: string; var VCliente: string; var VAlta: boolean ): Integer;



implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, ImportarClientesMD;

var
  FDImportarClientes: TFDImportarClientes;

(*
   RESULT
   -1 -> no quiero importar ningun envase, cancelar
   0  -> envase importado correctamente
   >0 -> error en la importacion
*)
function ImportarCliente( const AOwner: TComponent; const BDRemota: string; var VCliente: string; var VAlta: Boolean ): Integer;
begin

  FDImportarClientes:= TFDImportarClientes.Create( AOwner );
  try
    FDImportarClientes.PutBaseDatosRemota( BDRemota );
    FDImportarClientes.ParamToEdit( VCliente, VAlta );
    FDImportarClientes.PreparaEntorno;
    Result:= FDImportarClientes.ShowModal;
    FDImportarClientes.VarToParam( VCliente, VAlta );
  finally
    FreeAndNil( FDImportarClientes );
  end;
end;

procedure TFDImportarClientes.FormCreate(Sender: TObject);
begin
  cliente_c.Tag := kCliente;
end;

procedure TFDImportarClientes.PutBaseDatosRemota( const BDRemota: string );
begin
  sBDRemota:= BDRemota;
  qryClientes.DatabaseName:= sBDRemota;
  qryEnvases_.DatabaseName:= sBDRemota;
  qrySuministros.DatabaseName:= sBDRemota;
end;

procedure TFDImportarClientes.ParamToEdit( const ACliente: string; const AAlta: boolean );
begin
  cliente_c.Text:= ACliente;
  bAlta:= AAlta;
end;

procedure TFDImportarClientes.VarToParam( var VCliente: string; var VAlta: boolean );
begin
  VCliente:= sCliente;
  VAlta:= bAlta;
end;

function  TFDImportarClientes.EditToVar: Boolean;
var
  bAux: Boolean;
begin
  //Hay cambio de estado

  bAux:= txtCliente.Caption = '';
  if bAux <> bAlta then
    Result:= CambioDeEstado( bAux )
  else
    Result:= True;
  if Result then
  begin
    sCliente:= Trim( cliente_c.Text );
  end;
end;

function  TFDImportarClientes.CambioDeEstado( const ANew: Boolean ): Boolean;
begin
  //Pasa a alta
  if ANew then
  begin
    Result:= AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: El artículo elegido no esta en la Base de Datos de origen', 'CAMBIO DE ESTADO A ALTA',
                                       'Confirmo que quiero dar de alta el nuevo artículo', 'Cambiar a ALTA') = mrIgnore;
    if Result then
    begin
      bAlta:= ANew;
      btnAceptar.Caption:= 'Insertar';
    end;
  end
  else
  //Pasa a modificar
  begin
    Result:= AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: El artículo elegido ya existe en la Base de Datos de origen', 'CAMBIO DE ESTADO A ACTUALIZAR',
                                       'Confirmo que quiero actualizar el artículo existente', 'Cambiar a ACTUALIZAR')  = mrIgnore;
    if Result then
    begin
      bAlta:= ANew;
      btnAceptar.Caption:= 'Actualizar';
    end;
  end;
end;


procedure TFDImportarClientes.PreparaEntorno;
begin
  btnImportar.Enabled:= True;

  cliente_c.Enabled:= bAlta;
  btnCliente.Enabled:= bAlta;

  if bAlta then
  begin
    btnAceptar.Caption:= 'Insertar';
    btnAceptar.Enabled:= False;
  end
  else
  begin
    btnAceptar.Caption:= 'Actualizar';
    btnAceptar.Enabled:= False;
  end;
end;

procedure TFDImportarClientes.btnImportarClick(Sender: TObject);
begin
  if EditToVar then
  begin
    btnAceptar.Enabled:= ImportarCliente;
  end
  else
  begin
    btnAceptar.Enabled:= False;
  end;
end;

procedure TFDImportarClientes.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  ModalResult:= 1;
  if ImportarClientesMD.SincronizarCliente( Self, sBDRemota, sCliente, bAlta, sMsg ) then
  begin
    ModalResult:= 1;
  end
  else
  begin
    ShowMessage( sMsg );
  end;
end;

procedure TFDImportarClientes.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TFDImportarClientes.btnClienteClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCliente: DespliegaRejilla(btnCliente);
  end;
end;

procedure TFDImportarClientes.LoadQuerys;
begin
  with qryClientes do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_c cod_cliente, nombre_c des_cliente, nif_c nif, ');
    SQL.Add('        cta_cliente_c cuenta, domicilio_c domicilio, poblacion_c poblacion, cod_postal_c cod_postal, ');
    SQL.Add('        pais_c apis, telefono_c telefono, moneda_c moneda, email_alb_c correo ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where cliente_c = :cliente ');
  end;
  with qryEnvases_ do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ce, envase_ce envase, descripcion_ce, variedad_ce, unidad_fac_ce ');
    SQL.Add(' from frf_clientes_env ');
    SQL.Add(' where cliente_ce = :cliente ');
  end;
  with qrySuministros do
  begin
    SQL.Clear;
    SQL.Add('select dir_sum_ds suministro, nombre_ds nombre ');
    SQL.Add('from frf_dir_sum ');
    SQL.Add('where cliente_ds = :cliente ');
  end;
end;

function TFDImportarClientes.ImportarCliente: Boolean;
begin
  LoadQuerys;
  qryClientes.ParamByName('cliente').AsString:= sCliente;
  qryClientes.Open;
  if qryClientes.IsEmpty then
  begin
    Result:= False;
    ShowMessage('NO encontrado cliente en la BD Remota');
  end
  else
  begin
    LoadMemos;
    qryEnvases_.ParamByName('cliente').AsString:= sCliente;
    qryEnvases_.Open;

    qrySuministros.ParamByName('cliente').AsString:= sCliente;
    qrySuministros.Open;

    Result:= True;
  end;
end;

procedure TFDImportarClientes.LoadMemos;
var
  i: Integer;
begin
  mmoIzq.Clear;
  mmoDer.Clear;
  mmoIzq.Font.Style:= mmoIzq.Font.Style + [fsBold];
  i:= 0;
  while i < qryClientes.Fields.Count do
  begin
    mmoIzq.Lines.Add( UpperCase(qryClientes.Fields[i].FieldName) );
    mmoDer.Lines.Add( qryClientes.Fields[i].AsString );
    inc( i );
  end;
end;

procedure TFDImportarClientes.cliente_cChange(Sender: TObject);
begin
  txtCliente.Caption := desCliente(cliente_c.Text);
end;

procedure TFDImportarClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (bgrdRejillaFlotante.Visible) then
           //No hacemos nada
     Exit;

  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
  end;
end;

procedure TFDImportarClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryClientes.Close;
  qryEnvases_.Close;
  qrySuministros.Close;
end;

end.
