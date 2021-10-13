unit ResumenProduccionQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, grimgctrl;

type
  TQRResumenProduccion = class(TQuickRep)
    QRBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblFecha: TQRLabel;
    lblCentro: TQRLabel;
    QRBand2: TQRBand;
    QRDBText94: TQRDBText;
    QRDBText95: TQRDBText;
    QRDBText100: TQRDBText;
    QRDBText101: TQRDBText;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    QRDBText110: TQRDBText;
    QRDBText111: TQRDBText;
    QRDBText112: TQRDBText;
    QRDBText113: TQRDBText;
    QRDBText114: TQRDBText;
    QRDBText115: TQRDBText;
    QRDBText146: TQRDBText;
    QRDBText147: TQRDBText;
    QRDBText148: TQRDBText;
    QRDBText150: TQRDBText;
    QRDBText156: TQRDBText;
    QRDBText157: TQRDBText;
    QRDBText158: TQRDBText;
    QRDBText159: TQRDBText;
    QRLabel64: TQRLabel;
    QRDBText166: TQRDBText;
    QRLabel71: TQRLabel;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText128: TQRDBText;
    QRDBText129: TQRDBText;
    QRDBText130: TQRDBText;
    QRDBText131: TQRDBText;
    QRDBText132: TQRDBText;
    QRDBText133: TQRDBText;
    QRDBText134: TQRDBText;
    QRDBText135: TQRDBText;
    QRLabel22: TQRLabel;
    qrdbtxtKilosIn: TQRDBText;
    qrbndColumnHeaderBand1: TQRBand;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl5: TQRLabel;
    qrdbtxtKilosFin: TQRDBText;
    qrdbtxtSalDestrio: TQRDBText;
    qrdbtxtSalDestrio1: TQRDBText;
    qrlbl7: TQRLabel;
    qrdbtxtIniCampo: TQRDBText;
    procedure QRDBText36Print(sender: TObject; var Value: String);
    procedure QRDBText38Print(sender: TObject; var Value: String);
    procedure QRDBText40Print(sender: TObject; var Value: String);
    procedure QRDBText41Print(sender: TObject; var Value: String);
    procedure QRDBText75Print(sender: TObject; var Value: String);
    procedure QRDBText53Print(sender: TObject; var Value: String);
    procedure QRDBText76Print(sender: TObject; var Value: String);
    procedure QRDBText54Print(sender: TObject; var Value: String);
    procedure QRDBText77Print(sender: TObject; var Value: String);
    procedure QRDBText55Print(sender: TObject; var Value: String);
    procedure QRDBText78Print(sender: TObject; var Value: String);
    procedure QRDBText58Print(sender: TObject; var Value: String);
    procedure QRDBText80Print(sender: TObject; var Value: String);
    procedure QRDBText57Print(sender: TObject; var Value: String);
    procedure QRDBText81Print(sender: TObject; var Value: String);
    procedure QRDBText59Print(sender: TObject; var Value: String);
    procedure QRDBText82Print(sender: TObject; var Value: String);
    procedure QRDBText60Print(sender: TObject; var Value: String);
    procedure QRDBText83Print(sender: TObject; var Value: String);
    procedure QRDBText61Print(sender: TObject; var Value: String);
    procedure QRDBText84Print(sender: TObject; var Value: String);
    procedure QRDBText62Print(sender: TObject; var Value: String);
    procedure QRDBText85Print(sender: TObject; var Value: String);
    procedure QRDBText63Print(sender: TObject; var Value: String);
    procedure QRDBText7Print(sender: TObject; var Value: String);
    procedure QRDBText9Print(sender: TObject; var Value: String);
    procedure qrdbtxtSalDestrio1Print(sender: TObject; var Value: String);
    procedure qrdbtxtIniCampoPrint(sender: TObject; var Value: String);
  private

  public

  end;

procedure PrintAprovechaResumen( const AOwner: TComponent;
                                 const AEmpresa, ACentro, AProducto: string;
                                 const AFechaIni, AFechaFin: TDateTime );

implementation

{$R *.DFM}

uses
  ResumenProduccionDM, DPreview, CReportes, UDMAuxDB;

var
  QRResumenProduccion: TQRResumenProduccion;

