unit VerificarKilosEntregadosFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, nbButtons,
  nbEdits, nbCombos, BSpeedButton, BCalendarButton, ComCtrls, BCalendario,
  Grids, DBGrids, DB, DBTables, kbmMemTable, BGrid;

type
  TFLVerificarKilosEntregados = class(TForm)
    btnCancelar: TSpeedButton;
    edtAnyoSem: TBEdit;
    lblEmpresa: TnbLabel;
    lblEntrega: TnbLabel;
    edtEntrega: TBEdit;
    lblCodigo1: TnbLabel;
    edtEmpresa: TBEdit;
    lblCodigo2: TnbLabel;
    edtProveedor: TBEdit;
    btnValorarPalets: TButton;
    chkVerEntrega: TCheckBox;
    lblDesPlanta: TLabel;
    lblCodigo3: TnbLabel;
    lblProducto: TnbLabel;
    edtProducto: TBEdit;
    lblCategoria: TnbLabel;
    edtCategoria: TBEdit;
    lblDesProducto: TLabel;
    lblDesProveedor: TLabel;
    lblDesCategoria: TLabel;
    chkPlantas: TCheckBox;
    RejillaFlotante: TBGrid;
    lblSobrepeso: TnbLabel;
    edtSobrepeso: TBEdit;
    CalendarioFlotante: TBCalendario;
    eFDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label14: TLabel;
    eFHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    lbl1: TnbLabel;
    rbAnoSemana: TRadioButton;
    rbFecha: TRadioButton;
    rbEntrega: TRadioButton;
    grp1: TGroupBox;
    rbProveedor: TRadioButton;
    rbCategorias: TRadioButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnValorarPaletsClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure edtProveedorChange(Sender: TObject);
    procedure edtCategoriaChange(Sender: TObject);
    procedure BCBDesdeClick(Sender: TObject);
    procedure rbFechaClick(Sender: TObject);

  private
     rSobrepeso: Real;
     dIni, dFin: TDateTime;
     iRangoFechas: Integer;
     
     function ValidarParametros: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     CAuxiliarDB, VerificarKilosEntregadosDL, bMath;

var
  DLVerificarKilosEntregados: TDLVerificarKilosEntregados;

procedure TFLVerificarKilosEntregados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  FreeAndNil(DLVerificarKilosEntregados);
  Action := caFree;
end;

procedure TFLVerificarKilosEntregados.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;


  DLVerificarKilosEntregados := TDLVerificarKilosEntregados.Create(self);



  //edtEmpresa.Text:= 'BAG';
  edtEmpresa.Text:= gsDefEmpresa;
  //edtProducto.Text:= 'P';
  edtProducto.Text:= '';
  edtAnyoSem.Text := AnyoSemana( Date - 7 );
  eFDesde.Text := FormatDateTime( 'dd/mm/yyyy', Date - 1 );
  eFHasta.Text := FormatDateTime( 'dd/mm/yyyy', Date - 1 );
  edtProveedor.Text:= '';
  edtCategoria.Text:= '';
  edtEntrega.Text:= '';
  edtSobrepeso.Text:= '4';
  eFDesde.Tag:= kCalendar;
  eFHasta.Tag:= kCalendar;

  CalendarioFlotante.Date:= Date - 1;


end;

