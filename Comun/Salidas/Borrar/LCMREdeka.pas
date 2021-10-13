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
    qrlFormalizadoEn: TQRLabel;
    lblNumeroPagina: TQRLabel;
    lblDescripcionHoja: TQRLabel;
    lblCodigoCmr: TQRLabel;
    QRMTransportista: TQRMemo;
    QRMClausulas: TQRMemo;
    QPesoPalet: TQuery;
    qrmEntrega: TQRMemo;
    qrmCarga: TQRMemo;
    qrlFormalizadoFecha: TQRLabel;
    qrmTransporte2: TQRMemo;
    QRImgFirma: TQRImage;
    qrmPalets: TQRMemo;
    QRImage: TQRImage;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure detallesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private

  public
    sFirma: string;
    procedure ImprimirCMR( const ACodigoCMR: string; const ACopias: integer;
                           const ARemitente, ADestino, ATransportista: boolean);
    procedure PreparaListado;

    constructor Create( AOwner: TComponent ); Override;

  end;

  procedure PreCMREdeka( const AEmpresa, ACentroSalida: String;
                       const AAlbaran: integer;
                       const AFecha: TDateTime;
                       const ACliente: string;
                       const CabCMR: RCabCMR );

var
  QRLCMREdeka: TQRLCMREdeka;

implementation

uses UDMBaseDatos, SysUtils, CVariables, UDMAuxDB, DError, DPreview, UDMConfig,
     Dialogs, bMath;

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

procedure TQRLCMREdeka.PreparaListado;
begin
  (*
  lblNumeroPagina.Enabled:= not bMatricial;
  lblDescripcionHoja.Enabled:= not bMatricial;
  lblCodigoCmr.Enabled:= not bMatricial;

  QRImage.Enabled:= not bMatricial;

  begin
    lblNumeroPagina.caption:= '';
    lblDescripcionHoja.caption:= '';
    lblCodigoCmr.caption:= '';

    qrmRazon.Top:= qrmRazon.Top - 50;
    qrmCliente.Top:= qrmCliente.Top - 50;
    qrmSuministro.Top:= qrmSuministro.Top - 50;
    qrmSalida.Top:= qrmSalida.Top - 50;
    QRMTransportista.Top:= QRMTransportista.Top - 50;
    LMatricula.Top:= LMatricula.Top - 50;
    marcas.Top:= marcas.Top - 50;
    cajas.Top:= cajas.Top - 50;
    agrupacion.Top:= agrupacion.Top - 50;
    producto.Top:= producto.Top - 50;
    volumen.Top:= volumen.Top - 50;
    cmrObservaciones.Top:= cmrObservaciones.Top - 50;
    QRMClausulas.Top:= QRMClausulas.Top - 50;
    qrlFormalizadoEn.Top:= qrlFormalizadoEn.Top - 50;
    qrlFormalizadoFecha.Top:= qrlFormalizadoFecha.Top - 50;
    QRImgFirma.Top:= QRImgFirma.Top - 50;
  end;
    *)
end;


procedure TQRLCMREdeka.ImprimirCMR( const ACodigoCMR: string; const ACopias: integer;
                                    const ARemitente, ADestino, ATransportista: boolean);
var
  i, iCopias, iAux: integer;
begin
  i:= 0;

  PreparaListado;
  //if not bMatricial then
  begin
    lblCodigoCMR.Caption:= 'Nº: ' + ACodigoCMR;

    DPreview.Imprimir:= False;
    iAux:= printerSettings.PrinterIndex;
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
      //if not bMatricial then
      begin
        lblNumeroPagina.Caption:= IntToStr(i);
        lblDescripcionHoja.Caption:= '';
      end;
      Print;
    end;
    printerSettings.PrinterIndex:= iAux;
  end;
  (*
  else
  begin
    iAux:= printerSettings.PrinterIndex;
    PrinterSettings.PrinterIndex := giPrintMatricial;
    Print;
    printerSettings.PrinterIndex:= iAux;
  end;
  *)
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
  end
  else
  begin
    QRImgFirma.Enabled:= False;
  end;
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
        '   AND  (empresa_e = :emp) ' +
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
var iPesoBruto, iPesoAux : Integer;
    iCajas, iPalets: Integer;
