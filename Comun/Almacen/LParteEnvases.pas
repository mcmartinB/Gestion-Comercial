unit LParteEnvases;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DBTables, Provider, DB,
  DBClient, kbmMemTable, MidasLib, Dialogs, grimgctrl;

type
  TQRParteEnvases = class(TQuickRep)
    BandaDetalle: TQRBand;
    BandaCabecera: TQRBand;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRLabel9: TQRLabel;
    LCentro: TQRLabel;
    QRSysData1: TQRSysData;
    periodo: TQRLabel;
    MemTable: TkbmMemTable;
    MemTablecategoria: TStringField;
    MemTableenvase: TStringField;
    MemTableactual: TFloatField;
    MemTablenacional: TFloatField;
    MemTableexportacion: TFloatField;
    MemTabletransitos: TFloatField;
    MemTableanterior: TFloatField;
    ClientDataSet: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    ClientDataSetcategoria: TStringField;
    ClientDataSetenvase: TStringField;
    ClientDataSetactual: TFloatField;
    ClientDataSetnacional: TFloatField;
    ClientDataSetexportacion: TFloatField;
    ClientDataSettransitos: TFloatField;
    ClientDataSetanterior: TFloatField;
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    BandaProducto: TQRGroup;
    QRExpr18: TQRExpr;
    BandaPieProducto: TQRBand;
    QRExpr27: TQRExpr;
    QRExpr28: TQRExpr;
    QRExpr29: TQRExpr;
    QRExpr30: TQRExpr;
    QRExpr31: TQRExpr;
    QRExpr32: TQRExpr;
    QRExpr33: TQRExpr;
    QRExpr34: TQRExpr;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    ClientDataSetproducto: TStringField;
    MemTableproducto: TStringField;
    BandaCategoria: TQRGroup;
    QRExpr26: TQRExpr;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    procedure QRExpr17Print(sender: TObject; var Value: string);
    procedure QRExpr1Print(sender: TObject; var Value: string);
    procedure QRExpr2Print(sender: TObject; var Value: string);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr18Print(sender: TObject; var Value: string);
    procedure QRExpr34Print(sender: TObject; var Value: string);
  private

  public
    sEmpresa, sCentro, sProducto: string;
    dFechaDesde, dFechaHasta: TDate;

    procedure InsertarDato(const ATipo: string);
    procedure DatosActual;
    procedure DatosAnterior;
    procedure SalidasDirectasNacional;
    procedure SalidasDirectasExportacion;
    procedure Transitos;

  end;

procedure Visualizar(const AEmpresa, ACentro, AProducto: string;
  const AFechaDesde, AFechaHasta: TDate);

var
  QRParteEnvases: TQRParteEnvases;

implementation

{$R *.DFM}

uses DPreview, CReportes, UDMAuxDB, variants;

procedure Visualizar(const AEmpresa, ACentro, AProducto: string;
  const AFechaDesde, AFechaHasta: TDate);
begin
  QRParteEnvases := TQRParteEnvases.Create(nil);
  try
    with QRParteEnvases do
    begin
      sEmpresa := AEmpresa;
      sCentro := ACentro;
      sProducto := AProducto;
      dFechaHasta := AFechaHasta;
      dFechaDesde := AFechaDesde;

      Periodo.Caption := 'DEL ' + DateToStr(dFechaDesde) + ' AL ' + DateToStr(dFechaHasta);
      LCentro.Caption := desCentro(AEmpresa, ACentro);

      ClientDataSet.Open;
      DatosActual;
      DatosAnterior;
      SalidasDirectasNacional;
      SalidasDirectasExportacion;
      Transitos;

      if ClientDataSet.IsEmpty then
      begin
        ShowMessage('Listado sin datos.');
        exit;
      end;

      PonLogoGrupoBonnysa(QRParteEnvases, AEmpresa);
      DPreview.Preview(QRParteEnvases);
    end;
  except
    if QRParteEnvases <> nil then
    begin
      FreeAndNil(QRParteEnvases);
    end;
  end;
