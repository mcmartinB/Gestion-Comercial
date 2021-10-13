unit SalidasSuperReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRSalidasSuper = class(TQuickRep)
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

procedure PreviewSalidasSuper( const AEmpresa, ACliente, ATipoCliente, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime; const AExcluir: boolean );

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants, SalidasSuperData;


procedure PreviewSalidasSuper( const AEmpresa, ACliente, ATipoCliente, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime; const AExcluir: boolean );
var
  RSalidasSuper: TRSalidasSuper;
begin
  if SalidasSuperData.OpenDataSalidasSuper( AEmpresa, ACliente,ATipoCliente,  AProducto, AFechaIni, AFechaFin, AExcluir ) then
  begin
    try
      RSalidasSuper := TRSalidasSuper.Create(nil);
      PonLogoGrupoBonnysa(RSalidasSuper, AEmpresa);
      RSalidasSuper.Empresa := AEmpresa;
      RSalidasSuper.lblPeriodo.Caption :=  'Del ' +  FormatDateTime('dd/mm/yyyy',AFechaIni) + ' al ' + FormatDateTime('dd/mm/yyyy',AFechaFin);
      if AProducto <> '' then
        RSalidasSuper.lblCentro.Caption := desProducto(AEmpresa, AProducto)
      else
        RSalidasSuper.lblCentro.Caption := 'TODOS LOS PRODUCTOS';
      Preview(RSalidasSuper);
      DMBaseDatos.QListado.Close;
    finally
      SalidasSuperData.CloseDataSalidasSuper;
    end;
  end
  else
  begin
    SalidasSuperData.CloseDataSalidasSuper;
    ShowMessage('Listado sin datos.');
  end;
end;

end.
