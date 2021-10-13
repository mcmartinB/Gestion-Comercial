unit EscandallosVsAjustesReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TQREscandallosVsAjustes = class(TQuickRep)
    BndTitulo: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    DetailBand1: TQRBand;
    PsQRExpr13: TQRExpr;
    CabGrupo: TQRGroup;
    CabCosechero: TQRGroup;
    PsQRExpr9: TQRExpr;
    BndCabecera: TQRBand;
    PsQRLabel10: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLblDestrio: TQRLabel;
    PsQRLblMerma: TQRLabel;
    PsQRExpr14: TQRExpr;
    PieGrupoProducto: TQRBand;
    PieCosechero: TQRBand;
    BndTotal: TQRBand;
    pc1: TQRLabel;
    pc2: TQRLabel;
    pc3: TQRLabel;
    pcd: TQRLabel;
    ptd: TQRLabel;
    pt3: TQRLabel;
    pt2: TQRLabel;
    pt1: TQRLabel;
    PsQRLabel18: TQRLabel;
    rango: TQRLabel;
    pcm: TQRLabel;
    ptm: TQRLabel;
    CabProducto: TQRGroup;
    PieGrupo: TQRBand;
    PsQRExpr3: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    QRExpr31: TQRExpr;
    QRExpr32: TQRExpr;
    QRExpr34: TQRExpr;
    QRExpr35: TQRExpr;
    QRExpr36: TQRExpr;
    QRExpr26: TQRExpr;
    QRExpr38: TQRExpr;
    ChildBand1: TQRChildBand;
    pp1: TQRLabel;
    pp2: TQRLabel;
    pp3: TQRLabel;
    ppd: TQRLabel;
    ppm: TQRLabel;
    QRExpr24: TQRExpr;
    QRExpr25: TQRExpr;
    QRExpr27: TQRExpr;
    QRExpr28: TQRExpr;
    QRExpr29: TQRExpr;
    QRExpr39: TQRExpr;
    ChildBand2: TQRChildBand;
    pg1: TQRLabel;
    pg2: TQRLabel;
    pg3: TQRLabel;
    pgd: TQRLabel;
    pgm: TQRLabel;
    QRExpr17: TQRExpr;
    QRExpr18: TQRExpr;
    QRExpr20: TQRExpr;
    QRExpr21: TQRExpr;
    QRExpr22: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr33: TQRExpr;
    QRShape1: TQRShape;
    PsQRExpr15: TQRExpr;
    ChildBand3: TQRChildBand;
    pm: TQRLabel;
    pd: TQRLabel;
    p3: TQRLabel;
    p2: TQRLabel;
    p1: TQRLabel;
    QRShape2: TQRShape;
    qrlTipoEntrada: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    QRExpr1: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr40: TQRExpr;
    QRExpr41: TQRExpr;
    QRExpr42: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrxpr20: TQRExpr;
    p1e: TQRLabel;
    p2e: TQRLabel;
    p3e: TQRLabel;
    pde: TQRLabel;
    pc1e: TQRLabel;
    pc2e: TQRLabel;
    pc3e: TQRLabel;
    pcde: TQRLabel;
    pg1e: TQRLabel;
    pg2e: TQRLabel;
    pg3e: TQRLabel;
    pgde: TQRLabel;
    QRExpr19: TQRExpr;
    pp1e: TQRLabel;
    pp2e: TQRLabel;
    pp3e: TQRLabel;
    ppde: TQRLabel;
    pt1e: TQRLabel;
    pt2e: TQRLabel;
    pt3e: TQRLabel;
    ptde: TQRLabel;
    procedure PsQRExpr9Print(sender: TObject; var Value: string);
    procedure QRExpr3Print(sender: TObject; var Value: String);
    procedure QRExpr33Print(sender: TObject; var Value: String);
    procedure a(sender: TObject; var Value: String);
    procedure QRExpr39Print(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure PsQRExpr3Print(sender: TObject; var Value: String);
    procedure PsQRExpr15Print(sender: TObject; var Value: String);
    procedure CabGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PieCosecheroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BndTotalBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabCosecheroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PieGrupoProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PieGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BndTituloBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
      //1-> a:acumulado
      //2-> t:total, 1:primera, 2:segunda, 3:tercera, d:destrio, m:merma
      //3-> p:producto, g:grupo, c:cosechero, t:total_listado
      //4-> a:ajuste, escandallo
      atp, atg, atc, att: real;

      a1pe, a1ge, a1ce, a1te,
      a2pe, a2ge, a2ce, a2te,
      a3pe, a3ge, a3ce, a3te,
      adpe, adge, adce, adte: real;

      a1pa, a1ga, a1ca, a1ta,
      a2pa, a2ga, a2ca, a2ta,
      a3pa, a3ga, a3ca, a3ta,
      adpa, adga, adca, adta: real;
      ampa, amga, amca, amta: real;
  public
     bVerPlantaciones: boolean;

  end;

procedure ListadoDiarioAprovechamiento(const AEmpresa, ACentro, AProducto: string;
  const AFechaDesde, AFechaHasta: TDateTime; const ACosecheroDesde, ACosecheroHasta, APlantacionDesde,
  APlantacionHasta: Integer; const AVerPlantaciones: boolean;
  const ATipoEntrada: integer; const ADesTipo: string; const ASepRama: boolean );


implementation

{$R *.DFM}

uses CReportes, AprovechaData, Dpreview, UDMAuxDB, Dialogs;

procedure ListadoDiarioAprovechamiento(const AEmpresa, ACentro, AProducto: string;
  const AFechaDesde, AFechaHasta: TDateTime; const ACosecheroDesde, ACosecheroHasta, APlantacionDesde,
  APlantacionHasta: Integer; const AVerPlantaciones: boolean;
  const ATipoEntrada: integer; const ADesTipo: string; const ASepRama: boolean );
var
  QREscandallosVsAjustes: TQREscandallosVsAjustes;
begin
  DMAprovecha := TDMAprovecha.Create(nil);

  try
    DMAprovecha.QAprovechaDiario.SQL.Text :=
        ' SELECT min(fecha_e) fechamin, max(fecha_e) fechamax, count(*) escandallos' +
        ' FROM frf_escandallo ' +
        ' WHERE empresa_e = :empresa ' +
        '   AND centro_e = :centro ';
    if Trim( AProducto ) <> '' then
      DMAprovecha.QAprovechaDiario.SQL.Add('   AND producto_e = :producto ' );
    DMAprovecha.QAprovechaDiario.SQL.Add(
          '   AND fecha_e between :fecha_desde and :fecha_hasta ' +
          '   AND cosechero_e between :cosechero_desde and :cosechero_hasta ' +
          '   AND plantacion_e between :plantacion_desde and :plantacion_hasta ' +
          '   AND (aporcen_primera_e + aporcen_segunda_e + aporcen_tercera_e + aporcen_destrio_e ) = 0');

    DMAprovecha.QAprovechaDiario.ParamByName('empresa').AsString := AEmpresa;
    DMAprovecha.QAprovechaDiario.ParamByName('centro').AsString := ACentro;
    if Trim( AProducto ) <> '' then
      DMAprovecha.QAprovechaDiario.ParamByName('producto').AsString := AProducto;
    DMAprovecha.QAprovechaDiario.ParamByName('fecha_desde').AsDateTime:= AFechaDesde;
    DMAprovecha.QAprovechaDiario.ParamByName('fecha_hasta').AsDateTime := AFechaHasta;
    DMAprovecha.QAprovechaDiario.ParamByName('cosechero_desde').AsInteger := ACosecheroDesde;
    DMAprovecha.QAprovechaDiario.ParamByName('cosechero_hasta').AsInteger := ACosecheroHasta;
    DMAprovecha.QAprovechaDiario.ParamByName('plantacion_desde').AsInteger := APlantacionDesde;
    DMAprovecha.QAprovechaDiario.ParamByName('plantacion_hasta').AsInteger := APlantacionHasta;


    DMAprovecha.QAprovechaDiario.Open;

    if DMAprovecha.QAprovechaDiario.FieldByName('escandallos').AsInteger > 0 then
    begin
      if Application.MessageBox(
        PCHAR( 'Entre el "' + DMAprovecha.QAprovechaDiario.FieldByName('fechamin').AsString +
               '" y el "' + DMAprovecha.QAprovechaDiario.FieldByName('fechamax').AsString +
               '" hay ' + DMAprovecha.QAprovechaDiario.FieldByName('escandallos').AsString +
               ' escandallos sin ajustar.      ' + #13 + #10 +
               '¿Esta seguro que desea imprimir el listado.?     '),
         'FALTA AJUSTAR ESCANDALLOS',MB_YESNO) = IDNO then
      begin
        DMAprovecha.QAprovechaDiario.Close;
        Exit;
      end
      else
      begin
        DMAprovecha.QAprovechaDiario.Close;
      end;
    end;

    with DMAprovecha.QAprovechaDiario.SQL do
    begin
      Clear;

      (*
      if AVerPlantaciones then
      begin
        Add(' SELECT empresa_e, centro_e, producto_e, cosechero_e, plantacion_e, anyo_semana_e, ');
      end
      else
      begin
        Add(' SELECT empresa_e, centro_e, producto_e, cosechero_e,  ');
      end;
      *)
      Add(' SELECT empresa_e, centro_e, producto_e, cosechero_e, plantacion_e, anyo_semana_e, ');

      if ASepRama then
        Add('        case when producto_e = ''T'' and descripcion_p like ''%RAMA%'' then 1 else 0 end tipo, ')
      else
        Add('        0 tipo, ');

      Add('       (SELECT case when cosechero_c = 0 then ''C'' else pertenece_grupo_c end ');
      Add('        FROM frf_cosecheros ');
      Add('        WHERE empresa_c = empresa_e ');
      Add('          AND cosechero_c = cosechero_e) esdel_grupo, ');

      Add('       sum( (SELECT sum(total_cajas_e2l) from frf_entradas2_l ');
      Add('        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ');
      Add('          AND numero_entrada_e2l = numero_entrada_e ');
      Add('          AND cosechero_e2l = cosechero_e ');
      Add('          AND plantacion_e2l = plantacion_e ');
      Add('          AND fecha_e2l = fecha_e) ) cajas, ');

      Add('       sum( (SELECT sum(total_kgs_e2l) from frf_entradas2_l ');
      Add('        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ');
      Add('          AND numero_entrada_e2l = numero_entrada_e ');
      Add('          AND cosechero_e2l = cosechero_e ');
      Add('          AND plantacion_e2l = plantacion_e ');
      Add('          AND fecha_e2l = fecha_e) ) kilos, ');

      Add('       round( sum( (SELECT sum(total_kgs_e2l) from frf_entradas2_l ');
      Add('        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ');
      Add('          AND numero_entrada_e2l = numero_entrada_e ');
      Add('          AND cosechero_e2l = cosechero_e ');
      Add('          AND plantacion_e2l = plantacion_e ');
      Add('          AND fecha_e2l = fecha_e) * ( aporcen_segunda_e/ 100 )  ), 2) kilos_segunda, ');

      Add('       round( sum( (SELECT sum(total_kgs_e2l) from frf_entradas2_l ');
      Add('        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ');
      Add('          AND numero_entrada_e2l = numero_entrada_e ');
      Add('          AND cosechero_e2l = cosechero_e ');
      Add('          AND plantacion_e2l = plantacion_e ');
      Add('          AND fecha_e2l = fecha_e) * ( aporcen_tercera_e/ 100 ) ), 2) kilos_tercera, ');

      Add('       round( sum( (SELECT sum(total_kgs_e2l) from frf_entradas2_l ');
      Add('        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ');
      Add('          AND numero_entrada_e2l = numero_entrada_e ');
      Add('          AND cosechero_e2l = cosechero_e ');
      Add('          AND plantacion_e2l = plantacion_e ');
      Add('          AND fecha_e2l = fecha_e) * ( aporcen_destrio_e/ 100 ) ), 2) kilos_destrio, ');

      Add('       round( sum( (SELECT sum(total_kgs_e2l) from frf_entradas2_l ');
      Add('        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ');
      Add('          AND numero_entrada_e2l = numero_entrada_e ');
      Add('          AND cosechero_e2l = cosechero_e ');
      Add('          AND plantacion_e2l = plantacion_e ');
      Add('          AND fecha_e2l = fecha_e) * ( aporcen_merma_e/ 100 ) ), 2) kilos_merma, ');

      Add('       round( sum( (SELECT sum(total_kgs_e2l) from frf_entradas2_l ');
      Add('        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ');
      Add('          AND numero_entrada_e2l = numero_entrada_e ');
      Add('          AND cosechero_e2l = cosechero_e ');
      Add('          AND plantacion_e2l = plantacion_e ');
      Add('          AND fecha_e2l = fecha_e) * ( porcen_segunda_e/ 100 )  ), 2) kilos_esc_segunda, ');

      Add('       round( sum( (SELECT sum(total_kgs_e2l) from frf_entradas2_l ');
      Add('        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ');
      Add('          AND numero_entrada_e2l = numero_entrada_e ');
      Add('          AND cosechero_e2l = cosechero_e ');
      Add('          AND plantacion_e2l = plantacion_e ');
      Add('          AND fecha_e2l = fecha_e) * ( porcen_tercera_e/ 100 ) ), 2) kilos_esc_tercera, ');

      Add('       round( sum( (SELECT sum(total_kgs_e2l) from frf_entradas2_l ');
      Add('        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ');
      Add('          AND numero_entrada_e2l = numero_entrada_e ');
      Add('          AND cosechero_e2l = cosechero_e ');
      Add('          AND plantacion_e2l = plantacion_e ');
      Add('          AND fecha_e2l = fecha_e) * ( porcen_destrio_e/ 100 ) ), 2) kilos_esc_destrio ');


      Add(' FROM frf_escandallo ');

      if ASepRama then
      begin
        Add('      join frf_plantaciones on  empresa_e = empresa_p and producto_e = producto_p ');
        Add('                             and cosechero_e = cosechero_p and plantacion_e = plantacion_p ');
        Add('                             and  anyo_semana_e = ano_semana_p ');
      end;

      Add(' WHERE empresa_e = :empresa  ');
      Add(' AND centro_e = :centro  ');
      if Trim( AProducto ) <> '' then
        Add('   AND producto_e = :producto ' );
      Add(' AND fecha_e between :fecha_desde and :fecha_hasta  ');
      Add(' AND cosechero_e between :cosechero_desde and :cosechero_hasta  ');
      Add(' AND plantacion_e between :plantacion_desde and :plantacion_hasta  ');
      if ATipoEntrada > -1 then
        DMAprovecha.QAprovechaDiario.SQL.Add('   AND tipo_entrada_e = :tipo_entrada ' );

      Add(' GROUP BY empresa_e, centro_e, producto_e, cosechero_e, plantacion_e, anyo_semana_e, esdel_grupo, tipo ');
      Add(' ORDER BY empresa_e, centro_e, esdel_grupo, producto_e, tipo, cosechero_e, plantacion_e, anyo_semana_e ');
      (*
      if AVerPlantaciones then
      begin
        Add(' GROUP BY empresa_e, centro_e, producto_e, cosechero_e, plantacion_e, anyo_semana_e, tipo, 7 ');
        Add(' ORDER BY empresa_e, centro_e, 7, producto_e, cosechero_e, plantacion_e, anyo_semana_e ');
      end
      else
      begin
        Add(' GROUP BY empresa_e, centro_e, producto_e, cosechero_e, 5 ');
        Add(' ORDER BY empresa_e, centro_e, 5, producto_e, cosechero_e ');
      end;
      *)
    end;


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
    if ATipoEntrada > -1 then
        DMAprovecha.QAprovechaDiario.ParamByName('tipo_entrada').Asinteger := ATipoEntrada;

    DMAprovecha.QAprovechaDiario.Open;

    if DMAprovecha.QAprovechaDiario.IsEmpty then
    begin
      ShowMessage('Listado sin datos.');
      DMAprovecha.QAprovechaDiario.Close;
      Exit;
    end;

    QREscandallosVsAjustes := TQREscandallosVsAjustes.Create(nil);
    PonLogoGrupoBonnysa(QREscandallosVsAjustes, AEmpresa);

    QREscandallosVsAjustes.lblTitulo.Caption := 'RESUMEN DE APROVECHAMIENTO';
    QREscandallosVsAjustes.qrlTipoEntrada.Caption := ADesTipo;
    QREscandallosVsAjustes.PsQRLblMerma.Enabled := True;
    QREscandallosVsAjustes.PsQRLblDestrio.Enabled := True;

    QREscandallosVsAjustes.rango.Caption := 'Desde ' + DateToStr( AFechaDesde ) +
      ' hasta ' + DateToStr( AFechaHasta );

    //DMAprovecha.QAprovechaDiario.Open;
    QREscandallosVsAjustes.bVerPlantaciones:= AVerPlantaciones;
    Preview(QREscandallosVsAjustes);

  finally
    DMAprovecha.QAprovechaDiario.Close;
    FreeAndNil(DMAprovecha);

  end;
end;

procedure TQREscandallosVsAjustes.PsQRExpr9Print(sender: TObject;
  var Value: string);
begin
  Value := desCentro(DataSet.fieldbyname('empresa_e').AsString, Value);
end;

procedure TQREscandallosVsAjustes.PsQRExpr15Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( DataSet.FieldByName('empresa_e').AsString, Value );
  if DataSet.FieldByName('tipo').AsInteger = 1 then
    Value:= value + ' (RAMA SUELTA)';
end;

procedure TQREscandallosVsAjustes.QRExpr3Print(sender: TObject;
  var Value: String);
begin
  if Value = 'C' then
  begin
    Value:= 'COMPRAS SAT BONNYSA';
  end
  else
  if Value = 'S' then
  begin
    Value:= 'ENTRADAS DEL GRUPO';
  end
  else
  if Value = 'N' then
  begin
    Value:= 'ENTRADAS DE TERCEROS';
  end;
end;

procedure TQREscandallosVsAjustes.QRExpr2Print(sender: TObject;
  var Value: String);
begin
  Value:= value + ' ' + desCosechero( DataSet.FieldByName('empresa_e').AsString, Value );
end;

procedure TQREscandallosVsAjustes.PsQRExpr3Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + desPlantacion( DataSet.FieldByName('empresa_e').AsString,
                         DataSet.FieldByName('producto_e').AsString,
                         DataSet.FieldByName('cosechero_e').AsString,
                         Value, DataSet.FieldByName('anyo_semana_e').AsString );
end;

procedure TQREscandallosVsAjustes.QRExpr33Print(sender: TObject;
  var Value: String);
begin
  if Value = 'C' then
  begin
    Value:= 'TOTAL COMPRAS SAT BONNYSA';
  end
  else
  if Value = 'S' then
  begin
    Value:= 'TOTAL ENTRADAS DEL GRUPO';
  end
  else
  if Value = 'N' then
  begin
    Value:= 'TOTAL ENTRADAS DE TERCEROS';
  end;
end;

procedure TQREscandallosVsAjustes.a(sender: TObject;
  var Value: String);
begin
  if bVerPlantaciones then
    Value:= 'TOTAL ' + Value + ' ' + desCosechero( DataSet.FieldByName('empresa_e').AsString, Value )
  else
    Value:= Value + ' ' + desCosechero( DataSet.FieldByName('empresa_e').AsString, Value );
end;

procedure TQREscandallosVsAjustes.QRExpr39Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + Value + ' ' + desProducto( DataSet.FieldByName('empresa_e').AsString, Value );
  if DataSet.FieldByName('tipo').AsInteger = 1 then
    Value:= value + ' (RAMA SUELTA)';
end;

procedure TQREscandallosVsAjustes.CabGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  CabGrupo.Height:= 0;
end;

procedure TQREscandallosVsAjustes.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  atp:= 0;
  atg:= 0;
  atc:= 0;
  att:= 0;

  a1pa:= 0;
  a1ga:= 0;
  a1ca:= 0;
  a1ta:= 0;
  a2pa:= 0;
  a2ga:= 0;
  a2ca:= 0;
  a2ta:= 0;
  a3pa:= 0;
  a3ga:= 0;
  a3ca:= 0;
  a3ta:= 0;
  adpa:= 0;
  adga:= 0;
  adca:= 0;
  adta:= 0;
  ampa:= 0;
  amga:= 0;
  amca:= 0;
  amta:= 0;

  a1pe:= 0;
  a1ge:= 0;
  a1ce:= 0;
  a1te:= 0;
  a2pe:= 0;
  a2ge:= 0;
  a2ce:= 0;
  a2te:= 0;
  a3pe:= 0;
  a3ge:= 0;
  a3ce:= 0;
  a3te:= 0;
  adpe:= 0;
  adge:= 0;
  adce:= 0;
  adte:= 0;
end;

procedure TQREscandallosVsAjustes.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  at: real;
  a1a, a2a, a3a, ada, ama: real;
  a1e, a2e, a3e, ade: real;
begin
  if not bVerPlantaciones then
    DetailBand1.Height:= 0;

  at:= DataSet.FieldByName('kilos').AsFloat;

  a2a:= DataSet.FieldByName('kilos_segunda').AsFloat;
  a3a:= DataSet.FieldByName('kilos_tercera').AsFloat;
  ada:= DataSet.FieldByName('kilos_destrio').AsFloat;
  ama:= DataSet.FieldByName('kilos_merma').AsFloat;
  a1a:= ( at - ( a2a + a3a + ada + ama ) );

  a2e:= DataSet.FieldByName('kilos_esc_segunda').AsFloat;
  a3e:= DataSet.FieldByName('kilos_esc_tercera').AsFloat;
  ade:= DataSet.FieldByName('kilos_esc_destrio').AsFloat;
  a1e:= ( at - ( a2e + a3e + ade  ) );

  atp:= atp + at;
  atg:= atg + at;
  atc:= atc + at;
  att:= att + at;

  a1pa:= a1pa + a1a;
  a1ga:= a1ga + a1a;
  a1ca:= a1ca + a1a;
  a1ta:= a1ta + a1a;

  a2pa:= a2pa + a2a;
  a2ga:= a2ga + a2a;
  a2ca:= a2ca + a2a;
  a2ta:= a2ta + a2a;

  a3pa:= a3pa + a3a;
  a3ga:= a3ga + a3a;
  a3ca:= a3ca + a3a;
  a3ta:= a3ta + a3a;

  adpa:= adpa + ada;
  adga:= adga + ada;
  adca:= adca + ada;
  adta:= adta + ada;

  ampa:= ampa + ama;
  amga:= amga + ama;
  amca:= amca + ama;
  amta:= amta + ama;

  a1pe:= a1pe + a1e;
  a1ge:= a1ge + a1e;
  a1ce:= a1ce + a1e;
  a1te:= a1te + a1e;

  a2pe:= a2pe + a2e;
  a2ge:= a2ge + a2e;
  a2ce:= a2ce + a2e;
  a2te:= a2te + a2e;

  a3pe:= a3pe + a3e;
  a3ge:= a3ge + a3e;
  a3ce:= a3ce + a3e;
  a3te:= a3te + a3e;

  adpe:= adpe + ade;
  adge:= adge + ade;
  adce:= adce + ade;
  adte:= adte + ade;

  try
    p1.Caption:= FormatFloat( '#00.00', ( a1a * 100 ) / at );
    p2.Caption:= FormatFloat( '#00.00', ( a2a * 100 ) / at );
    p3.Caption:= FormatFloat( '#00.00', ( a3a * 100 ) / at );
    pd.Caption:= FormatFloat( '#00.00', ( ada * 100 ) / at );
    pm.Caption:= FormatFloat( '#00.00', ( ama * 100 ) / at );

    p1e.Caption:= FormatFloat( '#00.00', ( a1e * 100 ) / at );
    p2e.Caption:= FormatFloat( '#00.00', ( a2e * 100 ) / at );
    p3e.Caption:= FormatFloat( '#00.00', ( a3e * 100 ) / at );
    pde.Caption:= FormatFloat( '#00.00', ( ade * 100 ) / at );
  except
    p1.Caption:= '';
    p2.Caption:= '';
    p3.Caption:= '';
    pd.Caption:= '';
    pm.Caption:= '';

    p1e.Caption:= '';
    p2e.Caption:= '';
    p3e.Caption:= '';
    pde.Caption:= '';
  end;

end;

procedure TQREscandallosVsAjustes.PieCosecheroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  try
    pc1.Caption:= FormatFloat( '#00.00', ( a1ca * 100 ) / atc );
    pc2.Caption:= FormatFloat( '#00.00', ( a2ca * 100 ) / atc );
    pc3.Caption:= FormatFloat( '#00.00', ( a3ca * 100 ) / atc );
    pcd.Caption:= FormatFloat( '#00.00', ( adca * 100 ) / atc );
    pcm.Caption:= FormatFloat( '#00.00', ( amca * 100 ) / atc );

    pc1e.Caption:= FormatFloat( '#00.00', ( a1ce * 100 ) / atc );
    pc2e.Caption:= FormatFloat( '#00.00', ( a2ce * 100 ) / atc );
    pc3e.Caption:= FormatFloat( '#00.00', ( a3ce * 100 ) / atc );
    pcde.Caption:= FormatFloat( '#00.00', ( adce * 100 ) / atc );
  except
    pc1.Caption:= '';
    pc2.Caption:= '';
    pc3.Caption:= '';
    pcd.Caption:= '';
    pcm.Caption:= '';

    pc1e.Caption:= '';
    pc2e.Caption:= '';
    pc3e.Caption:= '';
    pcde.Caption:= '';
  end;

  a1ca:= 0;
  a2ca:= 0;
  a3ca:= 0;
  adca:= 0;
  amca:= 0;

  a1ce:= 0;
  a2ce:= 0;
  a3ce:= 0;
  adce:= 0;

  atc:= 0;
end;

procedure TQREscandallosVsAjustes.ChildBand2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  try
    pg1.Caption:= FormatFloat( '#00.00', ( a1ga * 100 ) / atg );
    pg2.Caption:= FormatFloat( '#00.00', ( a2ga * 100 ) / atg );
    pg3.Caption:= FormatFloat( '#00.00', ( a3ga * 100 ) / atg );
    pgd.Caption:= FormatFloat( '#00.00', ( adga * 100 ) / atg );
    pgm.Caption:= FormatFloat( '#00.00', ( amga * 100 ) / atg );

    pg1e.Caption:= FormatFloat( '#00.00', ( a1ge * 100 ) / atg );
    pg2e.Caption:= FormatFloat( '#00.00', ( a2ge * 100 ) / atg );
    pg3e.Caption:= FormatFloat( '#00.00', ( a3ge * 100 ) / atg );
    pgde.Caption:= FormatFloat( '#00.00', ( adge * 100 ) / atg );
  except
    pg1.Caption:= '';
    pg2.Caption:= '';
    pg3.Caption:= '';
    pgd.Caption:= '';
    pgm.Caption:= '';

    pg1e.Caption:= '';
    pg2e.Caption:= '';
    pg3e.Caption:= '';
    pgde.Caption:= '';
  end;

  a1ga:= 0;
  a2ga:= 0;
  a3ga:= 0;
  adga:= 0;
  amga:= 0;

  a1ge:= 0;
  a2ge:= 0;
  a3ge:= 0;
  adge:= 0;

  atg:= 0;
end;

procedure TQREscandallosVsAjustes.ChildBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  try
    pp1.Caption:= FormatFloat( '#00.00', ( a1pa * 100 ) / atp );
    pp2.Caption:= FormatFloat( '#00.00', ( a2pa * 100 ) / atp );
    pp3.Caption:= FormatFloat( '#00.00', ( a3pa * 100 ) / atp );
    ppd.Caption:= FormatFloat( '#00.00', ( adpa * 100 ) / atp );
    ppm.Caption:= FormatFloat( '#00.00', ( ampa * 100 ) / atp );

    pp1e.Caption:= FormatFloat( '#00.00', ( a1pe * 100 ) / atp );
    pp2e.Caption:= FormatFloat( '#00.00', ( a2pe * 100 ) / atp );
    pp3e.Caption:= FormatFloat( '#00.00', ( a3pe * 100 ) / atp );
    ppde.Caption:= FormatFloat( '#00.00', ( adpe * 100 ) / atp );
  except
    pp1.Caption:= '';
    pp2.Caption:= '';
    pp3.Caption:= '';
    ppd.Caption:= '';
    ppm.Caption:= '';

    pp1e.Caption:= '';
    pp2e.Caption:= '';
    pp3e.Caption:= '';
    ppde.Caption:= '';
  end;

  a1pa:= 0;
  a2pa:= 0;
  a3pa:= 0;
  adpa:= 0;
  ampa:= 0;

  a1pe:= 0;
  a2pe:= 0;
  a3pe:= 0;
  adpe:= 0;

  atp:= 0;
end;

procedure TQREscandallosVsAjustes.BndTotalBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  try
    pt1.Caption:= FormatFloat( '#00.00', ( a1ta * 100 ) / att );
    pt2.Caption:= FormatFloat( '#00.00', ( a2ta * 100 ) / att );
    pt3.Caption:= FormatFloat( '#00.00', ( a3ta * 100 ) / att );
    ptd.Caption:= FormatFloat( '#00.00', ( adta * 100 ) / att );
    ptm.Caption:= FormatFloat( '#00.00', ( amta * 100 ) / att );

    pt1e.Caption:= FormatFloat( '#00.00', ( a1te * 100 ) / att );
    pt2e.Caption:= FormatFloat( '#00.00', ( a2te * 100 ) / att );
    pt3e.Caption:= FormatFloat( '#00.00', ( a3te * 100 ) / att );
    ptde.Caption:= FormatFloat( '#00.00', ( adte * 100 ) / att );
  except
    pt1.Caption:= '';
    pt2.Caption:= '';
    pt3.Caption:= '';
    ptd.Caption:= '';
    ptm.Caption:= '';

    pt1e.Caption:= '';
    pt2e.Caption:= '';
    pt3e.Caption:= '';
    ptde.Caption:= '';
  end;

  a1ta:= 0;
  a2ta:= 0;
  a3ta:= 0;
  adta:= 0;
  amta:= 0;

  a1te:= 0;
  a2te:= 0;
  a3te:= 0;
  adte:= 0;

  att:= 0;
end;

procedure TQREscandallosVsAjustes.CabProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if not bVerPlantaciones then
    CabProducto.Height:= 0;
end;

procedure TQREscandallosVsAjustes.CabCosecheroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if not bVerPlantaciones then
    CabCosechero.Height:= 0;
end;

procedure TQREscandallosVsAjustes.PieGrupoProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if not bVerPlantaciones then
    PieGrupoProducto.Height:= 0;
end;

procedure TQREscandallosVsAjustes.PieGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if not bVerPlantaciones then
    PieGrupo.Height:= 0;
end;

procedure TQREscandallosVsAjustes.BndTituloBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    lblTitulo.Left:= QRExpr3.Left;
    qrlTipoEntrada.Left:= PsQRExpr3.Left;
  end;
end;

end.
