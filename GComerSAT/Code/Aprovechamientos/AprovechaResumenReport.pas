unit AprovechaResumenReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, grimgctrl;

type
  TQRAprovechaResumen = class(TQuickRep)
    QRBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblFecha: TQRLabel;
    lblCentro: TQRLabel;
    lblProducto: TQRLabel;
    QRBand2: TQRBand;
    QRDBText94: TQRDBText;
    QRDBText95: TQRDBText;
    QRDBText96: TQRDBText;
    QRDBText97: TQRDBText;
    QRDBText98: TQRDBText;
    QRDBText99: TQRDBText;
    QRDBText100: TQRDBText;
    QRDBText101: TQRDBText;
    QRDBText102: TQRDBText;
    QRDBText103: TQRDBText;
    QRDBText104: TQRDBText;
    QRDBText105: TQRDBText;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    lblInventarioIni: TQRLabel;
    lblInventarioFin: TQRLabel;
    QRLabel50: TQRLabel;
    QRPDFShape22: TQRPDFShape;
    QRPDFShape30: TQRPDFShape;
    QRPDFShape31: TQRPDFShape;
    QRPDFShape32: TQRPDFShape;
    QRPDFShape33: TQRPDFShape;
    QRPDFShape34: TQRPDFShape;
    QRDBText106: TQRDBText;
    QRDBText107: TQRDBText;
    QRDBText108: TQRDBText;
    QRDBText109: TQRDBText;
    QRDBText110: TQRDBText;
    QRDBText111: TQRDBText;
    QRDBText112: TQRDBText;
    QRDBText113: TQRDBText;
    QRDBText114: TQRDBText;
    QRDBText115: TQRDBText;
    QRLabel51: TQRLabel;
    QRLabel52: TQRLabel;
    QRDBText116: TQRDBText;
    QRDBText117: TQRDBText;
    QRDBText118: TQRDBText;
    QRDBText119: TQRDBText;
    QRDBText120: TQRDBText;
    QRDBText121: TQRDBText;
    QRLabel53: TQRLabel;
    QRDBText122: TQRDBText;
    QRDBText123: TQRDBText;
    QRDBText124: TQRDBText;
    QRDBText125: TQRDBText;
    QRDBText126: TQRDBText;
    QRDBText127: TQRDBText;
    QRLabel54: TQRLabel;
    QRLabel55: TQRLabel;
    QRLabel56: TQRLabel;
    QRLabel57: TQRLabel;
    QRPDFShape35: TQRPDFShape;
    QRPDFShape36: TQRPDFShape;
    QRPDFShape37: TQRPDFShape;
    QRPDFShape38: TQRPDFShape;
    QRPDFShape39: TQRPDFShape;
    QRPDFShape40: TQRPDFShape;
    QRPDFShape41: TQRPDFShape;
    QRLabel58: TQRLabel;
    QRDBText128: TQRDBText;
    QRDBText129: TQRDBText;
    QRDBText130: TQRDBText;
    QRDBText131: TQRDBText;
    QRLabel59: TQRLabel;
    QRLabel60: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRPDFShape42: TQRPDFShape;
    QRPDFShape43: TQRPDFShape;
    QRPDFShape44: TQRPDFShape;
    QRPDFShape45: TQRPDFShape;
    QRPDFShape46: TQRPDFShape;
    QRPDFShape47: TQRPDFShape;
    QRDBText132: TQRDBText;
    QRLabel63: TQRLabel;
    QRPDFShape48: TQRPDFShape;
    QRDBText133: TQRDBText;
    QRDBText134: TQRDBText;
    QRDBText135: TQRDBText;
    QRDBText136: TQRDBText;
    QRDBText137: TQRDBText;
    QRDBText138: TQRDBText;
    QRDBText139: TQRDBText;
    QRDBText140: TQRDBText;
    QRDBText141: TQRDBText;
    QRDBText142: TQRDBText;
    QRDBText143: TQRDBText;
    QRDBText144: TQRDBText;
    QRDBText145: TQRDBText;
    QRDBText146: TQRDBText;
    QRDBText147: TQRDBText;
    QRDBText148: TQRDBText;
    QRDBText149: TQRDBText;
    QRDBText150: TQRDBText;
    QRDBText151: TQRDBText;
    QRDBText152: TQRDBText;
    QRDBText153: TQRDBText;
    QRDBText154: TQRDBText;
    QRDBText155: TQRDBText;
    QRDBText156: TQRDBText;
    QRDBText157: TQRDBText;
    QRDBText158: TQRDBText;
    QRDBText159: TQRDBText;
    QRDBText160: TQRDBText;
    QRDBText161: TQRDBText;
    QRDBText162: TQRDBText;
    QRDBText163: TQRDBText;
    QRDBText164: TQRDBText;
    QRDBText165: TQRDBText;
    QRPDFShape49: TQRPDFShape;
    QRLabel64: TQRLabel;
    QRLabel65: TQRLabel;
    QRDBText166: TQRDBText;
    QRDBText167: TQRDBText;
    QRLabel66: TQRLabel;
    QRDBText172: TQRDBText;
    QRLabel67: TQRLabel;
    QRPDFShape50: TQRPDFShape;
    QRPDFShape51: TQRPDFShape;
    QRPDFShape53: TQRPDFShape;
    QRPDFShape54: TQRPDFShape;
    QRPDFShape55: TQRPDFShape;
    QRPDFShape56: TQRPDFShape;
    QRDBText181: TQRDBText;
    QRDBText184: TQRDBText;
    QRLabel71: TQRLabel;
    QRLabel1: TQRLabel;
    QRPDFShape1: TQRPDFShape;
    QRLabel2: TQRLabel;
    QRPDFShape2: TQRPDFShape;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    qreSalInventario3: TQRDBText;
    QRDBText15: TQRDBText;
    qreSalInventarioDestrio: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText18: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText19: TQRDBText;
    QRDBText20: TQRDBText;
    QRDBText21: TQRDBText;
    QRDBText22: TQRDBText;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText25: TQRDBText;
    QRDBText26: TQRDBText;
    QRDBText27: TQRDBText;
    QRPDFShape5: TQRPDFShape;
    QRPDFShape6: TQRPDFShape;
    QRPDFShape8: TQRPDFShape;
    QRLabel15: TQRLabel;
    QRDBText37: TQRDBText;
    QRDBText38: TQRDBText;
    QRDBText39: TQRDBText;
    QRDBText40: TQRDBText;
    QRDBText41: TQRDBText;
    QRDBText42: TQRDBText;
    QRDBText45: TQRDBText;
    QRDBText28: TQRDBText;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRPDFShape7: TQRPDFShape;
    QRPDFShape11: TQRPDFShape;
    QRLabel20: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape1: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText35: TQRDBText;
    QRDBText36: TQRDBText;
    QRDBText46: TQRDBText;
    QRDBText47: TQRDBText;
    QRDBText48: TQRDBText;
    QRDBText51: TQRDBText;
    QRDBText52: TQRDBText;
    qre22: TQRDBText;
    qre23: TQRDBText;
    qre24: TQRDBText;
    qre25: TQRDBText;
    qre26: TQRDBText;
    qreespecial3: TQRDBText;
    QRPDFShape3: TQRPDFShape;
    qrlMerma: TQRLabel;
    ObjetivoTotalDestrio: TQRDBText;
    qre2: TQRDBText;
    ObjetivoNormalDestrio: TQRDBText;
    qre4: TQRDBText;
    QRLabel14: TQRLabel;
    QRDBText43: TQRDBText;
    QRDBText44: TQRDBText;
    QRDBText49: TQRDBText;
    QRDBText50: TQRDBText;
    QRDBText63: TQRDBText;
    QRDBText64: TQRDBText;
    QRDBText65: TQRDBText;
    QRLabel23: TQRLabel;
    QRDBText66: TQRDBText;
    QRDBText67: TQRDBText;
    QRDBText68: TQRDBText;
    QRDBText69: TQRDBText;
    QRDBText70: TQRDBText;
    QRDBText71: TQRDBText;
    QRDBText72: TQRDBText;
    QRPDFShape4: TQRPDFShape;
    QRLabel24: TQRLabel;
    qre1: TQRDBText;
    qre3: TQRDBText;
    qre5: TQRDBText;
    qre6: TQRDBText;
    qre7: TQRDBText;
    qre8: TQRDBText;
    qre9: TQRDBText;
    qre10: TQRDBText;
    qre11: TQRDBText;
    QRPDFShape9: TQRPDFShape;
    qrl1: TQRLabel;
    qre12: TQRDBText;
    qre13: TQRDBText;
    qre14: TQRDBText;
    qre15: TQRDBText;
    qre16: TQRDBText;
    qre17: TQRDBText;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrpdfshp1: TQRPDFShape;
    qre18: TQRDBText;
    qre19: TQRDBText;
    qre20: TQRDBText;
    qre21: TQRDBText;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrl8: TQRLabel;
    QRLabel10: TQRLabel;
    qrdbtxtEscandallod: TQRDBText;
    qrdbtxtEscandalloD1: TQRDBText;
    qrdbtxtSeleccionadoD1: TQRDBText;
    qrdbtxtSeleccionadoD: TQRDBText;
    qrdbtxtIndustriaD: TQRDBText;
    qrdbtxtIndustriaD1: TQRDBText;
    qrdbtxtcompraD: TQRDBText;
    qrdbtxtcompraD1: TQRDBText;
    qrdbtxtNormalD: TQRDBText;
    qrdbtxtNormalD1: TQRDBText;
    procedure QRDBText36Print(sender: TObject; var Value: String);
    procedure QRDBText38Print(sender: TObject; var Value: String);
    procedure QRDBText40Print(sender: TObject; var Value: String);
    procedure QRDBText41Print(sender: TObject; var Value: String);
    procedure QRDBText42Print(sender: TObject; var Value: String);
    procedure QRDBText43Print(sender: TObject; var Value: String);
    procedure QRDBText45Print(sender: TObject; var Value: String);
    procedure QRDBText46Print(sender: TObject; var Value: String);
    procedure Normal1Porcentajes(sender: TObject; var Value: String);
    procedure Normal2Porcentajes(sender: TObject; var Value: String);
    procedure Normal3Porcentajes(sender: TObject; var Value: String);
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
    procedure QRDBText181Print(sender: TObject; var Value: String);
    procedure QRDBText184Print(sender: TObject; var Value: String);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRDBText5Print(sender: TObject; var Value: String);
    procedure QRDBText7Print(sender: TObject; var Value: String);
    procedure QRDBText9Print(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure QRDBText13Print(sender: TObject; var Value: String);
    procedure QRDBText15Print(sender: TObject; var Value: String);
    procedure QRDBText17Print(sender: TObject; var Value: String);
    procedure QRDBText20Print(sender: TObject; var Value: String);
    procedure QRDBText22Print(sender: TObject; var Value: String);
    procedure QRDBText24Print(sender: TObject; var Value: String);
    procedure QRDBText26Print(sender: TObject; var Value: String);
    procedure QRDBText35Print(sender: TObject; var Value: String);
    procedure QRDBText46bPrint(sender: TObject; var Value: String);
    procedure QRDBText48bPrint(sender: TObject; var Value: String);
    procedure QRDBText52bPrint(sender: TObject; var Value: String);
    procedure QRDBText38bPrint(sender: TObject; var Value: String);
    procedure QRDBText40bPrint(sender: TObject; var Value: String);
    procedure QRDBText42bPrint(sender: TObject; var Value: String);
    procedure QRDBText28Print(sender: TObject; var Value: String);
    procedure qre2Print(sender: TObject; var Value: String);
    procedure qre4Print(sender: TObject; var Value: String);
    procedure QRDBText142Print(sender: TObject; var Value: String);
    procedure QRDBText64Print(sender: TObject; var Value: String);
    procedure QRDBText67Print(sender: TObject; var Value: String);
    procedure QRDBText69Print(sender: TObject; var Value: String);
    procedure QRDBText71Print(sender: TObject; var Value: String);
    procedure QRDBText141Print(sender: TObject; var Value: String);
    procedure QRDBText44Print(sender: TObject; var Value: String);
    procedure QRDBText50Print(sender: TObject; var Value: String);
    procedure qre3Print(sender: TObject; var Value: String);
    procedure qre6Print(sender: TObject; var Value: String);
    procedure qre8Print(sender: TObject; var Value: String);
    procedure qre10Print(sender: TObject; var Value: String);
    procedure qre13Print(sender: TObject; var Value: String);
    procedure qre15Print(sender: TObject; var Value: String);
    procedure qre17Print(sender: TObject; var Value: String);
    procedure qre23Print(sender: TObject; var Value: String);
    procedure qre25Print(sender: TObject; var Value: String);
    procedure qreespecial3Print(sender: TObject; var Value: String);
    procedure qre19Print(sender: TObject; var Value: String);
    procedure qre21Print(sender: TObject; var Value: String);
    procedure qrdbtxtEscandalloD1Print(sender: TObject; var Value: String);
    procedure qrdbtxtSeleccionadoDPrint(sender: TObject;
      var Value: String);
    procedure qrdbtxtIndustriaD1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcompraD1Print(sender: TObject; var Value: String);
    procedure qrdbtxtNormalD1Print(sender: TObject; var Value: String);
  private

  public

  end;

procedure PrintAprovechaResumen( const AOwner: TComponent;
                                 const AEmpresa, ACentro, AProducto: string;
                                 const AFechaIni, AFechaFin: TDateTime );

implementation

{$R *.DFM}

uses
  AprovechaResumenData, DPreview, CReportes, UDMAuxDB;

var
  QRAprovechaResumen: TQRAprovechaResumen;

procedure PrintAprovechaResumen( const AOwner: TComponent;
                                 const AEmpresa, ACentro, AProducto: string;
                                 const AFechaIni, AFechaFin: TDateTime );
begin
  QRAprovechaResumen:= TQRAprovechaResumen.Create( AOwner );
  try
    PonLogoGrupoBonnysa(QRAprovechaResumen, AEmpresa);
    QRAprovechaResumen.lblCentro.Caption:= ACentro + ' ' + desCentro( AEmpresa, ACentro );
    QRAprovechaResumen.lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto );
    QRAprovechaResumen.lblFecha.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin ) ;
    QRAprovechaResumen.lblInventarioIni.Caption:= DateToStr( AFechaIni - 1 );
    QRAprovechaResumen.lblInventarioFin.Caption:= DateToStr( AFechaFin );
    Previsualiza( QRAprovechaResumen );
  finally
    FreeAndNil( QRAprovechaResumen );
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

