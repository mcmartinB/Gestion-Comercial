unit LVentasPorPais;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables;

type
  TFLVentasPorPais = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GBEmpresa: TGroupBox;
    Label3: TLabel;
    Label1: TLabel;
    BGBEmpresa: TBGridButton;
    BGBPais: TBGridButton;
    EPais: TBEdit;
    EEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STPais: TStaticText;
    RejillaFlotante: TBGrid;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    Label2: TLabel;
    EProducto: TBEdit;
    BGBProducto: TBGridButton;
    STProducto: TStaticText;
    cbxTomate: TCheckBox;
    Label5: TLabel;
    ECategoria: TBEdit;
    Label6: TLabel;
    Desde: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label4: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label7: TLabel;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function CamposVacios: boolean;
  private
    function fechas(nomCamp: string): string;
    function seleccionar(): string;

  public
    { Public declarations }
    empresa, centro, producto, factura: string;
  end;

var
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview, CReportes,
  CAuxiliarDB, QLVentasPorPais, StrUtils, UDMBaseDatos, bSQLUtils;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFLVentasPorPais.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;
  if CamposVacios then Exit;
  Self.ActiveControl := nil;

  empresa := desEmpresa(EEmpresa.Text);

  seleccionar;

  if DMBaseDatos.QListado.IsEmpty then
  begin
    ShowError('No se han encontrado datos para los valores introducidos.');
    EEmpresa.SetFocus;
    Exit;
  end;
  QRLVentasPorPais := TQRLVentasPorPais.Create(Application);

  with QRLVentasPorPais.selecc do
  begin
    Lines.Clear;
    Lines.Add('Durante el periodo del ' + MEDesde.Text + ' al ' + MEHasta.Text + ' se han efectuado ');
    Lines.Add('las siguientes exportaciones a: ' + STPais.Caption );
  end;

  PonLogoGrupoBonnysa(QRLVentasPorPais, EEmpresa.Text, 55);

  //************************************************
  QRLVentasPorPais.lblProducto.Caption:= '';
  if eproducto.Text <> '' then
  begin
    if ((eproducto.Text = 'E')or(eproducto.Text = 'T')) and cbxTomate.Checked then
      QRLVentasPorPais.lblProducto.Caption:= 'PRODUCTO "TE"'
    else
      QRLVentasPorPais.lblProducto.Caption:= 'PRODUCTO "' + EProducto.Text + '"';
  end;
  if ECategoria.Text <> '' then
  begin
    QRLVentasPorPais.lblProducto.Caption:= QRLVentasPorPais.lblProducto.Caption  +
      ' CAT ' + ECategoria.Text;
    if length( ECategoria.Text ) = 1 then
      QRLVentasPorPais.lblProducto.Caption:= QRLVentasPorPais.lblProducto.Caption  + 'ª';
  end;
  //************************************************

  Preview(QRLVentasPorPais);
  DMBaseDatos.QListado.Close;
end;

procedure TFLVentasPorPais.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLVentasPorPais.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;


  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;


  MEDesde.Text := DateTostr(Date-7);
  MEHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;
  gCF := CalendarioFlotante;
  EEmpresa.Tag := kEmpresa;
  EPais.Tag := kPais;
  EProducto.Tag := kProducto;

  EEmpresa.Text := gsDefEmpresa;
  EPais.Text := 'GB';
  EProducto.Text := gsDefProducto;
end;

procedure TFLVentasPorPais.FormActivate(Sender: TObject);
begin
  ActiveControl := EEmpresa;
  gCF := CalendarioFlotante;
end;

procedure TFLVentasPorPais.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;

  end;
end;

procedure TFLVentasPorPais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  Action := caFree;
end;

