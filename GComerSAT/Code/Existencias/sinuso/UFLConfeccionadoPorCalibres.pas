unit UFLConfeccionadoPorCalibres;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, BEdit, nbLabels, DBTables;

type
  TDFLConfeccionadoPorCalibres = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    des_empresa: TnbStaticText;
    des_centro: TnbStaticText;
    des_producto: TnbStaticText;
    empresa: TBEdit;
    centro: TBEdit;
    producto: TBEdit;
    fecha: TBEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    dDesde: TDate;
    Calibres: TStringList;

    function  RangoValidos: Boolean;
    procedure VisualizarListado;
    function  CalibresListado: Integer;
    procedure CrearComponentes;
    procedure PreparaTablas;
    procedure DespreparaTablas;
    function  UltimoInventario: TDate;
    function  ObservacionesInventario: boolean;

  public
    { Public declarations }
    QDetListInventario: TQuery;
    QAntesInventario: TQuery;
    QSalidas: TQuery;
    QTransitos: TQuery;
    QNotaInventario: TQuery;

    function  DatosListados(categoria: string): boolean;
  end;

var
  FLConfeccionadoPorCalibres: TDFLConfeccionadoPorCalibres;

implementation

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, UDMBaseDatos,
  DPreview, CReportes, DError, Qrctrls, UQLConfeccionadoPorCalibres, DB;

{$R *.dfm}

procedure TDFLConfeccionadoPorCalibres.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TDFLConfeccionadoPorCalibres.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DespreparaTablas;
  QDetListInventario.Free;
  QAntesInventario.Free;
  QSalidas.Free;
  QTransitos.Free;
  QNotaInventario.Free;

  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TDFLConfeccionadoPorCalibres.FormCreate(Sender: TObject);
