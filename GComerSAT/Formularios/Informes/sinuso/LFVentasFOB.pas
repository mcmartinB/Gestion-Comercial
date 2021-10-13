unit LFVentasFOB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables;

type
  TFLVentasFOB = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GBEmpresa: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    BGBEmpresa: TBGridButton;
    BGBProducto: TBGridButton;
    EProducto: TBEdit;
    EEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STProducto: TStaticText;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    QTemporal: TQuery;
    TTemporal: TTable;
    QKilosAlbaran: TQuery;
    Categoria: TEdit;
    lblCategoria: TLabel;
    QLVentasFOB: TQuery;
    QGastosAlbaran: TQuery;
    Label3: TLabel;
    ECentroDesde: TBEdit;
    ECentroHasta: TBEdit;
    Label4: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label8: TLabel;
    EDesde: TBEdit;
    EHasta: TBEdit;
    cbTipoCliente: TComboBox;
    RGTipoListado: TRadioGroup;
    cbxNacionalidad: TComboBox;
    ePais: TBEdit;
    btnPais: TBGridButton;
    cbTipoCentro: TComboBox;
    lblNombre2: TLabel;
    lblNombre1: TLabel;
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
    function CamposVacios: boolean;
    procedure cbxNacionalidadChange(Sender: TObject);

    {Private declarations}
  private
    nomTabla: string;
    rFactorFob: real;
    nom_tabla: string;
    sTipoCliente: string;
    sProductos: string;

    procedure CrearTemporal;
    procedure CrearQuerys;
    function  AbrirQuerys: boolean;
    procedure RecorrerQuerys;
    procedure Imprimir;
    procedure CerrarDatos;
    function  RepartirGastos: real;

    procedure ListadoTotales;
    procedure ListadoAlbaranes;
    procedure ImprimirTotal;
    procedure RecorrerQuerysTotal;
    procedure RellenarTemporal(cliente: string; albaran: integer; fecha: TDate; kil: real; ventas, gasto, total: real);

    //***********************************************************************
    //Listado Semanal
    //***********************************************************************
    procedure ListadoSemanal;
    procedure CrearTabla;
    function  InsertarDatos: Bool;
    procedure SacaKilosTotales;
    procedure AnyadeGastos;
    procedure AplicaCambio;
    procedure AgruparPorSemana;
    procedure Previsualiza;
    procedure Limpieza;
    //***********************************************************************
    //***********************************************************************

    procedure PutListaDeProductos( var VProductos: string );
    function  GetListaDeProductos: string;

  public
    { Public declarations }
    empresa, centro, producto, factura: string;
    rangoCentros: Boolean;
  end;

var
  Autorizado: boolean;

implementation

uses Principal, CVariables, CAuxiliarDB, CReportes, UDMConfig,
  LVentasFOB, LVentasFOB_tot, LVentasFOBSemanal, UDMAuxDB, DPreview,
  UDMBaseDatos, bTimeUtils, bSQLUtils, UDMCambioMoneda;

{$R *.DFM}

//                         ****  BOTONES  ****


function TFLVentasFOB.GetListaDeProductos: string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_sl ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = ' + QuotedStr( EEmpresa.Text ) + ' ');
    SQL.Add(' and fecha_sl between ' + QuotedStr( MEDesde.Text ) + ' and ' + QuotedStr( MEHasta.Text ) + ' ');
    if cbTipoCentro.ItemIndex = 1 then
      SQL.Add(' and centro_salida_sc between ' + QuotedStr( ECentroDesde.Text ) + ' and ' + QuotedStr( ECentroHasta.Text ) + ' ');
    if cbTipoCentro.ItemIndex = 0 then
      SQL.Add(' and cliente_sal_sc between ' + QuotedStr( EDesde.Text ) + ' and ' + QuotedStr( EHasta.Text ) + ' ')
    else
      SQL.Add(' and cliente_fac_sc between ' + QuotedStr( EDesde.Text ) + ' and ' + QuotedStr( EHasta.Text ) + ' ');


    SQL.Add(' and empresa_sl = ' + QuotedStr( EEmpresa.Text ) + ' ');
    SQL.Add(' and centro_salida_sl = centro_salida_sc ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl =  n_albaran_sc ');
    if cbTipoCentro.ItemIndex = 0 then
      SQL.Add(' and centro_origen_sl between ' + QuotedStr( ECentroDesde.Text ) + ' and ' + QuotedStr( ECentroHasta.Text ) + ' ');
    if trim( Categoria.Text ) <> '' then
      SQL.Add(' and categoria_sl = ' + QuotedStr( Categoria.Text ) + ' ');

    SQL.Add(' group by producto_sl ');

    Open;
    if IsEmpty then
    begin
      result:= '';
    end
    else
    begin
      result:= '';
      while not Eof do
      begin
        result:= result +  FieldByname('producto_sl').AsString;
        Next;
      end;
    end;
    Close;
  end;
end;

procedure TFLVentasFOB.PutListaDeProductos( var VProductos: string );
begin
  if EProducto.Text = '' then
  begin
    VProductos := GetListaDeProductos;
  end
  else
  begin
    VProductos := EProducto.Text;
  end;
end;

procedure TFLVentasFOB.BBAceptarClick(Sender: TObject);
begin
  if cbTipoCliente.ItemIndex = 0 then
  begin
    sTipoCliente := 'cliente_sal_sc';
  end
  else
  begin
    sTipoCliente := 'cliente_fac_sc';
  end;

  if not CerrarForm(true) then
    Exit;
  Self.ActiveControl := nil;
  if CamposVacios then
    Exit;

  empresa := STEmpresa.Caption;
  centro := desCentro(EEmpresa.Text, ECentroDesde.Text);
  producto := STproducto.Caption;

  PutListaDeProductos( sProductos );
  if sProductos = '' then
  begin
    ShowMessage( 'Listado sin datos.');
  end
  else
  begin
    CrearQuerys;
    case RGTipoListado.ItemIndex of
      0: ListadoTotales;
      1: ListadoAlbaranes;
      2: ListadoSemanal;
    end;
  end;
