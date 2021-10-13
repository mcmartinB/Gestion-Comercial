unit ListEntregasFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit;

type
  TFLListEntregas = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    edtFechaDesde: TBEdit;
    edtFechaHasta: TBEdit;
    lblEmpresa: TnbLabel;
    lblFechaDesde: TnbLabel;
    etqEmpresa: TnbStaticText;
    lblFechaHasta: TnbLabel;
    lblProveedor: TnbLabel;
    edtProveedor: TBEdit;
    etqProveedor: TnbStaticText;
    lblProducto: TnbLabel;
    edtProducto: TBEdit;
    etqProducto: TnbStaticText;
    cbxDetalle: TCheckBox;
    cbxObservacion: TCheckBox;
    nbLabel1: TnbLabel;
    edtAlmacen: TBEdit;
    etqAlmacen: TnbStaticText;
    edtAdjudicacion: TBEdit;
    Label4: TLabel;
    nbLabel3: TnbLabel;
    edtCentro: TBEdit;
    etqCentro: TnbStaticText;
    cbxStatus: TComboBox;
    nbLabel4: TnbLabel;
    cbxPacking: TCheckBox;
    cbxResumen: TCheckBox;
    cbxBorrados: TCheckBox;
    cmbEntrega: TComboBox;
    lblMercado: TnbLabel;
    cbxMercado: TComboBox;
    chkAgruparAlmacen: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtProveedorChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure edtAlmacenChange(Sender: TObject);
    procedure edtCentroChange(Sender: TObject);
    procedure cbxPackingClick(Sender: TObject);
  private
    { Private declarations }
    function ValidarEntrada: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
  ListEntregasQL, EntregasCB, DB, UDMConfig;

procedure TFLListEntregas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;

  ListEntregasQL.UnloadReport;
end;

procedure TFLListEntregas.FormCreate(Sender: TObject);
var
  fecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text := gsDefEmpresa;
(*
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select proveedor_p ');
    SQL.Add(' from frf_proveedores ');
    SQL.Add(' order by proveedor_p ');
    Open;
    edtProveedor.Text := Fields[0].AsString;
    Close;
  end;
*)
  fecha:= LunesAnterior( Date );
  edtFechaDesde.Text := DateToStr(fecha - 7);
  edtFechaHasta.Text := DateToStr(fecha - 1);

  ListEntregasQL.LoadReport( Self );

  cbxPacking.Visible:= not ( DMConfig.EsLaFont );
  cbxResumen.Visible:= cbxPacking.Visible;
  cbxBorrados.Visible:= cbxPacking.Visible;

  //if ( DMConfig.EsValenciaBonde or DMConfig.EsTenerifeBonde ) then
  (*
  begin
    lblMercado.Visible:= True;
    lblMercado.Caption:= 'Venta Directa';
    cbxMercado.Visible:= True;
    cbxMercado.Items.Clear;
    cbxMercado.Items.Add('INDIFERENTE');
    cbxMercado.Items.Add('PRODUCTO PROCESADO');
    cbxMercado.Items.Add('VENTA DIRECTA');
    cbxMercado.ItemIndex:= 0;
  end
  else
  if ( DMConfig.sEmpresaInstalacion = '037' ) and ( DMConfig.sCentroInstalacion = '6' ) then
  begin
    lblMercado.Visible:= True;
    lblMercado.Caption:= 'Tipo Mercado';
    cbxMercado.Visible:= True;
    cbxMercado.Items.Clear;
    cbxMercado.Items.Add('INDIFERENTE');
    cbxMercado.Items.Add('MERCADO EXTERIOR');
    cbxMercado.Items.Add('MERCADO LOCAL');
    cbxMercado.ItemIndex:= 0;
  end
  else
  begin
    lblMercado.Visible:= False;
    cbxMercado.Visible:= False;
  end;
  *)
end;

procedure TFLListEntregas.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLListEntregas.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLListEntregas.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
  edtCentroChange( edtCentro );
  edtProveedorChange( edtProveedor );
  edtAlmacenChange( edtAlmacen );
  edtProductoChange( edtProducto );
end;

