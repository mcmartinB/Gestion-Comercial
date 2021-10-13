unit AlbaranesFacturadosEn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, BEdit, nbLabels, DB, DBTables, BSpeedButton,
  BCalendarButton, ComCtrls, BCalendario, BGridButton;

type
  TFAlbaranesFacturadosEn = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel1: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    des_empresa: TnbStaticText;
    des_producto: TnbStaticText;
    empresa: TBEdit;
    producto: TBEdit;
    fecha_desde: TBEdit;
    nbLabel2: TnbLabel;
    centro: TBEdit;
    des_centro: TnbStaticText;
    SpeedButton1: TSpeedButton;
    CalendarioFlotante: TBCalendario;
    btnDesde: TBCalendarButton;
    fecha_hasta: TBEdit;
    btnHasta: TBCalendarButton;
    lbl1: TnbLabel;
    lblPais: TLabel;
    edtPais: TBEdit;
    btnPais: TBGridButton;
    stPais: TStaticText;
    cbbPaises: TComboBox;
    nbLabel5: TnbLabel;
    ESerie: TBEdit;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure empresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure centroChange(Sender: TObject);

    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnDesdeClick(Sender: TObject);
    procedure btnHastaClick(Sender: TObject);
    procedure edtPaisChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sSerie, sCentro, sProducto, sPais: string;
    dIni, dFin: TDateTime;

    function ParametrosOk: Boolean;
    function GetTextoAyuda: string;

  public
    { Public declarations }

  end;



implementation

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, DateUtils,
     AlbaranesFacturadosEnData, UFAyuda, CAuxiliarDB, CGlobal;

{$R *.dfm}


procedure TFAlbaranesFacturadosEn.FormCreate(Sender: TObject);
begin
  Top := 1;
  FormType := tfOther;
  BHFormulario;

  if CGlobal.gProgramVersion =  CGlobal.pvSAT then
  begin
    empresa.Text := 'SAT';
  end
  else
  begin
    empresa.Text := 'BAG';
  end;
  ESerie.Text := '';
  centro.Text := '';
  producto.Text := '';
  edtPais.Tag := kPais;

  fecha_desde.Tag := kCalendar;

  CalendarioFlotante.Date := Date;
  edtPais.Text := '';
  edtPaisChange( edtPais );

  //fecha := date;
  //while DayOfWeek(fecha) <> 1 do fecha := fecha - 1;
  fecha_desde.Text := FormatDateTime( 'dd/mm/yyyy', IncYear( Date, - 1 ) );
  fecha_hasta.Text := FormatDateTime( 'dd/mm/yyyy', Date );
end;

procedure TFAlbaranesFacturadosEn.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFAlbaranesFacturadosEn.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización

  if (CalendarioFlotante <> nil) then
    if (CalendarioFlotante.Visible) then
            //No hacemos nada
      Exit;

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
        btnCancelar.Click
      end;
    vk_f1:
      begin
        btnAceptar.Click
      end;
  end;
end;

procedure TFAlbaranesFacturadosEn.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;


procedure TFAlbaranesFacturadosEn.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
  productoChange( producto );
  centroChange( centro );
end;

procedure TFAlbaranesFacturadosEn.productoChange(Sender: TObject);
begin
  if producto.Text = '' then
    des_producto.Caption := 'TODOS LOS PRODUCTOS.'
  else
    des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFAlbaranesFacturadosEn.centroChange(Sender: TObject);
begin
  if centro.Text = '' then
    des_centro.Caption := 'TODOS LOS CENTROS.'
  else
    des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFAlbaranesFacturadosEn.FormActivate(Sender: TObject);
begin
  Top := 10;
  gCF := CalendarioFlotante;
end;

function TFAlbaranesFacturadosEn.ParametrosOK: Boolean;
begin
  result := false;

  if des_empresa.Caption = '' then
  begin
    empresa.SetFocus;
    ShowMessage('Empresa incorrecta.');
    Exit;
  end;
  sEmpresa:= empresa.Text;

  if des_centro.Caption = '' then
  begin
    centro.SetFocus;
    ShowMessage('Centro incorrecto.');
    Exit;
  end;
  sCentro:= centro.Text;

  if des_producto.Caption = '' then
  begin
    producto.SetFocus;
    ShowMessage('Producto incorrecto.');
    Exit;
  end;
  sProducto:= producto.Text;

  if stPais.Caption = '' then
  begin
    ShowMessage('Código de país incorrecto.');
    edtPais.SetFocus;
    Exit;
  end;
  sPais:= Trim(edtPais.Text);

  if not tryStrToDate( fecha_desde.Text, dIni ) then
  begin
    fecha_desde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  if not tryStrToDate( fecha_hasta.Text, dFin ) then
  begin
    fecha_hasta.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  if dIni > dFin then
  begin
    fecha_desde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;

  sSerie := ESerie.Text;

  result := true;
end;

