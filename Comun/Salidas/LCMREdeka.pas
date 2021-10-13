unit LCMREdeka;

interface

uses Forms, Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, jpeg, UDMCmr;
type
  TQRLCMREdeka = class(TQuickRep)
    detalles: TQRBand;
    qrmRemitente: TQRMemo;
    qrmConsignatario: TQRMemo;
    cmrObservaciones: TQRMemo;
    marcas: TQRMemo;
    cajas: TQRMemo;
    agrupacion: TQRMemo;
    qrmPesoBruto: TQRMemo;
    producto: TQRMemo;
    LMatricula: TQRLabel;
    QDetallesCMR: TQuery;
    QPesoEnvase: TQuery;
    lblNumeroPagina: TQRLabel;
    lblDescripcionHoja: TQRLabel;
    lblCodigoCmr: TQRLabel;
    QRMTransportista: TQRMemo;
    QRMClausulas: TQRMemo;
    QPesoPalet: TQuery;
    QRImgFirma: TQRImage;
    qrmEntrega: TQRMemo;
    qrmCarga: TQRMemo;
    qrlFormalizadoEn: TQRLabel;
    qrlFormalizadoFecha: TQRLabel;
    qrmTransporte2: TQRMemo;
    categoria: TQRMemo;
    pais: TQRMemo;
    calibre: TQRMemo;
    lote: TQRMemo;
    qrmPalets: TQRMemo;
    QRImage: TQRImage;
    fecha_sc: TQRDBText;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure detallesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
     procedure DireccionCentroCMR( const AEmpresa, ACentro: string;
                 var ADireccion: TStringList; var APais, APoblacion: string );
  public
    sFirma: string;
    procedure ImprimirCMR( const ACodigoCMR: string; const ACopias: integer;
                           const ARemitente, ADestino, ATransportista: boolean);

    constructor Create( AOwner: TComponent ); Override;

  end;

  procedure PreCMREdeka( const AEmpresa, ACentroSalida, ACliente: String;
                       const AAlbaran: integer;
                       const AFecha: TDateTime;
                       const CabCMR: RCabCMR );

var
  QRLCMREdeka: TQRLCMREdeka;

  procedure DatosTransportista( var AReport: TQRLCMREdeka; const AEmpresa, ATransportista:string );

implementation

uses UDMBaseDatos, SysUtils, CVariables, UDMAuxDB, DError, DPreview, UDMConfig,
     Dialogs, SignatureForm, bTextUtils, DateUtils, bMath;

{$R *.DFM}

var
  sEmpresa, sCentroSalida: String;
  iAlbaran: integer;
  dFecha: TDateTime;


constructor TQRLCMREdeka.Create( AOwner: TComponent );
begin
  inherited;
  (*
  QRImage.Picture.LoadFromFile(gsDirActual + '\recursos\cmr.jpg');
  QRImage.Refresh;
  Application.ProcessMessages;
  *)
end;

procedure TQRLCMREdeka.detallesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRImage.Picture.LoadFromFile(gsDirActual + '\recursos\cmr.jpg');
  QRImage.Refresh;
end;


procedure TQRLCMREdeka.ImprimirCMR( const ACodigoCMR: string; const ACopias: integer;
                               const ARemitente, ADestino, ATransportista: boolean);
var
  i, iCopias: integer;
begin
  i:= 0;

  lblCodigoCMR.Caption:= 'Nº: ' + ACodigoCMR;

  DPreview.Imprimir:= False;
  DPreview.Preview( self, ACopias );
  DPreview.Imprimir:= True;
  iCopias:= self.PrinterSettings.Copies;
  self.PrinterSettings.Copies:= 1;

  if not DPreview.PressBtnPrint then
    Exit;

  if ( iCopias > 0 ) and ARemitente then
  begin
    Inc( i );
    lblNumeroPagina.Caption:= '1';
    lblDescripcionHoja.Caption:= 'Ejemplar para el remitente - Exemplaire de l''expéditeur - Copy for sender';
    Print;
  end;

  if ( iCopias > 1 ) and ADestino then
  begin
    Inc( i );
    lblNumeroPagina.Caption:= '2';
    lblDescripcionHoja.Caption:= 'Ejemplar para el consignatario - Exemplaire du destinataire - Copy for consignee';
    Print;
  end;

  if ( iCopias > 2 ) and ATransportista then
  begin
    Inc( i );
    lblNumeroPagina.Caption:= '3';
    lblDescripcionHoja.Caption:= 'Ejemplar para el porteador - Exemplaire du transporteur - Copy for carrier';
    Print;
  end;

  while i < iCopias do
  begin
    Inc( i );
    lblNumeroPagina.Caption:= IntToStr(i);
    lblDescripcionHoja.Caption:= '';
    Print;
  end;
