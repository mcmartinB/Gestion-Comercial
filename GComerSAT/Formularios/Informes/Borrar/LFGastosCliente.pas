unit LFGastosCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt, BDEdit, QRCtrls;

type
  TFLGastosCliente = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LCliente: TLabel;
    BGBCliente: TBGridButton;
    STCliente: TStaticText;
    STEmpresa: TStaticText;
    ADesplegarRejilla: TAction;
    EEmpresa: TBEdit;
    ECliente: TBEdit;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    GBDatos: TGroupBox;
    lblTipo: TLabel;
    Label1: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    lbl1: TLabel;
    edtPais: TBEdit;
    btnPais: TBGridButton;
    stPais: TStaticText;
    lblProvincia: TLabel;
    edtProvincia: TBEdit;
    btnProvincia: TBGridButton;
    stProvincia: TStaticText;
    edtTipo: TBEdit;
    btnTipo: TBGridButton;
    StTipo: TStaticText;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonEmpresa(Sender: TObject);
    procedure EClienteChange(Sender: TObject);
    procedure edtPaisChange(Sender: TObject);
    procedure edtProvinciaChange(Sender: TObject);
    procedure edtTipoChange(Sender: TObject);
  private
    {private declarations}
    function CamposVacios: boolean;
    function Imprimir: boolean;
    function ExistenDatos: boolean;
    function Consulta: boolean;
    function ConsultaGuia: boolean;
    function Recorrer: boolean;
    function Temporal: boolean;
    function ConsultaListado: boolean;

    function AplicarCambio: boolean;

  public
    { Public declarations }
    QListado, QGuia: TQuery;
    DSUnion: TDataSource;
  end;


implementation


uses CVariables, UDMAuxDB, Principal, CAuxiliarDB, DPreview, UDMBaseDatos,
  LGastosCliente, bSQLUtils, CReportes, UDMCambioMoneda;

{$R *.DFM}

procedure TFLGastosCliente.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  ECliente.Tag := kCliente;
  edtpais.Tag := kPais;
  edtProvincia.Tag := kProvincia;
  edtTipo.Tag := kTipoGastos;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;


  ECliente.Text := '';
  EEmpresa.Text := gsDefEmpresa;
  edtPais.Text:= '';
  edtPaisChange( edtPais );
  edtProvincia.Text:= '';
  edtProvinciaChange( edtProvincia );
  edtTipo.Text := '';
  edtTipoChange( edtTipo );
  MEDesde.Text := DateToStr(Date-7);
  MEHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;


  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  Temporal;
end;

procedure TFLGastosCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BorrarTemporal('tmp_gastos_cli');

  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFLGastosCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
  end;
end;

procedure TFLGastosCliente.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

procedure TFLGastosCliente.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLGastosCliente.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if CamposVacios then Exit;

  ConsultaExec('DELETE FROM tmp_gastos_cli', false, false);

  //Comprueba con cuantas monedas ha trabajado el cliente.Salimos si falla
  if not ExistenDatos then Exit;

  if not ConsultaGuia then Exit;

  if not Consulta then exit;
  if not Recorrer then Exit;
  if not AplicarCambio then Exit;

  if not ConsultaListado then exit;

  if not Imprimir then
  begin
    Exit;
  end;
end;

