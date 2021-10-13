unit RDetalleLiquidacionFruta;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;
type
  TQRDetalleLiquidacionFruta = class(TQuickRep)
    CabeceraPagina: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData2: TQRSysData;
    qrbndDetailBand1: TQRBand;
    qrdbtxtentrada: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    qrdbtxttipo: TQRDBText;
    qrgrpCosechero: TQRGroup;
    qrdbtxtcosechero: TQRDBText;
    qrdbtxtcosechero1: TQRDBText;
    qrgrPlantacion: TQRGroup;
    qrxprImporte: TQRExpr;
    qrbndPieCosechero: TQRBand;
    qrlbl2: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    qrlbl3: TQRLabel;
    qrbndPiePlantacion: TQRBand;
    qrlbl4: TQRLabel;
    bndcChildBand1: TQRChildBand;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl14: TQRLabel;
    qrdbtxtcosechero2: TQRDBText;
    qrdbtxt1: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrxpr13: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrshp1: TQRShape;
    qrshp2: TQRShape;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr19: TQRExpr;
    qrshp3: TQRShape;
    qrshp4: TQRShape;
    qrxpr20: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr9: TQRExpr;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr12: TQRExpr;
    qrxpr21: TQRExpr;
    qrxpr22: TQRExpr;
    qrxpr23: TQRExpr;
    qrxpr24: TQRExpr;
    qrxpr25: TQRExpr;
    qrxpr26: TQRExpr;
    qrxpr27: TQRExpr;
    qrxpr28: TQRExpr;
    qrxpr29: TQRExpr;
    qrxpr31: TQRExpr;
    qrxpr32: TQRExpr;
    qrxpr33: TQRExpr;
    qrxpr34: TQRExpr;
    qrxpr35: TQRExpr;
    qrxpr36: TQRExpr;
    qrdbtxtorigen: TQRDBText;
    qrdbtxtorigen1: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    QRDBText1: TQRDBText;
    qrlblRango: TQRLabel;
    qrxpr11: TQRExpr;
    qrxpr30: TQRExpr;
    qrxpr37: TQRExpr;
    qrlbl19: TQRLabel;
    QRDBText2: TQRDBText;
    procedure qrlbl4Print(sender: TObject; var Value: String);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure qrlbl1Print(sender: TObject; var Value: String);
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcosechero1Print(sender: TObject; var Value: String);
    procedure qrdbtxtplantacion1Print(sender: TObject; var Value: String);
    procedure qrgrPlantacionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtorigen1Print(sender: TObject; var Value: String);

  private

  public
    procedure PreparaListado( const AEmpresa, ACentro, AProducto, ACosechero: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

  function DetalleLiquidacionFruta( const AOwner: TComponent; const AEmpresa, ACentro, AProducto, ACosechero: string;
                                const AFechaIni, AFechaFin: TDateTime ): boolean;

implementation

{$R *.DFM}

uses
 DDetalleLiquidacionFruta, DPreview, CReportes, UDMAuxDB;
 
var
  QRDetalleLiquidacionFruta: TQRDetalleLiquidacionFruta;
  DMDetalleLiquidacionFruta: TDMDetalleLiquidacionFruta;

procedure VerListado( const AOwner: TComponent; const AEmpresa, ACentro, AProducto, ACosechero: string;
                      const AFechaIni, AFechaFin: TDateTime );
begin
  QRDetalleLiquidacionFruta:= TQRDetalleLiquidacionFruta.Create( AOwner );
  try
    QRDetalleLiquidacionFruta.PreparaListado( AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin );
    Previsualiza( QRDetalleLiquidacionFruta );
  finally
    FreeAndNil(QRDetalleLiquidacionFruta);
  end;
end;

function DetalleLiquidacionFruta( const AOwner: TComponent; const AEmpresa, ACentro, AProducto, ACosechero: string;
                                const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  DMDetalleLiquidacionFruta:= TDMDetalleLiquidacionFruta.Create( AOwner );
  try
    if DMDetalleLiquidacionFruta.DatosLiquidacionFruta( AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin ) then
    begin
      VerListado( AOwner, AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin );
      result:= True;
    end
    else
    begin
      result:= False;
    end;
  finally
    FreeAndNil(DMDetalleLiquidacionFruta);
  end;
end;

procedure TQRDetalleLiquidacionFruta.PreparaListado( const AEmpresa, ACentro, AProducto, ACosechero: string;
                              const AFechaIni, AFechaFin: TDateTime );
begin
  CReportes.PonLogoGrupoBonnysa( Self, AEmpresa );
  qrlblRango.Caption:= 'Liquidaciòn del ' + FormatDateTime('dd/mm/yyy', AFechaIni) + ' al ' + FormatDateTime('dd/mm/yyy', AFechaFin) + '.';
end;

procedure TQRDetalleLiquidacionFruta.qrlbl4Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + desPlantacion( DataSet.FieldByname('empresa').AsString,
                           DataSet.FieldByname('producto').AsString,
                           DataSet.FieldByname('cosechero').AsString,
                           DataSet.FieldByname('plantacion').AsString,
                           DataSet.FieldByname('anyo_sem').AsString );
end;

procedure TQRDetalleLiquidacionFruta.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + desCosechero( DataSet.FieldByname('empresa').AsString,
                                   DataSet.FieldByname('cosechero').AsString );
end;

procedure TQRDetalleLiquidacionFruta.qrlbl1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + desProducto( DataSet.FieldByname('empresa').AsString,
                                  DataSet.FieldByname('producto').AsString );
end;

procedure TQRDetalleLiquidacionFruta.qrdbtxtproducto1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByname('empresa').AsString, Value )
end;

procedure TQRDetalleLiquidacionFruta.qrdbtxtcosechero1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCosechero( DataSet.FieldByname('empresa').AsString, Value )
end;

procedure TQRDetalleLiquidacionFruta.qrdbtxtplantacion1Print(sender: TObject;
  var Value: String);
begin
  Value:= desPlantacion( DataSet.FieldByname('empresa').AsString,
                           DataSet.FieldByname('producto').AsString,
                           DataSet.FieldByname('cosechero').AsString,
                           Value, DataSet.FieldByname('anyo_sem').AsString )
end;

procedure TQRDetalleLiquidacionFruta.qrgrPlantacionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Sender.Height:= 0;
end;

procedure TQRDetalleLiquidacionFruta.qrdbtxtorigen1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( DataSet.FieldByname('empresa').AsString, Value )
end;

end.

