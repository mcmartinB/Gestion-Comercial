unit UDMTransitos;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMTransitos = class(TDataModule)
    QKilosTransito: TQuery;
    QKilosDeposito: TQuery;
    qKilosVenta: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PesosTransito( const AEmpresa, ACentro: string; const AReferencia: integer; const AFecha: TDateTime; var ANeto, ABruto: real );
    procedure PesosVenta( const AEmpresa, ACentro: string; const AReferencia: integer; const AFecha: TDateTime; var ANeto, ABruto: real );
    procedure PesosTransitoDeposito( const AEmpresa, ACentro: string; const AReferencia: integer; const AFecha: TDateTime; var ANeto, ABruto: real );
    procedure PesosVentaDeposito( const AEmpresa, ACentro: string; const AReferencia: integer; const AFecha: TDateTime; var ANeto, ABruto: real );
    function  PesosBrutoDeposito( const AEmpresa, ACentro: string; const AReferencia: integer; const AFecha: TDateTime ): integer;
  end;

  procedure CreateDMTransitos( AOwner: TComponent );
  procedure DestroyDMTransitos;

var
  DMTransitos: TDMTransitos;

implementation

{$R *.dfm}

uses
  UDMEnvases, bMath, Dialogs;


var
  i: integer = 0;

procedure CreateDMTransitos( AOwner: TComponent );
begin
  if i = 0 then
    DMTransitos:= TDMTransitos.Create( AOwner );
  inc( i );
end;

procedure DestroyDMTransitos;
begin
  Dec( i );
  if i = 0 then
    FreeAndNil( DMTransitos );
end;

procedure TDMTransitos.DataModuleCreate(Sender: TObject);
begin
  UDMEnvases.CreateDMEnvase( self );

  QKilosTransito.SQL.Clear;
  QKilosTransito.SQL.Add(' select empresa_tl,centro_tl,referencia_tl,fecha_tl, envase_comercial_e, ' +
        '        producto_tl,descripcion_p, envase_tl,descripcion_e, tipo_palet_tl, ' +
        '        marca_tl,descripcion_m, categoria_tl,color_tl,calibre_tl, unidades_caja_tl,' +
        '        sum(cajas_tl) cajas_tl, sum(kilos_tl) kilos_tl, sum( palets_tl ) palets ' +
        ' from frf_transitos_l,frf_productos,frf_envases,frf_marcas ' +
        ' where empresa_tl=:empresa ' +
        '  and centro_tl=:centro ' +
        '  and referencia_tl=:referencia ' +
        '  and fecha_tl=:fecha ' +
        '  and producto_tl=producto_p ' +
        '  and marca_tl=codigo_m ' +
        '  and envase_tl=envase_e ' +
        ' group by empresa_tl,centro_tl,referencia_tl,fecha_tl, envase_comercial_e,' +
        '        producto_tl,descripcion_p, tipo_palet_tl, ' +
        '        envase_tl,descripcion_e, marca_tl,descripcion_m, ' +
        '        categoria_tl,color_tl,calibre_tl, unidades_caja_tl ' +
        ' order by producto_tl, marca_tl, envase_comercial_e ');

  qKilosVenta.SQL.Clear;
  qKilosVenta.SQL.Add(' select empresa_sl,centro_salida_sl,n_albaran_sl,fecha_sl, envase_comercial_e, ');
  qKilosVenta.SQL.Add('         producto_sl,descripcion_p, envase_sl,descripcion_e, tipo_palets_sl, ');
  qKilosVenta.SQL.Add('         marca_sl,descripcion_m, categoria_sl,color_sl,calibre_sl, unidades_caja_sl, ');
  qKilosVenta.SQL.Add('         sum(cajas_sl) cajas_sl, sum(kilos_sl) kilos_sl, sum( n_palets_sl ) palets ');
  qKilosVenta.SQL.Add('  from frf_salidas_l,frf_productos,frf_envases,frf_marcas ');
  qKilosVenta.SQL.Add('  where empresa_sl=:empresa ');
  qKilosVenta.SQL.Add('   and centro_salida_sl=:centro ');
  qKilosVenta.SQL.Add('   and n_albaran_sl=:referencia ');
  qKilosVenta.SQL.Add('   and fecha_sl=:fecha ');
  qKilosVenta.SQL.Add('   and producto_sl=producto_p ');
  qKilosVenta.SQL.Add('   and marca_sl=codigo_m ');
  qKilosVenta.SQL.Add('   and envase_sl=envase_e ');
  qKilosVenta.SQL.Add('  group by empresa_sl,centro_salida_sl,n_albaran_sl,fecha_sl, envase_comercial_e, ');
  qKilosVenta.SQL.Add('         producto_sl,descripcion_p, tipo_palets_sl, ');
  qKilosVenta.SQL.Add('         envase_sl,descripcion_e, marca_sl,descripcion_m, ');
  qKilosVenta.SQL.Add('         categoria_sl,color_sl,calibre_sl, unidades_caja_sl ');
  qKilosVenta.SQL.Add('  order by producto_sl, marca_sl, envase_comercial_e ');

      QKilosDeposito.SQL.Clear;
      QKilosDeposito.SQL.Add(' select kilos_netos_dac, kilos_brutos_dac ');
      QKilosDeposito.SQL.Add(' from frf_depositos_aduana_c ');
      QKilosDeposito.SQL.Add(' where empresa_dac = :empresa');
      QKilosDeposito.SQL.Add(' and centro_dac = :centro');
      QKilosDeposito.SQL.Add(' and fecha_dac = :fecha');
      QKilosDeposito.SQL.Add(' and referencia_dac = :referencia');
