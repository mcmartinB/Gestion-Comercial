unit AgingDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLAging = class(TDataModule)
    qryAging: TQuery;
    kmtAging: TkbmMemTable;
    qryCliente: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

    { Private declarations }
    sMsg, sRiesgos: string;
    sEmpresa: string;
    iDeficit, iDiasCobroPagares: Integer;
    bIva: Boolean;

    sPlanta: string;
    bAll: Boolean;

    sEmpresaFact, sFechaFact, sNumeroFact, sClienteFact: string;
    rPendienteFact, rCambioFact, rTotalFact, rNetoFact: Real;
    iDiasFact: Integer;
    bSoloRiesgo: Boolean;

    procedure PutMessage( const AMsg: string );
    procedure ErrorRiesgos;
    procedure PreparaQuery( const AEmpresa, ACliente: string; const AIni, AFin: TDateTime;
                            const AAbonos: Boolean );
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

  public

    { Public declarations }
    function GetMessage( var AMsg: string ): Boolean;
    function GetDatos( const AEmpresa, ACliente: string; const AIni, AFin: TDateTime;
                       const ADiasCobroPagare, ADeficit: integer; const AAbonos, AIva: Boolean ): boolean;
  end;

  function AgingExecute( const AOwner: TComponent; const AEmpresa, ACliente: string;
                         const AIni, AFin: TDateTime; const ADiasCobroPagare, ADeficit: integer;
                         const AAbonos, AIva, ASoloRiesgo: Boolean; var VMsg: string  ): boolean;

implementation

{$R *.dfm}

uses
  AgingQL, CGlobal, Dialogs, Math, bMath;

var
  DLAging: TDLAging;

function AgingExecute( const AOwner: TComponent; const AEmpresa, ACliente: string;
                       const AIni, AFin: TDateTime; const ADiasCobroPagare, ADeficit: integer;
                       const AAbonos, AIva, ASoloRiesgo: Boolean; var VMsg: string ): boolean;
begin
  DLAging:= TDLAging.Create( AOwner );
  try
    DLAging.bSoloRiesgo:= ASoloRiesgo;
    if DLAging.GetDatos( AEmpresa, ACliente, AIni, AFin, ADiasCobroPagare, ADeficit, AAbonos, AIva ) then
    begin
      DLAging.ErrorRiesgos;
      AgingQL.AgingView( DLAging, AEmpresa, FormatDateTime('dd/mm/yyyy', AIni ), FormatDateTime('dd/mm/yyyy', AFin ),
                         IntToStr( ADiasCobroPagare ), IntToStr( ADeficit ) );
      DLAging.CerrarTablas;
      DLAging.PutMessage('OK');
    end;
  finally
    Result:= DLAging.GetMessage( VMsg );
    FreeAndNil( DLAging );
  end;
end;

