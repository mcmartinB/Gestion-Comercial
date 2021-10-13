unit DetalleEntradasFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls,
  BCalendarButton, BSpeedButton, BGridButton, Grids, DBGrids, BGrid,
  ComCtrls, BCalendario;

type
  TFLDetalleEntradas = class(TForm)
    btnCerrar: TBitBtn;
    btnAceptar: TBitBtn;
    lblNombre1: TLabel;
    eEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    lEmpresa: TStaticText;
    Desde: TLabel;
    eFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lblNombre2: TLabel;
    eFechaHasta: TBEdit;
    btnFechaHasta: TBCalendarButton;
    lblNombre3: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    lProducto: TStaticText;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    lblNombre4: TLabel;
    eCentro: TBEdit;
    btnCentro: TBGridButton;
    lCentro: TStaticText;
    lblCosechero: TLabel;
    eCosechero: TBEdit;
    btnCosechero: TBGridButton;
    stCosechero: TStaticText;
    lblPlantacion: TLabel;
    ePlantacion: TBEdit;
    stPlantacion: TStaticText;
    lblFormato: TLabel;
    eFormato: TBEdit;
    btnFormato: TBGridButton;
    stFormato: TStaticText;
    btnPlantacion: TBGridButton;
    cbbLogifruit: TComboBox;
    cbbCategoria: TComboBox;
    cbbCalibre: TComboBox;
    lblLogifruit: TLabel;
    lblCategoria: TLabel;
    lblCalibre: TLabel;
    rbDetalle: TRadioButton;
    rbResumen: TRadioButton;
    lblTipo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure botonClick(Sender: TObject);
    procedure PonNombreEmpresa(Sender: TObject);
    procedure PonNombreProducto(Sender: TObject);
    procedure PonNombreCentro(Sender: TObject);
    procedure PonNombreCosechero(Sender: TObject);
    procedure PonNombrePlantacion(Sender: TObject);
    procedure PonNombreFormato(Sender: TObject);
  private
    { Private declarations }

    sEmpresa, sCentro, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;
    iCosechero, iPlantacion, iFormato: integer;

    procedure ValidarCampos;
    procedure ListadoDetalleEntregas;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     UDMBaseDatos, UDMConfig, DetalleEntradasQL, DetalleResumenEntradasQL,
     bTimeUtils, CAuxiliarDB;

procedure TFLDetalleEntradas.FormCreate(Sender: TObject);
var
  dAux: TDate;
begin
  FormType:=tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eProducto.Tag := kProducto;

  eCosechero.Tag:= kCosechero;
  ePlantacion.Tag:= kPlantacion;
  eFormato.Tag:= kFormatoEntrada;

  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;

  dAux:= LunesAnterior( Date );
  eFechaDesde.Text := DateToStr(dAux - 7);
  eFechaHasta.Text := DateToStr(dAux - 1);
  eEmpresa.Text:= gsDefEmpresa;
  eCentro.Text:= gsDefCentro;
  eProducto.Text:= '';
  eCosechero.Text:= '';
  ePlantacion.Text:= '';
  eFormato.Text:= '';

  CalendarioFlotante.Date := Date - 1;
  PonNombreEmpresa( eEmpresa );
end;

procedure TFLDetalleEntradas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;

  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLDetalleEntradas.ValidarCampos;
begin
  //Comprobamos que los campos esten todos con datos
  if lEmpresa.caption = '' then
  begin
    EEmpresa.SetFocus;
    raise Exception.Create( 'Falta el código de la empresa o es incorrecto.');
  end;
  sEmpresa:= eEmpresa.Text;

  if lCentro.caption = '' then
  begin
    eCentro.SetFocus;
    raise Exception.Create( 'Falta el código del centro o es incorrecto.');
  end;
  sCentro:= eCentro.Text;

  if lProducto.Caption = '' then
  begin
    eProducto.SetFocus;
    raise Exception.Create( 'El código del producto es incorrecto.');
  end;
  sProducto:= eProducto.Text;

  if stCosechero.Caption = '' then
  begin
    eCosechero.SetFocus;
    raise Exception.Create( 'El código del cosechero es incorrecto.');
  end;
  iCosechero:= StrToIntDef( eCosechero.Text, -1 );

  if ( iCosechero <> -1 ) and ( stPlantacion.Caption = '' ) then
  begin
    ePlantacion.SetFocus;
    raise Exception.Create( 'El código del plantación es incorrecto.');
  end;
  iPlantacion:= StrToIntDef( ePlantacion.Text, -1 );

  if stFormato.Caption = '' then
  begin
    eFormato.SetFocus;
    raise Exception.Create( 'El código del formato es incorrecto.');
  end;
  iFormato:= StrToIntDef( eFormato.Text, -1 );

  if not TryStrToDate( eFechaDesde.Text, dFechaIni ) then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create( 'La fecha de inicio es incorrecta.');
  end;

  if not TryStrToDate( eFechaHasta.Text, dFechaFin ) then
  begin
    eFechaHasta.SetFocus;
    raise Exception.Create( 'La fecha de fin es incorrecta.');
  end;

  if dFechaFin < dFechaIni then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create( 'Rango de fechas incorrecto.');
  end;


