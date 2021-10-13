unit LEntregas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt;

type
  TFLEntregas = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RGAgrupar: TRadioGroup;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    BGBCentro: TBGridButton;
    LCentro: TLabel;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LProducto: TLabel;
    BGBProducto: TBGridButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    STCentro: TStaticText;
    STProducto: TStaticText;
    STEmpresa: TStaticText;
    EEmpresa: TBEdit;
    ECentro: TBEdit;
    EProducto: TBEdit;
    ECosecheroDesde: TBEdit;
    EPlantacionDesde: TBEdit;
    ECosecheroHasta: TBEdit;
    EPlantacionHasta: TBEdit;
    Label1: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label3: TLabel;
    edtAnoSemDesde: TBEdit;
    Label4: TLabel;
    rbPeriodo: TRadioButton;
    rbRecoleccion: TRadioButton;
    Label9: TLabel;
    eAgrupacion: TBEdit;
    BGBAgrupacion: TBGridButton;
    STAgrupacion: TStaticText;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure eAgrupacionChange(Sender: TObject);
  private
      {private declarations}
    function  CamposVacios: boolean;
    function ObtenerDatos: Boolean;
    procedure PreparaListado;
    //procedure ListadoPorCampos(campo, tipo: string);
    //procedure ListadoPorProvincia;

  public
    { Public declarations }
    sEmpresa, sCentro, sProducto, sAnoSemana, sAgrupacion: string;
    icosini, icosfin, iplaini, iplafin: Integer;
    dIni, dFin: TDateTime;


    //empresa, centro, producto, sem: string;
    //fechaInicio, inicioCampana: TDAte;

    //estomate: boolean;
    //escosechero: boolean;

    //campo, tipo: string;
  end;

//var
  //recoleccion: Boolean;

implementation

uses CVariables, UDMAuxDB, DPreview, Principal, CAuxiliarDB, CReportes,
  LEntradasPeriodo, UDMBaseDatos, bTimeUtils, bSQLUtils;

{$R *.DFM}

procedure TFLEntregas.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLEntregas.BBAceptarClick(Sender: TObject);
//var campo: string;
begin
  if not CerrarForm(true) then Exit;

  if not CamposVacios then
  begin
    //Ahora aqui se selecciona el tipo de listado que se quiere mostrar
    //se construye la query de acuerdo con las opciones elegidas
  (*
  case RGAgrupar.ItemIndex of
    0: begin
        ListadoPorCampos('estructura_p', 'ESTRUCTURA');
        campo := 'estructura_p';
        tipo := 'ESTRUCTURA';
      end;
    1: begin
        ListadoPorCampos('tipo_cultivo_p', 'CULTIVO');
        campo := 'tipo_cultivo_p';
        tipo := 'CULTIVO';
      end;
    2: begin
        ListadoPorCampos('tipo_sustrato_p', 'SUSTRATO');
        campo := 'tipo_sustrato_p';
        tipo := 'SUSTRATO';
      end;
    3: begin
        ListadoPorCampos('variedad_p', 'VARIEDAD');
        campo := 'variedad_p';
        tipo := 'VARIEDAD';
      end;
    4: begin
        ListadoPorProvincia; //en realidad se agrupa las plantaciones por provincia
        escosechero := true; //que se saca por el codigo postal del cosechero
      end;
  end;
  *)


    try
      if ObtenerDatos then
      begin
        QRLEntradasPeriodo := TQRLEntradasPeriodo.Create(Application);
        PreparaListado;
        PonLogoGrupoBonnysa(QRLEntradasPeriodo, EEmpresa.Text);

        with QRLEntradasPeriodo do
        begin
          //if escosechero then
          //  BGrupo.Height := 0
          //else
            Bgrupo.Height := 22;
          if EProducto.Text <>  '' then
            LProducto.Caption := EProducto.Text + ' _ ' + STProducto.Caption
          else
            LProducto.Caption := STProducto.Caption;
          if ECentro.Text <>  '' then
            LCentro.Caption := ECentro.Text + '  ' + STCentro.Caption
          else
            LCentro.Caption := STCentro.Caption;
          LPeriodo.Caption := MEDesde.Text + ' - ' + MEHasta.Text;
          LSemana.Caption := 'Semana: ' + IntToStr(Semana(StrToDate(MEDesde.Text)));
          LCosecheros.Caption := 'Cos. del ' + ECosecheroDesde.Text + ' al ' + ECosecheroHasta.Text;
          LPlantaciones.Caption := 'Plan. del ' + EPlantacionDesde.Text + ' al ' + EPlantacionHasta.Text;
        end;

        try
          Preview(QRLEntradasPeriodo);
        except
          QRLentradasPeriodo.Free;
        end;
        //BorrarTemporal('tmp_listado');
      end
      else
      begin
        ShowMessage('Sin entradas para los parametros seleccionados');
      end;
    finally
      DMBaseDatos.QListado.Close;
      Application.ProcessMessages;
      //BorrarTemporal('tmp_listado');
    end;
  end;
