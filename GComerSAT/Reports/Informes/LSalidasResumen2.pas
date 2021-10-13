unit LSalidasResumen2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, dbtables,
  LSalidasResumenForm, dialogs;

type
  TQRLSalidasResumen2 = class(TQuickRep)
    TitleBand1: TQRBand;
    QRLabelTitle: TQRLabel;
    QRSysData2: TQRSysData;
    pieCalibre: TQRChildBand;
    QRLabel37: TQRLabel;
    LTTamPer: TQRLabel;
    LTTamPerPor: TQRLabel;
    LTTamAcu: TQRLabel;
    LTTamAcuPor: TQRLabel;
    QRLabel42: TQRLabel;
    LTEnvPer: TQRLabel;
    LTEnvPerPor: TQRLabel;
    LTEnvAcu: TQRLabel;
    LTEnvAcuPor: TQRLabel;
    lblProducto: TQRLabel;
    lblPeriodo: TQRLabel;
    lblCentro: TQRLabel;
    QRBand1: TQRBand;
    QRSysData1: TQRSysData;
    PsQRShape3: TQRShape;
    PsQRShape4: TQRShape;
    PsQRLabel3: TQRLabel;
    LTTamPerE: TQRLabel;
    LTTamAcuE: TQRLabel;
    PsQRLabel8: TQRLabel;
    LTEnvPerE: TQRLabel;
    LTEnvAcuE: TQRLabel;
    datCalibre: TQRSubDetail;
    LTamPer: TQRLabel;
    LTamPerPor: TQRLabel;
    LTamAcu: TQRLabel;
    LTamAcuPor: TQRLabel;
    LEnvPer: TQRLabel;
    LEnvPerPor: TQRLabel;
    LEnvAcu: TQRLabel;
    LEnvAcuPor: TQRLabel;
    LTam: TQRLabel;
    LEnv: TQRLabel;
    lblNumSemana: TQRLabel;
    datColores: TQRSubDetail;
    psColor: TQRDBText;
    tantoPerColor: TQRLabel;
    tantoAcuColor: TQRLabel;
    QRBColoresHeader: TQRBand;
    PsQRLabel24: TQRLabel;
    PsQRLabel25: TQRLabel;
    PsQRLabel26: TQRLabel;
    PsQRLabel27: TQRLabel;
    PsQRLabel28: TQRLabel;
    PerColor: TQRLabel;
    AcuColor: TQRLabel;
    QRBColoresFooter: TQRBand;
    PsQRLabel21: TQRLabel;
    PsQRShape6: TQRShape;
    PsQRShape7: TQRShape;
    acumPerColor: TQRLabel;
    acumTantoPerColor: TQRLabel;
    acumAcuColor: TQRLabel;
    acumTantoAcuColor: TQRLabel;
    PsQRLabel22: TQRLabel;
    equiAcuColor: TQRLabel;
    equiPerColor: TQRLabel;
    cabCalibre: TQRChildBand;
    cabPaises: TQRChildBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel52: TQRLabel;
    datPaises: TQRSubDetail;
    LPais: TQRLabel;
    LPerCat2: TQRLabel;
    LPerTotal: TQRLabel;
    LNombre: TQRLabel;
    LPerCat1: TQRLabel;
    LAcuCat1: TQRLabel;
    LAcuCat2: TQRLabel;
    LAcuTotal: TQRLabel;
    piePaises: TQRChildBand;
    LTPerCat1: TQRLabel;
    LTPerCat2: TQRLabel;
    LTPerTotal: TQRLabel;
    LTAcuCat1: TQRLabel;
    LTAcuCat2: TQRLabel;
    LTAcuTotal: TQRLabel;
    QRLabel11: TQRLabel;
    PsQRLabel23: TQRLabel;
    LPerCat1EP1: TQRLabel;
    LPerCat2EP1: TQRLabel;
    LPerTotalEP1: TQRLabel;
    LAcuCat1EP1: TQRLabel;
    LAcuCat2EP1: TQRLabel;
    LAcuTotalEP1: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    QRBand2: TQRBand;
    RecRetirada: TQRShape;
    LRetirada: TQRLabel;
    lblTransito2: TQRLabel;
    LPerRetirada: TQRLabel;
    PTT: TQRLabel;
    LAcuRetirada: TQRLabel;
    PTT2: TQRLabel;
    PsQRLabel1: TQRLabel;
    LPerConserva: TQRLabel;
    LAcuConserva: TQRLabel;
    PsQRLabel2: TQRLabel;
    LPerTercera: TQRLabel;
    LAcuTercera: TQRLabel;
    procedure datPaisesNeedData(Sender: TObject; var MoreData: Boolean);
    procedure datPaisesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure piePaisesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLSalidasResumenBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure datCalibreNeedData(Sender: TObject; var MoreData: Boolean);
    procedure datCalibreBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure pieCalibreBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure datColoresBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure psColorPrint(sender: TObject; var Value: string);
    procedure QRBColoresFooterBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cabCalibreBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBColoresHeaderBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cabPaisesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    //Querys
    QSalPerCat1, QSalAcuCat1, QSalPerTotal, QSalAcuTotal: TQuery;
    QSalPerTam, QSalAcuTam: TQuery;
    QSalPerEnv, QSalAcuEnv: TQuery;
    QSalPerColor, QSalAcuColor: TQuery;


    cat1totalP, cat2totalP: real;
    cat1totalA, cat2totalA: real;
    totalPeriodo, totalAcumulado: real;

    tamPerTotal, tamAcuTotal: real;
    envPerTotal, envAcuTotal: real;

    cat1EspP, totalEspP: real;
    cat1EspA, totalEspA: real;
    MercadoNacional: boolean;

    _acumPerColor, _acumTantoPerColor, _acumAcuColor, _acumTantoAcuColor: Real;

    procedure datPaisesBeforePrintNormal;
  public
    empresa, producto: string;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  QRLSalidasResumen2: TQRLSalidasResumen2;

