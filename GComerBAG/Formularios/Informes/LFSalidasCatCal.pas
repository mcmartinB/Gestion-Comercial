unit LFSalidasCatCal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, BEdit, Buttons, BSpeedButton, BGridButton, ExtCtrls,
  BCalendarButton, Grids, DBGrids, BGrid, ComCtrls, BCalendario, ActnList,
  Db, DBTables;

type
  TFLSalidasCatCal = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    ADesplegarRejilla: TAction;
    ACancelar: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    QDatos: TQuery;
    QBorrarTablaTemporal: TQuery;
    Label1: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    Label5: TLabel;
    CentroD: TBEdit;
    Label6: TLabel;
    CentroH: TBEdit;
    Label2: TLabel;
    edtProducto: TBEdit;
    Desde: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label14: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label4: TLabel;
    edtCliente: TBEdit;
    stCliente: TLabel;
    stProducto: TLabel;
    procedure BAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    emp: string;
    centro_d, centro_h: string;
    fecha_d, fecha_h: string;
    producto: string;
    cliente: string;

    procedure RecogerDatos;
    function Temporal: boolean;
    function Listado: boolean;
  public
    { Public declarations }
  end;

//var
//  FLSalidasCatCal: TFLSalidasCatCal;

implementation

uses CAuxiliarDB, cVariables, UDMAuxDB, LSalidasCatCal, DPreview,
  UDMBaseDatos, CGestionPrincipal, CReportes, Principal;

{$R *.DFM}

procedure TFLSalidasCatCal.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
  
  EEmpresa.Tag := kEmpresa;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  edtProducto.Tag := kProducto;
  edtCliente.Tag := kCliente;

  EEmpresa.Text:= gsDefEmpresa;
  CentroD.Text:= gsDefCentro;
  CentroH.Text:= gsDefCentro;
  edtProducto.Text:= gsDefProducto;
  MEDesde.Text:= DateToStr( Date - 6 );
  MEHasta.Text:= DateToStr( Date );
  edtCliente.Text:= '';

  calendarioFlotante.Date:= Date;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

end;

procedure TFLSalidasCatCal.FormClose(Sender: TObject;
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

  action := caFree;
end;

procedure TFLSalidasCatCal.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLSalidasCatCal.BAceptarExecute(Sender: TObject);
begin

  RecogerDatos;

  Temporal;

  Listado;

  try
    QBorrarTablaTemporal.ExecSQL;
  except
    //ya vorem
  end;

end;

procedure TFLSalidasCatCal.RecogerDatos;
begin

  emp := EEmpresa.Text;
  centro_d := CentroD.Text;
  centro_h := centroH.Text;
  fecha_d := MEDesde.Text;
  fecha_h := MEHasta.Text;
  producto := edtProducto.Text;
  cliente := edtCliente.Text;

end;

function TFLSalidasCatCal.Temporal: boolean;
begin
  //pasar los parametros y abir la temporal;
  with QDatos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl, cliente_sl, categoria_sl categoria, calibre_sl calibre, sum(kilos_sl)kilos, sum(importe_neto_sl)importe, ');
    SQL.Add(' year(fecha_sl)anyo, month(fecha_sl)mes, producto_sl producto ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where (empresa_sl= :emp) ');
    SQL.Add(' and   (centro_origen_sl between :ctr_d and :ctr_h) ');
    SQL.Add(' and   (fecha_sl between :fec_d and :fec_h) ');
    SQL.Add(' and empresa_sc = empresa_sl ');
    SQL.Add(' and centro_salida_sc = centro_salida_sl ');
    SQL.Add(' and n_albaran_sc = n_albaran_sl ');
    SQL.Add(' and fecha_sc = fecha_sl ');
    SQL.Add(' and es_transito_sc <> 2 ');         //Tipo Salida: Devolucion
    if producto <> '' then
      SQL.Add(' and   (producto_sl = :producto) ');
    if cliente <> '' then
      SQL.Add(' and   (cliente_sl = :cliente) ')
    else
      SQL.Add(' and   (cliente_sl <> ''RET'') ');

    SQL.Add(' group by empresa_sl, cliente_sl, producto_sl, categoria_sl, calibre_sl, fecha_sl ');
    SQL.Add(' order by cliente_sl, categoria_sl, calibre_sl ');
    SQL.Add(' into temp cat_cal ');


    ParamByName('emp').AsString := emp;
    ParamByName('ctr_d').AsString := centro_d;
    ParamByName('ctr_h').AsString := centro_h;
    ParamByName('fec_d').AsString := fecha_d;
    ParamByName('fec_h').AsString := fecha_h;
    if cliente <> '' then
      ParamByName('cliente').AsString := cliente;
    if producto <> '' then
      ParamByName('producto').AsString := producto;
    ExecSQL;
  end;
  result := false;
end;

function TFLSalidasCatCal.Listado: boolean;
begin
  result := false;


  //Llamada al report que mostrara el informe
  QRLSalidasCatCal := TQRLSalidasCatCal.Create(Application);
  PonLogoGrupoBonnysa(QRLSalidasCatCal, EEmpresa.Text);

  with QRLSalidasCatCal.QListado do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_sl ||'' ''|| nombre_c cliente, anyo, mes, producto, ');
    SQL.Add(' categoria, calibre, sum(kilos) kilos, sum(importe) importe ');
    SQL.Add(' from cat_cal, frf_clientes ');
    SQL.Add(' where cliente_c = cliente_sl ');
    SQL.Add(' group by 1, anyo, mes, producto, categoria, calibre ');
    SQL.Add(' order by 1, producto, anyo, mes,  categoria, calibre ');
  end;

  QRLSalidasCatCal.QListado.Open;

  QRLSalidasCatCal.lblCentros.Caption:= RangoCentros( EEmpresa.Text, CentroD.Text, CentroH.Text );
  if edtProducto.Text = '' then
    QRLSalidasCatCal.lblProductos.Caption:= 'TODOS LOS PRODUTOS'
  else
    QRLSalidasCatCal.lblProductos.Caption:= edtProducto.Text + ' '  + desProducto( EEmpresa.Text, edtProducto.Text );

  QRLSalidasCatCal.lblRango.Caption:= RangoFechas( MEDesde.Text, MEHasta.Text );

  Preview(QRLSalidasCatCal);
end;

procedure TFLSalidasCatCal.ACancelarExecute(Sender: TObject);
begin
  if cerrarform(false) then Close;
end;

procedure TFLSalidasCatCal.PonNombre(Sender: TObject);
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
      PonNombre( edtCliente );
      PonNombre( edtProducto );
    end;
    kCliente:
    begin
      if edtCliente.Text <> '' then
      begin
        stCliente.Caption := desCliente(edtCliente.Text);
      end
      else
      begin
        stCliente.Caption := 'Vacio saca todos los clientes';
      end;
    end;
    kProducto:
    begin
      if edtProducto.Text <> '' then
      begin
        stProducto.Caption := desProducto(Eempresa.Text,edtProducto.Text);
      end
      else
      begin
        stProducto.Caption := 'Vacio saca todos los productos';
      end;
    end;
  end;
end;

procedure TFLSalidasCatCal.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLSalidasCatCal.FormActivate(Sender: TObject);
begin
  Top := 10;
end;

end.