end;

procedure TQRLCMREdeka.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  //Carga firma si la tiene
  If FileExists( sFirma ) then
  begin
    QRImgFirma.Enabled:= True;
    QRImgFirma.Stretch:= True;
    QRImgFirma.Picture.LoadFromFile( sFirma );
  end;
end;

function GetLote ( const AFecha: TDateTime ): string;
var
  iAux: Integer;
begin
  iAux:= WeekOfTheYear(  AFecha );
  if iAux  < 10 then
   result:= 'L 0' + IntToStr( iAux )
  else
   result:= 'L ' + IntToStr( iAux );
  iAux:= DayOfTheWeek(  AFecha );
  if iAux  < 10 then
   result:= result + ' 0' + IntToStr( iAux )
  else
   result:= result + ' ' + IntToStr( iAux );
end;

function GetPesoPalets(const APalets, APalet: string): Extended;
begin
  result:= StrToIntDef( APalets, 0 );
  QRLCMREdeka.QPesoPalet.Close;
  with QRLCMREdeka.QPesoPalet.SQL do
  begin
    Clear;
    Add(' SELECT kilos_tp ');
    Add(' FROM frf_tipo_palets ');
    Add(' WHERE  codigo_tp = :palet ');
  end;
  QRLCMREdeka.QPesoPalet.ParamByName('palet').AsString := QRLCMREdeka.QDetallesCMR.FieldByname( 'tipo_palets_sl' ).AsString;
  QRLCMREdeka.QPesoPalet.Open;
  if QRLCMREdeka.QPesoPalet.IsEmpty then
    result:= 0
  else
    result:= result * QRLCMREdeka.QPesoPalet.FieldByName('kilos_tp').AsFloat;
  QRLCMREdeka.QPesoPalet.Close;
end;

function GetPesoEnvases(const ACajas, AUnidades, AEnvase: string): Extended;
var
  peso, pesounidad, pesoenvase: Extended;
  iUnidadesCaja: Integer;
begin
  if Trim(QRLCMREdeka.QPesoEnvase.SQL.Text) = '' then
    with QRLCMREdeka.QPesoEnvase do
    begin
      SQL.Clear;
      SQl.Add(' SELECT DISTINCT empresa_sl, centro_salida_sl, n_albaran_sl,' +
        '        fecha_sl, kilos_sl, peso_envase_uc, peso_envase_e ' +
        ' FROM frf_salidas_l, frf_envases, OUTER frf_und_consumo ' +
        ' WHERE   (empresa_sl =:emp) ' +
        '   AND  (centro_salida_sl =:cen) ' +
        '   AND  (n_albaran_sl =:alb) ' +
        '   AND  (fecha_sl = :fec) ' +
        '   AND  (envase_sl= :envase) ' +
        '   AND  (envase_e = envase_sl) ' +
        '   AND  (empresa_uc = :emp) ' +
        '   AND  (codigo_uc = tipo_unidad_e)');
    end;
  peso := 0;
  QRLCMREdeka.QPesoEnvase.ParamByName('emp').AsString := sEmpresa;
  QRLCMREdeka.QPesoEnvase.ParamByName('cen').AsString := sCentroSalida;
  QRLCMREdeka.QPesoEnvase.ParamByName('alb').AsInteger := iAlbaran;
  QRLCMREdeka.QPesoEnvase.ParamByName('fec').AsDatetime := dFEcha;
  QRLCMREdeka.QPesoEnvase.ParamByName('envase').AsString := AEnvase;
  if not QRLCMREdeka.QPesoEnvase.Active then
    QRLCMREdeka.QPesoEnvase.Open;

  QRLCMREdeka.QPesoEnvase.First;

  if (QRLCMREdeka.QPesoEnvase.FieldByName('peso_envase_uc').AsString = '') then
    pesounidad := 0
  else pesounidad := QRLCMREdeka.QPesoEnvase.FieldByName('peso_envase_uc').AsFloat;

  if (QRLCMREdeka.QPesoEnvase.FieldByName('peso_envase_e').AsString <> '') then
    pesoenvase := QRLCMREdeka.QPesoEnvase.FieldByName('peso_envase_e').AsFloat
  else pesoenvase := 0;

  iUnidadesCaja:= StrToIntDef( AUnidades, 0 );
  (*TODO*) //Por que pongo peso de unidades, no esta incluido con el del envase
  iUnidadesCaja:= 0;
  if ( iUnidadesCaja > 1) and (pesounidad > 0) then
    peso := peso + ( iUnidadesCaja * pesounidad ) + pesoenvase
  else peso := peso + pesoenvase;

  result := StrToIntDef( ACajas, 0 )*  peso;
  QRLCMREdeka.QPesoEnvase.Close;
