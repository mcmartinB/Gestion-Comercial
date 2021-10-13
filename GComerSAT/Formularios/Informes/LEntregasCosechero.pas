unit LEntregasCosechero;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ActnList, ComCtrls, Db,
  CGestionPrincipal, BEdit, BCalendarButton, BSpeedButton, BGridButton,
  BCalendario, BGrid, DError, QuickRpt, Grids, DBGrids;

type
  TFLEntregasCosechero = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    ACancelar: TAction;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    BGBEmpresa: TBGridButton;
    BGBCentro: TBGridButton;
    BGBProducto: TBGridButton;
    EProducto: TBEdit;
    ECentro: TBEdit;
    EEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    STProducto: TStaticText;
    Desde: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label14: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label4: TLabel;
    EDesde: TBEdit;
    Label7: TLabel;
    EHasta: TBEdit;
    Label5: TLabel;
    EDesde2: TBEdit;
    Label6: TLabel;
    EHasta2: TBEdit;
    cmbPunto: TComboBox;
    cbxProductoPerido: TCheckBox;
    cbxSoloActivas: TCheckBox;
    Label8: TLabel;
    eAgrupacion: TBEdit;
    BGBAgrupacion: TBGridButton;
    STAgrupacion: TStaticText;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure EHastaExit(Sender: TObject);
    procedure EHasta2Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure eAgrupacionChange(Sender: TObject);

  public
    { Public declarations }
    empresa, centro, producto, agrupacion: string;
    fechaInicio: TDate;
    function PreparaListado: Boolean;
  end;

var
  Autorizado: boolean;

implementation

uses Principal, CVariables, CAuxiliarDB, UDMAuxDB, CReportes, bSQLUtils,
  LEntradasCosEjercicio, DPreview, UDMBaseDatos;

{$R *.DFM}

procedure TFLEntregasCosechero.BBAceptarClick(Sender: TObject);
begin
  BorrarTemporal('tmp_listado');
  BorrarTemporal('tmp_acumulado');
  BorrarTemporal('tmp_periodo');
  BorrarTemporal('tmp_per_acu');
  BorrarTemporal('tmp_cos');

  if not CerrarForm(true) then Exit;
        //Comprobamos que los campos esten todos con datos
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EEmpresa.SetFocus;
    Exit;
  end;

  if Trim( STAgrupacion.Caption ) = '' then
  begin
    ShowError('El código de agrupación es incorrecto');
    EAgrupacion.SetFocus;
    Exit;
  end;

  //if STProducto.Caption = '' then
  if Trim( STProducto.Caption ) = '' then
  begin
    ShowError('El código del producto es incorrecto');
    EProducto.SetFocus;
    Exit;
  end;

  if Trim( STCentro.Caption) = '' then
  begin
    ShowError('El código del centro es incorrecto');
    ECentro.SetFocus;
    Exit;
  end;

  if EDesde.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EDesde.SetFocus;
    Exit;
  end;

  if EHasta.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EHasta.SetFocus;
    Exit;
  end;

  if EDesde2.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EDesde2.SetFocus;
    Exit;
  end;

  if EHasta2.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EHasta2.SetFocus;
    Exit;
  end;

//.......................NOMBRE CENTRO Y PRODUCTO.................
  empresa := STEmpresa.Caption;
  centro := STCentro.Caption;
  producto := STProducto.Caption;
  agrupacion := STAgrupacion.Caption;

  fechaInicio := StrToDate(MEDesde.Text);

    //Preparamos datos para el listado
  if not PreparaListado then
  begin
    ShowError('No hay entradas de fruta para el periodo seleccionado con los datos introducidos.');
    Exit;
  end;
    //Llamamos al QReport
  QRLEntradasCosEjercicio := TQRLEntradasCosEjercicio.Create(Application);
  try
    PonLogoGrupoBonnysa(QRLEntradasCosEjercicio, EEmpresa.Text);
    QRLEntradasCosEjercicio.QListado.SQL.Add(
      ' select centro, cos,nom_cos,pla,nom_pla,ano_semana, producto, ' +
      '        cajas_per,kilos_per,kilos_acu,kilos_superficie,  kilos_planta, ' +
      '        has, plantas ' +
      ' from tmp_listado ' +
      ' order by centro, producto,cos,pla,ano_semana ');
    QRLEntradasCosEjercicio.QListado.Open;

    with QRLEntradasCosEjercicio do
    begin
        //Coloco la fecha del rango en el informe
      sEmpresa:= EEmpresa.Text;
      QRLDesde.Caption := MEDesde.Text + ' - ';
      QRLHasta.Caption := MEHasta.Text;
