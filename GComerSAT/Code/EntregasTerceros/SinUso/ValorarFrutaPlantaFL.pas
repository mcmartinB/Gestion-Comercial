unit ValorarFrutaPlantaFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit;

type
  TFLValorarFrutaPlanta = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    stEmpresa: TLabel;
    stCentro: TLabel;
    eEmpresa: TnbDBSQLCombo;
    eCentro: TnbDBSQLCombo;
    cbxVariedad: TCheckBox;
    Label3: TLabel;
    cbxCalibre: TCheckBox;
    nbLabel1: TnbLabel;
    eProducto: TnbDBSQLCombo;
    stProducto: TLabel;
    nbLabel3: TnbLabel;
    eEntregaDesde: TBEdit;
    nbLabel4: TnbLabel;
    eEntregaHasta: TBEdit;
    lblStatus: TLabel;
    lblTipoFacturas: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function  eProductoGetSQL: String;
    function  eCentroGetSQL: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eEmpresaChange(Sender: TObject);
    procedure eCentroChange(Sender: TObject);
    procedure cbxVariedadClick(Sender: TObject);
    procedure eProductoChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, UDMConfig, ValorarFrutaPlantaQL;

procedure TFLValorarFrutaPlanta.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  eEmpresa.Text:= gsDefEmpresa;
  eCentro.Text:= gsDefCentro;
end;

procedure TFLValorarFrutaPlanta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLValorarFrutaPlanta.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLValorarFrutaPlanta.ValidarCampos;
begin
  if Trim(eEmpresa.Text) = '' then
  begin
    eEmpresa.SetFocus;
    raise Exception.Create('Falta el codigo de la empresa que es de obligada inserción.');
  end
  else
  begin
    if stEmpresa.Caption = '' then
    begin
      eEmpresa.SetFocus;
      raise Exception.Create('El codigo de la empresa es incorrecto.');
    end;
  end;

  if Trim(eCentro.Text) = '' then
  begin
    eCentro.SetFocus;
    raise Exception.Create('Falta el codigo del centro que es de obligada inserción.');
  end
  else
  begin
    if stCentro.Caption = '' then
    begin
      eCentro.SetFocus;
      raise Exception.Create('El codigo del centro es incorrecto.');
    end;
  end;

  if Trim( eEntregaDesde.Text ) = '' then
  begin
    eEntregaDesde.SetFocus;
    raise Exception.Create('Falta el código de la  entrega inicial.');
  end;

  if Trim( eEntregaHasta.Text ) = '' then
  begin
    eEntregaHasta.SetFocus;
    raise Exception.Create('Falta el código de la  entrega final.');
  end;

  if stProducto.Caption = '' then
  begin
    eProducto.SetFocus;
    raise Exception.Create('El codigo del producto es incorrecto.');
  end;
end;


procedure TFLValorarFrutaPlanta.btnImprimirClick(Sender: TObject);
begin
  Label3.Visible:= True;
  Application.ProcessMessages;
  try
    ValidarCampos;
    if not ValorarFrutaPlantaQL.VerListadoStock( self, Trim(eEmpresa.Text), Trim(eCentro.Text),
      Trim(eProducto.Text), Trim(eEntregaDesde.Text), Trim(eEntregaHasta.Text), cbxVariedad.Checked, cbxCalibre.Checked ) then
      ShowMEssage('Sin Stock para los parametros usados.');
  finally
    Label3.Visible:= False;
    Application.ProcessMessages;
  end;
end;

function TFLValorarFrutaPlanta.eProductoGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select producto_p, descripcion_p from frf_productos where empresa_p = ' +
             eEmpresa.GetSQLText + ' order by producto_p'
  else
    result:= 'select producto_p, descripcion_p from frf_productos order by producto_p';
end;



function TFLValorarFrutaPlanta.eCentroGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             eEmpresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

procedure TFLValorarFrutaPlanta.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLValorarFrutaPlanta.eEmpresaChange(Sender: TObject);
begin
  if Trim(eEmpresa.Text) = '' then
  begin
    stEmpresa.Caption:= '(Falta código de la empresa)';
  end
  else
  begin
    stEmpresa.Caption:= desEmpresa( eEmpresa.Text );
  end;

  eCentroChange( eCentro );
end;

procedure TFLValorarFrutaPlanta.eCentroChange(Sender: TObject);
begin
  if Trim(eCentro.Text) = '' then
  begin
    stCentro.Caption:= '(Falta código del centro)';
  end
  else
  begin
    stCentro.Caption:= desCentro( eEmpresa.Text, eCentro.Text );
  end;
end;

procedure TFLValorarFrutaPlanta.eProductoChange(Sender: TObject);
begin
  if Trim(eProducto.Text) = '' then
  begin
    stProducto.Caption:= '(Vacio =Todos los productos)';
  end
  else
  begin
    stProducto.Caption:= desProducto( eEmpresa.Text, eProducto.Text );
  end;
end;

procedure TFLValorarFrutaPlanta.cbxVariedadClick(Sender: TObject);
begin
  cbxCalibre.Enabled:= cbxVariedad.Checked;
  if not cbxCalibre.Enabled then
    cbxCalibre.Checked:= False;
end;


procedure TFLValorarFrutaPlanta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  if eEntregaDesde.Focused or eEntregaHasta.Focused then
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
  end;
end;

end.
