unit EnvasesSinCosteEnvasado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids;

type
  TFEnvasesSinCosteEnvasado = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    empresa: TBEdit;
    anyo: TBEdit;
    mes: TBEdit;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    des_empresa: TnbStaticText;
    des_mes: TnbStaticText;
    nbLabel4: TnbLabel;
    centro: TBEdit;
    des_centro: TnbStaticText;
    lblProducto: TnbLabel;
    edtProducto: TBEdit;
    des_producto: TnbStaticText;
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
    procedure centroChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro, sProducto: string;
    iAnyo, iMes: Integer;

    function ValidarParametros: Boolean;
    procedure PrevisualizarListado;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
  EnvasesSinCosteEnvasadoReport, UDMBaseDatos, bSQLUtils;

procedure TFEnvasesSinCosteEnvasado.FormClose(Sender: TObject;
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

procedure TFEnvasesSinCosteEnvasado.FormCreate(Sender: TObject);
var
  year, month, day: word;
begin
  FormType := tfOther;
  BHFormulario;

  empresa.Text := gsDefEmpresa;
  centro.Text := gsDefCentro;
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

procedure TFEnvasesSinCosteEnvasado.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFEnvasesSinCosteEnvasado.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFEnvasesSinCosteEnvasado.btnAceptarClick(Sender: TObject);
begin
  if ValidarParametros then
    PrevisualizarListado;
end;

function TFEnvasesSinCosteEnvasado.ValidarParametros: Boolean;
begin
  Result:= False;
  if esMes(mes.Text) then
  begin
    if length(Trim(anyo.Text)) = 4 then
    begin
      if des_empresa.Caption = '' then
      begin
        ShowMessage('Falta el código de la empresa o es incorrecto.');
        empresa.SetFocus;
      end
      else
      if des_centro.Caption = '' then
      begin
        ShowMessage('Falta el código del centro o es incorrecto.');
        centro.SetFocus;
      end
      else
      if des_producto.Caption = '' then
      begin
        ShowMessage('Falta el código del producto o es incorrecto.');
        centro.SetFocus;
      end
      else
      begin
        sEmpresa:= empresa.Text;
        sCentro:= centro.Text;
        sProducto:= edtProducto.Text;
        iAnyo:= StrToInt(anyo.Text);
        iMes:= StrToInt( mes.Text);
        Result:= True;
      end;
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

procedure TFEnvasesSinCosteEnvasado.PrevisualizarListado;
begin
  ShowMessage('Programa en desarrollo');
  //QREnvasesSinCostePrint(sEmpresa, sCentro, sProducto, iAnyo, iMes );
end;

procedure TFEnvasesSinCosteEnvasado.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFEnvasesSinCosteEnvasado.mesChange(Sender: TObject);
begin
  des_mes.Caption := desMes(mes.Text);
end;

procedure TFEnvasesSinCosteEnvasado.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFEnvasesSinCosteEnvasado.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFEnvasesSinCosteEnvasado.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text = '' then
    des_producto.Caption := 'TODOS LOS PRODUCTOS'
  else
    des_producto.Caption := desProducto(empresa.Text, edtProducto.Text);
end;

end.
