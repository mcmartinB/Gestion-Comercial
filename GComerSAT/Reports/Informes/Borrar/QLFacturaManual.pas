
unit QLFacturaManual;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, jpeg;

type
  TQRLFacturaManual = class(TQuickRep)
    BandaTotales: TQRBand;
    Rtotal: TQRShape;
    Riva: TQRShape;
    Rneto: TQRShape;
    CabeceraFactura2: TQRChildBand;
    PsQRShape21: TQRShape;
    pais: TQRDBText;
    provincia: TQRDBText;
    codPostal: TQRDBText;
    PsQRDBText14: TQRDBText;
    Domicilio: TQRDBText;
    via: TQRDBText;
    PsQRDBText17: TQRDBText;
    Nif: TQRLabel;
    CabeceraLinea: TQRChildBand;
    ChildBand3: TQRChildBand;
    con: TQRLabel;
    PsQRShape42: TQRShape;
    PsQRShape43: TQRShape;
    REuro: TQRShape;
    MEuro: TQRLabel;
    BDFactura2: TQRDBText;
    PsQRDBText18: TQRDBText;
    PsQRShape14: TQRShape;
    PsQRLabel16: TQRLabel;
    PsQRLabel26: TQRLabel;
    PsQRShape15: TQRShape;
    PsQRShape24: TQRShape;
    PsQRShape25: TQRShape;
    PsQRShape26: TQRShape;
    PsQRShape27: TQRShape;
    PsQRShape28: TQRShape;
    PsQRLabel32: TQRLabel;
    PsQRShape30: TQRShape;
    PsQRLabel33: TQRLabel;
    PsQRLabel34: TQRLabel;
    PsQRLabel35: TQRLabel;
    con2: TQRLabel;
    Lneto: TQRLabel;
    LIva: TQRLabel;
    Ltotal: TQRLabel;
    LEuro: TQRLabel;
    LMon2: TQRLabel;
    etqNet: TQRLabel;
    Liva2: TQRLabel;
    LTotal2: TQRLabel;
    LMon1: TQRLabel;
    lFormaPago: TQRLabel;
    rlin: TQRShape;
    PsQRLabel36: TQRLabel;
    PiePagina: TQRBand;
    ChildBand1: TQRChildBand;
    PsQRDBRichText1: TQRDBRichText;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    cantIva: TQRDBText;
    CantTotal: TQRDBText;
    cantEuro: TQRDBText;
    desImpuestos: TQRDBText;
    LMon3: TQRLabel;
    PsQRSysData1: TQRSysData;
    psEtiqueta: TQRLabel;
    etqIvaAleman: TQRLabel;
    BonnyBand: TQRBand;
    QRImageCab: TQRImage;
    PsEmpresa: TQRLabel;
    PsDireccion: TQRLabel;
    PsNif: TQRLabel;
    QRMemoPago: TQRMemo;
    ChildBand2: TQRChildBand;
    qrlAseguradora: TQRLabel;
    qrmReponsabilidadEnvase: TQRMemo;
    qrmGarantia: TQRMemo;
    procedure lFormaPagoPrint(sender: TObject; var Value: string);
    procedure CabeceraFactura2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PiePaginaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure PsQRLabel33Print(sender: TObject; var Value: string);
    procedure PsQRLabel36Print(sender: TObject; var Value: string);
    procedure PsQRLabel34Print(sender: TObject; var Value: string);
    procedure PsQRLabel35Print(sender: TObject; var Value: string);
    procedure BandaTotalesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLFacturaManualStartPage(Sender: TCustomQuickRep);
    procedure LnetoPrint(sender: TObject; var Value: string);
    procedure PsQRSysData1Print(sender: TObject; var Value: string);
    procedure con2Print(sender: TObject; var Value: string);
    procedure BDFactura2Print(sender: TObject; var Value: String);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);

  private
    paraAlemania: boolean;
    sEmpresa: string;
    bHayGranada: Boolean;

    procedure CuadroFormaPago;

  public
    procedure Configurar(const AEmpresa: string);

  end;

var
  QRLFacturaManual: TQRLFacturaManual;

implementation

uses UDMAuxDB, CVariables, UDMBaseDatos, UDMFacturacion, CGLobal;

{$R *.DFM}


