unit UQRAlbaranInglesVal;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables,
  jpeg, usalidautils;

type
  TQRAlbaranInglesVal = class(TQuickRep)
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
    qryAlbaranLin: TQuery;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    QRLabel3: TQRLabel;
    qrlbl4: TQRLabel;
    QRLabel4: TQRLabel;
    qrlbl5: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
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
  private
    bTransito: Boolean;

    rIvaFlag: Real;
    bFlag: Boolean;


    procedure FontLinea( const ATipo: Integer );

  public
    resumenList: TStringList;
    bOriginal: boolean;
    sFirma: string;
    sempresa, cliente, scentro, sFecha: string;
    iAlbaran: integer;
    codProveedor: string;
    bEnEspanyol: Boolean;
    bHayGranada: Boolean;
    rGGN : TGGN;

    bMultiproductoInf, bMultiproductoLin: Boolean;

    procedure Configurar(const AEmpresa: string);
    procedure LineasAlbaran;

    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
  end;
var
  QRAlbaranInglesVal: TQRAlbaranInglesVal;

  function PreAlbaranIngles( const AEmpresa, ACentro, ACliente: String; const AAlbaran: Integer;
                             const AFecha: TDateTime; const APedirFirma, AOriginal: boolean; const APrevisualizar: boolean = True ): boolean;

implementation

uses UDMAuxDB, CVariables, StrUtils, bTextUtils, bSQLUtils,
     Dialogs, UDMConfig, bMath, UDQAlbaranSalida, CGlobal, UCAlbaran, SignatureForm,
     UDMBaseDatos, dPreview;

{$R *.DFM}

constructor TQRAlbaranInglesVal.Create(AOwner: TComponent);
begin
  inherited;

  resumenList := TStringList.Create;
  bOriginal:= True;
end;

destructor TQRAlbaranInglesVal.Destroy;
begin
  resumenList.Free;

  inherited;
end;



