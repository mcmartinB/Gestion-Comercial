unit AprovechaDiarioComprasReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TQRAprovechaDiarioCompras = class(TQuickRep)
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
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    QRExpr16: TQRExpr;
    QRExpr31: TQRExpr;
    QRExpr32: TQRExpr;
    QRExpr34: TQRExpr;
    QRExpr35: TQRExpr;
    QRExpr36: TQRExpr;
    QRExpr37: TQRExpr;
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
    QRExpr30: TQRExpr;
    QRExpr19: TQRExpr;
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
    QRExpr23: TQRExpr;
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
    procedure PsQRExpr9Print(sender: TObject; var Value: string);
    procedure QRExpr3Print(sender: TObject; var Value: String);
    procedure QRExpr33Print(sender: TObject; var Value: String);
    procedure QRExpr38Print(sender: TObject; var Value: String);
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
  private
      //1-> a:acumulado
      //2-> t:total, 1:primera, 2:segunda, 3:tercera, d:destrio, m:merma
      //3-> p:producto, g:grupo, c:cosechero, t:total_listado
      atp, atg, atc, att,
      a1p, a1g, a1c, a1t,
      a2p, a2g, a2c, a2t,
      a3p, a3g, a3c, a3t,
      adp, adg, adc, adt,
      amp, amg, amc, amt: real;
  public
     bVerPlantaciones: boolean;

  end;

procedure ListadoDiarioAprovechamiento(const AEmpresa, ACentro, AProducto: string;
  const AFechaDesde, AFechaHasta: TDateTime; const ACosecheroDesde, ACosecheroHasta, APlantacionDesde,
  APlantacionHasta: Integer; const AVerPlantaciones: boolean;
  const ATipoEntrada: integer; const ADesTipo: string );


implementation

{$R *.DFM}

uses CReportes, AprovechaData, Dpreview, UDMAuxDB, Dialogs;

procedure ListadoDiarioAprovechamiento(const AEmpresa, ACentro, AProducto: string;
  const AFechaDesde, AFechaHasta: TDateTime; const ACosecheroDesde, ACosecheroHasta, APlantacionDesde,
  APlantacionHasta: Integer; const AVerPlantaciones: boolean;
  const ATipoEntrada: integer; const ADesTipo: string );
