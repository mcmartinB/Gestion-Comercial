unit AlbaranEntreCentrosMercadonaQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables,
  jpeg, uSalidaUtils;

type
  TQRAlbaranEntreCentrosMercadona = class(TQuickRep)
    BonnyBand: TQRBand;
    BandaDatos: TQRBand;
    CabeceraTabla: TQRBand;
    marca: TQRDBText;
    color: TQRDBText;
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
    LHoraCarga: TQRLabel;
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
    PsQRShape9: TQRShape;
    PsQRShape10: TQRShape;
    psEtiqueta: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel19: TQRLabel;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    QRImgFirma: TQRImage;
    qrimgLogoBargosa: TQRImage;
    qrmGarantia: TQRMemo;
    qrmReponsabilidadEnvase: TQRMemo;
    qrlbl1: TQRLabel;
    qrshp1: TQRShape;
    LDescarga: TQRLabel;
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
  private
    bTransito: Boolean;
    resumenList: TStringList;
    rIvaFlag: Real;
    bFlag: Boolean;

  public
    bOriginal: boolean;
    sFirma: string;
    empresa, cliente: string;
    bValorar: Boolean;
    codProveedor: string;
    bEnEspanyol: Boolean;
    rGGN : TGGN;

    procedure GetCodigoProveedor(const AEmpresa, ACliente: string);
    procedure GetResumen(const AEmpresa, ACentro: string; const AAlbaran: integer; const Afecha: TDateTime );
    procedure Configurar(Empresa: string);
    
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses UDMAuxDB, CVariables, StrUtils, UDMBaseDatos, bTextUtils, bSQLUtils,
     Dialogs, UDMConfig, bMath;

{$R *.DFM}

constructor TQRAlbaranEntreCentrosMercadona.Create(AOwner: TComponent);
begin
  inherited;

  resumenList := TStringList.Create;
  bOriginal:= True;
end;

destructor TQRAlbaranEntreCentrosMercadona.Destroy;
begin
  resumenList.Free;

  inherited;
end;

procedure TQRAlbaranEntreCentrosMercadona.GetCodigoProveedor(const AEmpresa, ACliente: string);
begin
  if ACliente = 'MER' then
  begin
    DMBaseDatos.QTemp.SQL.Clear;
    DMBaseDatos.QTemp.SQL.Add(' SELECT codigo_ean_e  ' +
      ' FROM    frf_empresas ' +
      ' WHERE empresa_e = :empresa ');
    DMBaseDatos.QTemp.ParamByName('empresa').AsString := AEmpresa;
    DMBaseDatos.QTemp.open;
    codProveedor := DMBaseDatos.QTemp.FieldByName('codigo_ean_e').AsString;
    DMBaseDatos.QTemp.Close;
  end
  else
  begin
    codProveedor := '';
  end;
end;

procedure TQRAlbaranEntreCentrosMercadona.GetResumen(const AEmpresa, ACentro: string; const AAlbaran: integer; const Afecha: TDateTime );
var
  cajas, unidades, kilos, bruto, undsCaja: Real;
  sAux: string;
