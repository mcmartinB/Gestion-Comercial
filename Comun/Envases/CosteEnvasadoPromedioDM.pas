unit CosteEnvasadoPromedioDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMCosteEnvasadoPromedio = class(TDataModule)
    qryTotalesAnuales: TQuery;
    qryRegistroCoste: TQuery;
    qryActualizaRegsitro: TQuery;
    qryEnvaseNuevo: TQuery;
    qryPendientes: TQuery;
    qryEnvasesNuevos: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sCompany, sCenter, sPack, sProducto: string;
    iBaseProduct, iYear, iMonth, iRecalculate:integer;
    dInitialDate, dFinalDate: TDateTime;
    sMsg: string;

    function GrabarPromedios: Boolean;
    procedure ActualizarPromedios;
    procedure EnvaseNuevo;

  public
    { Public declarations }
    function PromedioPendientes( var VRegistros: Integer ): boolean;
    function PromedioRegistro( const ACompany, ACenter, APack, AProducto: string;
                               const ABaseProduct, AYear, AMonth, ARecalculate:integer; var AMsg: string ): Boolean;
  end;

  function PromedioPendientes( var VRegistros: Integer ): boolean;
  function PromedioRegistro( const AOwner: TComponent;  const ACompany, ACenter, APack, AProducto: string;
                             const ABaseProduct, AYear, AMonth, ARecalculate:integer; var AMsg: string ): Boolean;


implementation

uses
  Dialogs, Controls, bMath;

var
  DMCosteEnvasadoPromedio: TDMCosteEnvasadoPromedio;

{$R *.dfm}

procedure TDMCosteEnvasadoPromedio.DataModuleCreate(Sender: TObject);
begin
  //
  with qryTotalesAnuales do
  begin
    Sql.Clear;
    Sql.Clear;
    Sql.Add(' select sum(kilos_sl) kilos, ');
    Sql.Add('        sum( round( ( select coste_ec ');
    Sql.Add('                      from frf_env_costes ');
    Sql.Add('                      where empresa_ec = empresa_sl ');
    Sql.Add('                      and centro_ec = centro_salida_sl ');
    Sql.Add('                      and anyo_ec = year(fecha_sl) and mes_ec = month(fecha_sl) ');
    Sql.Add('                      and producto_ec = producto_sl ');
    Sql.Add('                      and envase_ec = envase_sl ');
    Sql.Add('                    ) * kilos_sl, 2 ) ) coste, ');
    Sql.Add('        sum( round( ( select material_ec ');
    Sql.Add('                      from frf_env_costes ');
    Sql.Add('                      where empresa_ec = empresa_sl ');
    Sql.Add('                      and centro_ec = centro_salida_sl ');
    Sql.Add('                      and anyo_ec = year(fecha_sl) and mes_ec = month(fecha_sl) ');
    Sql.Add('                      and producto_ec = producto_sl ');
    Sql.Add('                      and envase_ec = envase_sl ');
    Sql.Add('                    ) * kilos_sl, 2 ) ) material, ');
    Sql.Add('        sum( round( ( select secciones_ec ');
    Sql.Add('                      from frf_env_costes ');
    Sql.Add('                      where empresa_ec = empresa_sl ');
    Sql.Add('                      and centro_ec = centro_salida_sl ');
    Sql.Add('                      and anyo_ec = year(fecha_sl) and mes_ec = month(fecha_sl) ');
    Sql.Add('                      and producto_ec = producto_sl ');
    Sql.Add('                      and envase_ec = envase_sl ');
    Sql.Add('                    ) * kilos_sl, 2 ) ) secciones ');
    Sql.Add(' from frf_salidas_l ');
    Sql.Add(' where empresa_sl = :empresa ');
    Sql.Add(' and centro_salida_sl = :centro ');
    Sql.Add(' and fecha_sl between :fechaini and :fechafin ');
    SQl.Add(' and producto_sl = :producto ');
    Sql.Add(' and envase_sl = :envase ');

  end;
  with qryRegistroCoste do
  begin
    Sql.Clear;
    Sql.Add(' select costes_promedio_ec grabado_promedio');
    Sql.Add(' from frf_env_costes ');
    Sql.Add(' where empresa_ec = :empresa ');
    Sql.Add(' and centro_ec = :centro ');
    Sql.Add(' and anyo_ec = :year and mes_ec = :mes ');
    Sql.Add(' and producto_ec = :producto ');
    Sql.Add(' and envase_ec = :envase ');
  end;
  with qryActualizaRegsitro do
  begin
    Sql.Clear;
    Sql.Add(' update frf_env_costes  ');
    Sql.Add(' set pcoste_ec = :coste, pmaterial_ec = :material, psecciones_ec = :secciones, costes_promedio_ec = 1');
    Sql.Add(' where empresa_ec = :empresa ');
    Sql.Add(' and centro_ec = :centro ');
    Sql.Add(' and anyo_ec = :year and mes_ec = :mes ');
    Sql.Add(' and producto_ec = :producto ');
    Sql.Add(' and envase_ec = :envase ');
  end;
  with qryEnvaseNuevo do
  begin
    Sql.Clear;
    Sql.Add(' update frf_env_costes  ');
    Sql.Add(' set pcoste_ec = coste_ec, pmaterial_ec = material_ec, psecciones_ec = secciones_ec, costes_promedio_ec = 1');
    Sql.Add(' where empresa_ec = :empresa ');
    Sql.Add(' and centro_ec = :centro ');
    Sql.Add(' and anyo_ec = :year and mes_ec = :mes ');
    Sql.Add(' and producto_ec = :producto ');
    Sql.Add(' and envase_ec = :envase ');
  end;
  with qryPendientes do
  begin
    Sql.Clear;
    Sql.Add(' select * from frf_env_costes');
    Sql.Add(' where costes_promedio_ec = 0 ');
  end;
  with qryEnvasesNuevos do
  begin
    Sql.Clear;
    Sql.Add(' update frf_env_costes  ');
    Sql.Add(' set pcoste_ec = coste_ec, pmaterial_ec = material_ec, psecciones_ec = secciones_ec');
    Sql.Add(' where ( pcoste_ec + pmaterial_ec + psecciones_ec ) = 0 ');
    Sql.Add(' and ( coste_ec + material_ec + secciones_ec ) <> 0 ');
    Sql.Add(' and costes_promedio_ec = 1 ');
  end;
