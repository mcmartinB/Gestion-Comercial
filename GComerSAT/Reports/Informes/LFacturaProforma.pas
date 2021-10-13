unit LFacturaProforma;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, jpeg, Grids;

type
  TQRLFacturaProforma = class(TQuickRep)
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
    iva: TQRLabel;
    total: TQRLabel;
    Rtotal: TQRShape;
    ivaFrame: TQRShape;
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
    tipoFactura: TQRLabel;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    PsQRLabel9: TQRLabel;
    PsQRShape7: TQRShape;
    BandaLinea: TQRSubDetail;
    cantidad: TQRLabel;
    lin2: TQRShape;
    lin5: TQRShape;
    lin6: TQRShape;
    lin7: TQRShape;
    lin8: TQRShape;
    euroFrame: TQRShape;
    totalEuro: TQRLabel;
    euroMoneda: TQRLabel;
    PsQRLabel12: TQRLabel;
    PsQRLabel15: TQRLabel;
    PsQRLabel17: TQRLabel;
    PsQRLabel18: TQRLabel;
    PsQRLabel19: TQRLabel;
    PsQRLabel20: TQRLabel;
    Date: TQRLabel;
    PsQRLabel31: TQRLabel;
    Lneto: TQRLabel;
    ivaLabel1: TQRLabel;
    Ltotal: TQRLabel;
    euroLabel: TQRLabel;
    moneda2: TQRLabel;
    PsQRLabel13: TQRLabel;
    ivaLabel2: TQRLabel;
    LTotal2: TQRLabel;
    moneda1: TQRLabel;
    PsQRLabel25: TQRLabel;
    PsQRLabel37: TQRLabel;
    producto: TQRLabel;
    pedido: TQRLabel;
    envase: TQRLabel;
    fechaFactura: TQRLabel;
    codigoCliente: TQRLabel;
    albaran: TQRLabel;
    unidad: TQRLabel;
    precio: TQRLabel;
    importe: TQRLabel;
    clienteFacturacion: TQRMemo;
    moneda3: TQRLabel;
    BandaObservaciones: TQRChildBand;
    PsQRLabel7: TQRLabel;
    memoObservaciones: TQRMemo;
    BonnyBand: TQRBand;
    QRImageCab: TQRImage;
    PsEmpresa: TQRLabel;
    PsDireccion: TQRLabel;
    PsNif: TQRLabel;
    qrmFormaPago: TQRMemo;
    PiePagina: TQRBand;
    qrmReponsabilidadEnvase: TQRMemo;
    qrlIncotermLabel: TQRLabel;
    qrsIncoterm: TQRShape;
    qrlIncoterm: TQRLabel;
    procedure BandaLineaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaLineaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRLFacturaProformaStartPage(Sender: TCustomQuickRep);
    procedure QRLFacturaProformaBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BandaLineaNeedData(Sender: TObject; var MoreData: Boolean);
  private
    contador: integer;
  public
    mascara, mascara2: string;
    StringGrid: TStringGrid;
    procedure Configurar(Empresa: string);
  end;

var
  QRLFacturaProforma: TQRLFacturaProforma;

implementation

uses UDMAuxDB, CVariables, UDMConfig;

{$R *.DFM}

procedure TQRLFacturaProforma.Configurar(Empresa: string);
var
  bAux: Boolean;
  sAux: string;
begin
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

procedure TQRLFacturaProforma.BandaLineaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  aux: string;
begin
  producto.Caption := StringGrid.Cells[2, contador];

  if (StringGrid.Cells[1, contador] <> '') and
    (producto.Caption <> '') then
    producto.Caption := producto.Caption + ' - ' +
      StringGrid.Cells[1, contador];

  envase.Caption := StringGrid.Cells[3, contador];
  unidad.Caption := StringGrid.Cells[5, contador];
  cantidad.Caption := StringGrid.Cells[4, contador];
  //calibre.Caption:= StringGrid.Cells[8,contador];
  aux := StringGrid.Cells[6, contador];
  if aux <> '' then
    precio.Caption := FormatFloat('#0.000', StrToFloat(aux))
  else
    precio.Caption := '';
  importe.Caption := StringGrid.Cells[7, contador];
end;

procedure TQRLFacturaProforma.BandaLineaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  albaran.Enabled := False;
  pedido.Enabled := False;
  Inc(contador);
end;

procedure TQRLFacturaProforma.QRLFacturaProformaStartPage(
  Sender: TCustomQuickRep);
begin
  albaran.Enabled := True;
  pedido.Enabled := True;
end;

procedure TQRLFacturaProforma.QRLFacturaProformaBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  contador := 1;
end;

procedure TQRLFacturaProforma.BandaLineaNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData := not (contador = StringGrid.RowCount);
end;

end.

