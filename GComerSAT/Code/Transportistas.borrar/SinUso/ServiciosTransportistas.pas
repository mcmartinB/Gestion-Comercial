unit ServiciosTransportistas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids, nbEdits,
  nbCombos;

type
  TFServiciosTransportistas = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    empresa: TBEdit;
    nbLabel1: TnbLabel;
    des_empresa: TnbStaticText;
    lblCentro: TnbLabel;
    centro: TBEdit;
    des_centro: TnbStaticText;
    lblProducto: TnbLabel;
    producto: TBEdit;
    des_producto: TnbStaticText;
    lblDesde: TnbLabel;
    lblHasta: TnbLabel;
    desde: TnbDBCalendarCombo;
    hasta: TnbDBCalendarCombo;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables,
  ServiciosTransportistasReport;

procedure TFServiciosTransportistas.FormClose(Sender: TObject;
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

procedure TFServiciosTransportistas.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFServiciosTransportistas.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFServiciosTransportistas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  {des_empresa.Caption:= desEmpresa( empresa.Text );
  des_centro.Caption:= desCentro( empresa.Text, centro.Text );
  des_producto.Caption:= desProducto( empresa.Text, producto.Text );}

  empresa.Text := '050';
  centro.Text := '1';
  //producto.Text:= 'T';
  desde.Text := DateToStr(Date - 1);
  hasta.Text := DateToStr(Date - 1);
end;

procedure TFServiciosTransportistas.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFServiciosTransportistas.productoChange(Sender: TObject);
begin
  des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFServiciosTransportistas.btnAceptarClick(Sender: TObject);
begin
  TQRServiciosTransportistasReport.Ejecutar(empresa.Text, centro.Text, producto.Text,
    desde.AsDate, hasta.AsDate);
end;

procedure TFServiciosTransportistas.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFServiciosTransportistas.FormKeyDown(Sender: TObject; var Key: Word;
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
    vk_f1:
      begin
        btnAceptar.Click;
      end;
  end;
end;

end.
