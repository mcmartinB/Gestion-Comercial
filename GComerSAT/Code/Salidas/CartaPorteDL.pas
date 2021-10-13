unit CartaPorteDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLCartaPorte = class(TDataModule)
    QAlbaranCab: TQuery;
    QEmpresa: TQuery;
    QCliente: TQuery;
    QDirSum: TQuery;
    QTransportista: TQuery;
    QAlbaranLin: TQuery;
    QOperador: TQuery;
    QCentro: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

    procedure AbrirQuerys( const AEmpresa, ACentro: string;
                      const AAlbaran: integer; const AFecha: TDateTime );
    procedure CerrarQuerys;

  public
    { Public declarations }
  end;

  procedure Ejecutar( const AOwner: TComponent; const AEmpresa, ACentro: string;
                      const AAlbaran: integer; const AFecha: TDateTime;
                      const AFirma: string );

implementation

{$R *.dfm}

uses CartaPorteQL, UDMConfig;

var
  DLCartaPorte: TDLCartaPorte;

procedure Ejecutar( const AOwner: TComponent; const AEmpresa, ACentro: string;
                    const AAlbaran: integer; const AFecha: TDateTime;
                    const AFirma: string );
begin
  DLCartaPorte:= TDLCartaPorte.Create( AOwner );
  try
    DLCartaPorte.AbrirQuerys( AEmpresa, ACentro, AAlbaran, AFecha );
    CartaPorteQL.Previsualizar( AOwner, DLCartaPorte , AFirma );
    DLCartaPorte.CerrarQuerys;
  finally
    FreeAndNil( DLCartaPorte );
  end;
end;

procedure TDLCartaPorte.DataModuleCreate(Sender: TObject);
begin
  with QAlbaranCab do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and fecha_sc = :fecha ');
    Prepare;
  end;

  with QAlbaranLin do
  begin
    SQL.Clear;
    SQL.Add(' select producto_sl producto, ');
    SQL.Add('        envase_sl envase, sum(cajas_sl) bultos, sum(kilos_sl)  kilos ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and n_albaran_sl = :albaran ');
    SQL.Add(' and fecha_sl = :fecha ');
    SQL.Add(' group by 1, 2 ');
    SQL.Add(' order by 1, 2 ');
    Prepare;
  end;

  with QEmpresa do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_empresas ');
    SQL.Add(' where empresa_e = :empresa ');
    Prepare;
  end;
  with QCentro do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_centros ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add('   and centro_c = :centro ');
    Prepare;
  end;
  with QCliente do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where cliente_c = :cliente ');
    Prepare;
  end;
  with QDirSum do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_dir_sum ');
    SQL.Add(' where cliente_ds = :cliente ');
    SQL.Add(' and dir_sum_ds = :dirsum ');
    Prepare;
  end;
  with QTransportista do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transportistas ');
    SQL.Add(' where transporte_t = :transporte ');
    Prepare;
  end;
  with QOperador do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transportistas ');
    SQL.Add(' where transporte_t = :transporte ');
    Prepare;
  end;
end;

procedure TDLCartaPorte.DataModuleDestroy(Sender: TObject);
begin
  QOperador.Close;
  if QOperador.Prepared then
    QOperador.UnPrepare;
  QTransportista.Close;
  if QTransportista.Prepared then
    QTransportista.UnPrepare;
  QDirSum.Close;
  if QDirSum.Prepared then
    QDirSum.UnPrepare;
  QCliente.Close;
  if QCliente.Prepared then
    QCliente.UnPrepare;
  QEmpresa.Close;
  if QEmpresa.Prepared then
    QEmpresa.UnPrepare;
  QCentro.Close;
  if QCentro.Prepared then
    QCentro.UnPrepare;
  QAlbaranLin.Close;
  if QAlbaranLin.Prepared then
    QAlbaranLin.UnPrepare;
  QAlbaranCab.Close;
  if QAlbaranCab.Prepared then
    QAlbaranCab.UnPrepare;
end;

procedure TDLCartaPorte.AbrirQuerys( const AEmpresa, ACentro: string; const AAlbaran: integer;
                                     const AFecha: TDateTime );
begin
  with QAlbaranCab do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('albaran').AsInteger:= AAlbaran;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
  end;
  with QAlbaranLin do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('albaran').AsInteger:= AAlbaran;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
  end;
  with QEmpresa do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    Open;
  end;
  with QCentro do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    Open;
  end;
  with QCliente do
  begin
    ParamByName('cliente').AsString:= QAlbaranCab.FieldByName('cliente_sal_sc').AsString;
    Open;
  end;
  with QDirSum do
  begin
    ParamByName('cliente').AsString:= QAlbaranCab.FieldByName('cliente_sal_sc').AsString;
    ParamByName('dirsum').AsString:= QAlbaranCab.FieldByName('dir_sum_sc').AsString;
    Open;
  end;
  with QTransportista do
  begin
    ParamByName('transporte').AsString:= QAlbaranCab.FieldByName('transporte_sc').AsString;
    Open;
  end;
  //if QAlbaranCab.FieldByName('operador_transporte_sc').AsString <> QAlbaranCab.FieldByName('transporte_sc').AsString then
  //begin
    with QOperador do
    begin
      ParamByName('transporte').AsString:= QAlbaranCab.FieldByName('operador_transporte_sc').AsString;
      Open;
    end;
  //end;
end;

procedure TDLCartaPorte.CerrarQuerys;
begin
  QOperador.Close;
  QTransportista.Close;
  QDirSum.Close;
  QCliente.Close;
  QEmpresa.Close;
  QCentro.Close;
  QAlbaranLin.Close;
  QAlbaranCab.Close;
end;

end.
