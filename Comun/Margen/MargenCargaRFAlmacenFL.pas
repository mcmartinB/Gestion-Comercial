unit MargenCargaRFAlmacenFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, nbButtons,
  nbEdits, nbCombos, BSpeedButton, BCalendarButton, ComCtrls, BCalendario,
  Grids, DBGrids, DB, DBTables, kbmMemTable, BGridButton, BGrid;

type
  TFLMargenCargaRFAlmacen = class(TForm)
    lblCodigo1: TnbLabel;
    edtEmpresa: TBEdit;
    btnMargen: TButton;
    edtCostesFinancierosCargados: TBEdit;
    lblDesEmpresa: TLabel;
    RejillaFlotante: TBGrid;
    btnEmpresa: TBGridButton;
    lblCodigo4: TnbLabel;
    edtDesde: TnbDBCalendarCombo;
    lblCodigo5: TnbLabel;
    edtHasta: TnbDBCalendarCombo;
    lblCodigo6: TnbLabel;
    edtProducto: TBEdit;
    btnProducto: TBGridButton;
    lblCodigo7: TnbLabel;
    lblDesProducto: TLabel;
    mmo1: TMemo;
    btnCancelar: TButton;
    pnlTipo: TPanel;
    rbStock: TRadioButton;
    rbCarga: TRadioButton;
    rbVolcado: TRadioButton;
    rbDestrio: TRadioButton;
    rbTodo: TRadioButton;
    lbl1: TLabel;
    chkVariedad: TCheckBox;
    chkCategoria: TCheckBox;
    chkCalibre: TCheckBox;
    lblCodigo2: TnbLabel;
    edtCostesFinancierosVolcados: TBEdit;
    lblCodigo3: TnbLabel;
    edtAnyoSemana: TBEdit;
    lblEntrega: TnbLabel;
    edtEntrega: TBEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    rbConsumido: TRadioButton;
    Label1: TLabel;
    cbbVerTransitos: TComboBox;
    lblCodigo8: TnbLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMargenClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure rbStockClick(Sender: TObject);

  private
    iTipo, iVerTransitos: Integer;
    sEmpresa, sProducto, sSemana, sEntrega: string;
    rFinancierosCargados, rFinancierosVolcados: Real;
    dFechaIni, dFechaFin: TDateTime;
    bFechaIni, bFechaFin: Boolean;

    function ValidarParametros: Boolean;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     CAuxiliarDB, bMath, MargenCargaRFAlmacenDL;

var
  DLMargenCargaRFAlmacen: TDLMargenCargaRFAlmacen;

procedure TFLMargenCargaRFAlmacen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  FreeAndNil(DLMargenCargaRFAlmacen);
  Action := caFree;
end;

procedure TFLMargenCargaRFAlmacen.FormCreate(Sender: TObject);
var
  dFecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;


  DLMargenCargaRFAlmacen := TDLMargenCargaRFAlmacen.Create(self);


  edtEmpresa.Tag:= kEmpresa;
  edtEmpresa.Text:= 'BAG';
  edtProducto.Tag:= kProducto;
  edtProducto.Text:= 'KIW';
  dFecha:= LunesAnterior( Now );
  edtHasta.AsDate:= dFecha - 1;
  edtDesde.AsDate:= dFecha - 7;
  edtHasta.Text:= '';
  edtDesde.Text:= '';

  edtEntrega.Text:= 'F17115-21387';
  edtCostesFinancierosCargados.Text:= '0,027';
  edtCostesFinancierosVolcados.Text:= '0,042';

  edtCostesFinancierosCargados.Text:= '';
  edtCostesFinancierosVolcados.Text:= '';
  edtCostesFinancierosCargados.Enabled:= False;
  edtCostesFinancierosVolcados.Enabled:= False;
end;

