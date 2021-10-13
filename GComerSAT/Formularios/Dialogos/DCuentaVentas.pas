unit DCuentaVentas;

///////////////////////////////////////////////////////////////////////
// ATENCION: PREPARADO PARA FACTURACION POR KILOS
///////////////////////////////////////////////////////////////////////

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Buttons, StdCtrls, BEdit, ExtCtrls,
  ActnList, Db, DBTables;

type
  TFDCuentaVentas = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Total: TBEdit;
    sbAceptar: TSpeedButton;
    sbCancelar: TSpeedButton;
    Grid: TDBGrid;
    ActionList1: TActionList;
    AMinimizar: TAction;
    AAceptar: TAction;
    ACancelar: TAction;
    Label1: TLabel;
    Table: TTable;
    Tableusuario_cv: TStringField;
    Tableempresa_cv: TStringField;
    Tablen_albaran_cv: TIntegerField;
    Tablefecha_sl: TDateField;
    Tablecentro_cv: TStringField;
    Tableproducto_cv: TStringField;
    Tableenvase_cv: TStringField;
    Tablemarca_cv: TStringField;
    Tablecalibre_cv: TStringField;
    Tablecolor_cv: TStringField;
    Tablecajas_cv: TIntegerField;
    Tablekilos_cv: TFloatField;
    Tableneto_cv: TFloatField;
    DataSource: TDataSource;
    Tableunidad_fac_cv: TStringField;
    Tableunidades_cv: TIntegerField;
    QLineas: TQuery;
    UpdateLineas: TUpdateSQL;
    QLineasempresa_sl: TStringField;
    QLineascentro_salida_sl: TStringField;
    QLineasn_albaran_sl: TIntegerField;
    QLineasfecha_sl: TDateField;
    QLineascentro_origen_sl: TStringField;
    QLineasproducto_sl: TStringField;
    QLineasenvase_sl: TStringField;
    QLineasmarca_sl: TStringField;
    QLineascategoria_sl: TStringField;
    QLineascalibre_sl: TStringField;
    QLineascolor_sl: TStringField;
    QLineasref_transitos_sl: TIntegerField;
    QLineascajas_sl: TIntegerField;
    QLineasunidades_caja_sl: TIntegerField;
    QLineaskilos_sl: TFloatField;
    QLineasprecio_sl: TFloatField;
    QLineasunidad_precio_sl: TStringField;
    QLineasimporte_neto_sl: TFloatField;
    QLineasporc_iva_sl: TFloatField;
    QLineasiva_sl: TFloatField;
    QLineasimporte_total_sl: TFloatField;
    QLineastipo_iva_sl: TStringField;
    QTotal: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AMinimizarExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure GridColEnter(Sender: TObject);
    procedure TableAfterPost(DataSet: TDataSet);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    CantidadTotal: Currency;

    procedure LimpiarTemporal;
    procedure RellenaTemporal;
    procedure PonTotal;
    procedure AsignarNetos;
    function ComprobarTotalesOk(var TotalGrabado: Currency): Boolean;
    function AsignarNetoPorKilos(kilos: Real; cantidad: Real): Real;
    function AsignarNetoPorCajas(cajas: Integer; cantidad: Real): Real;
    function AsignarNetoPorUnidades(llevamos, actual: Integer; cantidad: Real): Real;

  public
    { Public declarations }
    Error: boolean;
    FacturacionPorKilos: boolean;
  end;

var
  FDCuentaVentas: TFDCuentaVentas;

implementation

uses CVariables, MSalidas, UDMBaseDatos, DError, UDMAuxDB,
  bNumericUtils, bDialogs;

{$R *.DFM}

