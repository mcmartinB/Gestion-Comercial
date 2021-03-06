unit CFDFacturaManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BCalendarButton, nbLabels, Buttons, BSpeedButton,
  BGridButton, BEdit, ComCtrls, BCalendario, Grids, DBGrids, BGrid,
  ExtCtrls, BDEdit;

type
  TDFDFacturaManual = class(TForm)
    lblEmpresa: TnbLabel;
    eEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    stEmpresa: TnbStaticText;
    lblNumeroFactura: TnbLabel;
    eNumeroFactura: TBEdit;
    lblFechaFactura: TnbLabel;
    eFechaFactura: TBEdit;
    btnFechaFactura: TBCalendarButton;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    RejillaFlotante: TBGrid;
    Calendario: TBCalendario;
    lblClienteFactura: TnbLabel;
    eClienteFactura: TBEdit;
    btnClienteFactura: TBGridButton;
    stClienteFactura: TnbStaticText;
    lblImpuesto: TnbLabel;
    eImpuesto: TBEdit;
    btnImpuesto: TBGridButton;
    stImpuesto: TnbStaticText;
    lblMoneda: TnbLabel;
    eMoneda: TBEdit;
    btnMoneda: TBGridButton;
    stMoneda: TnbStaticText;
    eImporteNeto: TBEdit;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    nbLabel6: TnbLabel;
    eImporteTotal: TBEdit;
    eImporteEuros: TBEdit;
    ePorcentajeImpuesto: TBEdit;
    eImporteImpuesto: TBEdit;
    Label1: TLabel;
    mmoConcepto: TMemo;
    lblTextoManual: TnbLabel;
    nbLabel8: TnbLabel;
    nbLabel9: TnbLabel;
    nbLabel10: TnbLabel;
    btnFechaAlbaran: TBCalendarButton;
    stCentroSalida: TnbStaticText;
    centro_salida_fal: TBEdit;
    n_albaran_fal: TBEdit;
    fecha_albaran_fal: TBEdit;
    nbLabel11: TnbLabel;
    nbLabel12: TnbLabel;
    nbLabel13: TnbLabel;
    producto_fal: TBEdit;
    envase_fal: TBEdit;
    categoria_fal: TBEdit;
    nbLabel14: TnbLabel;
    unidad_fal: TComboBox;
    lblUnidades: TnbLabel;
    nbLabel16: TnbLabel;
    nbLabel17: TnbLabel;
    stProducto: TnbStaticText;
    stEnvase: TnbStaticText;
    btnEnvase: TBGridButton;
    Bevel1: TBevel;
    unidades_fal: TBEdit;
    precio_fal: TBEdit;
    importe_fal: TBEdit;
    stCategoria: TnbStaticText;
    Label2: TLabel;
    nbLabel7: TnbLabel;
    centro_origen_fal: TBEdit;
    stCentroOrigen: TnbStaticText;
    btnCentroSalida: TBGridButton;
    btnProducto: TBGridButton;
    btnCentroOrigen: TBGridButton;
    btnCategoria: TBGridButton;
    nbLabel1: TnbLabel;
    ePrevision_cobro_f: TBEdit;
    btnPrevisionCobro: TBCalendarButton;
    Bevel2: TBevel;
    rbReducido: TRadioButton;
    rbSuper: TRadioButton;
    rbNormal: TRadioButton;
    lblCodigo1: TnbLabel;
    neto_fal: TBEdit;
    chkDescuento: TCheckBox;
    porc_descuento_fal: TBEdit;
    descuento_fal: TBEdit;
    edtImporteBruto: TBEdit;
    lbl1: TnbLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure btnFechaFacturaClick(Sender: TObject);
    procedure btnClienteFacturaClick(Sender: TObject);
    procedure btnImpuestoClick(Sender: TObject);
    procedure btnMonedaClick(Sender: TObject);
    procedure eEmpresaChange(Sender: TObject);
    procedure eClienteFacturaChange(Sender: TObject);
    procedure eImpuestoChange(Sender: TObject);
    procedure eMonedaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnSeccionContable_Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eImporteNetoChange(Sender: TObject);
    procedure eFechaFacturaChange(Sender: TObject);
    procedure centro_salida_falChange(Sender: TObject);
    procedure producto_falChange(Sender: TObject);
    procedure categoria_falChange(Sender: TObject);
    procedure envase_falChange(Sender: TObject);
    procedure centro_origen_falChange(Sender: TObject);
    procedure unidad_falChange(Sender: TObject);
    procedure unidades_falChange(Sender: TObject);
    procedure btnFechaAlbaranClick(Sender: TObject);
    procedure btnCentroSalidaClick(Sender: TObject);
    procedure btnProductoClick(Sender: TObject);
    procedure btnCentroOrigenClick(Sender: TObject);
    procedure btnEnvaseClick(Sender: TObject);
    procedure btnCategoriaClick(Sender: TObject);
    procedure btnPrevisionCobroClick(Sender: TObject);
    procedure rbSuperClick(Sender: TObject);
    procedure chkDescuentoClick(Sender: TObject);
    procedure edtImporteBrutoChange(Sender: TObject);
  private
    { Private declarations }
    bAceptar: boolean;
    bAbono: Boolean;

    sEmpresa, sCliente, sImpuesto, sMoneda: string;
    iFactura: integer;
    dFechaFactura, dPrevisionCobro: TDateTime;
    rImporte, rPorcentajeActual, rFactor: Real;
    rPorcentajeSuper, rPorcentajeReducido, rPorcentajeGeneral: Real;
    rImporteIva: real;
    rImporteTotal, rImporteEuros: real;

    sCentroSalida, sCentroOrigen, sProducto, sCategoria, sEnvase: string;
    iAlbaran, iUnidad: integer;
    rUnidades: real;
    dFechaAlbaran: TDateTime;
    rNetoAlb, rPorcDescuentoAlb, rDescuentoAlb, rImporteAlb, rPrecioAlb : Real;

    rPorcDescuento: Real;


    function  ParametrosCorrectos: boolean;
    function  ComprobarConstraints: boolean;
    function  ExisteAlbaran: boolean;
    function  ExisteDatosAlbaran: boolean;

    function  CadenaCorrecta( const AControl: TWinControl; const AMsg, ADescripcion: string; var AResult: string ): boolean;
    function  FechaCorrecta( const AControl: TWinControl; const AMsg: string; var AResult: TDateTime ): boolean;
    function  EnteroCorrecto( const AControl: TWinControl; const AMsg: string; var AResult: Integer ): boolean;
    function  RealCorrecto( const AControl: TWinControl; const AMsg: string; var AResult: Real ): boolean;

    procedure ConfigurarUnidadAbono;
    function  IvaEnvase( const AEmpresa, AEnvase, AProducto: string ): Integer;
    procedure ActualizarIva;
    function  TipoIvaValido( var sMsg: string ): boolean;

    function  GetDescuento: real;
    procedure DescuentoCliente;
  public
    { Public declarations }
  end;

  function FacturaManual( const AOwner: TComponent; var AEmpresa: string;
                          var AFactura: Integer; var AFecha: TDateTime ): boolean;

implementation

