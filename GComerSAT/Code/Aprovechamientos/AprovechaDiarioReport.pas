unit AprovechaDiarioReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TQRAprovechaDiario = class(TQuickRep)
    QRBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    DetailBand1: TQRBand;
    porcen_c1: TQRExpr;
    porcen_c3: TQRExpr;
    porcen_c2: TQRExpr;
    porcen_des: TQRExpr;
    PsQRExpr12: TQRExpr;
    PsQRExpr13: TQRExpr;
    CabGrupoCosechero: TQRGroup;
    CabGrupoPlantacion: TQRGroup;
    PsQRExpr9: TQRExpr;
    PsQRExpr1: TQRExpr;
    PsQRExpr15: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr10: TQRExpr;
    PsQRExpr11: TQRExpr;
    PsQRExpr3: TQRExpr;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel10: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLblDestrio: TQRLabel;
    PsQRLabel11: TQRLabel;
    PsQRLabel12: TQRLabel;
    PsQRLblMerma: TQRLabel;
    PsQRExpr4: TQRExpr;
    PsQRExpr14: TQRExpr;
    PieGrupoCosechero: TQRBand;
    PieGrupoPlantacion: TQRBand;
    kgs_c1: TQRLabel;
    kgs_d: TQRLabel;
    kgs_c3: TQRLabel;
    kgs_c2: TQRLabel;
    pkgs_c1: TQRLabel;
    pkgs_c2: TQRLabel;
    pkgs_c3: TQRLabel;
    pkgs_d: TQRLabel;
    SummaryBand1: TQRBand;
    pkgs_todos: TQRLabel;
    PsQRExpr19: TQRExpr;
    PsQRLabel14: TQRLabel;
    ppor_c1: TQRLabel;
    ppor_c2: TQRLabel;
    ppor_c3: TQRLabel;
    ppor_d: TQRLabel;
    PsQRShape1: TQRShape;
    tpor_d: TQRLabel;
    tkgs_d: TQRLabel;
    tpor_c3: TQRLabel;
    tkgs_c3: TQRLabel;
    tpor_c2: TQRLabel;
    tkgs_c2: TQRLabel;
    tpor_c1: TQRLabel;
    tkgs_c1: TQRLabel;
    tkgs_todos: TQRLabel;
    PsQRLabel16: TQRExpr;
    PsQRLabel18: TQRLabel;
    PsQRShape2: TQRShape;
    PsQRLabel17: TQRLabel;
    PsQRExpr21: TQRExpr;
    PsQRExpr20: TQRExpr;
    ckgs_todos: TQRLabel;
    cpor_c1: TQRLabel;
    ckgs_c2: TQRLabel;
    cpor_c2: TQRLabel;
    ckgs_c3: TQRLabel;
    cpor_c3: TQRLabel;
    ckgs_d: TQRLabel;
    cpor_d: TQRLabel;
    ckgs_c1: TQRLabel;
    rango: TQRLabel;
    kgs_m: TQRLabel;
    porcen_mer: TQRExpr;
    pkgs_m: TQRLabel;
    ppor_m: TQRLabel;
    ckgs_m: TQRLabel;
    cpor_m: TQRLabel;
    tkgs_m: TQRLabel;
    tpor_m: TQRLabel;
    CabGrupoProducto: TQRGroup;
    PieGrupoProducto: TQRBand;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRLabel1: TQRLabel;
    QRExpr5: TQRExpr;
    okgs_todos: TQRLabel;
    okgs_c1: TQRLabel;
    opor_c1: TQRLabel;
    okgs_c2: TQRLabel;
    opor_c2: TQRLabel;
    okgs_c3: TQRLabel;
    opor_c3: TQRLabel;
    okgs_d: TQRLabel;
    opor_d: TQRLabel;
    okgs_m: TQRLabel;
    opor_m: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    qrlTipo: TQRLabel;
    qrxtipo_entrega_e: TQRExpr;
    procedure PsQRExpr9Print(sender: TObject; var Value: string);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PieGrupoPlantacionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRLabel14Print(sender: TObject; var Value: string);
    procedure PsQRLabel23Print(sender: TObject; var Value: string);
    procedure PieGrupoCosecheroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRLabel11Print(sender: TObject; var Value: string);
    procedure PsQRExpr21Print(sender: TObject; var Value: string);
    procedure CabGrupoCosecheroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure rango2Print(sender: TObject; var Value: string);
    procedure PsQRExpr1Print(sender: TObject; var Value: String);
    procedure CabGrupoProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PieGrupoProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel1Print(sender: TObject; var Value: String);
  private
    pla_todos, pla_c1, pla_c2, pla_c3, pla_des, pla_mer: real;
    pro_todos, pro_c1, pro_c2, pro_c3, pro_des, pro_mer: real;
    cos_todos, cos_c1, cos_c2, cos_c3, cos_des, cos_mer: real;
    acu_todos, acu_c1, acu_c2, acu_c3, acu_des, acu_mer: real;

    VerLotes: Boolean;

    SoloUnProducto: Boolean;

  public
    constructor Create(AOwner: TComponent); override;
  end;