//      psCentro.Caption := ECentro.Text + '  ' + centro;
      //psProducto.Caption := EProducto.Text + '  ' + producto;
    end;

    Preview(QRLEntradasCosEjercicio);
  finally
    //BorrarTemporal('tmp_listado');
  end;
end;

procedure TFLEntregasCosechero.eAgrupacionChange(Sender: TObject);
begin
  if Trim( eAgrupacion.Text ) = '' then
    STAgrupacion.Caption := 'TODAS LAS AGRUPACIONES'
  else
    STAgrupacion.Caption := desAgrupacion(eAgrupacion.Text);
end;

procedure TFLEntregasCosechero.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BorrarTemporal('tmp_listado');
  BorrarTemporal('tmp_acumulado');
  BorrarTemporal('tmp_periodo');
  BorrarTemporal('tmp_per_acu');
  BorrarTemporal('tmp_cos');

  CloseAuxQuerys;
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

procedure TFLEntregasCosechero.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  EAgrupacion.Tag := kAgrupacion;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  ECentro.Text:= gsDefCentro;
  EEmpresa.Text:= gsDefEmpresa;
//  EProducto.Text:= gsDefProducto;

  //PonNombre( EProducto );
  MEDesde.Text := DateTostr(Date);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;

  eAgrupacionChange(eagrupacion);
  PonNombre(EProducto);

  EDesde.Text := '0';
  EHasta.Text := '999';
  EDesde2.Text := '0';
  EHasta2.Text := '999';

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

end;

procedure TFLEntregasCosechero.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLEntregasCosechero.ADesplegarRejillaExecute(Sender: TObject);
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

procedure TFLEntregasCosechero.PonNombre(Sender: TObject);
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
      end;
    kProducto:
    begin

      if ( EProducto.Text = '' ) then
        STProducto.Caption:= 'TODOS LOS PRODUCTOS'
      else
        STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
    end;
    kAgrupacion:
    begin

      if ( EAgrupacion.Text = '' ) then
        STAgrupacion.Caption:= 'TODAS LAS AGRUPACIONES'
      else
        STAgrupacion.Caption := desAgrupacion(EAgrupacion.Text);
    end;
    kCentro:
      if (ECentro.Text = '' ) then
        STCentro.Caption := 'TODOS LOS CENTROS'
      else
        STCentro.Caption := desCentro(Eempresa.Text, Ecentro.Text);
  end;
end;

procedure TFLEntregasCosechero.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

procedure TFLEntregasCosechero.EHastaExit(Sender: TObject);
begin
  if StrToInt(EHasta.Text) < StrToInt(EDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de cosecheros correcto',
      mtError, [mbOk], 0);
    EDesde.SetFocus;
  end;
end;

procedure TFLEntregasCosechero.EHasta2Exit(Sender: TObject);
begin
  if StrToInt(EHasta2.Text) < StrToInt(EDesde2.Text) then
  begin
    MessageDlg('Debe escribir un rango de plantaciones correcto',
      mtError, [mbOk], 0);
    EDesde2.SetFocus;
  end;
end;

procedure TFLEntregasCosechero.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := EEmpresa;
end;