{$R *.dfm}

uses UDMAuxDB, CAuxiliarDB, CVariables, UDMBaseDatos, CMDFacturaManual, bMath,
     UDMCambioMoneda, DB, UDMFacturacion, UDMConfig;

  function FacturaManual( const AOwner: TComponent; var AEmpresa: string;
                          var AFactura: Integer; var AFecha: TDateTime ): boolean;
var
  DFDFacturaManual: TDFDFacturaManual;
begin
  DFDFacturaManual:= TDFDFacturaManual.Create( AOwner );
  try
    DFDFacturaManual.ShowModal;
    result:= DFDFacturaManual.bAceptar;
    if result then
    begin
      AEmpresa:= DFDFacturaManual.sEmpresa;
      AFactura:= DFDFacturaManual.iFactura;
      AFecha:= DFDFacturaManual.dFechaFactura;
    end;
  finally
    FreeAndNil( DFDFacturaManual );
  end;
end;

procedure TDFDFacturaManual.FormCreate(Sender: TObject);
begin
  CMDFacturaManual.UsarModuloDeDatos( Self, DMBaseDatos.DBBaseDatos.DatabaseName );

  eEmpresa.Tag := kEmpresa; //Para mostrar rejilla flotante
  eClienteFactura.Tag := KCliente; //Para poner nombre rejilla
  eMoneda.Tag := KMoneda; //Para poner todos los nombres
  eImpuesto.Tag := kImpuesto; //del panel maestro
  eFechaFactura.Tag := kCalendar;
  ePrevision_cobro_f.Tag := kCalendar;

  fecha_albaran_fal.Tag:= kCalendar;
  centro_salida_fal.Tag:= kCentro;
  centro_origen_fal.Tag:= kCentro;
  producto_fal.Tag:= kProducto;
  envase_fal.Tag:= kEnvase;
  categoria_fal.Tag:= kCategoria;


  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  eEmpresa.Text:= gsDefEmpresa;
  Calendario.Date:= Date;

  ConfigurarUnidadAbono;

  bAbono:= False;

  DescuentoCliente;
end;

procedure TDFDFacturaManual.FormDestroy(Sender: TObject);
begin
  CMDFacturaManual.LiberarModuloDeDatos;
end;

procedure TDFDFacturaManual.btnEmpresaClick(Sender: TObject);
begin
  DespliegaRejilla(btnEmpresa);
end;

procedure TDFDFacturaManual.btnClienteFacturaClick(Sender: TObject);
begin
  DespliegaRejilla(btnClienteFactura,[eEmpresa.Text]);
end;

procedure TDFDFacturaManual.btnImpuestoClick(Sender: TObject);
begin
  DespliegaRejilla( btnImpuesto );
end;

procedure TDFDFacturaManual.btnSeccionContable_Click(Sender: TObject);
begin
  //DespliegaRejilla(btnSeccionContable,[eEmpresa.Text]);
end;

procedure TDFDFacturaManual.btnMonedaClick(Sender: TObject);
begin
  DespliegaRejilla( btnMoneda );
end;

procedure TDFDFacturaManual.eEmpresaChange(Sender: TObject);
var
  iAux: integer;
  dFechaAux: TDateTime;
  sIvaAux, sMonedaAux: string;
begin
  stEmpresa.Caption:= DesEmpresa( eEmpresa.Text );
  stClienteFactura.Caption:= DesCliente( eEmpresa.Text, eClienteFactura.Text );

  (*FACTA?OS*)
  if eFechaFactura.Text = '' then
      eFechaFactura.Text:= DateToStr( Date );
  dFechaAux:= StrToDateDef( eFechaFactura.Text, Date );
  if DMDFacturaManual.ClaveFactura( eEmpresa.Text, eImpuesto.Text, bAbono, dFechaAux, iAux ) then
  begin
    eNumeroFactura.Text:= IntToStr( iAux );
  end
  else
  begin
    eNumeroFactura.Text:= '';
  end;
(*
  if DMDFacturaManual.ClaveFactura( eEmpresa.Text, eImpuesto.Text, bAbono, iAux, dAux ) then
  begin
    eNumeroFactura.Text:= IntToStr( iAux );
    if eFechaFactura.Text = '' then
      eFechaFactura.Text:= DateToStr( Date );
  end;
*)

  if DMDFacturaManual.GetImpuestoMoneda( eEmpresa.Text, eClienteFactura.Text, sIvaAux, sMonedaAux ) then
  begin
    eImpuesto.Text:= sIvaAux;
    eMoneda.Text:= sMonedaAux;
  end;

  stCentroSalida.Caption:= desCentro(eEmpresa.Text, centro_salida_fal.Text);
  stCentroOrigen.Caption:= desCentro(eEmpresa.Text, centro_origen_fal.Text);
  stProducto.Caption:= desProducto(eEmpresa.Text, producto_fal.Text);
  //stEnvase.Caption:= desEnvaseP(eEmpresa.Text, envase_fal.Text, producto_fal.Text);
  envase_falChange( envase_fal );
  stCategoria.Caption:= desCategoria(eEmpresa.Text, producto_fal.Text, categoria_fal.Text);

  //Fecha prevista cobro
  if TryStrToDate( eFechaFactura.Text, dFechaAux ) then
  begin
    ePrevision_cobro_f.Text:= DateToStr( GetFechaVencimiento( eEmpresa.Text, eClienteFactura.Text, dFechaAux ) );
  end;

  DescuentoCliente;
end;

procedure TDFDFacturaManual.eClienteFacturaChange(Sender: TObject);
var
  sIvaAux, sMonedaAux: string;
  dAux: TDateTime;
begin
  stClienteFactura.Caption:= DesCliente( eEmpresa.Text, eClienteFactura.Text );
  if DMDFacturaManual.GetImpuestoMoneda( eEmpresa.Text, eClienteFactura.Text, sIvaAux, sMonedaAux ) then
  begin
    eImpuesto.Text:= sIvaAux;
    eMoneda.Text:= sMonedaAux;
  end;
  //Fecha prevista cobro
  if TryStrToDate( eFechaFactura.Text, dAux ) then
  begin
    ePrevision_cobro_f.Text:= DateToStr( GetFechaVencimiento( eEmpresa.Text, eClienteFactura.Text, dAux ) );
  end;

  DescuentoCliente;
end;

procedure TDFDFacturaManual.eImpuestoChange(Sender: TObject);
var
  iAux: integer;
  dFechaAux: TDateTime;
  rImporteNetoAux, rImporteIvaAux, rImporteTotalAux: real;
