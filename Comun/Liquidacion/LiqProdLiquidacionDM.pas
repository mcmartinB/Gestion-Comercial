unit LiqProdLiquidacionDM;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable, StdCtrls;

type
  TDMLiqProdLiquidacion = class(TDataModule)
    kmtMes: TkbmMemTable;
    qryInfLiquidacion: TQuery;
    kmtLiqCos: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    sWarnig, sError: string;

    { Private declarations }
    //Parametros de entrada
    sEmpresa, sCentro, sProducto: string;
    sOrigen, sCosechero, sSemana, sMes, sCategoria: string;
    iCategoria: integer;
    dFechaIni, dFechaFin, dFEcha: TDateTime;
    sKey, sHora: string;
    bDefinitiva, bSemana: boolean;

    rPrecioBruto, rPrecioGastos, rPrecioNeto: real;
    rImporteBruto, rImporteGastos, rImporteLiquido: real;
    ikilos_ent, ikilos_liq, ikilos_fac: integer;

    procedure SQLInformeLiquidacion(const AEmpresa, ACentro, AProducto: string;
                                    const ADesde, AHasta: TDateTime );
    function  InformeLiquidacion(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime ): boolean;
    procedure ReiniciarTabla;
    procedure ReiniciarLiquidacion;
    procedure RellenarTabla;
    procedure RellenarLiquidacion;

    procedure NewValues;
    procedure AddValues;
    procedure SaveValues;
    function  GetKey: string;
    function  SetKey: string;

    procedure NewValuesLiq;
    procedure AddValuesLiq;
    procedure SaveValuesLiq;
    function  GetKeyLiq: string;
    function  SetKeyLiq: string;
  public
    { Public declarations }

    procedure AddWarning( const AMsg: string );
    procedure AddError( const AMsg: string );


    procedure InformeLiquidacionCategoria( const AEmpresa, ACentro, AProducto: string;
                                           const ADesde, AHasta: TDateTime );
    procedure InformeLiquidacionResumen( const AEmpresa, ACentro, AProducto: string;
                                         const ADesde, AHasta: TDateTime );
    procedure InformeLiquidacionSemanas( const AEmpresa, ACentro, AProducto: string;
                                         const ADesde, AHasta: TDateTime );
    procedure InformeLiquidacionPosei( const AEmpresa, ACentro, AProducto: string;
                                         const ADesde, AHasta: TDateTime );
  end;



var
  DMLiqProdLiquidacion: TDMLiqProdLiquidacion;

implementation

{$R *.dfm}

uses
  Math, bMath, bTimeUtils, LiqProdVendidoEntradasDM, Forms, Dialogs,
  Variants, LiqProdInfLiquidacionQR, LiqProdLiquidacionCosQR;

procedure TDMLiqProdLiquidacion.AddWarning( const AMsg: string );
begin
  if sWarnig <> '' then
    sWarnig := sWarnig + #13 + #10 + AMsg
  else
    sWarnig := AMsg;
end;


procedure TDMLiqProdLiquidacion.AddError( const AMsg: string );
begin
  if sError <> '' then
    sError := sError + #13 + #10 + AMsg
  else
    sError := AMsg;
end;

procedure TDMLiqProdLiquidacion.DataModuleDestroy(Sender: TObject);
begin
  kmtMes.Close;
  kmtLiqCos.Close;
end;

