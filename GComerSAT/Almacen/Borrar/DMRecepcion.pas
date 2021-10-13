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
    QPaletCabLocal: TQuery;
    QPaletCabRemota: TQuery;
    QPaletDetLocal: TQuery;
    QPaletDetRemota: TQuery;
    QPaletPbRemota: TQuery;
    QBorrarPaletCabLocal: TQuery;
    QBorrarPaletDetLocal: TQuery;
    qryPaletCabSGP: TQuery;
    qryPaletDetSGP: TQuery;
    qryBorrarPaletCabSGP: TQuery;
    qryBorrarPaletDetSGP: TQuery;
    QBorrarPaletPb: TQuery;
    DSTransitoRemoto: TDataSource;
    QPaletPbLocal: TQuery;
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
  with QTransito do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QTransitoRemoto do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QLinea do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QLineaRemota do
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

  with QPaletPbLocal do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;

  with QBorrarPaletPb do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;

  with QPaletPbRemota do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;

  if DMBaseDatos.DBSGP.Connected then
  begin
    with qryPaletCabSGP do
    begin
      Close;
      if Prepared then
        Unprepare;
    end;
    with qryBorrarPaletCabSGP do
    begin
      Close;
      if Prepared then
        Unprepare;
    end;
    with qryPaletDetSGP do
    begin
      Close;
      if Prepared then
        Unprepare;
    end;
    with qryBorrarPaletDetSGP do
    begin
      Close;
      if Prepared then
        Unprepare;
    end;
    DMBaseDatos.DBSGP.Connected:= False;
  end
  else
  begin
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
    if not Prepared then
      Prepare;
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
    if not Prepared then
      Prepare;
  end;
  with QLinea do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transitos_l ');
    if not Prepared then
      Prepare;
  end;
  with QLineaRemota do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and centro_tl = :centro ');
    SQL.Add(' and fecha_tl = :fecha ');
    SQL.Add(' and referencia_tl = :referencia ');
    if not Prepared then
      Prepare;
  end;


  if DMConfig.EsLosLLanos then
  begin
    DMBaseDatos.DBSGP.Connected:= true;

    with qryPaletCabSGP do
    begin
      SQL.Clear;
      SQL.Add(' INSERT INTO rf_Palet_Pc_Cab ( ');
      SQL.Add('       empresa_cab, ');
      SQL.Add('       centro_cab,   ');
      SQL.Add('       ean128_cab, ');
      SQL.Add('       tipo_palet_cab, ');
      SQL.Add('       cliente_cab, ');
      SQL.Add('       dirsum_cab, ');
      SQL.Add('       terminal_cab, ');
      SQL.Add('       fecha_alta_cab, ');
      SQL.Add('       status_cab, ');
      //SQL.Add('       orden_carga_cab, ');
      //SQL.Add('       fecha_carga_cab, ');
      //SQL.Add('       terminal_carga_cab, ');
      //SQL.Add('       fecha_volcado_cab, ');
      //SQL.Add('       le_volcado_cab, ');
      //SQL.Add('       terminal_volcado_cab, ');
      //SQL.Add('       fecha_borrado_cab, ');
      //SQL.Add('       terminal_borrado_cab, ');
      SQL.Add('       eti_conserva, ');
      SQL.Add('       ref_transito, ');
      SQL.Add('       fecha_transito, ');
      //SQL.Add('       previsto_carga, ');
      SQL.Add('       lote ');
      SQL.Add('       ) values ( ');
      SQL.Add('       :empresa_cab, ');
      SQL.Add('       :centro_cab, ');
      SQL.Add('       :ean128_cab, ');
      SQL.Add('       :tipo_palet_cab, ');
      SQL.Add('       :cliente_cab, ');
      SQL.Add('       :dirsum_cab, ');
      SQL.Add('       :terminal_cab, ');
      SQL.Add('       :fecha_alta_cab, ');
      SQL.Add('       :status_cab, ');
      //SQL.Add('       :orden_carga_cab, ');
      //SQL.Add('       :fecha_carga_cab, ');
      //SQL.Add('       :terminal_carga_cab, ');
      //SQL.Add('       :fecha_volcado_cab, ');
      //SQL.Add('       :le_volcado_cab, ');
      //SQL.Add('       :terminal_volcado_cab, ');
      //SQL.Add('       :fecha_borrado_cab, ');
      //SQL.Add('       :terminal_borrado_cab, ');
      SQL.Add('       :eti_conserva, ');
      SQL.Add('       :ref_transito, ');
      SQL.Add('       :fecha_transito, ');
      //SQL.Add('       :previsto_carga, ');
      SQL.Add('       :lote ');
      SQL.Add('       ) ');

      if not Prepared then
        Prepare;
    end;
    with qryBorrarPaletCabSGP do
    begin
      SQL.Clear;
      SQL.Add(' delete ');
      SQL.Add(' from rf_Palet_Pc_Cab ');
      SQL.Add(' where empresa_cab = :empresa ');
      SQL.Add('   and centro_cab = :centro ');
      SQL.Add('   and fecha_transito = :fecha ');
      SQL.Add('   and ref_transito = :referencia ');
      if not Prepared then
        Prepare;
    end;
    with qryPaletDetSGP do
    begin
      SQL.Clear;
      SQL.Add(' INSERT INTO rf_Palet_Pc_Det ( ');
      //SQL.Add('       movimiento, ');
      SQL.Add('       ean128_det, ');
      SQL.Add('       ean13_det, ');
      SQL.Add('       fecha_alta_det, ');
      SQL.Add('       envase_det, ');
      SQL.Add('       unidades_det, ');
      SQL.Add('       calibre_det, ');
      SQL.Add('       color_det, ');
      SQL.Add('       le_det, ');
      SQL.Add('       peso_det, ');
      SQL.Add('       ean128_orig_det, ');
      SQL.Add('       ean128_dest_det, ');
      SQL.Add('       terminal_det, ');
      SQL.Add('       albaran_entrada_tfe ');
      SQL.Add('       ) values ( ');
      //SQL.Add('       :movimiento, ');
      SQL.Add('       :ean128_det, ');
      SQL.Add('       :ean13_det, ');
      SQL.Add('       :fecha_alta_det, ');
      SQL.Add('       :envase_det, ');
      SQL.Add('       :unidades_det, ');
      SQL.Add('       :calibre_det, ');
      SQL.Add('       :color_det, ');
      SQL.Add('       :le_det, ');
      SQL.Add('       :peso_det, ');
      SQL.Add('       :ean128_orig_det, ');
      SQL.Add('       :ean128_dest_det, ');
      SQL.Add('       :terminal_det, ');
      SQL.Add('       :albaran_entrada_tfe ');
      SQL.Add('       ) ');
      if not Prepared then
        Prepare;
    end;
    with qryBorrarPaletDetSGP do
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
      SQL.Add('     and fecha_transito = :fecha ');
      SQL.Add('     and ref_transito = :referencia ');
      SQL.Add('     and ean128_cab = ean128_det ');
      SQL.Add(' ) ');
      if not Prepared then
        Prepare;
    end;
  end
  else
  begin
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
  end;

  with QPaletCabRemota do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from rf_Palet_Pc_Cab ');
    SQL.Add(' where empresa_cab = :empresa ');
    SQL.Add('   and centro_cab = :centro ');
    SQL.Add('   and fecha_transito = :fecha ');
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
    SQL.Add('   where empresa_cab = :empresa_tc ');
    SQL.Add('   and centro_cab = :centro_tc ');
    SQL.Add('   and fecha_transito = :fecha_tc ');
    SQL.Add('   and ref_transito = :referencia_tc ');
    SQL.Add(' ) ');
    if not Prepared then
      Prepare;
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

end;

end.



