unit LVentasFOB_tot;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, Variants,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLVentasFOB_tot = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRGroup1: TQRGroup;
    QRBPieGrupo: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    PsQRLabel11: TQRLabel;
    PsQRLabel12: TQRLabel;
    PsQRLabel1: TQRLabel;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRExpr8: TQRExpr;
    PsQRLabel2: TQRLabel;
    ChildBand1: TQRChildBand;
    PsQRLabel3: TQRLabel;
    PsQRLabel10: TQRLabel;
    PsQRSysData3: TQRSysData;
    LCategoria: TQRLabel;
    LPeriodo: TQRLabel;
    LProducto: TQRLabel;
    LCentro: TQRLabel;
    PageFooterBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    procedure PsQRLabel2Print(sender: TObject; var Value: string);
    procedure PsQRDBText7Print(sender: TObject; var Value: string);
  private
    cli: string;

  public
    sCodEmpresa, sEmpresa: string;

  end;

var
  QRLVentasFOB_tot: TQRLVentasFOB_tot;

implementation

{$R *.DFM}

uses UDMAuxDB, UDMBaseDatos;

procedure TQRLVentasFOB_tot.PsQRLabel2Print(sender: TObject;
  var Value: string);
begin
  Value := desCliente(sCodEmpresa, cli);
end;

procedure TQRLVentasFOB_tot.PsQRDBText7Print(sender: TObject;
  var Value: string);
begin
  cli := Value;
end;

end.