begin
  with DMBaseDatos.QTemp do
  begin
    with SQL do
    begin
      Clear;
      Add(' SELECT centro_origen_sl  as centro, producto_p, ');
      Add('        descripcion_p as nomProducto,');
      Add('        sum(cajas_sl) as cajasResumen, ');
      Add('        sum(cajas_sl*unidades_caja_sl) as unidadesResumen, ');
      Add('        sum(kilos_sl) as kilosResumen, ');
      Add('        sum(  round( ( cajas_sl * nvl(peso_envase_e,0) ), 2 ) + kilos_sl ) as brutoResumen, ');
      Add('        unidad_precio_sl unidadPrecio ');

      Add(' FROM frf_salidas_l , frf_productos , frf_envases ');

      Add(' WHERE (empresa_sl = :empresa) ');
      Add(' AND   (centro_salida_sl = :centro) ');
      Add(' AND   (n_albaran_sl = :albaran) ');
      Add(' AND   (fecha_sl = :fecha) ');

      Add(' AND   (producto_p = producto_sl) ');

      Add(' AND   (envase_sl = envase_e and producto_e = producto_p ) '); // envase

      Add(' GROUP BY  centro_origen_sl, producto_p, descripcion_p, unidad_precio_sl ');
      Add(' ORDER BY  1, 2 ');

    end;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsInteger := AAlbaran;
    ParamByName('fecha').AsDateTime := AFecha;
    try
      Open;
      resumenList.Clear;
      resumenList.Add('   Cajas   Unid.       Kilos  Unds/Caj       Bruto(Sin Palets)');
      cajas := 0;
      unidades := 0;
      kilos := 0;
      bruto := 0;
      First;
      undsCaja:= 0;
      while not Eof do
      begin
        //'1 5XXXX 5XXXX 8XXXXXX 9XXXXXXX RESTO'
        if Fields[7].AsString = 'UND' then
        begin
          if Fields[3].AsInteger <> 0 then
            undsCaja:= bRoundTo( ( Fields[4].AsInteger / Fields[3].AsInteger ), -2 );
          sAux:= 'U';
        end
        else
        begin
          if Fields[3].AsInteger <> 0 then
            undsCaja:= bRoundTo( ( Fields[5].AsFloat / Fields[3].AsInteger ), -2 );
          sAux:= 'K';
        end;
        resumenList.Add(Fields[0].AsString + ' ' +
          Rellena(FormatFloat('#0', Fields[3].AsInteger ), 6) + ' ' +
          Rellena(FormatFloat('#0', Fields[4].AsInteger ), 7) + ' ' +
          Rellena(FormatFloat('#0.00', Fields[5].AsFloat ), 11) + ' ' +

          Rellena(FormatFloat('#0.00', undsCaja ), 7) + ' ' + sAux + ' ' +

          Rellena(Fields[6].AsString, 11) + ' ' +
          Fields[1].AsString + ' ' +
          Fields[2].AsString);
        cajas := cajas + Fields[3].AsFloat;
        unidades := unidades + Fields[4].AsFloat;
        kilos := kilos + Fields[5].AsFloat;
        bruto := bruto + Fields[6].AsFloat;
        Next;
      end;
      resumenList.Add('  ------ ------- ----------- --------- -----------');
      resumenList.Add(Rellena(FormatFloat('#0', cajas), 8) + ' ' +
        Rellena(FormatFloat('#0', unidades), 7) + ' ' +
        Rellena(FormatFloat('#0.00', kilos), 11) + ' ' +
        Rellena(FormatFloat('#0.00', bruto), 21));
    finally
      Close;
    end;
  end;
end;

procedure TQRAlbaranEntreCentrosMercadona.QuickReport1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  bEnEspanyol:= true;
  //Si el albaran es no valorado no imprimir precios
  if not bValorar then
  begin
    PrecioUnidad.Enabled := false;
    UnidadCobro.Enabled := false;
    PrecioNeto.Enabled := false;
    Lpor.Enabled := false;
  end;

  bTransito := false;

  rIvaFlag:= DMBaseDatos.QListado.FieldByName('porc_iva_sl').AsFloat;
  bFlag:= true;

end;

procedure TQRAlbaranEntreCentrosMercadona.BandaDatosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bFlag and ( DMBaseDatos.QListado.FieldByName('porc_iva_sl').AsFloat <> rIvaFlag ) then
  begin
    bFlag:= False;
  end;
end;

procedure TQRAlbaranEntreCentrosMercadona.Configurar(Empresa: string);
var
  bAux: Boolean;
  sAux: string;
  ssEmpresa: string;
begin
  if Copy( Empresa, 1, 1 ) = 'F' then
    ssEmpresa:= 'BAG'
  else
  if Empresa  = '510' then
    ssEmpresa:= '505'
  else
  if ( Empresa = '050' ) or ( Empresa = '080' ) then
    ssEmpresa:= 'SAT'
  else
    ssEmpresa:= Empresa;

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
      ' where empresa_e=' + QuotedStr(Trim(Empresa)) +
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

