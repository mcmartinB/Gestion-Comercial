unit ActualizarDiasCobroDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMActualizarDiasCobro = class(TDataModule)
    qryFacturas: TQuery;
    qryDiasTesoreriaCliente: TQuery;
    qryDiasCobroFactura: TQuery;
    qryUpdatefactura: TQuery;
    qryFacturaAsociada: TQuery;
    qryFacturaAlbaran: TQuery;
    qryFacturaFechas: TQuery;
    qryAbonosSinFactura: TQuery;
    qryUpdatefacturaAsociada: TQuery;
    qryDiasCobroCliente: TQuery;
    qryUpdateFacAnula: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    bFactura, bCobro, bTesoreria: Boolean;

    procedure SQLUpdate;
    procedure SQLFacturas( const ATipo, AEmpresa, ACliente: string; const AFecha: TDateTime;  var AMsg: string );
    function  GetCliente: string;
    function  GetDiasTesoreria: Integer;
    function  GetDiasCobro: Integer;
    procedure UpdateFechas( const VFactura, VCobro, VTesoreria: TDateTime );
    procedure UpdateFacAnula( const AFactura: string );
    procedure ActualizarFactura( const VTesoreria: Integer );
    procedure ActualizarAbono( const VTesoreria: Integer );
    function  FacturaAsociada: string;
    procedure PutFechasFactura( const AFactura: string; var VFactura, VCobro, VTesoreria: TDateTime );

    function ActualizarFacturaAsocida( const AQuery: TQuery ): string;
  public
    { Public declarations }
    function  ActualizarFacturas( const AEmpresa, ACliente: string; const AFecha: TDateTime;  var AMsg: string ): boolean;
    function  ActualizarAbonos( const AEmpresa, ACliente: string; const AFecha: TDateTime;  var AMsg: string ): boolean;
    procedure ActualizarAbonosSinFactura( const AFecha: TDateTime );
  end;

  function Ejecutar( const AOwner: TComponent; const AEmpresa, ACliente: string;
                     const AFactura, ACobro, ATesoreria: Boolean; var AMsg: string ): boolean;

implementation

{$R *.dfm}

uses
 SeleccionarFechaFD, CGlobal;

var
  DMActualizarDiasCobro: TDMActualizarDiasCobro;


function Ejecutar( const AOwner: TComponent; const AEmpresa, ACliente: string;
                   const AFactura, ACobro, ATesoreria: Boolean; var AMsg: string ): boolean;
var
  dFecha: TDateTime;
begin
  dFecha:= Now;
  if not AFactura and not ACobro and not ATesoreria then
  begin
    AMsg:= 'Indique si quiere actualizar Fecha Factura Asociada, Fecha Cobro y/o Tesoreria.';
    result:= False;
  end
  else
  begin
    if SeleccionarFechaFD.SeleccionarFecha( AOwner, dFecha ) then
    begin
      DMActualizarDiasCobro:= TDMActualizarDiasCobro.Create( AOwner );
      try
        AMsg:= '';
        DMActualizarDiasCobro.bFactura:= AFactura;
        DMActualizarDiasCobro.bCobro:= ACobro;
        DMActualizarDiasCobro.bTesoreria:= ATesoreria;
        DMActualizarDiasCobro.SQLUpdate;
        DMActualizarDiasCobro.ActualizarFacturas( AEmpresa, ACliente, dFecha, AMsg );
        DMActualizarDiasCobro.ActualizarAbonos( AEmpresa, ACliente, dFecha, AMsg );
        AMsg:= AMsg + #13  + #10 + 'Proceso finalizado.';
        result:= True;
        //DMActualizarDiasCobro.ActualizarAbonosSinFactura( dFecha );
      finally
        FreeAndNil( DMActualizarDiasCobro );
      end;
    end
    else
    begin
      AMsg:= 'Operación cancelada.';
      result:= False;
    end;
  end;
end;

