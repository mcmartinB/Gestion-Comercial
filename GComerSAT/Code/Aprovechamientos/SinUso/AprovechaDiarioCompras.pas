unit AprovechaDiarioCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit;

type
  TFAprovechaDiarioCompras = class(TForm)
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
    cbxVerPlantaciones: TCheckBox;
    cbxTipoEntrada: TComboBox;
    lblTipoEntrada: TnbLabel;
    chkVsEscandallos: TCheckBox;
    chkRama: TCheckBox;
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
    procedure chkVsEscandallosClick(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro, sProducto: string;
    dDesde, dHasta: TDate;
    iCosIni, iCosFin, iPlanIni, iPlanFin: Integer;

    function RangoValidos: Boolean;
    procedure ListaTipoEntradas( const AEmpresa: string );
    function  GetTipoEntrada( const ADescripcion: string ): integer;
    procedure EnabledRama;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses UDMAuxDB, AprovechaDiarioComprasReport, Principal, CGestionPrincipal, CVariables,
     bTimeUtils, ULiquidacionComun, EscandallosVsAjustesReport;

procedure TFAprovechaDiarioCompras.FormClose(Sender: TObject;
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

procedure TFAprovechaDiarioCompras.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFAprovechaDiarioCompras.btnAceptarClick(Sender: TObject);
var
  sAux, fechaCorte: string;
  bRama: Boolean;
begin
  if RangoValidos then
  begin

    //Esta el escandallo grabado y ajustado
    if not EstaEscandalloGrabado( sEmpresa, sCentro, sProducto, dDesde, dHasta, fechaCorte ) then
    begin
      if fechaCorte = '' then
      begin
        MessageDlg('Sin entradas para los parametros seleccionados.', mtWarning, [mbOK], 0);
        Exit;
      end
      else
      begin
        MessageDlg('' + #13 + #10 + 'Falta grabar escandallos. ' + #13 + #10 + fechaCorte, mtWarning, [mbOK], 0);
        Exit;
      end;
    end;
    if not EstaAjustado( sEmpresa, sCentro, sProducto, dDesde, dHasta, sAux, fechaCorte ) then
    begin
      MessageDlg('' + #13 + #10 + 'Falta ajustar los escandallos para ' + QuotedStr( sAux ) + ' desde el ' + QuotedStr( fechaCorte ) +  ', semana ' +
        QuotedStr( AnyoSemana(  StrToDate(fechacorte) ) ) + '.  ', mtWarning, [mbOK], 0);
      Exit;
    end;

    if chkVsEscandallos.Checked then
    begin
      if ( chkRama.Enabled ) and ( chkRama.Checked ) then
        bRama:= True
      else
        bRama:= False;
      EscandallosVsAjustesReport.ListadoDiarioAprovechamiento(sEmpresa, sCentro, sProducto,
        dDesde, dHasta, iCosIni, iCosFin, iPlanIni, iPlanFin, cbxVerPlantaciones.Checked,
        GetTipoEntrada(cbxTipoEntrada.Items[cbxTipoEntrada.ItemIndex]),
        cbxTipoEntrada.Items[cbxTipoEntrada.ItemIndex], bRama );
    end
    else
    begin
       AprovechaDiarioComprasReport.ListadoDiarioAprovechamiento(sEmpresa, sCentro, sProducto,
        dDesde, dHasta, iCosIni, iCosFin, iPlanIni, iPlanFin, cbxVerPlantaciones.Checked,
        GetTipoEntrada(cbxTipoEntrada.Items[cbxTipoEntrada.ItemIndex]),
        cbxTipoEntrada.Items[cbxTipoEntrada.ItemIndex] );
    end;
  end;
end;

procedure TFAprovechaDiarioCompras.ListaTipoEntradas( const AEmpresa: string );
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

function TFAprovechaDiarioCompras.GetTipoEntrada( const ADescripcion: string ):integer;
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

procedure TFAprovechaDiarioCompras.empresaChange(Sender: TObject);
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

procedure TFAprovechaDiarioCompras.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFAprovechaDiarioCompras.productoChange(Sender: TObject);
begin
  if Trim( producto.text ) = '' then
  begin
    des_producto.Caption := 'TODAS VARIEDADES DE TOMATE.';
  end
  else
  begin
    des_producto.Caption := desProducto(empresa.Text, producto.Text);

  end;
  EnabledRama;
end;

procedure TFAprovechaDiarioCompras.EnabledRama;
begin
  //chkRama.Enabled:= ( producto.Text = 'T' ) and chkVsEscandallos.checked;
  chkRama.Enabled:= chkVsEscandallos.checked;
end;

procedure TFAprovechaDiarioCompras.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFAprovechaDiarioCompras.RangoValidos: Boolean;
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

  result := true;
end;

procedure TFAprovechaDiarioCompras.FormCreate(Sender: TObject);
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

  Caption:= '    RESUMEN DE APROVECHAMIENTOS';
end;

procedure TFAprovechaDiarioCompras.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFAprovechaDiarioCompras.chkVsEscandallosClick(Sender: TObject);
begin
  EnabledRama;
end;

end.
