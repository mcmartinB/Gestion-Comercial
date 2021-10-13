unit RiesgoDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLRiesgo = class(TDataModule)
    qryRiesgo: TQuery;
    kmtRiesgo: TkbmMemTable;
    qryCliente: TQuery;
    qryAlbaranado: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

    { Private declarations }
    sMsg, sRiesgos: string;
    sEmpresa: string;
    dFechaIni, dFechaFin: TDateTime;
    iDeficit, iDiasCobroPagares: Integer;
    bIva: Boolean;

    sPlanta: string;
    bAll: Boolean;

    sEmpresaFact, sFechaFact, sNumeroFact, sClienteFact: string;
    rPendienteFact, rCambioFact, rTotalFact, rNetoFact: Real;
    iDiasFact: Integer;

    procedure PutMessage( const AMsg: string );
    procedure ErrorRiesgos;
    procedure PreparaQuery( const AEmpresa, ACliente, APais, ATipoCliente, ANacional: string; const AExcluirTipoCli:boolean;  const AIni, AFin: TDateTime;
                            const AAbonos, AConRiesgo: Boolean );
    function  PreparaTablas: Boolean;
    procedure CerrarTablas;
    procedure AddFactura;
    procedure AddRegistro;
    procedure ModRegistro;
    procedure HayPendiente;
    procedure AddPendiente;
    procedure ClasificaRegistro( const ANew: Boolean );
    procedure NewOrExistent( const AOrigen, ADestino: string; const ANew: Boolean );
    procedure PMC( const ANew: Boolean );
    procedure DatosCliente;
    procedure CalculoDeficitPMC;
    function  HayNoActivos: Boolean;

    function  ImporteALbaranado( const ACliente: string ): Real;
    procedure QueryALbaranado( const AEmpresa: string; const AFechaIni, AFechaFin: TDateTime );
    function DiasTesoreriaCliente( const ACliente: string): integer;
  public

    { Public declarations }
    function GetMessage( var AMsg: string ): Boolean;
    function GetDatos( const AEmpresa, ACliente, APais, ATipoCliente, ANacional: string; const AExcluirTipoCli:boolean; const AIni, AFin: TDateTime;
                       const ADiasCobroPagare, ADeficit: integer; const AAbonos, AIva, AConRiesgo: Boolean ): boolean;
  end;

  function RiesgoExecute( const AOwner: TComponent; const AEmpresa, ACliente, APais, ATipoCliente, ANacional: string;
                       const AExcluirTipoCli: Boolean; const AIni, AFin: TDateTime; const ADiasCobroPagare, ADeficit: integer;
                       const AAbonos, AIva, AConRiesgo: Boolean; var VMsg: string ): boolean;

implementation

{$R *.dfm}

uses
  CGlobal, Dialogs, Math, bMath, RiesgoQL, BonnyQuery;

var
  DLRiesgo: TDLRiesgo;

function RiesgoExecute( const AOwner: TComponent; const AEmpresa, ACliente, APais, ATipoCliente, ANacional: string;
                       const AExcluirTipoCli: Boolean; const AIni, AFin: TDateTime; const ADiasCobroPagare, ADeficit: integer;
                       const AAbonos, AIva, AConRiesgo: Boolean; var VMsg: string ): boolean;
begin
  DLRiesgo:= TDLRiesgo.Create( AOwner );
  try
    if DLRiesgo.GetDatos( AEmpresa, ACliente, APais, ATipoCliente, ANacional, AExcluirTipoCli, AIni, AFin, ADiasCobroPagare, ADeficit, AAbonos, AIva, AConRiesgo ) then
    begin
      DLRiesgo.ErrorRiesgos;
      RiesgoQL.ExecuteReport( DLRiesgo, AEmpresa, APais, AIni );
      DLRiesgo.CerrarTablas;
      DLRiesgo.PutMessage('OK');
    end;
  finally
    Result:= DLRiesgo.GetMessage( VMsg );
    FreeAndNil( DLRiesgo );
  end;
end;