end;

{
procedure TFLEntregas.PreparaListado;
begin
  QRLEntradasPeriodo.sEmpresa:= EEmpresa.Text;
  QRLEntradasPeriodo.bSoloUnProducto:= EProducto.Text <> '';

          //Nombre del campo porque el que se ha pedido el listado,
  case RGAgrupar.ItemIndex of
    0: begin
        QRLEntradasPeriodo.LCampo.Caption := 'ESTRUCTURA';
        QRLEntradasPeriodo.QRDBAgrupar.DataField := 'tipo';
        QRLEntradasPeriodo.QRDBAgrupar2.DataField := 'tipo';
        QRLEntradasPeriodo.BGrupo.Expression := '[producto]+[estructura_p]';
        QRLEntradasPeriodo.QListado.SQL.Clear;
        QRLEntradasPeriodo.QListado.SQL.Add('SELECT * FROM tmp_listado ' +
          'ORDER BY producto, estructura_p, ano_semana, inicio, nom_pla');
        //escosechero := False;
      end;
    1: begin
        QRLEntradasPeriodo.LCampo.Caption := 'TIPO CULTIVO';
        QRLEntradasPeriodo.QRDBAgrupar.DataField := 'tipo';
        QRLEntradasPeriodo.QRDBAgrupar2.DataField := 'tipo';
        QRLEntradasPeriodo.BGrupo.Expression := '[producto]+[tipo_cultivo_p]';
        QRLEntradasPeriodo.QListado.SQL.Clear;
        QRLEntradasPeriodo.QListado.SQL.Add('SELECT * FROM tmp_listado ' +
          'ORDER BY producto, tipo_cultivo_p, ano_semana, inicio, nom_pla');
        //escosechero := False;
      end;
    2: begin
        QRLEntradasPeriodo.LCampo.Caption := 'TIPO SUSTRATO';
        QRLEntradasPeriodo.QRDBAgrupar.DataField := 'tipo';
        QRLEntradasPeriodo.QRDBAgrupar2.DataField := 'tipo';
        QRLEntradasPeriodo.BGrupo.Expression := '[producto]+[tipo_sustrato_p]';
        QRLEntradasPeriodo.QListado.SQL.Clear;
        QRLEntradasPeriodo.QListado.SQL.Add('SELECT * FROM tmp_listado ' +
          'ORDER BY producto, tipo_sustrato_p, ano_semana, inicio, nom_pla');
        //escosechero := False;
      end;
    3: begin
        QRLEntradasPeriodo.LCampo.Caption := 'VARIEDAD';
        QRLEntradasPeriodo.QRDBAgrupar.DataField := 'tipo';
        QRLEntradasPeriodo.QRDBAgrupar2.DataField := 'tipo';
        QRLEntradasPeriodo.BGrupo.Expression := '[producto]+[variedad_p]';
        QRLEntradasPeriodo.QListado.SQL.Clear;
        QRLEntradasPeriodo.QListado.SQL.Add('SELECT * FROM tmp_listado ' +
          'ORDER BY producto, variedad_p, ano_semana, inicio, nom_pla');
        //escosechero := False;
      end;
    4: begin
        QRLEntradasPeriodo.LCampo.Caption := 'PROVINCIA';
        QRLEntradasPeriodo.BProvincia:= True;
        QRLEntradasPeriodo.QRDBAgrupar.DataField := 'cod_post';
        QRLEntradasPeriodo.QRDBAgrupar2.DataField := 'cod_post';
        QRLEntradasPeriodo.BGrupo.Expression := '[producto]+COPY(QListado.cod_post,1,2)';
        QRLEntradasPeriodo.QListado.SQL.Clear;
        QRLEntradasPeriodo.QListado.SQL.Add('SELECT * FROM tmp_listado ' +
          'ORDER BY producto, cod_post[1,2] ,ano_semana, inicio, nom_pla');

        //escosechero := True;
      end;
  end;
  if rbRecoleccion.Checked then
  begin
    QRLEntradasPeriodo.LTitulo.Caption := ' RESUMEN DE ENTRADAS EN RECOLECCIÓN';
    QRLEntradasPeriodo.msgTipoAcumulado.Caption := 'Acumulado desde el inicio de plantación.';
    //QRLEntradasPeriodo.msgTipoAcumulado.Alignment := taRightJustify;
  end
  else
  begin
    QRLEntradasPeriodo.LTitulo.Caption := ' RESUMEN DE ENTRADAS PERIDO';
    QRLEntradasPeriodo.msgTipoAcumulado.Caption := 'Acumulado desde el inicio de plantación.';
    //QRLEntradasPeriodo.msgTipoAcumulado.Caption := 'Acumulado desde el inicio de ejercicio.';
    //QRLEntradasPeriodo.msgTipoAcumulado.Alignment := taLeftJustify;
  end;
end;
}

