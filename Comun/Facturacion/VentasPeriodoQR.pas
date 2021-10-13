unit VentasPeriodoQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, bMath, DB;

type
  TQRVentasPeriodo = class(TQuickRep)
    cabecera: TQRBand;
    detalle: TQRBand;
    pie: TQRBand;
    descripcion_p: TQRDBText;
    kilos: TQRDBText;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    qrdbtxtcajas: TQRDBText;
    qrlblPeriodo: TQRLabel;
    qrlblCentro: TQRLabel;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    qrdbtxtcajas1: TQRDBText;
    qrdbtxtdes_producto: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtdes_producto1: TQRDBText;
    qrbndColumnHeaderBand1: TQRBand;
    qrlbl3: TQRLabel;
    qrlblPsQRLabel1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlblLKilos: TQRLabel;
    qrlblLPais: TQRLabel;
    qrlbl1: TQRLabel;
    qrlblEmpresa: TQRLabel;
    qrlbl4: TQRLabel;
    qrdbtxtproducto1: TQRDBText;
    qrdbtxtdes_producto2: TQRDBText;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtdes_envase: TQRDBText;
    qrdbtxtproducto2: TQRDBText;
    qrdbtxtcod_factura: TQRDBText;
    qrdbtxtfecha_factura: TQRDBText;
    qrdbtxtcod_pais: TQRDBText;
    qrdbtxtcod_producto: TQRDBText;
    qrdbtxtcod_pais1: TQRDBText;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrlblCliente: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr5: TQRExpr;
    qrshp1: TQRShape;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrlbl16: TQRLabel;
    qrbl1: TQRLabel;
    QRDBText1: TQRDBText;
    qrbl2: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel1: TQRLabel;
    qrxpr4: TQRExpr;
    procedure qrdbtxtcod_pais1Print(sender: TObject; var Value: String);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtdes_producto2Print(sender: TObject;
      var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrxpr6Print(sender: TObject; var Value: string);
    procedure qrxpr4Print(sender: TObject; var Value: string);
    procedure qrxpr7Print(sender: TObject; var Value: string);
    procedure qrxpr5Print(sender: TObject; var Value: string);
  private
    rBaseImponible, rTotal: currency;

  public
    provincia: string;
    fecha: string;
  end;

implementation

uses UDMAuxDB, UDFactura, CFactura;

{$R *.DFM}

procedure TQRVentasPeriodo.qrdbtxtcod_pais1Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TQRVentasPeriodo.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRVentasPeriodo.qrdbtxtdes_producto2Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('cod_factura').AsString = '' then
    Value:= '';
end;

procedure TQRVentasPeriodo.qrxpr4Print(sender: TObject; var Value: string);
begin
  Value := FormatFloat('#,##0.00', bRoundTo( rBaseImponible, 2) );
end;

procedure TQRVentasPeriodo.qrxpr5Print(sender: TObject; var Value: string);
begin
   Value := FormatFloat('#,##0.00', bRoundTo( rTotal, 2) );
end;

procedure TQRVentasPeriodo.qrxpr6Print(sender: TObject; var Value: string);
var rLinea, rCajasTotal, rKilosTotal, rImporteTotal,
    rComision, rDescuento, rEurosKg, rEurosPale,
    rImpComision, rImpDescuento, rImpEurosKg, rImpEurosPale: real;
begin
  rLinea := StrToCurr ( StringReplace(Value, '.', '', [rfReplaceAll]) );
  rCajasTotal := 0;
  rKilosTotal := 0;
  rImporteTotal := 0;

  with DFactura.QVenta do
    begin
      if Active then Close;

      SQL.Clear;
      SQL.Add(' select empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, representante_c,  ');
      SQL.Add('        (case when fecha_factura_sc is not null then fecha_factura_sc else today end) fechaFactura, ');
      SQL.Add('        sum(cajas_sl) cajas, sum(kilos_sl) kilos, sum(importe_neto_sl) importe ');
      SQL.Add('  from frf_salidas_l ');
      SQL.Add(' left join frf_salidas_c on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
      SQL.Add(' left join frf_clientes on cliente_c = cliente_sal_sc                                                                                               ');
      SQL.Add(' where empresa_sl = :empresa ');
      SQL.Add('   and centro_salida_sl = :centro ');
      SQL.Add('   and n_albaran_sl = :albaran ');
      SQL.Add('   and fecha_sl = :fecha ');
      SQL.Add(' group by 1,2,3,4,5,6,7  ');

      ParamByName('empresa').AsString:= DataSet.FieldByName('empresa').AsString;
      ParamByName('centro').AsString:= DataSet.FieldByName('centro').AsString;
      ParamByName('albaran').AsString:= DataSet.FieldByName('n_albaran').AsString;
      ParamByName('fecha').AsString:= DataSet.FieldByName('fecha_albaran').AsString;
      Open;

      rCajasTotal := FieldByName('cajas').AsFloat;
      rKilosTotal := FieldByName('kilos').AsFloat;
      rImporteTotal := FieldByName('importe').AsFloat;

      rComision := GetPorcentajeComision(FieldByName('representante_c').AsString,
                                         FieldByName('fechaFactura').AsDatetime);
      rDescuento:= GetPorcentajeDescuento(FieldByName('empresa_sc').AsString,
                                          FieldByName('cliente_sal_sc').asString,
                                          FieldByName('centro_salida_sc').asString,
                                          DataSet.FieldByName('cod_producto').AsString,
                                          FieldByName('fechaFactura').AsDatetime);
      rEurosKg:= GetEurosKg(FieldByName('empresa_sc').AsString,
                            FieldByName('cliente_sal_sc').asString,
                            FieldByName('centro_salida_sc').asString,
                            DataSet.FieldByName('cod_producto').AsString,
                            FieldByName('fechaFactura').AsDatetime);

      rEurosPale:= GetEurosPale(FieldByName('empresa_sc').AsString,
                                FieldByName('cliente_sal_sc').asString,
                                FieldByName('centro_salida_sc').asString,
                                DataSet.FieldByName('cod_producto').AsString,
                                FieldByName('fechaFactura').AsDatetime);

      rImpComision := bRoundTo(FieldByName('importe').AsFloat * rComision/100, 2);
      rImpDescuento:= bRoundTo((FieldByName('importe').AsFloat - rImpComision) * rDescuento/100, 3);
      rImpEurosKg := bRoundTo(Dataset.FieldByName('kilos').AsFloat * rEurosKg);
      rImpEurosPale := bRoundTo(Dataset.FieldByName('palets').AsFloat * rEurosPale);      //CAMBIAR!!!

      rImporteTotal := rImporteTotal - (rImpComision + rImpDescuento +  rImpEurosKg +  rImpEurosPale);

      Close;

      SQL.Clear;
      SQL.Add(' select unidad_dist_tg unidad');
      SQL.Add('   from frf_gastos  ');
      SQL.Add('   left join frf_tipo_gastos on tipo_tg = tipo_g');
      SQL.Add('  where empresa_g = :empresa ');
      SQL.Add('    and centro_salida_g = :centro ');
      SQL.Add('    and n_albaran_g = :albaran ');
      SQL.Add('    and fecha_g = :fecha ');

      ParamByName('empresa').AsString:= DataSet.FieldByName('empresa').AsString;
      ParamByName('centro').AsString:= DataSet.FieldByName('centro').AsString;
      ParamByName('albaran').AsString:= DataSet.FieldByName('n_albaran').AsString;
      ParamByName('fecha').AsString:= DataSet.FieldByName('fecha_albaran').AsString;
      Open;

      if not IsEmpty then
      begin
        if FieldByName('unidad').AsString = 'CAJAS' then
          rLinea := rLinea + ((  DataSet.FieldByName('cajas').AsFloat * DataSet.FieldByName('gasto_antes_impuestos').AsFloat ) / rCajasTotal )
        else if FieldByName('unidad').AsString = 'IMPORTE' then
          rLinea := rLinea + ((  DataSet.FieldByName('importe_antes_impuestos').AsFloat * DataSet.FieldByName('gasto_antes_impuestos').AsFloat ) / rImporteTotal )
        else
          rLinea := rLinea + ((  DataSet.FieldByName('kilos').AsFloat * DataSet.FieldByName('gasto_antes_impuestos').AsFloat ) / rKilosTotal );
      end;
    end;
  rBaseImponible := rBaseImponible + rLinea;
  Value :=  FormatFloat('#,##0.00', bRoundTo( rLinea, 2) );

end;

procedure TQRVentasPeriodo.qrxpr7Print(sender: TObject; var Value: string);
var rLinea, rCajasTotal, rKilosTotal, rImporteTotal,
    rComision, rDescuento, rEurosKg, rEurosPale,
    rImpComision, rImpDescuento, rImpEurosKg, rImpEurosPale: real;
begin
  rLinea := StrToCurr (  StringReplace(Value, '.', '', [rfReplaceAll]) );
  rCajasTotal := 0;
  rKilosTotal := 0;
  rImporteTotal := 0;

  with DFactura.QVenta do
    begin
      if Active then Close;

      SQL.Clear;
      SQL.Add(' select empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, representante_c,  ');
      SQL.Add('        (case when fecha_factura_sc is not null then fecha_factura_sc else today end) fechaFactura, ');
      SQL.Add('        sum(cajas_sl) cajas, sum(kilos_sl) kilos, sum(importe_neto_sl) importe ');
      SQL.Add('  from frf_salidas_l ');
      SQL.Add(' left join frf_salidas_c on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
      SQL.Add(' left join frf_clientes on cliente_c = cliente_sal_sc                                                                                               ');
      SQL.Add(' where empresa_sl = :empresa ');
      SQL.Add('   and centro_salida_sl = :centro ');
      SQL.Add('   and n_albaran_sl = :albaran ');
      SQL.Add('   and fecha_sl = :fecha ');
      SQL.Add(' group by 1,2,3,4,5,6,7  ');

      ParamByName('empresa').AsString:= DataSet.FieldByName('empresa').AsString;
      ParamByName('centro').AsString:= DataSet.FieldByName('centro').AsString;
      ParamByName('albaran').AsString:= DataSet.FieldByName('n_albaran').AsString;
      ParamByName('fecha').AsString:= DataSet.FieldByName('fecha_albaran').AsString;
      Open;

      rCajasTotal := FieldByName('cajas').AsFloat;
      rKilosTotal := FieldByName('kilos').AsFloat;
      rImporteTotal := FieldByName('importe').AsFloat;

      rComision := GetPorcentajeComision(FieldByName('representante_c').AsString,
                                         FieldByName('fechaFactura').AsDatetime);
      rDescuento:= GetPorcentajeDescuento(FieldByName('empresa_sc').AsString,
                                          FieldByName('cliente_sal_sc').asString,
                                          FieldByName('centro_salida_sc').asString,
                                          DataSet.FieldByName('cod_producto').AsString,
                                          FieldByName('fechaFactura').AsDatetime);
      rEurosKg:= GetEurosKg(FieldByName('empresa_sc').AsString,
                            FieldByName('cliente_sal_sc').asString,
                            FieldByName('centro_salida_sc').asString,
                            DataSet.FieldByName('cod_producto').AsString,
                            FieldByName('fechaFactura').AsDatetime);

      rEurosPale:= GetEurosPale(FieldByName('empresa_sc').AsString,
                                FieldByName('cliente_sal_sc').asString,
                                FieldByName('centro_salida_sc').asString,
                                DataSet.FieldByName('cod_producto').AsString,
                                FieldByName('fechaFactura').AsDatetime);

      rImpComision := bRoundTo(FieldByName('importe').AsFloat * rComision/100, 2);
      rImpDescuento:= bRoundTo((FieldByName('importe').AsFloat - rImpComision) * rDescuento/100, 3);
      rImpEurosKg := bRoundTo(Dataset.FieldByName('kilos').AsFloat * rEurosKg);
      rImpEurosPale := bRoundTo(Dataset.FieldByName('palets').AsFloat * rEurosPale);        //CAMBIAR!!!

      rImporteTotal := rImporteTotal - (rImpComision + rImpDescuento +  rImpEurosKg +  rImpEurosPale);


      Close;

      SQL.Clear;
      SQL.Add(' select unidad_dist_tg unidad');
      SQL.Add('   from frf_gastos  ');
      SQL.Add('   left join frf_tipo_gastos on tipo_tg = tipo_g');
      SQL.Add('  where empresa_g = :empresa ');
      SQL.Add('    and centro_salida_g = :centro ');
      SQL.Add('    and n_albaran_g = :albaran ');
      SQL.Add('    and fecha_g = :fecha ');

      ParamByName('empresa').AsString:= DataSet.FieldByName('empresa').AsString;
      ParamByName('centro').AsString:= DataSet.FieldByName('centro').AsString;
      ParamByName('albaran').AsString:= DataSet.FieldByName('n_albaran').AsString;
      ParamByName('fecha').AsString:= DataSet.FieldByName('fecha_albaran').AsString;
      Open;

      if not IsEmpty then
      begin
        if FieldByName('unidad').AsString = 'CAJAS' then
          rLinea := rLinea + ((  DataSet.FieldByName('cajas').AsFloat * DataSet.FieldByName('gasto_total').AsFloat ) / rCajasTotal )
        else if FieldByName('unidad').AsString = 'IMPORTE' then
          rLinea := rLinea + ((  DataSet.FieldByName('importe_antes_impuestos').AsFloat * DataSet.FieldByName('gasto_total').AsFloat ) / rImporteTotal )
        else
          rLinea := rLinea + ((  DataSet.FieldByName('kilos').AsFloat * DataSet.FieldByName('gasto_total').AsFloat ) / rKilosTotal );
      end;
    end;
  rTotal := rTotal + rLinea;
  Value :=  FormatFloat('#,##0.00', bRoundTo( rLinea, 2) );
end;

procedure TQRVentasPeriodo.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  bAux: Boolean;
begin
  rBaseImponible := 0;
  rTotal := 0;

  bAux:= ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
    qrlbl1.AutoSize:= bAux;
    qrlbl5.AutoSize:= bAux;
    qrlbl6.AutoSize:= bAux;
    qrlbl10.AutoSize:= bAux;
    qrlblLPais.AutoSize:= bAux;
    qrlbl8.AutoSize:= bAux;
    qrlbl9.AutoSize:= bAux;
    qrlbl11.AutoSize:= bAux;
    qrlbl7.AutoSize:= bAux;
    qrlbl12.AutoSize:= bAux;
    qrlbl13.AutoSize:= bAux;
    qrlbl1.AutoSize:= bAux;
    qrlbl15.AutoSize:= bAux;
    qrlblLKilos.AutoSize:= bAux;
    qrlblPsQRLabel1.AutoSize:= bAux;
    qrlbl2.AutoSize:= bAux;
    qrlbl3.AutoSize:= bAux;
    qrlbl4.AutoSize:= bAux;


   qrlbl1.Width:= qrdbtxtcod_pais.Width;
    qrlbl5.Width:= qrdbtxtcod_producto.Width;
    qrlbl6.Width:= qrdbtxtcod_factura.Width;
    qrlbl10.Width:= qrdbtxtfecha_factura.Width;
    qrlblLPais.Width:= qrdbtxtproducto1.Width;
    qrlbl8.Width:= qrdbtxtdes_producto2.Width;
    qrlbl9.Width:= qrdbtxtenvase.Width;
    qrlbl11.Width:= qrdbtxtdes_envase.Width;
    qrlbl7.Width:= qrdbtxtproducto2.Width;
    qrlbl12.Width:= qrdbtxtdes_producto.Width;
    qrlbl13.Width:= descripcion_p.Width;
    qrlbl1.Width:= qrdbtxtproducto.Width;
    qrlbl15.Width:= qrdbtxtdes_producto1.Width;
    qrlblLKilos.Width:= qrdbtxtcajas.Width;
    qrlblPsQRLabel1.Width:= qrdbtxtcajas1.Width;
    qrlbl2.Width:= kilos.Width;
    qrlbl3.Width:= qrxpr6.Width;
    qrlbl4.Width:= qrxpr7.Width;
    qrlbl16.Width:= qrdbtxtcod_pais1.Width;
    qrbl1.Width:=QRDBText1.Width;

    qrlblLKilos.Left:= qrdbtxtcajas.Left;
    qrlblPsQRLabel1.Left:= qrdbtxtcajas1.Left;
    qrlbl2.Left:= kilos.Left;
    qrlbl3.Left:= qrxpr6.Left;
    qrlbl4.Left:= qrxpr7.Left;

  if not bAux then
  begin
    qrlbl1.AutoSize:= True;
    qrlbl1.Caption:= 'PLANTA';
    qrlbl5.Enabled:= False;
    qrlbl9.AutoSize:= True;
    qrlbl11.Enabled:= False;
    qrlbl12.AutoSize:= True;
    qrlbl13.Enabled:= False;
    qrlbl14.AutoSize:= True;
    qrlbl15.Enabled:= False;
    qrlbl16.Enabled:= False;
  end
  else
  begin
    qrlbl1.Caption:= 'EMPRESA';
    qrlbl5.Enabled:= True;
    qrlbl11.Enabled:= True;
    qrlbl13.Enabled:= True;
    qrlbl15.Enabled:= True;
    qrlbl16.Enabled:= True;
  end;

  if (Exporting) and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) then
  begin
    qrlbl11.width := 200;
    qrdbtxtdes_envase.width := 200;
    QRLabel1.width := 70;
    QRLabel1.Caption := 'Código X3';
    QRDBText3.width := 70;

    qrlbl13.width := 300;
    descripcion_p.width := 300;

  end
  else
  begin
    qrlbl11.width := 98;
    qrdbtxtdes_envase.width := 98;
    QRLabel1.width := 23;
    QRLabel1.Caption := 'C.X3';
    QRDBText3.width := 23;

    qrlbl13.width := 100;
    descripcion_p.width := 100;
  end;

end;

end.
