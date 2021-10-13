//ATENCION:Aqui que usar la tabla "aux_resumen" para el
//         acumulado de la campaña 1/7/2000-1/7/2001
unit LSalidasResumenForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids, dbtables,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton;

type
  TFLSalidasResumen = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    BGBCentro: TBGridButton;
    LCentro: TLabel;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LProducto: TLabel;
    BGBProducto: TBGridButton;
    STCentro: TStaticText;
    STProducto: TStaticText;
    STEmpresa: TStaticText;
    EEmpresa: TBEdit;
    ECentro: TBEdit;
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
    lblInicioCampana: TLabel;
    edtInicioCampana: TBEdit;
    btnInicioCampana: TBCalendarButton;
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
    procedure sacarTransito;
    procedure sacarRetirada;
    procedure sacarConserva;
    procedure sacarTercera;

    procedure ReiniciarTablas;

  public
    { Public declarations }
    empresa, centro, producto: string;
    fechaInicio, fechaFin, inicioCampana: TDate;
    fechaIniTrans: TDate; //fechaFinTrans:TDate;

    hayTransito: Boolean;
    transitoTotal: Real;
    retiradaPer, retiradaAcum: Real;
    conservaPer, conservaAcum: Real;
    terceraPer, terceraAcum: Real;

     //procedure Borrar;override;
  end;

var
  FLSalidasResumen: TFLSalidasResumen;

implementation

uses CVariables, UDMAuxDB, LSalidasResumen2, UDMBaseDatos, CReportes,
  CAuxiliarDB, DError, Principal, DPreview, bTimeUtils, bSQLUtils;

{$R *.DFM}


