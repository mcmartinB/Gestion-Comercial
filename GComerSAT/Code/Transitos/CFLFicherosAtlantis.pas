unit CFLFicherosAtlantis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils, DBCtrls, BDEdit;

type
  TFLFicherosAtlantis = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label1: TLabel;
    eEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    BCBDesde: TBCalendarButton;
    eFechaDesde: TBEdit;
    Desde: TLabel;
    Label14: TLabel;
    eFechaHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    btnFicheros: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lblNombre1: TLabel;
    eCentro: TBEdit;
    BGBCentro: TBGridButton;
    stCentro: TStaticText;
    lbl1: TLabel;
    lbl2: TLabel;
    edtCarpeta: TBEdit;
    lbl3: TLabel;
    edtTransito: TBEdit;
    lbl4: TLabel;
    lbl5: TLabel;
    actInforme: TAction;
    lblpuerto_salida: TLabel;
    edtpuerto_salida: TBDEdit;
    btnpuerto_salida: TBGridButton;
    txtpuerto_salida: TStaticText;
    cbbFormatoFecha: TComboBox;
    lbl6: TLabel;
    btnInforme: TSpeedButton;
    actFicheros: TAction;
    rgDatos: TRadioGroup;
    lblProducto: TLabel;
    edtproducto: TBDEdit;
    btnproducto: TBGridButton;
    txtproducto: TStaticText;
    Label2: TLabel;
    edtagrupacion: TBDEdit;
    btnAgrupacion: TBGridButton;
    txtagrupacion: TStaticText;
    cbDestino: TCheckBox;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtpuerto_salidaChange(Sender: TObject);
    procedure btnpuerto_salidaClick(Sender: TObject);
    procedure actFicherosExecute(Sender: TObject);
    procedure edtagrupacionChange(Sender: TObject);

  private
    sEmpresa, sCentro, sProducto, sPuerto, sAgrupacion: string;
    dFechaDesde, dFechaHasta: TDateTime;

    function  LeerParametros: Boolean;
  public

  end;

var
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview,
   CAuxiliarDB, UDMBaseDatos, bDialogs, bMath, bTimeUtils, FileCtrl,
   CDLFicherosAtlantis, CRLFicherosAtlantis, CRLFicherosAtlantisPapel;


{$R *.DFM}

//                       ****  BOTONES  ****

function  TFLFicherosAtlantis.LeerParametros: Boolean;
begin
  result:= False;
  if stEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
    Exit;
  end;
  sEmpresa := Trim(eEmpresa.Text);

  if stCentro.Caption = '' then
  begin
    ShowMessage('Falta el código del centro o es incorrecto.');
    Exit;
  end;
  sCentro := eCentro.Text;

  if txtagrupacion.Caption = '' then
  begin
    ShowMessage('Falta la agrupacion o es incorrecto.');
    Exit;
  end;
  sAgrupacion := edtAgrupacion.Text;

  if txtproducto.Caption = '' then
  begin
    ShowMessage('Falta el código del producto o es incorrecto.');
    Exit;
  end;
  sProducto := edtProducto.Text;

  if txtpuerto_salida.Caption = '' then
  begin
    ShowMessage('El código del puerto es incorrecto.');
    Exit;
  end;
  sPuerto := Trim( edtpuerto_salida.Text );

  if not TryStrToDate( eFechaDesde.Text, dFechaDesde ) then
  begin
    ShowMessage('Fecha de inicio incorrecta');
    Exit;
  end;
  if not TryStrToDate( eFechaHasta.Text, dFechaHasta ) then
  begin
    ShowMessage('Fecha de fin incorrecta');
    Exit;
  end;
  if dFechaDesde > dFechaHasta then
  begin
    if dFechaDesde < StrToDate('1/7/2001') then
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

procedure TFLFicherosAtlantis.BBAceptarClick(Sender: TObject);
var
  sDesProducto: string;
begin
  if not CerrarForm(true) then Exit;
  if LeerParametros then
  begin
    if not CDLFicherosAtlantis.DLFicherosAtlantis.AbrirQuery( sEmpresa, sCentro, sProducto, sPuerto, sAgrupacion, dFechaDesde, dFechaHasta, StrToIntDef( edtCarpeta.Text, -1 ), StrToIntDef( edtTransito.Text, -1 ), rgDatos.ItemIndex, cbDestino.Checked )  then
    begin
      ShowMessage('Sin datos para los paremtros seleccionados.' );
    end
    else
    begin
      if edtProducto.Text <> ''  then
        sDesProducto:= Trim(txtproducto.Caption)
      else
        sDesProducto:= '';
      Informe( self, sDesProducto );
    end;
    DLFicherosAtlantis.CerrarQuery;
  end;
end;

procedure TFLFicherosAtlantis.actFicherosExecute(Sender: TObject);
var
  sDir, sPuertoSalida, sDestino, sDesProducto: string;
