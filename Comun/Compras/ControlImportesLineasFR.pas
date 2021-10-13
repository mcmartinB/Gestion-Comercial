unit ControlImportesLineasFR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids,
  BSpeedButton, BCalendarButton, ComCtrls, BCalendario, ActnList,
  BGridButton, BGrid;

type
  TFRControlImportesLineas = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    edtAnyoSemana: TBEdit;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    des_empresa: TnbStaticText;
    nbLabel4: TnbLabel;
    edtAlmacen: TBEdit;
    des_almacen: TnbStaticText;
    lblProducto: TnbLabel;
    edtProducto: TBEdit;
    des_producto: TnbStaticText;
    CalendarioFlotante: TBCalendario;
    edtFechaIni: TBEdit;
    btnFechaIni: TBCalendarButton;
    edtFechaFin: TBEdit;
    btnFechaFin: TBCalendarButton;
    lblCodigo1: TnbLabel;
    lblCodigo2: TnbLabel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    rejillaFlotante: TBGrid;
    btnEmpresa: TBGridButton;
    btnProducto: TBGridButton;
    btnAlmacen: TBGridButton;
    lblCliente: TnbLabel;
    edtProveedor: TBEdit;
    btnProveedor: TBGridButton;
    des_proveedor: TnbStaticText;
    lblCodigo3: TnbLabel;
    edtEntrega: TBEdit;
    edtMaxDiferencia: TBEdit;
    cbbVer: TComboBox;
    chkVerAlmacen: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtAlmacenChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure edtProveedorChange(Sender: TObject);
  private
    { Private declarations }
    { Private declarations }
    sEmpresa, sProveedor, sAlmacen, sProducto, sAnyoSemana, sEntrega: string;
    dFechaIni, dFechaFin: TDateTime;
    iTipo: Integer;
    rMaxDif: Real;

    function ValidarParametros: Boolean;
    function RangoFechas( var VMsg: string ): Boolean;
    function Tipo( var VMsg: string ): Boolean;
    procedure PrevisualizarListado;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CAuxiliarDB, UDMAuxDB, Principal, CGestionPrincipal, CVariables, CGlobal,
     bTimeUtils, UDMBaseDatos, ControlImportesLineasQR;

