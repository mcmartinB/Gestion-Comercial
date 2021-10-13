unit CRLFicherosAtlantisPapel;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, Dialogs;

type
  TRLFicherosAtlantisPapel = class(TQuickRep)
    bndDetalle: TQRBand;
    qrekilos_das: TQRDBText;
    qrecajas: TQRDBText;
    naviera: TQRDBText;
    qredvd_dac1: TQRDBText;
    qren_palets: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    qredto_rappel: TQRDBText;
    qrecoste_manipulacion: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText2: TQRDBText;
    bndTitleBand1: TQRBand;
    qrgDestino: TQRGroup;
    qrl15: TQRLabel;
    qrl17: TQRLabel;
    qrl18: TQRLabel;
    qrl12: TQRLabel;
    qrl19: TQRLabel;
    qrl11: TQRLabel;
    qrl10: TQRLabel;
    qrl9: TQRLabel;
    qrl8: TQRLabel;
    qrl7: TQRLabel;
    qrl6: TQRLabel;
    qrl5: TQRLabel;
    qrl2: TQRLabel;
    qrl1: TQRLabel;
    qreDestino: TQRDBText;
    qrl3: TQRLabel;
    qrlMatricula: TQRLabel;
    qreMatricula: TQRDBText;
    qrlbl1: TQRLabel;
    teus_40: TQRDBText;
    procedure teus_40Print(sender: TObject; var Value: String);
    procedure qreDestinoPrint(sender: TObject; var Value: String);
  private
  public
  end;

  procedure Informe( const AForm: TForm; const AProducto: string  );

implementation

{$R *.DFM}

uses
  CDLFicherosAtlantis, UDMAUXDB, CReportes, DPreview, QRExport, Shellapi;

var
  RLFicherosAtlantisPapel: TRLFicherosAtlantisPapel;


procedure Informe( const AForm: TForm; const AProducto: string  );
begin
  RLFicherosAtlantisPapel:= TRLFicherosAtlantisPapel.Create( AForm );
  try
    if  AProducto <> '' then
      RLFicherosAtlantisPapel.qrl3.Caption:= 'INFORME SUBVENCIÓN ATLANTIS (' + AProducto + ')';
    Previsualiza( RLFicherosAtlantisPapel, 1 );
  finally
    FreeAndNil( RLFicherosAtlantisPapel );
  end;
end;


procedure TRLFicherosAtlantisPapel.teus_40Print(sender: TObject;
  var Value: String);
begin
  if Value <> '0' then
    Value:= 'Teus40'
  else
  if DataSet.FieldByName('teus_45').AsInteger <> 0 then
    Value:= 'Teus45'
  else
  if DataSet.FieldByName('metros_lineales').AsFloat = 0 then
    Value:= 'Kilos'
  else
    Value:= FormatFloat( '#0.00', DataSet.FieldByName('metros_lineales').AsFloat );

end;

procedure TRLFicherosAtlantisPapel.qreDestinoPrint(sender: TObject;
  var Value: String);
begin
  Value:= DataSet.FieldByName('puerto_salida').AsString + ' - PENÍNSULA (' + Value + ')';
end;

end.