begin
  QDetListInventario := TQuery.Create(nil);
  QDetListInventario.DatabaseName := 'BDProyecto';
  QDetListInventario.SQL.Add(' select envase_il,descripcion_e, medida_c, calibre_il, ');
  QDetListInventario.SQL.Add('        SUM( case when 1 = :categoria then cajas_ce_c1_il else cajas_ce_c2_il end) cajas_il, ');
  QDetListInventario.SQL.Add('        SUM( case when 1 = :categoria then kilos_ce_c1_il else kilos_ce_c2_il end) kilos_il ');
  QDetListInventario.SQL.Add(' from frf_inventarios_l, frf_envases, frf_calibres ');
  QDetListInventario.SQL.Add(' where empresa_il = :empresa ');
  QDetListInventario.SQL.Add(' and centro_il = :centro ');
  QDetListInventario.SQL.Add(' and producto_il = :producto ');
  QDetListInventario.SQL.Add(' and fecha_il= :fecha ');
  QDetListInventario.SQL.Add(' and empresa_e = :empresa ');
  QDetListInventario.SQL.Add(' and envase_e = envase_il ');
  QDetListInventario.SQL.Add(' and empresa_c = :empresa ');
  QDetListInventario.SQL.Add(' and producto_c = :producto ');
  QDetListInventario.SQL.Add(' and calibre_c = calibre_il ');
  QDetListInventario.SQL.Add(' group by envase_il,descripcion_e, medida_c, calibre_il ');
  QDetListInventario.SQL.Add(' having NVL( SUM( case when 1 = :categoria then kilos_ce_c1_il else kilos_ce_c2_il end), 0) <> 0 ');
  QDetListInventario.SQL.Add(' order by envase_il,medida_c ');

  QAntesInventario := TQuery.Create(nil);
  QAntesInventario.DatabaseName := 'BDProyecto';
  QAntesInventario.SQL.Add(' select medida_c, calibre_il, ');
  QAntesInventario.SQL.Add('        SUM( case when 1 = :categoria then kilos_ce_c1_il else kilos_ce_c2_il end) kilos_il ');
  QAntesInventario.SQL.Add(' from frf_inventarios_l,frf_envases,frf_calibres ');
  QAntesInventario.SQL.Add(' where empresa_il = :empresa ');
  QAntesInventario.SQL.Add(' and centro_il = :centro ');
  QAntesInventario.SQL.Add(' and producto_il = :producto ');
  QAntesInventario.SQL.Add(' and fecha_il = :fecha ');
  QAntesInventario.SQL.Add(' and empresa_e = :empresa ');
  QAntesInventario.SQL.Add(' and envase_e = envase_il ');
  QAntesInventario.SQL.Add(' and empresa_c = :empresa ');
  QAntesInventario.SQL.Add(' and producto_c = :producto ');
  QAntesInventario.SQL.Add(' and calibre_c = calibre_il ');
  QAntesInventario.SQL.Add(' group by medida_c, calibre_il ');
  QAntesInventario.SQL.Add(' having NVL( SUM( case when 1 = :categoria then kilos_ce_c1_il else kilos_ce_c2_il end), 0) <> 0 ');
  QAntesInventario.SQL.Add(' order by medida_c ');

  QNotaInventario := TQuery.Create(nil);
  QNotaInventario.DatabaseName := 'BDProyecto';
  QNotaInventario.SQL.Add(' select notas_ic ');
  QNotaInventario.SQL.Add(' from frf_inventarios_c ');
  QNotaInventario.SQL.Add(' where empresa_ic = :empresa ');
  QNotaInventario.SQL.Add(' and centro_ic = :centro ');
  QNotaInventario.SQL.Add(' and producto_ic = :producto ');
  QNotaInventario.SQL.Add(' and fecha_ic= :fecha ');

  QSalidas := TQuery.Create(nil);
  QSalidas.DatabaseName := 'BDProyecto';
  QSalidas.SQL.Text :=
    ' select medida_c,calibre_sl,sum (kilos_sl) as peso_calibre ' +
    ' from frf_salidas_l,frf_calibres ' +
    ' where empresa_sl=:empresa ' +
    '   and centro_salida_sl=:centro ' +
    '   and centro_origen_sl=:centro ' +
    '   and producto_sl=:producto ' +
    '   and fecha_sl=:fecha ' +
    '   and categoria_sl=:categoria ' +
    '   and empresa_c = :empresa ' +
    '   and producto_c = :producto ' +
    '   and calibre_c = calibre_sl ' +
    ' group by medida_c,calibre_sl ' +
    ' order by medida_c ';

  QTransitos := TQuery.Create(nil);
  QTransitos.DatabaseName := 'BDProyecto';
  QTransitos.SQL.Text :=
    ' select medida_c,calibre_tl,sum (kilos_tl) as peso_calibre ' +
    'from frf_calibres,frf_transitos_l  ' +
    'where empresa_tl=:empresa ' +
    '  and centro_origen_tl=:centro ' +
    '  and producto_tl=:producto ' +
    '  and fecha_tl=:fecha ' +
    '  and categoria_tl=:categoria ' +
    '   and empresa_c = :empresa ' +
    '   and producto_c = :producto ' +
    '   and calibre_c = calibre_tl ' +
    'group by medida_c,calibre_tl ' +
    'order by medida_c  ';

  PreparaTablas;

  FormType := tfOther;
  BHFormulario;

  empresa.Text := '050';
  centro.Text := '6';
  producto.Text := 'E';

  fecha.Text := DateToStr(Date - 1);
end;

procedure TDFLConfeccionadoPorCalibres.PreparaTablas;
begin
  if not QDetListInventario.Prepared then
  begin
    QDetListInventario.Cancel;
    QDetListInventario.Close;
    QDetListInventario.Prepare;
  end;
  if not QNotaInventario.Prepared then
  begin
    QNotaInventario.Cancel;
    QNotaInventario.Close;
    QNotaInventario.Prepare;
  end;
  if not QAntesInventario.Prepared then
  begin
    QAntesInventario.Cancel;
    QAntesInventario.Close;
    QAntesInventario.Prepare;
  end;
  if not QSalidas.Prepared then
  begin
    QSalidas.Cancel;
    QSalidas.Close;
    QSalidas.Prepare;
  end;
  if not QTransitos.Prepared then
  begin
    QTransitos.Cancel;
    QTransitos.Close;
    QTransitos.Prepare;
  end;
