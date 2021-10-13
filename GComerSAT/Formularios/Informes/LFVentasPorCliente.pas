unit LFVentasPorCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables;

type
  TFLVentasPorCliente = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    ECategoria: TEdit;
    Lcategoria: TLabel;
    QVentasPorClienteL: TQuery;
    QVentasPorClienteLcliente_tvc: TStringField;
    DSVentasPorClienteL: TDataSource;
    TVentasCliente: TTable;
    Label1: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    BGBProducto: TBGridButton;
    STProducto: TStaticText;
    EProducto: TBEdit;
    Label2: TLabel;
    cbEnvase: TCheckBox;
    Label3: TLabel;
    ECentroD: TBEdit;
    BGBCentroD: TBGridButton;
    Label4: TLabel;
    ECentroH: TBEdit;
    BGBCentroH: TBGridButton;
    Desde: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label14: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label5: TLabel;
    EDesde: TBEdit;
    BGBClienteD: TBGridButton;
    Label6: TLabel;
    EHasta: TBEdit;
    BGBClienteH: TBGridButton;
    Label7: TLabel;
    Label8: TLabel;
    cbxNacionalidad: TComboBox;
    ePais: TBEdit;
    btnPais: TBGridButton;
    cbxJuntarTE: TCheckBox;
    cbxUnidad: TComboBox;
    Label9: TLabel;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbxNacionalidadChange(Sender: TObject);

  private

    procedure RellenarTablaTemporal;
    procedure RellenaTabla( const ACliente: string; const AAnoSemana: integer; const AUnidades, AImporte: real);
    function  GetGastos: Real;

  public
    { Public declarations }
    sUnidad: string;

    empresa, centro, producto, factura: string;
    envase, productos, lblEnvase: string;

    procedure AbrirTabla;
    procedure VaciarTemporal;
    function  QuerysListado: boolean;
    function  AnyoSemana(fecha: TDate): integer;
    function  CamposVacios: boolean;
    function  HacerTemporal: boolean;
    function  AbrirTemporal: boolean;
    procedure CerrarTemporal;

    function Procede: boolean;
  end;

var
  FLVentasPorCliente: TFLVentasPorCliente;

  acAcumImportes, acAcumKilos: real;

  Autorizado: boolean;
  indice: integer;
  //Controla la semana para la que se inserta valor
  indice_semana: integer;
  //En el se guarda el valor de cambio de la moneda
  rFactorFOB: real;


implementation

uses Principal, CVariables, DPreview, bNumericUtils, CReportes, Variants,
  CAuxiliarDB, LVentasPorCliente, UDMAuxDB, UDMBaseDatos, bTimeUtils,
  bSQLUtils, UDMCambioMoneda, UDMConfig, bMath;


{$R *.DFM}

