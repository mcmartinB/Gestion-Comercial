unit UQLConfecPorAgrupacion;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DBTables, Provider, DB,
  DBClient, kbmMemTable, MidasLib;

type
  TQLConfecPorAgrupacion = class(TQuickRep)
    BandaDetalle: TQRBand;
    BandaCabecera: TQRBand;
    BandaCabGrupo: TQRGroup;
    BandaPieGrupo: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    QRExpr16: TQRExpr;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRExpr17: TQRExpr;
    QRShape1: TQRShape;
    ChildBand1: TQRChildBand;
    ChildBand2: TQRChildBand;
    QRExpr19: TQRExpr;
    QRExpr20: TQRExpr;
    QRExpr21: TQRExpr;
    QRExpr22: TQRExpr;
    QRExpr23: TQRExpr;
    QRExpr24: TQRExpr;
    QRExpr25: TQRExpr;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    LCentro: TQRLabel;
    ProductoDia: TQRLabel;
    QRSysData1: TQRSysData;
    ChildBand3: TQRChildBand;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
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
    procedure QRExpr17Print(sender: TObject; var Value: string);
    procedure QRExpr1Print(sender: TObject; var Value: string);
    procedure QRExpr2Print(sender: TObject; var Value: string);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
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
  QLConfecPorAgrupacion: TQLConfecPorAgrupacion;

implementation

{$R *.DFM}

uses DPreview, CReportes, UDMAuxDB, variants;

procedure Visualizar(const AEmpresa, ACentro, AProducto: string;
  const AFechaDesde, AFechaHasta: TDate);
begin
  QLConfecPorAgrupacion := TQLConfecPorAgrupacion.Create(nil);
  try
    with QLConfecPorAgrupacion do
    begin
      sEmpresa := AEmpresa;
      sCentro := ACentro;
      sProducto := AProducto;
      dFechaHasta := AFechaHasta;
      dFechaDesde := AFechaDesde;

      ProductoDia.Caption := AProducto + '/' + DesProducto(AEmpresa, AProducto);
      Periodo.Caption := 'DEL ' + DateToStr(dFechaDesde) + ' AL ' + DateToStr(dFechaHasta);
      LCentro.Caption := desCentro(AEmpresa, ACentro);

      ClientDataSet.Open;
      DatosActual;
      DatosAnterior;
      SalidasDirectasNacional;
      SalidasDirectasExportacion;
      Transitos;

      PonLogoGrupoBonnysa(QLConfecPorAgrupacion, AEmpresa);
      DPreview.Preview(QLConfecPorAgrupacion);
    end;
  except
    if QLConfecPorAgrupacion <> nil then
    begin
      FreeAndNil(QLConfecPorAgrupacion);
    end;
  end;
end;

procedure TQLConfecPorAgrupacion.InsertarDato(const ATipo: string);
var
  sCategoria, sEnvase: string;
begin
  if DMAuxDB.QAux.FieldByName('kilos').AsFloat = 0 then
    Exit;

  sCategoria := DMAuxDB.QAux.FieldByName('categoria').AsString;
  sEnvase := DMAuxDB.QAux.FieldByName('envase').AsString;
  if sEnvase = '' then
    sEnvase:= 'SIN AGRUPACIÓN';
  with ClientDataSet do
  begin
    //Buscar a ver si ya esta grabado
    if Locate('categoria;envase', VarArrayOf([sCategoria, sEnvase]), []) then
    begin
      Edit;
    end
    else
    begin
      Insert;
      ClientDataSetcategoria.AsString := sCategoria;
      ClientDataSetenvase.AsString := sEnvase;
    end;
    ClientDataSet.FieldByName(ATipo).AsFloat := DMAuxDB.QAux.FieldByName('kilos').AsFloat;
    Post;
  end;
end;

procedure TQLConfecPorAgrupacion.DatosActual;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select ''1'' categoria, ');
    SQL.Add('         ( select agrupacion_e from frf_envases ');
    SQL.Add('           where envase_e = envase_il ');
    SQL.Add('                 and producto_e = producto_il ) envase, ');
    SQL.Add('        sum(kilos_ce_c1_il) kilos ');
    SQL.Add(' from  frf_inventarios_l ');
    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha ');
    SQL.Add(' group by 1,2 ');
    SQL.Add(' UNION ');
    SQL.Add(' select ''2'' categoria, ');
    SQL.Add('         ( select agrupacion_e from frf_envases ');
    SQL.Add('           where envase_e = envase_il ');
    SQL.Add('             and producto_e = producto_il ) envase, ');
    SQL.Add('        sum(kilos_ce_c2_il) kilos ');
    SQL.Add(' from  frf_inventarios_l ');
    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha ');
    SQL.Add(' group by 1,2 ');
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
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

