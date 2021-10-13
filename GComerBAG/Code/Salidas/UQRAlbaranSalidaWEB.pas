unit UQRAlbaranSalidaWEB;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables,
  jpeg, usalidaUtils;

type
  TQRAlbaranSalidaWEB = class(TQuickRep)
    BonnyBand: TQRBand;
    BandaDatos: TQRBand;
    CabeceraTabla: TQRBand;
    cajas: TQRLabel;
    PrecioUnidad: TQRDBText;
    precioNeto: TQRDBText;
    lin5: TQRShape;
    lin7: TQRShape;
    lin8: TQRShape;
    QRBand1: TQRBand;
    QRGroup1: TQRGroup;
    Rneto: TQRShape;
    ChildBand2: TQRChildBand;
    LObservaciones: TQRLabel;
    cantNeta: TQRExpr;
    mmoObservaciones: TQRMemo;
    QRBand2: TQRBand;
    PsQRShape16: TQRShape;
    PsQRShape17: TQRShape;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRLabel10: TQRLabel;
    LCentro: TQRLabel;
    PsQRLabel11: TQRLabel;
    LTransporte: TQRLabel;
    PsQRShape20: TQRShape;
    PsQRShape23: TQRShape;
    PsQRShape24: TQRShape;
    PsQRShape25: TQRShape;
    PsQRShape26: TQRShape;
    PsQRShape22: TQRShape;
    PsQRShape21: TQRShape;
    PsQRShape19: TQRShape;
    PsQRLabel23: TQRLabel;
    PsQRLabel29: TQRLabel;
    PsQRLabel30: TQRLabel;
    PsQRShape33: TQRShape;
    PsQRShape35: TQRShape;
    PsQRShape36: TQRShape;
    descripcion2_e: TQRDBText;
    PsQRLabel18: TQRLabel;
    qrlNAlbaran: TQRLabel;
    LFecha: TQRLabel;
    LHora: TQRLabel;
    LPedido: TQRLabel;
    QRImageCab: TQRImage;
    qrmDireccion: TQRMemo;
    qrxIva: TQRExpr;
    qrsIva: TQRShape;
    qrlLblTotal: TQRLabel;
    qrsTotal: TQRShape;
    qrlNAlbaran2: TQRLabel;
    QRImgLogo: TQRImage;
    bndPie: TQRBand;
    PsQRSysData1: TQRSysData;
    qrlBaseTransporte: TQRLabel;
    PsQRShape14: TQRShape;
    qrl1: TQRLabel;
    qrs1: TQRShape;
    qrl3: TQRLabel;
    qrlTotalCobrar: TQRLabel;
    qrs2: TQRShape;
    qreimporte_neto_sl: TQRDBText;
    qreimporte_neto_sl1: TQRDBText;
    qrs4: TQRShape;
    qrl5: TQRLabel;
    qreimporte_total_sl: TQRDBText;
    qrs3: TQRShape;
    qrx1: TQRExpr;
    qrs5: TQRShape;
    qrs6: TQRShape;
    qrs7: TQRShape;
    qrs8: TQRShape;
    qrl2: TQRLabel;
    qrlIvaTransporte: TQRLabel;
    qrlTotalTransporte: TQRLabel;
    qrlTipoIvaTransporte: TQRLabel;
    qrmReponsabilidadEnvase: TQRMemo;
    qrmGarantia: TQRMemo;
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cajasPrint(sender: TObject; var Value: String);
    procedure CabeceraTablaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaDatosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure descripcion2_ePrint(sender: TObject; var Value: String);
    procedure qreimporte_neto_sl1Print(sender: TObject; var Value: String);
    procedure bndPieBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    rGGN : TGGN;
    rBaseTransporte, rTipoIvaTransporte, rIvaTransporte, rTotalPedido: real;
    sCodCliente, sCodEmpresa: string;
    bHayGranada: Boolean;

    procedure Configurar(const AFecha: TDateTime);

  end;

implementation

uses UDMAuxDB, CVariables, StrUtils, UDMBaseDatos, bTextUtils, bSQLUtils,
     Dialogs, UDMConfig, bMath, CGlobal;

{$R *.DFM}


