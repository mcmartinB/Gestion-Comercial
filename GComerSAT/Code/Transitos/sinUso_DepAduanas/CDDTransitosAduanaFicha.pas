unit CDDTransitosAduanaFicha;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDDTransitosAduanaFicha = class(TDataModule)
    QKilosTransito: TQuery;
    QKilosDetalle: TQuery;
    QDatosCliente: TQuery;
    DSDatosAduana: TDataSource;
    QDatosDepositoCab: TQuery;
    QDatosDepositoLin: TQuery;
    QDatosDepositoSal: TQuery;
    QNumFacturaPlataforma: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure QDatosDepositoCabAfterOpen(DataSet: TDataSet);
    procedure QDatosDepositoCabBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }

  public
    { Public declarations }
    function  FichaDatosAduana( const ACodigo: Integer ): boolean;
    procedure DatosCliente( const AEmpresa, ACliente: string; var ALinea1, ALinea2: string );
    function  GetNumeroFactura( const AEmpresa, Acentro: string;
                                                   const AFecha: TDateTime;
                                                   const AAlbaran: integer;
                                                   var VNumFactura: Integer;
                                                   var VFechaFactura: TDateTime;
                                                   var VCostePlataforma: real  ): string;

  end;

var
  DDTransitosAduanaFicha: TDDTransitosAduanaFicha;

implementation

{$R *.DFM}

uses
  bTextUtils;