procedure TFLEntregas.PreparaListado;
begin
  QRLEntradasPeriodo.bSoloUnProducto:= EProducto.Text <> '';
          //Nombre del campo porque el que se ha pedido el listado,
  case RGAgrupar.ItemIndex of
    0: begin
        QRLEntradasPeriodo.LCampo.Caption := '';
      end;
    1: begin
        QRLEntradasPeriodo.LCampo.Caption := 'ESTRUCTURA';
      end;
    2: begin
        QRLEntradasPeriodo.LCampo.Caption := 'TIPO CULTIVO';
      end;
    3: begin
        QRLEntradasPeriodo.LCampo.Caption := 'TIPO SUSTRATO';
      end;
    4: begin
        QRLEntradasPeriodo.LCampo.Caption := 'VARIEDAD';
      end;
    5: begin
        QRLEntradasPeriodo.LCampo.Caption := 'PROVINCIA';
      end;
    6: begin
        QRLEntradasPeriodo.LCampo.Caption := 'FEDERACION';
      end;
  end;
  if rbRecoleccion.Checked then
  begin
    QRLEntradasPeriodo.LTitulo.Caption := ' RESUMEN DE ENTRADAS EN RECOLECCIÓN';
    QRLEntradasPeriodo.msgTipoAcumulado.Caption := 'Acumulado desde el inicio de plantación.';
  end
  else
  begin
    QRLEntradasPeriodo.LTitulo.Caption := ' RESUMEN DE ENTRADAS PERIDO';
    QRLEntradasPeriodo.msgTipoAcumulado.Caption := 'Acumulado desde el inicio de plantación.';
  end;
end;