procedure TQLConfecPorAgrupacion.DatosAnterior;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select ''1'' categoria, ');
    SQL.Add('         ( select agrupacion_e from frf_envases ');
    SQL.Add('           where envase_e = envase_il ');
    SQL.Add('             and producto_e = producto_il ) envase, ');
    SQL.Add('     sum(kilos_ce_c1_il) kilos');
    SQL.Add(' from  frf_inventarios_l ');
    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha ');
    SQL.Add(' group by 1,2 ');
    SQL.Add(' UNION ');
    SQL.Add(' select ''2'' categoria, ');
    SQL.Add('         ( select agrupacion_e from frf_envases ');
    SQL.Add('           where envase_e = envase_il ');
    SQL.Add('             and producto_e = producto_il ) envase, ');
    SQL.Add('     sum(kilos_ce_c2_il) kilos');
    SQL.Add(' from  frf_inventarios_l ');
    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha ');
    SQL.Add(' group by 1,2 ');
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
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

procedure TQLConfecPorAgrupacion.SalidasDirectasNacional;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select categoria_sl categoria, ');
    SQL.Add('         ( select agrupacion_e from frf_envases ');
    SQL.Add('           where envase_e = envase_sl ');
    SQL.Add('             and producto_e = producto_sl ) envase, ');
    SQL.Add('     sum( kilos_sl ) kilos');

    SQL.Add(' from  frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and fecha_sc between :fechaDesde and :fechaHasta ');

    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');

    SQL.Add(' and producto_sl = :producto ');

    if sEmpresa = '037' then
    begin
      SQL.Add(' and categoria_sl = ''I'' ');
    end
    else
    begin
      SQL.Add(' and centro_origen_sl = centro_salida_sl ');
      SQL.Add(' and categoria_sl in (''1'', ''2'') ');
    end;

    SQL.Add('  and nvl(es_transito_sc,0) = 0 ');    
    SQL.Add(' and ref_transitos_sl is null ');
    SQL.Add(' and exists ( select * from frf_clientes where cliente_c = cliente_sl ');
    SQL.Add('                                           and pais_c = ''ES'' ) ');
    SQL.Add(' group by 1,2 ');

    ParamByName('empresa').AsString := sEmpresa;
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

procedure TQLConfecPorAgrupacion.SalidasDirectasExportacion;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select categoria_sl categoria, ');
    SQL.Add('         ( select agrupacion_e from frf_envases ');
    SQL.Add('           where envase_e = envase_sl ');
    SQL.Add('             and producto_e = producto_sl ) envase, ');
    SQL.Add('     sum( kilos_sl ) kilos');
    SQL.Add(' from  frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and fecha_sc between :fechaDesde and :fechaHasta ');

    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');

    SQL.Add(' and centro_origen_sl = :centro ');
    SQL.Add(' and producto_sl = :producto ');

    if sEmpresa = '037' then
    begin
      SQL.Add(' and categoria_sl = ''I'' ');
    end
    else
    begin
      SQL.Add(' and centro_origen_sl = centro_salida_sl ');
      SQL.Add(' and categoria_sl in (''1'', ''2'') ');
    end;

    SQL.Add('  and nvl(es_transito_sc,0) = 0 ');
    SQL.Add(' and ref_transitos_sl is null ');
    SQL.Add(' and exists ( select * from frf_clientes where cliente_c = cliente_sl ');
    SQL.Add('                                           and pais_c <> ''ES'' ) ');
    SQL.Add(' group by 1,2 ');

    ParamByName('empresa').AsString := sEmpresa;
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

procedure TQLConfecPorAgrupacion.Transitos;

begin
  if sEmpresa = '037' then
    Exit;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select categoria_tl categoria, ');
    SQL.Add('         ( select agrupacion_e from frf_envases ');
    SQL.Add('           where envase_e = envase_tl ');
    SQL.Add('             and producto_e = producto_tl ) envase, ');
    SQL.Add('     sum( kilos_tl ) kilos');
    SQL.Add(' from  frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and centro_tl = :centro ');
    SQL.Add(' and producto_tl = :producto ');
    SQL.Add(' and fecha_tl between :fechaDesde and :fechaHasta ');
    SQL.Add(' group by 1,2 ');

    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
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

procedure TQLConfecPorAgrupacion.QRExpr17Print(sender: TObject; var Value: string);
begin
  Value := 'TOTALES CAT. ' + Value;
end;

procedure TQLConfecPorAgrupacion.QRExpr1Print(sender: TObject; var Value: string);
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

procedure TQLConfecPorAgrupacion.QRExpr2Print(sender: TObject; var Value: string);
begin
  //Value := Value + ' - ' + DesEnvase(sEmpresa, Value);
end;

procedure TQLConfecPorAgrupacion.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := DataSet.FieldByName('categoria').AsString = '2';
end;

end.
