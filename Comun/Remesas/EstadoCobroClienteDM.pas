unit EstadoCobroClienteDM;

interface

uses
  SysUtils, Classes, DB, Provider, DBClient, DBTables;

type
  TDMEstadoCobroCliente = class(TDataModule)
    qryFacturas: TQuery;
    cdsFacturas: TClientDataSet;
    dtstprvdrFacturas: TDataSetProvider;
    strngfldFacturascod_empresa_fac_fc: TStringField;
    strngfldFacturascta_cliente_fc: TStringField;
    strngfldFacturascod_cliente_fc: TStringField;
    dtfldFacturasfecha_factura_fc: TDateField;
    strngfldFacturascod_factura_fc: TStringField;
    strngfldFacturasmoneda_fc: TStringField;
    fltfldFacturasimporte_neto_fc: TFloatField;
    fltfldFacturasimporte_total_fc: TFloatField;
    fltfldFacturasimporte_neto_euros_fc: TFloatField;
    fltfldFacturasimporte_total_euros_fc: TFloatField;
    dtfldFacturasfecha_fac_ini_fc: TDateField;
    dtfldFacturasprevision_cobro_fc: TDateField;
    dtfldFacturasprevision_tesoreria_fc: TDateField;
    fltfldFacturasimporte_cobrado: TFloatField;
    dtfldFacturasfecha_vencimiento_rc: TDateField;
    fltfldFacturaspendiente_cobro: TFloatField;
    cdsFacturasCobro: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    DateField1: TDateField;
    StringField4: TStringField;
    StringField5: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    DateField2: TDateField;
    DateField3: TDateField;
    DateField4: TDateField;
    FloatField5: TFloatField;
    DateField5: TDateField;
    fltfldFacturasCobroremesado: TFloatField;
    fltfldFacturasCobrocobrado: TFloatField;
    fltfldFacturasCobropendiente: TFloatField;
    fltfldFacturasCobroprevisto_cobro: TFloatField;
    fltfldFacturasCobroprevisto_tesoreria: TFloatField;
    fltfldFacturasCobrono_remesado: TFloatField;
    cdsFacturasCobroimporte: TFloatField;
  private
    { Private declarations }
    slClientes, slMail: TStringList;

    sEmpresa, sCliente, sTipoCliente, sPais: string;
    dFechaIni, dFechaFin: TDateTime;
    dFechaCobro, dPrevistoIni, dPrevistoFin: TDateTime;
    iMercado, iMoneda: integer;
    bExcluirCliente, bExcluirInterplanta: boolean;

    function  CargaCDS: boolean;
    function  AnyadirFacturas: boolean;
    procedure PresentarDatos(  bAVerFacturas: Boolean);
    procedure LimpiarTodo;

    procedure NuevaFactura;
    procedure ModificarFactura;
    procedure ActualizarImportes;
    procedure Remesado( const rAImporte: real );
    procedure NoRemesado( const rAImporte: real );
    function RegularizarFacturas: boolean;
  public
    { Public declarations }


    procedure PendienteCobro( const sAEmpresa, sACliente, sATipoCliente, sAPais: string;
                             const dAFechaIni, dAFechaFin: TDateTime;
                             const iAMercado, iAMoneda, iAEstadoCobro: integer;
                             const bAExcluirCliente, bAExcluirInterplanta, bAVerFacturas: boolean );
    procedure PrevistoCobro( const sAEmpresa, sACliente, sATipoCliente, sAPais: string;
                             const dAFechaIni, dAFechaFin, dAFechaCobroIni, dAFechaCobroFin: TDateTime;
                             const iAMercado, iAMoneda, iAEstadoCobro: integer;
                             const bAExcluirCliente, bAVerFacturas: boolean );

  end;

var
  DMEstadoCobroCliente: TDMEstadoCobroCliente;

implementation

{$R *.dfm}

uses
  dialogs, dateutils, USincronizarTablas, EstadoCobroClientesQL, Math, UDMCambioMoneda;

procedure TDMEstadoCobroCliente.PendienteCobro( const sAEmpresa, sACliente, sATipoCliente, sAPais: string;
                             const dAFechaIni, dAFechaFin: TDateTime;
                             const iAMercado, iAMoneda, iAEstadoCobro: integer;
                             const bAExcluirCliente, bAExcluirInterplanta, bAVerFacturas: boolean );