end;


procedure definirDetallesCMRInyeccion;
var
    pesoBruto, pesoAux, cajas: Integer;
    sLote: string;
    iPalets: Integer;
begin
  pesobruto := 0;
  cajas := 0;

   //Dejo en blanco los campos del Report
  QRLCMREdeka.marcas.Lines.Clear;
  QRLCMREdeka.marcas.Lines.Add('Marke');
  QRLCMREdeka.categoria.Lines.Clear;
  QRLCMREdeka.categoria.Lines.Add('Kategorie');
  QRLCMREdeka.cajas.Lines.Clear;
  QRLCMREdeka.cajas.Lines.Add('Kolli');
  QRLCMREdeka.agrupacion.Lines.Clear;
  QRLCMREdeka.agrupacion.Lines.Add('Format');
  QRLCMREdeka.producto.Lines.Clear;
  QRLCMREdeka.producto.Lines.Add('Produkt ');
  QRLCMREdeka.pais.Lines.Clear;
  QRLCMREdeka.pais.Lines.Add('Herkunft');
  QRLCMREdeka.calibre.Lines.Clear;
  QRLCMREdeka.calibre.Lines.Add('Kaliber');
  QRLCMREdeka.qrmPesoBruto.Lines.Clear;
  QRLCMREdeka.qrmPesoBruto.Lines.Add('Bruttogewicht');
  QRLCMREdeka.lote.Lines.Clear;
  QRLCMREdeka.lote.Lines.Add('Losnr.');

  with QRLCMREdeka.QDetallesCMR do
  begin
    try
      Close;

      SQL.Clear;
      SQl.Add(' SELECT cliente_sl, marca_sl, producto_sl, descripcion_m, envase_comercial_e, envase_sl, categoria_sl, calibre_sl, tipo_palets_sl, ' +
        '        unidades_caja_sl, SUM(n_palets_sl) palets, SUM(cajas_sl) cajas, SUM(kilos_sl) pesoNetoProducto ' +
        ' FROM frf_salidas_l, OUTER frf_envases, OUTER frf_marcas ' +
        ' WHERE  (envase_sl = envase_e ) ' +
        '   AND  (marca_sl = codigo_m) ' +
        '   AND  ( (empresa_sl =:emp) ' +
        '   AND  (centro_salida_sl = :cen) ' +
        '   AND  (n_albaran_sl = :alb) ' +
        '   AND  (fecha_sl =:fec) ) ' +
        ' GROUP BY cliente_sl, marca_sl, descripcion_m, envase_comercial_e, producto_sl,envase_sl, categoria_sl, calibre_sl, tipo_palets_sl, unidades_caja_sl ' +
        ' ORDER BY descripcion_m, envase_comercial_e, producto_sl, envase_sl ');

      ParamByName('emp').AsString := sEmpresa;
      ParamByName('cen').AsString := sCentroSalida;
      ParamByName('alb').AsString := IntToStr( iAlbaran );
      ParamByName('fec').AsDatetime := dFecha;
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        Exit;
      end;
    end;
    First;

    ///////////////////////////////////////////////////////////////////////////
    iPalets:= 0;
    while not EOF do
    begin
      //Pasar los valores al Report
      iPalets:= iPalets + FieldByName('palets').AsInteger;
      sLote:= GetLote( dFecha );
      QRLCMREdeka.lote.Lines.Add(sLote);
      QRLCMREdeka.marcas.Lines.Add(FieldByName('descripcion_m').AsString);
      //QRLCMREdeka.categoria.Lines.Add(' Kat. ' + FieldByName('categoria_sl').AsString);
      QRLCMREdeka.categoria.Lines.Add( FieldByName('categoria_sl').AsString);
      QRLCMREdeka.producto.Lines.Add( desEnvaseCliente( sEmpresa, FieldByName('producto_sl').AsString, FieldByName('envase_sl').AsString,
                             FieldByName('cliente_sl').AsString, 0) );
      QRLCMREdeka.pais.Lines.Add( 'SPANIEN' );
      //QRLCMREdeka.calibre.Lines.Add( 'Kal. ' + FieldByName('calibre_sl').AsString );
      QRLCMREdeka.calibre.Lines.Add( FieldByName('calibre_sl').AsString );

      if (FieldByName('envase_comercial_e').AsString = 'S') then
        QRLCMREdeka.agrupacion.Lines.Add('KARTON')
      else
        QRLCMREdeka.agrupacion.Lines.Add('EUROPOOL');
        //QRLCMREdeka.agrupacion.Lines.Add('PTE.RECICLABLE');

      pesoAux:= Trunc( bRoundTo( FieldByName('pesoNetoProducto').AsFloat +
                GetPesoEnvases( FieldByName('cajas').AsString, FieldByName('unidades_caja_sl').AsString,  FieldByName('envase_sl').AsString ) +
                GetPesoPalets( FieldByName('palets').AsString, FieldByName('tipo_palets_sl').AsString), 0 ) );

      cajas := cajas + FieldByName('cajas').AsInteger;
      pesoBruto := pesobruto + pesoAux;
      QRLCMREdeka.cajas.Lines.Add(FormatFloat('###,##0;-###,##0', FieldByName('cajas').AsInteger));
      QRLCMREdeka.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', pesoAux));
      //QRLCMREdeka.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0.00;0', iPesoAux));
      Next;
    end;
    QRLCMREdeka.qrmPalets.Lines.Clear;
    QRLCMREdeka.qrmPalets.Lines.Add( IntToStr( iPalets ) + ' ' + desTipoPalet(FieldByName('tipo_palets_sl').AsString) );
    Close;

    QRLCMREdeka.cajas.Lines.Add('------------');
    QRLCMREdeka.cajas.Lines.Add(FormatFloat('###,##0;-###,##0', cajas));
    QRLCMREdeka.qrmPesoBruto.Lines.Add('------------');
    QRLCMREdeka.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', pesoBruto));

  end;