function TFLEntregas.ObtenerDatos;
begin
  with DMBaseDatos.QListado do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

     //Cantidades acumuladas ejercicio
    SQL.Clear;
    SQL.Add(' select empresa_p empresa, producto_p producto, cosechero_p cos, plantacion_p pla, ano_semana_p ano_semana, descripcion_p nom_pla, ');
    SQL.Add('        superficie_p has, plantas_p plantas, fecha_inicio_p inicio, fecha_fin_p fin, ');

    case RGAgrupar.ItemIndex of
      0:  SQL.Add('        '''' cod_tipo, ''''  tipo, ');
      1:  SQL.Add('        nvl( estructura_p, ''##'') cod_tipo, nvl( ( select descripcion_c from frf_campos where campo_c = ''ESTRUCTURA'' and tipo_c = estructura_p ), ''SIN ASIGNAR'')  tipo, ');
      2:  SQL.Add('        nvl( tipo_cultivo_p, ''##'') cod_tipo, nvl( ( select descripcion_c from frf_campos where campo_c = ''CULTIVO'' and tipo_c = tipo_cultivo_p ), ''SIN ASIGNAR'') tipo, ');
      3:  SQL.Add('        nvl( tipo_sustrato_p, ''##'') cod_tipo, nvl( ( select descripcion_c from frf_campos where campo_c = ''SUSTRATO'' and tipo_c = tipo_sustrato_p ), ''SIN ASIGNAR'') tipo, ');
      4:  SQL.Add('        nvl( variedad_p, ''##'') cod_tipo, nvl( ( select descripcion_c from frf_campos where campo_c = ''VARIEDAD'' and tipo_c = variedad_p ), ''SIN ASIGNAR'') tipo, ');
      5:  SQL.Add('        cod_postal_c cod_tipo, nvl( ( select nombre_p from frf_provincias where codigo_p = cod_postal_c[1,2] ), ''SIN ASIGNAR'') tipo, ');
      6:  SQL.Add('        nvl( federacion_p, 0) cod_tipo, nvl( ( select provincia_f from frf_federaciones where codigo_f = federacion_p ), ''SIN ASIGNAR'') tipo, ');
    end;
    SQL.Add('        sum(total_kgs_e2l) kilos_acu, sum( case when fecha_e2l between :fechaini and :fechafin then total_kgs_e2l else 0 end ) kilos_per, ');
    SQL.Add('        sum(total_cajas_e2l) cajas_acu, sum( case when fecha_e2l between :fechaini and :fechafin then total_cajas_e2l else 0 end ) cajas_per ');

    SQL.Add(' from frf_plantaciones ');
    SQL.Add('      join frf_cosecheros on empresa_c = empresa_p and cosechero_c = cosechero_p ');
    SQL.Add('      left join frf_entradas2_l on empresa_e2l = empresa_p and cosechero_e2l = cosechero_p and plantacion_e2l = plantacion_p and ano_sem_planta_e2l = ano_semana_p and producto_e2l = producto_p ');
    if EEmpresa.Text <> 'SAT' then
      SQL.Add(' where empresa_p = :empresa ')
    else
      SQL.Add(' where ( empresa_p = ''050'' or empresa_p = ''080'' ) ');
    //if rbRecoleccion.Checked then
      SQL.Add(' and ( ( fecha_fin_p is null ) or ( fecha_fin_p >= :fechaini ) ) ');
    SQL.Add(' and cosechero_p between :cosini and :cosfin ');
    SQL.Add(' and plantacion_p between :plaini and :plafin ');
    if  edtAnoSemDesde.Text <> '' then
      SQL.Add(' and ano_semana_p >= :anosem ');
    if EProducto.Text <> '' then
      SQL.Add(' and producto_p = :producto ');
    if Trim( eAgrupacion.Text ) <> '' then
      SQl.Add(' and producto_p in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');
    if ECentro.Text <> '' then
      SQL.Add(' and centro_e2l = :centro ');
    //if rbPeriodo.Checked then
      //SQL.Add(' and fecha_e2l between :fechain and :fechafin ');
    SQL.Add(' and fecha_e2l <= :fechafin ');
    SQL.Add(' group by empresa, producto_p, cos, pla, ano_semana, nom_pla, has, plantas, inicio, fin, cod_tipo, tipo');
    if rbPeriodo.Checked then
      SQL.Add(' having sum( case when fecha_e2l between :fechaini and :fechafin then total_kgs_e2l else 0 end )  <> 0 ');
    SQL.Add(' order by empresa, producto, tipo, ano_semana, cos, pla ');


    if EEmpresa.Text <> 'SAT' then
      ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('cosini').AsInteger := icosini;
    ParamByName('cosfin').AsInteger := icosfin;
    ParamByName('plaini').AsInteger := iplaini;
    ParamByName('plafin').AsInteger := iplafin;
    ParamByName('fechafin').AsDate := dFin;
    ParamByName('fechaini').AsDate := dIni;

    if edtAnoSemDesde.Text <> '' then
      ParamByName('anosem').AsString := edtAnoSemDesde.Text;
    if EProducto.Text <> '' then
      ParamByName('producto').AsString := EProducto.Text;
    if ECentro.Text <> '' then
      ParamByName('centro').AsString := ECentro.Text;
    if Trim( EAgrupacion.Text ) <> '' then
      ParamByName('agrupacion').AsString := EAgrupacion.Text;

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TFLEntregas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAuxQuerys;
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

procedure TFLEntregas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
  MEDesde.Text := DateToStr(Date);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;
  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  EAgrupacion.Tag := kAgrupacion;
  ECosecheroDesde.Tag:= kCosechero;
  ECosecheroHasta.Tag:= kCosechero;
  EPlantacionDesde.Tag:= kPlantacion;
  EPlantacionHasta.Tag:= kPlantacion;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  EEmpresa.Text := '';
  ECentro.Text := '';
  EProducto.Text := '';
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  (*   //dependiendo del tipo de listado, recoleccion o inicio, se debe mostrar un titulo u otro
  if recoleccion then
  begin
    Caption := ' RESUMEN DE ENTRADAS EN RECOLECCIÓN';
  end
  else
  begin
    Caption := ' RESUMEN DE ENTRADAS DESDE INICIO EJERCICIO';
  end;
  *)
  
  EEmpresa.text:= gsDefEmpresa;
  ECentro.text:= gsDefCentro;
  //EProducto.text:= gsDefProducto;
  ECosecheroDesde.Text:= '0';
  ECosecheroHasta.Text:= '999';
  EPlantacionDesde.Text:= '0';
  EPlantacionHasta.Text:= '999';
  eAgrupacionChange(eagrupacion);
end;

procedure TFLEntregas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLEntregas.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kAgrupacion: DespliegaRejilla(BGBAgrupacion);
    kCentro: DespliegaRejilla(BGBCentro, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLEntregas.PonNombre(Sender: TObject);
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
       ECentro.OnChange( ECentro );
       EProducto.OnChange( EProducto );
    end;
    kProducto:
    begin
      if EProducto.Text <> '' then
        STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text)
      else
        STProducto.Caption := 'TODOS LOS PRODUCTOS';
    end;
    kCentro:
    begin
      if Ecentro.Text <> '' then
        STCentro.Caption := desCentro(Eempresa.Text, Ecentro.Text)
      else
        STCentro.Caption := 'TODOS LOS CENTROS';
    end;
    kAgrupacion:
    begin

      if ( EAgrupacion.Text = '' ) then
        STAgrupacion.Caption:= 'TODAS LAS AGRUPACIONES'
      else
        STAgrupacion.Caption := desAgrupacion(EAgrupacion.Text);
    end;
  end;
