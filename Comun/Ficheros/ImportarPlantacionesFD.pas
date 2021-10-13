unit ImportarPlantacionesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFDImportarPlantaciones = class(TForm)
    btnImportar: TButton;
    btnAceptar: TButton;
    btnCancelar: TButton;
    bgrdRejillaFlotante: TBGrid;
    lblNombre6: TLabel;
    empresa_p: TBEdit;
    btnEmpresa: TBGridButton;
    txtEmpresa: TStaticText;
    lblNombre7: TLabel;
    plantacion_p: TBEdit;
    dbgrdPlantacion: TDBGrid;
    qryPlantacion: TQuery;
    dsPlantacion: TDataSource;
    mmoIzq: TMemo;
    mmoDer: TMemo;
    lbl1: TLabel;
    ano_semana_p: TBEdit;
    lbl2: TLabel;
    producto_p: TBEdit;
    lbl3: TLabel;
    cosechero_p: TBEdit;
    procedure btnImportarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure empresa_pChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgrdPlantacionCellClick(Column: TColumn);
  private
    { Private declarations }
    sEmpresa, sProducto, sCosechero, sPlantacion, sAnySemana: string;
    sBDRemota: string;

    procedure PutBaseDatosRemota( const BDRemota: string );
    procedure ParamToEdit( const AEmpresa, AProducto, ACosechero, APlantacion, AAnySemana: string );
    function  EditToVar: Boolean;
    procedure VarToParam( var VEmpresa, VProducto, VCosechero, VPlantacion, VAnySemana: string );
    procedure PreparaEntorno;
    function  ImportarEnvase: boolean;
    procedure LoadQuerys;
    procedure LoadMemos;


  public
    { Public declarations }
  end;

  function ImportarPlantacion( const AOwner: TComponent;  const BDRemota: string; var VEmpresa, VProducto, VCosechero, VPlantacion, VAnySemana: string ): Integer;



implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, ImportarPlantacionesMD, bCodeUtils;

var
  FDImportarPlantaciones: TFDImportarPlantaciones;

(*
   RESULT
   -1 -> no quiero importar ningun envase, cancelar
   0  -> envase importado correctamente
   >0 -> error en la importacion
*)

function ImportarPlantacion( const AOwner: TComponent;  const BDRemota: string; var VEmpresa, VProducto, VCosechero, VPlantacion, VAnySemana: string ): Integer;
begin
  FDImportarPlantaciones:= TFDImportarPlantaciones.Create( AOwner );
  try
    FDImportarPlantaciones.PutBaseDatosRemota( BDRemota );
    FDImportarPlantaciones.ParamToEdit( VEmpresa, VProducto, VCosechero, VPlantacion, VAnySemana );
    FDImportarPlantaciones.PreparaEntorno;
    Result:= FDImportarPlantaciones.ShowModal;
    FDImportarPlantaciones.VarToParam( VEmpresa, VProducto, VCosechero, VPlantacion, VAnySemana );
  finally
    FreeAndNil( FDImportarPlantaciones );
  end;
end;

procedure TFDImportarPlantaciones.FormCreate(Sender: TObject);
begin
  empresa_p.Tag := kEmpresa;
end;

procedure TFDImportarPlantaciones.PutBaseDatosRemota( const BDRemota: string );
begin
  sBDRemota:= BDRemota;
  qryPlantacion.DatabaseName:= sBDRemota;
end;

procedure TFDImportarPlantaciones.ParamToEdit( const AEmpresa, AProducto, ACosechero, APlantacion, AAnySemana: string );
begin
  empresa_p.Text:= AEmpresa;
  producto_p.Text:= AProducto;
  cosechero_p.Text:= ACosechero;
  Plantacion_p.Text:= APlantacion;
  ano_semana_p.Text:= AAnySemana;
end;

procedure TFDImportarPlantaciones.VarToParam( var VEmpresa, VProducto, VCosechero, VPlantacion, VAnySemana: string );
begin
  VEmpresa:= sEmpresa;
  VProducto:= sProducto;
  VCosechero:= sCosechero;
  VPlantacion:= sPlantacion;
  VAnySemana:= sAnySemana;