procedure TDMActualizarDiasCobro.DataModuleCreate(Sender: TObject);
begin
  bCobro:= True;
  bTesoreria:= True;
  bFactura:= True;
  with qryDiasTesoreriaCliente do
  begin
    SQL.Clear;
    SQL.Add('select nvL(dias_tesoreria_c,-1) dias_tesoreria_c, forma_pago_c ');
    SQL.Add('from frf_clientes ');
    SQL.Add('where empresa_c = :empresa ');
    SQL.Add('and cliente_c = :cliente ');
  end;
  with qryDiasCobroCliente do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(dias_cobro_fp,0) dias_cobro_fp');
    SQL.Add(' from tforma_pago ');
    SQL.Add(' where codigo_fp = :tipo ');
  end;
  with qryDiasCobroFactura do
  begin
    SQL.Clear;
    SQL.Add(' select cod_factura_fc, forma_pago_fc, nvl(dias_cobro_fp,0) dias_cobro_fp ');
    SQL.Add(' from tfacturas_cab join tforma_pago on codigo_fp = forma_pago_fc ');
    SQL.Add(' where cod_factura_fc = :factura ');
  end;
  with qryFacturaAsociada do
  begin
    SQL.Clear;
    SQL.Add('select cod_factura_fd, cod_empresa_albaran_fd, cod_centro_albaran_fd, n_albaran_fd, fecha_albaran_fd, cod_factura_origen_fd');
    SQL.Add('from tfacturas_det');
    SQL.Add('where cod_factura_fd = :abono');
    SQL.Add('group by cod_factura_fd, cod_empresa_albaran_fd, cod_centro_albaran_fd, n_albaran_fd, fecha_albaran_fd, cod_factura_origen_fd ');
    SQL.Add('order by cod_factura_origen_fd ');
  end;
  with qryFacturaAlbaran do
  begin
    SQL.Clear;
    SQL.Add('select cod_factura_fd ');
    SQL.Add('from tfacturas_det join tfacturas_cab on cod_factura_fd = cod_factura_fc ');
    SQL.Add('where cod_empresa_albaran_fd = :empresa ');
    SQL.Add('and cod_centro_albaran_fd = :centro ');
    SQL.Add('and n_albaran_fd = :albaran ');
    SQL.Add('and fecha_albaran_fd = :fecha ');
    SQL.Add('and tipo_factura_fc = 380 ');
    SQL.Add('order by fecha_factura_fc asc ');
  end;
  with qryFacturaFechas do
  begin
    SQL.Clear;
    SQL.Add('select fecha_factura_fc , prevision_cobro_fc , prevision_tesoreria_fc');
    SQL.Add('from tfacturas_cab');
    SQL.Add('where cod_factura_fc = :factura');
  end;
  with qryAbonosSinFactura do
  begin
    SQL.Clear;
    SQL.Add('select cod_factura_fd, cod_empresa_albaran_fd, cod_centro_albaran_fd, n_albaran_fd, fecha_albaran_fd ');
    SQL.Add('from tfacturas_cab join tfacturas_det on cod_factura_fd = cod_factura_fc ');
    SQL.Add('   where fecha_factura_fc >= :fecha ');
    SQL.Add('   and tipo_factura_fc = 381 ');
    SQL.Add('   and nvl(cod_factura_origen_fd,'''') = '''' ');
    SQL.Add('group by cod_factura_fd, cod_empresa_albaran_fd, cod_centro_albaran_fd, n_albaran_fd, fecha_albaran_fd ');
  end;

  with qryUpdateFacAnula do
  begin
    SQL.Clear;
    SQL.Add(' update tfacturas_cab');
    SQL.Add(' set cod_factura_anula_fc = :cod_factura_anula ' );
    SQL.Add(' where cod_factura_fc = :factura ');
  end;

  with qryUpdateFacturaAsociada do
  begin
    SQL.Clear;
    SQL.Add('update tfacturas_det  ');
    SQL.Add('set cod_factura_origen_fd = :factura ');
    SQL.Add('where cod_factura_fd = :abono ');
    SQL.Add('and cod_empresa_albaran_fd = :empresa ');
    SQL.Add('and cod_centro_albaran_fd = :centro ');
    SQL.Add('and n_albaran_fd = :albaran ');
    SQL.Add('and fecha_albaran_fd = :fecha ');
  end;
end;

procedure TDMActualizarDiasCobro.SQLUpdate;
var
  sAux: string;
begin
  with qryUpdatefactura do
  begin
    SQL.Clear;
    SQL.Add(' update tfacturas_cab');

    if bCobro then
    begin
      sAux:=  ' prevision_cobro_fc = :prevision_cobro ';
    end;
    if bTesoreria then
    begin
      if sAux = '' then
        sAux:=  ' prevision_tesoreria_fc = :prevision_tesoreria '
      else
        sAux:=  sAux + ' ,prevision_tesoreria_fc = :prevision_tesoreria ';
    end;
    if bFactura then
    begin
      if sAux = '' then
        sAux:=  ' fecha_fac_ini_fc = :fecha_fac_ini '
      else
        sAux:=  sAux + ' ,fecha_fac_ini_fc = :fecha_fac_in ';
    end;

    SQL.Add(' set  ' + sAux );
    SQL.Add(' where cod_factura_fc = :factura ');
  end;
