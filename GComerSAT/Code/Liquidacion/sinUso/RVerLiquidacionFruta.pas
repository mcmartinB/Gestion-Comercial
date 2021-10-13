unit RVerLiquidacionFruta;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;
type
  TQRVerLiquidacionFruta = class(TQuickRep)
    CabeceraPagina: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData2: TQRSysData;
    qrbndDetailBand1: TQRBand;
    qrdbtxtkilos: TQRDBText;
    qrbndSummaryBand1: TQRBand;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtcosechero2: TQRDBText;
    qrdbtxtcosechero: TQRDBText;
    qrdbtxtorigen: TQRDBText;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrshp1: TQRShape;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrshp3: TQRShape;
    qrshp4: TQRShape;
    bndcChildBand2: TQRChildBand;
    qrshp13: TQRShape;
    bndcChildBand3: TQRChildBand;
    qrlbl3: TQRLabel;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrxpr20: TQRExpr;
    qrshp6: TQRShape;
    qrshp8: TQRShape;
    qrshp9: TQRShape;
    qrshp10: TQRShape;
    qrshp11: TQRShape;
    bndcChildBand1: TQRChildBand;
    qrshp7: TQRShape;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrshp5: TQRShape;
    qrlbl13: TQRLabel;
    qrlbl15: TQRLabel;
    qrshp14: TQRShape;
    qrshp15: TQRShape;
    qrshp17: TQRShape;
    qrshp18: TQRShape;
    qrshp19: TQRShape;
    qrshp20: TQRShape;
    qrshp21: TQRShape;
    qrshp22: TQRShape;
    qrshp2: TQRShape;
    qrshp16: TQRShape;
    qrlbl16: TQRLabel;
    qrdbtxtcat: TQRDBText;
    qrxpr21: TQRExpr;
    QRDBText1: TQRDBText;
    qrlblRango: TQRLabel;
    qrdbtxtorigen1: TQRDBText;
    qrgrpCosechero: TQRGroup;
    qrbndPieCosechero: TQRBand;
    QRLabel2: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    qrxpr31: TQRExpr;
    qrshp12: TQRShape;
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: String);
    procedure qrdbtxtplantacion1Print(sender: TObject; var Value: String);
    procedure qrdbtxtorigen1Print(sender: TObject; var Value: String);
    procedure qrgrpCosecheroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel2Print(sender: TObject; var Value: String);

  private

  public
    procedure PreparaListado( const AEmpresa, ACentro, AProducto, ACosechero: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

  function VerLiquidacionFruta( const AOwner: TComponent; const AEmpresa, ACentro, AProducto, ACosechero: string;
                                const AFechaIni, AFechaFin: TDateTime; const AVerPlantaciones, AIncluirGastos, AIncluirAbonos: boolean ): boolean;

implementation

{$R *.DFM}

uses
 DVerLiquidacionFruta, DPreview, CReportes, UDMAuxDB;
 
var
  QRVerLiquidacionFruta: TQRVerLiquidacionFruta;
  DMVerLiquidacionFruta: TDMVerLiquidacionFruta;

procedure VerListado( const AOwner: TComponent; const AEmpresa, ACentro, AProducto, ACosechero: string;
                      const AFechaIni, AFechaFin: TDateTime );
begin
  QRVerLiquidacionFruta:= TQRVerLiquidacionFruta.Create( AOwner );
  try
    QRVerLiquidacionFruta.PreparaListado( AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin );
    Previsualiza( QRVerLiquidacionFruta );
  finally
    FreeAndNil(QRVerLiquidacionFruta);
  end;
end;

function VerLiquidacionFruta( const AOwner: TComponent; const AEmpresa, ACentro, AProducto, ACosechero: string;
                                const AFechaIni, AFechaFin: TDateTime; const AVerPlantaciones, AIncluirGastos, AIncluirAbonos: boolean ): boolean;
begin
  DMVerLiquidacionFruta:= TDMVerLiquidacionFruta.Create( AOwner );
  try
    if DMVerLiquidacionFruta.DatosLiquidacionFruta( AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin, AVerPlantaciones, AIncluirGastos, AIncluirAbonos ) then
    begin
      VerListado( AOwner, AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin );
      result:= True;
    end
    else
    begin
      result:= False;
    end;
  finally
    FreeAndNil(DMVerLiquidacionFruta);
  end;
end;

procedure TQRVerLiquidacionFruta.PreparaListado( const AEmpresa, ACentro, AProducto, ACosechero: string;
                              const AFechaIni, AFechaFin: TDateTime );
begin
  CReportes.PonLogoGrupoBonnysa( Self, AEmpresa );
  qrlblRango.Caption:= 'Liquidaciòn del ' + FormatDateTime('dd/mm/yyy', AFechaIni) + ' al ' + FormatDateTime('dd/mm/yyy', AFechaFin) + '.';
end;

procedure TQRVerLiquidacionFruta.qrdbtxtproducto1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByname('empresa').AsString, Value )
end;

procedure TQRVerLiquidacionFruta.qrdbtxtplantacion1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCosechero( DataSet.FieldByname('empresa').AsString, Value )
end;

procedure TQRVerLiquidacionFruta.qrdbtxtorigen1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( DataSet.FieldByname('empresa').AsString, Value )
end;

procedure TQRVerLiquidacionFruta.qrgrpCosecheroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Height:= 0;
end;

procedure TQRVerLiquidacionFruta.QRLabel2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + DataSet.FieldByname('cosechero').AsString + ' '+ desCosechero( DataSet.FieldByname('empresa').AsString,
                                   DataSet.FieldByname('cosechero').AsString );
end;

end.