procedure ListadoDiarioAprovechamiento(const AEmpresa, ACentro, AProducto: string; const AFechaDesde, AFechaHasta: TDateTime;
  const ACosecheroDesde, ACosecheroHasta, APlantacionDesde, APlantacionHasta: integer;
  const APrimera, ASegunda, ATErcera, ADestrio: real; const AVerLotes: Boolean;  const ATipoEntrada: integer );

implementation

{$R *.DFM}

uses CReportes, AprovechaData, Dpreview, UDMAuxDB, Dialogs;

constructor TQRAprovechaDiario.Create(AOwner: TComponent);
begin
  inherited;

  VerLotes := True;
end;

procedure ListadoDiarioAprovechamiento(const AEmpresa, ACentro, AProducto: string; const AFechaDesde, AFechaHasta: TDateTime;
  const ACosecheroDesde, ACosecheroHasta, APlantacionDesde, APlantacionHasta: integer;
  const APrimera, ASegunda, ATErcera, ADestrio: real;  const AVerLotes: Boolean; const ATipoEntrada: integer );
var
  QRAprovechaDiario: TQRAprovechaDiario;
begin
  DMAprovecha := TDMAprovecha.Create(nil);

  try
    DMAprovecha.QAprovechaDiario.SQL.Clear;
    DMAprovecha.QAprovechaDiario.SQL.Add(
      ' SELECT empresa_e, centro_e, ' +
      '       numero_entrada_e, fecha_e, tipo_entrada_e, ' +
      '       (SELECT sum(total_cajas_e2l) from frf_entradas2_l ' +
      '        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ' +
      '          AND numero_entrada_e2l = numero_entrada_e ' +
      '          AND cosechero_e2l = cosechero_e ' +
      '          AND plantacion_e2l = plantacion_e ' +
      '          AND fecha_e2l = fecha_e) cajas, ' +

    '       (SELECT sum(total_kgs_e2l) from frf_entradas2_l ' +
      '        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ' +
      '          AND numero_entrada_e2l = numero_entrada_e ' +
      '          AND cosechero_e2l = cosechero_e ' +
      '          AND plantacion_e2l = plantacion_e ' +
      '          AND fecha_e2l = fecha_e) kilos, ' +

    '       producto_e, ' +
      '       (SELECT descripcion_p from frf_productos ' +
      '        WHERE producto_p = producto_e) des_producto, ' +

    '       cosechero_e, ' +
      '       (SELECT nombre_c from frf_cosecheros ' +
      '        WHERE empresa_c = empresa_e ' +
      '          AND cosechero_c = cosechero_e) des_cosechero, ' +

    '       plantacion_e, anyo_semana_e, ' +
      '       (SELECT descripcion_p from frf_plantaciones ' +
      '        WHERE ano_semana_p = anyo_semana_e and empresa_p = empresa_e ' +
      '          AND producto_p = producto_e and cosechero_p = cosechero_e ' +
      '          AND plantacion_p = plantacion_e ) des_plantacion, ' +

    '       porcen_primera_e, porcen_segunda_e, porcen_tercera_e, porcen_destrio_e, ' +
      '       aporcen_primera_e, aporcen_segunda_e, aporcen_tercera_e, aporcen_destrio_e, aporcen_merma_e, ' +
      '       tipo_entrada_e ' +

        ' from frf_escandallo ' + #13 + #10 +
        '  where empresa_e = :empresa ' + #13 + #10 +
        '    and centro_e = :centro ' + #13 + #10 +
        '    and fecha_e between :fecha_desde and :fecha_hasta ' + #13 + #10 +
        '    and cosechero_e between :cosechero_desde and :cosechero_hasta ' +
        '    and plantacion_e between :plantacion_desde and :plantacion_hasta ');

      begin
        if APrimera <> -1 then
        begin
          DMAprovecha.QAprovechaDiario.SQL.Add(' and porcen_primera_e = :primera ');
        end;
        if ASegunda <> -1 then
        begin
          DMAprovecha.QAprovechaDiario.SQL.Add(' and porcen_segunda_e = :segunda ');
        end;
        if ATErcera <> -1 then
        begin
          DMAprovecha.QAprovechaDiario.SQL.Add(' and porcen_tercera_e = :tercera ');
        end;
        if ADestrio <> -1 then
        begin
          DMAprovecha.QAprovechaDiario.SQL.Add(' and porcen_destrio_e = :destrio ');
        end;
      end;

      if ATipoEntrada > -1 then
        DMAprovecha.QAprovechaDiario.SQL.Add('   AND tipo_entrada_e = :tipo_entrada ' )
      else
      if ATipoEntrada = -2 then
        DMAprovecha.QAprovechaDiario.SQL.Add('   and aporcen_primera_e + aporcen_segunda_e + aporcen_tercera_e + aporcen_destrio_e= 0 ' );


      if Trim( AProducto ) <> '' then
      begin
        DMAprovecha.QAprovechaDiario.SQL.Add('   AND producto_e = :producto ' );
      end;

      DMAprovecha.QAprovechaDiario.SQL.Add(' ORDER BY empresa_e, centro_e,  cosechero_e, producto_e,' +
      '          plantacion_e, fecha_e, numero_entrada_e ');


    DMAprovecha.QAprovechaDiario.ParamByName('empresa').AsString := AEmpresa;
    DMAprovecha.QAprovechaDiario.ParamByName('centro').AsString := ACentro;
    if Trim( AProducto ) <> '' then
      DMAprovecha.QAprovechaDiario.ParamByName('producto').AsString := AProducto;

    DMAprovecha.QAprovechaDiario.ParamByName('fecha_desde').AsDateTime := AFechaDesde;
    DMAprovecha.QAprovechaDiario.ParamByName('fecha_hasta').AsDateTime := AFechaHasta;
    DMAprovecha.QAprovechaDiario.ParamByName('cosechero_desde').AsInteger := ACosecheroDesde;
    DMAprovecha.QAprovechaDiario.ParamByName('cosechero_hasta').AsInteger := ACosecheroHasta;
    DMAprovecha.QAprovechaDiario.ParamByName('plantacion_desde').AsInteger := APlantacionDesde;
    DMAprovecha.QAprovechaDiario.ParamByName('plantacion_hasta').AsInteger := APlantacionHasta;

    if APrimera <> -1 then
    begin
       DMAprovecha.QAprovechaDiario.ParamByName('primera').AsFloat:= APrimera;
    end;
    if ASegunda <> -1 then
    begin
      DMAprovecha.QAprovechaDiario.ParamByName('segunda').AsFloat:= ASegunda;
    end;
    if ATercera <> -1 then
    begin
      DMAprovecha.QAprovechaDiario.ParamByName('tercera').AsFloat:= ATercera;
    end;
    if ADestrio <> -1 then
    begin
      DMAprovecha.QAprovechaDiario.ParamByName('destrio').AsFloat:= ADestrio;
    end;


    if ATipoEntrada > -1 then
        DMAprovecha.QAprovechaDiario.ParamByName('tipo_entrada').Asinteger := ATipoEntrada;

    DMAprovecha.QAprovechaDiario.Open;

    if DMAprovecha.QAprovechaDiario.IsEmpty then
    begin
      ShowMessage('Listado sin datos.');
      DMAprovecha.QAprovechaDiario.Close;
      Exit;
    end;

    QRAprovechaDiario := TQRAprovechaDiario.Create(nil);
    PonLogoGrupoBonnysa(QRAprovechaDiario, AEmpresa);

      QRAprovechaDiario.lblTitulo.Caption := 'LISTADO DE ESCANDALLO';
      QRAprovechaDiario.PsQRLblMerma.Enabled := False;
      QRAprovechaDiario.PsQRLblDestrio.Enabled := True;

    QRAprovechaDiario.SoloUnProducto:= Trim( AProducto ) <> '';
    QRAprovechaDiario.VerLotes := AVerLotes;
    QRAprovechaDiario.rango.Caption := 'Desde ' + DateToStr( AFechaDesde ) + ' hasta ' + DateToStr( AFechaHasta );

    Preview(QRAprovechaDiario);

  finally
    DMAprovecha.QAprovechaDiario.Close;
    FreeAndNil(DMAprovecha);

  end;
