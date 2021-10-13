unit QRControlFob;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRControlFob = class(TQuickRep)
    CabPagina: TQRBand;
    PiePagina: TQRBand;
    Detalle: TQRBand;
    CabColumna: TQRBand;
    etqReferencia: TQRDBText;
    etqFecha: TQRDBText;
    etqKilos: TQRDBText;
    etqVendidos: TQRDBText;
    etqFacturado: TQRExpr;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    lblVendidos: TQRLabel;
    lblFacturado: TQRLabel;
    lblRango: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRSysData3: TQRSysData;
    CabGrupo: TQRGroup;
    PieGrupo: TQRBand;
    QRLabel7: TQRLabel;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRLabel8: TQRLabel;
    lblProducto: TQRLabel;
    lblCentro: TQRLabel;
    etqCentro: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel1: TQRLabel;
    lblCategorias: TQRLabel;
    procedure etqFacturadoPrint(sender: TObject; var Value: string);
    procedure QuickRepStartPage(Sender: TCustomQuickRep);
    procedure CabColumnaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    iColumna: Integer;
    bSalidas: Boolean;

    procedure ConfigurarDataSets(const ASalidas: Boolean; const ATipo: integer);
  public

  end;

procedure Previsualizar(const AEmpresa, ACEntro, AProducto, AInicio, AFin: string;
  const ATipoListado: Integer; const ATitulo: string);

implementation

uses UDMControlFob, CReportes, DPreview, UDMAuxDB;

{$R *.DFM}

procedure Previsualizar(const AEmpresa, ACEntro, AProducto, AInicio, AFin: string;
  const ATipoListado: Integer; const ATitulo: string);
var
  RControlFob: TRControlFob;
begin
  RControlFob := TRControlFob.Create(nil);
  try
    if AProducto <> '' then
      RControlFob.lblProducto.Caption := AProducto + ' ' + desProducto(AEmpresa, AProducto)
    else
      RControlFob.lblProducto.Caption:= 'TODOS LOS PRODUCTOS';
    RControlFob.lblCentro.Caption := ACentro + ' ' + desCentro(AEmpresa, ACentro);
    RControlFob.lblRango.Caption := 'Del ' + AInicio + ' al ' + AFin;
    RControlFob.bSalidas := ATipoListado < 3;
    RControlFob.ReportTitle := AnsiUpperCase('- ' + ATitulo + ' -');
    PonLogoGrupoBonnysa(RControlFob, AEmpresa);

    RControlFob.ConfigurarDataSets(RControlFob.bSalidas, ATipoListado);

    Preview(RControlFob);
  except
    FreeANdNil(RControlFob);
    raise;
  end;
end;

procedure TRControlFob.ConfigurarDataSets(const ASalidas: Boolean; const ATipo: integer);
begin
  if bSalidas then
  begin
    DataSet := DMControlFob.CDSSalidas;
    DMControlFob.CDSSalidas.Filtered := True;
    lblFacturado.Caption := 'Fact.';
    etqFacturado.Expression := '[facturado]';
    lblVendidos.Caption := 'Con Precio';
    lblCategorias.Enabled := True;
  end
  else
  begin
    DataSet := DMControlFob.CDSTransitos;
    DMControlFob.CDSTransitos.Filtered := True;
    lblFacturado.Caption := ''; //'Nivel';
    etqFacturado.Expression := ''; //'[nivel]';
    lblVendidos.Caption := 'Vendidos';
    lblCategorias.Enabled := False;
  end;
  etqCentro.DataSet := DataSet;
  etqReferencia.DataSet := DataSet;
  etqFecha.DataSet := DataSet;
  etqKilos.DataSet := DataSet;
  etqVendidos.DataSet := DataSet;
  case ATipo of
    0: begin
        DataSet.Filter := '';
        DataSet.Filtered := False;
      end;
    1: begin
        DataSet.Filter := 'kilos <> vendidos and facturado = 0';
        DataSet.Filtered := True;
      end;
    2: begin
        DataSet.Filter := 'facturado = 0';
        DataSet.Filtered := True;
      end;
    3: begin
        DataSet.Filter := '';
        DataSet.Filtered := False;
      end;
    4: begin
        DataSet.Filter := ' kilos <> vendidos ';
        DataSet.Filtered := True;
      end;
  end;
end;

procedure TRControlFob.etqFacturadoPrint(sender: TObject; var Value: string);
begin
  if bSalidas then
  begin
    if Value = '0' then
      Value := 'NO'
    else
      Value := 'SI';
  end;
end;

procedure TRControlFob.QuickRepStartPage(Sender: TCustomQuickRep);
begin
  iColumna := 0;
end;

procedure TRControlFob.CabColumnaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Inc(iColumna);
  if iColumna > 1 then
  begin
    CabColumna.Frame.DrawLeft := true;
    Detalle.Frame.DrawLeft := true;
  end
  else
  begin
    CabColumna.Frame.DrawLeft := False;
    Detalle.Frame.DrawLeft := False;
  end;
end;

procedure TRControlFob.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  CabGrupo.Height := 0;
end;

end.
