unit LFComprobacionGastos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DBtables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Derror, Grids,
  DBGrids, BGrid, CheckLst;

type
  TFLComprobacionGastos = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    QLCompGastosTransitos: TQuery;
    QLCompGastosTransporte: TQuery;
    QLCompGastosAduana: TQuery;
    QLCompGastosTransitos2: TQuery;
    mmoDescripcion: TMemo;
    Label3: TLabel;
    eEmpresa: TBEdit;
    STEmpresa: TStaticText;
    clbGastosTransito: TCheckListBox;
    cbxSeleccion: TComboBox;
    Label1: TLabel;
    EDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    EHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    cbxTipoTransito: TComboBox;
    QLCompGastosEntregas: TQuery;
    Label4: TLabel;
    eCliente: TBEdit;
    STCliente: TStaticText;
    QLCompGastosSalidas: TQuery;
    QLCompGastosEntregasTransportes: TQuery;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure EHastaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure eEmpresaChange(Sender: TObject);
    procedure cbxSeleccionChange(Sender: TObject);
    procedure eClienteChange(Sender: TObject);

  private
    {private declarations}
    function  ConsultaGastosTransito: boolean;
    function  ConsultaGastosSalidas: boolean;
    function  ConsultaGastosTransporte: boolean;
    function  ConsultaGastosAduana: boolean;
    function  ConsultaGastosTransito2: boolean;
    function  ConsultaGastosEntregas: boolean;
    function  ConsultaGastosEntregasTransportes: boolean;

    function  ConfiguraGastosTransitos: boolean;
    function  ConfiguraGastosTransitos2: boolean;
    function  ConfiguraGastosSalidas: boolean;
    procedure ConfiguraGastosTransporte;
    function  ConfiguraGastosEntregas: boolean;
    procedure ConfiguraGastosEntregasTransporte;

    procedure DescripcionMemo(const AOpcion: Integer);
    function  ParametrosCorrectos(const AOpcion: Integer): boolean;
    procedure VerTiposDeGastos(const AOpcion: Integer);
    function  TipoDeGastos( var ATipos: string ): integer;

  public
    { Public declarations }
  end;

implementation

uses Principal, CVariables, CAuxiliarDB, CReportes,
  LComprobacionGastos, DPreview, UDMAuxDB, QuickRpt;

{$R *.DFM}

//                          **** FORMULARIO ****

function TFLComprobacionGastos.TipoDeGastos( var ATipos: string ): integer;
var
  i, cont: integer;