procedure TFLMargenCargaRFAlmacen.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLMargenCargaRFAlmacen.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLMargenCargaRFAlmacen.FormKeyDown(Sender: TObject; var Key: Word;
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
        btnMargen.Click;
      end;
  end;
end;

function TFLMargenCargaRFAlmacen.ValidarParametros: Boolean;
begin
  if edtEmpresa.Text = '' then
  begin
    raise Exception.Create('Falta el código de la empresa.');
  end;
  if lblDesEmpresa.Caption = '' then
  begin
    raise Exception.Create('El código de la empresa es incorrrecto.');
  end;
  if edtProducto.Text = '' then
  begin
    raise Exception.Create('Falta el código del producto.');
  end;
  if lblDesProducto.Caption = '' then
  begin
    raise Exception.Create('El código del producto es incorrrecto.');
  end;


  if ( edtAnyoSemana.Text <> '' ) and ( Length( edtAnyoSemana.Text ) <> 6 ) then
  begin
    raise Exception.Create('El año/semana debe de tener 6 digitos.');
  end
  else
  begin
    sSemana:= edtAnyoSemana.Text;
  end;
  if ( edtEntrega.Text <> '' ) and ( Length( edtEntrega.Text ) <> 12 ) then
  begin
    raise Exception.Create('El año/semana debe de tener 12 digitos.');
  end
  else
  begin
    sEntrega:= edtEntrega.Text;
  end;

  if not TryStrToDate( edtDesde.Text, dFechaIni ) then
  begin
    if not rbStock.Checked then
    begin
      if ( sSemana = '' ) and  ( sEntrega = '' ) then
        raise Exception.Create('Falta la fecha de inicio o es incorrrecta.')
    end
    else
      bFechaIni:= false;
  end
  else
  begin
    bFechaIni:= True;
  end;
  if not TryStrToDate( edtHasta.Text, dFechaFin ) then
  begin
    if not rbStock.Checked then
    begin
      if ( sSemana = '' ) and  ( sEntrega = '' ) then
        raise Exception.Create('Falta la fecha de fin o es incorrrecta.')
    end
    else
      bFechaFin:= false;
  end
  else
  begin
    bFechaFin:= True;
  end;
  if bFechaFin and bFechaIni then
  begin
     if dFechaIni > dFechaFin then
     begin
        raise Exception.Create('Rango de fechas incorrecto ');
     end
  end;


  if edtEmpresa.Text = '' then
    sEmpresa:= 'BAG'
  else
    sEmpresa:= edtEmpresa.Text;
  sProducto:= edtProducto.Text;
  rFinancierosCargados:= StrToFloatDef( edtCostesFinancierosCargados.Text,0 );
  rFinancierosVolcados:= StrToFloatDef( edtCostesFinancierosVolcados.Text,0 );


  if rbStock.Checked then
  begin
    iTipo:= MargenCargaRFAlmacenDL.kiStock;
  end
  else
  if rbCarga.Checked then
  begin
    iTipo:= MargenCargaRFAlmacenDL.kiCarga;
  end
  else
  if rbVolcado.Checked then
  begin
    iTipo:= MargenCargaRFAlmacenDL.kiVolcado;
  end
  else
  if rbDestrio.Checked then
  begin
    iTipo:= MargenCargaRFAlmacenDL.kiDestrio;
  end
  else
  if rbConsumido.Checked then
  begin
    iTipo:= MargenCargaRFAlmacenDL.kiConsumido;
  end
  else
  if rbTodo.Checked then
  begin
    iTipo:= MargenCargaRFAlmacenDL.kiTodo;
  end;

  iVerTransitos:= cbbVerTransitos.ItemIndex;

  Result:= True;
end;

procedure TFLMargenCargaRFAlmacen.btnMargenClick(Sender: TObject);
begin
  if ValidarParametros then
  begin
      DLMargenCargaRFAlmacen.ValorarFrutaProveedorRFAlmacen( iTipo, iVerTransitos, sEmpresa, sProducto, sSemana, sEntrega,
        bFechaIni, bFechaFin, dFechaIni, dFechaFin, rFinancierosCargados, rFinancierosVolcados,
        chkVariedad.Checked, chkCategoria.Checked, chkCalibre.Checked );
  end;
end;

procedure TFLMargenCargaRFAlmacen.btnEmpresaClick(Sender: TObject);
begin
  if ActiveControl <> nil then
  case ActiveControl.Tag of
    kEmpresa:
      begin
        DespliegaRejilla(btnEmpresa);
      end;
    kProducto:
      begin
        DespliegaRejilla(btnProducto, [edtEmpresa.Text])
      end;
  end;
end;

procedure TFLMargenCargaRFAlmacen.edtEmpresaChange(Sender: TObject);
begin
  if ( edtEmpresa.Text = '' )  then
  begin
    lblDesEmpresa.Caption:= 'Por favor selecione una planta.';
  end
  else
  if ( edtEmpresa.Text = 'BAG' ) then
  begin
    lblDesEmpresa.Caption:= 'Plantas  F17, F23, F24, F42';
  end
  else
  begin
    lblDesEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
  end;
  edtProductoChange( edtProducto );
end;

procedure TFLMargenCargaRFAlmacen.edtProductoChange(Sender: TObject);
begin
  if ( edtProducto.Text = '' )  then
  begin
    lblDesProducto.Caption:= 'Por favor selecione un producto.';
  end
  else
  begin
    lblDesProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
  end;
end;

procedure TFLMargenCargaRFAlmacen.rbStockClick(Sender: TObject);
begin
  cbbVerTransitos.Enabled:= rbCarga.Checked or rbConsumido.Checked or rbTodo.Checked;
end;

end.