procedure TFDCuentaVentas.FormCreate(Sender: TObject);
begin
  with QLineas do
  begin
    SQL.Clear;
    SQL.Add(' SELECT empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, centro_origen_sl, producto_sl, envase_sl, marca_sl, ');
    SQL.Add('        categoria_sl, calibre_sl, color_sl, ref_transitos_sl, cajas_sl, unidades_caja_sl, kilos_sl, precio_sl, unidad_precio_sl, ');
    SQL.Add('        importe_neto_sl, porc_iva_sl, iva_sl, importe_total_sl, tipo_iva_sl ');
    SQL.Add(' FROM frf_salidas_l ');
    SQL.Add(' where empresa_sl=:empresa ');
    SQL.Add('  and centro_salida_sl=:centro ');
    SQL.Add('  and n_albaran_sl=:albaran ');
    SQL.Add('  and fecha_sl=:fecha ');
    SQL.Add('  order by producto_sl, envase_sl, marca_sl, categoria_sl, calibre_sl, color_sl, centro_origen_sl, ref_transitos_sl ');
  end;
  //Al crearse el formulario
  Error := false;
  FacturacionPorKilos := true;
  Total.Text := '';
  //Borrar tabla temporal
  LimpiarTemporal;
  //Rellenar tabla temporal
  if not error then RellenaTemporal;
  //Filtrar
  if not error then
  begin
    table.Filter := 'usuario_cv=' + QuotedStr(gsCodigo);
    table.Filtered := true;
    try
      table.Open;
      PonTotal;
    except
      Error := true;
      Exit;
    end;
  end;
end;

procedure TFDCuentaVentas.FormActivate(Sender: TObject);
begin
  //Al activarse
    Tableneto_cv.DisplayFormat := '#0.00;-#0.00';
end;

procedure TFDCuentaVentas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AL cerrarse
  //Borrar tabla temporal
  LimpiarTemporal;
end;

