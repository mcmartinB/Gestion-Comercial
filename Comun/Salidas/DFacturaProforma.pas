unit DFacturaProforma;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Buttons, Db, DBTables,
  DBCtrls, ExtCtrls, nbEdits, ComCtrls, BEdit, uSalidaUtils;

type
  TFDFacturaProforma = class(TForm)
    Panel1: TPanel;
    memoDireccion: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    labelIva: TLabel;
    Label3: TLabel;
    LMoneda: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    exNeto: TEdit;
    exIva: TEdit;
    exTotal: TEdit;
    exTotalEUR: TEdit;
    exFactura: TEdit;
    exFecha: TEdit;
    exCliente: TEdit;
    Label8: TLabel;
    exSuministro: TEdit;
    Label9: TLabel;
    exPedido: TEdit;
    Label10: TLabel;
    exVehiculo: TEdit;
    Label2: TLabel;
    MemoObservaciones: TMemo;
    Label11: TLabel;
    nCopias: TnbDBNumeric;
    StringGrid1: TStringGrid;
    UpDown1: TUpDown;
    chkCuatroDecimales: TCheckBox;
    lblIcoterm: TLabel;
    edtIncoterm: TEdit;
    lblPrecioCajaPlastica: TLabel;
    lblPrecioPaletPlastico: TLabel;
    bvlPrecioPlasticos: TBevel;
    edtPrecioCaja: TBEdit;
    edtPrecioPalet: TBEdit;
    memoDireccionEnv: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BitBtn2Click(Sender: TObject);
    procedure chkCuatroDecimalesClick(Sender: TObject);
  private
    cerrarForm: Boolean;
    bFacDespacho: Boolean;
    rLineas, rPlasticos, rNeto, rIva, rTotal, rEuros: real;

    ivaPorcentaje: Real;
    ivaTipo: string;
    ivaDescripcion: string;
    codEmpresa, codCentro: string;
    fechaAlbaran: string;
    numeroAlbaran, codAlbaran: string;
    moneda: string;
    espanol: Boolean;
    codigoCliente: string;
    bSpain: Boolean;
    //Mario
    cod_cli: string; //para guardar el archivo PDF

    rGGN : TGGN;

    procedure Limpiar;
    procedure RellenaTotales;
    procedure RecalculaValores;
    procedure DatosCliente(empresa, cliente, suministro: string);
    function SacaPais(pais: string; tipoalbaran: integer): string;
    function SacaProvincia(pais, codPostal: string): string;
    procedure CabeceraAlbaran(empresa, centro, fecha, albaran: string);
    procedure DatosIva(empresa, centro, fecha, albaran: string);
    procedure DetalleAlbaran(empresa, centro, fecha, albaran, cliente: string);
    function SacaProducto(empresa, producto, calibre, envase: string): string;
    function SacaMarca(marca: string): string;
    function SacaCantidad(empresa, unidad, envase, producto: string; cajas, unidades: Integer; kilos: Real): Real;
    procedure Previsualizar;

    procedure TotalesDespacho;
    procedure TotalesProforma;
    procedure Totales;

    function PutPaletsPlastico: real;
    function PutCajasPlastico: real;

  public
    { Public declarations }
    lObservaciones: TStringList;
    bGranada: boolean;

    sTitulo: string;
    procedure RellenaDatos(empresa, centro, fecha, albaran, cliente, suministro: string; const AFacDespacho: Boolean );
  end;

var
  FDFacturaProforma: TFDFacturaProforma;

implementation

uses UDMAuxDB, CAuxiliarDB, CVariables, LFacturaProforma, Printers, StrUtils,
     UDMBaseDatos, bSQLUtils, bTextUtils, UDMCambioMoneda, cGlobal, bMath,
  UDMConfig;

{$R *.DFM}

procedure TFDFacturaProforma.RellenaDatos(empresa, centro, fecha, albaran, cliente, suministro: string; const AFacDespacho: Boolean);
begin
  Limpiar;
  bFacDespacho:= AFacDespacho;
  if AFacDespacho then
  begin
    exFactura.Text:= empresa + centro + '-' + Rellena( albaran, 5, '0', taLeftJustify );
    Caption:= 'FACTURA DESPACHO';
    bvlPrecioPlasticos.Visible:= True;
    lblPrecioCajaPlastica.Visible:= True;
    lblPrecioPaletPlastico.Visible:= True;
    edtPrecioCaja.Visible:= True;
    edtPrecioPalet.Visible:= True;
    //edtPrecioCaja.Text:= '0,01';
    //edtPrecioPalet.Text:= '0,05';
    edtPrecioCaja.Text:= '';
    edtPrecioPalet.Text:= '';    
    MemoObservaciones.Width:= 506;
    MemoObservaciones.Left:= 27;
  end
  else
  begin
    exFactura.Text:= 'PROFORMA';
    Caption:= 'FACTURA PROFORMA';
    bvlPrecioPlasticos.Visible:= False;
    lblPrecioCajaPlastica.Visible:= False;
    lblPrecioPaletPlastico.Visible:= False;
    edtPrecioCaja.Visible:= False;
    edtPrecioPalet.Visible:= False;
    edtPrecioCaja.Text:= '';
    edtPrecioPalet.Text:= '';
    MemoObservaciones.Width:= 616;
    MemoObservaciones.Left:= 27;
  end;

  codEmpresa := empresa;
  fechaAlbaran := fecha;
  numeroAlbaran := albaran;
  codCentro:= centro;
  (*ALBARAN*)
    if ( Copy( empresa, 1, 1) = 'F' ) and ( cliente <> 'ECI' ) then
    //if ( Copy( empresa, 1, 1) = 'F' ) then
    begin
      codAlbaran := empresa + centro + Rellena( albaran, 5, '0', taLeftJustify ) + Coletilla( empresa );
    end
    else
    begin
      codAlbaran := albaran;
    end;

  cod_cli := cliente;

  //Datos cliente facturacion
  DatosCliente(empresa, cliente, suministro);

  //Datos de la cabecera del albaran
  CabeceraAlbaran(empresa, centro, fecha, albaran);

  //Datos sobre los impuestos a aplicar
  DatosIva(empresa, centro, fecha, albaran);

  //Rellenar tabla temporal con detalle albaran
  DetalleAlbaran(empresa, centro, fecha, albaran, cliente);