end;

procedure TransportitaCasilla16( var AReport: TQRLCMREdeka; const AEmpresa, ATransportista:string );
begin
  AReport.QRMTransportista.Lines.Clear;
  AReport.QRMClausulas.Lines.Clear;

  if ( ATransportista <> '00' ) and ( ATransportista <> '0' ) then
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_transportistas where transporte_t = :transporte ');
    ParamByName('transporte').AsString:= ATransportista;
    try
      Open;
      if FieldByName('descripcion_t').AsString <> '' then
      begin
        if FieldByName('cif_t').AsString <> '' then
        begin
          AReport.QRMTransportista.Lines.Add( FieldByName('descripcion_t').AsString +
                                              '   CIF: ' + FieldByName('cif_t').AsString );
        end
        else
        begin
          AReport.QRMTransportista.Lines.Add( FieldByName('descripcion_t').AsString );
        end;
      end
      else
      begin
        if FieldByName('cif_t').AsString <> '' then
          AReport.QRMTransportista.Lines.Add( 'CIF: ' + FieldByName('cif_t').AsString );
      end;
      if FieldByName('direccion2_t').AsString <> '' then
      begin
        AReport.QRMTransportista.Lines.Add( FieldByName('direccion1_t').AsString );
        AReport.QRMTransportista.Lines.Add( FieldByName('direccion2_t').AsString );
      end
      else
      begin
        if FieldByName('direccion1_t').AsString <> '' then
          AReport.QRMTransportista.Lines.Add( FieldByName('direccion1_t').AsString );
      end;
      if FieldByName('telefono_t').AsString <> '' then
      begin
        if FieldByName('fax_t').AsString <> '' then
        begin
          AReport.QRMTransportista.Lines.Add( 'TELEFONO: ' + FieldByName('telefono_t').AsString +
                                              '   FAX: ' + FieldByName('fax_t').AsString );
        end
        else
        begin
          AReport.QRMTransportista.Lines.Add( 'TELEFONO: ' + FieldByName('telefono_t').AsString );
        end;
      end
      else
      begin
        if FieldByName('fax_t').AsString <> '' then
          AReport.QRMTransportista.Lines.Add( 'FAX: ' + FieldByName('fax_t').AsString );
      end;
      if FieldByName('notas_t').AsString <> '' then
        AReport.QRMClausulas.Lines.Add( FieldByName('notas_t').AsString );
    finally
      Close;
    end;
  end;
end;