end;

procedure TFLVentasFOB.CrearQuerys;
begin
  with QKilosAlbaran do
  begin
    if Prepared then
      UnPrepare;
    SQL.Clear;
    SQL.Add(' SELECT sum(case when ( producto_sl = :producto ) then kilos_sl else 0 end) kilos_producto, ');
    if cbTipoCentro.ItemIndex = 0 then
    begin
      SQL.Add('        sum(case when ( producto_sl = :producto AND centro_origen_sl between :centroini and :centrofin ) and ref_transitos_sl is not null then kilos_sl else 0 end) kilos_producto_transito, ');
    end
    else
    begin
      SQL.Add('        sum(case when ( producto_sl = :producto ) and ref_transitos_sl is not null then kilos_sl else 0 end) kilos_producto_transito, ');
    end;
    SQL.Add('        sum(case when ref_transitos_sl is not null then kilos_sl else 0 end) kilos_transito, ');
    SQL.Add('        SUM(kilos_sl) kilos_total ');
    SQL.Add(' FROM frf_salidas_l ');
    SQL.Add(' WHERE empresa_sl =:empresa ');
    SQL.Add(' AND centro_salida_sl = :centro ');
    SQL.Add(' AND n_albaran_sl = :albaran ');
    SQL.Add(' AND fecha_sl = :fecha ');
    Prepare;
  end;

  with QGastosAlbaran do
  begin
    if Prepared then
      UnPrepare;
    SQL.Clear;
    SQL.Add(' SELECT case when producto_g is null then 1 else 0 end general, ');
    SQL.Add('        case when gasto_transito_tg = 1 then 1 else 0 end transito, ');
    SQL.Add('        SUM(importe_g*CASE WHEN facturable_tg= ''S'' THEN -1 ELSE 1 END) gastos ');
    SQL.Add(' FROM  frf_gastos, frf_tipo_gastos ');
    SQL.Add(' WHERE empresa_g = :empresa ');
    SQL.Add(' AND   centro_salida_g = :centro ');
    SQL.Add(' AND   n_albaran_g = :albaran ');
    SQL.Add(' AND   fecha_g = :fecha ');
    SQL.Add(' AND   tipo_tg = tipo_g ');
    SQL.Add(' AND   ( producto_g is null or producto_g = :producto ) ');
    (*PEPE*)
    //SQL.Add(' AND   facturable_tg = ''S'' ');
    SQL.Add(' AND   (descontar_fob_tg = ''S'' OR  facturable_tg = ''S'' ) ');
    SQL.Add(' group by 1, 2 ');
    Prepare;
  end;
end;

procedure TFLVentasFOB.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLVentasFOB.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  MEDesde.Text := DateTostr(Date-6);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;

  EDesde.Text := '0';
  EHasta.Text := 'ZZZ';
  EEmpresa.Tag := kEmpresa;
  ECentroDesde.Tag := kCentro;
  ECentroHasta.Tag := kCentro;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;
  ePais.Tag := kPais;
  ePais.Text := 'ES';

  eEmpresa.Text:= gsDefEmpresa;
  eProducto.Text:= '';//gsDefProducto;
  PonNombre( eProducto );
  eCentroDesde.Text:= gsDefCentro;
  eCentroHasta.Text:= gsDefCentro;


  CrearTemporal;
end;

procedure TFLVentasFOB.FormActivate(Sender: TObject);
begin
  Top := 1;
    //Hoja de ayuda
  ActiveControl := EEmpresa;
end;

procedure TFLVentasFOB.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLVentasFOB.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TTemporal.Close;
  BorrarTemporal( nom_tabla );
  CerrarDatos;
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');

     //Liberamos memoria
  Action := caFree;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLVentasFOB.MEHastaExit(Sender: TObject);
begin
  if BCBHasta.calendar.Visible then Exit;
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLVentasFOB.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kPais: DespliegaRejilla(btnPais, []);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLVentasFOB.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
    kProducto:
    begin
      if Trim( Eproducto.Text ) = '' then
      begin
        STProducto.Caption := 'VACIO TODOS LOS PRODUCTOS';
      end
      else
      begin
        STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
      end;
    end;
  end;
end;

function TFLVentasFOB.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if STEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto.');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if STProducto.Caption = '' then
  begin
    ShowError('El código del producto es incorrecto.');
    EProducto.SetFocus;
    Result := True;
    Exit;
  end;

  if ECentroDesde.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    ECentroDesde.SetFocus;
    Result := True;
    Exit;
  end
  else
  begin
    if Trim(ECentroHasta.Text) = '' then
    begin
      ECentroHasta.Text := ECentroDesde.Text;
      rangoCentros := False;
    end
    else
      if ECentroHasta.Text = ECentroDesde.Text then
        rangoCentros := False
      else
        rangoCentros := True;
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

  if MEDesde.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    MEDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if MEHasta.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    MEHasta.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;

procedure TFLVentasFOB.CrearTemporal;
begin
  (*TODO-20060526*)
  (*Pasar a tablas en memoria*)
  nom_tabla := gsCodigo + '_ventas_fob';
  TTemporal.TableName := nom_tabla;
  with QTemporal do
  begin
    Close;
    SQL.Clear;
    SQL.Add('CREATE TEMP TABLE ' + nom_tabla + ' (');
    SQL.Add(' cliente_tvf CHAR(3),');
    SQL.Add(' albaran_tvf INTEGER, ');
    SQL.Add(' fecha_tvf DATE, ');
    SQL.Add(' kilos_tvf DECIMAL(12,2),');
    SQL.Add(' importe_venta_tvf DECIMAL(12,2),');
    SQL.Add(' gastos_tvf DECIMAL (12,2),');
    SQl.Add(' neto_tvf DECIMAL (12,2))');
    try
      ExecSQL;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        raise;
      end;
    end;
  end;
  TTemporal.Open;
end;