end;

procedure TDMTransitos.DataModuleDestroy(Sender: TObject);
begin
  UDMEnvases.DestroyDMEnvase;
end;

procedure TDMTransitos.PesosTransito( const AEmpresa, ACentro: string; const AReferencia: integer; const AFecha: TDateTime; var ANeto, ABruto: real );
var
  pesoBruto: real;
  sAux, sAux2: string;
begin
  ANeto:= 0;
  ABruto:= 0;
  pesoBruto:= 0;

      QKilosTransito.ParamByName('empresa').AsString := AEmpresa;
      QKilosTransito.ParamByName('centro').AsString := ACentro;
      QKilosTransito.ParamByName('referencia').AsInteger := AReferencia;
      QKilosTransito.ParamByName('fecha').AsdateTime := AFecha;
      try
        QKilosTransito.Open;
        sAux:= QKilosTransito.FieldByName('producto_tl').AsString +
               QKilosTransito.FieldByName('envase_comercial_e').AsString +
               QKilosTransito.FieldByName('marca_tl').AsString;

        while not QKilosTransito.Eof do
        begin
          ANeto:= ANeto + QKilosTransito.FieldByname('kilos_tl').AsInteger;

          pesoBruto := pesoBruto+ QKilosTransito.FieldByName('kilos_tl').AsFloat +
                     ( QKilosTransito.FieldByName('cajas_tl').AsFloat *
                          DMEnvases.GetPesoEnvase(QKilosTransito.FieldByName('empresa_tl').AsString,
                                        QKilosTransito.FieldByName('envase_tl').AsString, AFecha) );
          if ( QKilosTransito.FieldByName('palets').AsFloat <> 0 ) and  ( QKilosTransito.FieldByName('tipo_palet_tl').AsString <> '' ) then
          begin
            pesoBruto := pesobruto + ( QKilosTransito.FieldByName('palets').AsFloat *  DMEnvases.GetPesoPalet( QKilosTransito.FieldByName('tipo_palet_tl').AsString ) );
          end;


          QKilosTransito.Next;

          sAux2:= QKilosTransito.FieldByName('producto_tl').AsString +
               QKilosTransito.FieldByName('envase_comercial_e').AsString +
               QKilosTransito.FieldByName('marca_tl').AsString;
          if sAux <> sAux2 then
          begin
//            ABruto := ABruto + Trunc( bRoundTo( pesoBruto, 0 ) );
            ABruto := ABruto + pesoBruto;
            sAux:= sAux2;
            pesoBruto:= 0;
          end;
        end;

//        ABruto := ABruto + Trunc( bRoundTo( pesoBruto, 0 ) );
        ABruto := ABruto + pesoBruto;
        QKilosTransito.Close;
      except
        ShowMessage('Problemas al conseguir los pesos del tr�nsito.');
        Exit;
      end;
end;

procedure TDMTransitos.PesosVenta( const AEmpresa, ACentro: string; const AReferencia: integer; const AFecha: TDateTime; var ANeto, ABruto: real );
var
  pesoBruto: real;
  sAux, sAux2: string;
