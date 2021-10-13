unit CostesDeEnvasadoMensual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids, nbEdits,
  nbCombos;

type
  TFCostesDeEnvasadoMensual = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    empresa: TBEdit;
    nbLabel1: TnbLabel;
    des_empresa: TnbStaticText;
    nbLabel4: TnbLabel;
    centro: TBEdit;
    des_centro: TnbStaticText;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    fechaIni: TnbDBCalendarCombo;
    fechaFin: TnbDBCalendarCombo;
    nbLabel5: TnbLabel;
    producto: TBEdit;
    des_producto: TnbStaticText;
    lbl1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure centroChange(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure productoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
  CostesDeEnvasadoMensualReport, UDMBaseDatos, bSQLUtils;

procedure TFCostesDeEnvasadoMensual.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFCostesDeEnvasadoMensual.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFCostesDeEnvasadoMensual.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
  productoChange( producto );
end;

procedure TFCostesDeEnvasadoMensual.FormKeyDown(Sender: TObject; var Key: Word;
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
        btnCancelar.Click;
      end;
    vk_f1:
      begin
        btnAceptar.Click;
      end;
  end;
end;


procedure TFCostesDeEnvasadoMensual.FormCreate(Sender: TObject);
var
  year, month, day: word;
begin
  FormType := tfOther;
  BHFormulario;

  {des_empresa.Caption:= desEmpresa( empresa.Text );
  des_centro.Caption:= desCentro( empresa.Text, centro.Text );
  des_producto.Caption:= desProducto( empresa.Text, producto.Text );}

  empresa.Text := gsDefEmpresa;
  centro.Text := gsDefCentro;
  producto.Text := '';
  DecodeDate(Date, year, month, day);
  if month = 1 then
  begin
    year := year - 1;
    month := 12;
  end
  else
  begin
    Dec(month);
  end;
  fechaini.AsDate := Date - 7;
  fechafin.AsDate := Date;
end;

procedure TFCostesDeEnvasadoMensual.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFCostesDeEnvasadoMensual.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFCostesDeEnvasadoMensual.btnAceptarClick(Sender: TObject);
var
  dIni, dFin: TDateTime;
begin
  if des_empresa.Caption = '' then
  begin
    empresa.SetFocus;
    ShowMessage('Falta código de la empresa o es incorrecto');
  end
  else
  if des_centro.Caption = '' then
  begin
    centro.SetFocus;
    ShowMessage('Falta código del centro o es incorrecto');
  end
  else
  if des_producto.Caption = '' then
  begin
    producto.SetFocus;
    ShowMessage('Falta código del producto o es incorrecto');
  end
  else
  if not TryStrToDate( fechaIni.Text, dIni ) then
  begin
    fechaIni.SetFocus;
    ShowMessage('Falta fecha de inicio o es incorrecta');
  end
  else
  if not TryStrToDate( fechaFin.Text, dFin ) then
  begin
    fechaFin.SetFocus;
    ShowMessage('Falta fecha de fin o es incorrecta');
  end
  else
  if dIni > dFin then
  begin
    fechaIni.SetFocus;
    ShowMessage('Rango de fechas incorrecto');
  end
  else
  begin
    QRCostesDeEnvasadoMensualPrint(Empresa.Text, Centro.Text, Producto.Text,
      FechaIni.AsDate, FechaFin.AsDate);
  end;
end;

procedure TFCostesDeEnvasadoMensual.productoChange(Sender: TObject);
begin
  if producto.Text = '' then
  begin
    des_producto.Caption := 'TODOS LOS PRODUCTOS';
  end
  else
  begin
    des_producto.Caption := desproducto(empresa.Text, producto.Text);
  end;
end;

end.