end;

procedure TDMCosteEnvasadoPromedio.DataModuleDestroy(Sender: TObject);
begin
  //
end;

function PromedioPendientes( var VRegistros: Integer ): boolean;
begin
  DMCosteEnvasadoPromedio:= TDMCosteEnvasadoPromedio.Create( Nil );
  try
    VRegistros:= 0;
    Result:= DMCosteEnvasadoPromedio.PromedioPendientes ( VRegistros );
  finally
    FreeAndNil( DMCosteEnvasadoPromedio );
  end;
end;

function TDMCosteEnvasadoPromedio.PromedioPendientes( var VRegistros: Integer ): boolean;
var
  sMsg: string;
begin
  result:= False;
  VRegistros:= 0;
  with qryPendientes do
  begin
    Open;
    try
      if not IsEmpty then
      begin
        result:= True;
        while not Eof do
        begin
          VRegistros:= VRegistros + 1;
          PromedioRegistro( FieldByName('empresa_ec').AsString,FieldByName('centro_ec').AsString,FieldByName('envase_ec').AsString, FieldByName('producto_ec').AsString,
                            FieldByName('producto_base_ec').AsInteger,FieldByName('anyo_ec').AsInteger,FieldByName('mes_ec').AsInteger, 0, sMsg );
          Next;
        end;
      end;
    finally
      Close;
    end;
  end;
  with qryEnvasesNuevos do
  begin
    ExecSQL;
    VRegistros:= VRegistros + RowsAffected;
  end;
  Result:= VRegistros > 0;
end;

//ARecalculate
//0 -> no
//1 -> preguntar
//2 -> recalcular
function PromedioRegistro( const AOwner: TComponent;  const ACompany, ACenter, APack, AProducto: string;
                           const ABaseProduct, AYear, AMonth, ARecalculate:integer; var AMsg: string ): Boolean;
begin
  DMCosteEnvasadoPromedio:= TDMCosteEnvasadoPromedio.Create( AOwner );
  try
    Result:= DMCosteEnvasadoPromedio.PromedioRegistro( ACompany, ACenter, APack, AProducto, ABaseProduct, AYear, AMonth, ARecalculate, AMsg );
    AMsg:= DMCosteEnvasadoPromedio.sMsg;
  finally
    FreeAndNil( DMCosteEnvasadoPromedio );
  end;
end;

procedure TDMCosteEnvasadoPromedio.EnvaseNuevo;
begin
  with qryEnvaseNuevo do
  begin
    ParamByName('empresa').AsString:= sCompany;
    ParamByName('centro').AsString:= sCenter;
    ParamByName('envase').AsString:= sPack;
    ParamByName('year').AsInteger:= iYear;
    ParamByName('mes').AsInteger:= iMonth;
    ParamByName('producto').AsString:= sProducto;
    ExecSQL;
  end;
end;

function TDMCosteEnvasadoPromedio.PromedioRegistro( const ACompany, ACenter, APack, AProducto: string;
                                   const ABaseProduct, AYear, AMonth, ARecalculate:integer; var AMsg: string ): Boolean;
