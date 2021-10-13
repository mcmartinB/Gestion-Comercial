unit AprovechaInicializarAjuste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, BEdit, nbLabels;

type
  TFAprovechaInicializarAjuste = class(TForm)
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
    fechaHasta: TBEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fecha_desdeChange(Sender: TObject);
  private
    { Private declarations }
    sLunes, sDomingo: string;
    dDesde: TDate;
    function  RangoValidos: Boolean;
    procedure ComprobarFechaLiquidacion;
  public
    { Public declarations }
  end;

implementation

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, UDMBaseDatos,
  bSQLUtils, bMath, DB, DBTables, bDialogs, DError, UEscandallosUC,
  DateUtils;

{$R *.dfm}

procedure TFAprovechaInicializarAjuste.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFAprovechaInicializarAjuste.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFAprovechaInicializarAjuste.FormCreate(Sender: TObject);
var
  fecha: TDate;
begin
  Top := 1;
  FormType := tfOther;
  BHFormulario;

  empresa.Text := '050';
  centro.Text := '1';
  producto.Text := 'T';

  fecha := date;
  while DayOfWeek(fecha) <> 1 do fecha := fecha - 1;
  fecha_desde.Text := DateToStr(fecha - 6);
end;

procedure TFAprovechaInicializarAjuste.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFAprovechaInicializarAjuste.ComprobarFechaLiquidacion;
var
  dFecha, dLiquida: TDateTime;
begin
  dFecha:= StrToDate( fecha_desde.Text );
  dLiquida:= GetFechaUltimaLiquidacion( empresa.Text, centro.Text, producto.Text );
  if dFecha < dLiquida then
  begin
    ShowMessage('No se puede inicializar un ajuste con fecha anterior a la ultima liquidación definitiva (' +
                DateToStr( dLiquida ) +  ').');
    Abort;
  end;
end;

procedure TFAprovechaInicializarAjuste.btnAceptarClick(Sender: TObject);
begin
  if RangoValidos then
  begin
    ComprobarFechaLiquidacion;

    InicializarAprovechamientos(empresa.Text, centro.Text, producto.Text, dDesde);
    //InsertarEnvento(  RellenaEnvento( 4, 'M', empresa.Text, centro.Text,
    //          producto.Text, sLunes, sDomingo, ''));
    Informar(' Proceso finalizado con éxito. ');
  end;
end;

procedure TFAprovechaInicializarAjuste.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFAprovechaInicializarAjuste.productoChange(Sender: TObject);
begin
  des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFAprovechaInicializarAjuste.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

function TFAprovechaInicializarAjuste.RangoValidos: Boolean;
begin
  result := false;
  //Comprobar que las fechas sean correctas
  try
    dDesde := StrToDate(fecha_desde.Text);
  except
    fecha_desde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  if DayOfTheWeek(dDesde) <> 1 then
  begin
    fecha_desde.SetFocus;
    ShowMessage('El dia de inicio debe ser Lunes.');
    Exit;
  end;
  sDomingo := DateToStr(dDesde + 6);
  sLunes := fecha_desde.Text;
  result := true;
end;

procedure TFAprovechaInicializarAjuste.FormActivate(Sender: TObject);
begin
  Top := 10;
end;

procedure TFAprovechaInicializarAjuste.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFAprovechaInicializarAjuste.fecha_desdeChange(Sender: TObject);
var
  dFecha: TDatetime;
begin
  if TryStrToDate( fecha_desde.Text, dFecha ) then
  begin
    fechaHasta.Text:= DateToStr( dFecha + 6 )
  end
  else
  begin
    fechaHasta.Text:= '';
  end;
end;

end.


