unit LFResumenTransporte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, ComCtrls, DBCtrls, ActnList,
  BDEdit, BSpeedButton, BGridButton, Db,
  CGestionPrincipal, BEdit, Grids, DBGrids, BGrid,
  BCalendarButton, BCalendario, DError, DPreview, DBTables;

type
  TFLResumenTransporte = class(TForm)
    Panel1: TPanel;
    GBEmpresa: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    STProducto: TStaticText;
    BGBEmpresa: TBGridButton;
    BGBCentro: TBGridButton;
    BGBProducto: TBGridButton;
    RejillaDespegable: TAction;
    RejillaFlotante: TBGrid;
    empresa: TBEdit;
    centro: TBEdit;
    producto: TBEdit;
    fechaDesde: TBEdit;
    BCBFechaDesde: TBCalendarButton;
    CalendarioFlotante: TBCalendario;
    QAlbResumenC: TQuery;
    DSAlbResumenC: TDataSource;
    QAlbResumenD1: TQuery;
    QAlbResumenD2: TQuery;
    QAlbResumenCtransporte: TSmallintField;
    QAlbResumenCcosechero: TSmallintField;
    fechaHasta: TBEdit;
    BCBFechaHasta: TBCalendarButton;
    lblNombre1: TLabel;
    lblNombre2: TLabel;
    transporte: TBEdit;
    BGBTransporte: TBGridButton;
    STTransporte: TStaticText;
    procedure BCancelarExecute(Sender: TObject);
    procedure BAceptarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RejillaDespegableExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure transporteChange(Sender: TObject);
    procedure productoChange(Sender: TObject);

  private
    bPrimeraVez: boolean;
  end;

implementation

uses UDMAuxDB, UDMBaseDatos, CVariables, Principal, CAuxiliarDB,
  QLResumenTrasporte, bSQLUtils, UFCamiones;

{$R *.DFM}

