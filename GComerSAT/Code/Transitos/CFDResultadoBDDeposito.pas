unit CFDResultadoBDDeposito;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DB, DBTables, StdCtrls;

type
  TFDResultadoBDDeposito = class(TForm)
    sgrdResultados: TStringGrid;
    QAux: TQuery;
    btnCerrar: TButton;
    btnBaseDatos: TButton;
    btnInforme: TButton;
    chkIgnorarErrores: TCheckBox;
    procedure btnInformeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnBaseDatosClick(Sender: TObject);
    procedure chkIgnorarErroresClick(Sender: TObject);
  private
    { Private declarations }
    iResult: integer;
    dsAux: TDataSet;

    procedure ComprobarTotales( const AEmpresa, ACentro, APuertoSalida: string; const AFechainicio, AFechafin: TDateTime;
                               const ACarpeta, ATransito: integer; const APlataforma, ASinFacturaEstadistico: boolean );
  public
    { Public declarations }
  end;

  function ComprobarTotalesExec( const AOwner: TComponent; const ATransitos: TDataSet; const AEmpresa, ACentro, APuertoSalida: string;
                                 const AFechainicio, AFechafin: TDateTime; const ACarpeta, ATransito: integer; const APlataforma, ASinFacturaEstadistico: boolean ): integer;

implementation

{$R *.dfm}

uses
  bMath;

var
  FDResultadoBDDeposito: TFDResultadoBDDeposito;

function ComprobarTotalesExec( const AOwner: TComponent; const ATransitos: TDataSet; const AEmpresa, ACentro, APuertoSalida: string;
                               const AFechainicio, AFechafin: TDateTime; const ACarpeta, ATransito: integer; const APlataforma, ASinFacturaEstadistico: boolean ): integer;
begin

  FDResultadoBDDeposito:= TFDResultadoBDDeposito.Create( AOwner );
  try
    with FDResultadoBDDeposito do
    begin
     dsAux:= ATransitos;
     ComprobarTotales( AEmpresa, ACentro, APuertoSalida, AFechainicio, AFechafin, ACarpeta,  ATransito, APlataforma, ASinFacturaEstadistico );
     ShowModal;
     result:= iResult;
    end;
  finally
    FreeAndNil( FDResultadoBDDeposito );
  end;
end;

procedure TFDResultadoBDDeposito.ComprobarTotales( const AEmpresa, ACentro, APuertoSalida: string; const AFechainicio, AFechafin: TDateTime;
                                                  const ACarpeta, ATransito: integer; const APlataforma, ASinFacturaEstadistico: boolean );
var
  bFlag: boolean;
  rAux: real;
  iSalidas: integer;
  rPesoSalidas, rPesoTotal: real;
  rFlete, rRappel, rManipulacion, rMercancia, rCombustible, rSeguridad, rFrigorifico, rPlataforma: real;
  iFlete, iRappel, iManipulacion, iMercancia, iCombustible, iSeguridad, iFrigorifico, iPlataforma: integer;
  rMinFlete, rMinRappel, rMinManipulacion, rMinMercancia, rMinCombustible, rMinSeguridad, rMinFrigorifico, rMinPlataforma: real;
  rKgsFlete, rKgsRappel, rKgsManipulacion, rKgsMercancia, rKgsCombustible, rKgsSeguridad, rKgsFrigorifico, rKgsPlataforma: real;
  rMedFlete, rMedRappel, rMedManipulacion, rMedMercancia, rMedCombustible, rMedSeguridad, rMedFrigorifico, rMedPlataforma: real;
  rMaxFlete, rMaxRappel, rMaxManipulacion, rMaxMercancia, rMaxCombustible, rMaxSeguridad, rMaxFrigorifico, rMaxPlataforma: real;