procedure TDMLiqProdLiquidacion.DataModuleCreate(Sender: TObject);
begin
  kmtMes.FieldDefs.Clear;
  kmtMes.FieldDefs.Add('codigo', ftInteger, 0, False);
  kmtMes.FieldDefs.Add('keyMes', ftString, 18, False);
  kmtMes.FieldDefs.Add('empresa', ftString, 3, False);
  kmtMes.FieldDefs.Add('centro', ftString, 3, False);
  kmtMes.FieldDefs.Add('producto', ftString, 3, False);
  kmtMes.FieldDefs.Add('origen', ftString, 3, False);
  kmtMes.FieldDefs.Add('cosechero', ftString, 3, False);
  kmtMes.FieldDefs.Add('anyomes', ftString, 6, False);
  kmtMes.FieldDefs.Add('categoria', ftInteger, 0, False);

  kmtMes.FieldDefs.Add('fecha_ini', ftDate, 0, False);
  kmtMes.FieldDefs.Add('fecha_fin', ftDate, 0, False);
  kmtMes.FieldDefs.Add('fecha_calculo', ftDate, 0, False);
  kmtMes.FieldDefs.Add('hora_calculo', ftString, 5, False);

  kmtMes.FieldDefs.Add('kilos_ent', ftInteger, 0, False);
  kmtMes.FieldDefs.Add('kilos_liq', ftInteger, 0, False);
  kmtMes.FieldDefs.Add('kilos_fac', ftInteger, 0, False);

  kmtMes.FieldDefs.Add('precio_venta', ftFloat, 0, False);
  kmtMes.FieldDefs.Add('precio_gastos', ftFloat, 0, False);
  kmtMes.FieldDefs.Add('precio_liquido', ftFloat, 0, False);
  kmtMes.FieldDefs.Add('importe_venta', ftFloat, 0, False);
  kmtMes.FieldDefs.Add('importe_gastos', ftFloat, 0, False);
  kmtMes.FieldDefs.Add('importe_liquido', ftFloat, 0, False);

  kmtMes.IndexFieldNames:= 'codigo;keyMes';
  kmtMes.CreateTable;

  kmtLiqCos.FieldDefs.Clear;
  kmtLiqCos.FieldDefs.Add('codigo', ftInteger, 0, False);
  kmtLiqCos.FieldDefs.Add('keyMes', ftString, 18, False);
  kmtLiqCos.FieldDefs.Add('empresa', ftString, 3, False);
  kmtLiqCos.FieldDefs.Add('centro', ftString, 3, False);
  kmtLiqCos.FieldDefs.Add('producto', ftString, 3, False);
  kmtLiqCos.FieldDefs.Add('origen', ftString, 3, False);
  kmtLiqCos.FieldDefs.Add('cosechero', ftString, 3, False);
  kmtLiqCos.FieldDefs.Add('anyomes', ftString, 6, False);

  kmtLiqCos.FieldDefs.Add('fecha_ini', ftDate, 0, False);
  kmtLiqCos.FieldDefs.Add('fecha_fin', ftDate, 0, False);
  kmtLiqCos.FieldDefs.Add('fecha_calculo', ftDate, 0, False);
  kmtLiqCos.FieldDefs.Add('hora_calculo', ftString, 5, False);

  kmtLiqCos.FieldDefs.Add('categoria', ftInteger, 0, False);
  kmtLiqCos.FieldDefs.Add('kilos_ent', ftInteger, 0, False);
  kmtLiqCos.FieldDefs.Add('kilos_liq', ftInteger, 0, False);
  kmtLiqCos.FieldDefs.Add('kilos_fac', ftInteger, 0, False);

  kmtLiqCos.FieldDefs.Add('precio_liquido', ftFloat, 0, False);
  kmtLiqCos.FieldDefs.Add('importe_liquido', ftFloat, 0, False);

  kmtLiqCos.IndexFieldNames:= 'codigo;keyMes';
  kmtLiqCos.CreateTable;
end;

