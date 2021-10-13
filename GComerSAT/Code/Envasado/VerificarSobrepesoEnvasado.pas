unit VerificarSobrepesoEnvasado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids;

type
  TFVerificarSobrepesoEnvasado = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    empresa: TBEdit;
    anyo: TBEdit;
    mes: TBEdit;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    des_empresa: TnbStaticText;
    des_mes: TnbStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure mesChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
  VerificarSobrepesoEnvasadoReport, UDMBaseDatos, bSQLUtils;

procedure TFVerificarSobrepesoEnvasado.FormClose(Sender: TObject;
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

procedure TFVerificarSobrepesoEnvasado.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFVerificarSobrepesoEnvasado.btnAceptarClick(Sender: TObject);
begin
  if esMes(mes.Text) then
  begin
    if length(Trim(anyo.Text)) = 4 then
    begin
      QRVerificarSobrepesoEnvasadoPrint(empresa.Text, anyo.Text, mes.Text);
    end
    else
    begin
      ShowMessage('El año debe tener 4 digitos.');
      anyo.SetFocus;
    end;
  end
  else
  begin
    ShowMessage('Valor para el mes incorrecto.');
    mes.SetFocus;
  end;
end;

procedure TFVerificarSobrepesoEnvasado.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFVerificarSobrepesoEnvasado.FormKeyDown(Sender: TObject; var Key: Word;
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


procedure TFVerificarSobrepesoEnvasado.FormCreate(Sender: TObject);
var
  year, month, day: word;
begin
  FormType := tfOther;
  BHFormulario;

  {des_empresa.Caption:= desEmpresa( empresa.Text );
  des_centro.Caption:= desCentro( empresa.Text, centro.Text );
  des_producto.Caption:= desProducto( empresa.Text, producto.Text );}

  empresa.Text := '050';
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
  anyo.Text := IntToStr(year);
  mes.Text := IntToStr(month);
end;

procedure TFVerificarSobrepesoEnvasado.mesChange(Sender: TObject);
begin
  des_mes.Caption := desMes(mes.Text);
end;

procedure TFVerificarSobrepesoEnvasado.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

end.