procedure TQRAlbaranEntreCentrosMercadona.PsQRLabel19Print(sender: TObject;
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

procedure TQRAlbaranEntreCentrosMercadona.CabeceraTablaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := bValorar or (MemoPalets.Lines.Count <> 0) or (MemoCajas.Lines.Count <> 0);
  CantNeta.Enabled := bValorar;
  qrxIva.Enabled := bValorar;
  qrxTotal.Enabled := bValorar;
end;

procedure TQRAlbaranEntreCentrosMercadona.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := mmoObservaciones.Lines.Count <> 0;
end;

procedure TQRAlbaranEntreCentrosMercadona.LPaletsPrint(sender: TObject; var Value: string);
begin
  if MemoPalets.Lines.Count = 0 then
    Value := '';
end;

procedure TQRAlbaranEntreCentrosMercadona.LCajasPrint(sender: TObject; var Value: string);
begin
  if MemoCajas.Lines.Count = 0 then
    Value := '';
end;

procedure TQRAlbaranEntreCentrosMercadona.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  mmoResumen.Lines.Clear;
  mmoResumen.Lines.AddStrings(resumenList);
end;

procedure TQRAlbaranEntreCentrosMercadona.bndPaletsMercadonaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if bOriginal then
  begin
    PrintBand:= ( tag = 2 );
  end
  else
  begin
    PrintBand:= ( tag = 1 );
  end;
end;

procedure TQRAlbaranEntreCentrosMercadona.descripcion2_ePrint(sender: TObject;
  var Value: string);

begin
  Value := desEnvaseCliente(
    empresa,
    DMBaseDatos.QListado.FieldByName('producto_p').AsString,
    Value,
    cliente,
    -1);
end;

procedure TQRAlbaranEntreCentrosMercadona.psKilosPrint(sender: TObject;
  var Value: String);
begin
  if cliente = 'MER' then
  begin
    if (DMBaseDatos.QListado.FieldByName('unidad_precio_sl').AsString = 'UND') then
      value := FormatFloat('#,##0', DMBaseDatos.QListado.FieldByName('unidades').AsInteger)
    else
      value := FormatFloat('#,##0.00', DMBaseDatos.QListado.FieldByName('kilos_sl').AsFloat);
  end
  else
  begin
    value := FormatFloat('#,##0.00', DMBaseDatos.QListado.FieldByName('kilos_sl').AsFloat);
  end;
end;

procedure TQRAlbaranEntreCentrosMercadona.cajasPrint(sender: TObject; var Value: String);
begin
  //CAJAS O UNIDADES
  if cliente = 'MER' then
  begin
    value := FormatFloat('#,##0', DMBaseDatos.QListado.FieldByName('cajas_sl').AsInteger);
  end
  else
  begin
    if (DMBaseDatos.QListado.FieldByName('unidad_precio_sl').AsString = 'UND') then
    begin
      value := FormatFloat('#,##0', DMBaseDatos.QListado.FieldByName('unidades').AsInteger);
    end
    else
    begin
      value := FormatFloat('#,##0', DMBaseDatos.QListado.FieldByName('cajas_sl').AsInteger);
    end
  end;
end;

procedure TQRAlbaranEntreCentrosMercadona.PsQRLabel18Print(sender: TObject;
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

procedure TQRAlbaranEntreCentrosMercadona.PsQRLabel27Print(sender: TObject;
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

procedure TQRAlbaranEntreCentrosMercadona.PsQRLabel28Print(sender: TObject;
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

procedure TQRAlbaranEntreCentrosMercadona.QRDBText1Print(sender: TObject; var Value: String);
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

procedure TQRAlbaranEntreCentrosMercadona.UnidadCobroPrint(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 1, 1 );
end;

procedure TQRAlbaranEntreCentrosMercadona.QRDBText2Print(sender: TObject; var Value: String);
begin
  //CAJAS O UNIDADES
  if cliente = 'MER' then
  begin
    value := '';
  end
  else
  begin
    if (DMBaseDatos.QListado.FieldByName('unidad_precio_sl').AsString = 'UND') then
    begin
      value := 'U';
    end
    else
    begin
      value := 'C';
    end
  end;
end;

procedure TQRAlbaranEntreCentrosMercadona.qrlLblIvaPrint(sender: TObject; var Value: String);
begin
  if bFlag and bValorar then
  begin
    Value:= 'IVA ' + FloatToStr( rIvaFlag ) + '%';
  end
  else
  begin
    Value:= 'IVA ';
  end;
end;

procedure TQRAlbaranEntreCentrosMercadona.ChildBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bOriginal then
  begin
    case Tag of
      0: psEtiqueta.Caption := '';
      1: psEtiqueta.Caption := 'ORIGINAL EMPRESA';
      2: psEtiqueta.Caption := 'ORIGINAL CLIENTE';
      3: psEtiqueta.Caption := 'COPIA 1';
      4: psEtiqueta.Caption := 'COPIA 2';
      5: psEtiqueta.Caption := 'COPIA 3';
      else psEtiqueta.Caption := 'COPIA ' + IntToStr(Tag - 2);
    end;
  end
  else
  begin
    case Tag of
      0: psEtiqueta.Caption := '';
      1: psEtiqueta.Caption := 'ORIGINAL CLIENTE';
      2: psEtiqueta.Caption := 'COPIA 1';
      3: psEtiqueta.Caption := 'COPIA 2';
      4: psEtiqueta.Caption := 'COPIA 3';
      else psEtiqueta.Caption := 'COPIA ' + IntToStr(Tag - 1);
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

end.