procedure TFLVerificarKilosEntregados.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLVerificarKilosEntregados.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLVerificarKilosEntregados.FormKeyDown(Sender: TObject; var Key: Word;
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
        btnValorarPalets.Click;
      end;
  end;
end;


function TFLVerificarKilosEntregados.ValidarParametros: Boolean;
var
  sAux: string;
begin
  result:= True;
  if ( Trim(edtEmpresa.Text )  = '' ) or ( lblDesPlanta.Caption = '' ) then
  begin
    sAux:= 'ERROR: Falta el código de la empresa o es incorrecto.';
    result:= False;
  end;
  if ( lblDesProducto.Caption = '' ) then
  begin
    sAux:= 'ERROR: El código del producto es incorrecto.';
    result:= False;
  end;
  if ( lblDesProveedor.Caption = '' ) then
  begin
    sAux:= 'ERROR: El código del proveedor es incorrecto.';
    result:= False;
  end;
  if ( lblDesCategoria.Caption = '' ) then
  begin
    sAux:= 'ERROR: El código de la categoría es incorrecto.';
    result:= False;
  end;

  if rbAnoSemana.Checked then
  begin
    iRangoFechas:= 0;
    if (edtAnyoSem.Text = '' ) and ( edtEntrega.Text = '' ) then
    begin
      if sAux <> '' then
        sAux:= sAux + #13 + #10;
      sAux:= sAux + 'ERROR: El Año/Semana es obligatorio.';
      result:= False;
    end;
  end
  else
  if rbEntrega.Checked then
  begin
    iRangoFechas:= 1;
    if ( edtEntrega.Text = '' ) then
    begin
      if sAux <> '' then
        sAux:= sAux + #13 + #10;
      sAux:= sAux + 'ERROR: El código de la entrega es obligatorio.';
      result:= False;
    end;
  end
  else
  if rbFecha.Checked then
  begin
    iRangoFechas:= 2;
    if not TryStrToDateTime( eFDesde.Text, dIni ) then
    begin
      if sAux <> '' then
        sAux:= sAux + #13 + #10;
      sAux:= sAux + 'ERROR: Falta la fecha de inicio o es incorrecta.';
      result:= False;
    end;
    if not TryStrToDateTime( eFHasta.Text, dFin ) then
    begin
      if sAux <> '' then
        sAux:= sAux + #13 + #10;
      sAux:= sAux + 'ERROR: Falta la fecha de fin o es incorrecta.';
      result:= False;
    end;
    if dIni > dFin then
    begin
      if sAux <> '' then
        sAux:= sAux + #13 + #10;
      sAux:= sAux + 'ERROR: Rango de fechas incorrecto.';
      result:= False;
    end;
  end;


  if not Result then
    ShowMessage( sAux );

  rSobrepeso:= StrToFloatDef( edtSobrepeso.Text, 0 );
end;

procedure TFLVerificarKilosEntregados.btnValorarPaletsClick(Sender: TObject);
begin
  if ValidarParametros then
    DLVerificarKilosEntregados.KilosEntregasPlatano( edtEmpresa.Text, edtProducto.Text, edtCategoria.Text, edtProveedor.Text,
                                         iRangoFechas, edtAnyoSem.Text, edtEntrega.Text, dIni, dFin, rSobrepeso,
                                         chkPlantas.Checked, rbCategorias.Checked, rbCategorias.Checked, chkVerEntrega.Checked  );
end;

procedure TFLVerificarKilosEntregados.edtEmpresaChange(Sender: TObject);
begin
  if Trim( edtEmpresa.Text ) = '' then
  begin
    lblDesPlanta.Caption:= 'FALTA EMPRESA';
  end
  else
  begin
    if Trim( edtEmpresa.Text ) = 'BAG' then
    begin
      lblDesPlanta.Caption:= 'Plantas  F17, F23, F24, F42';
    end
    else
    begin
      lblDesPlanta.Caption:= desEmpresa( edtEmpresa.Text );
    end;
  end;
  edtProductoChange( edtProducto );
  edtProveedorChange( edtProveedor );
end;

procedure TFLVerificarKilosEntregados.edtProductoChange(Sender: TObject);
begin
  if Trim( edtProducto.Text ) = '' then
  begin
    lblDesProducto.Caption:= 'TODOS LOS PRODUCTOS';
  end
  else
  begin
    if  Trim( edtEmpresa.Text ) = 'BAG'  then
      lblDesProducto.Caption:= desProducto( 'F17', edtProducto.Text )
    else
      lblDesProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
  end;
  edtCategoriaChange( edtCategoria );
end;

procedure TFLVerificarKilosEntregados.edtProveedorChange(Sender: TObject);
begin
  if Trim( edtProveedor.Text ) = '' then
  begin
    lblDesProveedor.Caption:= 'TODOS LOS PROVEDORES';
  end
  else
  begin
    if  Trim( edtEmpresa.Text ) = 'BAG'  then
      lblDesProveedor.Caption:= desProveedor( 'F17', edtProveedor.Text )
    else
      lblDesProveedor.Caption:= desProveedor( edtEmpresa.Text, edtProveedor.Text );
  end;
end;

procedure TFLVerificarKilosEntregados.edtCategoriaChange(Sender: TObject);
begin
  if Trim( edtCategoria.Text ) = '' then
  begin
    lblDesCategoria.Caption:= 'TODAS LAS CATEGORIAS';
  end
  else
  begin
    if  Trim( edtEmpresa.Text ) = 'BAG'  then
      lblDesCategoria.Caption:= desCategoria( 'F17', edtProducto.Text, edtCategoria.Text )
    else
      lblDesCategoria.Caption:= desCategoria( edtEmpresa.Text, edtProducto.Text, edtCategoria.Text );
  end;
end;

procedure TFLVerificarKilosEntregados.BCBDesdeClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCalendar:
      begin
        if EFDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLVerificarKilosEntregados.rbFechaClick(Sender: TObject);
begin
  edtAnyoSem.Enabled:= rbAnoSemana.Checked;
  eFDesde.Enabled:= rbFecha.Checked;
  BCBDesde.Enabled:= rbFecha.Checked;
  eFHasta.Enabled:= rbFecha.Checked;
  BCBHasta.Enabled:= rbFecha.Checked;
  edtEntrega.Enabled:= rbEntrega.Checked;
end;

end.