implementation

uses UDMAuxDB, bSQLUtils, bNumericUtils;

{$R *.DFM}

constructor TQRLSalidasResumen2.Create(AOwner: TComponent);
begin
  inherited;

  //Desglose por color
  QSalPerColor := TQuery.Create(nil);
  QSalPerColor.DatabaseName := 'BDProyecto';
  QSalPerColor.SQL.Add(' SELECT color, SUM( kilos ) as kilos ' +
    ' FROM tablaTemporal ' +
    ' WHERE (categoria= ' + SQLString('1') +
    '       OR categoria=' + SQLString('2') + ') ' +
    ' AND tipo=' + SQLString('P') + ' ' +
    ' AND cliente <> ' + SQLString('RET') +
    ' GROUP BY color ORDER BY color');

  QSalAcuColor := TQuery.Create(nil);
  QSalAcuColor.DatabaseName := 'BDProyecto';
  QSalAcuColor.SQL.Add(' SELECT color, SUM( kilos ) as kilos ' +
    ' FROM tablaTemporal ' +
    ' WHERE (categoria=' + SQLString('1') +
    '        OR categoria=' + SQLString('2') + ') ' +
    ' AND cliente <> ' + SQLString('RET') +
    ' GROUP BY color ORDER BY color');

  //Desglose por pais y categoria
  QSalPerCat1 := TQuery.Create(nil);
  QSalPerCat1.DatabaseName := 'BDProyecto';
  QSalPerCat1.SQL.Add(' SELECT pais, SUM( kilos ) as kilos ' +
    ' FROM tablaTemporal ' +
    ' WHERE  categoria=' + SQLString('1') +
    ' AND tipo=' + SQLString('P') + '  ' +
    ' AND cliente <> ' + SQLString('RET') +
    ' GROUP BY pais ORDER BY pais ');

  //Total Periodo
  QSalPerTotal := TQuery.Create(nil);
  QSalPerTotal.DatabaseName := 'BDProyecto';
  QSalPerTotal.SQL.Add(' SELECT SUM( kilos ) as kilos ' +
    ' FROM tablaTemporal ' +
    ' WHERE (categoria=' + SQLString('1') +
    '       OR categoria=' + SQLString('2') + ') ' +
    ' AND tipo=' + SQLString('P') + ' ' +
    ' AND cliente <> ' + SQLString('RET'));
  QSalPerTotal.Open;
  totalPeriodo := QSalPerTotal.Fields[0].AsFloat;
  QSalPerTotal.Close;

  QSalPerTotal.SQL.Clear;
  QSalPerTotal.SQL.Add(' SELECT pais, SUM( kilos ) as kilos ' +
    ' FROM tablaTemporal ' +
    ' WHERE (categoria=' + SQLString('1') +
    '        OR categoria=' + SQLString('2') + ') ' +
    ' AND tipo=' + SQLString('P') + ' ' +
    ' AND cliente <> ' + SQLString('RET') +
    ' GROUP BY pais ORDER BY pais');


  QSalAcuCat1 := TQuery.Create(nil);
  QSalAcuCat1.DatabaseName := 'BDProyecto';
  QSalAcuCat1.SQL.Add(' SELECT pais, SUM( kilos ) as kilos ' +
    ' FROM tablaTemporal ' +
    ' WHERE categoria=' + SQLString('1') + ' ' +
    ' AND cliente <> ' + SQLString('RET') +
    ' GROUP BY pais ORDER BY pais');

  //Total acumulado
  QSalAcuTotal := TQuery.Create(nil);
  QSalAcuTotal.DatabaseName := 'BDProyecto';
  QSalAcuTotal.SQL.Add(' SELECT SUM( kilos ) as kilos ' +
    ' FROM tablaTemporal ' +
    ' WHERE (categoria=' + SQLString('1') +
    '        OR categoria=' + SQLString('2') + ') ' +
    ' AND cliente <> ' + SQLString('RET'));
  QSalAcuTotal.Open;
  totalAcumulado := QSalAcuTotal.Fields[0].AsFloat;
  QSalAcuTotal.Close;

  QSalAcuTotal.SQL.Clear;
  QSalAcuTotal.SQL.Add(' SELECT pais, descripcion_p, SUM( kilos ) as kilos ' +
    ' FROM tablaTemporal, frf_paises ' +
    ' WHERE pais=pais_p ' +
    ' AND (categoria=' + SQLString('1') +
    '      OR categoria=' + SQLString('2') + ') ' +
    ' AND cliente <> ' + SQLString('RET') +
    ' GROUP BY pais, descripcion_p ORDER BY pais ');

  //Desglose por calibre
  QSalPerEnv := TQuery.Create(nil);
  QSalPerEnv.DatabaseName := 'BDProyecto';
  QSalPerEnv.SQL.Add(' SELECT agrupacion, SUM( kilos ) as kilos ' +
    ' FROM tablaTemporal ' +
    ' WHERE (categoria=' + SQLString('1') +
    '        OR categoria=' + SQLString('2') + ') ' +
    ' AND tipo=' + SQLString('P') + '  ' +
    ' AND cliente <> ' + SQLString('RET') +
    ' GROUP BY agrupacion ORDER BY agrupacion ');

  QSalAcuEnv := TQuery.Create(nil);
  QSalAcuEnv.DatabaseName := 'BDProyecto';
  QSalAcuEnv.SQL.Add(' SELECT agrupacion, SUM( kilos ) as kilos ' +
    ' FROM tablaTemporal ' +
    ' WHERE (categoria=' + SQLString('1') +
    '        OR categoria=' + SQLString('2') + ') ' +
    ' AND cliente <> ' + SQLString('RET') +
    ' GROUP BY agrupacion ORDER BY agrupacion ');

  //Desglose por envase
  QSalPerTam := TQuery.Create(nil);
  QSalPerTam.DatabaseName := 'BDProyecto';
  QSalPerTam.SQL.Add(' SELECT calibre, SUM( kilos ) kilos, medida  ' +
    ' FROM tablaTemporal ' +
    ' WHERE (categoria=' + SQLString('1') +
    '        OR categoria=' + SQLString('2') + ') ' +
    ' AND tipo=' + SQLString('P') + ' ' +
    ' AND cliente <> ' + SQLString('RET') +
    ' GROUP BY medida,calibre ORDER BY medida,calibre');

  QSalAcuTam := TQuery.Create(nil);
  QSalAcuTam.DatabaseName := 'BDProyecto';
  QSalAcuTam.SQL.Add(' SELECT calibre, SUM( kilos ) kilos, medida ' +
    ' FROM tablaTemporal ' +
    ' WHERE (categoria=' + SQLString('1') +
    '        OR categoria=' + SQLString('2') + ') ' +
    ' AND cliente <> ' + SQLString('RET') +
    ' GROUP BY medida,calibre ORDER BY medida,calibre');

  //Desglose por color
  QSalPerColor.Open;
  QSalAcuColor.Open;
  datColores.DataSet := QSalAcuColor;
  psColor.DataSet := QSalAcuColor;

  //Desglose por pais y categoria
  QSalAcuTotal.Open;
  QSalAcuCat1.Open;
  QSalPerCat1.Open;
  QSalPerTotal.Open;

  //Desglose por calibre
  QSalAcuTam.Open;
  QSalPerTam.Open;

  //Desglose por envase
  QSalAcuEnv.Open;
  QSalPerEnv.Open;

