unit CDDTransitosAduana;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDDTransitosAduana = class(TDataModule)
    QDatosAduana: TQuery;
    DSDatosAduana: TDataSource;
    QGetClave: TQuery;
    qryTransportePuerto: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure QDatosAduanaBeforePost(DataSet: TDataSet);
  private
    { Private declarations }

    function GetClave: integer;
  public
    { Public declarations }
    function  GetDatosAduana( const AEmpresa, ACentro: String; const AFecha: TDateTime;
                              const ATransito: Integer ): boolean;

    function  MetrosLineales( const AEmpresa, ACentro: String;
                              const AFecha: TDateTime; const ATransito: Integer ): real;
  end;

var
  DDTransitosAduana_: TDDTransitosAduana;

implementation

{$R *.DFM}

uses bMath;

procedure TDDTransitosAduana.DataModuleCreate(Sender: TObject);
begin
  With QDatosAduana do
  begin
    RequestLive:= True;
    SQL.Clear;
    SQL.Add(' SELECT * FROM FRF_DEPOSITOS_ADUANA_C ');
    SQL.Add('  WHERE EMPRESA_DAC = :empresa ');
    SQL.Add('    AND CENTRO_DAC = :centro ');
    SQL.Add('    AND FECHA_DAC = :fecha ');
    SQL.Add('    AND REFERENCIA_DAC = :transito ');
    Prepare;
  end;

  with QGetClave do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(max(codigo_dac),0) codigo_dac ');
    SQL.Add(' from frf_depositos_aduana_c ');
    Prepare;
  end;

  With qryTransportePuerto do
  begin
    SQL.Clear;
    SQL.Add(' select transporte_tc transporte, puerto_tc puerto, descripcion_a des_puerto');
    SQL.Add(' from frf_transitos_c left join frf_aduanas on puerto_tc = codigo_a ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc = :fecha ');
    SQL.Add(' and referencia_tc = :referencia ');
    Prepare;
  end;
end;

procedure TDDTransitosAduana.DataModuleDestroy(Sender: TObject);
begin
  with QDatosAduana do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QGetClave do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with qryTransportePuerto do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
end;

function  TDDTransitosAduana.MetrosLineales( const AEmpresa, ACentro: String;
                             const AFecha: TDateTime; const ATransito: Integer ): real;

begin
  Result:= 14.2;
  (*TODO*)
  //Tabla para guaradar valores
  with qryTransportePuerto do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('referencia').AsInteger:= ATransito;
    Open;
    if FieldByName('transporte').AsString = '691' then
    begin
      if Pos( 'ALICANTE', FieldByName('des_puerto').AsString ) > 0 then
      begin
        Result:= 0; //0 implica TEUS 40
      end;
    end
    else
    if FieldByName('transporte').AsString = '20' then
    begin
      if ( Pos( 'SEVILLA', FieldByName('des_puerto').AsString ) > 0 ) or
         ( Pos( 'HUELVA', FieldByName('des_puerto').AsString ) > 0 )then
      begin
        Result:= 13.6;
      end;
    end
    else
    if FieldByName('transporte').AsString = '310' then
    begin
      if ( Pos( 'SEVILLA', FieldByName('des_puerto').AsString ) > 0 ) or
         ( Pos( 'HUELVA', FieldByName('des_puerto').AsString ) > 0 )then
      begin
        Result:= 13.6;
      end;
    end
    else
    if FieldByName('transporte').AsString = '280' then
    begin
      if ( Pos( 'HUELVA', FieldByName('des_puerto').AsString ) > 0 )then
      begin
        Result:= 13.6;
      end;
    end;
    Close;
  end;
end;



function TDDTransitosAduana.GetDatosAduana( const AEmpresa, ACentro: String;
                             const AFecha: TDateTime;
                             const ATransito: Integer ): boolean;
begin
  With QDatosAduana do
  begin
    Close;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('transito').AsInteger:= ATransito;
    Open;
    result:= not IsEmpty;
  end;
end;

function TDDTransitosAduana.GetClave: integer;
begin
  with QGetClave do
  begin
    Open;
    result:= FieldByname('codigo_dac').AsInteger + 1;
    Close;
  end;
end;

procedure TDDTransitosAduana.QDatosAduanaBeforePost(DataSet: TDataSet);
begin
  //Rellenar clave primaria
  if DataSet.State = dsInsert then
  begin
    DataSet.FieldByName('codigo_dac').AsInteger:= GetClave;
  end;
end;

end.