begin
  if not CerrarForm(true) then Exit;
  if LeerParametros then
  begin
    if CDLFicherosAtlantis.DLFicherosAtlantis.AbrirQuery( sEmpresa, sCentro, sProducto, sPuerto, sAgrupacion, dFechaDesde, dFechaHasta, StrToIntDef( edtCarpeta.Text, -1 ), StrToIntDef( edtTransito.Text, -1 ), rgDatos.ItemIndex, cbDestino.Checked )  then
    begin
            //Previsualizar informe
            sDir := 'c:\';
            if SelectDirectory('   Selecciona directorio destino.', '', sdir) then
            begin
              if Copy( sDir, length( sdir ), 1 ) = '\' then
                sDir:= sDir + 'DepositoAduana'
              else
                sDir:= sDir + '\DepositoAduana';

              while not DLFicherosAtlantis.QDestinos.Eof do
              begin
                sPuertoSalida:= DLFicherosAtlantis.QDestinos.FieldByName('puerto_salida').AsString;
                sDestino:= DLFicherosAtlantis.QDestinos.FieldByName('destino').AsString;
                if edtProducto.Text <> '' then
                  sDesProducto:= StringReplace( Trim(txtproducto.Caption),' ','_',[rfReplaceAll] ) + '_'
                else
                  sDesProducto:= '';
                DLFicherosAtlantis.FiltrarDestino( sPuertoSalida, sDestino );
                HojaExcel( self, sDir + StringReplace( sDesProducto + Trim(sPuertoSalida),' ','_',[rfReplaceAll] ) + '_' + sDestino + '.xls', cbbFormatoFecha.Items[ cbbFormatoFecha.ItemIndex ] );
                DLFicherosAtlantis.QDestinos.Next;
              end;

            end;
            DLFicherosAtlantis.LimpiarFiltros;
            if edtProducto.Text <> ''  then
              sDesProducto:= Trim(txtproducto.Caption)
            else
              sDesProducto:= '';
            Informe( self, sDesProducto );

    end
    else
    begin
      ShowMessage('Sin datos para los paremtros seleccionados.' );
    end;
    DLFicherosAtlantis.CerrarQuery;
  end;
end;

procedure TFLFicherosAtlantis.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLFicherosAtlantis.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CalendarioFlotante.Date := Date;
    gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  edtagrupacion.Tag := kAgrupacion;
  edtProducto.Tag := kProducto;
  edtpuerto_salida.Tag := kAduana;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;


  eEmpresa.Text := '050';
  eCentro.Text := '6';
  edtpuerto_salida.Text:= '';
  edtpuerto_salida.Change;
  eFechaDesde.Text := DateTostr( Date - 7);
  eFechaHasta.Text := DateTostr( Date - 1);
  (*
  eFechaDesde.Text := DateTostr(LunesAnterior(Date) - 7);
  eFechaHasta.Text := DateTostr(LunesAnterior(Date) - 1);
  *)


  PonNombre( eEmpresa );
  edtagrupacionChange(edtagrupacion);


  DLFicherosAtlantis:= TDLFicherosAtlantis.Create( self );
end;

procedure TFLFicherosAtlantis.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TFLFicherosAtlantis.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLFicherosAtlantis.FormClose(Sender: TObject;
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

  FreeAndNil( DLFicherosAtlantis );
  Action := caFree;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLFicherosAtlantis.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(BGBCentro, [eEmpresa.Text]);
    kProducto: DespliegaRejilla( btnproducto, [eEmpresa.Text] );
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
    kAgrupacion: DespliegaRejilla ( btnAgrupacion );
  end;
end;

procedure TFLFicherosAtlantis.PonNombre(Sender: TObject);
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
      STEmpresa.Caption := desEmpresa(eEmpresa.Text);
      PonNombre( eCentro );
      PonNombre( edtProducto );
    end;
    kCentro:
    begin
      stCentro.Caption := desCentro(eEmpresa.Text, eCentro.Text);
    end;
    kAgrupacion:
    begin
      if edtAgrupacion.Text = '' then
        txtagrupacion.Caption := 'TODAS LAS AGRUPACIONES'
      else
        txtagrupacion.Caption := desAgrupacion(edtAgrupacion.Text);
    end;
    kProducto:
    begin
      if edtProducto.Text = '' then
        txtProducto.Caption := 'TODOS LOS PRODUCTOS'
      else
        txtProducto.Caption := desProducto(eEmpresa.Text, edtProducto.Text);
    end;
  end;
end;

procedure TFLFicherosAtlantis.edtagrupacionChange(Sender: TObject);
begin
  if Trim( edtagrupacion.Text ) = '' then
    txtagrupacion.Caption := 'TODAS LAS AGRUPACIONES'
  else
    txtagrupacion.Caption := desAgrupacion(edtAgrupacion.Text);
end;

procedure TFLFicherosAtlantis.edtpuerto_salidaChange(Sender: TObject);
begin
  if Trim( edtpuerto_salida.Text ) = '' then
    txtpuerto_salida.Caption := 'TODOS LOS PUERTOS'
  else
    txtpuerto_salida.Caption := desAduana(edtpuerto_salida.Text);
end;

procedure TFLFicherosAtlantis.btnpuerto_salidaClick(Sender: TObject);
begin
  DespliegaRejilla( btnpuerto_salida, [] );
end;

end.