procedure TFLSalidasResumen.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFLSalidasResumen.DatosValidos: Boolean;
begin
  DatosValidos := false;

  //Comprobar si los campos se han rellenado correctamente
  if EEmpresa.Text = '' then
  begin
    MessageDlg('Debe introducir algun dato en el campo "Empresa"',
      mtError, [mbOk], 0);
    EEmpresa.SetFocus;
    Exit;
  end;

  if EProducto.Text = '' then
  begin
    MessageDlg('Debe introducir algún dato en el campo "Producto"',
      mtError, [mbOk], 0);
    EProducto.SetFocus;
    Exit;
  end;

  if ECentro.Text = '' then
  begin
    MessageDlg('Debe introducir algún dato en el campo "Centro"',
      mtError, [mbOk], 0);
    ECentro.SetFocus;
    Exit;
  end;

  //Fecha hasta mayor fecha desde
  if StrToDate(MEdesde.Text) > StrToDate(MEhasta.Text) then
  begin
    MessageDlg('La fecha "Hasta" debe ser mayor o igual que la del campo "Desde".',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
    Exit;
  end;

  //Fecha hasta mayor fecha desde
  if StrToDate(edtInicioCampana.Text) > StrToDate(MEDesde.Text) then
  begin
    MessageDlg('La fecha "Desde" debe ser mayor o igual que la del campo "Inicio Ejercicio".',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
    Exit;
  end;


  DatosValidos := true;
end;

procedure TFLSalidasResumen.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if not DatosValidos then eXit;

  //.......................NOMBRE CENTRO Y PRODUCTO.................
  empresa := STEmpresa.Caption;
  centro := STCentro.Caption;
  producto := STProducto.Caption;

  //Rango de fechas
  fechaInicio := StrToDate(MEDesde.text);
  FechaFin := StrToDate(MEHasta.text);
  inicioCampana := StrToDate(edtInicioCampana.text);

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

  {if hayTransito then}sacarTransito;

  sacarRetirada;
  sacarConserva;
  sacarTercera;

  //ViSUALIZAMOS INFORME
  QRLSalidasResumen2 := TQRLSalidasResumen2.Create(Application);
  try
     //Retirada
    QRLSalidasResumen2.lAcuRetirada.caption := FormatFloat('#,##0', retiradaAcum);
    QRLSalidasResumen2.lPerRetirada.caption := FormatFloat('#,##0', retiradaPer);

     //Conserva
    QRLSalidasResumen2.LPerConserva.Caption := FormatFloat('#,##0', conservaPer);
    QRLSalidasResumen2.LAcuConserva.Caption := FormatFloat('#,##0', conservaAcum);

     //Transito
    QRLSalidasResumen2.PTT.Caption := FormatFloat('#,##0', transitoTotal);
    QRLSalidasResumen2.PTT2.Caption := QRLSalidasResumen2.PTT.Caption;

     //Tercera
    QRLSalidasResumen2.LPerTercera.Caption := FormatFloat('#,##0', terceraPer);
    QRLSalidasResumen2.LAcuTercera.Caption := FormatFloat('#,##0', terceraAcum);

     //Datos estaticos
    QRLSalidasResumen2.empresa := EEmpresa.Text;
    QRLSalidasResumen2.producto := EProducto.Text;
    QRLSalidasResumen2.lblCentro.Caption := centro;
    QRLSalidasResumen2.lblProducto.Caption := producto;
    QRLSalidasResumen2.lblPeriodo.Caption := 'Periodo : ' + DateTostr(fechaInicio) + ' al ' + MEHasta.Text;
    QRLSalidasResumen2.lblNumSemana.Caption := NumeroSemana(DateToStr(fechainicio), MEHasta.Text);

     //Mostrar listado
    PonLogoGrupoBonnysa(QRLSalidasResumen2, EEmpresa.Text);
    Preview(QRLSalidasResumen2);
  except
    QRLSalidasResumen2.Free;
    ReiniciarTablas;
  end;
  ReiniciarTablas;
end;

procedure TFLSalidasResumen.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;


procedure TFLSalidasResumen.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFLSalidasResumen.FormCreate(Sender: TObject);
var
  iDia, iMes, iAno: word;
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  edtInicioCampana.Tag := kCalendar;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;
  CalendarioFlotante.Date := Date;

  EEmpresa.Text := gsDefEmpresa;
  ECentro.Text := gsDefCentro;
  EProducto.Text:= gsDefProducto;
  MEDesde.Text := DateToStr(Date - 7);
  MEHasta.Text := DateToStr(Date - 1);
  DecodeDate( Date - 7, iAno, iMes, iDia );
  if iMes < 7 then
  begin
    Inc( iAno, -1);
  end;
  edtInicioCampana.Text := DateToStr(EncodeDate( iAno,7,1));
end;

procedure TFLSalidasResumen.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLSalidasResumen.ReiniciarTablas;
begin
  //BORRAMOS TEMPORAL
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    SQl.Add('Drop Table tablaTemporal');
    try
      ExecSQL;
    except
    end;
    SQL.Clear;
    SQl.Add('Drop Table tmpRefTransitos');
    try
      ExecSQL;
    except
    end;
  end;
end;

procedure TFLSalidasResumen.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCentro: DespliegaRejilla(BGBCentro, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
        if MEHasta.Focused then
          DespliegaCalendario(BCBHasta)
        else
          DespliegaCalendario(btnInicioCampana);
      end;
  end;
end;

procedure TFLSalidasResumen.PonNombre(Sender: TObject);
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
        STCentro.Caption := desCentro(Eempresa.Text, Ecentro.Text);
        STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
      end;
    kProducto: STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
    kCentro: STCentro.Caption := desCentro(Eempresa.Text, Ecentro.Text);
  end;
end;

procedure TFLSalidasResumen.SacarTransito;
begin
  transitoTotal := -1;
  with DMBaseDatos.QGeneral do
  begin

    SQL.Clear;

    //Kilos vendidos

    SQL.Add('  select SUM(kilos) ' +
      ' from tablaTemporal ' +
      ' where tipo= ' + SQLString('P') + ' ' +
      ' and  referencia is not null  ');
    try
      Open;
    except
      Exit;
    end;
    transitoTotal := fields[0].asfloat;
    Close;
    SQL.Clear;


    //Kilos quedan
    SQL.Add('  select SUM(kilos) ' +
      ' from tmpRefTransitos ' +
      ' where fecha >=:inicio ');
    ParamByName('inicio').asDateTime := fechaInicio;
    try
      Open;
    except
      transitoTotal := -1;
      Exit;
    end;
    transitoTotal := fields[0].asfloat - transitoTotal;
    Close;
    SQL.Clear;
  end;
end;


function TFLSalidasResumen.NumeroSemana(inicio, fin: string): string;
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

//Retirada

procedure TFLSalidasResumen.sacarRetirada;
begin
  retiradaPer := 0;
  retiradaAcum := 0;
  //Sacamos los datos de la industria como de la retirada
  with DMBaseDatos.QGeneral do
  begin
    Cancel;
    Close;
    Sql.Clear;
    Sql.Add(' SELECT  SUM(kilos ) kilos ' +
      ' FROM  tablaTemporal ' +
      ' WHERE categoria = ' + quotedstr('2B')); //Acumulado
    try
      Open;
      retiradaAcum := Fields[0].AsFloat;
    except
      Exit;
    end;

    Cancel;
    Close;
    Sql.Clear;
    Sql.Add(' SELECT  SUM(kilos ) kilos ' +
      ' FROM  tablaTemporal ' +
      ' WHERE categoria = ' + quotedstr('2B') +
      '   AND tipo = ' + quotedstr('P') + //Periodo
      '   AND  ((referencia IS NULL) OR (referencia IN (SELECT transito FROM tmpRefTransitos )))');
    try
      Open;
      retiradaPer := Fields[0].asfloat;
    except
      Exit;
    end;
  end;
end;


//Conserva

procedure TFLSalidasResumen.sacarConserva;
begin
  with DMBaseDatos.QGeneral do
  begin
    Cancel;
    Close;
    Sql.Clear;
    Sql.Add(' SELECT  SUM(kilos ) kilos ' +
      ' FROM  tablaTemporal ' +
      ' WHERE categoria = ' + quotedstr('3B')); //Acumulado
    try
      Open;
      conservaAcum := Fields[0].AsFloat;
    except
      Exit;
    end;

    Cancel;
    Close;
    Sql.Clear;
    Sql.Add(' SELECT  SUM(kilos ) kilos ' +
      ' FROM  tablaTemporal ' +
      ' WHERE categoria = ' + quotedstr('3B') +
      '   AND tipo = ' + quotedstr('P') + //Periodo
      '   AND  ((referencia IS NULL) OR (referencia IN (SELECT transito FROM tmpRefTransitos )))');
    try
      Open;
      conservaPer := Fields[0].asfloat;
    except
      Exit;
    end;
  end;
end;

//Conserva

procedure TFLSalidasResumen.sacarTercera;
begin
  with DMBaseDatos.QGeneral do
  begin
    Cancel;
    Close;
    Sql.Clear;
    Sql.Add(' SELECT  SUM(kilos ) kilos ' +
      ' FROM  tablaTemporal ' +
      ' WHERE categoria = ' + quotedstr('3')); //Acumulado
    try
      Open;
      terceraAcum := Fields[0].AsFloat;
    except
      Exit;
    end;

    Cancel;
    Close;
    Sql.Clear;
    Sql.Add(' SELECT  SUM(kilos ) kilos ' +
      ' FROM  tablaTemporal ' +
      ' WHERE categoria = ' + quotedstr('3') +
      '   AND tipo = ' + quotedstr('P') + //Periodo
      '   AND  ((referencia IS NULL) OR (referencia IN (SELECT transito FROM tmpRefTransitos )))');
    try
      Open;
      terceraPer := Fields[0].asfloat;
    except
      Exit;
    end;
  end;
end;

function TFLSalidasResumen.RellenarTablaTemporal: Boolean;
begin
  //CREAMOS TABLA TEMPORAL
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(' SELECT ' + SQLString('A') + ' tipo, centro_origen_sl, ' +
      '       fecha_sl fecha, categoria_sl categoria, ' +
      '       calibre_sl calibre, medida_c medida, ref_transitos_sl referencia, ' +
      '       color_sl color, cliente_sl cliente, cli.pais_c pais, ' +
      '       agrupacion_e agrupacion, sum(kilos_sl) kilos ' +
      ' FROM   frf_salidas_c, frf_salidas_l, frf_clientes cli, frf_envases, frf_calibres cal' +
      ' WHERE  empresa_sl ' + SQLEqualS(EEmpresa.Text) +
      '  AND  centro_origen_sl ' + SQLEqualS(ECentro.Text) +
      '  AND  fecha_sl ' + SQLRangeD(DateToStr(inicioCampana), DateToStr(FechaFin)) +
      '  AND  producto_sl ' + SQLEqualS(EProducto.Text) +

      '  AND  cli.cliente_c = cliente_sl ' +

      '  AND  cal.empresa_c ' + SQLEqualS(EEmpresa.Text) +
      '  AND  cal.producto_c = producto_sl ' +
      '  AND  cal.calibre_c = calibre_sl ' +

      '  AND  envase_e = envase_sl ' +

      '  AND empresa_sc = empresa_sl ' +
      '  AND centro_salida_sc = centro_salida_sl ' +
      '  AND n_albaran_sc = n_albaran_sl ' +
      '  AND fecha_sc = fecha_sl ' +

      '  AND NOT EXISTS ' +
      '      (SELECT * FROM frf_transitos_l ' +
      '       WHERE empresa_tl ' + SQLEqualS(EEmpresa.Text) +
      '        AND centro_origen_tl ' + SQLEqualS(ECentro.Text) +
      '        AND referencia_tl = ref_transitos_sl ' +
      '        AND fecha_tl ' + SQLRangeD(DateToStr(fechaInicio-30),DateToStr(FechaFin)) +
      '        AND producto_tl ' + SQLEqualS(EProducto.Text) +
             //NO QUIERO LAS SALIDAS QUE VENGAN DE UN TRANSITO A ALEMANIA O REINO UNIDO
      '        AND EXISTS ' +
      '            ( ' +
      '              select * ' +
      '              from frf_centros ' +
      '              where empresa_c ' + SQLEqualS(EEmpresa.Text) +
      '              and centro_c = centro_destino_tl ' +
      '              and pais_c = ''ES'' ' +
      '            )) ' +

      '    AND NOT EXISTS ' +
      '     (SELECT * FROM FRF_SALIDAS_C ' +
      '      WHERE EMPRESA_SC ' + SQLEqualS(EEmpresa.Text) +
      '        AND CENTRO_SALIDA_SC = CENTRO_SALIDA_SL ' +
      '        AND N_ALBARAN_SC = N_ALBARAN_SL ' +
      '        AND FECHA_SC = FECHA_SL ' +
      '        AND ES_TRANSITO_SC = 1 ' +
      '        AND ''ES'' <> ( select pais_c from frf_clientes where cliente_c = cliente_sal_sc ) ) ' +

      '  and es_transito_sc <> 2 ' +       // Tipo Salida: Devolucion

      ' GROUP BY centro_origen_sl, fecha_sl, categoria_sl, calibre_sl, medida_c,' +
      '          ref_transitos_sl, color_sl, cliente_sl, pais_c, ' +
      '          agrupacion_e ' +
      ' INTO TEMP tablaTemporal');
    ExecSQL;
    result := RowsAffected <> 0;

    if not result then
    begin
      MessageDlg('Consulta sin datos.', mtError, [mbOk], 0);
      ReiniciarTablas;
      Exit;
    end;

    SQL.Clear;
    SQL.Add(' -- TODOS LOS TRANSITOS A ALEMANIA ');
    SQL.Add(' INSERT INTO tablaTemporal ' +
      ' SELECT ' + SQLString('A') + ' tipo, centro_origen_tl, fecha_tl fecha, ' +
      '       categoria_tl categoria, calibre_tl calibre, medida_c medida, ' +
      '       ref_origen_tl referencia, color_tl color, ' +
      '       ' + SQLString('D') + ' cliente, ' + SQLString('DE') + ' pais, ' +
      '       agrupacion_e agrupacion, ' +
      '       SUM( kilos_tl ) kilos ' +
      ' FROM   frf_transitos_l, frf_envases, frf_calibres cal ' +
      ' WHERE  empresa_tl ' + SQLEqualS(EEmpresa.Text) +
      '  AND  centro_origen_tl ' + SQLEqualS(ECentro.Text) +
      '  AND  fecha_tl ' + SQLRangeD(DateToStr(inicioCampana), DateToStr(FechaFin)) +
      '  AND  producto_tl ' + SQLEqualS(EProducto.Text) +

      '  AND  cal.empresa_c ' + SQLEqualS(EEmpresa.Text) +
      '  AND  cal.producto_c = producto_tl ' +
      '  AND  cal.calibre_c = calibre_tl ' +

      '        AND EXISTS ' +
      '            ( ' +
      '              select * ' +
      '              from frf_centros ' +
      '              where empresa_c ' + SQLEqualS(EEmpresa.Text) +
      '              and centro_c = centro_destino_tl ' +
      '              and pais_c = ''DE'' ' +
      '            ) ' +


      '  AND  envase_e = envase_tl ' +

      ' GROUP BY centro_origen_tl, fecha_tl, categoria_tl, calibre_tl, medida_c, ' +
      '          ref_origen_tl, color_tl, agrupacion_e ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' -- TODOS LOS TRANSITOS A REINO UNIDO ');
    SQL.Add(' INSERT INTO tablaTemporal ' +
      ' SELECT ' + SQLString('A') + ' tipo, centro_origen_tl, fecha_tl fecha, ' +
      '       categoria_tl categoria, calibre_tl calibre, medida_c medida, ' +
      '       ref_origen_tl referencia, color_tl color, ' +
      '       ' + SQLString('U') + ' cliente, ' + SQLString('GB') + ' pais, ' +
      '       agrupacion_e agrupacion, ' +
      '       SUM( kilos_tl ) kilos ' +
      ' FROM   frf_transitos_l, frf_envases, frf_calibres cal ' +
      ' WHERE  empresa_tl ' + SQLEqualS(EEmpresa.Text) +
      '  AND  centro_origen_tl ' + SQLEqualS(ECentro.Text) +
      '  AND  fecha_tl ' + SQLRangeD(DateToStr(inicioCampana), DateToStr(FechaFin)) +
      '  AND  producto_tl ' + SQLEqualS(EProducto.Text) +

      '  AND  cal.empresa_c ' + SQLEqualS(EEmpresa.Text) +
      '  AND  cal.producto_c = producto_tl ' +
      '  AND  cal.calibre_c = calibre_tl ' +

      '        AND EXISTS ' +
      '            ( ' +
      '              select * ' +
      '              from frf_centros ' +
      '              where empresa_c ' + SQLEqualS(EEmpresa.Text) +
      '              and centro_c = centro_destino_tl ' +
      '              and pais_c = ''GB'' ' +
      '            ) ' +

      '  AND  envase_e = envase_tl '+ 

      ' GROUP BY centro_origen_tl, fecha_tl, categoria_tl, calibre_tl, medida_c, ' +
      '          ref_origen_tl, color_tl, agrupacion_e ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' -- TRANSITOS DEL PERIODO EXCEPTO LOS DE ALEMANIA / REINO UNIDO');
    SQL.Add(' select referencia_tl transito, fecha_tl fecha,  ' +
      '       categoria_tl categoria, SUM(kilos_tl) kilos ' +
      ' from  frf_transitos_l ' +
      ' where empresa_tl ' + SQLEqualS(EEmpresa.Text) +
      '  and  centro_origen_tl ' + SQLEqualS(ECentro.Text) +
      '  and  fecha_tl ' + SQLRangeD(DateToStr(fechaInicio), DateToStr(FechaFin)) +
      '  and  producto_tl ' + SQLEqualS(EProducto.Text) +
      '        AND EXISTS ' +
      '            ( ' +
      '              select * ' +
      '              from frf_centros ' +
      '              where empresa_c ' + SQLEqualS(EEmpresa.Text) +
      '              and centro_c = centro_destino_tl ' +
      '              and pais_c = ''ES'' ' +
      '            ) ' +
      ' GROUP BY referencia_tl, fecha_tl, categoria_tl ' +
      ' into temp tmpRefTransitos ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' -- PERIODO ');
    SQL.Add(' UPDATE tablaTemporal ' +
      ' SET tipo = ' + SQLString('P') + ' ' +
      ' WHERE EXISTS ' +
      '            (SELECT referencia ' +
      '             FROM tmpRefTransitos ' +
      '             WHERE referencia = transito ) ' +
      '  AND referencia IS NOT NULL ' +
      '  AND fecha ' + SQLEqualD(DateToStr(FechaInicio), '>='));


    ExecSQL;

    SQL.Clear;
    SQL.Add(' -- PERIODO ');
    SQL.Add(' UPDATE tablaTemporal ' +
      ' SET tipo = ' + SQLString('P') + ' ' +
      ' WHERE referencia IS NULL ' +
      '  AND fecha ' + SQLEqualD(DateToStr(FechaInicio), '>='));
    ExecSQL;
  end;
end;

end.