//                     ****  CAMPOS DE EDICION  ****

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLVentasPorPais.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa:
      begin
        DMBaseDatos.QDespegables.Tag := kEmpresa;
        DespliegaRejilla(BGBEmpresa);
      end;
    kPais:
      begin
        DespliegaRejilla(BGBPais, [EEmpresa.Text]);
      end;
    kProducto:
      begin
        DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
      end;
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLVentasPorPais.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
    kPais: STPais.Caption := desPais(EPais.Text);
    kProducto: STProducto.Caption := desProducto(Eempresa.Text, EProducto.Text);
  end;
end;

function TFLVentasPorPais.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if EPais.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EPais.SetFocus;
    Result := True;
    Exit;
  end;
  Result := False;
end;

function TFLVentasPorPais.seleccionar(): string;
begin
  with DMBaseDatos.QListado.SQL do
  begin
    Clear;
    
    Add(' select empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, nombre_c, ');
    Add('        pais_c, moneda_sc, n_factura_sc, fecha_factura_sc, ');
    Add('        sum(importe_neto_sl) importetotal, sum(kilos_sl) kilosTotal');

    Add(' from frf_clientes, frf_salidas_c, frf_salidas_l ');

    Add(' where empresa_c = ' + QuotedStr(EEmpresa.Text ) );
    Add(' and pais_c = ' + QuotedStr(EPais.Text )  );
    Add(' and empresa_sc = ' + QuotedStr(EEmpresa.Text ) );
    Add(' and cliente_fac_sc = cliente_c ');
    Add(' and fecha_sc between :fechaini and :fechafin ');
    Add(' and empresa_sl = ' + QuotedStr(EEmpresa.Text )  );
    Add(' and centro_salida_sl = centro_salida_sc ');
    Add(' and n_albaran_sl = n_albaran_sc ');
    Add(' and fecha_sl = fecha_sc ');

    if Trim(EProducto.Text) <> '' then
    begin
      if ((Eproducto.Text = 'T')or(Eproducto.Text = 'E')) and cbxTomate.Checked then
      begin
        Add(' And producto_sl in (''E'',''T'') ');
      end
      else
      begin
        Add(' And producto_sl=' + QuotedStr(Eproducto.Text) );
      end;
    end;
    if Trim(ECategoria.Text) <> '' then
    begin
      Add(' And categoria_sl=' + QuotedStr(ECategoria.Text) );
    end;

    Add(' group by empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, nombre_c, ');
    Add('        pais_c, moneda_sc, n_factura_sc, fecha_factura_sc ');
    Add(' order by cliente_sal_sc,fecha_sc,n_albaran_sc ');
  end;

  try
    DMBaseDatos.QListado.ParamByName('fechaini').AsDate:= StrToDate(MEDesde.Text);
    DMBaseDatos.QListado.ParamByName('fechafin').AsDate:= StrToDate(MEHasta.Text);
    DMBaseDatos.QListado.Open;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Exit;
    end;
  end;