procedure TFLGastosCliente.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente: DespliegaRejilla(BGBCliente, [EEmpresa.Text]);
    kPais: DespliegaRejilla(btnPais, []);
    kProvincia: DespliegaRejilla(btnProvincia, []);
    kTipoGastos: DespliegaRejilla(btnTipo, []);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLGastosCliente.PonEmpresa(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  EClienteChange( ECliente );
end;

function TFLGastosCliente.CamposVacios: boolean;
var
  dIni, dFin: TDateTime;
begin
  result := True;
  if STEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
  end
  else
  if STCliente.Caption = '' then
  begin
    ShowMessage('Código de cliente incorrecto.');
  end
  else
  if stPais.Caption = '' then
  begin
    ShowMessage('Código de pais incorrecto.');
  end
  else
  if stProvincia.Caption = '' then
  begin
    ShowMessage('Código de provincia incorrecto.');
  end
  else
  if StTipo.Caption = '' then
  begin
    ShowMessage('Código de tipo gasto incorrecto.');
  end
  else
  if not TryStrToDate( MEDesde.Text, dIni ) then
  begin
    ShowMessage('Fecha de incio incorrecta.');
  end
  else
  if not TryStrToDate( MEHasta.Text, dFin ) then
  begin
    ShowMessage('Fecha de fin incorrecta.');
  end
  else
  if dIni > dFin then
  begin
    ShowMessage('rango de fechas incorrecto.');
  end
  else
  begin
    Result:= False;
  end;
end;

function TFLGastosCliente.Imprimir: boolean;
var i: integer;
begin

  try
    QRLGastosCliente := TQRLGastosCliente.Create(Application);
  except
    QRLGastosCliente := nil;
    result := False;
    Exit;
  end;
  QRLGastosCliente.DataSet := QGuia;


  QRLGastosCliente.lblCliente.Caption := ECliente.Text + ' ' + STCliente.caption;
  QRLGastosCliente.bCliente:= ECliente.Text <> '';
  if ( edtPais.Text <> '' ) or ( edtProvincia.Text <> '' ) then
  begin
    if ( edtPais.Text <> '' ) And ( edtProvincia.Text <> '' ) then
    begin
      QRLGastosCliente.qrlblPais.Caption := stPais.caption + ' - ' + stProvincia.caption;
    end
    else
    if ( edtProvincia.Text <> '' ) then
    begin
      QRLGastosCliente.qrlblPais.Caption := stProvincia.caption;
    end
    else
    if ( edtPais.Text <> '' ) then
    begin
      QRLGastosCliente.qrlblPais.Caption := stPais.caption;
    end;
  end
  else
  begin
    QRLGastosCliente.qrlblPais.Caption := '';
  end;

  QRLGastosCliente.lblMoneda.Caption := 'EUROS';

  for i := 0 to QRLGastosCliente.QRGrupo.ControlCount - 1 do
  begin
    if QRLGastosCliente.QRGrupo.Controls[i] is TQRDBText then
      TQRDBText(QRLGastosCliente.QRGrupo.Controls[i]).DataSet := QGuia;
  end;

  QRLGastosCliente.QRSub.DataSet := QListado;
  for i := 0 to QRLGastosCliente.QRSub.ControlCount - 1 do
  begin
    if QRLGastosCliente.QRSub.Controls[i] is TQRDBText then
      TQRDBText(QRLGastosCliente.QRSub.Controls[i]).DataSet := QListado;
  end;
  PonLogoGrupoBonnysa(QRLGastosCliente, EEmpresa.text);
  try
    Preview(QRLGastosCliente);
  except
    result := false;
    exit;
  end;
  Result := True;
end;

//Comprueba si en el periodo seleccionado el cliente ha trabajado con 2 monedas

function TFLGastosCliente.ExistenDatos: boolean;
begin
  result:= False;
  with TQuery.Create(nil) do
  begin
    DataBaseName := DMBaseDatos.DBBaseDatos.DatabaseName;

       //Comprobar que existan gastos
    SQl.Add(' SELECT count(*) ' +
      ' FROM frf_salidas_c, frf_gastos ' +
      ' WHERE empresa_sc = ' + QuotedStr(EEmpresa.Text) );
    if ECliente.Text <> '' then
      SQl.Add(' AND   cliente_sal_sc = ' + QuotedStr(ECliente.Text) );
    SQl.Add(' AND   fecha_sc BETWEEN ' + QuotedStr(MEDesde.Text) + ' AND ' + QuotedStr(MEHasta.Text) );
    SQl.Add(' AND   empresa_sc = empresa_g ' +
      ' AND   centro_salida_sc = centro_salida_g ' +
      ' AND   n_albaran_sc = n_albaran_g ' +
      ' AND   fecha_sc = fecha_g ');
    if edtTipo.Text <> '' then
      SQl.Add(' AND   tipo_g = ' + QuotedStr(edtTipo.Text) );

    if edtPais.Text <> '' then
    begin
      SQl.Add(' and exists ( select * from frf_clientes ');
      SQl.Add('               where empresa_c = ' + QuotedStr(EEmpresa.Text) );
      SQl.Add('               and cliente_c = cliente_sal_sc ' );
      SQl.Add('               and pais_c = ' + QuotedStr(edtPais.Text)  + ' ) ');
    end;
    if edtProvincia.Text <> '' then
    begin
      SQl.Add(' and exists ( select * from frf_clientes ');
      SQl.Add('               where empresa_c = ' + QuotedStr(EEmpresa.Text) );
      SQl.Add('               and cliente_c = cliente_sal_sc ' );
      SQl.Add('               and cod_postal_c[1,2] = ' + QuotedStr(edtProvincia.Text) + ' ) ');
    end;

    try
      Open;
    except
      ShowError('Error comprobando existencia de gastos para el periodo indicado ..');
      Close;
      Free;
      Exit;
    end;

    if Fields[0].AsInteger = 0 then
    begin
      ShowError('Sin gastos para el periodo indicado ...');
      Close;
      Free;
      exit;
    end;
  end;
  result:= True;
end;

//comprueba si tiene cambio fijo o variable


function TFLGastosCliente.ConsultaGuia: boolean;
var resultado: integer;
begin
  result := false;
  if QGuia = nil then
  begin
    QGuia := TQuery.Create(Self);
    QGuia.DatabaseName := DMBaseDatos.DBBaseDatos.DatabaseName;
  end;
  if DSUnion = nil then
  begin
    DSUnion := TDataSource.Create(self);
    DSUnion.DataSet := QGuia;
  end;
  with QGuia do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT distinct n_albaran_sc albaran, fecha_sc fecha,  ' +
      ' empresa_sc empresa, centro_salida_sc centro, moneda_sc moneda, cliente_sal_sc cliente, ' +
      ' ( select sum(kilos_sl) from frf_salidas_l ' +
      '   where empresa_sl = ' + QuotedStr(EEmpresa.Text) +
      '   AND   centro_salida_sl = centro_salida_sc ' +
      '   AND   fecha_sl = fecha_sc ' +
      '   and   n_albaran_sl = n_albaran_sc ) kilos' +
      ' FROM frf_salidas_c, frf_gastos ' +
      ' WHERE empresa_sc = ' + QuotedStr(EEmpresa.Text) );
    if ECliente.Text <> '' then
      SQL.Add(' AND   cliente_sal_sc = ' + QuotedStr(ECliente.Text) );
    SQL.Add(' AND   fecha_sc BETWEEN ' + QuotedStr(MEDesde.Text) + ' AND ' + QuotedStr(MEHasta.Text) );
    if edtTipo.Text <> '' then
      SQl.Add(' AND   tipo_g = ' + QuotedStr(edtTipo.Text) );
    SQl.Add(' AND   empresa_sc = empresa_g ' +
      ' AND   centro_salida_sc = centro_salida_g ' +
      ' AND   n_albaran_sc = n_albaran_g ' +
      ' AND   fecha_sc = fecha_g ');
    if edtPais.Text <> '' then
    begin
      SQl.Add(' and exists ( select * from frf_clientes ');
      SQl.Add('               where empresa_c = ' + QuotedStr(EEmpresa.Text) );
      SQl.Add('               and cliente_c = cliente_sal_sc ' );
      SQl.Add('               and pais_c = ' + QuotedStr(edtPais.Text)  + ' ) ');
    end;
    if edtProvincia.Text <> '' then
    begin
      SQl.Add(' and exists ( select * from frf_clientes ');
      SQl.Add('               where empresa_c = ' + QuotedStr(EEmpresa.Text) );
      SQl.Add('               and cliente_c = cliente_sal_sc ' );
      SQl.Add('               and cod_postal_c[1,2] = ' + QuotedStr(edtProvincia.Text) + ' ) ');
    end;

    SQl.Add(' ORDER BY n_albaran_sc, fecha_sc  ');

    resultado := ConsultaOpen(Qguia, false);
    if resultado = 0 then
    begin
      ShowError('No existen datos a mostrar');
      Result := False;
      Exit;
    end
    else
      if resultado = 1 then
        result := true
      else
        if resultado = -1 then
        begin
          ShowError('Error al abrir la consulta');
          Result := False;
          Exit;
        end;
  end;
