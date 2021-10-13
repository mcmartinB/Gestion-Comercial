unit UQLConfeccionadoPorCalibres;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls;
type
  TDQLConfeccionadoPorCalibres = class(TQuickRep)
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData2: TQRSysData;
    BandaResumen: TQRBand;
    QRLabel14: TQRLabel;
    PsQRShape1: TQRShape;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    lKilosConfeccionadoTotal: TQRLabel;
    c1: TQRLabel;
    c2: TQRLabel;
    tc: TQRLabel;
    QRLabel20: TQRLabel;
    BandaCategorias: TQRSubDetail;
    PsQRLabel1: TQRLabel;
    categoria_pl: TQRLabel;
    BandaSintesis: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    lKilosLineaTotal: TQRLabel;
    lKilosSalidas: TQRLabel;
    lKilosSalNacional: TQRLabel;
    lKilosTransitos: TQRLabel;
    lKilosLineaAyer: TQRLabel;
    lKilosConfeccionado: TQRLabel;
    BandaCalibres: TQRSubDetail;
    lKilosLinea: TQRLabel;
    BandaCabecera: TQRBand;
    PSQRLabelEnvase: TQRLabel;
    envase: TQRLabel;
    QRLabel19: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabelObs: TQRLabel;
    PsQRMemo: TQRMemo;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    lblProducto: TQRLabel;
    lblFecha: TQRLabel;
    procedure BandaCalibresNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRLParteExistenciasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BandaResumenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaCategoriasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaCategoriasNeedData(Sender: TObject;
      var MoreData: Boolean);
    procedure BandaSintesisAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaSintesisBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaCalibresAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaCalibresBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    Existencias, Sintesis: boolean;
    calibres: Integer;
    Categorias: Integer;
    tipoCalibres: TStringList;
    detalle: array of TQRLabel;
    titulo: array of TQRLabel;
    sumaKilosDetalle: array of TQRLabel;
    sumaKilosAyer: array of TQRLabel;
    sumaSalidas: array of TQRLabel;
    salNacional: array of TQRLabel;
    salTransitos: array of TQRLabel;
    confeccionado: array of TQRLabel;
    confeccionadoTotal: array of TQRLabel;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  QLConfeccionadoPorCalibres: TDQLConfeccionadoPorCalibres;

implementation

uses UFLConfeccionadoPorCalibres;

{$R *.DFM}

procedure TDQLConfeccionadoPorCalibres.BandaCalibresNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  if (not Existencias) and (not Sintesis) then
  begin
    MoreData := true;
  end
  else
    if (not Existencias) and (Sintesis) then
    begin
      MoreData := false;
    end
    else
    begin
      if FLConfeccionadoPorCalibres.QDetListInventario.Eof then
        MoreData := false
      else
        MoreData := true;
    end;
end;

procedure TDQLConfeccionadoPorCalibres.QRLParteExistenciasBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
var
  i: Integer;
begin
  for i := 0 to Calibres - 1 do
  begin
    confeccionadoTotal[i].Tag := 0;
  end;
  lKilosConfeccionadoTotal.Tag := 0;
  c1.tag := 0;
  c2.tag := 0;
  Categorias := 0;
end;

procedure TDQLConfeccionadoPorCalibres.BandaResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i: Integer;
begin
  for i := 0 to Calibres - 1 do
  begin
    confeccionadoTotal[i].caption := FormatFloat('#,##0', confeccionadoTotal[i].Tag);
  end;
  lKilosConfeccionadoTotal.caption := FormatFloat('#,##0', lKilosConfeccionadoTotal.Tag);
  tc.Caption := lKilosConfeccionadoTotal.Caption;
  c1.Caption := FormatFloat('#,##0', c1.tag);
  c2.Caption := FormatFloat('#,##0', c2.tag);

  if Trim( FLConfeccionadoPorCalibres.QNotaInventario.FieldByName('notas_ic').AsString ) = '' then
  begin
    PsQRLabelObs.Enabled:= False;
    PsQRMemo.Enabled:= False;
  end
  else
  begin
    PsQRLabelObs.Enabled:= True;
    PsQRMemo.Enabled:= True;
    PsQRMemo.Lines.Add( FLConfeccionadoPorCalibres.QNotaInventario.FieldByName('notas_ic').AsString );
  end;
end;

procedure TDQLConfeccionadoPorCalibres.BandaCategoriasBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Categorias = 0 then
  begin
    categoria_pl.Caption := ' I PRIMERA ';
    if not FLConfeccionadoPorCalibres.DatosListados('1') then
    begin
      Existencias := false;
      Sintesis := false;
    end
    else
    begin
      Existencias := true;
      Sintesis := false;
    end;
  end
  else
    if Categorias = 1 then
    begin
      categoria_pl.Caption := ' II SEGUNDA ';
      if not FLConfeccionadoPorCalibres.DatosListados('2') then
      begin
        Existencias := false;
        Sintesis := false;
      end
      else
      begin
        Existencias := true;
        Sintesis := false;
      end;
    end
    else
    begin
      PrintBand := false;
    end;
  Inc(categorias);