end;

destructor TQRLSalidasResumen2.Destroy;
begin
  QSalPerColor.Close;
  QSalAcuColor.Close;
  QSalAcuTotal.Close;
  QSalPerCat1.Close;
  QSalPerTotal.Close;
  QSalAcuCat1.Close;
  QSalPerTam.Close;
  QSalAcuTam.Close;
  QSalPerEnv.Close;
  QSalAcuEnv.Close;

  QSalPerColor.Free;
  QSalAcuColor.Free;
  QSalAcuTotal.Free;
  QSalPerCat1.Free;
  QSalPerTotal.Free;
  QSalAcuCat1.Free;
  QSalPerTam.Free;
  QSalAcuTam.Free;
  QSalPerEnv.Free;
  QSalAcuEnv.Free;

  inherited;
end;

procedure TQRLSalidasResumen2.datPaisesNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  if ((QSalAcuTotal.EOF) and not MercadoNacional) then
    MoreData := false
  else MoreData := true;
end;

procedure SaltaEspanya;
begin
  with QRLSalidasResumen2 do
  begin
    MercadoNacional := true;
    if QSalAcuTotal.FieldByName('pais').AsString = 'ES' then
    begin
      totalEspA := Redondea(QSalAcuTotal.FieldByName('kilos').AsFloat);
      QSalAcuTotal.Next;
      if QSalAcuCat1.FieldByName('pais').AsString = 'ES' then
      begin
        cat1EspA := Redondea(QSalAcuCat1.FieldByName('kilos').AsFloat);
        QSalAcuCat1.Next;
      end
      else cat1EspA := 0;
      if QSalPerTotal.FieldByName('pais').AsString = 'ES' then
      begin
        totalEspP := Redondea(QSalPerTotal.FieldByName('kilos').AsFloat);
        QSalPerTotal.Next;
      end
      else totalEspP := 0;

      if QSalPerCat1.FieldByName('pais').AsString = 'ES' then
      begin
        cat1EspP := Redondea(QSalPerCat1.FieldByName('kilos').AsFloat);
        QSalPerCat1.Next;
      end
      else cat1EspP := 0;
    end;
  end;