begin
  Result:= True;
  sCompany:= ACompany;
  sCenter:= ACenter;
  sPack:= APack;
  iYear:= AYear;
  iMonth:= AMonth;
  sProducto:=AProducto;
  iBaseProduct:= ABaseProduct;
  iRecalculate:= ARecalculate;
  dFinalDate:= IncMonth( EncodeDate(AYear, AMonth, 1), 1 ) - 1;
  dInitialDate:= IncMonth(dFinalDate, -12) + 1;
  sMsg:= '';

  with qryTotalesAnuales do
  begin
    ParamByName('empresa').AsString:= sCompany;
    ParamByName('centro').AsString:= sCenter;
    ParamByName('envase').AsString:= sPack;
    ParamByName('fechaini').AsDate:= dInitialDate;
    ParamByName('fechafin').AsDate:= dFinalDate;
    ParamByName('producto').AsString:= sProducto;
    Open;
    try
      if FieldByName('kilos').AsFloat = 0 then
      begin
        EnvaseNuevo;
        //Result:= False;
        //sMsg:= 'No hay salidas para el artículo "' + sPack + '" del ' + FormatDateTime('dd/mm/yyyy', dInitialDate) + ' al ' + FormatDateTime('dd/mm/yyyy', dFinalDate) + ' para la empresa ' + sCompany;
      end
      else
      begin
        Result:= GrabarPromedios;
      end;
    finally
      Close;
    end;
  end;
end;

function TDMCosteEnvasadoPromedio.GrabarPromedios: Boolean;
begin
  with qryRegistroCoste do
  begin
    ParamByName('empresa').AsString:= sCompany;
    ParamByName('centro').AsString:= sCenter;
    ParamByName('envase').AsString:= sPack;
    ParamByName('year').AsInteger:= iYear;
    ParamByName('mes').AsInteger:= iMonth;
    ParamByName('producto').AsString:= sProducto;
    Open;
    try
      if IsEmpty then
      begin
        Result:= False;
        sMsg:= 'No hay coste grabado para el artículo "' + sPack + '" año ' + IntToStr( iYear ) + ' y mes ' + IntToStr( iMonth ) + ' para la empresa ' + sCompany;
      end
      else
      begin
        if FieldByName('grabado_promedio').AsInteger > 0 then
        begin
          if iRecalculate = 1 then
          begin
            if MessageDlg('Los promedios para el artículo "' + sPack + '" año ' + IntToStr( iYear ) + ' y mes ' + IntToStr( iMonth ) + ' de la empresa ' + sCompany + ' ya estan grabados.'
                          + #13 + #10 + '¿Seguro que quiere actualizarlos?', mtConfirmation, [mbYes, mbNo] , 0 ) = mrYes then
            begin
              Result:= True;
              ActualizarPromedios;
            end
            else
            begin
             Result:= False;
             sMsg:= 'Proceso cancelado por el usaurio.';
            end;
          end
          else
          if iRecalculate = 2 then
          begin
            Result:= True;
            ActualizarPromedios;
          end;
        end
        else
        begin
          Result:= True;
          ActualizarPromedios;
        end;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TDMCosteEnvasadoPromedio.ActualizarPromedios;
var
  rCoste, rMaterial, rSecciones: Real;
begin
  with qryTotalesAnuales do
  begin
    if FieldByName('kilos').AsFloat > 0 then
    begin
      rCoste:= bRoundTo( FieldByName('coste').AsFloat / FieldByName('kilos').AsFloat, 5 );
      rMaterial:= bRoundTo( FieldByName('material').AsFloat / FieldByName('kilos').AsFloat, 5 );
      rSecciones:= bRoundTo( FieldByName('secciones').AsFloat / FieldByName('kilos').AsFloat, 5 );
    end
    else
    begin
      rCoste:= 0;
      rMaterial:= 0;
      rSecciones:= 0;
    end;
  end;

  with qryActualizaRegsitro do
  begin
    ParamByName('empresa').AsString:= sCompany;
    ParamByName('centro').AsString:= sCenter;
    ParamByName('envase').AsString:= sPack;
    ParamByName('year').AsInteger:= iYear;
    ParamByName('mes').AsInteger:= iMonth;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('coste').AsFloat:= rCoste;
    ParamByName('material').AsFloat:= rMaterial;
    ParamByName('secciones').AsFloat:= rSecciones;
    ExecSQL;
    sMsg:= 'El promedio para el artículo "' + sPack + '" año ' + IntToStr( iYear ) + ' y mes ' + IntToStr( iMonth ) + ' de la empresa ' + sCompany + ' ha sido calculado correctamente.'
  end;
end;


end.

