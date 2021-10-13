unit RVerLiquidacionFrutaEx;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;
type
  TQRVerLiquidacionFrutaEx = class(TQuickRep)
    CabeceraPagina: TQRBand;
    QRSysData2: TQRSysData;
    qrbndDetailBand1: TQRBand;
    qrgrpCosechero: TQRGroup;
    qrdbtxtcosechero: TQRDBText;
    qrdbtxtcosechero1: TQRDBText;
    qrbndPieCosechero: TQRBand;
    qrlbl2: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    qrlbl3: TQRLabel;
    qrdbtxt1: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtorigen: TQRDBText;
    QRDBText1: TQRDBText;
    qrlblRango: TQRLabel;
    qrdbtxtorigen1: TQRDBText;
    bndcChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    qrshp15: TQRShape;
    qrshp14: TQRShape;
    qrshp7: TQRShape;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl5: TQRLabel;
    QRLabel2: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrshp5: TQRShape;
    qrlbl13: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl1: TQRLabel;
    qrxpr13: TQRExpr;
    qrxpr1: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr8: TQRExpr;
    qrshp17: TQRShape;
    qrshp13: TQRShape;
    qrshp18: TQRShape;
    qrdbtxtkilos: TQRDBText;
    qrxpr21: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrxpr20: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr22: TQRExpr;
    qrxpr23: TQRExpr;
    qrxpr24: TQRExpr;
    qrxpr25: TQRExpr;
    qrxpr26: TQRExpr;
    qrxpr27: TQRExpr;
    qrxpr28: TQRExpr;
    qrxpr29: TQRExpr;
    qrxpr30: TQRExpr;
    qrxpr31: TQRExpr;
    qrxpr32: TQRExpr;
    qrshp1: TQRShape;
    qrshp12: TQRShape;
    qrshp6: TQRShape;
    qrshp8: TQRShape;
    procedure qrlbl4Print(sender: TObject; var Value: String);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure qrlbl1Print(sender: TObject; var Value: String);
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcosechero1Print(sender: TObject; var Value: String);
    procedure qrdbtxtplantacion1Print(sender: TObject; var Value: String);
    procedure qrdbtxtorigen1Print(sender: TObject; var Value: String);

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
  QRVerLiquidacionFrutaEx: TQRVerLiquidacionFrutaEx;
  DMVerLiquidacionFruta: TDMVerLiquidacionFruta;

procedure VerListado( const AOwner: TComponent; const AEmpresa, ACentro, AProducto, ACosechero: string;
                      const AFechaIni, AFechaFin: TDateTime );
begin
  QRVerLiquidacionFrutaEx:= TQRVerLiquidacionFrutaEx.Create( AOwner );
  try
    QRVerLiquidacionFrutaEx.PreparaListado( AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin );
    Previsualiza( QRVerLiquidacionFrutaEx );
  finally
    FreeAndNil(QRVerLiquidacionFrutaEx);
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

procedure TQRVerLiquidacionFrutaEx.PreparaListado( const AEmpresa, ACentro, AProducto, ACosechero: string;
                              const AFechaIni, AFechaFin: TDateTime );
begin
  CReportes.PonLogoGrupoBonnysa( Self, AEmpresa );
  qrlblRango.Caption:= 'Liquidaciòn del ' + FormatDateTime('dd/mm/yyy', AFechaIni) + ' al ' + FormatDateTime('dd/mm/yyy', AFechaFin) + '.';
end;

procedure TQRVerLiquidacionFrutaEx.qrlbl4Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + desPlantacionEx( DataSet.FieldByname('empresa').AsString,
                           DataSet.FieldByname('producto').AsString,
                           DataSet.FieldByname('cosechero').AsString,
                           DataSet.FieldByname('plantacion').AsString,
                           DataSet.FieldByname('fecha').AsString );
end;

procedure TQRVerLiquidacionFrutaEx.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + DataSet.FieldByname('cosechero').AsString + ' '+ desCosechero( DataSet.FieldByname('empresa').AsString,
                                   DataSet.FieldByname('cosechero').AsString );
end;

procedure TQRVerLiquidacionFrutaEx.qrlbl1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + desProducto( DataSet.FieldByname('empresa').AsString,
                                  DataSet.FieldByname('producto').AsString );
end;

procedure TQRVerLiquidacionFrutaEx.qrdbtxtproducto1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByname('empresa').AsString, Value )
end;

procedure TQRVerLiquidacionFrutaEx.qrdbtxtcosechero1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCosechero( DataSet.FieldByname('empresa').AsString, Value )
end;

procedure TQRVerLiquidacionFrutaEx.qrdbtxtplantacion1Print(sender: TObject;
  var Value: String);
begin
  Value:= desPlantacion( DataSet.FieldByname('empresa').AsString,
                           DataSet.FieldByname('producto').AsString,
                           DataSet.FieldByname('cosechero').AsString,
                           Value, DataSet.FieldByname('anyo_sem').AsString )
end;

procedure TQRVerLiquidacionFrutaEx.qrdbtxtorigen1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( DataSet.FieldByname('empresa').AsString, Value )
end;

end.