procedure PrintAprovechaResumen( const AOwner: TComponent;
                                 const AEmpresa, ACentro, AProducto: string;
                                 const AFechaIni, AFechaFin: TDateTime );
begin
  QRResumenProduccion:= TQRResumenProduccion.Create( AOwner );
  try
    PonLogoGrupoBonnysa(QRResumenProduccion, AEmpresa);
    QRResumenProduccion.lblCentro.Caption:= ACentro + ' ' + desCentro( AEmpresa, ACentro );
    //QRResumenProduccion.lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto );
    QRResumenProduccion.lblFecha.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin ) ;
    //QRResumenProduccion.lblInventarioIni.Caption:= DateToStr( AFechaIni - 1 );
    //QRResumenProduccion.lblInventarioFin.Caption:= DateToStr( AFechaFin );
    Previsualiza( QRResumenProduccion );
  finally
    FreeAndNil( QRResumenProduccion );
  end;
end;

function GetPorcentaje( const AParcial, ATotal: Real ): string;
begin
  if ATotal >= 0 then
  begin
    if ATotal = 0 then
      Result:= '0,00%'
    else
      Result:= FormatFloat( '##0.00%', ( AParcial * 100 ) / ATotal );
  end
  else
  begin
    Result:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText36Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Sal1').AsFloat, DataSet.FieldByName('KilosOut').AsFloat );
end;

procedure TQRResumenProduccion.QRDBText38Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Sal2').AsFloat, DataSet.FieldByName('KilosOut').AsFloat );
end;

procedure TQRResumenProduccion.QRDBText40Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Sal3').AsFloat, DataSet.FieldByName('KilosOut').AsFloat );
end;

procedure TQRResumenProduccion.QRDBText41Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalDestrio').AsFloat, DataSet.FieldByName('KilosOut').AsFloat );
end;

procedure TQRResumenProduccion.QRDBText75Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosIni').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosIni').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('IniCampo').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosIni').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText53Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosFin').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosFin').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('FinCampo').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosFin').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText76Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosIni').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosIni').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('IniDestrio').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosIni').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText54Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosFin').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosFin').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('FinDestrio').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosFin').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText77Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosIni').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosIni').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('IniPrimera').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosIni').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText55Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosFin').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosFin').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('FinPrimera').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosFin').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText78Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosIni').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosIni').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('IniSegunda').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosIni').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText58Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosFin').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosFin').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('FinSegunda').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosFin').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText7Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosIni').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosIni').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('IniTercera').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosIni').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText9Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosFin').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosFin').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('FinTercera').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosFin').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText80Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosIni').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosIni').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('IniIntermedia1').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosIni').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText57Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosFin').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosFin').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('FinIntermedia1').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosFin').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText81Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosIni').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosIni').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('IniIntermedia2').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosIni').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText59Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosFin').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosFin').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('FinIntermedia2').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosFin').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText82Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosIni').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosIni').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('IniIntermedia').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosIni').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText60Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosFin').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosFin').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('FinIntermedia').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosFin').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText83Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosIni').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosIni').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('IniExpedicion1').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosIni').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText61Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosFin').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosFin').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('FinExpedicion1').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosFin').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText84Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosIni').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosIni').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('IniExpedicion2').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosIni').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText62Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosFin').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosFin').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('FinExpedicion2').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosFin').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText85Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosIni').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosIni').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('IniExpedicion').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosIni').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.QRDBText63Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('KilosFin').AsFloat >= 0 then
  begin
    if DataSet.FieldByName('KilosFin').AsFloat = 0 then
      Value:= '0,00%'
    else
      Value:= FormatFloat( '##0.00%', ( DataSet.FieldByName('FinExpedicion').AsFloat * 100 ) /
                                     DataSet.FieldByName('KilosFin').AsFloat );
  end
  else
  begin
    Value:= 'FALTA';
  end;
end;

procedure TQRResumenProduccion.qrdbtxtSalDestrio1Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Merma').AsFloat, DataSet.FieldByName('KilosProcesados').AsFloat );
end;

procedure TQRResumenProduccion.qrdbtxtIniCampoPrint(sender: TObject;
  var Value: String);
begin
 Value:= Value + ' - ' + desProducto( DataSet.FieldByName('empresa').AsString, Value )
end;

end.
