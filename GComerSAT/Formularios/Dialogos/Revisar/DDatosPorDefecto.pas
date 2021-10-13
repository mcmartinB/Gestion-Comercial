unit DDatosPorDefecto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt;

type
  TFDDatosPorDefecto = class(TForm)
    ListaAcciones: TActionList;
    ADesplegarRejilla: TAction;
    RejillaFlotante: TBGrid;
    LEmpresa: TLabel;
    LCentro: TLabel;
    edtEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    stEmpresa: TStaticText;
    BGBCentro: TBGridButton;
    edtCentro: TBEdit;
    LProducto: TLabel;
    edtProducto: TBEdit;
    BGBProducto: TBGridButton;
    BGBCliente: TBGridButton;
    edtCliente: TBEdit;
    lblNombre2: TLabel;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    stCentro: TStaticText;
    stProducto: TStaticText;
    stCliente: TStaticText;
    lblNota: TLabel;
    lblNot2: TLabel;
    bvl1: TBevel;
    procedure BBCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
      {private declarations}
      procedure ActualizarDatosPorDefecto;

  public
    { Public declarations }

  end;

implementation

uses CVariables, Principal, CAuxiliarDB, UDMAuxDB, DPreview, UDMBaseDatos, UDMConfig;

{$R *.DFM}

procedure TFDDatosPorDefecto.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  edtProducto.Tag := kProducto;
  edtCliente.Tag := kCliente;

  edtEmpresa.Text := gsDefEmpresa;
  edtCentro.Text := gsDefCentro;
  edtProducto.Text := gsDefProducto;
  edtCliente.Text := gsDefCliente;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := nil;

  STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
  stCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text );
  stProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
  stCliente.Caption := desCliente(edtEmpresa.Text, edtCliente.Text);
end;

procedure TFDDatosPorDefecto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAuxQuerys;
  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFDDatosPorDefecto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
    VK_ESCAPE: btnCancelar.Click;
    VK_F1: btnAceptar.Click;
  end;
end;

procedure TFDDatosPorDefecto.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(BGBCentro, [edtEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [edtEmpresa.Text]);
    kCliente: DespliegaRejilla(BGBCliente, [edtEmpresa.Text]);
  end;
end;

procedure TFDDatosPorDefecto.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
    begin
      STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
      stCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text );
      stProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
      stCliente.Caption := desCliente(edtEmpresa.Text, edtCliente.Text);
    end;
    kCentro:
      stCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text );
    kProducto:
      stProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
    kCliente:
      stCliente.Caption := desCliente(edtEmpresa.Text, edtCliente.Text);
  end;
end;

procedure TFDDatosPorDefecto.FormActivate(Sender: TObject);
begin
  Self.top := 1;
end;

procedure TFDDatosPorDefecto.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

procedure TFDDatosPorDefecto.btnAceptarClick(Sender: TObject);
begin
  //Comprobar si los campos se han rellenado correctamente
  if stEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto.');
    edtEmpresa.SetFocus;
    Exit;
  end;
  if Trim ( edtCentro.Text ) <> '' then
  begin
    if stCentro.Caption = '' then
    begin
      ShowError('El código del centro es incorrrecto.');
      edtCentro.SetFocus;
      Exit;
    end;
  end;
  if Trim ( edtProducto.Text ) <> '' then
  begin
    if stProducto.Caption = '' then
    begin
      ShowError('El código del producto es incorrrecto.');
      edtProducto.SetFocus;
      Exit;
    end;
  end;
  if Trim( edtCliente.Text ) <> '' then
  begin
    if stCliente.Caption = '' then
    begin
      ShowError('El código del cliente es incorrrecto.');
      edtCliente.SetFocus;
      Exit;
    end;
  end;

  gsDefEmpresa:= edtEmpresa.Text;
  gsDefCentro:= edtCentro.Text;
  gsDefProducto:= edtProducto.Text;
  gsDefCliente:= edtCliente.Text;

  ActualizarDatosPorDefecto;
  Close;
end;

procedure TFDDatosPorDefecto.ActualizarDatosPorDefecto;
begin
  try
    with DMBaseDatos.QAux do
    begin
      RequestLive:= True;
      SQL.Clear;
      SQL.Add('select * from cnf_datos_por_defecto where usuario_cdd = :usuario ');
      ParamByName('usuario').AsString:= gsCodigo;
      Open;
      if IsEmpty then
      begin
        Insert;
        FieldByName('usuario_cdd').AsString:= gsCodigo;
        FieldByName('empresa_cdd').AsString:= gsDefEmpresa;
        FieldByName('centro_cdd').AsString:= gsDefCentro;
        FieldByName('producto_cdd').AsString:= gsDefProducto;
        FieldByName('cliente_cdd').AsString:= gsDefCliente;
        Post;
      end
      else
      begin
        Edit;
        FieldByName('empresa_cdd').AsString:= gsDefEmpresa;
        FieldByName('centro_cdd').AsString:= gsDefCentro;
        FieldByName('producto_cdd').AsString:= gsDefProducto;
        FieldByName('cliente_cdd').AsString:= gsDefCliente;
        Post;
      end;

    end;
  finally
    DMBaseDatos.QAux.Close;
    DMBaseDatos.QAux.RequestLive:= False;
  end;
end;

procedure TFDDatosPorDefecto.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= gsDefEmpresa <> '';
  if not CanClose then
  begin
    ShowMessage('La empresa por defecto es de obligada inserción.');
  end;
end;

end.
