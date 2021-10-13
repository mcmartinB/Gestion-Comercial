unit FacturasParaAnticipar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, BEdit, nbLabels, DB, DBTables, BSpeedButton,
  BCalendarButton, ComCtrls, BCalendario, Grids, DBGrids, BGrid,
  BGridButton;

type
  TFFacturasParaAnticipar = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel1: TnbLabel;
    nbLabel4: TnbLabel;
    des_empresa: TnbStaticText;
    empresa: TBEdit;
    fecha_desde: TBEdit;
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
    RejillaFlotante: TBGrid;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure empresaChange(Sender: TObject);

    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnDesdeClick(Sender: TObject);
    procedure btnHastaClick(Sender: TObject);
    procedure edtPaisChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sPais: string;
    dIni, dFin: TDateTime;

    function ParametrosOk: Boolean;
    function GetTextoAyuda: string;

  public
    { Public declarations }

  end;



implementation

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, DateUtils,
     FacturasParaAnticiparData, UFAyuda, CAuxiliarDB, CGlobal;

{$R *.dfm}


procedure TFFacturasParaAnticipar.FormCreate(Sender: TObject);
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

  fecha_desde.Tag := kCalendar;
  edtPais.Tag := kPais;

  CalendarioFlotante.Date := Date;
  edtPais.Text := '';
  edtPaisChange( edtPais );

  //fecha := date;
  //while DayOfWeek(fecha) <> 1 do fecha := fecha - 1;
  fecha_desde.Text := FormatDateTime( 'dd/mm/yyyy', Date - 1 );
  fecha_hasta.Text := FormatDateTime( 'dd/mm/yyyy', Date - 1 );
end;

procedure TFFacturasParaAnticipar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFFacturasParaAnticipar.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFFacturasParaAnticipar.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;


procedure TFFacturasParaAnticipar.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFFacturasParaAnticipar.FormActivate(Sender: TObject);
begin
  Top := 10;
  gCF := CalendarioFlotante;
end;

function TFFacturasParaAnticipar.ParametrosOK: Boolean;
begin
  result := false;

  if des_empresa.Caption = '' then
  begin
    empresa.SetFocus;
    ShowMessage('Empresa incorrecta.');
    Exit;
  end;
  sEmpresa:= empresa.Text;

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

  result := true;
end;

procedure TFFacturasParaAnticipar.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFFacturasParaAnticipar.btnAceptarClick(Sender: TObject);
var
  sAux: string;
begin
  if ParametrosOk then
  begin
    if not ExecuteFacturasParaAnticipar( self, sEmpresa, sPais, cbbPaises.ItemIndex,  dIni, dFin, sAux ) then
      ShowMessage( sAux );
  end;
  BEMensajes('');
end;

procedure TFFacturasParaAnticipar.SpeedButton1Click(Sender: TObject);
begin
  UFAyuda.ExecuteAyuda( self, GetTextoAyuda );
  //UFAyudaWeb.ExecuteAyudaWeb( self, 'C:/Comercializacion/Ayuda/FacturasParaAnticipar.txt' );
end;

function TFFacturasParaAnticipar.GetTextoAyuda: string;
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

procedure TFFacturasParaAnticipar.btnDesdeClick(Sender: TObject);
begin
  DespliegaCalendario(btnDesde);
end;

procedure TFFacturasParaAnticipar.btnHastaClick(Sender: TObject);
begin
  DespliegaCalendario(btnHasta);
end;

procedure TFFacturasParaAnticipar.edtPaisChange(Sender: TObject);
begin
  if Trim(edtPais.Text ) = '' then
   stPais.Caption:= 'TODOS LOS PAISES'
  else
   stPais.Caption:= desPais( edtPais.Text );
end;

end.