function TFLVentasFOB.AbrirQuerys: boolean;
begin
    //pasar los parametros y abrir querys
  with QLVentasFOB do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT empresa_sc, ' + sTipoCliente);

    if EProducto.Text = '' then
      SQL.Add(', ' + QuotedStr('T') + ' producto_sl,')
    else
      SQL.Add(', producto_sl,');

    SQL.Add(' n_albaran_sc,moneda_sc, fecha_sc, centro_salida_sc, SUM(kilos_sl)kilos, ' +

      ' SUM(  Round( NVL(importe_neto_sl,0)* '+
      '      (1-(GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100))* '+
      '      (1-(GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 2 )/100)), 2) ) neto '+

      ' FROM frf_salidas_c, frf_salidas_l, frf_clientes, ' +
      '      OUTER frf_representantes  ' +
      ' WHERE empresa_sc = :empresa ');
    if cbTipoCentro.ItemIndex = 0 then
      SQL.Add(' AND   centro_origen_sl between :centroDesde and :centroHasta ')
    else
      SQL.Add(' AND   centro_salida_sc between :centroDesde and :centroHasta ');
    SQL.Add(' AND producto_sl MATCHES ' + QuotedStr('[' + sProductos + ']'));

    case cbxNacionalidad.ItemIndex of
      1: SQL.Add(' and pais_c = "ES" ');
      2: SQL.Add(' and pais_c <> "ES" ');
      3: SQL.Add(' and pais_c = "' + ePais.Text + '" ');
    end;
    SQL.Add(' AND   ' + sTipoCliente + ' BETWEEN :cliente_d AND :cliente_h ');

    (*PEPE*)
    SQL.Add('  AND   fecha_sc BETWEEN :fecha_d AND :fecha_h ' +
    //SQL.Add('  AND   fecha_factura_sc BETWEEN :fecha_d AND :fecha_h ' +
      ' AND   ' + sTipoCliente + ' <> ' + QuotedStr('RET') +
      ' AND   ' + sTipoCliente + ' <> ' + QuotedStr('REA') +
      ' AND   ' + sTipoCliente + ' <> ' + QuotedStr('EG') +
      ' AND   ' + sTipoCliente + ' <> ' + QuotedStr('0BO'));
    //if ( Trim(EProducto.Text) <> 'P' ) or ( Trim(EProducto.Text) <> 'B' )then
    if Trim( EEmpresa.Text ) = '050' then
      SQL.Add(' AND   (length(categoria_sl) = 1 or (length(categoria_sl) = 2 and categoria_sl not matches "?[A-Z]")) ');
    if trim(Categoria.Text) <> '' then
      SQL.Add(' AND   (categoria_sl = ' + QuotedStr(Trim(Categoria.text)) + ')');
    SQL.Add(' AND   empresa_sc = empresa_sl ' +
      ' AND   centro_salida_sc = centro_salida_sl ' +
      ' AND   n_albaran_sc = n_albaran_sl ' +
      ' AND   fecha_sc = fecha_sl ' +
                  //RELACION SALIDAS - CLIENTES ********************************
      ' AND   empresa_c = empresa_sc ' + //*
      ' AND   cliente_c = cliente_fac_sc ' + //*
      ' AND   empresa_r = empresa_c ' + //*
      ' AND   representante_r = representante_c ' //*
                  //************************************************************
      );

          //Solamente lineas valoradas
    (*PEPE*)
    //SQL.Add(' and fecha_factura_sc is not null ');
    SQL.Add(' and ( NVL( precio_sl, 0) <> 0  ');
    SQL.Add(' or fecha_factura_sc is not null ) ');
  
    (*ATENCION
      Teresa 2005.04.25 Para sacar un listado especifico
    SQL.Add(' AND   ' + sTipoCliente + ' IN (''DW'',''KF'',''MER'',''TS'',''UL'') ');
    *)



    SQL.Add(' GROUP BY empresa_sc, ' + sTipoCliente + ', n_albaran_sc, fecha_sc, ' +
      ' 3, moneda_sc, centro_salida_sc ' +
      ' ORDER BY empresa_sc, ' + sTipoCliente + ', n_albaran_sc, fecha_sc, ' +
      ' producto_sl, moneda_sc ');

    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('centroDesde').AsString := ECentroDesde.Text;
    ParamByName('centroHasta').AsString := ECentroHasta.Text;
          //ParamByName('producto').AsString:=EProducto.Text;
    ParamByName('fecha_d').AsDate := StrToDate(MEDesde.Text);
    ParamByName('fecha_h').AsDate := StrToDate(MEHasta.Text);
    ParamByName('cliente_d').AsString := EDesde.Text;
    ParamByName('cliente_h').AsString := EHasta.Text;

    try
      Open;
    except
      on E: EDBEngineError do
      begin
        Result := False;
        ShowError('Error al abrir la consulta principal');
        Exit;
      end;
    end;
    if RecordCount < 1 then
    begin
      Result := False;
      ShowError('No existen datos para los parametros introducidos');
      Exit;
    end;
    Result := True;
  end;
end;

procedure TFLVentasFOB.RecorrerQuerys;
var gastos, netos, importe, gastos_aux: real;
  kilos: real;
  cli, moneda: string;
