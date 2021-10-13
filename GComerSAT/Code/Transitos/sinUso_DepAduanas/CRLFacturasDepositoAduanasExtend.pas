unit CRLFacturasDepositoAduanasExtend;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, Dialogs;

type
  TRLFacturasDepositoAduanasExtend = class(TQuickRep)
    bndDetalle: TQRBand;
    dlgSave: TSaveDialog;
    bnd2: TQRBand;
    qrl3: TQRLabel;
    qrl19: TQRLabel;
    qrl18: TQRLabel;
    qrl17: TQRLabel;
    bndTitulo: TQRBand;
    QRLabel1: TQRLabel;
    lblCentro: TQRLabel;
    lblPeriodo: TQRLabel;
    qrsImpreso: TQRSysData;
    qrgCabCarpeta: TQRGroup;
    qredvd_dac1: TQRDBText;
    qrgCabTransito: TQRGroup;
    qrereferencia_tc: TQRDBText;
    qrecajas: TQRDBText;
    qrecategoria: TQRDBText;
    qredvd_dac: TQRDBText;
    qren_cmr_das: TQRDBText;
    qrecliente_dal: TQRDBText;
    qrevehiculo_tc: TQRDBText;
    qrebuque: TQRDBText;
    qrepais: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrlFechaFactComercial: TQRLabel;
    qrlNumFactComercial: TQRLabel;
    qrlFacturaTransporte: TQRLabel;
    procedure qredvd_dac1Print(sender: TObject; var Value: String);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgCabTransitoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

  procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro: string;
                           const AFechainicio, AFechafin: TDateTime );

implementation

{$R *.DFM}

uses
  CDLFacturasDepositoAduanas, UDMAUXDB, CReportes, DPreview;

var
  RLFacturasDepositoAduanasExtend: TRLFacturasDepositoAduanasExtend;




procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime );

begin
  RLFacturasDepositoAduanasExtend:= TRLFacturasDepositoAduanasExtend.Create( nil );
  with RLFacturasDepositoAduanasExtend do
  begin
    PonLogoGrupoBonnysa( RLFacturasDepositoAduanasExtend, AEmpresa );
    lblCentro.Caption:= ACentro + ' ' + DesCentro( AEmpresa, ACentro );
    lblPeriodo.Caption:= 'Del ' + DateToStr( AFechainicio ) + ' al ' + DateToStr( AFechafin ) + '.';
  end;
  try
    Preview( RLFacturasDepositoAduanasExtend );
  except
    FreeAndNil( RLFacturasDepositoAduanasExtend );
  end;

end;

procedure TRLFacturasDepositoAduanasExtend.qredvd_dac1Print(
  sender: TObject; var Value: String);
begin
  Value:= 'CARPETA: ' + Value;
end;

procedure TRLFacturasDepositoAduanasExtend.bndDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if DataSet.FieldByName('factura_alquiler').AsString <> '' then
  begin
    qrlFechaFactComercial.Caption:= '';
    qrlNumFactComercial.Caption:= DataSet.FieldByName('factura_alquiler').AsString;
  end
  else
  begin
    if DataSet.FieldByName('porte_pagado').AsInteger = 1 then
    begin
      qrlFechaFactComercial.Caption:= '';
      qrlNumFactComercial.Caption:= '*FALTA FACTURA';
    end
    else
    begin
      if DataSet.FieldByName('coste_kg_alquiler').AsFloat = 0 then
      begin
        qrlFechaFactComercial.Caption:= '';
        qrlNumFactComercial.Caption:= '';
      end
      else
      begin
        if DataSet.FieldByName('num_fact_comercial').AsString = '' then
        begin
          qrlFechaFactComercial.Caption:= '';
          qrlNumFactComercial.Caption:= '-SIN FACTURAR';
        end
        else
        begin
          qrlFechaFactComercial.Caption:= DataSet.FieldByName('fecha_fact_comercial').AsString;
          qrlNumFactComercial.Caption:= DataSet.FieldByName('num_fact_comercial').AsString;
        end;
      end;
    end;
  end;
end;

procedure TRLFacturasDepositoAduanasExtend.qrgCabTransitoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if DataSet.FieldByName('factura_transporte').AsString <> '' then
  begin
    qrlFacturaTransporte.Caption:= DataSet.FieldByName('factura_transporte').AsString;
  end
  else
  begin
    qrlFacturaTransporte.Caption:= '>>> FALTA FACTURA <<<';
  end;
end;

end.