procedure TQRAprovechaResumen.QRDBText36Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Sal1').AsFloat, DataSet.FieldByName('KilosOut').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText38Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Sal2').AsFloat, DataSet.FieldByName('KilosOut').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText40Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Sal3').AsFloat, DataSet.FieldByName('KilosOut').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText41Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalDestrio').AsFloat, DataSet.FieldByName('KilosOut').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText42Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Escandallo1').AsFloat, DataSet.FieldByName('KilosIn').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText43Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Escandallo2').AsFloat, DataSet.FieldByName('KilosIn').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText45Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Escandallo3').AsFloat, DataSet.FieldByName('KilosIn').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText46Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Seleccionado1').AsFloat, DataSet.FieldByName('Seleccionado').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText141Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Seleccionado2').AsFloat, DataSet.FieldByName('Seleccionado').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText142Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Seleccionado3').AsFloat, DataSet.FieldByName('Seleccionado').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText44Print(sender: TObject;
  var Value: String);
begin
    Value:= GetPorcentaje( DataSet.FieldByName('Industria1').AsFloat, DataSet.FieldByName('Industria').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText50Print(sender: TObject;
  var Value: String);
begin
    Value:= GetPorcentaje( DataSet.FieldByName('Industria2').AsFloat, DataSet.FieldByName('Industria').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText64Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Industria3').AsFloat, DataSet.FieldByName('Industria').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText67Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Compra1').AsFloat, DataSet.FieldByName('Compra').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText69Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Compra2').AsFloat, DataSet.FieldByName('Compra').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText71Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Compra3').AsFloat, DataSet.FieldByName('Compra').AsFloat );