begin
  sEmpresa:= sAEmpresa;
  sCliente:= sACliente;
  sTipoCliente:= sATipoCliente;
  sPais:= sAPais;
  dFechaIni:= dAFechaIni;
  dFechaFin:= dAFechaFin;
  iMercado:= iAMercado;
  iMoneda:= iAMoneda;
  bExcluirCliente:= bAExcluirCliente;
  bExcluirInterplanta:=bAExcluirInterplanta;


  slClientes:= TStringList.Create;
  try

    if CargaCDS then
    begin
      if AnyadirFacturas then
      begin
        cdsFacturas.EmptyDataSet;
        cdsFacturas.Close;
        PresentarDatos( bAVerFacturas );
      end
      else
      begin
        ShowMessage('Sin facturas pendientes de cobro.');
      end
    end
    else
    begin
      ShowMessage('Sin facturas pendientes de cobro.');
    end;

  finally
    LimpiarTodo;
  end;

end;

//DESUSO
procedure TDMEstadoCobroCliente.PrevistoCobro( const sAEmpresa, sACliente, sATipoCliente, sAPais: string;
                             const dAFechaIni, dAFechaFin, dAFechaCobroIni, dAFechaCobroFin: TDateTime;
                             const iAMercado, iAMoneda, iAEstadoCobro: integer;
                             const bAExcluirCliente, bAVerFacturas: boolean );
begin
  sEmpresa:= sAEmpresa;
  sCliente:= sACliente;
  sTipoCliente:= sATipoCliente;
  sPais:= sAPais;
  dFechaIni:= dAFechaIni;
  dFechaFin:= dAFechaFin;
  dFechaCobro:= dAFechaCobroIni;
  dPrevistoIni:= dAFechaCobroIni;
  dPrevistoFin:= dAFechaCobroFin;
  iMercado:= iAMercado;
  iMoneda:= iAMoneda;
  bExcluirCliente:= bAExcluirCliente;


  slClientes:= TStringList.Create;
  try
    if CargaCDS then
    begin
      if AnyadirFacturas then
      begin
        cdsFacturas.EmptyDataSet;
        cdsFacturas.Close;
        PresentarDatos( bAVerFacturas );
      end
      else
      begin
        ShowMessage('Sin facturas pendientes de cobro.');
      end
    end
    else
    begin
      ShowMessage('Sin facturas pendientes de cobro.');
    end;
  finally
    LimpiarTodo;
  end;

end;


procedure TDMEstadoCobroCliente.LimpiarTodo;
begin
  FreeAndNil( slClientes );
  if cdsFacturas.Active then
  begin
    cdsFacturas.EmptyDataSet;
    cdsFacturas.Close;
  end;
  //cdsFacturas.CreateDataSet;

  if cdsFacturasCobro.Active then
  begin
    cdsFacturasCobro.EmptyDataSet;
    cdsFacturasCobro.Close;
  end;
  //cdsFacturasCobro.CreateDataSet;
end;

function TDMEstadoCobroCliente.CargaCDS: boolean;
var
  dIni, dFin: TDatetime;
  iMinutos, iSegundos: integer;
begin
  qryFacturas.SQL.Clear;
  qryFacturas.SQL.Add(' select cod_empresa_fac_fc, cta_cliente_fc, cod_cliente_fc, fecha_factura_fc, cod_factura_fc, ');
  qryFacturas.SQL.Add('        moneda_fc, importe_neto_fc, importe_total_fc, importe_neto_euros_fc,  importe_total_euros_fc, ');
  qryFacturas.SQL.Add('        fecha_fac_ini_fc, prevision_cobro_fc, prevision_tesoreria_fc, nvl(importe_cobrado_rf,0) importe_cobrado, fecha_vencimiento_rc ');
  qryFacturas.SQL.Add(' from tfacturas_cab ');
  qryFacturas.SQL.Add('      left join tremesas_fac on cod_factura_rf = cod_factura_fc ');
  qryFacturas.SQL.Add('      left join tremesas_cab on empresa_remesa_rc = empresa_remesa_rf and n_remesa_rc = n_remesa_rf ');
  qryFacturas.SQL.Add('      left join frf_clientes on cod_cliente_fc = cliente_c ');
  qryFacturas.SQL.Add(' where fecha_factura_fc between :fechaini and  :fechafin ');
  qryFacturas.SQL.Add('   and importe_total_fc <> nvl(importe_cobrado_rf,0) ');
  //qryFacturas.SQL.Add(' and anulacion_fc = 0 ');
  //qryFacturas.SQL.Add(' and not ( importe_total_fc = nvl(importe_cobrado_rf,0) and fecha_vencimiento_rc is not null and fecha_vencimiento_rc < :fechacobro ) ');

  if sEmpresa <> '' then
  begin
    if sEmpresa = 'SAT' then
      qryFacturas.SQL.Add(' and ( cod_empresa_fac_fc = ''050'' or cod_empresa_fac_fc = ''080'' ) ')
    else
    if sEmpresa = 'BAG' then
      qryFacturas.SQL.Add(' and ( substr(cod_empresa_fac_fc,1,1) = ''F''  ) ')
    else
      qryFacturas.SQL.Add(' and cod_empresa_fac_fc = :empresa ');
  end;
  if sCliente <> '' then
  begin
    if Pos( ',', sCliente ) > 0 then
    begin
      if bExcluirCliente then
        qryFacturas.SQL.Add(' and cod_cliente_fc not in (' +  sCliente + ' )  ')
      else
        qryFacturas.SQL.Add(' and cod_cliente_fc in (' +  sCliente + ' ) ');
    end
    else
    begin
      if bExcluirCliente then
        qryFacturas.SQL.Add(' and cod_cliente_fc <> :cliente ')
      else
        qryFacturas.SQL.Add(' and cod_cliente_fc = :cliente ');
    end;
  end;
  if sTipoCliente <> '' then
    qryFacturas.SQL.Add(' and tipo_cliente_c = :tipocliente ');

  //Excluir interplanta IP
  if bExcluirInterplanta then
    qryFacturas.SQL.Add(' and tipo_cliente_c <> ''IP'' ');

  if sPais <> '' then
    qryFacturas.SQL.Add(' and cod_pais_fc = :pais ');


  qryFacturas.SQL.Add(' order by cod_factura_fc ');

  qryFacturas.ParamByName('fechaini').AsDateTime:= dFechaIni;
  qryFacturas.ParamByName('fechafin').AsDateTime:= dFechaFin;

  if sEmpresa <> '' then
  begin
    if ( sEmpresa <> 'SAT' ) and ( sEmpresa <> 'BAG' ) then
      qryFacturas.ParamByName('empresa').AsString:= sEmpresa;
  end;
  if ( sCliente <> '' ) and ( Pos( ',', sCliente ) = 0 ) then
    qryFacturas.ParamByName('cliente').AsString:= sCliente;
  if sTipoCliente <> '' then
    qryFacturas.ParamByName('tipocliente').AsString:= sTipoCliente;
  if sPais <> '' then
    qryFacturas.ParamByName('pais').AsString := sPais;

  dIni:= now;
  //qryFacturas.Sql.SaveToFile('c:\temp\pepe.sql');
  cdsFacturas.Open;
  if qryFacturas.Active then
    qryFacturas.Close;
  dFin:= now;

