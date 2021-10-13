unit ControlEnvioAlbaranesDR;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDRControlEnvioAlbaranes = class(TDataModule)
    kmtListado: TkbmMemTable;
    qryDatosLocal: TQuery;
    qryDatosCentral: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa: string;
    iTipo: Integer;
    rMax: Real;

    function  OpenDataReporte(const AEmpresa: string; const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer ): Boolean;
    function  LoadData: boolean;
    procedure LoadRegister;
    procedure CargaQuerys;
    function  NoExisteAlbaran: Boolean;
  public
    { Public declarations }
  end;

  function OpenDataReporte(const AEmpresa: string; const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer ): Boolean;
  procedure CloseDataReporte;



implementation

{$R *.dfm}

uses
  UDMAuxDB, bMath;

var
  DRControlEnvioAlbaranes: TDRControlEnvioAlbaranes;

function OpenDataReporte(const AEmpresa: string; const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer ): Boolean;
begin
  DRControlEnvioAlbaranes:= TDRControlEnvioAlbaranes.Create( nil );
  result:= DRControlEnvioAlbaranes.OpenDataReporte(AEmpresa, AFechaIni, AFechaFin, ATipo );
end;

procedure CloseDataReporte;
begin
  FreeAndNil( DRControlEnvioAlbaranes );
end;

procedure TDRControlEnvioAlbaranes.DataModuleCreate(Sender: TObject);
begin
  with kmtListado do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('empresa', ftString, 3, False);
    FieldDefs.Add('centro', ftString, 3, False);
    FieldDefs.Add('fecha', ftDate, 0, False);
    FieldDefs.Add('numero', ftInteger, 0, False);
    CreateTable;
    Open;
  end;
end;

procedure TDRControlEnvioAlbaranes.DataModuleDestroy(Sender: TObject);
begin
  kmtListado.Close;
end;

procedure TDRControlEnvioAlbaranes.CargaQuerys;
begin
  if  iTipo = 0 then
  begin
    //Entradas
    with qryDatosLocal do
    begin
      SQL.Clear;
      SQL.Add(' select empresa_ec empresa, centro_ec centro, ');
      SQL.Add('        fecha_ec fecha, numero_entrada_ec numero ');
      SQL.Add(' from frf_entradas_c ');
      SQL.Add(' where fecha_ec between :fechaini and :fechafin ');
      if sEmpresa = 'BAG' then
        SQL.Add(' and empresa_ec[1,1] =  "F"  ')
      else
      if sEmpresa = 'SAT' then
        SQL.Add(' and ( empresa_ec = "050" or empresa_ec = "080" ) ')
      else
        SQL.Add(' and empresa_ec =  :empresa  ');
      SQL.Add(' order by empresa, centro, fecha, numero ');
    end;
    with qryDatosCentral do
    begin
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_entradas_c ');
      SQL.Add(' where empresa_ec =  :empresa ');
      SQL.Add(' and  centro_ec = :centro ');
      SQL.Add(' and  fecha_ec = :fecha ');
      SQL.Add(' and  numero_entrada_ec = :numero ');
      Prepare;
    end;
  end
  else
  if  iTipo = 1 then
  begin
    //Transitos
    with qryDatosLocal do
    begin
      SQL.Clear;
      SQL.Add(' select empresa_tc empresa, centro_tc centro, ');
      SQL.Add('        fecha_tc fecha, referencia_tc numero ');
      SQL.Add(' from frf_transitos_c ');
      SQL.Add(' where fecha_ec between :fechaini and :fechafin ');
      if sEmpresa = 'BAG' then
        SQL.Add(' and empresa_tc[1,1] =  "F"  ')
      else
      if sEmpresa = 'SAT' then
        SQL.Add(' and ( empresa_tc = "050" or empresa_ec = "080" ) ')
      else
        SQL.Add(' and empresa_tc =  :empresa  ');
      SQL.Add(' order by empresa, centro, fecha, numero ');
    end;
    with qryDatosCentral do
    begin
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_transitos_c ');
      SQL.Add(' where empresa_tc =  :empresa ');
      SQL.Add(' and  centro_tc = :centro ');
      SQL.Add(' and  fecha_tc = :fecha ');
      SQL.Add(' and  referencia_tc = :numero ');
      Prepare;
    end;
  end
  else
  if  iTipo = 2 then
  begin
    //Albaranes
    with qryDatosLocal do
    begin
      SQL.Clear;
      SQL.Add(' select empresa_sc empresa, centro_salida_sc centro, ');
      SQL.Add('        fecha_sc fecha, n_albaran_sc numero ');
      SQL.Add(' from frf_salidas_c ');
      SQL.Add(' where fecha_sc between :fechaini and :fechafin ');
      if sEmpresa = 'BAG' then
        SQL.Add(' and empresa_sc[1,1] =  "F"  ')
      else
      if sEmpresa = 'SAT' then
        SQL.Add(' and ( empresa_sc = "050" or empresa_ec = "080" ) ')
      else
        SQL.Add(' and empresa_sc =  :empresa  ');
      SQL.Add(' order by empresa, centro, fecha, numero ');
    end;
    with qryDatosCentral do
    begin
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_salidas_c ');
      SQL.Add(' where empresa_sc =  :empresa ');
      SQL.Add(' and  centro_salida_sc = :centro ');
      SQL.Add(' and  fecha_sc = :fecha ');
      SQL.Add(' and  n_albaran_sc = :numero ');
      Prepare;
    end;
  end;
