unit LFacturaTransito;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, jpeg, Grids, DB, DBTables;

type
  TQRLFacturaTransito = class(TQuickRep)
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
    Date: TQRLabel;
    PsQRLabel31: TQRLabel;
    Lneto: TQRLabel;
    Ltotal: TQRLabel;
    moneda1: TQRLabel;
    PsQRLabel25: TQRLabel;
    PsQRLabel37: TQRLabel;
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
    procedure transporte_tcPrint(sender: TObject; var Value: String);
    procedure lbImportePrint(sender: TObject; var Value: String);
    procedure netoPrint(sender: TObject; var Value: String);
    procedure totalPrint(sender: TObject; var Value: String);
    procedure puerto_tcPrint(sender: TObject; var Value: String);
    procedure puerto_tc_Print(sender: TObject; var Value: String);
  private
    sEmpresa: String;
    rImporte: real;

  public
    function SeleccionarDatos( const AEmpresa, ACentro: String;
             const AReferencia: Integer; const AFecha: TDateTime ): boolean;
    procedure DireccionFactura( const AEmpresa: string );
    procedure Configurar(Empresa: string);
  end;


  function PreviewFactura( const AOwner: TComponent; const AEmpresa, ACentro: String;
             const AReferencia: Integer; const AFecha: TDateTime ): boolean;

implementation

uses UDMAuxDB, CVariables, UDMConfig, DPreview;

{$R *.DFM}

var
  QRLFacturaTransito: TQRLFacturaTransito;

function PreviewFactura( const AOwner: TComponent; const AEmpresa, ACentro: String;
           const AReferencia: Integer; const AFecha: TDateTime ): boolean;
begin
  result:= false;
  QRLFacturaTransito:= TQRLFacturaTransito.Create( AOwner );
  try
    if QRLFacturaTransito.SeleccionarDatos( AEmpresa, ACentro, AReferencia, AFecha ) then
    begin
      QRLFacturaTransito.Configurar( AEmpresa );
      QRLFacturaTransito.DireccionFactura( AEmpresa );
      DPreview.Preview( QRLFacturaTransito );
    end
    else
    begin
      result:= True;
      FreeAndNil( QRLFacturaTransito );
    end;
  except
    FreeAndNil( QRLFacturaTransito );
    raise;
  end;
end;

procedure TQRLFacturaTransito.Configurar(Empresa: string);
var
  bAux: Boolean;
  sAux: string;
begin
  sEmpresa:= Empresa;
  bAux:= FileExists( gsDirActual + '\recursos\' + Empresa + 'Page.wmf');
  if bAux then
  begin
    QRImageCab.Top:= -18; //-20
    QRImageCab.Left:= -37; //-20
    QRImageCab.Width:= 763; //-30
    QRImageCab.Height:= 1102; //-20
    QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\' + Empresa + 'Page.wmf');
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

procedure TQRLFacturaTransito.DireccionFactura( const AEmpresa: string );
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
    clienteFacturacion.Lines.Add( 'CF. ES' + FieldByName('nif_e').AsString );
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

function TQRLFacturaTransito.SeleccionarDatos( const AEmpresa, ACentro: String;
           const AReferencia: Integer; const AFecha: TDateTime ): boolean;
begin
  with QDatos do
  begin
    SQL.Clear;
    SQL.Add('select referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, ');
    SQL.Add('       fecha_facontrol_tc, precio_facontrol_tc, sum( kilos_tl ) kilos_tc');

    SQL.Add('from frf_transitos_c, frf_transitos_l');

    SQL.Add('where empresa_tc = :empresa');
    SQL.Add('and centro_tc = :centro');
    SQL.Add('and referencia_tc = :referencia');
    SQL.Add('and fecha_tc = :fecha');

    SQL.Add('and empresa_tl = :empresa');
    SQL.Add('and centro_tl = :centro');
    SQL.Add('and referencia_tl = :referencia');
    SQL.Add('and fecha_tl = :fecha');

    SQL.Add('group by referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc,');
    SQL.Add('       fecha_facontrol_tc, precio_facontrol_tc');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('referencia').AsInteger:= AReferencia;
    ParamByName('fecha').AsDate:= AFecha;

    Open;

    result:= not IsEmpty;
  end;
end;

procedure TQRLFacturaTransito.transporte_tcPrint(sender: TObject;
  var Value: String);
begin
  Value:= desTransporte( sEmpresa, Value );
end;

procedure TQRLFacturaTransito.lbImportePrint(sender: TObject;
  var Value: String);
begin
  rImporte:= QDatos.FieldByname('kilos_tc').AsFloat *
             QDatos.FieldByname('precio_facontrol_tc').AsFloat;
  Value:= FormatFloat( '#,##0.00', rImporte );
end;

procedure TQRLFacturaTransito.netoPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rImporte );
end;

procedure TQRLFacturaTransito.totalPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rImporte );
end;

procedure TQRLFacturaTransito.puerto_tcPrint(sender: TObject;
  var Value: String);
begin
  {ROSANA - Dic 2008 - Siempre se pone ALICANTE*}
  {ROSANA - May 2011 - Siempre se pone ALICANTE*}
  //Value:= 'DDP ' + desAduana( Value );
  Value:= 'DDP ' + 'ALICANTE';
end;

procedure TQRLFacturaTransito.puerto_tc_Print(sender: TObject;
  var Value: String);
begin
  Value:= 'PUERTO DESTINO : ' + desAduana( Value );
end;

end.