end;


function CompletaNif( const APais, ANif: string ): string;
begin
  if Pos( APais, ANif ) = 0 then
    Result:= APais + ANif
  else
    Result:= ANif;
end;


procedure TFDFacturaProforma.DatosCliente(empresa, cliente, suministro: string);
var
  hasDirSuministro: Boolean;
  registros: integer;
  eori: String;
begin
//  if (suministro <> '') and (suministro <> cliente) then hasDirSuministro := True
//  else hasDirSuministro := False;
{
  if hasDirSuministro then
  begin
    registros := ConsultaOpen(DMAuxDB.QGeneral, ' select nombre_c nombre, ' +
      '        nombre_ds suministro, ' +
      '        tipo_via_ds via, ' +
      '        domicilio_ds domicilio, ' +
      '        poblacion_ds poblacion, ' +
      '        cod_postal_ds codpostal, ' +
      '        provincia_ds provincia, ' +
      '        pais_ds pais, ' +
      '        nif_c cif, ' +
      '        moneda_c moneda, ' +
      '        cta_cliente_c codigo, ' +
      '        tipo_albaran_c tipoalbaran, ' +
      '        eori_cliente_c eori ' +
      '        from frf_clientes,frf_dir_sum ' +
      ' where  cliente_c= ' + SQLString(cliente) +
      '        and cliente_c=cliente_ds ' +
      '        and dir_sum_ds= ' + SQLString(suministro), False, False);
  end
  else
  begin
}
//Direccion Facturacion
    registros := ConsultaOpen(DMAuxDB.QGeneral, ' select nombre_c nombre, ' +
      '        tipo_via_fac_c via,' +
      '        domicilio_fac_c domicilio,' +
      '        poblacion_fac_c poblacion,' +
      '        cod_postal_fac_c codpostal,' +
      '        pais_fac_c pais,' +
      '        nif_c cif,' +
      '        moneda_c moneda,' +
      '        cta_cliente_c codigo, ' +
      '        tipo_albaran_c tipoalbaran, ' +
      '        eori_cliente_c eori ' +
      ' from frf_clientes ' +
      ' where  cliente_c= ' + SQLString(cliente), False, False);
//  end;
  bSpain:= True;
  if registros > 0 then
  begin
    with DMAuxDB.QGeneral, memoDireccion.Lines do
    begin
      bSpain:= FieldByName('pais').AsString = 'ES';
      Add(FieldByName('nombre').AsString);

      if hasDirSuministro then
        Add(FieldByName('suministro').AsString);

      if Trim(FieldByName('via').AsString) <> '' then
        Add(FieldByName('via').AsString + ' ' + FieldByName('domicilio').AsString)
      else
        Add(FieldByName('domicilio').AsString);

      Add(FieldByName('poblacion').AsString);

      //Provincia
      if hasDirSuministro then
      begin
        if FieldByName('pais').AsString <> 'ES' then
        begin
          Add(FieldByName('codpostal').AsString + ' ' + FieldByName('provincia').AsString);
        end
        else
        begin
          Add(FieldByName('codpostal').AsString + ' ' +
            SacaProvincia(FieldByName('pais').AsString, FieldByName('codpostal').AsString));
        end
      end
      else
      begin
        Add(FieldByName('codpostal').AsString + ' ' +
          SacaProvincia(FieldByName('pais').AsString, FieldByName('codpostal').AsString));
      end;

      Add(SacaPais(FieldByName('pais').AsString, FieldByName('tipoalbaran').AsInteger));

      eori := FieldByName('eori').asString;
      if eori <> '' then
        eori := Format('  - EORI: %s', [ eori ]);

      //De momento no sacamos el NIF
      if FieldByName('pais').AsString = 'ES' then
      begin
        espanol := True;
        Add('C.I.F. : ' + FieldByName('cif').AsString + eori)
      end
      else
      begin
        espanol := False;
        Add('V.A.T. : ' + CompletaNif( FieldByName('pais').AsString, FieldByName('cif').AsString ) + eori );
      end;

      moneda := FieldByName('moneda').AsString;
      LMoneda.Caption := moneda;

      codigoCliente := FieldByName('codigo').AsString;
      exCliente.Text := codigoCliente;
    end;
  end;
  DMAuxDB.QGeneral.Cancel;
  DMAuxDB.QGeneral.Close;

//Direccion Envio
    registros := ConsultaOpen(DMAuxDB.QGeneral, ' select nombre_c nombre, ' +
      '        nombre_ds suministro, ' +
      '        tipo_via_ds via, ' +
      '        domicilio_ds domicilio, ' +
      '        poblacion_ds poblacion, ' +
      '        cod_postal_ds codpostal, ' +
      '        provincia_ds provincia, ' +
      '        pais_ds pais, ' +
      '        nif_c cif, ' +
      '        moneda_c moneda, ' +
      '        cta_cliente_c codigo, ' +
      '        tipo_albaran_c tipoalbaran, ' +
      '        eori_cliente_c eori ' +
      '        from frf_clientes,frf_dir_sum ' +
      ' where  cliente_c= ' + SQLString(cliente) +
      '        and cliente_c=cliente_ds ' +
      '        and dir_sum_ds= ' + SQLString(suministro), False, False);

  bSpain:= True;
  if registros > 0 then
  begin
    with DMAuxDB.QGeneral, memoDireccionEnv.Lines do
    begin
      bSpain:= FieldByName('pais').AsString = 'ES';
      Add(FieldByName('suministro').AsString);

      if Trim(FieldByName('via').AsString) <> '' then
        Add(FieldByName('via').AsString + ' ' + FieldByName('domicilio').AsString)
      else
        Add(FieldByName('domicilio').AsString);

      Add(FieldByName('poblacion').AsString);

      //Provincia
      if hasDirSuministro then
      begin
        if FieldByName('pais').AsString <> 'ES' then
        begin
          Add(FieldByName('codpostal').AsString + ' ' + FieldByName('provincia').AsString);
        end
        else
        begin
          Add(FieldByName('codpostal').AsString + ' ' +
            SacaProvincia(FieldByName('pais').AsString, FieldByName('codpostal').AsString));
        end
      end
      else
      begin
        Add(FieldByName('codpostal').AsString + ' ' +
          SacaProvincia(FieldByName('pais').AsString, FieldByName('codpostal').AsString));
      end;

      Add(SacaPais(FieldByName('pais').AsString, FieldByName('tipoalbaran').AsInteger));

      eori := FieldByName('eori').asString;
      if eori <> '' then
        eori := Format('  - EORI: %s', [ eori ]);

