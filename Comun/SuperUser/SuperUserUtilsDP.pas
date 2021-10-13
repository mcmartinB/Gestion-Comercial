unit SuperUserUtilsDP;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDPSuperUserUtils = class(TDataModule)
    qryAux: TQuery;
    qryTempo: TQuery;
    dbBAG: TDatabase;
    dbF17: TDatabase;
    dbF18: TDatabase;
    dbF21_old: TDatabase;
    dbF23: TDatabase;
    dbF24_old: TDatabase;
    qryUpdate: TQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    procedure CerrarTablas;

    (*REMESAS FACTURAS*)

    (*BRUTO TRANSITOS*)
    function  BrutoTransitos: boolean;
  end;

implementation

{$R *.dfm}

uses
  UDMBaseDatos, Dialogs, Controls, cGlobal;

procedure TDPSuperUserUtils.CerrarTablas;
begin
  if qryTempo.Active then
    qryTempo.Close;
  if qryAux.Active then
    qryAux.Close;
end;

(*INICIO BRUTO TRANSITOS*)
(*vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv*)
function  TDPSuperUserUtils.BrutoTransitos: boolean;
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add('select empresa_tc, centro_tc, referencia_tc, fecha_tc, sum(palets_tl) palets, sum(cajas_tl) cajas,  sum(kilos_tl) neto, ');
  qryAux.SQL.Add('       sum(kilos_tl) + ');
  qryAux.SQL.Add('       sum( palets_tl *  case when referencia_tc = 605707 then -0.04 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 605735 then -0.06 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 605765 then -0.03 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 605796 then -0.04 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 605954 then -0.08 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606044 then -0.04 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606107 then -0.09 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606246 then 2.78 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606255 then -0.29 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606256 then 1.24 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606258 then -0.04 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606262 then -0.05 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606264 then -0.05 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606270 then -0.06 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606284 then -0.04 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606287 then -0.06 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606292 then -0.06 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');
  qryAux.SQL.Add('                              when referencia_tc = 606300 then -0.08 + ( case when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                                                                      when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                                                                      else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) ');

  qryAux.SQL.Add('                              when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''07'' then 18 ');
  qryAux.SQL.Add('                              when fecha_tc < ''1/9/2013'' and tipo_palet_tl = ''19'' then 23 ');
  qryAux.SQL.Add('                              else ( select kilos_tp from  frf_tipo_palets where tipo_palet_tl = codigo_tp ) end ) + ');

  qryAux.SQL.Add('       sum( cajas_tl * case when referencia_tc = 605692 then -0.0776 + ( case when fecha_tc < ''1/9/2013'' and envase_tl = ''512'' then 1.93 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''542'' then 0.46 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''574'' then 0.37 ');
  qryAux.SQL.Add('                                                                           else ( select peso_envase_e from  frf_envases where envase_e = envase_tl ) end ) ');
  qryAux.SQL.Add('                            when referencia_tc = 605714 then -0.1616 + ( case when fecha_tc < ''1/9/2013'' and envase_tl = ''512'' then 1.93 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''542'' then 0.46 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''574'' then 0.37 ');
  qryAux.SQL.Add('                                                                           else ( select peso_envase_e from  frf_envases where envase_e = envase_tl ) end ) ');
  qryAux.SQL.Add('                            when referencia_tc = 605715 then -0.1616 + ( case when fecha_tc < ''1/9/2013'' and envase_tl = ''512'' then 1.93 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''542'' then 0.46 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''574'' then 0.37 ');
  qryAux.SQL.Add('                                                                           else ( select peso_envase_e from  frf_envases where envase_e = envase_tl ) end ) ');
  qryAux.SQL.Add('                            when referencia_tc = 605720 then -0.1616 + ( case when fecha_tc < ''1/9/2013'' and envase_tl = ''512'' then 1.93 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''542'' then 0.46 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''574'' then 0.37 ');
  qryAux.SQL.Add('                                                                           else ( select peso_envase_e from  frf_envases where envase_e = envase_tl ) end ) ');
  qryAux.SQL.Add('                            when referencia_tc = 605722 then -0.1666 + ( case when fecha_tc < ''1/9/2013'' and envase_tl = ''512'' then 1.93 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''542'' then 0.46 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''574'' then 0.37 ');
  qryAux.SQL.Add('                                                                           else ( select peso_envase_e from  frf_envases where envase_e = envase_tl ) end ) ');
  qryAux.SQL.Add('                            when referencia_tc = 605828 then -0.4137 + ( case when fecha_tc < ''1/9/2013'' and envase_tl = ''512'' then 1.93 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''542'' then 0.46 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''574'' then 0.37 ');
  qryAux.SQL.Add('                                                                           else ( select peso_envase_e from  frf_envases where envase_e = envase_tl ) end ) ');
  qryAux.SQL.Add('                            when referencia_tc = 606226 then -0.3553 + ( case when fecha_tc < ''1/9/2013'' and envase_tl = ''512'' then 1.93 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''542'' then 0.46 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''574'' then 0.37 ');
  qryAux.SQL.Add('                                                                           else ( select peso_envase_e from  frf_envases where envase_e = envase_tl ) end ) ');
  qryAux.SQL.Add('                            when referencia_tc = 606260 then 2.8577 + ( case when fecha_tc < ''1/9/2013'' and envase_tl = ''512'' then 1.93 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''542'' then 0.46 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''574'' then 0.37 ');
  qryAux.SQL.Add('                                                                           else ( select peso_envase_e from  frf_envases where envase_e = envase_tl ) end ) ');
  qryAux.SQL.Add('                            when referencia_tc = 606269 then -0.1241 + ( case when fecha_tc < ''1/9/2013'' and envase_tl = ''512'' then 1.93 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''542'' then 0.46 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''574'' then 0.37 ');
  qryAux.SQL.Add('                                                                           else ( select peso_envase_e from  frf_envases where envase_e = envase_tl ) end ) ');
  qryAux.SQL.Add('                            when referencia_tc = 606364 then 0.1763 + ( case when fecha_tc < ''1/9/2013'' and envase_tl = ''512'' then 1.93 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''542'' then 0.46 ');
  qryAux.SQL.Add('                                                                           when fecha_tc < ''1/9/2013'' and envase_tl = ''574'' then 0.37 ');
  qryAux.SQL.Add('                                                                           else ( select peso_envase_e from  frf_envases where envase_e = envase_tl ) end ) ');

  qryAux.SQL.Add('                            when fecha_tc < ''1/9/2013'' and envase_tl = ''512'' then 1.93 ');
  qryAux.SQL.Add('                            when fecha_tc < ''1/9/2013'' and envase_tl = ''542'' then 0.46 ');
  qryAux.SQL.Add('                            when fecha_tc < ''1/9/2013'' and envase_tl = ''574'' then 0.37 ');
  qryAux.SQL.Add('                            else ( select peso_envase_e from  frf_envases where envase_e = envase_tl ) end ) bruto, ');
  qryAux.SQL.Add('       nota_tc ');
  qryAux.SQL.Add('from frf_transitos_c, frf_transitos_l ');
  qryAux.SQL.Add('where empresa_tc = ''050'' ');
  qryAux.SQL.Add('and centro_tc = ''6'' ');
  qryAux.SQL.Add('and fecha_tc between ''1/1/2013'' and ''31/12/2013'' ');
  qryAux.SQL.Add('and empresa_tc = empresa_tl ');
  qryAux.SQL.Add('and centro_tc = centro_tl ');
  qryAux.SQL.Add('and referencia_tc = referencia_tl ');
  qryAux.SQL.Add('and fecha_tc = fecha_tl ');
  qryAux.SQL.Add('group by empresa_tc, centro_tc, referencia_tc, fecha_tc, nota_tc ');
  qryAux.Open;
  result:= not qryAux.IsEmpty;
end;
(*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*)
(*FIN BRUTO TRANSITOS*)


end.