end;

procedure TQRAprovechaDiario.PsQRExpr9Print(sender: TObject;
  var Value: string);
begin
  Value := desCentro(DataSet.fieldbyname('empresa_e').AsString, Value);
end;

procedure TQRAprovechaDiario.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  aux_todos, aux_c1, aux_c2, aux_c3, aux_des, aux_mer: real;
begin
  aux_todos := DMAprovecha.QAprovechaDiario.fieldbyname('kilos').AsFloat;
  begin
    aux_c1 := (aux_todos * DMAprovecha.QAprovechaDiario.fieldbyname('porcen_primera_e').AsFloat / 100);
    aux_c2 := (aux_todos * DMAprovecha.QAprovechaDiario.fieldbyname('porcen_segunda_e').AsFloat / 100);
    aux_c3 := (aux_todos * DMAprovecha.QAprovechaDiario.fieldbyname('porcen_tercera_e').AsFloat / 100);
    aux_des:= ( aux_todos * DMAprovecha.QAprovechaDiario.fieldbyname('porcen_destrio_e').AsFloat  / 100);
    //aux_des := 0;
    aux_mer := 0;
  end;

  pla_todos := pla_todos + aux_todos;
  pla_c1 := pla_c1 + aux_c1;
  pla_c2 := pla_c2 + aux_c2;
  pla_c3 := pla_c3 + aux_c3;
  pla_des := pla_des + aux_des;
  pla_mer := pla_mer + aux_mer;

  pro_todos := pro_todos + aux_todos;
  pro_c1 := pro_c1 + aux_c1;
  pro_c2 := pro_c2 + aux_c2;
  pro_c3 := pro_c3 + aux_c3;
  pro_des := pro_des + aux_des;
  pro_mer := pro_mer + aux_mer;

  kgs_c1.Caption := FormatFloat('#,##0', aux_c1);
  kgs_c2.Caption := FormatFloat('#,##0', aux_c2);
  kgs_c3.Caption := FormatFloat('#,##0', aux_c3);

  begin
    kgs_m.Caption := '';
    //kgs_d.Caption := ''
    kgs_d.Caption := FormatFloat('#,##0', aux_des);
  end;

  if VerLotes then
    DetailBand1.Height := 18
  else
    DetailBand1.Height := 0;
  //PrintBand:= VerLotes;