end;

function TDMActualizarDiasCobro.GetCliente: string;
begin
  Result:= qryFacturas.fieldByName('cod_Empresa_fac_fc').AsString + qryFacturas.fieldByName('cod_cliente_fc').AsString;
end;

function TDMActualizarDiasCobro.GetDiasTesoreria: Integer;
begin
  with qryDiasTesoreriaCliente do
  begin
    ParamByName('empresa').asstring:=  qryFacturas.fieldByName('cod_Empresa_fac_fc').AsString;
    ParamByName('cliente').asstring:=  qryFacturas.fieldByName('cod_cliente_fc').AsString;
    Open;
  end;

  if qryDiasTesoreriaCliente.fieldByName('dias_tesoreria_c').AsInteger = -1 then
  begin
    with qryDiasCobroCliente do
    begin
      ParamByName('tipo').asstring:=  qryDiasTesoreriaCliente.fieldByName('forma_pago_c').AsString;
      Open;
    end;
    Result:= qryDiasCobroCliente.fieldByName('dias_cobro_fp').AsInteger;
    qryDiasCobroCliente.Close;
  end
  else
  begin
    result:= qryDiasTesoreriaCliente.fieldByName('dias_tesoreria_c').AsInteger;
  end;
  qryDiasTesoreriaCliente.Close;
end;

function TDMActualizarDiasCobro.GetDiasCobro: Integer;
begin
  with qryDiasCobroFactura do
  begin
    ParamByName('factura').asstring:=  qryFacturas.fieldByName('cod_factura_fc').AsString;
    Open;
  end;
  result:= qryDiasCobroFactura.fieldByName('dias_cobro_fp').AsInteger;
  qryDiasCobroFactura.Close;
end;

procedure TDMActualizarDiasCobro.SQLFacturas( const ATipo, AEmpresa, ACliente: string; const AFecha: TDateTime;  var AMsg: string );
begin
  with qryFacturas do
  begin
    SQL.Clear;
    //SQL.Add('select cod_Empresa_fac_fc, cod_cliente_fc, cod_factura_fc, fecha_factura_fc, prevision_cobro_fc, tipo_factura_fc ');
    SQL.Add('select cod_Empresa_fac_fc, cod_cliente_fc, cod_factura_fc, fecha_factura_fc, prevision_cobro_fc, tipo_factura_fc ');
    SQL.Add('from tfacturas_cab ');
    SQL.Add('where fecha_factura_fc >= :fecha ');
    SQL.Add('and tipo_factura_fc = :tipo ');
    if AEmpresa <> '' then
    begin
      SQL.Add('and cod_empresa_fac_fc = :empresa ')
    end
    else
    begin
      if CGlobal.gProgramVersion = CGlobal.pvBAG then
      begin
        SQL.Add('and cod_empresa_fac_fc[1,1] = ''F'' ');
      end
      else
      begin
        SQL.Add('and cod_empresa_fac_fc in  (''080'',''050'') ');
      end;
    end;

    if ACliente <> '' then
      SQL.Add('and cod_cliente_fc = :cliente ');
    SQL.Add('order By cod_Empresa_fac_fc, cod_cliente_fc ');

    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('tipo').AsString:= ATipo;
    if AEmpresa <> '' then
      ParamByName('empresa').AsString:= AEmpresa;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
  end;
end;


procedure TDMActualizarDiasCobro.UpdateFechas( const VFactura, VCobro, VTesoreria: TDateTime );
begin
  with qryUpdatefactura do
  begin
    if bFactura then
      ParamByName('fecha_fac_ini').AsDateTime:= VFactura;
    if bCobro then
      ParamByName('prevision_cobro').AsDateTime:= VCobro;
    if bTesoreria then
      ParamByName('prevision_tesoreria').AsDateTime:= VTesoreria;
    ParamByName('factura').AsString:= qryFacturas.FieldByName('cod_factura_fc').AsString;
    ExecSQL;
  end;
end;

procedure TDMActualizarDiasCobro.UpdateFacAnula( const AFactura: string );
begin
  with qryUpdateFacAnula do
  begin
    ParamByName('cod_factura_anula').AsString:= AFactura;
    ParamByName('factura').AsString:= qryFacturas.FieldByName('cod_factura_fc').AsString;
    ExecSQL;
  end;
