unit LCMRInyeccion;

interface

uses Forms, Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, jpeg;
type
  TQRLCMRInyeccion = class(TQuickRep)
    detalles: TQRBand;
    fecha_sc: TQRDBText;
    cmrObservaciones: TQRMemo;
    marcas: TQRMemo;
    cajas: TQRMemo;
    agrupacion: TQRMemo;
    qrmPesoBruto: TQRMemo;
    producto: TQRMemo;
    LMatricula: TQRLabel;
    QDetallesCMR: TQuery;
    LOrigen2: TQRLabel;
    fecha_sc2: TQRDBText;
    QRImage: TQRImage;
    lblNumeroPagina: TQRLabel;
    lblDescripcionHoja: TQRLabel;
    lblCodigoCmr: TQRLabel;
    QRMTransportista: TQRMemo;
    QRMClausulas: TQRMemo;
    qNota: TQuery;
    QRImgFirma: TQRImage;
    qrmEntrega: TQRMemo;
    qrmByRemitente: TQRMemo;
    qrlblCasilla15: TQRLabel;
    qrmCarga: TQRMemo;
    qrmTransporte2: TQRMemo;
    qrmRemitente: TQRMemo;
    qrmConsignatario: TQRMemo;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);

  private

  public
    sFirma: string;
    
    procedure ImprimirCMR( const ACodigoCMR: string; const ACopias: integer;
                           const ARemitente, ADestino, ATransportista: boolean);

    procedure definirDetallesCMR(const AEmpresa, ACentro, AReferencia,
      AFecha: string);

    constructor Create( AOwner: TComponent ); Override;

    procedure ByRemitente( const ACliente: string );

  end;

var
  QRLCMR: TQRLCMRInyeccion;
  QRLCMRInyeccion: TQRLCMRInyeccion;

procedure DatosTransportista( var AReport: TQRLCMRInyeccion; const AEmpresa, ATransportista:string );

implementation

uses UDMBaseDatos, SysUtils, CVariables, UDMAuxDB, DError, DPreview,
  UDMConfig, bMath, UDMEnvases, UDMTransitos, UDMCmr;

{$R *.DFM}



constructor TQRLCMRInyeccion.Create( AOwner: TComponent );
begin
  inherited;
  QRImage.Picture.LoadFromFile(gsDirActual + '\recursos\cmr.jpg');
  QRImage.Refresh;
  Application.ProcessMessages;
end;

procedure TQRLCMRInyeccion.definirDetallesCMR(const AEmpresa, ACentro, AReferencia,
  AFecha: string);
var
  pesoBruto, pesoproducto: Extended;
  cajas, pesoBrutoTotal, cajasTotal, iAux: integer;
  marca, producto, envase, env_comer: string;
  i, iArray, iAuxPro, pesoBrutoAux: integer;
  descripcion, ingles: string;
  Array_dinamico: array of Integer;