procedure TFLResumenTransporte.BCancelarExecute(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLResumenTransporte.BAceptarExecute(Sender: TObject);
var
  dDesde, dHasta: TDateTime;
begin
  if not CerrarForm(true) then Exit;

     //Comprobar que todos los campos tienen valor
  if (trim(empresa.Text) = '') or
    (trim(centro.Text) = '') (*or
    (trim(producto.Text) = '')*) then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    if trim(empresa.Text) = '' then
    begin
      empresa.SetFocus;
      Exit;
    end;
    if trim(centro.Text) = '' then
    begin
      centro.SetFocus;
      Exit;
    end;
    (*
    if trim(producto.Text) = '' then
    begin
      producto.SetFocus;
      Exit;
    end;
    *)
  end;

  if not TryStrToDate( fechaDesde.Text, dDesde ) then
  begin
    ShowError('La fecha de inicio es de obligada inserción.');
    fechaDesde.SetFocus;
    Exit;
  end;
  if not TryStrToDate( fechaHasta.Text, dHasta ) then
  begin
    ShowError('La fecha de fin es de obligada inserción.');
    fechaHasta.SetFocus;
    Exit;
  end;
  if dHasta < dDesde  then
  begin
    ShowError('rango de fechas incorrecto.');
    fechaDesde.SetFocus;
    Exit;
  end;

     //EXTRAER DATOS
  QAlbResumenC.SQL.Clear;
  QAlbResumenD1.SQL.Clear;
  QAlbResumenD2.SQL.Clear;


  QAlbResumenC.SQL.Add(' select distinct transportista_ec transporte, ');
  QAlbResumenC.SQL.Add('        cosechero_e2l cosechero ');
  QAlbResumenC.SQL.Add(' from frf_entradas2_l, frf_entradas_c ');
  QAlbResumenC.SQL.Add(' where empresa_ec = ' + QuotedStr(empresa.Text));
  QAlbResumenC.SQL.Add(' and centro_ec = ' + QuotedStr(centro.Text));
  QAlbResumenC.SQL.Add(' and fecha_ec between ' + SQLDate(fechaDesde.Text) + ' and ' + SQLDate(fechaHasta.Text));
  if transporte.Text <> '' then
    QAlbResumenC.SQL.Add(' and transportista_ec = ' + QuotedStr(transporte.Text));
  QAlbResumenC.SQL.Add(' and empresa_e2l = ' + QuotedStr(empresa.Text));
  QAlbResumenC.SQL.Add(' and centro_e2l = ' + QuotedStr(centro.Text));
  if producto.Text <> '' then
    QAlbResumenC.SQL.Add(' and producto_e2l = ' + QuotedStr(producto.Text));
  QAlbResumenC.SQL.Add(' and fecha_e2l = fecha_ec ');
  QAlbResumenC.SQL.Add(' and numero_entrada_e2l = numero_entrada_ec ');
  QAlbResumenC.Prepare;

  QAlbResumenD1.SQL.Add(' select transportista_ec transporte, cosechero_e2l cosechero,  ');
  QAlbResumenD1.SQL.Add('        numero_entrada_e2l entrada,  producto_e2l producto, ');
  QAlbResumenD1.SQL.Add('        sum( total_cajas_e2l ) cajas, sum( total_kgs_e2l ) kilos ');
  QAlbResumenD1.SQL.Add(' from frf_entradas2_l, frf_entradas_c ');
  QAlbResumenD1.SQL.Add(' where empresa_ec = ' + QuotedStr(empresa.Text));
  QAlbResumenD1.SQL.Add(' and centro_ec = ' + QuotedStr(centro.Text));
  QAlbResumenD1.SQL.Add(' and fecha_ec between ' + SQLDate(fechaDesde.Text) + ' and ' + SQLDate(fechaHasta.Text));
  QAlbResumenD1.SQL.Add(' and empresa_e2l = ' + QuotedStr(empresa.Text));
  QAlbResumenD1.SQL.Add(' and centro_e2l = ' + QuotedStr(centro.Text));
  if producto.Text <> '' then
    QAlbResumenD1.SQL.Add(' and producto_e2l = ' + QuotedStr(producto.Text));
  QAlbResumenD1.SQL.Add(' and fecha_e2l = fecha_ec ');;
  QAlbResumenD1.SQL.Add(' and numero_entrada_e2l = numero_entrada_ec ');
  QAlbResumenD1.SQL.Add(' and transportista_ec = :transporte ');
  QAlbResumenD1.SQL.Add(' and cosechero_e2l = :cosechero ');
  QAlbResumenD1.SQL.Add(' group by transportista_ec, cosechero_e2l, numero_entrada_e2l, producto_e2l ');
  QAlbResumenD1.Prepare;

  QAlbResumenD2.SQL.Add(' select transportista_ec transporte, cosechero_e2l cosechero,  ');
  QAlbResumenD2.SQL.Add('        plantacion_e2l plantacion, producto_e2l producto, min(fecha_e2l) fecha, ');
  QAlbResumenD2.SQL.Add('        sum( total_cajas_e2l ) cajas, sum( total_kgs_e2l ) kilos ');
  QAlbResumenD2.SQL.Add(' from frf_entradas2_l, frf_entradas_c ');
  QAlbResumenD2.SQL.Add(' where empresa_ec = ' + QuotedStr(empresa.Text));
  QAlbResumenD2.SQL.Add(' and centro_ec = ' + QuotedStr(centro.Text));
  QAlbResumenD2.SQL.Add(' and fecha_ec between ' + SQLDate(fechaDesde.Text) + ' and ' + SQLDate(fechaHasta.Text));
  QAlbResumenD2.SQL.Add(' and empresa_e2l = ' + QuotedStr(empresa.Text));
  QAlbResumenD2.SQL.Add(' and centro_e2l = ' + QuotedStr(centro.Text));
  if producto.Text <> '' then
    QAlbResumenD2.SQL.Add(' and producto_e2l = ' + QuotedStr(producto.Text));
  QAlbResumenD2.SQL.Add(' and fecha_e2l = fecha_ec ');
  QAlbResumenD2.SQL.Add(' and numero_entrada_e2l = numero_entrada_ec ');
  QAlbResumenD2.SQL.Add(' and transportista_ec = :transporte ');
  QAlbResumenD2.SQL.Add(' and cosechero_e2l = :cosechero ');
  QAlbResumenD2.SQL.Add(' group by transportista_ec, cosechero_e2l, plantacion_e2l, producto_e2l ');
  QAlbResumenD2.Prepare;

  try
    QAlbResumenC.Open;
    if not QAlbResumenC.IsEmpty then
    begin
      QAlbResumenD1.Open;
      QAlbResumenD2.Open;
    end
    else
    begin
      QAlbResumenC.Close;
      ShowError('Informe sin datos para los parametros de busqueda introducidos.');
      Exit;
    end;
  except
    ShowError('No se pueden abrir las tablas necesarias para elaborar el informe.');
        //Cerramos si hay alguna tabla abierta
    QAlbResumenC.Close;
    QAlbResumenD1.Close;
    QAlbResumenD2.Close;
    QAlbResumenD1.UnPrepare;
    QAlbResumenD2.UnPrepare;
    QAlbResumenC.UnPrepare;
    Exit;
  end;


     //CREAR LISTADO
  QResumenTrasporte := TQResumenTrasporte.Create(Self);

     //MOSTRAR DATOS
  QResumenTrasporte.Configurar(empresa.Text);
  QResumenTrasporte.empresa := empresa.Text;
  QResumenTrasporte.centro := centro.Text;
  if producto.Text = '' then
  begin
    QResumenTrasporte.lblProducto.Caption := 'TODOS LOS PRODUCTOS'
  end
  else
  begin
    QResumenTrasporte.lblProducto.Caption := producto.Text;
  end;

  if fechaDesde.Text = fechaHasta.Text then
    QResumenTrasporte.lblFecha.Caption := fechaHasta.Text
  else
    QResumenTrasporte.lblFecha.Caption := fechaDesde.Text + ' - ' + fechaHasta.Text;

  Preview(QResumenTrasporte, 1, False, False);

  QAlbResumenC.Close;
  QAlbResumenD1.Close;
  QAlbResumenD2.Close;
  QAlbResumenD1.UnPrepare;
  QAlbResumenD2.UnPrepare;
  QAlbResumenC.UnPrepare;
end;

procedure TFLResumenTransporte.FormCreate(Sender: TObject);
begin
  Top := 1;
  FormType := tfOther;
  BHFormulario;
  Empresa.Tag := kEmpresa;
  Centro.Tag := kCentro;
  Producto.Tag := kProducto;
  transporte.Tag := kCamion;
  fechaDesde.Tag := kCalendar;
  fechaHasta.Tag := kCalendar;

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  bPrimeraVez:= True;
end;

procedure TFLResumenTransporte.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bnCloseQuerys([QAlbResumenD1, QAlbResumenD2, QAlbResumenC]);
  CloseAuxQuerys;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  gRF := nil;
  gCF := nil;
  Action := caFree;
end;

procedure TFLResumenTransporte.RejillaDespegableExecute(
  Sender: TObject);
var
  sAux: string;
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [empresa.Text]);
    kCentro: DespliegaRejilla(BGBCentro, [empresa.Text]);
    kCalendar:
      if fechaDesde.Focused then
        DespliegaCalendario(BCBFechaDesde)
      else
        DespliegaCalendario(BCBFechaHasta);
    kCamion:
    begin
      sAux:= transporte.Text;
      if SeleccionaCamion( self, transporte, sAux ) then
      begin
        transporte.Text:= sAux;
      end;
    end;
  end;
