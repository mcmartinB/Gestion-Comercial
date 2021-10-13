unit ImportarTransportistaFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFDImportarTransportista = class(TForm)
    btnImportar: TButton;
    btnAceptar: TButton;
    btnCancelar: TButton;
    lblNombre7: TLabel;
    codigo_tp: TBEdit;
    qryTransportista: TQuery;
    dsTransportista: TDataSource;
    mmoIzq: TMemo;
    mmoDer: TMemo;
    btnTransportista: TBGridButton;
    txtTransportista: TStaticText;
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
    sTransportista: string;
    sBDRemota: string;

    procedure PutBaseDatosRemota( const BDRemota: string );
    procedure ParamToEdit( const ATransportista: string );
    function  EditToVar: Boolean;
    procedure VarToParam( var VTransportista: string );
    procedure PreparaEntorno;
    function  ImportarTransportista: boolean;
    procedure LoadQuerys;
    procedure LoadMemos;


  public
    { Public declarations }
  end;

  function ImportarTransportista( const AOwner: TComponent;  const BDRemota: string; var VTransportista: string ): Integer;



implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, ImportarTransportistaMD, bCodeUtils;

var
  FDImportarTransportista: TFDImportarTransportista;

(*
   RESULT
   -1 -> no quiero importar ningun transportista, cancelar
   0  -> transportista importado correctamente
   >0 -> error en la importacion
*)

function ImportarTransportista( const AOwner: TComponent;  const BDRemota: string; var VTransportista: string ): Integer;
begin

  FDImportarTransportista:= TFDImportarTransportista.Create( AOwner );
  try
    FDImportarTransportista.PutBaseDatosRemota( BDRemota );
    FDImportarTransportista.ParamToEdit( VTransportista );
    FDImportarTransportista.PreparaEntorno;
    Result:= FDImportarTransportista.ShowModal;
    FDImportarTransportista.VarToParam( VTransportista );
  finally
    FreeAndNil( FDImportarTransportista );
  end;
end;

procedure TFDImportarTransportista.FormCreate(Sender: TObject);
begin
  //empresa_e.Tag := kEmpresa;
end;

procedure TFDImportarTransportista.PutBaseDatosRemota( const BDRemota: string );
begin
  sBDRemota:= BDRemota;
  qryTransportista.DatabaseName:= sBDRemota;
end;

procedure TFDImportarTransportista.ParamToEdit( const ATransportista: string );
begin
  codigo_tp.Text:= ATransportista;
end;

procedure TFDImportarTransportista.VarToParam( var VTransportista: string );
begin
  VTransportista:= sTransportista;
end;

function  TFDImportarTransportista.EditToVar: Boolean;
begin
  //Hay cambio de estado
  Result:= True;
  sTransportista:= Trim( codigo_tp.Text );
end;


procedure TFDImportarTransportista.PreparaEntorno;
begin
  codigo_tpChange( codigo_tp );
  if txtTransportista.Caption <> '' then
    btnAceptar.Caption:= 'Actualizar'
  else
    btnAceptar.Caption:= 'Insertar';

  btnImportar.Enabled:= True;
  btnAceptar.Enabled:= False;
end;

procedure TFDImportarTransportista.btnImportarClick(Sender: TObject);
begin
  if EditToVar then
  begin
    btnAceptar.Enabled:= ImportarTransportista;
  end
  else
  begin
    btnAceptar.Enabled:= False;
  end;
end;

procedure TFDImportarTransportista.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if ImportarTransportistaMD.SincronizarTransportista( Self, sBDRemota, sTransportista,  sMsg ) then
  begin
    ModalResult:= 1;
  end
  else
  begin
    ShowMessage( sMsg );
  end;
end;

procedure TFDImportarTransportista.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TFDImportarTransportista.LoadQuerys;
begin
  with qryTransportista do
  begin
    SQL.Clear;
    SQL.Add('select *                              ');
    SQL.Add('from frf_transportistas               ');
    SQL.Add('where transporte_t = :transportista   ');
  end;
end;

function TFDImportarTransportista.ImportarTransportista: Boolean;
begin
  //TODO
  LoadQuerys;
  qryTransportista.ParamByName('transportista').AsString:= sTransportista;
  qryTransportista.Open;
  if qryTransportista.IsEmpty then
  begin
    Result:= False;
    ShowMessage('NO encontrado el Transportista en la BD Remota');
  end
  else
  begin
    LoadMemos;
    Result:= True;
  end;
end;

procedure TFDImportarTransportista.LoadMemos;
var
  i: Integer;
begin
  mmoIzq.Clear;
  mmoDer.Clear;
  mmoIzq.Font.Style:= mmoIzq.Font.Style + [fsBold];
  i:= 0;
  while i < qryTransportista.Fields.Count do
  begin
    mmoIzq.Lines.Add( UpperCase(qryTransportista.Fields[i].FieldName) );
    mmoDer.Lines.Add( qryTransportista.Fields[i].AsString );
    inc( i );
  end;
end;

procedure TFDImportarTransportista.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDImportarTransportista.FormShow(Sender: TObject);
begin
  codigo_tp.SetFocus;
end;

procedure TFDImportarTransportista.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryTransportista.Close;
end;


procedure TFDImportarTransportista.codigo_tpChange(Sender: TObject);
begin
  txtTransportista.Caption:= desTransporte( '', codigo_tp.Text );
  if txtTransportista.Caption <> '' then
    btnAceptar.Caption:= 'Actualizar'
  else
    btnAceptar.Caption:= 'Insertar';
end;

end.