function TFLVentasPorCliente.Procede: boolean;
begin
  result := true;
     //Guardo los datos de la cabecera del informe
  empresa := EEmpresa.Text + '  ' + STEmpresa.Caption;
  producto := EProducto.Text + '  ' + STProducto.Caption;

     //Se vacia la temporal para que se no se mezclen datos de informes anteriores
  VaciarTemporal;

     //Sacar datos de salidas y gastos
  if not HacerTemporal then
  begin
    ShowMessage('No existen datos a listar con los parámetros introducidos');
    Exit;
  end;

     //Abrir temporal
  if not AbrirTemporal then
  begin
    BorrarTemporal('tmp_listado');
    ShowMessage('No existen datos a listar con los parámetros introducidos');
    Exit;
  end;
  AbrirTabla;

  //Recorro la query principal, para restar gastos, sacar precios...
  RellenarTablaTemporal;
  CerrarTemporal;

     //Abro las querys que van a utilizarse para sacar el informe
  if not QuerysListado then
  begin
    Exit;
  end;

     //Llamamos al QReport
  QRLVentasPorCliente := TQRLVentasPorCliente.Create(Application);
  try
    PonLogoGrupoBonnysa(QRLVentasPorCliente, EEmpresa.Text);

    if Trim(ECategoria.Text) <> '' then
      QRLVentasPorCliente.lblCategorias.Caption := 'CATEGORÍA: ' + ECategoria.Text
    else
      QRLVentasPorCliente.lblCategorias.Caption := 'TODAS LAS CATEGORIAS';

    case cbxUnidad.ItemIndex of
      0:begin
          QRLVentasPorCliente.lblUnidad.Caption:= 'Kgs';
          QRLVentasPorCliente.lblPrecio.Caption:= 'Eur/Kg';
        end;
      1:begin
          QRLVentasPorCliente.lblUnidad.Caption:= 'Cajas';
          QRLVentasPorCliente.lblPrecio.Caption:= 'Eur/Cj';
        end;
      2:begin
          QRLVentasPorCliente.lblUnidad.Caption:= 'Unds';
          QRLVentasPorCliente.lblPrecio.Caption:= 'Eur/Un';
        end;
    end;

    QRLVentasPorCliente.lblPeriodo.Caption := 'DEL ' + MEDesde.Text + ' AL ' + MEHasta.Text;

    QRLVentasPorCliente.lblCentro.Caption := RangoCentros( EEmpresa.Text, ECentroD.Text, ECentroH.Text );

    envase := StringReplace(envase, '''', '', [rfReplaceAll, rfIgnoreCase]);
    if envase <> '' then
    begin
      QRLVentasPorCliente.lblEnvase.Caption := desEnvase(EEmpresa.Text, envase);
      if QRLVentasPorCliente.lblEnvase.Caption = '' then
      begin
        QRLVentasPorCliente.lblEnvase.Caption := lblEnvase;
      end
      else
      begin
        QRLVentasPorCliente.lblEnvase.Caption := envase + ' ' + QRLVentasPorCliente.lblEnvase.Caption;
      end;
    end
    else
    begin
      QRLVentasPorCliente.lblEnvase.Caption := 'TODOS LOS ARTICULOS';
    end;
    if not Preview(QRLVentasPorCliente) then
    begin
      if cbEnvase.Checked and not DMBaseDatos.QTemp.Eof then
      begin
        result := MessageDlg('Desea cancelar los artículos restantes?',
          mtConfirmation, [mbYes, mbNo], 0) = mrNo;
      end;
    end;
  finally
    TVentasCliente.Close;
    BorrarTemporal('tmp_listado');
  end;

  indice := 0;
end;


procedure TFLVentasPorCliente.BBAceptarClick(Sender: TObject);
var
  canario, ensalada: string;
begin
  sUnidad:= cbxUnidad.Items[cbxUnidad.ItemIndex];
  if UpperCase( sUnidad ) = 'KILOS' then
    sUnidad:= 'kilos_producto';
  if not CerrarForm(true) then Exit;

  Self.ActiveControl := nil;

  if CamposVacios then Exit;

//  if ((eProducto.Text = 'TOM') or (eProducto.Text = 'TOM')) and (cbxJuntarTE.Checked) then
//    productos := 'TE'
//  else
    productos := eProducto.Text;
  {
  productos:= StringReplace(eProducto.Text,',','',[rfReplaceAll, rfIgnoreCase]);
  productos:= StringReplace(productos,' ','',[rfReplaceAll, rfIgnoreCase]);
  }

  envase := '';
  canario := '';
  ensalada := '';

  if cbEnvase.Checked then
  begin
    with DMBaseDatos.QTemp do
    begin
      SQL.Clear;
      SQL.Add(' select unique envase_sl, descripcion_e ');
      SQL.Add(' from frf_salidas_c, frf_salidas_l s, frf_envases, frf_clientes ');
      SQL.Add(' where empresa_sl = :empresa ');
      if Trim(productos) <> '' then
        SQL.Add(' AND producto_sl =' + QuotedStr(productos));
      SQL.Add(' and centro_origen_sl between :centroD and :centroH');
      SQL.Add(' and cliente_sl between :clienteD and  :clienteH ');
      SQL.Add(' and fecha_sl between :fechaDesde and :fechaHasta');
      SQL.Add(' and envase_e = envase_sl ');
      SQL.Add(' and empresa_sc = empresa_sl ');
      SQL.Add(' and empresa_sc = empresa_sl ');
      SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      SQL.Add(' and n_albaran_sc = n_albaran_sl ');
      SQL.Add(' and fecha_sc = fecha_sl ');
      SQL.Add(' and es_transito_sc <> 2 ');                     //Tipo Salida: Devolucion

             //Solamente albaranes valorados
      SQL.Add(' and ( exists ( select * from frf_salidas_l saux  ');
      SQL.Add(' where saux.empresa_sl = ' + QuotedStr(EEmpresa.Text));
      SQL.Add(' and saux.centro_salida_sl = s.centro_salida_sl ');
      SQL.Add(' and saux.fecha_sl = s.fecha_sl ');
      SQL.Add(' and saux.n_albaran_sl = s.n_albaran_sl ');
      SQL.Add(' and NVL(saux.precio_sl, 0) <> 0 ) ');
      SQL.Add(' or  exists ( select * from frf_salidas_c  ');
      SQL.Add(' where empresa_sc = ' + QuotedStr(EEmpresa.Text));
      SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      SQL.Add(' and fecha_sc = fecha_sl ');
      SQL.Add(' and n_albaran_sc = s.n_albaran_sl ');
      SQL.Add(' and fecha_factura_sc is not null ) )');

      if cbxNacionalidad.ItemIndex > 0 then
      begin
        SQL.Add(' and cliente_c = cliente_sl ');
        case cbxNacionalidad.ItemIndex of
          1: SQL.Add(' and pais_c = "ES" ');
          2: SQL.Add(' and pais_c <> "ES" ');
          3: SQL.Add(' and pais_c = "' + ePais.Text + '" ');
        end;
      end;
      ParamByName('empresa').AsString := EEmpresa.Text;
      ParamByName('clienteD').AsString := EDesde.Text;
      ParamByName('clienteH').AsString := EHasta.Text;
      ParamByName('centroD').AsString := ECentroD.Text;
      ParamByName('centroH').AsString := ECentroH.Text;
      ParamByName('fechaHasta').AsString := MEHasta.Text;
      ParamByName('fechaDesde').AsString := MEDesde.Text;
      Open;
      if IsEmpty then
      begin
        Close;
        ShowMessage('No hay salidas valoradas para los datos seleccionados.');
        Exit;
      end;
      while not eof do
      begin
        if Pos('ENS', Fields[1].asstring) > 0 then
        begin
          if ensalada <> '' then
            ensalada := ensalada + ',' + QUOTEDSTR(Fields[0].asstring)
          else
            ensalada := QUOTEDSTR(Fields[0].asstring);
          next;
        end
        else
          if (Pos('CANARIO', Fields[1].asstring) > 0) or
            (Pos('UNTAR', Fields[1].asstring) > 0) then
          begin
            if canario <> '' then
              canario := canario + ',' + QUOTEDSTR(Fields[0].asstring)
            else
              canario := QUOTEDSTR(Fields[0].asstring);
            next;
          end
          else
          begin
            lblEnvase := 'OTROS';
            envase := QUOTEDSTR(Fields[0].asstring);
            next;
            if not Procede then
            begin
              Close;
              Exit;
            end;
          end;
      end;
      Close;

      if canario <> '' then
      begin
        lblEnvase := 'CANARIO (' + canario + ')';
        envase := canario;
        if not Procede then
        begin
          Close;
          Exit;
        end;
      end;

      if ensalada <> '' then
      begin
        lblEnvase := 'ENSALADA (' + ensalada + ')';
        envase := ensalada;
        if not Procede then
        begin
          Close;
          Exit;
        end;
      end;
      ShowMessage('Proceso finalizado.');
    end;
  end
  else
  begin
    Procede;
  end;
end;

procedure TFLVentasPorCliente.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLVentasPorCliente.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  EDesde.Tag := kCliente;
  EHasta.Tag := kCliente;
  ECentroD.Tag := kCentro;
  ECentroH.Tag := kCentro;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  ePais.Tag := kPais;
  gRF := rejillaFlotante;
  gCF := calendarioFlotante;

  EDesde.Text := '0';
  EHasta.Text := 'ZZZ';
  ECentroD.Text := '1';
  ECentroH.Text := '6';
  MEDesde.Text := DateTostr(Date);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;
  eEmpresa.Text:= gsDefEmpresa;
  eProducto.Text:= gsDefProducto;

  ePais.Text := 'ES';

  indice := 0;
     //lleva la cuenta de los clientes para los que se ha guardado el precio por semana

  ECategoria.Visible := True;
  LCategoria.Visible := True;

  (*
  if not DMConfig.EsLaFont then
  begin
    cbxJuntarTE.Visible:= False;
  end;
  *)
end;

procedure TFLVentasPorCliente.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := EEmpresa;
end;

procedure TFLVentasPorCliente.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLVentasPorCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  Action := caFree;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLVentasPorCliente.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLVentasPorCliente.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kPais: DespliegaRejilla(btnPais, []);
    KCentro:
      begin
        if ECentroD.Focused then
          DespliegaRejilla(BGBCentroD, [EEmpresa.Text])
        else
          DespliegaRejilla(BGBCentroH, [EEmpresa.Text]);
      end;
    kCliente:
      begin
        if EDesde.Focused then
          DespliegaRejilla(BGBClienteD, [EEmpresa.Text])
        else
          DespliegaRejilla(BGBClienteH, [EEmpresa.Text])
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

procedure TFLVentasPorCliente.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
    kProducto: STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
  end;
end;

function TFLVentasPorCliente.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if EProducto.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EProducto.SetFocus;
    Result := True;
    Exit;
  end;

  if ECentroD.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    ECentroD.SetFocus;
    Result := True;
    Exit;
  end;


  if ECentroh.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    ECentroH.SetFocus;
    Result := True;
    Exit;
  end;

  if EDesde.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if EHasta.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EHasta.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;

procedure TFLVentasPorCliente.AbrirTabla;
begin
  try
    TVentasCliente.Open;
  except
    on E: EDBEngineError do
    begin
      ShowError('No se puede abrir la tabla para mostrar el listado');
      Exit;
    end;
  end;
end;

procedure TFLVentasPorCliente.VaciarTemporal;
begin
//  Exit;
  with DMBaseDatos.QGeneral do
  begin
    Close;
    SQL.Clear;
    SQl.Add(' DELETE FROM tmp_ventas_cliente');
    try
      ExecSQL;
    except
      on E: EDBEngineError do
      begin
        raise Exception.Create('No se puede vaciar la temporal');
      end;
    end;
  end;
end;

function TFLVentasPorCliente.QuerysListado: boolean;
begin
  begin
    QVentasPorClienteL.Close;
    QVentasPorClienteL.ParamByName('desde').AsString := EDesde.Text;
    QVentasPorClienteL.ParamByName('hasta').AsString := EHasta.Text;
    try
      QVentasPorClienteL.Open;
    except
      on E: EDBEngineError do
      begin
        raise;
        Result := False;
        Exit;
      end;
    end;
    if QVentasPorClienteL.RecordCount < 1 then Result := False
    else Result := True;
  end;
end;

function TFLVentasPorCliente.AnyoSemana(fecha: Tdate): integer;
var anyo, mes, dia: word;
  sem: integer;
  aux: string;
begin
     //*************************************************************************
  DecodeDate(fecha, anyo, mes, dia);
  sem := Semana(fecha);
     //Comprobar que la semana pertenece al año que se indica
  if (sem = 1) and (mes = 12) then
  begin
    Inc(anyo);
  end;
  if (sem > 51) and (mes = 1) then
  begin
    Dec(anyo);
  end;
  if sem < 10 then
    aux := '0' + IntToStr(sem)
  else
    aux := IntToStr(sem);
  aux := IntToStr(anyo) + aux;
  Result := StrToInt(aux);
     //*************************************************************************
end;

function TFLVentasPorCliente.HacerTemporal: boolean;
begin

  BorrarTemporal('tmp_listado');


   //SACO LOS DATOS DE LAS TABLAS DE SALIDAS DEL PRODUCTO SELECCIONADO
  with DMBaseDatos.QGeneral do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT empresa_sc, cliente_sal_sc,moneda_sc,fecha_sc,n_albaran_sc,' +

      '      ROUND( SUM((case when producto_sl = ' + QuotedStr(productos) + ' then importe_neto_sl else 0 end * ' +
      '        ( 1 - ( GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc ) / 100 ) ) * ' +
      '        ( 1 - ( GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 2 ) /100 ) ) )), 2) Total, ');

    SQL.Add('       SUM(kilos_sl) Kilos_total, ');
    SQL.Add('       sum(case when producto_sl =' + QuotedStr(productos) + ' then kilos_sl else 0 end) kilos_producto, ');
    SQL.Add('       sum(case when ref_transitos_sl is not null then kilos_sl else 0 end) kilos_ttotal, ');
    SQL.Add('       sum(case when ( ref_transitos_sl is not null ) and ( producto_sl =' + QuotedStr(productos) + ' ) then kilos_sl else 0 end) kilos_tproducto, ');


    SQL.Add('      SUM( case when producto_sl =' + QuotedStr(productos) + ' then cajas_sl else 0 end )cajas, ' +
      '      SUM( unidades_caja_sl * case when producto_sl =' + QuotedStr(productos) + ' then cajas_sl else 0 end ) Unidades, centro_salida_sc ' +

      ' FROM frf_salidas_l s, frf_salidas_c' +
      ' WHERE empresa_sc = ' + QuotedStr(EEmpresa.Text) +
             //' AND   producto_sl = '+QuotedStr(EProducto.Text) +
      ' AND   (centro_origen_sl BETWEEN ' + QuotedStr(ECentroD.Text) + ' AND ' + QuotedStr(ECentroH.Text) + ')' +
      ' AND   (cliente_sal_sc BETWEEN ' + QuotedStr(EDesde.Text) + ' AND ' + QuotedStr(EHasta.Text) + ')' +
      ' AND   (fecha_sc BETWEEN ' + QuotedStr(MEDesde.Text) + ' AND ' + QuotedStr(MEHasta.Text) + ')' +
      ' AND   (cliente_sal_sc<> ' + QuotedStr('RET') + ')');


    if cbxNacionalidad.ItemIndex > 0 then
    begin
      SQL.Add('  AND   (cliente_sal_sc in (select cliente_c from frf_clientes ' +
        '         where cliente_c = cliente_sal_sc ');

      case cbxNacionalidad.ItemIndex of
        1: SQL.Add(' and pais_c = "ES" ) )');
        2: SQL.Add(' and pais_c <> "ES" ) )');
        3: SQL.Add(' and pais_c = "' + ePais.Text + '" ) )');
      end;
    end;

    SQL.Add(' AND   (empresa_sl = empresa_sc)' +
      ' AND   (centro_salida_sl = centro_salida_sc)' +
      ' AND   (n_albaran_sl = n_albaran_sc)' +
      ' AND   (fecha_sl = fecha_sc)');

    if envase <> '' then
      SQL.Add(' AND  envase_sl IN (' + envase + ')');
    if trim(ECategoria.Text) <> '' then
      SQL.Add(' AND   (categoria_sl = ' + QuotedStr(Trim(ECategoria.text)) + ')');

    SQL.Add(' AND es_transito_sc <> 2 ');           //Tipo Salida: Devolucion

    SQL.Add(' GROUP BY empresa_sc, cliente_sal_sc, centro_salida_sc, n_albaran_sc, fecha_sc,' +
      ' moneda_sc');
    SQL.Add(' HAVING ( sum(case when producto_sl =' + QuotedStr(productos) + ' then kilos_sl else 0 end) > 0 )');
    SQL.Add('        AND ( sum(case when producto_sl =' + QuotedStr(productos) + ' then importe_neto_sl else 0 end) > 0 )');
    SQL.Add(' ORDER BY empresa_sc, cliente_sal_sc, centro_salida_sc, n_albaran_sc, fecha_sc, moneda_sc' +
      ' INTO TEMP tmp_salidas');

    ExecSQl;

     //Comprobar que existan datos
    SQL.Clear;
    SQL.Add('select count(*) from tmp_salidas');
    Open;
    if Fields[0].asinteger < 0 then
    begin
      Cancel;
      Close;
      BorrarTemporal('tmp_salidas');
      Result := False;
      Exit;
    end
    else
    begin
      Cancel;
      Close;
      Result := True;
    end;

     //CONSULTA DE LOS GASTOS SIN TENER EN CUENTA LOS GASTOS DE TRANSITO
    SQL.Clear;
    SQL.Add('SELECT s.*, ' +
      '        nvl(sum(case when ( gasto_transito_tg <> 1 ) and ( producto_g is null ) then g.Importe_g else 0 end*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END),0) gastos_gtodos, ' +
      '        nvl(sum(case when ( gasto_transito_tg <> 1 ) and ( producto_g is not null ) then g.Importe_g else 0 end*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END),0) gastos_ptodos, ' +
      '        nvl(sum(case when ( gasto_transito_tg = 1 ) and ( producto_g is null ) then g.Importe_g else 0 end*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END),0) gastos_gtransitos, ' +
      '        nvl(sum(case when ( gasto_transito_tg = 1 ) and ( producto_g is not null ) then g.Importe_g else 0 end*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END),0) gastos_ptransitos ' +
      ' FROM tmp_salidas s, OUTER(frf_gastos g ,frf_tipo_gastos)' +
      ' WHERE (empresa_g = empresa_sc) ' +
      ' AND   (centro_salida_g = centro_salida_sc)' +
      ' AND   (n_albaran_g = n_albaran_sc)' +
      ' AND   (fecha_g = fecha_sc)' +
      ' AND   (tipo_g=tipo_tg)  ' +
      ' AND   (descontar_fob_tg = "S"' +
      '    OR  facturable_tg = ' + QuotedStr('S') + ') ' +
      ' and   (producto_g is null or  producto_g  =' + QuotedStr(productos) + ') ' +
      ' GROUP BY empresa_sc, cliente_sal_sc, moneda_sc, fecha_sc, n_albaran_sc,' +
      ' centro_salida_sc,  total, kilos_total, kilos_producto, kilos_ttotal, kilos_tproducto, cajas, unidades' +
      ' ORDER BY empresa_sc, cliente_sal_sc, fecha_sc, n_albaran_sc' +
      ' INTO TEMP tmp_listado ');
    ExecSQL;

    BorrarTemporal('tmp_salidas');
  end;
end;

function TFLVentasPorCliente.AbrirTemporal: boolean;
begin
  with DMBaseDatos.QMaestro do
  begin
    RequestLive:= False;
    Close;
    SQL.Clear;
    SQL.Add('SELECT cliente_sal_sc ');
    SQL.Add('FROM tmp_listado ');
    SQL.Add('GROUP BY cliente_sal_sc ');
    SQL.Add('ORDER BY cliente_sal_sc ');
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError('E');
        Result := False;
        Exit;
      end;
    end;
    if RecordCount < 1 then
      Result := False
    else
      Result := True;
  end;
  if Result then
  with DMBaseDatos.QDetalle do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM tmp_listado ');
    SQL.Add('WHERE cliente_sal_sc = :cliente_sal_sc');
    SQL.Add('ORDER BY  FECHA_SC ');
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError('E');
        Result := False;
        Exit;
      end;
    end;
  end;
end;

procedure TFLVentasPorCliente.CerrarTemporal;
begin
  DMBaseDatos.QDetalle.Cancel;
  DMBaseDatos.QDetalle.Close;
  DMBaseDatos.QMaestro.Cancel;
  DMBaseDatos.QMaestro.Close;
  DMBaseDatos.QMaestro.RequestLive:= True;
end;

procedure TFLVentasPorCliente.cbxNacionalidadChange(Sender: TObject);
begin
  ePais.Enabled := TComboBox(sender).ItemIndex = 3;
  btnPais.Enabled := ePais.Enabled;
end;

function TFLVentasPorCliente.GetGastos: Real;
begin
  result:= 0;
  with DMBaseDatos do
  begin
    if ( QDetalle.FieldByname('gastos_gtodos').AsFloat <> 0 ) and
       ( QDetalle.FieldByname('kilos_total').AsFloat > 0 ) then
    begin
      result:= Result + bRoundTo( ( QDetalle.FieldByname('gastos_gtodos').AsFloat *
                                    QDetalle.FieldByname('kilos_producto').AsFloat ) /
                                      QDetalle.FieldByname('kilos_total').AsFloat, 2 );
    end;

    if QDetalle.FieldByname('gastos_ptodos').AsFloat <> 0 then
    begin
      result:= result + QDetalle.FieldByname('gastos_ptodos').AsFloat;
    end;

    if ( QDetalle.FieldByname('kilos_ttotal').AsFloat > 0 ) and
       ( QDetalle.FieldByname('gastos_gTransitos').AsFloat <> 0 ) then
    begin
      result:= result + bRoundTo( ( QDetalle.FieldByname('gastos_gTransitos').AsFloat *
                                      QDetalle.FieldByname('kilos_tproducto').AsFloat ) /
                                        QDetalle.FieldByname('kilos_ttotal').AsFloat, 2 );
    end;

    if ( QDetalle.FieldByname('gastos_pTransitos').AsFloat <> 0 ) then
    begin
      result:= result + QDetalle.FieldByname('gastos_pTransitos').AsFloat;
    end;
  end;
end;

procedure TFLVentasPorCliente.RellenarTablaTemporal;
var
  bFlag: Boolean;
  dFecha: TDateTime;
  dFechaIni, dFechaFin: TDateTime;
  ano_semana, ano_semana_aux: Integer;
  ano_semana_ini, ano_semana_fin: Integer;
  rAcumUnidades, rAcumImportes: Real;
  rGastos, rFactor: real;
begin
  //Cambiar por año-semana
  dFechaIni:= StrToDate(MEDesde.Text);
  dFechaFin:= StrToDate(MEHasta.Text);
  ano_semana_ini:= AnyoSemana( dFechaIni );
  ano_semana_fin:= AnyoSemana( dFechaFin );

  //Correcto si la semana empieza en lunes y termina en domingo
  //Y las semanas que no tienen datos, hacer por cliente
  //gastos y cambio

  //Inicializar totales semana
  dFecha:= dFechaIni;
  ano_semana:= AnyoSemana( dFecha );
  while ano_semana <= ano_semana_fin do
  begin
    TVentasCliente.Insert;
    TVentasCliente.FieldByName('cliente_tvc').AsString:= 'ZZZ';
    TVentasCliente.FieldByName('ano_semana_tvc').AsInteger:= ano_semana;
    TVentasCliente.FieldByName('kilos_tvc').AsFloat:= 0;
    TVentasCliente.FieldByName('neto_tvc').AsFloat:= 0;
    TVentasCliente.FieldByName('precio_tvc').AsFloat:= 0;
    TVentasCliente.Post;
    dFecha:= dFecha + 7;
    ano_semana:= AnyoSemana( dFecha );
  end;

  //Para cada cliente
  with DMBaseDatos do
  begin
    while not QMaestro.Eof do
    begin

      dFecha:= dFechaIni;
      ano_semana:= AnyoSemana( dFecha );
      while ano_semana <= ano_semana_fin do
      begin

        bFlag:= True;
        rAcumUnidades:= 0;
        rAcumImportes:= 0;
        while ( not QDetalle.Eof ) and bFlag do
        begin

          ano_semana_aux:= AnyoSemana( QDetalle.FieldByname('fecha_sc').AsDateTime );
          if ano_semana_aux <= ano_semana then
          begin
            //y las cajas
            case cbxUnidad.ItemIndex of
              0: //kilos
                 rAcumUnidades:= rAcumUnidades + QDetalle.FieldByname('kilos_producto').AsFloat;
              1: //Cajas
                 rAcumUnidades:= rAcumUnidades + QDetalle.FieldByname('cajas').AsFloat;
              2: //unidades
                 rAcumUnidades:= rAcumUnidades + QDetalle.FieldByname('unidades').AsFloat;
            end;


            rGastos:= GetGastos;
            rFactor:= ToEuro( QDetalle.FieldByname('moneda_sc').AsString, QDetalle.FieldByname('fecha_sc').AsDateTime );
            rAcumImportes:= rAcumImportes + bRoundTo( ( QDetalle.FieldByname('total').AsFloat - rGastos ) * rFactor, 2) ;

            QDetalle.Next;
          end
          else
          begin
            bFlag:= False;
          end;

        end;

        RellenaTabla( QDetalle.FieldByname('cliente_sal_sc').AsString, ano_semana, rAcumUnidades, rAcumImportes );
        dFecha:= dFecha + 7;
        ano_semana:= AnyoSemana( dFecha );
      end;

      QMaestro.Next;
    end;
  end;
end;

procedure TFLVentasPorCliente.RellenaTabla( const ACliente: string; const AAnoSemana: integer; const AUnidades, AImporte: real);
begin
  with TVentasCliente do
  begin
    try
      if Locate('cliente_tvc;ano_semana_tvc', VarArrayOf([ACliente,AAnoSemana]), []) then
      begin
        Edit;
        FieldByName('kilos_tvc').AsFloat:= FieldByName('kilos_tvc').AsFloat + AUnidades;
        FieldByName('neto_tvc').AsFloat:= FieldByName('neto_tvc').AsFloat + AImporte;
        if  FieldByName('kilos_tvc').AsFloat <> 0 then
          FieldByName('precio_tvc').AsFloat:= bRoundTo( FieldByName('neto_tvc').AsFloat / FieldByName('kilos_tvc').AsFloat, 3 )
        else
          FieldByName('precio_tvc').AsFloat:= 0;
        Post;
      end
      else
      begin
        Insert;
        FieldByName('cliente_tvc').AsString:= ACliente;
        FieldByName('ano_semana_tvc').AsInteger:= AAnoSemana;
        FieldByName('kilos_tvc').AsFloat:= AUnidades;
        FieldByName('neto_tvc').AsFloat:= AImporte;
        if  FieldByName('kilos_tvc').AsFloat <> 0 then
          FieldByName('precio_tvc').AsFloat:= bRoundTo( FieldByName('neto_tvc').AsFloat / FieldByName('kilos_tvc').AsFloat, 3 )
        else
          FieldByName('precio_tvc').AsFloat:= 0;
        Post;
      end;
      if Locate('cliente_tvc;ano_semana_tvc', VarArrayOf(['ZZZ',AAnoSemana]), []) then
      begin
        Edit;
        FieldByName('kilos_tvc').AsFloat:= FieldByName('kilos_tvc').AsFloat + AUnidades;
        FieldByName('neto_tvc').AsFloat:= FieldByName('neto_tvc').AsFloat + AImporte;
        if  FieldByName('kilos_tvc').AsFloat <> 0 then
          FieldByName('precio_tvc').AsFloat:= bRoundTo( FieldByName('neto_tvc').AsFloat / FieldByName('kilos_tvc').AsFloat, 3 )
        else
          FieldByName('precio_tvc').AsFloat:= 0;
        Post;
      end;
    except
      on E: EDBEngineError do
      begin
        ShowError(ACliente + ' - ' + inttostr(AAnoSemana));
        raise;
      end;
    end;
  end;
end;


end.