procedure TQRAlbaranSalidaWEB.Configurar(const AFecha: TDateTime);
begin


  if FileExists( gsDirActual + '\recursos\000Page.wmf') then
  begin
    QRImageCab.Top:= -18; //-20
    QRImageCab.Left:= -37; //-20
    QRImageCab.Width:= 763; //-30
    QRImageCab.Height:= 1102; //-20
    QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\000Page.wmf');
  end;
  (*TODO*)
  (*
  if Now < StrToDate('1/2/2014') then
  begin
    if FileExists( gsDirActual + '\recursos\LogoPicaroGourmet.jpg') then
    begin
      QRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\LogoPicaroGourmet.jpg');
    end;
  end
  else
  *)
  begin
    if AFecha >= StrToDate('01/07/2020') then
    begin
      if FileExists( gsDirActual + '\recursos\LogoGrupoBonnysa.jpg') then
      begin
        QRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\LogoGrupoBonnysa.jpg');
      end
    end
    else
    if FileExists( gsDirActual + '\recursos\LogoBongranade.jpg') then
    begin
      QRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\LogoBongranade.jpg');
    end
    else
    if FileExists( gsDirActual + '\recursos\BongranadeSanflavino.jpg') then
    begin
      QRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\BongranadeSanflavino.jpg');
    end
    else
    if FileExists( gsDirActual + '\recursos\Sanflavino.jpg') then
    begin
      QRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\Sanflavino.jpg');
    end;
  end;
end;

procedure TQRAlbaranSalidaWEB.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := Trim( mmoObservaciones.Lines.Text ) <> '';
end;

procedure TQRAlbaranSalidaWEB.cajasPrint(sender: TObject; var Value: String);
begin
  //CAJAS O UNIDADES
  value := FormatFloat('#,##0', DMBaseDatos.QListado.FieldByName('unidades').AsInteger);
end;

procedure TQRAlbaranSalidaWEB.CabeceraTablaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlTipoIvaTransporte.Caption:= FloatToStr( rTipoIvaTransporte ) + '%';
  qrlBaseTransporte.Caption:= FormatFloat( '#,##0.00€', rBaseTransporte );
  qrlIvaTransporte.Caption:= FormatFloat( '#,##0.00€', rIvaTransporte );
  qrlTotalTransporte.Caption:= FormatFloat( '#,##0.00€', rBaseTransporte +  rIvaTransporte);
  qrlTotalCobrar.Caption:= FormatFloat( '#,##0.00€', rBaseTransporte +  rIvaTransporte + rTotalPedido );
end;

procedure TQRAlbaranSalidaWEB.BandaDatosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if not bHayGranada then
    bHayGranada:= DMBaseDatos.QListado.FieldByName('producto_p').AsString = 'W';
  rTotalPedido:= rTotalPedido + DMBaseDatos.QListado.FieldByName('importe_total_sl').AsFloat;
end;

procedure TQRAlbaranSalidaWEB.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  bHayGranada:= False;
  rTotalPedido:= 0;
end;

procedure TQRAlbaranSalidaWEB.descripcion2_ePrint(sender: TObject;
  var Value: String);
begin
  Value:= desEnvaseCliente( sCodEmpresa, DMBaseDatos.QListado.FieldByName('producto_p').AsString,
                              DMBaseDatos.QListado.FieldByName('envase_sl').AsString, sCodCliente);
end;

procedure TQRAlbaranSalidaWEB.qreimporte_neto_sl1Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + '%';
end;

