unit PDTransitoActivar;

interface

uses
  Forms, SysUtils, Classes, DB, DBTables;

type
  TDPTransitoActivar = class(TDataModule)
    QProceso: TQuery;
    qryPaletsComer: TQuery;
    qryPaletsSGP: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

    function ActivarPalets( const AEmpresa, ACentro, ATransito, ADestino, AOrden: string;
                             const AFechaSalida, AFechaEntrada: TDateTime ): boolean;
    function ActivarPaletsComer( const AEmpresa, ACentro, ATransito, ADestino, AOrden: string;
                             const AFechaSalida, AFechaEntrada: TDateTime ): boolean;
    function ActivarPaletsSGP( const AEmpresa, ACentro, ATransito, ADestino, AOrden: string;
                             const AFechaSalida, AFechaEntrada: TDateTime ): boolean;
  public
    { Public declarations }
    function Proceso( const AEmpresa, ACentro, ATransito: string;
                      const AFechaSalida, AFechaEntrada: TDateTime; const AHora: string; var AMsg: string ): boolean;
    procedure CerrarQuery;
  end;

  function InicializarModulo: TDPTransitoActivar;
  procedure FinalizarModulo;
  function Proceso( const AEmpresa, ACentro, ATransito: string;
                    const AFechaSalida, AFechaEntrada: TDateTime; const AHora: string; var AMsg: string ): boolean;

implementation

{$R *.dfm}

uses CVariables, UDMBaseDatos, UDMConfig, CGlobal, UDMAuxDB;

var
  DPTransitoActivar: TDPTransitoActivar;
  i: integer = 0;

function InicializarModulo: TDPTransitoActivar;
begin
  Inc( i );
  if i = 1 then
    DPTransitoActivar:= TDPTransitoActivar.Create( Application );
  result:= DPTransitoActivar
end;

procedure FinalizarModulo;
begin
  Dec( i );
  if i = 0 then
    FreeAndNil( DPTransitoActivar );
end;


function Proceso( const AEmpresa, ACentro, ATransito: string;
                  const AFechaSalida, AFechaEntrada: TDateTime; const AHora: string; var AMsg: string ): boolean;
begin
  if i > 0 then
  begin
    result:= DPTransitoActivar.Proceso( AEmpresa, ACentro, ATransito, AFechaSalida, AFechaEntrada, AHora, AMsg );
  end
  else
  begin
    Raise Exception.Create('Falta inicializar el modulo de datos.');
  end;
end;

function TDPTransitoActivar.Proceso( const AEmpresa, ACentro, ATransito: string;
                                     const AFechaSalida, AFechaEntrada: TDateTime; const AHora: string; var AMsg: string ): boolean;
var
  sOrden: string;
  sDestino: String;
begin
  with QProceso do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transitos_c ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc = :fecha ');
    SQL.Add(' and referencia_tc = :transito ');


    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('transito').AsString:= ATransito;
    ParamByName('fecha').AsDateTime:= AFechaSalida;

    Open;

    if IsEmpty then
    begin
      AMsg:= 'Error, no existe el tránsito seleccionado';
      Result:= False;
      Close;
    end
    else
    begin
      Edit;
      FieldByName('fecha_entrada_tc').AsDateTime:= AFechaEntrada;
      FieldByName('hora_entrada_tc').AsString:= AHora;
      Post;

      sOrden:= FieldByName('n_orden_tc').AsString;
      sDestino:= FieldByName('centro_destino_tc').AsString;
      Close;
      if ActivarPalets( AEmpresa, ACentro, ATransito, sDestino, sOrden, AFechaSalida, AFechaEntrada ) then
      begin
        AMsg:= 'OK';
        Result:= True;
      end
      else
      begin
        AMsg:= 'Los palets asociados al tránsito ya estaban activados (o no tiene palets).';
        Result:= False;
      end;
    end;
  end;
end;

procedure TDPTransitoActivar.CerrarQuery;
begin
  QProceso.Close;
end;

procedure TDPTransitoActivar.DataModuleDestroy(Sender: TObject);
begin
  if DMBaseDatos.DBSGP.Connected then
  begin
    with qryPaletsSGP do
    begin
      Close;
      if Prepared then
        Unprepare;
    end;
    DMBaseDatos.DBSGP.Connected:= False;
  end
  else
  begin
    with qryPaletsComer do
    begin
      Close;
      if Prepared then
        Unprepare;
    end;
  end;
