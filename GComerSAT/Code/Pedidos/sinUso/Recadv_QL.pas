unit Recadv_QL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLRecadv_ = class(TQuickRep)
    TitleBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    QRLabel8: TQRLabel;
    DetailBand1: TQRBand;
    qreidcab_ecr: TQRDBText;
    qretipo_ecr: TQRDBText;
    qrefecdoc_ecr: TQRDBText;
    qrenumalb_ecr: TQRDBText;
    QRSubDetail1: TQRSubDetail;
    qreean_elr: TQRDBText;
    qrerefcli_elr: TQRDBText;
    qrerefprov_elr: TQRDBText;
    qreenvase: TQRDBText;
    qrecantace_elr: TQRDBText;
    qrecantue_elr: TQRDBText;
    qreunidad_fac: TQRDBText;
    bndCabLin: TQRBand;
    QRLabel5: TQRLabel;
    bndPieRecadv: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    qrenumped_ecr: TQRDBText;
    qreorigen_ecr: TQRDBText;
    qreproveedor_ecr: TQRDBText;
    QRLabel7: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    qrenumcon_ecr: TQRDBText;
    qrefuncion_ecr: TQRDBText;
    qrefecrec_ecr: TQRDBText;
    qrefcarga_ecr: TQRDBText;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    qrematric_ecr: TQRDBText;
    qredestino_ecr: TQRDBText;
    qreaqsfac_ecr: TQRDBText;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    qreidlin_elr: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    bnddCantidades: TQRSubDetail;
    qrecantidad_enr: TQRDBText;
    qrerazon: TQRDBText;
    qrediscrep_enr: TQRDBText;
    qreunidad_fac1: TQRDBText;
    bnddObservaciones: TQRSubDetail;
    qrl6: TQRLabel;
    qrecalificador1: TQRDBText;
    qrecalificador2: TQRDBText;
    bndSepDetalle: TQRBand;
    procedure qreorigen_ecrPrint(sender: TObject; var Value: String);
    procedure qredestino_ecrPrint(sender: TObject; var Value: String);
    procedure qreproveedor_ecrPrint(sender: TObject; var Value: String);
    procedure qreaqsfac_ecrPrint(sender: TObject; var Value: String);
    procedure qretipo_ecrPrint(sender: TObject; var Value: String);
    procedure qrefuncion_ecrPrint(sender: TObject; var Value: String);
  private

  public
    procedure PreparaListado;
  end;

  procedure VerFichaRecadv( const AOwner: TComponent; const ARecadv: string );

implementation

{$R *.DFM}

uses
  Recadv_DL, RecadvDM, CReportes, DPreview, UDMAuxDB, Dialogs;

var
  QLRecadv_: TQLRecadv_;

procedure VerFichaRecadv( const AOwner: TComponent; const ARecadv: string );
begin
  QLRecadv_:= TQLRecadv_.Create( AOwner );
  DLRecadv_:= TDLRecadv_.Create( AOwner );
  try
    if DLRecadv_.ObtenerDatosListado( ARecadv ) then
    begin
      QLRecadv_.PreparaListado;
      Previsualiza( QLRecadv_ );
    end
    else
    begin
      ShowMessage('RECADV Inexistente.');
    end;
  finally
    DLRecadv_.CerrarDatosListado;
    FreeAndNil( DLRecadv_ );
    FreeAndNil( QLRecadv_ );
  end;
end;

procedure TQLRecadv_.PreparaListado;
begin
  //PonLogoGrupoBonnysa( self, AEmpresa );
end;

procedure TQLRecadv_.qreorigen_ecrPrint(sender: TObject;
  var Value: String);
begin
  if DMRecadv <> nil then
  begin
    Value:= Value + ' ' + DMRecadv.DesOrigen( Value );
  end;
end;

procedure TQLRecadv_.qredestino_ecrPrint(sender: TObject;
  var Value: String);
begin
  if DMRecadv <> nil then
  begin
    Value:= Value + ' ' + DMRecadv.DesProveedor( Value );
  end;
end;

procedure TQLRecadv_.qreproveedor_ecrPrint(sender: TObject;
  var Value: String);
begin
  if DMRecadv <> nil then
  begin
    Value:= Value + ' ' + DMRecadv.DesProveedor( Value );
  end;
end;

procedure TQLRecadv_.qreaqsfac_ecrPrint(sender: TObject;
  var Value: String);
begin
  if DMRecadv <> nil then
  begin
    Value:= Value + ' ' + DMRecadv.DesFacturarA( Value );
  end;
end;

procedure TQLRecadv_.qretipo_ecrPrint(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + GetTipo( Value );
end;

procedure TQLRecadv_.qrefuncion_ecrPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + GetFuncion( Value );
end;

end.