var
  QRAprovechaDiarioCompras: TQRAprovechaDiarioCompras;
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
      Add('          AND fecha_e2l = fecha_e) * ( aporcen_merma_e/ 100 ) ), 2) kilos_merma ');


      Add(' FROM frf_escandallo ');
      Add(' WHERE empresa_e = :empresa  ');
      Add(' AND centro_e = :centro  ');
      if Trim( AProducto ) <> '' then
        Add('   AND producto_e = :producto ' );
      Add(' AND fecha_e between :fecha_desde and :fecha_hasta  ');
      Add(' AND cosechero_e between :cosechero_desde and :cosechero_hasta  ');
      Add(' AND plantacion_e between :plantacion_desde and :plantacion_hasta  ');
      if ATipoEntrada > -1 then
        DMAprovecha.QAprovechaDiario.SQL.Add('   AND tipo_entrada_e = :tipo_entrada ' );

      Add(' GROUP BY empresa_e, centro_e, producto_e, cosechero_e, plantacion_e, anyo_semana_e, 7 ');
      Add(' ORDER BY empresa_e, centro_e, 7, producto_e, cosechero_e, plantacion_e, anyo_semana_e ');
      (*
      if AVerPlantaciones then
      begin
        Add(' GROUP BY empresa_e, centro_e, producto_e, cosechero_e, plantacion_e, anyo_semana_e, 7 ');
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

    QRAprovechaDiarioCompras := TQRAprovechaDiarioCompras.Create(nil);
    PonLogoGrupoBonnysa(QRAprovechaDiarioCompras, AEmpresa);

    QRAprovechaDiarioCompras.lblTitulo.Caption := 'RESUMEN DE APROVECHAMIENTO';
    QRAprovechaDiarioCompras.qrlTipoEntrada.Caption := ADesTipo;
    QRAprovechaDiarioCompras.PsQRLblMerma.Enabled := True;
    QRAprovechaDiarioCompras.PsQRLblDestrio.Enabled := True;

    QRAprovechaDiarioCompras.rango.Caption := 'Desde ' + DateToStr( AFechaDesde ) +
      ' hasta ' + DateToStr( AFechaHasta );

    //DMAprovecha.QAprovechaDiario.Open;
    QRAprovechaDiarioCompras.bVerPlantaciones:= AVerPlantaciones;
    Preview(QRAprovechaDiarioCompras);

  finally
    DMAprovecha.QAprovechaDiario.Close;
    FreeAndNil(DMAprovecha);

  end;
end;

procedure TQRAprovechaDiarioCompras.PsQRExpr9Print(sender: TObject;
  var Value: string);
begin
  Value := desCentro(DataSet.fieldbyname('empresa_e').AsString, Value);
end;

procedure TQRAprovechaDiarioCompras.PsQRExpr15Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( DataSet.FieldByName('empresa_e').AsString, Value );
end;

procedure TQRAprovechaDiarioCompras.QRExpr3Print(sender: TObject;
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

procedure TQRAprovechaDiarioCompras.QRExpr2Print(sender: TObject;
  var Value: String);
begin
  Value:= value + desCosechero( DataSet.FieldByName('empresa_e').AsString, Value );
end;

procedure TQRAprovechaDiarioCompras.PsQRExpr3Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + desPlantacion( DataSet.FieldByName('empresa_e').AsString,
                         DataSet.FieldByName('producto_e').AsString,
                         DataSet.FieldByName('cosechero_e').AsString,
                         Value, DataSet.FieldByName('anyo_semana_e').AsString );
end;

procedure TQRAprovechaDiarioCompras.QRExpr33Print(sender: TObject;
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

procedure TQRAprovechaDiarioCompras.QRExpr38Print(sender: TObject;
  var Value: String);
begin
  if bVerPlantaciones then
    Value:= 'TOTAL ' + Value + ' ' + desCosechero( DataSet.FieldByName('empresa_e').AsString, Value )
  else
    Value:= Value + ' ' + desCosechero( DataSet.FieldByName('empresa_e').AsString, Value );
end;

procedure TQRAprovechaDiarioCompras.QRExpr39Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + Value + ' ' + desProducto( DataSet.FieldByName('empresa_e').AsString, Value );
end;

procedure TQRAprovechaDiarioCompras.CabGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  CabGrupo.Height:= 0;
end;

procedure TQRAprovechaDiarioCompras.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  atp:= 0;
  atg:= 0;
  atc:= 0;
  att:= 0;
  a1p:= 0;
  a1g:= 0;
  a1c:= 0;
  a1t:= 0;
  a2p:= 0;
  a2g:= 0;
  a2c:= 0;
  a2t:= 0;
  a3p:= 0;
  a3g:= 0;
  a3c:= 0;
  a3t:= 0;
  adp:= 0;
  adg:= 0;
  adc:= 0;
  adt:= 0;
  amp:= 0;
  amg:= 0;
  amc:= 0;
  amt:= 0;
end;

procedure TQRAprovechaDiarioCompras.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  at, a1, a2, a3, ad, am: real;
begin
  if not bVerPlantaciones then
    DetailBand1.Height:= 0;

  at:= DataSet.FieldByName('kilos').AsFloat;
  a2:= DataSet.FieldByName('kilos_segunda').AsFloat;
  a3:= DataSet.FieldByName('kilos_tercera').AsFloat;
  ad:= DataSet.FieldByName('kilos_destrio').AsFloat;
  am:= DataSet.FieldByName('kilos_merma').AsFloat;
  a1:= ( at - ( a2 + a3 + ad + am ) );

  atp:= atp + at;
  atg:= atg + at;
  atc:= atc + at;
  att:= att + at;

  a1p:= a1p + a1;
  a1g:= a1g + a1;
  a1c:= a1c + a1;
  a1t:= a1t + a1;

  a2p:= a2p + a2;
  a2g:= a2g + a2;
  a2c:= a2c + a2;
  a2t:= a2t + a2;

  a3p:= a3p + a3;
  a3g:= a3g + a3;
  a3c:= a3c + a3;
  a3t:= a3t + a3;

  adp:= adp + ad;
  adg:= adg + ad;
  adc:= adc + ad;
  adt:= adt + ad;

  amp:= amp + am;
  amg:= amg + am;
  amc:= amc + am;
  amt:= amt + am;

  try
    p1.Caption:= FormatFloat( '#00.00', ( a1 * 100 ) / at );
    p2.Caption:= FormatFloat( '#00.00', ( a2 * 100 ) / at );
    p3.Caption:= FormatFloat( '#00.00', ( a3 * 100 ) / at );
    pd.Caption:= FormatFloat( '#00.00', ( ad * 100 ) / at );
    pm.Caption:= FormatFloat( '#00.00', ( am * 100 ) / at );
  except
    p1.Caption:= '';
    p2.Caption:= '';
    p3.Caption:= '';
    pd.Caption:= '';
    pm.Caption:= '';
  end;

end;

procedure TQRAprovechaDiarioCompras.PieCosecheroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  try
    pc1.Caption:= FormatFloat( '#00.00', ( a1c * 100 ) / atc );
    pc2.Caption:= FormatFloat( '#00.00', ( a2c * 100 ) / atc );
    pc3.Caption:= FormatFloat( '#00.00', ( a3c * 100 ) / atc );
    pcd.Caption:= FormatFloat( '#00.00', ( adc * 100 ) / atc );
    pcm.Caption:= FormatFloat( '#00.00', ( amc * 100 ) / atc );
  except
    pc1.Caption:= '';
    pc2.Caption:= '';
    pc3.Caption:= '';
    pcd.Caption:= '';
    pcm.Caption:= '';
  end;

  a1c:= 0;
  a2c:= 0;
  a3c:= 0;
  adc:= 0;
  amc:= 0;
  atc:= 0;
end;

procedure TQRAprovechaDiarioCompras.ChildBand2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  try
    pg1.Caption:= FormatFloat( '#00.00', ( a1g * 100 ) / atg );
    pg2.Caption:= FormatFloat( '#00.00', ( a2g * 100 ) / atg );
    pg3.Caption:= FormatFloat( '#00.00', ( a3g * 100 ) / atg );
    pgd.Caption:= FormatFloat( '#00.00', ( adg * 100 ) / atg );
    pgm.Caption:= FormatFloat( '#00.00', ( amg * 100 ) / atg );
  except
    pg1.Caption:= '';
    pg2.Caption:= '';
    pg3.Caption:= '';
    pgd.Caption:= '';
    pgm.Caption:= '';
  end;

  a1g:= 0;
  a2g:= 0;
  a3g:= 0;
  adg:= 0;
  amg:= 0;
  atg:= 0;
end;

procedure TQRAprovechaDiarioCompras.ChildBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  try
    pp1.Caption:= FormatFloat( '#00.00', ( a1p * 100 ) / atp );
    pp2.Caption:= FormatFloat( '#00.00', ( a2p * 100 ) / atp );
    pp3.Caption:= FormatFloat( '#00.00', ( a3p * 100 ) / atp );
    ppd.Caption:= FormatFloat( '#00.00', ( adp * 100 ) / atp );
    ppm.Caption:= FormatFloat( '#00.00', ( amp * 100 ) / atp );
  except
    pp1.Caption:= '';
    pp2.Caption:= '';
    pp3.Caption:= '';
    ppd.Caption:= '';
    ppm.Caption:= '';
  end;

  a1p:= 0;
  a2p:= 0;
  a3p:= 0;
  adp:= 0;
  amp:= 0;
  atp:= 0;
end;

procedure TQRAprovechaDiarioCompras.BndTotalBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  try
    pt1.Caption:= FormatFloat( '#00.00', ( a1t * 100 ) / att );
    pt2.Caption:= FormatFloat( '#00.00', ( a2t * 100 ) / att );
    pt3.Caption:= FormatFloat( '#00.00', ( a3t * 100 ) / att );
    ptd.Caption:= FormatFloat( '#00.00', ( adt * 100 ) / att );
    ptm.Caption:= FormatFloat( '#00.00', ( amt * 100 ) / att );
  except
    pt1.Caption:= '';
    pt2.Caption:= '';
    pt3.Caption:= '';
    ptd.Caption:= '';
    ptm.Caption:= '';
  end;

  a1t:= 0;
  a2t:= 0;
  a3t:= 0;
  adt:= 0;
  amt:= 0;
  att:= 0;
end;

procedure TQRAprovechaDiarioCompras.CabProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if not bVerPlantaciones then
    CabProducto.Height:= 0;
end;

procedure TQRAprovechaDiarioCompras.CabCosecheroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if not bVerPlantaciones then
    CabCosechero.Height:= 0;
end;

procedure TQRAprovechaDiarioCompras.PieGrupoProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if not bVerPlantaciones then
    PieGrupoProducto.Height:= 0;
end;

procedure TQRAprovechaDiarioCompras.PieGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if not bVerPlantaciones then
    PieGrupo.Height:= 0;
end;

end.
