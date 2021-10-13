(*
Los kilos de retirada no tienen en cuenta al cliente RET. Se comento con Jose Aparicio, 3/10/200,
pendiente de que lo comente con exportacion y n diga lo que quiere.
*)
unit LSalidasAlmacen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids, dbtables,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton;

type
  TFLSalidasAlmacen = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    BGBCentroOrigen: TBGridButton;
    LCentro: TLabel;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LProducto: TLabel;
    BGBProducto: TBGridButton;
    STCentroOrigen: TStaticText;
    STProducto: TStaticText;
    STEmpresa: TStaticText;
    EEmpresa: TBEdit;
    ECentroOrigen: TBEdit;
    EProducto: TBEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    BCBDesde: TBCalendarButton;
    BCBHasta: TBCalendarButton;
    MEDesde: TBEdit;
    MEHasta: TBEdit;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label3: TLabel;
    Label4: TLabel;
    ECentroSalida: TBEdit;
    BGBCentroSalida: TBGridButton;
    STCentroSalida: TStaticText;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);

  private
    { Private declarations }
    function DatosValidos: Boolean;

    function NumeroSemana(inicio, fin: string): string;

    function RellenarTablaTemporal: Boolean;
    //function  sacarKilosCliente( ACliente: String): Real;
    function sacarRetirada: Real;
    function sacarConserva: Real;
    function sacarTercera: Real;

    procedure ReiniciarTablas;

  public
    { Public declarations }
    empresa, centroOrigen, centroSalida, producto: string;
    fechaInicio, fechaFin: TDate;

    retirada, conserva, tercera: Real;
  end;

var
  FLSalidasAlmacen: TFLSalidasAlmacen;

implementation

uses CVariables, UDMAuxDB, QLSalidasAlmacen, UDMBaseDatos, CReportes,
  CAuxiliarDB, DError, Principal, DPreview, bTimeUtils, bSQLUtils,
  UDMConfig;

{$R *.DFM}

