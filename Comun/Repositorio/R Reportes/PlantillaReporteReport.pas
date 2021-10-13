unit PlantillaReporteReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRPlantillaReporte = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    lblPeriodo: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    coste: TQRExpr;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    lblCentro: TQRLabel;
    secciones: TQRExpr;
    QRLabel1: TQRLabel;
    qrxGeneral: TQRExpr;
    qrlGeneral: TQRLabel;
    qrlTotal: TQRLabel;
    qrxTotal: TQRExpr;
    qrxpr1: TQRExpr;
    qrgrpCab: TQRGroup;
    qrbndPie: TQRBand;
    qrbndTotales: TQRBand;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrshpPie: TQRShape;
    qrshpTotal: TQRShape;
    qrxprcliente: TQRExpr;
    qrxpr8: TQRExpr;
  private

  public
    Empresa: string;
  end;

procedure PreviewPlantillaReporte(const AEmpresa, ACentro, ACliente, AProducto: string;
                                  const AFechaIni, AFechaFin: TDateTime; const AAnyo, AMes: integer );

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants, PlantillaReporteData;


procedure PreviewPlantillaReporte(const AEmpresa, ACentro, ACliente, AProducto: string;
                                  const AFechaIni, AFechaFin: TDateTime; const AAnyo, AMes: integer );
var
  RPlantillaReporte: TRPlantillaReporte;
begin
  if PlantillaReporteData.OpenDataPlantillaReporte( AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin, AAnyo, AMes ) then
  begin
    try
      RPlantillaReporte := TRPlantillaReporte.Create(nil);
      PonLogoGrupoBonnysa(RPlantillaReporte, AEmpresa);
      RPlantillaReporte.Empresa := AEmpresa;
      //RPlantillaReporte.lblPeriodo.Caption :=  AMes + ' (' + desMes(AMes) + ') de ' + AAnyo;
      RPlantillaReporte.lblCentro.Caption := desCentro(AEmpresa, ACentro);
      Preview(RPlantillaReporte);
      DMBaseDatos.QListado.Close;
    finally
      PlantillaReporteData.CloseDataPlantillaReporte;
    end;
  end
  else
  begin
    ShowMessage('Listado sin datos.');
  end;
end;

end.