procedure TFRControlImportesLineas.FormClose(Sender: TObject;
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

procedure TFRControlImportesLineas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag:= kEmpresa;
  edtProveedor.Tag:= kProveedor;
  edtAlmacen.Tag:= kProveedorAlmacen;
  edtProducto.Tag:= kProducto;

  //edtEmpresa.Text := gsDefEmpresa;
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
  begin
    edtEmpresa.Text := 'BAG';
  end
  else
  begin
    edtEmpresa.Text := 'SAT';
  end;
  //edtCentro.Text := gsDefCentro;
  edtFechaIni.Tag := kCalendar;
  edtFechaFin.Tag := kCalendar;
  edtFechaIni.Text := DateTostr(Date-7);
  edtFechaFin.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;
  gCF := calendarioFlotante;
  edtMaxDiferencia.Text:= '0,5';

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
end;

procedure TFRControlImportesLineas.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFRControlImportesLineas.btnAceptarClick(Sender: TObject);
begin
  if ValidarParametros then
    PrevisualizarListado;
end;

function TFRControlImportesLineas.Tipo( var VMsg: string ): Boolean;
begin
  VMsg:= '';
  Result:= True;
  iTipo:= cbbVer.ItemIndex;

  if iTipo = 0 then
  begin
    rMaxDif:= 0;
  end
  else
  if ( iTipo = 1 ) or ( iTipo = 2 ) then
  begin
    rMaxDif:= StrToFloatDef( edtMaxDiferencia.Text, 0 );
  end
  else
  begin
    VMsg:= 'Tipo de entrada a visualizar no valido.';
    Result:= False;
  end;
end;

function TFRControlImportesLineas.RangoFechas( var VMsg: string ): Boolean;
begin
  VMsg:= '';
  Result:= False;
  if not TryStrToDate( edtFechaIni.Text, dFechaini ) then
  begin
    VMsg:= 'Fecha de inicio incorrecto.'
  end
  else
  if not TryStrToDate( edtFechaFin.Text, dFechafin ) then
  begin
    VMsg:= 'Fecha de fin incorrecto.'
  end
  else
  if dFechaini > dFechaFin then
  begin
    VMsg:= 'Rango de fechas incorrecto.'  end
  else
  begin
    Result:= True;
  end;
end;

function TFRControlImportesLineas.ValidarParametros: Boolean;
var
  sMsg: string;
begin
  Result:= False;
  if des_empresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
  end
  else
  if not RangoFechas( sMsg ) then
  begin
    ShowMessage( sMsg );
  end
  else
  if des_producto.Caption = '' then
  begin
    ShowMessage('El código del producto es incorrecto.');
  end
  else
  if des_proveedor.Caption = '' then
  begin
    ShowMessage('El código del proveedor es incorrecto.');
  end
  else
  if des_almacen.Caption = '' then
  begin
    ShowMessage('El código del almacén es incorrecto.');
  end
  else
  if ( Length( Trim(edtAnyoSemana.Text) ) > 0 ) and ( Length( Trim(edtAnyoSemana.Text) ) <> 6 ) then
  begin
    ShowMessage('El año/semana debe de tener 6 digitos "AAAASS".');
  end
  else
  if ( Length( Trim(edtEntrega.Text) ) > 0 ) and ( Length( Trim(edtEntrega.Text) ) <> 12 ) then
  begin
    ShowMessage('El codigo de la entrega debe de tener 12 caracteres.');
  end
  else
  if not Tipo ( sMsg ) then
  begin
    ShowMessage( sMsg );
  end
  else
  begin
    sEmpresa:= Trim( edtEmpresa.Text );
    sProducto:= Trim( edtProducto.Text );
    sProveedor:= Trim( edtProveedor.Text );
    sAlmacen:= Trim( edtAlmacen.Text );
    sAnyoSemana:= Trim( edtAnyoSemana.Text );
    sEntrega:= Trim( edtEntrega.Text );
    Result:= True;
  end;
end;

procedure TFRControlImportesLineas.PrevisualizarListado;
begin
  ControlImportesLineasQR.PreviewReporte( sEmpresa, sProducto, sProveedor, sAlmacen, sAnyoSemana, sEntrega, dFechaIni, dFechaFin, iTipo, rMaxDif, chkVerAlmacen.Checked  );
end;

procedure TFRControlImportesLineas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFRControlImportesLineas.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFRControlImportesLineas.ADesplegarRejillaExecute(Sender: TObject);
var
  sEmpresa: string;
begin
    if edtEmpresa.Text  = 'BAG' then
    begin
      sEmpresa:= 'F17';
    end
    else
    if edtEmpresa.Text  = 'SAT' then
    begin
      sEmpresa:= '050';
    end
    else
    begin
      sEmpresa:= edtEmpresa.Text;
    end;

  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProveedor: DespliegaRejilla(btnProveedor, [sEmpresa]);
    kProveedorAlmacen: DespliegaRejilla(btnAlmacen, [sEmpresa, edtProveedor.Text]);
    kProducto: DespliegaRejilla(btnProducto, [sEmpresa]);
    kCalendar:
      begin
        if edtFechaIni.Focused then
          DespliegaCalendario(btnFechaIni)
        else
          DespliegaCalendario(btnFechaFin);
      end;
  end;
end;

procedure TFRControlImportesLineas.edtEmpresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(edtEmpresa.Text);
  edtProveedor.OnChange( edtProveedor );
  edtProducto.OnChange( edtProducto );
end;

procedure TFRControlImportesLineas.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text = '' then
    des_producto.Caption := 'TODOS LOS PRODUCTOS'
  else
    des_producto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
end;

procedure TFRControlImportesLineas.edtProveedorChange(Sender: TObject);
begin
  if edtProveedor.Text = '' then
    des_proveedor.Caption := 'TODOS LOS PROVEEDORES'
  else
  begin
    if edtEmpresa.Text = 'BAG' then
      des_proveedor.Caption := desProveedor('F17', edtProveedor.Text)
    else
    if edtEmpresa.Text = 'SAT' then
      des_proveedor.Caption := desProveedor('050', edtProveedor.Text)
    else
      des_proveedor.Caption := desProveedor(edtEmpresa.Text, edtProveedor.Text);
  end;
  edtAlmacenChange( edtAlmacen );
end;

procedure TFRControlImportesLineas.edtAlmacenChange(Sender: TObject);
begin
  if edtAlmacen.Text = '' then
    des_almacen.Caption := 'TODOS LOS ALMACENES DE PROVEEDOR'
  else
  begin
    if Trim( edtProveedor.Text ) = '' then
    begin
      des_almacen.Caption := 'FALTA PROVEEDOR'
    end
    else
    if edtEmpresa.Text  = 'BAG' then
    begin
      des_almacen.Caption := desProveedorAlmacen('F17',  edtProveedor.Text, edtAlmacen.Text);
    end
    else
    if edtEmpresa.Text  = 'SAT' then
    begin
      des_almacen.Caption := desProveedorAlmacen('050',  edtProveedor.Text, edtAlmacen.Text);
    end
    else
    begin
      des_almacen.Caption := desProveedorAlmacen(edtEmpresa.Text,  edtProveedor.Text, edtAlmacen.Text);
    end;
  end;
end;

end.
