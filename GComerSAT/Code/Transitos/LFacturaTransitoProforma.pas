unit LFacturaTransitoProforma;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, jpeg, Grids, DB, DBTables;

type
  TQRLFacturaTransitoProforma = class(TQuickRep)
    BandaTotales: TQRBand;
    CabeceraTabla: TQRChildBand;
    PsQRShape29: TQRShape;
    PsQRShape33: TQRShape;
    PsQRShape34: TQRShape;
    PsQRShape35: TQRShape;
    PsQRShape36: TQRShape;
    PsQRLabel22: TQRLabel;
    PsQRLabel23: TQRLabel;
    PsQRLabel27: TQRLabel;
    PsQRLabel28: TQRLabel;
    PsQRLabel29: TQRLabel;
    PsQRLabel30: TQRLabel;
    neto: TQRLabel;
    total: TQRLabel;
    Rtotal: TQRShape;
    Rneto: TQRShape;
    QRChildBand1: TQRChildBand;
    PsQRShape8: TQRShape;
    PsQRShape9: TQRShape;
    CabeceraFactura: TQRGroup;
    PsQRShape1: TQRShape;
    PsQRShape16: TQRShape;
    PsQRLabel6: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRShape20: TQRShape;
    PsQRShape23: TQRShape;
    PsQRShape22: TQRShape;
    PsQRShape18: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    PsQRLabel9: TQRLabel;
    PsQRShape7: TQRShape;
    BandaLinea: TQRSubDetail;
    lin2: TQRShape;
    lin5: TQRShape;
    lin6: TQRShape;
    lin7: TQRShape;
    lin8: TQRShape;
    Lneto: TQRLabel;
    Ltotal: TQRLabel;
    moneda1: TQRLabel;
    producto: TQRLabel;
    envase: TQRLabel;
    lbImporte: TQRLabel;
    clienteFacturacion: TQRMemo;
    moneda3: TQRLabel;
    BonnyBand: TQRBand;
    QRImageCab: TQRImage;
    PsEmpresa: TQRLabel;
    PsDireccion: TQRLabel;
    PsNif: TQRLabel;
    QRShape1: TQRShape;
    QDatos: TQuery;
    referencia_tc: TQRDBText;
    fecha_facontrol_tc: TQRDBText;
    fecha_carga_tc: TQRDBText;
    kilos_tc: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    vehiculo_tc: TQRDBText;
    buque_tc: TQRDBText;
    transporte_tc: TQRDBText;
    QRLabel3: TQRLabel;
    puerto_tc: TQRDBText;
    puerto_tc_: TQRDBText;
    precio_facontrol_tc: TQRDBText;
    QRLabel4: TQRLabel;
    qrlblDesPalets: TQRLabel;
    qrlblDesCajas: TQRLabel;
    qrlblNumPalets: TQRLabel;
    qrlblNumCajas: TQRLabel;
    qrlblPesoPalets: TQRLabel;
    qrlblPesoCajas: TQRLabel;
    qrlblUndFacPalets: TQRLabel;
    qrlblPrecioCajas: TQRLabel;
    qrlblPrecioPalets: TQRLabel;
    qrlblUndFacCajas: TQRLabel;
    qrlblImpPalets: TQRLabel;
    qrlblImpCajas: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrshp1: TQRShape;
    qrsIncoterm: TQRShape;
    qrlIncotermLabel: TQRLabel;
    qrlIncoterm: TQRLabel;
    procedure transporte_tcPrint(sender: TObject; var Value: String);
    procedure lbImportePrint(sender: TObject; var Value: String);
    procedure netoPrint(sender: TObject; var Value: String);
    procedure totalPrint(sender: TObject; var Value: String);
    procedure puerto_tcPrint(sender: TObject; var Value: String);
    procedure puerto_tc_Print(sender: TObject; var Value: String);
    procedure envasePrint(sender: TObject; var Value: String);
    procedure productoPrint(sender: TObject; var Value: String);
    procedure CabeceraFacturaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);


  private
    sEmpresa, sCentro: String;
    iReferencia: Integer;
    dFecha: TDateTime;

    rImporte, rImportePlas: real;

    function PutPaletsPlastico: real;
    function PutCajasPlastico: real;
  public
    function SeleccionarDatos( const AEmpresa, ACentro: String;
             const AReferencia: Integer; const AFecha: TDateTime ): boolean;
    procedure DireccionFactura( const AEmpresa: string );
    procedure Configurar(const AEmpresa: string);
  end;


  function PreviewFactura( const AOwner: TComponent; const AEmpresa, ACentro: String;
             const AReferencia: Integer; const AFecha: TDateTime ): boolean;