begin
     //En este procedimiento al ir recorriendo las 2 querys se restan los
     //gastos en caso de haberlos, se cambia la moneda en caso de que no sean
     //euros y se guarda en una temporal, con la que luego se sacara el informe

  kilos := 0;
  netos := 0;
  gastos := 0;
  importe := 0;
  gastos_aux := 0;

  begin
    QLVentasFOB.First;
    cli := QLVentasFOB.FieldByName(sTipoCliente).AsString;
    moneda := QLVentasFOB.FieldByName('moneda_sc').AsString;
    while not QLVentasFOB.Eof do
    begin
      if cli <> QLVentasFOB.FieldByName(sTipoCliente).AsString then
      begin
             //se rellena la tabla temporal
        importe := importe + (netos - gastos);
        RellenarTemporal(cli, 0, date, kilos, netos, gastos, importe);
        kilos := 0;
        netos := 0;
        gastos := 0;
        importe := 0;
        cli := QLVentasFOB.FieldByName(sTipoCliente).AsString;
      end
      else
      begin
            //acumular
        kilos := kilos + QLVentasFOB.FieldByName('kilos').AsFloat;
            //hay que realizar el cambio de la moneda antes de la suma
            {cotiza:= BuscaFactorConversion(QLVentasFOB.FieldByName('moneda_sc').AsString,
                                           QLVentasFOB.FieldByName('fecha_sc').AsString);
            }
        rFactorFob := FactorCambioFOB(QLVentasFOB.FieldByName('empresa_sc').AsString,
          QLVentasFOB.FieldByName('centro_salida_sc').AsString,
          QLVentasFOB.FieldByName('fecha_sc').AsString,
          QLVentasFOB.FieldByName('n_albaran_sc').AsString,
          QLVentasFOB.FieldByName('moneda_sc').AsString);

        netos := netos + (QLVentasFOB.FieldByName('neto').AsFloat * rFactorFob);
            //************************
            //Comprobar que los gastos del albaran son todos sobre este producto
            //Hacer un try por si acaso la consulta de los gastos produce un error
            //************************
        try
          gastos_aux := RepartirGastos;
        except
          exit;
        end;
        if gastos_aux <> 0 then
        begin
          gastos := gastos + (gastos_aux * rFactorFob);
        end;
        QLVentasFOB.Next;
      end;
    end;
        //Se graba el ultimo cliente
    importe := importe + (netos - gastos);
    RellenarTemporal(cli, 0, date, kilos, netos, gastos, importe);
  end;
end;

procedure TFLVentasFOB.Imprimir;
begin
  //Llamamos al QReport
  QRLVentasFOB := TQRLVentasFOB.Create(Application);
  try
    PonLogoGrupoBonnysa(QRLVentasFOB, EEmpresa.Text);
    with QRLVentasFOB do
    begin
      sEmpresa := empresa;
      sCodEmpresa:= EEmpresa.Text;
      if rangoCentros then
        LCentro.Caption := 'CENTROS DESDE ' + ECentroDesde.Text + ' HASTA ' +
          ECentroHasta.Text
      else
        LCentro.Caption := ECentroDesde.Text + ' ' + centro;
      LProducto.Caption := sProductos + ' ' + producto;
      LPeriodo.Caption := MEDesde.Text + ' a ' + MEHasta.Text;

      if Categoria.Text <> '' then
      begin
        case StrToInt(Categoria.Text) of
          1: LCategoria.Caption := 'CATEGORÍA: PRIMERA';
          2: LCategoria.Caption := 'CATEGORÍA: SEGUNDA';
          3: LCategoria.Caption := 'CATEGORÍA: TERCERA';
        else LCategoria.Caption := 'CATEGORÍA: ' + Trim(Categoria.Text);
        end;
      end
      else
      begin
        LCategoria.Caption := 'CATEGORÍA: TODAS';
      end;
    end;


    with DMBaseDatos.QListado do
    begin
      SQL.Clear;
      SQL.Add('select * from ' + nom_tabla + ' order by cliente_tvf, fecha_tvf, albaran_tvf ');
      Open;
    end;

    Preview(QRLVentasFOB);
  finally

    DMBaseDatos.QListado.Close;
    with DMBaseDatos.QListado do
    begin
      SQL.Clear;
      SQL.Add('delete from ' + nom_tabla );
      ExecSQL;
    end;
  end;
end;

procedure TFLVentasFOB.CerrarDatos;
begin
    //Se cerraran todas los datasets que se utilicen en el formulario
  try
    QLVentasFOB.Close;
    DMBaseDatos.DBBaseDatos.CloseDataSets;
  except
    on E: EDBEngineError do
    begin
      ShowError(e);
      raise;
    end;
  end;
end;

//Comprobar si existe sólo un tipo de producto, si existen mas de un producto en
//las lineas, repartir el gasto
function TFLVentasFOB.RepartirGastos: real;
var
  kilos_producto, kilos_producto_transito, kilos_transito, kilos_total: real;
  gastog_todos, gastog_transitos, gastop_todos, gastop_transito: real;
