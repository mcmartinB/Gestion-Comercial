unit LQGastosConduce;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLGastosConduce = class(TQuickRep)
    bndCabeceraListado: TQRBand;
    lblTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    bndPieListado: TQRBand;
    QRSysData2: TQRSysData;
    DetailBand1: TQRBand;
    lblRangoFechas: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText1: TQRDBText;
    SummaryBand1: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel3: TQRLabel;
    procedure bndCabeceraListadoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    sConduce: String;

  public
    sEmpresa: string;

  end;

 function  Imprimir( const AEmpresa, ACentro, AProveedor, AProducto, AEntrega, AGasto: string;
                      const AFechaIni, AFechaFin: TDateTime;
                      const APendientePago: boolean;  const AEnvio: Integer;
                      const ATipoCodigo, ATipoFecha, ATipoCentro: Integer ): boolean;

implementation

{$R *.DFM}

uses
  LDGastosEntregas, DPreview, CReportes;

var
  QLGastosConduce: TQLGastosConduce;

function Imprimir( const AEmpresa, ACentro, AProveedor, AProducto, AEntrega, AGasto: string;
                   const AFechaIni, AFechaFin: TDateTime;
                   const APendientePago: boolean; const AEnvio: Integer;
                   const ATipoCodigo, ATipoFecha, ATipoCentro: Integer ): boolean;
begin
  DLGastosEntregas:= TDLGastosEntregas.Create( Application );
  try
    result:= DLGastosEntregas.ObtenerDatosConduce(AEmpresa, ACentro, AProveedor, AProducto, AEntrega, AGasto,
                AFechaIni, AFechaFin, APendientePago, AEnvio, ATipoCodigo, ATipoFecha, ATipoCentro );
    if result then
    begin
      QLGastosConduce:= TQLGastosConduce.Create( Application );
      QLGastosConduce.sEmpresa:= AEmpresa;
      PonLogoGrupoBonnysa( QLGastosConduce, AEmpresa );
      QLGastosConduce.lblRangoFechas.Caption:= DateToStr( AFechaIni ) + ' a ' +
                                                      DateToStr( AFechaFin );
      try
        Preview( QLGastosConduce );
      except
        FreeAndNil(QLGastosConduce);
        raise;
      end;
    end;
  finally
    DLGastosEntregas.CerrarQuery;
    FreeAndNil( DLGastosEntregas );
  end;
end;

procedure TQLGastosConduce.bndCabeceraListadoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  sConduce:= '';
end;

procedure TQLGastosConduce.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  if sConduce <> Value then
  begin
    sConduce:= Value;
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLGastosConduce.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  DetailBand1.Frame.DrawTop:= DataSet.FieldByName('conduce').AsString <> sConduce;
end;

end.