begin
  stImpuesto.Caption:= desImpuesto( eImpuesto.Text );

  (*FACTA?OS*)
  if eFechaFactura.Text = '' then
      eFechaFactura.Text:= DateToStr( Date );
  dFechaAux:= StrToDateDef( eFechaFactura.Text, Date );
  if DMDFacturaManual.ClaveFactura( eEmpresa.Text, eImpuesto.Text, bAbono, dFechaAux, iAux ) then
  begin
    eNumeroFactura.Text:= IntToStr( iAux );
  end
  else
  begin
    eNumeroFactura.Text:= '';
  end;

  if DMDFacturaManual.GetPorcentajeIva( eEmpresa.Text, eClienteFactura.Text, eImpuesto.Text, StrToDateTime( eFechaFactura.Text ),
                                        rPorcentajeSuper, rPorcentajeReducido, rPorcentajeGeneral ) then
  begin
    rPorcentajeActual:= -1;
    if rbSuper.Checked then
      rPorcentajeActual:=  rPorcentajeSuper;
    if rbReducido.Checked then
      rPorcentajeActual:=  rPorcentajeReducido;
    if rbNormal.Checked then
      rPorcentajeActual:=  rPorcentajeGeneral;


    rImporteNetoAux:= StrToFloatDEf( eImporteNeto.Text, 0 );
    if rPorcentajeActual <> -1 then
    begin
      rImporteIvaAux:= bRoundTo( ( rImporteNetoAux * rPorcentajeActual ) / 100, -2 );
      ePorcentajeImpuesto.Text:= FormatFloat( '#0.00', rPorcentajeActual );
    end
    else
    begin
      ePorcentajeImpuesto.Text:= '';
      rImporteIvaAux:= 0;
    end;
    rImporteTotalAux:= rImporteNetoAux + rImporteIvaAux;

    if rImporteIvaAux <> 0 then
      eImporteImpuesto.Text:= FormatFloat( '#0.00', rImporteIvaAux )
    else
      eImporteImpuesto.Text:= '0';
    if rImporteTotalAux <> 0 then
      eImporteTotal.Text:= FormatFloat( '#0.00', rImporteTotalAux )
    else
      eImporteTotal.Text:= '0';
  end;
end;

procedure TDFDFacturaManual.eImporteNetoChange(Sender: TObject);
var
  rImporteNetoAux: real;
  iAux: integer;
  dFechaAux: TDateTime;
  iSigno: Integer;
begin
  rImporteNetoAux:= StrToFloatDEf( eImporteNeto.Text, 0 );
  if rImporteNetoAux < 0 then
    iSigno:= -1
  else
    iSigno:= 1;

  if  rImporteNetoAux < 0 then
  begin
    if not bAbono then
    begin
      bAbono:= True;
      lblFechaFactura.Caption:= 'Fecha Abono';
      lblNumeroFactura.Caption:= 'N?mero Abono';
      eNumeroFactura.Font.Color:= clRed;

      (*FACTA?OS*)
      if eFechaFactura.Text = '' then
        eFechaFactura.Text:= DateToStr( Date );
      dFechaAux:= StrToDateDef( eFechaFactura.Text, Date );
      if DMDFacturaManual.ClaveFactura( eEmpresa.Text, eImpuesto.Text, bAbono, dFechaAux, iAux ) then
      begin
        eNumeroFactura.Text:= IntToStr( iAux );
      end
      else
      begin
        eNumeroFactura.Text:= '';
      end;
    end;
  end
  else
  begin
    if bAbono then
    begin
      bAbono:= False;
      lblFechaFactura.Caption:= 'Fecha Factura';
      lblNumeroFactura.Caption:= 'N?mero Factura';
      eNumeroFactura.Font.Color:= clNavy;

      (*FACTA?OS*)
      if eFechaFactura.Text = '' then
        eFechaFactura.Text:= DateToStr( Date );
      dFechaAux:= StrToDateDef( eFechaFactura.Text, Date );
      if DMDFacturaManual.ClaveFactura( eEmpresa.Text, eImpuesto.Text, bAbono, dFechaAux, iAux ) then
      begin
        eNumeroFactura.Text:= IntToStr( iAux );
      end
      else
      begin
        eNumeroFactura.Text:= '';
      end;
    end;
  end;

  if rPorcentajeActual <> -1 then
    rImporteIva:= bRoundTo( ( iSigno * rImporteNetoAux * rPorcentajeActual ) / 100, -2 )
  else
    rImporteIva:= 0;

  rImporteIva:= iSigno * rImporteIva;
  rImporteTotal:= rImporteNetoAux + rImporteIva;
  if rImporteIva <> 0 then
    eImporteImpuesto.Text:= FormatFloat( '#0.00', iSigno * rImporteIva )
  else
    eImporteImpuesto.Text:= '0';
  if rImporteTotal <> 0 then
    eImporteTotal.Text:= FormatFloat( '#0.00', rImporteTotal )
  else
    eImporteTotal.Text:= '0';

  if rFactor = 0 then
  begin
    if not ChangeExist( eMoneda.Text, eFechaFactura.Text, rFactor ) then
    begin
      rFactor:= 0;
    end;
  end;

  if rFactor <> 0 then
  begin
    rImporteTotal:= StrToFloatDEf( eImporteTotal.Text, 0 );
    if rImporteTotal < 0 then
      rImporteEuros:= -1 * bRoundTo( ABS(rImporteTotal) * rFactor, -2)
    else
      rImporteEuros:= bRoundTo( rImporteTotal * rFactor, -2)
  end
  else
  begin
    rImporteEuros:= 0;
  end;

  if rImporteEuros <> 0 then
    eImporteEuros.Text:= FormatFloat( '#0.00', rImporteEuros )
  else
    eImporteEuros.Text:= '';

  if rImporteNetoAux < 0 then
  begin
    lblTextoManual.Caption:= 'Texto Abono';
  end
  else
  begin
    lblTextoManual.Caption:= 'Texto Factura';
  end;
end;

procedure TDFDFacturaManual.eMonedaChange(Sender: TObject);
var
  rImporteTotalAux, rImporteEurosAux: Real;
begin
  stMoneda.Caption:= desMoneda( eMoneda.Text );

  if not ChangeExist( eMoneda.Text, eFechaFactura.Text, rFactor ) then
  begin
    rFactor:= 0;
  end;

  if rFactor <> 0 then
  begin
    rImporteTotalAux:= StrToFloatDEf( eImporteTotal.Text, 0 );
    rImporteEurosAux:= bRoundTo( rImporteTotalAux * rFactor, -2)
  end
  else
  begin
    rImporteEurosAux:= 0;
  end;

  if rImporteEurosAux <> 0 then
    eImporteEuros.Text:= FormatFloat( '#0.00', rImporteEurosAux )
  else
    eImporteEuros.Text:= '';
end;

procedure TDFDFacturaManual.eFechaFacturaChange(Sender: TObject);
var
  rImporteTotalAux, rImporteEurosAux: Real;
  dFecha: TDateTime;
  iAux: integer;
begin
  if TryStrToDate( eFechaFactura.Text, dFecha) then
  begin
    if not ChangeExist( eMoneda.Text, eFechaFactura.Text, rFactor ) then
    begin
      rFactor:= 0;
    end;
  end
  else
  begin
    rFactor:= 0;
  end;


  if rFactor <> 0 then
  begin
    rImporteTotalAux:= StrToFloatDEf( eImporteTotal.Text, 0 );
    rImporteEurosAux:= bRoundTo( rImporteTotalAux * rFactor, -2)
  end
  else
  begin
    rImporteEurosAux:= 0;
  end;

  if rImporteEurosAux <> 0 then
    eImporteEuros.Text:= FormatFloat( '#0.00', rImporteEurosAux )
  else
    eImporteEuros.Text:= '';

  //Fecha prevista cobro
  if TryStrToDate( eFechaFactura.Text, dFecha ) then
  begin
    ePrevision_cobro_f.Text:= DateToStr( GetFechaVencimiento( eEmpresa.Text, eClienteFactura.Text, dFecha ) );
  end;

  (*FACTA?OS*)
  if DMDFacturaManual.ClaveFactura( eEmpresa.Text, eImpuesto.Text, bAbono, StrToDateDef( eFechaFactura.Text, Date ), iAux ) then
  begin
    eNumeroFactura.Text:= IntToStr( iAux );
  end
  else
  begin
    eNumeroFactura.Text:= '';
  end;

  DescuentoCliente;
