unit UTransitosList_QR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TTransitosList_QR = class(TQuickRep)
    CabPagina: TQRBand;
    PiePagina: TQRBand;
    Detalle: TQRBand;
    CabColumna: TQRBand;
    etqReferencia: TQRDBText;
    etqFecha: TQRDBText;
    etqKilos: TQRDBText;
    etqVendidos: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    lblVendidos: TQRLabel;
    QRSysData3: TQRSysData;
    CabGrupo: TQRGroup;
    PieGrupo: TQRBand;
    QRLabel7: TQRLabel;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRLabel8: TQRLabel;
    etqCentro: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel1: TQRLabel;
    lblRango: TQRLabel;
    QRSysData1: TQRSysData;
    lblProducto: TQRLabel;
    lblCentro: TQRLabel;
    QRSysData2: TQRSysData;
    procedure QuickRepStartPage(Sender: TCustomQuickRep);
    procedure CabColumnaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    iColumna: Integer;

    procedure ConfigurarDataSets(const ATipo: integer);
  public

  end;

procedure Previsualizar(const AEmpresa, ACEntro, AProducto: String; const AInicio, AFin: TDateTime;
  const ATipoListado: Integer; const ATitulo: string);

implementation

uses UTransitosList_MD, CReportes, DPreview, UDMAuxDB, Dialogs;

{$R *.DFM}

procedure Previsualizar(const AEmpresa, ACEntro, AProducto: String; const AInicio, AFin: TDateTime;
  const ATipoListado: Integer; const ATitulo: string);
var
  TransitosList_QR: TTransitosList_QR;
begin
  TransitosList_QR := TTransitosList_QR.Create(nil);
  try
    TransitosList_QR.lblProducto.Caption := AProducto + ' ' + desProducto(AEmpresa, AProducto);
    TransitosList_QR.lblCentro.Caption := ACentro + ' ' + desCentro(AEmpresa, ACentro);
    TransitosList_QR.lblRango.Caption := 'Del ' + DateToStr( AInicio ) + ' al ' + DateToStr( AFin );
    TransitosList_QR.ReportTitle := ATitulo;
    PonLogoGrupoBonnysa(TransitosList_QR, AEmpresa);

    TransitosList_QR.ConfigurarDataSets(ATipoListado);

    if TransitosList_QR.DataSet.IsEmpty then
    begin
      ShowMessage('Listado sin datos para los parametros de busqueda introducidos.');
      FreeANdNil(TransitosList_QR);
      Exit;
    end;

    Preview(TransitosList_QR);
  except
    FreeANdNil(TransitosList_QR);
    raise;
  end;
end;

procedure TTransitosList_QR.ConfigurarDataSets(const ATipo: integer);
begin
  case ATipo of
    0: begin
        DataSet.Filter := '';
        DataSet.Filtered := False;
      end;
    1: begin
        DataSet.Filter := 'kilos = vendidos';
        DataSet.Filtered := True;
      end;
    2: begin
        DataSet.Filter := 'kilos <> vendidos';
        DataSet.Filtered := True;
      end;
  end;
end;

procedure TTransitosList_QR.QuickRepStartPage(Sender: TCustomQuickRep);
begin
  iColumna := 0;
end;

procedure TTransitosList_QR.CabColumnaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Inc(iColumna);
  if iColumna > 1 then
  begin
    CabColumna.Frame.DrawLeft := true;
    Detalle.Frame.DrawLeft := true;
  end
  else
  begin
    CabColumna.Frame.DrawLeft := False;
    Detalle.Frame.DrawLeft := False;
  end;
end;

procedure TTransitosList_QR.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  CabGrupo.Height := 0;
end;

end.
