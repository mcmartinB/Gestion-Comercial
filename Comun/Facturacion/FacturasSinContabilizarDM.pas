unit FacturasSinContabilizarDM;

interface

uses
  SysUtils, Classes, DB, Provider, DBClient, DBTables, ADODB;

type
  TDMFacturasSinContabilizar = class(TDataModule)
    qryFacturas: TQuery;
    cdsFacturas: TClientDataSet;
    dsFacturas: TDataSource;
    dspFacturas: TDataSetProvider;
    strngfldFacturascod_factura_fc: TStringField;
    strngfldFacturascod_empresa_fac_fc: TStringField;
    cdsFacturasn_factura_fc: TIntegerField;
    dtfldFacturasfecha_factura_fc: TDateField;
    strngfldFacturascod_cliente_fc: TStringField;
    strngfldFacturascta_cliente_fc: TStringField;
    strngfldFacturasdes_cliente_fc: TStringField;
    strngfldFacturasmoneda_fc: TStringField;
    fltfldFacturasimporte_neto_fc: TFloatField;
    fltfldFacturasimporte_neto_euros_fc: TFloatField;
    fltfldFacturasimporte_total_fc: TFloatField;
    fltfldFacturasimporte_total_euros_fc: TFloatField;
    aqryX3Factura: TADOQuery;
    fltfldFacturasimporte_conta_neto_fc: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    sEmpresa: string;
    dFechaini, dFechaFin: TDateTime;
    bPendiente: boolean;

    function QueryFacturas: boolean;
    function ComprobarContabilizacion: boolean;
    function EstaContabilizada: boolean;
    function ComprobarImportes: boolean;
    function ImporteContabilizado: real;
  end;

  function PendienteContabilizarComer( const sAEmpresa: string; const dAFechaini, dAFechaFin: TDateTime ): boolean;
  function PendienteContabilizarX3( const sAEmpresa: string; const dAFechaini, dAFechaFin: TDateTime ): boolean;
  function ComparaComerX3( const sAEmpresa: string; const dAFechaini, dAFechaFin: TDateTime ): boolean;

var
  DMFacturasSinContabilizar: TDMFacturasSinContabilizar;

implementation

{$R *.dfm}

uses
  FacturasSinContabilizarQR, UDMBaseDatos, bMath;

function PendienteContabilizarComer( const sAEmpresa: string; const dAFechaini, dAFechaFin: TDateTime ): boolean;
begin
  DMFacturasSinContabilizar:= TDMFacturasSinContabilizar.Create( nil );
  try
    DMFacturasSinContabilizar.sEmpresa:= sAEmpresa;
    DMFacturasSinContabilizar.dFechaini:= dAFechaini;
    DMFacturasSinContabilizar.dFechaFin:= dAFechaFin;
    DMFacturasSinContabilizar.bPendiente:= True;
    result:= DMFacturasSinContabilizar.QueryFacturas;
    if result then
    begin
      FacturasSinContabilizarQR.dFechaIni := dAFechaIni;
      FacturasSinContabilizarQR.dFechaFin := dAFechaFin;
      FacturasSinContabilizarQR.Imprimir;
    end;
  finally
    //DMFacturasSinContabilizar.qryFacturas.Close;
    DMFacturasSinContabilizar.cdsFacturas.Close;
    FreeAndNil(DMFacturasSinContabilizar);
  end;
end;

function PendienteContabilizarX3( const sAEmpresa: string; const dAFechaini, dAFechaFin: TDateTime ): boolean;
begin
  DMFacturasSinContabilizar:= TDMFacturasSinContabilizar.Create( nil );
  try
    DMFacturasSinContabilizar.sEmpresa:= sAEmpresa;
    DMFacturasSinContabilizar.dFechaini:= dAFechaini;
    DMFacturasSinContabilizar.dFechaFin:= dAFechaFin;
    DMFacturasSinContabilizar.bPendiente:= False;
    result:= DMFacturasSinContabilizar.QueryFacturas;
    if result then
    begin
      result:= DMFacturasSinContabilizar.ComprobarContabilizacion;
      if result then
      begin
        FacturasSinContabilizarQR.dFechaIni := dAFechaIni;
        FacturasSinContabilizarQR.dFechaFin := dAFechaFin;
        FacturasSinContabilizarQR.Imprimir;
      end;
    end;
  finally
    //DMFacturasSinContabilizar.qryFacturas.Close;
    DMFacturasSinContabilizar.cdsFacturas.Close;
    FreeAndNil(DMFacturasSinContabilizar);
  end;
end;

function ComparaComerX3( const sAEmpresa: string; const dAFechaini, dAFechaFin: TDateTime ): boolean;
begin
  DMFacturasSinContabilizar:= TDMFacturasSinContabilizar.Create( nil );
  try
    DMFacturasSinContabilizar.sEmpresa:= sAEmpresa;
    DMFacturasSinContabilizar.dFechaini:= dAFechaini;
    DMFacturasSinContabilizar.dFechaFin:= dAFechaFin;
    DMFacturasSinContabilizar.bPendiente:= False;
    result:= DMFacturasSinContabilizar.QueryFacturas;
    if result then
    begin
      result:= DMFacturasSinContabilizar.ComprobarImportes;
      if result then
      begin
        FacturasSinContabilizarQR.dFechaIni := dAFechaIni;
        FacturasSinContabilizarQR.dFechaFin := dAFechaFin;
        FacturasSinContabilizarQR.Imprimir;
      end;
    end;
  finally
    //DMFacturasSinContabilizar.qryFacturas.Close;
    DMFacturasSinContabilizar.cdsFacturas.Close;
    FreeAndNil(DMFacturasSinContabilizar);
  end;