end;

procedure TQRParteEnvases.InsertarDato(const ATipo: string);
var
  sProducto, sCategoria, sEnvase: string;
begin
  if DMAuxDB.QAux.FieldByName('kilos').AsFloat = 0 then
    Exit;

  sProducto := DMAuxDB.QAux.FieldByName('producto').AsString;
  sCategoria := DMAuxDB.QAux.FieldByName('categoria').AsString;
  sEnvase := DMAuxDB.QAux.FieldByName('envase').AsString;
  with ClientDataSet do
  begin
    //Buscar a ver si ya esta grabado
    if Locate('producto;categoria;envase', VarArrayOf([sProducto, sCategoria, sEnvase]), []) then
    begin
      Edit;
    end
    else
    begin
      Insert;
      ClientDataSetproducto.AsString := sProducto;
      ClientDataSetcategoria.AsString := sCategoria;
      ClientDataSetenvase.AsString := sEnvase;
    end;
    ClientDataSet.FieldByName(ATipo).AsFloat := DMAuxDB.QAux.FieldByName('kilos').AsFloat;
    Post;
  end;
end;

procedure TQRParteEnvases.DatosActual;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_il producto, ''1'' categoria, envase_il envase, sum(kilos_ce_c1_il) kilos');
    SQL.Add(' from  frf_inventarios_l ');
    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    if sProducto <> ''  then
      SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha ');
    SQL.Add(' group by 1,2,3 ');
    SQL.Add(' UNION ');
    SQL.Add(' select producto_il producto, ''2'' categoria, envase_il envase, sum(kilos_ce_c2_il) kilos');
    SQL.Add(' from  frf_inventarios_l ');
    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    if sProducto <> ''  then
      SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha ');
    SQL.Add(' group by 1,2,3 ');
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    if sProducto <> '' then
      ParamByName('producto').AsString := sProducto;
    ParamByName('fecha').AsDate := dFechaHasta;
    Open;
    while not EOF do
    begin
      InsertarDato('actual');
      Next;
    end;
    Close;
  end;
end;

procedure TQRParteEnvases.DatosAnterior;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_il producto, ''1'' categoria, envase_il envase, sum(kilos_ce_c1_il) kilos');
    SQL.Add(' from  frf_inventarios_l ');
    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    if sProducto <> ''  then
      SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha ');
    SQL.Add(' group by 1,2,3 ');
    SQL.Add(' UNION ');
    SQL.Add(' select producto_il producto, ''2'' categoria, envase_il envase, sum(kilos_ce_c2_il) kilos');
    SQL.Add(' from  frf_inventarios_l ');
    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    if sProducto <> ''  then
      SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha ');
    SQL.Add(' group by 1,2,3 ');
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    if sProducto <> '' then
      ParamByName('producto').AsString := sProducto;
    ParamByName('fecha').AsDate := dFechaDesde - 1;
    Open;
    while not EOF do
    begin
      InsertarDato('anterior');
      Next;
    end;
    Close;
  end;
end;

procedure TQRParteEnvases.SalidasDirectasNacional;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_sl producto, categoria_sl categoria, envase_sl envase, sum( kilos_sl ) kilos');

    SQL.Add(' from  frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and fecha_sc between :fechaDesde and :fechaHasta ');

    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    if sProducto <> ''  then
      SQL.Add(' and producto_sl = :producto ');

    if sEmpresa = '037' then
    begin
      SQL.Add(' and categoria_sl = ''I'' ');
    end
    else
    begin
      SQL.Add(' and categoria_sl in (''1'', ''2'') ');
    end;

    SQL.Add('  and nvl(es_transito_sc,0) = 0 ');    
    SQL.Add(' and ref_transitos_sl is null ');
    SQL.Add(' and exists ( select * from frf_clientes where cliente_c = cliente_sl ');
    SQL.Add('                                           and pais_c = ''ES'' ) ');
    SQL.Add(' group by 1,2,3 ');

    ParamByName('empresa').AsString := sEmpresa;
    if sProducto <> '' then
      ParamByName('producto').AsString := sProducto;
    ParamByName('centro').AsString := sCentro;
    ParamByName('fechaDesde').AsDate := dFechaDesde;
    ParamByName('fechaHasta').AsDate := dFechaHasta;
    Open;
    while not EOF do
    begin
      InsertarDato('nacional');
      Next;
    end;
    Close;
  end;