end;

procedure TDFLConfeccionadoPorCalibres.DespreparaTablas;
begin
  if QDetListInventario.Prepared then
  begin
    QDetListInventario.Cancel;
    QDetListInventario.Close;
    QDetListInventario.UnPrepare;
  end;
  if QNotaInventario.Prepared then
  begin
    QNotaInventario.Cancel;
    QNotaInventario.Close;
    QNotaInventario.UnPrepare;
  end;
  if QAntesInventario.Prepared then
  begin
    QAntesInventario.Cancel;
    QAntesInventario.Close;
    QAntesInventario.UnPrepare;
  end;
  if QSalidas.Prepared then
  begin
    QSalidas.Cancel;
    QSalidas.Close;
    QSalidas.UnPrepare;
  end;
  if QTransitos.Prepared then
  begin
    QTransitos.Cancel;
    QTransitos.Close;
    QTransitos.UnPrepare;
  end;
end;

function TDFLConfeccionadoPorCalibres.UltimoInventario: TDate;
begin
  with DMBAseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' select max(fecha_ic) as fecha ' +
      ' from frf_inventarios_c ' +
      ' where fecha_ic<:fecha ' +
      ' and empresa_ic=:empresa ' +
      ' and centro_ic=:centro ' +
      ' and producto_ic=:producto ');
    ParamByName('fecha').AsDateTime := StrTodate(fecha.Text);
    ParamByName('empresa').AsString := empresa.Text;
    ParamByName('centro').AsString := centro.Text;
    ParamByName('producto').AsString := producto.Text;
    try
      Open;
      if isempty then UltimoInventario := StrTodate(fecha.Text) - 1
      else UltimoInventario := FieldByName('fecha').asdatetime;
    except
      UltimoInventario := StrTodate(fecha.Text) - 1;
    end;
  end;
end;

function TDFLConfeccionadoPorCalibres.ObservacionesInventario: boolean;
begin
  QNotaInventario.Close;
  QNotaInventario.ParamByName('empresa').asstring := empresa.text;
  QNotaInventario.ParamByName('centro').asstring := centro.Text;
  QNotaInventario.ParamByName('producto').asstring := producto.Text;
  QNotaInventario.ParamByName('fecha').AsDateTime := StrTodate(fecha.Text);
  QNotaInventario.Open;
  ObservacionesInventario := not QNotaInventario.IsEmpty;
end;

function TDFLConfeccionadoPorCalibres.DatosListados(categoria: string): boolean;
begin
  DatosListados := true;

  QDetListInventario.Close;
  QDetListInventario.ParamByName('empresa').asstring := empresa.text;
  QDetListInventario.ParamByName('centro').asstring := centro.Text;
  QDetListInventario.ParamByName('producto').asstring := producto.Text;
  QDetListInventario.ParamByName('fecha').AsDateTime := StrTodate(fecha.Text);
  QDetListInventario.ParamByName('categoria').asstring := categoria;
  QDetListInventario.Open;

  if QDetListInventario.IsEmpty then
    DatosListados := false;

  QAntesInventario.Close;
  QAntesInventario.ParamByName('empresa').asstring := empresa.text;
  QAntesInventario.ParamByName('centro').asstring := centro.Text;
  QAntesInventario.ParamByName('producto').asstring := producto.Text;
  QAntesInventario.ParamByName('fecha').asdatetime := UltimoInventario;
  QAntesInventario.ParamByName('categoria').asstring := categoria;
  QAntesInventario.Open;

  QSalidas.Close;
  QSalidas.ParamByName('empresa').asstring := empresa.text;
  QSalidas.ParamByName('centro').asstring := centro.Text;
  QSalidas.ParamByName('producto').asstring := producto.Text;
  QSalidas.ParamByName('fecha').AsDateTime := StrTodate(fecha.Text);
  QSalidas.ParamByName('categoria').asstring := categoria;
  QSalidas.Open;

  QTransitos.Close;
  QTransitos.ParamByName('empresa').asstring := empresa.text;
  QTransitos.ParamByName('centro').asstring := centro.Text;
  QTransitos.ParamByName('producto').asstring := producto.Text;
  QTransitos.ParamByName('fecha').AsDateTime := StrTodate(fecha.Text);
  QTransitos.ParamByName('categoria').asstring := categoria;
  QTransitos.Open;

