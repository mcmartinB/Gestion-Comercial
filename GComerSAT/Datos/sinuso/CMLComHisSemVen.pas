unit CMLComHisSemVen;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDMLComHisSemVen = class(TDataModule)
    kbmListado: TkbmMemTable;
    QHistorico: TQuery;
    QMonedaHistorico: TQuery;
    QSoloKilos: TQuery;
    QActual: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    bKilos, bMoneda: boolean;


    procedure PreparaQuerys( const AEmpresa, ACliente, AProducto: string; const ATomate: boolean );
    procedure AnyadeSemana( const ALinea: Integer; AFecha1, AFecha2, AFecha3: TDateTime );
    procedure DatosSemana( const AFecha: TDateTime; var rKilos, rImporte: real );
    procedure DatosSemanaActual(  const AFecha: TDateTime; const AMoneda: string; var rKilos, rImporte: real );
    procedure DatosSemanaHistorica( const AFecha: TDateTime; var rKilos, rImporte: real );
    procedure MonedaHistorico( const AFecha: TDateTime );
  public
    { Public declarations }
    bImporte: Boolean;
    sMoneda: String;

    procedure RellenarTabla( const AEmpresa, ACliente, AProducto: string;
                             const ATomate, AKilos: boolean;
                             const AInicio1, AFin1, AInicio2, AFin2, AInicio3, AFin3: TDateTime );
  end;

var
  DMLComHisSemVen: TDMLComHisSemVen;

implementation

{$R *.dfm}

uses DateUtils, bTimeUtils, bMath, UDMCambioMoneda;

procedure TDMLComHisSemVen.DataModuleCreate(Sender: TObject);
begin
  with kbmListado do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('linea', ftInteger, 0, False);
    FieldDefs.Add('semana', ftString, 2, False);
    FieldDefs.Add('kilos1', ftFloat, 0, False);
    FieldDefs.Add('importe1', ftFloat, 0, False);
    FieldDefs.Add('precio1', ftFloat, 0, False);
    FieldDefs.Add('kilos2', ftFloat, 0, False);
    FieldDefs.Add('importe2', ftFloat, 0, False);
    FieldDefs.Add('precio2', ftFloat, 0, False);
    FieldDefs.Add('kilos3', ftFloat, 0, False);
    FieldDefs.Add('importe3', ftFloat, 0, False);
    FieldDefs.Add('precio3', ftFloat, 0, False);
    FieldDefs.Add('dif_kilos', ftFloat, 0, False);
    FieldDefs.Add('dif_importe', ftFloat, 0, False);
    FieldDefs.Add('dif_precio', ftFloat, 0, False);
    SortFields:= 'linea';
  end;
end;

procedure TDMLComHisSemVen.PreparaQuerys( const AEmpresa, ACliente, AProducto: string; const ATomate: boolean );
begin
  with QHistorico do
  begin
    if Prepared then UnPrepare;
    SQL.Clear;
    SQL.Add('select sum(bultos_he) cajas, sum(kilos_he) kilos, sum(liquido_he) importe');
    SQL.Add('from frf_historico_ext');
    SQL.Add('where empresa_he = ' + QuotedStr(AEmpresa));
    if ATomate then
    begin
      SQL.Add('  and ( producto_he = ''T'' or  producto_he = ''E'' )');
    end
    else
    begin
      SQL.Add('  and producto_he = ' + QuotedStr(AProducto));
    end;
    SQL.Add('  and semana_he = :anyosemana');
    if ACliente <> '' then
    begin
      SQL.Add('  and cliente_he = ' + QuotedStr(ACliente));
    end;
    Prepare;
  end;

  with QMonedaHistorico do
  begin
    if Prepared then UnPrepare;
    SQL.Clear;
    SQL.Add('select moneda_he moneda');
    SQL.Add('from frf_historico_ext');
    SQL.Add('where empresa_he = ' + QuotedStr(AEmpresa));
    if ATomate then
    begin
      SQL.Add('  and ( producto_he = ''T'' or  producto_he = ''E'' )');
    end
    else
    begin
      SQL.Add('  and producto_he = ' + QuotedStr(AProducto));
    end;
    SQL.Add('  and semana_he >= :anyosemana');
    if ACliente <> '' then
    begin
      SQL.Add('  and cliente_he = ' + QuotedStr(ACliente));
    end;
    SQL.Add('group by 1');
    Prepare;
  end;

  with QSoloKilos do
  begin
    if Prepared then UnPrepare;
    SQL.Clear;
    SQL.Add('select sum(cajas_sl) cajas, sum(kilos_sl) kilos');
    SQL.Add('from frf_salidas_l');
    SQL.Add('where empresa_sl = ' + QuotedStr(AEmpresa));
    if ACliente <> '' then
    begin
      SQL.Add('  and cliente_sl = ' + QuotedStr(ACliente));
    end;
    if ATomate then
    begin
      SQL.Add('  and ( producto_sl = ''T'' or  producto_sl = ''E'' )');
    end
    else
    begin
      SQL.Add('  and producto_sl = ' + QuotedStr(AProducto));
    end;
    SQL.Add('and fecha_sl between :fechaini and :fechafin');
    Prepare;
  end;

  with QActual do
  begin
    if Prepared then UnPrepare;
    SQL.Clear;
    SQL.Add('select moneda_sc moneda, fecha_sc fecha, ');
    SQL.Add('       sum(importe_neto_sl) importe, sum(cajas_sl) cajas, sum(kilos_sl) kilos ');
    SQL.Add('from frf_salidas_c, frf_salidas_l');

    SQL.Add('where empresa_sc = ' + QuotedStr(AEmpresa));
    SQL.Add('  and fecha_sc between :fechaini and :fechafin');
    if ACliente <> '' then
    begin
      SQL.Add('  and cliente_sal_sc = ' + QuotedStr(ACliente));
    end;

    SQL.Add('  and empresa_sl = ' + QuotedStr(AEmpresa));
    SQL.Add('  and centro_salida_sl = centro_salida_sc ');
    SQL.Add('  and fecha_sl = fecha_sc ');
    SQL.Add('  and n_albaran_sl = n_albaran_sc ');
    if ATomate then
    begin
      SQL.Add('  and ( producto_sl = ''T'' or  producto_sl = ''E'' )');
    end
    else
    begin
      SQL.Add('  and producto_sl = ' + QuotedStr(AProducto));
    end;
    SQL.Add('group by 1,2 ');
    Prepare;
  end;

