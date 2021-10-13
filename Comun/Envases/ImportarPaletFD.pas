unit ImportarPaletFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFDImportarPalet = class(TForm)
    btnImportar: TButton;
    btnAceptar: TButton;
    btnCancelar: TButton;
    lblNombre7: TLabel;
    codigo_tp: TBEdit;
    qryPalet: TQuery;
    dsPalet: TDataSource;
    mmoIzq: TMemo;
    mmoDer: TMemo;
    lblPalet: TLabel;
    procedure btnImportarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure codigo_tpChange(Sender: TObject);
  private
    { Private declarations }
    sPalet: string;
    sBDRemota: string;

    procedure PutBaseDatosRemota( const BDRemota: string );
    procedure ParamToEdit( const APalet: string );
    function  EditToVar: Boolean;
    procedure VarToParam( var VPalet: string );
    procedure PreparaEntorno;
    function  ImportarPalet: boolean;
    procedure LoadQuerys;
    procedure LoadMemos;


  public
    { Public declarations }
  end;

  function ImportarPalet( const AOwner: TComponent;  const BDRemota: string; var VPalet: string ): Integer;



implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, ImportarPaletMD, bCodeUtils;

var
  FDImportarPalet: TFDImportarPalet;

(*
   RESULT
   -1 -> no quiero importar ningun envase, cancelar
   0  -> envase importado correctamente
   >0 -> error en la importacion
*)

function ImportarPalet( const AOwner: TComponent;  const BDRemota: string; var VPalet: string ): Integer;
begin

  FDImportarPalet:= TFDImportarPalet.Create( AOwner );
  try
    FDImportarPalet.PutBaseDatosRemota( BDRemota );
    FDImportarPalet.ParamToEdit( VPalet );
    FDImportarPalet.PreparaEntorno;
    Result:= FDImportarPalet.ShowModal;
    FDImportarPalet.VarToParam( VPalet );
  finally
    FreeAndNil( FDImportarPalet );
  end;
end;

procedure TFDImportarPalet.FormCreate(Sender: TObject);
begin
  //empresa_e.Tag := kEmpresa;
end;

procedure TFDImportarPalet.PutBaseDatosRemota( const BDRemota: string );
begin
  sBDRemota:= BDRemota;
  qryPalet.DatabaseName:= sBDRemota;
end;

procedure TFDImportarPalet.ParamToEdit( const APalet: string );
begin
  codigo_tp.Text:= APalet;
end;

procedure TFDImportarPalet.VarToParam( var VPalet: string );
begin
  VPalet:= sPalet;
end;

function  TFDImportarPalet.EditToVar: Boolean;
begin
  //Hay cambio de estado
  Result:= True;
  sPalet:= Trim( codigo_tp.Text );
end;


procedure TFDImportarPalet.PreparaEntorno;
begin
  codigo_tpChange( codigo_tp );
  if lblPalet.Caption <> '' then
    btnAceptar.Caption:= 'Actualizar'
  else
    btnAceptar.Caption:= 'Insertar';

  btnImportar.Enabled:= True;
  btnAceptar.Enabled:= False;
end;

procedure TFDImportarPalet.btnImportarClick(Sender: TObject);
begin
  if EditToVar then
  begin
    btnAceptar.Enabled:= ImportarPalet;
  end
  else
  begin
    btnAceptar.Enabled:= False;
  end;
end;

procedure TFDImportarPalet.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if ImportarPaletMD.SincronizarPalet( Self, sBDRemota, sPalet,  sMsg ) then
  begin
    ModalResult:= 1;
  end
  else
  begin
    ShowMessage( sMsg );
  end;
end;

procedure TFDImportarPalet.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TFDImportarPalet.LoadQuerys;
begin
  with qryPalet do
  begin
    SQL.Clear;
    SQL.Add('select codigo_tp codigo, ');
    SQL.Add('       descripcion_tp descripcion, ');
    SQL.Add('       kilos_tp tara, ');
    SQL.Add('       env_comer_operador_tp operador, ');
    SQL.Add('       (select des_operador_eco from frf_env_comer_operadores where cod_operador_eco = env_comer_operador_tp ) des_operador, ');
    SQL.Add('       env_comer_producto_tp cod_operador, ');
    SQL.Add('       (select des_producto_ecp from frf_env_comer_productos where cod_operador_ecp = env_comer_operador_tp and cod_producto_ecp = env_comer_producto_tp ) des_palet_operador ');
    SQL.Add('from frf_tipo_Palets ');
    SQL.Add('where codigo_tp = :palet ');
  end;
end;

function TFDImportarPalet.ImportarPalet: Boolean;
begin
  //TODO
  LoadQuerys;
  qryPalet.ParamByName('palet').AsString:= sPalet;
  qryPalet.Open;
  if qryPalet.IsEmpty then
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

procedure TFDImportarPalet.LoadMemos;
var
  i: Integer;
begin
  mmoIzq.Clear;
  mmoDer.Clear;
  mmoIzq.Font.Style:= mmoIzq.Font.Style + [fsBold];
  i:= 0;
  while i < qryPalet.Fields.Count do
  begin
    mmoIzq.Lines.Add( UpperCase(qryPalet.Fields[i].FieldName) );
    mmoDer.Lines.Add( qryPalet.Fields[i].AsString );
    inc( i );
  end;
end;

procedure TFDImportarPalet.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  (*
  if (bgrdRejillaFlotante.Visible) then
           //No hacemos nada
     Exit;
  *)
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

procedure TFDImportarPalet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qrypalet.Close;
end;


procedure TFDImportarPalet.codigo_tpChange(Sender: TObject);
begin
  lblPalet.Caption:= desTipoPalet( codigo_tp.Text );
  if lblPalet.Caption <> '' then
    btnAceptar.Caption:= 'Actualizar'
  else
    btnAceptar.Caption:= 'Insertar';  
end;

end.