end;

procedure TQRAprovechaResumen.Normal1Porcentajes(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Normal1').AsFloat, DataSet.FieldByName('Normal').AsFloat );
end;

procedure TQRAprovechaResumen.Normal2Porcentajes(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Normal2').AsFloat, DataSet.FieldByName('Normal').AsFloat );
end;

procedure TQRAprovechaResumen.Normal3Porcentajes(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Normal3').AsFloat, DataSet.FieldByName('Normal').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalInventario1').AsFloat, DataSet.FieldByName('SalInventario').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText13Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalInventario2').AsFloat, DataSet.FieldByName('SalInventario').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText15Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalInventario3').AsFloat, DataSet.FieldByName('SalInventario').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText17Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalInventarioDestrio').AsFloat, DataSet.FieldByName('SalInventario').AsFloat );
end;

procedure TQRAprovechaResumen.qre3Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalSinMerma1').AsFloat, DataSet.FieldByName('SalSinMerma').AsFloat );
end;

procedure TQRAprovechaResumen.qre6Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalSinMerma2').AsFloat, DataSet.FieldByName('SalSinMerma').AsFloat );
end;

procedure TQRAprovechaResumen.qre8Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalSinMerma3').AsFloat, DataSet.FieldByName('SalSinMerma').AsFloat );
end;

procedure TQRAprovechaResumen.qre10Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalSinMermaDestrio').AsFloat, DataSet.FieldByName('SalSinMerma').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText20Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalConMerma1').AsFloat, DataSet.FieldByName('SalConMerma').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText22Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalConMerma2').AsFloat, DataSet.FieldByName('SalConMerma').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText24Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalConMerma3').AsFloat, DataSet.FieldByName('SalConMerma').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText26Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SalConMermaDestrio').AsFloat, DataSet.FieldByName('SalConMerma').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText181Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Merma').AsFloat, DataSet.FieldByName('KilosIn').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText184Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Merma').AsFloat, DataSet.FieldByName('ConMerma').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Merma').AsFloat, DataSet.FieldByName('Procesados').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText5Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Merma').AsFloat, DataSet.FieldByName('Confeccionados').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText35Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteEntradas1').AsFloat, DataSet.FieldByName('AjusteEntradas').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText46bPrint(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteEntradas2').AsFloat, DataSet.FieldByName('AjusteEntradas').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText48bPrint(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteEntradas3').AsFloat, DataSet.FieldByName('AjusteEntradas').AsFloat );
end;