procedure TQRLCMREdeka.DireccionCentroCMR( const AEmpresa, ACentro: string;
                             var ADireccion: TStringList; var APais, APoblacion: string );
var
  sAux: string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select case when empresa_e[1,1] = ''F'' then ''BONNYSA AGROALIMENTARIA'' else nombre_e end nombre_e, nif_e, ');
    SQL.Add('       descripcion_c, direccion_c, poblacion_c, cod_postal_c, descripcion_p ');
    SQL.Add('from frf_empresas, frf_centros, frf_paises  ');
    SQL.Add('where empresa_e = :empresa ');
    SQL.Add('and empresa_c = :empresa ');
    SQL.Add('and centro_c = :centro ');
    SQL.Add('and pais_p = pais_c');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    Open;

    ADireccion.Add( FieldByName('nombre_e').AsString + '  -  CIF: ' + FieldByName('nif_e').AsString);
    ADireccion.Add( FieldByName('descripcion_c').AsString);
    ADireccion.Add( FieldByName('direccion_c').AsString);
    sAux:= desProvincia( FieldByName('cod_postal_c').AsString );
    if sAux <> '' then
      ADireccion.Add( FieldByName('cod_postal_c').AsString + ' ' + FieldByName('poblacion_c').AsString +  '(' +  sAux + ')' )
    else
      ADireccion.Add( FieldByName('cod_postal_c').AsString + ' ' + FieldByName('poblacion_c').AsString );
    ADireccion.Add( APais );

    APoblacion:= FieldByName('poblacion_c').AsString;
    APais := FieldByName('descripcion_p').AsString;

    Close;
  end;
end;

procedure PreCMREdeka( const AEmpresa, ACentroSalida, ACliente: String;
                       const AAlbaran: integer;
                       const AFecha: TDateTime;
                       const CabCMR: RCabCMR );
var
  slAux: TStringList;
  sPais, sPoblacion: string;
  codAlbaran: string;
begin
  sEmpresa:= AEmpresa;
  sCentroSalida:= ACentroSalida;
  iAlbaran:= AAlbaran;
  dFecha:= AFecha;

  // Previsualización del segundo Informe para Salidas...
  with DMBaseDatos.QListado do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT fecha_sc, hora_sc, transporte_sc, vehiculo_sc, higiene_sc, nota_sc ');
    SQL.Add('FROM frf_salidas_c ' +
      'WHERE (empresa_sc = ' + QuotedStr( AEmpresa ) + ') ' +
      'And   (centro_salida_sc = ' + QuotedStr( ACentroSalida ) + ') ' +
      'And   (n_albaran_sc = ' + IntToStr( AAlbaran )  + ') ' +
      'And   (fecha_sc = :fecha ) ');
    ParamByName('fecha').asdatetime := AFecha;
    Open;

    // Definición de la dirección de Suministro de la Carta de Transporte...( C.M.R.)
    try
      QRLCMREdeka := TQRLCMREdeka.Create(Application);

      QRLCMREdeka.qrmConsignatario.Lines.Clear;
      QRLCMREdeka.qrmConsignatario.Lines.AddStrings( CabCMR.Consignatario );
      QRLCMREdeka.qrmEntrega.Lines.Clear;
      QRLCMREdeka.qrmEntrega.Lines.AddStrings( CabCMR.Entrega );
      QRLCMREdeka.qrmRemitente.Lines.Clear;
      QRLCMREdeka.qrmRemitente.Lines.AddStrings( CabCMR.Remitente );
      QRLCMREdeka.qrmCarga.Lines.Clear;
      QRLCMREdeka.qrmCarga.Lines.AddStrings( CabCMR.Carga );

      with DMBaseDatos.QAux do
      begin
        SQL.Clear;
        SQL.Add('select direccion_c, cod_postal_c, poblacion_c, pais_c ');
        SQL.Add('from frf_centros ');
        SQL.Add('where empresa_c = :empresa ');
        SQL.Add('and centro_c = :centro ');
        ParamByname('empresa').AsString:= sEmpresa;
        ParamByname('centro').AsString:= sCentroSalida;
        Open;
        QRLCMREdeka.qrlFormalizadoEn.Caption:= FieldByname('poblacion_c').AsString;
        QRLCMREdeka.qrlFormalizadoFecha.Caption:= DateToStr( dFecha );
        Close;
      end;

      QRLCMREdeka.LMatricula.Caption := FieldByName('vehiculo_sc').AsString;
      DatosTransportista( QRLCMREdeka, AEmpresa, FieldByName('transporte_sc').AsString );

      QRLCMREdeka.cmrObservaciones.Lines.Clear;


      if ( Copy( AEmpresa, 1, 1) = 'F' ) and ( ACliente <> 'ECI' ) then
      begin
        codAlbaran := AEmpresa + ACentroSalida + Rellena( IntToStr( AAlbaran ), 5, '0', taLeftJustify ) + Coletilla( AEmpresa );
      end
      else
      begin
        codAlbaran := IntToStr( AAlbaran );
      end;
      QRLCMREdeka.cmrObservaciones.Lines.Add('Nº ALBARÁN (Referenz): ' + codAlbaran );


      if FieldByName('higiene_sc').AsInteger = 1 then
      begin
        QRLCMREdeka.cmrObservaciones.Lines.Add('CONDICIONES HIGIENICAS (Hygienischen Bedingungen): OK ');
      end
      else
      begin
        QRLCMREdeka.cmrObservaciones.Lines.Add('CONDICIONES HIGIENICAS (Hygienischen Bedingungen): MALAS (BAD)');
      end;
      QRLCMREdeka.cmrObservaciones.Lines.Add( FieldByName('nota_sc').AsString );

      definirDetallesCMRInyeccion;

      QRLCMREdeka.ImprimirCMR( 'A'+IntToStr( AAlbaran ), 4, True, True, True );

    finally
      QRLCMREdeka.Free;
      Close;
    end;
  end;