begin
  if EProducto.Text = '' then
  begin
    with DMBaseDatos.QGeneral do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT SUM(importe_g*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END) gastos' +
            ' FROM frf_gastos, frf_tipo_gastos' +
            ' WHERE empresa_g = ' + QuotedStr(EEmpresa.Text) +
            ' AND   centro_salida_g = ' + QuotedStr(QLVentasFOB.FieldByName('centro_salida_sc').AsString) +
            ' AND   n_albaran_g = ' + QLVentasFOB.FieldByName('n_albaran_sc').AsString +
            ' AND   fecha_g = ' + SQLDate(QLVentasFOB.FieldByName('fecha_sc').AsString) +
            ' AND   tipo_tg = tipo_g ' );
            (*PEPE*)
            //' AND facturable_tg="S" ');
      Open;
      Result := FieldByName('gastos').AsFloat;
    end;
  end
  else
  begin
    with QKilosAlbaran do
    begin
      Close;
      ParamByName('empresa').AsString := EEmpresa.Text;
      ParamByName('centro').AsString := QLVentasFOB.FieldByName('centro_salida_sc').AsString;
      ParamByName('albaran').AsInteger := QLVentasFOB.FieldByName('n_albaran_sc').AsInteger;
      ParamByName('fecha').AsDate := QLVentasFOB.FieldByName('fecha_sc').AsDateTime;
      ParamByName('producto').AsString := EProducto.Text;
      if cbTipoCentro.ItemIndex = 0 then
      begin
        ParamByName('centroini').AsString := ECentroDesde.Text;
        ParamByName('centrofin').AsString := ECentroHasta.Text;
      end;
      try
        Open;
        kilos_producto:= QLVentasFOB.FieldByName('kilos').AsFloat;//FieldByName('kilos_producto').AsFloat;
        kilos_producto_transito:= FieldByName('kilos_producto_transito').AsFloat;
        kilos_transito:= FieldByName('kilos_transito').AsFloat;
        kilos_total:= FieldByName('kilos_total').AsFloat;
        Close;
      except
        on E: EDBEngineError do
        begin
          Close;
          ShowError('Error en la consulta de gastos');
          raise;
        end;
      end;
    end;

    with QGastosAlbaran do
    begin
      Close;
      ParamByName('empresa').AsString := EEmpresa.Text;
      ParamByName('centro').AsString := QLVentasFOB.FieldByName('centro_salida_sc').AsString;
      ParamByName('albaran').AsInteger := QLVentasFOB.FieldByName('n_albaran_sc').AsInteger;
      ParamByName('fecha').AsDate := QLVentasFOB.FieldByName('fecha_sc').AsDateTime;
      ParamByName('producto').AsString := EProducto.Text;
      try
        Open;
        gastog_todos:= 0;
        gastog_transitos:= 0;
        gastop_todos:= 0;
        gastop_transito:= 0;
        while not eof do
        begin
          if FieldByName('general').AsInteger = 1 then
          begin
            if FieldByName('transito').AsInteger = 1 then
            begin
              gastog_transitos:= FieldByName('gastos').AsFloat;
            end
            else
            begin
              gastog_todos:= FieldByName('gastos').AsFloat;
            end;
          end
          else
          begin
            if FieldByName('transito').AsInteger = 1 then
            begin
              gastop_transito:= FieldByName('gastos').AsFloat;
            end
            else
            begin
              gastop_todos:= FieldByName('gastos').AsFloat;
            end;
          end;
          Next;
        end;
        Close;
      except
        on E: EDBEngineError do
        begin
          Close;
          ShowError('Error en la consulta de gastos');
          raise;
        end;
      end;
    end;

    Result := gastop_todos;
    if kilos_total <> 0 then
    begin
      Result := Result + ( gastog_todos * kilos_producto ) / kilos_total;
    end;
    if kilos_transito <> 0 then
    begin
      Result := Result + ( gastog_transitos * kilos_producto_transito ) / kilos_transito;
    end;
    if kilos_producto_transito <> 0 then
    begin
      //Result := Result + ( gastop_transito * kilos_producto ) / kilos_producto_transito;
      Result := Result + gastop_transito;
    end;
  end;
end;

procedure TFLVentasFOB.ListadoTotales;
begin
  if not AbrirQuerys then Exit;
  RecorrerQuerys;
  Imprimir;
end;

procedure TFLVentasFOB.ListadoAlbaranes;
begin
  if not AbrirQuerys then Exit;
  RecorrerQuerysTotal;
  ImprimirTotal;
end;

procedure TFLVentasFOB.RecorrerQuerysTotal;
var gastos, netos, importe, gastos_aux: real;
  kilos: Real;
  albaran, i: integer;
  fecha: TDate;
  cli: string;
begin
     //En este procedimiento al ir recorriendo las 2 querys se restan los
     //gastos en caso de haberlos, se cambia la moneda en caso de que no sean
     //euros y se guarda en una temporal, con la que luego se sacara el informe
  gastos_aux := 0;

  begin
    QLVentasFOB.First;
    for i := 0 to QLVentasFOB.RecordCount - 1 do
    begin
            //hay que realizar el cambio de la moneda
            {cotiza:= BuscaFactorConversion(QLVentasFOB.FieldByName('moneda_sc').AsString,
                                           QLVentasFOB.FieldByName('fecha_sc').AsString);
            }
      rFactorFob := FactorCambioFOB(QLVentasFOB.FieldByName('empresa_sc').AsString,
        QLVentasFOB.FieldByName('centro_salida_sc').AsString,
        QLVentasFOB.FieldByName('fecha_sc').AsString,
        QLVentasFOB.FieldByName('n_albaran_sc').AsString,
        QLVentasFOB.FieldByName('moneda_sc').AsString);

            //************************
            //Comprobar que los gastos del albaran son todos sobre este producto
            //Hacer un try por si acaso la consulta de los gastos produce un error
            //***********************
      try
        gastos_aux := RepartirGastos;
      except
        exit;
      end;
      gastos := 0;
      if gastos_aux <> 0 then
      begin
                //gastos:=gastos + (gastos_aux/cotiza);
        gastos := (gastos_aux * rFactorFob);
      end;

      cli := QLVentasFOB.FieldByName(sTipoCliente).AsString;
      albaran := QLVentasFOB.FieldByName('n_albaran_sc').AsInteger;
      fecha := QLVentasFOB.FieldByName('fecha_sc').AsDateTime;
      kilos := QLVentasFOB.FieldByName('kilos').AsFloat;
      netos := (QLVentasFOB.FieldByName('neto').AsFloat * rFactorFob);
      importe := (netos - gastos);

            //se rellena la tabla temporal
      RellenarTemporal(cli, albaran, fecha, kilos, netos, gastos, importe);
      QLVentasFOB.Next;
    end;
  end;
end;

procedure TFLVentasFOB.RellenarTemporal(cliente: string; albaran: integer; fecha: TDate; kil: real; ventas, gasto, total: real);
begin
  try
    TTemporal.InsertRecord([cliente, albaran, fecha, kil, ventas, gasto, total]);
  except
    on E: EDBEngineError do
    begin
      ShowError('Error al insertar registro en la tabla temporal');
      raise;
    end;
  end;
end;

