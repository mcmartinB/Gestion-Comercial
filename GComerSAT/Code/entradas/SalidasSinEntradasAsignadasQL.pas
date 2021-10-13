unit SalidasSinEntradasAsignadasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLSalidasSinEntradasAsignadas = class(TQuickRep)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    fecha_ec: TQRDBText;
    qrdbtxtn_salida: TQRDBText;
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
    qrdbtxtn_salida1: TQRDBText;
    qrdbtxtn_salida2: TQRDBText;
    qrdbtxtn_salida3: TQRDBText;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
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
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndSummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    sEmpresa, sMarca: string;
    rPesoEntrada, rPesoSinAsignar, rPesoSalida, rPesoTransito: Real;

  public
    procedure PreparaListado( const AEmpresa, ACentro, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime; const ATipo, ATipoSalida: integer );

  end;

  function ImprimirSalidasSinAsignar(const AOwner: TComponent; const AEmpresa, ACentro, AProducto, ANumero: string;
                                      const AFechaIni, AFechaFin: TDateTime; const ATipo, ATipoSalida: integer ): Boolean;

implementation

{$R *.DFM}

uses
  EntradasSalidasDM, Dialogs, DPreview, CReportes, UDMAuxDB, DB;

var
  QLSalidasSinEntradasAsignadas: TQLSalidasSinEntradasAsignadas;
  DMEntradasSalidas: TDMEntradasSalidas;


procedure ImprimirSalidasSinAsignarQR( const AOwner: TComponent; const AEmpresa, ACentro, AProducto: string;
                                    const AFechaIni, AFechaFin: TDateTime; const ATipo, ATipoSalida: integer );
begin
  QLSalidasSinEntradasAsignadas:= TQLSalidasSinEntradasAsignadas.Create( AOwner );
  try
    QLSalidasSinEntradasAsignadas.PreparaListado( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, ATipo, ATipoSalida );
    Previsualiza( QLSalidasSinEntradasAsignadas );
  finally
    FreeAndNil( QLSalidasSinEntradasAsignadas );
  end;
end;

function ImprimirSalidasSinAsignar(const AOwner: TComponent; const AEmpresa, ACentro, AProducto, ANumero: string;
                                   const AFechaIni, AFechaFin: TDateTime; const ATipo, ATipoSalida: integer ): boolean;
begin
  result:= False;

  DMEntradasSalidas:= TDMEntradasSalidas.Create(AOwner);
  try
    if DMEntradasSalidas.HaySalidasSinAsignar( AEmpresa, ACentro, AProducto, ANumero, AFechaIni, AFechaFin, ATipo, ATipoSalida ) then
    begin
      ImprimirSalidasSinAsignarQR( AOwner, AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, ATipo, ATipoSalida );
      result:= True;
    end
    else
    begin
      if ATipo = 0 then
        ShowMessage('No hay salidas para los parametros seleccionados.')
      else
      if ATipo = 1 then
       ShowMessage('Todas las salidas ya estan asignadas o no hay salidas para los parametros seleccionados.')
      else
      if ATipo = 2 then
       ShowMessage('Todas las salidas estan por asignar o no hay salidas para los parametros seleccionados.')
    end;
  finally
    FreeAndNil( DMEntradasSalidas );
  end;
end;

procedure TQLSalidasSinEntradasAsignadas.PreparaListado( const AEmpresa, ACentro, AProducto: string;
                                                        const AFechaIni, AFechaFin: TDateTime; const ATipo, ATipoSalida: integer );
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

  if ATipoSalida = 0 then
     ReportTitle:= 'SALIDAS Y TRANSITOS '
  else
  if ATipoSalida = 1 then
   ReportTitle:= 'SALIDAS '
  else
  if ATipoSalida = 2 then
    ReportTitle:= 'TRANSITOS ';


  if ATipo = 0 then
     ReportTitle:= ReportTitle + '- ENTRADAS ASIGNADAS'
  else
  if ATipo = 1 then
   ReportTitle:= ReportTitle + '- 100% ASIGNADAS'
  else
  if ATipo = 2 then
   ReportTitle:= ReportTitle + '- PENDIENTES DE ASIGNAR';
end;

procedure TQLSalidasSinEntradasAsignadas.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  sMarca:= '';
  rPesoEntrada:= 0;
  rPesoSinAsignar:= 0;
  rPesoSalida:= 0;
  rPesoTransito:= 0;
end;

procedure TQLSalidasSinEntradasAsignadas.QRBand4AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  sMarca:= DataSet.fieldByname('fecha_salida').AsString +
           DataSet.fieldByname('n_salida').AsString;
end;

procedure TQLSalidasSinEntradasAsignadas.fecha_ecPrint(sender: TObject;
  var Value: String);
begin
  if sMarca = DataSet.fieldByname('fecha_salida').AsString +
           DataSet.fieldByname('n_salida').AsString   then
    Value:= '';
end;

procedure TQLSalidasSinEntradasAsignadas.qrlbl7Print(sender: TObject;
  var Value: String);
begin
  if sMarca <> DataSet.fieldByname('fecha_salida').AsString +
           DataSet.fieldByname('n_salida').AsString   then
    Value:= '';
end;

(*

empresa, centro_salida, , ,  , , , producto,
,  , , , ,
*)

procedure TQLSalidasSinEntradasAsignadas.QRBand4BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if sMarca <> DataSet.fieldByname('fecha_salida').AsString + DataSet.fieldByname('n_salida').AsString   then
  begin
    if DataSet.fieldByname('tipo_salida').AsString = 'SALIDA' then
      rPesoSalida:= rPesoSalida + DataSet.fieldByname('kilos_total_salida').AsFloat
    else
      rPesoTransito:= rPesoTransito  + DataSet.fieldByname('kilos_total_salida').AsFloat;
  end;
  rPesoEntrada:= rPesoEntrada + DataSet.fieldByname('kilos_linea_entrada').AsFloat;
  rPesoSinAsignar:= rPesoSinAsignar + ( DataSet.fieldByname('kilos_total_salida').AsFloat -
                                        DataSet.fieldByname('kilos_total_entrada').AsFloat ) ;
end;

procedure TQLSalidasSinEntradasAsignadas.qrbndSummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlblPesoEntradas.Caption:= FormatFloat('#,##0.00', rPesoEntrada);
  qrlblPesoSalidas.Caption:= FormatFloat('#,##0.00', rPesoSalida);
  qrlblPesoTransitos.Caption:= FormatFloat('#,##0.00', rPesoTransito);
  qrlblPesoAlbaranes.Caption:= FormatFloat('#,##0.00', rPesoTransito + rPesoSalida);
  qrlblPesoSinAsignar.Caption:= FormatFloat('#,##0.00', rPesoSinAsignar);
end;

end.