procedure TQRAlbaranSalidaWEB.bndPieBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  bEnEspanyol: Boolean;
begin
  bEnEspanyol:= True;



  if bEnEspanyol then
  begin
    qrmReponsabilidadEnvase.Lines.Clear;
    qrmReponsabilidadEnvase.Lines.Add('"De conformidad con lo establecido en la ley 11/1997, de 24 de abril, de envases y residuos de envases y, el artículo 18.1 del  Real Decreto 782/1998,  de 30 de Abril que desarrolla');
    qrmReponsabilidadEnvase.Lines.Add('la Ley 11/1997; el responsable de la entrega  del residuo de envase o envase usado para su correcta  gestión ambiental de aquellos envases no identificados mediante el Punto Verde');
    if bHayGranada then
      qrmReponsabilidadEnvase.Lines.Add('(sistema integrado de gestión  de Ecoembes), será el poseedor final del mismo".                                                                          ENTIDAD DE CONTROL ES-ECO-020-CV.  GRANADA ECO.')
    else
      qrmReponsabilidadEnvase.Lines.Add('(sistema integrado de gestión  de Ecoembes), será el poseedor final del mismo".                                                                          ');
  end
  else
  begin
    qrmReponsabilidadEnvase.Lines.Clear;
    qrmReponsabilidadEnvase.Lines.Add('"In accordance with which it is established in law 11/1997 dated April 24th about packaging and packaging waste, according to article 18.1 of Royal decree 782/1998 dated April');
    qrmReponsabilidadEnvase.Lines.Add('30th that develops law 11/1997; the responsible for the delivery of packaging and packaging waste used for proper enviroment management  from those packaging non identified by');
    if bHayGranada then
      qrmReponsabilidadEnvase.Lines.Add('the green point (inegrated management system Ecoembes), will be the final holder".                                                        ENTIDAD DE CONTROL ES-ECO-020-CV.  POMEGRANATE ECO.')
    else
      qrmReponsabilidadEnvase.Lines.Add('the green point (inegrated management system Ecoembes), will be the final holder".                                                        ');
  end;

  qrmGarantia.Enabled:= True;
  qrmGarantia.Lines.Clear;
  if not bEnEspanyol then
  begin
    qrmGarantia.Lines.Add( 'Partial or complete rejections should be communicated and quantified no later than 48 hours after the reception of the goods by email or fax.' );
  end
  else
  begin
    qrmGarantia.Lines.Add( 'Las incidencias deben ser comunicadas y cuantificadas  por escrito dentro del plazo de 48 horas posteriores a la descarga de la mercancía.' );
  end;

  if self.rGGN.imprimir_garantia = true then
  begin
    if not bEnEspanyol then
    begin
      qrmGarantia.Lines.Add( self.rGGN.descri_eng+' '+self.rGGN.GGN_Code);
    end
    else
    begin
      qrmGarantia.Lines.Add( self.rGGN.descri_esp+' '+self.rGGN.GGN_Code);
    end;
  end;

  if (CGlobal.gProgramVersion = CGlobal.pvSAT) or (rGGN.imprimir_garantia = true) then
    qrmReponsabilidadEnvase.Top:= 25
  else
    qrmReponsabilidadEnvase.Top:= 15;

  PsQRSysData1.Top:= 58;
  bndPie.Height:= 75;

{
  (*Vuelto a poner a peticion de Esther Cuerda, si alguien vuelve a pedir que se quite que hable con ella*)
  //if gProgramVersion = pvSAT then
  begin
    qrmGarantia.Enabled:= True;
    qrmGarantia.Lines.Clear;
    if not bEnEspanyol then
    begin
      qrmGarantia.Lines.Add( 'Partial or complete rejections should be communicated and quantified no later than 48 hours after the reception of the goods by email or fax.' );
      if CGlobal.gProgramVersion = CGlobal.pvSAT then
//        qrmGarantia.Lines.Add( 'All the fruit and vegatables produts packed by S.A.T. Nº9359 BONNYSA are certified according to GLOBALGAP (EUREPGAP) IFA V5.3 product standards.     GGN=4049928415684');
        qrmGarantia.Lines.Add( 'Certified product GLOBALG.A.P.  GGN: '+self.GGN_Code);
    end
    else
    begin
      qrmGarantia.Lines.Add( 'Las incidencias deben ser comunicadas y cuantificadas  por escrito dentro del plazo de 48 horas posteriores a la descarga de la mercancía.' );
      if CGlobal.gProgramVersion = CGlobal.pvSAT then
//        qrmGarantia.Lines.Add( 'Toda la producción hortofrutícola comercializada por S.A.T. Nº9359 BONNYSA está certificada conforme a la norma GLOBALGAP (EUREPGAP) IFA V5.3.    GGN=4049928415684');
        qrmGarantia.Lines.Add( 'Producto Certificado GLOBALG.A.P.  GGN: '+self.GGN_Code);
    end;

    if CGlobal.gProgramVersion = CGlobal.pvSAT then
        qrmReponsabilidadEnvase.Top:= 25
    else
        qrmReponsabilidadEnvase.Top:= 15;
    PsQRSysData1.Top:= 58;
    bndPie.Height:= 75;
  end;
  (*
  else
  begin
    qrmGarantia.Enabled:= False;
    qrmReponsabilidadEnvase.Top:= 0;
    PsQRSysData1.Top:= 33;
    bndPie.Height:= 50;
  end;
  *)
  }

end;

end.