procedure TFLVentasFOB.ImprimirTotal;
begin
  //Llamamos al QReport
  QRLVentasFOB_tot := TQRLVentasFOB_tot.Create(Application);
  try
    PonLogoGrupoBonnysa(QRLVentasFOB_tot, EEmpresa.Text);
    with QRLVentasFOB_tot do
    begin
      sEmpresa := empresa;
      sCodEmpresa := EEmpresa.Text;
      if rangoCentros then
        LCentro.Caption := 'CENTROS DESDE ' + ECentroDesde.Text + ' HASTA ' +
          ECentroHasta.Text
      else
        LCentro.Caption := ECentroDesde.Text + ' ' + centro;
      LProducto.Caption := sProductos + ' ' + producto;
      LPeriodo.Caption := MEDesde.Text + ' a ' + MEHasta.Text;

      if Categoria.Text <> '' then
      begin
        case StrToInt(Categoria.Text) of
          1: LCategoria.Caption := 'CATEGORÍA: PRIMERA';
          2: LCategoria.Caption := 'CATEGORÍA: SEGUNDA';
          3: LCategoria.Caption := 'CATEGORÍA: TERCERA';
        else LCategoria.Caption := 'CATEGORÍA: ' + Trim(Categoria.Text);
        end;
      end
      else
      begin
        LCategoria.Caption := 'CATEGORÍA: TODAS';
      end;
    end;

    with DMBaseDatos.QListado do
    begin
      SQL.Clear;
      SQL.Add('select * from ' + nom_tabla + ' order by cliente_tvf, fecha_tvf, albaran_tvf ');
      Open;
    end;

    Preview(QRLVentasFOB_tot);
  finally

    DMBaseDatos.QListado.Close;
    with DMBaseDatos.QListado do
    begin
      SQL.Clear;
      SQL.Add('delete from ' + nom_tabla );
      ExecSQL;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// LISTADO POR SEMANAS (Inicio)
////////////////////////////////////////////////////////////////////////////////

procedure TFLVentasFOB.ListadoSemanal;
begin
  try
    CrearTabla;
    if InsertarDatos then
    begin
      SacaKilosTotales;
      AnyadeGastos;
      //************************************************************************
      // Aqui tenemos una tabla temporal con los siguientes campos(tmp_aux1)
      // cliente,albaran,centro,fecha,anyo,semana,moneda,
      // kilos_pro --> kilos de la seleccion, sin categorias con letra
      // kilos_tot --> kilos totales de los albaranes
      // neto --> sumatorio importe neto de las Lines de las salidas
      // gasto_nor --> sumatorio de todos los gastos asociados que no sean de transito
      // gasto_tra --> sumatorio gastos de transito (<>0 sólo si centro=6 producto=E)
      // gasto_tot --> porcion de gasto que le corresponde
      //               gasto_tot=((gasto_nor*kilos_pro)/kilos_tot)+gasto_tra
      //************************************************************************
      AplicaCambio;
      AgruparPorSemana;
      Previsualiza;
    end
    else
    begin
      MessageDlg('No se realizaron ventas que concuerden con los datos de entrada.', mtInformation, [mbOK], 0);
    end;
  finally
    Limpieza;
  end;
end;

procedure TFLVentasFOB.CrearTabla;
var
  aux: string;
begin
  nomTabla := gsCodigo + '_fob_semal';

 //Primero creamos la tabla temporal
  aux := 'CREATE TEMP TABLE ' + nomTabla + ' (' +
    ' cliente_fm CHAR(3),' +
    ' anyo_fm CHAR(4),' +
    ' semana_fm INTEGER,' +
    ' kilos_fm DECIMAL(12,2),' +
    ' importe_venta_fm DECIMAL(12,2),' +
    ' gastos_fm DECIMAL (12,2))';

  ConsultaExec(aux);
end;

function TFLVentasFOB.InsertarDatos: Bool;
begin
  with DMBaseDatos.QListado do
  begin
    //Ahora añadimos los datos sobre los que vamos a trabajar
    SQL.Clear;

    SQL.Add(' SELECT ' + sTipoCliente + ' cliente, n_albaran_sc albaran, ');

    SQL.Add('          centro_salida_sc centro, fecha_sc fecha, ' +
      '         substr(YEARANDWEEK(fecha_sc),1,4) anyo, 0 semana, moneda_sc moneda, ' +
      '         SUM(kilos_sl) kilos_pro, ' +

      ' SUM(  Round( NVL(importe_neto_sl,0)* '+
      '      (1-(GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100))* '+
      '      (1-(GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 2 )/100)), 2) ) neto '+



      ' FROM frf_salidas_c, frf_salidas_l, frf_clientes, OUTER frf_representantes ' +
      ' WHERE empresa_sc = :empresa ');
    if cbTipoCentro.ItemIndex = 0 then
      SQL.Add(' AND   centro_origen_sl between :centroDesde and :centroHasta ')
    else
      SQL.Add(' AND   centro_salida_sc between :centroDesde and :centroHasta ');
    SQL.Add(' AND producto_sl MATCHES ' + QuotedStr('[' + sProductos + ']'));

    case cbxNacionalidad.ItemIndex of
      1: SQL.Add(' and pais_c = "ES" ');
      2: SQL.Add(' and pais_c <> "ES" ');
      3: SQL.Add(' and pais_c = "' + ePais.Text + '" ');
    end;
    SQL.Add(' AND   ' + sTipoCliente + ' BETWEEN :cliente_d AND :cliente_h ');

    SQL.Add('  AND   fecha_sc BETWEEN :fecha_d AND :fecha_h ');

    if Trim( EEmpresa.Text ) = '050' then
    //if Trim(EProducto.Text) <> 'P' then
    begin
      SQL.Add(' AND   (length(categoria_sl) = 1 or (length(categoria_sl) = 2 ' +
        ' and categoria_sl not matches "?[A-Z]")) ');
    end;
    if trim(Categoria.Text) <> '' then
    begin
      SQL.Add(' AND   (categoria_sl = ' + QuotedStr(Trim(Categoria.text)) + ')');
    end;

    //Solamente lineas valoradas
    SQL.Add(' and ( NVL( precio_sl, 0) <> 0  ');
    SQL.Add(' or fecha_factura_sc is not null ) ');

    SQL.Add(' AND   empresa_sc = empresa_sl ' +
      ' AND   centro_salida_sc = centro_salida_sl ' +
      ' AND   n_albaran_sc = n_albaran_sl ' +
      ' AND   fecha_sc = fecha_sl ' +
      ' AND   empresa_c = empresa_sc ' +
      ' AND   cliente_c = cliente_fac_sc ' +
      ' AND   empresa_r = empresa_c ' +
      ' AND   representante_r = representante_c ');

    if Trim(Categoria.Text) <> '' then
      SQL.Add(' AND categoria_sl = ' + QuotedStr(Categoria.Text) + ' ');

    SQL.Add(' GROUP BY ' + sTipoCliente + ', centro_salida_sc, n_albaran_sc, fecha_sc, moneda_sc ');
    SQL.Add(' ORDER BY ' + sTipoCliente + ', centro_salida_sc, n_albaran_sc, fecha_sc, moneda_sc ');

    SQL.Add('  INTO TEMP tmp_aux1 ');

    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('centroDesde').AsString := ECentroDesde.Text;
    ParamByName('centroHasta').AsString := ECentroHasta.Text;
          //ParamByName('producto').AsString:=sProductos;
    ParamByName('fecha_d').AsDate := StrToDate(MEDesde.Text);
    ParamByName('fecha_h').AsDate := StrToDate(MEHasta.Text);
    ParamByName('cliente_d').AsString := EDesde.Text;
    ParamByName('cliente_h').AsString := EHasta.Text;

    if ConsultaExec(DMBaseDatos.QListado) >= 1 then
      InsertarDatos := true
    else
      InsertarDatos := false;
  end;