end;

procedure TQRAprovechaDiario.PieGrupoPlantacionBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  cos_todos := cos_todos + pla_todos;
  cos_c1 := cos_c1 + pla_c1;
  cos_c2 := cos_c2 + pla_c2;
  cos_c3 := cos_c3 + pla_c3;
  cos_des := cos_des + pla_des;
  cos_mer := cos_mer + pla_mer;

  pkgs_todos.Caption := FormatFloat('#,##0', pla_todos);
  pkgs_c1.Caption := FormatFloat('#,##0', pla_c1);
  pkgs_c2.Caption := FormatFloat('#,##0', pla_c2);
  pkgs_c3.Caption := FormatFloat('#,##0', pla_c3);

  ppor_c1.Caption := FormatFloat('00.00', (pla_c1 / pla_todos) * 100);
  ppor_c2.Caption := FormatFloat('00.00', (pla_c2 / pla_todos) * 100);
  ppor_c3.Caption := FormatFloat('00.00', (pla_c3 / pla_todos) * 100);


  begin
    pkgs_d.Caption := FormatFloat('#,##0', pla_des);
    ppor_d.Caption := FormatFloat('00.00', (pla_des / pla_todos) * 100);
    //pkgs_d.Caption := '';
    //ppor_d.Caption := '';
    pkgs_m.Caption := '';
    ppor_m.Caption := '';
  end;

  pla_todos := 0;
  pla_c1 := 0;
  pla_c2 := 0;
  pla_c3 := 0;
  pla_des := 0;
  pla_mer := 0;
