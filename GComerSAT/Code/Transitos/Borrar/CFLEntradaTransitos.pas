unit CFLEntradaTransitos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils, DBCtrls, DBTables;

type
  TFLEntradaTransitos = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label1: TLabel;
    edtEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    BGBCentro: TBGridButton;
    edtCentro: TBEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtProducto: TBEdit;
    BGBProducto: TBGridButton;
    STProducto: TStaticText;
    BCBDesde: TBCalendarButton;
    edtDesde: TBEdit;
    Desde: TLabel;
    Label14: TLabel;
    edtHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    qryTransitos: TQuery;
    chkSinEntrada: TCheckBox;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);

  private
    sEmpresa, sCentro, sProducto: string;
    dFechainicio, dFechafin: TDateTime;

    function  LeerParametros: Boolean;
    function  AbrirTabla: Boolean;
    procedure CerrarTabla;
    procedure VisualizarListado;
  public

  end;


implementation

uses UDMAuxDB, Principal, CVariables, DPreview,
     CQREntradaTransitos, CAuxiliarDB, UDMBaseDatos,
     bDialogs, bTimeUtils, CReportes;

{$R *.DFM}

//                       ****  BOTONES  ****

function  TFLEntradaTransitos.LeerParametros: Boolean;
begin
  result:= False;

  if STEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa.');
    Exit;
  end;
  sEmpresa := Trim(edtEmpresa.Text);

  if STCentro.Caption = '' then
  begin
    ShowMessage('Falta el código del centro.');
    Exit;
  end;
  sCentro := edtCentro.Text;

  if STProducto.Caption = '' then
  begin
    ShowMessage('Falta el código del producto.');
    Exit;
  end;
  sProducto := Trim(edtProducto.Text);

  if not TryStrToDate( edtDesde.Text, dFechainicio ) then
  begin
    ShowMessage('Fecha de inicio incorrecta');
    Exit;
  end;
  if not TryStrToDate( edtHasta.Text, dFechafin ) then
  begin
    ShowMessage('Fecha de fin incorrecta');
    Exit;
  end;
  if dFechainicio > dFechafin then
  begin
    ShowMessage('La fecha de fin debe ser meyor que la de inicio. ');
    Exit;
  end;

  result:= True;
end;

function TFLEntradaTransitos.AbrirTabla: Boolean;
begin
  with qryTransitos do
  begin
    SQL.Clear;
    SQL.Add('select fecha_tc, referencia_tc, centro_destino_tc, fecha_entrada_dda_dac, transporte_tc, vehiculo_tc, buque_tc, ');
    SQL.Add('       naviera_tc, puerto_tc, n_orden_tc, carpeta_deposito_tc, producto_tl, tipo_palet_tl, envase_tl, ');
    SQL.Add('       sum(cajas_tl) cajas_tl, sum(kilos_tl) kilos_tl, sum(palets_tl) palets_tl ');

    SQL.Add('from frf_transitos_c left join frf_depositos_aduana_c on empresa_tc = empresa_dac and centro_tc = centro_dac ');
    SQL.Add('                                                           and fecha_tc = fecha_dac and referencia_tc = referencia_dac ');
    SQL.Add('                          join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl ');
    SQL.Add('                                                           and fecha_tc = fecha_tl and referencia_tc = referencia_tl ');

    SQL.Add('where empresa_tc = :empresa ');
    SQL.Add('and centro_tc = :centro ');
    if chkSinEntrada.Checked then
    begin
      SQL.Add('and ( ( fecha_entrada_dda_dac between :fecha_ini and :fecha_fin ) ');
      SQL.Add('       or ( fecha_entrada_dda_dac is null and fecha_tc between :fecha_corte and :fecha_fin ) ) ');
    end
    else
    begin
      SQL.Add('and ( fecha_entrada_dda_dac between :fecha_ini and :fecha_fin ) ');
    end;
    if sProducto <> '' then
       SQL.Add('and producto_tl = :producto ');

    SQL.Add('group by fecha_tc, referencia_tc, centro_destino_tc, fecha_entrada_dda_dac, transporte_tc, vehiculo_tc, buque_tc, ');
    SQL.Add('       naviera_tc, puerto_tc, n_orden_tc, carpeta_deposito_tc, producto_tl, tipo_palet_tl, envase_tl ');
    SQL.Add('order by fecha_tc desc, referencia_tc ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    if sProducto <> '' then
      ParamByName('producto').AsString:= sProducto;
    if chkSinEntrada.Checked then
      ParamByName('fecha_corte').AsDate:= dFechainicio-30;
    ParamByName('fecha_ini').AsDate:= dFechainicio;
    ParamByName('fecha_fin').AsDate:= dFechafin;
    Open;
    result:= not IsEmpty;
    if not Result then
      Close;
  end;
end;

procedure TFLEntradaTransitos.CerrarTabla;
begin
  qryTransitos.Close;
end;

procedure TFLEntradaTransitos.VisualizarListado;
var
  QREntradaTransitos: TQREntradaTransitos;
begin
  QREntradaTransitos:= TQREntradaTransitos.Create( Self );
  try
    PonLogoGrupoBonnysa( QREntradaTransitos, edtEmpresa.Text );
    QREntradaTransitos.ReportTitle:= 'ENTRADA DE TRANSITOS EN DEPOSITO DE ADUANAS';
    QREntradaTransitos.sEmpresa:= edtEmpresa.Text;
    QREntradaTransitos.lblCentro.Caption:= edtCentro.Text + ' ' + STCentro.Caption;
    QREntradaTransitos.lblProducto.Caption:= Trim( edtProducto.Text + ' ' + STProducto.Caption );
    QREntradaTransitos.lblRango.Caption:= 'Entrada DDA del ' + edtDesde.Text + ' al ' + edtHasta.Text;
    Preview( QREntradaTransitos );
  except
    FreeAndNil( QREntradaTransitos );
    raise;
  end;
end;

procedure TFLEntradaTransitos.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;
  if LeerParametros then
  begin
    if AbrirTabla then
    begin
      try
        VisualizarListado;
      finally
        CerrarTabla;
      end;
    end;
  end;
end;

procedure TFLEntradaTransitos.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

//                          **** FORMULARIO ****

procedure TFLEntradaTransitos.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  edtEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  edtProducto.Tag := kProducto;
  edtDesde.Tag := kCalendar;
  edtHasta.Tag := kCalendar;  

  edtProducto.Text:= '';
  edtCentro.Text := '6';
  edtEmpresa.Text := '050';
  PonNombre(edtEmpresa);
  edtDesde.Text := DateTostr(LunesAnterior(Date) - 7);
  edtHasta.Text := DateTostr(LunesAnterior(Date) - 1);
  CalendarioFlotante.Date := Date;
end;

procedure TFLEntradaTransitos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLEntradaTransitos.FormClose(Sender: TObject;
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

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLEntradaTransitos.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(BGBCentro, [edtEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [edtEmpresa.Text]);
    kCalendar:
      begin
        if edtDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLEntradaTransitos.PonNombre(Sender: TObject);
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
       STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
       PonNombre( edtCentro );
       PonNombre( edtProducto );
    end;
    kCentro:
       STCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text);
    kProducto:
    begin
      if edtProducto.Text = '' then
      begin
        STProducto.Caption := 'TODOS LOS PRODUCTOS';
      end
      else
      begin
        STProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
      end;
    end;
  end;
end;

end.
