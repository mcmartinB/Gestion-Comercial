unit UTransitosList_FC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils, DBCtrls;

type
  TTransitosList_FC = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label1: TLabel;
    edtEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    BGBCentro: TBGridButton;
    edtCentro: TBEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtProducto: TBEdit;
    BGBProducto: TBGridButton;
    STProducto: TStaticText;
    BCBDesde: TBCalendarButton;
    edtDesde: TBEdit;
    Desde: TLabel;
    Label14: TLabel;
    edtHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    cbxTipoListado: TComboBox;
    Label4: TLabel;
    lblEspere1: TLabel;
    cbxCategoriasListado: TComboBox;
    cbxDesgloseListado: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    edtAgrupacion: TBEdit;
    BGBAgrupacion: TBGridButton;
    STAgrupacion: TStaticText;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function CamposVacios: boolean;
    procedure FormDestroy(Sender: TObject);
    procedure edtDesdeExit(Sender: TObject);
    procedure edtAgrupacionChange(Sender: TObject);

  private
    empresa, centro, producto, agrupacion, sFechainicio, sFechafin: string;
    dFechainicio, dFechafin: TDateTime;

    function  LeerParametros: Boolean;
  public

  end;

var
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview, UTransitosList_QR, UTransitosListDesglose_QR,
     UTransitosList_MD, CAuxiliarDB, UDMBaseDatos, bDialogs, bMath, bTimeUtils;

{$R *.DFM}

//                       ****  BOTONES  ****

function  TTransitosList_FC.LeerParametros: Boolean;
begin
  result:= False;

  empresa := Trim(edtEmpresa.Text);
  if empresa = '' then
  begin
    ShowMessage('Falta el código de la empresa.');
    Exit;
  end;

  centro := edtCentro.Text;
  if centro = '' then
  begin
    ShowMessage('Falta el código del centro.');
    Exit;
  end;

  producto := Trim(edtProducto.Text);
  agrupacion := Trim (edtAgrupacion.Text);

  sFechainicio:= edtDesde.Text;
  sFechaFin:= edtHasta.Text;
  if not TryStrToDate( edtDesde.Text, dFechainicio ) then
  begin
    ShowMessage('Fecha de inicio incorrecta');
    Exit;
  end;
  (*PARCHE-20060524*)(*MODIF-20060524*)(*PACO*)(*ERNESTO*)
  (*Ignorar transitos de antes del *)
  if dFechainicio < StrToDate('1/7/2001') then
  begin
    dFechainicio:= StrToDate('1/7/2001');
  end;

  if not TryStrToDate( edtHasta.Text, dFechafin ) then
  begin
    ShowMessage('Fecha de fin incorrecta');
    Exit;
  end;
  if dFechainicio > dFechafin then
  begin
    if dFechaFin < StrToDate('1/7/2001') then
    begin
      ShowMessage('La fecha de fin debe ser mayor que ''1/7/2001''. ');
      Exit;
    end
    else
    begin
      ShowMessage('La fecha de fin debe ser meyor que la de inicio. ');
      Exit;
    end;
  end;

  result:= True;
end;

procedure TTransitosList_FC.BBAceptarClick(Sender: TObject);
var
  sTitulo: string;