end;

procedure TFLResumenTransporte.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
      begin
        STEmpresa.Caption := desEmpresa(empresa.Text);
        STCentro.Caption := desCentro(empresa.Text, centro.Text);
      end;
    kCentro: STCentro.Caption := desCentro(empresa.Text, centro.Text);
  end;
end;

procedure TFLResumenTransporte.productoChange(Sender: TObject);
begin
  if producto.Text = '' then
  begin
    STProducto.Caption := 'OPTATIVO, VACIO TODOS LOS PRODUCTOS.';
  end
  else
  begin
    STProducto.Caption := desProducto(empresa.Text, producto.Text);
  end;
end;

procedure TFLResumenTransporte.transporteChange(Sender: TObject);
begin
  if transporte.Text = '' then
  begin
    STTransporte.Caption := 'OPTATIVO, VACIO TODOS LOS TRANSPORTES.';
  end
  else
  begin
    STTransporte.Caption := desCamion(transporte.Text);
  end;
end;

procedure TFLResumenTransporte.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure TFLResumenTransporte.FormActivate(Sender: TObject);
begin
  if bPrimeraVez then
  begin
    Empresa.Text := gsDefEmpresa;
    Centro.Text := gsDefCentro;
    fechaDesde.Text := DateToStr(Date-1);
    fechaHasta.Text := DateToStr(Date-1);
    CalendarioFlotante.Date := Date-1;
    productoChange( producto );
    transporteChange( transporte );
    bPrimeraVez:= False;
  end;
end;

end.