//  iMinutos:= MinutesBetween(dFin, dIni);
//  iSegundos:= SecondsBetween(dFin, dIni) mod 60;
//  ShowMessage( 'INICIO-> ' + FormatDateTime('hh:nn:ss', dIni ) + ' - FIN->: ' + FormatDateTime('hh:nn:ss', dFin ) + ' -> TIEMPO-> ' + IntToStr( iMinutos ) + ':' + IntToStr( iSegundos )  );

  result:= not cdsFacturas.isempty;
end;

function TDMEstadoCobroCliente.AnyadirFacturas: boolean;
begin
  cdsFacturasCobro.Open;
  while not cdsFacturas.eof do
  begin
    if cdsFacturasCobro.Locate('cod_factura_fc',cdsFacturas.FieldByName('cod_factura_fc').AsString,[]) then
    begin
      ModificarFactura;
    end
    else
    begin
      NuevaFactura;
    end;
    cdsFacturas.Next;
  end;


  result:= not cdsFacturasCobro.isempty;
  if result then
  begin
    result:= RegularizarFacturas;
  end;
end;

procedure TDMEstadoCobroCliente.Presentardatos(  bAVerFacturas: Boolean);
begin
  EstadoCobroClientesQL.SaldoClientes( bAVerFacturas );
end;

procedure TDMEstadoCobroCliente.NuevaFactura;
begin
  USincronizarTablas.ClonarRegistro( cdsFacturas, cdsFacturasCobro );

  cdsFacturasCobro.FieldByName('remesado').AsFloat:= 0;
  cdsFacturasCobro.FieldByName('no_remesado').AsFloat:= 0;
  cdsFacturasCobro.FieldByName('cobrado').AsFloat:= 0;
  cdsFacturasCobro.FieldByName('pendiente').AsFloat:= 0;
  cdsFacturasCobro.FieldByName('previsto_tesoreria').AsFloat:= 0;
  cdsFacturasCobro.FieldByName('previsto_cobro').AsFloat:= 0;

  ActualizarImportes;

  cdsFacturasCobro.Post;
end;

procedure TDMEstadoCobroCliente.ModificarFactura;
begin
  cdsFacturasCobro.Edit;

  ActualizarImportes;

  cdsFacturasCobro.Post;
end;

