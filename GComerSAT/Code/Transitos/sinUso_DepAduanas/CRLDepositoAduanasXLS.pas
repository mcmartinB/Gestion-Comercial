unit CRLDepositoAduanasXLS;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, Dialogs;

type
  TRLDepositoAduanasXLS = class(TQuickRep)
    bndTitulo: TQRBand;
    bndDetalle: TQRBand;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    qrereferencia_tc: TQRDBText;
    qrekilos_das: TQRDBText;
    QRLabel7: TQRLabel;
    qrefecha_entrada_dda_dac: TQRDBText;
    qrecajas: TQRDBText;
    qrecategoria: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qredvd_dac: TQRDBText;
    qredvd_dac1: TQRDBText;
    qrl5: TQRLabel;
    qredes_puerto_tc: TQRDBText;
    qrepais_tc: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRDBText20: TQRDBText;
    QRDBText21: TQRDBText;
    QRDBText22: TQRDBText;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText25: TQRDBText;
    QRDBText26: TQRDBText;
    QRDBText27: TQRDBText;
    QRDBText28: TQRDBText;
    QRDBText29: TQRDBText;
    QRDBText30: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    dlgSave: TSaveDialog;
    qrgGrupo1: TQRGroup;
    qrefecha_tc: TQRDBText;
    qrlDesTransporte: TQRLabel;
    qredes_transporte: TQRDBText;
    qrlPalets: TQRLabel;
    qrlCajas: TQRLabel;
    qrlKilos: TQRLabel;
    qrlBruto: TQRLabel;
    qrePalets: TQRDBText;
    qreCajas_tc: TQRDBText;
    qreKilos: TQRDBText;
    qreBruto: TQRDBText;
    qrdbtxtcarpeta_deposito_tc: TQRDBText;
  private

  public

  end;

  procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro: string;
                           const AFechainicio, AFechafin: TDateTime );

implementation

{$R *.DFM}

uses
  CDLDepositoAduanasXLS, UDMAUXDB, CReportes, DPreview, QRExport, Shellapi;

var
  RLDepositoAduanasXLS: TRLDepositoAduanasXLS;
  (*
  empresa_tc, centro_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc, ');
    SQL.Add('         sum(kilos_tl) kilos_tc
  *)
procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime );
var
  sFileName: string;
begin
  RLDepositoAduanasXLS:= TRLDepositoAduanasXLS.Create( nil );
  try
    RLDepositoAduanasXLS.dlgSave.FileName:= 'XLSDepositoAduanas.xls';
    if RLDepositoAduanasXLS.dlgSave.Execute then
    begin
      RLDepositoAduanasXLS.ExportToFilter(TQRXLSFilter.Create(RLDepositoAduanasXLS.dlgSave.FileName));
      if FileExists( RLDepositoAduanasXLS.dlgSave.FileName ) then
        ShellExecute(AForm.Handle, nil, PChar(RLDepositoAduanasXLS.dlgSave.FileName), nil, nil, SW_NORMAL)
      else
        ShowMessage('Error an intentar abrir el fichero ' + RLDepositoAduanasXLS.dlgSave.FileName );
    end;
  finally
    FreeAndNil( RLDepositoAduanasXLS );
  end;
end;


end.
