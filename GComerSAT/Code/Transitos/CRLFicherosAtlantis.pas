unit CRLFicherosAtlantis;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, Dialogs;

type
  TRLFicherosAtlantis = class(TQuickRep)
    bndDetalle: TQRBand;
    qrekilos_das: TQRDBText;
    qrecajas: TQRDBText;
    qrepallets: TQRDBText;
    naviera: TQRDBText;
    qredvd_dac1: TQRDBText;
    qredes_puerto_tc: TQRDBText;
    QRDBText1: TQRDBText;
    qren_palets: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    qredto_rappel: TQRDBText;
    qrecoste_manipulacion: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    qreporcentaje: TQRDBText;
    QRDBText2: TQRDBText;
    bndTitleBand1: TQRBand;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrl8: TQRLabel;
    qrl9: TQRLabel;
    qrl10: TQRLabel;
    qrl11: TQRLabel;
    qrl13: TQRLabel;
    qrl14: TQRLabel;
    qrl15: TQRLabel;
    qrl16: TQRLabel;
    qrl19: TQRLabel;
    qrl12: TQRLabel;
    qrl18: TQRLabel;
    qrl17: TQRLabel;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    procedure qredvd_dac1Print(sender: TObject; var Value: String);
    procedure qren_paletsPrint(sender: TObject; var Value: String);
  private
  public
    sFormatoFecha: string; 

  end;

  procedure HojaExcel( const AForm: TForm; const AFileName, AFormatoFecha: string );

implementation

{$R *.DFM}

uses
  CDLFicherosAtlantis, UDMAUXDB, CReportes, DPreview, QRExport, Shellapi;

var
  RLFicherosAtlantis: TRLFicherosAtlantis;


procedure HojaExcel( const AForm: TForm; const AFileName, AFormatoFecha: string );
begin
  RLFicherosAtlantis:= TRLFicherosAtlantis.Create( AForm );
  try
    RLFicherosAtlantis.sFormatoFecha:= AFormatoFecha;
    RLFicherosAtlantis.ExportToFilter( TQRXLSFilter.Create( AFileName ) );
    (*
    if FileExists( AFileName ) then
      ShellExecute(AForm.Handle, nil, PChar(AFileName), nil, nil, SW_NORMAL)
    else
      ShowMessage('Error an intentar abrir el fichero ' + AFileName );
    *)
  finally
    FreeAndNil( RLFicherosAtlantis );
  end;
end;


procedure TRLFicherosAtlantis.qredvd_dac1Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatDateTime( sFormatoFecha, DataSet.fieldByName('fecha_transito').AsDateTime );
end;

procedure TRLFicherosAtlantis.qren_paletsPrint(sender: TObject;
  var Value: String);
begin
  Value:= StringReplace( Value, ',', '', [rfReplaceAll] );
  Value:= StringReplace( Value, '.', '', [rfReplaceAll] );
end;

end.