procedure TFLSalidasAlmacen.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFLSalidasAlmacen.DatosValidos: Boolean;
begin
  DatosValidos := false;

  //Comprobar si los campos se han rellenado correctamente
  if EEmpresa.Text = '' then
  begin
    MessageDlg('Debe introducir algun dato en el campo "Empresa"',
      mtError, [mbOk], 0);
    EEmpresa.SetFocus;
    Exit;
  end
  else
  begin
    if STEmpresa.Caption = '' then
    begin
      MessageDlg('"Empresa" incorrecta.',
        mtError, [mbOk], 0);
      EEmpresa.SetFocus;
      Exit;
    end;
  end;

  if EProducto.Text = '' then
  begin
    MessageDlg('Debe introducir algún dato en el campo "Producto"',
      mtError, [mbOk], 0);
    EProducto.SetFocus;
    Exit;
  end
  else
  begin
    if STProducto.Caption = '' then
    begin
      MessageDlg('"Producto" incorrecto.',
        mtError, [mbOk], 0);
      EProducto.SetFocus;
      Exit;
    end;
  end;

  if ECentroOrigen.Text = '' then
  begin
    MessageDlg('Debe introducir algún dato en el campo "Centro Origen"',
      mtError, [mbOk], 0);
    ECentroOrigen.SetFocus;
    Exit;
  end
  else
  begin
    if STCentroOrigen.Caption = '' then
    begin
      MessageDlg('"Centro Origen" incorrecto.',
        mtError, [mbOk], 0);
      ECentroOrigen.SetFocus;
      Exit;
    end;
  end;

  if ECentroSalida.Text <> '' then
  begin
    if STCentroSalida.Caption = '' then
    begin
      MessageDlg('"Centro Salida" incorrecto.',
        mtError, [mbOk], 0);
      ECentroSalida.SetFocus;
      Exit;
    end;
  end;

  //Fecha hasta mayor fecha desde
  if StrToDate(MEdesde.Text) > StrToDate(MEhasta.Text) then
  begin
    MessageDlg('La fecha "Hasta" debe ser mayor o igual que la del campo "Desde".',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
    Exit;
  end;

  DatosValidos := true;
end;

procedure TFLSalidasAlmacen.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if not DatosValidos then eXit;

  //.......................NOMBRE CENTRO Y PRODUCTO.................
  empresa := STEmpresa.Caption;
  centroOrigen := STCentroOrigen.Caption;
  producto := STProducto.Caption;

  //Rango de fechas
  fechaInicio := StrToDate(MEDesde.text);
  FechaFin := StrToDate(MEHasta.text);

  //···························:::::::::::::::::::::::····························
  try
    if not RellenarTablaTemporal then
      Exit;
  except
    on E: Exception do
    begin
         //Mensaje de error
      MessageDlg('Error al intentar seleccionar los datos.', mtError, [mbOk], 0);
      ReiniciarTablas;
      Exit;
    end;
  end;
  retirada := sacarRetirada;
  conserva := sacarConserva;
  tercera := sacarTercera;

  //ViSUALIZAMOS INFORME
  QRLSalidasAlmacen := TQRLSalidasAlmacen.Create(Application);
  try
     //Retirada
    QRLSalidasAlmacen.lblRetirada.caption := 'Retirada [2B] = ' + FormatFloat('#,##0', retirada);

     //Conserva
    QRLSalidasAlmacen.lblIndustria.Caption := 'Destrucción [3B] = ' + FormatFloat('#,##0', conserva);

     //Tercera
    QRLSalidasAlmacen.lblTercera.Caption := 'Tercera = ' + FormatFloat('#,##0', tercera);

     //Transito
     //QRLSalidasAlmacen.PTC1.Caption:=FormatFloat('#,##0',transitoCat1);
     //QRLSalidasAlmacen.PTC2.Caption:=FormatFloat('#,##0',transitoCat2);
     //QRLSalidasAlmacen.PTT.Caption:=FormatFloat('#,##0',transitoTotal);

     //Datos estaticos
    QRLSalidasAlmacen.empresa := EEmpresa.Text;
    QRLSalidasAlmacen.producto := EProducto.Text;
    QRLSalidasAlmacen.lblOrigen.Caption := 'CENTRO ORIGEN: ' + ECentroOrigen.Text;
    if ECentroSalida.Text = '' then
      QRLSalidasAlmacen.lblSalida.Caption := 'CENTRO SALIDA: CUALQUIERA'
    else
      QRLSalidasAlmacen.lblSalida.Caption := 'CENTRO SALIDA: ' + ECentroSalida.Text;
    QRLSalidasAlmacen.lblProducto.Caption := EProducto.Text + '  ' + producto;
    QRLSalidasAlmacen.lblPeriodo.Caption := 'Periodo : ' +
      DateTostr(fechaInicio) + ' al ' +
      MEHasta.Text;
     //averiguar el numero de la semana
    QRLSalidasAlmacen.lblNumSemana.Caption := NumeroSemana(DateToStr(fechainicio), MEHasta.Text);

     //Mostrar listado
    PonLogoGrupoBonnysa(QRLSalidasAlmacen, EEmpresa.Text);
    Preview(QRLSalidasAlmacen);
  except
    QRLSalidasAlmacen.Free;
  end;
  ReiniciarTablas;
end;

procedure TFLSalidasAlmacen.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;


procedure TFLSalidasAlmacen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAuxQuerys;
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFLSalidasAlmacen.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  ECentroOrigen.Tag := kCentro;
  ECentroSalida.Tag := kCentro;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;
  CalendarioFlotante.Date := Date;

  EEmpresa.Text := '050';
  ECentroOrigen.Text := gsDefCentro;
  EProducto.Text:= gsDefProducto;
  MEDesde.Text := DateToStr(Date - 7);
  MEHasta.Text := DateToStr(Date - 1);
end;

procedure TFLSalidasAlmacen.FormKeyDown(Sender: TObject; var Key: Word;
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
  end;
end;

procedure TFLSalidasAlmacen.ReiniciarTablas;
begin
  //BORRAMOS TEMPORAL
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    SQl.Add('Drop Table tmpSalidas');
    try
      ExecSQL;
    except
    end;
  end;
end;

procedure TFLSalidasAlmacen.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCentro:
      begin
        if ECentroOrigen.Focused then
          DespliegaRejilla(BGBCentroOrigen, [EEmpresa.Text])
        else
          DespliegaRejilla(BGBCentroSalida, [EEmpresa.Text]);
      end;
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLSalidasAlmacen.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
      begin
        STEmpresa.Caption := desEmpresa(Eempresa.Text);
        STCentroOrigen.Caption := desCentro(Eempresa.Text, ECentroOrigen.Text);
        if ECentroSalida.Text = '' then
          STCentroSalida.Caption := 'Vacio = Todos'
        else
          STCentroSalida.Caption := desCentro(Eempresa.Text, ECentroSalida.Text);
      end;
    kProducto: STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
    kCentro:
    begin
      STCentroOrigen.Caption := desCentro(Eempresa.Text, ECentroOrigen.Text);
      if ECentroSalida.Text = '' then
        STCentroSalida.Caption := 'Vacio = Todos'
      else
        STCentroSalida.Caption := desCentro(Eempresa.Text, ECentroSalida.Text);
    end;
  end;
end;

function TFLSalidasAlmacen.NumeroSemana(inicio, fin: string): string;
var a, b: integer;
begin
  //hallar el numero o numeros de semana para el periodo seleccionado.
  a := semana(StrToDate(inicio));
  b := semana(StrToDate(fin));
  if a <> b then
    result := 'Semanas: ' + IntToStr(a) + '-' + IntToStr(b)
  else
    result := 'Semana: ' + intToStr(a);
end;

function TFLSalidasAlmacen.sacarConserva: Real;
begin
  result := 0;
  with DMBaseDatos.QGeneral do
  begin
    Cancel;
    Close;
    Sql.Clear;
    Sql.Add(' SELECT SUM(kilos) kilos ' +
      ' FROM   tmpSalidas' +
      ' WHERE  categoria =  ' + QuotedStr('3B'));
    try
      Open;
      result := Fields[0].AsFloat;
    except
    end;
    Cancel;
    Close;
  end;
end;

function TFLSalidasAlmacen.sacarRetirada: Real;
begin
  result := 0;
  with DMBaseDatos.QGeneral do
  begin
    Cancel;
    Close;
    Sql.Clear;
    Sql.Add(' SELECT SUM(kilos) kilos ' +
      ' FROM   tmpSalidas' +
      ' WHERE  categoria =  ' + QuotedStr('2B'));
    try
      Open;
      result := Fields[0].AsFloat;
    except
    end;
    Cancel;
    Close;
  end;
end;

function TFLSalidasAlmacen.sacarTercera: Real;
begin
  result := 0;
  with DMBaseDatos.QGeneral do
  begin
    Cancel;
    Close;
    Sql.Clear;
    Sql.Add(' SELECT SUM(kilos) kilos ' +
      ' FROM   tmpSalidas' +
      ' WHERE  categoria =  ' + QuotedStr('3'));
    try
      Open;
      result := Fields[0].AsFloat;
    except
    end;
    Cancel;
    Close;
  end;
end;

function TFLSalidasAlmacen.RellenarTablaTemporal: Boolean;
var
  aux: integer;
begin
(*
   Todo lo que ha salido del alamcen hoy ->
   Todas las salidas de Almacen excepto las que provienen de un transito a
   Alemania o Gran Bretaña mas los transitos a Alemania o Grasn Bretaña
   NOTA: Las salidas que provienen de un transito a Alemania o Gran Bretaña
         se graban a posteriores con la fecha del transito, no las sacamos
         para no duplicar el producto
*)
  //CREAMOS TABLA TEMPORAL
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(' SELECT ' + SQLString('0') + '||pais_c pais, categoria_sl categoria, calibre_sl calibre, ' +
      '   cliente_sl cliente, SUM( kilos_sl ) kilos ' +

      ' FROM   frf_salidas_l, frf_clientes ' +

      ' WHERE  empresa_sl = :empresa ' +
      '   AND  centro_origen_sl = :centroOrigen ');
      if ECentroSalida.Text <> '' then
        SQL.Add('   AND  centro_salida_sl = :centroSalida ');
      SQL.Add('   AND  fecha_sl BETWEEN :inicio AND :fin ' +
      '   AND  producto_sl = :producto ' +

      '   AND  empresa_c = :empresa ' +
      '   AND  cliente_c = cliente_sl  ' +
      '   AND  cliente_c <> ' + QuotedStr('RET') + ' ' +

      //EXCEPTO LAS QUE VIENEN DE UN TRANSITO A ALEMANIA O INGLATERRA
      '    AND NOT EXISTS ' +
      '      (SELECT * FROM FRF_TRANSITOS_L ' +
      '       WHERE EMPRESA_TL = :empresa ' +
      '        AND CENTRO_ORIGEN_TL = CENTRO_ORIGEN_SL ' +
      '        AND REFERENCIA_TL = REF_TRANSITOS_SL ' +
      '        AND FECHA_TL <= :fin ' +
      '        AND CENTRO_DESTINO_TL IN ( select centro_c ' +
                                 ' from frf_centros ' +
                                 ' where empresa_c = :empresa ' +
                                 '   and ( pais_c = ''DE'' or pais_c = ''GB'' ) )' +
      '        AND PRODUCTO_TL = :producto) ' +

      '    AND NOT EXISTS ' +
      '     (SELECT * FROM FRF_SALIDAS_C ' +
      '      WHERE EMPRESA_SC = :empresa ' +
      '        AND CENTRO_SALIDA_SC = CENTRO_SALIDA_SL ' +
      '        AND N_ALBARAN_SC = N_ALBARAN_SL ' +
      '        AND FECHA_SC = FECHA_SL ' +
      '        AND not ( nvl(es_transito_sc,0) = 1 and (select pais_c from frf_clientes where empresa_sc = empresa_c and cliente_sal_sc = cliente_c) <> ''ES'' ) ) ' +

      ' GROUP BY 1,2,3,4 ' +
      ' INTO TEMP tmpSalidas');
     //Inicio de campaña
    ParamByName('inicio').asDateTime := fechaInicio;
    ParamByName('fin').AsDateTime := FechaFin;
    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('centroOrigen').AsString := ECentroOrigen.Text;
    if ECentroSalida.Text <> '' then
      ParamByName('centroSalida').AsString := ECentroSalida.Text;
    ParamByName('producto').AsString := EProducto.Text;
    ExecSQL;
    aux := RowsAffected;

     //MAS TRANSITOS A ALEMANIA
    SQL.Clear;
    SQL.Add(' INSERT INTO tmpSalidas ' +
      ' SELECT ' + SQLString('0DE') + ', categoria_tl , calibre_tl , ' +
      '        ' + SQLString('D') + ',  SUM(kilos_tl) ' +
      ' from frf_transitos_c, frf_transitos_l ' +
      ' WHERE empresa_tc = :empresa ' +
      ' And   centro_origen_tl = :centroOrigen  ');
      if ECentroSalida.Text <> '' then
        SQL.Add('   AND  centro_tl = :centroSalida ');
      SQL.Add('   and   fecha_tc between :inicio and :fin ' +
      //' and centro_destino_tc=' + QuotedStr('D') +
      ' and centro_destino_tc IN ( select centro_c ' +
                                 ' from frf_centros ' +
                                 ' where empresa_c = :empresa ' +
                                 '   and pais_c = ''DE'' )' +
      ' and empresa_tl = empresa_tc ' +
      ' and centro_tl = centro_tc ' +
      ' and referencia_tl = referencia_tc ' +
      ' and fecha_tl = fecha_tc ' +
      ' And producto_tl = :producto ' +
      ' group by 1,2,3,4 ');
    ParamByName('inicio').asDateTime := fechaInicio;
    ParamByName('fin').AsDateTime := FechaFin;
    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('centroOrigen').AsString := ECentroOrigen.Text;
    if ECentroSalida.Text <> '' then
      ParamByName('centroSalida').AsString := ECentroSalida.Text;
    ParamByName('producto').AsString := EProducto.Text;
    ExecSQL;
    aux := aux + RowsAffected;

     //MAS TRANSITOS A REINO UNIDO
    SQL.Clear;
    SQL.Add(' INSERT INTO tmpSalidas ' +
      ' SELECT ' + SQLString('0GB') + ', categoria_tl , calibre_tl , ' +
      '        ' + SQLString('U') + ',  SUM(kilos_tl) ' +
      ' from frf_transitos_c, frf_transitos_l ' +
      ' WHERE empresa_tc = :empresa ' +
      ' And   centro_origen_tl = :centroOrigen  ');
      if ECentroSalida.Text <> '' then
        SQL.Add('   AND  centro_tl = :centroSalida ');
      SQL.Add('   and   fecha_tc between :inicio and :fin ' +
      //' and centro_destino_tc IN (' + QuotedStr('U') + ', ' + QuotedStr('P') + ')' +
      ' and centro_destino_tc IN ( select centro_c ' +
                                 ' from frf_centros ' +
                                 ' where empresa_c = :empresa ' +
                                 '   and pais_c = ''GB'' )' +
      ' and empresa_tl = :empresa ' +
      ' and centro_tl = centro_tc ' +
      ' and referencia_tl = referencia_tc ' +
      ' and fecha_tl = fecha_tc ' +
      ' And producto_tl = :producto ' +
      ' group by 1,2,3,4 ');
    ParamByName('inicio').asDateTime := fechaInicio;
    ParamByName('fin').AsDateTime := FechaFin;
    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('centroOrigen').AsString := ECentroOrigen.Text;
    if ECentroSalida.Text <> '' then
      ParamByName('centroSalida').AsString := ECentroSalida.Text;
    ParamByName('producto').AsString := EProducto.Text;
    ExecSQL;
    aux := aux + RowsAffected;

    if DMConfig.EsUnAlmacen then
    begin
      SQL.Clear;
      //Sacamos transitos del perido de tiempo indicado
      SQL.Add(' INSERT INTO tmpSalidas ' +
        ' select ' + SQLString('1TR') + ' pais, categoria_tl categoria, calibre_tl calibre, ' +
        '        ' + SQLString('XXX') + ' cliente, SUM( kilos_tl ) kilos ' +
        ' from frf_transitos_l TL1' +

        ' where empresa_tl= :empresa ' +
        ' and  centro_origen_tl= :centroOrigen  ');
      if ECentroSalida.Text <> '' then
        SQL.Add('   AND  centro_tl = :centroSalida ');
      SQL.Add('   and  fecha_tl between :inicio and :fin ' +
        ' and  producto_tl= :producto ' +
        //EXCEPTO LOS QUE VIENEN DE TRANSITOS DE ALEMANIA - REINO UNIDO
        ' AND CENTRO_DESTINO_TL not IN ( select centro_c ' +
                                 ' from frf_centros ' +
                                 ' where empresa_c = :empresa ' +
                                 '   and ( pais_c = ''DE'' or pais_c = ''GB'' ) )' +
        ' group by 1,2,3,4 ');
      ParamByName('fin').asDateTime := fechaFin;
      ParamByName('inicio').asDateTime := fechaInicio;
      ParamByName('empresa').asString := EEmpresa.Text;
      ParamByName('producto').asString := EProducto.Text;
      ParamByName('centroOrigen').asString := ECentroOrigen.Text;
      if ECentroSalida.Text <> '' then
        ParamByName('centroSalida').AsString := ECentroSalida.Text;
      ExecSQL;
    end;
    result := (RowsAffected + aux) <> 0;
    if not result then
    begin
      MessageDlg('Consulta sin datos.', mtError, [mbOk], 0);
      ReiniciarTablas;
      Exit;
    end;
  end;
end;

end.