end;

procedure TDQLConfeccionadoPorCalibres.BandaCategoriasNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  if categorias < 2 then
  begin
    MoreData := true;
  end
  else                                                             
  begin
    MoreData := false;
  end;
end;

procedure TDQLConfeccionadoPorCalibres.BandaSintesisAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
var
  i: integer;
begin
  for i := 0 to Calibres - 1 do
  begin
    sumaKilosDetalle[i].Tag := 0;
    sumaKilosDetalle[i].Enabled := false;
    sumaKilosAyer[i].Tag := 0;
    sumaKilosAyer[i].Enabled := False;
    sumaSalidas[i].Tag := 0;
    sumaSalidas[i].Enabled := false;
    salNacional[i].Tag := 0;
    salNacional[i].Enabled := false;
    salTransitos[i].Tag := 0;
    salTransitos[i].Enabled := false;
    confeccionado[i].Tag := 0;
  end;
  lKilosLineaTotal.Tag := 0;
  lKilosLineaAyer.Tag := 0;
  lKilosSalidas.Tag := 0;
  lKilosSalNacional.Tag := 0;
  lKilosTransitos.Tag := 0;
  lKilosConfeccionado.Tag := 0;
end;

procedure TDQLConfeccionadoPorCalibres.BandaSintesisBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i: Integer;
  aux: Integer;
  flag: string;
begin
  //EXISTENCIAS ACTUALES
  lKilosLineaTotal.Caption := FormatFloat('#,##0', lKilosLineaTotal.Tag);
  for i := 0 to Calibres - 1 do
  begin
    if sumaKilosDetalle[i].Tag <> 0 then
    begin
      sumaKilosDetalle[i].Caption := IntToStr(sumaKilosDetalle[i].Tag);
      sumaKilosDetalle[i].enabled := true;
    end
    else
    begin
      sumaKilosDetalle[i].enabled := false;
    end;
  end;

  //EXISTENCIAS DE AYER
  flag := FLConfeccionadoPorCalibres.QAntesInventario.FieldByName('calibre_il').AsString;
  for i := 0 to calibres - 1 do
  begin
    if FLConfeccionadoPorCalibres.QAntesInventario.FieldByName('calibre_il').AsString = tipoCalibres[i] then
    begin
      while (flag = FLConfeccionadoPorCalibres.QAntesInventario.FieldByName('calibre_il').AsString) and
        not FLConfeccionadoPorCalibres.QAntesInventario.Eof do
      begin
        lKilosLineaAyer.Tag := lKilosLineaAyer.Tag + FLConfeccionadoPorCalibres.QAntesInventario.FieldByName('kilos_il').AsInteger;
        sumaKilosAyer[i].Tag := sumaKilosAyer[i].Tag + FLConfeccionadoPorCalibres.QAntesInventario.FieldByName('kilos_il').AsInteger;
        FLConfeccionadoPorCalibres.QAntesInventario.Next;
      end;
      if (flag <> FLConfeccionadoPorCalibres.QAntesInventario.FieldByName('calibre_il').AsString) and
        not FLConfeccionadoPorCalibres.QAntesInventario.Eof then
        flag := FLConfeccionadoPorCalibres.QAntesInventario.FieldByName('calibre_il').AsString
      else
      begin
        sumaKilosAyer[i].Enabled := true;
        sumaKilosAyer[i].Caption := IntToStr(sumaKilosAyer[i].Tag);
        Break;
      end;
    end;

    if sumaKilosAyer[i].Tag <> 0 then
    begin
      sumaKilosAyer[i].Enabled := true;
      sumaKilosAyer[i].Caption := IntToStr(sumaKilosAyer[i].Tag);
    end;
  end;
  lKilosLineaAyer.Caption := FormatFloat('#,##0', lKilosLineaAyer.Tag);

  for i := 0 to calibres - 1 do
  begin
    //TRANSITOS
    if FLConfeccionadoPorCalibres.QTransitos.FieldByName('calibre_tl').AsString = tipoCalibres[i] then
    begin
      lKilosTransitos.Tag := lKilosTransitos.Tag + FLConfeccionadoPorCalibres.QTransitos.FieldByName('peso_calibre').AsInteger;
      salTransitos[i].Tag := FLConfeccionadoPorCalibres.QTransitos.FieldByName('peso_calibre').AsInteger;
      salTransitos[i].Enabled := true;
      salTransitos[i].Caption := IntToStr(salTransitos[i].Tag);
      FLConfeccionadoPorCalibres.QTransitos.Next;
    end;
    //SALIDAS
    if FLConfeccionadoPorCalibres.QSalidas.FieldByName('calibre_sl').AsString = tipoCalibres[i] then
    begin
      sumaSalidas[i].Tag := FLConfeccionadoPorCalibres.QSalidas.FieldByName('peso_calibre').AsInteger;
      FLConfeccionadoPorCalibres.QSalidas.Next;
    end;
    if sumaSalidas[i].Tag + salTransitos[i].Tag <> 0 then
    begin
      sumaSalidas[i].Enabled := true;
      sumaSalidas[i].Tag := sumaSalidas[i].Tag + salTransitos[i].Tag;
      sumaSalidas[i].Caption := IntToStr(sumaSalidas[i].Tag);
      lKilossalidas.Tag := lKilossalidas.Tag + sumaSalidas[i].Tag; //+salTransitos[i].Tag;MARIO
    end;
    //SALIDAS NACIONAL
    if FLConfeccionadoPorCalibres.QSalidas.FieldByName('calibre_sl').AsString = tipoCalibres[i] then
    begin
      lKilosSalNacional.Tag := lKilosSalNacional.Tag + FLConfeccionadoPorCalibres.QSalidas.FieldByName('peso_calibre').AsInteger;
      salNacional[i].Tag := FLConfeccionadoPorCalibres.QSalidas.FieldByName('peso_calibre').AsInteger;
      salNacional[i].Enabled := true;
      salNacional[i].Caption := IntToStr(salNacional[i].Tag);
      FLConfeccionadoPorCalibres.QSalidas.Next;
    end;

    //CONFECCIONADO
    aux := sumaKilosDetalle[i].Tag + sumaSalidas[i].tag - sumaKilosAyer[i].Tag;
    confeccionado[i].Caption := FormatFloat('#,##0', aux);
    lKilosConfeccionado.Tag := lKilosConfeccionado.Tag + aux;
    confeccionadoTotal[i].Tag := confeccionadoTotal[i].Tag + aux;
    lKilosConfeccionadoTotal.Tag := lKilosConfeccionadoTotal.Tag + aux;
  end;
  lKilosTransitos.Caption := FormatFloat('#,##0', lKilosTransitos.Tag);
  lKilossalidas.Caption := FormatFloat('#,##0', lKilossalidas.Tag);
  lKilosSalNacional.Caption := FormatFloat('#,##0', lKilosSalNacional.Tag);
  lKilosConfeccionado.Caption := FormatFloat('#,##0', lKilosConfeccionado.Tag);

  if categorias = 1 then
    c1.tag := lKilosConfeccionado.Tag
  else
    if categorias = 2 then
      c2.tag := lKilosConfeccionado.Tag;