procedure TFAlbaranesFacturadosEn.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFAlbaranesFacturadosEn.btnAceptarClick(Sender: TObject);
var
  sAux: string;
begin
  if ParametrosOk then
  begin
    if not ExecuteAlbaranesFacturadosEn( self, sEmpresa, sSerie, sCentro, sProducto, sPais, cbbPaises.ItemIndex, dIni, dFin, sAux ) then
      ShowMessage( sAux );
  end;
  BEMensajes('');
end;

procedure TFAlbaranesFacturadosEn.SpeedButton1Click(Sender: TObject);
begin
  UFAyuda.ExecuteAyuda( self, GetTextoAyuda );
  //UFAyudaWeb.ExecuteAyudaWeb( self, 'C:/Comercializacion/Ayuda/AlbaranesFacturadosEn.txt' );
end;

function TFAlbaranesFacturadosEn.GetTextoAyuda: string;
begin
  result:= '';
  result:= result + '' + #13 + #10;
  result:= result + '-----------------' + #13 + #10;
  result:= result + '* DATOS LISTADO *' + #13 + #10;
  result:= result + '-----------------' + #13 + #10;
  result:= result + '' + #13 + #10;
  result:= result + '* ENTRADA ESCANDALLO ' + #13 + #10;
  result:= result + '*************************************************************************************' + #13 + #10;
  result:= result + 'Cosechado    	-> Kilos totales entradas segun los porcentajes del escandallo' + #13 + #10;
  result:= result + 'Seleccionado 	-> Kilos entradas marcadas como selecciondo/industria' + #13 + #10;
  result:= result + 'Normal 	 	-> Kilos entradas no marcadas como selecciondo/industria segun escandallo' + #13 + #10;
  result:= result + '--------------------------------------------------------------------------------------' + #13 + #10;
  result:= result + '' + #13 + #10;
  result:= result + '* SALIDAS' + #13 + #10;
  result:= result + '*************************************************************************************' + #13 + #10;
  result:= result + 'ALbaranes	-> Salidas y tránsitos del almacen segun categoria' + #13 + #10;
  result:= result + 'Ajuste Invent.	-> salidas ajustadas con el inventario =' + #13 + #10;
  result:= result + '                	( Salidas_cat_X + Inventario_Final_Cat_X ) - Inventario_Inicio_Cat_X' + #13 + #10;
  result:= result + 'Quitar Selecc. 	-> Quitamos seleccionado (este no es necesario ajustar) =' + #13 + #10;
  result:= result + '                	Salidas_Ajuste_Invent_cat_X - Seleccionado_Cat_X' + #13 + #10;
  result:= result + 'Aplicar Merma 	-> Añadimos el porcentaje de merma calculado para para la entrada normal.' + #13 + #10;
  result:= result + '--------------------------------------------------------------------------------------' + #13 + #10;
  result:= result + '' + #13 + #10;
  result:= result + '* MERMA' + #13 + #10;
  result:= result + '*************************************************************************************' + #13 + #10;
  result:= result + 'Merma		-> ( Inventario_Inicial + Cosechado ) - ( Inventario_Final + Salidas )' + #13 + #10;
  result:= result + 'Cosechados      -> Porcentaje de la merma sobre la Entrada_Cosechado' + #13 + #10;
  result:= result + 'Normal		-> Porcentaje de la merma sobre la Entrada_Normal' + #13 + #10;
  result:= result + 'Procesados      -> Porcentaje de la merma sobre el producto procesado' + #13 + #10;
  result:= result + '                	( IniCampo + Cosechado ) - FinCampo' + #13 + #10;
  result:= result + 'Confeccionados	-> Porcentaje de la merma sobre el producto confeccionado' + #13 + #10;
  result:= result + '                	( IniCampo + Cosechado +  IniIntermedia ) - ( FinCampo + FinIntermedia )' + #13 + #10;
  result:= result + '--------------------------------------------------------------------------------------' + #13 + #10;
  result:= result + '' + #13 + #10;
  result:= result + '* ENTRADA AJUSTADA' + #13 + #10;
  result:= result + '*************************************************************************************' + #13 + #10;
  result:= result + 'Entrada ajustada a los porcentajes de salida calculados una vez que han sido ajustados,' + #13 + #10;
  result:= result + 'eliminado el seleccionado/industria y aplicado la merma.' + #13 + #10;
  result:= result + '--------------------------------------------------------------------------------------;' + #13 + #10;
end;

procedure TFAlbaranesFacturadosEn.btnDesdeClick(Sender: TObject);
begin
  DespliegaCalendario(btnDesde);
end;

procedure TFAlbaranesFacturadosEn.btnHastaClick(Sender: TObject);
begin
  DespliegaCalendario(btnHasta);
end;

procedure TFAlbaranesFacturadosEn.edtPaisChange(Sender: TObject);
begin
  if Trim(edtPais.Text ) = '' then
   stPais.Caption:= 'TODOS LOS PAISES'
  else
   stPais.Caption:= desPais( edtPais.Text );
end;

end.