end;

function TDMActualizarDiasCobro.ActualizarFacturas( const AEmpresa, ACliente: string; const AFecha: TDateTime;  var AMsg: string ): boolean;
var
  sCliente: string;
  i, iDiasTesoreria: Integer;
  sAux: string;
begin
  sCliente:= '';
  iDiasTesoreria:= 0;
  //Facturas
  SQLFacturas( '380', AEmpresa, ACliente, AFecha, AMsg );

  qryFacturas.Open;
  try
    if not qryFacturas.IsEmpty then
    begin
      Result:= True;
      i:= 0;
      while not qryFacturas.Eof do
      begin
         sAux:= GetCliente;
         if sCliente <> sAux then
         begin
           sCliente:= GetCliente;
           if bTesoreria then
             iDiasTesoreria:= GetDiasTesoreria;
         end;
         ActualizarFactura(  iDiasTesoreria );
        qryFacturas.Next;
        Inc( i );
      end;
      if AMsg <> '' then
        AMsg:= AMsg + #13  + #10 + 'Actualizadas ' + IntToStr(i) + ' facturas. '
      else
        AMsg:= 'Actualizadas ' + IntToStr(i) + ' facturas. ';
    end
    else
    begin
      Result:= False;
      if AMsg <> '' then
        AMsg:= AMsg + #13  + #10 + 'No hay facturas para actualizar.'
      else
        AMsg:= 'No hay facturas para actualizar.';
    end;
  finally
    qryFacturas.Close;
  end;
end;

procedure TDMActualizarDiasCobro.ActualizarFactura( const  VTesoreria: Integer );
var
  iCobro: Integer;
begin
  if bCobro then
    iCobro:= GetDiasCobro
  else
    iCobro:= 0;
  UpdateFechas( qryFacturas.FieldByName('fecha_factura_fc').AsDateTime,
                qryFacturas.FieldByName('fecha_factura_fc').AsDateTime + iCobro,
                qryFacturas.FieldByName('fecha_factura_fc').AsDateTime + VTesoreria );
end;

function TDMActualizarDiasCobro.ActualizarAbonos( const AEmpresa, ACliente: string; const AFecha: TDateTime;  var AMsg: string ): boolean;
var
  sCliente: string;
  i, iDiasTesoreria: Integer;
begin
  sCliente:= '';
  iDiasTesoreria:= 0;
  //Facturas
  SQLFacturas( '381', AEmpresa, ACliente, AFecha, AMsg );

  qryFacturas.Open;
  try
    if not qryFacturas.IsEmpty then
    begin
      Result:= True;
      i:= 0;
      while not qryFacturas.Eof do
      begin
         if sCliente <> GetCliente then
         begin
           sCliente:= GetCliente;
           if bTesoreria then
             iDiasTesoreria:= GetDiasTesoreria;
         end;
         ActualizarAbono( iDiasTesoreria );
        qryFacturas.Next;
        inc(i);
      end;
      if AMsg <> '' then
        AMsg:= AMsg + #13  + #10 + 'Actualizados ' + IntToStr(i) + ' abonos. '
      else
        AMsg:= 'Actualizados ' + IntToStr(i) + ' abonos. ';
    end
    else
    begin
      Result:= False;
      if AMsg <> '' then
        AMsg:= AMsg + #13  + #10 + 'No hay abonos para actualizar.'
      else
        AMsg:= 'No hay abonos para actualizar.';
    end;
  finally
    qryFacturas.Close;
  end;
end;

procedure TDMActualizarDiasCobro.ActualizarAbono( const VTesoreria: Integer );
var
  sFacturaAsociada: string;
  dFactura, dCobro, dTesoreria: TDateTime;
  iCobro: integer;
begin
  //Tiene factura asociada
  sFacturaAsociada:= FacturaAsociada;
  if sFacturaAsociada <> '' then
  begin
    PutFechasFactura( sFacturaAsociada, dFactura, dCobro, dTesoreria );
    UpdateFacAnula( sFacturaAsociada );
  end
  else
  begin
    if bCobro then
      iCobro:= GetDiasCobro
    else
      iCobro:= 0;
    dFactura:= qryFacturas.FieldByName('fecha_factura_fc').AsDateTime;
    dCobro:= qryFacturas.FieldByName('fecha_factura_fc').AsDateTime + iCobro;
    dTesoreria:= qryFacturas.FieldByName('fecha_factura_fc').AsDateTime + VTesoreria;
  end;
  UpdateFechas( dFactura, dCobro, dTesoreria );
