unit DMRecepcion;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMRecepcionForm = class(TDataModule)
    QTransito: TQuery;
    QTransitoRemoto: TQuery;
    QLinea: TQuery;
    QLineaRemota: TQuery;
    QPaletPbRemota: TQuery;
    QBorrarPaletPb: TQuery;
    DSTransitoRemoto: TDataSource;
    QPaletPbLocal: TQuery;
    QPaletCabLocal: TQuery;
    QPaletDetLocal: TQuery;
    QBorrarPaletCabLocal: TQuery;
    QBorrarPaletDetLocal: TQuery;
    QPaletCabRemota: TQuery;
    QPaletDetRemota: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses UDMBaseDatos, UDMConfig;

{$R *.dfm}

procedure TDMRecepcionForm.DataModuleDestroy(Sender: TObject);
begin
  QTransito.Close;
  QTransitoRemoto.Close;
  QLinea.Close;
  QLineaRemota.Close;

  QPaletPbRemota.Close;
  QPaletPbLocal.Close;


    with QPaletCabLocal do
    begin
      Close;
      if Prepared then
        Unprepare;
    end;
    with QBorrarPaletCabLocal do
    begin
      Close;
      if Prepared then
        Unprepare;
    end;
    with QPaletDetLocal do
    begin
      Close;
      if Prepared then
        Unprepare;
    end;
    with QBorrarPaletDetLocal do
    begin
      Close;
      if Prepared then
        Unprepare;
    end;
  with QPaletCabRemota do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QPaletDetRemota do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;    
end;

procedure TDMRecepcionForm.DataModuleCreate(Sender: TObject);
begin
  with QTransito do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transitos_c ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc = :fecha ');
    SQL.Add(' and referencia_tc = :referencia ');
  end;
  with QTransitoRemoto do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transitos_c ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc = :fecha ');
    SQL.Add(' and referencia_tc = :referencia ');
  end;

  with QLinea do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transitos_l ');
  end;
  with QLineaRemota do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa_tc ');
    SQL.Add(' and centro_tl = :centro_tc ');
    SQL.Add(' and fecha_tl = :fecha_tc ');
    SQL.Add(' and referencia_tl = :referencia_tc ');
  end;

  with QPaletPbLocal do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where sscc = :sscc ');
  end;
  with QBorrarPaletPb do
  begin
    SQL.Clear;
    SQL.Add(' delete ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where orden_carga = :n_orden_tc');
    SQL.Add('   and empresa = :empresa_tc ');
  end;
  with QPaletPbRemota do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where orden_carga = :n_orden_tc ');
    SQL.Add('   and empresa = :empresa_tc ');
  end;


    with QPaletCabLocal do
    begin
      SQL.Clear;
     SQL.Add(' select * ');
      SQL.Add(' from rf_Palet_Pc_Cab ');
      if not Prepared then
        Prepare;
    end;
    with QBorrarPaletCabLocal do
    begin
      SQL.Clear;
      SQL.Add(' delete ');
      SQL.Add(' from rf_Palet_Pc_Cab ');
      SQL.Add(' where empresa_cab = :empresa ');
      SQL.Add('   and centro_cab = :centro ');
      SQL.Add('   and date(fecha_transito) = :fecha ');
      SQL.Add('   and ref_transito = :referencia ');
      if not Prepared then
        Prepare;
    end;
    with QPaletDetLocal do
    begin
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from rf_Palet_Pc_Det ');
      if not Prepared then
        Prepare;
    end;
    with QBorrarPaletDetLocal do
    begin
      SQL.Clear;
      SQL.Add(' delete ');
      SQL.Add(' from rf_Palet_Pc_Det ');
      SQL.Add(' where exists ');
      SQL.Add(' ( ');
      SQL.Add('   select ean128_cab ');
      SQL.Add('   from rf_Palet_Pc_Cab ');
      SQL.Add('   where empresa_cab = :empresa ');
      SQL.Add('     and centro_cab = :centro ');
      SQL.Add('     and date(fecha_transito) = :fecha ');
      SQL.Add('     and ref_transito = :referencia ');
      SQL.Add('     and ean128_cab = ean128_det ');
      SQL.Add(' ) ');
      if not Prepared then
        Prepare;
    end;

  with QPaletCabRemota do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from rf_Palet_Pc_Cab ');
    SQL.Add(' where empresa_cab = :empresa ');
    SQL.Add('   and centro_cab = :centro ');
    SQL.Add('   and date(fecha_transito) = :fecha ');
    SQL.Add('   and ref_transito = :referencia ');
    if not Prepared then
      Prepare;
  end;
  with QPaletDetRemota do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from rf_Palet_Pc_Det ');
    SQL.Add(' where ean128_det in ');
    SQL.Add(' ( ');
    SQL.Add('   select ean128_cab ');
    SQL.Add('   from rf_Palet_Pc_Cab ');
    SQL.Add('   where empresa_cab = :empresa ');
    SQL.Add('   and centro_cab = :centro ');
    SQL.Add('   and date(fecha_transito) = :fecha ');
    SQL.Add('   and ref_transito = :referencia ');
    SQL.Add(' ) ');
    if not Prepared then
      Prepare;
  end;  

end;

end.