procedure TDDTransitosAduanaFicha.DataModuleCreate(Sender: TObject);
begin
  With QDatosDepositoCab do
  begin
    SQL.Clear;
    SQL.Add(' select buque_tc, vehiculo_tc, transporte_tc, frf_depositos_aduana_c.* ');
    SQL.Add(' from frf_depositos_aduana_c, frf_transitos_c ');
    SQL.Add(' where codigo_dac = :codigo  ');
    SQL.Add('   and empresa_tc = empresa_dac ');
    SQL.Add('   and centro_tc = centro_dac ');
    SQL.Add('   and fecha_tc = fecha_dac ');
    SQL.Add('   and referencia_tc = referencia_dac ');
    Prepare;
  end;

  With QDatosDepositoLin do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_depositos_aduana_l ');
    SQL.Add(' where codigo_dal = :codigo_dac ');
    SQL.Add(' order by fecha_dal, dua_consumo_dal ');
    Prepare;
  end;

  With QDatosDepositoSal do
  begin
    SQL.Clear;
    SQL.Add(' select frf_depositos_aduana_sal.* ');
    SQL.Add(' from frf_depositos_aduana_sal ');
    SQL.Add(' where codigo_das = :codigo_dac ');
    SQL.Add('   order by fecha_das, vehiculo_das, n_albaran_das ');
    Prepare;
  end;

  With QKilosTransito do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_tl) kilos_tl');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa_dac ');
    SQL.Add(' and centro_tl = :centro_dac ');
    SQL.Add(' and fecha_tl = :fecha_dac ');
    SQL.Add(' and referencia_tl = :referencia_dac ');
    Prepare;
  end;

  With QKilosDetalle do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_dal) kilos_dal ');
    SQL.Add(' from frf_depositos_aduana_l ');
    SQL.Add(' where codigo_dal = :codigo_dac ');
    Prepare;
  end;

  with QDatosCliente do
  begin
    SQL.Clear;
    SQL.Add(' select nombre_c, tipo_via_c, domicilio_c, poblacion_c, ');
    SQL.Add('        cod_postal_c, ');
    SQL.Add('        case when pais_c = ''ES'' then ');
    SQL.Add('            ( select nombre_p from frf_provincias where codigo_p = cod_postal_c[1,2] ) ');
    SQL.Add('          else ');
    SQL.Add('            '''' ');
    SQL.Add('        end provincia_c, ');
    SQL.Add('        ( select descripcion_p from frf_paises where pais_p = pais_c ) pais_c ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add(' and cliente_c = :cliente ');
    Prepare;
  end;

  with QNumFacturaPlataforma do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sc, n_factura_sc, fecha_factura_sc, fob_plataforma_p  ');
    SQL.Add(' from frf_salidas_c, frf_clientes, frf_paises ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and fecha_sc = :fecha ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and porte_bonny_sc = 0 ');
    SQL.Add(' and empresa_c = empresa_sc ');
    SQL.Add(' and cliente_c = cliente_sal_sc ');
    SQL.Add(' and pais_c = pais_p ');
    Prepare;
  end;
end;

procedure TDDTransitosAduanaFicha.DataModuleDestroy(Sender: TObject);
begin
  with QDatosDepositoCab do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QDatosDepositoLin do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QDatosDepositoSal do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QDatosCliente do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QKilosTransito do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QKilosDetalle do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QDatosCliente do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QNumFacturaPlataforma do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
end;

function TDDTransitosAduanaFicha.FichaDatosAduana( const ACodigo: Integer ): boolean;
begin
  With QDatosDepositoCab do
  begin
    Close;
    ParamByName('codigo').AsInteger:= ACodigo;
    Open;
    result:= not IsEmpty;
  end;
end;

procedure TDDTransitosAduanaFicha.DatosCliente( const AEmpresa, ACliente: string; var ALinea1, ALinea2: string );
begin

  with QDatosCliente do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    Open;

    if FieldByName('provincia_c').AsString <> '' then
    begin
      ALinea1:= Trim( FieldByName('nombre_c').AsString ) + ' - ' +
                Trim( FieldByName('provincia_c').AsString ) + ' - ' +
                Trim( FieldByName('pais_c').AsString );
    end
    else
    begin
      ALinea1:= FieldByName('nombre_c').AsString + ' - ' +
                FieldByName('pais_c').AsString;
    end;

    ALinea2:= Trim( FieldByName('tipo_via_c').AsString + '  ' + FieldByName('domicilio_c').AsString ) + ' - ' +
              FieldByName('poblacion_c').AsString;
    if FieldByName('cod_postal_c').AsString <> '' then
    begin
        ALinea2:= ALinea2 + ' (' + FieldByName('cod_postal_c').AsString + ') ';
    end;
    Close;
  end;
end;

procedure TDDTransitosAduanaFicha.QDatosDepositoCabAfterOpen(
  DataSet: TDataSet);
begin
  QDatosDepositoLin.Open;
  QDatosDepositoSal.Open;
  QKilosTransito.Open;
  QKilosDetalle.Open;
end;

procedure TDDTransitosAduanaFicha.QDatosDepositoCabBeforeClose(
  DataSet: TDataSet);
begin
  QDatosDepositoLin.Close;
  QDatosDepositoSal.Close;
  QKilosTransito.Close;
  QKilosDetalle.Close;
end;

function GetPrefijoFactura( const AEmpresa, ACentro: string; const AFecha: TDateTime ): string;
var
  iAnyo, iMes, iDia: word;
  sAux: string;
begin
  result:= 'ERROR ';
  DecodeDate( AFecha, iAnyo, iMes, iDia );
  sAux:= IntToStr( iAnyo );
  sAux:= Copy( sAux, 3, 2 );
  if ACentro = '6' then
  begin
    result:= 'FCT-' + AEmpresa + sAux + '-';
  end
  else
  begin
    result:= 'FCP-' + AEmpresa + sAux + '-';
  end;
end;

function NewContadorFactura( const AFactura: string ): string;
begin
  if StrToIntDef( AFactura, 0 ) > 99999 then
  begin
    result:= Copy( result, length( AFactura ) - 4, 5 );
  end
  else
  begin
    result:= Rellena( AFactura , 5, '0', taLeftJustify );
  end;
end;

function  NewCodigoFactura( const AEmpresa, ACentro, AFactura: string;
                            const AFecha: TDateTime ): string;
begin
  if ( AEmpresa = '501' ) or ( AEmpresa = '502' ) then
  begin
    result:= AFactura;
  end
  else
  begin
    result:= GetPrefijoFactura( AEmpresa, ACentro, AFecha ) +
             NewContadorFactura( AFactura );
  end;
end;

function TDDTransitosAduanaFicha.GetNumeroFactura( const AEmpresa, Acentro: string;
                                                   const AFecha: TDateTime;
                                                   const AAlbaran: integer;
                                                   var VNumFactura: Integer;
                                                   var VFechaFactura: TDateTime;
                                                   var VCostePlataforma: real  ): string;
begin
  result:= '';
  VNumFactura:= 0;
  VFechaFactura:= Date;
  VCostePlataforma:= 0;

  With QNumFacturaPlataforma do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= Acentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('albaran').AsInteger:= AAlbaran;
    Open;
    if not IsEmpty then
    begin
      if FieldByName('fob_plataforma_p').AsFloat <> 0 then
      begin
        if FieldByName('n_factura_sc').AsString <> '' then
        begin
          VNumFactura:= FieldByName('n_factura_sc').AsInteger;
          VFechaFactura:= FieldByName('fecha_factura_sc').AsDateTime;
          result:= NewCodigoFactura( AEmpresa, ACentro,
                                   FieldByName('n_factura_sc').AsString,
                                   FieldByName('fecha_factura_sc').AsDateTime );
          VCostePlataforma:= FieldByName('fob_plataforma_p').AsFloat;
        end;
      end;
    end;
    Close;
  end;
end;

end.