begin
  marca := '';
  producto := '';
  envase := '';
  env_comer := '';
  pesobruto := 0;
  cajas := 0;
  pesoBrutoTotal:= 0;
  cajasTotal:= 0;

   //Dejo en blanco los campos del Report
  QRLCMR.marcas.Lines.Clear;
  QRLCMR.cajas.Lines.Clear;
  QRLCMR.agrupacion.Lines.Clear;
  QRLCMR.producto.Lines.Clear;
  QRLCMR.qrmPesoBruto.Lines.Clear;

  with QDetallesCMR do
  begin
    SQL.Clear;

    SQL.Add(' SELECT marca_tl, producto_tl, descripcion_m, envase_comercial_e, envase_tl, tipo_palet_tl, ');
    SQL.Add('        categoria_tl,color_tl,calibre_tl, unidades_caja_tl,');
    SQL.Add('        SUM(cajas_tl) cajas, SUM(kilos_tl) pesoNetoProducto, sum( palets_tl ) palets ');
    SQL.Add(' FROM Frf_transitos_l, OUTER Frf_envases, OUTER Frf_marcas ');
    SQL.Add(' WHERE  (envase_tl = envase_e and empresa_e = :emp ) ');
    SQL.Add('    AND  (marca_tl = codigo_m) ');
    SQL.Add('    AND  ( (empresa_tl =:emp) ');
    SQL.Add('    AND  (centro_tl = :cen) ');
    SQL.Add('    AND  (referencia_tl = :alb) ');
    SQL.Add('    AND  (fecha_tl =:fec) ) ');
    SQL.Add(' GROUP BY marca_tl, descripcion_m, envase_comercial_e, producto_tl,envase_tl, tipo_palet_tl, ');
    SQL.Add('          categoria_tl,color_tl,calibre_tl, unidades_caja_tl');
    SQL.Add(' ORDER BY descripcion_m, envase_comercial_e, producto_tl ');
    try
      Close;
      ParamByName('emp').AsString := AEmpresa;
      ParamByName('cen').AsString := ACentro;
      ParamByName('alb').AsString := AReferencia;
      ParamByName('fec').AsDatetime := StrToDate(AFecha);
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        Exit;
      end;
    end;
    First;
     //le paso los datos al report y me quedo con los datos que agrupan
    QRLCMR.marcas.Lines.Add(FieldByName('descripcion_m').AsString);
     //QRLCMR.cajas.Lines.Add(FormatFloat('###,##0;-###,##0',FieldByName('cajas').AsFloat));
    if (FieldByName('envase_comercial_e').AsString = 'S') then
      QRLCMR.agrupacion.Lines.Add('CARTÓN')
    else QRLCMR.agrupacion.Lines.Add('PT.RECICLABLE');

    if UDMCmr.DMCmr.esTomate(AEmpresa, FieldByName('producto_tl').AsString, descripcion, ingles) then
    begin
      QRLCMR.producto.Lines.Add('TOMATE (' + FieldByName('producto_tl').AsString + ')');
    end
    else
    begin
      QRLCMR.producto.Lines.Add(descripcion + ' (' + FieldByName('producto_tl').AsString + ')');
    end;

    marca := FieldByName('marca_tl').AsString;
    env_comer := FieldByName('envase_comercial_e').AsString;
    producto := FieldByName('producto_tl').AsString;
     ///////////////////////////////////////////////////////////////////////////
    iArray:= 1;
    for i := 1 to RecordCount do
    begin

      if (marca <> FieldByName('marca_tl').AsString) or
        (producto <> FieldByName('producto_tl').AsString) or
        (env_comer <> FieldByName('envase_comercial_e').AsString) then
      begin
            //guardar los campos por los que se agrupa
        marca := FieldByName('marca_tl').AsString;
        env_comer := FieldByName('envase_comercial_e').AsString;
        producto := FieldByName('producto_tl').AsString;

            //Pasar los valores al Report
        QRLCMR.marcas.Lines.Add(FieldByName('descripcion_m').AsString);
        QRLCMR.cajas.Lines.Add(FormatFloat('###,##0;-###,##0', cajas));
        if (FieldByName('envase_comercial_e').AsString = 'S') then
          QRLCMR.agrupacion.Lines.Add('CARTÓN')
        else QRLCMR.agrupacion.Lines.Add('PT.RECICLABLE');

        if UDMCmr.DMCmr.esTomate(AEmpresa, FieldByName('producto_tl').AsString, descripcion, ingles) then
        begin
          QRLCMR.producto.Lines.Add('TOMATE (' + FieldByName('producto_tl').AsString + ')');
        end
        else
        begin
          QRLCMR.producto.Lines.Add(descripcion + ' (' + FieldByName('producto_tl').AsString + ')');
        end;

        iAux:= Trunc( bRoundTo( pesoBruto, 0 ) );
        pesoBrutoTotal:= pesoBrutoTotal + iAux;
        cajasTotal:= cajasTotal + Cajas;
        QRLCMR.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', iAux));
        SetLength(Array_dinamico, iArray);
        Array_dinamico[iArray-1]:= iAux;
        Inc( iArray );
        Cajas := 0;
        PesoBruto := 0;
      end;
      if (FieldByName('pesoNetoProducto').AsString <> '') then
        pesoProducto := FieldByName('pesoNetoProducto').AsFloat
      else pesoProducto := 0;
      pesoBruto := pesobruto + pesoProducto +
                  ( FieldByName('cajas').AsFloat *  DMEnvases.GetPesoEnvase(AEmpresa, FieldByName('envase_tl').AsString,StrToDate(AFecha)) );
      if ( FieldByName('palets').AsFloat <> 0 ) and  ( FieldByName('tipo_palet_tl').AsString <> '' ) then
      begin
        pesoBruto := pesobruto + ( FieldByName('palets').AsFloat *  DMEnvases.GetPesoPalet( FieldByName('tipo_palet_tl').AsString) );
      end;
      cajas := cajas + FieldByName('cajas').AsInteger;
      Next;
    end;
    iAux:= Trunc( bRoundTo( pesoBruto, 0 ) );
    pesoBrutoTotal:= pesoBrutoTotal + iAux;
    cajasTotal:= cajasTotal + Cajas;
    QRLCMR.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', iAux));
    QRLCMR.cajas.Lines.Add(FormatFloat('###,##0;-###,##0', cajas));
    SetLength(Array_dinamico, iArray);
    Array_dinamico[iArray-1]:= iAux;

    iAuxPro:= DMTransitos.PesosBrutoDeposito( AEmpresa, ACentro, StrToInt( AReferencia), strToDateTime( AFecha ) );
    if ( iAuxPro <> 0 ) and ( iAuxPro <> pesoBrutoTotal ) then
    begin
      QRLCMR.qrmPesoBruto.Lines.Clear;
      pesoBrutoAux:= 0;
      for i:= 0 to iArray-2 do
      begin
        Array_dinamico[i]:= Trunc( ( Array_dinamico[i] * iAuxPro ) / pesoBrutoTotal );
        QRLCMR.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', Array_dinamico[i]));
        pesoBrutoAux:= pesoBrutoAux + Array_dinamico[i];
      end;
      QRLCMR.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', iAuxPro-pesoBrutoAux));
      pesoBrutoTotal:= iAuxPro;
    end;
    QRLCMR.qrmPesoBruto.Lines.Add('-------');
    QRLCMR.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', pesoBrutoTotal));
    QRLCMR.cajas.Lines.Add('-------');
    QRLCMR.cajas.Lines.Add(FormatFloat('###,##0;-###,##0', cajasTotal));
    QDetallesCMR.Close;
  end;