end;

procedure TDFLConfeccionadoPorCalibres.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    vk_escape:
      begin
        btnCancelar.Click;
      end;
    vk_f1:
      begin
        btnAceptar.Click;
      end;
  end;
end;

procedure TDFLConfeccionadoPorCalibres.btnAceptarClick(Sender: TObject);
begin
  if RangoValidos then
  begin
    VisualizarListado;
  end;
end;

procedure TDFLConfeccionadoPorCalibres.VisualizarListado;
begin

  QLConfeccionadoPorCalibres := TDQLConfeccionadoPorCalibres.Create(Application);
  try
    PonLogoGrupoBonnysa(QLConfeccionadoPorCalibres, empresa.Text);

        //Calibres
    Calibres := TStringList.Create;
    QLConfeccionadoPorCalibres.calibres := CalibresListado;
    QLConfeccionadoPorCalibres.tipoCalibres.AddStrings(Calibres);

        //Crear array de componentes del listado

    CrearComponentes;
    Calibres.Free;

        //Titulo del informe
    QLConfeccionadoPorCalibres.lblFecha.Caption := fecha.Text;
    QLConfeccionadoPorCalibres.lblCentro.Caption := des_centro.Caption;
    QLConfeccionadoPorCalibres.lblProducto.Caption := des_producto.Caption;

    //Observaciones
    QLConfeccionadoPorCalibres.PsQRMemo.Enabled := False;
    QLConfeccionadoPorCalibres.PsQRLabelObs.Enabled := False;
    try
      if ObservacionesInventario then
      begin
        Preview(QLConfeccionadoPorCalibres);
      end
      else
      begin
        FreeAndNil( QLConfeccionadoPorCalibres );
        ShowMessage('Inventario inexistente. Por favor verifique que los parametros de busqueda sean correctos.');
      end;
    except
      FreeAndNil( QLConfeccionadoPorCalibres );
      raise;
    end;
  finally
        //Cerrar tablas
    QDetListInventario.Close;
    QNotaInventario.Close;
    QAntesInventario.Close;
    QSalidas.Close;
    QTransitos.Close;
  end;
end;

function TDFLConfeccionadoPorCalibres.CalibresListado: Integer;
begin
     //Busqueda de calibres
  with DMBAseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' select   calibre_c, medida_c ' +
      ' from     frf_calibres ' +
      ' where    empresa_c=:empresa ' +
      '   and    producto_c=:producto ' +
      ' order by medida_c,calibre_c');
    ParamByName('empresa').AsString := empresa.Text;
    ParamByName('producto').AsString := producto.Text;
    try
      Open;
      if isempty then
      begin
        ShowError('Error al localizar la descripción de las categorias.');
        CalibresListado := 0;
        Exit;
      end;
      Calibres.Clear;
      while not EOF do
      begin
        Calibres.Add(FieldByName('calibre_c').AsString);
        Next;
      end;
    except
      ShowError('Error al localizar la descripción de las categorias.');
      CalibresListado := 0;
      Exit;
    end;
    CalibresListado := RecordCount;
  end;
end;