procedure TDMEstadoCobroCliente.ActualizarImportes;
var rImporte, rImporteCobrado: real;
begin

  rImporte := 0;
  rImporteCobrado := 0;

  if iMoneda = 0 then       //EURO
  begin
    rImporte := cdsFacturas.FieldByName('importe_total_euros_fc').AsFloat;
    if cdsFacturas.FieldByName('importe_cobrado').AsFloat <> 0 then
      rImporteCobrado := ChangeToEuro( cdsFacturas.FieldByName('moneda_fc').AsString,
                                       cdsFacturas.FieldByName('fecha_factura_fc').AsString,
                                       cdsFacturas.FieldByName('importe_cobrado').AsFloat);
  end
  else
  begin
    rImporte := cdsFacturas.FieldByName('importe_total_fc').AsFloat;
    rImporteCobrado := cdsFacturas.FieldByName('importe_cobrado').AsFloat;
  end;

  if rImporteCobrado <> 0 then
    Remesado( rImporteCobrado )
  else
    NoRemesado( rImporte );


  cdsFacturasCobro.FieldByName('importe').AsFloat := rImporte;
end;

procedure TDMEstadoCobroCliente.Remesado( const rAImporte: real );
begin
  cdsFacturasCobro.FieldByName('remesado').AsFloat:= cdsFacturasCobro.FieldByName('remesado').AsFloat + rAImporte;

  cdsFacturasCobro.FieldByName('cobrado').AsFloat:= cdsFacturasCobro.FieldByName('cobrado').AsFloat + rAImporte;
//  cdsFacturasCobro.FieldByName('pendiente').AsFloat:= cdsFacturasCobro.FieldByName('pendiente').AsFloat + rAImporte;

  cdsFacturasCobro.FieldByName('previsto_tesoreria').AsFloat:= cdsFacturasCobro.FieldByName('previsto_tesoreria').AsFloat + rAImporte;
  cdsFacturasCobro.FieldByName('previsto_cobro').AsFloat:= cdsFacturasCobro.FieldByName('previsto_cobro').AsFloat + rAImporte;
end;

procedure TDMEstadoCobroCliente.NoRemesado( const rAImporte: real );
begin
  cdsFacturasCobro.FieldByName('no_remesado').AsFloat:= cdsFacturasCobro.FieldByName('no_remesado').AsFloat + rAImporte;
  cdsFacturasCobro.FieldByName('pendiente').AsFloat:= cdsFacturasCobro.FieldByName('pendiente').AsFloat + rAImporte;

  cdsFacturasCobro.FieldByName('previsto_tesoreria').AsFloat:= cdsFacturasCobro.FieldByName('previsto_tesoreria').AsFloat + rAImporte;
  cdsFacturasCobro.FieldByName('previsto_cobro').AsFloat:= cdsFacturasCobro.FieldByName('previsto_cobro').AsFloat + rAImporte;
end;

function TDMEstadoCobroCliente.RegularizarFacturas: boolean;
var
  rAux: real;
  iCliente: integer;
begin
  cdsFacturasCobro.First;
  while not cdsFacturasCobro.eof do
  begin
    if iMoneda = 0 then   //EURO
      rAux := RoundTo( cdsFacturasCobro.FieldByName('importe_total_euros_fc').AsFloat -
       ( cdsFacturasCobro.FieldByName('remesado').AsFloat + cdsFacturasCobro.FieldByName('no_remesado').AsFloat ), -2 )
    else
      rAux:= RoundTo( cdsFacturasCobro.FieldByName('importe_total_fc').AsFloat -
         ( cdsFacturasCobro.FieldByName('remesado').AsFloat + cdsFacturasCobro.FieldByName('no_remesado').AsFloat ), -2 );

    cdsFacturasCobro.Edit;
    if iMoneda = 0 then
      cdsFacturasCobro.FieldByName('moneda_fc').AsString := 'EUR';

    if rAux <> 0  then
    begin
//      cdsFacturasCobro.Edit;
      NoRemesado( rAux );
      cdsFacturasCobro.Post;
      if not slClientes.Find( cdsFacturas.FieldByName('cta_cliente_fc').AsString, iCliente )  then
      begin
        slClientes.Add( cdsFacturas.FieldByName('cta_cliente_fc').AsString );
        //AddMail;
      end;
    end;
    if cdsFacturasCobro.FieldByName('pendiente').AsFloat <> 0 then
      cdsFacturasCobro.Next
    else
      cdsFacturasCobro.Delete;
  end;
  result:= not cdsFacturasCobro.isempty;
end;

(*
cod_empresa_fac_fc,
cta_cliente_fc,
cod_cliente_fc,

cod_factura_fc,
moneda_fc,
importe_neto_fc,
importe_total_fc,
importe_neto_euros_fc,
importe_total_euros_fc,

fecha_factura_fc,
-->>> fecha_fac_ini_fc,
prevision_cobro_fc,
prevision_tesoreria_fc,
importe_cobrado,
fecha_vencimiento_rc

prevision_ini=fecha_cobro
prevision_fin

cobrado:= 0
pendiente_cobro:= 0
remesado  := 0
previsto_cobro:= 0
previsto_tesoreria:= 0




**************************************************


*)

end.
