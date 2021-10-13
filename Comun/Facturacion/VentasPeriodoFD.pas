(*
  NOTA EXCLUIMOS EL PRODUCTO E
*)
unit VentasPeriodoFD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton,
  DBTables;

type
  TFDVentasPeriodo = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    LEmpresa: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    STProducto: TStaticText;
    stCentro: TStaticText;
    BGBProducto: TBGridButton;
    EProducto: TBEdit;
    LProducto: TLabel;
    Label3: TLabel;
    ECentro: TBEdit;
    Label1: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    btnCentro: TBGridButton;
    lblCliente: TLabel;
    eCliente: TBEdit;
    btnCliente: TBGridButton;
    stCliente: TStaticText;
    Label4: TLabel;
    ESerie: TBEdit;
    BGBSerie: TBGridButton;
    cbbTipoFecha: TComboBox;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure EEmpresaChange(Sender: TObject);
    procedure EProductoChange(Sender: TObject);
    procedure ECentroChange(Sender: TObject);
    procedure eClienteChange(Sender: TObject);

  private
    { Private declarations }
    function ValidarParametros: Boolean;
    procedure ObtenerDatos;
    procedure PrevisualizarInforme;
  public
    { Public declarations }
    sEmpresa, sserie, sCentro, sCliente, sProducto: string;
    dIni, dFin: TDateTime;
  end;

implementation

uses UDMAuxDB, CVariables, Principal, UDMBaseDatos, CReportes, CGlobal,
  CAuxiliarDB, VentasPeriodoQR, DPreview, bTimeUtils, DateUtils, UDMMaster, CFactura;


{$R *.DFM}

procedure TFDVentasPeriodo.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFDVentasPeriodo.ValidarParametros: Boolean;
begin
  Result:= False;

  //Comprobar parametros de entrada
  if STEmpresa.Caption = '' then
  begin
    MessageDlg('Falta o código de empresa incorrecto', mtError, [mbOk], 0);
    EEmpresa.SetFocus;
    Exit;
  end;

  if ESErie.Text <> '' then
  begin
    if not ExisteSerieG( ESerie.Text ) then
    begin
      MessageDlg('La serie indicada es incorrecta.', mtError, [mbOk], 0);
      ESerie.SetFocus;
      Exit;
    end;
  end;

  if stCentro.Caption = '' then
  begin
    MessageDlg('Código de centro incorrecto', mtError, [mbOk], 0);
    ECentro.SetFocus;
    Exit;
  end;

  if stCliente.Caption = '' then
  begin
    MessageDlg('Código de cliente incorrecto', mtError, [mbOk], 0);
    ECliente.SetFocus;
    Exit;
  end;

  if STProducto.Caption = '' then
  begin
    MessageDlg('Código de producto incorrecto.', mtError, [mbOk], 0);
    EProducto.SetFocus;
    Exit;
  end;

  if not TryStrToDate( MEDesde.Text, dIni ) then
  begin
    MessageDlg('Fecha de inicio incorrecta ...', mtError, [mbOk], 0);
    MEDesde.SetFocus;
    Exit;
  end;
  if not TryStrToDate( MEHasta.Text, dFin ) then
  begin
    MessageDlg('Fecha de fin incorrecta ...', mtError, [mbOk], 0);
    MEHasta.SetFocus;
    Exit;
  end;
  if dIni > dFin then
  begin
    MessageDlg('Rango de fechas incorrecto ...', mtError, [mbOk], 0);
    MEDesde.SetFocus;
    Exit;
  end;

  sempresa:= EEmpresa.Text;
  sserie:= ESerie.Text;
  scentro:= ECentro.Text;
  sCliente:= eCliente.Text;
  sproducto:= EProducto.Text;

  result:= True;
end;

procedure TFDVentasPeriodo.PrevisualizarInforme;
var
  QRVentasPeriodo: TQRVentasPeriodo;
begin
  QRVentasPeriodo:= TQRVentasPeriodo.Create( Application );
  try
    QRVentasPeriodo.qrlblCliente.Caption:= stCliente.Caption;
    QRVentasPeriodo.qrlblCentro.Caption:= stcentro.Caption;
    QRVentasPeriodo.qrlblPeriodo.Caption:= 'Del ' + MEDesde.Text + ' al ' + MEHasta.Text;
    QRVentasPeriodo.qrlblEmpresa.Caption:= STEmpresa.Caption;
    PonLogoGrupoBonnysa( QRVentasPeriodo );
    Preview( QRVentasPeriodo );
  except
    FreeAndNil( QRVentasPeriodo );
  end;
end;