end;

procedure PonEspanya;
begin
  with QRLSalidasResumen2 do
  begin
    LPais.Caption := 'ES';
    LNombre.Caption := 'ESPAÑA';

    if cat1EspP = 0 then
      LPerCat1.Caption := ''
    else
      LPerCat1.Caption := FormatFloat('#,##0', cat1EspP);
    if totalEspP - cat1EspP = 0 then
      LPerCat2.Caption := ''
    else
      LPerCat2.Caption := FormatFloat('#,##0', totalEspP - cat1EspP);
    if totalEspP = 0 then
      LPerTotal.Caption := ''
    else
      LPerTotal.Caption := FormatFloat('#,##0', totalEspP);

    if cat1EspA = 0 then
      LAcuCat1.Caption := ''
    else
      LAcuCat1.Caption := FormatFloat('#,##0', cat1EspA);
    if totalEspA - cat1EspA = 0 then
      LAcuCat2.Caption := ''
    else
      LAcuCat2.Caption := FormatFloat('#,##0', totalEspA - cat1EspA);
    if totalEspA = 0 then
      LAcuTotal.Caption := ''
    else
      LAcuTotal.Caption := FormatFloat('#,##0', totalEspA);

    cat1totalP := cat1totalP + cat1EspP;
    cat2totalP := cat2totalP + totalEspP - cat1EspP;
    cat1totalA := cat1totalA + cat1EspA;
    cat2totalA := cat2totalA + totalEspA - cat1EspA;
  end;
end;

procedure TQRLSalidasResumen2.datPaisesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var aux3, aux4: real;
begin
  begin
    if (QSalAcuTotal.EOF) and MercadoNacional then
    begin
      PonEspanya;
      MercadoNacional := false;
      Exit;
    end;
    if not MercadoNacional and (QSalAcuTotal.FieldByName('pais').AsString = 'ES') then
    begin
      SaltaEspanya;
      PrintBand := false;
      Exit;
    end;
  end;

  datPaisesBeforePrintNormal;


//***************** Periodo Total ***********************************
  if (QSalPerTotal.FieldByName('pais').AsString = LPais.Caption) then
  begin
    if LPais.Caption = 'DE' then
    begin
      LPerTotal.Caption := FormatFloat('#,##0', QSalPerTotal.FieldByName('kilos').AsFloat);
      aux4 := Redondea(QSalPerTotal.FieldByName('kilos').AsFloat);
      QSalPerTotal.Next;
    end
    else
    begin
      LPerTotal.Caption := FormatFloat('#,##0', QSalPerTotal.FieldByName('kilos').AsFloat);
      aux4 := Redondea(QSalPerTotal.FieldByName('kilos').AsFloat);
      QSalPerTotal.Next;
    end;

    if (QSalAcuTotal.FieldByName('pais').AsString =
      QSalPerCat1.FieldByName('pais').AsString) (*or (LPais.Caption = 'DE')*) then
    begin
      if LPais.Caption = 'DE' then
      begin
        LPerCat1.Caption := FormatFloat('#,##0', QSalPerCat1.FieldByName('kilos').AsFloat);
        aux3 := Redondea(QSalPerCat1.FieldByName('kilos').AsFloat);
        QSalPerCat1.Next;
      end
      else
      begin
        LPerCat1.Caption := FormatFloat('#,##0', QSalPerCat1.FieldByName('kilos').AsFloat);
        aux3 := Redondea(QSalPerCat1.FieldByName('kilos').AsFloat);
        QSalPerCat1.Next;
      end;
    end
    else
    begin
      LPerCat1.Caption := '';
      aux3 := 0;
    end;

    if Trim(LPerCat1.Caption) <> '' then
    begin
      cat1totalP := cat1totalP + aux3;
    end;

    if LPerCat1.Caption = LPerTotal.Caption then
    begin
      LPerCat2.Caption := '';
    end
    else
    begin
      aux3 := aux4 - aux3;
      cat2totalP := cat2totalP + aux3;
      LPerCat2.Caption := formatfloat('#,##', aux3);
    end;
  end
  else
  begin
    LPerCat1.Caption := '';
    LPerCat2.Caption := '';
    LPerTotal.Caption := '';
  end;