begin
  bFlag:= true;

  iSalidas:= 0;
  rPesoSalidas:= 0;

  rFlete:=0;
  rRappel:=0;
  rManipulacion:=0;
  rMercancia:=0;
  rCombustible:=0;
  rSeguridad:=0;
  rFrigorifico:=0;
  rPlataforma:=0;

  iFlete:=0;
  iRappel:=0;
  iManipulacion:=0;
  iMercancia:=0;
  iCombustible:=0;
  iSeguridad:=0;
  iFrigorifico:=0;
  iPlataforma:=0;

  rKgsFlete:= 0;
  rKgsRappel:= 0;
  rKgsManipulacion:= 0;
  rKgsMercancia:= 0;
  rKgsCombustible:= 0;
  rKgsSeguridad:= 0;
  rKgsFrigorifico:= 0;
  rKgsPlataforma:= 0;

  rMinFlete:= 0;
  rMinRappel:= 0;
  rMinManipulacion:= 0;
  rMinMercancia:= 0;
  rMinCombustible:= 0;
  rMinSeguridad:= 0;
  rMinFrigorifico:= 0;
  rMinPlataforma:= 0;

  rMaxFlete:= 0;
  rMaxRappel:= 0;
  rMaxManipulacion:= 0;
  rMaxMercancia:= 0;
  rMaxCombustible:= 0;
  rMaxSeguridad:= 0;
  rMaxFrigorifico:= 0;
  rMaxPlataforma:= 0;

  dsAux.First;
  while not dsAux.Eof do
  begin
    iSalidas:= iSalidas + 1;
    rPesoSalidas:= rPesoSalidas + dsAux.FieldByName('peso_neto').AsFloat;

    if dsAux.FieldByName('flete').AsFloat <> 0 then
    begin
      iFlete:= iFlete + 1;
      rKgsFlete:= rKgsFlete + dsAux.FieldByName('peso_neto').AsFloat;
      rflete:=rflete + dsAux.FieldByName('flete').AsFloat;
      if dsAux.FieldByName('peso_neto').AsFloat > 0 then
      begin
        rAux:= bRoundTo( dsAux.FieldByName('flete').AsFloat / dsAux.FieldByName('peso_neto').AsFloat, 3);
        if rMinFlete = 0 then
        begin
          rMinFlete:= rAux;
        end
        else
        begin
          if rAux <  rMinFlete then
          begin
            rMinFlete:= rAux;
          end;
        end;
        if rAux >  rMaxFlete then
        begin
          rMaxFlete:= rAux;
        end;
      end;
    end;

    if dsAux.FieldByName('dto_rappel').AsFloat <> 0 then
    begin
      iRappel:= iRappel + 1;
      rKgsRappel:= rKgsRappel + dsAux.FieldByName('peso_neto').AsFloat;
      rrappel:=rrappel + dsAux.FieldByName('dto_rappel').AsFloat;
      if dsAux.FieldByName('peso_neto').AsFloat > 0 then
      begin
        rAux:= bRoundTo( dsAux.FieldByName('dto_rappel').AsFloat / dsAux.FieldByName('peso_neto').AsFloat, 3);
        if rMinRappel = 0 then
        begin
          rMinRappel:= rAux;
        end
        else
        begin
          if rAux <  rMinRappel then
          begin
            rMinRappel:= rAux;
          end;
        end;
        if rAux >  rMaxRappel then
        begin
          rMaxRappel:= rAux;
        end;
      end;
    end;

    if dsAux.FieldByName('coste_manipulacion_thc').AsFloat <> 0 then
    begin
      iManipulacion:= iManipulacion + 1;
      rKgsManipulacion:= rKgsManipulacion + dsAux.FieldByName('peso_neto').AsFloat;
      rmanipulacion:=rmanipulacion + dsAux.FieldByName('coste_manipulacion_thc').AsFloat;
      if dsAux.FieldByName('peso_neto').AsFloat > 0 then
      begin
        rAux:= bRoundTo( dsAux.FieldByName('coste_manipulacion_thc').AsFloat / dsAux.FieldByName('peso_neto').AsFloat, 3);
        if rMinManipulacion = 0 then
        begin
          rMinManipulacion:= rAux;
        end
        else
        begin
          if rAux <  rMinManipulacion then
          begin
            rMinManipulacion:= rAux;
          end;
        end;
        if rAux >  rMaxManipulacion then
        begin
          rMaxManipulacion:= rAux;
        end;
      end;
    end;

    if dsAux.FieldByName('tasa_mercancia_t3').AsFloat <> 0 then
    begin
      iMercancia:= iMercancia + 1;
      rKgsMercancia:= rKgsMercancia + dsAux.FieldByName('peso_neto').AsFloat;
      rmercancia:=rmercancia + dsAux.FieldByName('tasa_mercancia_t3').AsFloat;
      if dsAux.FieldByName('peso_neto').AsFloat > 0 then
      begin
        rAux:= bRoundTo( dsAux.FieldByName('tasa_mercancia_t3').AsFloat / dsAux.FieldByName('peso_neto').AsFloat, 3);
        if rMinMercancia = 0 then
        begin
          rMinMercancia:= rAux;
        end
        else
        begin
          if rAux <  rMinMercancia then
          begin
            rMinMercancia:= rAux;
          end;
        end;
        if rAux >  rMaxMercancia then
        begin
          rMaxMercancia:= rAux;
        end;
      end;
    end;

    if dsAux.FieldByName('rec_combustible_baf').AsFloat <> 0 then
    begin
      iCombustible:= iCombustible + 1;
      rKgsCombustible:= rKgsCombustible + dsAux.FieldByName('peso_neto').AsFloat;
      rcombustible:=rcombustible + dsAux.FieldByName('rec_combustible_baf').AsFloat;
      if dsAux.FieldByName('peso_neto').AsFloat > 0 then
      begin
        rAux:= bRoundTo( dsAux.FieldByName('rec_combustible_baf').AsFloat / dsAux.FieldByName('peso_neto').AsFloat, 3);
        if rMinCombustible = 0 then
        begin
          rMinCombustible:= rAux;
        end
        else
        begin
          if rAux <  rMinCombustible then
          begin
            rMinCombustible:= rAux;
          end;
        end;
        if rAux >  rMaxCombustible then
        begin
          rMaxCombustible:= rAux;
        end;
      end;
    end;

    if dsAux.FieldByName('tasas_seguridad').AsFloat <> 0 then
    begin
      iSeguridad:= iSeguridad + 1;
      rKgsSeguridad:= rKgsSeguridad + dsAux.FieldByName('peso_neto').AsFloat;
      rseguridad:=rseguridad + dsAux.FieldByName('tasas_seguridad').AsFloat;
      if dsAux.FieldByName('peso_neto').AsFloat > 0 then
      begin
        rAux:= bRoundTo( dsAux.FieldByName('tasas_seguridad').AsFloat / dsAux.FieldByName('peso_neto').AsFloat, 3);
        if rMinSeguridad = 0 then
        begin
          rMinSeguridad:= rAux;
        end
        else
        begin
          if rAux <  rMinSeguridad then
          begin
            rMinSeguridad:= rAux;
          end;
        end;
        if rAux >  rMaxSeguridad then
        begin
          rMaxSeguridad:= rAux;
        end;
      end;
    end;

    if dsAux.FieldByName('alquiler_frigorifico').AsFloat <> 0 then
    begin
      iFrigorifico:= iFrigorifico + 1;
      rKgsFrigorifico:= rKgsFrigorifico + dsAux.FieldByName('peso_neto').AsFloat;
      rfrigorifico:=rfrigorifico + dsAux.FieldByName('alquiler_frigorifico').AsFloat;
      if dsAux.FieldByName('peso_neto').AsFloat > 0 then
      begin
        rAux:= bRoundTo( dsAux.FieldByName('alquiler_frigorifico').AsFloat / dsAux.FieldByName('peso_neto').AsFloat, 3);
        if rMinFrigorifico = 0 then
        begin
          rMinFrigorifico:= rAux;
        end
        else
        begin
          if rAux <  rMinFrigorifico then
          begin
            rMinFrigorifico:= rAux;
          end;
        end;
        if rAux >  rMaxFrigorifico then
        begin
          rMaxFrigorifico:= rAux;
        end;
      end;
    end;

    if dsAux.FieldByName('alquiler_frigorifico_dda_ue').AsFloat <> 0 then
    begin
      iPlataforma:= iPlataforma + 1;
      rKgsPlataforma:= rKgsPlataforma + dsAux.FieldByName('peso_neto').AsFloat;
      rplataforma:=rplataforma + dsAux.FieldByName('alquiler_frigorifico_dda_ue').AsFloat;
      if dsAux.FieldByName('peso_neto').AsFloat > 0 then
      begin
        rAux:= bRoundTo( dsAux.FieldByName('alquiler_frigorifico_dda_ue').AsFloat / dsAux.FieldByName('peso_neto').AsFloat, 3);
        if rMinPlataforma = 0 then
        begin
          rMinPlataforma:= rAux;
        end
        else
        begin
          if rAux <  rMinPlataforma then
          begin
            rMinPlataforma:= rAux;
          end;
        end;
        if rAux >  rMaxPlataforma then
        begin
          rMaxPlataforma:= rAux;
        end;
      end;
    end;
    dsAux.Next;
  end;
  dsAux.First;

  if rKgsFlete > 0 then
  begin
   rMedFlete:= bRoundTo( rFlete / rKgsFlete, 3 );
  end
  else
  begin
    rMedFlete:= 0;
  end;
  if rKgsRappel > 0 then
  begin
   rMedRappel:= bRoundTo( rRappel / rKgsRappel, 3 );
  end
  else
  begin
    rMedRappel:= 0;
  end;
  if rKgsManipulacion > 0 then
  begin
   rMedManipulacion:= bRoundTo( rManipulacion / rKgsManipulacion, 3 );
  end
  else
  begin
    rMedManipulacion:= 0;
  end;
  if rKgsMercancia > 0 then
  begin
   rMedMercancia:= bRoundTo( rMercancia / rKgsMercancia, 3 );
  end
  else
  begin
    rMedMercancia:= 0;
  end;
  if rKgsCombustible > 0 then
  begin
   rMedCombustible:= bRoundTo( rCombustible / rKgsCombustible, 3 );
  end
  else
  begin
    rMedCombustible:= 0;
  end;
  if rKgsSeguridad > 0 then
  begin
   rMedSeguridad:= bRoundTo( rSeguridad / rKgsSeguridad, 3 );
  end
  else
  begin
    rMedSeguridad:= 0;
  end;
  if rKgsFrigorifico > 0 then
  begin
   rMedFrigorifico:= bRoundTo( rFrigorifico / rKgsFrigorifico, 3 );
  end
  else
  begin
    rMedFrigorifico:= 0;
  end;
  if rKgsPlataforma > 0 then
  begin
   rMedPlataforma:= bRoundTo( rPlataforma / rKgsPlataforma, 3 );
  end
  else
  begin
    rMedPlataforma:= 0;
  end;


  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('   sum( kilos_das ) peso_neto ');
    SQL.Add(' from frf_transitos_c, frf_depositos_aduana_c, frf_depositos_aduana_sal ');
    SQL.Add(' where empresa_tc= :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    if ACarpeta <> -1 then
      SQL.Add(' and carpeta_deposito_tc = :carpeta ');
    SQL.Add(' and fecha_tc between :fechaini and :fechafin ');
    if ATransito <> -1 then
      SQL.Add(' and referencia_tc = :transito ');
    SQL.Add(' and empresa_dac = :empresa ');
    SQL.Add(' and centro_dac = :centro ');
    SQL.Add(' and fecha_dac = fecha_tc ');
    SQL.Add(' and referencia_dac = referencia_tc ');
    if APuertoSalida <> '' then
      SQL.Add(' and puerto_salida_dac = :puerto_salida ');
    SQL.Add(' and codigo_dac = codigo_das ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if APuertoSalida <> '' then
      ParamByName('puerto_salida').AsString:= APuertoSalida;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;
    if ACarpeta <> -1 then
    begin
      ParamByName('carpeta').AsInteger:= ACarpeta;
    end;
    if ATransito <> -1 then
    begin
      ParamByName('transito').AsInteger:= ATransito;
    end;
    Open;
    rPesoTotal:= FieldByName('peso_neto').AsFloat;
    Close;

    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('   sum( ( select sum( kilos_tl ) from frf_transitos_l ');
    SQL.Add('          where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('           and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) ) peso_neto ');
    SQL.Add(' from frf_transitos_c, frf_depositos_aduana_c ');
    SQL.Add(' where empresa_tc= :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc between :fechaini and :fechafin ');
    if ACarpeta <> -1 then
      SQL.Add(' and carpeta_deposito_tc = :carpeta ');
    if ATransito <> -1 then
      SQL.Add(' and referencia_tc = :transito ');
    SQL.Add(' and empresa_dac = :empresa ');
    SQL.Add(' and centro_dac = :centro ');
    SQL.Add(' and referencia_dac = referencia_tc ');
    SQL.Add(' and fecha_dac = fecha_tc ');
    if APuertoSalida <> '' then
      SQL.Add(' and puerto_salida_dac = :puerto_salida ');    
    SQL.Add(' and not exists ( select * from frf_depositos_aduana_l where codigo_dac = codigo_dal ) ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if APuertoSalida <> '' then
      ParamByName('puerto_salida').AsString:= APuertoSalida;    
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;
    if ACarpeta <> -1 then
    begin
      ParamByName('carpeta').AsInteger:= ACarpeta;
    end;
    if ATransito <> -1 then
    begin
      ParamByName('transito').AsInteger:= ATransito;
    end;
    Open;
    rPesoTotal:= rPesoTotal + FieldByName('peso_neto').AsFloat;
    Close;

    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('       sum( ( select sum( kilos_tl ) from frf_transitos_l ');
    SQL.Add('              where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('              and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) ) neto, ');
    SQL.Add('       sum( flete_dac ) flete, ');
    SQL.Add('       sum( rappel_dac ) rappel, ');
    SQL.Add('       sum( manipulacion_dac ) manipulacion, ');
    SQL.Add('       sum( mercancia_dac ) mercancia, ');
    SQL.Add('       sum( combustible_dac ) combustible, ');
    SQL.Add('       sum( seguridad_dac ) seguridad, ');
    SQL.Add('       sum( frigorifico_dac ) frigorifico, ');

    if APlataforma then
    begin
      SQL.Add('       sum( ( select sum( case when nvl(n_factura_das,'''') <> ''''  then frigorifico_das else kilos_das * ');

      SQL.Add('                               case when  es_transito_das = 0 ');
      SQL.Add('                                     then ( select nvl(fob_plataforma_p,0)  ');
      SQL.Add('                                            from frf_salidas_c, frf_clientes, frf_paises ');
      SQL.Add('                                            where empresa_sc = empresa_das and centro_salida_sc = centro_salida_das ');
      SQL.Add('                                            and fecha_sc = fecha_das  and n_albaran_sc = n_albaran_das ');
      if not ASinFacturaEstadistico then
        SQL.Add('                                            and n_factura_sc is not null and porte_bonny_sc = 0 ');
      SQL.Add('                                            and empresa_c = empresa_sc and cliente_c = cliente_sal_sc  ');
      SQL.Add('                                            and pais_p = pais_c  ) ');
      SQL.Add('                                     else ( select nvl(fob_plataforma_p,0)');
      SQL.Add('                                            from frf_transitos_c, frf_centros, frf_paises');
      SQL.Add('                                            where empresa_tc = empresa_das and centro_tc = centro_salida_das');
      SQL.Add('                                            and fecha_tc = fecha_das  and referencia_tc = n_albaran_das');
      if not ASinFacturaEstadistico then
        SQL.Add('                                            and porte_bonny_tc = 0 ');
      SQL.Add('                                            and empresa_c = empresa_tc and centro_c = centro_destino_tc');
      SQL.Add('                                            and pais_p = pais_c ) ');
      SQL.Add('                                end ');
      SQL.Add('                          end ) ');

      SQL.Add('             from frf_depositos_aduana_sal ');
      SQL.Add('             where codigo_dac = codigo_das ) ) plataforma ');
    end
    else
    begin
      SQL.Add('             0 plataforma ');
    end;


    SQL.Add(' from frf_transitos_c, frf_depositos_aduana_c ');
    SQL.Add(' where empresa_dac= :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc between :fechaini and :fechafin ');
    if ACarpeta <> -1 then
      SQL.Add(' and carpeta_deposito_tc = :carpeta ');
    if ATransito <> -1 then
      SQL.Add(' and referencia_tc = :transito ');
    SQL.Add(' and empresa_dac = :empresa ');
    SQL.Add(' and centro_dac = :centro ');
    SQL.Add(' and referencia_dac = referencia_tc ');
    SQL.Add(' and fecha_dac = fecha_tc ');
    if APuertoSalida <> '' then
      SQL.Add(' and puerto_salida_dac = :puerto_salida ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if APuertoSalida <> '' then
      ParamByName('puerto_salida').AsString:= APuertoSalida;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;
    if ACarpeta <> -1 then
    begin
      ParamByName('carpeta').AsInteger:= ACarpeta;
    end;
    if ATransito <> -1 then
    begin
      ParamByName('transito').AsInteger:= ATransito;
    end;
    Open;

    //Rellenar rejilla
    //sgrdResultados.ColCount:= 8;
    //sgrdResultados.RowCount:= 10;
    sgrdResultados.Cells[0,0] := '';
    sgrdResultados.Cells[1,0] := 'Estado';
    sgrdResultados.Cells[2,0] := 'Total';
    sgrdResultados.Cells[3,0] := 'Sum(Linea)';
    sgrdResultados.Cells[4,0] := 'Ceros';
    sgrdResultados.Cells[5,0] := 'Minimo';
    sgrdResultados.Cells[6,0] := 'Media';
    sgrdResultados.Cells[7,0] := 'Maximo';

    //PESO
    sgrdResultados.Cells[0,1] := 'Peso';
    if abs( rPesoTotal - rPesoSalidas ) > 0.9 then
    begin
      bFlag:= False;
      sgrdResultados.Cells[1,1] := 'ERROR';
      sgrdResultados.Cells[2,1] := FloatToStr( rPesoTotal );
      sgrdResultados.Cells[3,1] := FloatToStr( rPesoSalidas );
    end
    else
    begin
      sgrdResultados.Cells[1,1] := 'OK';
      sgrdResultados.Cells[2,1] := FloatToStr( rPesoTotal );
      sgrdResultados.Cells[3,1] := '';
    end;
    sgrdResultados.Cells[4,1] := '';
    sgrdResultados.Cells[5,1] := '';
    sgrdResultados.Cells[6,1] := '';
    sgrdResultados.Cells[7,1] := '';

    //FLETE
    sgrdResultados.Cells[0,2] := 'Flete';
    if abs( rFlete - FieldByName('flete').AsFloat ) > 0.9 then
    begin
      bFlag:= False;
      sgrdResultados.Cells[1,2] := 'ERROR';
      sgrdResultados.Cells[2,2] := FieldByName('flete').AsString;
      sgrdResultados.Cells[3,2] := FloatToStr( rFlete );
    end
    else
    begin
      sgrdResultados.Cells[1,2] := 'OK';
      sgrdResultados.Cells[2,2] := FieldByName('flete').AsString;
      sgrdResultados.Cells[3,2] := '';
    end;
    sgrdResultados.Cells[4,2] := IntToStr( iSalidas - iFlete );
    sgrdResultados.Cells[5,2] := FloatToStr( rMinFlete );
    sgrdResultados.Cells[6,2] := FloatToStr( rMedFlete );
    sgrdResultados.Cells[7,2] := FloatToStr( rMaxFlete );

    //RAPPEL
    sgrdResultados.Cells[0,3] := 'Rappel';
    if abs( rRappel - FieldByName('rappel').AsFloat ) > 0.9 then
    begin
      bFlag:= False;
      sgrdResultados.Cells[1,3] := 'ERROR';
      sgrdResultados.Cells[2,3] := FieldByName('rappel').AsString;
      sgrdResultados.Cells[3,3] := FloatToStr( rRappel );
    end
    else
    begin
      sgrdResultados.Cells[1,3] := 'OK';
      sgrdResultados.Cells[2,3] := FieldByName('rappel').AsString;
      sgrdResultados.Cells[3,3] := '';
    end;
    sgrdResultados.Cells[4,3] := IntToStr( iSalidas - iRappel );
    sgrdResultados.Cells[5,3] := FloatToStr( rMinRappel );
    sgrdResultados.Cells[6,3] := FloatToStr( rMedRappel );
    sgrdResultados.Cells[7,3] := FloatToStr( rMaxRappel );


    //MANIPULACION
    sgrdResultados.Cells[0,4] := 'Manipula';
    if abs( rManipulacion - FieldByName('manipulacion').AsFloat ) > 0.9 then
    begin
      bFlag:= False;
      sgrdResultados.Cells[1,4] := 'ERROR';
      sgrdResultados.Cells[2,4] := FieldByName('manipulacion').AsString;
      sgrdResultados.Cells[3,4] := FloatToStr( rManipulacion );
    end
    else
    begin
      sgrdResultados.Cells[1,4] := 'OK';
      sgrdResultados.Cells[2,4] := FieldByName('manipulacion').AsString;
      sgrdResultados.Cells[3,4] := '';
    end;
    sgrdResultados.Cells[4,4] := IntToStr( iSalidas - iManipulacion );
    sgrdResultados.Cells[5,4] := FloatToStr( rMinManipulacion );
    sgrdResultados.Cells[6,4] := FloatToStr( rMedManipulacion );
    sgrdResultados.Cells[7,4] := FloatToStr( rMaxManipulacion );


    //Mercancia
    sgrdResultados.Cells[0,5] := 'Mercancia';
    if abs( rMercancia - FieldByName('mercancia').AsFloat ) > 0.9 then
    begin
      bFlag:= False;
      sgrdResultados.Cells[1,5] := 'ERROR';
      sgrdResultados.Cells[2,5] := FieldByName('mercancia').AsString;
      sgrdResultados.Cells[3,5] := FloatToStr( rMercancia );
    end
    else
    begin
      sgrdResultados.Cells[1,5] := 'OK';
      sgrdResultados.Cells[2,5] := FieldByName('mercancia').AsString;
      sgrdResultados.Cells[3,5] := '';
    end;
    sgrdResultados.Cells[4,5] := IntToStr( iSalidas - iMercancia );
    sgrdResultados.Cells[5,5] := FloatToStr( rMinMercancia );
    sgrdResultados.Cells[6,5] := FloatToStr( rMedMercancia );
    sgrdResultados.Cells[7,5] := FloatToStr( rMaxMercancia );


    //Combustible
    sgrdResultados.Cells[0,6] := 'Combustible';
    if abs( rCombustible - FieldByName('combustible').AsFloat ) > 0.9 then
    begin
      bFlag:= False;
      sgrdResultados.Cells[1,6] := 'ERROR';
      sgrdResultados.Cells[2,6] := FieldByName('combustible').AsString;
      sgrdResultados.Cells[3,6] := FloatToStr( rCombustible );
    end
    else
    begin
      sgrdResultados.Cells[1,6] := 'OK';
      sgrdResultados.Cells[2,6] := FieldByName('combustible').AsString;
      sgrdResultados.Cells[3,6] := '';
    end;
    sgrdResultados.Cells[4,6] := IntToStr( iSalidas - iCombustible );
    sgrdResultados.Cells[5,6] := FloatToStr( rMinCombustible );
    sgrdResultados.Cells[6,6] := FloatToStr( rMedCombustible );
    sgrdResultados.Cells[7,6] := FloatToStr( rMaxCombustible );

    //Seguridad
    sgrdResultados.Cells[0,7] := 'Seguridad';
    if abs( rSeguridad - FieldByName('seguridad').AsFloat ) > 0.9 then
    begin
      bFlag:= False;
      sgrdResultados.Cells[1,7] := 'ERROR';
      sgrdResultados.Cells[2,7] := FieldByName('seguridad').AsString;
      sgrdResultados.Cells[3,7] := FloatToStr( rSeguridad );
    end
    else
    begin
      sgrdResultados.Cells[1,7] := 'OK';
      sgrdResultados.Cells[2,7] := FieldByName('seguridad').AsString;
      sgrdResultados.Cells[3,7] := '';
    end;
    sgrdResultados.Cells[4,7] := IntToStr( iSalidas - iSeguridad );
    sgrdResultados.Cells[5,7] := FloatToStr( rMinSeguridad );
    sgrdResultados.Cells[6,7] := FloatToStr( rMedSeguridad );
    sgrdResultados.Cells[7,7] := FloatToStr( rMaxSeguridad );


    //Frigorifico
    sgrdResultados.Cells[0,8] := 'Frigorifico';
    if abs( rFrigorifico - FieldByName('frigorifico').AsFloat ) > 0.9 then
    begin
      bFlag:= False;
      sgrdResultados.Cells[1,8] := 'ERROR';
      sgrdResultados.Cells[2,8] := FieldByName('frigorifico').AsString ;
      sgrdResultados.Cells[3,8] := FloatToStr( rFrigorifico );
    end
    else
    begin
      sgrdResultados.Cells[1,8] := 'OK';
      sgrdResultados.Cells[2,8] := FieldByName('frigorifico').AsString;
      sgrdResultados.Cells[3,8] := '';
    end;
    sgrdResultados.Cells[4,8] := IntToStr( iSalidas - iFrigorifico );
    sgrdResultados.Cells[5,8] := FloatToStr( rMinFrigorifico );
    sgrdResultados.Cells[6,8] := FloatToStr( rMedFrigorifico );
    sgrdResultados.Cells[7,8] := FloatToStr( rMaxFrigorifico );

    //Plataforma
    sgrdResultados.Cells[0,9] := 'Plataforma';
    if APlataforma then
    begin
      if abs( rPlataforma - FieldByName('plataforma').AsFloat ) > 0.9 then
      begin
        bFlag:= False;
        sgrdResultados.Cells[1,9] := 'ERROR';
        sgrdResultados.Cells[2,9] := FieldByName('plataforma').AsString;
        sgrdResultados.Cells[3,9] := FloatToStr( rPlataforma );
      end
      else
      begin
        sgrdResultados.Cells[1,9] := 'OK';
        sgrdResultados.Cells[2,9] := FieldByName('plataforma').AsString;
        sgrdResultados.Cells[3,9] := '';
      end;
      sgrdResultados.Cells[4,9] := IntToStr( iSalidas - iPlataforma );
      sgrdResultados.Cells[5,9] := FloatToStr( rMinPlataforma );
      sgrdResultados.Cells[6,9] := FloatToStr( rMedPlataforma );
      sgrdResultados.Cells[7,9] := FloatToStr( rMaxPlataforma );
    end
    else
    begin
      sgrdResultados.Cells[1,9] := '';
      sgrdResultados.Cells[2,9] := '';
      sgrdResultados.Cells[3,9] := '';
      sgrdResultados.Cells[4,9] := '';
      sgrdResultados.Cells[5,9] := '';
      sgrdResultados.Cells[6,9] := '';
      sgrdResultados.Cells[7,9] := '';
    end;

    Close;

    btnInforme.Enabled:= bFlag;
    btnBaseDatos.Enabled:= bFlag;
    chkIgnorarErrores.Visible:= not bFlag;
  end;
end;

procedure TFDResultadoBDDeposito.FormCreate(Sender: TObject);
begin
  iResult:= 0;
end;

procedure TFDResultadoBDDeposito.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDResultadoBDDeposito.btnInformeClick(Sender: TObject);
begin
  iResult:= 1;
  Close;
end;

procedure TFDResultadoBDDeposito.btnBaseDatosClick(Sender: TObject);
begin
  iResult:= 2;
  Close;
end;

procedure TFDResultadoBDDeposito.chkIgnorarErroresClick(Sender: TObject);
begin
  btnInforme.Enabled:= chkIgnorarErrores.Checked;
  btnBaseDatos.Enabled:= chkIgnorarErrores.Checked;
end;

end.
