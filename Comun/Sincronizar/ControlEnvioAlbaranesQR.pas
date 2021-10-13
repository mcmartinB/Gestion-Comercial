unit ControlEnvioAlbaranesQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRControlEnvioAlbaranes = class(TQuickRep)
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    lblPeriodo: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    coste: TQRExpr;
    secciones: TQRExpr;
    qrxpr1: TQRExpr;
    qrxpr9: TQRExpr;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel5: TQRLabel;
    QRLabel1: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    procedure qrxpr14Print(sender: TObject; var Value: String);
  private

  public
    Empresa: string;
  end;

procedure PreviewReporte(const AEmpresa: string; const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer );

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants, ControlEnvioAlbaranesDR;


procedure PreviewReporte(const AEmpresa: string; const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer );
var
  QRControlEnvioAlbaranes: TQRControlEnvioAlbaranes;
begin
  try
    if ControlEnvioAlbaranesDR.OpenDataReporte( AEmpresa, AFechaIni, AFechaFin, ATipo  ) then
    begin
      QRControlEnvioAlbaranes := TQRControlEnvioAlbaranes.Create(nil);
      QRControlEnvioAlbaranes.lblPeriodo.Caption:= 'DEL ' + FormatDateTime('dd/mm/yyyy', AFechaIni) + ' AL ' +
                                                   FormatDateTime('dd/mm/yyyy', AFechaFin);
      PonLogoGrupoBonnysa(QRControlEnvioAlbaranes, AEmpresa);
      QRControlEnvioAlbaranes.Empresa := AEmpresa;
      Preview(QRControlEnvioAlbaranes);
      DMBaseDatos.QListado.Close;
    end
    else
    begin
      ShowMessage('Listado sin datos.');
    end;
  finally
    ControlEnvioAlbaranesDR.CloseDataReporte;
  end;
end;

procedure TQRControlEnvioAlbaranes.qrxpr14Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.fieldByName('empresa').AsString, Value );
end;

end.
