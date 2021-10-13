unit AprovechaDiario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit;

type
  TFAprovechaDiario = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    empresa: TBEdit;
    centro: TBEdit;
    producto: TBEdit;
    fecha_desde: TBEdit;
    cosechero_desde: TBEdit;
    fecha_hasta: TBEdit;
    cosechero_hasta: TBEdit;
    plantacion_desde: TBEdit;
    plantacion_hasta: TBEdit;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    nbLabel5: TnbLabel;
    nbLabel6: TnbLabel;
    des_empresa: TnbStaticText;
    des_centro: TnbStaticText;
    des_producto: TnbStaticText;
    nbLabel7: TnbLabel;
    nbLabel8: TnbLabel;
    desglose: TCheckBox;
    cbxTipoEntrada: TComboBox;
    edtPrimera: TBEdit;
    edtSegunda: TBEdit;
    edtTErcera: TBEdit;
    lblPrimera: TLabel;
    lblSegunda: TLabel;
    lblTercera: TLabel;
    lblEscandallo: TnbLabel;
    lblDestrio: TLabel;
    edtDestrio: TBEdit;
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
  private
    { Private declarations }
    sEmpresa, sCentro, sProducto: string;
    dDesde, dHasta: TDate;
    iCosIni, iCosFin, iPlanIni, iPlanFin: Integer;
    rPrimera, rSegunda, rTErcera, rDestrio: real;

    function  RangoValidos: Boolean;
    procedure ListaTipoEntradas( const AEmpresa: string );
    function  GetTipoEntrada( const ADescripcion: string ): integer;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses UDMAuxDB, AprovechaDiarioReport, Principal, CGestionPrincipal, CVariables,
     bTimeUtils;

procedure TFAprovechaDiario.FormClose(Sender: TObject;
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

procedure TFAprovechaDiario.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFAprovechaDiario.btnAceptarClick(Sender: TObject);
begin
  if RangoValidos then
  begin
    ListadoDiarioAprovechamiento(sEmpresa, sCentro, sProducto,
      dDesde, dHasta, iCosIni, iCosFin, iPlanIni, iPlanFin, rPrimera, rSegunda, rTErcera, rDestrio,
      desglose.Checked, GetTipoEntrada(cbxTipoEntrada.Items[cbxTipoEntrada.ItemIndex]) );
  end;
end;

procedure TFAprovechaDiario.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
  centroChange( centro );
  productoChange( producto );
  if des_empresa.Caption <> '' then
  begin
    ListaTipoEntradas( empresa.Text );
  end
  else
  begin
    cbxTipoEntrada.Items.Clear;
  end;
end;

procedure TFAprovechaDiario.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFAprovechaDiario.productoChange(Sender: TObject);
begin
  if Trim( producto.text ) = '' then
    des_producto.Caption := 'VACIO TODOS LOS PRODUCTOS.'
  else
    des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFAprovechaDiario.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFAprovechaDiario.RangoValidos: Boolean;
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
  sProducto:= Trim( producto.Text );

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

  if not TryStrToInt( cosechero_desde.Text, iCosIni ) then
  begin
    cosechero_desde.SetFocus;
    ShowMessage('Falta el cosechero de inicio.');
    Exit;
  end;
  if not TryStrToInt( cosechero_hasta.Text, iCosFin ) then
  begin
    cosechero_hasta.SetFocus;
    ShowMessage('Falta el cosechero de fin.');
    Exit;
  end;
  if iCosIni > iCosFin then
  begin
    cosechero_desde.SetFocus;
    ShowMessage('Rango de cosecheros incorrecto.');
    Exit;
  end;

  if not TryStrToInt( plantacion_desde.Text, iPlanIni ) then
  begin
    plantacion_desde.SetFocus;
    ShowMessage('Falta la plantación de inicio.');
    Exit;
  end;
  if not TryStrToInt( plantacion_hasta.Text, iPlanFin ) then
  begin
    plantacion_hasta.SetFocus;
    ShowMessage('Falta la plantación de fin.');
    Exit;
  end;
  if iPlanIni > iPlanFin then
  begin
    cosechero_desde.SetFocus;
    ShowMessage('Rango de cosecheros incorrecto.');
    Exit;
  end;

  rPrimera:= StrToFloatDef( edtPrimera.Text, -1 );
  rSegunda:= StrToFloatDef( edtSegunda.Text, -1 );
  rTErcera:= StrToFloatDef( edtTErcera.Text, -1 );
  rDestrio:= StrToFloatDef( edtDestrio.Text, -1 );

  result := true;
end;

procedure TFAprovechaDiario.FormCreate(Sender: TObject);
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
  producto.Text := '';

  fecha:= LunesAnterior( Date );
  fecha_desde.Text := DateToStr(fecha - 7);
  fecha_hasta.Text := DateToStr(fecha - 1);

  cosechero_desde.Text := '0';
  cosechero_hasta.Text := '999';

  plantacion_desde.Text := '1';
  plantacion_hasta.Text := '999';

  Caption:= '    LISTADO DE ESCANDALLOS';

end;

procedure TFAprovechaDiario.ListaTipoEntradas( const AEmpresa: string );
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
    cbxTipoEntrada.Items.Add( 'PRODUCTO SIN AJUSTAR' );
    cbxTipoEntrada.ItemIndex:= 0;
    Close;
  end;
end;

function TFAprovechaDiario.GetTipoEntrada( const ADescripcion: string ):integer;
var
  iPos: Integer;
begin
  iPos:= Pos( '-', ADescripcion );
  if iPos = 0 then
  begin
    if ADescripcion = 'PRODUCTO SIN AJUSTAR' then
      result:= -2
    else
      result:= -1;
  end
  else
  begin
    result:= StrToIntDef(Copy(ADescripcion,1,iPos-1),-1);
  end;
end;

procedure TFAprovechaDiario.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

end.