end;

procedure TDMActualizarDiasCobro.PutFechasFactura( const AFactura: string; var VFactura, VCobro, VTesoreria: TDateTime );
begin
  with qryFacturaFechas do
  begin
    ParamByName('factura').AsString:= AFactura;
    Open;

    VFactura:= FieldByName('fecha_factura_fc').AsDateTime;

    if FieldByName('prevision_cobro_fc').AsDateTime < qryFacturas.FieldByName('fecha_factura_fc').AsDateTime then
      VCobro:=  qryFacturas.FieldByName('fecha_factura_fc').AsDateTime
    else
      VCobro:=  FieldByName('prevision_cobro_fc').AsDateTime;

    if FieldByName('prevision_tesoreria_fc').AsDateTime < qryFacturas.FieldByName('fecha_factura_fc').AsDateTime then
      VTesoreria:=  qryFacturas.FieldByName('fecha_factura_fc').AsDateTime
    else
      VTesoreria:=  FieldByName('prevision_tesoreria_fc').AsDateTime;


    Close;
  end;
end;

function TDMActualizarDiasCobro.FacturaAsociada: string;
var
  sAux: string;
begin
  qryFacturaAsociada.ParamByName('abono').AsString:= qryFacturas.FieldByName('cod_factura_fc').AsString;
  qryFacturaAsociada.Open;
  Result:= '';
  sAux:= '';
  while not qryFacturaAsociada.Eof do
  begin
    if Trim( qryFacturaAsociada.FieldByName('cod_factura_origen_fd').AsString ) <> '' then
    begin
      sAux:= Trim( qryFacturaAsociada.FieldByName('cod_factura_origen_fd').AsString );
    end
    else
    begin
      sAux:= ActualizarFacturaAsocida( qryFacturaAsociada );
    end;

    if Result = '' then
    begin
      Result:= sAux;
    end;
    qryFacturaAsociada.Next;
  end;
  qryFacturaAsociada.Close;
end;

procedure TDMActualizarDiasCobro.ActualizarAbonosSinFactura( const AFecha: TDateTime );
begin
  with qryAbonosSinFactura do
  begin
    ParamByName('fecha').AsDateTime:= AFecha;
    Open;
    while not qryAbonosSinFactura.Eof do
    begin
      ActualizarFacturaAsocida( qryAbonosSinFactura );
      qryAbonosSinFactura.Next;
    end;
    qryAbonosSinFactura.Close;
  end
end;

function TDMActualizarDiasCobro.ActualizarFacturaAsocida( const AQuery: TQuery ): string;
begin
  qryFacturaAlbaran.ParamByName('empresa').AsString:= AQuery.FieldByName('cod_empresa_albaran_fd').AsString;
  qryFacturaAlbaran.ParamByName('centro').AsString:= AQuery.FieldByName('cod_centro_albaran_fd').AsString;
  qryFacturaAlbaran.ParamByName('albaran').AsInteger:= AQuery.FieldByName('n_albaran_fd').AsInteger;
  qryFacturaAlbaran.ParamByName('fecha').AsDateTime:= AQuery.FieldByName('fecha_albaran_fd').AsDateTime;
  qryFacturaAlbaran.Open;
  if not qryFacturaAlbaran.IsEmpty then
  begin
    result:= qryFacturaAlbaran.FieldByName('cod_factura_fd').AsString;;
    qryUpdateFacturaAsociada.ParamByName('factura').AsString:= result;
    qryUpdateFacturaAsociada.ParamByName('abono').AsString:= AQuery.FieldByName('cod_factura_fd').AsString;
    qryUpdateFacturaAsociada.ParamByName('empresa').AsString:= AQuery.FieldByName('cod_empresa_albaran_fd').AsString;
    qryUpdateFacturaAsociada.ParamByName('centro').AsString:= AQuery.FieldByName('cod_centro_albaran_fd').AsString;
    qryUpdateFacturaAsociada.ParamByName('albaran').AsInteger:= AQuery.FieldByName('n_albaran_fd').AsInteger;
    qryUpdateFacturaAsociada.ParamByName('fecha').AsDateTime:= AQuery.FieldByName('fecha_albaran_fd').AsDateTime;
    qryUpdateFacturaAsociada.ExecSQL;
  end
  else
  begin
    result:= '';
  end;
  qryFacturaAlbaran.Close;
end;

end.
