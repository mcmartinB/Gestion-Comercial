unit CRLFacturasTransporteDepositos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, Dialogs;

type
  TRLFacturasTransporteDepositos = class(TQuickRep)
    bndTitulo: TQRBand;
    bndDetalle: TQRBand;
    ChildBand1: TQRChildBand;
    qrl3: TQRLabel;
    factura: TQRDBText;
    qretransporte: TQRDBText;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    des_transporte: TQRDBText;
    qreimporte_total: TQRDBText;
    qrlQRLTitulo: TQRLabel;
    fecha_impresion: TQRSysData;
    qrefecha_tc: TQRDBText;
    qrlrango: TQRLabel;
    fechaImpresion: TQRSysData;
    qrlblproducto: TQRLabel;
  private

  public

  end;

  procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro, AAgrupacion, AProducto: string;
                           const AFechainicio, AFechafin: TDateTime );

implementation

{$R *.DFM}

uses
  CDLFacturasTransporteDepositos, UDMAUXDB, CReportes, DPreview, CVariables;

var
  RLFacturasTransporteDepositos: TRLFacturasTransporteDepositos;

procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro, AAGrupacion, AProducto: string;
                         const AFechainicio, AFechafin: TDateTime );
begin
    RLFacturasTransporteDepositos:= TRLFacturasTransporteDepositos.Create( nil );
    try
      PonLogoGrupoBonnysa(RLFacturasTransporteDepositos);
      if AProducto <> '' then
        RLFacturasTransporteDepositos.qrlblproducto.caption:= 'Producto ' +  AProducto +  ' ' + DesProducto(AEmpresa, AProducto)
      else
        RLFacturasTransporteDepositos.qrlblproducto.caption:= '';
      RLFacturasTransporteDepositos.qrlrango.Caption:= 'Del ' + FormatDateTime( 'dd/mm/yyyy', AFechainicio ) + ' al ' + FormatDateTime( 'dd/mm/yyyy', AFechaFin );
      Preview(RLFacturasTransporteDepositos);
    except
      FreeAndNil(RLFacturasTransporteDepositos);
      Raise;
    end;
end;


end.