end;

function TFLGastosCliente.Consulta: boolean;
var resultado: integer;
begin
  result := false;
  if QListado = nil then
  begin
    QListado := TQuery.Create(Self);
    QListado.DatabaseName := DMBaseDatos.DBBaseDatos.DatabaseName;
    QListado.DataSource := DSUnion;
  end;
  with QListado do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT tipo_g tipo, ' +
      ' ref_fac_g factura, fecha_fac_g fecha_fac, ' +
      ' importe_g importe, descripcion_tg descripcion ' +
      ' FROM frf_gastos, frf_tipo_gastos ' +
      ' WHERE   empresa_g = :empresa ' +
      ' AND   centro_salida_g = :centro' +
      ' AND   n_albaran_g = :albaran ' +
      ' AND   fecha_g = :fecha ' +
      ' AND   tipo_tg = tipo_g ');
    if edtTipo.Text <> '' then
      SQl.Add(' AND   tipo_g = ' + QuotedStr(edtTipo.Text) );
      SQl.Add(' ORDER BY tipo_g');

    resultado := ConsultaOpen(QListado, false);
    if resultado = 0 then
    begin
      ShowError('No existen datos a mostrar');
      Result := False;
      Exit;
    end
    else
      if resultado = 1 then
        result := true
      else
        if resultado = -1 then
        begin
          ShowError('Error al abrir la consulta');
          Result := False;
          Exit;
        end;
  end;
end;