end;


procedure TFLDetalleEntradas.btnAceptarClick(Sender: TObject);
begin
  ListadoDetalleEntregas;
end;

procedure TFLDetalleEntradas.ListadoDetalleEntregas;
begin
  ValidarCampos;
  if rbDetalle.Checked then
  begin
    if not DetalleEntradasQL.VerDetalleEntradas( self, sEmpresa, sCentro,
             sProducto, dFechaIni, dFechaFin, iCosechero, iPlantacion, iFormato,
             cbbLogifruit.ItemIndex, cbbCategoria.ItemIndex, cbbCalibre.ItemIndex ) then
    begin
      ShowMessage('No hay entradas para los parametros introducidos.');
    end;
  end
  else
  if rbResumen.Checked then
  begin
    if not DetalleResumenEntradasQL.VerDetalleResumenEntradas( self, sEmpresa, sCentro,
             sProducto, dFechaIni, dFechaFin, iCosechero, iPlantacion, iFormato,
             cbbLogifruit.ItemIndex, cbbCategoria.ItemIndex, cbbCalibre.ItemIndex ) then
    begin
      ShowMessage('No hay entradas para los parametros introducidos.');
    end;
  end;
end;


procedure TFLDetalleEntradas.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLDetalleEntradas.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnAceptar.Click;
  end;
end;

procedure TFLDetalleEntradas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
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
    vk_f2:
      begin
        Key := 0;
        botonClick( Sender );
      end;
  end;
end;

procedure TFLDetalleEntradas.botonClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro,[eEmpresa.Text]);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kCosechero: DespliegaRejilla(btnCosechero,[eEmpresa.Text]);
    kPlantacion: DespliegaRejilla(btnPlantacion,[eEmpresa.Text, eProducto.Text, eCosechero.Text]);
    kFormatoEntrada: DespliegaRejilla(btnFormato,[eEmpresa.Text, eCentro.Text, eProducto.Text]);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

procedure TFLDetalleEntradas.PonNombreEmpresa(Sender: TObject);
begin
  lEmpresa.Caption := desEmpresa(eEmpresa.Text);
  PonNombreProducto( eProducto );
  PonNombreCentro( eCentro );
  PonNombreCosechero( eCosechero );
  PonNombrePlantacion( ePlantacion );
  PonNombreFormato( eFormato );
end;

procedure TFLDetalleEntradas.PonNombreProducto(Sender: TObject);
begin
  if eProducto.Text = '' then
    lProducto.Caption := 'TODOS LOS PRODUCTOS'
  else
    lProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text );
  PonNombrePlantacion( ePlantacion );
  PonNombreFormato( eFormato );
end;

procedure TFLDetalleEntradas.PonNombreCentro(Sender: TObject);
begin
  lCentro.Caption := desCentro(eEmpresa.Text, eCentro.Text );
  PonNombreFormato( eFormato );
end;

procedure TFLDetalleEntradas.PonNombreCosechero(Sender: TObject);
begin
  if eCosechero.Text = '' then
    stCosechero.Caption := 'TODOS LOS COSECHEROS'
  else
    stCosechero.Caption := desCosechero(eEmpresa.Text, eCosechero.Text );
  PonNombrePlantacion( ePlantacion );
end;

procedure TFLDetalleEntradas.PonNombrePlantacion(Sender: TObject);
begin
  if ePlantacion.Text = '' then
    stPlantacion.Caption := 'TODAS LAS PLANTACIONES'
  else
    stPlantacion.Caption := desPlantacionEx(eEmpresa.Text, eProducto.Text, eCosechero.Text, ePlantacion.Text, DateToStr( Date ) );
end;

procedure TFLDetalleEntradas.PonNombreFormato(Sender: TObject);
begin

  if eFormato.Text = '' then
    stFormato.Caption := 'TODOS LOS FORMATOS'
  else
    stFormato.Caption := desFormatoEntrada(eEmpresa.Text, eCentro.Text, eProducto.Text, eFormato.Text );
end;

end.