end;

procedure TQRAprovechaDiario.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  pla_todos := 0;
  pla_c1 := 0;
  pla_c2 := 0;
  pla_c3 := 0;
  pla_des := 0;
  pla_mer := 0;
  cos_todos := 0;
  cos_c1 := 0;
  cos_c2 := 0;
  cos_c3 := 0;
  cos_des := 0;
  cos_mer := 0;
  acu_todos := 0;
  acu_c1 := 0;
  acu_c2 := 0;
  acu_c3 := 0;
  acu_des := 0;
  acu_mer := 0;

  if VerLotes then
  begin
    CabGrupoCosechero.ForceNewPage := True;
    CabGrupoCosechero.Color := $00DFDFDF;
    CabGrupoPlantacion.Color := $00DFDFDF;
  end
  else
  begin
    CabGrupoCosechero.ForceNewPage := False;
    CabGrupoCosechero.Color := clWhite;
    CabGrupoPlantacion.Color := clWhite;
  end;

  begin
    porcen_c1.Expression := '[porcen_primera_e]';
    porcen_c2.Expression := '[porcen_segunda_e]';
    porcen_c3.Expression := '[porcen_tercera_e]';
    porcen_des.Expression:= '[porcen_destrio_e]';
    //porcen_des.Enabled := False;
    porcen_mer.enabled := false;
  end;
end;

procedure TQRAprovechaDiario.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  tkgs_todos.Caption := FormatFloat('#,##0', acu_todos);
  tkgs_c1.Caption := FormatFloat('#,##0', acu_c1);
  tkgs_c2.Caption := FormatFloat('#,##0', acu_c2);
  tkgs_c3.Caption := FormatFloat('#,##0', acu_c3);

  tpor_c1.Caption := FormatFloat('00.00', (acu_c1 / acu_todos) * 100);
  tpor_c2.Caption := FormatFloat('00.00', (acu_c2 / acu_todos) * 100);
  tpor_c3.Caption := FormatFloat('00.00', (acu_c3 / acu_todos) * 100);

  begin
    tkgs_m.Caption := '';
    tpor_m.Caption := '';
    //tkgs_d.Caption := '';
    //tpor_d.Caption := '';
    tkgs_d.Caption := FormatFloat('#,##0', acu_des);
    tpor_d.Caption := FormatFloat('00.00', (acu_des / acu_todos) * 100);
  end;
end;

procedure TQRAprovechaDiario.PsQRLabel14Print(sender: TObject;
  var Value: string);
begin
  if not VerLotes then
    Value := ''
  else
    Value := 'TOTAL PLA. ' + DMAprovecha.QAprovechaDiario.fieldbyname('plantacion_e').AsString;
end;

procedure TQRAprovechaDiario.PsQRLabel23Print(sender: TObject;
  var Value: string);
