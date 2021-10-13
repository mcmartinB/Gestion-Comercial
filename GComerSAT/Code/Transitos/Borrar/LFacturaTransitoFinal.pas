unit LFacturaTransitoFinal;


interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, jpeg, Grids, DB, DBTables;

type
  TQRLFacturaTransitoFinal = class(TQuickRep)
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
    qrlPrecio: TQRLabel;
    procedure transporte_tcPrint(sender: TObject; var Value: String);
    procedure lbImportePrint(sender: TObject; var Value: String);
    procedure netoPrint(sender: TObject; var Value: String);
    procedure totalPrint(sender: TObject; var Value: String);
    procedure puerto_tcPrint(sender: TObject; var Value: String);
    procedure puerto_tc_Print(sender: TObject; var Value: String);
    procedure qrlPrecioPrint(sender: TObject; var Value: String);
    procedure productoPrint(sender: TObject; var Value: String);
    procedure envasePrint(sender: TObject; var Value: String);
  private
    sEmpresa: String;
    dFecha: TDateTime;
    rKilos, rImporte, rPrecio: real;

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
  QRLFacturaTransitoFinal: TQRLFacturaTransitoFinal;

function PreviewFactura( const AOwner: TComponent; const AEmpresa, ACentro: String;
           const AReferencia: Integer; const AFecha: TDateTime ): boolean;
begin
  result:= false;
  QRLFacturaTransitoFinal:= TQRLFacturaTransitoFinal.Create( AOwner );
  try
    if QRLFacturaTransitoFinal.SeleccionarDatos( AEmpresa, ACentro, AReferencia, AFecha ) then
    begin
      QRLFacturaTransitoFinal.dFecha:= AFecha;
      QRLFacturaTransitoFinal.Configurar( AEmpresa );
      QRLFacturaTransitoFinal.DireccionFactura( AEmpresa );
      DPreview.Preview( QRLFacturaTransitoFinal );
    end
    else
    begin
      result:= True;
      FreeAndNil( QRLFacturaTransitoFinal );
    end;
  except
    FreeAndNil( QRLFacturaTransitoFinal );
    raise;
  end;
end;

procedure TQRLFacturaTransitoFinal.Configurar(const AEmpresa: string);
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

procedure TQRLFacturaTransitoFinal.DireccionFactura( const AEmpresa: string );
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

function TQRLFacturaTransitoFinal.SeleccionarDatos( const AEmpresa, ACentro: String;
           const AReferencia: Integer; const AFecha: TDateTime ): boolean;
var
  rPrecioFijo, rCosteLinea: real;
begin
  with QDatos do
  begin
    if AEmpresa = '050' then
    begin
      SQL.Clear;
      SQL.Add('select empresa_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc,');
      SQL.Add('       fecha_facontrol_tc, sum( kilos_tl ) kilos_tc');

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
      SQL.Add('       fecha_facontrol_tc');
    end
    else
    begin
      SQL.Clear;
      SQL.Add('select empresa_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc,');
      SQL.Add('       fecha_facontrol_tc, producto_tl, envase_tl, sum( kilos_tl ) kilos_tc');

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
      SQL.Add('       fecha_facontrol_tc, producto_tl, envase_tl ');
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
    rKilos:= QDatos.FieldByName('kilos_tc').AsFloat;
    if rKilos > 0 then
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add(' select importe_fijo_dai, coste_salida_dai ');
      SQL.Add(' from frf_depositos_aduana_importes ');
      SQL.Add(' where empresa_dai = :empresa ');
      SQL.Add(' and :fecha between fecha_ini_dai and nvl(fecha_fin_dai,TODAY) ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('fecha').AsDate:= QDatos.FieldByName('fecha_facontrol_tc').AsDateTime;
      Open;
      if not IsEmpty then
      begin
        rPrecioFijo:= FieldByName('importe_fijo_dai').AsFloat;
        rCosteLinea:= FieldByName('coste_salida_dai').AsFloat;
      end
      else
      begin
        rPrecioFijo:= 0;
        rCosteLinea:= 0;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select count(*) salidas');
      SQL.Add(' from frf_depositos_aduana_c, frf_depositos_aduana_l ');
      SQL.Add(' where empresa_dac = :empresa ');
      SQL.Add(' and centro_dac = :centro ');
      SQL.Add(' and referencia_dac = :referencia ');
      SQL.Add(' and fecha_dac = :fecha ');
      SQL.Add(' and codigo_dac = codigo_dal ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('referencia').AsInteger:= AReferencia;
      ParamByName('fecha').AsDate:= AFecha;
      Open;
      if not IsEmpty then
      begin
        rImporte:= bRoundTo( ( FieldByName('salidas').AsInteger * rCosteLinea ) + ( rKilos * rPrecioFijo ), 2);
        rPrecio:= bRoundTo( rImporte/rKilos, 3 );
      end
      else
      begin
        rImporte:= bRoundTo( ( rKilos * rPrecioFijo ), 2);
        rPrecio:= bRoundTo( rImporte/rKilos, 3 );
      end;
      Close;
    end
    else
    begin
      rImporte:= 0;
      rPrecio:= 0;
    end;
  end;
end;

procedure TQRLFacturaTransitoFinal.transporte_tcPrint(sender: TObject;
  var Value: String);
begin
  Value:= desTransporte( sEmpresa, Value );
end;

procedure TQRLFacturaTransitoFinal.lbImportePrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rImporte );
end;

procedure TQRLFacturaTransitoFinal.netoPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rImporte );
end;

procedure TQRLFacturaTransitoFinal.totalPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rImporte );
end;

procedure TQRLFacturaTransitoFinal.qrlPrecioPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.000', rPrecio );
end;

procedure TQRLFacturaTransitoFinal.puerto_tcPrint(sender: TObject;
  var Value: String);
begin
  {ROSANA - Dic 2008 - Siempre se pone ALICANTE*}
  //Value:= 'DDP ' + 'ALICANTE';
  {ROSANA - May 2011 - Siempre se pone ALICANTE*}
  //Value:= 'DDP ' + 'ALICANTE';
  {ROSANA - JULIO 2011 - CAMBIO TEMPORAL        }
  //Value:= 'DDP ' + desAduana( Value );
  {ROSANA - OCTUBRE 2011 - CAMBIO TEMPORAL        }
  //Value:= 'DAT  DDA ESIC03001001';
  {ROSANA - DICIEMBRE 2011 - CAMBIO TEMPORAL        }
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
    Value:= 'DAP  ALICANTE';
end;

procedure TQRLFacturaTransitoFinal.puerto_tc_Print(sender: TObject;
  var Value: String);
begin
  Value:= 'PUERTO DESTINO : ' + desAduana( Value );
end;

procedure TQRLFacturaTransitoFinal.productoPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('empresa_tc').AsString = '050' then
  begin
    Value:= 'TOMATES FRESCOS';
  end
  else
  begin
    Value:= desProducto( DataSet.FieldByName('empresa_tc').AsString,
                         DataSet.FieldByName('producto_tl').AsString)
  end;
end;

procedure TQRLFacturaTransitoFinal.envasePrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('empresa_tc').AsString = '050' then
  begin
    Value:= 'CARTON 6 KGS';
  end
  else
  begin
    Value:= desEnvaseProducto( DataSet.FieldByName('empresa_tc').AsString,
                         DataSet.FieldByName('producto_tl').AsString,
                         DataSet.FieldByName('envase_tl').AsString)
  end;
end;

end.