end;

function TFLEntregas.CamposVacios: boolean;
begin
  Result := True;

  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    EEmpresa.SetFocus;
    Exit;
  end;

  if not TryStrToDate( MEDesde.Text, dIni ) then
  begin
    ShowError('La fecha de inicio es incorrecta.');
    MEDesde.SetFocus;
    Exit;
  end;

  if not TryStrToDate( MEHasta.Text, dFin ) then
  begin
    ShowError('La fecha de fin es incorrecta.');
    MEHasta.SetFocus;
    Exit;
  end;

  if dIni > dFin then
  begin
    ShowError('Rango de fechas incorrecto.');
    MEDesde.SetFocus;
    Exit;
  end;

  if STCentro.Caption = '' then
  begin
    ShowError('El código del producto es incorrecto.');
    ECentro.SetFocus;
    Exit;
  end;

  if StProducto.Caption = '' then
  begin
    ShowError('El código del producto es incorrecto.');
    EProducto.SetFocus;
    Exit;
  end;

  if Trim( STAgrupacion.Caption ) = '' then
  begin
    ShowError('El código de agrupación es incorrecto');
    EAgrupacion.SetFocus;
    Exit;
  end;


  sEmpresa:= EEmpresa.Text;
  sCentro:= EEmpresa.Text;
  sProducto:= EEmpresa.Text;
  sAnoSemana:= EEmpresa.Text;
  sAgrupacion := EAgrupacion.Text;
  icosini:= StrToIntDef( ECosecheroDesde.Text, 0 );
  icosfin:= StrToIntDef( ECosecheroHasta.Text, 0 );
  iplaini:= StrToIntDef( EPlantacionDesde.Text, 0 );
  iplafin:= StrToIntDef( EPlantacionHasta.Text, 0 );

  Result := False;
end;


procedure TFLEntregas.eAgrupacionChange(Sender: TObject);
begin
  if Trim( eAgrupacion.Text ) = '' then
    STAgrupacion.Caption := 'TODAS LAS AGRUPACIONES'
  else
    STAgrupacion.Caption := desAgrupacion(eAgrupacion.Text);
end;

