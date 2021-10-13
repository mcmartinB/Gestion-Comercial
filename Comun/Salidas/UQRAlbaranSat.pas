unit UQRAlbaranSat;

interface               

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables,
  jpeg, uSalidaUtils;

type
  TQRAlbaranSat = class(TQuickRep)
    BonnyBand: TQRBand;
    bandaFinal: TQRBand;
    BandaDatos: TQRBand;
    CabeceraTabla: TQRBand;
    QRSubDetail1: TQRSubDetail;
    beef: TQRLabel;
    descripcion2_p: TQRDBText;
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
    transito_num: TQRLabel;
    cajas_num: TQRLabel;
    kilos_num: TQRLabel;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    PsQRShape4: TQRShape;
    PsQRShape5: TQRShape;
    PsQRShape6: TQRShape;
    PsQRShape7: TQRShape;
    PsQRShape8: TQRShape;
    QEmpresas: TQuery;
    memoGarantia: TQRMemo;
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
    LAlbaran: TQRLabel;
    LFecha: TQRLabel;
    LHoraCarga: TQRLabel;
    LPedido: TQRLabel;
    LVehiculo: TQRLabel;
    PsEmpresa: TQRLabel;
    PsNif: TQRLabel;
    PsDireccion: TQRLabel;
    QRImageCab: TQRImage;
    ChildBand3: TQRChildBand;
    PsQRShape9: TQRShape;
    PsQRShape10: TQRShape;
    psEtiqueta: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel19: TQRLabel;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    qrmDireccion: TQRMemo;
    QRImgFirma: TQRImage;
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
    qrmReponsabilidadEnvase: TQRMemo;
    PsQRShape18: TQRShape;
    QRShape1: TQRShape;
    qrlbl1: TQRLabel;
    LDescarga: TQRLabel;
    notas_sl: TQRLabel;
    QRShape2: TQRShape;
    procedure QuickReport1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BandaDatosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bandaFinalBeforePrint(Sender: TQRCustomBand;
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
    procedure ChildBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPaletsMercadonaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlLblIvaPrint(sender: TObject; var Value: String);
    procedure PsQRLabel25Print(sender: TObject; var Value: String);
    procedure colorPrint(sender: TObject; var Value: String);
    procedure LVehiculoPrint(sender: TObject; var Value: String);
    procedure productoPrint(sender: TObject; var Value: String);
    procedure LHoraCargaPrint(sender: TObject; var Value: string);
  private
    bTransito: Boolean;
    resumenList: TStringList;
    rIvaFlag: Real;
    bFlag: Boolean;



  public
    rGGN : TGGN;
    bOriginal: boolean;
    sFirma: string;
    empresa, cliente: string;
    bValorar: Boolean;
    bAquiHayTomate, bHayGranada: Boolean;
    codProveedor: string;
    bEnEspanyol: Boolean;


    procedure GetCodigoProveedor(const AEmpresa, ACliente: string);
    procedure GetResumen(const AEmpresa, ACentro, AAlbaran, Afecha: string);
    procedure Configurar(const AEmpresa: string);
    //procedure PutBarCode( const AEmpresa, ACentro, AAlbaran, AFecha, ACliente: string );

    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
  end;

var
  QRAlbaranSat: TQRAlbaranSat;

implementation

uses UDMAuxDB, CVariables, StrUtils, UDMBaseDatos, bTextUtils, bSQLUtils,
     Dialogs, UDMConfig, bMath, CGlobal;

{$R *.DFM}

constructor TQRAlbaranSat.Create(AOwner: TComponent);
begin
  inherited;

  resumenList := TStringList.Create;
  bOriginal:= True;
end;

destructor TQRAlbaranSat.Destroy;
begin

//  QRAlbaranSat.QEmpresas.Cancel;
//  QRAlbaranSat.QEmpresas.Close;

  resumenList.Free;

  inherited;
end;

procedure TQRAlbaranSat.GetCodigoProveedor(const AEmpresa, ACliente: string);
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

procedure TQRAlbaranSat.GetResumen(const AEmpresa, ACentro, AAlbaran, Afecha: string);
var
  //cajas, unidades, kilos, bruto, undsCaja, rAux: Integer;
  cajas, unidades, kilos, bruto, undsCaja, rAux: Real;
  sAux: string;
  bFlag, bLineaSinPalets: boolean;
begin
  with DMBaseDatos.QTemp do
  begin
    with SQL do
    begin
      Clear;
      Add(' SELECT count(*) registros ');
      Add(' FROM frf_salidas_l ');
      Add(' WHERE (empresa_sl = :empresa) ');
      Add(' AND   (centro_salida_sl = :centro) ');
      Add(' AND   (n_albaran_sl = :albaran) ');
      Add(' AND   (fecha_sl = :fecha) ');
      Add(' AND   (tipo_palets_sl is null) ');
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      ParamByName('albaran').AsString := AAlbaran;
      ParamByName('fecha').AsDateTime := StrToDate(AFecha);
      try
        Open;
        bLineaSinPalets:= FieldByName('registros').AsInteger <> 0;
      finally
        Close;
      end;


      Clear;
      Add(' SELECT centro_origen_sl  as centro, producto_p, ');
      Add('        TRIM( descripcion_p ) || ' + SQLString(' [BEEF] ') + ' as nomProducto,');
      Add('        ( select nvl(kilos_tp,0) from frf_tipo_palets where codigo_tp = tipo_palets_sl ) as pesoPalet, ');
      Add('        sum(nvl(n_palets_sl,0)) as paletsResumen, ');
      Add('        sum(cajas_sl) as cajasResumen, ');
      Add('        sum(cajas_sl*unidades_caja_sl) as unidadesResumen, ');
      Add('        sum(kilos_sl) as kilosResumen, ');

      Add('        sum(  round( ( cajas_sl * nvl( ');
      Add('                                     case when empresa_sl = ''080'' and envase_sl = ''885'' and fecha_sl <= ''13/3/2017'' ');
      Add('                                          then 0.71 ');
      Add('                                          when empresa_sl = ''080'' and envase_sl = ''886'' and fecha_sl <= ''9/4/2017'' ');
      Add('                                          then 0.65 ');
      Add('                                          else peso_envase_e ');
      Add('                                     end ');
      Add('                                    ,0) ), 2 ) + kilos_sl ) as brutoResumen,  ');

      //Add('        sum(  round( ( cajas_sl * nvl(peso_envase_e,0) ), 2 ) + kilos_sl ) as brutoResumen, ');
      Add('        unidad_precio_sl unidadPrecio ');

      Add(' FROM frf_salidas_l , frf_productos , frf_envases ');

      Add(' WHERE (empresa_sl = :empresa) ');
      Add(' AND   (centro_salida_sl = :centro) ');
      Add(' AND   (n_albaran_sl = :albaran) ');
      Add(' AND   (fecha_sl = :fecha) ');

      Add(' AND   (producto_p = producto_sl) ');

      Add(' AND   (envase_sl = envase_e ) '); // envase
      Add(' AND   (envase_sl <> ' + QuotedStr('001') + ') '); // envase
      Add(' AND   (producto_sl IN (' + SQLString('TOM') + ','
        + SQLString('TOM') + ') ' +
        ' AND calibre_sl IN (' + SQLString('G') + ','
        + SQLString('GG') + ','
        + SQLString('g') + ','
        + SQLString('gg') + ')) ');

      Add(' GROUP BY  centro_origen_sl, producto_p, descripcion_p, unidad_precio_sl, 4 ');
      Add(' UNION ');
      Add(' SELECT centro_origen_sl  as centro, producto_p, ');
      Add('        descripcion_p as nomProducto,');
      Add('        ( select nvl(kilos_tp,0) from frf_tipo_palets where codigo_tp = tipo_palets_sl ) as pesoPalet, ');
      Add('        sum(nvl(n_palets_sl,0)) as paletsResumen, ');
      Add('        sum(cajas_sl) as cajasResumen, ');
      Add('        sum(cajas_sl*unidades_caja_sl) as unidadesResumen, ');
      Add('        sum(kilos_sl) as kilosResumen, ');
      Add('        sum(  round( ( cajas_sl * nvl( ');
      Add('                                     case when empresa_sl = ''080'' and envase_sl = ''885'' and fecha_sl <= ''13/3/2017'' ');
      Add('                                          then 0.71 ');
      Add('                                          when empresa_sl = ''080'' and envase_sl = ''886'' and fecha_sl <= ''9/4/2017'' ');
      Add('                                          then 0.65 ');
      Add('                                          else peso_envase_e ');
      Add('                                     end ');
      Add('                                    ,0) ), 2 ) + kilos_sl ) as brutoResumen,  ');
      Add('        unidad_precio_sl unidadPrecio ');

      Add(' FROM frf_salidas_l , frf_productos , frf_envases ');

      Add(' WHERE (empresa_sl = :empresa) ');
      Add(' AND   (centro_salida_sl = :centro) ');
      Add(' AND   (n_albaran_sl = :albaran) ');
      Add(' AND   (fecha_sl = :fecha) ');

      Add(' AND   (producto_p = producto_sl) ');

      Add(' AND   (envase_sl = envase_e) '); // envase
      Add(' AND   NOT (producto_sl IN (' + SQLString('TOM') + ','
        + SQLString('TOM') + ') ' +
        ' AND calibre_sl IN (' + SQLString('G') + ','
        + SQLString('GG') + ','
        + SQLString('g') + ','
        + SQLString('gg') + ') ');
      Add('            AND (envase_sl <> ' + QuotedStr('001') + '))');

      Add(' GROUP BY  centro_origen_sl, producto_p, descripcion_p, unidad_precio_sl, 4 ');
      Add(' ORDER BY  1, 2 ');

    end;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsString := AAlbaran;
    ParamByName('fecha').AsDateTime := StrToDate(AFecha);
    try
      Open;
      resumenList.Clear;
      resumenList.Add('   Cajas   Unid.       Kilos  Unds/Caj        Bruto');
      cajas := 0;
      unidades := 0;
      kilos := 0;
      bruto := 0;
      undsCaja:= 0;
      bFlag:= False;
      First;

      while not Eof do
      begin
        //'1 5XXXX 5XXXX 8XXXXXX 9XXXXXXX RESTO'
        if FieldByName('unidadPrecio').AsString = 'UND' then
        begin
          if FieldByName('cajasResumen').AsInteger <> 0 then
            //undsCaja:= bRoundTo( ( FieldByName('unidadesResumen').AsInteger / FieldByName('cajasResumen').AsInteger ), -2 );
            undsCaja:= ( FieldByName('unidadesResumen').AsInteger div FieldByName('cajasResumen').AsInteger );
          sAux:= 'U';
        end
        else
        begin
          if FieldByName('cajasResumen').AsInteger <> 0 then
            //undsCaja:= bRoundTo( ( FieldByName('kilosResumen').AsInteger / FieldByName('cajasResumen').AsInteger ), -2 );
            undsCaja:=  ( FieldByName('kilosResumen').AsInteger div FieldByName('cajasResumen').AsInteger );
          sAux:= 'K';
        end;


        if FieldByName('pesoPalet').AsFloat = 0 then
        begin
          if not bFlag then
          begin
            if bLineaSinPalets  then
              ShowMessage('Falta grabar el peso del palet o linea de albaran sin palet.')
            else
              ShowMessage('Falta grabar el peso del palet. (Ficheros/Tipo de Palets).');
            bFlag:= True;
          end;
        end;
        rAux:= bRoundTo( FieldByName('brutoResumen').AsFloat + ( FieldByName('paletsResumen').AsInteger * FieldByName('pesoPalet').AsFloat ), 2 );
//        rAux:= Trunc( bRoundTo( FieldByName('brutoResumen').AsFloat + ( FieldByName('paletsResumen').AsInteger * FieldByName('pesoPalet').AsFloat ), 2 ) );

        resumenList.Add(FieldByName('centro').AsString + ' ' +
          Rellena(FormatFloat('#0', FieldByName('cajasResumen').AsInteger ), 6) + ' ' +
          Rellena(FormatFloat('#0', FieldByName('unidadesResumen').AsInteger ), 7) + ' ' +
          //Rellena(FormatFloat('#0.00', FieldByName('kilosResumen').AsFloat ), 11) + ' ' +
          Rellena(FormatFloat('#0', FieldByName('kilosResumen').AsInteger ), 11) + ' ' +

          //Rellena(FormatFloat('#0.00', undsCaja ), 8) + ' ' + sAux + ' ' +
          Rellena(FormatFloat('#0', undsCaja ), 8) + ' ' + sAux + ' ' +

          //Rellena(FormatFloat('#0.00', rAux ), 11) + ' ' +
          Rellena(FormatFloat('#0', rAux ), 10) + ' ' +
          FieldByName('producto_p').AsString + ' ' +
          FieldByName('nomProducto').AsString);

        cajas := cajas + FieldByName('cajasResumen').AsInteger;
        unidades := unidades + FieldByName('unidadesResumen').AsInteger;
        //kilos := kilos + FieldByName('kilosResumen').AsFloat;
        kilos := kilos + FieldByName('kilosResumen').AsInteger;
        bruto := bruto + rAux;
        Next;
      end;
      resumenList.Add('  ------ ------- ----------- --------- -----------');
      resumenList.Add(Rellena(FormatFloat('#0', cajas), 8) + ' ' +
        Rellena(FormatFloat('#0', unidades), 7) + ' ' +
        //Rellena(FormatFloat('#0.00', kilos), 11) + ' ' +
        Rellena(FormatFloat('#0', kilos), 11) + ' ' +
        //Rellena(FormatFloat('#0.00', bruto), 21));
        Rellena(FormatFloat('#0', bruto), 21));
    finally
      Close;
    end;
  end;
end;

procedure TQRAlbaranSat.QuickReport1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  //Si el albaran es no valorado no imprimir precios
  if not bValorar then
  begin
    PrecioUnidad.Enabled := false;
    UnidadCobro.Enabled := false;
    PrecioNeto.Enabled := false;
    Lpor.Enabled := false;
  end;

  QEmpresas.First;
  bTransito := false;

  rIvaFlag:= DMBaseDatos.QListado.FieldByName('porc_iva_sl').AsFloat;


  bFlag:= true;

end;

procedure TQRAlbaranSat.BandaDatosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
(*
var
  temporal: string;
*)
begin
  //PRODUCTO-ENVASE
  if not bEnEspanyol then
  begin
    //PRODUCTO
    (*
    temporal := Trim(DMBaseDatos.QListado.FieldByName('producto_p').AsString);
    if ((temporal = 'E') or (temporal = 'T')) and
      ((Trim(DMBaseDatos.QListado.FieldByName('calibre_sl').AsString) = 'G') or
      (Trim(DMBaseDatos.QListado.FieldByName('calibre_sl').AsString) = 'GG')) and
      (DMBaseDatos.QListado.FieldByName('envase_sl').AsString <> '001') then
    begin
         //Descripcion en ingles -producto(beef)
      producto.Enabled := false;
      descripcion2_p.Enabled := false;
      beef.Enabled := true;
    end
    else
    *)
      if Trim(DMBaseDatos.QListado.FieldByName('descripcion2_p').asstring) <> '' then
      begin
           //Descripcion en ingles -producto
        producto.Enabled := false;
        descripcion2_p.Enabled := true;
        beef.Enabled := false;
      end
      else
      begin
           //Descripcion en castellano -producto
        producto.Enabled := true;
        descripcion2_p.Enabled := false;
        beef.Enabled := false;
      end;
  end
  else
  begin
       //Descripcion en castellano
       //Producto
    producto.Enabled := true;
    descripcion2_p.Enabled := false;
    beef.Enabled := false;
  end;

  if bFlag and ( DMBaseDatos.QListado.FieldByName('porc_iva_sl').AsFloat <> rIvaFlag ) then
  begin
    bFlag:= False;
  end;
end;

procedure TQRAlbaranSat.Configurar(const AEmpresa: string);
var
  bAux: Boolean;
  sAux, sEmpresa: string;
begin

  if ( AEmpresa = '050' ) or ( AEmpresa = '080' ) then
    sEmpresa:= 'SAT'
  else
    sEmpresa:= AEmpresa;


  bAux:= FileExists( gsDirActual + '\recursos\' + sEmpresa + 'Page.wmf');
  if bAux then
  begin
    QRImageCab.Top:= -18; //-20
    QRImageCab.Left:= -37; //-20
    QRImageCab.Width:= 763; //-30
    QRImageCab.Height:= 1102; //-20
    QRImageCab.Stretch:= True;
    QRImageCab.Enabled:= True;

    QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\' + sEmpresa + 'Page.wmf');
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

procedure TQRAlbaranSat.QRSubDetail1NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  if ((Self.Tag = 1) or (Self.Tag = 3)) and
    QEmpresas.Active and
    (QEmpresas.FieldByName('producto_p').AsString =
    DMBaseDatos.QListado.FieldByName('producto_p').AsString) and
    (QEmpresas.FieldByName('envase_e').AsString =
    DMBaseDatos.QListado.FieldByName('envase_e').AsString) and
    (QEmpresas.FieldByName('descripcion_m').AsString =
    DMBaseDatos.QListado.FieldByName('descripcion_m').AsString) and
    (QEmpresas.FieldByName('color_sl').AsString =
    DMBaseDatos.QListado.FieldByName('color_sl').AsString) and
    (QEmpresas.FieldByName('calibre_sl').AsString =
    DMBaseDatos.QListado.FieldByName('calibre_sl').AsString) and
    (QEmpresas.FieldByName('unidad_precio_sl').AsString =
    DMBaseDatos.QListado.FieldByName('unidad_precio_sl').AsString) and
    (QEmpresas.FieldByName('precio_sl').AsString =
    DMBaseDatos.QListado.FieldByName('precio_sl').AsString) and
    not QEmpresas.EOF then
  begin
//    MoreData := true;
    bTransito := true;
  end
  else
  begin
//    MoreData := false;
    bTransito := false;
  end;
end;

procedure TQRAlbaranSat.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin

  if Trim(QEmpresas.FieldByName('ref_transitos_sl').AsString) <> '' then
  begin
    transito_num.Caption := QEmpresas.FieldByName('ref_transitos_sl').AsString;
    if cliente = 'MER' then
    begin
      cajas_num.Caption := FormatFloat('#,##0', QEmpresas.FieldByName('cajas_sl').ASFloat);
      //CAJAS O UNIDADES
      if (DMBaseDatos.QListado.FieldByName('unidad_precio_sl').AsString = 'UND') then
      begin
        kilos_num.Caption := FormatFloat('#,##0 u', QEmpresas.FieldByName('unidades').AsInteger);
      end
      else
      begin
        kilos_num.Caption := FormatFloat('#,##0.00 k', QEmpresas.FieldByName('kilos_sl').AsFloat);
      end;
    end
    else
    begin
      kilos_num.Caption := FormatFloat('#,##0.00', QEmpresas.FieldByName('kilos_sl').ASFloat);
      //CAJAS O UNIDADES
      if (DMBaseDatos.QListado.FieldByName('unidad_precio_sl').AsString = 'UND') then
      begin
        cajas_num.Caption := FormatFloat('#,##0 u', QEmpresas.FieldByName('unidades').AsInteger);
      end
      else
      begin
        cajas_num.Caption := FormatFloat('#,##0 c', QEmpresas.FieldByName('cajas_sl').AsInteger);
      end;
    end;
  end;

  if Trim(QEmpresas.FieldByName('notas_sl').AsString) <> '' then
    notas_sl.Caption := QEmpresas.FieldByName('notas_sl').AsString;

  if (Trim(QEmpresas.FieldByName('ref_transitos_sl').AsString) = '') and
     (Trim(QEmpresas.FieldByName('notas_sl').AsString) = '')then
    PrintBand := false
  else if Trim(QEmpresas.FieldByName('ref_transitos_sl').AsString) = '' then
  begin
    transito_num.Enabled := false;
    cajas_num.enabled := false;
    kilos_num.enabled := false;
  end
  else if Trim(QEmpresas.FieldByName('notas_sl').AsString) = '' then
    notas_sl.Enabled := False;

  QEmpresas.Next;
end;

procedure TQRAlbaranSat.PsQRLabel19Print(sender: TObject;
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

procedure TQRAlbaranSat.bandaFinalBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  (*Vuelto a poner a peticion de Esther Cuerda, si alguien vuelve a pedir que se quite que hable con ella*)
  memoGarantia.Lines.Clear;


  if not bEnEspanyol then
  begin
    memoGarantia.Lines.Add( 'Partial or complete rejections should be communicated and quantified no later than 48 hours after the reception of the goods by email or fax.' );

     // memoGarantia.Lines.Add( 'Certified product GLOBALG.A.P.  GGN: '+self.GGN_Code);
  end
  else
  begin
    memoGarantia.Lines.Add( 'Las incidencias deben ser comunicadas y cuantificadas  por escrito dentro del plazo de 48 horas posteriores a la descarga de la mercanc�a.' );
  end;

  if rGGN.imprimir_garantia = true then
  begin
    if bEnEspanyol = true then memoGarantia.lines.add(rggn.descri_esp+rggn.ggn_code)
    else memoGarantia.lines.add(rggn.descri_eng+rggn.ggn_code);
  end;

  if (CGlobal.gProgramVersion = CGlobal.pvSAT) or (rGGN.imprimir_garantia = true) then
    bandaFinal.Height:= 25
  else
    bandaFinal.Height:= 15;


end;

procedure TQRAlbaranSat.ChildBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
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
      else psEtiqueta.Caption := 'COPIA ' + IntToStr(Tag - 2) + '/' + IntToStr(Tag - 2) + 'TH COPY';
    end;
  end;


  //Carga firma si la tiene
  If FileExists( sFirma ) then
  begin
    QRImgFirma.Enabled:= True;
    QRImgFirma.Stretch:= True;
    QRImgFirma.Picture.LoadFromFile( sFirma );
  end;

  if bEnEspanyol then
  begin
    qrmReponsabilidadEnvase.Lines.Clear;
    qrmReponsabilidadEnvase.Lines.Add('"De conformidad con lo establecido en la ley 11/1997, de 24 de abril, de envases y residuos de envases y, el art�culo 18.1 del  Real Decreto 782/1998,  de 30 de Abril que desarrolla');
    qrmReponsabilidadEnvase.Lines.Add('la Ley 11/1997; el responsable de la entrega  del residuo de envase o envase usado para su correcta  gesti�n ambiental de aquellos envases no identificados mediante el Punto Verde');
    if bHayGranada then
      qrmReponsabilidadEnvase.Lines.Add('(sistema integrado de gesti�n  de Ecoembes), ser� el poseedor final del mismo".                                                                          ENTIDAD DE CONTROL ES-ECO-020-CV.  GRANADA ECO.')
    else
      qrmReponsabilidadEnvase.Lines.Add('(sistema integrado de gesti�n  de Ecoembes), ser� el poseedor final del mismo".                                                                          ');
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
end;


procedure TQRAlbaranSat.CabeceraTablaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := bValorar or (MemoPalets.Lines.Count <> 0) or (MemoCajas.Lines.Count <> 0);
  CantNeta.Enabled := bValorar;
  qrxIva.Enabled := bValorar;
  qrxTotal.Enabled := bValorar;
end;

procedure TQRAlbaranSat.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := mmoObservaciones.Lines.Count <> 0;
end;

procedure TQRAlbaranSat.LPaletsPrint(sender: TObject; var Value: string);
begin
  if MemoPalets.Lines.Count = 0 then Value := '';
end;

procedure TQRAlbaranSat.LCajasPrint(sender: TObject; var Value: string);
begin
  if MemoCajas.Lines.Count = 0 then Value := '';
end;

procedure TQRAlbaranSat.LHoraCargaPrint(sender: TObject; var Value: string);
begin
  if cliente = 'LID' then value := '';
end;

procedure TQRAlbaranSat.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  mmoResumen.Lines.Clear;
  if ( tag = 1 ) or ( (empresa <> '037' ) and ( cliente = 'MER' ) and ( tag = 2 ) )then
    mmoResumen.Lines.AddStrings(resumenList)
  else
    PrintBand := false;
end;

procedure TQRAlbaranSat.bndPaletsMercadonaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= ( empresa = '037' ) and  ( cliente = 'MER' ) and ( tag = 2 );
end;

procedure TQRAlbaranSat.descripcion2_ePrint(sender: TObject;
  var Value: string);

begin
  Value := desEnvaseCliente(
    empresa,
    DMBaseDatos.QListado.FieldByName('producto_p').AsString,
    Value,
    cliente,
    -1);
    //, DMBaseDatos.QListado.FieldByName('unidades_caja_sl').AsInteger);

 //   if self.rPlatanoGGC.repeticiones = 1 then value := '*' + value;


end;

procedure TQRAlbaranSat.PsQRLabel8Print(sender: TObject;
  var Value: String);
begin
(*
  if cliente = 'MER' then
    Value:= 'Fecha Carga'
  else
    Value:= 'Fecha Carga';
*)
end;

procedure TQRAlbaranSat.psKilosPrint(sender: TObject;
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

procedure TQRAlbaranSat.cajasPrint(sender: TObject; var Value: String);
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

procedure TQRAlbaranSat.PsQRLabel18Print(sender: TObject;
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

procedure TQRAlbaranSat.PsQRLabel27Print(sender: TObject;
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

procedure TQRAlbaranSat.PsQRLabel28Print(sender: TObject;
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

procedure TQRAlbaranSat.QRDBText1Print(sender: TObject; var Value: String);
begin
  if cliente = 'MER' then
  begin
    Value:= Copy( Value, 1, 1 );
  end
  else
  begin
    begin
      Value:= 'K';
    end;
  end;
end;

procedure TQRAlbaranSat.UnidadCobroPrint(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 1, 1 );
end;

procedure TQRAlbaranSat.QRDBText2Print(sender: TObject; var Value: String);
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

procedure TQRAlbaranSat.qrlLblIvaPrint(sender: TObject; var Value: String);
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

procedure TQRAlbaranSat.PsQRLabel25Print(sender: TObject;
  var Value: String);
begin
  if empresa = '001' then
  begin
    value:= 'Categ.';
  end
  else
  begin
    value:= 'Color';
  end;
end;

procedure TQRAlbaranSat.colorPrint(sender: TObject; var Value: String);
begin
  if empresa = '001' then
    Value:= DMBaseDatos.QListado.FieldByName('categoria_sl').AsString;
end;

procedure TQRAlbaranSat.LVehiculoPrint(sender: TObject; var Value: String);
begin
  //PARA BORRAR
end;

procedure TQRAlbaranSat.productoPrint(sender: TObject; var Value: String);
begin
  if ( empresa = '050' ) and ( DMBaseDatos.QListado.FieldByName('producto_p').AsString = 'TCP' ) then
  begin
    Value:= 'TOMATE CHERRY'
  end;

  value := ArreglaProductoGGN(rggn, empresa, DMBaseDatos.QListado.FieldByName('producto_sl').AsString, value);
end;

end.
