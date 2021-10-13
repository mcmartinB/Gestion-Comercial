unit FacturarEdiDP;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDPFacturarEdi = class(TDataModule)
    QCabEdi: TQuery;
    DSCabEdi: TDataSource;
    QLinEdi: TQuery;
    QLinIva: TQuery;
    QCabIva: TQuery;
    QClienteEDI: TQuery;
    QClientesEDI: TQuery;
    QImpuestoFactura: TQuery;
    QueryVendedor: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

    procedure CerrarTablas;
    procedure LimpiarBuffers;

    function  TipoIva: string;
    procedure AddCabecera;
    procedure AddLineas;
    procedure AddLinea;
    procedure AddImpuestos;
    procedure AddCabecerasImpuestos;
    procedure AddCabeceraImpuestos;
    procedure AddLineasImpuestos;
    procedure AddLineaImpuestos;

  public
    { Public declarations }
    cabeceras, lineas, cabImpuestos, linImpuestos: TStringList;
    sEmpresa, sVendedor, sCliente: string;
    iFactIni, iFactFin: Integer;
    dFechaFact: TDateTime;
    sNumFactura: string;

    function  EanVendedor( const AEmpresa: string ):string;
    function  EsClienteEDI( const AEmpresa, ACliente: string ): boolean;
    procedure ClientesEDI( const AEmpresa: string; var ALista: TStringList );
    function  HayDatos( const AEmpresa, AVendedor, ACliente: string;
                       const AFactIni, AFactFin: Integer;
                       const Afecha: TDateTime; var AMsg: string  ): Boolean;
    function CrearFicheros( var VMensaje: string ): Boolean;
    procedure GuardarFicheros( const ARuta: string );
  end;

var
  DPFacturarEdi: TDPFacturarEdi;

implementation

{$R *.dfm}

uses
  FacturarEdiMercadonaUP, FacturarEdiTescoUP, FacturarEdiSocomoUP, FacturarEdiZenalcoUP,
  FacturarEdiCorteInglesUP, FacturarEdiDiaUP, FacturarEdiConsumUP, FacturarEdiEroskiUP,
  FacturarEdiAhorramasUP, FacturarEdiLidlUP, FacturarEdiAlcampoUP, FacturarEdiMonoprixUP,
  UDMFacturacion, CGlobal;