//En este procedimiento se sacan los datos por los cosecheros de cada provincia
{
procedure TFLEntregas.ListadoPorProvincia;
var fin_plantacion: string;
  periodo: string;
  sectores: string;
  anoSemanaStr: string;
begin

  if recoleccion then
  begin
    periodo := ' and fecha_e2l <= ' + SQLDate(MEHasta.Text);
    fin_plantacion := ' and (p.fecha_fin_p is null or p.fecha_fin_p >=' + SQLDate(MEDesde.Text) + ')';
      //AÑADIDO 13/02/2002 NO SALEN LOS KILOS DE LOS SECTORES QUE TENGAN UN PUNTO INICIAL
      //Sólo se aplica a la distribucion por provincias
    sectores := ' AND (SECTORES_E2L[1,1]<> ' + QuotedStr('.') + ' OR SECTORES_E2L IS NULL) ';
  end
  else
  begin
    periodo := ' and fecha_e2l BETWEEN ' + SQLDate(InicioCampana) +
      ' and ' + SQLDate(MEHasta.Text);
      //la fecha de fin de recoleccion tiene que ser mayor que el inicio de ejercicio para salir
      //en este listado.
      //29-4-2002 Para que no salgan unas plantaciones que D. Antonio no quiere que salgan
      //se pone la fecha de fin sin ningun sentido
    //fin_plantacion := ' and (fecha_fin_p > ' + SQLDate('20/08/2001') + //SQLDate(DateToStr(InicioCampana))+
    //  ' or fecha_fin_p is Null) ';
    fin_plantacion := ' ';
    sectores := '';
  end;

  if Trim(eAnoSemana.Text) <> '' then
  begin
    anoSemanaStr := ' and ano_sem_planta_e2l >= ' + QuotedStr(Trim(eAnoSemana.Text)) + ' ';
  end;

  with DMBaseDatos.QListado do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

     //Cantidades acumuladas ejercicio
    SQL.Clear;
    SQL.Add(' SELECT producto_e2l producto, ano_sem_planta_e2l anyo, cosechero_e2l cos,  ' +
      ' plantacion_e2l pla, SUM(total_kgs_e2l) kilos_acu' +
      ' FROM  frf_entradas2_l ' +
      ' WHERE empresa_e2l = :empresa ' +
      ' AND centro_e2l = :centro ');

    if EProducto.Text <> '' then
      SQL.Add('  AND producto_e2l = :producto ' );

    SQL.Add( periodo + sectores + anoSemanaStr );

    //COSECHERO-Plantacion
    SQL.Add(' AND cosechero_e2l between ' + ECosecheroDesde.Text + ' and ' + ECosecheroHasta.Text);
    SQL.Add(' AND plantacion_e2l between ' + EPlantacionDesde.Text + ' and ' + EPlantacionHasta.Text);

    SQL.Add(
      ' GROUP BY producto, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l ' +
      //' ORDER BY cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l ' +
      ' INTO TEMP tmp_acumulado');
    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('centro').AsString := ECentro.Text;
    if EProducto.Text <> '' then
      ParamByName('producto').AsString := EProducto.Text;
     //ParamByName('desde').AsDateTime:=InicioCampana;
     //ParamByName('hasta').AsDateTime:=StrToDate(MEHasta.Text);
    ExecSQl;

     //Comprobar que existan datos
    SQL.Clear;
    SQL.Add('select count(*) from tmp_acumulado');
    Open;
    if Fields[0].asinteger < 0 then
    begin
      Cancel;
      Close;
      Exit;
    end
    else
    begin
      Cancel;
      Close;
    end;

     //Datos por periodo
    SQL.Clear;
    SQL.Add(' SELECT producto_e2l producto, ano_sem_planta_e2l anyo, cosechero_e2l cos,  ' +
      ' plantacion_e2l pla, SUM(total_kgs_e2l) kilos_per ' +
      ' FROM frf_entradas2_l ' +
      ' WHERE empresa_e2l = :empresa ' +
      ' AND centro_e2l = :centro ' );
    if EProducto.Text <> '' then
      SQL.Add(' AND producto_e2l = :producto ' );
    SQL.Add(' AND fecha_e2l BETWEEN :desde AND :hasta ' +
      sectores +
      anoSemanaStr  );

    //COSECHERO-Plantacion
    SQL.Add(' AND cosechero_e2l between ' + ECosecheroDesde.Text + ' and ' + ECosecheroHasta.Text);
    SQL.Add(' AND plantacion_e2l between ' + EPlantacionDesde.Text + ' and ' + EPlantacionHasta.Text);

    SQL.Add(
      ' GROUP BY producto, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l ' +
      //' ORDER BY cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l ' +
      ' INTO TEMP tmp_periodo');
    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('centro').AsString := ECentro.Text;
    if EProducto.Text <> '' then
      ParamByName('producto').AsString := EProducto.Text;
    ParamByName('desde').AsDateTime := StrToDate(MEDesde.Text);
    ParamByName('hasta').AsDateTime := StrToDate(MEHasta.Text);
    ExecSQl;

     //Union acumulado-periodo
    SQL.Clear;
    SQL.Add(' select a.producto, a.cos,a.pla,a.anyo, ' +
      ' p.kilos_per, ' +
      ' a.kilos_acu ' +
      ' from tmp_acumulado a, outer tmp_periodo p ' +
      ' where p.cos=a.cos ' +
      '  and p.pla=a.pla ' +
      '  and p.anyo=a.anyo ' +
      ' into temp tmp_per_acu ');
    ExecSql;

    BorrarTemporal('tmp_periodo');
    BorrarTemporal('tmp_acumulado');

    SQL.Clear;
    SQL.Add(' select c.cod_postal_c cod_post, a.producto, a.cos, a.pla,a.anyo, ' +
      '        a.kilos_per, a.kilos_acu ' +
      ' from frf_cosecheros c,tmp_per_acu a ' +
      ' where c.empresa_c=:empresa ' +
      '  and c.cosechero_c=a.cos ' +
      ' into temp tmp_cos ');
    ParamByName('empresa').AsString := EEmpresa.Text;
    ExecSql;

     //Sacar datos de las plantaciones(el listado va ordenado  por cosechero)
    SQL.Clear;
    SQL.Add(' select a.producto, a.cos, a.cod_post,  ' +
      '       a.pla, p.descripcion_p nom_pla, ' +
      '       p.ano_semana_p ano_semana, ' +
      '       p.superficie_p has, ' +
      '       p.fecha_inicio_p inicio, ' +
      '       p.plantas_p plantas, ' +
      '       a.kilos_per, a.kilos_acu, ' +

      '       case when nvl(p.superficie_p,0) = 0 then 0 else ROUND(a.kilos_per/p.superficie_p,1) end kilos_superficie, ' +
      '       case when nvl(p.plantas_p,0) = 0 then 0 else ROUND(a.kilos_per/p.plantas_p,3) end kilos_planta, ' +
      '       case when nvl(p.superficie_p,0) = 0 then 0 else ROUND(a.kilos_acu/p.superficie_p,1) end kilos_super_acu, ' +
      '       case when nvl(p.plantas_p,0) = 0 then 0 else ROUND(a.kilos_acu/p.plantas_p,3) end kilos_plantas_acu ' +

      ' from   frf_plantaciones p,  tmp_cos a ' +
      ' where  p.empresa_p=:empresa ' +
      '  and  p.cosechero_p=a.cos ');
    if EProducto.Text <> '' then
      SQL.Add(' and  p.producto_p=:producto ');
    SQL.Add(' and  p.ano_semana_p=a.anyo ' +
      '  and  p.plantacion_p=a.pla ' +
              //Para evitar la division por cero
              //lo quito a peticion de Roberto 07/01/2002
              //'  and p.superficie_p>0 and p.plantas_p>0 '+
              //si es recoleccion sólo se cogen las plantaciones cuya fecha de fin sea null
              //si es desde inicio de ejercicio las que tengan fecha de fin de recoleccion menor
              //a la fecha de inicio de ejercicio no deben salir
      fin_plantacion +
      '  order by a.producto, a.cod_post ' +
      '  into temp tmp_listado');
    ParamByName('empresa').AsString := EEmpresa.Text;
    if EProducto.Text <> '' then
      ParamByName('producto').AsString := EProducto.Text;

    ExecSql;

    BorrarTemporal('tmp_per_acu');
    BorrarTemporal('tmp_cos');

  end; //fin with
end;

//En este procedimiento se hacen las consultas para sacar los datos segun el tipo de
//campo elegido: estructura, tipo cultivo, tipo sustrato, variedad.

procedure TFLEntregas.ListadoPorCampos(campo, tipo: string);
var fin_plantacion: string;
  periodo: string;
  sectores: string;
  anoSemanaStr: string;
begin

   //Si el listado es recoleccion, sólo se mostraran las plantaciones que no tengan fecha de fin
   //Si es recoleccion, el acumulado es desde que haya datos, todo.
  if recoleccion then
  begin
    //fin_plantacion := ' and p.fecha_fin_p is null ';
    fin_plantacion := ' and (p.fecha_fin_p is null or p.fecha_fin_p >=' + SQLDate(MEDesde.Text) + ')';
    periodo := ' and fecha_e2l <= ' + SQLDate(MEHasta.Text);
    sectores := '';
  end
  else
  begin
    fin_plantacion := ' ';
    periodo := ' and fecha_e2l BETWEEN ' + SQLDate(InicioCampana) +
      ' and ' + SQLDate(MEHasta.Text);
    sectores := '';
  end;

  if Trim(eAnoSemana.Text) <> '' then
  begin
    anoSemanaStr := ' and ano_sem_planta_e2l >= ' + QuotedStr(Trim(eAnoSemana.Text)) + ' ';
  end;

  with DMBaseDatos.QListado do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

     //Cantidades acumuladas ejercicio
    SQL.Clear;
    SQL.Add(' SELECT producto_e2l producto, ano_sem_planta_e2l anyo, cosechero_e2l cos,  ' +
      ' plantacion_e2l pla, SUM(total_kgs_e2l) kilos_acu' +
      ' FROM  frf_entradas2_l ' +
      ' WHERE empresa_e2l = :empresa ' +
      ' AND centro_e2l = :centro ' );
    if EProducto.Text <> '' then
      SQL.Add('  AND producto_e2l = :producto ' );
    SQL.Add( periodo +
      sectores +
      anoSemanaStr  );

    //COSECHERO-Plantacion
    SQL.Add(' AND cosechero_e2l between ' + ECosecheroDesde.Text + ' and ' + ECosecheroHasta.Text);
    SQL.Add(' AND plantacion_e2l between ' + EPlantacionDesde.Text + ' and ' + EPlantacionHasta.Text);

    SQL.Add('  GROUP BY producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l ' +
      //' ORDER BY cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l ' +
      ' INTO TEMP tmp_acumulado');
    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('centro').AsString := ECentro.Text;
    if EProducto.Text <> '' then
      ParamByName('producto').AsString := EProducto.Text;
     //ParamByName('desde').AsDateTime:=InicioCampana;
     //ParamByName('hasta').AsDateTime:=StrToDate(MEHasta.Text);
    ExecSQl;

     //Comprobar que existan datos
    SQL.Clear;
    SQL.Add('select count(*) from tmp_acumulado');
    Open;
    if Fields[0].asinteger < 0 then
    begin
      Cancel;
      Close;
         //borrar la temporal
      Exit;
    end
    else
    begin
      Cancel;
      Close;
    end;

     //Datos por periodo
    SQL.Clear;
    SQL.Add(' SELECT producto_e2l producto, ano_sem_planta_e2l anyo, cosechero_e2l cos,  ' +
      ' plantacion_e2l pla, SUM(total_kgs_e2l) kilos_per ' +
      ' FROM  frf_entradas2_l ' +
      ' WHERE empresa_e2l = :empresa ' +
      ' AND centro_e2l = :centro '   );
   if EProducto.Text <> '' then
      SQL.Add(' AND producto_e2l = :producto '   );
   SQL.Add(' AND fecha_e2l BETWEEN :desde AND :hasta ' +
      sectores +
      anoSemanaStr  );

    //COSECHERO-Plantacion
    SQL.Add(' AND cosechero_e2l between ' + ECosecheroDesde.Text + ' and ' + ECosecheroHasta.Text);
    SQL.Add(' AND plantacion_e2l between ' + EPlantacionDesde.Text + ' and ' + EPlantacionHasta.Text);

    SQL.Add(
      ' GROUP BY producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l ' +
      //' ORDER BY producto, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l ' +
      ' INTO TEMP tmp_periodo');
    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('centro').AsString := ECentro.Text;
    if EProducto.Text <> '' then
      ParamByName('producto').AsString := EProducto.Text;
    ParamByName('desde').AsDateTime := StrToDate(MEDesde.Text);
    ParamByName('hasta').AsDateTime := StrToDate(MEHasta.Text);
    ExecSQl;

     //Union acumulado-periodo
    SQL.Clear;
    SQL.Add(' select a.producto, a.cos,a.pla,a.anyo, ' +
      ' p.kilos_per, ' +
      ' a.kilos_acu ' +
      ' from tmp_acumulado a, outer tmp_periodo p ' +
      ' where p.cos=a.cos ' +
      '  and p.pla=a.pla ' +
      '  and p.anyo=a.anyo ' +
      ' into temp tmp_per_acu ');
    ExecSql;

    BorrarTemporal('tmp_periodo');
    BorrarTemporal('tmp_acumulado');

     //Sacar datos de las plantaciones(el listado va ordenado por el tipo de campo)
    SQL.Clear;
    SQL.Add(' select a.producto, a.cos,' +
      '       a.pla, p.descripcion_p nom_pla, ' +
      '       p.ano_semana_p ano_semana, ' +
      '       p.fecha_inicio_p inicio, ' +
      '       p.superficie_p has, ' +
      '       p.plantas_p plantas, ' +
      campo + ',' +
      '       c.descripcion_c tipo ,' +
      '       a.kilos_per, a.kilos_acu, ' +

      '       case when nvl(p.superficie_p,0) = 0 then 0 else ROUND(a.kilos_per/p.superficie_p,1) end kilos_superficie, ' +
      '       case when nvl(p.plantas_p,0) = 0 then 0 else ROUND(a.kilos_per/p.plantas_p,3) end kilos_planta, ' +
      '       case when nvl(p.superficie_p,0) = 0 then 0 else ROUND(a.kilos_acu/p.superficie_p,1) end kilos_super_acu, ' +
      '       case when nvl(p.plantas_p,0) = 0 then 0 else ROUND(a.kilos_acu/p.plantas_p,3) end kilos_plantas_acu ' +

      ' from   frf_plantaciones p,  tmp_per_acu a, frf_campos c' +
      ' where  p.empresa_p=:empresa ' +
      '  and  p.cosechero_p=a.cos ' );
    if EProducto.Text <> '' then
      SQL.Add('  and  p.producto_p=:producto ' );
    SQL.Add('  and  p.ano_semana_p=a.anyo ' +
      '  and  p.plantacion_p=a.pla ' +
      '  and  c.campo_c = ' + QuotedStr(tipo) + //ESTRUCTURA, TIPO CULTIVO, TIPO SUSTRATO, VARIEDAD
      '  and  c.tipo_c = ' + Campo + //estructura_p, tipo_cultivo_p, tipo_sustrato_p, variedad_p
      fin_plantacion + //si el listado es recoleccion, sólo se mostraran las plantaciones que no tengan fecha de fin
              //esta variable puedes estar a blanco o puede tener el valor fecha_fin is null
      '  order by a.producto, ' + campo +
      '  into temp tmp_listado');
    ParamByName('empresa').AsString := EEmpresa.Text;
    if EProducto.Text <> '' then
      ParamByName('producto').AsString := EProducto.Text;

    ExecSql;

    BorrarTemporal('tmp_per_acu');

  end; //fin with
end;
}

procedure TFLEntregas.FormActivate(Sender: TObject);
begin
  Top := 1;
end;

end.