end;

procedure TDPTransitoActivar.DataModuleCreate(Sender: TObject);
begin
  if DMConfig.EsLosLLanos then
  begin
    DMBaseDatos.DBSGP.Connected:= true;
  end;
end;

function TDPTransitoActivar.ActivarPalets( const AEmpresa, ACentro, ATransito, ADestino, AOrden: string;
                             const AFechaSalida, AFechaEntrada: TDateTime ): boolean;
begin
  if gProgramVersion = pvBAG then
  begin
    Result:= ActivarPaletsComer( AEmpresa, ACentro, ATransito, ADestino, AOrden, AFechaSalida, AFechaEntrada );
  end
  else
  begin
    if DMConfig.EsLosLLanos then
    begin
      Result:= ActivarPaletsSGP( AEmpresa, ACentro, ATransito, ADestino, AOrden, AFechaSalida, AFechaEntrada );
    end
    else
    begin
      Result:= ActivarPaletsComer( AEmpresa, ACentro, ATransito, ADestino, AOrden, AFechaSalida, AFechaEntrada );
    end;
  end;
end;

function TDPTransitoActivar.ActivarPaletsComer( const AEmpresa, ACentro, ATransito, ADestino, AOrden: string;
                             const AFechaSalida, AFechaEntrada: TDateTime ): boolean;