end;


procedure TQRLCMRInyeccion.ImprimirCMR( const ACodigoCMR: string; const ACopias: integer;
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

procedure TransportitaCasilla16( var AReport: TQRLCMRInyeccion; const AEmpresa, ATransportista:string );
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

procedure TransportitaCasilla23( var AReport: TQRLCMRInyeccion; const AEmpresa, ATransportista:string );
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


procedure TQRLCMRInyeccion.QuickRepBeforePrint(Sender: TCustomQuickRep;
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
    QRImgFirma.Enabled:= false;
  end;
  qrlblCasilla15.Enabled:= False;
end;

procedure TQRLCMRInyeccion.ByRemitente( const ACliente: string );
begin
  qrmByRemitente.Lines.Clear;
  if ACliente = 'BAI' then
  begin
    qrmByRemitente.Font.Size:= 7;
    qrmByRemitente.Left:= 230;
    qrmByRemitente.Enabled:= True;
    qrmByRemitente.Lines.Add('by order:  ELGH K/S ');
    qrmByRemitente.Lines.Add('  Lergravsvej 53 ');
    qrmByRemitente.Lines.Add('  2300 Copenhagen S ');
    qrmByRemitente.Lines.Add('  Denmark ');
    qrlblCasilla15.Enabled:= False;
  end
  else
  if ACliente = 'BEY' then
  begin
    qrmEntrega.Font.Size:= 6;
    qrmByRemitente.Font.Size:= 7;
    qrmByRemitente.Left:= 230;
    qrmByRemitente.Enabled:= True;
    qrmByRemitente.Lines.Clear;
    qrmByRemitente.Lines.Add('by order of "FRUITCOM Inc."');
    qrmByRemitente.Lines.Add('  Contract Nº FC-11/06.09 ');
    qrmByRemitente.Lines.Add('  OT 01.07.2009 ');
    qrlblCasilla15.Enabled:= True;
  end
  else
  if ACliente = 'UKT' then
  begin
    qrmByRemitente.Font.Size:= 6;
    qrmByRemitente.Left:= 210;
    qrmByRemitente.Enabled:= True;
    qrmByRemitente.Lines.Clear;
    qrmByRemitente.Lines.Add('By order "TAVITON COMMERCIAL LTD" ');
    qrmByRemitente.Lines.Add('Craigmuir Chambers, Road Town, B.V.I. ');
    qrmByRemitente.Lines.Add('Contrat Nr:1506/12 from 15.06.2012 ');
    qrlblCasilla15.Enabled:= False;
  end
  else
  begin
    qrmByRemitente.Enabled:= False;
    qrlblCasilla15.Enabled:= False;
  end;
end;

procedure DatosTransportista( var AReport: TQRLCMRInyeccion; const AEmpresa, ATransportista:string );
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

