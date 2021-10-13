unit FacturarEdiConsumUP;

interface

  procedure AddCabecera( const AFactura: string );
  procedure AddLinea( const AFactura: string );

implementation

uses
  UDMAuxDB, FacturarEdiDP, CGlobal;

function GetIdTiket: string;
begin
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    result:= DPFacturarEdi.QCabEdi.FieldByName('idticket_fec').AsString + '|'
  else
    result:= '|';
end;

procedure AddCabecera( const AFactura: string );
begin
  with DPFacturarEdi do
  begin
    cabeceras.Add(
        AFactura + '|' +
        QCabEdi.FieldByName('vendedor_fec').AsString + '|' +
        QCabEdi.FieldByName('cobrador_fec').AsString + '|' +
        QCabEdi.FieldByName('comprador_fec').AsString + '|' +
        QCabEdi.FieldByName('receptor_fec').AsString + '|' +
        QCabEdi.FieldByName('cliente_fec').AsString + '|' +
        QCabEdi.FieldByName('pagador_fec').AsString + '|' +
        QCabEdi.FieldByName('pedido_fec').AsString + '|' +
        QCabEdi.FieldByName('fecha_factura_fec').AsString + '|' +
        QCabEdi.FieldByName('nodo_fec').AsString + '|' +
        QCabEdi.FieldByName('funcion_fec').AsString + '|' +
        QCabEdi.FieldByName('rsocial_fec').AsString + '|' +
        QCabEdi.FieldByName('domicilio_fec').AsString + '|' +
        QCabEdi.FieldByName('ciudad_fec').AsString + '|' +
        QCabEdi.FieldByName('cp_fec').AsString + '|' +
        QCabEdi.FieldByName('nif_fec').AsString + '|' +
        QCabEdi.FieldByName('razon_fec').AsString + '|' +
        GetIdTiket +
        QCabEdi.FieldByName('albaran_fec').AsString + '|' +
        QCabEdi.FieldByName('bruto_fec').AsString + '|' +
        QCabEdi.FieldByName('tipo_cargos_fec').AsString + '|' +
        QCabEdi.FieldByName('porc_cargos_fec').AsString + '|' +
        QCabEdi.FieldByName('cargos_fec').AsString + '|' +
        '|' + //QCabEdi.FieldByName('tipo_desc_fec').AsString + '|' +
        '0|' + //QCabEdi.FieldByName('porc_descuen_fec').AsString + '|' +
        QCabEdi.FieldByName('descuentos_fec').AsString + '|' +
        QCabEdi.FieldByName('impuestos_fec').AsString + '|' +
        QCabEdi.FieldByName('total_factura_fec').AsString + '|' +
        QCabEdi.FieldByName('forma_pago_fec').AsString + '|' +
        QCabEdi.FieldByName('moneda_fec').AsString + '|' +
        QCabEdi.FieldByName('vencimiento1_fec').AsString + '|' +
        QCabEdi.FieldByName('importe_vto1_fec').AsString + '|' +
        QCabEdi.FieldByName('vencimiento2_fec').AsString + '|' +
        QCabEdi.FieldByName('importe_vto2_fec').AsString + '|' +
        QCabEdi.FieldByName('vencimiento3_fec').AsString + '|' +
        QCabEdi.FieldByName('importe_vto3_fec').AsString + '|' +
        QCabEdi.FieldByName('status_fec').AsString + '|' +
        '|' //Departamento
    );
  end;
end;

function GetCantidad: string;
begin
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    result:= DPFacturarEdi.QLinEdi.FieldByName('cantidad_fel').AsString + '|'
  else
    result:= '0|';
end;

procedure AddLinea( const AFactura: string );
begin
  with DPFacturarEdi do
  begin
    lineas.Add(
          AFactura + '|' +
          QLinEdi.FieldByName('fecha_factura_fel').AsString + '|' +
          QLinEdi.FieldByName('num_linea_fel').AsString + '|' +
          QLinEdi.FieldByName('producto_fel').AsString + '|' +
          QLinEdi.FieldByName('descripcion_fel').AsString + '|' +
          QLinEdi.FieldByName('var_prom_fel').AsString + '|' +
          QLinEdi.FieldByName('dun14_fel').AsString + '|' +
          GetCantidad +
          QLinEdi.FieldByName('medida_fel').AsString + '|' +
          QLinEdi.FieldByName('unidad_medida_fel').AsString + '|' +
          QLinEdi.FieldByName('precio_bruto_fel').AsString + '|' +
          QLinEdi.FieldByName('precio_neto_fel').AsString + '|' +
          QLinEdi.FieldByName('tipo_cargo_fel').AsString + '|' +
          QLinEdi.FieldByName('porc_cargo_fel').AsString + '|' +
          QLinEdi.FieldByName('cargos_fel').AsString + '|' +
          QLinEdi.FieldByName('tipo_desc_fel').AsString + '|' +
          QLinEdi.FieldByName('porc_descuen_fel').AsString + '|' +
          QLinEdi.FieldByName('descuentos_fel').AsString + '|' +
          QLinEdi.FieldByName('neto_fel').AsString + '|' +
          QLinEdi.FieldByName('status_fel').AsString + '|'
        );
  end;
end;

end.