end;

procedure TransportitaCasilla23( var AReport: TQRLCMREdeka; const AEmpresa, ATransportista:string );
begin
  AReport.qrmTransporte2.Lines.Clear;

  AReport.qrmTransporte2.Lines.Add( 'CARGADOR CONTRACTUAL:' );
  if ( ATransportista <> '00' ) and ( ATransportista <> '0' ) then
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_transportistas where transporte_t = :transporte ');
    ParamByName('transporte').AsString:= ATransportista;
    try
      Open;
      if FieldByName('descripcion_t').AsString <> '' then
      begin
        if Trim(FieldByName('cif_t').AsString) <> '' then
        begin
          AReport.qrmTransporte2.Lines.Add( FieldByName('descripcion_t').AsString +
                                              '   CIF: ' + FieldByName('cif_t').AsString );
        end
        else
        begin
          AReport.qrmTransporte2.Lines.Add( FieldByName('descripcion_t').AsString );
        end;
      end
      else
      begin
        if Trim(FieldByName('cif_t').AsString) <> '' then
          AReport.qrmTransporte2.Lines.Add( 'CIF: ' + FieldByName('cif_t').AsString );
      end;
      if FieldByName('direccion2_t').AsString <> '' then
      begin
        AReport.qrmTransporte2.Lines.Add( FieldByName('direccion1_t').AsString );
        AReport.qrmTransporte2.Lines.Add( FieldByName('direccion2_t').AsString );
      end
      else
      begin
        if FieldByName('direccion1_t').AsString <> '' then
          AReport.qrmTransporte2.Lines.Add( FieldByName('direccion1_t').AsString );
      end;
      if FieldByName('telefono_t').AsString <> '' then
      begin
        if FieldByName('fax_t').AsString <> '' then
        begin
          AReport.qrmTransporte2.Lines.Add( 'TELEFONO: ' + FieldByName('telefono_t').AsString +
                                              '   FAX: ' + FieldByName('fax_t').AsString );
        end
        else
        begin
          AReport.qrmTransporte2.Lines.Add( 'TELEFONO: ' + FieldByName('telefono_t').AsString );
        end;
      end
      else
      begin
        if FieldByName('fax_t').AsString <> '' then
          AReport.qrmTransporte2.Lines.Add( 'FAX: ' + FieldByName('fax_t').AsString );
      end;
    finally
      Close;
    end;
  end;
end;

procedure DatosTransportista( var AReport: TQRLCMREdeka; const AEmpresa, ATransportista:string );
begin
  if ( ( AEmpresa = '080' ) or  ( AEmpresa = '050' ) ) and ( ATransportista = '10' ) then
  begin
    //TransportitaCasilla16( AReport, AEmpresa, ATransportista );
    AReport.QRMTransportista.Lines.Clear;
    TransportitaCasilla23( AReport, AEmpresa, ATransportista );
  end
  else
  begin
    TransportitaCasilla16( AReport, AEmpresa, ATransportista );
    TransportitaCasilla23( AReport, AEmpresa, ATransportista );
  end;
end;

end.