end;

procedure TFLVentasFOB.SacaKilosTotales;
begin
  with DMBaseDatos.QListado do
  begin
    //Cuantos kilos totales de producto tienen los albaranes seleccionados
    SQL.Clear;
    SQL.Add(' SELECT  tmp_aux1.*, SUM(kilos_sl) kilos_tot, ');

    if EProducto.Text = '' then
    begin
      SQL.Add('       SUM(CASE WHEN ref_transitos_sl is not null THEN kilos_sl ELSE 0 END) kilost_pro, ');
    end
    else
    begin
      if cbTipoCentro.ItemIndex = 0 then
        SQL.Add('        sum(case when ( producto_sl = ' + QuotedStr( EProducto.Text ) + ' AND centro_origen_sl between ' + QuotedStr( ECentroDesde.Text ) + ' and ' + QuotedStr( ECentroHasta.Text ) + ' ) and ref_transitos_sl is not null then kilos_sl else 0 end) kilost_pro, ')
      else
        SQL.Add('        sum(case when ( producto_sl = ' + QuotedStr( EProducto.Text ) + ' ) and ref_transitos_sl is not null then kilos_sl else 0 end) kilost_pro, ');
    end;
    SQL.Add('       SUM(CASE WHEN ref_transitos_sl is not null THEN kilos_sl ELSE 0 END) kilost_tot ');


    SQL.Add('  FROM  frf_salidas_l,tmp_aux1 ' +
      ' WHERE empresa_sl = :empresa ' +
      ' AND   centro_salida_sl = centro ' +
      ' AND   n_albaran_sl = albaran ' +
      ' AND   fecha_sl = fecha ' +

      ' GROUP BY cliente, centro, albaran, fecha, anyo, semana, moneda, kilos_pro, neto ' +
      ' ORDER BY cliente, centro, albaran, fecha  ' +
      ' INTO TEMP tmp_aux2 ');
    ParamByName('empresa').AsString := EEmpresa.Text;

    ConsultaExec(DMBaseDatos.QListado);

  end;
  BorrarTemporal('tmp_aux1');
end;

procedure TFLVentasFOB.AnyadeGastos;
begin
  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    //SQL.Add(' SELECT  tmp_aux2.*,SUM(importe_g*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END) gasto_nor ' +

    SQL.Add(' SELECT  tmp_aux2.*, ');
    SQL.Add('     sum( case when producto_g is null and gasto_transito_tg = 0 then ');
    SQL.Add('                   importe_g*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END ');
    SQL.Add('               else 0 ');
    SQL.Add('          end ) gastog_todos, ');
    SQL.Add('          sum( case when producto_g is not null and gasto_transito_tg = 0 then ');
    SQL.Add('                   importe_g*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END ');
    SQL.Add('               else 0 ');
    SQL.Add('          end ) gastog_producto, ');
    SQL.Add('          sum( case when producto_g is null and gasto_transito_tg = 1 then ');
    SQL.Add('                   importe_g*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END ');
    SQL.Add('               else 0 ');
    SQL.Add('          end ) gastot_todos, ');
    SQL.Add('          sum( case when producto_g is not null and gasto_transito_tg = 1 then ');
    SQL.Add('                   importe_g*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END ');
    SQL.Add('               else 0 ');
    SQL.Add('          end ) gastot_producto ');

    SQL.Add(' FROM  tmp_aux2,OUTER ( frf_gastos,frf_tipo_gastos )' +
      ' WHERE empresa_g = :empresa ' +
      ' AND   centro_salida_g = centro ' +
      ' AND   n_albaran_g = albaran ' +
      ' AND   fecha_g = fecha ' +
      ' and   tipo_g=tipo_tg ' +
      ' and   (descontar_fob_tg ="S"  OR  facturable_tg = "S") ');

    if EProducto.Text <> '' then
    begin
      SQL.Add('       and ( producto_g = ' + QuotedStr( Eproducto.Text ) + ' or producto_g is null ) ');
    end;

    SQL.Add(' GROUP BY cliente, centro, albaran, fecha, anyo, semana, moneda, neto,' +
      '          kilos_tot, kilos_pro, kilost_tot, kilost_pro ' +
      ' INTO TEMP tmp_aux3 ');

    ParamByName('empresa').AsString := EEmpresa.Text;
    ConsultaExec(DMBaseDatos.QListado);
    BorrarTemporal('tmp_aux2');

  end;

  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    SQL.Add(' Update tmp_aux3 set gastot_todos = ( kilos_pro * gastot_todos ) / kilost_tot ');
    SQL.Add(' where kilost_tot <> 0 ');
    ConsultaExec(DMBaseDatos.QListado);
  end;

  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    SQL.Add(' Update tmp_aux3 set gastot_producto = 0 ');
    SQL.Add(' where kilost_pro = 0 ');
    ConsultaExec(DMBaseDatos.QListado);
  end;

  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    SQL.Add(' select cliente, centro, albaran, fecha, anyo, semana, moneda, neto, kilos_pro, kilos_tot, ');
    SQL.Add('           ((gastog_todos * kilos_pro) / kilos_tot) + gastog_producto gasto_nor, ');
    SQL.Add('           gastot_todos + gastot_producto gasto_tra, ');
    SQL.Add('           ((gastog_todos * kilos_pro) / kilos_tot) + gastog_producto + gastot_todos + gastot_producto gasto_tot ');
    SQL.Add(' from tmp_aux3 ');
    SQL.Add(' INTO TEMP tmp_aux1 ');
    ConsultaExec(DMBaseDatos.QListado);
    BorrarTemporal('tmp_aux3');
  end;
