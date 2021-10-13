unit GenerarRemesaCobroQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, ListProductoSinFacturarDL;

type
  TQLGenerarRemesaCobro = class(TQuickRep)
    bndTitulo: TQRBand;
    bndDetalle: TQRBand;
    bndCabeceraColumna: TQRBand;
    bndPiePagina: TQRBand;
    lblImpresoEl: TQRSysData;
    lblTitulo: TQRSysData;
    lblPaginaNum: TQRSysData;
    qrdbtxtiban_cliente: TQRDBText;
    qrdbtxtcliente: TQRDBText;
    qrdbtxtnombre: TQRDBText;
    qrdbtxtnif: TQRDBText;
    qrdbtxttipo_iva: TQRDBText;
    qrdbtxtfactura: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    lblFecha: TQRLabel;
    QRLabel9: TQRLabel;
    qrdbtxtempresa: TQRDBText;
    qrdbtxtimporte: TQRDBText;
    qrdbtxtdias_pago: TQRDBText;
    qrbndSummaryBand1: TQRBand;
    qrxprImporte: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl_facturas: TQRLabel;
    qrlbl3: TQRLabel;
    qrlblBanco1: TQRLabel;
    qrlblBanco: TQRLabel;
    qrlblIbanEmpresa1: TQRLabel;
    qrlblIbanEmpresa: TQRLabel;
    qrshp1: TQRShape;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure qrdbtxttipo_ivaPrint(sender: TObject; var Value: String);
    procedure qrlbl_facturasPrint(sender: TObject; var Value: String);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrdbtxtiban_clientePrint(sender: TObject; var Value: String);

  private
    iFacturas: Integer;

    procedure PutDataSet( const AQuery: TQuery );
  public

  end;

procedure LoadReport( APadre: TComponent );
procedure UnloadReport;
function ExecuteReport( const APadre: TComponent; const AQuery: TQuery; const ARemesaGiro: integer;
                        const ABanco, AIbanEmpresa: string ): boolean;


implementation

{$R *.DFM}

uses UDMAuxDB, CReportes, Dpreview, Dialogs, CBancos;

var
  QLGenerarRemesaCobro: TQLGenerarRemesaCobro;
  iContadorUso: integer = 0;

procedure LoadReport( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      QLGenerarRemesaCobro:= TQLGenerarRemesaCobro.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
  ListProductoSinFacturarDL.LoadModule( APadre );
end;

procedure UnloadReport;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if QLGenerarRemesaCobro <> nil then
        FreeAndNil( QLGenerarRemesaCobro );
    end;
  end;
  ListProductoSinFacturarDL.UnloadModule;
end;

function ExecuteReport( const APadre: TComponent; const AQuery: TQuery; const ARemesaGiro: integer;
                        const ABanco, AIbanEmpresa: string ): boolean;
begin
  LoadReport( APadre );
  try
    if ARemesaGiro <> -1 then
      QLGenerarRemesaCobro.ReportTitle:= 'FACTURAS REMESA GIRO Nº ' + IntToStr( ARemesaGiro + 1 )
    else
      QLGenerarRemesaCobro.ReportTitle:= 'FACTURAS REMESA GIRO ';
    if ABanco <> '' then
    begin
      QLGenerarRemesaCobro.qrlblBanco.Caption:= desBanco(  ABanco );
      QLGenerarRemesaCobro.qrlblIbanEmpresa.Caption:= FomateaIBAN( AIbanEmpresa );
    end
    else
    begin
      QLGenerarRemesaCobro.qrlblBanco.Caption:= '';
      QLGenerarRemesaCobro.qrlblIbanEmpresa.Caption:= '';
      QLGenerarRemesaCobro.qrlblBanco1.Caption:= '';
      QLGenerarRemesaCobro.qrlblIbanEmpresa1.Caption:= '';
    end;
    QLGenerarRemesaCobro.lblFecha.Caption:= FormatDateTime( 'dd/mm/yyyy', Date );
    QLGenerarRemesaCobro.PutDataSet( AQuery );
    PonLogoGrupoBonnysa( QLGenerarRemesaCobro, AQuery.FieldByName('empresa').AsString );
    result:= Previsualiza( QLGenerarRemesaCobro );
  finally
    UnloadReport;
  end;
end;

procedure TQLGenerarRemesaCobro.PutDataSet( const AQuery: TQuery );
begin
  QLGenerarRemesaCobro.DataSet:= AQuery;
  qrdbtxtempresa.DataSet:= AQuery;
  qrdbtxtiban_cliente.DataSet:= AQuery;
  qrdbtxtcliente.DataSet:= AQuery;
  qrdbtxtnombre.DataSet:= AQuery;
  qrdbtxtnif.DataSet:= AQuery;
  qrdbtxttipo_iva.DataSet:= AQuery;
  qrdbtxtfactura.DataSet:= AQuery;
  qrdbtxtfecha.DataSet:= AQuery;
  qrdbtxtimporte.DataSet:= AQuery;
  qrdbtxtdias_pago.DataSet:= AQuery;
end;


procedure TQLGenerarRemesaCobro.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= DesProducto( DataSet.FieldByName('empresa_sc').AsString, Value );
end;

procedure TQLGenerarRemesaCobro.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL "' + Value + '"';
end;

procedure TQLGenerarRemesaCobro.qrdbtxttipo_ivaPrint(sender: TObject;
  var Value: String);
begin
  if Value = 'I' then
    Value:= 'Iva'
  else
    Value:= 'Igic';
end;

procedure TQLGenerarRemesaCobro.qrlbl_facturasPrint(sender: TObject;
  var Value: String);
begin
  Value:= IntToStr( iFacturas );
end;

procedure TQLGenerarRemesaCobro.bndDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Inc( iFacturas );
end;

procedure TQLGenerarRemesaCobro.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  iFacturas:= 0;
end;

procedure TQLGenerarRemesaCobro.qrdbtxtiban_clientePrint(sender: TObject;
  var Value: String);
begin
  Value:= FomateaIBAN( Value );
end;

end.