begin
  if not VerLotes then
    Value := ''
  else
    Value := 'TOTAL COS. ' + DMAprovecha.QAprovechaDiario.fieldbyname('cosechero_e').AsString;
end;

procedure TQRAprovechaDiario.PieGrupoCosecheroBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  acu_todos := acu_todos + cos_todos;
  acu_c1 := acu_c1 + cos_c1;
  acu_c2 := acu_c2 + cos_c2;
  acu_c3 := acu_c3 + cos_c3;
  acu_des := acu_des + cos_des;
  acu_mer := acu_mer + cos_mer;

  ckgs_todos.Caption := FormatFloat('#,##0', cos_todos);
  ckgs_c1.Caption := FormatFloat('#,##0', cos_c1);
  ckgs_c2.Caption := FormatFloat('#,##0', cos_c2);
  ckgs_c3.Caption := FormatFloat('#,##0', cos_c3);

  cpor_c1.Caption := FormatFloat('00.00', (cos_c1 / cos_todos) * 100);
  cpor_c2.Caption := FormatFloat('00.00', (cos_c2 / cos_todos) * 100);
  cpor_c3.Caption := FormatFloat('00.00', (cos_c3 / cos_todos) * 100);

  begin
    ckgs_d.Caption := FormatFloat('#,##0', cos_des);
    cpor_d.Caption := FormatFloat('00.00', (cos_des / cos_todos) * 100);
    //ckgs_d.Caption := '';
    //cpor_d.Caption := '';
    ckgs_m.Caption := '';
    cpor_m.Caption := '';
  end;

  cos_todos := 0;
  cos_c1 := 0;
  cos_c2 := 0;
  cos_c3 := 0;
  cos_des := 0;
  cos_mer := 0;
end;

procedure TQRAprovechaDiario.PsQRLabel11Print(sender: TObject;
  var Value: string);
begin
  if not VerLotes then Value := '';
end;

procedure TQRAprovechaDiario.PsQRExpr21Print(sender: TObject;
  var Value: string);
begin
  if not VerLotes then
    Value := Value + ' ' + DMAprovecha.QAprovechaDiario.fieldbyname('des_cosechero').AsString
  else
    Value := '';
end;

procedure TQRAprovechaDiario.CabGrupoCosecheroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := VerLotes and SoloUnProducto;
end;

procedure TQRAprovechaDiario.rango2Print(sender: TObject;
  var Value: string);
begin
  Value := rango.Caption;
end;

procedure TQRAprovechaDiario.PsQRExpr1Print(sender: TObject;
  var Value: String);
begin
  if not SoloUnProducto then
    Value:= '';
end;

procedure TQRAprovechaDiario.CabGrupoProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not SoloUnProducto;
end;

procedure TQRAprovechaDiario.PieGrupoProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not SoloUnProducto;

  okgs_todos.Caption := FormatFloat('#,##0', pro_todos);
  okgs_c1.Caption := FormatFloat('#,##0', pro_c1);
  okgs_c2.Caption := FormatFloat('#,##0', pro_c2);
  okgs_c3.Caption := FormatFloat('#,##0', pro_c3);

  opor_c1.Caption := FormatFloat('00.00', (pro_c1 / pro_todos) * 100);
  opor_c2.Caption := FormatFloat('00.00', (pro_c2 / pro_todos) * 100);
  opor_c3.Caption := FormatFloat('00.00', (pro_c3 / pro_todos) * 100);

  begin
    okgs_d.Caption := FormatFloat('#,##0', pro_des);
    opor_d.Caption := FormatFloat('00.00', (pro_des / pro_todos) * 100);
    //okgs_d.Caption := '';
    //opor_d.Caption := '';
    okgs_m.Caption := '';
    opor_m.Caption := '';
  end;

  pro_todos := 0;
  pro_c1 := 0;
  pro_c2 := 0;
  pro_c3 := 0;
  pro_des := 0;
  pro_mer := 0;
end;

procedure TQRAprovechaDiario.QRLabel1Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL PRO. ' + DMAprovecha.QAprovechaDiario.fieldbyname('producto_e').AsString;
end;

end.
