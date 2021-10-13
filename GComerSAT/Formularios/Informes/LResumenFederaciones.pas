(*
  NOTA EXCLUIMOS EL PRODUCTO E
*)
unit LResumenFederaciones;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton,
  DBTables;

type
  TFLResumenFederaciones = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    QFederaciones: TQuery;
    QFederacionesdescripcion_p: TStringField;
    QFederacionespais_p: TStringField;
    QFederacioneskilos: TFloatField;
    QFederacionesbultos: TFloatField;
    LEmpresa: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    STProducto: TStaticText;
    stFederacion: TStaticText;
    BGBProducto: TBGridButton;
    EProducto: TBEdit;
    LProducto: TLabel;
    Label3: TLabel;
    EFederacion: TBEdit;
    Label1: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    cbxFechas: TCheckBox;
    rbNacional: TRadioButton;
    rbExportacion: TRadioButton;
    rbTodos: TRadioButton;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure EEmpresaChange(Sender: TObject);
    procedure EProductoChange(Sender: TObject);
    procedure EFederacionChange(Sender: TObject);
    procedure MEDesdeChange(Sender: TObject);
    procedure cbxFechasClick(Sender: TObject);

  private
    { Private declarations }
    function desProductoEx( const AEmpresa, AProducto: string ): string;
    function desFederacionEx( const AFederacion: string ): string;
  public
    { Public declarations }
    empresa, centro, producto: string;
    inicioCampana, fechaInicio: TDate;
    industriaPeriodo, industriaAcumulado: string;
    retiradaPeriodo, retiradaAcumulado: string;
  end;

implementation

uses UDMAuxDB, CVariables, Principal, UDMBaseDatos, CReportes,
  CAuxiliarDB, LFederaciones, DPreview, bTimeUtils, DateUtils;


{$R *.DFM}

procedure TFLResumenFederaciones.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLResumenFederaciones.BBAceptarClick(Sender: TObject);
var
  sema: string;
  dFechaIni, dFechaFin: TDateTime;
  fec: TDate;
