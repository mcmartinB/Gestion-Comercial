unit ResumenProduccionFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, BEdit, nbLabels, DB, DBTables, BSpeedButton,
  BCalendarButton, ComCtrls, BCalendario, Grids, DBGrids, BGrid,
  BGridButton;

type
  TFDResumenProduccion = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel1: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    des_empresa: TnbStaticText;
    des_producto: TnbStaticText;
    empresa: TBEdit;
    producto: TBEdit;
    fecha_desde: TBEdit;
    nbLabel2: TnbLabel;
    centro: TBEdit;
    des_centro: TnbStaticText;
    nbLabel6: TnbLabel;
    fecha_hasta: TBEdit;
    CalendarioFlotante: TBCalendario;
    btnDesde: TBCalendarButton;
    btnHasta: TBCalendarButton;
    RejillaFlotante: TBGrid;
    btnEmpresa: TBGridButton;
    btnCentro: TBGridButton;
    btnProducto: TBGridButton;
    btnAyuda: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure empresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure centroChange(Sender: TObject);

    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAyudaClick(Sender: TObject);
    procedure btnDesdeClick(Sender: TObject);
    procedure btnHastaClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro, sProducto: string;
    dIni, dFin: TDateTime;

    function ParametrosOk: Boolean;
    function GetTextoAyuda: string;

  public
    { Public declarations }

  end;



implementation

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, DateUtils,
     ResumenProduccionDM, UFAyuda, CAuxiliarDB, UDMBaseDatos;

{$R *.dfm}


procedure TFDResumenProduccion.FormCreate(Sender: TObject);
var
  fecha: TDate;
begin

  (*
  qryKilosRet.SQL.Clear;
  qryKilosRet.SQL.Add(' SELECT sum(kilos_sl) kilos ');
  qryKilosRet.SQL.Add(' FROM FRF_SALIDAS_L ');
  qryKilosRet.SQL.Add(' WHERE EMPRESA_SL = :empresa ');
  qryKilosRet.SQL.Add(' AND PRODUCTO_SL  = :producto ');
  qryKilosRet.SQL.Add(' AND CENTRO_ORIGEN_SL = :centro ');
  qryKilosRet.SQL.Add(' AND FECHA_SL BETWEEN :fechaini AND :fechafin ');
  qryKilosRet.SQL.Add(' and ( cliente_sl = ''RET'' or cliente_sl[1,1] = ''0'' ) ');
  *)
  
  Top := 1;
  FormType := tfOther;
  BHFormulario;


  empresa.Tag := kEmpresa;
  centro.Tag := kCentro;
  producto.Tag := kProducto;

  empresa.Text := gsDefEmpresa;
  centro.Text := gsDefCentro;
  producto.Text := '';

  fecha_desde.Tag := kCalendar;
  fecha_hasta.Tag := kCalendar;

  gRF := RejillaFlotante;
  CalendarioFlotante.Date := Date;


  fecha_desde.Text := DateToStr(date - 1);
  fecha_hasta.Text := DateToStr(date - 1);
  (*
  fecha := date;
  while DayOfWeek(fecha) <> 1 do fecha := fecha - 1;
  fecha_desde.Text := DateToStr(fecha - 6);
  *)
end;

procedure TFDResumenProduccion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFDResumenProduccion.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización

  if (CalendarioFlotante <> nil) then
    if (CalendarioFlotante.Visible) then
            //No hacemos nada
      Exit;

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
    vk_escape:
      begin
        btnCancelar.Click
      end;
    vk_f1:
      begin
        btnAceptar.Click
      end;
  end;
end;

procedure TFDResumenProduccion.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F2:
      begin
        btnEmpresaClick( Sender );
      end;
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;


procedure TFDResumenProduccion.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
  centroChange( centro );
  productoChange( producto );
end;

procedure TFDResumenProduccion.productoChange(Sender: TObject);
begin
  if producto.Text = '' then
    des_producto.Caption := 'TODOS LOS PRODUCTOS.'
  else
    des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFDResumenProduccion.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFDResumenProduccion.FormActivate(Sender: TObject);
begin
  Top := 10;
  gCF := CalendarioFlotante;
end;

function TFDResumenProduccion.ParametrosOK: Boolean;
begin
  result := false;

  if des_empresa.Caption = '' then
  begin
    empresa.SetFocus;
    ShowMessage('Empresa incorrecta.');
    Exit;
  end;
  sEmpresa:= empresa.Text;

  if des_centro.Caption = '' then
  begin
    centro.SetFocus;
    ShowMessage('Centro incorrecto.');
    Exit;
  end;
  sCentro:= centro.Text;

  if des_producto.Caption = '' then
  begin
    producto.SetFocus;
    ShowMessage('Producto incorrecto.');
    Exit;
  end;
  sProducto:= producto.Text;

  if not tryStrToDate( fecha_desde.Text, dIni ) then
  begin
    fecha_desde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  if not tryStrToDate( fecha_hasta.Text, dFin ) then
  begin
    fecha_hasta.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  if dFin < dIni then
  begin
    fecha_desde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;
  result := true;
end;

procedure TFDResumenProduccion.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDResumenProduccion.btnAceptarClick(Sender: TObject);
var
  sAux: string;
begin
  if ParametrosOk then
  begin
    if not ExecuteAprovechaResumen( self, sEmpresa, sCentro, sProducto, dIni, dFin, sAux ) then
      ShowMessage( sAux );
  end;
  BEMensajes('');
end;

procedure TFDResumenProduccion.btnAyudaClick(Sender: TObject);
begin
  UFAyuda.ExecuteAyuda( self, GetTextoAyuda );
  //UFAyudaWeb.ExecuteAyudaWeb( self, 'C:/Comercializacion/Ayuda/AprovechaResumen.txt' );
end;

function TFDResumenProduccion.GetTextoAyuda: string;
begin
  result:= '';
end;

procedure TFDResumenProduccion.btnDesdeClick(Sender: TObject);
begin
  DespliegaCalendario(btnDesde);
end;

procedure TFDResumenProduccion.btnHastaClick(Sender: TObject);
begin
  DespliegaCalendario(btnHasta);
end;

procedure TFDResumenProduccion.btnEmpresaClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [empresa.Text]);
    kProducto: DespliegaRejilla(btnProducto, [empresa.Text]);
  end;
end;

end.