end;

function TDRControlEnvioAlbaranes.OpenDataReporte(const AEmpresa: string; const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer ): Boolean;
begin
  iTipo:= ATipo;
  sEmpresa:= AEmpresa;
  CargaQuerys;

  if ( AEmpresa <> 'BAG' ) and ( AEmpresa <> 'SAT' )then
    qryDatosLocal.ParamByName('empresa').AsString:= AEmpresa;
  qryDatosLocal.ParamByName('fechaini').AsDate:= AFechaIni;
  qryDatosLocal.ParamByName('fechafin').AsDate:= AFechaFin;

  qryDatosLocal.Open;
  try
    if not qryDatosLocal.IsEmpty then
    begin
      Result:= LoadData;
      kmtListado.SortFields:= 'empresa;centro;fecha;numero';
      kmtListado.Sort([]);
    end
    else
    begin
      Result:= False;
    end;
  finally
    qryDatosLocal.Close;
    qryDatosCentral.UnPrepare;
  end;
end;

function TDRControlEnvioAlbaranes.LoadData: boolean;
begin
  while not qryDatosLocal.Eof do
  begin
    LoadRegister;
    qryDatosLocal.Next;
  end;
  Result:= not kmtListado.IsEmpty;
end;

function TDRControlEnvioAlbaranes.NoExisteAlbaran: Boolean;
begin
  qryDatosCentral.ParamByName('empresa').AsString:= qryDatosLocal.FieldByName('empresa').AsString;
  qryDatosCentral.ParamByName('centro').AsString:= qryDatosLocal.FieldByName('centro').AsString;
  qryDatosCentral.ParamByName('fecha').AsDateTime:= qryDatosLocal.FieldByName('fecha').AsDateTime;
  qryDatosCentral.ParamByName('numero').AsInteger:= qryDatosLocal.FieldByName('numero').AsInteger;
  qryDatosCentral.Open;
  result:= qryDatosCentral.IsEmpty;
  qryDatosCentral.Close;
end;

procedure TDRControlEnvioAlbaranes.LoadRegister;
var
  rAux: Real;
begin
  if NoExisteAlbaran then
  begin
    kmtListado.Insert;
    kmtListado.FieldByName('empresa').AsString:= qryDatosLocal.FieldByName('empresa').AsString;
    kmtListado.FieldByName('centro').AsString:= qryDatosLocal.FieldByName('centro').AsString;
    kmtListado.FieldByName('fecha').AsDateTime:= qryDatosLocal.FieldByName('fecha').AsDateTime;
    kmtListado.FieldByName('numero').AsInteger:= qryDatosLocal.FieldByName('numero').AsInteger;
    kmtListado.Post;
  end;
end;

end.