end;

function TDMFacturasSinContabilizar.QueryFacturas: boolean;
begin
  qryFacturas.Sql.clear;
  qryFacturas.Sql.Add('select cod_factura_fc, cod_empresa_fac_fc, n_factura_fc, fecha_factura_fc, ');
  qryFacturas.Sql.Add('       cod_cliente_fc, cta_cliente_fc, des_cliente_fc, moneda_fc, ');
  qryFacturas.Sql.Add('       importe_neto_fc, importe_neto_euros_fc, ');
  qryFacturas.Sql.Add('       importe_total_fc, importe_total_euros_fc, contabilizado_fc ');
  qryFacturas.Sql.Add('from tfacturas_cab ');
  qryFacturas.Sql.Add('where fecha_factura_fc between :fechaini and :fechafin ');
  if sEmpresa = 'SAT' then
  begin
    qryfacturas.sql.add('and cod_empresa_fac_fc in (''050'',''080'', ''086'') ');
  end
  else
  if sEmpresa = 'BAG' then
  begin
    qryfacturas.sql.add('and substr(cod_empresa_fac_fc,1,1) = ''F'' ');
  end
  else
  if sEmpresa <> '' then
  begin
    qryfacturas.sql.add('and cod_empresa_fac_fc = :empresa ');
  end;
  if bPendiente then
  begin
    qryfacturas.sql.add('and contabilizado_fc = 0 ');
  end;

  if (sEmpresa <> '') and (sEmpresa <> 'SAT') and (sEmpresa <> 'BAG') then
  begin
    qryfacturas.ParamByname('empresa').AsString:= sEmpresa;
  end;
  qryfacturas.ParamByname('fechaini').AsDateTime:= dFechaini;
  qryfacturas.ParamByname('fechafin').AsDateTime:= dFechaFin;


  //qryFacturas.Open;
  //result:= not qryFacturas.isEmpty;
  cdsFacturas.Open;
  result:= not cdsFacturas.isEmpty;
end;

function TDMFacturasSinContabilizar.ComprobarContabilizacion: boolean;
begin
  while not cdsFacturas.Eof do
  begin
    if EstaContabilizada then
      cdsFacturas.Delete
    else
      cdsFacturas.Next;
  end;
  cdsFacturas.First;
  result:= not cdsFacturas.isEmpty;
end;

function TDMFacturasSinContabilizar.EstaContabilizada: boolean;
begin
  aqryX3Factura.Parameters.ParamByName('factura').Value:= cdsFacturas.FieldByName('cod_factura_fc').AsString;
  aqryX3Factura.Open;
  if aqryX3Factura.IsEmpty then
  begin
    result:= False;
  end
  else
  begin
    result:= True;
  end;
  aqryX3Factura.Close;
end;

function TDMFacturasSinContabilizar.ComprobarImportes: boolean;
var
  rAux: real;
begin
  while not cdsFacturas.Eof do
  begin
    rAux:= ImporteContabilizado;
    if rAux = broundTo(abs(cdsFacturas.FieldByname('importe_neto_fc').AsFloat), 2) then
      cdsFacturas.Delete
    else
    begin
      cdsFacturas.Edit;
      cdsFacturas.FieldByname('importe_conta_neto_fc').AsFloat:= rAux;
      cdsFacturas.Post;
      cdsFacturas.Next;
    end;
  end;

  cdsFacturas.First;
  result:= not cdsFacturas.isEmpty;
end;

function TDMFacturasSinContabilizar.ImporteContabilizado: real;
begin
  aqryX3Factura.Parameters.ParamByName('factura').Value:= cdsFacturas.FieldByName('cod_factura_fc').AsString;
  aqryX3Factura.Open;
  if aqryX3Factura.IsEmpty then
  begin
    result:= 0;
  end
  else
  begin
    result:= aqryX3Factura.FieldByname('ImporteAI').AsFloat;
  end;
  aqryX3Factura.Close;
end;

procedure TDMFacturasSinContabilizar.DataModuleCreate(Sender: TObject);
begin
  DMBaseDatos.conX3.Open;
  aqryX3Factura.SQL.Clear;
  aqryX3Factura.SQL.Add(' SELECT AMTNOT_0 as ImporteAI, CUR_0 as Moneda, ACCDAT_0 AS FechaContable ');
  aqryX3Factura.SQL.Add(' FROM BONNYSA.SINVOICE WHERE  NUM_0 = :factura ');
end;

procedure TDMFacturasSinContabilizar.DataModuleDestroy(Sender: TObject);
begin
  DMBaseDatos.conX3.Close;
end;

end.