{
      //De momento no sacamos el NIF
      if FieldByName('pais').AsString = 'ES' then
      begin
        espanol := True;
        Add('C.I.F. : ' + FieldByName('cif').AsString + eori)
      end
      else
      begin
        espanol := False;
        Add('V.A.T. : ' + CompletaNif( FieldByName('pais').AsString, FieldByName('cif').AsString ) + eori );
      end;
}
      moneda := FieldByName('moneda').AsString;
      LMoneda.Caption := moneda;

      codigoCliente := FieldByName('codigo').AsString;
      exCliente.Text := codigoCliente;
    end;
  end;
  DMAuxDB.QGeneral.Cancel;
  DMAuxDB.QGeneral.Close;

end;

function TFDFacturaProforma.SacaPais(pais: string; tipoalbaran: integer): string;
var query: String;
begin
 if tipoalbaran > 1 then
    query :=  ' select case when original_name_p <> '''' then original_name_p else descripcion_p end descripcion ' +
              ' from frf_paises ' +
              ' where pais_p= ' + SQLString(pais)
  else
    query :=  ' select descripcion_p descripcion ' +
              ' from frf_paises ' +
              ' where pais_p= ' + SQLString(pais);
  if ConsultaOpen(DMBaseDatos.QGeneral, query, False, False) > 0 then
  begin
    Result := DMBaseDatos.QGeneral.FieldByName('descripcion').AsString;
  end
  else
    Result := '';

  DMBaseDatos.QGeneral.Cancel;
  DMBaseDatos.QGeneral.Close;
end;

function TFDFacturaProforma.SacaProvincia(pais, codPostal: string): string;
begin
  if Trim(pais) <> 'ES' then
  begin
    Result := '';
    Exit;
  end;

  if ConsultaOpen(DMBaseDatos.QGeneral,
    ' select nombre_p provincia ' +
    ' from frf_provincias ' +
    ' where codigo_p= ' + SQLString(Copy(codPostal, 0, 2)), False, False) > 0 then
  begin
    Result := DMBaseDatos.QGeneral.FieldByName('provincia').AsString;
  end
  else
    Result := '';

  DMBaseDatos.QGeneral.Cancel;
  DMBaseDatos.QGeneral.Close;
end;

procedure TFDFacturaProforma.CabeceraAlbaran(empresa, centro, fecha, albaran: string);
var
  sAux: string;
begin
//  if gProgramVersion = pvBAG then
//  begin
//    sAux:= ' '''' incoterm, '''' plaza, ';
//  end
//  else
//  begin
    sAux:= ' incoterm_sc incoterm, plaza_incoterm_sc plaza, ';
//  end;

  if ConsultaOpen(DMAuxDB.QGeneral,
    ' select nota_factura_sc, dir_sum_sc suministro, '  + sAux +
    '        n_pedido_sc pedido, vehiculo_sc vehiculo ' +
    ' from frf_salidas_c ' +
    ' where empresa_sc= ' + SQLString(empresa) +
    '   and centro_salida_sc= ' + SQLString(centro) +
    '   and fecha_sc= ' + SQLDate(fecha) +
    '   and n_albaran_sc= ' + SQLNumeric(albaran), False, False) > 0 then
  begin
    with DMAuxDB.QGeneral do
    begin
      exSuministro.Text := FieldByName('suministro').AsString;
      exPedido.Text := FieldByName('pedido').AsString;
      exVehiculo.Text := FieldByName('vehiculo').AsString;
      exFecha.Text := fecha;
      if FieldByName('incoterm').AsString <> '' then
        edtIncoterm.Text:= FieldByName('incoterm').AsString + ' ' + FieldByName('plaza').AsString
      else
        edtIncoterm.Text:= '';

      MemoObservaciones.Lines.Clear;
      MemoObservaciones.Lines.Add(FieldByName('nota_factura_sc').AsString);
    end;
  end;

  DMAuxDB.QGeneral.Cancel;
  DMAuxDB.QGeneral.Close;

end;

procedure TFDFacturaProforma.DatosIva(empresa, centro, fecha, albaran: string);
begin
  ;

  if ConsultaOpen(DMAuxDB.QGeneral,
    ' select porc_iva_sl ivaPorcentaje, ' +
    '        tipo_iva_sl tipoIva, descripcion_i descripcion ' +
    ' from frf_salidas_l,frf_impuestos ' +
    ' where empresa_sl= ' + SQLString(empresa) +
    '   and centro_salida_sl= ' + SQLString(centro) +
    '   and fecha_sl= ' + SQLDate(fecha) +
    '   and n_albaran_sl= ' + SQLNumeric(albaran) +
    '   and tipo_iva_sl=codigo_i', false, false) > 0 then
  begin
    ivaPorcentaje := DMAuxDB.QGeneral.FieldByName('ivaPorcentaje').AsFloat;
    ivaDescripcion := DMAuxDB.QGeneral.FieldByName('descripcion').AsString;
    if Copy(DMAuxDB.QGeneral.FieldByName('tipoIva').AsString, 0, 1) = 'I' then
    begin
      if espanol then ivaTipo := 'IVA'
      else ivaTipo := 'VAT';
      labelIva.caption := 'IVA (' + FloatToStr(ivaPorcentaje) + '%)';
    end
    else
    begin
      if espanol then ivaTipo := 'IGIC'
      else ivaTipo := 'IGIC';
      labelIva.caption := 'IGIC (' + FloatToStr(ivaPorcentaje) + '%)';
    end;

  end;

  DMAuxDB.QGeneral.Cancel;
  DMAuxDB.QGeneral.Close;
end;

function GetPesoBruto( const AEmpresa, AEnvase, APalet: string; const AFecha: TDateTime; const AKilos, ACajas, APalets: Real ): Real;
begin
  result:= AKilos;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' SELECT kilos_tp ');
    SQL.Add(' FROM frf_tipo_palets ');
    SQL.Add(' WHERE  codigo_tp = :palet ');
    ParamByName('palet').AsString := APalet;
    Open;
    if not IsEmpty then
    begin
      result:= result + ( APalets * FieldByName('kilos_tp').AsFloat );
    end;
    Close;


    if ( AEmpresa = '080' ) and ( AEnvase = '885' ) and ( AFecha <= strToDate('13/3/2017') ) then
    begin
      result:= result + ( ACajas * 0.71);
      Exit;
    end;
    if ( AEmpresa = '080' ) and ( AEnvase = '886' ) and ( AFecha <= strToDate('9/4/2017') ) then
    begin
      result:= result + ( ACajas * 0.65);
      Exit;
    end;


    SQL.Clear;
    SQl.Add(' SELECT peso_envase_e ' +
        ' FROM   frf_envases ' +
        ' WHERE  (envase_e = :envase) ');
    ParamByName('envase').AsString := AEnvase;
    Open;
    if not IsEmpty then
    begin
      result:= result + ( ACajas * FieldByName('peso_envase_e').AsFloat );
    end;
    Close;
  end;
end;

procedure TFDFacturaProforma.DetalleAlbaran(empresa, centro, fecha, albaran, cliente: string);
var
  registros, fila: integer;
  articulo : string;
begin
  registros := ConsultaOpen(DMAuxDB.QGeneral,
    ' select empresa_sl empresa, producto_sl producto, marca_sl marca, tipo_palets_sl tipo_palet, n_palets_sl palets, ' +
    '        envase_sl envase, cajas_sl cajas, unidades_caja_sl unidades_caja, ( cajas_sl * unidades_caja_sl ) unidades, calibre_sl calibre, ' +
    '        kilos_sl kilos, unidad_precio_sl unidad, precio_sl precio, importe_neto_sl neto' +
    ' from frf_salidas_l ' +
    ' where empresa_sl= ' + SQLString(empresa) +
    '   and centro_salida_sl= ' + SQLString(centro) +
    '   and fecha_sl= ' + SQLDate(fecha) +
    '   and n_albaran_sl= ' + SQLNumeric(albaran), false, false);

  bGranada:= False;
  if registros > 0 then
  begin
    self.rGGN := ConfigurarGGN(DMAuxDB.QGeneral.DatabaseName, empresa, centro, StrtoInt(albaran), StrToDate(fecha));

    QRLFacturaProforma.rGGN := self.rGGN;
    //Para cada tupla seleccionada
    with DMAuxDB.QGeneral do
    begin
      First;
      fila := 1;
      while not Eof do
      begin
        articulo := Uppercase(FieldByName('producto').AsString);
        if not bGranada then
          bGranada:= FieldByName('producto').AsString = 'W';
        StringGrid1.RowCount := fila + 1;

        StringGrid1.Cells[1, fila] := SacaProducto(empresa, FieldByName('producto').AsString, FieldByName('calibre').AsString, FieldByName('envase').AsString);

        if (articulo = 'PLA') and (self.rGGN.poner_arterisco = true) then StringGrid1.Cells[1, fila] := StringGrid1.Cells[1, fila] + ' *';


        StringGrid1.Cells[2, fila] := SacaMarca(FieldByName('marca').AsString);
        StringGrid1.Cells[3, fila] := desEnvaseCliente(
          empresa,
          FieldByName('producto').AsString,
          FieldByName('envase').AsString,
          cliente);
        StringGrid1.Cells[4, fila] := FloatToStr(SacaCantidad(empresa, FieldByName('unidad').AsString,
          FieldByName('envase').AsString, FieldByName('producto').AsString,
          FieldByName('cajas').AsInteger, FieldByName('unidades').AsInteger,
          FieldByName('kilos').AsFloat));
        StringGrid1.Cells[5, fila] := FieldByName('unidad').AsString;
        StringGrid1.Cells[6, fila] := FieldByName('precio').AsString;
        StringGrid1.Cells[7, fila] := FieldByName('neto').AsString;
        (*
        if Trim(FieldByName('precio').AsString) = '' then
        begin
          StringGrid1.Cells[7, fila] := '';
        end
        else
        begin
          if chkCuatroDecimales.Checked then
            StringGrid1.Cells[7, fila] :=
              FormatFloat('#0.000', StrToFloat(StringReplace(StringGrid1.Cells[4, fila], '.', '', [rfReplaceAll, rfIgnoreCase])) *
              (StrToFloat(FieldByName('precio').AsString)))
          else
            StringGrid1.Cells[7, fila] :=
              FormatFloat('#0.00', StrToFloat(StringReplace(StringGrid1.Cells[4, fila], '.', '', [rfReplaceAll, rfIgnoreCase])) *
              (StrToFloat(FieldByName('precio').AsString)));
        end;
        *)

        StringGrid1.Cells[8, fila] := FloatToStr( FieldByName('cajas').AsInteger );
        StringGrid1.Cells[9, fila] := FloatToStr( FieldByName('unidades_caja').AsInteger );
        StringGrid1.Cells[10, fila] := FloatToStr( FieldByName('unidades').AsInteger );
        StringGrid1.Cells[11, fila] := FloatToStr( FieldByName('kilos').AsFloat );
        StringGrid1.Cells[12, fila] := FloatToStr( GetPesoBruto( FieldByName('empresa').AsString, FieldByName('envase').AsString, FieldByName('tipo_palet').AsString,
                      strToDate(fecha), FieldByName('kilos').AsFloat,FieldByName('cajas').AsFloat,FieldByName('palets').AsFloat) );

        StringGrid1.Cells[13, fila] :=  Uppercase(FieldByName('producto').AsString);       //producto_sl
        Inc(fila);
        Next;
      end;
    end;
  end;
  DMAuxDB.QGeneral.Cancel;
  DMAuxDB.QGeneral.Close;
  RellenaTotales;
end;

function TFDFacturaProforma.SacaProducto(empresa, producto, calibre, envase: string): string;
begin
  if ConsultaOpen(DMBaseDatos.QGeneral,
    ' select descripcion_p castellano, ' +
    ' descripcion2_p ingles ' +
    ' from frf_productos ' +
    ' where producto_p= ' + SQLString(producto), False, False) > 0 then
    if espanol then
      result := DMBaseDatos.QGeneral.FieldByName('castellano').AsString
    else
    begin
      if Trim(DMBaseDatos.QGeneral.FieldByName('ingles').AsString) <> '' then
      begin
        result := DMBaseDatos.QGeneral.FieldByName('ingles').AsString
      end
      else
      begin
        result := DMBaseDatos.QGeneral.FieldByName('castellano').AsString;
      end;
    end;
  DMBaseDatos.QGeneral.Cancel;
  DMBaseDatos.QGeneral.Close;
end;

function TFDFacturaProforma.SacaMarca(marca: string): string;
begin
  if ConsultaOpen(DMBaseDatos.QGeneral,
    ' select descripcion_m descripcion ' +
    ' from frf_marcas ' +
    ' where codigo_m = ' + SQLString(Marca), False, False) > 0 then
    SacaMarca := DMBaseDatos.QGeneral.FieldByName('descripcion').AsString;

  DMBaseDatos.QGeneral.Cancel;
  DMBaseDatos.QGeneral.Close;
end;

function TFDFacturaProforma.SacaCantidad(empresa, unidad, envase, producto: string; cajas, unidades: Integer; kilos: Real): Real;
begin
  if unidad = 'UND' then
  begin
    SacaCantidad := unidades
  end
  else
    if unidad = 'KGS' then
      SacaCantidad := kilos
    else
      if unidad = 'CAJ' then
        SacaCantidad := cajas
      else
        SacaCantidad := 0;
end;

procedure TFDFacturaProforma.Limpiar;
begin
  memoDireccion.Lines.Clear;
  memoDireccionenv.Lines.Clear;
end;

procedure TFDFacturaProforma.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseAuxQuerys;
  Action := caHide;
end;


procedure TFDFacturaProforma.FormActivate(Sender: TObject);
begin
  if CerrarForm = True then
  begin
    MessageDlg('' + #13 + #10 + '      Error al generar los datos necesarios.' + #13 + #10 + '      Si el problema persiste póngase en contacto         ' + #13 + #10 + '      con el departamento de informática.', mtWarning, [mbOK], 0);
    BitBtn1.Enabled := False;
  end;
end;

procedure TFDFacturaProforma.BitBtn1Click(Sender: TObject);
begin
  Previsualizar;
end;

procedure TFDFacturaProforma.Previsualizar;
var
  i: integer;
  sFecha: string;
begin

  QRLFacturaProforma.Configurar(codEmpresa, codCentro, bSpain, bFacDespacho, cod_cli);

  QRLFacturaProforma.sEmpresa:= codEmpresa;
  QRLFacturaProforma.sCentro:= codCentro;
  QRLFacturaProforma.iALbaran:= StrToInt(numeroAlbaran);
  QRLFacturaProforma.dFEcha:= StrToDate(fechaAlbaran);

  self.rGGN :=   ConfigurarGGN('database', codEmpresa, codCentro, StrToInt(numeroAlbaran), strtodate(fechaAlbaran));

  QRLFacturaProforma.rGGN := self.rGGN;
 // QRLFacturaProforma.GGN_Code :=

  QRLFacturaProforma.bHayGranada:= bGranada;
  QRLFacturaProforma.tipoFactura.Caption := exFactura.Text;
  QRLFacturaProforma.fechaFactura.Caption := fechaAlbaran;


  QRLFacturaProforma.clienteFacturacion.Lines.Clear;
  for i := 0 to memoDireccion.Lines.Count - 1 do
  begin
    QRLFacturaProforma.clienteFacturacion.Lines.Add(memoDireccion.Lines[i]);
  end;

  QRLFacturaProforma.clienteEnvio.Lines.Clear;
  for i := 0 to memoDireccionEnv.Lines.Count - 1 do
  begin
    QRLFacturaProforma.clienteEnvio.Lines.Add(memoDireccionEnv.Lines[i]);
  end;

  QRLFacturaProforma.qrmFormaPago.Lines.Clear;
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('select descripcion_fp, descripcion2_fp, descripcion3_fp, ');
    SQL.Add('       descripcion4_fp, descripcion5_fp, descripcion6_fp, ');
    SQL.Add('       descripcion7_fp, descripcion8_fp, descripcion9_fp  ');
    SQL.Add('from frf_clientes_tes, frf_forma_pago ');

    SQL.Add('where empresa_ct = :empresa ');
    SQL.Add(' and cliente_ct = :cliente ');
    SQL.Add('and forma_pago_ct = codigo_fp ');
    ParamByName('empresa').AsString:=codEmpresa;
    ParamByName('cliente').AsString:= cod_cli;
    Open;
    if not IsEmpty then
    begin
      QRLFacturaProforma.qrmFormaPago.Lines.Add('Forma Pago:');
      QRLFacturaProforma.qrmFormaPago.Lines.Add(fieldbyName('descripcion_fp').AsString);
      if Trim( fieldbyName('descripcion2_fp').AsString ) <> '' then
        QRLFacturaProforma.qrmFormaPago.Lines.Add(fieldbyName('descripcion2_fp').AsString);
      if Trim( fieldbyName('descripcion3_fp').AsString ) <> '' then
        QRLFacturaProforma.qrmFormaPago.Lines.Add(fieldbyName('descripcion3_fp').AsString);
      if Trim( fieldbyName('descripcion4_fp').AsString ) <> '' then
        QRLFacturaProforma.qrmFormaPago.Lines.Add(fieldbyName('descripcion4_fp').AsString);
      if Trim( fieldbyName('descripcion5_fp').AsString ) <> '' then
        QRLFacturaProforma.qrmFormaPago.Lines.Add(fieldbyName('descripcion5_fp').AsString);
      if Trim( fieldbyName('descripcion6_fp').AsString ) <> '' then
        QRLFacturaProforma.qrmFormaPago.Lines.Add(fieldbyName('descripcion6_fp').AsString);
      if Trim( fieldbyName('descripcion7_fp').AsString ) <> '' then
        QRLFacturaProforma.qrmFormaPago.Lines.Add(fieldbyName('descripcion7_fp').AsString);
      if Trim( fieldbyName('descripcion8_fp').AsString ) <> '' then
        QRLFacturaProforma.qrmFormaPago.Lines.Add(fieldbyName('descripcion8_fp').AsString);
      if Trim( fieldbyName('descripcion9_fp').AsString ) <> '' then
        QRLFacturaProforma.qrmFormaPago.Lines.Add(fieldbyName('descripcion9_fp').AsString);
    end;
    Close;
  end;

  QRLFacturaProforma.albaran.Caption := codAlbaran;
  if (QRLFacturaProforma.albaran.Caption <> '') and (exSuministro.Text <> '') then
    QRLFacturaProforma.albaran.Caption := exSuministro.Text + ' - ' + QRLFacturaProforma.albaran.Caption;
  if (QRLFacturaProforma.albaran.Caption <> '') and (fechaAlbaran <> '') then
    QRLFacturaProforma.albaran.Caption := QRLFacturaProforma.albaran.Caption + ' - ' + fechaAlbaran;

  if (exPedido.Text = '') and (exVehiculo.Text = '') then
    QRLFacturaProforma.pedido.Caption := ''
  else
    if (exPedido.Text <> '') and (exVehiculo.Text <> '') then
      QRLFacturaProforma.pedido.Caption := exPedido.Text + ' / ' + exVehiculo.Text
    else
      if (exPedido.Text <> '') and (exVehiculo.Text = '') then
        QRLFacturaProforma.pedido.Caption := exPedido.Text
      else
        if (exPedido.Text = '') and (exVehiculo.Text <> '') then
          QRLFacturaProforma.pedido.Caption := exVehiculo.Text;


  if bFacDespacho then
  begin
    TotalesDespacho;
  end
  else
  begin
    TotalesProforma;
  end;

  //Observaciones
  if Trim(MemoObservaciones.Text) = '' then
    QRLFacturaProforma.BandaObservaciones.enabled := False
  else
    QRLFacturaProforma.MemoObservaciones.Lines.Text := MemoObservaciones.Text;

  sFecha := StringReplace(fechaalbaran, '/', '-', [rfReplaceAll, rfIgnoreCase]);
  sTitulo:= cod_cli + ' ' + sFecha + ' ' + numeroalbaran; //numeroalbaran;//ponerle la fecha y el codigo de cliente

  //Incoterm
  if edtIncoterm.Text = '' then
  begin
    QRLFacturaProforma.qrsIncoterm.Enabled:= False;
    QRLFacturaProforma.qrlIncotermLabel.Enabled:= False;
    QRLFacturaProforma.qrlIncoterm.Enabled:= False;
  end
  else
  begin
    QRLFacturaProforma.qrsIncoterm.Enabled:= True;
    QRLFacturaProforma.qrlIncotermLabel.Enabled:= True;
    QRLFacturaProforma.qrlIncoterm.Enabled:= True;
    QRLFacturaProforma.qrlIncoterm.Caption:= edtIncoterm.Text;
  end;

  Close;
end;


function TFDFacturaProforma.PutPaletsPlastico: real;
var
  rPrecio,rPalets,rPeso: extended;
begin
  if not TryStrToFloat(edtPrecioPalet.Text, rPrecio) then
  begin
    rPrecio:= 0;
  end;

  if rPrecio <> 0 then
  begin
    with DMAuxDB.QAux do
    begin
      SQl.clear;
      SQL.Add(' select sum(n_palets_sl) palets, sum(n_palets_sl * kilos_tp) peso_palets ');
      SQL.Add(' from frf_salidas_l ');
      SQL.Add('      join frf_tipo_palets on codigo_tp = tipo_palets_sl ');
      SQL.Add(' where empresa_sl = :empresa ');
      SQL.Add(' and centro_salida_sl = :centro ');
      SQL.Add(' and fecha_sl = :fecha ');
      SQL.Add(' and n_albaran_sl = :albaran ');
      SQL.Add(' and palet_plastico_tp = 1 ');
      ParamByName('empresa').AsString:= codEmpresa;
      ParamByName('centro').AsString:= codCentro;
      ParamByName('albaran').AsInteger:= StrToInt(numeroAlbaran);
      ParamByName('fecha').AsDateTime:= StrToDate(fechaAlbaran);
      Open;

      rPalets:= FieldByName('palets').AsFloat;
      rPeso:= FieldByName('peso_palets').AsFloat;
      result:= bRoundTo( rPalets * rPrecio, 2 );

      Close;
    end;
  end
  else
  begin
    rPalets:= 0;
    rPeso:= 0;
    result:= 0;
  end;

  if result = 0 then
  begin
    QRLFacturaProforma.qrlblDesPalets.Enabled:= False;
    QRLFacturaProforma.qrlblUndFacPalets.Enabled:= False;
    QRLFacturaProforma.qrlblNumPalets.Enabled:= False;
    QRLFacturaProforma.qrlblPesoPalets.Enabled:= False;
    QRLFacturaProforma.qrlblPrecioPalets.Enabled:= False;
    QRLFacturaProforma.qrlblImpPalets.Enabled:= False;
  end
  else
  begin
    QRLFacturaProforma.qrlblDesPalets.Enabled:= True;
    QRLFacturaProforma.qrlblUndFacPalets.Enabled:= True;
    QRLFacturaProforma.qrlblNumPalets.Enabled:= True;
    QRLFacturaProforma.qrlblPesoPalets.Enabled:= True;
    QRLFacturaProforma.qrlblPrecioPalets.Enabled:= True;
    QRLFacturaProforma.qrlblImpPalets.Enabled:= True;

    QRLFacturaProforma.qrlblNumPalets.Caption:= FormatFloat('#,##0', rPalets);
    QRLFacturaProforma.qrlblPesoPalets.Caption:= FormatFloat('#,##0',rPeso);
    QRLFacturaProforma.qrlblPrecioPalets.Caption:= FormatFloat('#,##0.000', rPrecio);
    QRLFacturaProforma.qrlblImpPalets.Caption:= FormatFloat('#,##0.00', resulT);
  end;
end;

function TFDFacturaProforma.PutCajasPlastico: real;
var
  rPrecio,rCajas,rPeso: extended;
begin
  if not TryStrToFloat(edtPrecioCaja.Text, rPrecio) then
  begin
    rPrecio:= 0;
  end;

  if rPrecio <> 0 then
  begin
    with DMAuxDB.QAux do
    begin
      SQl.clear;
      SQL.Add(' select sum(cajas_sl) cajas, sum(cajas_sl * peso_envase_e) peso_envases ');
      SQL.Add(' from frf_salidas_l ');
      SQL.Add('      join frf_envases on envase_sl = envase_E ');
      SQL.Add(' where empresa_sl = :empresa ');
      SQL.Add(' and centro_salida_sl = :centro ');
      SQL.Add(' and fecha_sl = :fecha ');
      SQL.Add(' and n_albaran_sl = :albaran ');
      SQL.Add(' and envase_comercial_e = ''N'' ');
      ParamByName('empresa').AsString:= codEmpresa;
      ParamByName('centro').AsString:= codCentro;
      ParamByName('albaran').AsInteger:= StrToInt(numeroAlbaran);
      ParamByName('fecha').AsDateTime:= StrToDate(fechaAlbaran);
      Open;

      rCajas:= FieldByName('cajas').AsFloat;
      rPeso:= FieldByName('peso_envases').AsFloat;
      result:= bRoundTo( rCajas * rPrecio, 2 );

      Close;
    end;
  end
  else
  begin
    rCajas:= 0;
    rPeso:= 0;
    result:= 0;
  end;

  if result = 0 then
  begin
    QRLFacturaProforma.qrlblDesCajas.Enabled:= False;
    QRLFacturaProforma.qrlblUndFacCajas.Enabled:= False;
    QRLFacturaProforma.qrlblNumCajas.Enabled:= False;
    QRLFacturaProforma.qrlblPesoCajas.Enabled:= False;
    QRLFacturaProforma.qrlblPrecioCajas.Enabled:= False;
    QRLFacturaProforma.qrlblImpCajas.Enabled:= False;
  end
  else
  begin
    QRLFacturaProforma.qrlblDesCajas.Enabled:= True;
    QRLFacturaProforma.qrlblUndFacCajas.Enabled:= True;
    QRLFacturaProforma.qrlblNumCajas.Enabled:= True;
    QRLFacturaProforma.qrlblPesoCajas.Enabled:= True;
    QRLFacturaProforma.qrlblPrecioCajas.Enabled:= True;
    QRLFacturaProforma.qrlblImpCajas.Enabled:= True;

    QRLFacturaProforma.qrlblNumCajas.Caption:= FormatFloat('#,##0', rCajas);
    QRLFacturaProforma.qrlblPesoCajas.Caption:= FormatFloat('#,##0',rPeso);
    QRLFacturaProforma.qrlblPrecioCajas.Caption:= FormatFloat('#,##0.000', rPrecio);
    QRLFacturaProforma.qrlblImpCajas.Caption:= FormatFloat('#,##0.00', resulT);
  end;
end;

procedure TFDFacturaProforma.TotalesDespacho;
begin
  rLineas:= rNeto;
  rPlasticos:= PutPaletsPlastico;
  rPlasticos:= rPlasticos + PutCajasPlastico;

  rNeto:= rLineas + rPlasticos;
  rIva := (rNeto * ivaPorcentaje) / 100;
  rTotal:= rNeto + rIva;
  rEuros:= ChangeToEuro( moneda, exFecha.Text, rNeto + rIva);

  QRLFacturaProforma.qrbndPaletsCajas.Enabled:= ( rPlasticos <> 0 );
  if QRLFacturaProforma.qrbndPaletsCajas.Enabled then
  begin
    QRLFacturaProforma.qrlblTotalAlbaran2.Caption := FormatFloat('#,##0.00', rLineas);;
    QRLFacturaProforma.qrlblTotalPlasticos.Caption := FormatFloat('#,##0.00', rPlasticos);;
  end;
  Totales;
end;

procedure TFDFacturaProforma.TotalesProforma;
begin
  QRLFacturaProforma.qrbndPaletsCajas.Enabled:= False;
  Totales;
end;

procedure TFDFacturaProforma.Totales;
begin
    QRLFacturaProforma.neto.Caption := FormatFloat('#,##0.00', rNeto);;
    QRLFacturaProforma.moneda1.Caption := moneda;

    if chkCuatroDecimales.Checked then
      QRLFacturaProforma.mascara:= '#0.0000'
    else
      QRLFacturaProforma.mascara:= '#0.0000';

    //Catidad Iva o mensaje descriptivo sobre el Iva
    if ivaPorcentaje = 0 then
    begin
      QRLFacturaProforma.iva.Caption := ivaDescripcion;
      QRLFacturaProforma.moneda2.Enabled := False;
      QRLFacturaProforma.ivaLabel1.Enabled := False;
      QRLFacturaProforma.ivaLabel2.Enabled := False;
      QRLFacturaProforma.ivaFrame.Enabled := False;
    end
    else
    begin
      QRLFacturaProforma.iva.Caption := FormatFloat('#,##0.00', rIva);
      QRLFacturaProforma.moneda2.Caption := moneda;
    end;

    //Cantidad total
    QRLFacturaProforma.total.Caption := FormatFloat('#,##0.00', rTotal);
    QRLFacturaProforma.moneda3.Caption := moneda;

    //Total en Euros si es necesario
    (*
    if moneda = 'EUR' then
    begin
      QRLFacturaProforma.euroLabel.Enabled := False;
      QRLFacturaProforma.euroMoneda.Enabled := False;
      QRLFacturaProforma.euroFrame.Enabled := False;
      QRLFacturaProforma.totalEuro.Enabled := False;
    end
    else
      QRLFacturaProforma.totalEuro.Caption := FormatFloat('#,##0.00', rEuros);
        *)
end;


procedure TFDFacturaProforma.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := (ACol = 6) and (ARow <> 0);
end;

procedure TFDFacturaProforma.FormCreate(Sender: TObject);
begin
  StringGrid1.RowCount := 2;
  StringGrid1.Cells[1, 0] := 'Producto';
  StringGrid1.Cells[2, 0] := 'Marca';
  StringGrid1.Cells[3, 0] := 'Envase';
  StringGrid1.Cells[4, 0] := 'Cantidad';
  StringGrid1.Cells[5, 0] := 'Unidad';
  StringGrid1.Cells[6, 0] := 'Precio';
  StringGrid1.Cells[7, 0] := 'Importe';

  StringGrid1.ColWidths[8] := 0;
  StringGrid1.ColWidths[9] := 0;
  StringGrid1.ColWidths[10] := 0;
  StringGrid1.ColWidths[11] := 0;
  StringGrid1.ColWidths[12] := 0;

  StringGrid1.col := 6;
  StringGrid1.row := 1;
  bSpain:= True;
end;

procedure TFDFacturaProforma.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  if Trim(Value) = '' then
  begin
    TStringGrid(sender).Cells[7, ARow] := '';
  end
  else
  begin
    if chkCuatroDecimales.Checked then
      TStringGrid(sender).Cells[7, ARow] :=
        FormatFloat('#0.000', StrToFloat(StringReplace(TStringGrid(sender).Cells[4, ARow], '.', '', [rfReplaceAll, rfIgnoreCase])) *
        (StrToFloat(Value)))
    else
      TStringGrid(sender).Cells[7, ARow] :=
        FormatFloat('#0.00', StrToFloat(StringReplace(TStringGrid(sender).Cells[4, ARow], '.', '', [rfReplaceAll, rfIgnoreCase])) *
        (StrToFloat(Value)));
    RellenaTotales;
  end;
end;

procedure TFDFacturaProforma.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (ACol = 6) and (ARow > 0) then
  begin
    TStringGrid(Sender).Canvas.Brush.Color := clWhite;
    TStringGrid(Sender).Canvas.FillRect(Rect);
    TStringGrid(Sender).Canvas.TextOut(Rect.Left, Rect.Top,
      TStringGrid(Sender).Cells[ACol, ARow]);
  end;
end;

procedure TFDFacturaProforma.RellenaTotales;
var
  conta: integer;
begin
  //Suma de los importes
  rNeto := 0;
  for conta := 1 to StringGrid1.RowCount do
  begin
    if StringGrid1.cells[7, conta] <> '' then
      rNeto := rNeto + StrToFloat(StringGrid1.cells[7, conta]);
  end;
  exNeto.text := FormatFloat('#,##0.00', rNeto);

  rIva := (rNeto * ivaPorcentaje) / 100;
  exIva.Text := FormatFloat('#,##0.00', rIva);

  rTotal:= rNeto + rIva;
  exTotal.text := FormatFloat('#,##0.00', rTotal);
  if DMConfig.EsLaFont then
    rEuros:= ChangeToEuro( moneda, exFecha.Text, rNeto + rIva)
  else
    rEuros:= 0;
  exTotalEUR.text := FormatFloat('#,##0.00', rEuros);
end;

procedure TFDFacturaProforma.BitBtn2Click(Sender: TObject);
begin
  nCopias.Text:= '0';
  Close;
end;

procedure TFDFacturaProforma.chkCuatroDecimalesClick(Sender: TObject);
begin
  RecalculaValores;
end;

procedure TFDFacturaProforma.RecalculaValores;
var
  conta: integer;
begin
  //Suma de los importes
  for conta := 1 to StringGrid1.RowCount do
  begin
    if Trim(StringGrid1.Cells[6, conta]) = '' then
    begin
      StringGrid1.Cells[7, conta] := '';
    end
    else
    begin
      if chkCuatroDecimales.Checked then
        StringGrid1.Cells[7, conta] :=
          FormatFloat('#0.000', StrToFloat(StringReplace(StringGrid1.Cells[4, conta], '.', '', [rfReplaceAll, rfIgnoreCase])) *
          (StrToFloat(StringGrid1.Cells[6, conta])))
      else
        StringGrid1.Cells[7, conta] :=
          FormatFloat('#0.00', StrToFloat(StringReplace(StringGrid1.Cells[4, conta], '.', '', [rfReplaceAll, rfIgnoreCase])) *
          (StrToFloat(StringGrid1.Cells[6, conta])));
    end;
  end;

  RellenaTotales;
end;

end.