begin
  if not CerrarForm(true) then Exit;

  if eProducto.Text = 'E' then
  begin
    MessageDlg('El producto ''E'' esta excluido de la gestion de federaciones.', mtError, [mbOk], 0);
    eProducto.SetFocus;
    Exit;
  end;

  //Comprobar parametros de entrada
  if STEmpresa.Caption = '' then
  begin
    MessageDlg('Falta o código de empresa incorrecto', mtError, [mbOk], 0);
    EEmpresa.SetFocus;
    Exit;
  end;

  if STProducto.Caption = '' then
  begin
    MessageDlg('Código de producto incorrecto.', mtError, [mbOk], 0);
    EProducto.SetFocus;
    Exit;
  end;

  if stFederacion.Caption = '' then
  begin
    MessageDlg('Falta o código de federación incorrecto', mtError, [mbOk], 0);
    EFederacion.SetFocus;
    Exit;
  end;

  if not TryStrToDate( MEDesde.Text, dFechaIni ) then
  begin
    MessageDlg('Fecha de inicio incorrecta ...', mtError, [mbOk], 0);
    MEDesde.SetFocus;
    Exit;
  end;
  if not cbxFechas.Checked then
  begin
    if DayOfTheWeek( dFechaIni ) <> 1 then
    begin
      MessageDlg('La fecha de inicio de ser lunes ...', mtError, [mbOk], 0);
      MEDesde.SetFocus;
      Exit;
    end;
  end
  else
  begin
    if not TryStrToDate( MEHasta.Text, dFechaFin ) then
    begin
      MessageDlg('Fecha de fin incorrecta ...', mtError, [mbOk], 0);
      MEHasta.SetFocus;
      Exit;
    end;
    if dFechaIni > dFechaFin then
    begin
      MessageDlg('Rango de fechas incorrecto ...', mtError, [mbOk], 0);
      MEDesde.SetFocus;
      Exit;
    end;
  end;

  //Crear query
  if QFederaciones.Active then QFederaciones.Close;

  QFederaciones.SQL.Clear;

  //                                                        +
  //SALIDAS
  //                                                        +
  QFederaciones.SQL.Add(' SELECT p.pais_p pais, p.descripcion_p nombre, ' );
  QFederaciones.SQL.Add('        sum(kilos_sl) As kilos, sum(cajas_sl) As bultos ' );
  QFederaciones.SQL.Add(' FROM  frf_salidas_c, frf_salidas_l, frf_clientes, frf_paises p ' );


  QFederaciones.SQL.Add(' Where empresa_sc = :empresa ' );
  QFederaciones.SQL.Add('   And fecha_sc between :inicio and :fin ');

  QFederaciones.SQL.Add('   and empresa_sl = :empresa ' );
  QFederaciones.SQL.Add('   And centro_salida_sl = centro_salida_sc ');
  QFederaciones.SQL.Add('   And fecha_sl = fecha_sc ');
  QFederaciones.SQL.Add('   And n_albaran_sl = n_albaran_sc ');

  if Trim(EFederacion.Text) <> '' then
  begin
    if Trim(EFederacion.Text) = '0' then
      QFederaciones.SQL.Add('   And ( nvl(federacion_sl,'''')='''' or federacion_sl = :federacion )')
    else
      QFederaciones.SQL.Add('   And federacion_sl = :federacion ');
  end;

  if Trim(eProducto.Text) <> '' then
    QFederaciones.SQL.Add('  And producto_sl = :producto ');

  // CLIENTES
  QFederaciones.SQL.Add('  And cliente_c = cliente_sl ' );

  if rbNacional.Checked then
    QFederaciones.SQL.Add('  And pais_c = ' + QuotedStr('ES') )
  else
  if rbExportacion.Checked then
    QFederaciones.SQL.Add('  And pais_c <> ' + QuotedStr('ES') );

  // PAISE
  QFederaciones.SQL.Add('  And pais_p = pais_c ' );

  //QUE SEAN UNA VENTA
  QFederaciones.SQL.Add('  and nvl(es_transito_sc,0) = 0 ');
  QFederaciones.SQL.Add('  and nvl(ref_transitos_sl, '''') = '''' ');

  //No se asignan el producto de tenerife ¿ESTO ES NECESARIO?
  QFederaciones.SQL.Add('  and centro_salida_sc <> ''6'' ');

  QFederaciones.SQL.Add(' GROUP BY 1,2');

  //                                                        +
  //MAS TRANSITOS  AL EXTRANJERO
  //                                                        +
  QFederaciones.SQL.Add(' UNION ');
  QFederaciones.SQL.Add(' select ');
  QFederaciones.SQL.Add(' (select pais_c ');
  QFederaciones.SQL.Add(' from frf_centros ');
  QFederaciones.SQL.Add(' where empresa_c = :empresa ');
  QFederaciones.SQL.Add(' and centro_c = centro_destino_tl) pais, ');
  QFederaciones.SQL.Add(' (select descripcion_p ');
  QFederaciones.SQL.Add(' from frf_centros, frf_paises ');
  QFederaciones.SQL.Add(' where empresa_c = :empresa ');
  QFederaciones.SQL.Add(' and centro_c = centro_destino_tl ');
  QFederaciones.SQL.Add(' and pais_c = pais_p ) nompais, ');
  QFederaciones.SQL.Add(' sum(kilos_tl), sum(cajas_tl) ');

  QFederaciones.SQL.Add(' from frf_transitos_l ');
  QFederaciones.SQL.Add(' where empresa_tl = :empresa ');
  QFederaciones.SQL.Add(' and   fecha_tl between :inicio and :fin ');
  if Trim(EFederacion.Text) <> '' then
  begin
    if Trim(EFederacion.Text) = '0' then
      QFederaciones.SQL.Add('   And ( nvl(federacion_tl,'''')='''' or federacion_tl = :federacion ) ')
    else
      QFederaciones.SQL.Add('   And federacion_tl = :federacion ');
  end;

  (*NOTA*)
  //No se asignan el producto de tenerife
  QFederaciones.SQL.Add(' And centro_tl <> ''6'' ');

  if Trim(EProducto.Text) <> '' then
    QFederaciones.SQL.Add(' and producto_tl = :producto ');

  //Que no provengan de un transito
  //QFederaciones.SQL.Add(' and centro_origen_tl <> ''6''  ');
  QFederaciones.SQL.Add(' and nvl(ref_origen_tl, '''') = '''' ');

  QFederaciones.SQL.Add(' and centro_destino_tl in ');
  QFederaciones.SQL.Add(' ( ');
  QFederaciones.SQL.Add(' select centro_c ');
  QFederaciones.SQL.Add(' from frf_centros ');
  QFederaciones.SQL.Add(' where empresa_c = :empresa ');

  if rbNacional.Checked then
    QFederaciones.SQL.Add('  And pais_c = ' + QuotedStr('ES') )
  else
  if rbExportacion.Checked then
    QFederaciones.SQL.Add('  And pais_c <> ' + QuotedStr('ES') );

  QFederaciones.SQL.Add(' ) ');
  QFederaciones.SQL.Add(' group by 1,2 ');

  QFederaciones.SQL.Add(' INTO TEMP tmp_federaciones ');


  QFederaciones.ParamByName('empresa').AsString := EEmpresa.Text;
  QFederaciones.ParamByName('inicio').AsDateTime := StrToDate(MEDesde.Text);
  QFederaciones.ParamByName('fin').AsDateTime := StrToDate(MEHasta.Text);
  if Trim(EFederacion.Text) <> '' then
  begin
    QFederaciones.ParamByName('federacion').AsString := EFederacion.Text;
  end;
  if Trim(eProducto.Text) <> '' then
  begin
    QFederaciones.ParamByName('producto').AsString := EProducto.Text;
  end;

  QFederaciones.ExecSQl;

  QFederaciones.SQL.Clear;
  QFederaciones.SQL.Add(' SELECT pais, nombre, sum(kilos) As kilos, ' +
    '        sum(bultos) As bultos ' +
    ' FROM  tmp_federaciones ' +
    ' GROUP BY 1,2 ORDER BY 1,2 ');