end;


procedure TFLVentasFOB.AplicaCambio;
begin
  //Aplicamos el cambio del dia en las tablas
  ConsultaOpen(DMBaseDatos.QListado,
    ' select unique centro,fecha,albaran, moneda from tmp_aux1 order by fecha,moneda ');
  ConsultaPrepara(QTemporal, ' UPDATE tmp_aux1 set (neto,gasto_tot)=' +
    '        (ROUND(neto * :cambio,2),ROUND(gasto_tot * :cambio,2))' +
    ' WHERE moneda=:moneda and fecha=:fecha ' +
    ' and centro= :centro and albaran= :albaran ', False);

  with DMBaseDatos.QListado do
  begin
    First;
    //if QTemporal.Active then
    while not eof do
    begin
      QTemporal.ParamByName('fecha').asDateTime := FieldByName('fecha').AsDateTime;
      QTemporal.ParamByName('moneda').AsString := FieldByName('moneda').AsString;
      QTemporal.ParamByName('centro').AsString := FieldByName('centro').AsString;
      QTemporal.ParamByName('albaran').AsString := FieldByName('albaran').AsString;
      {QTemporal.ParamByName('cambio').AsFloat:=
                           BuscaFactorConversion(FieldByName('moneda').AsString,
                                                 FieldByName('fecha').AsString);
      }
      rFactorFob := FactorCambioFOB(EEmpresa.Text,
        FieldByName('centro').AsString,
        FieldByName('fecha').AsString,
        FieldByName('albaran').AsString,
        FieldByName('moneda').AsString);
      QTemporal.ParamByName('cambio').AsFloat := rFactorFob;
      ConsultaExec(QTemporal);
      Next;
    end;
    Cancel;
    Close;
  end;
end;

procedure TFLVentasFOB.AgruparPorSemana;
begin
  ConsultaOpen(DMBaseDatos.QListado,
    ' SELECT unique fecha FROM tmp_aux1 order by fecha ');
  ConsultaPrepara(QTemporal, ' update tmp_aux1 set semana=:semana' +
    ' where fecha=:fecha');

  with DMBaseDatos.QListado do
  begin
    First;
    while not Eof do
    begin
      QTemporal.ParamByName('semana').AsInteger := Semana(FieldByName('fecha').asdatetime);
      QTemporal.ParamByName('fecha').AsDateTime := FieldByName('fecha').asdatetime;
      ConsultaExec(QTemporal);
      Next;
    end;
    Cancel;
    Close;
  end;

  ConsultaExec(' INSERT INTO ' + nomTabla +
    ' SELECT cliente, anyo ,semana,SUM(kilos_pro),SUM(neto),SUM(gasto_tot) ' +
    ' FROM tmp_aux1 GROUP BY cliente,anyo, semana ');
  BorrarTemporal('tmp_aux1');
end;

procedure TFLVentasFOB.Previsualiza;
begin
  //Vamos a ver el listado
  QRLVentasFOBSemanal := TQRLVentasFOBSemanal.Create(Application);
  try
    ConsultaOpen(QRLVentasFOBSemanal.QListado,
      'Select * from ' + nomTabla + ' ORDER BY cliente_fm,anyo_fm,semana_fm');

    PonLogoGrupoBonnysa(QRLVentasFOBSemanal, EEmpresa.Text);
    with QRLVentasFOBSemanal do
    begin
      sEmpresa := empresa;
      if rangoCentros then
        LCentro.Caption := 'CENTROS DESDE ' + ECentroDesde.Text + ' HASTA ' +
          ECentroHasta.Text
      else
        LCentro.Caption := ECentroDesde.Text + ' ' + centro;
      LProducto.Caption := sProductos + ' ' + producto;
      LPeriodo.Caption := MEDesde.Text + ' a ' + MEHasta.Text;

      if Categoria.Text <> '' then
      begin
        case StrToInt(Categoria.Text) of
          1: LCategoria.Caption := 'CATEGORÍA: PRIMERA';
          2: LCategoria.Caption := 'CATEGORÍA: SEGUNDA';
          3: LCategoria.Caption := 'CATEGORÍA: TERCERA';
        else LCategoria.Caption := 'CATEGORÍA: ' + Trim(Categoria.Text);
        end;
      end
      else
      begin
        LCategoria.Caption := 'CATEGORÍA: TODAS';
      end;

    end;
    Preview(QRLVentasFOBSemanal);
  finally
    //QRLVentasFOBSemanal.QListado.Cancel;
    //QRLVentasFOBSemanal.QListado.Close;
    //QRLVentasFOBSemanal.Free;
    //Application.ProcessMessages;
  end;
end;

procedure TFLVentasFOB.Limpieza;
begin
  BorrarTemporal(nomTabla);
  BorrarTemporal('tmp_aux1');
  BorrarTemporal('tmp_aux2');
end;


////////////////////////////////////////////////////////////////////////////////
// LISTADO POR SEMANAS (Fin)
////////////////////////////////////////////////////////////////////////////////

procedure TFLVentasFOB.cbxNacionalidadChange(Sender: TObject);
begin
  ePais.Enabled := TComboBox(sender).ItemIndex = 3;
  btnPais.Enabled := ePais.Enabled;
end;

end.