end;

procedure TDMLComHisSemVen.DataModuleDestroy(Sender: TObject);
begin
  with QHistorico do
  begin
    if Prepared then UnPrepare;
  end;
  with QMonedaHistorico do
  begin
    if Prepared then UnPrepare;
  end;
  with QSoloKilos do
  begin
    if Prepared then UnPrepare;
  end;
  with QActual do
  begin
    if Prepared then UnPrepare;
  end;
end;

procedure TDMLComHisSemVen.RellenarTabla( const AEmpresa, ACliente, AProducto: string;
                             const ATomate, AKilos: boolean;
                             const AInicio1, AFin1, AInicio2, AFin2, AInicio3, AFin3: TDateTime );
var
  AS1,AS2,AS3: string;
  bFlag: boolean;
  i: integer;
  dFecha1, dFecha2, dFecha3: TDateTime;
begin
  kbmListado.Close;
  kbmListado.Open;

  bKilos:= AKilos;
  bMoneda:= False;
  bImporte:= ACliente <> '';
  PreparaQuerys( AEmpresa, ACliente, AProducto, ATomate );

  i:= 0;

  dFecha1:= AInicio1;
  dFecha2:= AInicio2;
  dFecha3:= AInicio3;

  bFlag:= False;
  while not bFlag do
  begin
    inc( i );
    AS1:= AnyoSemana( dFecha1 );
    AS2:= IncAnyoSemana( AnyoSemana( dFecha2 ), 1 );
    AS3:= IncAnyoSemana( AnyoSemana( dFecha3 ), 2 );
    if AS1 = AS2 then
    begin
      if AS1 = AS3 then
      begin
        (*AS1 = AS2 = AS3*)
        AnyadeSemana( i, dFecha1, dFecha2, dFecha3 );
        dFecha1:= DomingoSiguiente( dFecha1 ) + 1;
        dFecha2:= DomingoSiguiente( dFecha2 ) + 1;
        dFecha3:= DomingoSiguiente( dFecha3 ) + 1;
      end
      else
      begin
        (*AS1 = AS2 <> AS3*)
        if AS1 < AS3 then
        begin
          AnyadeSemana( i, dFecha1, dFecha2, -1 );
          dFecha1:= DomingoSiguiente( dFecha1 ) + 1;
          dFecha2:= DomingoSiguiente( dFecha2 ) + 1;
        end
        else
        begin
          AnyadeSemana( i, -1, -1, dFecha3 );
          dFecha3:= DomingoSiguiente( dFecha3 ) + 1;
        end;
      end;
    end
    else
    begin
      if AS1 = AS3 then
      begin
        (*AS1 = AS3 <> AS2*)
        if AS1 < AS2 then
        begin
          AnyadeSemana( i, dFecha1, -1, dFecha3 );
          dFecha1:= DomingoSiguiente( dFecha1 ) + 1;
          dFecha3:= DomingoSiguiente( dFecha3 ) + 1;
        end
        else
        begin
          AnyadeSemana( i, -1, dFecha2, -1  );
          dFecha2:= DomingoSiguiente( dFecha2 ) + 1;
        end;
      end
      else
      if AS2 = AS3 then
      begin
        (*AS1 <> AS2 = AS3*)
        if AS1 < AS2 then
        begin
          AnyadeSemana( i, dFecha1, -1, -1 );
          dFecha1:= DomingoSiguiente( dFecha1 ) + 1;
        end
        else
        begin
          AnyadeSemana( i, -1, dFecha2, dFecha3 );
          dFecha2:= DomingoSiguiente( dFecha2 ) + 1;
          dFecha3:= DomingoSiguiente( dFecha3 ) + 1;
        end;
      end
      else
      begin
        (*AS1 <> AS2 <> AS3*)
        if AS1 < AS2 then
        begin
          if AS1 < AS3 then
          begin
            AnyadeSemana( i, dFecha1, -1, -1 );
            dFecha1:= DomingoSiguiente( dFecha1 ) + 1;
          end
          else
          begin
            AnyadeSemana( i, -1, -1, dFecha3 );
            dFecha3:= DomingoSiguiente( dFecha3 ) + 1;
          end;
        end
        else
        begin
          if AS2 < AS3 then
          begin
            AnyadeSemana( i, -1, dFecha2, -1 );
            dFecha2:= DomingoSiguiente( dFecha2 ) + 1;
          end
          else
          begin
            AnyadeSemana( i, -1, -1, dFecha3 );
            dFecha3:= DomingoSiguiente( dFecha3 ) + 1;
          end;
        end;
      end;
    end;
    bFlag:= not ( ( dFecha1 < AFin1 ) or ( dFecha2 < AFin2 ) or ( dFecha3 < AFin3 ) );
  end;
  kbmListado.Sort([]);

  //Calculamos precios y diferncias entre los dos ultimos años
  kbmListado.First;
  while not kbmListado.Eof do
  begin
    kbmListado.Edit;

    if kbmListado.FieldByName('kilos1').AsFloat = 0 then
      kbmListado.FieldByName('precio1').AsFloat:= 0
    else
      kbmListado.FieldByName('precio1').AsFloat:= bRoundTo( kbmListado.FieldByName('importe1').AsFloat / kbmListado.FieldByName('kilos1').AsFloat, -3 );

    if kbmListado.FieldByName('kilos2').AsFloat = 0 then
      kbmListado.FieldByName('precio2').AsFloat:= 0
    else
      kbmListado.FieldByName('precio2').AsFloat:= bRoundTo( kbmListado.FieldByName('importe2').AsFloat / kbmListado.FieldByName('kilos2').AsFloat, -3 );

    if kbmListado.FieldByName('kilos3').AsFloat = 0 then
      kbmListado.FieldByName('precio3').AsFloat:= 0
    else
      kbmListado.FieldByName('precio3').AsFloat:= bRoundTo( kbmListado.FieldByName('importe3').AsFloat / kbmListado.FieldByName('kilos3').AsFloat, -3 );

    kbmListado.FieldByName('dif_kilos').AsFloat:= kbmListado.FieldByName('kilos1').AsFloat - kbmListado.FieldByName('kilos2').AsFloat;
    kbmListado.FieldByName('dif_importe').AsFloat:= kbmListado.FieldByName('importe1').AsFloat - kbmListado.FieldByName('importe2').AsFloat;
    kbmListado.FieldByName('dif_precio').AsFloat:= kbmListado.FieldByName('precio1').AsFloat - kbmListado.FieldByName('precio2').AsFloat;

    kbmListado.Post;

    kbmListado.Next;
  end;
  kbmListado.First;
