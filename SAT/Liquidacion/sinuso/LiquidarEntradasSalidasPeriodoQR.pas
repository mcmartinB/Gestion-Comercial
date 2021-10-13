unit LiquidarEntradasSalidasPeriodoQR;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRLiquidarEntradasSalidasPeriodo = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    fecha_c: TQRDBText;
    numero_c: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRGroup1: TQRGroup;
    centro_c: TQRDBText;
    ref_compra_c: TQRDBText;
    quien_compra_c: TQRDBText;
    QRLabel4: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    qrdbtxtkilos_in: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    procedure centro_cPrint(sender: TObject; var Value: String);
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: String);
  private

  public

  end;

  procedure ViewValorarPendiente(const AEmpresa, ACentro, AProducto: string;
                           const AFechaIni, AFechaFin: TDateTime; const ACosechero: string; const ATipo: integer );

var
  QRLiquidarEntradasSalidasPeriodo: TQRLiquidarEntradasSalidasPeriodo;

implementation

uses
  CVariables, DB, UDMAuxDB, LiquidarEntradasSalidasPeriodoDM, DPreview, Forms;

{$R *.DFM}

procedure ViewValorarPendiente(const AEmpresa, ACentro, AProducto: string;
                           const AFechaIni, AFechaFin: TDateTime; const ACosechero: string; const ATipo: integer );
begin
  Application.CreateForm( TQRLiquidarEntradasSalidasPeriodo, QRLiquidarEntradasSalidasPeriodo );
  try
    case ATipo of
      -1: QRLiquidarEntradasSalidasPeriodo.QRLTitulo.Caption:= 'ENTRADAS SIN SALIDAS 100% ASIGNADAS.';
       0: QRLiquidarEntradasSalidasPeriodo.QRLTitulo.Caption:= 'ENTRADAS LIQUIDACIÓN OK.';
       1: QRLiquidarEntradasSalidasPeriodo.QRLTitulo.Caption:= 'ENTRADAS CON ERRORES LIQUIDACION';
    end;
    DPreview.Previsualiza( QRLiquidarEntradasSalidasPeriodo );
  finally
    FreeAndNil( QRLiquidarEntradasSalidasPeriodo );
  end;
end;

procedure TQRLiquidarEntradasSalidasPeriodo.centro_cPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desEmpresa( Value );
end;

procedure TQRLiquidarEntradasSalidasPeriodo.qrdbtxtproducto1Print(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - ' + desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

end.