//***************** Siguiente linea ***********************************
  if QSalAcuTotal.FieldByName('pais').AsString = LPais.Caption then
    QSalAcuTotal.Next;
end;

procedure TQRLSalidasResumen2.datPaisesBeforePrintNormal;
var aux, aux2: real;
begin
//***************** ACumulado total ***********************************
  LPais.Caption := QSalAcuTotal.FieldByName('pais').AsString;
  LNombre.Caption := QSalAcuTotal.FieldByName('descripcion_p').AsString;
  if LPais.Caption = 'DE' then
  begin
    LAcuTotal.Caption := FormatFloat('#,##0', QSalAcuTotal.FieldByName('kilos').AsFloat);
    aux2 := Redondea(QSalAcuTotal.FieldByName('kilos').AsFloat);
  end
  else
  begin
    LAcuTotal.Caption := FormatFloat('#,##0', QSalAcuTotal.FieldByName('kilos').AsFloat);
    aux2 := Redondea(QSalAcuTotal.FieldByName('kilos').AsFloat);
  end;

//***************** ACumulado Categoria 1 ***********************************
  if (QSalAcuCat1.FieldByName('pais').AsString = LPais.Caption) then
  begin
    if LPais.Caption = 'DE' then
    begin
      LAcuCat1.Caption := FormatFloat('#,##0', QSalAcuCat1.FieldByName('kilos').AsFloat);
      aux := Redondea(QSalAcuCat1.FieldByName('kilos').AsFloat);
      QSalAcuCat1.Next;
    end
    else
    begin
      LAcuCat1.Caption := FormatFloat('#,##0', QSalAcuCat1.FieldByName('kilos').AsFloat);
      aux := Redondea(QSalAcuCat1.FieldByName('kilos').AsFloat);
      QSalAcuCat1.Next;
    end;
  end
  else
  begin
    LAcuCat1.Caption := '';
    aux := 0;
  end;

  if Trim(LAcuCat1.Caption) <> '' then
  begin
    cat1totalA := cat1totalA + aux;
  end;

  if LAcuCat1.Caption = LAcuTotal.Caption then
  begin
    LAcuCat2.Caption := '';
  end
  else
  begin
    aux := aux2 - aux;
    cat2totalA := cat2totalA + aux;
    LAcuCat2.Caption := formatfloat('#,##', aux);
  end;
end;

procedure TQRLSalidasResumen2.piePaisesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if totalAcumulado = 0 then
  begin
    PrintBand := false;
    Exit;
  end;

  piePaises.Height := 33;

  if cat1totalP <> 0 then
    LTPerCat1.Caption := formatfloat('#,##', cat1totalP)
  else
    LTPerCat1.Caption := '';
  if cat2totalP <> 0 then
    LTPerCat2.Caption := formatfloat('#,##', cat2totalP)
  else
    LTPerCat2.Caption := '';
  if (cat1totalP <> 0) or (cat2totalP <> 0) then
  begin
        //totalPeriodo:=cat1totalP+cat2totalP;
    LTPerTotal.Caption := formatfloat('#,##', totalPeriodo);
  end
  else
    LTPerTotal.Caption := '';
  if cat1totalA <> 0 then
    LTAcuCat1.Caption := formatfloat('#,##', cat1totalA)
  else
    LTAcuCat1.Caption := '';
  if cat2totalA <> 0 then
    LTAcuCat2.Caption := formatfloat('#,##', cat2totalA)
  else
    LTAcuCat2.Caption := '';
  if (cat1totalA <> 0) or (cat2totalA <> 0) then
  begin
        //totalAcumulado:=cat1totalA+cat2totalA;
    LTAcuTotal.Caption := formatfloat('#,##', totalAcumulado);
  end
  else
    LTAcuTotal.Caption := '';

     //PonEquivalenciaPorPaises1;
end;