end;

procedure TDFDFacturaManual.btnFechaFacturaClick(Sender: TObject);
begin
  DespliegaCalendario(btnFechaFactura);
end;

procedure TDFDFacturaManual.btnPrevisionCobroClick(Sender: TObject);
begin
  DespliegaCalendario(btnPrevisionCobro);
end;

procedure TDFDFacturaManual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*DEJAR SI EXISTE CALENDARIO}
    //Si  el calendario esta desplegado no hacemos nada
  if (Calendario <> nil) then
    if (Calendario.Visible) then
            //No hacemos nada
      Exit;

  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
            //No hacemos nada
      Exit;


    // Tecla ENTER - Cambio entre los Controles de Datos en modo edici?n
    //               y entre los Campos de B?squeda en la localizaci?n
  case key of
    vk_Return, vk_down:
      begin
        if not mmoConcepto.Focused then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
      end;
    vk_up:
      begin
        if not mmoConcepto.Focused then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        end;
      end;
    VK_F1:
      begin
        btnAceptar.Click;
      end;
    VK_ESCAPE:
      begin
        btnCancelar.Click;
      end;
    VK_F2:
      begin
        if eEmpresa.Focused then
          btnEmpresa.Click
        else
        if eClienteFactura.Focused then
          btnClienteFactura.Click
        else
        if eImpuesto.Focused then
          btnImpuesto.Click
        else
        if eMoneda.Focused then
          btnMoneda.Click
        else
        if eFechaFactura.Focused then
          btnFechaFactura.Click
        else
        if ePrevision_cobro_f.Focused then
          btnPrevisionCobro.Click
        else
        if centro_salida_fal.Focused then
          btnCentroSalida.Click
        else
        if centro_origen_fal.Focused then
          btnCentroOrigen.Click
        else
        if producto_fal.Focused then
          btnProducto.Click
        else
        if envase_fal.Focused then
          btnEnvase.Click
        else
        if categoria_fal.Focused then
          btnCategoria.Click
        else
        if fecha_albaran_fal.Focused then
          btnFechaAlbaran.Click;
      end;
  end;
end;

function TDFDFacturaManual.TipoIvaValido( var sMsg: string ): boolean;
var
  iAux: Integer;
begin
  result:= True;
  iAux:= IvaEnvase( eEmpresa.Text, envase_fal.Text, producto_fal.Text  );
  if iAux = 0 then
  begin
    if not rbSuper.Checked then
    begin
      sMsg:= 'Para el envase "' + envase_fal.Text + '" el tipo de IVA debe de ser el 0 - SuperReducido ';
      result:= False;
    end;
  end
  else
  if iAux = 1 then
  begin
    if not rbReducido.Checked then
    begin
      sMsg:= 'Para el envase "' + envase_fal.Text + '" el tipo de IVA debe de ser el 1 - Reducido ';
      result:= False;
    end;
  end
  else
  if iAux = 2 then
  begin
    if not rbNormal.Checked then
    begin
      sMsg:= 'Para el envase "' + envase_fal.Text + '" el tipo de IVA debe de ser el 2 - General ';
      result:= False;
    end;
  end;
end;


procedure TDFDFacturaManual.btnAceptarClick(Sender: TObject);
var
  sAux: string;
begin
  bAceptar:= False;
  if ParametrosCorrectos then
  begin
    if ComprobarConstraints then
    begin
      with DMDFacturaManual do
      begin
        if ClaveFacturaValida( sEmpresa, sImpuesto, bAbono, iFactura, dFechaFactura, sAux ) then
        begin
          if rbReducido.Checked or rbSuper.Checked or rbNormal.Checked then
          begin
            if TipoIvaValido( sAux )  then
            begin
              rImporte:= StrToFloat( eImporteNeto.Text );
              rImporteIva:= StrToFloat( eImporteImpuesto.Text );
              rImporteTotal:= StrToFloat( eImporteTotal.Text );
              rImporteEuros:= StrToFloat( eImporteEuros.Text );

              if not InsertarFacturaManual( sEmpresa, sCliente, sImpuesto, sMoneda, iFactura, dFechaFactura, dPrevisionCobro,
                   rImporte, rPorcentajeActual, rImporteIva, rImporteTotal, rImporteEuros, mmoConcepto.Text,
                   sCentroSalida, iAlbaran, dFechaAlbaran, sProducto, sCentroOrigen, sCategoria, sEnvase,
                   iUnidad, rUnidades, rPrecioAlb, rNetoAlb, rPorcDescuentoAlb, rDescuentoAlb, rImporteAlb, '' ) then
              begin
                Exit;
              end;
            end
            else
            begin
              ShowMessage( sAux );
              Exit;
            end;
          end
          else
          begin
            ShowMessage( 'Es necesario seleccionar un tipo de IVA (0- Supereducio, 1- Reducido o 2- General).');
            Exit;
          end;
        end
        else
        begin
          ShowMessage( sAux );
          Exit;
        end;
      end;

      //mensaje si tiene comision
          with DMAuxDB.QAux do
          begin
            SQl.Clear;
            SQl.Add(' select * ');
            SQl.Add(' from frf_fac_abonos_l, frf_salidas_c, frf_clientes ');
            SQl.Add(' where empresa_fal = :empresa ');
            SQl.Add(' and factura_fal = :abono ');
            SQl.Add(' and fecha_fal = :fecha ');
            SQl.Add(' and empresa_sc = :empresa ');
            SQl.Add(' and centro_salida_sc = centro_salida_fal ');
            SQl.Add(' and n_albaran_sc =  n_albaran_fal ');
            SQl.Add(' and fecha_sc = fecha_albaran_fal ');
            SQl.Add(' and empresa_c = :empresa ');
            SQl.Add(' and cliente_c = cliente_fac_sc ');
            SQl.Add(' and ( exists (select * from frf_clientes_descuento ');
            SQl.Add('               where empresa_cd = :empresa ');
            SQl.Add('               and cliente_cd = cliente_fac_sc ');
            SQl.Add('               and fecha_factura_sc between fecha_ini_cd and nvl(fecha_fin_cd,Today) ');
            SQl.Add('               and descuento_cd <> 0 ');
            SQl.Add('               and facturable_cd = 1 ) ');
            SQl.Add('       or ');
            SQl.Add('       exists (select * from frf_representantes_comision ');
            SQl.Add('               where empresa_rc = :empresa ');
            SQl.Add('               and representante_rc = representante_c ');
            SQl.Add('               and fecha_factura_sc between fecha_ini_rc and nvl(fecha_fin_rc,Today) ');
            SQl.Add('               and comision_rc <> 0 ) ');
            SQl.Add('     ) ');
            ParamByName('empresa').AsString:= eEmpresa.Text;
            ParamByName('abono').AsInteger:= StrToIntDef( eNumeroFactura.Text, 0 );
            ParamByName('fecha').AsDateTime:= StrToDateDef( eFechaFactura.Text, Date );
            Open;
            if not IsEmpty then
            begin
              ShowMessage('Cliente con descuento facturable o con representante con comisi?n, por favor revise los importes.');
            end;
            Close;
          end;

      bAceptar:= True;
      Close;
    end;
  end;
