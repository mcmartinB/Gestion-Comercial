unit LEntradasFruta;

interface

uses
  Classes, Controls, ExtCtrls, QuickRpt, Qrctrls, Db, DBTables;

type
  TQRLEntradasFruta = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    QRSubDetail1: TQRSubDetail;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLabel9: TQRLabel;
    QRGroup1: TQRGroup;
    PsQRLabel2: TQRLabel;
    PSQRLCentro: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    PsQRDBText8: TQRDBText;
    PsQRDBText9: TQRDBText;
    PsQRDBText10: TQRDBText;
    PsQRDBText11: TQRDBText;
    PsQRDBText12: TQRDBText;
    PsQRDBText13: TQRDBText;
    DSEntradas: TDataSource;
    QEntradasLin: TQuery;
    PsQRLabel3: TQRLabel;
    PsQRDBText14: TQRDBText;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    PsQRLabel12: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    QEntradasCab: TQuery;
    PsQRDBText16: TQRDBText;
    PsQRDBText15: TQRDBText;
    PsQRDBText17: TQRDBText;
    PsQRDBText18: TQRDBText;
    PsQRDBText19: TQRDBText;
    PsQRLabel15: TQRLabel;
    PsQRDBText20: TQRDBText;

  private

  public
    Constructor Create( AOwner: TComponent ); Override;
  end;

implementation

{$R *.DFM}

Constructor TQRLEntradasFruta.Create( AOwner: TComponent );
begin
  inherited;

  QEntradasLin.SQL.Clear;
  QEntradasLin.SQL.Add(' SELECT cosechero_e2l, nombre_c, plantacion_e2l, descripcion_p, ');
  QEntradasLin.SQL.Add('   ano_sem_planta_e2l, total_cajas_e2l, ');
  QEntradasLin.SQL.Add('   total_kgs_e2l ');

  QEntradasLin.SQL.Add(' FROM frf_entradas2_l, frf_cosecheros, frf_plantaciones ');

  QEntradasLin.SQL.Add(' WHERE empresa_e2l=:empresa_ec ');
  QEntradasLin.SQL.Add(' AND centro_e2l=:centro_ec ');
  QEntradasLin.SQL.Add(' AND numero_entrada_e2l=:numero_entrada_ec ');
  QEntradasLin.SQL.Add(' AND fecha_e2l=:fecha_ec ');

  QEntradasLin.SQL.Add(' AND empresa_e2l = empresa_c ');
  QEntradasLin.SQL.Add(' AND cosechero_e2l = cosechero_c ');
  QEntradasLin.SQL.Add(' AND empresa_e2l = empresa_p ');
  QEntradasLin.SQL.Add(' AND producto_e2l = producto_p ');
  QEntradasLin.SQL.Add(' AND ano_sem_planta_e2l = ano_semana_p ');
  QEntradasLin.SQL.Add(' AND cosechero_e2l = cosechero_p ');
  QEntradasLin.SQL.Add(' AND plantacion_e2l = plantacion_p ');
end;

end.
