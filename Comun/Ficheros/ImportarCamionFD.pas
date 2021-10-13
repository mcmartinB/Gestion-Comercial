unit ImportarCamionFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFDImportarCamion = class(TForm)
    btnImportar: TButton;
    btnAceptar: TButton;
    btnCancelar: TButton;
    lblNombre7: TLabel;
    codigo_tp: TBEdit;
    qryCamion: TQuery;
    dsCamion: TDataSource;
    mmoIzq: TMemo;
    mmoDer: TMemo;
    btnCamion: TBGridButton;
    txtCamion: TStaticText;
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
    sCamion: string;
    sBDRemota: string;

    procedure PutBaseDatosRemota( const BDRemota: string );
    procedure ParamToEdit( const ACamion: string );
    function  EditToVar: Boolean;
    procedure VarToParam( var VCamion: string );
    procedure PreparaEntorno;
    function  ImportarCamion: boolean;
    procedure LoadQuerys;
    procedure LoadMemos;


  public
    { Public declarations }
  end;

  function ImportarCamion( const AOwner: TComponent;  const BDRemota: string; var VCamion: string ): Integer;



implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, ImportarCamionMD, bCodeUtils;

var
  FDImportarCamion: TFDImportarCamion;

(*
   RESULT
   -1 -> no quiero importar ningun camion, cancelar
   0  -> camion importado correctamente
   >0 -> error en la importacion
*)

function ImportarCamion( const AOwner: TComponent;  const BDRemota: string; var VCamion: string ): Integer;
begin

  FDImportarCamion:= TFDImportarCamion.Create( AOwner );
  try
    FDImportarCamion.PutBaseDatosRemota( BDRemota );
    FDImportarCamion.ParamToEdit( VCamion );
    FDImportarCamion.PreparaEntorno;
    Result:= FDImportarCamion.ShowModal;
    FDImportarCamion.VarToParam( VCamion );
  finally
    FreeAndNil( FDImportarCamion );
  end;
end;

procedure TFDImportarCamion.FormCreate(Sender: TObject);
begin
  //empresa_e.Tag := kEmpresa;
end;

procedure TFDImportarCamion.PutBaseDatosRemota( const BDRemota: string );
begin
  sBDRemota:= BDRemota;
  qryCamion.DatabaseName:= sBDRemota;
end;

procedure TFDImportarCamion.ParamToEdit( const ACamion: string );
begin
  codigo_tp.Text:= ACamion;
end;

procedure TFDImportarCamion.VarToParam( var VCamion: string );
begin
  VCamion:= sCamion;
end;

function  TFDImportarCamion.EditToVar: Boolean;
begin
  //Hay cambio de estado
  Result:= True;
  sCamion:= Trim( codigo_tp.Text );
end;


procedure TFDImportarCamion.PreparaEntorno;
begin
  codigo_tpChange( codigo_tp );
  if txtCamion.Caption <> '' then
    btnAceptar.Caption:= 'Actualizar'
  else
    btnAceptar.Caption:= 'Insertar';

  btnImportar.Enabled:= True;
  btnAceptar.Enabled:= False;
end;

procedure TFDImportarCamion.btnImportarClick(Sender: TObject);
begin
  if EditToVar then
  begin
    btnAceptar.Enabled:= ImportarCamion;
  end
  else
  begin
    btnAceptar.Enabled:= False;
  end;
end;

procedure TFDImportarCamion.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if ImportarCamionMD.SincronizarCamion( Self, sBDRemota, sCamion,  sMsg ) then
  begin
    ModalResult:= 1;
  end
  else
  begin
    ShowMessage( sMsg );
  end;
end;

procedure TFDImportarCamion.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TFDImportarCamion.LoadQuerys;
begin
  with qryCamion do
  begin
    SQL.Clear;
    SQL.Add('select *                   ');
    SQL.Add('from frf_camiones            ');
    SQL.Add('where camion_c = :camion   ');
  end;
end;

function TFDImportarCamion.ImportarCamion: Boolean;
begin
  //TODO
  LoadQuerys;
  qryCamion.ParamByName('camion').AsString:= sCamion;
  qryCamion.Open;
  if qryCamion.IsEmpty then
  begin
    Result:= False;
    ShowMessage('NO encontrado el Camión en la BD Remota');
  end
  else
  begin
    LoadMemos;
    Result:= True;
  end;
end;

procedure TFDImportarCamion.LoadMemos;
var
  i: Integer;
begin
  mmoIzq.Clear;
  mmoDer.Clear;
  mmoIzq.Font.Style:= mmoIzq.Font.Style + [fsBold];
  i:= 0;
  while i < qryCamion.Fields.Count do
  begin
    mmoIzq.Lines.Add( UpperCase(qryCamion.Fields[i].FieldName) );
    mmoDer.Lines.Add( qryCamion.Fields[i].AsString );
    inc( i );
  end;
end;

procedure TFDImportarCamion.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDImportarCamion.FormShow(Sender: TObject);
begin
  codigo_tp.SetFocus;
end;

procedure TFDImportarCamion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryCamion.Close;
end;


procedure TFDImportarCamion.codigo_tpChange(Sender: TObject);
begin
  txtCamion.Caption:= desCamion( codigo_tp.Text );
  if txtCamion.Caption <> '' then
    btnAceptar.Caption:= 'Actualizar'
  else
    btnAceptar.Caption:= 'Insertar';
end;

end.
