unit LQPlantilla;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLPlantilla = class(TQuickRep)
    bndCabeceraListado: TQRBand;
    lblTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    bndPieListado: TQRBand;
    QRSysData2: TQRSysData;
    DetailBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    lblRangoFechas: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel7: TQRLabel;
  private
    
  public
    sEmpresa: string;

  end;

  procedure InicializarReport;
  procedure FinalizarReport;
  function  Imprimir( const AEmpresa, ACentro, ACliente, AProducto: string;
                      const AFechaIni, AFechaFin: TDateTime ): boolean;

implementation

{$R *.DFM}

uses
  LDPlantilla, DPreview, UDMAuxDB, CReportes;

var
  QLPlantilla: TQLPlantilla;
  DLPlantilla: TDLPlantilla;
  i: integer = 0;

procedure InicializarReport;
begin
  Inc( i );
  if i = 1 then
  begin
    DLPlantilla:= LDPlantilla.InicializarModulo;
  end;
end;

procedure FinalizarReport;
begin
  Dec( i );
  if i = 0 then
  begin
    LDPlantilla.FinalizarModulo;
  end;
end;

function Imprimir( const AEmpresa, ACentro, ACliente, AProducto: string;
                                           const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  try
    result:= DLPlantilla.ObtenerDatos(AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin );
    if result then
    begin
      QLPlantilla:= TQLPlantilla.Create( Application );
      QLPlantilla.sEmpresa:= AEmpresa;
      PonLogoGrupoBonnysa( QLPlantilla, AEmpresa );
      QLPlantilla.lblRangoFechas.Caption:= DateToStr( AFechaIni ) + ' a ' +
                                                      DateToStr( AFechaFin ); 
      try
        Preview( QLPlantilla );
      except
        FreeAndNil(QLPlantilla);
        raise;
      end;
    end;
  finally
    DLPlantilla.CerrarQuery;
  end;
end;

end.