procedure TDFLConfeccionadoPorCalibres.CrearComponentes;
var i: Integer;
begin
  with QLConfeccionadoPorCalibres do
  begin
    SetLength(detalle, calibres);
    SetLength(titulo, calibres);
    SetLength(sumaKilosDetalle, calibres);
    SetLength(sumaKilosAyer, calibres);
    SetLength(sumaSalidas, calibres);
    SetLength(salTransitos, calibres);
    SetLength(salNacional, calibres);
    SetLength(confeccionado, calibres);
    SetLength(confeccionadoTotal, calibres);

    for i := 0 to calibres - 1 do
    begin
      titulo[i] := TQRLabel.Create(QLConfeccionadoPorCalibres);
      with titulo[i] do
      begin
        Parent := BandaCabecera;
        Transparent := true;
        Width := 48;
        Left := 211 + (53 * i);
        Top := 2;
        Height := 17;
        Alignment := taRightJustify;
        Tag := i;
        Font.Style := Font.Style + [fsBold];
        Caption := self.Calibres[i];
        Visible := true;
      end;


      detalle[i] := TQRLabel.Create(QLConfeccionadoPorCalibres);
      with detalle[i] do
      begin
        Parent := BandaCalibres;
        Transparent := true;
        Width := 48;
        Left := 211 + (53 * i);
        Top := 1;
        Height := 17;
        Alignment := taRightJustify;
        Tag := i;
        Font.size := 8;
      end;

      sumaKilosDetalle[i] := TQRLabel.Create(QLConfeccionadoPorCalibres);
      with sumaKilosDetalle[i] do
      begin
        Parent := BandaSintesis;
        Transparent := true;
        Width := 48;
        Left := 211 + (53 * i);
        Top := 9;
        Height := 17;
        Alignment := taRightJustify;
        Tag := 0;
        Font.size := 8;
      end;

      sumaKilosAyer[i] := TQRLabel.Create(QLConfeccionadoPorCalibres);
      with sumaKilosAyer[i] do
      begin
        Parent := BandaSintesis;
        Transparent := true;
        Width := 48;
        Left := 211 + (53 * i);
        Top := 73;
        Height := 17;
        Alignment := taRightJustify;
        Tag := 0;
        Font.size := 8;
      end;

      sumaSalidas[i] := TQRLabel.Create(QLConfeccionadoPorCalibres);
      with sumaSalidas[i] do
      begin
        Parent := BandaSintesis;
        Transparent := true;
        Width := 48;
        Left := 211 + (53 * i);
        Top := 25;
        Height := 17;
        Alignment := taRightJustify;
        Tag := 0;
        Font.size := 8;
      end;

      salTransitos[i] := TQRLabel.Create(QLConfeccionadoPorCalibres);
      with salTransitos[i] do
      begin
        Parent := BandaSintesis;
        Transparent := true;
        Width := 48;
        Left := 211 + (53 * i);
        Top := 57;
        Height := 17;
        Alignment := taRightJustify;
        Tag := 0;
        Font.size := 8;
      end;

      salNacional[i] := TQRLabel.Create(QLConfeccionadoPorCalibres);
      with salNacional[i] do
      begin
        Parent := BandaSintesis;
        Transparent := true;
        Width := 48;
        Left := 211 + (53 * i);
        Top := 41;
        Height := 17;
        Alignment := taRightJustify;
        Tag := 0;
        Font.size := 8;
      end;

      confeccionado[i] := TQRLabel.Create(QLConfeccionadoPorCalibres);
      with confeccionado[i] do
      begin
        Parent := BandaSintesis;
        Transparent := true;
        Width := 48;
        Left := 211 + (53 * i);
        Top := 89;
        Height := 17;
        Alignment := taRightJustify;
        Tag := 0;
        Font.size := 8;
      end;

      confeccionadoTotal[i] := TQRLabel.Create(QLConfeccionadoPorCalibres);
      with confeccionadoTotal[i] do
      begin
        Parent := BandaResumen;
        Transparent := true;
        Width := 48;
        Left := 211 + (53 * i);
        Top := 20;
        Height := 17;
        Alignment := taRightJustify;
        Tag := 0;
        Font.size := 8;
      end;
    end;
  end;
end;

function TDFLConfeccionadoPorCalibres.RangoValidos: Boolean;
begin
  result := false;
  //Comprobar que las fechas sean correctas
  try
    dDesde := StrToDate(fecha.Text);
  except
    fecha.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  result := true;
end;

procedure TDFLConfeccionadoPorCalibres.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TDFLConfeccionadoPorCalibres.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TDFLConfeccionadoPorCalibres.productoChange(Sender: TObject);
begin
  des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TDFLConfeccionadoPorCalibres.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

end.
