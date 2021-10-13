unit RecadvQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLRecadv = class(TQuickRep)
    TitleBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    lblCliente: TQRLabel;
    lblRangoFechas: TQRLabel;
    QRLabel8: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRSubDetail1: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    bndCabLin: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRSubDetail2: TQRSubDetail;
    codigo: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    palets: TQRDBText;
    cajas: TQRDBText;
    unidades: TQRDBText;
    QRDBText22: TQRDBText;
    bndCabAlb: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    ChildBand2: TQRChildBand;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText25: TQRDBText;
    QRDBText26: TQRDBText;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRDBText27: TQRDBText;
    QRLabel25: TQRLabel;
    bndPieRecadv: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    bndPieAlbaran: TQRBand;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRLabel19: TQRLabel;
    QRDBText14: TQRDBText;
    QRDBText17: TQRDBText;
    QRLabel20: TQRLabel;
    QRLabel26: TQRLabel;
    procedure QRDBText14Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRLabel20Print(sender: TObject; var Value: String);
    procedure QRDBText27Print(sender: TObject; var Value: String);
  private
    sEmpresa: string;
    rTotal: real;
    sCliente: string;

  public
    procedure PreparaListado( const AEmpresa, APedido, AAlbaran: string;
                              const AFecha: TDateTime );
  end;

  procedure VerListadoRecadv( const AOwner: TComponent );

implementation

{$R *.DFM}

uses
  RecadvDL, CReportes, DPreview, UDMAuxDB;

var
  QLRecadv: TQLRecadv;

procedure VerListadoRecadv( const AOwner: TComponent );
begin
  QLRecadv:= TQLRecadv.Create( AOwner );
  try
    DLRecadv.ObtenerDatosListado;
    QLRecadv.PreparaListado(DLRecadv.QCab.FieldByName('empresa').AsString,
                            DLRecadv.QCab.FieldByName('pedido').AsString,
                            DLRecadv.QCab.FieldByName('albaran').AsString,
                            DLRecadv.QCab.FieldByName('fecha').AsDateTime );
    Previsualiza( QLRecadv );
  finally
    DLRecadv.CerrarDatosListado;
    FreeAndNil( QLRecadv );
  end;
end;

procedure TQLRecadv.PreparaListado( const AEmpresa, APedido, AAlbaran: string;
                                    const AFecha: TDateTime );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );

  sEmpresa:= AEmpresa;
  lblRangoFechas.Caption:= 'Fecha ' + DateToStr(AFecha);

  sCliente:= DLRecadv.QAlbaranCabList.FieldByName('cliente_sal_sc').AsString;
  lblCliente.Caption:= sCliente + ' ' + DesCliente( sCliente );
end;

procedure TQLRecadv.QRDBText14Print(sender: TObject; var Value: String);
begin
  if Value = 'K' then
  begin
    rTotal:= rTotal + QRSubDetail2.DataSet.FieldByname('kilos2').AsFloat;
    Value:= FormatFloat( '0.00', QRSubDetail2.DataSet.FieldByname('kilos2').AsFloat );
  end
  else
  if Value = 'U' then
  begin
    rTotal:= rTotal + QRSubDetail2.DataSet.FieldByname('unidades2').AsFloat;
    Value:= FormatFloat( '0.00', QRSubDetail2.DataSet.FieldByname('unidades2').AsFloat );
  end
  else
  if Value = 'C' then
  begin
    rTotal:= rTotal + QRSubDetail2.DataSet.FieldByname('cajas2').AsFloat;
    Value:= FormatFloat( '0.00', QRSubDetail2.DataSet.FieldByname('cajas2').AsFloat );
  end;
end;

procedure TQLRecadv.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rTotal:= 0;
end;

procedure TQLRecadv.QRLabel20Print(sender: TObject; var Value: String);
begin
  Value:= FormatFloat( '0.00', rTotal );
end;

procedure TQLRecadv.QRDBText27Print(sender: TObject; var Value: String);
begin
  Value:= VAlue + ' '  + desSuministro( sEmpresa, sCliente, value );
end;

end.