procedure  TDMLiqProdLiquidacion.SQLInformeLiquidacion(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  qryInfLiquidacion.SQL.Clear;
  qryInfLiquidacion.SQL.Add(' select empresa_ent, producto_ent, centro_ent, centro_origen_ent,  ');
  qryInfLiquidacion.SQL.Add('        cosechero_ent, ');
  if bSemana then
    qryInfLiquidacion.SQL.Add('        semana, ')
  else
    qryInfLiquidacion.SQL.Add('     ''''   semana, ');
  qryInfLiquidacion.SQL.Add('        categoria_ent, ');
  qryInfLiquidacion.SQL.Add('        sum(kilos_ent) kilos_ent, sum(kilos_liq) kilos_liq, ');
  qryInfLiquidacion.SQL.Add('        round(sum( case when categoria_ent = 1 then porcentaje1 ');
  qryInfLiquidacion.SQL.Add('                        when categoria_ent = 2 then porcentaje2 ');
  qryInfLiquidacion.SQL.Add('                        when categoria_ent = 3 then porcentaje3 ');
  qryInfLiquidacion.SQL.Add('                        else porcentaje4 ');
  qryInfLiquidacion.SQL.Add('                   end * kilos_liq )) kilos_fac,  ');
  qryInfLiquidacion.SQL.Add('        case when categoria_ent = 1 then importe1 ');
  qryInfLiquidacion.SQL.Add('             when categoria_ent = 2 then importe2 ');
  qryInfLiquidacion.SQL.Add('             when categoria_ent = 3 then importe3 ');
  qryInfLiquidacion.SQL.Add('             else importe4 ');
  qryInfLiquidacion.SQL.Add('        end precio_venta, ');
  qryInfLiquidacion.SQL.Add('        case when categoria_ent = 1 then gastos1 ');
  qryInfLiquidacion.SQL.Add('             when categoria_ent = 2 then gastos2 ');
  qryInfLiquidacion.SQL.Add('             when categoria_ent = 3 then gastos3 ');
  qryInfLiquidacion.SQL.Add('             else gastos4 ');
  qryInfLiquidacion.SQL.Add('        end gastos, ');
  qryInfLiquidacion.SQL.Add('        case when categoria_ent = 1 then liquido1 ');
  qryInfLiquidacion.SQL.Add('             when categoria_ent = 2 then liquido2 ');
  qryInfLiquidacion.SQL.Add('             when categoria_ent = 3 then liquido3 ');
  qryInfLiquidacion.SQL.Add('             else liquido4 ');
  qryInfLiquidacion.SQL.Add('        end precio_liquido ');

  qryInfLiquidacion.SQL.Add(' from tliq_liquida_det det ');
  qryInfLiquidacion.SQL.Add('      join tliq_semanas cab on cab.codigo = det.codigo_liq ');
  qryInfLiquidacion.SQL.Add(' where empresa_ent = :empresa ');
  qryInfLiquidacion.SQL.Add(' and fecha_ent between :fechaini and :fechafin ');
  if ACentro <> '' then
    qryInfLiquidacion.SQL.Add(' and centro_ent = :centro ');
  if AProducto <> '' then
    qryInfLiquidacion.SQL.Add(' and producto_ent = :producto ');
  qryInfLiquidacion.SQL.Add(' group by empresa_ent, producto_ent, centro_ent, centro_origen_ent, cosechero_ent, ');
  qryInfLiquidacion.SQL.Add('          categoria_ent, semana, precio_venta, gastos, precio_liquido  ');
  qryInfLiquidacion.SQL.Add(' order by empresa_ent, producto_ent, centro_ent,centro_origen_ent, cosechero_ent, ');
  qryInfLiquidacion.SQL.Add('          semana, categoria_ent ');

  qryInfLiquidacion.ParamByName('empresa').AsString:= AEmpresa;
  qryInfLiquidacion.ParamByName('fechaini').AsDateTime:= ADesde;
  qryInfLiquidacion.ParamByName('fechafin').AsDateTime:= AHasta;
  if ACentro <> '' then
    qryInfLiquidacion.ParamByName('centro').AsString:= ACentro;
  if AProducto <> '' then
    qryInfLiquidacion.ParamByName('producto').AsString:= AProducto;
end;

procedure TDMLiqProdLiquidacion.InformeLiquidacionResumen(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  bSemana:= False;
  SQLInformeLiquidacion(AEmpresa, ACentro, AProducto, ADesde, AHasta );
  if InformeLiquidacion( AEmpresa, ACentro, AProducto, ADesde, AHasta ) then
  begin
    kmtMes.SortFields:= 'codigo;keyMes';
    kmtMes.Sort([]);
    kmtMes.First;
    RellenarLiquidacion;
    kmtLiqCos.SortFields:= 'codigo;keyMes';
    kmtLiqCos.Sort([]);
    kmtLiqCos.First;
    LiqProdLiquidacionCosQR.Imprimir( ADesde, AHasta )
  end
  else
  begin
    ShowMessage('No hay productos a liquidar para los parametros seleccionados.');
  end;
end;

procedure TDMLiqProdLiquidacion.InformeLiquidacionCategoria(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  bSemana:= False;
  SQLInformeLiquidacion(AEmpresa, ACentro, AProducto, ADesde, AHasta );
  if InformeLiquidacion( AEmpresa, ACentro, AProducto, ADesde, AHasta ) then
  begin
    kmtMes.SortFields:= 'codigo;keyMes';
    kmtMes.Sort([]);
    kmtMes.First;
    LiqProdInfLiquidacionQR.Imprimir( ADesde, AHasta );
  end
  else
    ShowMessage('No hay productos a liquidar para los parametros seleccionados.');
end;

procedure TDMLiqProdLiquidacion.InformeLiquidacionSemanas(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  bSemana:= True;
  SQLInformeLiquidacion(AEmpresa, ACentro, AProducto, ADesde, AHasta );
  if InformeLiquidacion( AEmpresa, ACentro, AProducto, ADesde, AHasta ) then
  begin
    kmtMes.SortFields:= 'codigo;keyMes';
    kmtMes.Sort([]);
    kmtMes.First;
    LiqProdInfLiquidacionQR.Imprimir( ADesde, AHasta );
  end
  else
    ShowMessage('No hay productos a liquidar para los parametros seleccionados.');
end;

function TDMLiqProdLiquidacion.InformeLiquidacion(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime ): boolean;
begin
  qryInfLiquidacion.Open;
  try
    if not qryInfLiquidacion.IsEmpty then
    begin
      result:= True;
      sMes:= FormatDateTime('yyyymm', ADesde );
      dFechaIni:= ADesde;
      dFechaFin:= AHasta;
      dFEcha:= Now;
      sHora:= FormatDateTime('hh:nn', Now);
      RellenarTabla;
      kmtmes.First;
    end
    else
    begin
      result:= False;
    end;
  finally
    qryInfLiquidacion.Close;
  end;
end;

function TDMLiqProdLiquidacion.GetKey: string;
begin
  if bSemana then
    result:=  qryInfLiquidacion.fieldByName('empresa_ent').AsString + qryInfLiquidacion.fieldByName('centro_ent').AsString +
              qryInfLiquidacion.fieldByName('producto_ent').AsString + qryInfLiquidacion.fieldByName('centro_origen_ent').AsString +
              qryInfLiquidacion.fieldByName('cosechero_ent').AsString+
              qryInfLiquidacion.fieldByName('semana').AsString + qryInfLiquidacion.fieldByName('categoria_ent').AsString
  else
    result:=  qryInfLiquidacion.fieldByName('empresa_ent').AsString + qryInfLiquidacion.fieldByName('centro_ent').AsString +
              qryInfLiquidacion.fieldByName('producto_ent').AsString + qryInfLiquidacion.fieldByName('centro_origen_ent').AsString +
              qryInfLiquidacion.fieldByName('cosechero_ent').AsString+
              sMes + qryInfLiquidacion.fieldByName('categoria_ent').AsString;
end;

function TDMLiqProdLiquidacion.GetKeyLiq: string;
begin
  result:=  kmtMes.fieldByName('empresa').AsString + kmtMes.fieldByName('centro').AsString +
            kmtMes.fieldByName('producto').AsString + kmtMes.fieldByName('cosechero').AsString+
            kmtMes.fieldByName('anyomes').AsString;
end;

function TDMLiqProdLiquidacion.SetKey: string;
begin
  sEmpresa:= qryInfLiquidacion.fieldByName('empresa_ent').AsString;
  sCentro:= qryInfLiquidacion.fieldByName('centro_ent').AsString;
  sProducto:= qryInfLiquidacion.fieldByName('producto_ent').AsString;
  sOrigen:= qryInfLiquidacion.fieldByName('centro_origen_ent').AsString;
  sCosechero:= qryInfLiquidacion.fieldByName('cosechero_ent').AsString;
  sCategoria:= qryInfLiquidacion.fieldByName('categoria_ent').AsString;
  iCategoria:= qryInfLiquidacion.fieldByName('categoria_ent').AsInteger;
  sSemana:= qryInfLiquidacion.fieldByName('semana').AsString;
  if bSemana then
    result:=  sEmpresa + sCentro + sProducto + sOrigen + sCosechero+ sSemana + sCategoria
  else
    result:=  sEmpresa + sCentro + sProducto + sOrigen + sCosechero+ sMes + sCategoria;
end;


function TDMLiqProdLiquidacion.SetKeyLiq: string;
begin
  sEmpresa:= kmtMes.fieldByName('empresa').AsString;
  sCentro:= kmtMes.fieldByName('centro').AsString;
  sProducto:= kmtMes.fieldByName('producto').AsString;
  sOrigen:= kmtMes.fieldByName('origen').AsString;
  sCosechero:= kmtMes.fieldByName('cosechero').AsString;
  sMes:= kmtMes.fieldByName('anyomes').AsString;
  result:=  sEmpresa + sCentro + sProducto + sOrigen + sCosechero+ sMes;
end;


procedure TDMLiqProdLiquidacion.ReiniciarTabla;
begin
  if kmtMes.Active then
    kmtMes.Close;
  kmtMes.Open;

  if kmtLiqCos.Active then
    kmtLiqCos.Close;
  kmtLiqCos.Open;
end;

procedure TDMLiqProdLiquidacion.ReiniciarLiquidacion;
begin
  if kmtLiqCos.Active then
    kmtLiqCos.Close;
  kmtLiqCos.Open;
end;

procedure TDMLiqProdLiquidacion.NewValues;
begin
  rImporteBruto:= roundto( qryInfLiquidacion.fieldByName('kilos_fac').AsInteger * qryInfLiquidacion.fieldByName('precio_venta').AsFloat, -2);
  rImporteGastos:= roundto( qryInfLiquidacion.fieldByName('kilos_fac').AsInteger * qryInfLiquidacion.fieldByName('gastos').AsFloat, -2);;
  ikilos_ent:= qryInfLiquidacion.fieldByName('kilos_ent').AsInteger;
  ikilos_liq:= qryInfLiquidacion.fieldByName('kilos_liq').AsInteger;
  ikilos_fac:= qryInfLiquidacion.fieldByName('kilos_fac').AsInteger;
end;

procedure TDMLiqProdLiquidacion.NewValuesLiq;
begin
  rImporteLiquido:= kmtMes.fieldByName('importe_liquido').AsFloat;
  ikilos_ent:= kmtMes.fieldByName('kilos_ent').AsInteger;
  ikilos_liq:= kmtMes.fieldByName('kilos_liq').AsInteger;
  ikilos_fac:= kmtMes.fieldByName('kilos_fac').AsInteger;
end;

procedure TDMLiqProdLiquidacion.AddValues;
begin
  rImporteBruto:= rImporteBruto + roundto( qryInfLiquidacion.fieldByName('kilos_fac').AsInteger * qryInfLiquidacion.fieldByName('precio_venta').AsFloat, -2);
  rImporteGastos:= rImporteGastos + roundto( qryInfLiquidacion.fieldByName('kilos_fac').AsInteger * qryInfLiquidacion.fieldByName('gastos').AsFloat, -2);;
  ikilos_ent:= ikilos_ent + qryInfLiquidacion.fieldByName('kilos_ent').AsInteger;
  ikilos_liq:= ikilos_liq + qryInfLiquidacion.fieldByName('kilos_liq').AsInteger;
  ikilos_fac:= ikilos_fac + qryInfLiquidacion.fieldByName('kilos_fac').AsInteger;
end;

procedure TDMLiqProdLiquidacion.AddValuesLiq;
begin
  rImporteLiquido:= rImporteLiquido + kmtMes.fieldByName('importe_liquido').AsFloat;
  ikilos_ent:= ikilos_ent + kmtMes.fieldByName('kilos_ent').AsInteger;
  ikilos_liq:= ikilos_liq + kmtMes.fieldByName('kilos_liq').AsInteger;
  ikilos_fac:= ikilos_fac + kmtMes.fieldByName('kilos_fac').AsInteger;
end;

procedure TDMLiqProdLiquidacion.SaveValues;
var
  rAux: real;
begin
  kmtMes.Insert;

  kmtMes.FieldByName('codigo').AsInteger:= 1;
  kmtMes.FieldByName('keyMes').AsString:= sKey;
  kmtMes.FieldByName('empresa').AsString:= sEmpresa;
  kmtMes.FieldByName('centro').AsString:= sCentro;
  kmtMes.FieldByName('producto').AsString:= sProducto;
  kmtMes.FieldByName('cosechero').AsString:= sOrigen;
  kmtMes.FieldByName('cosechero').AsString:= sCosechero;
  if bSemana then
    kmtMes.FieldByName('anyomes').AsString:= sSemana
  else
    kmtMes.FieldByName('anyomes').AsString:= Smes;
  kmtMes.FieldByName('categoria').AsInteger:= iCategoria;

  kmtMes.FieldByName('fecha_ini').AsDateTime:= dFechaIni;
  kmtMes.FieldByName('fecha_fin').AsDateTime:= dFechaFin;
  kmtMes.FieldByName('fecha_calculo').AsDateTime:= dFEcha;
  kmtMes.FieldByName('hora_calculo').AsString:= sHora;

  kmtMes.FieldByName('kilos_ent').AsInteger:= ikilos_ent;
  kmtMes.FieldByName('kilos_liq').AsInteger:= ikilos_liq;
  kmtMes.FieldByName('kilos_fac').AsInteger:= ikilos_fac;

  if ikilos_liq > 0 then
  begin
    kmtMes.FieldByName('precio_venta').AsFloat:= bRoundTo ( rImporteBruto / ikilos_liq, -4);
    kmtMes.FieldByName('importe_venta').AsFloat:= rImporteBruto;//bRoundTo ( kmtMes.FieldByName('precio_venta').AsFloat * ikilos_liq, -2);

    kmtMes.FieldByName('precio_gastos').AsFloat:= bRoundTo ( rImporteGastos / ikilos_liq, -4);
    kmtMes.FieldByName('importe_gastos').AsFloat:= rImporteGastos;//bRoundTo ( kmtMes.FieldByName('precio_gastos').AsFloat * ikilos_liq, -2);

    rAux:= kmtMes.FieldByName('importe_venta').AsFloat - kmtMes.FieldByName('importe_gastos').AsFloat;
    kmtMes.FieldByName('precio_liquido').AsFloat:= bRoundTo ( rAux / ikilos_liq, -4);
    kmtMes.FieldByName('importe_liquido').AsFloat:= rAux;//bRoundTo ( kmtMes.FieldByName('precio_liquido').AsFloat * ikilos_liq, -2);
  end
  else
  begin
    kmtMes.FieldByName('precio_venta').AsFloat:= 0;
    kmtMes.FieldByName('precio_gastos').AsFloat:= 0;
    kmtMes.FieldByName('precio_liquido').AsFloat:= 0;
    kmtMes.FieldByName('importe_venta').AsFloat:= 0;
    kmtMes.FieldByName('importe_gastos').AsFloat:= 0;
    kmtMes.FieldByName('importe_liquido').AsFloat:= 0;
  end;
  kmtMes.Post;
end;

procedure TDMLiqProdLiquidacion.SaveValuesLiq;
var
  rAux: real;
begin
  kmtLiqCos.Insert;

  kmtLiqCos.FieldByName('codigo').AsInteger:= 1;
  kmtLiqCos.FieldByName('keyMes').AsString:= sKey;
  kmtLiqCos.FieldByName('empresa').AsString:= sEmpresa;
  kmtLiqCos.FieldByName('centro').AsString:= sCentro;
  kmtLiqCos.FieldByName('producto').AsString:= sProducto;
  kmtLiqCos.FieldByName('origen').AsString:= sOrigen;
  kmtLiqCos.FieldByName('cosechero').AsString:= sCosechero;
  kmtLiqCos.FieldByName('anyomes').AsString:= Smes;

  kmtLiqCos.FieldByName('fecha_ini').AsDateTime:= dFechaIni;
  kmtLiqCos.FieldByName('fecha_fin').AsDateTime:= dFechaFin;
  kmtLiqCos.FieldByName('fecha_calculo').AsDateTime:= dFEcha;
  kmtLiqCos.FieldByName('hora_calculo').AsString:= sHora;

  kmtLiqCos.FieldByName('kilos_ent').AsInteger:= ikilos_ent;
  kmtLiqCos.FieldByName('kilos_liq').AsInteger:= ikilos_liq;
  kmtLiqCos.FieldByName('kilos_fac').AsInteger:= ikilos_fac;

  if ikilos_fac > 0 then
  begin
    kmtLiqCos.FieldByName('precio_liquido').AsFloat:= bRoundTo ( rImporteLiquido / ikilos_fac, -4);
    kmtLiqCos.FieldByName('importe_liquido').AsFloat:= bRoundTo ( kmtLiqCos.FieldByName('precio_liquido').AsFloat * ikilos_fac, -2);

  end
  else
  begin
    kmtLiqCos.FieldByName('precio_liquido').AsFloat:= 0;
    kmtLiqCos.FieldByName('importe_liquido').AsFloat:= 0;
  end;
  kmtLiqCos.Post;
end;

procedure TDMLiqProdLiquidacion.RellenarTabla;
var
  sAux: string;
begin
  while ( qryInfLiquidacion.fieldByName('cosechero_ent').AsInteger <= 0 ) and
        ( not qryInfLiquidacion.Eof ) do
  begin
    qryInfLiquidacion.Next;
  end;

  if not qryInfLiquidacion.isempty then
  begin
    ReiniciarTabla;
    sKey:= SetKey;
    NewValues;
    qryInfLiquidacion.Next;

    while not qryInfLiquidacion.eof do
    begin
      //Ni transitos (-1) ni compras (0)
      if qryInfLiquidacion.fieldByName('cosechero_ent').AsInteger > 0 then
      begin
        sAux:= GetKey;
        if sAux = sKey then
        begin
          AddValues;
        end
        else
        begin
          SaveValues;
          sKey:= SetKey;
          NewValues;
        end;
      end;
      qryInfLiquidacion.Next;
    end;
    SaveValues;
  end;
end;

procedure TDMLiqProdLiquidacion.RellenarLiquidacion;
var
  sAux: string;
begin
  if not kmtMes.isempty then
  begin
    ReiniciarLiquidacion;
    sKey:= SetKeyLiq;
    NewValuesLiq;
    kmtMes.Next;

    while not kmtMes.eof do
    begin
      //Ni transitos (-1) ni compras (0)
      if kmtMes.fieldByName('cosechero').AsInteger > 0 then
      begin
        sAux:= GetKeyLiq;
        if sAux = sKey then
        begin
          AddValuesLiq;
        end
        else
        begin
          SaveValuesLiq;
          sKey:= SetKeyLiq;
          NewValuesLiq;
        end;
      end;
      kmtMes.Next;
    end;
  end;
  SaveValuesLiq;
end;

procedure TDMLiqProdLiquidacion.InformeLiquidacionPosei(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  bSemana:= False;
  SQLInformeLiquidacion(AEmpresa, ACentro, AProducto, ADesde, AHasta );
  if InformeLiquidacion( AEmpresa, ACentro, AProducto, ADesde, AHasta ) then
  begin
    kmtMes.SortFields:= 'codigo;keyMes';
    kmtMes.Sort([]);
    kmtMes.First;
    LiqProdInfLiquidacionQR.Imprimir( ADesde, AHasta );
  end
  else
    ShowMessage('No hay productos a liquidar para los parametros seleccionados.');
end;

end.