procedure TFDVentasPeriodo.ObtenerDatos;
begin
  //with DMMaster.qryAux do
  with DMAuxDB.QAux do
  begin
    if Active then Close;
  end;

  //if CGlobal.gProgramVersion = CGlobal.pvSAT then
  //with DMMaster.qryAux do
  with DMAuxDB.QAux do
  begin
    //COMERSAT
    //FACTURADO
    SQL.Clear;
    SQL.Add(' select cod_empresa_albaran_fd empresa, cod_centro_albaran_fd centro, fecha_albaran_fd fecha_albaran, n_albaran_fd n_albaran, ');
    SQL.Add('        (select cta_cliente_c from frf_clientes where cliente_c = cod_cliente_fc) codigox3, ');
    SQL.Add('        (select  case when pais_c = ''ES'' then ''ES'' else ''EX'' end from frf_clientes where cliente_c = cod_cliente_fc) nacional, ');
    SQL.Add('        (case when automatica_fc = 1 then ''A'' else ''M'' end) manual, ');
    SQL.Add('        cod_factura_fd cod_factura, fecha_factura_fc fecha_factura, cod_cliente_albaran_fd cod_cliente, ');
    SQL.Add('        (select nombre_c from frf_clientes where cliente_c = cod_cliente_fc) des_cliente, ');
    SQL.Add('        cod_pais_fc cod_pais, (select descripcion_p from  frf_clientes, frf_paises where cod_cliente_albaran_fd = cliente_c and pais_c = pais_p ) pais, ');
    SQL.Add('        cod_producto_fd cod_producto, (select descripcion_p from frf_productos where producto_p = cod_producto_fd) des_producto, ');
    SQL.Add('        cod_envase_fd cod_envase, ( select max(descripcion_e) from frf_envases where envase_E = cod_envase_fd )  des_envase, ');
    SQL.Add('      (select nvl(sum(cajas_sl), 0)  ');
    SQL.Add('      from frf_salidas_c, frf_salidas_l ');
    SQL.Add('      	 where empresa_sc = cod_empresa_albaran_fd ');
    SQL.Add('                 and centro_salida_sc = cod_centro_albaran_fd ');
    SQL.Add('                 and n_albaran_sc = n_albaran_fd  ');
    SQL.Add('                 and fecha_sc = fecha_albaran_fd  ');
    SQL.Add('                 and empresa_sl = empresa_sc      ');
    SQL.Add('                 and centro_salida_sl = centro_salida_sc ');
    SQL.Add('      	          and n_albaran_sl = n_albaran_sc   ');
    SQL.Add('                 and fecha_sl = fecha_sc    ');
    SQL.Add('                 and producto_sl = cod_producto_fd ');
    SQL.Add('                 and envase_sl =  cod_envase_fd ');
    SQL.Add('                 and es_transito_sc <> 2) cajas2, ');

    SQL.Add('             (select nvl(sum(unidades_caja_sl*cajas_sl), 0) ');
    SQL.Add('      	  from frf_salidas_c, frf_salidas_l   ');
    SQL.Add('      	 where empresa_sc = cod_empresa_albaran_fd ');
    SQL.Add('                 and centro_salida_sc = cod_centro_albaran_fd ');
    SQL.Add('                 and n_albaran_sc = n_albaran_fd   ');
    SQL.Add('                 and fecha_sc = fecha_albaran_fd   ');
    SQL.Add('                 and empresa_sl = empresa_sc       ');
    SQL.Add('                 and centro_salida_sl = centro_salida_sc ');
    SQL.Add('      	   and n_albaran_sl = n_albaran_sc          ');
    SQL.Add('                 and fecha_sl = fecha_sc           ');
    SQL.Add('                 and producto_sl = cod_producto_fd ');
    SQL.Add('                 and envase_sl =  cod_envase_fd ');
    SQL.Add('                 and es_transito_sc <> 2) unidades2,  ');

    SQL.Add('             (select nvl(sum(kilos_sl), 0)  ');
    SQL.Add('      	  from frf_salidas_c, frf_salidas_l  ');
    SQL.Add('      	 where empresa_sc = cod_empresa_albaran_fd ');
    SQL.Add('                 and centro_salida_sc = cod_centro_albaran_fd ');
    SQL.Add('                 and n_albaran_sc = n_albaran_fd  ');
    SQL.Add('                 and fecha_sc = fecha_albaran_fd  ');
    SQL.Add('                 and empresa_sl = empresa_sc      ');
    SQL.Add('                 and centro_salida_sl = centro_salida_sc ');
    SQL.Add('      	          and n_albaran_sl = n_albaran_sc  ');
    SQL.Add('                 and fecha_sl = fecha_sc   ');
    SQL.Add('                 and producto_sl = cod_producto_fd ');
    SQL.Add('                 and envase_sl =  cod_envase_fd ');
    SQL.Add('                 and es_transito_sc <> 2) kilos2, ');

    SQL.Add('             (select nvl(sum(n_palets_sl), 0)  ');
    SQL.Add('      	  from frf_salidas_c, frf_salidas_l  ');
    SQL.Add('      	 where empresa_sc = cod_empresa_albaran_fd ');
    SQL.Add('                 and centro_salida_sc = cod_centro_albaran_fd ');
    SQL.Add('                 and n_albaran_sc = n_albaran_fd  ');
    SQL.Add('                 and fecha_sc = fecha_albaran_fd  ');
    SQL.Add('                 and empresa_sl = empresa_sc      ');
    SQL.Add('                 and centro_salida_sl = centro_salida_sc ');
    SQL.Add('      	          and n_albaran_sl = n_albaran_sc  ');
    SQL.Add('                 and fecha_sl = fecha_sc   ');
    SQL.Add('                 and producto_sl = cod_producto_fd ');
    SQL.Add('                 and envase_sl =  cod_envase_fd ');
    SQL.Add('                 and es_transito_sc <> 2) palets, ');

    SQL.Add('        sum( nvl(cajas_fd,0) ) cajas, sum( nvl(unidades_fd,0) ) unidades, sum( nvl(kilos_fd,0) ) kilos, ');
    SQL.Add('        sum( euros( moneda_fc, fecha_factura_fc, importe_neto_fd ) ) importe_antes_impuestos, ');

    SQL.Add('        ( select sum(euros( moneda_fc, fecha_factura_fc, importe_neto_fg)) ');
    SQL.Add('          from tfacturas_gas ');
    SQL.Add('          where cod_factura_fg = cod_factura_fd ');
    SQL.Add('            and cod_empresa_albaran_fg = cod_empresa_albaran_fd ');
    SQL.Add('            and cod_centro_albaran_fg = cod_centro_albaran_fd ');
    SQL.Add('            and n_albaran_fg = n_albaran_fd ');
    SQL.Add('            and fecha_albaran_fg =  fecha_albaran_fd ) gasto_antes_impuestos, ');

    SQL.Add('        sum( euros( moneda_fc, fecha_factura_fc, importe_total_fd) ) importe_total, ');
    SQL.Add('        ( select sum(euros( moneda_fc, fecha_factura_fc, importe_total_fg)) ');
    SQL.Add('          from tfacturas_gas ');
    SQL.Add('          where cod_factura_fg = cod_factura_fd ');
    SQL.Add('            and cod_empresa_albaran_fg = cod_empresa_albaran_fd ');
    SQL.Add('            and cod_centro_albaran_fg = cod_centro_albaran_fd ');
    SQL.Add('            and n_albaran_fg = n_albaran_fd ');
    SQL.Add('            and fecha_albaran_fg = fecha_albaran_fd ) gasto_total, ');

    SQL.Add('        ( select sum(kilos_sl) ');
    SQL.Add('          from frf_salidas_l ');
    SQL.Add('          where empresa_sl = cod_empresa_albaran_fd ');
    SQL.Add('            and centro_salida_sl = cod_centro_albaran_fd ');
    SQL.Add('            and n_albaran_sl = n_albaran_fd ');
    SQL.Add('            and fecha_sl = fecha_albaran_fd ) kilos_albaran ');

    SQL.Add(' from tfacturas_det ');
    SQL.Add('      join tfacturas_cab on cod_factura_fd = cod_factura_fc ');
    SQL.Add(' where anulacion_fc = 0 ');
    if sEmpresa = 'SAT' then
      SQL.Add('       and (cod_empresa_albaran_fd = ''050'' or cod_empresa_albaran_fd = ''080'' ) ')
    else
    if sEmpresa = 'BAG' then
      SQL.Add('       and cod_empresa_albaran_fd[1,1] = ''F'' ')
    else
      SQL.Add('       and cod_empresa_albaran_fd = :empresa ');
    if sSerie <> '' then
      SQL.Add('       and cod_serie_fac_fc = :serie ');
    if sCentro <> '' then
      SQL.Add('       and cod_centro_albaran_fd = :centro ');
    if sProducto <> '' then
      SQL.Add('       and cod_producto_fd = :producto ');
    if sCliente <> '' then
      SQL.Add('       and cod_cliente_albaran_fd = :cliente ');

    if cbbTipoFecha.ItemIndex = 0 then        //Fecha Albaran
      SQL.Add('     and fecha_albaran_fd between :fechaini and  :fechafin ')
    else                                     //Fecha Factura
      SQL.Add('     and fecha_factura_fc between :fechaini and  :fechafin ');

    SQL.Add(' group by empresa, centro, fecha_albaran, n_albaran, codigox3, nacional, manual, cod_factura, fecha_factura, cod_cliente, des_cliente, cod_pais, pais, ');
    SQL.Add('          cod_producto, des_producto, cod_envase, des_envase, cajas2, unidades2, kilos2, palets, gasto_antes_impuestos, gasto_total, kilos_albaran ');

    //COMERSAT
    //PENDIENTE DE FACTURAR
    SQL.Add(' union ');
    SQL.Add(' select empresa_sc empresa, centro_salida_sc centro, fecha_sc fecha_albaran, n_albaran_sc n_albaran, ');
    SQL.Add('        (select cta_cliente_c from frf_clientes where cliente_c = cliente_sal_sc) codigox3, ');
    SQL.Add('        (select  case when pais_c = ''ES'' then ''ES'' else ''EX'' end from frf_clientes where cliente_c = cliente_sal_sc) nacional, ');
    SQL.Add('        '''' manual, ');
    SQL.Add('        '''' cod_factura, TODAY fecha_factura, ');
    SQL.Add('       cliente_fac_Sc cod_cliente, ');
    SQL.Add('        (select nombre_c from frf_clientes where cliente_sal_sc = cliente_c ) des_cliente, ');
    SQL.Add('        (select pais_c from frf_clientes where cliente_sal_sc = cliente_c ) cod_pais, ');
    SQL.Add('        (select descripcion_p from  frf_clientes, frf_paises where cliente_sal_sc = cliente_c and pais_c = pais_p ) pais, ');
    SQL.Add('        producto_sl cod_producto, ( select descripcion_p from frf_productos where producto_p =  producto_sl  ) des_producto, ');
    SQL.Add('        envase_sl cod_envase, ');
    SQL.Add('       (select max(descripcion_e) from frf_envases where envase_sl = envase_E ) des_envase, ');

    SQL.Add('        sum( cajas_sl ) cajas2, ');
    SQL.Add('        sum( cajas_sl ) unidades2, ');
    SQL.Add('        sum( kilos_sl ) kilos2, ');
    SQL.Add('        sum(n_palets_sl) palets, ');

    SQL.Add('        sum( cajas_sl ) cajas, ');
    SQL.Add('        sum( cajas_sl ) unidades, ');
    SQL.Add('        sum( kilos_sl ) kilos, ');

    SQL.Add('       sum( euros( moneda_sc, fecha_sc, round( importe_neto_sl * ');
    SQL.Add('                                                 ( 1 - ( ( GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 1) + ');
    SQL.Add('                                                           GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc) ) / 100 ) ), 2 ) ) ) importe_antes_impuestos, ');

    SQL.Add('       euros( moneda_sc, fecha_sc, nvl( ( select sum(importe_g) ');
    SQL.Add('              from frf_gastos, frf_tipo_gastos ');
    SQL.Add('              where empresa_sc = empresa_g and centro_salida_sc = centro_salida_g ');
    SQL.Add('                and n_albaran_sc = n_albaran_g and fecha_sc = fecha_g ');
    SQL.Add('                and tipo_tg = tipo_g and facturable_tg = ''S'' ), 0) ) gasto_antes_impuestos, ');

    SQL.Add('       sum( round( ( 1 + porc_iva_sl/100 ) * ');
    SQL.Add('            euros( moneda_sc, fecha_sc, round( importe_neto_sl * ');
    SQL.Add('                                                 ( 1 - ( ( GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 1) + ');
    SQL.Add('                                                           GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc) ) / 100 ) ), 2 ) ), 2) ) importe_antes_impuestos, ');

    SQL.Add('       euros( moneda_sc, fecha_sc, nvl( ( select sum(importe_g) ');
    SQL.Add('              from frf_gastos, frf_tipo_gastos ');
    SQL.Add('              where empresa_sc = empresa_g and centro_salida_sc = centro_salida_g ');
    SQL.Add('                and n_albaran_sc = n_albaran_g and fecha_sc = fecha_g ');
    SQL.Add('                and tipo_tg = tipo_g and facturable_tg = ''S'' ), 0) ) gasto_total, ');

    SQL.Add('       ( select sum(kilos_sl) from frf_salidas_l sal ');
    SQL.Add('         where empresa_sc = sal.empresa_sl and centro_salida_sc = sal.centro_salida_sl ');
    SQL.Add('           and n_albaran_sc = sal.n_albaran_sl and fecha_sc = sal.fecha_sl ) kilos_albaran ');

    SQL.Add(' from frf_salidas_c join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sL ');
    SQL.Add('                                       and n_albaran_sc = n_albaran_sl and  fecha_sc = fecha_sl ');
    SQL.Add(' where fecha_sc between :fechaini and  :fechafin ');
    SQL.Add('   and fecha_factura_sc is null ');

    if sEmpresa = 'SAT' then
      SQL.Add('     and ( empresa_sc = ''050'' or empresa_sc = ''080'' ) ')
    else
    if sEmpresa = 'BAG' then
      SQL.Add('     and empresa_sc[1,1] = ''F'' ')
    else
      SQL.Add('       and empresa_sc = :empresa ');
    if sCentro <> '' then
      SQL.Add('       and centro_salida_sc = :centro ');
    if sProducto <> '' then
      SQL.Add('       and producto_sl = :producto ');

    if sCliente <> '' then
    begin
      SQL.Add('     and cliente_sal_sc = :cliente ');
    end
    else
    begin
      if sEmpresa = 'SAT' then
      begin
        SQL.Add('     and cliente_sal_sc <> ''REP'' ');
      end
      else
      begin
        SQL.Add('     and cliente_sal_sc <> ''BAA'' ');
        SQL.Add('     and cliente_sal_sc <> ''GAN'' ');
      end;
      SQL.Add(' and cliente_sal_sc <> ''RET'' and cliente_sal_sc <> ''REA'' and cliente_sal_sc[1,1] <> ''0'' and cliente_sal_sc <> ''EG'' ');
    end;

    SQL.Add(' and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion

    SQL.Add(' group by  empresa, centro, fecha_albaran, n_albaran, codigox3, nacional, manual, cod_factura, fecha_factura, cod_cliente, des_cliente, cod_pais, pais, ');
    SQL.Add('        cod_producto, des_producto,  cod_envase, des_envase, gasto_antes_impuestos, gasto_total, kilos_albaran ');

    SQL.Add(' order by  empresa, centro, fecha_albaran, n_albaran ');
  end;

  with DMAuxDB.QAux do
  begin
    if ( sEmpresa <> 'BAG' ) and  ( sEmpresa <> 'SAT' ) then
      ParamByName('empresa').AsString:= sEmpresa;
    if sSerie <> '' then
      ParamByName('serie').AsString:= sSerie;
    if sCentro <> '' then
      ParamByName('centro').AsString:= sCentro;
    if sCliente <> '' then
      ParamByName('cliente').AsString:= sCliente;
    if sProducto <> '' then
      ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsDateTime:= dIni;
    ParamByName('fechafin').AsDateTime:= dFin;

    Open;
    try
      if IsEmpty then
      begin
        ShowMessage('Sin datos para los parametros seleccionados.');
      end
      else
      begin
        PrevisualizarInforme;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TFDVentasPeriodo.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if ValidarParametros then
    ObtenerDatos;
end;

procedure TFDVentasPeriodo.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFDVentasPeriodo.FormCreate(Sender: TObject);
var
  dFecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  ESerie.Tag := kSerie;
  ECentro.Tag := kCentro;
  eCliente.Tag := kCliente;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

  ECentro.Text := '';
  EProducto.Text:= '';
  ESerie.Text := '';

  dFecha:= LunesAnterior( Date ) - 7;
  MEDesde.Text:= DateToStr( dFEcha );
  MEHasta.Text:= DateToStr( dFEcha + 6 );

  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    EEmpresa.Text := 'BAG'
  else
    EEmpresa.Text := 'SAT';
  ESerie.Text := '';
end;

procedure TFDVentasPeriodo.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDVentasPeriodo.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kSerie: DespliegaRejilla(BGBSerie);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFDVentasPeriodo.EEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  ECentroChange( ECentro );
  EClienteChange( ECliente );
  EProductoChange( EProducto );
end;

procedure TFDVentasPeriodo.EProductoChange(Sender: TObject);
begin
  if EProducto.Text <> '' then
    STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text)
  else
    STProducto.Caption := 'TODOS LOS PRODUCTOS';
end;

procedure TFDVentasPeriodo.ECentroChange(Sender: TObject);
begin
  if ECentro.Text <> '' then
    stCentro.Caption := desCentro( Eempresa.Text, ECentro.Text )
  else
    stCentro.Caption := 'TODOS LOS CENTROS';

end;

procedure TFDVentasPeriodo.eClienteChange(Sender: TObject);
begin
  if eCliente.Text <> '' then
    stCliente.Caption := desCliente( eCliente.Text )
  else
    stCliente.Caption := 'TODOS LOS CLIENTES';
end;

end.