procedure  TDLAging.ErrorRiesgos;
begin
  if sRiesgos <> '' then
    ShowMessage( 'Se utiliza el máximo.' + #13 + #10 + sRiesgos );
end;

function  TDLAging.GetMessage( var AMsg: string ): Boolean;
begin
  Result:= ( sMsg = 'OK' );
  AMsg:= sMsg;
end;

procedure TDLAging.PutMessage( const AMsg: string );
begin
  sMsg:= AMsg;
end;

procedure TDLAging.DataModuleCreate(Sender: TObject);
begin
  sMsg:= '';
  sEmpresa:= '';
  sRiesgos:= '';
  iDeficit:= 10000;
  iDiasCobroPagares:= 0;

  with kmtAging do
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

    FieldDefs.Add('cobrado', ftFloat, 0, False);
    FieldDefs.Add('pagares', ftFloat, 0, False);
    FieldDefs.Add('menos30', ftFloat, 0, False);
    FieldDefs.Add('entre31y60', ftFloat, 0, False);
    FieldDefs.Add('entre61y75', ftFloat, 0, False);
    FieldDefs.Add('entre76y90', ftFloat, 0, False);
    FieldDefs.Add('entre91y120', ftFloat, 0, False);
    FieldDefs.Add('mas121', ftFloat, 0, False);


    FieldDefs.Add('riesgo', ftFloat, 0, False);
    FieldDefs.Add('clasificacion', ftFloat, 0, False);
    FieldDefs.Add('deficit', ftFloat, 0, False);
    FieldDefs.Add('pmc', ftFloat, 0, False);
    FieldDefs.Add('activo', ftInteger, 0, False);
    IndexFieldNames := 'cod_cliente';
    CreateTable;
  end;
end;

procedure TDLAging.PreparaQuery( const AEmpresa, ACliente: string; const AIni, AFin: TDateTime;
                                 const AAbonos: Boolean );
begin
  with qryAging do
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

    SQL.Add('       Today - fecha_factura_fc dias_desde_factura, ');
    SQL.Add('       Today - fecha_vencimiento_rc dias_desde_cobro, ');
    SQL.Add('       fecha_vencimiento_rc - fecha_factura_fc dias_cobro ');

    SQL.Add('from tfacturas_cab ');
    SQL.Add('     left join tremesas_fac on cod_factura_fc = cod_factura_rf ');
    SQL.Add('     left join tremesas_cab on empresa_remesa_rf = empresa_remesa_rc and n_remesa_rf = n_remesa_rc ');

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
    //ABONOS
    if not AAbonos then
       SQL.Add('and tipo_factura_fc <> 381  ');
    //IGNORAR ANULACIONES
    SQL.Add('and nvl(anulacion_fc,0) <> 1 ');
    SQL.Add('order by cod_cliente_fc, empresa, fecha_factura, factura ');

(*
    SQL.Add('select ');
    SQL.Add('       cliente_fac_f cod_cliente, empresa_f empresa, ');
    SQL.Add('       case when tipo_factura_f = 380 then ''F'' else ''A'' end tipo, ');
    SQL.Add('       case when tipo_impuesto_f[1,1] = ''I'' then ''P'' else ''T'' end serie, ');
    SQL.Add('       fecha_factura_f fecha_factura, ');
    SQL.Add('       n_factura_f factura, ');

    SQL.Add('       importe_neto_f neto, ');
    SQL.Add('       importe_total_f total, ');

    SQL.Add('       case when importe_total_f = 0 then 0 ');
    SQL.Add('            else round( importe_euros_f / importe_total_f, 5 ) end cambio, ');

    SQL.Add('       fecha_remesa_fr fecha_remesa, ');
    SQL.Add('       importe_cobrado_fr cobrado, ');

    SQL.Add('       Today - fecha_factura_f dias_desde_factura, ');
    SQL.Add('       Today - fecha_remesa_fr dias_desde_cobro, ');
    SQL.Add('       fecha_remesa_fr - fecha_factura_f dias_cobro ');


    SQL.Add('from frf_facturas fac left join frf_facturas_remesa on ');
    if CGlobal.gProgramVersion = pvBAG then
      SQL.Add('     ( planta_fr = empresa_f and factura_fr = n_factura_f and fecha_factura_fr = fecha_factura_f ) ')
    else
      SQL.Add('     ( empresa_fr = empresa_f and factura_fr = n_factura_f and fecha_factura_fr = fecha_factura_f ) ');
    SQL.Add('where fecha_factura_f between :fechaini and :fechafin ');
    if AEmpresa <> '' then
    begin
      if AEmpresa = 'BAG' then
        SQL.Add('and (  empresa_f[1,1] = ''F'' and empresa_f <> ''F22'' )')
      else
      if AEmpresa = 'SAT' then
        SQL.Add('and (  empresa_f in ( ''050'',''080'' ) )')
      else
        SQL.Add('and exists (select * from frf_facturas fac_aux where fac_aux.empresa_f = :empresa and fac_aux.cliente_fac_f = fac.cliente_fac_f ) ');
        //SQL.Add('and exists (select * from frf_clientes where empresa_c = :empresa and cliente_c = cliente_fac_f ) ');
        //SQL.Add('and empresa_f = :empresa ');
    end;

    if ACliente <> '' then
      SQL.Add('and cliente_fac_f = :cliente ');
    //ABONOS
    //SQL.Add('and tipo_factura_f = 381  ');
    if not AAbonos then
       SQL.Add('and tipo_factura_f <> 381  ');
    //FACTURAS
    //SQL.Add('and tipo_factura_f = 380  ');
    //MANUAL
    //SQL.Add('and concepto_f = 'M' ');
    //AUTOMATICA
    //SQL.Add('and concepto_f = 'A' ');
    //IGNORAR ANULACIONES
    SQL.Add('and nvl(anulacion_f,0) <> 1 ');
    SQL.Add('order by cliente_fac_f, empresa_f, fecha_factura_f, n_factura_f ');
*)
    ParamByName('fechaini').AsDateTime:= AIni;
    ParamByName('fechafin').AsDateTime:= AFin;
    if ( AEmpresa <> '' ) and ( AEmpresa <> 'BAG' ) and ( AEmpresa <> 'SAT' ) then
      ParamByName('empresa').AsString:= AEmpresa;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
  end;
end;

procedure TDLAging.CerrarTablas;
begin
  if kmtAging.Active then
    kmtAging.Close;
end;

function TDLAging.HayNoActivos: Boolean;
begin
  kmtAging.First;
  while not kmtAging.Eof do
  begin
    if kmtAging.FieldByName('activo').AsInteger = 1 then
      kmtAging.Next
    else
      kmtAging.Delete;
  end;
  kmtAging.First;
  Result:= not kmtAging.IsEmpty;
end;

function TDLAging.PreparaTablas: Boolean;
begin
  qryAging.Open;
  try
    if not qryAging.IsEmpty then
    begin
      result:= True;
      kmtAging.Open;
      while not qryAging.Eof do
      begin
        AddFactura;
        qryAging.Next;
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
    qryAging.Close;
  end;
end;

procedure TDLAging.AddPendiente;
var
  rPendienteEuros: real;
begin
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
    if iDiasFact <= 30 then
    begin
      kmtAging.FieldByName('menos30_planta').AsFloat:=
        kmtAging.FieldByName('menos30_planta').AsFloat +  rPendienteEuros;
    end
    else
    if ( iDiasFact >= 31  ) and
       ( iDiasFact <= 60  ) then
    begin
      kmtAging.FieldByName('entre31y60_planta').AsFloat:=
        kmtAging.FieldByName('entre31y60_planta').AsFloat + rPendienteEuros;
    end
    else
    if ( iDiasFact >= 61  ) and
       ( iDiasFact <= 75  ) then
    begin
      kmtAging.FieldByName('entre61y75_planta').AsFloat:=
        kmtAging.FieldByName('entre61y75_planta').AsFloat + rPendienteEuros;
    end
    else
    if ( iDiasFact >= 76  ) and
       ( iDiasFact <= 90  ) then
    begin
      kmtAging.FieldByName('entre76y90_planta').AsFloat:=
        kmtAging.FieldByName('entre76y90_planta').AsFloat + rPendienteEuros;
    end
    else
    if ( iDiasFact >= 91  ) and
       ( iDiasFact <= 120  ) then
    begin
      kmtAging.FieldByName('entre91y120_planta').AsFloat:=
        kmtAging.FieldByName('entre91y120_planta').AsFloat + rPendienteEuros;
    end
    else
    begin
      kmtAging.FieldByName('mas121_planta').AsFloat:=
        kmtAging.FieldByName('mas121_planta').AsFloat + rPendienteEuros;
    end;
  end;


  //No tiene remesa, pendiente
  if iDiasFact <= 30 then
  begin
    kmtAging.FieldByName('menos30').AsFloat:=
    kmtAging.FieldByName('menos30').AsFloat +  rPendienteEuros;
  end
  else
  if ( iDiasFact >= 31  ) and
     ( iDiasFact <= 60  ) then
  begin
    kmtAging.FieldByName('entre31y60').AsFloat:=
      kmtAging.FieldByName('entre31y60').AsFloat + rPendienteEuros;
  end
  else
  if ( iDiasFact >= 61  ) and
     ( iDiasFact <= 75  ) then
  begin
    kmtAging.FieldByName('entre61y75').AsFloat:=
      kmtAging.FieldByName('entre61y75').AsFloat + rPendienteEuros;
  end
  else
  if ( iDiasFact >= 76  ) and
     ( iDiasFact <= 90  ) then
  begin
    kmtAging.FieldByName('entre76y90').AsFloat:=
      kmtAging.FieldByName('entre76y90').AsFloat + rPendienteEuros;
  end
  else
  if ( iDiasFact >= 91  ) and
     ( iDiasFact <= 120  ) then
  begin
    kmtAging.FieldByName('entre91y120').AsFloat:=
      kmtAging.FieldByName('entre91y120').AsFloat + rPendienteEuros;
  end
  else
  begin
    kmtAging.FieldByName('mas121').AsFloat:=
      kmtAging.FieldByName('mas121').AsFloat + rPendienteEuros;
  end;
  kmtAging.FieldByName('riesgo').AsFloat:=
    kmtAging.FieldByName('riesgo').AsFloat + rPendienteEuros;
end;

procedure TDLAging.HayPendiente;
begin
  if ( ( sEmpresaFact <> qryAging.fieldByName('empresa').AsString ) or
       ( sFechaFact <> qryAging.fieldByName('fecha_factura').AsString ) or
       ( sNumeroFact <> qryAging.fieldByName('factura').AsString ) or
       qryAging.Eof ) and
     ( abs(rPendienteFact) >  0.015 ) then
  begin
    if kmtAging.Locate('cod_cliente', sClienteFact, [] ) then
    begin
      kmtAging.Edit;
      try
        if kmtAging.fieldByName('activo').AsInteger = 0 then
        begin
          if ( sEmpresa = '' ) or
             ( sEmpresa = 'BAG' ) or
             ( sEmpresa = 'SAT' ) or
             ( sEmpresa = sEmpresaFact )  then
          begin
            kmtAging.fieldByName('activo').AsInteger:= 1;
          end;
        end;
        AddPendiente;
        kmtAging.Post;
      except
        kmtAging.Cancel;
        raise;
      end;
    end;
  end;
end;

procedure TDLAging.AddFactura;
begin
  if kmtAging.Locate('cod_cliente', qryAging.fieldByName('cod_cliente').AsString, [] ) then
  begin
    ModRegistro;
  end
  else
  begin
    AddRegistro;
  end;
end;

procedure TDLAging.PMC( const ANew: Boolean );
begin
  if ANew then
    kmtAging.FieldByName('pmc').AsFloat:=
      qryAging.fieldByName('dias_cobro').AsFloat * Abs( qryAging.fieldByName('cobrado').AsFloat )
  else
    kmtAging.FieldByName('pmc').AsFloat:= kmtAging.FieldByName('pmc').AsFloat +
      (qryAging.fieldByName('dias_cobro').AsFloat * Abs( qryAging.fieldByName('cobrado').AsFloat ) );
end;

procedure TDLAging.NewOrExistent( const AOrigen, ADestino: string; const ANew: Boolean );
var
  rImporteAux: real;
begin
  //Cambio moneda
  rImporteAux:= bRoundTo( qryAging.fieldByName(AOrigen).AsFloat * qryAging.fieldByName('cambio').AsFloat, 2);
  //Quitar o no el iva
  if not bIVa then
  begin
    if rTotalFact <> 0 then
      rImporteAux:= bRoundTo( ( rImporteAux * qryAging.fieldByName('neto').AsFloat ) / qryAging.fieldByName('total').AsFloat, 2 );
  end;

  if ANew then
    kmtAging.FieldByName(ADestino).AsFloat:= rImporteAux
  else
    kmtAging.FieldByName(ADestino).AsFloat:= kmtAging.FieldByName(ADestino).AsFloat + rImporteAux;

  if bAll or ( sPlanta = qryAging.fieldByName('empresa').AsString )  then
  begin
    if kmtAging.FindField( ADestino + '_planta' ) <> nil then
    begin
      if ANew then
        kmtAging.FieldByName(ADestino+'_planta').AsFloat:= rImporteAux
      else
        kmtAging.FieldByName(ADestino+'_planta').AsFloat:= kmtAging.FieldByName(ADestino+'_planta').AsFloat + rImporteAux;
    end;
  end;
end;

procedure TDLAging.ClasificaRegistro( const ANew: Boolean );
begin
  if kmtAging.fieldByName('activo').AsInteger = 0 then
  begin
    if ( sEmpresa = '' ) or
       ( sEmpresa = 'BAG' ) or
       ( sEmpresa = 'SAT' ) or
       ( sEmpresa = qryAging.fieldByName('empresa').AsString ) then
    begin
      kmtAging.fieldByName('activo').AsInteger:= 1;
    end;
  end;

  if bRoundTo( qryAging.fieldByName('cobrado').AsFloat, 2) <> 0 then
  begin
    if Abs( qryAging.fieldByName('cobrado').AsFloat -
       qryAging.fieldByName('total').AsFloat ) > 0.01 then
    begin
      if ( sEmpresaFact = qryAging.fieldByName('empresa').AsString ) and
         ( sFechaFact = qryAging.fieldByName('fecha_factura').AsString ) and
         ( sNumeroFact = qryAging.fieldByName('factura').AsString ) then
      begin
        rPendienteFact:= bRoundTo( rPendienteFact - qryAging.fieldByName('cobrado').AsFloat, 2);
      end
      else
      begin
        sEmpresaFact:= qryAging.fieldByName('empresa').AsString;
        sFechaFact:= qryAging.fieldByName('fecha_factura').AsString;
        sNumeroFact:= qryAging.fieldByName('factura').AsString;
        sClienteFact:= qryAging.fieldByName('cod_cliente').AsString;
        iDiasFact:= qryAging.fieldByName('dias_desde_factura').AsInteger;
        rCambioFact:= qryAging.fieldByName('cambio').AsInteger;
        rTotalFact:= qryAging.fieldByName('total').AsInteger;
        rNetoFact:= qryAging.fieldByName('neto').AsInteger;
        rPendienteFact:= bRoundTo( qryAging.fieldByName('total').AsFloat -
                     qryAging.fieldByName('cobrado').AsFloat, 2 );
      end;
    end
    else
    begin
      sEmpresaFact:= qryAging.fieldByName('empresa').AsString;
      sFechaFact:= qryAging.fieldByName('fecha_factura').AsString;
      sNumeroFact:= qryAging.fieldByName('factura').AsString;
      sClienteFact:= qryAging.fieldByName('cod_cliente').AsString;
      iDiasFact:= qryAging.fieldByName('dias_desde_factura').AsInteger;
      rCambioFact:= qryAging.fieldByName('cambio').AsInteger;
      rTotalFact:= qryAging.fieldByName('total').AsInteger;
      rNetoFact:= qryAging.fieldByName('neto').AsInteger;
      rPendienteFact:= 0;
    end;

    if qryAging.fieldByName('dias_desde_cobro').AsInteger >= iDiasCobroPagares then
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
    sEmpresaFact:= qryAging.fieldByName('empresa').AsString;
    sFechaFact:= qryAging.fieldByName('fecha_factura').AsString;
    sNumeroFact:= qryAging.fieldByName('factura').AsString;
    sClienteFact:= qryAging.fieldByName('cod_cliente').AsString;
    iDiasFact:= qryAging.fieldByName('dias_desde_factura').AsInteger;
    rCambioFact:= qryAging.fieldByName('cambio').AsInteger;
    rTotalFact:= qryAging.fieldByName('total').AsInteger;
    rNetoFact:= qryAging.fieldByName('neto').AsInteger;
    rPendienteFact:= 0;

    //No tiene remesa, pendiente
    if qryAging.fieldByName('dias_desde_factura').AsInteger <= 30 then
    begin
      NewOrExistent( 'total', 'menos30', ANew );
    end
    else
    if ( qryAging.fieldByName('dias_desde_factura').AsInteger >= 31  ) and
       ( qryAging.fieldByName('dias_desde_factura').AsInteger <= 60  ) then
    begin
      NewOrExistent( 'total', 'entre31y60', ANew );
    end
    else
    if ( qryAging.fieldByName('dias_desde_factura').AsInteger >= 61  ) and
       ( qryAging.fieldByName('dias_desde_factura').AsInteger <= 75  ) then
    begin
      NewOrExistent( 'total', 'entre61y75', ANew );
    end
    else
    if ( qryAging.fieldByName('dias_desde_factura').AsInteger >= 76  ) and
       ( qryAging.fieldByName('dias_desde_factura').AsInteger <= 90  ) then
    begin
      NewOrExistent( 'total', 'entre76y90', ANew );
    end
    else
    if ( qryAging.fieldByName('dias_desde_factura').AsInteger >= 91  ) and
       ( qryAging.fieldByName('dias_desde_factura').AsInteger <= 120  ) then
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


procedure TDLAging.AddRegistro;
begin
  kmtAging.Insert;
  try
    DatosCliente;
    ClasificaRegistro( True );
    kmtAging.Post;
  except
    kmtAging.Cancel;
    raise;
  end;
end;

procedure TDLAging.ModRegistro;
begin
  kmtAging.Edit;
  try
    ClasificaRegistro( False );
    kmtAging.Post;
  except
    kmtAging.Cancel;
    raise;
  end;
end;

procedure TDLAging.DatosCliente;
begin
  kmtAging.FieldByName('cod_cliente').AsString:= qryAging.FieldByName('cod_cliente').AsString;
  kmtAging.FieldByName('activo').AsInteger:= 0;

  with qryCliente do
  begin
    SQL.Clear;
    SQL.Add('select nombre_c, max(max_riesgo_cr) max_riesgo_c, ');
    SQL.Add('       max(seguro_cr) seguro_c, count( distinct max_riesgo_cr ) riesgos ');
    SQL.Add('from frf_clientes, outer(frf_clientes_rie) ');
    SQL.Add('where cliente_c = :cliente ');
    SQL.Add('  and cliente_cr = cliente_c ');
    SQL.Add('  and empresa_cr = :empresa ');
    SQL.Add('  and fecha_fin_cr is null ');

    SQL.Add('group by 1 ');

    ParamByName('empresa').AsString:= qryAging.FieldByName('empresa').AsString;
    ParamByName('cliente').AsString:= qryAging.FieldByName('cod_cliente').AsString;

    qryCliente.Open;
    kmtAging.FieldByName('cliente').AsString:= qryCliente.FieldByName('nombre_c').AsString;
    kmtAging.FieldByName('clasificacion').AsFloat:= qryCliente.FieldByName('max_riesgo_c').AsFloat;
    if qryCliente.FieldByName('riesgos').AsInteger > 1 then
    begin
      if sRiesgos = '' then
        sRiesgos:= 'El cliente "' + qryAging.FieldByName('cod_cliente').AsString + '" ' +
                  qryCliente.FieldByName('nombre_c').AsString + ' tiene diferentes riesgos grabados en las empresas que le sirven.'
      else
        sRiesgos:= sRiesgos + #13 + #10 + 'El cliente "' + qryAging.FieldByName('cod_cliente').AsString + '" ' +
                  qryCliente.FieldByName('nombre_c').AsString + ' tiene diferentes riesgos grabados en las empresas que le sirven.';
    end;
    Close;
  end;
end;

procedure TDLAging.CalculoDeficitPMC;
begin
  with kmtAging do
  begin
    First;
    while not Eof do
    begin
      if ( FieldByName('riesgo').AsFloat = 0 ) and bSoloRiesgo then
      begin
        Delete;
      end
      else
      begin
        Edit;
        FieldByName('deficit').AsFloat:= FieldByName('clasificacion').AsFloat -
                                       FieldByName('riesgo').AsFloat;
        if FieldByName('deficit').AsFloat >= iDeficit then
          FieldByName('deficit').AsFloat:= 0;
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

function TDLAging.GetDatos( const AEmpresa, ACliente: string; const AIni, AFin: TDateTime;
                            const ADiasCobroPagare, ADeficit: integer; const AAbonos, AIva: Boolean ): boolean;
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

  PreparaQuery( AEmpresa, ACliente, AIni, AFin, AAbonos );
  Result:= PreparaTablas;
  CalculoDeficitPMC;
  if Result then
  begin
    kmtAging.SortFields := 'cliente';
    kmtAging.Sort([]);
  end;
end;

end.
