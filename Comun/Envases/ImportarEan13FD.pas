unit ImportarEan13FD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFDImportarEan13 = class(TForm)
    btnImportar: TButton;
    btnAceptar: TButton;
    btnCancelar: TButton;
    bgrdRejillaFlotante: TBGrid;
    lblNombre6: TLabel;
    empresa_e: TBEdit;
    btnEmpresa: TBGridButton;
    txtEmpresa: TStaticText;
    lblNombre7: TLabel;
    ean13_e: TBEdit;
    dbgrdEan13: TDBGrid;
    qryEan13: TQuery;
    dsEan13: TDataSource;
    mmoIzq: TMemo;
    mmoDer: TMemo;
    procedure btnImportarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure empresa_eChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgrdEan13CellClick(Column: TColumn);
  private
    { Private declarations }
    sEmpresa, sEan13: string;
    sBDRemota: string;

    procedure PutBaseDatosRemota( const BDRemota: string );
    procedure ParamToEdit( const AEmpresa, AEan13: string );
    function  EditToVar: Boolean;
    procedure VarToParam( var VEmpresa, VEan13: string );
    procedure PreparaEntorno;
    function  ImportarEnvase: boolean;
    procedure LoadQuerys;
    procedure LoadMemos;


  public
    { Public declarations }
  end;

  function ImportarEan13( const AOwner: TComponent;  const BDRemota: string; var VEmpresa, VEan13: string ): Integer;



implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, ImportarEan13MD, bCodeUtils;

var
  FDImportarEan13: TFDImportarEan13;

(*
   RESULT
   -1 -> no quiero importar ningun envase, cancelar
   0  -> envase importado correctamente
   >0 -> error en la importacion
*)

function ImportarEan13( const AOwner: TComponent;  const BDRemota: string; var VEmpresa, VEan13: string ): Integer;
begin

  FDImportarEan13:= TFDImportarEan13.Create( AOwner );
  try
    FDImportarEan13.PutBaseDatosRemota( BDRemota );
    FDImportarEan13.ParamToEdit( VEmpresa, VEan13 );
    FDImportarEan13.PreparaEntorno;
    Result:= FDImportarEan13.ShowModal;
    FDImportarEan13.VarToParam( VEmpresa, VEan13 );
  finally
    FreeAndNil( FDImportarEan13 );
  end;
end;

procedure TFDImportarEan13.FormCreate(Sender: TObject);
begin
  empresa_e.Tag := kEmpresa;
end;

procedure TFDImportarEan13.PutBaseDatosRemota( const BDRemota: string );
begin
  sBDRemota:= BDRemota;
  qryEan13.DatabaseName:= sBDRemota;
end;

procedure TFDImportarEan13.ParamToEdit( const AEmpresa, AEan13: string );
begin
  empresa_e.Text:= AEmpresa;
  ean13_e.Text:= AEan13;
end;

procedure TFDImportarEan13.VarToParam( var VEmpresa, VEan13: string );
begin
  VEmpresa:= sEmpresa;
  VEan13:= sEan13;
end;

function  TFDImportarEan13.EditToVar: Boolean;
begin
  if txtEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
    Result:= False;
  end
  else
  if DigitoControlEAN13(ean13_e.Text) = False then
  begin
    ShowMessage('Código EAN13 no válido.');
    Result:= False;
  end
  else
  begin
    //Hay cambio de estado
    Result:= True;
    sEmpresa:= Trim( empresa_e.Text );
    sEan13:= Trim( ean13_e.Text );
  end;
end;


procedure TFDImportarEan13.PreparaEntorno;
begin
  btnImportar.Enabled:= True;
  btnAceptar.Caption:= 'Actualizar';
  btnAceptar.Enabled:= False;
end;

procedure TFDImportarEan13.btnImportarClick(Sender: TObject);
begin
  if EditToVar then
  begin
    btnAceptar.Enabled:= ImportarEnvase;
  end
  else
  begin
    btnAceptar.Enabled:= False;
  end;
end;

procedure TFDImportarEan13.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if ImportarEan13MD.SincronizarEan13( Self, sBDRemota, sEmpresa, sEan13,  sMsg ) then
  begin
    ModalResult:= 1;
  end
  else
  begin
    ShowMessage( sMsg );
  end;
end;

procedure TFDImportarEan13.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TFDImportarEan13.LoadQuerys;
begin
  with qryEan13 do
  begin
    SQL.Clear;
    SQL.Add(' select ( SELECT DESCRIPCION_P                        ');
    SQL.Add('            FROM FRF_PRODUCTOS                        ');
    SQL.Add('          WHERE PRODUCTO_P = PRODUCTOP_E ) PRODUCTO,  ');
    SQL.Add('               ( SELECT max(env.descripcion_e)        ');
    SQL.Add('          FROM FRF_envases env                        ');
    SQL.Add('          WHERE env.envase_e = e13.envase_e ) envase,   ');
    SQL.Add('        MARCA_E MARCA, CATEGORIA_e CATEGORIA, CALIBRE_e CALIBRE, ');
    SQL.Add('        DESCRIPCION_e DESCRIPCION,                               ');
    SQL.Add('        case when AGRUPACION_e = 1 then ''UNIDAD''                 ');
    SQL.Add('             when AGRUPACION_e = 2 then ''CAJA''                   ');
    SQL.Add('             when AGRUPACION_e = 3 then ''PALET''                  ');
    SQL.Add('             else  ''ERROR'' end agrupacion, fecha_baja_e Baja       ');
    SQL.Add('from frf_ean13 e13 ');
    SQL.Add('where empresa_e = :EMPRESA  ');
    SQL.Add('AND CODIGO_E = :EAN13 ');
   SQL.Add('  order by 1,2,3,4,5 ');
  end;
end;

function TFDImportarEan13.ImportarEnvase: Boolean;
begin
  LoadQuerys;
  qryEan13.ParamByName('empresa').AsString:= sEmpresa;
  qryEan13.ParamByName('ean13').AsString:= sEan13;
  qryEan13.Open;
  if qryEan13.IsEmpty then
  begin
    Result:= False;
    ShowMessage('NO encontrado Ean13 en la BD Remota');
  end
  else
  begin
    LoadMemos;
    Result:= True;
  end;
end;

procedure TFDImportarEan13.LoadMemos;
var
  i: Integer;
begin
  mmoIzq.Clear;
  mmoDer.Clear;
  mmoIzq.Font.Style:= mmoIzq.Font.Style + [fsBold];
  i:= 0;
  while i < qryEan13.Fields.Count do
  begin
    mmoIzq.Lines.Add( UpperCase(qryEan13.Fields[i].FieldName) );
    mmoDer.Lines.Add( qryEan13.Fields[i].AsString );
    inc( i );
  end;
end;

procedure TFDImportarEan13.btnEmpresaClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
  end;
end;

procedure TFDImportarEan13.empresa_eChange(Sender: TObject);
begin
  txtEmpresa.Caption := desEmpresa(empresa_e.Text);
end;

procedure TFDImportarEan13.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDImportarEan13.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryEan13.Close;
end;

procedure TFDImportarEan13.dbgrdEan13CellClick(Column: TColumn);
begin
  LoadMemos;
end;

end.