end;

procedure TQRParteEnvases.SalidasDirectasExportacion;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_sl producto, categoria_sl categoria, envase_sl envase, sum( kilos_sl ) kilos');
    SQL.Add(' from  frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and fecha_sc between :fechaDesde and :fechaHasta ');

    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');

    if sProducto <> ''  then
      SQL.Add(' and producto_sl = :producto ');

    if sEmpresa = '037' then
    begin
      SQL.Add(' and categoria_sl = ''I'' ');
    end
    else
    begin
      SQL.Add(' and categoria_sl in (''1'', ''2'') ');
    end;

    SQL.Add('  and nvl(es_transito_sc,0) = 0 ');
    SQL.Add(' and ref_transitos_sl is null ');
    SQL.Add(' and exists ( select * from frf_clientes where cliente_c = cliente_sl ');
    SQL.Add('                                           and pais_c <> ''ES'' ) ');
    SQL.Add(' group by 1,2,3 ');

    ParamByName('empresa').AsString := sEmpresa;
    if sProducto <> '' then
      ParamByName('producto').AsString := sProducto;
    ParamByName('centro').AsString := sCentro;
    ParamByName('fechaDesde').AsDate := dFechaDesde;
    ParamByName('fechaHasta').AsDate := dFechaHasta;
    Open;
    while not EOF do
    begin
      InsertarDato('exportacion');
      Next;
    end;
    Close;
  end;
end;

procedure TQRParteEnvases.Transitos;

begin
  if sEmpresa = '037' then
    Exit;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_tl producto, categoria_tl categoria, envase_tl envase, sum( kilos_tl ) kilos');
    SQL.Add(' from  frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and centro_tl = :centro ');
    if sProducto <> ''  then
      SQL.Add(' and producto_tl = :producto ');
    SQL.Add(' and fecha_tl between :fechaDesde and :fechaHasta ');
    SQL.Add(' group by 1,2,3 ');

    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    if sProducto <> '' then
      ParamByName('producto').AsString := sProducto;
    ParamByName('fechaDesde').AsDate := dFechaDesde;
    ParamByName('fechaHasta').AsDate := dFechaHasta;
    Open;
    while not EOF do
    begin
      InsertarDato('transitos');
      Next;
    end;
    Close;
  end;
end;

procedure TQRParteEnvases.QRExpr17Print(sender: TObject; var Value: string);
begin
  Value := 'TOTALES CAT. ' + Value;
end;

procedure TQRParteEnvases.QRExpr18Print(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesProducto(sEmpresa, DataSet.Fieldbyname('producto').AsString);
end;

procedure TQRParteEnvases.QRExpr1Print(sender: TObject; var Value: string);
begin
  if Value = '1' then
    Value := 'CATEGORIA 1ª'
  else
    if Value = '2' then
      Value := 'CATEGORIA 2ª'
    else
      if Value = 'I' then
        Value := 'CATEGORIA I';
end;

procedure TQRParteEnvases.QRExpr2Print(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesEnvase(sEmpresa, Value);
end;

procedure TQRParteEnvases.QRExpr34Print(sender: TObject; var Value: string);
begin
  Value := 'TOTAL ' + Value;
end;

procedure TQRParteEnvases.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := DataSet.FieldByName('categoria').AsString = '2';
end;

end.
