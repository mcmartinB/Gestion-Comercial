unit UFLConfecPorAgrupacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, BEdit, nbLabels;

type
  TFLConfecPorAgrupacion = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    des_empresa: TnbStaticText;
    des_centro: TnbStaticText;
    des_producto: TnbStaticText;
    empresa: TBEdit;
    centro: TBEdit;
    producto: TBEdit;
    fechaDesde: TBEdit;
    fechaHasta: TBEdit;
    nbLabel5: TnbLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    dDesde, dHasta: TDate;

    function RangoValidos: Boolean;
  public
    { Public declarations }
  end;

implementation

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, UDMBaseDatos,
  DPreview, UQLConfecPorAgrupacion;

{$R *.dfm}

procedure TFLConfecPorAgrupacion.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLConfecPorAgrupacion.FormClose(Sender: TObject;
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

procedure TFLConfecPorAgrupacion.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  empresa.Text := '050';
  centro.Text := '1';
  producto.Text := 'TOM';

  fechaDesde.Text := DateToStr(Date - 1);
  fechaHasta.Text := DateToStr(Date - 1);
end;

procedure TFLConfecPorAgrupacion.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLConfecPorAgrupacion.btnAceptarClick(Sender: TObject);
begin
  if RangoValidos then
  begin
    UQLConfecPorAgrupacion.Visualizar(empresa.Text, centro.Text, producto.Text, dDesde, dHasta);
  end;
end;

function TFLConfecPorAgrupacion.RangoValidos: Boolean;
begin
  result := false;
  //Comprobar que las fechas sean correctas
  try
    dDesde := StrToDate(fechaDesde.Text);
  except
    fechaDesde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  try
    dHasta := StrToDate(fechaHasta.Text);
  except
    fechaHasta.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  if dHasta < dDesde then
  begin
    fechaDesde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;
  result := true;
end;

procedure TFLConfecPorAgrupacion.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFLConfecPorAgrupacion.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFLConfecPorAgrupacion.productoChange(Sender: TObject);
begin
  des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFLConfecPorAgrupacion.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

end.
