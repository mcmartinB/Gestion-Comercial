unit EntradaSinSalidasAsignadasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLEntradaSinSalidasAsignadas = class(TQuickRep)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    fecha_ec: TQRDBText;
    descripcion_v: TQRDBText;
    QRSysData3: TQRSysData;
    lblCentro: TQRLabel;
    lblProducto: TQRLabel;
    lblRango: TQRLabel;
    qrdbtxt1: TQRDBText;
    qrdbtxtdescripcion_v: TQRDBText;
    qrdbtxt3: TQRDBText;
    qrdbtxtfecha_salida_es: TQRDBText;
    qrdbtxtkilos_linea_es: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrxprKgsFaltan: TQRExpr;
    qrlbl7: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlblPesoAlbaranes: TQRLabel;
    qrlblPesoSinAsignar: TQRLabel;
    qrlblPesoEntradas: TQRLabel;
    qrlblPesoSalidas: TQRLabel;
    qrlblPesoTransitos: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrlbl21: TQRLabel;
    qrshp1: TQRShape;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand4AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure fecha_ecPrint(sender: TObject; var Value: String);
    procedure qrlbl7Print(sender: TObject; var Value: String);
    procedure qrbndSummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    sEmpresa, sMarca: string;
    rPesoEntrada, rPesoSinAsignar, rPesoSalida, rPesoTransito: Real;

  public
    procedure PreparaListado( const AEmpresa, ACentro, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime; const ATipo: integer );

  end;

  function ImprimirEntradasSinAsignar(const AOwner: TComponent; const AEmpresa, ACentro, AProducto, ANumero: string;
                                      const AFechaIni, AFechaFin: TDateTime; const ATipo: integer ): Boolean;

implementation

{$R *.DFM}

uses
  EntradasSalidasDM, Dialogs, DPreview, CReportes, UDMAuxDB, DB;

var
  QLEntradaSinSalidasAsignadas: TQLEntradaSinSalidasAsignadas;
  DMEntradasSalidas: TDMEntradasSalidas;

procedure ImprimirEntradasSinAsignarQR( const AOwner: TComponent; const AEmpresa, ACentro, AProducto: string;
                                    const AFechaIni, AFechaFin: TDateTime; const ATipo: integer );
begin
  QLEntradaSinSalidasAsignadas:= TQLEntradaSinSalidasAsignadas.Create( AOwner );
  try
    QLEntradaSinSalidasAsignadas.PreparaListado( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, ATipo );
    Previsualiza( QLEntradaSinSalidasAsignadas );
  finally
    FreeAndNil( QLEntradaSinSalidasAsignadas );
  end;
end;

function ImprimirEntradasSinAsignar(const AOwner: TComponent; const AEmpresa, ACentro, AProducto, ANumero: string;
                                    const AFechaIni, AFechaFin: TDateTime; const ATipo: integer ): boolean;
begin
  result:= False;

  DMEntradasSalidas:= TDMEntradasSalidas.Create(AOwner);
  try
    if DMEntradasSalidas.HayEntradasSinAsignar( AEmpresa, ACentro, AProducto, ANumero, AFechaIni, AFechaFin, ATipo ) then
    begin
      ImprimirEntradasSinAsignarQR( AOwner, AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, ATipo );
      result:= True;
    end
    else
    begin
      if ATipo = 0 then
        ShowMessage('No hay entradas para los parametros seleccionados.')
      else
      if ATipo = 1 then
       ShowMessage('Todas las entradas ya estan asignadas o no hay entradas para los parametros seleccionados.')
      else
      if ATipo = 2 then
       ShowMessage('Todas las entradas estan por asignar o no hay entradas para los parametros seleccionados.')
    end;
  finally
    FreeAndNil( DMEntradasSalidas );
  end;
end;

procedure TQLEntradaSinSalidasAsignadas.PreparaListado( const AEmpresa, ACentro, AProducto: string;
                                                        const AFechaIni, AFechaFin: TDateTime; const ATipo: integer );