procedure  TDLRiesgo.ErrorRiesgos;
begin
  if sRiesgos <> '' then
    ShowMessage( 'Se utiliza el máximo.' + #13 + #10 + sRiesgos );
end;

function  TDLRiesgo.GetMessage( var AMsg: string ): Boolean;
begin
  Result:= ( sMsg = 'OK' );
  AMsg:= sMsg;
end;

procedure TDLRiesgo.PutMessage( const AMsg: string );
begin
  sMsg:= AMsg;
end;

procedure TDLRiesgo.DataModuleCreate(Sender: TObject);
begin
  sMsg:= '';
  sEmpresa:= '';
  sRiesgos:= '';
  iDeficit:= 10000;
  iDiasCobroPagares:= 2;

  with kmtRiesgo do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_cliente', ftString, 3, False);
    FieldDefs.Add('cliente', ftString, 30, False);

    FieldDefs.Add('cobrado_planta', ftFloat, 0, False);
    FieldDefs.Add('pagares_planta', ftFloat, 0, False);
    FieldDefs.Add('menos30_planta', ftFloat, 0, False);
    FieldDefs.Add('entre31y60_planta', ftFloat, 0, False);
    FieldDefs.Add('entre61y75_planta', ftFloat, 0, False);
    FieldDefs.Add('entre76y90_planta', ftFloat, 0, False);
    FieldDefs.Add('entre91y120_planta', ftFloat, 0, False);
    FieldDefs.Add('mas121_planta', ftFloat, 0, False);
    FieldDefs.Add('vencimiento_planta', ftFloat, 0, False);
    FieldDefs.Add('encurso_planta', ftFloat, 0, False);

    FieldDefs.Add('cobrado', ftFloat, 0, False);
    FieldDefs.Add('pagares', ftFloat, 0, False);
    FieldDefs.Add('menos30', ftFloat, 0, False);
    FieldDefs.Add('entre31y60', ftFloat, 0, False);
    FieldDefs.Add('entre61y75', ftFloat, 0, False);
    FieldDefs.Add('entre76y90', ftFloat, 0, False);
    FieldDefs.Add('entre91y120', ftFloat, 0, False);
    FieldDefs.Add('mas121', ftFloat, 0, False);
    FieldDefs.Add('vencimiento', ftFloat, 0, False);
    FieldDefs.Add('encurso', ftFloat, 0, False);

    FieldDefs.Add('riesgo_planta', ftFloat, 0, False);
    FieldDefs.Add('clasificacion_planta', ftFloat, 0, False);
    FieldDefs.Add('seguro_planta', ftInteger, 0, False);
    FieldDefs.Add('disponible_planta', ftFloat, 0, False);
    FieldDefs.Add('exceso_planta', ftFloat, 0, False);
    FieldDefs.Add('deficit_planta', ftFloat, 0, False);
    FieldDefs.Add('pmc_planta', ftFloat, 0, False);

    FieldDefs.Add('riesgo', ftFloat, 0, False);
    FieldDefs.Add('clasificacion', ftFloat, 0, False);
    FieldDefs.Add('seguro', ftInteger, 0, False);
    FieldDefs.Add('disponible', ftFloat, 0, False);
    FieldDefs.Add('exceso', ftFloat, 0, False);
    FieldDefs.Add('deficit', ftFloat, 0, False);
    FieldDefs.Add('pmc', ftFloat, 0, False);

    FieldDefs.Add('activo', ftInteger, 0, False);
    IndexFieldNames := 'cod_cliente';
    CreateTable;
  end;
end;

procedure TDLRiesgo.PreparaQuery( const AEmpresa, ACliente, APais, ATipoCliente, ANacional: string; const AExcluirTipoCli:boolean;  const AIni, AFin: TDateTime;
                                 const AAbonos, AConRiesgo: Boolean );
begin
  with qryRiesgo do
  begin
    SQL.Clear;

    SQL.Add('select cod_cliente_fc cod_cliente, cod_empresa_fac_fc empresa, ');
    SQL.Add('       case when tipo_factura_fc = 380 then ''F'' else ''A'' end tipo, ');
    SQL.Add('       case when tipo_impuesto_fc[1,1] = ''I'' then ''P'' else ''T'' end serie, ');
    SQL.Add('       fecha_factura_fc fecha_factura, ');
    SQL.Add('       n_factura_fc factura, ');

    SQL.Add('       importe_neto_fc neto, ');
    SQL.Add('       importe_total_fc total, ');
    SQL.Add('       case when importe_total_fc = 0 then 0 ');
    SQL.Add('            else round( importe_total_euros_fc / importe_total_fc, 5 ) end cambio, ');

    SQL.Add('       fecha_vencimiento_rc fecha_remesa, ');
    SQL.Add('       importe_cobrado_rf cobrado, ');


    SQL.Add('       case tipo_factura_fc when 380 then ');
    SQL.Add('            Today - fecha_fac_ini_fc      ');     // Factura
    SQL.Add('       else                               ');
    SQL.Add('             121                          ');     // Abono
    SQL.Add('       end dias_desde_factura,            ');
    SQL.Add('       Today - fecha_vencimiento_rc dias_desde_cobro, ');
    SQL.Add('       fecha_vencimiento_rc - fecha_factura_fc dias_cobro ');

    SQL.Add('from tfacturas_cab ');
    SQL.Add('     left join tremesas_fac on cod_factura_fc = cod_factura_rf ');
    SQL.Add('     left join tremesas_cab on empresa_remesa_rf = empresa_remesa_rc and n_remesa_rf = n_remesa_rc ');
    SQL.Add('     join frf_clientes on cod_cliente_fc = cliente_c ');

    SQL.Add('where fecha_factura_fc between :fechaini and :fechafin ');
    //SQL.Add('and n_remesa_rc <> 0 ');

    if AEmpresa <> '' then
    begin
      if AEmpresa = 'BAG' then
        SQL.Add('and (  cod_empresa_fac_fc[1,1] = ''F'' and cod_empresa_fac_fc <> ''F22'' )')
      else
      if AEmpresa = 'SAT' then
        SQL.Add('and (  cod_empresa_fac_fc in ( ''050'',''080'' ) )')
      else
        SQL.Add('and cod_empresa_fac_fc = :empresa ');
    end;


    if ACliente <> '' then
      SQL.Add('and cod_cliente_fc = :cliente ');
    if APais <> '' then
      SQL.Add('and ( select pais_c from frf_clientes where cliente_c = cod_cliente_fc ) = :pais ');
    if ATipoCliente <> '' then
    begin
      if AExcluirTipoCli then
        SQL.Add(' and tipo_cliente_c <> :tipocliente ')
      else
        SQL.Add(' and tipo_cliente_c = :tipocliente ');
    end;


    if AConRiesgo then
      SQL.Add('and ( select max_riesgo_cr max_riesgo_c from frf_clientes_rie where empresa_cr = cod_empresa_fac_fc and cliente_c = cod_cliente_fc  and fecha_fin_cr is null) is not null ');
    //ABONOS
    if not AAbonos then
       SQL.Add('and tipo_factura_fc <> 381  ');
    if ANacional <> 'T' then
      if ANacional = 'N' then     
        SQL.Add(' and pais_c = "ES" ')
      else
        SQL.Add(' and pais_c <> "ES" ');

    //IGNORAR ANULACIONES
//    SQL.Add('and nvl(anulacion_fc,0) <> 1 ');
    SQL.Add('order by cod_cliente, empresa, fecha_factura, factura ');

    ParamByName('fechaini').AsDateTime:= AIni;
    ParamByName('fechafin').AsDateTime:= AFin;
    if ( AEmpresa <> '' ) and ( AEmpresa <> 'BAG' ) and ( AEmpresa <> 'SAT' ) then
      ParamByName('empresa').AsString:= AEmpresa;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
    if APais <> '' then
      ParamByName('pais').AsString:= APais;
    if ATipoCliente <> '' then
      ParamByName('tipocliente').AsString:= ATipoCliente;
  end;
end;

procedure TDLRiesgo.CerrarTablas;
begin
  if kmtRiesgo.Active then
    kmtRiesgo.Close;
end;

function TDLRiesgo.HayNoActivos: Boolean;
begin
  kmtRiesgo.First;
  while not kmtRiesgo.Eof do
  begin
    if kmtRiesgo.FieldByName('activo').AsInteger = 1 then
      kmtRiesgo.Next
    else
      kmtRiesgo.Delete;
  end;
  kmtRiesgo.First;
  Result:= not kmtRiesgo.IsEmpty;
end;

function TDLRiesgo.PreparaTablas: Boolean;
begin
  qryRiesgo.Open;
  try
    if not qryRiesgo.IsEmpty then
    begin
      result:= True;
      kmtRiesgo.Open;
      while not qryRiesgo.Eof do
      begin
        AddFactura;
        qryRiesgo.Next;
        HayPendiente;
      end;
      if HayNoActivos then
      begin
        PutMessage('OK');
      end
      else
      begin
        Result:= False;
        PutMessage('Sin deuda para los parametros seleccionados.');
      end;
    end
    else
    begin
      Result:= False;
      PutMessage('Sin facturas para los parametros seleccionados.');
    end;
  finally
    qryRiesgo.Close;
  end;
end;

procedure TDLRiesgo.AddPendiente;
var
  rPendienteEuros: real;
  iDiasVencimiento: Integer;
begin
//  iDiasVencimiento:= 45;
  iDiasVencimiento := DiasTesoreriaCliente(kmtRiesgo.FieldByName('cod_cliente').AsString);

  //Cambio moneda
  rPendienteEuros:= bRoundTo( rPendienteFact * rCambioFact, 2);
  if not bIVa then
  begin
    if rTotalFact <> 0 then
      rPendienteEuros:= bRoundTo( ( rPendienteEuros * rNetoFact ) / rTotalFact, 2 );
  end;

  if ( bAll ) or  (sPlanta = sEmpresaFact ) then
  begin
    //No tiene remesa, pendiente
    if iDiasFact > iDiasVencimiento then
    begin
      kmtRiesgo.FieldByName('vencimiento_planta').AsFloat:=
        kmtRiesgo.FieldByName('vencimiento_planta').AsFloat +  rPendienteEuros;
    end;

    //No tiene remesa, pendiente
    if iDiasFact <= 30 then
    begin
      kmtRiesgo.FieldByName('menos30_planta').AsFloat:=
        kmtRiesgo.FieldByName('menos30_planta').AsFloat +  rPendienteEuros;
    end
    else
    if ( iDiasFact >= 31  ) and
       ( iDiasFact <= 60  ) then
    begin
      kmtRiesgo.FieldByName('entre31y60_planta').AsFloat:=
        kmtRiesgo.FieldByName('entre31y60_planta').AsFloat + rPendienteEuros;
    end
    else
    if ( iDiasFact >= 61  ) and
       ( iDiasFact <= 75  ) then
    begin
      kmtRiesgo.FieldByName('entre61y75_planta').AsFloat:=
        kmtRiesgo.FieldByName('entre61y75_planta').AsFloat + rPendienteEuros;
    end
    else
    if ( iDiasFact >= 76  ) and
       ( iDiasFact <= 90  ) then
    begin
      kmtRiesgo.FieldByName('entre76y90_planta').AsFloat:=
        kmtRiesgo.FieldByName('entre76y90_planta').AsFloat + rPendienteEuros;
    end
    else
    if ( iDiasFact >= 91  ) and
       ( iDiasFact <= 120  ) then
    begin
      kmtRiesgo.FieldByName('entre91y120_planta').AsFloat:=
        kmtRiesgo.FieldByName('entre91y120_planta').AsFloat + rPendienteEuros;
    end
    else
    begin
      kmtRiesgo.FieldByName('mas121_planta').AsFloat:=
        kmtRiesgo.FieldByName('mas121_planta').AsFloat + rPendienteEuros;
    end;

    kmtRiesgo.FieldByName('riesgo_planta').AsFloat:=
      kmtRiesgo.FieldByName('riesgo_planta').AsFloat + rPendienteEuros;
  end;

    //No tiene remesa, pendiente
  if iDiasFact > iDiasVencimiento then
  begin
    kmtRiesgo.FieldByName('vencimiento').AsFloat:=
      kmtRiesgo.FieldByName('vencimiento').AsFloat +  rPendienteEuros;
  end;


  //No tiene remesa, pendiente
  if iDiasFact <= 30 then
  begin
    kmtRiesgo.FieldByName('menos30').AsFloat:=
    kmtRiesgo.FieldByName('menos30').AsFloat +  rPendienteEuros;
  end
  else
  if ( iDiasFact >= 31  ) and
     ( iDiasFact <= 60  ) then
  begin
    kmtRiesgo.FieldByName('entre31y60').AsFloat:=
      kmtRiesgo.FieldByName('entre31y60').AsFloat + rPendienteEuros;
  end
  else
  if ( iDiasFact >= 61  ) and
     ( iDiasFact <= 75  ) then
  begin
    kmtRiesgo.FieldByName('entre61y75').AsFloat:=
      kmtRiesgo.FieldByName('entre61y75').AsFloat + rPendienteEuros;
  end
  else
  if ( iDiasFact >= 76  ) and
     ( iDiasFact <= 90  ) then
  begin
    kmtRiesgo.FieldByName('entre76y90').AsFloat:=
      kmtRiesgo.FieldByName('entre76y90').AsFloat + rPendienteEuros;
  end
  else
  if ( iDiasFact >= 91  ) and
     ( iDiasFact <= 120  ) then
  begin
    kmtRiesgo.FieldByName('entre91y120').AsFloat:=
      kmtRiesgo.FieldByName('entre91y120').AsFloat + rPendienteEuros;
  end
  else
  begin
    kmtRiesgo.FieldByName('mas121').AsFloat:=
      kmtRiesgo.FieldByName('mas121').AsFloat + rPendienteEuros;
  end;
  kmtRiesgo.FieldByName('riesgo').AsFloat:=
    kmtRiesgo.FieldByName('riesgo').AsFloat + rPendienteEuros;
end;

procedure TDLRiesgo.HayPendiente;
begin
  if ( ( sEmpresaFact <> qryRiesgo.fieldByName('empresa').AsString ) or
       ( sFechaFact <> qryRiesgo.fieldByName('fecha_factura').AsString ) or
       ( sNumeroFact <> qryRiesgo.fieldByName('factura').AsString ) or
       qryRiesgo.Eof ) and
     ( abs(rPendienteFact) >  0.015 ) then
  begin
    if kmtRiesgo.Locate('cod_cliente', sClienteFact, [] ) then
    begin
      kmtRiesgo.Edit;
      try
        if kmtRiesgo.fieldByName('activo').AsInteger = 0 then
        begin
          if ( sEmpresa = '' ) or
             ( sEmpresa = 'BAG' ) or
             ( sEmpresa = 'SAT' ) or
             ( sEmpresa = sEmpresaFact )  then
          begin
            kmtRiesgo.fieldByName('activo').AsInteger:= 1;
          end;
        end;
        AddPendiente;
        kmtRiesgo.Post;
      except
        kmtRiesgo.Cancel;
        raise;
      end;
    end;
  end;
end;

procedure TDLRiesgo.AddFactura;
begin
  if kmtRiesgo.Locate('cod_cliente', qryRiesgo.fieldByName('cod_cliente').AsString, [] ) then
  begin
    ModRegistro;
  end
  else
  begin
    AddRegistro;
  end;
end;

procedure TDLRiesgo.PMC( const ANew: Boolean );
begin
  if ANew then
    kmtRiesgo.FieldByName('pmc').AsFloat:=
      qryRiesgo.fieldByName('dias_cobro').AsFloat * Abs( qryRiesgo.fieldByName('cobrado').AsFloat )
  else
    kmtRiesgo.FieldByName('pmc').AsFloat:= kmtRiesgo.FieldByName('pmc').AsFloat +
      (qryRiesgo.fieldByName('dias_cobro').AsFloat * Abs( qryRiesgo.fieldByName('cobrado').AsFloat ) );
end;

procedure TDLRiesgo.NewOrExistent( const AOrigen, ADestino: string; const ANew: Boolean );
var
  rImporteAux: real;
begin
  //Cambio moneda
  rImporteAux:= bRoundTo( qryRiesgo.fieldByName(AOrigen).AsFloat * qryRiesgo.fieldByName('cambio').AsFloat, 2);
  //Quitar o no el iva
  if not bIVa then
  begin
    if rTotalFact <> 0 then
      rImporteAux:= bRoundTo( ( rImporteAux * qryRiesgo.fieldByName('neto').AsFloat ) / qryRiesgo.fieldByName('total').AsFloat, 2 );
  end;

  if ANew then
    kmtRiesgo.FieldByName(ADestino).AsFloat:= rImporteAux
  else
    kmtRiesgo.FieldByName(ADestino).AsFloat:= kmtRiesgo.FieldByName(ADestino).AsFloat + rImporteAux;

  if bAll or ( sPlanta = qryRiesgo.fieldByName('empresa').AsString )  then
  begin
    if kmtRiesgo.FindField( ADestino + '_planta' ) <> nil then
    begin
      if ANew then
        kmtRiesgo.FieldByName(ADestino+'_planta').AsFloat:= rImporteAux
      else
        kmtRiesgo.FieldByName(ADestino+'_planta').AsFloat:= kmtRiesgo.FieldByName(ADestino+'_planta').AsFloat + rImporteAux;
    end;
  end;
end;

procedure TDLRiesgo.ClasificaRegistro( const ANew: Boolean );
var
  iDiasVencimiento: Integer;
begin
//  iDiasVencimiento:= 45;
  iDiasVencimiento := DiasTesoreriaCliente(kmtRiesgo.Fieldbyname('cod_cliente').AsString);

  if kmtRiesgo.fieldByName('activo').AsInteger = 0 then
  begin
    if ( sEmpresa = '' ) or
       ( sEmpresa = 'BAG' ) or
       ( sEmpresa = 'SAT' ) or
       ( sEmpresa = qryRiesgo.fieldByName('empresa').AsString ) then
    begin
      kmtRiesgo.fieldByName('activo').AsInteger:= 1;
    end;
  end;

  if bRoundTo( qryRiesgo.fieldByName('cobrado').AsFloat, 2) <> 0 then
  begin
    if Abs( qryRiesgo.fieldByName('cobrado').AsFloat -
       qryRiesgo.fieldByName('total').AsFloat ) > 0.01 then
    begin
      if ( sEmpresaFact = qryRiesgo.fieldByName('empresa').AsString ) and
         ( sFechaFact = qryRiesgo.fieldByName('fecha_factura').AsString ) and
         ( sNumeroFact = qryRiesgo.fieldByName('factura').AsString ) then
      begin
        rPendienteFact:= bRoundTo( rPendienteFact - qryRiesgo.fieldByName('cobrado').AsFloat, 2);
      end
      else
      begin
        sEmpresaFact:= qryRiesgo.fieldByName('empresa').AsString;
        sFechaFact:= qryRiesgo.fieldByName('fecha_factura').AsString;
        sNumeroFact:= qryRiesgo.fieldByName('factura').AsString;
        sClienteFact:= qryRiesgo.fieldByName('cod_cliente').AsString;
        iDiasFact:= qryRiesgo.fieldByName('dias_desde_factura').AsInteger;
        rCambioFact:= qryRiesgo.fieldByName('cambio').AsFloat;
        rTotalFact:= qryRiesgo.fieldByName('total').AsFloat;
        rNetoFact:= qryRiesgo.fieldByName('neto').AsFloat;
        rPendienteFact:= bRoundTo( qryRiesgo.fieldByName('total').AsFloat -
                     qryRiesgo.fieldByName('cobrado').AsFloat, 2 );
      end;
    end
    else
    begin
      sEmpresaFact:= qryRiesgo.fieldByName('empresa').AsString;
      sFechaFact:= qryRiesgo.fieldByName('fecha_factura').AsString;
      sNumeroFact:= qryRiesgo.fieldByName('factura').AsString;
      sClienteFact:= qryRiesgo.fieldByName('cod_cliente').AsString;
      iDiasFact:= qryRiesgo.fieldByName('dias_desde_factura').AsInteger;
      rCambioFact:= qryRiesgo.fieldByName('cambio').AsFloat;
      rTotalFact:= qryRiesgo.fieldByName('total').AsFloat;
      rNetoFact:= qryRiesgo.fieldByName('neto').AsFloat;
      rPendienteFact:= 0;
    end;

    if qryRiesgo.fieldByName('dias_desde_cobro').AsInteger > iDiasCobroPagares then
    begin
      //Tiene remesa y ha sido cobrado
      NewOrExistent( 'cobrado', 'cobrado', ANew );
    end
    else
    begin
      //Tiene remesa y ha NO sido cobrado, tenemos un documento de pagare
      NewOrExistent( 'cobrado', 'pagares', ANew );
      NewOrExistent( 'cobrado', 'riesgo', ANew );
    end;
    PMC( ANew );
  end
  else
  begin
    sEmpresaFact:= qryRiesgo.fieldByName('empresa').AsString;
    sFechaFact:= qryRiesgo.fieldByName('fecha_factura').AsString;
    sNumeroFact:= qryRiesgo.fieldByName('factura').AsString;
    sClienteFact:= qryRiesgo.fieldByName('cod_cliente').AsString;
    iDiasFact:= qryRiesgo.fieldByName('dias_desde_factura').AsInteger;
    rCambioFact:= qryRiesgo.fieldByName('cambio').AsFloat;
    rTotalFact:= qryRiesgo.fieldByName('total').AsFloat;
    rNetoFact:= qryRiesgo.fieldByName('neto').AsFloat;
    rPendienteFact:= 0;


    //No tiene remesa, pendiente
    if (qryRiesgo.fieldByName('dias_desde_factura').AsInteger > iDiasVencimiento) then
//       (qryRiesgo.fieldByName('total').AsFloat < 0) then          // Abono
    begin
      NewOrExistent( 'total', 'vencimiento', ANew );
    end;

    //No tiene remesa, pendiente
    if qryRiesgo.fieldByName('dias_desde_factura').AsInteger <= 30 then
    begin
      NewOrExistent( 'total', 'menos30', ANew );
    end
    else
    if ( qryRiesgo.fieldByName('dias_desde_factura').AsInteger >= 31  ) and
       ( qryRiesgo.fieldByName('dias_desde_factura').AsInteger <= 60  ) then
    begin
      NewOrExistent( 'total', 'entre31y60', ANew );
    end
    else
    if ( qryRiesgo.fieldByName('dias_desde_factura').AsInteger >= 61  ) and
       ( qryRiesgo.fieldByName('dias_desde_factura').AsInteger <= 75  ) then
    begin
      NewOrExistent( 'total', 'entre61y75', ANew );
    end
    else
    if ( qryRiesgo.fieldByName('dias_desde_factura').AsInteger >= 76  ) and
       ( qryRiesgo.fieldByName('dias_desde_factura').AsInteger <= 90  ) then
    begin
      NewOrExistent( 'total', 'entre76y90', ANew );
    end
    else
    if ( qryRiesgo.fieldByName('dias_desde_factura').AsInteger >= 91  ) and
       ( qryRiesgo.fieldByName('dias_desde_factura').AsInteger <= 120  ) then
    begin
      NewOrExistent( 'total', 'entre91y120', ANew );
    end
    else
    // mas de 120 dias
    begin
      NewOrExistent( 'total', 'mas121', ANew );
    end;
    NewOrExistent( 'total', 'riesgo', ANew );
  end;
end;


procedure TDLRiesgo.AddRegistro;
begin
  kmtRiesgo.Insert;
  try
    DatosCliente;
    ClasificaRegistro( True );
    kmtRiesgo.Post;
  except
    kmtRiesgo.Cancel;
    raise;
  end;
end;

procedure TDLRiesgo.ModRegistro;
begin
  kmtRiesgo.Edit;
  try
    ClasificaRegistro( False );
    kmtRiesgo.Post;
  except
    kmtRiesgo.Cancel;
    raise;
  end;
end;

procedure TDLRiesgo.DatosCliente;
begin
  (*TODO*)
  (*Separar riesgo/seguro del grupo/planta*)

  kmtRiesgo.FieldByName('cod_cliente').AsString:= qryRiesgo.FieldByName('cod_cliente').AsString;
  kmtRiesgo.FieldByName('activo').AsInteger:= 0;

  with qryCliente do
  begin
    SQL.Clear;
    SQL.Add('select nombre_c, max(max_riesgo_cr) max_riesgo_c, ');
    SQL.Add('       max(seguro_cr) seguro_c, count( distinct max_riesgo_cr ) riesgos ');
    SQL.Add('from frf_clientes, outer(frf_clientes_rie) ');
    SQL.Add('where cliente_c = :cliente ');
    SQL.Add(' and empresa_cr = :empresa ');
    SQL.Add(' and cliente_cr = cliente_c ');
    SQL.Add(' and fecha_fin_cr is null ');

    SQL.Add('group by 1 ');

    ParamByName('empresa').AsString:= qryRiesgo.FieldByName('empresa').AsString;
    ParamByName('cliente').AsString:= qryRiesgo.FieldByName('cod_cliente').AsString;

    qryCliente.Open;
    kmtRiesgo.FieldByName('cliente').AsString:= qryCliente.FieldByName('nombre_c').AsString;

    kmtRiesgo.FieldByName('clasificacion').AsFloat:= qryCliente.FieldByName('max_riesgo_c').AsFloat;
    kmtRiesgo.FieldByName('clasificacion_planta').AsFloat:= qryCliente.FieldByName('max_riesgo_c').AsFloat;
    kmtRiesgo.FieldByName('seguro').AsInteger:= qryCliente.FieldByName('seguro_c').AsInteger;
    kmtRiesgo.FieldByName('seguro_planta').AsInteger:= qryCliente.FieldByName('seguro_c').AsInteger;

    if qryCliente.FieldByName('riesgos').AsInteger > 1 then
    begin
      if sRiesgos = '' then
        sRiesgos:= 'El cliente "' + qryRiesgo.FieldByName('cod_cliente').AsString + '" ' +
                  qryCliente.FieldByName('nombre_c').AsString + ' tiene diferentes riesgos grabados en las empresas que le sirven.'
      else
        sRiesgos:= sRiesgos + #13 + #10 + 'El cliente "' + qryRiesgo.FieldByName('cod_cliente').AsString + '" ' +
                  qryCliente.FieldByName('nombre_c').AsString + ' tiene diferentes riesgos grabados en las empresas que le sirven.';
    end;
    Close;
  end;
end;

function TDLRiesgo.DiasTesoreriaCliente(const ACliente: string): integer;
var qryAux: TBonnyQuery;
begin
 qryAux := TBonnyQuery.Create(Self);
  with qryAux do
  try
    SQL.Add(' select nvl(max(dias_tesoreria_ct), 0) tesoreria from frf_clientes, frf_clientes_tes ');
    SQL.Add(' where cliente_c = :cliente ');
    SQL.Add('   and cliente_ct = cliente_c ');

    ParamByName('cliente').AsString := ACliente;

    Open;
    result:= FieldByName('tesoreria').AsInteger;
    Close;
  finally
    free;
  end;
end;

function TDLRiesgo.ImporteALbaranado( const ACliente: string ): Real;
begin
  with qryAlbaranado do
  begin
    qryAlbaranado.ParamByName('cliente').AsString:= ACliente;
    Open;
    result:= FieldByName('riesgo_en_curso').AsFloat;
    Close;
  end;
end;

procedure TDLRiesgo.QueryALbaranado( const AEmpresa: string; const AFechaIni, AFechaFin: TDateTime );
begin
  with qryAlbaranado do
  begin
    SQL.Clear;
    SQL.Add(' select sum(importe_neto_sl) riesgo_en_curso ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where empresa_sc = empresa_sl ');
    SQL.Add(' and centro_salida_sc = centro_salida_sl ');
    SQL.Add(' and n_albaran_sc = n_albaran_sl ');
    SQL.Add(' and fecha_sc = fecha_sl ');

    if AEmpresa = 'BAG' then
    begin
      SQL.Add('and (  empresa_sc[1,1] = ''F'' and empresa_sc <> ''F22'' )');
    end
    else
    if AEmpresa = 'SAT' then
    begin
      SQL.Add('and (  empresa_sc in ( ''050'',''080'' ) )');
    end
    else
    if AEmpresa <> '' then
    begin
      SQL.Add('and (  empresa_sc = :empresa )');
    end;

    SQL.Add(' and cliente_sal_sc = :cliente ');
    SQL.Add(' and fecha_sc between :fechaini and :fechafin ');
    SQL.Add(' and fecha_factura_sc is null ');
  end;

  if ( AEmpresa <> 'BAG'  ) and ( AEmpresa <> 'SAT'  ) and  ( AEmpresa <> ''  )then
  begin
    qryAlbaranado.ParamByName('empresa').AsString:= AEmpresa;
  end;
  qryAlbaranado.ParamByName('fechaini').AsDateTime:= AFechaIni;
  qryAlbaranado.ParamByName('fechafin').AsDateTime:= AFechaFin;
end;

procedure TDLRiesgo.CalculoDeficitPMC;
begin
  //Añadir albaranes valorados
  if kmtRiesgo.active then
  with kmtRiesgo do
  begin
    QueryALbaranado( sEmpresa, dFechaIni, dFechaFin );
    First;
    while not Eof do
    begin
      if FieldByName('riesgo').AsFloat = 0 then
      begin
        Delete;
      end
      else
      begin
        Edit;
        (*TODO*) //NO es correcto
        FieldByName('encurso').AsFloat:= ImporteALbaranado( FieldByName('cod_cliente').AsString );
        FieldByName('encurso_planta').AsFloat:= FieldByName('encurso').AsFloat;

        FieldByName('deficit').AsFloat:= FieldByName('clasificacion').AsFloat - ( FieldByName('riesgo').AsFloat + FieldByName('encurso').AsFloat );
        FieldByName('deficit_planta').AsFloat:= FieldByName('clasificacion_planta').AsFloat - ( FieldByName('riesgo_planta').AsFloat + FieldByName('encurso_planta').AsFloat );

        if FieldByName('deficit').AsFloat < 0 then
        begin
          FieldByName('exceso').AsFloat:= Abs(FieldByName('deficit').AsFloat);
          FieldByName('disponible').AsFloat:= 0;
        end
        else
        begin
          FieldByName('exceso').AsFloat:= 0;
          FieldByName('disponible').AsFloat:= FieldByName('deficit').AsFloat;
        end;
        if FieldByName('deficit').AsFloat >= iDeficit then
          FieldByName('deficit').AsFloat:= 0;

        if FieldByName('deficit_planta').AsFloat < 0 then
        begin
          FieldByName('exceso_planta').AsFloat:= Abs(FieldByName('deficit_planta').AsFloat);
          FieldByName('disponible_planta').AsFloat:= 0;
        end
        else
        begin
          FieldByName('exceso_planta').AsFloat:= 0;
          FieldByName('disponible_planta').AsFloat:= FieldByName('deficit_planta').AsFloat;
        end;
        if FieldByName('deficit_planta').AsFloat >= iDeficit then
          FieldByName('deficit_planta').AsFloat:= 0;


        if FieldByName('cobrado').AsFloat + FieldByName('pagares').AsFloat <> 0  then
          FieldByName('pmc').AsFloat:= Ceil( FieldByName('pmc').AsFloat /
                                           ( FieldByName('cobrado').AsFloat + FieldByName('pagares').AsFloat ) )
        else
          FieldByName('pmc').AsFloat:= 0;
        Post;
        Next;
      end;
    end;
    First;
  end;
end;

function TDLRiesgo.GetDatos( const AEmpresa, ACliente, APais, ATipoCliente, ANacional: string; const AExcluirTipoCli: boolean;  const AIni, AFin: TDateTime;
                            const ADiasCobroPagare, ADeficit: integer; const AAbonos, AIva, AConRiesgo: Boolean ): boolean;
begin
  if ( AEmpresa = '' ) or ( AEmpresa = 'BAG' ) or ( AEmpresa = 'SAT' ) then
  begin
    bAll:= True;
    sPlanta:= ''
  end
  else
  begin
    bAll:= False;
    sPlanta:= AEmpresa;
  end;

  sEmpresa:= AEmpresa;
  iDeficit:= ADeficit;
  iDiasCobroPagares:= ADiasCobroPagare;
  bIva:= AIva;
  dFechaIni:= AIni;
  dFechaFin:= AFin;

  PreparaQuery( AEmpresa, ACliente, APais, ATipoCliente, ANacional, AExcluirTipoCli, AIni, AFin, AAbonos, AConRiesgo );
  Result:= PreparaTablas;
  CalculoDeficitPMC;
  if Result then
  begin
    (*TODO*)
    //kmtRiesgo.SortFields := 'cliente';
    kmtRiesgo.SortFields:= 'cod_cliente';
    kmtRiesgo.Sort([]);
  end;
end;

end.