procedure TQRLSalidasResumen2.QRLSalidasResumenBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  QSalPerColor.First;
  _acumPerColor := 0;
  _acumTantoPerColor := 0;
  _acumAcuColor := 0;
  _acumTantoAcuColor := 0;

  LPerCat1.Caption := '';
  LPerCat2.Caption := '';
  LPerTotal.Caption := '';
  LAcuCat1.Caption := '';
  LAcuCat2.Caption := '';
  LAcuTotal.Caption := '';
  LTam.Caption := '';
  LTamPer.Caption := '';
  LTamPerPor.Caption := '';
  LTamAcu.Caption := '';
  LTamAcuPor.Caption := '';
  LTTamPer.Caption := '';
  LTTamPerPor.Caption := '';
  LTTamAcu.Caption := '';
  LTTamAcuPor.Caption := '';
  LEnv.Caption := '';
  LEnvPer.Caption := '';
  LEnvPerPor.Caption := '';
  LEnvAcu.Caption := '';
  LEnvAcuPor.Caption := '';
  LTEnvPer.Caption := '';
  LTEnvPerPor.Caption := '';
  LTEnvAcu.Caption := '';
  LTEnvAcuPor.Caption := '';
  cat1totalP := 0;
  cat2totalP := 0;
  cat1totalA := 0;
  cat2totalA := 0;
  tamPerTotal := 0;
  tamAcuTotal := 0;
  envPerTotal := 0;
  envAcuTotal := 0;
  cat1EspP := 0;
  totalEspP := 0;
  cat1EspA := 0;
  totalEspA := 0;
  MercadoNacional := false;

  QSalPerCat1.First;
  QSalPerTotal.First;
  QSalAcuCat1.First;
  QSalAcuTotal.First;
  QSalPerTam.First;
  QSalAcuTam.First;
  QSalPerEnv.First;
  QSalAcuEnv.First;

  MercadoNacional := false;
end;

procedure TQRLSalidasResumen2.datCalibreNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  if (not QSalAcuTam.EOF) or (not QSalAcuEnv.EOF) then
    MoreData := true
  else MoreData := false;
end;

procedure PonCalibreNormal;
begin
  with QRLSalidasResumen2 do
  begin
     //INICIO CATEGORIA**************************************************
    if (not QSalAcuTam.EOF) then
    begin
      LTam.Caption := QSalAcuTam.FieldByName('calibre').AsString;
      if Trim(QSalAcuTam.FieldByName('calibre').AsString) = 'MM' then
      begin
        LTamAcu.Caption := FormatFloat('#,##0', QSalAcuTam.FieldByName('kilos').AsFloat);
        cat2totalP := Redondea(QSalAcuTam.FieldByName('kilos').AsFloat);
      end
      else
      begin
        LTamAcu.Caption := FormatFloat('#,##0', QSalAcuTam.FieldByName('kilos').AsFloat);
        cat2totalP := Redondea(QSalAcuTam.FieldByName('kilos').AsFloat);
      end;

      tamAcuTotal := tamAcuTotal + cat2totalP;
      if totalAcumulado = 0 then
        LTamAcuPor.Caption := ''
      else
        LTamAcuPor.Caption := formatfloat('#,##', (cat2totalP / totalAcumulado) * 100);

      if Trim(QSalPerTam.FieldByName('kilos').AsString) <> '' then
      begin
        if Trim(QSalPerTam.FieldByName('calibre').AsString) = LTam.Caption then
        begin
          if Trim(QSalPerTam.FieldByName('calibre').AsString) = 'MM' then
          begin
            LTamPer.Caption := FormatFloat('#,##0', QSalPerTam.FieldByName('kilos').AsFloat);
            cat1totalP := Redondea(QSalPerTam.FieldByName('kilos').AsFloat);
          end
          else
          begin
            LTamPer.Caption := FormatFloat('#,##0', QSalPerTam.FieldByName('kilos').AsFloat);
            cat1totalP := Redondea(QSalPerTam.FieldByName('kilos').AsFloat);
          end;
          tamPerTotal := tamPerTotal + cat1totalP;
          if totalPeriodo = 0 then
            LTamPerPor.Caption := ''
          else
            LTamPerPor.Caption := formatfloat('#,##', (cat1totalP / totalPeriodo) * 100);
          QSalPerTam.Next;
        end
        else
        begin
          LTamPer.Caption := '';
          LTamPerPor.Caption := '';
        end;
      end;
      QSalAcuTam.Next;
    end
    else
    begin
      LTam.Caption := '';
      LTamPer.Caption := '';
      LTamPerPor.Caption := '';
      LTamAcu.Caption := '';
      LTamAcuPor.Caption := '';
    end;
  end;
  //FIN CATEGORIA**************************************************