begin
  with qryPaletsComer do
  begin
    SQL.Clear;
    SQL.Add('update rf_palet_pb ');
    SQL.Add('set    centro= :destino, ');
    SQL.Add('       status= ''S'', ');
    SQL.Add('       fecha_status= :fecha, ');
    SQL.Add('       terminal_status= :usuario, ');
    SQL.Add('       transito= :transito ');
    SQL.Add('  where orden_carga = :orden ');
    SQL.Add('  and status = ''T''  ');


    //ParamByName('origen').AsString:= ACentro;
    //ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('orden').AsString:= AOrden;

    ParamByName('usuario').AsString:= CVariables.gsCodigo;
    ParamByName('destino').AsString:= ADestino;
    ParamByName('fecha').AsDateTime:= Now;
    ParamByName('transito').AsString:= ATransito;

    ExecSQL;
    Result:= RowsAffected <> 0;
    with DMAuxDB.QGeneral do
    begin
      SQL.Clear;
      SQL.Add(' select * from rf_palet_pb ');
      SQL.Add('  where empresa = :empresa ');
      SQL.Add('    and centro =  :centro ');
      SQL.Add('    and transito = :transito ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ADestino;
      ParamByName('transito').AsString := ATransito;
      Open;
      while not DMAuxDB.QGeneral.Eof do
      begin
        //Borrar movimiento 15, por si ya se hubiera transmitido antes.
        BorrarPBLog(DMAuxDB.QGeneral.FieldByName('transito').AsString, DMAuxDB.QGeneral.FieldByName('sscc').AsString, 18);
        //Insertar LOG - Movimiento 18 - Activar Transito
        InsertarPBLog(DMAuxDB.QGeneral.FieldByName('empresa').AsString,
                      DMAuxDB.QGeneral.FieldByName('centro').AsString,
                      DMAuxDB.QGeneral.FieldByName('sscc').AsString,
                      CVariables.gsCodigo,
                      DMAuxDB.QGeneral.FieldByName('transito').AsString,
                      DMAuxDB.QGeneral.FieldByName('peso').AsFloat,
                      DMAuxDB.QGeneral.FieldByName('cajas').AsFloat,
                      18);

        DMAuxDB.QGeneral.Next;
      end;
    end;


    SQL.Clear;
    SQL.Add('update rf_Palet_Pc_Cab  ');
    SQL.Add('set    centro_cab= :destino, ');
    SQL.Add('       status_cab= ''S'', ');
    SQL.Add('       fecha_transito= :fecha, ');
    SQL.Add('       ref_transito= :transito ');

    //SQL.Add('where  empresa_cab = :empresa ');
    //SQL.Add('  and  centro_cab = :origen ');
    SQL.Add('  where  orden_carga_cab  = :orden ');
    //SQL.Add('  and  ( status_cab = ''C'' or status_cab = ''T'' ) ');
    SQL.Add('  and  status_cab = ''T''  ');

    //ParamByName('empresa').AsString:= AEmpresa;
    //ParamByName('origen').AsString:= ACentro;
    ParamByName('orden').AsString:= AOrden;

    ParamByName('destino').AsString:= ADestino;
    ParamByName('transito').AsString:= ATransito;
    ParamByName('fecha').AsDateTime:= AFechaSalida;

    ExecSQL;
    if RowsAffected = 0 then
    begin
      SQL.Clear;
      SQL.Add('update rf_Palet_Pc_Cab  ');
      SQL.Add('set    centro_cab= :destino, ');
      SQL.Add('       status_cab= ''S'' ');

      SQL.Add('where  empresa_cab = :empresa ');
      //SQL.Add('  and  centro_cab = :origen ');
      SQL.Add('  and ref_transito = :transito ');
      SQL.Add('  and fecha_transito = :fecha ');
      //SQL.Add('  and  ( status_cab = ''C'' or status_cab = ''T'' ) ');
      SQL.Add('  and  status_cab = ''T'' ');

      ParamByName('empresa').AsString:= AEmpresa;
      //ParamByName('origen').AsString:= ACentro;
      ParamByName('destino').AsString:= ADestino;
      ParamByName('transito').AsString:= ATransito;
      ParamByName('fecha').AsDateTime:= AFechaSalida;

      ExecSQL;
      Result:= Result or ( RowsAffected <> 0 );
      with DMAuxDB.QGeneral do
      begin
        SQL.Clear;
        SQL.Add(' select * from rf_palet_pc_cab, rf_palet_pc_det ');
        SQL.Add('  where empresa_cab = :empresa ');
        SQL.Add('    and centro_cab =  :centro ');
        SQL.Add('    and ref_transito = :transito ');
        SQL.Add('    and ean128_cab = ean128_det  ');

        ParamByName('empresa').AsString := AEmpresa;
        ParamByName('centro').AsString := ADestino;
        ParamByName('transito').AsString := ATransito;
        Open;
        while not DMAuxDB.QGeneral.Eof do
        begin
          //Borrar movimiento 15, por si ya se hubiera transmitido antes.
          BorrarPCLog(DMAuxDB.QGeneral.FieldByName('ref_transito').AsString, DMAuxDB.QGeneral.FieldByName('ean128_cab').AsString, 18);
          //Insertar LOG - Movimiento 18 - Activar Transito
          InsertarPCLog(DMAuxDB.QGeneral.FieldByName('empresa_cab').AsString,
                        DMAuxDB.QGeneral.FieldByName('centro_cab').AsString,
                        DMAuxDB.QGeneral.FieldByName('ean128_cab').AsString,
                        CVariables.gsCodigo,
                        DMAuxDB.QGeneral.FieldByName('ref_transito').AsString,
                        DMAuxDB.QGeneral.FieldByName('peso_det').AsFloat,
                        DMAuxDB.QGeneral.FieldByName('unidades_det').AsFloat,
                        18);

          DMAuxDB.QGeneral.Next;
        end;
      end;

    end
    else
    begin
      Result:= True;
    end;
  end;
end;

function TDPTransitoActivar.ActivarPaletsSGP( const AEmpresa, ACentro, ATransito, ADestino, AOrden: string;
                             const AFechaSalida, AFechaEntrada: TDateTime ): boolean;
begin
  with qryPaletsComer do
  begin
    SQL.Clear;
    SQL.Add('update rf_palet_pb ');
    SQL.Add('set    centro= :destino, ');
    SQL.Add('       status= ''S'', ');
    SQL.Add('       fecha_status= :fecha, ');
    SQL.Add('       terminal_status= :usuario, ');
    SQL.Add('       transito= :transito ');
    SQL.Add(' where orden_carga = :orden ');
    SQL.Add('  and status = ''T''  ');


    //ParamByName('origen').AsString:= ACentro;
    //ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('orden').AsString:= AOrden;

    ParamByName('usuario').AsString:= CVariables.gsCodigo;
    ParamByName('destino').AsString:= ADestino;
    ParamByName('fecha').AsDateTime:= Now;
    ParamByName('transito').AsString:= ATransito;

    ExecSQL;
    Result:= RowsAffected <> 0;
    with DMAuxDB.QGeneral do
    begin
      SQL.Clear;
      SQL.Add(' select * from rf_palet_pb ');
      SQL.Add('  where empresa = :empresa ');
      SQL.Add('    and centro =  :centro ');
      SQL.Add('    and transito = :transito ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ADestino;
      ParamByName('transito').AsString := ATransito;
      Open;
      while not DMAuxDB.QGeneral.Eof do
      begin
        //Borrar movimiento 15, por si ya se hubiera transmitido antes.
        BorrarPBLog(DMAuxDB.QGeneral.FieldByName('transito').AsString, DMAuxDB.QGeneral.FieldByName('sscc').AsString, 18);
        //Insertar LOG - Movimiento 18 - Activar Transito
        InsertarPBLog(DMAuxDB.QGeneral.FieldByName('empresa').AsString,
                      DMAuxDB.QGeneral.FieldByName('centro').AsString,
                      DMAuxDB.QGeneral.FieldByName('sscc').AsString,
                      CVariables.gsCodigo,
                      DMAuxDB.QGeneral.FieldByName('transito').AsString,
                      DMAuxDB.QGeneral.FieldByName('peso').AsFloat,
                      DMAuxDB.QGeneral.FieldByName('cajas').AsFloat,
                      18);

        DMAuxDB.QGeneral.Next;
      end;
    end;
  end;


  with qryPaletsSGP do
  begin
    SQL.Clear;
    SQL.Add('update rf_Palet_Pc_Cab  ');
    SQL.Add('set    centro_cab= :destino, ');
    SQL.Add('       status_cab= ''S'', ');
    SQL.Add('       fecha_transito= :fecha, ');
    SQL.Add('       ref_transito= :transito ');

    SQL.Add('where  empresa_cab = :empresa ');
    SQL.Add('  and  centro_cab = :origen ');
    SQL.Add('  and  orden_carga_cab  = :orden ');
    SQL.Add('  and  ( status_cab = ''C'' or status_cab = ''T'' ) ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('origen').AsString:= ACentro;
    ParamByName('orden').AsString:= AOrden;

    ParamByName('destino').AsString:= ADestino;
    ParamByName('transito').AsString:= ATransito;
    ParamByName('fecha').AsDateTime:= AFechaSalida;

    ExecSQL;
    if RowsAffected = 0 then
    begin
      SQL.Clear;
      SQL.Add('update rf_Palet_Pc_Cab  ');
      SQL.Add('set    centro_cab= :destino, ');
      SQL.Add('       status_cab= ''S'' ');

      SQL.Add('where  empresa_cab = :empresa ');
      SQL.Add('  and  centro_cab = :origen ');
      SQL.Add('  and ref_transito = :transito ');
      SQL.Add('  and fecha_transito = :fecha ');
      SQL.Add('  and  ( status_cab = ''C'' or status_cab = ''T'' ) ');

      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('origen').AsString:= ACentro;
      ParamByName('destino').AsString:= ADestino;
      ParamByName('transito').AsString:= ATransito;
      ParamByName('fecha').AsDateTime:= AFechaSalida;

      ExecSQL;
      Result:= ( RowsAffected <> 0 );
      with DMAuxDB.QGeneral do
      begin
        SQL.Clear;
        SQL.Add(' select * from rf_palet_pc_cab ');
        SQL.Add('  where empresa_cab = :empresa ');
        SQL.Add('    and centro_cab =  :centro ');
        SQL.Add('    and ref_transito = :transito ');

        ParamByName('empresa').AsString := AEmpresa;
        ParamByName('centro').AsString := ADestino;
        ParamByName('transito').AsString := ATransito;
        Open;
        while not DMAuxDB.QGeneral.Eof do
        begin
          //Borrar movimiento 15, por si ya se hubiera transmitido antes.
          BorrarPCLog(DMAuxDB.QGeneral.FieldByName('transito').AsString, DMAuxDB.QGeneral.FieldByName('sscc').AsString, 18);
          //Insertar LOG - Movimiento 18 - Activar Transito
          InsertarPCLog(DMAuxDB.QGeneral.FieldByName('empresa').AsString,
                        DMAuxDB.QGeneral.FieldByName('centro').AsString,
                        DMAuxDB.QGeneral.FieldByName('sscc').AsString,
                        CVariables.gsCodigo,
                        DMAuxDB.QGeneral.FieldByName('transito').AsString,
                        DMAuxDB.QGeneral.FieldByName('peso').AsFloat,
                        DMAuxDB.QGeneral.FieldByName('cajas').AsFloat,
                        18);

          DMAuxDB.QGeneral.Next;
        end;
      end;
    end
    else
    begin
      Result:= True;
    end;
  end;
end;

end.
