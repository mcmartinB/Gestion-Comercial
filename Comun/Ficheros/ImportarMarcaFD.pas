unit ImportarMarcaFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFDImportarMarca = class(TForm)
    btnImportar: TButton;
    btnAceptar: TButton;
    btnCancelar: TButton;
    lblNombre7: TLabel;
    codigo_tp: TBEdit;
    qryMarca: TQuery;
    dsMarca: TDataSource;
    mmoIzq: TMemo;
    mmoDer: TMemo;
    btnMarca: TBGridButton;
    txtMarca: TStaticText;
    procedure btnImportarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure codigo_tpChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    sMarca: string;
    sBDRemota: string;

    procedure PutBaseDatosRemota( const BDRemota: string );
    procedure ParamToEdit( const AMarca: string );
    function  EditToVar: Boolean;
    procedure VarToParam( var VMarca: string );
    procedure PreparaEntorno;
    function  ImportarMarca: boolean;
    procedure LoadQuerys;
    procedure LoadMemos;


  public
    { Public declarations }
  end;

  function ImportarMarca( const AOwner: TComponent;  const BDRemota: string; var VMarca: string ): Integer;



implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, ImportarMarcaMD, bCodeUtils;

var
  FDImportarMarca: TFDImportarMarca;

(*
   RESULT
   -1 -> no quiero importar ninguna marca, cancelar
   0  -> marca importado correctamente
   >0 -> error en la importacion
*)

function ImportarMarca( const AOwner: TComponent;  const BDRemota: string; var VMarca: string ): Integer;
begin

  FDImportarMarca:= TFDImportarMarca.Create( AOwner );
  try
    FDImportarMarca.PutBaseDatosRemota( BDRemota );
    FDImportarMarca.ParamToEdit( VMarca );
    FDImportarMarca.PreparaEntorno;
    Result:= FDImportarMArca.ShowModal;
    FDImportarMarca.VarToParam( VMarca );
  finally
    FreeAndNil( FDImportarMarca );
  end;
end;

procedure TFDImportarMarca.FormCreate(Sender: TObject);
begin
  //empresa_e.Tag := kEmpresa;
end;

procedure TFDImportarMarca.PutBaseDatosRemota( const BDRemota: string );
begin
  sBDRemota:= BDRemota;
  qryMarca.DatabaseName:= sBDRemota;
end;

procedure TFDImportarMarca.ParamToEdit( const AMarca: string );
begin
  codigo_tp.Text:= AMarca;
end;

procedure TFDImportarMarca.VarToParam( var VMarca: string );
begin
  VMarca:= sMarca;
end;

function  TFDImportarMarca.EditToVar: Boolean;
begin
  //Hay cambio de estado
  Result:= True;
  sMarca:= Trim( codigo_tp.Text );
end;


procedure TFDImportarMarca.PreparaEntorno;
begin
  codigo_tpChange( codigo_tp );
  if txtMarca.Caption <> '' then
    btnAceptar.Caption:= 'Actualizar'
  else
    btnAceptar.Caption:= 'Insertar';

  btnImportar.Enabled:= True;
  btnAceptar.Enabled:= False;
end;

procedure TFDImportarMarca.btnImportarClick(Sender: TObject);
begin
  if EditToVar then
  begin
    btnAceptar.Enabled:= ImportarMarca;
  end
  else
  begin
    btnAceptar.Enabled:= False;
  end;
end;

procedure TFDImportarMarca.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if ImportarMarcaMD.SincronizarMarca( Self, sBDRemota, sMarca,  sMsg ) then
  begin
    ModalResult:= 1;
  end
  else
  begin
    ShowMessage( sMsg );
  end;
end;

procedure TFDImportarMarca.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TFDImportarMarca.LoadQuerys;
begin
  with qryMarca do
  begin
    SQL.Clear;
    SQL.Add('select *                   ');
    SQL.Add('from frf_marcas            ');
    SQL.Add('where codigo_m = :marca    ');
  end;
end;

function TFDImportarMarca.ImportarMarca: Boolean;
begin
  //TODO
  LoadQuerys;
  qryMarca.ParamByName('marca').AsString:= sMarca;
  qryMarca.Open;
  if qryMarca.IsEmpty then
  begin
    Result:= False;
    ShowMessage('NO encontrado la marca en la BD Remota');
  end
  else
  begin
    LoadMemos;
    Result:= True;
  end;
end;

procedure TFDImportarMarca.LoadMemos;
var
  i: Integer;
begin
  mmoIzq.Clear;
  mmoDer.Clear;
  mmoIzq.Font.Style:= mmoIzq.Font.Style + [fsBold];
  i:= 0;
  while i < qryMarca.Fields.Count do
  begin
    mmoIzq.Lines.Add( UpperCase(qryMarca.Fields[i].FieldName) );
    mmoDer.Lines.Add( qryMarca.Fields[i].AsString );
    inc( i );
  end;
end;

procedure TFDImportarMarca.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDImportarMarca.FormShow(Sender: TObject);
begin
  codigo_tp.SetFocus;
end;

procedure TFDImportarMarca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryMarca.Close;
end;


procedure TFDImportarMarca.codigo_tpChange(Sender: TObject);
begin
  txtMarca.Caption:= desMarca( codigo_tp.Text );
  if txtMArca.Caption <> '' then
    btnAceptar.Caption:= 'Actualizar'
  else
    btnAceptar.Caption:= 'Insertar';
end;

end.