end;

function  TFDImportarPlantaciones.EditToVar: Boolean;
begin
  if txtEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
    Result:= False;
  end
  else
  if producto_p.Text = '' then
  begin
    ShowMessage('Falta el código del producto o es incorrecto.');
    Result:= False;
  end
  else
  if cosechero_p.Text = '' then
  begin
    ShowMessage('Falta el código del cosechero o es incorrecto.');
    Result:= False;
  end
  else
  if plantacion_p.Text = '' then
  begin
    ShowMessage('Falta el código de la plantación o es incorrecto.');
    Result:= False;
  end
  else
  if ano_semana_p.Text = '' then
  begin
    ShowMessage('Falta el código del año/semana o es incorrecto.');
    Result:= False;
  end
  else
  begin
    //Hay cambio de estado
    Result:= True;
    sEmpresa:= Trim( empresa_p.Text );
    sProducto:= Trim( producto_p.Text );
    sCosechero:= Trim( cosechero_p.Text );
    sPlantacion:= Trim( Plantacion_p.Text );
    sAnySemana:= Trim( ano_semana_p.Text );
  end;
end;


procedure TFDImportarPlantaciones.PreparaEntorno;
begin
  btnImportar.Enabled:= True;
  btnAceptar.Caption:= 'Actualizar';
  btnAceptar.Enabled:= False;
end;

procedure TFDImportarPlantaciones.btnImportarClick(Sender: TObject);
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

procedure TFDImportarPlantaciones.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if ImportarPlantacionesMD.SincronizarPlantacion( Self, sBDRemota, sEmpresa, sProducto, sCosechero, sPlantacion, sAnySemana, sMsg ) then
  begin
    ModalResult:= 1;
  end
  else
  begin
    ShowMessage( sMsg );
  end;
end;

procedure TFDImportarPlantaciones.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TFDImportarPlantaciones.LoadQuerys;
begin
  with qryPlantacion do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_Plantaciones  ');
    SQL.Add('where empresa_p = :EMPRESA  ');
    SQL.Add('and producto_p = :producto ');
    SQL.Add('and cosechero_p = :cosechero ');
    SQL.Add('and plantacion_p = :plantacion ');
    SQL.Add('and ano_semana_p = :ano_semana ');
  end;
end;

function TFDImportarPlantaciones.ImportarEnvase: Boolean;
begin
  LoadQuerys;
  qryPlantacion.ParamByName('empresa').AsString:= sEmpresa;
  qryPlantacion.ParamByName('producto').AsString:= sProducto;
  qryPlantacion.ParamByName('cosechero').AsString:= sCosechero;
  qryPlantacion.ParamByName('plantacion').AsString:= sPlantacion;
  qryPlantacion.ParamByName('ano_semana').AsString:= sAnySemana;

  qryPlantacion.Open;
  if qryPlantacion.IsEmpty then
  begin
    Result:= False;
    ShowMessage('NO encontrado Plantacion en la BD Remota');
  end
  else
  begin
    LoadMemos;
    Result:= True;
  end;
end;

procedure TFDImportarPlantaciones.LoadMemos;
var
  i: Integer;
begin
  mmoIzq.Clear;
  mmoDer.Clear;
  mmoIzq.Font.Style:= mmoIzq.Font.Style + [fsBold];
  i:= 0;
  while i < qryPlantacion.Fields.Count do
  begin
    mmoIzq.Lines.Add( UpperCase(qryPlantacion.Fields[i].FieldName) );
    mmoDer.Lines.Add( qryPlantacion.Fields[i].AsString );
    inc( i );
  end;
end;

procedure TFDImportarPlantaciones.btnEmpresaClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
  end;
end;

procedure TFDImportarPlantaciones.empresa_pChange(Sender: TObject);
begin
  txtEmpresa.Caption := desEmpresa(empresa_p.Text);
end;

procedure TFDImportarPlantaciones.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDImportarPlantaciones.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryPlantacion.Close;
end;

procedure TFDImportarPlantaciones.dbgrdPlantacionCellClick(Column: TColumn);
begin
  LoadMemos;
end;

end.