begin
  sEmpresa:= AEmpresa;
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblCentro.Caption:= DesCentro( AEmpresa, ACentro );
  lblProducto.Caption:= DesProducto( AEmpresa, AProducto );
  if AFechaIni = AFechaFin then
  begin
    lblRango.Caption:= 'Datos del ' + FormatDateTime('dd/mm/yyyy', AFechaIni );
  end
  else
  begin
    lblRango.Caption:= 'Del ' + FormatDateTime('dd/mm/yyyy', AFechaIni ) +
                       ' al ' + FormatDateTime('dd/mm/yyyy', AFechaFin );
  end;
  if ATipo = 0 then
     ReportTitle:= 'ENTRADAS Y SALIDAS ASIGNADAS'
  else
  if ATipo = 1 then
   ReportTitle:= 'ENTRADAS CON SALIDAS PENDIENTES'
  else
  if ATipo = 2 then
    ReportTitle:= 'ENTRADAS CON TODAS SALIDAS ASIGNADAS';
end;

procedure TQLEntradaSinSalidasAsignadas.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  sMarca:= '';
  rPesoEntrada:= 0;
  rPesoSinAsignar:= 0;
  rPesoSalida:= 0;
  rPesoTransito:= 0;  
end;

procedure TQLEntradaSinSalidasAsignadas.QRBand4AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  sMarca:= DataSet.fieldByname('fecha_ec').AsString +
           DataSet.fieldByname('numero_entrada_ec').AsString +
           DataSet.fieldByname('peso_neto_ec').AsString +
           DataSet.fieldByname('kilos_total_es').AsString;
end;

procedure TQLEntradaSinSalidasAsignadas.fecha_ecPrint(sender: TObject;
  var Value: String);
begin
  if sMarca = DataSet.fieldByname('fecha_ec').AsString +
           DataSet.fieldByname('numero_entrada_ec').AsString +
           DataSet.fieldByname('peso_neto_ec').AsString +
           DataSet.fieldByname('kilos_total_es').AsString  then
    Value:= '';
end;

procedure TQLEntradaSinSalidasAsignadas.qrlbl7Print(sender: TObject;
  var Value: String);
begin
  if sMarca <> DataSet.fieldByname('fecha_ec').AsString +
           DataSet.fieldByname('numero_entrada_ec').AsString +
           DataSet.fieldByname('peso_neto_ec').AsString +
           DataSet.fieldByname('kilos_total_es').AsString  then
    Value:= '';
end;

procedure TQLEntradaSinSalidasAsignadas.qrbndSummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlblPesoEntradas.Caption:= FormatFloat('#,##0.00', rPesoEntrada);
  qrlblPesoSalidas.Caption:= FormatFloat('#,##0.00', rPesoSalida);
  qrlblPesoTransitos.Caption:= FormatFloat('#,##0.00', rPesoTransito);
  qrlblPesoAlbaranes.Caption:= FormatFloat('#,##0.00', rPesoTransito + rPesoSalida);
  qrlblPesoSinAsignar.Caption:= FormatFloat('#,##0.00', rPesoSinAsignar);
end;

procedure TQLEntradaSinSalidasAsignadas.QRBand4BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if sMarca <> DataSet.fieldByname('fecha_ec').AsString +
           DataSet.fieldByname('numero_entrada_ec').AsString +
           DataSet.fieldByname('peso_neto_ec').AsString +
           DataSet.fieldByname('kilos_total_es').AsString   then
  begin
    rPesoEntrada:= rPesoEntrada + DataSet.fieldByname('peso_neto_ec').AsFloat;
  end;
  if DataSet.fieldByname('transito_es').AsString = 'SALIDA' then
    rPesoSalida:= rPesoSalida + DataSet.fieldByname('kilos_linea_es').AsFloat
  else
    rPesoTransito:= rPesoTransito  + DataSet.fieldByname('kilos_linea_es').AsFloat;
  rPesoSinAsignar:= rPesoSinAsignar + ( DataSet.fieldByname('peso_neto_ec').AsFloat -
                                        DataSet.fieldByname('kilos_total_es').AsFloat );
end;

end.