end;

procedure PonCalibre;
begin
  PonCalibreNormal;
end;

procedure PonEnvaseNormal;
begin
  with QRLSalidasResumen2 do
  begin
          //INICIO CATEGORIA**************************************************
    if (not QSalAcuEnv.EOF) then
    begin
      LEnv.Caption := QSalAcuEnv.FieldByName('agrupacion').AsString;
      if Trim(QSalAcuEnv.FieldByName('agrupacion').AsString) = 'GRANEL' then
      begin
        LEnvAcu.Caption := FormatFloat('#,##0', QSalAcuEnv.FieldByName('kilos').AsFloat);
        cat2totalA := Redondea(QSalAcuEnv.FieldByName('kilos').AsFloat);
      end
      else
      begin
        LEnvAcu.Caption := FormatFloat('#,##0', QSalAcuEnv.FieldByName('kilos').AsFloat);
        cat2totalA := Redondea(QSalAcuEnv.FieldByName('kilos').AsFloat);
      end;

      EnvAcuTotal := EnvAcuTotal + cat2totalA;
      if totalAcumulado = 0 then
        LEnvAcuPor.Caption := ''
      else
        LEnvAcuPor.Caption := formatfloat('#,##', (cat2totalA / totalAcumulado) * 100);

      if Trim(QSalPerEnv.FieldByName('kilos').AsString) <> '' then
      begin
        if Trim(QSalPerEnv.FieldByName('agrupacion').AsString) = LEnv.Caption then
        begin
          if Trim(QSalPerEnv.FieldByName('agrupacion').AsString) = 'GRANEL' then
          begin
            LEnvPer.Caption := FormatFloat('#,##0', QSalPerEnv.FieldByName('kilos').AsFloat);
            cat1totalA := Redondea(QSalPerEnv.FieldByName('kilos').AsFloat);
          end
          else
          begin
            LEnvPer.Caption := FormatFloat('#,##0', QSalPerEnv.FieldByName('kilos').AsFloat);
            cat1totalA := Redondea(QSalPerEnv.FieldByName('kilos').AsFloat);
          end;
          EnvPerTotal := EnvPerTotal + cat1totalA;
          if totalPeriodo = 0 then
            LEnvPerPor.Caption := ''
          else
            LEnvPerPor.Caption := formatfloat('#,##', (cat1totalA / totalPeriodo) * 100);
                //*********** Siguiente linea *****************************
          QSalPerEnv.Next;
        end
        else
        begin
          LEnvPer.Caption := '';
          LEnvPerPor.Caption := '';
        end;
      end;

      QSalAcuEnv.Next;
    end
    else
    begin
      LEnv.Caption := '';
      LEnvPer.Caption := '';
      LEnvPerPor.Caption := '';
      LEnvAcu.Caption := '';
      LEnvAcuPor.Caption := '';
    end;
          //FIN ENVASE**************************************************
  end;
end;

procedure PonEnvase;
begin
  PonEnvaseNormal;
end;

procedure TQRLSalidasResumen2.datCalibreBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PonCalibre;
  PonEnvase;
end;

procedure TQRLSalidasResumen2.pieCalibreBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if totalAcumulado = 0 then
  begin
    PrintBand := false;
    Exit;
  end;

  pieCalibre.Height := 33;

  LTTamAcu.Caption := formatfloat('#,##', tamAcuTotal);
     //LTTamAcuE.Caption:=formatfloat('#,##',tamAcuTotal/6);
  if totalAcumulado = 0 then
    LTTamAcuPor.Caption := ''
  else
    LTTamAcuPor.Caption := formatfloat('#,##', (tamAcuTotal / totalAcumulado) * 100);
  LTEnvAcu.Caption := formatfloat('#,##', envAcuTotal);
     //LTEnvAcuE.Caption:=formatfloat('#,##',envAcuTotal/6);
  if totalAcumulado = 0 then
    LTEnvAcuPor.Caption := ''
  else
    LTEnvAcuPor.Caption := formatfloat('#,##', (envAcuTotal / totalAcumulado) * 100);

  if tamPerTotal > 0 then
  begin
    LTTamPer.Caption := formatfloat('#,##', tamPerTotal);
          //LTTamPerE.Caption:=formatfloat('#,##',tamPerTotal/6);
    if totalPeriodo = 0 then
      LTTamPerPor.Caption := ''
    else
      LTTamPerPor.Caption := formatfloat('#,##', (tamPerTotal / totalPeriodo) * 100);
  end
  else
  begin
    LTTamPer.Caption := '';
          //LTTamPerE.Caption:='';
    LTTamPerPor.Caption := '';
  end;
  if envPerTotal > 0 then
  begin
    LTEnvPer.Caption := formatfloat('#,##', envPerTotal);
          //LTEnvPerE.Caption:=formatfloat('#,##',envPerTotal/6);
    if totalPeriodo = 0 then
      LTEnvPerPor.Caption := ''
    else
      LTEnvPerPor.Caption := formatfloat('#,##', (envPerTotal / totalPeriodo) * 100);
  end
  else
  begin
    LTEnvPer.Caption := '';
          //LTEnvPerE.Caption:='';
    LTEnvPerPor.Caption := '';
  end;

  cat1totalP := 0;
  cat2totalP := 0;
  cat1totalA := 0;
  cat2totalA := 0;
  tamPerTotal := 0;
  tamAcuTotal := 0;