implementation

uses UDMAuxDB, CVariables, UDMConfig, DPreview, bMath;

{$R *.DFM}

var
  QRLFacturaTransitoProforma: TQRLFacturaTransitoProforma;

function PreviewFactura( const AOwner: TComponent; const AEmpresa, ACentro: String;
           const AReferencia: Integer; const AFecha: TDateTime ): boolean;
begin
  result:= false;
  QRLFacturaTransitoProforma:= TQRLFacturaTransitoProforma.Create( AOwner );
  try
    if QRLFacturaTransitoProforma.SeleccionarDatos( AEmpresa, ACentro, AReferencia, AFecha ) then
    begin
      QRLFacturaTransitoProforma.Configurar( AEmpresa );
      QRLFacturaTransitoProforma.DireccionFactura( AEmpresa );
      DPreview.Preview( QRLFacturaTransitoProforma );
    end
    else
    begin
      result:= True;
      FreeAndNil( QRLFacturaTransitoProforma );
    end;
  except
    FreeAndNil( QRLFacturaTransitoProforma );
    raise;
  end;
end;

procedure TQRLFacturaTransitoProforma.CabeceraFacturaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
    //Incoterm
  if QDatos.FieldByName('incoterm_tc').AsString = '' then
  begin
    qrsIncoterm.Enabled:= False;
    qrlIncotermLabel.Enabled:= False;
    qrlIncoterm.Enabled:= False;
  end
  else
  begin
    qrsIncoterm.Enabled:= True;
    qrlIncotermLabel.Enabled:= True;
    qrlIncoterm.Enabled:= True;
    qrlIncoterm.Caption:= QDatos.FieldByName('incoterm_tc').AsString + ' ' +
                          QDatos.FieldByName('plaza_incoterm_tc').AsString;
  end;

end;

procedure TQRLFacturaTransitoProforma.Configurar(const AEmpresa: string);
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

function CompletaNif( const APais, ANif: string ): string;
begin
  if Pos( APais, ANif ) = 0 then
    Result:= APais + ANif
  else
    Result:= ANif;
end;

procedure TQRLFacturaTransitoProforma.DireccionFactura( const AEmpresa: string );
var
  sCodProvincia: string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nombre_e, nif_e, tipo_via_e, domicilio_e, cod_postal_e, poblacion_e ');
    SQL.Add(' from frf_empresas ');
    SQL.Add(' where empresa_e = :empresa ');
    ParamByName('empresa').AsString:= AEmpresa;
    Open;
    clienteFacturacion.Lines.Clear;
    clienteFacturacion.Lines.Add( FieldByName('nombre_e').AsString );
    clienteFacturacion.Lines.Add( 'CF. ' + CompletaNif( 'ES', FieldByName('nif_e').AsString ) );
    clienteFacturacion.Lines.Add( Trim( FieldByName('tipo_via_e').AsString + ' ' +
                                        FieldByName('domicilio_e').AsString ) );
    clienteFacturacion.Lines.Add( Trim( FieldByName('cod_postal_e').AsString + ' ' +
                                        FieldByName('poblacion_e').AsString ) );
    sCodProvincia:= Copy( FieldByName('cod_postal_e').AsString, 1, 2 );
    Close;

    SQL.Clear;
    SQL.Add(' select nombre_p ');
    SQL.Add(' from frf_provincias ');
    SQL.Add(' where codigo_p = :codigo ');
    ParamByName('codigo').AsString:= sCodProvincia;
    Open;
    clienteFacturacion.Lines.Add( FieldByName('nombre_p').AsString );
    Close;
  end;
end;