function TFLGastosCliente.Temporal: boolean;
begin
  if ConsultaExec('CREATE TEMP TABLE tmp_gastos_cli (' +
    ' albaran INTEGER, ' +
    ' fecha DATE, ' +
    ' factura CHAR(10), ' +
    ' fecha_fac DATE, ' +
    ' cliente CHAR(3), ' +
    ' tipo CHAR(3), ' +
    ' descripcion CHAR(30),' +
    ' kilos DECIMAL(12,2), ' +
    ' importe DECIMAL(12,2), ' +
    ' moneda CHAR(3) )', false, false) > -1 then
    Result := true
  else
    result := false;
end;

function TFLGastosCliente.Recorrer: boolean;
var texto: string;
begin
  result := true;
  QGuia.First;
  while not QGuia.Eof do
  begin
    while not QListado.Eof do
    begin
      texto := 'INSERT INTO tmp_gastos_cli VALUES (' +
        IntToStr(QGuia.FieldByName('albaran').Asinteger) + ',' +
        QuotedStr(QGuia.FieldByName('fecha').AsString) + ',' +
        QuotedStr(QListado.FieldByName('factura').AsString) + ',' +
        QuotedStr(QListado.FieldByName('fecha_fac').AsString) + ',' +
        QuotedStr(QGuia.FieldByName('cliente').AsString) + ',' +
        QuotedStr(QListado.FieldByName('tipo').AsString) + ',' +
        QuotedStr(QListado.FieldByName('descripcion').AsString) + ',' +
        SQLNumeric(QGuia.FieldByName('kilos').AsFloat) + ',' +
        SQLNumeric(QListado.FieldByName('importe').AsFloat) + ',' +
        QuotedStr(QGuia.FieldByName('moneda').AsString) + ')';
      if ConsultaExec(texto, false, false) > -1 then
        QListado.Next
      else
      begin
        result := false;
        ShowError('Error en la ejecución');
        exit;
      end;
    end;
    QGuia.Next
  end;
end;


function TFLGastosCliente.AplicarCambio: boolean;
var
  rFactor: real;
begin
  result := true;
  with QListado do
  begin
    Close;
    SQL.Clear;
    SQl.Add('SELECT moneda, fecha FROM tmp_gastos_cli GROUP BY moneda, fecha ');
    if ConsultaOpen(qListado, false, false) = 1 then
    begin
      while not Eof do
      begin
        if FieldByName('moneda').AsString <> 'EUR' then
        begin
          rFactor := ToEuro( FieldByName('moneda').AsString, FieldByName('fecha').AsDateTime );
          ConsultaExec(' UPDATE tmp_gastos_cli '+
                       ' SET importe = importe * ' + SQLNumeric(rFactor) +
                       ' , moneda = ''EUR'' ' +
                       ' WHERE fecha= ' + QuotedStr(FieldByName('fecha').AsString) +
                       ' AND moneda= ' + QuotedStr(FieldByName('moneda').AsString) , false, false);

        end;
        next;
      end;
    end
    else
      result := false;
  end;
end;

function TFLGastosCliente.ConsultaListado: boolean;
var resultado: integer;
begin
  result := false;
  with QListado do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT  cliente, tipo,importe, kilos, descripcion, factura, fecha_fac  ' +
      ' FROM tmp_gastos_cli ' +
      ' WHERE albaran = :albaran ' +
      ' AND   fecha = :fecha ' +
      ' ORDER BY tipo ');
    resultado := ConsultaOpen(QListado, false);
    if resultado = 0 then
    begin
      ShowError('No existen datos a mostrar');
      Result := False;
      Exit;
    end
    else
      if resultado = 1 then
        result := true
      else
        if resultado = -1 then
        begin
          ShowError('Error al abrir la consulta');
          Result := False;
          Exit;
        end;
  end;

end;

procedure TFLGastosCliente.EClienteChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  if ECliente.Text = '' then
    STCliente.Caption:= 'TODOS LOS CLIENTES'
  else
    STCliente.Caption := desCliente(Eempresa.Text, ECliente.Text);
end;

procedure TFLGastosCliente.edtPaisChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  if edtPais.Text = '' then
    stPais.Caption:= 'TODOS LOS PAISES'
  else
    stpais.Caption := despais(edtPais.Text);
end;

procedure TFLGastosCliente.edtProvinciaChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  if edtProvincia.Text = '' then
    stProvincia.Caption:= 'TODAS LOS PROVINCIAS (COD.POSTAL)'
  else
    stProvincia.Caption := desProvincia(edtProvincia.Text);
end;

procedure TFLGastosCliente.edtTipoChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  if edtTipo.Text = '' then
    stTipo.Caption:= 'TODOS LOS GASTOS'
  else
    stTipo.Caption := desTipoGastos(edtTipo.Text);
end;

end.