procedure TDPFacturarEdi.DataModuleCreate(Sender: TObject);
begin
  cabeceras := TStringList.Create;
  lineas := TStringList.Create;
  cabImpuestos := TStringList.Create;
  linImpuestos := TStringList.Create;

  with QueryVendedor do
  begin
    SQl.Clear;
    SQL.Add(' SELECT codigo_ean_e vendedor ');
    SQL.Add(' FROM frf_empresas Frf_empresas ');
    SQL.Add(' WHERE  empresa_e = :empresa ');
  end;
  with QClienteEDI do
  begin
    SQl.Clear;
    SQL.Add(' select nombre_c ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add(' and cliente_c = :cliente ');
    SQL.Add(' and edi_c = ''S'' ');
  end;
  with QClientesEDI do
  begin
    SQl.Clear;
    SQL.Add(' select cliente_c,nombre_c ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add(' and edi_c = ''S'' ');
  end;
  with QImpuestoFactura do
  begin
    SQl.Clear;
    SQL.Add(' select tipo_impuesto_f from frf_facturas ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add('   and n_factura_f = :factura ');
    SQL.Add('   and fecha_factura_f = :fecha ');
  end;

  with QCabEdi do
  begin
    SQl.Clear;
    (*
    SQL.Add(' SELECT * ');
    SQL.Add(' FROM frf_facturas_edi_c ');
    SQL.Add(' WHERE factura_fec  BETWEEN  :desde  AND :hasta ');
    SQL.Add(' AND fecha_factura_fec = :fecha ');
    SQL.Add(' AND empresa_fec = :empresa ');
    SQL.Add(' and cliente_fec in ( select aquiensefactura_ce ');
    SQL.Add('                      from frf_clientes_edi ');
    SQL.Add('                      where empresa_ce = :empresa ');
    SQL.Add('                      and cliente_ce = :cliente )');
    SQL.Add(' order by factura_fec, fecha_factura_fec ');
    *)
    SQL.Add('  Select * ');
    SQL.Add('  FROM frf_facturas ');
    SQL.Add('       join frf_clientes  on  empresa_c = empresa_f and cliente_c = cliente_fac_f ');
    SQL.Add('       left join frf_facturas_edi_c on empresa_fec = empresa_f and factura_fec = n_factura_f and ');
    SQL.Add('                                      fecha_factura_fec = fecha_factura_f and  nodo_fec = tipo_factura_f ');
    SQL.Add('  WHERE empresa_f = :empresa ');
    SQL.Add('  and n_factura_f  BETWEEN  :desde  AND :hasta ');
    SQL.Add('  AND fecha_factura_f = :fecha ');
    SQL.Add('  and cliente_fac_f = :cliente ');
    SQL.Add('  and edi_c = ''S'' ');
    SQL.Add(' order by n_factura_f, fecha_factura_f ');

  end;
  with QLinEdi do
  begin
    SQl.Clear;
    SQL.Add(' SELECT * ');
    SQL.Add(' FROM frf_facturas_edi_l ');
    SQL.Add(' WHERE empresa_fel=:empresa_fec ');
    SQL.Add(' AND factura_fel=:factura_fec ');
    SQL.Add(' AND fecha_factura_fel=:fecha_factura_fec ');
    SQL.Add(' order by factura_fel, fecha_factura_fel, num_linea_fel ');
  end;
  with QCabIva do
  begin
    SQl.Clear;
    SQL.Add(' SELECT * ');
    SQL.Add(' FROM frf_impues_edi_c ');
    SQL.Add(' WHERE empresa_iec=:empresa_fec ');
    SQL.Add(' AND factura_iec=:factura_fec ');
    SQL.Add(' AND fecha_factura_iec=:fecha_factura_fec ');
    SQL.Add(' order by factura_iec, fecha_factura_iec ');
  end;
  with QLinIva do
  begin
    SQl.Clear;
    SQL.Add(' SELECT * ');
    SQL.Add(' FROM frf_impues_edi_l ');
    SQL.Add(' WHERE empresa_iel=:empresa_fec ');
    SQL.Add(' AND factura_iel=:factura_fec ');
    SQL.Add(' AND fecha_factura_iel=:fecha_factura_fec ');
    SQL.Add(' order by factura_iel, fecha_factura_iel, num_linea_iel ');
  end;
end;

procedure TDPFacturarEdi.DataModuleDestroy(Sender: TObject);
begin
    FreeAndNil( cabeceras );
    FreeAndNil( lineas );
    FreeAndNil( cabImpuestos );
    FreeAndNil( linImpuestos );
end;

procedure CerrarTabla( const AQuery: TQuery );
begin
  if AQuery.Active then
  begin
    AQuery.Cancel;
    AQuery.Close;
  end;
end;

procedure TDPFacturarEdi.CerrarTablas;
begin
  CerrarTabla( QLinEdi );
  CerrarTabla( QLinIva );
  CerrarTabla( QCabIva );
  CerrarTabla( QCabEdi );
end;

function TDPFacturarEdi.EanVendedor( const AEmpresa: string ):string;
begin
  if QueryVendedor.Active then
  begin
    QueryVendedor.Cancel;
    QueryVendedor.Close;
  end;
  QueryVendedor.ParamByName('empresa').AsString := AEmpresa;

  QueryVendedor.Open;
  if QueryVendedor.isEmpty then
  begin
    Result:= '';
  end
  else
  begin
    Result := QueryVendedor.FieldByName('vendedor').AsString;
  end;
  QueryVendedor.Cancel;
  QueryVendedor.Close;
end;

function  TDPFacturarEdi.EsClienteEDI( const AEmpresa, ACliente: string ): boolean;
begin
  QClienteEDI.ParamByName('empresa').AsString:= AEmpresa;
  QClienteEDI.ParamByName('cliente').AsString:= ACliente;
  QClienteEDI.Open;
  result := ( not QClienteEDI.IsEmpty );// or ( UpperCase( Copy( gsCodigo, 1, 4 ) ) = 'INFO');
  QClienteEDI.Close;
end;

procedure TDPFacturarEdi.ClientesEDI( const AEmpresa: string; var ALista: TStringList );
begin
  ALista.Clear;
  QClientesEDI.ParamByName('empresa').AsString:= AEmpresa;
  QClientesEDI.Open;
  while not QClientesEDI.Eof do
  begin
    ALista.Add( QClientesEDI.FieldByName('cliente_c').AsString );
    QClientesEDI.Next;
  end;
  QClientesEDI.Close;
end;


function TDPFacturarEdi.HayDatos( const AEmpresa, AVendedor, ACliente: string;
                                  const AFactIni, AFactFin: Integer;
                                  const Afecha: TDateTime; var AMsg: string ): Boolean;
begin
  CerrarTablas;

  QCabEdi.ParamByName('desde').AsInteger := AFactIni;
  QCabEdi.ParamByName('hasta').AsInteger := AFactFin;
  QCabEdi.ParamByName('fecha').AsDateTime := Afecha;
  QCabEdi.ParamByName('empresa').AsString := AEmpresa;
  QCabEdi.ParamByName('cliente').AsString := ACliente;

  try
    QCabEdi.Open;
    if QCabEdi.IsEmpty then
    begin
      AMsg:= '' + #13 + #10 + 'No se han conseguido facturas para la generación de los ficheros.      ' + #13 + #10 + '' + #13 + #10 + 'Por favor, revise los datos introducidos en el formulario. Gracias.';
      CerrarTabla( QCabEdi );
      HayDatos := False;
    end
    else
    begin
      QLinEdi.Open;
      QCabIva.Open;
      QLinIva.Open;

      sEmpresa:= AEmpresa;
      sVendedor:= AVendedor;
      sCliente:= ACliente;
      iFactIni:= AFactIni;
      iFactFin:= AFactFin;
      dFechaFact:= AFecha;

      HayDatos := True;
    end;
  except
    CerrarTablas;
    raise;
  end;
end;

function TDPFacturarEdi.TipoIva: string;
begin
    QImpuestoFactura.ParamByName('empresa').AsString:= sEmpresa;
    QImpuestoFactura.ParamByName('factura').AsString:= QCabEdi.FieldByName('factura_fec').AsString;
    QImpuestoFactura.ParamByName('fecha').AsDateTime:= QCabEdi.FieldByName('fecha_factura_fec').AsDateTime;
    QImpuestoFactura.Open;
    Result:= QImpuestoFactura.FieldByName('tipo_impuesto_f').AsString;
    QImpuestoFactura.Close;
end;

procedure TDPFacturarEdi.LimpiarBuffers;
begin
  cabeceras.Clear;
  lineas.Clear;
  cabImpuestos.Clear;
  linImpuestos.Clear;
end;

procedure TDPFacturarEdi.AddCabecera;
begin
  if sCliente = 'TS' then
  begin
    FacturarEdiTescoUP.AddCabecera( sNumFactura );
  end
  else
  if sCliente = 'SOC' then //Carrefour
  begin
    FacturarEdiSocomoUP.AddCabecera( sNumFactura );
  end
  else
  if sCliente = 'ZE' then //Alcampo
  begin
    FacturarEdiZenalcoUP.AddCabecera( sNumFactura );
  end
  else
  if sCliente = 'CMP' then //Eroski
  begin
    FacturarEdiAlcampoUP.AddCabecera( sNumFactura );
  end
  else
  if sCliente = 'ECI' then //Corte Ingles
  begin
    FacturarEdiCorteInglesUP.AddCabecera( sNumFactura );
  end
  else
  if sCliente = 'DIA' then //Dia
  begin
    FacturarEdiDiaUP.AddCabecera( sNumFactura );
  end
  else
  if sCliente = 'SUM' then //Consum
  begin
    FacturarEdiConsumUP.AddCabecera( sNumFactura );
  end
  else
  if sCliente = 'AMA' then //Ahorramas
  begin
    FacturarEdiAhorramasUP.AddCabecera( sNumFactura );
  end
  else
  if ( sCliente = 'ERO' ) or ( sCliente = 'CAB' ) then //Eroski - Caprabo
  begin
    FacturarEdiEroskiUP.AddCabecera( sNumFactura );
  end
  else
  if sCliente = 'LID' then //Eroski
  begin
    FacturarEdiLidlUP.AddCabecera( sNumFactura );
  end
  else
  if sCliente = 'MON' then //Monoprix
  begin
    FacturarEdiMonoprixUP.AddCabecera( sNumFactura );
  end
  else
  begin
    FacturarEdiMercadonaUP.AddCabecera( sNumFactura );
  end;
end;

procedure TDPFacturarEdi.AddLineas;
begin
  QLinEdi.First;
  while not QLinEdi.EOF do
  begin
     AddLinea;
    QLinEdi.Next;
  end;
end;

procedure TDPFacturarEdi.AddLinea;
begin
  if sCliente = 'TS' then
  begin
    FacturarEdiTescoUP.AddLinea( sNumFactura );
  end
  else
  if sCliente = 'SOC'  then
  begin
    FacturarEdiSocomoUP.AddLinea( sNumFactura );
  end
  else
  if sCliente = 'ZE' then
  begin
    FacturarEdiZenalcoUP.AddLinea( sNumFactura );
  end
  else
  if sCliente = 'CMP' then
  begin
    FacturarEdiAlcampoUP.AddLinea( sNumFactura );
  end
  else
  if sCliente = 'ECI' then //Corte Ingles
  begin
    FacturarEdiCorteInglesUP.AddLinea( sNumFactura );
  end
  else
  if sCliente = 'DIA' then //Corte Ingles
  begin
    FacturarEdiDiaUP.AddLinea( sNumFactura );
  end
  else
  if sCliente = 'SUM' then //Consum
  begin
    FacturarEdiConsumUP.AddLinea( sNumFactura );
  end
  else
  if sCliente = 'AMA' then //Ahorramas
  begin
    FacturarEdiAhorramasUP.AddLinea( sNumFactura );
  end
  else
  if ( sCliente = 'ERO' ) or ( sCliente = 'CAB' ) then //Eroski - Caprabo
  begin
    FacturarEdiEroskiUP.AddLinea( sNumFactura );
  end
  else
  if sCliente = 'LID' then //Eroski
  begin
    FacturarEdiLidlUP.AddLinea( sNumFactura );
  end
  else
  if sCliente = 'MON'  then
  begin
    FacturarEdiMonoprixUP.AddLinea( sNumFactura );
  end
  else
  begin
    FacturarEdiMercadonaUP.AddLinea( sNumFactura );
  end;
end;

procedure TDPFacturarEdi.AddImpuestos;
begin
  AddCabecerasImpuestos;
  AddLineasImpuestos;
end;

procedure TDPFacturarEdi.AddCabecerasImpuestos;
begin
  QCabIva.First;
  while not QCabIva.EOF do
  begin
    AddCabeceraImpuestos;
    QCabIva.Next;
  end;
end;
procedure TDPFacturarEdi.AddCabeceraImpuestos;
begin
  cabImpuestos.Add(
    sNumFactura + '|' +
    QCabIva.FieldByName('fecha_factura_iec').AsString + '|' +
    QCabIva.FieldByName('tipo_iec').AsString + '|' +
    QCabIva.FieldByName('base_iec').AsString + '|' +
    QCabIva.FieldByName('porcentaje_iec').AsString + '|' +
    QCabIva.FieldByName('importe_iec').AsString + '|' +
    QCabIva.FieldByName('status_iec').AsString + '|'
  );
end;

procedure TDPFacturarEdi.AddLineasImpuestos;
begin
  QLinIva.First;
  while not QLinIva.EOF do
  begin
    AddLineaImpuestos;
    QLinIva.Next;
  end;
end;
procedure TDPFacturarEdi.AddLineaImpuestos;
begin
  linImpuestos.Add(
    sNumFactura + '|' +
    QLinIva.FieldByName('fecha_factura_iel').AsString + '|' +
    QLinIva.FieldByName('num_linea_iel').AsString + '|' +
    QLinIva.FieldByName('tipo_iel').AsString + '|' +
    QLinIva.FieldByName('base_iel').AsString + '|' +
    QLinIva.FieldByName('porcentaje_iel').AsString + '|' +
    QLinIva.FieldByName('importe_iel').AsString + '|' +
    QLinIva.FieldByName('status_iel').AsString + '|'
  );
end;

function TDPFacturarEdi.CrearFicheros( var VMensaje: string ): Boolean;
var
  iTotal, iPasados: Integer;
begin
  LimpiarBuffers;
  VMensaje:= '';
  iTotal:= 0;
  iPasados:= 0;

  QCabEdi.First;
  while not QCabEdi.Eof do
  begin
    iTotal:= iTotal + 1;
    if QCabEdi.FieldByName('factura_fec').AsString<> '' then
    begin
      sNumFactura:= NewCodigoFactura( sEmpresa, QCabEdi.FieldByName('nodo_fec').AsString,
                      TipoIva, QCabEdi.FieldByName('fecha_factura_fec').AsDateTime,
                      QCabEdi.FieldByName('factura_fec').AsInteger);

      AddCabecera;
      AddLineas;
      AddImpuestos;
      iPasados:= iPasados + 1;
    end
    else
    begin
      if VMensaje = '' then
        VMensaje:=  QCabEdi.FieldByName('empresa_f').AsString +  ' - ' +
                    QCabEdi.FieldByName('n_factura_f').AsString +  ' - ' +
                    QCabEdi.FieldByName('fecha_factura_f').AsString
      else
        VMensaje:=  VMensaje + #13 + #10 +
                    QCabEdi.FieldByName('empresa_f').AsString +  ' - ' +
                    QCabEdi.FieldByName('n_factura_f').AsString +  ' - ' +
                    QCabEdi.FieldByName('fecha_factura_f').AsString;
    end;

    QCabEdi.Next;
  end;

  CerrarTablas;

  if iPasados < iTotal then
  begin
    VMensaje:= 'Pasadas ' + IntToStr( iPasados ) + ' de ' +   IntToStr( iTotal ) + ' facturas.'  + #13 + #10 +
               'FALTAN: ' + #13 + #10 + VMensaje;

  end
  else
  begin
    VMensaje:= 'Pasadas ' + IntToStr( iPasados ) + ' facturas.'  + #13 + #10 +
               'PROCESO FINALIZADO CORRECTAMENTE.';
  end;
  result:= iPasados > 0;
end;

procedure TDPFacturarEdi.GuardarFicheros( const ARuta: string );
begin
  //Guardar ficheros
  cabeceras.savetofile(ARuta + 'cabfac.txt');
  lineas.savetofile(ARuta + 'linfac.txt');
  linImpuestos.savetofile(ARuta + 'implfac.txt');
  cabImpuestos.savetofile(ARuta + 'impfac.txt');
end;

end.
