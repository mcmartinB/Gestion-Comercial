unit FormatoPaletsDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMFormatoPalets = class(TDataModule)
    QMaestro: TQuery;
    QListado: TQuery;
    DSMaestro: TDataSource;
    QDetalle: TQuery;
    QInsertContador: TQuery;
    QUpdateContador: TQuery;
    QSelectContador: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure QMaestroAfterOpen(DataSet: TDataSet);
    procedure QMaestroBeforeClose(DataSet: TDataSet);
    procedure QDetalleBeforePost(DataSet: TDataSet);
    procedure QDetalleAfterPost(DataSet: TDataSet);
    procedure QMaestroBeforePost(DataSet: TDataSet);
    procedure QMaestroAfterPost(DataSet: TDataSet);
    procedure QMaestroPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  private
    { Private declarations }
    sSelect, sFrom, sWhere, sOrder: string;
    sSelectL, sFromL, sWhereL, sGroupL, sOrderL: string;

    //function ContadorFormatoPalets: string;
  public
    { Public declarations }
    procedure VisualizarListado(const ADetalle: Boolean);
    procedure Localizar(const AFiltro: string);
  end;

var
  DMFormatoPalets: TDMFormatoPalets;

implementation

{$R *.dfm}

uses bTextUtils, UDMAuxDB, FormatoPaletsQM;

procedure TDMFormatoPalets.DataModuleCreate(Sender: TObject);
begin
  with QMaestro do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_formatos where empresa_f = ''###''');
  end;
  with QDetalle do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_formatos_cli ');
    SQL.Add(' where empresa_fc = :empresa_f and formato_fc = :codigo_f ');
  end;

  //Mantenimiento cab
  sSelect := 'select * ';
  sFrom := 'From frf_formatos ';
  sWhere := '';
  sOrder := 'order by empresa_f, productop_f, codigo_f, palet_f';

  //Listado
  sSelectL := 'select * ';
  sFromL := 'From frf_formatos, outer frf_formatos_cli ';
  sWhereL := 'where empresa_f = empresa_fc and codigo_f = formato_fc ';
  sGroupL := '';
  sOrderL := 'order by empresa_fc, formato_fc, cliente_fc, suministro_fc, formato_cliente_fc';
end;

procedure TDMFormatoPalets.QMaestroAfterOpen(DataSet: TDataSet);
begin
  QDetalle.Open;
end;

procedure TDMFormatoPalets.QMaestroBeforeClose(DataSet: TDataSet);
begin
  QDetalle.Close;
end;

procedure TDMFormatoPalets.QDetalleBeforePost(DataSet: TDataSet);
begin
  QDetalle.FieldByName('formato_fc').AsString := QMaestro.FieldByName('codigo_f').AsString;
  QDetalle.FieldByName('empresa_fc').AsString := QMaestro.FieldByName('empresa_f').AsString;
end;

procedure TDMFormatoPalets.QDetalleAfterPost(DataSet: TDataSet);
begin
  QDetalle.Close;
  QDetalle.Open;
end;

procedure TDMFormatoPalets.QMaestroBeforePost(DataSet: TDataSet);
begin
  if Trim(QMaestro.FieldByName('descripcion_f').AsString) = '' then
    QMaestro.FieldByName('descripcion_f').AsString := QMaestro.FieldByName('nombre_f').AsString;
  (*
  if QMaestro.State = dsInsert then
  begin
    if not QMaestro.Database.InTransaction then
    begin
      QMaestro.Database.StartTransaction;
      bMiTransaccion := True;
      try
        QMaestro.FieldByName('codigo_f').AsString := ContadorFormatoPalets;
      except
        QMaestro.Database.Rollback;
        bMiTransaccion := False;
      end;
    end
    else
    begin
      raise
        Exception.Create('No se puede garantizar la unicidad de la operación, por favor intentelo mas tarde.');
    end;
  end;
  *)
end;

procedure TDMFormatoPalets.QMaestroAfterPost(DataSet: TDataSet);
begin
(*
  if bMiTransaccion then
  begin
    QMaestro.Database.Commit;
    bMiTransaccion := False;
  end;
*)
end;

procedure TDMFormatoPalets.QMaestroPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
(*
  if bMiTransaccion then
  begin
    QMaestro.Database.Rollback;
    bMiTransaccion := False;
  end;
*)
end;

(*
function TDMFormatoPalets.ContadorFormatoPalets: string;
begin
  if QMaestroempresa_fpc.AsString = '' then
  begin
    raise Exception.Create('Falta el codigo de la empresa');
  end
  else
  begin
    QSelectContador.ParamByName('empresa').AsString :=
      QMaestro.FieldByName('empresa_fpc.AsString;
    QSelectContador.Open;
    if QSelectContador.IsEmpty then
    begin
      QInsertContador.ParamByName('empresa').AsString :=
        QMaestroempresa_fpc.AsString;
      QInsertContador.ParamByName('contador').AsInteger := 1;
      QInsertContador.ExecSQL;
      result := 'FP' + QMaestroempresa_fpc.AsString + '-0001';
    end
    else
    begin
      result := 'FP' + QMaestroempresa_fpc.AsString + '-' +
        Rellena(IntToStr(QSelectContador.FieldByName('contador_fp').AsInteger +
        1), 4, '0', taLeftJustify);
      ;

      QUpdateContador.ParamByName('empresa').AsString :=
        QMaestroempresa_fpc.AsString;
      QUpdateContador.ParamByName('contador').AsInteger :=
        QSelectContador.FieldByName('contador_fp').AsInteger + 1;
      QUpdateContador.ExecSQL;
    end;
    QSelectContador.Close;
  end;
end;
*)

procedure TDMFormatoPalets.Localizar(const AFiltro: string);
begin
  sWhere := AFiltro;
  with QMaestro do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sSelect);
    SQL.Add(sFrom);
    SQL.Add(sWhere);
    SQL.Add(sOrder);
    try
      Open;
    except
      raise Exception.Create('Error a aplicar el filtro.');
    end;
  end;
end;

procedure TDMFormatoPalets.VisualizarListado(const ADetalle: boolean);
begin
  if Trim(sWhere) <> '' then
  begin
    sWhereL := sWhere;
    sWhereL := sWhereL + #13 + #10 +
    ' and empresa_f = empresa_fc and codigo_f = formato_fc ';
  end
  else
  begin
    sWhereL := 'where empresa_f = empresa_fc and codigo_f = formato_fc ';
  end;


  with QListado do
  begin
    SQL.Clear;
    SQL.Add(sSelectL);
    SQL.Add(sFromL);
    SQL.Add(sWhereL);
    SQL.Add(sGroupL);
    SQL.Add(sOrderL);
    Open;
    try
      if not IsEmpty then
      begin
        FormatoPaletsQM.VisualizarListado( self, ADetalle );
      end;
    finally
      Close;
    end;
  end;
end;

end.