procedure TFDCuentaVentas.AMinimizarExecute(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TFDCuentaVentas.AAceptarExecute(Sender: TObject);
begin
  //Aceptar
  if Table.state = dsedit then
  begin
    Table.Post;
  end
  else
  begin
    AsignarNetos;
    Close;
  end
end;

procedure TFDCuentaVentas.ACancelarExecute(Sender: TObject);
begin
  //Cancelar
  if Table.State = dsEdit then Table.Cancel
  else Close;
end;

procedure TFDCuentaVentas.GridColEnter(Sender: TObject);
begin
  //Sólo dejamos movernos por la columna editable
  if Grid.SelectedField <> Tableneto_cv then
    Grid.SelectedField := Tableneto_cv;
end;

procedure TFDCuentaVentas.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Edicion de campos
  if Key = vk_Return then
  begin
    if Table.State = dsEdit then
    begin
      Table.Post;
      Table.Next;
      key := 0;
    end;
  end;
end;

procedure TFDCuentaVentas.TableAfterPost(DataSet: TDataSet);
begin
  //Poner total
  PonTotal;
end;

procedure TFDCuentaVentas.LimpiarTemporal;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQl.Clear;
    SQL.Add('Delete from tmp_cuenta_ventas where usuario_cv=' + QuotedStr(gsCodigo));
    try
      ExecSQL;
    except
      Error := true;
    end;
  end;
end;

procedure TFDCuentaVentas.RellenaTemporal;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQl.Clear;
    SQL.Add('insert into tmp_cuenta_ventas ' +
      ' select ' + QuotedStr(gsCodigo) + ',empresa_sl,centro_salida_sl,n_albaran_sl, ' +
      ' fecha_sl,unidad_precio_sl,producto_sl, ' +
      ' envase_sl,'''', marca_sl,calibre_sl,color_sl, ' +
      ' SUM(cajas_sl), SUM(cajas_sl*unidades_caja_sl), ' +
      ' SUM(kilos_sl),SUM(importe_neto_sl) ' +
      ' from frf_salidas_l,frf_envases ' +
      ' where empresa_sl=:empresa ' +
      ' and centro_salida_sl=:centro ' +
      ' and n_albaran_sl=:albaran ' +
      ' and fecha_sl=:fecha ' +
      ' and envase_sl=envase_e ' +
      ' group by 1,empresa_sl,centro_salida_sl,n_albaran_sl, ' +
      ' fecha_sl,unidad_precio_sl,producto_sl, ' +
      ' envase_sl,marca_sl,calibre_sl,color_sl ');
    ParamByName('empresa').AsString := FMSalidas.empresa_sc.Text;
    ParamByName('centro').AsString := FMSalidas.centro_salida_sc.Text;
    ParamByName('albaran').Asinteger := StrToInt(FMSalidas.n_albaran_sc.Text);
    ParamByName('fecha').AsDateTime := StrToDate(FMSalidas.fecha_sc.Text);
    try
      ExecSQL;
    except
      Error := true;
    end;
  end;
end;

procedure TFDCuentaVentas.PonTotal;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQl.Clear;
    SQL.Add('select SUM(neto_cv) from tmp_cuenta_ventas where usuario_cv=' + quotedStr(gsCodigo));
    try
      Open;
    except
      Total.Text := 'ERROR';
      Exit;
    end;
    if isEmpty then
    begin
      Total.Text := '';
      Exit;
    end;
    CantidadTotal := Fields[0].ASFloat;
    begin
      Total.Text := FormatFloat('#,##0.00;-#,##0.00', CantidadTotal);
    end;

  end;
end;

procedure TFDCuentaVentas.AsignarNetos;
var
  marca1: TBookMark;
  kilos, cantidad: Real;
  cajas, unidades: Integer;
  TotalGrabado: Currency;
begin
 //Deshabilitar movimento en la rejilla
  marca1 := table.GetBookmark;
  Table.DisableControls;

  if QLineas.Active then QLineas.Close;
  QLineas.ParamByName('empresa').AsString := FMSalidas.empresa_sc.Text;
  QLineas.ParamByName('centro').AsString := FMSalidas.centro_salida_sc.Text;
  QLineas.ParamByName('albaran').Asinteger := StrToInt(FMSalidas.n_albaran_sc.Text);
  QLineas.ParamByName('fecha').AsDateTime := StrToDate(FMSalidas.fecha_sc.Text);
  QLineas.Open;

 //Sin optimizacion alguna

 //O todo o nada
  if DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    ShowError('No se puede realizar las modificaciones en base de datos en este momento.' +
      ' Por favor inténtelo mas tarde.');
    table.GotoBookmark(marca1);
    table.FreeBookmark(marca1);
    Table.EnableControls;
    QLineas.Close;
    Exit;
  end
  else
  begin
    DMBaseDatos.DBBaseDatos.StartTransaction;
  end;

  try
   //Bucle externo
    table.First;
    while not table.Eof do
    begin
     //Bucle interno
      QLineas.First;
      kilos := 0;
      cantidad := 0;
      cajas := 0;
      unidades := 0;
      while not QLineas.Eof do
      begin
        if (Tableempresa_cv.AsString = QLineasempresa_sl.AsString) and
          (Tablecentro_cv.AsString = QLineascentro_salida_sl.AsString) and
          (Tablen_albaran_cv.Asinteger = QLineasn_albaran_sl.Asinteger) and
          (Tablefecha_sl.AsDateTime = QLineasfecha_sl.AsDateTime) and
          (Tableproducto_cv.AsString = QLineasproducto_sl.AsString) and
          (Tableenvase_cv.AsString = QLineasenvase_sl.AsString) and
          (Tablemarca_cv.AsString = QLineasmarca_sl.AsString) and
          (Tablecalibre_cv.AsString = QLineascalibre_sl.AsString) and
          (Tablecolor_cv.AsString = QLineascolor_sl.AsString) then
        begin

          if Tableunidad_fac_cv.AsString = 'KGS' then
          begin
            kilos := kilos + QLineaskilos_sl.AsFloat;
            cantidad := cantidad + AsignarNetoPorKilos(kilos, cantidad);
          end
          else
            if Tableunidad_fac_cv.AsString = 'CAJ' then
            begin
              cajas := cajas + QLineascajas_sl.Asinteger;
              cantidad := cantidad + AsignarNetoPorCajas(cajas, cantidad);
            end
            else
              if Tableunidad_fac_cv.AsString = 'UND' then
              begin
                cajas := QLineasunidades_caja_sl.Asinteger * QLineascajas_sl.Asinteger;
                unidades := unidades + cajas;
                cantidad := cantidad + AsignarNetoPorUnidades(unidades, cajas, cantidad);
              end;
        end;
        QLineas.Next;
      end;
      Table.Next;
    end;
  except
    DMBaseDatos.DBBaseDatos.Rollback;
    ShowError('Problemas a la hora de actualizar los precios, no se ha podido' +
      ' llevar a cabo la actualización.');
    table.GotoBookmark(marca1);
    table.FreeBookmark(marca1);
    Table.EnableControls;
    QLineas.Close;
    Exit
  end;

  table.GotoBookmark(marca1);
  table.FreeBookmark(marca1);
  Table.EnableControls;
  QLineas.Close;

  if ComprobarTotalesOk(TotalGrabado) then
  begin
    DMBaseDatos.DBBaseDatos.Commit;
    FMSalidas.TSalidasL.Close;
    FMSalidas.TSalidasL.Open;
  end
  else
  begin
    if Abs( CantidadTotal - TotalGrabado ) <= 0.01 then
    begin
      if Preguntar(' No concuerdan las cantidades introducidas en el formulario -> ' + FormatFloat('#,##0.00', CantidadTotal) + ') ' + #13 + #10 +
                ' con las asignadas automaticamente a las lineas del albarán -> ' + FormatFloat('#,##0.00', TotalGrabado) + ') ' + #13 + #10 +
                ' Hay una diferencia de ' + FormatFloat('#,##0.00', CantidadTotal - TotalGrabado ) + ' euros.' + #13 + #10 +
                ' ¿Seguro que desea continuar? Asegurese que las cantidades grabadas son correctas.') then
      begin
        DMBaseDatos.DBBaseDatos.Commit;
        FMSalidas.TSalidasL.Close;
        FMSalidas.TSalidasL.Open;
      end
      else
      begin
        DMBaseDatos.DBBaseDatos.RollBack;
      end;
    end
    else
    begin
      ShowError(' No concuerdan las cantidades introducidas en el formulario -> ' + FormatFloat('#,##0.00', CantidadTotal) + ') ' + #13 + #10 +
                ' con las asignadas automaticamente a las lineas del albarán -> ' + FormatFloat('#,##0.00', TotalGrabado) + ') ' +              #13 + #10 +
                ' Hay una diferencia de ' + FormatFloat('#,##0.00', CantidadTotal - TotalGrabado ) + ' euros.' );
      DMBaseDatos.DBBaseDatos.RollBack;
    end;
  end;
end;


function TFDCuentaVentas.ComprobarTotalesOk(var TotalGrabado: Currency): Boolean;
begin
  if QTotal.Active then QTotal.Close;
  QTotal.ParamByName('empresa').AsString := FMSalidas.empresa_sc.Text;
  QTotal.ParamByName('centro').AsString := FMSalidas.centro_salida_sc.Text;
  QTotal.ParamByName('albaran').Asinteger := StrToInt(FMSalidas.n_albaran_sc.Text);
  QTotal.ParamByName('fecha').AsDateTime := StrToDate(FMSalidas.fecha_sc.Text);
  QTotal.Open;

  TotalGrabado:= QTotal.Fields[0].AsCurrency;
  QTotal.Close;

  Result := (TotalGrabado = CantidadTotal);
end;

function TFDCuentaVentas.AsignarNetoPorKilos(kilos: Real; cantidad: Real): Real;
var
  decimales, decimalesPrecio: Integer;
  ultimo: boolean;
begin
  //decimales
  begin
    decimales := 2;
    decimalesPrecio := 3;
  end;

  //Estamos en el ultimo registro del conjunto de transitos
  //Lo necesitamos saber para ajustar las cantidades
  if kilos = Tablekilos_cv.AsFloat then
    ultimo := true
  else
    ultimo := false;

  QLineas.Edit;

  if (trim(Tableneto_cv.AsString) = '') or
    (Tableneto_cv.AsFloat = 0) then
  begin
    QLineasimporte_neto_sl.AsFloat := 0;
    QLineasprecio_sl.AsFloat := 0;
    QLineasiva_sl.AsFloat := 0;
    QLineasimporte_total_sl.AsFloat := 0;
    QLineas.Post;
    Result := 0;
    Exit;
  end;


  //Nuevo neto
  if not ultimo then
    QLineasimporte_neto_sl.AsFloat :=
      Redondea((QLineaskilos_sl.AsFloat *
      Tableneto_cv.AsFloat) / Tablekilos_cv.AsFloat, decimales)
  else
    QLineasimporte_neto_sl.AsFloat :=
      Redondea(Tableneto_cv.AsFloat - cantidad, decimales);

  //Nuevo precio
  if QLineaskilos_sl.AsFloat <> 0 then
  begin
    QLineasprecio_sl.AsFloat :=
      Redondea(QLineasimporte_neto_sl.AsFloat /
      QLineaskilos_sl.AsFloat, decimalesPrecio);
  end
  else
  begin
    QLineasprecio_sl.AsFloat := 0;
  end;

  //Nuevo iva
  if QLineasporc_iva_sl.AsFloat = 0 then
  begin
    QLineasiva_sl.AsFloat := 0;
    QLineasimporte_total_sl.AsFloat :=
      QLineasimporte_neto_sl.AsFloat;
    QLineas.Post;
    Result := QLineasimporte_neto_sl.AsFloat;
    Exit;
  end;

  QLineasiva_sl.AsFloat :=
    Redondea((QLineasporc_iva_sl.AsFloat / 100) *
    QLineasimporte_neto_sl.AsFloat, decimales);

  //Nuevo total
  QLineasimporte_total_sl.AsFloat :=
    Redondea(QLineasimporte_neto_sl.AsFloat +
    QLineasiva_sl.AsFloat, decimales);

  QLineas.Post;
  Result := QLineasimporte_neto_sl.asfloat;
end;

function TFDCuentaVentas.AsignarNetoPorCajas(cajas: Integer; cantidad: Real): Real;
var
  decimales, decimalesPrecio: Integer;
  ultimo: boolean;
begin
  //decimales
  begin
    decimales := 2;
    decimalesPrecio := 3;
  end;

  //Estamos en el ultimo registro del conjunto de transitos
  //Lo necesitamos saber para ajustar las cantidades
  if cajas = Tablecajas_cv.Asinteger then
    ultimo := true
  else
    ultimo := false;

  QLineas.Edit;

  if (trim(Tableneto_cv.AsString) = '') or
    (Tableneto_cv.AsFloat = 0) then
  begin
    QLineasimporte_neto_sl.AsFloat := 0;
    QLineasprecio_sl.AsFloat := 0;
    QLineasiva_sl.AsFloat := 0;
    QLineasimporte_total_sl.AsFloat := 0;
    QLineas.Post;
    Result := 0;
    Exit;
  end;


  //Nuevo neto
  if not ultimo then
    QLineasimporte_neto_sl.AsFloat :=
      Redondea((QLineaskilos_sl.AsFloat *
      Tableneto_cv.AsFloat) / Tablekilos_cv.AsFloat, decimales)
  else
    QLineasimporte_neto_sl.AsFloat :=
      Redondea(Tableneto_cv.AsFloat - cantidad, decimales);

  //Nuevo precio
  QLineasprecio_sl.AsFloat :=
    Redondea(QLineasimporte_neto_sl.AsFloat /
    QLineascajas_sl.AsFloat, decimalesPrecio);

  //Nuevo iva
  if QLineasporc_iva_sl.AsFloat = 0 then
  begin
    QLineasiva_sl.AsFloat := 0;
    QLineasimporte_total_sl.AsFloat :=
      QLineasimporte_neto_sl.AsFloat;
    QLineas.Post;
    Result := QLineasimporte_neto_sl.AsFloat;
    Exit;
  end;

  QLineasiva_sl.AsFloat :=
    Redondea((QLineasporc_iva_sl.AsFloat / 100) *
    QLineasimporte_neto_sl.AsFloat, decimales);

  //Nuevo total
  QLineasimporte_total_sl.AsFloat :=
    Redondea(QLineasimporte_neto_sl.AsFloat +
    QLineasiva_sl.AsFloat, decimales);

  QLineas.Post;
  Result := QLineasimporte_neto_sl.AsFloat;
end;

function TFDCuentaVentas.AsignarNetoPorUnidades(llevamos, actual: Integer; cantidad: Real): Real;
var
  decimales, decimalesPrecio: Integer;
  ultimo: boolean;
begin
  //decimales
  begin
    decimales := 2;
    decimalesPrecio := 3;
  end;

  //Estamos en el ultimo registro del conjunto de transitos
  //Lo necesitamos saber para ajustar las cantidades
  if llevamos = Tableunidades_cv.Asinteger then
    ultimo := true
  else
    ultimo := false;

  QLineas.Edit;

  if (trim(Tableneto_cv.AsString) = '') or
    (Tableneto_cv.AsFloat = 0) then
  begin
    QLineasimporte_neto_sl.AsFloat := 0;
    QLineasprecio_sl.AsFloat := 0;
    QLineasiva_sl.AsFloat := 0;
    QLineasimporte_total_sl.AsFloat := 0;
    QLineas.Post;
    Result := 0;
    Exit;
  end;


  //Nuevo neto
  if not ultimo then
    QLineasimporte_neto_sl.AsFloat :=
      Redondea((QLineaskilos_sl.AsFloat *
      Tableneto_cv.AsFloat) / Tablekilos_cv.AsFloat, decimales)
  else
    QLineasimporte_neto_sl.AsFloat :=
      Redondea(Tableneto_cv.AsFloat - cantidad, decimales);

  //Nuevo precio
  QLineasprecio_sl.AsFloat :=
    Redondea(QLineasimporte_neto_sl.AsFloat /
    actual, decimalesPrecio);

  //Nuevo iva
  if QLineasporc_iva_sl.AsFloat = 0 then
  begin
    QLineasiva_sl.AsFloat := 0;
    QLineasimporte_total_sl.AsFloat :=
      QLineasimporte_neto_sl.AsFloat;
    QLineas.Post;
    Result := QLineasimporte_neto_sl.AsFloat;
    Exit;
  end;

  QLineasiva_sl.AsFloat :=
    Redondea((QLineasporc_iva_sl.AsFloat / 100) *
    QLineasimporte_neto_sl.AsFloat, decimales);

  //Nuevo total
  QLineasimporte_total_sl.AsFloat :=
    Redondea(QLineasimporte_neto_sl.AsFloat +
    QLineasiva_sl.AsFloat, decimales);

  QLineas.Post;
  Result := QLineasimporte_neto_sl.AsFloat;
end;

procedure TFDCuentaVentas.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '.' then
  begin
    Key := ',';
  end;
end;

procedure TFDCuentaVentas.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (DataCol = 0) and (Column.Field.AsString <> '') then
  begin
    TDBGrid(Sender).Canvas.TextRect(Rect, rect.Left + 4, rect.top + 2,
      desProducto(Table.fieldbyName('empresa_cv').AsString, Column.Field.AsString));
  end
  else
    if (DataCol = 1) and (Column.Field.AsString <> '') then
    begin
      TDBGrid(Sender).Canvas.TextRect(Rect, rect.Left + 4, rect.top + 2,
        desEnvase(Tableempresa_cv.AsString, Column.Field.AsString));
    end
    else
      if (DataCol = 2) and (Column.Field.AsString <> '') then
      begin
        TDBGrid(Sender).Canvas.TextRect(Rect, rect.Left + 4, rect.top + 2,
          desMarca(Column.Field.AsString));
      end
      else
      begin
        TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
      end;
end;

end.