procedure TQRAprovechaResumen.qre2Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteEntradasDestrio').AsFloat, DataSet.FieldByName('AjusteEntradas').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText52bPrint(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteEntradasMerma').AsFloat, DataSet.FieldByName('AjusteEntradas').AsFloat );
end;

procedure TQRAprovechaResumen.qre13Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SinMerma1').AsFloat, DataSet.FieldByName('SinMerma').AsFloat );
end;

procedure TQRAprovechaResumen.qre15Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SinMerma2').AsFloat, DataSet.FieldByName('SinMerma').AsFloat );
end;

procedure TQRAprovechaResumen.qre17Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SinMerma3').AsFloat, DataSet.FieldByName('SinMerma').AsFloat );
end;

procedure TQRAprovechaResumen.qre23Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteCompras1').AsFloat, DataSet.FieldByName('AjusteCompras').AsFloat );
end;

procedure TQRAprovechaResumen.qre25Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteCompras2').AsFloat, DataSet.FieldByName('AjusteCompras').AsFloat );
end;

procedure TQRAprovechaResumen.qreespecial3Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteCompras3').AsFloat, DataSet.FieldByName('AjusteCompras').AsFloat );
end;

procedure TQRAprovechaResumen.qre19Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteComprasDestrio').AsFloat, DataSet.FieldByName('AjusteCompras').AsFloat );
end;