end;

procedure TDFDFacturaManual.btnCancelarClick(Sender: TObject);
begin
  bAceptar:= False;
  Close;
end;

function TDFDFacturaManual.CadenaCorrecta( const AControl: TWinControl; const AMsg, ADescripcion: string;
                                           var AResult: string ): boolean;
begin
  if Trim( TEdit(AControl).Text ) <> '' then
  begin
    if ( ADescripcion <> 'nil' ) and ( ADescripcion = '' ) then
    begin
      ShowMessage( AMsg + ' es incorrecto.');
      result:= false;
    end
    else
    begin
      result:= true;
    end;
  end
  else
  begin
    ShowMessage( AMsg + ' es de obligada inserci?n.');
    result:= false;
  end;
  if not result then
  begin
    if AControl.CanFocus then
      AControl.SetFocus;
  end
  else
  begin
    AResult:= TEdit(AControl).Text;
  end;
end;

function  TDFDFacturaManual.FechaCorrecta( const AControl: TWinControl; const AMsg: string; var AResult: TDateTime ): boolean;
var
  dAux: TDateTime;
begin
  if TEdit(AControl).Text <> '' then
  begin
    if TryStrToDate( TEdit(AControl).Text, dAux ) then
    begin
      result:= true;
    end
    else
    begin
      ShowMessage( AMsg + ' es incorrecto.');
      result:= false;
    end;
  end
  else
  begin
    ShowMessage( AMsg + ' es de obligada inserci?n.');
    result:= false;
  end;
  if not result then
  begin
    if AControl.CanFocus then
      AControl.SetFocus;
  end
  else
  begin
    AResult:= dAux;
  end;
end;

function  TDFDFacturaManual.EnteroCorrecto( const AControl: TWinControl; const AMsg: string; var AResult: Integer ): boolean;
var
  dAux: Integer;
begin
  if TEdit(AControl).Text <> '' then
  begin
    if TryStrToInt( TEdit(AControl).Text, dAux ) then
    begin
      result:= true;
    end
    else
    begin
      ShowMessage( AMsg + ' es incorrecto.');
      result:= false;
    end;
  end
  else
  begin
    ShowMessage( AMsg + ' es de obligada inserci?n.');
    result:= false;
  end;
  if not result then
  begin
    if AControl.CanFocus then
      AControl.SetFocus;
  end
  else
  begin
    AResult:= dAux;
  end;
end;

function  TDFDFacturaManual.RealCorrecto( const AControl: TWinControl; const AMsg: string; var AResult: Real ): boolean;
var
  dAux: double;
begin
  if TEdit(AControl).Text <> '' then
  begin
    if TryStrToFloat( TEdit(AControl).Text, dAux ) then
    begin
      result:= true;
    end
    else
    begin
      ShowMessage( AMsg + ' es incorrecto.');
      result:= false;
    end;
  end
  else
  begin
    ShowMessage( AMsg + ' es de obligada inserci?n.');
    result:= false;
  end;
  if not result then
  begin
    if AControl.CanFocus then
      AControl.SetFocus;
  end
  else
  begin
    AResult:= dAux;
  end;
end;