end;

procedure TDQLConfeccionadoPorCalibres.BandaCalibresAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if not Existencias then
  begin
    sintesis := true;
    Exit;
  end;
  FLConfeccionadoPorCalibres.QDetListInventario.Next;
end;

procedure TDQLConfeccionadoPorCalibres.BandaCalibresBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i: Integer;
  flag: string;
  totalLinea: Integer;
begin
  if not Existencias then
  begin
    envase.Enabled := false;
    lKilosLinea.Enabled := false;
    for i := 0 to calibres - 1 do
    begin
      detalle[i].enabled := false;
    end;
    Exit;
  end
  else
  begin
    envase.Enabled := true;
    envase.Caption := FLConfeccionadoPorCalibres.QDetListInventario.FieldByName('descripcion_e').AsString;
    lKilosLinea.Enabled := true;
  end;

  flag := FLConfeccionadoPorCalibres.QDetListInventario.FieldByName('envase_il').AsString;
  totalLinea := 0;
  for i := 0 to calibres - 1 do
  begin
    detalle[i].enabled := false;
  end;
  for i := 0 to calibres - 1 do
  begin
    if FLConfeccionadoPorCalibres.QDetListInventario.FieldByName('calibre_il').AsString = tipoCalibres[i] then
    begin
      detalle[i].enabled := true;
      totalLinea := totalLinea + FLConfeccionadoPorCalibres.QDetListInventario.FieldByName('kilos_il').AsInteger;
      sumaKilosDetalle[i].Tag := sumaKilosDetalle[i].Tag + FLConfeccionadoPorCalibres.QDetListInventario.FieldByName('kilos_il').AsInteger;
      detalle[i].Caption := IntToStr(FLConfeccionadoPorCalibres.QDetListInventario.FieldByName('kilos_il').AsInteger);
      FLConfeccionadoPorCalibres.QDetListInventario.Next;
      if flag <> FLConfeccionadoPorCalibres.QDetListInventario.FieldByName('envase_il').AsString then
      begin
        FLConfeccionadoPorCalibres.QDetListInventario.Prior;
        Break;
      end;
    end;
  end;
  lKilosLinea.Caption := FormatFloat('#,##0', totalLinea);
  lKilosLineaTotal.Tag := lKilosLineaTotal.Tag + totalLinea;

end;

constructor TDQLConfeccionadoPorCalibres.Create(AOwner: TComponent);
begin
  inherited;

  tipoCalibres := TStringList.Create;
end;

destructor TDQLConfeccionadoPorCalibres.Destroy;
begin
  tipoCalibres.Free;

  inherited;
end;

end.
