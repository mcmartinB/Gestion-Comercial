unit FComercialComparativo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids, BDEdit,
  nbEdits, nbCombos;

type
  TfrmComercialComparativo = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel1: TnbLabel;
    empresa: TBDEdit;
    des_Empresa: TnbStaticText;
    des_Centro: TnbStaticText;
    centro: TBDEdit;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    producto: TBDEdit;
    des_Producto: TnbStaticText;
    anyo: TBDEdit;
    nbLabel4: TnbLabel;
    nbLabel5: TnbLabel;
    mesDesde: TBDEdit;
    des_MesDesde: TnbStaticText;
    nbLabel6: TnbLabel;
    mesHasta: TBDEdit;
    des_MesHasta: TnbStaticText;
    acumDesde: TnbDBCalendarCombo;
    nbLabel7: TnbLabel;
    cbxAcumDesde: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure mesDesdeChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure mesHastaChange(Sender: TObject);
    procedure mesDesdeExit(Sender: TObject);
    procedure cbxAcumDesdeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
  RComercialComparativo, UDMBaseDatos, bSQLUtils;

procedure TfrmComercialComparativo.FormClose(Sender: TObject;
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

procedure TfrmComercialComparativo.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmComercialComparativo.btnAceptarClick(Sender: TObject);
begin
  BEMensajes('Por favor, espere mientras se realizan los calculos ...');
  if esMes(mesDesde.Text) and esMes(mesHasta.Text) then
  begin
    if length(Trim(anyo.Text)) = 4 then
    begin
      if cbxAcumDesde.Checked then
        InformeComercialComparativo(empresa.Text, centro.Text, producto.Text,
          anyo.Text, mesDesde.Text, mesHasta.Text,
          acumDesde.Text)
      else
        InformeComercialComparativo(empresa.Text, centro.Text, producto.Text,
          anyo.Text, mesDesde.Text, mesHasta.Text, '');
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
    mesDesde.SetFocus;
  end;
  BEMensajes('');
end;

procedure TfrmComercialComparativo.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TfrmComercialComparativo.FormKeyDown(Sender: TObject; var Key: Word;
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


procedure TfrmComercialComparativo.FormCreate(Sender: TObject);
var
  year, month, day: word;
begin
  FormType := tfOther;
  BHFormulario;

  empresa.Text := gsDefEmpresa;
  centro.Text := gsDefCentro;
  producto.Text := gsDefProducto;

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
  mesDesde.Text := IntToStr(month);
  mesHasta.Text := IntToStr(month);
end;

procedure TfrmComercialComparativo.mesDesdeChange(Sender: TObject);
begin
  des_MesDesde.Caption := desMes(mesDesde.Text);
end;

procedure TfrmComercialComparativo.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TfrmComercialComparativo.productoChange(
  Sender: TObject);
begin
  des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TfrmComercialComparativo.mesHastaChange(Sender: TObject);
begin
  des_MesHasta.Caption := desMes(mesHasta.Text);
end;

procedure TfrmComercialComparativo.mesDesdeExit(Sender: TObject);
begin
  if mesHasta.CanFocus then
    mesHasta.Text := mesDesde.Text;
end;

procedure TfrmComercialComparativo.cbxAcumDesdeClick(Sender: TObject);
begin
  acumDesde.Enabled := cbxAcumDesde.Checked;
end;

end.