function  TDFDFacturaManual.ExisteAlbaran: boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_salidas_c');
    SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('  and centro_salida_sc = :centro ');
    SQL.Add('  and n_albaran_sc = :albaran ');
    SQL.Add('  and fecha_sc = :fecha ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentroSalida;
    ParamByName('albaran').AsInteger:= iAlbaran;
    ParamByName('fecha').AsDateTime:= dFechaAlbaran;

    Open;

    try
      result:= not IsEmpty;
    finally
      Close
    end;
  end;
end;

function  TDFDFacturaManual.ExisteDatosAlbaran: boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_salidas_l');
    SQL.Add('where empresa_sl = :empresa ');
    SQL.Add('  and centro_salida_sl = :centro ');
    SQL.Add('  and n_albaran_sl = :albaran ');
    SQL.Add('  and fecha_sl = :fecha ');

    SQL.Add('  and centro_origen_sl = :origen ');
    SQL.Add('  and producto_sl = :producto ');
    SQL.Add('  and envase_sl = :envase ');
    SQL.Add('  and categoria_sl = :categoria ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentroSalida;
    ParamByName('albaran').AsInteger:= iAlbaran;
    ParamByName('fecha').AsDateTime:= dFechaAlbaran;

    ParamByName('origen').AsString:= sCentroOrigen;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('envase').AsString:= sEnvase;
    ParamByName('categoria').AsString:= sCategoria;

    Open;

    try
      result:= not IsEmpty;
    finally
      Close
    end;
  end;
end;


function  TDFDFacturaManual.ComprobarConstraints: boolean;
begin
  result:= False;
  //Existe albaran
  if not  ExisteAlbaran then
  begin
    ShowMessage('Albar?n incorrecto (centro salida - n?mero albar?n - fecha albar?n ).');
    centro_salida_fal.SetFocus;
    Exit;
  end;

  //Existe producto, origen, envase, categoria si es un abono
  //if rImporteTotal < 0 then
  //begin
    if not  ExisteDatosAlbaran then
    begin
      ShowMessage('Producto, origen, envase y/o categoria inexistente para el albar?n seleccionado.');
      centro_salida_fal.SetFocus;
      Exit;
    end;
  //end;

  //Abono signo negativo, factura positivo
  if rImporteTotal > 0 then
  begin
    if rImporteAlb < 0 then
    begin
      ShowMessage('El signo del detalle de la factura debe ser el mismo que el de la cabecera.');
      if precio_fal.CanFocus then
        precio_fal.SetFocus
      else
        importe_fal.SetFocus;
      Exit;
    end;
  end
  else
  begin
    if rImporteAlb > 0 then
    begin
      ShowMessage('El signo del detalle de la factura debe ser el mismo que el de la cabecera.');
      if precio_fal.CanFocus then
        precio_fal.SetFocus
      else
        importe_fal.SetFocus;
      Exit;
    end;
  end;

  //La fecha de la factura debe ser superior a la del albaran
  if dFechaFactura < dFechaAlbaran then
  begin
    eFechaFactura.SetFocus;
    ShowMessage('La fecha de la factura debe de ser mayor o igual a la del albar?n.');
    Exit;
  end;

  if ABS(rImporte) < ABS(rImporteAlb) then
  begin
    if importe_fal.CanFocus then
      importe_fal.SetFocus
    else
      precio_fal.SetFocus;
    ShowMessage('El importe del albar?n es sin IVA, no puede ser superior al Importe Neto de la factura.');
    Exit;
  end;

  result:= True;
end;


function  TDFDFacturaManual.ParametrosCorrectos: boolean;
var
  iAux: integer;
begin
  result:= false;

  if ( not DMConfig.EsLaFont ) and ( Trim(eEmpresa.Text) <> '078' ) then
  begin
    eEmpresa.SetFocus;
    raise Exception.Create('Solo se pueden grabar remesas de la empresa 078-Bondelicious.');
  end;

    if CadenaCorrecta( eEmpresa, 'El c?digo de la empresa', stEmpresa.Caption, sEmpresa ) then
  if CadenaCorrecta( eClienteFactura, 'El c?digo del cliente a facturar ', stClienteFactura.Caption, sCliente ) then
  if CadenaCorrecta( eImpuesto, 'El c?digo del impuesto ', stImpuesto.Caption, sImpuesto ) then
  if CadenaCorrecta( eMoneda, 'El c?digo de la moneda ', stMoneda.Caption, sMoneda ) then
  if EnteroCorrecto( eNumeroFactura, 'El n?mero de la factura ', iFactura ) then
  if FechaCorrecta( eFechaFactura, 'La fecha de la factura ', dFechaFactura ) then
  if FechaCorrecta( ePrevision_cobro_f, 'La fecha prevista de cobro de la factura ', dPrevisionCobro ) then
  if RealCorrecto( eImporteNeto, 'El importe de la factura ', rImporte ) then
  if CadenaCorrecta( centro_salida_fal, 'El centro de salida ', stCentroSalida.Caption, sCentroSalida ) then
  if EnteroCorrecto( n_albaran_fal, 'El n?mero del albar?n ', iAlbaran ) then
  if FechaCorrecta( fecha_albaran_fal, 'La fecha del albar?n ', dFechaAlbaran ) then
  if CadenaCorrecta( producto_fal, 'El producto del detalle', stProducto.Caption, sProducto ) then
  if CadenaCorrecta( centro_origen_fal, 'El centro de origen ', stCentroOrigen.Caption, sCentroOrigen ) then
  if CadenaCorrecta( envase_fal, 'El envase del detalle', stEnvase.Caption, sEnvase ) then
  if CadenaCorrecta( categoria_fal, 'La categor?a del detalle', stCategoria.Caption, sCategoria ) then

  if RealCorrecto( neto_fal, 'El importe del albar?n ', rNetoAlb ) then
  if RealCorrecto( porc_descuento_fal, 'El descuento del albar?n ', rPorcDescuentoAlb ) then
  if RealCorrecto( descuento_fal, 'El descuento del albar?n ', rDescuentoAlb ) then
  if RealCorrecto( importe_fal, 'El importe del albar?n ', rImporteAlb ) then

  begin
    if not ChangeExist( eMoneda.Text, eFechaFactura.Text ) then
    begin
      ShowMessage('El cambio del dia no esta grabado.');    end
    else
    if Trim(eImporteEuros.Text) = '' then
    begin
      ShowMessage('Falta importe en euros. ' + #13 + #10 +
                  'Posiblemente moneda incorrecta o el cambio del dia no este grabado.');
    end
    else
    begin
      rImporteEuros:= StrToFloat( eImporteEuros.Text );
      iUnidad:= unidad_fal.ItemIndex;
      if iUnidad > 0 then
      begin
        if iUnidad = 3 then
        begin
          if not RealCorrecto( unidades_fal, 'El n?mero unidades ', rUnidades ) then
            Exit;
        end
        else
        begin
          if not EnteroCorrecto( unidades_fal, 'El n?mero unidades ', iAux ) then
            Exit;
          rUnidades:= iAux;
        end;

        if RealCorrecto( precio_fal, 'El precio del detalle ', rPrecioAlb ) then
        if rUnidades < 0 then
        begin
          case iUnidad  of
            1: ShowMessage('El n?mero de unidades debe ser mayor que 0');
            2: ShowMessage('El n?mero de cajas debe ser mayor que 0');
            3: ShowMessage('El n?mero de kilos debe ser mayor que 0');
          end;
          Exit;
        end;
      end;
      if Trim( mmoConcepto.Text ) = '' then
      begin
        ShowMessage('Factura/Abono sin texto en el cuerpo de la factura.');
        Exit;
      end;
      result:= true;
    end;
  end
end;

procedure TDFDFacturaManual.centro_salida_falChange(Sender: TObject);
begin
  stCentroSalida.Caption:= desCentro(eEmpresa.Text, centro_salida_fal.Text);
end;

procedure TDFDFacturaManual.centro_origen_falChange(Sender: TObject);
begin
  stCentroOrigen.Caption:= desCentro(eEmpresa.Text, centro_origen_fal.Text);
end;

procedure TDFDFacturaManual.producto_falChange(Sender: TObject);
begin
  stProducto.Caption:= desProducto(eEmpresa.Text, producto_fal.Text);
  stCategoria.Caption:= desCategoria(eEmpresa.Text, producto_fal.Text, categoria_fal.Text);
  ActualizarIva
end;

procedure TDFDFacturaManual.ActualizarIva;
var
  iAux: integer;
begin
  if not( rbSuper.Checked or rbReducido.Checked or rbNormal.Checked ) then
  begin
    iAux:= IvaEnvase( eEmpresa.Text, envase_fal.Text, producto_fal.Text  );
    if iAux = 0 then
      rbSuper.Checked:= True
    else
    if iAux = 1 then
      rbReducido.Checked:= True
    else
    if iAux = 2 then
      rbNormal.Checked:= True
  end;
end;

procedure TDFDFacturaManual.categoria_falChange(Sender: TObject);
begin
  stCategoria.Caption:= desCategoria(eEmpresa.Text, producto_fal.Text, categoria_fal.Text);
end;

procedure TDFDFacturaManual.envase_falChange(Sender: TObject);
begin
  stEnvase.Caption:= desEnvaseP(eEmpresa.Text, envase_fal.Text, producto_fal.Text);
  ActualizarIva;
end;

procedure TDFDFacturaManual.ConfigurarUnidadAbono;
begin
  if unidad_fal.ItemIndex = 0 then
  begin
    unidades_fal.ReadOnly:= True;
    unidades_fal.ColorEdit:= clSilver;
    unidades_fal.ColorNormal:= clSilver;
    unidades_fal.TabStop:= False;
    unidades_fal.Text:= '1';
    (*

    precio_fal.ReadOnly:= True;
    precio_fal.ColorEdit:= clSilver;
    precio_fal.ColorNormal:= clSilver;
    precio_fal.TabStop:= False;
    *)

    lblUnidades.Caption:= '';
    unidades_fal.Text:= '1';
    precio_fal.Text:= importe_fal.Text;
  end
  else
  begin
    unidades_fal.ReadOnly:= False;
    unidades_fal.ColorEdit:= clMoneyGreen;
    unidades_fal.ColorNormal:= clWhite;
    unidades_fal.TabStop:= True;
    (*
    precio_fal.ReadOnly:= False;
    precio_fal.ColorEdit:= clMoneyGreen;
    precio_fal.ColorNormal:= clWhite;
    precio_fal.TabStop:= True;
    *)
    case unidad_fal.ItemIndex of
      1:
      begin
        lblUnidades.Caption:= 'Unidades';
        if unidades_fal.Text <> '' then
        begin
          unidades_fal.Text:= IntToStr( Trunc( StrToFloat( unidades_fal.Text ) ) );
        end;
      end;
      2:
      begin
        lblUnidades.Caption:= 'Cajas';
        if unidades_fal.Text <> '' then
        begin
          unidades_fal.Text:= IntToStr( Trunc( StrToFloat( unidades_fal.Text ) ) );
        end;
      end;
      3: lblUnidades.Caption:= 'Kilos';
    end;
  end;
end;

procedure TDFDFacturaManual.unidad_falChange(Sender: TObject);
begin
  ConfigurarUnidadAbono;
end;

(*
procedure TDFDFacturaManual.precio_falChange(Sender: TObject);
var
  rUnidades, rPrecio, rImporte: Real;
begin
  if not precio_fal.Focused then
    Exit;

  if unidad_fal.ItemIndex = 0 then
    Exit;

  if Trim(unidades_fal.Text) = '' then
    rUnidades:= 0
  else
  begin
    if unidad_fal.ItemIndex = 3 then
    begin
      rUnidades:= StrToFloat( unidades_fal.Text );
    end
    else
    begin
      rUnidades:= StrToInt( unidades_fal.Text );
    end;
  end;

  if (Trim(precio_fal.Text) = '') or (Trim(precio_fal.Text) = '-') then
    rPrecio:= 0
  else
    rPrecio:= StrToFloat( precio_fal.Text );
  if rPrecio < 0 then
    rImporte:= -1 * bRoundTo( Abs( rPrecio ) * rUnidades, -2 )
  else
    rImporte:= bRoundTo( rPrecio * rUnidades, -2 );

  importe_fal.Text:= FloatToStr( rImporte );
end;

procedure TDFDFacturaManual.importe_falChange(Sender: TObject);
var
  rUnidades, rPrecio, rImporte: Real;
begin
  if not importe_fal.Focused then
    Exit;

  if unidad_fal.ItemIndex = 0 then
    Exit;

  if Trim(unidades_fal.Text) = '' then
    rUnidades:= 0
  else
  begin
    if unidad_fal.ItemIndex = 3 then
    begin
      rUnidades:= StrToFloat( unidades_fal.Text );
    end
    else
    begin
      rUnidades:= StrToInt( unidades_fal.Text );
    end;
  end;

  if Trim(importe_fal.Text) = '' then
    rImporte:= 0
  else
    rImporte:= StrToFloat( importe_fal.Text );
  if rUnidades = 0 then
  begin
    if rImporte = 0 then
    begin
      if Trim(precio_fal.Text) = '' then
        rPrecio:= 0
      else
        rPrecio:= StrToFloat( precio_fal.Text );
    end
    else
    begin
      rPrecio:= 0
    end;
  end
  else
  begin
    if rUnidades > 0 then
    begin
      rPrecio:= bRoundTo( rImporte / rUnidades, -3 );
    end
    else
    begin
      rPrecio:= 0;
    end;
  end;

  precio_fal.Text:= FloatToStr( rPrecio );
end;
*)

procedure TDFDFacturaManual.btnFechaAlbaranClick(Sender: TObject);
begin
  Calendario.BControl:= fecha_albaran_fal;
  btnFechaAlbaran.CalendarShow;
end;

procedure TDFDFacturaManual.btnCentroSalidaClick(Sender: TObject);
begin
  DespliegaRejilla(btnCentroSalida, [eEmpresa.text]);
end;

procedure TDFDFacturaManual.btnProductoClick(Sender: TObject);
begin
  DespliegaRejilla(btnProducto, [eEmpresa.text]);
end;

procedure TDFDFacturaManual.btnCentroOrigenClick(Sender: TObject);
begin
  DespliegaRejilla(btnCentroOrigen, [eEmpresa.text]);
end;

procedure TDFDFacturaManual.btnEnvaseClick(Sender: TObject);
var
  sAux: string;
begin
  sAux:= GetProductoBase( eEmpresa.Text, producto_fal.Text );
  DespliegaRejilla(btnEnvase, [eEmpresa.text, sAux, eClienteFactura.Text]);
end;

procedure TDFDFacturaManual.btnCategoriaClick(Sender: TObject);
begin
  DespliegaRejilla(btnCategoria, [eEmpresa.Text, producto_fal.Text]);
end;

procedure TDFDFacturaManual.rbSuperClick(Sender: TObject);
var
  rImporteNetoAux, rImporteIvaAux, rImporteTotalAux, rImporteEurosAux: real;
begin
    rPorcentajeActual:= -1;
    if rbSuper.Checked then
      rPorcentajeActual:=  rPorcentajeSuper;
    if rbReducido.Checked then
      rPorcentajeActual:=  rPorcentajeReducido;
    if rbNormal.Checked then
      rPorcentajeActual:=  rPorcentajeGeneral;

    rImporteNetoAux:= StrToFloatDEf( eImporteNeto.Text, 0 );
    if rPorcentajeActual <> -1 then
    begin
      rImporteIvaAux:= bRoundTo( ( rImporteNetoAux * rPorcentajeActual ) / 100, -2 );
      ePorcentajeImpuesto.Text:= FormatFloat( '#0.00', rPorcentajeActual );
    end
    else
    begin
      ePorcentajeImpuesto.Text:= '';
      rImporteIvaAux:= 0;
    end;
    rImporteTotalAux:= rImporteNetoAux + rImporteIvaAux;

    if rImporteIvaAux <> 0 then
      eImporteImpuesto.Text:= FormatFloat( '#0.00', rImporteIvaAux )
    else
      eImporteImpuesto.Text:= '0';
    if rImporteTotalAux <> 0 then
      eImporteTotal.Text:= FormatFloat( '#0.00', rImporteTotalAux )
    else
      eImporteTotal.Text:= '0';

    if rFactor <> 0 then
    begin
      if rImporteTotalAux < 0 then
        rImporteEurosAux:= -1 * bRoundTo( ABS(rImporteTotalAux) * rFactor, -2)
      else
        rImporteEurosAux:= bRoundTo( rImporteTotalAux * rFactor, -2)
    end
    else
    begin
      rImporteEurosAux:= 0;
    end;

    if rImporteEurosAux <> 0 then
      eImporteEuros.Text:= FormatFloat( '#0.00', rImporteEurosAux )
    else
      eImporteEuros.Text:= '';
end;

function TDFDFacturaManual.IvaEnvase( const AEmpresa, AEnvase, AProducto: string ): Integer;
var
  rImporteNetoAux, rImporteIvaAux, rImporteTotalAux: real;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_iva_e ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where empresa_e = :empresa ');
    SQL.Add(' and envase_e = :envase ');
    SQL.Add(' and producto_base_e = ');
    SQL.Add(' ( ');
    SQL.Add('   select producto_base_p ');
    SQL.Add('   from frf_productos ');
    SQL.Add('   where empresa_p = :empresa ');
    SQL.Add('   and producto_p = :producto ');
    SQL.Add(' ) ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('envase').AsString:= AEnvase;
    ParamByName('producto').AsString:= AProducto;
    Open;
    if IsEmpty then
      result:= -1
    else
      result:= FieldByName('tipo_iva_e').AsInteger;
    Close;
  end;
end;

function TDFDFacturaManual.GetDescuento: real;
begin
    DMAuxDB.QAux.SQL.Clear;
    DMAuxDB.QAux.SQL.Add(' select comision_rc  ');
    DMAuxDB.QAux.SQL.Add(' from frf_representantes_comision  ');
    DMAuxDB.QAux.SQL.Add(' where empresa_rc = :empresa  ');
    DMAuxDB.QAux.SQL.Add(' and representante_rc = ( select representante_c from frf_clientes  ');
    DMAuxDB.QAux.SQL.Add('                          where empresa_c = :empresa  ');
    DMAuxDB.QAux.SQL.Add('                          and cliente_c = :cliente )  ');
    DMAuxDB.QAux.SQL.Add(' and :fecha between fecha_ini_rc and nvl(fecha_fin_rc,Today)  ');
    DMAuxDB.QAux.ParamByName('empresa').AsString:= eEmpresa.Text;
    DMAuxDB.QAux.ParamByName('cliente').AsString:= eClienteFactura.Text;
    DMAuxDB.QAux.ParamByName('fecha').AsDateTime:= StrToDate( eFechaFactura.Text );
    DMAuxDB.QAux.Open;
    result:= DMAuxDB.QAux.FieldByName('comision_rc').AsFloat;
    DMAuxDB.QAux.Close;

    DMAuxDB.QAux.SQL.Clear;
    DMAuxDB.QAux.SQL.Add(' select descuento_cd from frf_clientes_descuento ');
    DMAuxDB.QAux.SQL.Add(' where empresa_cd = :empresa ');
    DMAuxDB.QAux.SQL.Add(' and cliente_cd = :cliente ');
    DMAuxDB.QAux.SQL.Add(' and :fecha between fecha_ini_cd and nvl(fecha_fin_cd,Today) ');
    DMAuxDB.QAux.SQL.Add(' and descuento_cd <> 0 ');
    DMAuxDB.QAux.SQL.Add(' and facturable_cd = 1  ');
    DMAuxDB.QAux.ParamByName('empresa').AsString:= eEmpresa.Text;
    DMAuxDB.QAux.ParamByName('cliente').AsString:= eClienteFactura.Text;
    DMAuxDB.QAux.ParamByName('fecha').AsDateTime:= StrToDate( eFechaFactura.Text );
    DMAuxDB.QAux.Open;
    result:= result + DMAuxDB.QAux.FieldByName('descuento_cd').AsFloat;
    DMAuxDB.QAux.Close;
end;

procedure TDFDFacturaManual.DescuentoCliente;
var
  dFechaAux: TDateTime;
begin
  if ( stEmpresa.Caption <> '' )  and  ( stClienteFactura.Caption <> '' ) and
     TryStrToDate( eFechaFactura.Text, dFechaAux ) then
  begin
    rPorcDescuento:= GetDescuento;
    chkDescuento.Caption:= 'Descuento del ' + FloatToStr(rPorcDescuento) + '%.'
  end;
end;

procedure TDFDFacturaManual.chkDescuentoClick(Sender: TObject);
begin
  if chkDescuento.Checked then
  begin
    porc_descuento_fal.Text:= FloatToStr( rPorcDescuento );
  end
  else
  begin
    porc_descuento_fal.Text:= FloatToStr( 0 );
  end;
  edtImporteBrutoChange( edtImporteBruto );
  unidades_falChange( unidades_fal );
end;

procedure TDFDFacturaManual.unidades_falChange(Sender: TObject);
var
  unidades, precio, porDescuento, descuento, neto, importe: real;
  aux: string;
begin
    if Trim( unidades_fal.Text ) = '' then
    begin
      unidades:= 0;
    end
    else
    begin
      aux:= StringReplace( unidades_fal.Text, '.', '', [rfReplaceAll, rfIgnoreCase] );
      unidades:= StrToFloat( aux );
    end;

    if ( Trim( precio_fal.Text ) = '' ) or  ( Trim( precio_fal.Text ) = '-' ) then
    begin
      precio:= 0
    end
    else
    begin
      aux:= StringReplace( precio_fal.Text, '.', '', [rfReplaceAll, rfIgnoreCase] );
      precio:= StrToFloat( aux );
    end;

    if ( Trim( porc_descuento_fal.Text ) = '' ) or  ( Trim( porc_descuento_fal.Text ) = '-' ) then
    begin
      porDescuento:= 0
    end
    else
    begin
      aux:= StringReplace( porc_descuento_fal.Text, '.', '', [rfReplaceAll, rfIgnoreCase] );
      porDescuento:= StrToFloat( aux );
    end;


    neto:= bRoundTo( unidades * precio, 2 );
    descuento:= bRoundTo( ( neto * porDescuento ) / 100, 2 );
    importe:= neto - descuento;

    neto_fal.Text:= FloatToStr( neto );
    //porc_descuento_fal.Text:= FloatToStr( porDescuento );
    descuento_fal.Text:= FloatToStr( Descuento );
    importe_fal.Text:= FloatToStr( importe );
end;
(*
var
  rUnidades, rPrecio, rImporte: Real;
begin
  if not unidades_fal.Focused then
    Exit;

  if unidad_fal.ItemIndex = 0 then
    Exit;

  if Trim(unidades_fal.Text) = '' then
    rUnidades:= 0
  else
  begin
    if unidad_fal.ItemIndex = 3 then
    begin
      rUnidades:= StrToFloat( unidades_fal.Text );
    end
    else
    begin
      try
        rUnidades:= StrToInt( unidades_fal.Text );
      except
        unidades_fal.Text:= IntToStr( Trunc( StrToFloat( unidades_fal.Text ) ) );
        unidades_fal.SelStart:= Length( unidades_fal.Text );
        unidades_fal.SelLength:= 0;
        rUnidades:= StrToInt( unidades_fal.Text );
      end;
    end;
  end;

  if (Trim(precio_fal.Text) = '') or (Trim(precio_fal.Text) = '-') then
    rPrecio:= 0
  else
    rPrecio:= StrToFloat( precio_fal.Text );

  if rPrecio < 0 then
    rImporte:= -1 * bRoundTo( Abs( rPrecio ) * rUnidades, -2 )
  else
    rImporte:= bRoundTo( rPrecio * rUnidades, -2 );

  importe_fal.Text:= FloatToStr( rImporte );
end;
*)

procedure TDFDFacturaManual.edtImporteBrutoChange(Sender: TObject);
begin
  if chkDescuento.Checked then
    eImporteNeto.Text:= FloatToStr( bRoundTo( StrToFloatDef( edtImporteBruto.Text, 0 ) * ( 1 - ( rPorcDescuento / 100 ) ), 2) )
  else
    eImporteNeto.Text:= edtImporteBruto.Text;
end;



end.
