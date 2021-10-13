unit ControlIntrastatFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls,
  BCalendarButton, BSpeedButton, BGridButton, Grids, DBGrids, BGrid,
  ComCtrls, BCalendario;

type
  TFLControlIntrastat = class(TForm)
    btnCerrar: TBitBtn;
    btnAceptar: TBitBtn;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    lblNombre1: TLabel;
    btnEmpresa: TBGridButton;
    Desde: TLabel;
    btnFechaDesde: TBCalendarButton;
    lblNombre2: TLabel;
    btnFechaHasta: TBCalendarButton;
    lblNombre3: TLabel;
    btnProducto: TBGridButton;
    lblTipo: TLabel;
    bvlTipo: TBevel;
    lblFiltro: TLabel;
    bvl1: TBevel;
    eEmpresa: TBEdit;
    lEmpresa: TStaticText;
    eFechaDesde: TBEdit;
    eFechaHasta: TBEdit;
    eProducto: TBEdit;
    lProducto: TStaticText;
    chkAsimilada: TCheckBox;
    chkComunitaria: TCheckBox;
    chkImportacion: TCheckBox;
    chkNacional: TCheckBox;
    chkFactura: TCheckBox;
    chkFlete: TCheckBox;
    chkTerrestre: TCheckBox;
    chkSinAsignar: TCheckBox;
    lblProveedor: TLabel;
    edtProveedor: TBEdit;
    btnProveedor: TBGridButton;
    stProveedor: TStaticText;
    chkISP: TCheckBox;
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
    procedure PonNombreProveedor(Sender: TObject);
  private
    { Private declarations }

    sEmpresa, sProducto, sProveedor: string;
    dFechaIni, dFechaFin: TDateTime;
    bAsimilada, bComunitaria, bImportacion, bNacional, bISP, bSinAsignar: boolean;
    bFactura, bFlete, bTerrestre: boolean;

    procedure ValidarCampos;
    procedure VerDiferenciasComer_RadioF;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     UDMBaseDatos, UDMConfig, ControlIntrastatQL,
     bTimeUtils, CAuxiliarDB;

procedure TFLControlIntrastat.FormCreate(Sender: TObject);
var
  dAux: TDate;
  iDia, iMes, iAnyo: Word;
begin
  FormType:=tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  eProducto.Tag := kProducto;
  edtProveedor.Tag := kProveedor;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;


  DecodeDate( date, iAnyo, iMes, iDia );
  dAux:= EncodeDate( iAnyo, iMes, 1 );
  eFechaDesde.Text := DateToStr( dAux );
  dAux:= IncMonth( dAux, 1 );
  eFechaHasta.Text := DateToStr( dAux - 1 );

  eEmpresa.Text:= gsDefEmpresa;
  eProducto.Text:= '';

  CalendarioFlotante.Date := Date - 1;
  PonNombreEmpresa( eEmpresa );
end;

procedure TFLControlIntrastat.FormClose(Sender: TObject;
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

procedure TFLControlIntrastat.ValidarCampos;
begin
  //Comprobamos que los campos esten todos con datos
  if lEmpresa.caption = '' then
  begin
    EEmpresa.SetFocus;
    raise Exception.Create( 'Falta el código de la empresa o es incorrecto.');
  end;
  sEmpresa:= eEmpresa.Text;

  if lProducto.Caption = '' then
  begin
    eProducto.SetFocus;
    raise Exception.Create( 'El código del producto es incorrecto.');
  end;
  sProducto:= eProducto.Text;

  if lblProveedor.Caption = '' then
  begin
    edtProveedor.SetFocus;
    raise Exception.Create( 'El código del proveedor es incorrecto.');
  end;
  sProveedor:= edtProveedor.Text;

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

  bAsimilada:= chkAsimilada.Checked;
  bComunitaria:= chkComunitaria.Checked;
  bImportacion:= chkImportacion.Checked;
  bSinAsignar:= chkSinAsignar.Checked;
  bNacional:= chkNacional.Checked;
  bISP:= chkISP.Checked;
  bFactura:= chkFactura.Checked;
  bFlete:= chkFlete.Checked;
  bTerrestre:= chkTerrestre.Checked;
end;


procedure TFLControlIntrastat.btnAceptarClick(Sender: TObject);
begin
  VerDiferenciasComer_RadioF;
end;

procedure TFLControlIntrastat.VerDiferenciasComer_RadioF;
begin
  ValidarCampos;

  if not ControlIntrastatQL.VerControlIntrastat( self, sEmpresa, sProducto, sProveedor, dFechaIni, dFechaFin,
                               bAsimilada, bComunitaria, bImportacion, bNacional, bISP, bSinAsignar, bFactura, bFlete, bTerrestre ) then
  begin
    ShowMessage('No hay datos para los parametros introducidos.');
  end;
end;


procedure TFLControlIntrastat.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLControlIntrastat.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnAceptar.Click;
  end;
end;

procedure TFLControlIntrastat.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLControlIntrastat.botonClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kProveedor:DespliegaRejilla(btnProveedor);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

procedure TFLControlIntrastat.PonNombreEmpresa(Sender: TObject);
begin
  if eEmpresa.Text = '' then
    lEmpresa.Caption := 'TODOS LAS PLANTAS'
  else
    lEmpresa.Caption := desEmpresa(eEmpresa.Text);
  PonNombreProducto( eProducto );
  PonNombreProveedor( edtProveedor );
end;

procedure TFLControlIntrastat.PonNombreProducto(Sender: TObject);
begin
  if eProducto.Text = '' then
    lProducto.Caption := 'TODOS LOS PRODUCTOS'
  else
    lProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text );
end;

procedure TFLControlIntrastat.PonNombreProveedor(Sender: TObject);
begin
  if edtProveedor.Text = '' then
    stProveedor.Caption := 'TODOS LOS PROVEEDORES'
  else
    stProveedor.Caption := desProveedor(eEmpresa.Text, edtProveedor.Text );
end;

end.