procedure TQRAprovechaResumen.qre21Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteComprasMerma').AsFloat, DataSet.FieldByName('AjusteCompras').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText38bPrint(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteNormal1').AsFloat, DataSet.FieldByName('AjusteNormal').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText40bPrint(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteNormal2').AsFloat, DataSet.FieldByName('AjusteNormal').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText42bPrint(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteNormal3').AsFloat, DataSet.FieldByName('AjusteNormal').AsFloat );
end;

procedure TQRAprovechaResumen.qre4Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteNormalDestrio').AsFloat, DataSet.FieldByName('AjusteNormal').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText28Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('AjusteNormalMerma').AsFloat, DataSet.FieldByName('AjusteNormal').AsFloat );
end;

procedure TQRAprovechaResumen.QRDBText75Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText53Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText76Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText54Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText77Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText55Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText78Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText58Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText7Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText9Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText80Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText57Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText81Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText59Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText82Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText60Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText83Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText61Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText84Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText62Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText85Print(sender: TObject;
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

procedure TQRAprovechaResumen.QRDBText63Print(sender: TObject;
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

procedure TQRAprovechaResumen.qrdbtxtEscandalloD1Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('EscandalloD').AsFloat, DataSet.FieldByName('KilosIn').AsFloat );
end;

procedure TQRAprovechaResumen.qrdbtxtSeleccionadoDPrint(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('SeleccionadoD').AsFloat, DataSet.FieldByName('Seleccionado').AsFloat );
end;

procedure TQRAprovechaResumen.qrdbtxtIndustriaD1Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('IndustriaD').AsFloat, DataSet.FieldByName('Industria').AsFloat );
end;

procedure TQRAprovechaResumen.qrdbtxtcompraD1Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('CompraD').AsFloat, DataSet.FieldByName('Compra').AsFloat );
end;

procedure TQRAprovechaResumen.qrdbtxtNormalD1Print(sender: TObject;
  var Value: String);
begin
  Value:= GetPorcentaje( DataSet.FieldByName('Normal').AsFloat, DataSet.FieldByName('Normal').AsFloat );
end;

end.