procedure TFLEntregasCosechero.ACancelarExecute(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFLEntregasCosechero.PreparaListado: Boolean;
begin
  PreparaListado := false;
  with DMBaseDatos.QListado do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

     //Cantidades acumuladas ejercicio
    SQL.Clear;
    SQL.Add(' select centro_e2l centro, cosechero_e2l cos,plantacion_e2l pla, ' +
            '        ano_sem_planta_e2l ano_semana, producto_e2l producto, ' +
            '        SUM(total_cajas_e2l) cajas_acu, ' +
            '        SUM(total_kgs_e2l) kilos_acu ');
    if cbxSoloActivas.Checked then
      SQL.Add(' from frf_entradas2_l, frf_plantaciones ')
    else
      SQL.Add(' from frf_entradas2_l ');
    SQL.Add(' where empresa_e2l=:empresa ');
    if Trim( ECentro.Text ) <> '' then
      SQL.Add('  and centro_e2l=:centro ');
    if Trim( EProducto.Text ) <> '' then
      SQL.Add(' and producto_e2l=:producto ');
    if Trim( eAgrupacion.Text ) <> '' then
      SQl.Add(' and producto_e2l in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');
    //SQL.Add(' and fecha_e2l between :inicio and :fin ');
    SQL.Add(' and fecha_e2l <= :fin ');
    SQL.Add(' and cosechero_e2l between :desdecos and :hastacos ' +
      '  and plantacion_e2l between :desdepla and :hastapla ');
    if cbxSoloActivas.Checked then
    begin
      SQL.Add('  and ano_semana_p = ano_sem_planta_e2l ' +
        '  and empresa_p = empresa_e2l ' +
        '  and producto_p = producto_e2l ' +
        '  and cosechero_p = cosechero_e2l ' +
        '  and plantacion_p = plantacion_e2l ' +
        '  and NVL(fecha_fin_p,today) >= :iniPeriodo ' );
    end;

    case cmbPunto.ItemIndex of
      1: SQL.Add(' and ( not trim(sectores_e2l) like ''.%'' or sectores_e2l is null ) ');
      2: SQL.Add(' and ( trim(sectores_e2l) like ''.%'' and not sectores_e2l is null ) ');
    end;

    SQL.Add(' group by centro_e2l, cosechero_e2l,plantacion_e2l,ano_sem_planta_e2l, producto_e2l ' +
      ' into temp tmp_acumulado ');
    ParamByName('empresa').AsString := EEmpresa.Text;
    if Trim( ECentro.Text ) <> '' then
      ParamByName('centro').AsString := ECentro.Text;
    if Trim( EProducto.Text ) <> '' then
      ParamByName('producto').AsString := EProducto.Text;
    if Trim( EAgrupacion.Text ) <> '' then
      ParamByName('agrupacion').AsString := EAgrupacion.Text;
    ParamByName('fin').AsDateTime := StrToDate(MEHasta.Text);
    ParamByName('desdeCos').AsInteger := StrToInt(EDesde.text);
    ParamByName('hastaCos').AsInteger := StrToInt(EHasta.Text);
    ParamByName('desdePla').AsInteger := StrToInt(EDesde2.Text);
    ParamByName('hastaPla').Asinteger := StrToInt(EHasta2.Text);
    if cbxSoloActivas.Checked then
      ParamByName('iniPeriodo').AsDateTime := fechaInicio;
    ExecSql;

     //Comprobar que existan datos
    if RowsAffected <= 0 then
    begin
      //BorrarTemporal('tmp_acumulado');
      Exit;
    end;

     //Cantidades periodo
    SQL.Clear;
    SQL.Add(' select d.centro_e2l centro, d.cosechero_e2l cos,d.plantacion_e2l pla, ' +
            '        d.ano_sem_planta_e2l ano_semana, producto_e2l producto, ' +
            '        SUM(d.total_cajas_e2l) cajas_per, ' +
            '        SUM(d.total_kgs_e2l) kilos_per ');
    if cbxSoloActivas.Checked then
      SQL.Add(' from frf_entradas2_l d, frf_plantaciones ')
    else
      SQL.Add(' from frf_entradas2_l d');
    SQL.Add(' where d.empresa_e2l=:empresa ');
      if Trim ( ECentro.Text ) <> '' then   
        SQL.Add('  and d.centro_e2l=:centro ');
      if Trim( EProducto.Text ) <> '' then
        SQL.Add(' and d.producto_e2l=:producto ');
    if Trim( eAgrupacion.Text ) <> '' then
      SQl.Add(' and d.producto_e2l in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');
      SQL.Add(' and d.fecha_e2l between :inicio and :fin ' +
      '  and d.cosechero_e2l between :desdecos and :hastacos ' +
      '  and d.plantacion_e2l between :desdepla and :hastapla ');
    if cbxSoloActivas.Checked then
    begin
      SQL.Add('  and ano_semana_p = ano_sem_planta_e2l ' +
        '  and empresa_p = empresa_e2l ' +
        '  and producto_p = producto_e2l ' +
        '  and cosechero_p = cosechero_e2l ' +
        '  and plantacion_p = plantacion_e2l ' +
        '  and NVL(fecha_fin_p,today) >= :inicio ' );
    end;
    case cmbPunto.ItemIndex of
      1: SQL.Add(' and ( not trim(sectores_e2l) like ''.%'' or sectores_e2l is null ) ');
      2: SQL.Add(' and ( trim(sectores_e2l) like ''.%'' and not sectores_e2l is null ) ');
    end;

    SQL.Add(' group by d.centro_e2l, d.cosechero_e2l,d.plantacion_e2l,d.ano_sem_planta_e2l, producto_e2l ' +
      ' into temp tmp_periodo ');
    ParamByName('empresa').AsString := EEmpresa.Text;
    if Trim (Ecentro.Text) <> '' then  
      ParamByName('centro').AsString := ECentro.Text;
    if Trim( EProducto.Text ) <> '' then
      ParamByName('producto').AsString := EProducto.Text;
    if Trim( EAgrupacion.Text ) <> '' then
      ParamByName('agrupacion').AsString := EAgrupacion.Text;
    ParamByName('inicio').AsDateTime := FechaInicio;
    ParamByName('fin').AsDateTime := StrToDate(MEHasta.Text);
    ParamByName('desdeCos').AsInteger := StrToInt(EDesde.text);
    ParamByName('hastaCos').AsInteger := StrToInt(EHasta.Text);
    ParamByName('desdePla').AsInteger := StrToInt(EDesde2.Text);
    ParamByName('hastaPla').Asinteger := StrToInt(EHasta2.Text);
    ExecSql;

     //Union acumulado-periodo
    SQL.Clear;
    SQL.Add(' select a.centro,a.cos,a.pla,a.ano_semana, a.producto,' +
      ' p.cajas_per,p.kilos_per, ' +
      ' a.kilos_acu ');
    if cbxProductoPerido.Checked then
      SQL.Add(' from tmp_acumulado a, tmp_periodo p ')
    else
      SQL.Add(' from tmp_acumulado a, outer tmp_periodo p ' );

    SQL.Add(' where p.cos=a.cos ' +
      '  and p.pla=a.pla ' +
      '  and p.ano_semana=a.ano_semana ' +
      '  and p.producto=a.producto ' +
      '  and p.centro=a.centro ' +
      ' into temp tmp_per_acu ');
    ExecSql;

    //BorrarTemporal('tmp_periodo');
    //BorrarTemporal('tmp_acumulado');


     //Sacar datos de los cosecheros y las plantaciones
    SQL.Clear;

    SQL.Add(' select a.centro,a.cos, c.nombre_c nom_cos, a.pla,a.ano_semana, ' +
            '        a.producto, a.cajas_per, a.kilos_per, a.kilos_acu ' +
      ' from frf_cosecheros c,tmp_per_acu a ' +
      ' where c.empresa_c= ' + QuotedStr(EEmpresa.Text) +
      '  and c.cosechero_c=a.cos ' +
      ' into temp tmp_cos ');
    ExecSql;

    SQL.Clear;
    SQL.Add(' select a.centro, a.cos, a.nom_cos, a.pla, p.descripcion_p nom_pla, ' +
      '       p.ano_semana_p ano_semana, a.producto, ' +
      '       p.superficie_p has, p.plantas_p plantas, ' +
      '       a.cajas_per, a.kilos_per, a.kilos_acu, ' +
      '       case when nvl(p.superficie_p,0) = 0 then 0 else ROUND(a.kilos_acu/p.superficie_p,1) end kilos_superficie, ' +
      '       case when nvl(p.plantas_p,0) = 0 then 0 else ROUND(a.kilos_acu/p.plantas_p,3) end kilos_planta ' +
      ' from   frf_plantaciones p, tmp_cos a ' +
      ' where  p.empresa_p= ' + QuotedStr(EEmpresa.Text) +
      '  and  p.cosechero_p=a.cos ' +
      '  and  p.producto_p = a.producto ' +
      '  and  p.ano_semana_p=a.ano_semana ' +
      '  and  p.plantacion_p=a.pla ' +
      ' order by a.cos,a.pla  ' +
      ' into temp tmp_listado');
    ExecSql;

    //BorrarTemporal('tmp_per_acu');
    //BorrarTemporal('tmp_cos');
  end;
  PreparaListado := True;
end;

end.