begin
  if not CerrarForm(true) then Exit;
  if CamposVacios then Exit;

  //inicio:= GetTickCount;
  if (empresa <> edtEmpresa.Text) or (centro <> edtCentro.Text) or (producto <> edtProducto.Text) or  (agrupacion <> edtAgrupacion.Text) or 
    (sFechainicio <> edtDesde.Text) or (sFechafin <> edtHasta.Text) then

  begin
    if not LeerParametros then
      Exit;

    lblEspere1.Visible := true;
    Application.ProcessMessages;
    TransitosList_MD.RellenaTablas( empresa, centro, producto, agrupacion, dFechainicio, dFechafin );
    lblEspere1.Visible := false;
    Application.ProcessMessages;

    TransitosList_MD.mtSalidasIndirectas.Close;
  end;

  case cbxTipoListado.ItemIndex of
    0: sTitulo:= 'TODOS LOS TRÁNSITOS';
    1: sTitulo:= 'TRÁNSITOS VENDIDOS';
    2: sTitulo:= 'TRÁNSITOS POR VENDER';
  end;

  if cbxDesgloseListado.ItemIndex = 2 then
  begin
    TransitosList_MD.RellenarSalidasIndirectas;
    TransitosList_MD.QDesgloseSalidas.Open;

    UTransitosListDesglose_QR.Previsualizar(empresa, centro, producto, dFechainicio, dFechafin,
      cbxTipoListado.ItemIndex, cbxCategoriasListado.ItemIndex, cbxDesgloseListado.ItemIndex, sTitulo  );
    TransitosList_MD.QDesgloseSalidas.Close;

  end
  else

  if cbxDesgloseListado.ItemIndex = 1 then
  begin
    TransitosList_MD.QDesgloseSalidas.Open;
    TransitosList_MD.QDesgloseTransitos.Open;
    UTransitosListDesglose_QR.Previsualizar(empresa, centro, producto, dFechainicio, dFechafin,
      cbxTipoListado.ItemIndex, cbxCategoriasListado.ItemIndex, cbxDesgloseListado.ItemIndex, sTitulo );
    TransitosList_MD.QDesgloseSalidas.Close;
    TransitosList_MD.QDesgloseTransitos.Close;
  end
  else
  begin
    UTransitosList_QR.Previsualizar(empresa, centro, producto, dFechainicio, dFechafin,
      cbxTipoListado.ItemIndex, sTitulo);
  end;
end;

procedure TTransitosList_FC.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TTransitosList_FC.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;  

  edtEmpresa.Text := '050';
  edtCentro.Text := '6';
  edtProducto.Text:= 'TOM';
  STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
  STCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text);
  STProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
  edtDesde.Text := DateTostr(LunesAnterior(Date) - 7);
  edtHasta.Text := DateTostr(LunesAnterior(Date) - 1);
  CalendarioFlotante.Date := Date;
  edtEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  edtAgrupacion.Tag := kAgrupacion;
  edtProducto.Tag := kProducto;
  edtDesde.Tag := kCalendar;
  edtHasta.Tag := kCalendar;

  edtAgrupacionChange(edtAgrupacion);

  TransitosList_MD := TTransitosList_MD.Create(nil);

  empresa := '';
  centro := '';
  producto := '';
  sFechainicio := '';
  sFechafin := '';

  cbxTipoListado.ItemIndex:= 0;
  cbxCategoriasListado.ItemIndex:= 0;
  cbxDesgloseListado.ItemIndex:= 0;
end;

procedure TTransitosList_FC.FormDestroy(Sender: TObject);
begin
  FreeAndNil(TransitosList_MD);
end;

procedure TTransitosList_FC.FormActivate(Sender: TObject);
begin
  ActiveControl := edtEmpresa;
end;

procedure TTransitosList_FC.FormKeyDown(Sender: TObject; var Key: Word;
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
  end;
end;

procedure TTransitosList_FC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  Action := caFree;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TTransitosList_FC.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(BGBCentro, [edtEmpresa.Text]);
    kAgrupacion: DespliegaRejilla(BGBAgrupacion);
    kProducto: DespliegaRejilla(BGBProducto, [edtEmpresa.Text]);
    kCalendar:
      begin
        if edtDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TTransitosList_FC.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
    kCentro: STCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text);
    kProducto: STProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
  end;
end;

function TTransitosList_FC.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if Trim( edtEmpresa.Text ) = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if Trim( edtCentro.Text ) = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtCentro.SetFocus;
    Result := True;
    Exit;
  end;

  if Trim( STAgrupacion.Caption ) = '' then
  begin
    ShowError('El código de agrupación es incorrecto');
    edtAgrupacion.SetFocus;
    Result := True;
    Exit;
  end;

(*  if Trim( edtProducto.Text ) = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtProducto.SetFocus;
    Result:=True;
    Exit;
  end;
*)

  if edtDesde.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if edtHasta.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtHasta.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;

procedure TTransitosList_FC.edtAgrupacionChange(Sender: TObject);
begin
  if Trim( edtAgrupacion.Text ) = '' then
    STAgrupacion.Caption := 'TODAS LAS AGRUPACIONES'
  else
    STAgrupacion.Caption := desAgrupacion(edtAgrupacion.Text);
end;

procedure TTransitosList_FC.edtDesdeExit(Sender: TObject);
var
  dFecha: TDate;
begin
  dFecha:= StrToDateDef( edtDesde.Text, Date );
  if dFecha < StrToDate( '1/7/2001') then
    edtDesde.Text:= '01/07/2001';
end;

end.
