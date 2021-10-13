unit VerificarCosteEnvasado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids;

type
  TFVerificarCosteEnvasado = class(TForm)
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
    nbLabel4: TnbLabel;
    centro: TBEdit;
    des_centro: TnbStaticText;
    nbLabel5: TnbLabel;
    cbxTipoCoste: TComboBox;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
  VerificarCosteEnvasadoReport, UDMBaseDatos, bSQLUtils,
  VerificarCosteEnvasadoData;

procedure TFVerificarCosteEnvasado.FormClose(Sender: TObject;
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

procedure TFVerificarCosteEnvasado.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFVerificarCosteEnvasado.btnAceptarClick(Sender: TObject);
var
  iAnyo, iMes: Integer;
begin
  if esMes(mes.Text) then
  begin
    iMes:= StrToInt( mes.Text );
    if length(Trim(anyo.Text)) = 4 then
    begin
      iAnyo:= StrToInt( anyo.Text );
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
      begin
        if VerificarCosteEnvasadoData.LoadData( empresa.Text, centro.Text, iAnyo, iMes ) then
        begin
          try
            QRVerificarCosteEnvasadoPrint(empresa.Text, centro.Text, anyo.Text, mes.Text, cbxTipoCoste.ItemIndex );
          finally
            VerificarCosteEnvasadoData.FreeData;
          end;
        end
        else
        begin
          VerificarCosteEnvasadoData.FreeData;
        end;
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

procedure TFVerificarCosteEnvasado.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFVerificarCosteEnvasado.FormKeyDown(Sender: TObject; var Key: Word;
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


procedure TFVerificarCosteEnvasado.FormCreate(Sender: TObject);
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

procedure TFVerificarCosteEnvasado.mesChange(Sender: TObject);
begin
  des_mes.Caption := desMes(mes.Text);
end;

procedure TFVerificarCosteEnvasado.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFVerificarCosteEnvasado.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

end.