//##############################################################################

  with QFederaciones do
  begin
    try
      Open;
      First;
    except
      on E: Exception do
      begin
        MessageDlg('Error al abrir la consulta del Listado...', mtError, [mbOk], 0);
        Exit;
      end;
    end;
  end;
//··································::::::::::::::::::::························
       //Generamos informe
  fec := StrToDateTime(MEDesde.text);
  sema := IntToStr(Semana(fec));
  if Length(sema) = 1 then
    sema := '0' + sema
  else sema := sema;
    sema := ' ( Semana nº. ' + sema + ' )';

  try
           //ViSUALIZAMOS INFORME
    QRLFederaciones := TQRLFederaciones.Create(Application);

    if cbxFechas.Checked then
    begin
      if MEDesde.Text =  MEHasta.Text then
        QRLFederaciones.fecha := 'durante el dia ' + MEDesde.Text + sema
      else
        QRLFederaciones.fecha := 'durante el periodo del ' + MEDesde.Text + ' al ' + MEHasta.Text;
    end
    else
    begin
      QRLFederaciones.fecha := 'durante la semana del ' + MEDesde.Text + ' al ' + MEHasta.Text + sema;
    end;

    DMBaseDatos.QGeneral.Close;
    if EFederacion.Text <> '9' then
    begin
      //PonLogoGrupoBonnysa(QRLFederaciones, EEmpresa.Text);
      if EFederacion.Text <> '' then
      begin
        QRLFederaciones.provincia := 'S.A.T.  Nº 9359 BONNYSA declara que en la provincia de ' + stFederacion.Caption + ' ';
      end
      else
      begin
        QRLFederaciones.provincia := 'S.A.T.  Nº 9359 BONNYSA declara que en TODAS las provincias ';
      end;
    end
    else
    begin
      QRLFederaciones.lblTitulo.Enabled:= False;
      PonLogoFederacionesAgroalicante(QRLFederaciones);
      QRLFederaciones.provincia := 'AGROALICANTE C.I.F. ES-F53103230 declara que en la provincia de ALICANTE';
    end;

    Preview(QRLFederaciones);
  finally
    QFederaciones.Close;
    QFederaciones.SQL.Clear;
    QFederaciones.SQL.Add(' DROP TABLE tmp_federaciones');
    try
      QFederaciones.ExecSQl;
    except
    end;
  end;
end;

procedure TFLResumenFederaciones.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;


procedure TFLResumenFederaciones.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFLResumenFederaciones.FormCreate(Sender: TObject);
var
  dFecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  MEDesde.Text := DateToStr(Date);
  MEHasta.Text := DateToStr(Date);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

  EEmpresa.Text := '050';
  EProducto.Text:= '';
  EFederacion.Text:= '0';

  dFecha:= LunesAnterior( Date ) - 7;
  MEDesde.Text:= DateToStr( dFEcha );
  MEHasta.Text:= DateToStr( dFEcha + 6 );
end;

procedure TFLResumenFederaciones.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLResumenFederaciones.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

function TFLResumenFederaciones.desProductoEx( const AEmpresa, AProducto: string ): string;
begin
  result:= desProducto( AEmpresa, AProducto );
  if result = '' then
  begin
    if AProducto = '' then
    begin
      result:= 'Vacio = Todos los productos.';
    end;
  end;
end;

function TFLResumenFederaciones.desFederacionEx( const AFederacion: string ): string;
begin
  result:= desFederacion( AFederacion );
  if result = '' then
  begin
    if AFederacion = '' then
    begin
      result:= 'Vacio = Todas las federaciones.';
    end;
  end;
end;

procedure TFLResumenFederaciones.EEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  STProducto.Caption := desProductoEx(Eempresa.Text, Eproducto.Text);
end;

procedure TFLResumenFederaciones.EProductoChange(Sender: TObject);
begin
  STProducto.Caption := desProductoEx(Eempresa.Text, Eproducto.Text);
end;

procedure TFLResumenFederaciones.EFederacionChange(Sender: TObject);
begin
  stFederacion.Caption := desFederacionEx( EFederacion.Text);
end;

procedure TFLResumenFederaciones.MEDesdeChange(Sender: TObject);
var
  dFecha: TDAteTime;
begin
  if not cbxFechas.Checked then
  begin
    if TryStrToDate( MEDesde.Text, dFecha ) then
    begin
      MEHasta.Text:= DateToStr( dFecha + 6 );
    end;
  end;
end;

procedure TFLResumenFederaciones.cbxFechasClick(Sender: TObject);
begin
  MEHasta.Enabled:= not MEHasta.Enabled;
  BCBHasta.Enabled:= MEHasta.Enabled;
  MEDesdeChange( MEDesde );
end;

end.