procedure TQRAlbaranInglesVal.QuickReport1BeforePrint(Sender: TCustomQuickRep;
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

procedure TQRAlbaranInglesVal.BandaDatosBeforePrint(Sender: TQRCustomBand;
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

procedure TQRAlbaranInglesVal.Configurar(const AEmpresa: string);
var
  bAux: Boolean;
  sAux: string;
  ssEmpresa: string;
begin
  if Copy( AEmpresa, 1, 1 ) = 'F' then
    ssEmpresa:= 'BAG'
  else
  if ( AEmpresa = '050' ) or ( AEmpresa = '080' ) then
    ssEmpresa:= '080'
  else
  if sEmpresa  = '510' then
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

procedure TQRAlbaranInglesVal.PsQRLabel19Print(sender: TObject;
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

procedure TQRAlbaranInglesVal.CabeceraTablaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := (MemoPalets.Lines.Count <> 0) or (MemoCajas.Lines.Count <> 0);
end;

procedure TQRAlbaranInglesVal.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := mmoObservaciones.Lines.Count <> 0;
end;

procedure TQRAlbaranInglesVal.LPaletsPrint(sender: TObject; var Value: string);
begin
  if MemoPalets.Lines.Count = 0 then Value := '';
end;

procedure TQRAlbaranInglesVal.LCajasPrint(sender: TObject; var Value: string);
begin
  if MemoCajas.Lines.Count = 0 then Value := '';
end;

procedure TQRAlbaranInglesVal.LineasAlbaran;
begin
  //Buscar cuerpo del formulario
  with qryAlbaranLin do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;

      Add(' SELECT ');
      Add('     estomate_p,producto_sl, producto_p,descripcion_p,descripcion2_p, envase_sl, ');
      Add('     tipo_e, descripcion_m, categoria_sl, calibre_sl, ');
      Add('     unidad_precio_sl, ');
      Add('     case when tipo_e = 2 then 0 else precio_sl end  as precio_sl, ');
      Add('     porc_iva_sl, ');

      Add('     descripcion_tp, notas_sl,');
      Add('     SUM(n_palets_sl) as palets_sl, ');
      Add('     SUM(n_palets_sl * kilos_tp) peso_palets, ');

      Add('     SUM(cajas_sl) as cajas_sl, ');
      Add('     SUM(cajas_sl*peso_envase_e) as peso_cajas, ');
      Add('     SUM(kilos_sl) as kilos_sl, ');

      Add('     unidades_caja_sl, ');
      Add('     SUM((cajas_sl*unidades_caja_sl)) as unidades_sl, ');

      Add('     SUM( case when tipo_e = 2 then 0 else importe_neto_sl end ) as importe_neto_sl, ');
      Add('     SUM( case when tipo_e = 2 then 0 else iva_sl end ) as iva_sl, ');
      Add('     SUM( case when tipo_e = 2 then 0 else importe_total_sl end ) as importe_total_sl ');

      Add('  FROM frf_salidas_l ');
      Add('       join frf_productos on (producto_p = producto_sl) ');
      Add('       join frf_envases  on envase_e = envase_sl -- and producto_e = producto_p ');
      Add('       join frf_marcas on  codigo_m = marca_sl ');
      Add('       left join frf_tipo_palets on codigo_tp = tipo_palets_sl ');
      Add(' WHERE   (empresa_sl = :empresa) ');
      Add('    AND  (centro_salida_sl = :centro) ');
      Add('    AND  (n_albaran_sl = :albaran) ');
      Add('    AND  (fecha_sl = :fecha) ');
      Add('  GROUP BY estomate_p, producto_sl, producto_p, descripcion_p, descripcion2_p, descripcion_tp, ');
      Add('           envase_sl, tipo_e, descripcion_m, categoria_sl, calibre_sl, ');
      Add('           unidad_precio_sl, precio_sl, porc_iva_sl, unidades_caja_sl, kilos_tp, notas_sl ');
      Add('  ORDER BY estomate_p, producto_sl, envase_sl, categoria_sl, ');
      Add('  calibre_sl, unidades_caja_sl, precio_sl, unidad_precio_sl ');

    end;
    ParamByName('empresa').AsString := sempresa;
    ParamByName('centro').AsString := scentro;
    ParamByName('albaran').AsInteger := ialbaran;
    ParamByName('fecha').AsString := sFecha;
    try
      Open;
    except
      qryAlbaranLin.Cancel;
      qryAlbaranLin.Close;
      MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
      raise;
    end;
  end;
end;

procedure TQRAlbaranInglesVal.ChildBand1BeforePrint(Sender: TQRCustomBand;
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

procedure TQRAlbaranInglesVal.bndPaletsMercadonaBeforePrint(
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

procedure TQRAlbaranInglesVal.descripcion2_ePrint(sender: TObject;
  var Value: string);

begin
  if bMultiproductoLin then
  begin
    if DataSet.FieldByName('tipo_e').Asinteger = 1 then
      Value := desEnvaseCliente(
        sempresa,
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
      sempresa,
      DataSet.FieldByName('producto_p').AsString,
      Value,
      cliente,
      -1);
  end;
end;

procedure TQRAlbaranInglesVal.PsQRLabel8Print(sender: TObject;
  var Value: String);
begin
  if cliente = 'MER' then
    Value:= 'Fecha Carga'
  else
    Value:= 'Fecha';
end;

procedure TQRAlbaranInglesVal.psKilosPrint(sender: TObject;
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

procedure TQRAlbaranInglesVal.cajasPrint(sender: TObject; var Value: String);
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

procedure TQRAlbaranInglesVal.PsQRLabel18Print(sender: TObject;
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

procedure TQRAlbaranInglesVal.PsQRLabel27Print(sender: TObject;
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

procedure TQRAlbaranInglesVal.PsQRLabel28Print(sender: TObject;
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

procedure TQRAlbaranInglesVal.QRDBText1Print(sender: TObject; var Value: String);
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

procedure TQRAlbaranInglesVal.UnidadCobroPrint(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 1, 1 );
end;

procedure TQRAlbaranInglesVal.QRDBText2Print(sender: TObject; var Value: String);
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

procedure TQRAlbaranInglesVal.qrlLblIvaPrint(sender: TObject; var Value: String);
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

procedure TQRAlbaranInglesVal.ChildBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bEnEspanyol then
  begin
    qrmReponsabilidadEnvase.Lines.Clear;
    qrmReponsabilidadEnvase.Lines.Add('"De conformidad con lo establecido en la ley 11/1997, de 24 de abril, de envases y residuos de envases y, el art?culo 18.1 del  Real Decreto 782/1998,  de 30 de Abril que desarrolla');
    qrmReponsabilidadEnvase.Lines.Add('la Ley 11/1997; el responsable de la entrega  del residuo de envase o envase usado para su correcta  gesti?n ambiental de aquellos envases no identificados mediante el Punto Verde');
    if bHayGranada then
      qrmReponsabilidadEnvase.Lines.Add('(sistema integrado de gesti?n  de Ecoembes), ser? el poseedor final del mismo".                                                                          ENTIDAD DE CONTROL ES-ECO-020-CV.  GRANADA ECO.')
    else
      qrmReponsabilidadEnvase.Lines.Add('(sistema integrado de gesti?n  de Ecoembes), ser? el poseedor final del mismo".                                                                          ')
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

  (*Vuelto a poner a peticion de Esther Cuerda, si alguien vuelve a pedir que se quite que hable con ella*)
  //if gProgramVersion = pvSAT then
  begin
    qrmGarantia.Enabled:= True;
    qrmGarantia.Lines.Clear;
    if not bEnEspanyol then
    begin
      qrmGarantia.Lines.Add( 'Partial or complete rejections should be communicated and quantified no later than 48 hours after the reception of the goods by email or fax.' );
    end
    else
    begin
      qrmGarantia.Lines.Add( 'Las incidencias deben ser comunicadas y cuantificadas  por escrito dentro del plazo de 48 horas posteriores a la descarga de la mercanc?a.' );
    end;

    if rGGN.imprimir_garantia = true then
    begin
      if bEnEspanyol = true then  qrmGarantia.Lines.Add(rggn.descri_esp + rggn.ggn_code)
      else qrmGarantia.Lines.Add(rggn.descri_eng + rggn.ggn_code);
    end;


    if (CGlobal.gProgramVersion = CGlobal.pvSAT) or (rGGN.imprimir_garantia = true) then
      qrmReponsabilidadEnvase.Top:= 25
    else
      qrmReponsabilidadEnvase.Top:= 15;

//    if rGGN.imprimir_garantia = true then
//    begin
//      if bEnEspanyol = true then
//        qrmGarantia.Lines.Add(trim(rGGN.arterisco+ 'Toda la producci?n hortofrut?cola comercializada por S.A.T. N?9359 BONNYSA est? certificada conforme a la norma GLOBALGAP IFA V5.3.    GGN='+rGGN.ggn_code))
//      else
//        qrmGarantia.Lines.Add(trim(rGGN.arterisco+ 'All the fruit and vegatables produts packed by S.A.T. N?9359 BONNYSA are certified according to GLOBALGAP IFA V5.3 product standards.     GGN='+rGGN.ggn_code));
//      end;
    end;
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

procedure TQRAlbaranInglesVal.productoPrint(sender: TObject;
  var Value: String);
begin
  if bMultiproductoLin then
  begin
    if DataSet.FieldByName('tipo_e').Asinteger = 1 then
      Value:= Value + ' ' + DataSet.FieldByName('envase_sl').AsString + ''
    else
      Value:= ' *  ' + DataSet.FieldByName('envase_sl').AsString + ' - ' + Value ;
  end;

//   if uppercase(DataSet.FieldByName('producto_sl').asstring) = uppercase(self.rGGN.producto_sl) then
//  begin
//    if (rGGN.imprimir_garantia = true) and (rGGN.poner_arterisco = true) then
//    begin
//      value := value + '*';
//    end;
//  end;
   value := ArreglaProductoGGN(rggn, sEmpresa, dataset.FieldByName('producto_sl').AsString, value);
end;

procedure TQRAlbaranInglesVal.FontLinea( const ATipo: Integer );
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

function PreAlbaranIngles( const AEmpresa, ACentro, ACliente: String; const AAlbaran: Integer;
                           const AFecha: TDateTime; const APedirFirma, AOriginal: boolean; const APrevisualizar: boolean = True ): boolean;
var
  sCliente, sSuministro, SFileName, sMsg: string;
  aux: TStringList;
  sAux, sDir: string;
  //bEsEspanya: boolean;
  iCopias: integer;
begin
  Result:= False;


  SFileName:= GetFirmaFileName( AEmpresa, ACentro, sCliente, AAlbaran, AFecha );
  sMsg:= '';
  if APedirFirma then
  begin
    if sFileName = '' then
    begin
      ShowMessage('Falta inicializar la ruta para guardar las firmas.');
    end
    else
    begin
      if not SignatureForm.SignSave( nil, sFilename, sMsg ) then
      begin
        ShowMessage( sMsg );
      end;
      //GetFirma( self, sFilename );//OLDTablet
    end;
  end;

  try
    QRAlbaranInglesVal := TQRAlbaranInglesVal.Create(Application);
    QRAlbaranInglesVal.sempresa := AEmpresa;
    QRAlbaranInglesVal.scentro := ACentro;
    QRAlbaranInglesVal.cliente := ACliente;
    QRAlbaranInglesVal.ialbaran := AAlbaran;
    QRAlbaranInglesVal.sfecha := DateToStr(AFecha);

    QRAlbaranInglesVal.bHayGranada:= TieneGranada( AEmpresa, ACentro, AFecha, AAlbaran );

    QRAlbaranInglesVal.LineasAlbaran;

    aux := TStringList.Create;
    PutPalets( AEmpresa, ACentro, AAlbaran, AFecha, TStrings(aux) );
    QRAlbaranInglesVal.MemoPalets.Lines.Clear;
    QRAlbaranInglesVal.MemoPalets.Lines.AddStrings(aux);

    aux.Clear;
    PutLogifruit( AEmpresa, ACentro, AAlbaran, AFecha, TStrings(aux) );
    QRAlbaranInglesVal.MemoCajas.Lines.Clear;
    QRAlbaranInglesVal.MemoCajas.Lines.AddStrings(aux);
    aux.Free;

    with DMBaseDatos.QListado do
    begin
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add('      cliente_sal_sc, dir_sum_sc, moneda_sc, nif_c, hora_sc,  ');
      SQL.Add('      tipo_via_c, domicilio_c, poblacion_c, cod_postal_c, telefono_c, pais_c, ');
      SQL.Add('      tipo_via_ds, domicilio_ds, cod_postal_ds, poblacion_ds, telefono_ds, provincia_ds,pais_ds, ');
      SQL.Add('      n_pedido_sc, vehiculo_sc, transporte_sc, n_orden_sc, higiene_sc, nota_sc, fecha_descarga_sc ');

      SQL.Add(' FROM frf_salidas_c ');
      SQL.Add('      join frf_clientes on cliente_sal_sc = cliente_C ');
      SQL.Add('      join frf_dir_sum on cliente_sal_sc = cliente_ds and dir_sum_sc = dir_sum_ds ');

      SQL.Add(' WHERE empresa_sc = :empresa ');
      SQL.Add(' and centro_salida_sc = :centro ');
      SQL.Add(' and n_albaran_sc = :albaran ');
      SQL.Add(' and fecha_sc = :fecha ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      ParamByName('albaran').AsInteger := AAlbaran;
      ParamByName('fecha').AsDateTime := AFecha;

      try
        Open;
      except
        MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
        raise;
      end;

      sCliente:= FieldByName('cliente_sal_sc').AsString;
      sSuministro:= FieldByName('dir_sum_sc').AsString;

      if ( sSuministro = sCliente ) then
      begin
        //Rellenamos datos
        with QRAlbaranInglesVal do
        begin
          QRAlbaranInglesVal.qrmDireccion.Lines.Clear;
          QRAlbaranInglesVal.qrmDireccion.Lines.Add( DesCliente( sCliente ) );
          //bEsEspanya:= Trim(FieldByName('pais_c').AsString) = 'ES';

          sAux:= Trim(FieldByName('nif_c').AsString);
          if sAux <> '' then
          begin
            (*if bEsEspanya then
              QRAlbaranAlemaniaNoVar.qrmDireccion.Lines.Add( 'CIF: ' + sAux )
            else
            *)
              QRAlbaranInglesVal.qrmDireccion.Lines.Add( 'VAT: ' + sAux )
          end;
          sAux:= Trim( FieldByName('tipo_via_c').AsString  + ' ' +  FieldByName('domicilio_c').AsString );
          if sAux <> '' then
            QRAlbaranInglesVal.qrmDireccion.Lines.Add( sAux );
          sAux:= Trim( FieldByName('poblacion_c').AsString );
          if sAux <> '' then
            QRAlbaranInglesVal.qrmDireccion.Lines.Add( sAux );

          (*if bEsEspanya then
          begin
            sAux:= Trim( FieldByName('cod_postal_c').AsString + ' ' + desProvincia(FieldByName('cod_postal_c').AsString) );
            if sAux <> '' then
              QRAlbaranAlemaniaNoVar.qrmDireccion.Lines.Add( sAux );
          end
          else
          *)
          begin
            sAux:= Trim( FieldByName('cod_postal_c').AsString + ' ' + DesPais( FieldByName('pais_c').AsString ) );
            if sAux <> '' then
              QRAlbaranInglesVal.qrmDireccion.Lines.Add( sAux );
          end;
        end;
      end
      else
      begin
        //Rellenamos datos
        with QRAlbaranInglesVal do
        begin
          QRAlbaranInglesVal.qrmDireccion.Lines.Clear;
          QRAlbaranInglesVal.qrmDireccion.Lines.Add( DesCliente( sCliente ) );

          //bEsEspanya:= Trim(FieldByName('pais_ds').AsString) = 'ES';
          sAux:= Trim(FieldByName('nif_c').AsString);
          if sAux <> '' then
          begin
            (*if bEsEspanya then
              QRAlbaranAlemaniaNoVar.qrmDireccion.Lines.Add( 'CIF: ' + sAux )
            else
            *)
              QRAlbaranInglesVal.qrmDireccion.Lines.Add( 'VAT: ' + sAux )
          end;

          QRAlbaranInglesVal.qrmDireccion.Lines.Add( DesSuministro( AEmpresa, sCliente, sSuministro ) );

          sAux:= Trim( FieldByName('tipo_via_ds').AsString  + ' ' +  FieldByName('domicilio_ds').AsString );
          if sAux <> '' then
            QRAlbaranInglesVal.qrmDireccion.Lines.Add( sAux );
          sAux:= Trim( FieldByName('poblacion_ds').AsString );
          if sAux <> '' then
            QRAlbaranInglesVal.qrmDireccion.Lines.Add( sAux );

          begin
            sAux:= Trim( FieldByName('provincia_ds').AsString );
            if sAux <> '' then
            begin
              QRAlbaranInglesVal.qrmDireccion.Lines.Add( Trim( FieldByName('cod_postal_ds').AsString + ' ' + sAux ) );
              sAux:= Trim( DesPais( FieldByName('pais_ds').AsString ) );
              if sAux <> '' then
                QRAlbaranInglesVal.qrmDireccion.Lines.Add( sAux );
            end
            else
            begin
              sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + DesPais( FieldByName('pais_ds').AsString ) );
              if sAux <> '' then
                QRAlbaranInglesVal.qrmDireccion.Lines.Add( sAux );
            end;
          end;
        end;
      end;
    end;

    QRAlbaranInglesVal.sFirma:= SFileName;
    QRAlbaranInglesVal.Configurar(AEmpresa);
    DPreview.bCanSend := DMConfig.EsLaFont;
    //QRAlbaranAlemaniaNoVar.bEnEspanyol:= bEsEspanya;


    QRAlbaranInglesVal.mmoObservaciones.Lines.Clear;
    if DMBaseDatos.QListado.FieldByName('n_orden_sc').AsString <> '' then
    begin
      QRAlbaranInglesVal.mmoObservaciones.Lines.Add('N? ORDEN CARGA:' + DMBaseDatos.QListado.FieldByName('n_orden_sc').AsString );
    end;
    if DMBaseDatos.QListado.FieldByName('higiene_sc').AsInteger <> 0  then
    begin
      QRAlbaranInglesVal.mmoObservaciones.Lines.Add('CONDICIONES HIGIENICAS: OK');
    end
    else
    begin
      QRAlbaranInglesVal.mmoObservaciones.Lines.Add('CONDICIONES HIGIENICAS: INCORRECTAS');
    end;
    if Trim( DMBaseDatos.QListado.FieldByName('nota_sc').AsString ) <> '' then
      QRAlbaranInglesVal.mmoObservaciones.Lines.Add( Trim(DMBaseDatos.QListado.FieldByName('nota_sc').AsString) );

    QRAlbaranInglesVal.bOriginal:= AOriginal;
    iCopias:= NumeroCopias( AEmpresa, sCliente );
    if not AOriginal then
      iCopias:= iCopias - 1;

    QRAlbaranInglesVal.ReportTitle:= sCliente + 'A' + IntToStr( AAlbaran );

    //Datos almacen
    if ( Copy( AEmpresa, 1, 1) = 'F' ) and ( ACliente <> 'ECI' )then
    begin
      QRAlbaranInglesVal.qrlNAlbaran.Caption := AEmpresa + ACentro + Rellena( IntToStr( AAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranInglesVal.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranInglesVal.qrlNAlbaran.Width:= 73;
      QRAlbaranInglesVal.qrlNAlbaran.Left:= 7;

      QRAlbaranInglesVal.qrlNAlbaran2.Caption := Coletilla( AEmpresa );
      QRAlbaranInglesVal.qrlNAlbaran2.Enabled := True;
    end
    else
    //Bargosa
    if Trim( AEmpresa ) = '505' then
    begin
      QRAlbaranInglesVal.qrlNAlbaran.Caption := 'BON.' + Rellena( IntToStr( AAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranInglesVal.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranInglesVal.qrlNAlbaran.Width:= 73;
      QRAlbaranInglesVal.qrlNAlbaran.Left:= 7;

      QRAlbaranInglesVal.qrlNAlbaran2.Caption := '';
      QRAlbaranInglesVal.qrlNAlbaran2.Enabled := False;
    end
    else
    begin
      QRAlbaranInglesVal.qrlNAlbaran.Caption:= IntToStr( AAlbaran );
      QRAlbaranInglesVal.qrlNAlbaran.Alignment := taCenter;
      QRAlbaranInglesVal.qrlNAlbaran.Width:= 84;
      QRAlbaranInglesVal.qrlNAlbaran.Left:= 7;

      QRAlbaranInglesVal.qrlNAlbaran2.Caption := '';
      QRAlbaranInglesVal.qrlNAlbaran2.Enabled := False;
    end;


    QRAlbaranInglesVal.LFecha.Caption := DateToStr( AFecha );
    QRAlbaranInglesVal.LHoraDescarga.Caption := DMBaseDatos.QListado.FieldByName('hora_sc').AsString;
    QRAlbaranInglesVal.LDescarga.Caption := DMBaseDatos.QListado.FieldByName('fecha_descarga_sc').AsString;
    QRAlbaranInglesVal.LPedido.Caption := DMBaseDatos.QListado.FieldByName('n_pedido_sc').AsString;
    QRAlbaranInglesVal.LVehiculo.Caption := DMBaseDatos.QListado.FieldByName('vehiculo_sc').AsString;

    QRAlbaranInglesVal.LCentro.Caption := DesCentro( AEmpresa, ACEntro );
    QRAlbaranInglesVal.LTransporte.Caption := desTransporte( AEmpresa, DMBaseDatos.QListado.FieldByName('Transporte_sc').AsString ) +
                                             DNITransporte(AEmpresa, DMBaseDatos.QListado.FieldByName('Transporte_sc').AsString );
    sDir := Dir2Transporte(AEmpresa, DMBaseDatos.QListado.FieldByName('Transporte_sc').AsString);
    if Trim( sDir ) <> '' then
      QRAlbaranInglesVal.LTransporteDir1.Caption := Dir1Transporte(AEmpresa, DMBaseDatos.QListado.FieldByName('Transporte_sc').AsString) + ', ' + sDir
    else
      QRAlbaranInglesVal.LTransporteDir1.Caption := Dir1Transporte(AEmpresa, DMBaseDatos.QListado.FieldByName('Transporte_sc').AsString);

        //Buscar cuerpo del formulario
    with DMBaseDatos.QListado do
    begin
      if Active then
      begin
        Cancel;
        Close;
      end;
      with SQL do
      begin
        Clear;
        Add(' SELECT producto_p, case when nvl(des_aleman_p,'''') = '''' then descripcion_p else des_aleman_p end desProducto, envase_sl,');
        Add('     envase_e, descripcion_m, color_sl, calibre_sl,  unidades_caja_sl, ');
        Add('    SUM(kilos_sl) as kilos_sl, ');
        Add('    SUM(cajas_sl) as cajas_sl, ');
        Add('    SUM((cajas_sl*unidades_caja_sl)) as unidades ');
        Add(' FROM frf_salidas_l , frf_productos , frf_envases , frf_marcas  ');
        Add(' WHERE   (empresa_sl = :empresa) ');
        Add('    AND  (centro_salida_sl = :centro) ');
        Add('    AND  (n_albaran_sl = :albaran) ');
        Add('    AND  (fecha_sl = :fecha) ');
        Add('    AND  (producto_p = producto_sl) ');
        Add('    AND  (envase_e = envase_sl ) '); //ENVASE
        Add('    AND  (codigo_m = marca_sl) '); //MARCA
        Add(' GROUP BY  producto_p, desProducto, envase_sl,  ');
        Add('           envase_e, descripcion_m, color_sl, calibre_sl, unidades_caja_sl ');
        Add(' ORDER BY producto_p, envase_e, color_sl, calibre_sl');
      end;
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      ParamByName('albaran').AsInteger := AAlbaran;
      ParamByName('fecha').AsDateTime := AFecha;
      try
        Open;
      except
        DMBaseDatos.QListado.Cancel;
        DMBaseDatos.QListado.Close;
        MessageDlg('Error : No se puede recuperar los datos del albar?n.', mtWarning, [mbOK], 0);
        raise;
      end;
    end;

    if APrevisualizar then
    begin
      result:= DPreview.Preview(QRAlbaranInglesVal, iCopias, False, True, ForzarEnvioAlbaran( AEmpresa, sCliente, AAlbaran, AFecha )  );
    end
    else
    begin
      try
        QRAlbaranInglesVal.Print;
        result:= True;
      finally
        FreeAndNil( QRAlbaranInglesVal );
      end;
    end;

    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;

  except
    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;
    QRAlbaranInglesVal.Free;
  end;
end;


end.