end;
(*
function TFLVentasPorPais.seleccionar(): string;
var WhereSQL, WhereSQL2: string;
  fec, fec2: string;

begin
  if Trim(EEmpresa.Text) <> '' then
  begin
    WhereSQL := 'And empresa_sc=' +
      QuotedStr(EEmpresa.Text) + ' ';
    WhereSQL2 := 'And empresa_sl=' +
      QuotedStr(EEmpresa.Text) + ' ';
  end;
  if Trim(EPais.Text) <> '' then
  begin
    WhereSQL := WhereSQL + ' ' +
      'And pais_c=' +
      QuotedStr(EPais.Text) + ' ';
    WhereSQL2 := WhereSQL2 + ' ' +
      'And pais_c=' +
      QuotedStr(EPais.Text) + ' ';
  end;
  if Trim(EProducto.Text) <> '' then
  begin
    if ((Eproducto.Text = 'T')or(Eproducto.Text = 'T')) and cbxTomate.Checked then
    begin
      WhereSQL := WhereSQL + ' ' + ' And producto_sl in (''E'',''T'') ';
    end
    else
    begin
      WhereSQL := WhereSQL + ' ' + 'And producto_sl=' + QuotedStr(Eproducto.Text) + ' ';
    end;
  end;
  if Trim(ECategoria.Text) <> '' then
  begin
    WhereSQL := WhereSQL + ' ' + 'And categoria_sl=' + QuotedStr(ECategoria.Text) + ' ';
  end;
  fec := fechas('fecha_sc');
  fec2 := fechas('fecha_sl');

  with DMBaseDatos.QListado do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('SELECT empresa_sc,centro_salida_sc,n_albaran_sc,fecha_sc,' +
      'cliente_sal_sc,nombre_c,pais_c,moneda_sc,n_factura_sc,fecha_factura_sc,');
    SQL.Add('(Select SUM( importe_total_sl) as import ' +
      'From frf_salidas_l Frf_salidas_l, frf_clientes Frf_clientes ' +
      'Where Frf_salidas_l.empresa_sl = Frf_salidas_c.empresa_sc ' +
      'And    Frf_salidas_l.centro_salida_sl=Frf_salidas_c.centro_salida_sc ' +
      'And    Frf_salidas_l.n_albaran_sl =Frf_salidas_c.n_albaran_sc ' +
      'And    Frf_salidas_l.fecha_sl= Frf_salidas_c.fecha_sc ' +
      'And    Frf_salidas_l.empresa_sl= Frf_clientes.empresa_c ' +
      'And    Frf_salidas_l.cliente_sl= Frf_clientes.cliente_c ');
    SQL.Add(WhereSQL2);
    SQL.Add(fec2);
    SQL.Add('Group By empresa_sl,centro_salida_sl,n_albaran_sl,fecha_sl' +
      ') As importeTotal, ');
    SQL.Add('(Select SUM( kilos_sl) as kilos ' +
      'From frf_salidas_l Frf_salidas_l, frf_clientes Frf_clientes ' +
      'Where Frf_salidas_l.empresa_sl = Frf_salidas_c.empresa_sc ' +
      'And    Frf_salidas_l.centro_salida_sl=Frf_salidas_c.centro_salida_sc ' +
      'And    Frf_salidas_l.n_albaran_sl =Frf_salidas_c.n_albaran_sc ' +
      'And    Frf_salidas_l.fecha_sl= Frf_salidas_c.fecha_sc ' +
      'And    Frf_salidas_l.empresa_sl= Frf_clientes.empresa_c ' +
      'And    Frf_salidas_l.cliente_sl= Frf_clientes.cliente_c ');
    SQL.Add(WhereSQL2);
    SQL.Add(fec2);
    SQL.Add('Group By empresa_sl,centro_salida_sl,n_albaran_sl,fecha_sl' +
      ') As kilosTotal ');
    SQL.Add('FROM frf_salidas_c Frf_salidas_c, frf_clientes Frf_clientes ');
    SQL.Add('WHERE (empresa_sc =empresa_c) ' +
      'And   (cliente_sal_sc=cliente_c) ');
    SQL.Add(WhereSQL);
    SQL.Add(fec);
    SQL.Add('ORDER BY cliente_sal_sc,fecha_sc,n_albaran_sc');

  end;
  try
    DMBaseDatos.QListado.Open;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Exit;
    end;
  end;
end;
*)

function TFLVentasPorPais.fechas(nomCamp: string): string;
var fec1, fec2: string;
begin
  fechas := '';

  fec1 := Trim(MEDesde.Text);
  fec2 := Trim(MEHasta.Text);

  if ((fec1 <> '') and (fec2 <> '')) then
    fechas := 'And (' + nomCamp + ' BETWEEN ' + SQLDate(fec1) +
      ' And ' + SQLDate(fec2) + ') '
  else
  begin
    if ((fec1 <> '') and (fec2 = '')) then
      fechas := 'And (' + nomCamp + ' = ' + SQLDate(fec1) + ') '
    else if ((fec1 = '') and (fec2 <> '')) then
      fechas := 'And (' + nomCamp + ' = ' + SQLDate(fec2) + ') '

  end;
end;

end.
