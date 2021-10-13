unit CRLDepositosAduanas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, Dialogs;

type
  TRLDepositosAduanas = class(TQuickRep)
    bndTitulo: TQRBand;
    bndDetalle: TQRBand;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    qreempresa: TQRDBText;
    QRLabel7: TQRLabel;
    qrecentro: TQRDBText;
    qretransito: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrefecha_transito: TQRDBText;
    qredvd: TQRDBText;
    qrl5: TQRLabel;
    qreembarque: TQRDBText;
    qredua_exporta: TQRDBText;
    factura: TQRDBText;
    qretransporte: TQRDBText;
    qrecodigo: TQRDBText;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel17: TQRLabel;
    dlgSave: TSaveDialog;
    qrgGrupo1: TQRGroup;
    qrefecha_tc: TQRDBText;
    qrlDesTransporte: TQRLabel;
    qrefecha_entrada: TQRDBText;
    des_transporte: TQRDBText;
    qreimporte_total: TQRDBText;
    qrlQRLTitulo: TQRLabel;
    fecha_impresion: TQRSysData;
  private

  public

  end;

  procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro: string;
                           const AFechainicio, AFechafin: TDateTime );

implementation

{$R *.DFM}

uses
  CDLDepositosAduanas, UDMAUXDB, CReportes, DPreview, CVariables;

var
  RLDepositosAduanas: TRLDepositosAduanas;

procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime );
begin
    RLDepositosAduanas:= TRLDepositosAduanas.Create( nil );
    try
      PonLogoGrupoBonnysa(RLDepositosAduanas);
      Preview(RLDepositosAduanas);
    except
      FreeAndNil(RLDepositosAduanas);
      Raise;
    end;
end;


end.