function TQRLFacturaTransitoProforma.SeleccionarDatos( const AEmpresa, ACentro: String;
           const AReferencia: Integer; const AFecha: TDateTime ): boolean;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iReferencia:= AReferencia;
  dFecha:= AFecha;

  with QDatos do
  begin
    if AEmpresa = '050' then
    begin
      SQL.Clear;
      SQL.Add('select empresa_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc,');
      SQL.Add('       fecha_facontrol_tc, precio_facontrol_tc, precio_palet_plas_tc, precio_caja_plas_tc, ');
      SQL.Add('       incoterm_tc, plaza_incoterm_tc, sum( kilos_tl ) kilos_tc');

      SQL.Add('from frf_transitos_c, frf_transitos_l');

      SQL.Add('where empresa_tc = :empresa');
      SQL.Add('and centro_tc = :centro');
      SQL.Add('and referencia_tc = :referencia');
      SQL.Add('and fecha_tc = :fecha');

      SQL.Add('and empresa_tl = :empresa');
      SQL.Add('and centro_tl = :centro');
      SQL.Add('and referencia_tl = :referencia');
      SQL.Add('and fecha_tl = :fecha');

      SQL.Add('group by empresa_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc,');
      SQL.Add('       fecha_facontrol_tc, precio_facontrol_tc, precio_palet_plas_tc, precio_caja_plas_tc, ');
      SQL.Add('       incoterm_tc, plaza_incoterm_tc ');
    end
    else
    begin
      SQL.Clear;
      SQL.Add('select empresa_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc,');
      SQL.Add('       fecha_facontrol_tc, precio_facontrol_tc, precio_palet_plas_tc, precio_caja_plas_tc, ');
      SQL.Add('       incoterm_tc, plaza_incoterm_tc, ');

      SQL.Add('       case when descripcion_p like ''%PIMIENTO%'' then ''PIMIENTOS'' else descripcion_p end producto, ');

      SQL.Add('       max(nvl(tipo_caja_e,'''')) tipo_caja, sum( kilos_tl ) kilos_tc');

      SQL.Add('from frf_transitos_c, frf_transitos_l, frf_productos, frf_envases');

      SQL.Add('where empresa_tc = :empresa');
      SQL.Add('and centro_tc = :centro');
      SQL.Add('and referencia_tc = :referencia');
      SQL.Add('and fecha_tc = :fecha');

      SQL.Add('and empresa_tl = empresa_tc');
      SQL.Add('and centro_tl = centro_tc');
      SQL.Add('and referencia_tl = referencia_tc');
      SQL.Add('and fecha_tl = fecha_tc');

      SQL.Add('and producto_tl = producto_p');

      SQL.Add('and envase_e = envase_tl ');

      SQL.Add('group by empresa_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc,');
      SQL.Add('       fecha_facontrol_tc, precio_facontrol_tc, producto, precio_palet_plas_tc, precio_caja_plas_tc,');
      SQL.Add('       incoterm_tc, plaza_incoterm_tc ');
    end;


    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('referencia').AsInteger:= AReferencia;
    ParamByName('fecha').AsDate:= AFecha;

    Open;

    result:= not IsEmpty;
  end;
  if result then
  begin
    rImportePlas:= PutPaletsPlastico;
    rImportePlas:= rImportePlas + PutCajasPlastico;
    if rImportePlas <> 0 then
    begin
      qrlbl2.enabled:= True;
      qrshp1.enabled:= True;
      qrlbl1.enabled:= True;
      qrlbl1.caption:= FormatFloat('#,##0.00', rImportePlas);
    end
    else
    begin
      qrlbl2.enabled:= False;
      qrshp1.enabled:= False;
      qrlbl1.enabled:= False;
    end;
  end;
end;

procedure TQRLFacturaTransitoProforma.transporte_tcPrint(sender: TObject;
  var Value: String);
begin
  Value:= desTransporte( sEmpresa, Value );
end;

procedure TQRLFacturaTransitoProforma.lbImportePrint(sender: TObject;
  var Value: String);
begin
  rImporte:= QDatos.FieldByname('kilos_tc').AsFloat *
             QDatos.FieldByname('precio_facontrol_tc').AsFloat;
  Value:= FormatFloat( '#,##0.00', rImporte );
end;

procedure TQRLFacturaTransitoProforma.netoPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rImporte + rImportePlas);
end;

procedure TQRLFacturaTransitoProforma.totalPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rImporte + rImportePlas);
end;

procedure TQRLFacturaTransitoProforma.puerto_tcPrint(sender: TObject;
  var Value: String);
begin
  {ROSANA - Dic 2008 - Siempre se pone ALICANTE*}
  //Value:= 'DDP ' + 'ALICANTE';
  {ROSANA - May 2011 - Siempre se pone ALICANTE*}
  //Value:= 'DDP ' + 'ALICANTE';
  {ROSANA - JULIO 2011 - CAMBIO TEMPORAL        }
  //Value:= 'DDP ' + desAduana( Value );
  {ROSANA - OBTUBRE 2011 - CAMBIO TEMPORAL        }
  //Value:= 'DAT  DDA ESIC03001001';
   {ROSANA - DICIEMBRE 2011 - CAMBIO TEMPORAL        }
 {ROSANA - FEBRERO 2012 - CAMBIO PARA TRANSITOS FRUTA        }
 {ROSANA - JUNIO 2014 - CAMBIO PARA TRANSITOS FRUTA        }
  //Value:= 'DAP  DDA ESIC03001001'
  if sEmpresa =  '050' then
  begin
    if dFecha > StrToDate('6/6/2014') then
      //Value:= 'DAP  ALICANTE'
      //Value:= 'DAP  ' + desAduana( Value )
      Value:= Value
    else
      Value:= 'DAP  DDA ESIC03001001';
  end
  else
  begin
    Value:= 'DAP  ALICANTE';
  end;
end;

procedure TQRLFacturaTransitoProforma.puerto_tc_Print(sender: TObject;
  var Value: String);
begin
  Value:= 'PUERTO DESTINO : ' + desAduana( Value );
end;

procedure TQRLFacturaTransitoProforma.envasePrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('empresa_tc').AsString = '050' then
  begin
    Value:= 'CARTON 6 KGS';
  end
  else
  begin
    (*
    Value:= desEnvase( DataSet.FieldByName('empresa_tc').AsString,
                         DataSet.FieldByName('envase_tl').AsString)
    *)
    Value:= desTipoCaja( DataSet.FieldByName('tipo_caja').AsString );
  end;
end;

procedure TQRLFacturaTransitoProforma.productoPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('empresa_tc').AsString = '050' then
  begin
    Value:= 'TOMATES FRESCOS';
  end
  else
  begin
    (*
    Value:= desProducto( DataSet.FieldByName('empresa_tc').AsString,
                         DataSet.FieldByName('producto_tl').AsString)
    *)
    Value:= DataSet.FieldByName('producto').AsString;
  end;
end;

function TQRLFacturaTransitoProforma.PutPaletsPlastico: real;
var
  rPrecio,rPalets,rPeso: extended;
begin
  rPrecio:= QDatos.FieldByname('precio_palet_plas_tc').AsFloat;
  if rPrecio <> 0 then
  begin
    with DMAuxDB.QAux do
    begin
      SQl.clear;
      SQL.Add(' select sum(nvl(palets_tl,0)) palets, sum(nvl(palets_tl,0) * nvl(kilos_tp,0)) peso_palets ');
      SQL.Add(' from frf_transitos_l ');
      SQL.Add('      join frf_tipo_palets on codigo_tp = tipo_palet_Tl ');
      SQL.Add(' where empresa_tl = :empresa ');
      SQL.Add(' and centro_tl = :centro ');
      SQL.Add(' and fecha_tl = :fecha ');
      SQL.Add(' and referencia_tl = :referencia ');
      SQL.Add(' and palet_plastico_tp = 1 ');
      ParamByName('empresa').AsString:= sEmpresa;
      ParamByName('centro').AsString:= sCentro;
      ParamByName('referencia').AsInteger:= iReferencia;
      ParamByName('fecha').AsDateTime:= dFecha;
      Open;

      rPalets:= FieldByName('palets').AsFloat;
      rPeso:= FieldByName('peso_palets').AsFloat;
      result:= bRoundTo( rPalets * rPrecio, 2 );

      Close;
    end;
  end
  else
  begin
    rPalets:= 0;
    rPeso:= 0;
    result:= 0;
  end;

  if result = 0 then
  begin
    qrlblDesPalets.Enabled:= False;
    qrlblUndFacPalets.Enabled:= False;
    qrlblNumPalets.Enabled:= False;
    qrlblPesoPalets.Enabled:= False;
    qrlblPrecioPalets.Enabled:= False;
    qrlblImpPalets.Enabled:= False;
  end
  else
  begin
    qrlblDesPalets.Enabled:= True;
    qrlblUndFacPalets.Enabled:= True;
    qrlblNumPalets.Enabled:= True;
    qrlblPesoPalets.Enabled:= True;
    qrlblPrecioPalets.Enabled:= True;
    qrlblImpPalets.Enabled:= True;

    qrlblNumPalets.Caption:= FormatFloat('#,##0', rPalets);
    qrlblPesoPalets.Caption:= FormatFloat('#,##0',rPeso);
    qrlblPrecioPalets.Caption:= FormatFloat('#,##0.000', rPrecio);
    qrlblImpPalets.Caption:= FormatFloat('#,##0.00', resulT);
  end;
end;

function TQRLFacturaTransitoProforma.PutCajasPlastico: real;
var
  rPrecio,rCajas,rPeso: extended;
begin
  rPrecio:= QDatos.FieldByname('precio_caja_plas_tc').AsFloat;
  if rPrecio <> 0 then
  begin
    with DMAuxDB.QAux do
    begin
      SQl.clear;
      SQL.Add(' select sum(nvl(cajas_tl,0)) cajas, sum(nvl(cajas_tl,0) * nvl(peso_envase_e,0)) peso_envases ');
      SQL.Add(' from frf_transitos_l ');
      SQL.Add('      join frf_envases on envase_tl = envase_E ');
      SQL.Add(' where empresa_tl = :empresa ');
      SQL.Add(' and centro_tl = :centro ');
      SQL.Add(' and fecha_tl = :fecha ');
      SQL.Add(' and referencia_tl = :referencia ');
      SQL.Add(' and envase_comercial_e = ''N'' ');
      SQL.Add(' and env_comer_operador_e IS NULL ');        // Calcular solo para envases en Propiedad (No Retornables)
      ParamByName('empresa').AsString:= sEmpresa;
      ParamByName('centro').AsString:= sCentro;
      ParamByName('referencia').AsInteger:= iReferencia;
      ParamByName('fecha').AsDateTime:= dFecha;
      Open;

      rCajas:= FieldByName('cajas').AsFloat;
      rPeso:= FieldByName('peso_envases').AsFloat;
      result:= bRoundTo( rCajas * rPrecio, 2 );

      Close;
    end;
  end
  else
  begin
    rCajas:= 0;
    rPeso:= 0;
    result:= 0;
  end;

  if result = 0 then
  begin
    qrlblDesCajas.Enabled:= False;
    qrlblUndFacCajas.Enabled:= False;
    qrlblNumCajas.Enabled:= False;
    qrlblPesoCajas.Enabled:= False;
    qrlblPrecioCajas.Enabled:= False;
    qrlblImpCajas.Enabled:= False;
  end
  else
  begin
    qrlblDesCajas.Enabled:= True;
    qrlblUndFacCajas.Enabled:= True;
    qrlblNumCajas.Enabled:= True;
    qrlblPesoCajas.Enabled:= True;
    qrlblPrecioCajas.Enabled:= True;
    qrlblImpCajas.Enabled:= True;

    qrlblNumCajas.Caption:= FormatFloat('#,##0', rCajas);
    qrlblPesoCajas.Caption:= FormatFloat('#,##0',rPeso);
    qrlblPrecioCajas.Caption:= FormatFloat('#,##0.000', rPrecio);
    qrlblImpCajas.Caption:= FormatFloat('#,##0.00', resulT);
  end;
end;


end.