begin
  ANeto:= 0;
  ABruto:= 0;
  pesoBruto:= 0;

      QKilosVenta.ParamByName('empresa').AsString := AEmpresa;
      QKilosVenta.ParamByName('centro').AsString := ACentro;
      QKilosVenta.ParamByName('referencia').AsInteger := AReferencia;
      QKilosVenta.ParamByName('fecha').AsdateTime := AFecha;
      try
        QKilosVenta.Open;
        sAux:= QKilosVenta.FieldByName('producto_sl').AsString +
               QKilosVenta.FieldByName('envase_comercial_e').AsString +
               QKilosVenta.FieldByName('marca_sl').AsString;

        while not QKilosVenta.Eof do
        begin
          ANeto:= ANeto + QKilosVenta.FieldByname('kilos_sl').AsInteger;

          pesoBruto := pesoBruto+ QKilosVenta.FieldByName('kilos_sl').AsFloat +
                     ( QKilosVenta.FieldByName('cajas_sl').AsFloat *
                          DMEnvases.GetPesoEnvase(QKilosVenta.FieldByName('empresa_sl').AsString,
                                        QKilosVenta.FieldByName('envase_sl').AsString, AFecha) );
          if ( QKilosVenta.FieldByName('palets').AsFloat <> 0 ) and  ( QKilosVenta.FieldByName('tipo_palets_sl').AsString <> '' ) then
          begin
            pesoBruto := pesobruto + ( QKilosVenta.FieldByName('palets').AsFloat *  DMEnvases.GetPesoPalet( QKilosVenta.FieldByName('tipo_palets_sl').AsString ) );
          end;


          QKilosVenta.Next;

          sAux2:= QKilosVenta.FieldByName('producto_sl').AsString +
               QKilosVenta.FieldByName('envase_comercial_e').AsString +
               QKilosVenta.FieldByName('marca_sl').AsString;
          if sAux <> sAux2 then
          begin
            ABruto := ABruto + Trunc( bRoundTo( pesoBruto, 0 ) );
            sAux:= sAux2;
            pesoBruto:= 0;
          end;
        end;

        ABruto := ABruto + Trunc( bRoundTo( pesoBruto, 0 ) );
        QKilosVenta.Close;
      except
        on e: exception do
        begin
          ShowMessage('Problemas al conseguir los pesos del tr�nsito.' + #13 + #10 + e.Message );
          Exit;
        end;
      end;
end;

procedure TDMTransitos.PesosTransitoDeposito( const AEmpresa, ACentro: string; const AReferencia: integer; const AFecha: TDateTime; var ANeto, ABruto: real );
var
  iNeto, iBruto: real;
begin
  ANeto:= 0;
  ABruto:= 0;

  QKilosDeposito.ParamByName('empresa').AsString := AEmpresa;
  QKilosDeposito.ParamByName('centro').AsString := ACentro;
  QKilosDeposito.ParamByName('referencia').AsInteger := AReferencia;
  QKilosDeposito.ParamByName('fecha').AsdateTime := AFecha;

  QKilosDeposito.Open;
  ANeto:= QKilosDeposito.FieldByName('kilos_netos_dac').AsInteger;
  ABruto:= QKilosDeposito.FieldByName('kilos_brutos_dac').AsInteger;
  QKilosDeposito.Close;

  if ( ANeto = 0 ) or ( ABruto = 0 ) then
  begin
    PesosTransito(  AEmpresa, ACentro, AReferencia, AFecha, iNeto, iBruto );
    if ANeto = 0 then
      ANeto:= iNeto;
    if ABruto = 0 then
      ABruto:= iBruto;
  end;
end;

procedure TDMTransitos.PesosVentaDeposito( const AEmpresa, ACentro: string; const AReferencia: integer; const AFecha: TDateTime; var ANeto, ABruto: real );
var
  iNeto, iBruto: real;
begin
  ANeto:= 0;
  ABruto:= 0;

  QKilosDeposito.ParamByName('empresa').AsString := AEmpresa;
  QKilosDeposito.ParamByName('centro').AsString := ACentro;
  QKilosDeposito.ParamByName('referencia').AsInteger := AReferencia;
  QKilosDeposito.ParamByName('fecha').AsdateTime := AFecha;

  QKilosDeposito.Open;
  ANeto:= QKilosDeposito.FieldByName('kilos_netos_dac').AsInteger;
  ABruto:= QKilosDeposito.FieldByName('kilos_brutos_dac').AsInteger;
  QKilosDeposito.Close;

  if ( ANeto = 0 ) or ( ABruto = 0 ) then
  begin
    PesosVenta(  AEmpresa, ACentro, AReferencia, AFecha, iNeto, iBruto );
    if ANeto = 0 then
      ANeto:= iNeto;
    if ABruto = 0 then
      ABruto:= iBruto;
  end;
end;

function TDMTransitos.PesosBrutoDeposito( const AEmpresa, ACentro: string; const AReferencia: integer; const AFecha: TDateTime ): integer;
begin
  QKilosDeposito.ParamByName('empresa').AsString := AEmpresa;
  QKilosDeposito.ParamByName('centro').AsString := ACentro;
  QKilosDeposito.ParamByName('referencia').AsInteger := AReferencia;
  QKilosDeposito.ParamByName('fecha').AsdateTime := AFecha;

  QKilosDeposito.Open;
  result:= QKilosDeposito.FieldByName('kilos_brutos_dac').AsInteger;
  QKilosDeposito.Close;
end;


end.
