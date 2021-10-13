unit SobrepesosPeriodoFD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton,
  DBTables;

type
  TFDSobrepesosPeriodo = class(TForm)
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
    cbbTipo: TComboBox;
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

  private
    { Private declarations }
    function ValidarParametros: Boolean;
    procedure ObtenerDatos;
    procedure PrevisualizarInforme;
  public
    { Public declarations }
    sEmpresa, sCentro, sProducto: string;
    dIni, dFin: TDateTime;
  end;

implementation

uses UDMAuxDB, CVariables, Principal, UDMBaseDatos, CReportes,
  CAuxiliarDB, SobrepesosPeriodoQR, DPreview, bTimeUtils, DateUtils;


{$R *.DFM}

procedure TFDSobrepesosPeriodo.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFDSobrepesosPeriodo.ValidarParametros: Boolean;
begin
  Result:= False;

  //Comprobar parametros de entrada
  if STEmpresa.Caption = '' then
  begin
    MessageDlg('Falta o código de empresa incorrecto', mtError, [mbOk], 0);
    EEmpresa.SetFocus;
    Exit;
  end;

  if stCentro.Caption = '' then
  begin
    MessageDlg('Falta o código de centro incorrecto', mtError, [mbOk], 0);
    ECentro.SetFocus;
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
  scentro:= ECentro.Text;
  sproducto:= EProducto.Text;

  result:= True;
end;

procedure TFDSobrepesosPeriodo.PrevisualizarInforme;
var
  QRSobrepesosPeriodo: TQRSobrepesosPeriodo;
begin
  QRSobrepesosPeriodo:= TQRSobrepesosPeriodo.Create( Application );
  try
    QRSobrepesosPeriodo.qrlblCentro.Caption:= stcentro.Caption;
    QRSobrepesosPeriodo.qrlblPeriodo.Caption:= 'Del ' + MEDesde.Text + ' al ' + MEHasta.Text;
    QRSobrepesosPeriodo.qrlblEmpresa.Caption:= STEmpresa.Caption;
    PonLogoGrupoBonnysa( QRSobrepesosPeriodo );
    Preview( QRSobrepesosPeriodo );
  except
    FreeAndNil( QRSobrepesosPeriodo );
  end;
end;