begin
  ATipos:=  '';
  i:= 0;
  cont:= 0;
  while i < clbGastosTransito.Items.Count  do
  begin
    if clbGastosTransito.Checked[i] then
    begin
      if ATipos <> '' then
        ATipos:=  ATipos + ',''' + copy(clbGastosTransito.Items[i],1,3) + ''''
      else
        ATipos:=  '''' + copy(clbGastosTransito.Items[i],1,3) + '''';
      inc( cont );
    end;
    inc(i);
  end;

  result:= cont;
end;

function TFLComprobacionGastos.ConfiguraGastosTransitos: boolean;
var
  sAux: string;
  cont: integer;
begin
  cont:= TipoDeGastos( sAux );
  result:= sAux <> '';

  with QLCompGastosTransitos do
  begin
    SQL.Clear;
    SQL.Add(' SELECT DISTINCT ''X'' tipo, n_albaran_sl codigo, fecha_sl fecha ');
    SQL.Add(' FROM  frf_salidas_l ');
    SQL.Add(' WHERE empresa_sl = :empresa ');

    SQL.Add(' AND   ref_transitos_sl is not null ');
    SQL.Add(' AND   centro_salida_sl = :centroalbaran ');
    SQL.Add(' AND   fecha_sl BETWEEN :desde AND :hasta ');

    if Trim(eCliente.Text) <> '' then
      SQL.Add(' AND   cliente_sl = :cliente ');

    SQL.Add(' AND   ' + IntToStr( cont ) + ' <> ');
    SQL.Add('       ( SELECT count( DISTINCT tipo_g  ) FROM frf_gastos ');
    SQL.Add('       WHERE empresa_g = :empresa ');
    SQL.Add('       AND   centro_salida_g = centro_salida_sl ');
    SQL.Add('       AND   n_albaran_g = n_albaran_sl ');
    SQL.Add('       AND   fecha_g = fecha_sl ');
    SQL.Add('       AND   tipo_g IN (' + sAux + ' )) ');

    if ( cbxTipoTransito.ItemIndex = 0 ) or ( cbxTipoTransito.ItemIndex = 2 ) then
    begin
      SQL.Add('  AND exists ');
      SQL.Add('             ( ');
      SQL.Add('              select * ');
      SQL.Add('              from frf_transitos_l ');
      SQL.Add('              where empresa_tl = :empresa ');
      SQL.Add('                and centro_tl = :centrosalida ');
      case cbxTipoTransito.ItemIndex of
        0: SQL.Add('                and centro_destino_tl = :centrodestino ');
        2: SQL.Add('                and centro_destino_tl <> :centrodestino ');
      end;

      SQL.Add('                and centro_origen_tl = centro_origen_sl ');
      SQL.Add('                and referencia_tl = ref_transitos_sl ');
      SQL.Add('                and fecha_tl between :desdeplus and :hasta ');
      SQL.Add('             ) ');
    end;

    SQL.Add(' ORDER BY 1,2 ');

    ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('desde').AsDate := StrToDate(EDesde.Text);
    ParamByName('hasta').AsDate := StrToDate(EHasta.Text);
    if Trim(eCliente.Text) <> '' then
      ParamByName('cliente').AsString := eCliente.Text;
    case cbxTipoTransito.ItemIndex of
        0:
        begin
          ParamByName('centroalbaran').AsString := '1';
          ParamByName('centrosalida').AsString := '6';
          ParamByName('centrodestino').AsString := '1';
          ParamByName('desdeplus').AsDate := StrToDate(EDesde.Text)  - 30;
        end;
        1:
        begin
          ParamByName('centroalbaran').AsString := '6';
        end;
        2:
        begin
          ParamByName('centroalbaran').AsString := '1';
          ParamByName('centrosalida').AsString := '1';
          ParamByName('centrodestino').AsString := '6';
          ParamByName('desdeplus').AsDate := StrToDate(EDesde.Text)  - 30;
        end;
    end;
  end;
end;


function TFLComprobacionGastos.ConfiguraGastosTransitos2: boolean;
var
  sAux: string;
  cont: integer;
begin
  cont:= TipoDeGastos( sAux );
  result:= sAux <> '';

  with QLCompGastosTransitos2 do
  begin
    SQL.Clear;
    SQL.Add(' SELECT DISTINCT ''X'' tipo, referencia_tl codigo, fecha_tl fecha ');
    SQL.Add(' FROM  frf_transitos_l ');
    SQL.Add(' WHERE empresa_tl = :empresa ');

    SQL.Add(' AND   centro_tl = :centrosalida ');
    case cbxTipoTransito.ItemIndex of
      0,1: SQL.Add(' AND   centro_destino_tl = :centrodestino ');
      2: SQL.Add(' AND   centro_destino_tl <> :centrodestino ');
    end;

    SQL.Add(' AND   fecha_tl BETWEEN :desde AND :hasta ');
    SQL.Add(' AND   ' + IntToStr( cont ) + ' <> ');
    SQL.Add('       ( SELECT count( DISTINCT tipo_gt ) FROM frf_gastos_trans ');
    SQL.Add('       WHERE empresa_gt = :empresa ');
    SQL.Add('       AND   centro_gt = centro_tl ');
    SQL.Add('       AND   referencia_gt = referencia_tl ');
    SQL.Add('       AND   fecha_gt = fecha_tl ');
    SQL.Add('       AND   tipo_gt IN (' + sAux + ' )) ');
    SQL.Add(' ORDER BY 1,2 ');

    ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('desde').AsDate := StrToDate(EDesde.Text);
    ParamByName('hasta').AsDate := StrToDate(EHasta.Text);

    case cbxTipoTransito.ItemIndex of
      0:
      begin
        ParamByName('centrosalida').AsString := '6';
        ParamByName('centrodestino').AsString := '1';
      end;
      1, 2:
      begin
        ParamByName('centrosalida').AsString := '1';
        ParamByName('centrodestino').AsString := '6';
      end;
    end;
  end;
end;

function TFLComprobacionGastos.ConfiguraGastosSalidas: boolean;
var
  sAux: string;
  cont: integer;
begin
  cont:= TipoDeGastos( sAux );
  result:= sAux <> '';

  with QLCompGastosSalidas do
  begin
    SQL.Clear;
    SQL.Add(' SELECT DISTINCT ''X'' tipo, n_albaran_sl codigo, fecha_sl fecha ');
    SQL.Add(' FROM  frf_salidas_l ');
    SQL.Add(' WHERE empresa_sl = :empresa ');
    SQL.Add(' AND   fecha_sl BETWEEN :desde AND :hasta ');
    if Trim(eCliente.Text) <> '' then
      SQL.Add(' AND   cliente_sl = :cliente ');
    SQL.Add(' AND   ' + IntToStr( cont ) + ' <> ');
    SQL.Add('       ( SELECT count( DISTINCT tipo_g  ) FROM frf_gastos ');
    SQL.Add('       WHERE empresa_g = :empresa ');
    SQL.Add('       AND   centro_salida_g = centro_salida_sl ');
    SQL.Add('       AND   n_albaran_g = n_albaran_sl ');
    SQL.Add('       AND   fecha_g = fecha_sl ');
    SQL.Add('       AND   tipo_g IN (' + sAux + ' )) ');
    SQL.Add(' ORDER BY 1,2 ');

    ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('desde').AsDate := StrToDate(EDesde.Text);
    ParamByName('hasta').AsDate := StrToDate(EHasta.Text);
    if Trim(eCliente.Text) <> '' then
      ParamByName('cliente').AsString := eCliente.Text;
  end;
end;

procedure  TFLComprobacionGastos.ConfiguraGastosTransporte;
begin
  with QLCompGastosTransporte.SQL do
  begin
    Clear;
    if ( cbxTipoTransito.ItemIndex = 0 ) or ( cbxTipoTransito.ItemIndex = 1 ) then
    begin
      Add(' SELECT ''A'' tipo, n_albaran_sc codigo, fecha_sc fecha, transporte_sc transporte, ');
      Add('        cliente_fac_sc cliente, vehiculo_sc matricula, ');
      Add('        ( select sum(n_palets_sl) from frf_salidas_l ');
      Add('          where empresa_sl = :empresa and centro_salida_sl = centro_salida_sc ');
      Add('          and n_albaran_sl = n_albaran_sc and fecha_sl = fecha_sc ) palets  ');
      Add(' FROM  frf_salidas_c ');
      Add(' WHERE empresa_sc = :empresa ');
      Add(' AND   porte_bonny_sc = 1 ');
      Add(' AND   fecha_sc BETWEEN :desde AND :hasta ');
      Add(' AND   NOT EXISTS ( ');
      Add('       SELECT * FROM frf_gastos ');
      Add('       WHERE empresa_g = :empresa ');
      Add('       AND   centro_salida_g = centro_salida_sc ');
      Add('       AND   n_albaran_g = n_albaran_sc ');
      Add('       AND   fecha_g = fecha_sc ');
//      Add('       AND   tipo_g = ''009'') ');
      Add('       AND   tipo_g = ''001'') ');
    end;

    if ( cbxTipoTransito.ItemIndex = 0 )  then
    begin
      Add(' UNION ');
    end;

    if ( cbxTipoTransito.ItemIndex = 0 ) or ( cbxTipoTransito.ItemIndex = 2 ) then
    begin
(*
      Add(' SELECT ''B'' tipo, referencia_tc codigo, fecha_tc fecha, transporte_tc transporte, ');
      Add('        centro_destino_tc cliente, vehiculo_tc matricula ');
      Add(' FROM  frf_transitos_c, frf_centros ');
      Add(' WHERE empresa_tc = :empresa ');
      Add(' AND   porte_bonny_tc = 1 ');
      Add(' AND   fecha_tc BETWEEN :desde AND :hasta ');
      Add(' AND   empresa_c = :empresa ');
      Add(' AND   centro_c = centro_destino_tc ');
      Add(' AND   pais_c <> ''ES'' ');
      Add(' AND   NOT EXISTS ( ');
      Add('       SELECT * FROM frf_gastos_trans ');
      Add('       WHERE empresa_gt = :empresa ');
      Add('       AND   centro_gt = centro_tc ');
      Add('       AND   referencia_gt = referencia_tc ');
      Add('       AND   fecha_gt = fecha_tc ');
      Add('       AND   tipo_gt = ''009'') ');

      Add(' UNION ');
*)

      Add(' SELECT ''C'' tipo, referencia_tc codigo, fecha_tc fecha, transporte_tc transporte, ');
      Add('        centro_destino_tc cliente, vehiculo_tc matricula, ');
      Add('        ( select  sum(palets_tl) from frf_transitos_l ');
      Add('          where empresa_tl = :empresa and centro_tl = centro_tc ');
      Add('          and referencia_tl = referencia_tc and fecha_tl = fecha_tc ) palets');
      Add(' FROM  frf_transitos_c, frf_centros ');
      Add(' WHERE empresa_tc = :empresa ');
      Add(' AND   porte_bonny_tc = 1 ');
      Add(' AND   fecha_tc BETWEEN :desde AND :hasta ');
      Add(' AND   empresa_c = :empresa ');
      Add(' AND   centro_c = centro_destino_tc ');
      //Add(' AND   pais_c = ''ES'' ');
      Add(' AND   NOT EXISTS ( ');
      Add('       SELECT * FROM frf_gastos_trans ');
      Add('       WHERE empresa_gt = :empresa ');
      Add('       AND   centro_gt = centro_tc ');
      Add('       AND   referencia_gt = referencia_tc ');
      Add('       AND   fecha_gt = fecha_tc ');
//      Add('       AND   tipo_gt = ''011'') ');
      Add('       AND   tipo_gt = ''017'') ');
    end;

    Add(' ORDER BY 3, 4, 6, 1, 2 ');
  end;
end;

function  TFLComprobacionGastos.ConfiguraGastosEntregas: boolean;
var
  sAux: string;
  cont: integer;
begin
  cont:= TipoDeGastos( sAux );
  result:= sAux <> '';

  if cont > 0 then
  with QLCompGastosEntregas.SQL do
  begin
    Clear;
    Add(' SELECT ''A'' tipo, albaran_ec codigo, fecha_carga_ec fecha, transporte_ec transporte, ');
    Add(' proveedor_ec cliente, vehiculo_ec matricula ');
    Add(' FROM  frf_entregas_c ');
    Add(' WHERE empresa_ec = :empresa ');
    Add(' AND   fecha_carga_ec BETWEEN :desde AND :hasta ');
    Add(' AND   NOT EXISTS ( ');
    Add('                    SELECT * FROM frf_gastos_entregas ');
    Add('                    WHERE codigo_ge = codigo_ec ');
    Add('                    AND   tipo_ge IN (' + sAux + ' )) ');
    Add(' ORDER BY 3, 4, 6, 1, 2 ');
  end;
end;

procedure  TFLComprobacionGastos.ConfiguraGastosEntregasTransporte;
begin
  with QLCompGastosEntregasTransportes.SQL do
  begin
    Clear;
    Add(' SELECT ''A'' tipo, albaran_ec codigo, fecha_carga_ec fecha, transporte_ec transporte, ');
    Add(' proveedor_ec cliente, vehiculo_ec matricula ');
    Add(' FROM  frf_entregas_c ');
    Add(' WHERE empresa_ec = :empresa ');
    Add(' AND   portes_pagados_ec = 1 ');
    Add(' AND   fecha_carga_ec BETWEEN :desde AND :hasta ');
    Add(' AND   NOT EXISTS ( ');
    Add('                    SELECT * FROM frf_gastos_entregas ');
    Add('                    WHERE codigo_ge = codigo_ec ');
//    Add('                    AND   tipo_ge = ''111'') ');
    Add('                    AND   tipo_ge = ''062'') ');
    Add(' ORDER BY 3, 4, 6, 1, 2 ');
  end;
end;

procedure TFLComprobacionGastos.FormCreate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
  
  FormType := tfOther;
  BHFormulario;

  EDesde.Text := DateTostr(Date-7);
  EHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;

  eEmpresa.Text:= gsDefEmpresa;

  EDesde.Tag := kCalendar;
  EHasta.Tag := kCalendar;

  eEmpresa.Tag:= kEmpresa;

  gCF := calendarioFlotante;

  with QLCompGastosAduana.SQL do
  begin
    Clear;
    Add(' SELECT ''X'' tipo, n_albaran_sc codigo, fecha_sc fecha, cliente_sal_sc cliente, vehiculo_sc matricula ');
    Add(' FROM  frf_salidas_c ');
    Add(' WHERE empresa_sc = :empresa ');
    Add('   AND cliente_sal_sc IN ( select cliente_c ');
    Add('                           from frf_clientes ');
    Add('                           where es_comunitario_c = ''N'' ) ');
    Add(' AND   fecha_sc BETWEEN :desde AND :hasta ');
    Add(' AND   NOT EXISTS ( ');
    Add('       SELECT * FROM frf_gastos ');
    Add('       WHERE empresa_g = :empresa ');
    Add('       AND   centro_salida_g = centro_salida_sc ');
    Add('       AND   n_albaran_g = n_albaran_sc ');
    Add('       AND   fecha_g = fecha_sc ');
//    Add('       AND   tipo_g = ''010'') ');
    Add('       AND   tipo_g = ''002'') ');
    Add(' ORDER BY 3,2 ');
  end;

  VerTiposDeGastos( 0 );
  DescripcionMemo( 0 );

  //Width:= 540;
  //CheckListBox.Enabled:= False;
  //CheckListBox.Visible:= False;
end;

procedure TFLComprobacionGastos.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TFLComprobacionGastos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLComprobacionGastos.FormClose(Sender: TObject;
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

//                         ****  BOTONES  ****

procedure TFLComprobacionGastos.BBAceptarClick(Sender: TObject);
var
  bMostrarReport: boolean;
  sAux: string;
begin
  if not CerrarForm(true) then Exit;
  if not ParametrosCorrectos( cbxSeleccion.ItemIndex ) then Exit;
  bMostrarReport:= True;

  //Llamamos al QReport
  QRLComprobacionGastos := TQRLComprobacionGastos.Create(Application);
  try
    QRLComprobacionGastos.LPeriodo.Caption := EDesde.Text + ' a ' + EHasta.Text;
    case cbxSeleccion.ItemIndex of
      0: bMostrarReport:= ConsultaGastosTransito;
      1: bMostrarReport:= ConsultaGastosTransito2;
      2: bMostrarReport:= ConsultaGastosTransporte;
      3: bMostrarReport:= ConsultaGastosAduana;
      4: bMostrarReport:= ConsultaGastosSalidas;
      5: bMostrarReport:= ConsultaGastosEntregas;
      6: bMostrarReport:= ConsultaGastosEntregasTransportes;
    end;

    if bMostrarReport then
    begin
      PonLogoGrupoBonnysa(QRLComprobacionGastos, eEmpresa.Text );
      QRLComprobacionGastos.seleccion := cbxSeleccion.ItemIndex;
      case cbxSeleccion.ItemIndex of
        0,1,4,5:
        begin
          QRLComprobacionGastos.lblTipoTransito.Caption:= cbxTipoTransito.Items[cbxTipoTransito.ItemIndex];
          TipoDeGastos( sAux );
          QRLComprobacionGastos.lblTipoGastos.Caption:= 'Gastos Seleccionados: ' + sAux;
          QRLComprobacionGastos.lblCliente.Caption:= eCliente.Text + ' ' + stCliente.Caption;
          QRLComprobacionGastos.bndCabecera.Height:= 90;
        end;
        2,3,6:
        begin
          QRLComprobacionGastos.lblTipoTransito.Caption:= '';
          QRLComprobacionGastos.lblTipoGastos.Caption:= '';
          QRLComprobacionGastos.lblCliente.Caption:= '';
          QRLComprobacionGastos.bndCabecera.Height:= 70;
        end;
      end;

      Preview(QRLComprobacionGastos);
    end
    else
    begin
      FreeAndNil(QRLComprobacionGastos);
    end;
  except
    FreeAndNil(QRLComprobacionGastos);
    Raise;
  end;
end;

procedure TFLComprobacionGastos.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLComprobacionGastos.EHastaExit(Sender: TObject);
begin
  if StrToDate(EHasta.Text) < StrToDate(EDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    EDesde.SetFocus;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLComprobacionGastos.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCalendar:
      begin
        if EDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

//                     *** PROCEDIMIENTOS PRIVADOS ***

function TFLComprobacionGastos.ConsultaGastosTransito: boolean;
begin
  if not clbGastosTransito.Enabled then
  begin
    result:= False;
    ShowMessage('Sin gastos de tránsito. Utilice el mantenimiento de "Tipo de Gastos" para dar de alta algun gasto de tránsito.');
    Exit;
  end;


  QLCompGastosTransitos.Close;
  if not ConfiguraGastosTransitos then
  begin
    result:= False;
    ShowMessage('Por favor seleccione algun tipo de gasto de tránsito.');
    Exit;
  end;

  with QLCompGastosTransitos do
  begin
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        raise;
      end;
    end;
  end;

  if QLCompGastosTransitos.IsEmpty then
  begin
    ShowMessage('Todos los gastos grabados para los datos pasados.');
    QLCompGastosTransitos.Close;
    result:= False;
  end
  else
  with QRLComprobacionGastos do
  begin
    result:= True;
    Page.Columns := 4;
    DataSet := QLCompGastosTransitos;
    ReportTitle := 'Comprobación de gastos de tránsitos (Ref. Nº Albarán)';

    LTitulo.Caption := 'Comprobación de gastos de tránsitos (Ref. Nº Albarán)';
    LVariable.Enabled := False;
    LCliente.Enabled := False;
    LMatricula.Enabled := False;

    DBAlbaran.DataSet := DataSet;
    DBFecha.DataSet := DataSet;

    qrePalets.DataSet := Nil;
    qrePalets.Enabled:= False;
    qrlPalets.Enabled:= False;

    DBVariable.Visible := False;
    DBVariable.DataSet := nil;
    DBCliente.Visible := False;
    DBCliente.DataSet := nil;
    DBMatricula.Visible := False;
    DBMatricula.DataSet := nil;

  end;
end;

function TFLComprobacionGastos.ConsultaGastosSalidas: boolean;
begin
  if not clbGastosTransito.Enabled then
  begin
    result:= False;
    ShowMessage('Sin gastos de salidas. Utilice el mantenimiento de "Tipo de Gastos" para dar de alta algun gasto de salida.');
    Exit;
  end;


  QLCompGastosSalidas.Close;
  if not ConfiguraGastosSalidas then
  begin
    result:= False;
    ShowMessage('Por favor seleccione algun tipo de gasto de salida.');
    Exit;
  end;

  with QLCompGastosSalidas do
  begin
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        raise;
      end;
    end;
  end;

  if QLCompGastosSalidas.IsEmpty then
  begin
    ShowMessage('Todos los gastos grabados para los datos pasados.');
    QLCompGastosSalidas.Close;
    result:= False;
  end
  else
  with QRLComprobacionGastos
   do
  begin
    result:= True;
    Page.Columns := 4;
    DataSet := QLCompGastosSalidas;
    ReportTitle := 'Comprobación de gastos de salidas.';

    LTitulo.Caption := 'Comprobación de gastos de salidas.';
    LVariable.Enabled := False;
    LCliente.Enabled := False;
    LMatricula.Enabled := False;

    DBAlbaran.DataSet := DataSet;
    DBFecha.DataSet := DataSet;

    qrePalets.DataSet := Nil;
    qrePalets.Enabled:= False;
    qrlPalets.Enabled:= False;

    DBVariable.Visible := False;
    DBVariable.DataSet := nil;
    DBCliente.Visible := False;
    DBCliente.DataSet := nil;
    DBMatricula.Visible := False;
    DBMatricula.DataSet := nil;

  end;
end;

function TFLComprobacionGastos.ConsultaGastosTransporte: Boolean;
begin
  ConfiguraGastosTransporte;
  with QLCompGastosTransporte do
  begin
    Close;
    ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('desde').AsDate := StrToDate(EDesde.Text);
    ParamByName('hasta').AsDate := StrToDate(EHasta.Text);
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        raise;
      end;
    end;
  end;

  if QLCompGastosTransporte.IsEmpty then
  begin
    ShowMessage('Todos los gastos grabados para los datos pasados.');
    QLCompGastosTransporte.Close;
    result:= False;
  end
  else
  begin
    result:= True;
    with QRLComprobacionGastos do
    begin
      Page.Columns := 2;
      DataSet := QLCompGastosTransporte;
      ReportTitle := 'Comprobación de gastos de transporte';
          //Encabezados de las columnas

      LTitulo.Caption := 'Comprobación de gastos de transporte';
      LVariable.Caption := 'Trans.';
      LCliente.Caption := 'Cli.';

      //Campos de base de datos
      DBAlbaran.DataSet := DataSet;
      DBFecha.DataSet := DataSet;
      DBVariable.DataSet := DataSet;
      DBCliente.DataSet := DataSet;
      DBMatricula.DataSet := DataSet;

      qrePalets.DataSet := DataSet;
    end;
  end;
end;

function TFLComprobacionGastos.ConsultaGastosEntregas: Boolean;
begin
  if ConfiguraGastosEntregas then
  begin
    with QLCompGastosEntregas do
    begin
      Close;
      ParamByName('empresa').AsString := eEmpresa.Text;
      ParamByName('desde').AsDate := StrToDate(EDesde.Text);
      ParamByName('hasta').AsDate := StrToDate(EHasta.Text);
      try
        Open;
      except
        on E: EDBEngineError do
        begin
          ShowError(E);
          raise;
        end;
      end;
    end;

    if QLCompGastosEntregas.IsEmpty then
    begin
      ShowMessage('Todos los gastos grabados para los datos pasados.');
      QLCompGastosEntregas.Close;
      result:= False;
    end
    else
    begin
      result:= True;
      with QRLComprobacionGastos do
      begin
        Page.Columns := 2;
        DataSet := QLCompGastosEntregas;
        ReportTitle := 'Comprobación de gastos en entregas';
            //Encabezados de las columnas

        LTitulo.Caption := 'Comprobación de gastos en entregas';

        LVariable.Caption := 'Trans.';
        LCliente.Caption := 'Prov.';

            //Campos de base de datos
        DBAlbaran.DataSet := DataSet;
        DBFecha.DataSet := DataSet;
        DBVariable.DataSet := DataSet;
        DBCliente.DataSet := DataSet;
        DBMatricula.DataSet := DataSet;

        qrePalets.DataSet := Nil;
        qrePalets.Enabled:= False;
        qrlPalets.Enabled:= False;
      end;
    end;
  end
  else
  begin
    ShowMessage('Por favor, seleccione un gasto.');
    result:= False;
  end;
end;

function TFLComprobacionGastos.ConsultaGastosEntregasTransportes: Boolean;
begin
  ConfiguraGastosEntregasTransporte;
  with QLCompGastosEntregasTransportes do
  begin
    Close;
    ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('desde').AsDate := StrToDate(EDesde.Text);
    ParamByName('hasta').AsDate := StrToDate(EHasta.Text);
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        raise;
      end;
    end;
  end;

  if QLCompGastosEntregasTransportes.IsEmpty then
  begin
    ShowMessage('Todos los gastos grabados para los datos pasados.');
    QLCompGastosEntregasTransportes.Close;
    result:= False;
  end
  else
  begin
    result:= True;
    with QRLComprobacionGastos do
    begin
      Page.Columns := 2;
      DataSet := QLCompGastosEntregasTransportes;
      ReportTitle := 'Comprobación de gastos de transporte en entregas';
          //Encabezados de las columnas

      LTitulo.Caption := 'Comprobación de gastos de transporte en entregas';

      LVariable.Caption := 'Trans.';
      LCliente.Caption := 'Prov.';

          //Campos de base de datos
      DBAlbaran.DataSet := DataSet;
      DBFecha.DataSet := DataSet;
      DBVariable.DataSet := DataSet;
      DBCliente.DataSet := DataSet;
      DBMatricula.DataSet := DataSet;

      qrePalets.DataSet := Nil;
      qrePalets.Enabled:= False;
      qrlPalets.Enabled:= False;
    end;
  end;
end;

function TFLComprobacionGastos.ConsultaGastosAduana: boolean;
begin
  with QLCompGastosAduana do
  begin
    Close;
    ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('desde').AsDate := StrToDate(EDesde.Text);
    ParamByName('hasta').AsDate := StrToDate(EHasta.Text);
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        raise;
      end;
    end;
  end;

  if QLCompGastosAduana.IsEmpty then
  begin
    ShowMessage('Todos los gastos grabados para los datos pasados.');
    QLCompGastosAduana.Close;
    result:= False;
  end
  else
  with QRLComprobacionGastos do
  begin
    result:= True;
    Page.Columns := 2;
    DataSet := QLCompGastosAduana;
    ReportTitle := 'Comprobación de gastos de aduana';
          //Encabezados de las columnas
    LTitulo.Caption := 'Comprobación de gastos de aduana';
    LVariable.Enabled := False;
    LVariable.Visible := False;

    //Campos de base de datos
    DBAlbaran.DataSet := DataSet;
    DBFecha.DataSet := DataSet;
    DBCliente.DataSet := DataSet;
    DBMatricula.DataSet := DataSet;

    DBVariable.Visible := False;
    DBVariable.Enabled := False;

    qrePalets.DataSet := Nil;
    qrePalets.Enabled:= False;
    qrlPalets.Enabled:= False;    
  end;
end;

function TFLComprobacionGastos.ConsultaGastosTransito2: boolean;
begin
  if not clbGastosTransito.Enabled then
  begin
    result:= False;
    ShowMessage('Sin gastos de tránsito. Utilice el mantenimiento de "Tipo de Gastos" para dar de alta algun gasto de tránsito.');
    Exit;
  end;

  QLCompGastosTransitos2.Close;
  if not ConfiguraGastosTransitos2 then
  begin
    result:= False;
    ShowMessage('Por favor seleccione algun tipo de gasto de tránsito.');
    Exit;
  end;

  with QLCompGastosTransitos2 do
  begin
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        raise;
      end;
    end;
  end;

  if QLCompGastosTransitos2.IsEmpty then
  begin
    ShowMessage('Todos los gastos grabados para los datos pasados.');
    QLCompGastosTransitos2.Close;
    result:= False;
  end
  else
  with QRLComprobacionGastos do
  begin
    result:= True;
    Page.Columns := 4;
    DataSet := QLCompGastosTransitos2;
    ReportTitle := 'Comprobación de gastos de tránsitos (Ref. Nº Trásito)';
          //Encabezados de las columnas
    LTitulo.Caption := 'Comprobación de gastos de tránsitos (Ref. Nº Tránsito)';
    LVariable.Enabled := False;
    LCliente.Enabled := False;
    LMatricula.Enabled := False;
          //Campos de base de datos
    DBAlbaran.DataSet := DataSet;
    DBFecha.DataSet := DataSet;

    qrePalets.DataSet := Nil;
    qrePalets.Enabled:= False;
    qrlPalets.Enabled:= False;

    DBVariable.Visible := False;
    DBVariable.DataSet := nil;
    DBCliente.Visible := False;
    DBCliente.DataSet := nil;
    DBMatricula.Visible := False;
    DBMatricula.DataSet := nil;
  end;
end;

procedure TFLComprobacionGastos.DescripcionMemo(const AOpcion: Integer);
begin
  mmoDescripcion.Clear;
  case AOpcion of
    0:
      begin
        mmoDescripcion.Lines.Add('Tipo Gasto  = Todos los marcados como "Gasto de Tránsito" en el mantenimiento de Tipos de Gastos.');
        mmoDescripcion.Lines.Add('');
        mmoDescripcion.Lines.Add('Para todos los albaranes con centro salida distinto centro destino.');
      end;
    1:
      begin
        mmoDescripcion.Lines.Add('Tipo Gasto  = Todos los marcados como "Gasto de Tránsito" en el mantenimiento de Tipos de Gastos.');
        mmoDescripcion.Lines.Add('');
        mmoDescripcion.Lines.Add('Para todos los tránsitos.');
      end;
    2:
      begin
        mmoDescripcion.Lines.Add('Tipo Gasto = "001" Salidas y ');
        mmoDescripcion.Lines.Add('             "017" Tránsitos ');
        mmoDescripcion.Lines.Add('');
        mmoDescripcion.Lines.Add('Para todos los albaranes/tránsitos marcados como "Transporte Bonnysa".');
      end;
    3:
      begin
        mmoDescripcion.Lines.Add('Tipo Gasto  = "002"');
        mmoDescripcion.Lines.Add('');
        mmoDescripcion.Lines.Add('Para todos los clientes no comunitarios.');
      end;
    4:
      begin
        mmoDescripcion.Lines.Add('Tipo Gasto  = Todos los marcados como "Gasto de Salidas" en el mantenimiento de Tipos de Gastos.');
        mmoDescripcion.Lines.Add('');
        mmoDescripcion.Lines.Add('Para todas las salidas.');
      end;
    5:
      begin
        mmoDescripcion.Lines.Add('Tipo Gasto  = Todos los marcados como "Gasto de Entregas" en el mantenimiento de Tipos de Gastos.');
        mmoDescripcion.Lines.Add('');
        mmoDescripcion.Lines.Add('Para todas las entregas.');
      end;
    6:
      begin
        mmoDescripcion.Lines.Add('Tipo Gasto  = "062"');
        mmoDescripcion.Lines.Add('');
        mmoDescripcion.Lines.Add('Para todos las entregas marcadas con pago "Aduana".');
      end;
  end;
  mmoDescripcion.SelStart := 0;
  mmoDescripcion.SelLength := 0;
end;

function TFLComprobacionGastos.ParametrosCorrectos(const AOpcion: Integer): boolean;
var
  dIni, dFin: TDateTime;
begin
  result:= False;
  if Trim( eEmpresa.Text ) = '' then
  begin
    ShowMessage('El código de la empresa es de obligada inserción.');
    eEmpresa.SetFocus;
  end
  else
  if not TryStrToDate( EDesde.Text, dIni ) then
  begin
    ShowMessage('Fecha de incio incorrecta.');
    EDesde.SetFocus;
  end
  else
  if not TryStrToDate( EHasta.Text, dFin ) then
  begin
    ShowMessage('Fecha de fin incorrecta.');
    EHasta.SetFocus;
  end
  else
  if dIni > dFin then
  begin
    ShowMessage('Rango de fechas incorrecto.');
    EDesde.SetFocus;
  end
  else
  begin
    result:= true;
  end;
end;

procedure TFLComprobacionGastos.eEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(eEmpresa.Text);
end;

procedure TFLComprobacionGastos.eClienteChange(Sender: TObject);
begin
  STCliente.Caption := desCliente(eCliente.Text);
end;

procedure TFLComprobacionGastos.cbxSeleccionChange(Sender: TObject);
begin
  DescripcionMemo(cbxSeleccion.ItemIndex);

  eCliente.Enabled:= (cbxSeleccion.ItemIndex = 0) or (cbxSeleccion.ItemIndex = 4);

  clbGastosTransito.Enabled:= ( ( cbxSeleccion.ItemIndex = 0 ) or
                                ( cbxSeleccion.ItemIndex = 1 ) or
                                ( cbxSeleccion.ItemIndex = 4 ) or
                                ( cbxSeleccion.ItemIndex = 5 )) and
                              ( clbGastosTransito.Items.Count > 0 );
  cbxTipoTransito.Enabled:= ( ( cbxSeleccion.ItemIndex = 0 ) or
                              ( cbxSeleccion.ItemIndex = 1 ) or
                              ( cbxSeleccion.ItemIndex = 2 ) or
                              ( cbxSeleccion.ItemIndex = 3 )) ;
  if cbxTipoTransito.Enabled then
  begin
    if ( cbxSeleccion.ItemIndex = 0 ) or ( cbxSeleccion.ItemIndex = 1 ) then
    begin
      cbxTipoTransito.Items.Clear;
      cbxTipoTransito.Items.Add(' Tránsitos de Tenerife a la Peninsula. ');
      cbxTipoTransito.Items.Add(' Tránsitos de la Peninsula a Tenerife. ');
      cbxTipoTransito.Items.Add(' Tránsitos de la Peninsula a Europa (Alemania, Gran Bretaña). ');
      cbxTipoTransito.ItemIndex:= 0;
    end
    else
    begin
      cbxTipoTransito.Items.Clear;
      cbxTipoTransito.Items.Add(' Salidas y tránsitos. ');
      cbxTipoTransito.Items.Add(' Solo salidas. ');
      cbxTipoTransito.Items.Add(' Solo tránsitos. ');
      cbxTipoTransito.ItemIndex:= 0;
    end;
  end;

  VerTiposDeGastos(cbxSeleccion.ItemIndex);
end;

procedure TFLComprobacionGastos.VerTiposDeGastos;
var
  i: integer;
begin
  clbGastosTransito.Clear;
  case AOpcion of
    0,1:
        with DMAuxDB.QAux do
        begin
          SQL.Clear;
          SQL.Add(' select * ');
          SQL.Add(' from frf_tipo_gastos ');
          SQL.Add(' where gasto_transito_tg = 1 ');
          SQL.Add(' order by tipo_tg ');
          Open;

          clbGastosTransito.Items.Clear;
          i:= 0;
          while not EOF do
          begin
            clbGastosTransito.Items.Add(FieldByName('tipo_tg').AsString + ':' + FieldByName('descripcion_tg').AsString);
            clbGastosTransito.Checked[i]:= False;
            Inc(i);
            Next;
          end;
          Close;
          clbGastosTransito.Enabled:= clbGastosTransito.Items.Count > 0;
        end;
    4:
        with DMAuxDB.QAux do
        begin
          SQL.Clear;
          SQL.Add(' select * ');
          SQL.Add(' from frf_tipo_gastos ');
          SQL.Add(' where gasto_transito_tg = 0 ');
          SQL.Add(' order by tipo_tg ');
          Open;

          clbGastosTransito.Items.Clear;
          i:= 0;
          while not EOF do
          begin
            clbGastosTransito.Items.Add(FieldByName('tipo_tg').AsString + ':' + FieldByName('descripcion_tg').AsString);
            clbGastosTransito.Checked[i]:= False;
            Inc(i);
            Next;
          end;
          Close;
          clbGastosTransito.Enabled:= clbGastosTransito.Items.Count > 0;
        end;
    5:
        with DMAuxDB.QAux do
        begin
          SQL.Clear;
          SQL.Add(' select * ');
          SQL.Add(' from frf_tipo_gastos ');
          SQL.Add(' where gasto_transito_tg = 2 ');
          SQL.Add(' order by tipo_tg ');
          Open;

          clbGastosTransito.Items.Clear;
          i:= 0;
          while not EOF do
          begin
            clbGastosTransito.Items.Add(FieldByName('tipo_tg').AsString + ':' + FieldByName('descripcion_tg').AsString);
            clbGastosTransito.Checked[i]:= False;
            Inc(i);
            Next;
          end;
          Close;
          clbGastosTransito.Enabled:= clbGastosTransito.Items.Count > 0;
        end;
  end;
end;

end.