end;

procedure TDMLComHisSemVen.AnyadeSemana( const ALinea: Integer; AFecha1, AFecha2, AFecha3: TDateTime );
var
  rKilos, rImporte: Real;
begin
  with kbmListado do
  begin
    Insert;
    FieldByName('linea').AsInteger:= ALinea;

    if AFecha1 <> -1 then
    begin
      FieldByName('semana').AsString:= Copy( AnyoSemana( AFecha1 ), 5, 2);
    end
    else
    begin
      if AFecha2 <> -1 then
      begin
        FieldByName('semana').AsString:= Copy( AnyoSemana( AFecha2 ), 5, 2);
      end
      else
      begin
        FieldByName('semana').AsString:= Copy( AnyoSemana( AFecha3 ), 5, 2);
      end;
    end;

    //Primero la fecha mas baja, para sacar correctamente la moneda del historico
    if AFecha3 <> -1 then
    begin
      DatosSemana( AFecha3, rKilos, rImporte );
      FieldByName('kilos3').AsFloat:= rKilos;
      FieldByName('importe3').AsFloat:= rImporte;
    end
    else
    begin
      FieldByName('kilos3').AsFloat:= 0;
      FieldByName('importe3').AsFloat:= 0;
    end;

    if AFecha2 <> -1 then
    begin
      DatosSemana( AFecha2, rKilos, rImporte );
      FieldByName('kilos2').AsFloat:= rKilos;
      FieldByName('importe2').AsFloat:= rImporte;
    end
    else
    begin
      FieldByName('kilos2').AsFloat:= 0;
      FieldByName('importe2').AsFloat:= 0;
    end;

    if AFecha1 <> -1 then
    begin
      DatosSemana( AFecha1, rKilos, rImporte );
      FieldByName('kilos1').AsFloat:= rKilos;
      FieldByName('importe1').AsFloat:= rImporte;
    end
    else
    begin
      FieldByName('kilos1').AsFloat:= 0;
      FieldByName('importe1').AsFloat:= 0;
    end;
    Post;
  end;
