unit AprovechaEntradasFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, Grids, DBGrids, BGrid,
  BSpeedButton, BGridButton, ActnList;

type
  TFDAprovechaEntradas = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    empresa: TBEdit;
    centro: TBEdit;
    producto: TBEdit;
    fecha_desde: TBEdit;
    cosechero: TBEdit;
    fecha_hasta: TBEdit;
    plantacion: TBEdit;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    nbLabel5: TnbLabel;
    nbLabel6: TnbLabel;
    des_empresa: TnbStaticText;
    des_centro: TnbStaticText;
    des_producto: TnbStaticText;
    nbLabel8: TnbLabel;
    cbxTipoEntrada: TComboBox;
    lblTipoEntrada: TnbLabel;
    chkRama: TCheckBox;
    des_cosechero: TnbStaticText;
    des_plantacion: TnbStaticText;
    rgVerDatos: TRadioGroup;
    rgVerDetalle: TRadioGroup;
    rgVerPeriodo: TRadioGroup;
    rgEntradasDe: TRadioGroup;
    chkNoIndustria: TCheckBox;
    eAgrupacion: TBEdit;
    BGBAgrupacion: TBGridButton;
    STAgrupacionOld: TStaticText;
    RejillaFlotante: TBGrid;
    nbLabel7: TnbLabel;
    ListaAcciones: TActionList;
    ADesplegarRejilla: TAction;
    STAgrupacion: TnbStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cosecheroChange(Sender: TObject);
    procedure plantacionChange(Sender: TObject);
    procedure eAgrupacionChange(Sender: TObject);
    procedure BGBAgrupacionClick(Sender: TObject);
    procedure eAgrupacionEnter(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro, sProducto, sCosechero, sPlantacion, sAgrupacion: string;
    dDesde, dHasta: TDate;

    function RangoValidos: Boolean;
    procedure ListaTipoEntradas( const AEmpresa: string );
    function  GetTipoEntrada( const ADescripcion: string ): integer;
    procedure PonNombre(Sender: TObject);

  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     AprovechaEntradasDM, CAuxiliarDB, UDMBaseDatos;

procedure TFDAprovechaEntradas.FormClose(Sender: TObject;
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

procedure TFDAprovechaEntradas.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDAprovechaEntradas.BGBAgrupacionClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kAgrupacion: DespliegaRejilla(BGBAgrupacion);
  end;
end;

procedure TFDAprovechaEntradas.btnAceptarClick(Sender: TObject);
begin
  if RangoValidos then
  begin
    AprovechaEntradasDM.InformeAprovechamientos(sEmpresa, sCentro, sProducto, sCosechero, sPlantacion, sAgrupacion, dDesde, dHasta,
      rgEntradasDe.ItemIndex, rgVerDatos.ItemIndex, rgVerDetalle.ItemIndex, rgVerPeriodo.ItemIndex, chkRama.Checked, chkNoIndustria.Checked );
    //GetTipoEntrada(cbxTipoEntrada.Items[cbxTipoEntrada.ItemIndex]), cbxTipoEntrada.Items[cbxTipoEntrada.ItemIndex]
  end;
end;

procedure TFDAprovechaEntradas.ListaTipoEntradas( const AEmpresa: string );
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add( ' select tipo_et, descripcion_et ');
    SQL.Add( ' from frf_entradas_tipo ');
    SQL.Add( ' where empresa_et = :empresa  ');
    SQL.Add( ' order by tipo_et   ');
    ParamByName('empresa').AsString:= AEmpresa;
    Open;
    cbxTipoEntrada.Items.Clear;
    cbxTipoEntrada.Items.Add( 'TODAS LAS ENTRADAS' );
    while not Eof do
    begin
      cbxTipoEntrada.Items.Add( FieldByname('tipo_et').AsString + '-' +  FieldByname('descripcion_et').AsString );
      Next;
    end;
    cbxTipoEntrada.ItemIndex:= 0;
    Close;
  end;
end;

function TFDAprovechaEntradas.GetTipoEntrada( const ADescripcion: string ):integer;
var
  iPos: Integer;
begin
  iPos:= Pos( '-', ADescripcion );
  if iPos = 0 then
  begin
    result:= -1;
  end
  else
  begin
    result:= StrToIntDef(Copy(ADescripcion,1,iPos-1),-1);
  end;
end;

procedure TFDAprovechaEntradas.eAgrupacionChange(Sender: TObject);
begin
  if Trim( eAgrupacion.Text ) = '' then
    STAgrupacion.Caption := 'TODAS LAS AGRUPACIONES'
  else
    STAgrupacion.Caption := desAgrupacion(eAgrupacion.Text);
end;

procedure TFDAprovechaEntradas.eAgrupacionEnter(Sender: TObject);
begin
  bgbAgrupacion.Enabled := true;
end;

procedure TFDAprovechaEntradas.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
  centroChange( centro );
  productoChange( producto );
  cosecheroChange( cosechero );
  if des_empresa.Caption <> '' then
  begin
    ListaTipoEntradas( empresa.Text );
  end
  else
  begin
    cbxTipoEntrada.Items.Clear;
  end;
end;

procedure TFDAprovechaEntradas.centroChange(Sender: TObject);
begin
  if Trim( centro.Text ) = '' then
    des_centro.Caption := 'TODOS LOS CENTROS'
  else
    des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFDAprovechaEntradas.productoChange(Sender: TObject);
begin
  if Trim( producto.Text ) = '' then
    des_producto.Caption := 'TODOS LOS PRODUCTOS'
  else
    des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFDAprovechaEntradas.cosecheroChange(Sender: TObject);
begin
  if Trim( cosechero.Text ) = '' then
    des_cosechero.Caption := 'TODOS LOS COSECHEROS'
  else
    des_cosechero.Caption := desCosechero(empresa.Text, cosechero.Text);
  plantacionChange( plantacion );
end;

procedure TFDAprovechaEntradas.plantacionChange(Sender: TObject);
begin
  if Trim( plantacion.Text ) = '' then
    des_plantacion.Caption := 'TODAS LOS PLANTACIONES'
  else
    des_plantacion.Caption := desPlantacionEx(empresa.Text, producto.Text, cosechero.Text, plantacion.Text, FormatDateTime('dd/mm/yyyy', Now ) );
end;


procedure TFDAprovechaEntradas.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFDAprovechaEntradas.RangoValidos: Boolean;
begin
  result := false;

  if des_empresa.Caption = '' then
  begin
    empresa.SetFocus;
    ShowMessage('Falta el código de la empresa o es incorrecto.');
    Exit;
  end;
  sEmpresa:= Trim( empresa.Text );

  if des_centro.Caption = '' then
  begin
    centro.SetFocus;
    ShowMessage('Falta el código del centro o es incorrecto.');
    Exit;
  end;
  sCentro:= Trim( centro.Text );

  if des_producto.Caption = '' then
  begin
    producto.SetFocus;
    ShowMessage('Código de producto incorrecto.');
    Exit;
  end;
  if ( empresa.Text = '050' ) and ( producto.Text = 'TOM' ) then
  begin
    producto.Text:= 'TOM'
  end;
  sProducto:= Trim( producto.Text );


  if des_cosechero.Caption = '' then
  begin
    cosechero.SetFocus;
    ShowMessage('Código de cosechero incorrecto.');
    Exit;
  end;
  sCosechero:= Trim( cosechero.Text );


  (*
  if des_plantacion.Caption = '' then
  begin
    plantacion.SetFocus;
    ShowMessage('Código de plantación incorrecto.');
    Exit;
  end;
  *)
  sPlantacion:= Trim( plantacion.Text );

  //Comprobar que las fechas sean correctas
  try
    dDesde := StrToDate(fecha_desde.Text);
  except
    fecha_desde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  try
    dHasta := StrToDate(fecha_hasta.Text);
  except
    fecha_hasta.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  //Comprobar que el rango sea correcto
  if dDesde > dHasta then
  begin
    fecha_desde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;

  if Trim( STAgrupacion.Caption ) = '' then
  begin
    ShowMessage('El código de agrupación es incorrecto');
    EAgrupacion.SetFocus;
    Exit;
  end;
  sAgrupacion:= Trim( eAgrupacion.Text );

  result := true;
end;

procedure TFDAprovechaEntradas.FormCreate(Sender: TObject);
var
  fecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  {des_empresa.Caption:= desEmpresa( empresa.Text );
  des_centro.Caption:= desCentro( empresa.Text, centro.Text );
  des_producto.Caption:= desProducto( empresa.Text, producto.Text );}


  empresa.Text := gsDefEmpresa;
  centro.Text := gsDefCentro;
  EAgrupacion.Tag := kAgrupacion;
  producto.Text := '';
  cosechero.Text  := '';
  plantacion.Text := '';

  fecha:= LunesAnterior( Date );
  fecha_desde.Text := DateToStr(fecha - 7);
  fecha_hasta.Text := DateToStr(fecha - 1);

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  eAgrupacionChange(eagrupacion);

end;

procedure TFDAprovechaEntradas.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFDAprovechaEntradas.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kAgrupacion:
    begin

      if ( EAgrupacion.Text = '' ) then
        STAgrupacion.Caption:= 'TODAS LAS AGRUPACIONES'
      else
        STAgrupacion.Caption := desAgrupacion(EAgrupacion.Text);
    end;
  end;
end;


end.
