unit CDDTransitosAduanaFicha;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDDTransitosAduanaFicha = class(TDataModule)
    QKilosTransito: TQuery;
    DSDatosAduana: TDataSource;
    QDatosDepositoCab: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure QDatosDepositoCabAfterOpen(DataSet: TDataSet);
    procedure QDatosDepositoCabBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }

  public
    { Public declarations }
    function  FichaDatosAduana( const ACodigo: Integer ): boolean;

  end;

var
  DDTransitosAduanaFicha: TDDTransitosAduanaFicha;

implementation

{$R *.DFM}

uses
  bTextUtils;

procedure TDDTransitosAduanaFicha.DataModuleCreate(Sender: TObject);
begin
  With QDatosDepositoCab do
  begin
    SQL.Clear;
    SQL.Add(' select buque_tc, vehiculo_tc, transporte_tc, frf_depositos_aduana_c.* ');
    SQL.Add(' from frf_depositos_aduana_c, frf_transitos_c ');
    SQL.Add(' where codigo_dac = :codigo  ');
    SQL.Add('   and empresa_tc = empresa_dac ');
    SQL.Add('   and centro_tc = centro_dac ');
    SQL.Add('   and fecha_tc = fecha_dac ');
    SQL.Add('   and referencia_tc = referencia_dac ');
    Prepare;
  end;


  With QKilosTransito do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_tl) kilos_tl');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa_dac ');
    SQL.Add(' and centro_tl = :centro_dac ');
    SQL.Add(' and fecha_tl = :fecha_dac ');
    SQL.Add(' and referencia_tl = :referencia_dac ');
    Prepare;
  end;

end;

procedure TDDTransitosAduanaFicha.DataModuleDestroy(Sender: TObject);
begin
  with QDatosDepositoCab do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QKilosTransito do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

end;

function TDDTransitosAduanaFicha.FichaDatosAduana( const ACodigo: Integer ): boolean;
begin
  With QDatosDepositoCab do
  begin
    Close;
    ParamByName('codigo').AsInteger:= ACodigo;
    Open;
    result:= not IsEmpty;
  end;
end;


procedure TDDTransitosAduanaFicha.QDatosDepositoCabAfterOpen(
  DataSet: TDataSet);
begin
  QKilosTransito.Open;
end;

procedure TDDTransitosAduanaFicha.QDatosDepositoCabBeforeClose(
  DataSet: TDataSet);
begin
  QKilosTransito.Close;
end;



end.