begin
  iPesobruto := 0;
  iCajas := 0;

   //Dejo en blanco los campos del Report
  QRLCMREdeka.marcas.Lines.Clear;
  QRLCMREdeka.cajas.Lines.Clear;
  QRLCMREdeka.agrupacion.Lines.Clear;
  QRLCMREdeka.producto.Lines.Clear;
  QRLCMREdeka.qrmPesoBruto.Lines.Clear;
  begin
    QRLCMREdeka.marcas.Lines.Add('Marke / Kat / Kaliber');
    QRLCMREdeka.cajas.Lines.Add('Kolli');
    QRLCMREdeka.agrupacion.Lines.Add('Format');
    //QRLCMREdeka.producto.Lines.Add('Format / Produkt / Herkunft');
    QRLCMREdeka.producto.Lines.Add('Produkt / Herkunft');
    QRLCMREdeka.qrmPesoBruto.Lines.Add('Bruttogewicht');
  end;


  with QRLCMREdeka.QDetallesCMR do
  begin
    try
      Close;

      SQL.Clear;
      SQl.Add(' SELECT cliente_sl, marca_sl, producto_sl, descripcion_m, envase_comercial_e, envase_sl, categoria_sl, calibre_sl, tipo_palets_sl, unidades_caja_sl, ' +
        '        SUM(n_palets_sl) palets, SUM(cajas_sl) cajas, SUM(cajas_sl*unidades_caja_sl) unidades, SUM(kilos_sl) pesoNetoProducto ' +
        ' FROM frf_salidas_l, OUTER frf_envases, OUTER frf_marcas ' +
        ' WHERE  (envase_sl = envase_e and empresa_e = :emp) ' +
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

      begin
        QRLCMREdeka.marcas.Lines.Add(FieldByName('descripcion_m').AsString + ' / Kat. ' + FieldByName('categoria_sl').AsString +
                                     ' / Kal. ' + FieldByName('calibre_sl').AsString  );
        QRLCMREdeka.producto.Lines.Add( desEnvaseClienteEx( sEmpresa, FieldByName('producto_sl').AsString, FieldByName('envase_sl').AsString,
                               FieldByName('cliente_sl').AsString, 0) + ' - SPANIEN ' );
      end;

        if (FieldByName('envase_comercial_e').AsString = 'S') then
        begin
          QRLCMREdeka.agrupacion.Lines.Add('KARTON');
        end
        else
        begin
          QRLCMREdeka.agrupacion.Lines.Add('EUROPOOL');
        end;

      iPesoAux:= Trunc( bRoundTo( FieldByName('pesoNetoProducto').AsFloat +
                GetPesoEnvases( FieldByName('cajas').AsString, FieldByName('unidades_caja_sl').AsString,  FieldByName('envase_sl').AsString ) +
                GetPesoPalets( FieldByName('palets').AsString, FieldByName('tipo_palets_sl').AsString), 0 ) );
      icajas := icajas + FieldByName('cajas').AsInteger;
      iPesoBruto := iPesobruto + iPesoAux;

      QRLCMREdeka.cajas.Lines.Add(FormatFloat('###,##0;-###,##0', FieldByName('cajas').AsInteger));
      QRLCMREdeka.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0.00;0', iPesoAux));

      Next;
    end;
    QRLCMREdeka.qrmPalets.Lines.Clear;
    QRLCMREdeka.qrmPalets.Lines.Add( IntToStr( iPalets ) + ' ' + desTipoPalet(FieldByName('tipo_palets_sl').AsString) );
    Close;

    QRLCMREdeka.cajas.Lines.Add('------------');
    QRLCMREdeka.cajas.Lines.Add(FormatFloat('###,##0;-###,##0', icajas));
    QRLCMREdeka.qrmPesoBruto.Lines.Add('------------');
    QRLCMREdeka.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', iPesoBruto));

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
    SQL.Add('select * from frf_transportistas where empresa_t = :empresa and transporte_t = :transporte ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('transporte').AsString:= ATransportista;
    try
      Open;
      if FieldByName('descripcion_t').AsString <> '' then
      begin
        if Trim(FieldByName('cif_t').AsString) <> '' then
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
        if Trim(FieldByName('cif_t').AsString) <> '' then
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

procedure TransportitaCasilla23( var AReport: TQRLCMREdeka; const AEmpresa, ATransportista:string );
begin
  AReport.qrmTransporte2.Lines.Clear;

  AReport.qrmTransporte2.Lines.Add( 'CARGADOR CONTRACTUAL:' );
  if ( ATransportista <> '00' ) and ( ATransportista <> '0' ) then
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_transportistas where empresa_t = :empresa and transporte_t = :transporte ');
    ParamByName('empresa').AsString:= AEmpresa;
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
    AReport.QRMTransportista.Lines.Clear;
    //TransportitaCasilla16( AReport, AEmpresa, ATransportista );
    TransportitaCasilla23( AReport, AEmpresa, ATransportista );
  end
  else
  begin
    TransportitaCasilla16( AReport, AEmpresa, ATransportista );
    TransportitaCasilla23( AReport, AEmpresa, ATransportista );
  end;
end;

procedure PreCMREdeka( const AEmpresa, ACentroSalida: String;
                       const AAlbaran: integer;
                       const AFecha: TDateTime;
                       const ACliente: string;
                       const CabCMR: RCabCMR );
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
    SQL.Add('SELECT hora_sc, transporte_sc, vehiculo_sc, higiene_sc, nota_sc ');
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
        QRLCMREdeka.cmrObservaciones.Lines.Add('REFERENZ : ' + IntToStr( AAlbaran ) );
        if FieldByName('higiene_sc').AsInteger = 1 then
        begin
          QRLCMREdeka.cmrObservaciones.Lines.Add('HYGIENISCHEN BEDINGUNGEN: OK ');
        end
        else
        begin
          QRLCMREdeka.cmrObservaciones.Lines.Add('HYGIENISCHEN BEDINGUNGEN: BAD');
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

end.