end;

procedure TDMLComHisSemVen.MonedaHistorico( const AFecha: TDateTime );
var
  i: integer;
begin
  if bImporte then
  begin
    if AFecha < StrToDate('1/1/2001') then
    begin
      with QMonedaHistorico do
      begin
        ParamByName('anyosemana').AsString:= AnyoSemana( AFecha );
        Open;
        i:= 0;
        while not eof do
        begin
          inc(i);
          Next;
        end;
        case i of
          0://sin datos en el historico, mostrar datos actuales como EUROS
          begin
            sMoneda:= 'EUR';
          end;
          1://OK
          begin
            sMoneda:= FieldByName('moneda').AsString;
          end ;
          else //Mas de una moneda en el historico, sin cambio, solo kilos
          begin
            sMoneda:= '';
            bImporte:= False;
          end;
        end;
        Close;
      end;
    end
    else
    begin
      //Datos actuales en euros
      sMoneda:= 'EUR';
    end;
  end
  else
  begin
    //Si no hay importe no es necesaria la moneda
    sMoneda:= '';
  end;
  bMoneda:= True;
end;

procedure TDMLComHisSemVen.DatosSemana(  const AFecha: TDateTime; var rKilos, rImporte: real );
begin
  if not bMoneda then
  begin
    MonedaHistorico( AFecha );
  end;

  if AFecha < StrToDate('1/1/2001') then
  begin
    DatosSemanaHistorica( AFecha, rKilos, rImporte );
  end
  else
  begin
    DatosSemanaActual( AFecha, sMoneda, rKilos, rImporte );
  end;
end;

procedure TDMLComHisSemVen.DatosSemanaHistorica(  const AFecha: TDateTime; var rKilos, rImporte: real );
begin
  with QHistorico do
  begin
    ParamByName('anyosemana').AsString:= AnyoSemana( AFecha );
    Open;

    if bKilos then
      rKilos:= FieldByName('kilos').AsFloat
    else
      rKilos:= FieldByName('cajas').AsFloat;

    if bImporte then
      rImporte:= FieldByName('importe').AsFloat
    else
      rImporte:= 0;

    Close;
  end;
end;

procedure TDMLComHisSemVen.DatosSemanaActual(  const AFecha: TDateTime; const AMoneda: string; var rKilos, rImporte: real );
var
  dDesde, dHasta: TDateTime;
begin
  dDesde:= AFecha;
  dHasta:= DomingoSiguiente( dDesde );
  if bImporte then
  begin
    rKilos:= 0;
    rImporte:= 0;
    with QActual do
    begin
      ParamByName('fechaini').AsDate:= dDesde;
      ParamByName('fechafin').AsDate:= dHasta;
      Open;
      while not EOF do
      begin
        if bKilos then
          rKilos:= rKilos + FieldByName('kilos').AsFloat
        else
          rKilos:= rKilos + FieldByName('cajas').AsFloat;
        if FieldByName('moneda').AsString <> sMoneda then
        begin
          rImporte:= rImporte + ChangeMoney( FieldByName('moneda').AsString, sMoneda,
                         FieldByName('fecha').AsDateTime, FieldByName('importe').AsFloat );
        end
        else
        begin
          rImporte:= rImporte + FieldByName('importe').AsFloat;
        end;
        Next;
      end;
      Close;
    end;
  end
  else
  begin
    with QSoloKilos do
    begin
      ParamByName('fechaini').AsDate:= dDesde;
      ParamByName('fechafin').AsDate:= dHasta;
      Open;
      if bKilos then
        rKilos:= rKilos + FieldByName('kilos').AsFloat
      else
        rKilos:= rKilos + FieldByName('cajas').AsFloat;
      Close;
    end;
    rImporte:= 0;
  end;
end;

end.