end;

procedure TQRLSalidasResumen2.datColoresBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Trim(QSalAcuColor.FieldByName('color').AsString) =
    Trim(QSalPerColor.FieldByName('color').AsString) then
  begin
    if Trim(QSalAcuColor.FieldByName('color').AsString) = '4' then
    begin
      _acumPerColor := _acumPerColor + QSalPerColor.FieldByName('kilos').asFloat;
      _acumTantoPerColor := _acumTantoPerColor + (QSalPerColor.FieldByName('kilos').asfloat) * 100 / totalPeriodo;
      PerColor.Caption := FormatFloat('#,##', QSalPerColor.FieldByName('kilos').asFloat);
      tantoPerColor.Caption := FormatFloat('#,##', ((QSalPerColor.FieldByName('kilos').asfloat) * 100 / totalPeriodo));
    end
    else
    begin
      _acumPerColor := _acumPerColor + QSalPerColor.FieldByName('kilos').asFloat;
      _acumTantoPerColor := _acumTantoPerColor + QSalPerColor.FieldByName('kilos').asfloat * 100 / totalPeriodo;
      PerColor.Caption := FormatFloat('#,##', QSalPerColor.FieldByName('kilos').asFloat);
      tantoPerColor.Caption := FormatFloat('#,##', (QSalPerColor.FieldByName('kilos').asfloat * 100 / totalPeriodo));
    end;
    QSalPerColor.Next;
  end
  else
  begin
    PerColor.Caption := '';
    tantoPerColor.Caption := '';
  end;

  if Trim(QSalAcuColor.FieldByName('color').AsString) = '4' then
  begin
    _acumAcuColor := _acumAcuColor + QSalAcuColor.FieldByName('kilos').asfloat;
    _acumTantoAcuColor := _acumTantoAcuColor + (QSalAcuColor.FieldByName('kilos').asfloat) * 100 / totalAcumulado;
    AcuColor.Caption := FormatFloat('#,##', QSalAcuColor.FieldByName('kilos').asfloat);
    tantoAcuColor.Caption := FormatFloat('#,##', ((QSalAcuColor.FieldByName('kilos').asfloat) * 100 / totalAcumulado));
  end
  else
  begin
    _acumAcuColor := _acumAcuColor + QSalAcuColor.FieldByName('kilos').asfloat;
    _acumTantoAcuColor := _acumTantoAcuColor + QSalAcuColor.FieldByName('kilos').asfloat * 100 / totalAcumulado;
    AcuColor.Caption := FormatFloat('#,##', QSalAcuColor.FieldByName('kilos').asfloat);
    tantoAcuColor.Caption := FormatFloat('#,##', (QSalAcuColor.FieldByName('kilos').asfloat * 100 / totalAcumulado));
  end;
end;

procedure TQRLSalidasResumen2.psColorPrint(sender: TObject;
  var Value: string);
begin
  Value := desColor(empresa, producto, Value);
end;

procedure TQRLSalidasResumen2.QRBColoresFooterBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if totalAcumulado = 0 then
  begin
    PrintBand := false;
    Exit;
  end;

  acumAcuColor.caption := FormatFloat('#,##', _acumAcuColor);
  acumTantoAcuColor.caption := FormatFloat('#,##', _acumTantoAcuColor);
  acumPerColor.caption := FormatFloat('#,##', _acumPerColor);
  acumTantoPerColor.caption := FormatFloat('#,##', _acumTantoPerColor);
  equiAcuColor.Caption := FormatFloat('#', _acumAcuColor / 6);
  equiPerColor.Caption := FormatFloat('#', _acumPerColor / 6);
end;

procedure TQRLSalidasResumen2.cabCalibreBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := totalAcumulado <> 0;
end;

procedure TQRLSalidasResumen2.QRBColoresHeaderBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if totalAcumulado = 0 then
  begin
    PrintBand := false;
    Exit;
  end;
end;

procedure TQRLSalidasResumen2.cabPaisesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if totalAcumulado = 0 then
  begin
    PrintBand := false;
    Exit;
  end;
end;

end.
