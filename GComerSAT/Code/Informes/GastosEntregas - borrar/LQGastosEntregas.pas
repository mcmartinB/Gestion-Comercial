unit LQGastosEntregas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLGastosEntregas = class(TQuickRep)
    bndCabeceraListado: TQRBand;
    lblTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    bndPieListado: TQRBand;
    QRSysData2: TQRSysData;
    DetailBand1: TQRBand;
    entrega_ec: TQRDBText;
    QRDBText4: TQRDBText;
    proveedor_ec: TQRDBText;
    lblRangoFechas: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRSubDetailGastos: TQRSubDetail;
    QRDBText6: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRCabGastos: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRShape1: TQRShape;
    QRPieGastos: TQRBand;
    QRDBText12: TQRDBText;
    lblProducto: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel7: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabel14: TQRLabel;
    QRDBText13: TQRDBText;
    QRLabel15: TQRLabel;
    QRExpr2: TQRExpr;
    adjudicacion: TQRDBText;
    SummaryBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure QRDBText6Print(sender: TObject; var Value: String);
    procedure proveedor_ecPrint(sender: TObject; var Value: String);
    procedure QRCabGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetailGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRPieGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText12Print(sender: TObject; var Value: String);
    procedure QRDBText13Print(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRExpr4Print(sender: TObject; var Value: String);
  private
    rKilos, rKilosAcum: real;

  public
    sEmpresa: string;

  end;

 function  Imprimir( const AEmpresa, ACentro, AProveedor, AProducto, AEntrega, AGasto: string;
                      const AFechaIni, AFechaFin: TDateTime;
                      const APendientePago, ASinGastos: boolean; const AEnvio: Integer;
                      const ATipoCodigo, ATipoFecha, ATipoCentro: Integer ): boolean;

implementation

{$R *.DFM}

uses
  LDGastosEntregas, DPreview, UDMAuxDB, CReportes, UDMConfig;

var
  QLGastosEntregas: TQLGastosEntregas;

function Imprimir( const AEmpresa, ACentro, AProveedor, AProducto, AEntrega, AGasto: string;
                   const AFechaIni, AFechaFin: TDateTime;
                   const APendientePago, ASinGastos: boolean; const AEnvio: Integer;
                   const ATipoCodigo, ATipoFecha, ATipoCentro: Integer ): boolean;
begin
  DLGastosEntregas:= TDLGastosEntregas.Create( Application );
  try
    result:= DLGastosEntregas.ObtenerDatosCompletos(AEmpresa, ACentro, AProveedor, AProducto, AEntrega, AGasto,
                AFechaIni, AFechaFin, APendientePago, ASinGastos,  AEnvio, ATipoCodigo, ATipoFecha, ATipoCentro );
    if result then
    begin
      QLGastosEntregas:= TQLGastosEntregas.Create( Application );
      QLGastosEntregas.sEmpresa:= AEmpresa;
      PonLogoGrupoBonnysa( QLGastosEntregas, AEmpresa );
      QLGastosEntregas.lblRangoFechas.Caption:= DateToStr( AFechaIni ) + ' a ' +
                                                      DateToStr( AFechaFin );
      begin
        QLGastosEntregas.lblProducto.Caption:= 'Producto';
        QLGastosEntregas.adjudicacion.Enabled:= False;
      end;
      try
        Preview( QLGastosEntregas );
      except
        FreeAndNil(QLGastosEntregas);
        raise;
      end;
    end;
  finally
    DLGastosEntregas.CerrarQuery;
    FreeAndNil( DLGastosEntregas );
  end;
end;

procedure TQLGastosEntregas.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  If VAlue <> '0' then
  begin
    Value:= 'OK';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLGastosEntregas.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value:= Value;
end;

procedure TQLGastosEntregas.QRDBText12Print(sender: TObject;
  var Value: String);
begin
  Value:= desTipoGastos( Value );
end;

procedure TQLGastosEntregas.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( DataSet.FieldByName('empresa_ec').AsString, Value );
end;

procedure TQLGastosEntregas.proveedor_ecPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProveedor( DataSet.FieldByName('empresa_ec').AsString, Value );
end;

procedure TQLGastosEntregas.QRCabGastosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //PrintBand:=  not QRSubDetailGastos.DataSet.IsEmpty;
end;

procedure TQLGastosEntregas.QRSubDetailGastosBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  //PrintBand:=  not QRSubDetailGastos.DataSet.IsEmpty;
end;

procedure TQLGastosEntregas.QRPieGastosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //PrintBand:=  not QRSubDetailGastos.DataSet.IsEmpty;
end;

procedure TQLGastosEntregas.QRDBText13Print(sender: TObject;
  var Value: String);
begin
  if rKilos = 0 then
  begin
    Value:= 'ERR: KGS=0';
  end
  else
  begin
    Value:= FormatFloat( '#,##0.000',
                       DLGastosEntregas.QDetalleGasto.FieldByName('importe_ge').AsFloat / rKilos );
  end;
end;

procedure TQLGastosEntregas.QRExpr2Print(sender: TObject;
  var Value: String);
begin
  if rKilos = 0 then
  begin
    Value:= 'ERR: KGS=0';
  end
  else
  begin
    Value:= FormatFloat( '#,##0.000', StrToFloat( Value ) / rKilos );
  end;
end;

procedure TQLGastosEntregas.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rKilos:= rKilos + DLGastosEntregas.QDetalleLinea.FieldByName('kilos_el').AsFloat;
  rKilosAcum:= rKilosAcum + DLGastosEntregas.QDetalleLinea.FieldByName('kilos_el').AsFloat;
end;

procedure TQLGastosEntregas.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rKilos:= 0;
end;

procedure TQLGastosEntregas.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rKilosAcum:= 0;
end;

procedure TQLGastosEntregas.QRExpr4Print(sender: TObject;
  var Value: String);
begin
  if rKilosAcum = 0 then
  begin
    Value:= 'ERR: KGS=0';
  end
  else
  begin
    Value:= FormatFloat( '#,##0.000', StrToFloat( Value ) / rKilosAcum );
  end;
end;

end.
