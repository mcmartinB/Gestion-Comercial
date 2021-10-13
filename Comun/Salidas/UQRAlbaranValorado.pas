unit UQRAlbaranValorado;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables,
  jpeg, uSalidaUtils;

type
  TQRAlbaranValorado = class(TQuickRep)
    BonnyBand: TQRBand;
    BandaDatos: TQRBand;
    CabeceraTabla: TQRBand;
    marca: TQRDBText;
    categoria_sl: TQRDBText;
    PsQRDBText28: TQRDBText;
    cajas: TQRLabel;
    psKilos: TQRDBText;
    PrecioUnidad: TQRDBText;
    LPor: TQRLabel;
    UnidadCobro: TQRDBText;
    precioNeto: TQRDBText;
    producto: TQRDBText;
    lin1: TQRShape;
    lin2: TQRShape;
    lin3: TQRShape;
    lin4: TQRShape;
    lin5: TQRShape;
    lin6: TQRShape;
    lin7: TQRShape;
    lin8: TQRShape;
    QRBand1: TQRBand;
    QRGroup1: TQRGroup;
    Rneto: TQRShape;
    LPalets: TQRLabel;
    LCajas: TQRLabel;
    Lneto: TQRLabel;
    MemoCajas: TQRMemo;
    MemoPalets: TQRMemo;
    moneda3: TQRLabel;
    ChildBand2: TQRChildBand;
    LObservaciones: TQRLabel;
    cantNeta: TQRExpr;
    mmoObservaciones: TQRMemo;
    ChildBand1: TQRChildBand;
    mmoResumen: TQRMemo;
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
    PsQRLabel12: TQRLabel;
    LTransporte: TQRLabel;
    PsQRShape20: TQRShape;
    PsQRShape23: TQRShape;
    PsQRShape24: TQRShape;
    PsQRShape25: TQRShape;
    PsQRShape26: TQRShape;
    PsQRShape22: TQRShape;
    PsQRShape21: TQRShape;
    PsQRShape27: TQRShape;
    PsQRShape19: TQRShape;
    PsQRShape18: TQRShape;
    PsQRLabel22: TQRLabel;
    PsQRLabel23: TQRLabel;
    PsQRLabel24: TQRLabel;
    PsQRLabel25: TQRLabel;
    PsQRLabel26: TQRLabel;
    PsQRLabel27: TQRLabel;
    PsQRLabel28: TQRLabel;
    PsQRLabel29: TQRLabel;
    PsQRLabel30: TQRLabel;
    PsQRShape29: TQRShape;
    PsQRShape30: TQRShape;
    PsQRShape31: TQRShape;
    PsQRShape32: TQRShape;
    PsQRShape33: TQRShape;
    PsQRShape34: TQRShape;
    PsQRShape35: TQRShape;
    PsQRShape36: TQRShape;
    LTransporteDir1: TQRLabel;
    descripcion2_e: TQRDBText;
    PsQRLabel18: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    qrlNAlbaran: TQRLabel;
    LFecha: TQRLabel;
    LHoraDescarga: TQRLabel;
    LPedido: TQRLabel;
    LVehiculo: TQRLabel;
    PsEmpresa: TQRLabel;
    PsNif: TQRLabel;
    PsDireccion: TQRLabel;
    QRImageCab: TQRImage;
    ChildBand3: TQRChildBand;
    qrmDireccion: TQRMemo;
    bndPaletsMercadona: TQRChildBand;
    mmoPaletsMercadona: TQRMemo;
    qrlLblIva: TQRLabel;
    qrlMonedaIva: TQRLabel;
    qrxIva: TQRExpr;
    qrsIva: TQRShape;
    qrlLblTotal: TQRLabel;
    qrlMonedaTotal: TQRLabel;
    qrxTotal: TQRExpr;
    qrsTotal: TQRShape;
    qrlNAlbaran2: TQRLabel;
    qrimgLogoBargosa: TQRImage;
    qrmGarantia: TQRMemo;
    qrmReponsabilidadEnvase: TQRMemo;
    PsQRLabel1: TQRLabel;
    PsQRShape9: TQRShape;
    psEtiqueta: TQRLabel;
    PsQRLabel2: TQRLabel;
    QRImgFirma: TQRImage;
    PsQRLabel19: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRShape10: TQRShape;
    qrshp1: TQRShape;
    qrlbl1: TQRLabel;
    LDescarga: TQRLabel;
    childDetalle: TQRChildBand;
    qrColor: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    notas_sl: TQRLabel;
    procedure QuickReport1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BandaDatosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRLabel19Print(sender: TObject; var Value: string);
    procedure CabeceraTablaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure LPaletsPrint(sender: TObject; var Value: string);
    procedure LCajasPrint(sender: TObject; var Value: string);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure descripcion2_ePrint(sender: TObject; var Value: string);
    procedure PsQRLabel8Print(sender: TObject; var Value: String);
    procedure psKilosPrint(sender: TObject; var Value: String);
    procedure cajasPrint(sender: TObject; var Value: String);
    procedure PsQRLabel18Print(sender: TObject; var Value: String);
    procedure PsQRLabel27Print(sender: TObject; var Value: String);
    procedure PsQRLabel28Print(sender: TObject; var Value: String);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure UnidadCobroPrint(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure bndPaletsMercadonaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlLblIvaPrint(sender: TObject; var Value: String);
    procedure ChildBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure productoPrint(sender: TObject; var Value: String);
    procedure LHoraDescargaPrint(sender: TObject; var Value: string);
    procedure childDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    bTransito: Boolean;

    rIvaFlag: Real;
    bFlag: Boolean;

    procedure FontLinea( const ATipo: Integer );
  public
    rGGN : TGGN;
    resumenList: TStringList;
    bOriginal: boolean;
    sFirma: string;
    empresa, cliente: string;
    codProveedor: string;
    bEnEspanyol: Boolean;
    bHayGranada: Boolean;

    bMultiproductoInf, bMultiproductoLin: Boolean;



    procedure Configurar(const AEmpresa: string);

    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses UDMAuxDB, CVariables, StrUtils, bTextUtils, bSQLUtils,
     Dialogs, UDMConfig, bMath, UDQAlbaranSalida, CGlobal;

{$R *.DFM}

constructor TQRAlbaranValorado.Create(AOwner: TComponent);
begin
  inherited;

  resumenList := TStringList.Create;
  bOriginal:= True;


end;

destructor TQRAlbaranValorado.Destroy;
begin
  resumenList.Free;

  inherited;
end;



procedure TQRAlbaranValorado.QuickReport1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  bHayGranada:= False;

  bEnEspanyol:= true;
  //Si el albaran es no valorado no imprimir precios
  bTransito := false;
  rIvaFlag:= DataSet.FieldByName('porc_iva_sl').AsFloat;
  bFlag:= true;

  bMultiproductoInf:= False;
  bMultiproductoLin:= False;

end;

procedure TQRAlbaranValorado.BandaDatosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
 if not bHayGranada then
    bHayGranada:= DataSet.FieldByName('producto_sl').AsString = 'W';

  if bFlag and ( DataSet.FieldByName('porc_iva_sl').AsFloat <> rIvaFlag ) then
  begin
    bFlag:= False;
  end;

  bMultiproductoLin:= DataSet.FieldByName('tipo_e').Asinteger > 0;
  bMultiproductoInf:= bMultiproductoInf or bMultiproductoLin;
  FontLinea( DataSet.FieldByName('tipo_e').Asinteger );
end;

procedure TQRAlbaranValorado.Configurar(const AEmpresa: string);
var
  bAux: Boolean;
  sAux: string;
  ssEmpresa: string;
begin
  if Copy( AEmpresa, 1, 1 ) = 'F' then
    ssEmpresa:= 'BAG'
  else
  if ( AEmpresa = '050' ) or ( AEmpresa = '080' ) then
    ssEmpresa:= 'SAT'
  else
  if Empresa  = '510' then
    ssEmpresa:= '505'
  else
    ssEmpresa:= AEmpresa;
  bAux:= FileExists( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
  if bAux then
  begin
    QRImageCab.Top:= -18; //-20
    QRImageCab.Left:= -37; //-20
    QRImageCab.Width:= 763; //-30
    QRImageCab.Height:= 1102; //-20
    QRImageCab.Stretch:= True;
    QRImageCab.Enabled:= True;
    QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
    if ( ( ssEmpresa = '505' ) or ( ssEmpresa = '510' ) ) and FileExists( gsDirActual + '\recursos\LogoBargosa.bmp') then
    begin
      //BARGOSA
      qrimgLogoBargosa.Stretch:= True;
      qrimgLogoBargosa.Enabled:= True;
      qrimgLogoBargosa.Picture.LoadFromFile( gsDirActual + '\recursos\LogoBargosa.bmp');
    end;
  end
  else
  begin
    qrimgLogoBargosa.Enabled:= False;
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

procedure TQRAlbaranValorado.PsQRLabel19Print(sender: TObject;
  var Value: string);
begin
  if codProveedor <> '' then
  begin
    Value := 'COD. PROVEEDOR: ' + codProveedor;
  end
  else
  begin
    Value := '';
  end;
end;

procedure TQRAlbaranValorado.CabeceraTablaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := (MemoPalets.Lines.Count <> 0) or (MemoCajas.Lines.Count <> 0);
end;

procedure TQRAlbaranValorado.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := mmoObservaciones.Lines.Count <> 0;
end;

procedure TQRAlbaranValorado.LPaletsPrint(sender: TObject; var Value: string);
begin
  if MemoPalets.Lines.Count = 0 then Value := '';
end;

procedure TQRAlbaranValorado.LCajasPrint(sender: TObject; var Value: string);
begin
  if MemoCajas.Lines.Count = 0 then Value := '';
end;

procedure TQRAlbaranValorado.LHoraDescargaPrint(sender: TObject;
  var Value: string);
begin
  if cliente = 'LID' then value := '';  
end;

procedure TQRAlbaranValorado.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bMultiproductoInf then
  begin
    PrintBand := false;
  end
  else
  begin
    mmoResumen.Lines.Clear;
    if bOriginal then  begin

      if ( tag = 1 ) or ( ( cliente = 'MER' ) and ( tag = 2 ) )then
      begin
        mmoResumen.Lines.AddStrings(resumenList)
      end
      else
       PrintBand := false;
    end
    else
    begin
      if ( cliente = 'MER' ) and ( tag = 1 ) then
      begin
        mmoResumen.Lines.AddStrings(resumenList)
      end
      else
        PrintBand := false;
    end;
  end;
end;

procedure TQRAlbaranValorado.bndPaletsMercadonaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if bMultiproductoInf then
  begin
    PrintBand := false;
  end
  else
  begin
    if bOriginal then
    begin
      PrintBand:= ( cliente = 'MER' ) and ( tag = 2 );
    end
    else
    begin
      PrintBand:= ( cliente = 'MER' ) and ( tag = 1 );
    end;
  end;
end;

procedure TQRAlbaranValorado.descripcion2_ePrint(sender: TObject;
  var Value: string);

begin
  if bMultiproductoLin then
  begin
    if DataSet.FieldByName('tipo_e').Asinteger = 1 then
      Value := desEnvaseCliente(
        empresa,
        DataSet.FieldByName('producto_p').AsString,
        Value,
        cliente,
        -1)
    else
      Value:= '' ;
  end
  else
  begin
    Value := desEnvaseCliente(
      empresa,
      DataSet.FieldByName('producto_p').AsString,
      Value,
      cliente,
      -1);
  end;
end;

procedure TQRAlbaranValorado.PsQRLabel8Print(sender: TObject;
  var Value: String);
begin
  if cliente = 'MER' then
    Value:= 'Fecha Carga'
  else
    Value:= 'Fecha';
end;

procedure TQRAlbaranValorado.psKilosPrint(sender: TObject;
  var Value: String);
begin
  if cliente = 'MER' then
  begin
    if (DataSet.FieldByName('unidad_precio_sl').AsString = 'UND') then
      value := FormatFloat('#,##0', DataSet.FieldByName('unidades_sl').AsInteger)
    else
      value := FormatFloat('#,##0.00', DataSet.FieldByName('kilos_sl').AsFloat);
  end
  else
  begin
    value := FormatFloat('#,##0.00', DataSet.FieldByName('kilos_sl').AsFloat);
  end;
end;

procedure TQRAlbaranValorado.cajasPrint(sender: TObject; var Value: String);
begin
  //CAJAS O UNIDADES
  if cliente = 'MER' then
  begin
    value := FormatFloat('#,##0', DataSet.FieldByName('cajas_sl').AsInteger);
  end
  else
  begin
    if (DataSet.FieldByName('unidad_precio_sl').AsString = 'UND') then
    begin
      value := FormatFloat('#,##0', DataSet.FieldByName('unidades_sl').AsInteger);
    end
    else
    begin
      value := FormatFloat('#,##0', DataSet.FieldByName('cajas_sl').AsInteger);
    end
  end;
end;

procedure TQRAlbaranValorado.PsQRLabel18Print(sender: TObject;
  var Value: String);
begin
  if cliente = 'MER' then
  begin
    value := '';
  end
  else
  begin
    value:= 'Unidad';
  end;
end;

procedure TQRAlbaranValorado.PsQRLabel27Print(sender: TObject;
  var Value: String);
begin
  if cliente = 'MER' then
  begin
    value := 'Cajas';
  end
  else
  begin
    value := 'Cajas/';
  end;
end;

procedure TQRAlbaranValorado.PsQRLabel28Print(sender: TObject;
  var Value: String);
begin
  if cliente = 'MER' then
  begin
    value := 'Kgs/Uds';
  end
  else
  begin
    //value := 'Kgs/Litros';
    value := 'Kgs';
  end;
end;

procedure TQRAlbaranValorado.QRDBText1Print(sender: TObject; var Value: String);
begin
  if cliente = 'MER' then
  begin
    Value:= Copy( Value, 1, 1 );
  end
  else
  begin
      Value:= 'K';
  end;
end;

procedure TQRAlbaranValorado.UnidadCobroPrint(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 1, 1 );
end;

procedure TQRAlbaranValorado.QRDBText2Print(sender: TObject; var Value: String);
begin
  //CAJAS O UNIDADES
  if cliente = 'MER' then
  begin
    value := '';
  end
  else
  begin
    if (DataSet.FieldByName('unidad_precio_sl').AsString = 'UND') then
    begin
      value := 'U';
    end
    else
    begin
      value := 'C';
    end
  end;
end;

procedure TQRAlbaranValorado.qrlLblIvaPrint(sender: TObject; var Value: String);
begin
  if bFlag then
  begin
    Value:= 'IVA ' + FloatToStr( rIvaFlag ) + '%';
  end
  else
  begin
    Value:= 'IVA ';
  end;
end;

procedure TQRAlbaranValorado.ChildBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bEnEspanyol then
  begin
    qrmReponsabilidadEnvase.Lines.Clear;
    qrmReponsabilidadEnvase.Lines.Add('"De conformidad con lo establecido en la ley 11/1997, de 24 de abril, de envases y residuos de envases y, el artículo 18.1 del  Real Decreto 782/1998,  de 30 de Abril que desarrolla');
    qrmReponsabilidadEnvase.Lines.Add('la Ley 11/1997; el responsable de la entrega  del residuo de envase o envase usado para su correcta  gestión ambiental de aquellos envases no identificados mediante el Punto Verde');
    if bHayGranada then
      qrmReponsabilidadEnvase.Lines.Add('(sistema integrado de gestión  de Ecoembes), será el poseedor final del mismo".                                                                          ENTIDAD DE CONTROL ES-ECO-020-CV.  GRANADA ECO.')
    else
      qrmReponsabilidadEnvase.Lines.Add('(sistema integrado de gestión  de Ecoembes), será el poseedor final del mismo".                                                                          ')
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

    if rGGN.imprimir_garantia = true then
    begin
        if bEnEspanyol = true then  qrmGarantia.Lines.Add(rggn.descri_esp+rGGN.ggn_code)
        else  qrmGarantia.Lines.Add(rggn.descri_eng+rGGN.ggn_code);
    end;

    if (CGlobal.gProgramVersion = CGlobal.pvSAT) or (empresa = 'F22') or (rGGN.imprimir_garantia = true) then
      qrmReponsabilidadEnvase.Top:= 25
    else
      qrmReponsabilidadEnvase.Top:= 15;

    PsQRLabel1.Top:= 62;
    PsQRLabel2.Top:= 62;
    psEtiqueta.Top:= 114;
    PsQRLabel19.Top:= 114;
    PsQRSysData1.Top:= 114;
    PsQRShape9.Top:= 61;
    PsQRShape10.Top:= 61;
    QRImgFirma.Top:= 63;
    ChildBand3.Height:= 130;
  (*
  else
  begin
    qrmGarantia.Enabled:= False;
    qrmReponsabilidadEnvase.Top:= 0;
    PsQRLabel1.Top:= 37;
    PsQRLabel2.Top:= 37;
    psEtiqueta.Top:= 89;
    PsQRLabel19.Top:= 89;
    PsQRSysData1.Top:= 89;
    PsQRShape9.Top:= 36;
    PsQRShape10.Top:= 36;
    QRImgFirma.Top:= 38;
    ChildBand3.Height:= 105;
  end;
  *)

  if bOriginal then
  begin
    case Tag of
      0: psEtiqueta.Caption := '';
      1: psEtiqueta.Caption := 'ORIGINAL EMPRESA';
      2: psEtiqueta.Caption := 'ORIGINAL CLIENTE';
      3: psEtiqueta.Caption := 'COPIA 1/1ST COPY';
      4: psEtiqueta.Caption := 'COPIA 2/2ND COPY';
      5: psEtiqueta.Caption := 'COPIA 3/1RD COPY';
      else psEtiqueta.Caption := 'COPIA ' + IntToStr(Tag - 2) + '/' + IntToStr(Tag - 2) + 'TH COPY';
    end;
  end
  else
  begin
    case Tag of
      0: psEtiqueta.Caption := '';
      1: psEtiqueta.Caption := 'ORIGINAL CLIENTE';
      2: psEtiqueta.Caption := 'COPIA 1/1ST COPY';
      3: psEtiqueta.Caption := 'COPIA 2/2ND COPY';
      4: psEtiqueta.Caption := 'COPIA 3/1RD COPY';
      else psEtiqueta.Caption := 'COPIA ' + IntToStr(Tag - 1) + '/' + IntToStr(Tag - 1) + 'TH COPY';
    end;
  end;


  //Carga firma si la tiene
  try
    If FileExists( sFirma ) then
    begin
      QRImgFirma.Enabled:= True;
      QRImgFirma.Stretch:= True;
      QRImgFirma.Picture.LoadFromFile( sFirma );
    end;
  except
    ShowMessage('Fichero de firma incorrecto: ' + sFirma );
  end;
end;

procedure TQRAlbaranValorado.childDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if (DataSet.FieldByName('producto_sl').AsString = 'PLA') or
     (DataSet.FieldByName('notas_sl').AsString <> '') then
      PrintBand := true
  else
      PrintBand := false;

  qrColor.Enabled := false;
  notas_sl.Enabled := false;
  if DataSet.FieldByName('producto_sl').AsString = 'PLA' then
  begin
      qrColor.Enabled := true;
      qrColor.Caption := ' ' + desColor('F17', DataSet.FieldByName('producto_sl').AsString, DataSet.FieldByName('color_sl').AsString);
  end;
  if (DataSet.FieldByName('notas_sl').AsString <> '') then
  begin
      notas_sl.Enabled := true;
      notas_sl.Caption := DataSet.FieldByName('notas_sl').AsString;
  end;
end;

procedure TQRAlbaranValorado.productoPrint(sender: TObject;
  var Value: String);
begin


  
  if bMultiproductoLin then
  begin
    if DataSet.FieldByName('tipo_e').Asinteger = 1 then
      Value:= Value + ' ' + DataSet.FieldByName('envase_sl').AsString + ''
    else
      Value:= ' *  ' + DataSet.FieldByName('envase_sl').AsString + ' - ' + Value ;
  end;

  value := ArreglaProductoGGN(rggn, empresa, dataset.FieldByName('producto_sl').AsString, value);

end;

procedure TQRAlbaranValorado.FontLinea( const ATipo: Integer );
begin
  case ATipo of
    0:
    begin
      //Normal
      producto.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      descripcion2_e.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      marca.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      categoria_sl.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      PsQRDBText28.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      cajas.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      QRDBText2.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      psKilos.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      QRDBText1.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      PrecioUnidad.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      LPor.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      UnidadCobro.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];
      precioNeto.Font.Style:= producto.Font.Style - [fsItalic] - [fsBold];

      descripcion2_e.Enabled:= True;
      PrecioUnidad.Enabled:= True;
      UnidadCobro.Enabled:= True;
      precioNeto.Enabled:= True;
      LPor.Enabled:= True;
      marca.Enabled:= True;
      categoria_sl.Enabled:= True;
      PsQRDBText28.Enabled:= True;

      producto.Font.Size:= 8;
      descripcion2_e.Font.Size:= 8;
      marca.Font.Size:= 8;
      categoria_sl.Font.Size:= 8;
      PsQRDBText28.Font.Size:= 8;
      cajas.Font.Size:= 8;
      psKilos.Font.Size:= 8;
      PrecioUnidad.Font.Size:= 8;
      precioNeto.Font.Size:= 8;
    end;
    1:
    begin
      //cabecera
      producto.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      descripcion2_e.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      marca.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      categoria_sl.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      PsQRDBText28.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      cajas.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      QRDBText2.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      psKilos.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      QRDBText1.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      PrecioUnidad.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      LPor.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      UnidadCobro.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];
      precioNeto.Font.Style:= producto.Font.Style - [fsItalic] + [fsBold];

      descripcion2_e.Enabled:= True;
      PrecioUnidad.Enabled:= True;
      UnidadCobro.Enabled:= True;
      precioNeto.Enabled:= True;
      LPor.Enabled:= True;
      marca.Enabled:= False;
      categoria_sl.Enabled:= False;
      PsQRDBText28.Enabled:= False;

      producto.Font.Size:= 8;
      descripcion2_e.Font.Size:= 8;
      marca.Font.Size:= 8;
      categoria_sl.Font.Size:= 8;
      PsQRDBText28.Font.Size:= 8;
      cajas.Font.Size:= 8;
      psKilos.Font.Size:= 8;
      PrecioUnidad.Font.Size:= 8;
      precioNeto.Font.Size:= 8;
    end;
    2:
    begin
      //Normal
      producto.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      descripcion2_e.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      marca.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      categoria_sl.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      PsQRDBText28.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      cajas.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      QRDBText2.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      psKilos.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      QRDBText1.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      PrecioUnidad.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      LPor.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      UnidadCobro.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];
      precioNeto.Font.Style:= producto.Font.Style + [fsItalic] - [fsBold];

      descripcion2_e.Enabled:= False;
      PrecioUnidad.Enabled:= False;
      UnidadCobro.Enabled:= False;
      precioNeto.Enabled:= False;
      LPor.Enabled:= False;
      marca.Enabled:= True;
      categoria_sl.Enabled:= True;
      PsQRDBText28.Enabled:= True;

      producto.Font.Size:= 7;
      descripcion2_e.Font.Size:= 7;
      marca.Font.Size:= 7;
      categoria_sl.Font.Size:= 7;
      PsQRDBText28.Font.Size:= 7;
      cajas.Font.Size:= 7;
      psKilos.Font.Size:= 7;
      PrecioUnidad.Font.Size:= 7;
      precioNeto.Font.Size:= 7;
    end;
  end;
end;

end.