procedure TFLListEntregas.edtProveedorChange(Sender: TObject);
begin
  if edtProveedor.Text <> '' then
  begin
    etqProveedor.Caption := desProveedor( edtEmpresa.Text, edtProveedor.Text );
  end
  else
  begin
    etqProveedor.Caption := 'TODOS LOS PROVEEDORES';
  end;
end;

procedure TFLListEntregas.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text <> '' then
  begin
    etqproducto.Caption := desProducto( edtEmpresa.Text, edtProducto.Text );
  end
  else
  begin
    etqproducto.Caption := 'TODOS LOS PRODUCTOS';
  end;
end;

procedure TFLListEntregas.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFLListEntregas.ValidarEntrada: Boolean;
var
  desde, hasta: TDate;
begin
  result := false;
  //El codigo de empresa es obligatorio
  if Trim( edtEmpresa.Text ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('El código de empresa es obligatorio.');
    Exit;
  end;

  if Trim( edtAlmacen.Text ) <> '' then
  begin
    if Trim( edtProveedor.Text ) = '' then
    begin
      edtProveedor.SetFocus;
      ShowMessage('Si el almacén no esta vacio el proveedor tiene que tener valor.');
      Exit;
    end;
  end;


  //Comprobar que las fechas sean correctas
  try
    desde := StrToDate(edtFechaDesde.Text);
  except
    edtFechaDesde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  try
    hasta := StrToDate(edtFechaHasta.Text);
  except
    edtFechaHasta.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;

  //Comprobar que el rango sea correcto
  if desde > hasta then
  begin
    edtFechaDesde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;
  result := true;
end;

procedure TFLListEntregas.btnAceptarClick(Sender: TObject);
var
  Parametros: REntregasQL;
begin
  if ValidarEntrada then
  begin
    Parametros.sEmpresa:= edtEmpresa.Text;
    Parametros.sCentro:= edtCentro.Text;
    Parametros.sProveedor:= edtProveedor.Text;
    Parametros.sAlmacen:= edtAlmacen.Text;
    Parametros.sProducto:= edtProducto.Text;

    Parametros.sEntrega:= '';
    Parametros.sAlbaran:= '';
    Parametros.sAdjudicacion:= '';
    case cmbEntrega.ItemIndex of
      0: Parametros.sEntrega:= edtAdjudicacion.Text;
      1: Parametros.sAlbaran:= edtAdjudicacion.Text;
      2: Parametros.sAdjudicacion:= edtAdjudicacion.Text;
    end;

    Parametros.dFechaDesde:= StrToDate( edtFechaDesde.Text );
    Parametros.dFechaHasta:= StrToDate( edtFechaHasta.Text );
    Parametros.bPrintDetalle:= cbxDetalle.Checked;
    Parametros.bPrintPacking:= cbxPacking.Checked;
    Parametros.bPrintObservacion:= cbxObservacion.Checked;
    Parametros.iStatus:= cbxStatus.Itemindex - 1;
    Parametros.iMercado:= cbxMercado.Itemindex - 1;
    Parametros.bAgrupar:= chkAgruparAlmacen.Checked;

    ListEntregasQL.ExecuteReport( Self, Parametros, cbxResumen.Checked, cbxBorrados.Checked );
  end;
end;

procedure TFLListEntregas.edtAlmacenChange(Sender: TObject);
begin
  if edtAlmacen.Text <> '' then
  begin
    etqAlmacen.Caption := desProveedorAlmacen( edtEmpresa.Text, edtProveedor.Text, edtAlmacen.Text );
  end
  else
  begin
    etqAlmacen.Caption := 'TODOS LOS ALMACENES';
  end;
end;

procedure TFLListEntregas.edtCentroChange(Sender: TObject);
begin
  if edtCentro.Text <> '' then
  begin
    etqCentro.Caption := desCentro( edtEmpresa.Text, edtCentro.Text );
  end
  else
  begin
    etqCentro.Caption := 'TODOS LOS CENTROS';
  end;
end;

procedure TFLListEntregas.cbxPackingClick(Sender: TObject);
begin
  if cbxPacking.Checked then
  begin
    cbxResumen.Enabled:= True;
    cbxBorrados.Enabled:= True;
  end
  else
  begin
    cbxResumen.Enabled:= False;
    cbxBorrados.Enabled:= False;
    cbxResumen.Checked:= False;
    cbxBorrados.Checked:= False;
  end;
end;

end.