procedure TQRLFacturaManual.Configurar(const AEmpresa: string);
var
  bAux: Boolean;
  sAux, ssEmpresa: string;
begin
  sEmpresa:= AEmpresa;
      if ( AEmpresa = '050' ) or ( AEmpresa = '050' ) then
      ssEmpresa:= '080'
    else
      ssEmpresa:= AEmpresa;
  bAux:= FileExists( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
  if bAux then
  begin
    QRImageCab.Top:= -18; //-20
    QRImageCab.Left:= -37; //-20
    QRImageCab.Width:= 763; //-30
    QRImageCab.Height:= 1102; //-20
    QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
    QRImageCab.Stretch:= True;
    QRImageCab.Enabled:= True;
  end
  else
  begin
    QRImageCab.Enabled:= False;
    ConsultaOpen(DMAuxDB.QAux,
      ' select nombre_e,nif_e,tipo_via_e,domicilio_e,cod_postal_e, ' +
      '        poblacion_e,nombre_p ' +
      ' from frf_empresas,frf_provincias ' +
      ' where empresa_e=' + QuotedStr(Trim(AEmpresa)) +
      '   and cod_postal_e[1,2]=codigo_p');

    with DMAuxDB.QAux do
    begin
      PsEmpresa.Caption := FieldByName('nombre_e').AsString;
      PsNif.Caption := 'NIF: ' + FieldByName('nif_e').AsString;

      sAux := '';
      if Trim(FieldByName('tipo_via_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('tipo_via_e').AsString) + '. ';
      if Trim(FieldByName('domicilio_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('domicilio_e').AsString) + '      ';
      if Trim(FieldByName('cod_postal_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('cod_postal_e').AsString) + '  ';
      if Trim(FieldByName('poblacion_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('poblacion_e').AsString) + '      ';
      if Trim(FieldByName('cod_postal_e').AsString) <> '' then
       sAux := sAux + '(' + Trim(FieldByName('nombre_p').AsString) + ')  ';

      PsDireccion.Caption := sAux;

      Close;
    end;
  end;

  PsDireccion.Enabled:= not bAux;
  PsEmpresa.Enabled:= not bAux;
  PsNif.Enabled:= not bAux;
end;

procedure TQRLFacturaManual.QRLFacturaManualStartPage(
  Sender: TCustomQuickRep);
begin
  paraAlemania := DMBaseDatos.QListado.FieldByName('pais').AsString = 'ALEMANIA';
end;


procedure TQRLFacturaManual.lFormaPagoPrint(sender: TObject;
  var Value: string);
begin
  if Trim(DMBaseDatos.QListado.FieldByName('pais').AsString) = 'ESPAÑA' then
    value := ' Pago  :'
  else if paraAlemania then
    value := 'Zahlung:'
  else
    value := 'Payment:';
end;

function CompletaNif( const APais, ANif: string ): string;
begin
  if Pos( APais, ANif ) = 0 then
    Result:= APais + ANif
  else
    Result:= ANif;
end;



procedure TQRLFacturaManual.CabeceraFactura2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Trim(DMBaseDatos.QListado.FieldByName('via').AsString) = '' then
  begin
    Domicilio.Left := 373;
    via.Enabled := false;
  end
  else
  begin
    Domicilio.Left := 401;
    via.Enabled := true;
  end;

  if Trim(DMBaseDatos.QListado.FieldByName('pais').AsString) = 'ESPAÑA' then
  begin
    Nif.Caption := 'C.I.F. : ' + DMBaseDatos.QListado.FieldByName('nif').AsString;
    if Trim(DMBaseDatos.QListado.FieldByName('codPostal').AsString) = '' then
    begin
      codPostal.Enabled := false;
      provincia.Enabled := false;
      pais.top := 86;
      nif.Top := 105;
    end
    else
    begin
      codPostal.Enabled := true;
      provincia.Enabled := true;
      pais.top := 105;
      nif.Top := 124;
    end;
  end
  else
  begin
    Nif.Caption := 'V.A.T. : ' +  CompletaNif( DMBaseDatos.QListado.FieldByName('codPais').AsString, DMBaseDatos.QListado.FieldByName('nif').AsString );
    provincia.Enabled := false;
    if Trim(DMBaseDatos.QListado.FieldByName('codPostal').AsString) = '' then
    begin
      codPostal.Enabled := false;
      pais.top := 86;
      pais.Left := 373;
      nif.Top := 105;
    end
    else
    begin
      codPostal.Enabled := true;
      pais.top := 86;
      pais.Left := 431;
      nif.Top := 105;
    end;
  end;
end;

procedure TQRLFacturaManual.PiePaginaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  (*
  if sEmpresa = '050' then
  begin
    psEtiqueta.Left:= 32;
  end
  else
  begin
    psEtiqueta.Left:= 12;
  end;
  *)

  case Tag of
    0: psEtiqueta.Caption := '';
    1: psEtiqueta.Caption := 'ORIGINAL';
    2: psEtiqueta.Caption := 'ORIGINAL EMPRESA';
    3: psEtiqueta.Caption := 'COPIA 1/1ST COPY';
    4: psEtiqueta.Caption := 'COPIA 2/2ND COPY';
    5: psEtiqueta.Caption := 'COPIA 3/1RD COPY';
  else psEtiqueta.Caption := 'COPIA ' + IntToStr(Tag - 2) + '/' + IntToStr(Tag - 2) + 'TH COPY';
  end;

  if Trim(DMBaseDatos.QListado.FieldByName('pais').AsString) = 'ESPAÑA' then
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

  if gProgramVersion = pvSAT then
  begin
    qrmGarantia.Enabled:= True;
    qrmGarantia.Lines.Clear;
    if not ( Trim(DMBaseDatos.QListado.FieldByName('pais').AsString) = 'ESPAÑA' ) then
    begin
      qrmGarantia.Lines.Add( 'Partial or complete rejections should be communicated and quantified no later than 48 hours after the reception of the goods by email or fax.' );
      qrmGarantia.Lines.Add( 'All the fruit and vegatables produts packed by S.A.T. Nº9359 BONNYSA are certified according to GLOBALGAP (EUREPGAP) IFA V4.1 product standards.     GGN=4049928415684');
    end
    else
    begin
      qrmGarantia.Lines.Add( 'Las incidencias deben ser comunicadas y cuantificadas  por escrito dentro del plazo de 48 horas posteriores a la descarga de la mercancía.' );
      qrmGarantia.Lines.Add( 'Toda la producción hortofrutícola comercializada por S.A.T. Nº9359 BONNYSA está certificada conforme a la norma GLOBALGAP (EUREPGAP) IFA V4.1.    GGN=4049928415684');
    end;

    qrmReponsabilidadEnvase.Top:= 25;
    psEtiqueta.Top:= 63;
    PsQRSysData1.Top:= 63;
    PiePagina.Height:= 80;
  end
  else
  begin
    qrmGarantia.Enabled:= False;
    qrmReponsabilidadEnvase.Top:= 0;
    psEtiqueta.Top:= 38;
    PsQRSysData1.Top:= 38;
    PiePagina.Height:= 55;
  end;
end;

procedure TQRLFacturaManual.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
    Value := FormatFloat('#,##0.00', StrToFloat(Value));
end;

procedure TQRLFacturaManual.PsQRLabel33Print(sender: TObject;
  var Value: string);
begin
  if paraAlemania then Value := 'Rechnung Nr.';
end;

procedure TQRLFacturaManual.PsQRLabel36Print(sender: TObject;
  var Value: string);
begin
  if paraAlemania then Value := '';
end;

procedure TQRLFacturaManual.PsQRLabel34Print(sender: TObject;
  var Value: string);
begin
  if paraAlemania then Value := 'Datum';
end;

procedure TQRLFacturaManual.PsQRLabel35Print(sender: TObject;
  var Value: string);
begin
  if paraAlemania then Value := 'Kunden Nr.';
end;


procedure TQRLFacturaManual.CuadroFormaPago;
var
  iDif, iAltura: integer;
begin
  if QRMemoPago.Lines.Count = 0 then
  begin
    with DMBaseDatos.QListado do
    begin
      QRMemoPago.Lines.Clear;
      if Trim( FieldByName('des').AsString) = '' then
      begin
        Rlin.Enabled := false;
        lFormaPago.Enabled := false;
      end
      else
      begin
        lFormaPago.Enabled := True;
        Rlin.Enabled := True;

        QRMemoPago.Lines.Add( FieldByName('des').AsString );
        if Trim(FieldByName('des2').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('des2').AsString );
        if Trim(FieldByName('des3').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('des3').AsString );
        if Trim(FieldByName('des4').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('des4').AsString );
        if Trim(FieldByName('des5').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('des5').AsString );
        if Trim(FieldByName('des6').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('des6').AsString );
        if Trim(FieldByName('des7').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('des7').AsString );
        if Trim(FieldByName('des8').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('des8').AsString );
        if Trim(FieldByName('des9').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('des9').AsString );

        iAltura:= 15 + ((  QRMemoPago.Lines.Count - 1 ) * 14 );
        QRMemoPago.Height:= iAltura;
        iAltura:= iAltura + 10;
        if rLin.Height < iAltura then
        begin
          iDif:= iAltura - rLin.Height;
          rLin.Height:= rLin.Height + iDif;
          BandaTotales.Height:= BandaTotales.Height + iDif;
        end;
      end;
    end;
  end;
end;

procedure TQRLFacturaManual.BandaTotalesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  CuadroFormaPago;
  
  if paraAlemania then
  begin
    Rtotal.Enabled := false;
    REuro.Enabled := false;
    Rtotal.Visible := false;
    REuro.Visible := false;

    etqNet.Enabled := false;
    etqNet.Visible := false;
    Ltotal.Enabled := false;
    Ltotal.Visible := false;
    LTotal2.Enabled := false;
    LTotal2.Visible := false;
    CantTotal.Enabled := false;
    CantTotal.Visible := false;
    LMon3.Enabled := false;
    LMon3.Visible := false;

    LEuro.Enabled := false;
    LEuro.Visible := false;
    MEuro.Enabled := false;
    MEuro.Visible := false;
    CantEuro.Enabled := false;
    CantEuro.Visible := false;

    LMon2.Caption := 'EUR';

    etqIvaAleman.Visible := true;
    etqIvaAleman.Enabled := true;
  end;
end;



procedure TQRLFacturaManual.LnetoPrint(sender: TObject; var Value: string);
begin
  if paraAlemania then
  begin
    Value := 'Total / Gesamtbetrag';
    TQRLabel(Sender).Font.Style := TQRLabel(Sender).Font.Style + [fsBold];
  end;
end;

procedure TQRLFacturaManual.PsQRSysData1Print(sender: TObject;
  var Value: string);
begin
  if paraAlemania then
    Value := 'Hoja/Blatt: ' + Value
  else
    Value := 'Hoja/Page: ' + Value;
end;

procedure TQRLFacturaManual.con2Print(sender: TObject; var Value: string);
begin
  if paraAlemania then
    Value := 'Rechnung';
    //Cambiado por Vanessa el 4/11/2008
    //Value := 'Abzug';

end;

procedure TQRLFacturaManual.BDFactura2Print(sender: TObject;
  var Value: String);
begin
  Value:= NewCodigoFactura( DataSet.FieldByName('empresa').AsString,
                      DataSet.FieldByName('tipo_factura').AsString,
                      DataSet.FieldByName('tipo_impuesto').AsString,
                      DataSet.FieldByName('fecha').AsDateTime,
                      DataSet.FieldByName('factura').AsInteger );
end;

procedure TQRLFacturaManual.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= ( DataSet.FieldByName('tipo_factura').AsString = '380' ) and
              EsClienteSeguro( sEmpresa, DataSet.FieldByName('cliente').AsString );
  if PrintBand then
  begin

     if DMBaseDatos.QListado.FieldByName('fecha').AsDateTime < StrToDate('1/3/2012') then
     begin
       if DMBaseDatos.QListado.FieldByName('pais').AsString = 'ESPAÑA' then
         qrlAseguradora.Caption:= 'Operación asegurada en Mapfre.'
       else
         qrlAseguradora.Caption:= 'Mapfre insured operation.';
     end
     else
     begin
       if DMBaseDatos.QListado.FieldByName('pais').AsString = 'ESPAÑA' then
         qrlAseguradora.Caption:= 'Operación asegurada en COFACE'
       else
         qrlAseguradora.Caption:= 'COFACE insured operation.';
     end;
   end;
end;

procedure TQRLFacturaManual.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  bHayGranada:= False;
end;

end.