procedure TFDSobrepesosPeriodo.ObtenerDatos;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    if ( cbbTipo.ItemIndex = 0 ) or ( cbbTipo.ItemIndex = 1 ) then
    begin
    SQL.Add(' select  ''S'' tipo, empresa_sl empresa, centro_salida_sl centro, ');
    SQL.Add('        producto_sl producto, ( select descripcion_p from frf_productos ');
    SQL.Add('                                where producto_p = producto_sl ) des_producto, ');
    SQL.Add('        envase_sl envase, ( select descripcion_e from frf_envases ');
    SQL.Add('                                where envase_e = envase_sl ) des_envase, ');
    SQL.Add('        sum(cajas_sl) cajas, sum(kilos_sl) kilos, ');
{
    SQL.Add('                case when ( select (s1.peso_es)
    SQL.Add('                  from frf_env_sobrepeso s1
    SQL.Add('                  where s1.empresa_es = empresa_sl
    SQL.Add('                    and s1.envase_Es = envase_sl
    SQL.Add('                    and s1.producto_Es = producto_sl
    SQL.Add('                    and s1.anyo_es = year(fecha_sl)
    SQL.Add('                    and s1.mes_es = month(fecha_sl) ) is not null then

    SQL.Add('        		( select (s1.peso_es)
    SQL.Add('        		          from frf_env_sobrepeso s1
    SQL.Add('        		          where s1.empresa_es = empresa_sl
    SQL.Add('        		            and s1.envase_Es = envase_sl
    SQL.Add('        		            and s1.producto_Es = producto_sl
    SQL.Add('        		            and s1.anyo_es = year(fecha_sl)
    SQL.Add('        		            and s1.mes_es = month(fecha_sl) )
    SQL.Add('        	else

    SQL.Add('        		nvl(( select (s1.peso_es)
    SQL.Add('        		          from frf_env_sobrepeso s1
    SQL.Add('        		          where s1.empresa_es = empresa_sl
    SQL.Add('        		            and s1.envase_Es = envase_sl
    SQL.Add('        		            and s1.producto_Es = producto_sl
    SQL.Add('        		            and ( s1.anyo_es * 100 + s1.mes_es ) = ( select max(s2.anyo_es * 100 + s2.mes_es ) from frf_env_sobrepeso s2
    SQL.Add('                                                   where s2.empresa_es = empresa_sl and s2.envase_Es = envase_sl )  ), 0)

    SQL.Add('        	end porcentaje_sobrepeso ,
}
    SQL.Add('         round(sum( kilos_sl *                                                                                                      ');
    SQL.Add('                (	 case when ( select (s1.peso_es)                                                                                 ');
    SQL.Add('                  from frf_env_sobrepeso s1                                                                                         ');
    SQL.Add('                  where s1.empresa_es = empresa_sl                                                                                  ');
    SQL.Add('                    and s1.envase_Es = envase_sl                                                                                    ');
    SQL.Add('                    and s1.producto_Es = producto_sl                                                                                ');
    SQL.Add('                    and s1.anyo_es = year(fecha_sl)                                                                                 ');
    SQL.Add('                    and s1.mes_es = month(fecha_sl) ) is not null then                                                              ');

    SQL.Add('        		( select (s1.peso_es)                                                                                                    ');
    SQL.Add('        		          from frf_env_sobrepeso s1                                                                                      ');
    SQL.Add('        		          where s1.empresa_es = empresa_sl                                                                               ');
    SQL.Add('        		            and s1.envase_Es = envase_sl                                                                                 ');
    SQL.Add('        		            and s1.producto_Es = producto_sl                                                                             ');
    SQL.Add('        		            and s1.anyo_es = year(fecha_sl)                                                                              ');
    SQL.Add('        		            and s1.mes_es = month(fecha_sl) )                                                                            ');
    SQL.Add('        	else                                                                                                                       ');

    SQL.Add('        		nvl( (select (s1.peso_es)                                                                                                ');
    SQL.Add('        		          from frf_env_sobrepeso s1                                                                                      ');
    SQL.Add('        		          where s1.empresa_es = empresa_sl                                                                               ');
    SQL.Add('        		            and s1.envase_Es = envase_sl                                                                                 ');
    SQL.Add('        		            and s1.producto_Es = producto_sl                                                                             ');
    SQL.Add('        		            and ( s1.anyo_es * 100 + s1.mes_es ) = ( select max(s2.anyo_es * 100 + s2.mes_es ) from frf_env_sobrepeso s2 ');
    SQL.Add('                                                   where s2.empresa_es = empresa_sl and s2.envase_Es = envase_sl )), 0 )            ');

    SQL.Add('        	end ) / 100), 2) sobrepeso ');

    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and fecha_sl between :fechaini and :fechafin ');
    SQL.Add(' and centro_salida_sl = :centro ');
    if sProducto <> '' then
      SQL.Add(' and producto_sl = :producto ');

    SQL.Add(' and empresa_sc = empresa_sl ');
    SQL.Add(' and centro_salida_sc = centro_salida_sl ');
    SQL.Add(' and n_albaran_sc = n_albaran_sl ');
    SQL.Add(' and fecha_sc = fecha_sl ');
    SQL.Add(' and es_transito_sc <> 2 ');                     //Tipo Salida: Devolucion

    SQL.Add(' group by tipo, empresa_sl, centro_salida_sl, producto_sl, des_producto, envase_sl, des_envase ');
    end;
    if ( cbbTipo.ItemIndex = 0 ) then
    begin
    SQL.Add('  union ');
    end;
    if ( cbbTipo.ItemIndex = 0 ) or ( cbbTipo.ItemIndex = 2 ) then
    begin
    SQL.Add('  select ''T'' tipo, empresa_tl empresa, centro_tl centro, ');
    SQL.Add('          producto_tl producto, ( select descripcion_p from frf_productos ');
    SQL.Add('                                  where producto_p = producto_tl ) des_producto, ');
    SQL.Add('          envase_tl envase, ( select descripcion_e from frf_envases ');
    SQL.Add('                                  where envase_e = envase_tl ) des_envase, ');
    SQL.Add('          sum(cajas_tl) cajas, sum(kilos_tl) kilos, ');
{
    SQL.Add('                case when ( select (s1.peso_es)
    SQL.Add('                  from frf_env_sobrepeso s1
    SQL.Add('                  where s1.empresa_es = empresa_tl
    SQL.Add('                    and s1.envase_Es = envase_tl
    SQL.Add('                    and s1.producto_Es = producto_tl
    SQL.Add('                    and s1.anyo_es = year(fecha_tl)
    SQL.Add('                    and s1.mes_es = month(fecha_tl) ) is not null then

    SQL.Add('        		( select (s1.peso_es)
    SQL.Add('        		          from frf_env_sobrepeso s1
    SQL.Add('        		          where s1.empresa_es = empresa_tl
    SQL.Add('        		            and s1.envase_Es = envase_tl
    SQL.Add('        		            and s1.producto_Es = producto_tl
    SQL.Add('        		            and s1.anyo_es = year(fecha_tl)
    SQL.Add('        		            and s1.mes_es = month(fecha_tl) )
    SQL.Add('        	else

    SQL.Add('        		nvl(( select (s1.peso_es)
    SQL.Add('        		          from frf_env_sobrepeso s1
    SQL.Add('        		          where s1.empresa_es = empresa_tl
    SQL.Add('        		            and s1.envase_Es = envase_tl
    SQL.Add('        		            and s1.producto_Es = producto_tl
    SQL.Add('        		            and ( s1.anyo_es * 100 + s1.mes_es ) = ( select max(s2.anyo_es * 100 + s2.mes_es ) from frf_env_sobrepeso s2
    SQL.Add('                                                   where s2.empresa_es = empresa_tl and s2.envase_Es = envase_tl )  ), 0)

    SQL.Add('        	end porcentaje_sobrepeso ,
}
    SQL.Add('         round(sum( kilos_tl *                                                                                                      ');
    SQL.Add('                (	 case when ( select (s1.peso_es)                                                                                 ');
    SQL.Add('                  from frf_env_sobrepeso s1                                                                                         ');
    SQL.Add('                  where s1.empresa_es = empresa_tl                                                                                  ');
    SQL.Add('                    and s1.envase_Es = envase_tl                                                                                    ');
    SQL.Add('                    and s1.producto_Es = producto_tl                                                                                ');
    SQL.Add('                    and s1.anyo_es = year(fecha_tl)                                                                                 ');
    SQL.Add('                    and s1.mes_es = month(fecha_tl) ) is not null then                                                              ');

    SQL.Add('        		( select (s1.peso_es)                                                                                                    ');
    SQL.Add('        		          from frf_env_sobrepeso s1                                                                                      ');
    SQL.Add('        		          where s1.empresa_es = empresa_tl                                                                               ');
    SQL.Add('        		            and s1.envase_Es = envase_tl                                                                                 ');
    SQL.Add('        		            and s1.producto_Es = producto_tl                                                                             ');
    SQL.Add('        		            and s1.anyo_es = year(fecha_tl)                                                                              ');
    SQL.Add('        		            and s1.mes_es = month(fecha_tl) )                                                                            ');
    SQL.Add('        	else                                                                                                                       ');

    SQL.Add('        		nvl( (select (s1.peso_es)                                                                                                ');
    SQL.Add('        		          from frf_env_sobrepeso s1                                                                                      ');
    SQL.Add('        		          where s1.empresa_es = empresa_tl                                                                               ');
    SQL.Add('        		            and s1.envase_Es = envase_tl                                                                                 ');
    SQL.Add('        		            and s1.producto_Es = producto_tl                                                                             ');
    SQL.Add('        		            and ( s1.anyo_es * 100 + s1.mes_es ) = ( select max(s2.anyo_es * 100 + s2.mes_es ) from frf_env_sobrepeso s2 ');
    SQL.Add('                                                   where s2.empresa_es = empresa_tl and s2.envase_Es = envase_tl )), 0 )            ');

    SQL.Add('        	end ) / 100), 2) sobrepeso ');

    SQL.Add('   from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and fecha_tl between :fechaini and :fechafin ');
    SQL.Add(' and centro_tl = :centro ');
    if sProducto <> '' then
      SQL.Add(' and producto_tl = :producto ');

    SQL.Add('   group by tipo, empresa_tl, centro_tl, producto_tl, des_producto, envase_tl, des_envase ');
    end;
    SQL.Add('   order by tipo, empresa, centro, producto, envase ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
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

procedure TFDSobrepesosPeriodo.BBAceptarClick(Sender: TObject);
var
  sema: string;
  dFechaIni, dFechaFin: TDateTime;
  fec: TDate;
begin
  if not CerrarForm(true) then
    Exit;

  if ValidarParametros then
    ObtenerDatos;
end;

procedure TFDSobrepesosPeriodo.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFDSobrepesosPeriodo.FormCreate(Sender: TObject);
var
  dFecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

  EEmpresa.Text := '050';
  ECentro.Text := '1';
  EProducto.Text:= '';

  dFecha:= LunesAnterior( Date ) - 7;
  MEDesde.Text:= DateToStr( dFEcha );
  MEHasta.Text:= DateToStr( dFEcha + 6 );
end;

procedure TFDSobrepesosPeriodo.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDSobrepesosPeriodo.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFDSobrepesosPeriodo.EEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  ECentroChange( ECentro );
  EProductoChange( EProducto );
end;

procedure TFDSobrepesosPeriodo.EProductoChange(Sender: TObject);
begin
  if EProducto.Text <> '' then
    STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text)
  else
    STProducto.Caption := 'TODOS LOS PRODUCTOS';
end;

procedure TFDSobrepesosPeriodo.ECentroChange(Sender: TObject);
begin
  stCentro.Caption := desCentro( Eempresa.Text, ECentro.Text );
end;

end.
