unit GastosProveedorFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DBtables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Derror, Grids,
  DBGrids, BGrid, CheckLst;

type
  TFLGastosProveedor = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label3: TLabel;
    eEmpresa: TBEdit;
    STEmpresa: TStaticText;
    clbGastosTransito: TCheckListBox;
    Label1: TLabel;
    EDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    EHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    QLCompGastosEntregas: TQuery;
    Label4: TLabel;
    eCliente: TBEdit;
    STCliente: TStaticText;
    lblNombre1: TLabel;
    edtProducto: TBEdit;
    txtProducto: TStaticText;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure EHastaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure eEmpresaChange(Sender: TObject);
    procedure eClienteChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);

  private
    {private declarations}
    function  TipoDeGastos( var ATipos: string ): integer;
    function  ConsultaGastosEntregas( var ATiposdeGastos: integer ): boolean;
    function  ConfiguraGastosEntregas( var ATiposdeGastos: integer ): boolean;

    function  ParametrosCorrectos: boolean;
    procedure VerTiposDeGastos;

  public
    { Public declarations }
  end;

implementation

uses Principal, CVariables, CAuxiliarDB, CReportes,
  GastosProveedorQL, DPreview, UDMAuxDB;

{$R *.DFM}

//                          **** FORMULARIO ****

function TFLGastosProveedor.TipoDeGastos( var ATipos: string ): integer;
var
  i, cont: integer;
begin
  ATipos:=  '';
  i:= 0;
  cont:= 0;
  while i < clbGastosTransito.Items.Count  do
  begin
    if clbGastosTransito.Checked[i] then
    begin
      if ATipos <> '' then
        ATipos:=  ATipos + ',''' + copy(clbGastosTransito.Items[i],1,3) + ''''
      else
        ATipos:=  '''' + copy(clbGastosTransito.Items[i],1,3) + '''';
      inc( cont );
    end;
    inc(i);
  end;

  result:= cont;
end;


function TFLGastosProveedor.ConfiguraGastosEntregas( var ATiposdeGastos: integer ): boolean;
var
  sAux: string;
begin
  ATiposdeGastos:= TipoDeGastos( sAux );
  result:= sAux <> '';

  if ATiposdeGastos > 0 then
  with QLCompGastosEntregas.SQL do
  begin
    Clear;

    Add(' select 0 marca, proveedor_ec proveedor, tipo_ge tipo, fecha_fac_ge fecha, ref_fac_ge factura, ');
    Add('        sum( importe_ge ) importe, ');
    Add('        (select sum( kilos_el ) from frf_entregas_l where codigo_ec = codigo_el ');
    if edtProducto.Text <> '' then
      Add('                                                          and producto_el = :producto ');
    Add('                                                                                ) kilos ');
    Add('  from frf_entregas_c, frf_gastos_entregas ');
    Add('  where empresa_ec = :empresa ');
    if eCliente.Text <> '' then
      Add('    and proveedor_ec = :proveedor ');
    Add('    and codigo_ge = codigo_ec ');
    Add('    AND   fecha_fac_ge BETWEEN :desde AND :hasta ');
    Add('    and tipo_ge IN (' + sAux + ' ) ');
    if edtProducto.Text <> '' then
      Add('    and ( producto_ge = :producto or producto_ge is null )');
    Add(' group by 1,2,3,4,5,7 ');

    Add(' order by proveedor, fecha, tipo, factura ');
  end;
end;

procedure TFLGastosProveedor.FormCreate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;

  FormType := tfOther;
  BHFormulario;

  EDesde.Text := DateTostr(Date-7);
  EHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;

  eCliente.Text:= '';
  eClienteChange( eCliente );
  edtProducto.Text:= '';
  edtProductoChange( edtProducto );

  eEmpresa.Text:= gsDefEmpresa;

  EDesde.Tag := kCalendar;
  EHasta.Tag := kCalendar;

  eEmpresa.Tag:= kEmpresa;

  gCF := calendarioFlotante;

  VerTiposDeGastos;
end;

procedure TFLGastosProveedor.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TFLGastosProveedor.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLGastosProveedor.FormClose(Sender: TObject;
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

//                         ****  BOTONES  ****

procedure TFLGastosProveedor.BBAceptarClick(Sender: TObject);
var
  bMostrarReport: boolean;
  sAux: string;
  iTiposdeGastos: integer;
begin
  if not CerrarForm(true) then
    Exit;
  if not ParametrosCorrectos then
    Exit;

  //Llamamos al QReport
  QLGastosProveedor := TQLGastosProveedor.Create(Application);
  try
    bMostrarReport:= ConsultaGastosEntregas( iTiposdeGastos );
    if bMostrarReport then
    begin
      QLGastosProveedor.sEmpresa:= eEmpresa.Text;
      QLGastosProveedor.LPeriodo.Caption := EDesde.Text + ' a ' + EHasta.Text;
      QLGastosProveedor.lblProducto.Caption:= '';
      if edtProducto.Text <> '' then
        QLGastosProveedor.lblProducto.Caption := txtProducto.Caption
      else
        QLGastosProveedor.lblProducto.Caption := 'TODOS LOS PRODUCTOS.';
      QLGastosProveedor.bVariosTipos:= iTiposdeGastos > 1;
      PonLogoGrupoBonnysa(QLGastosProveedor, eEmpresa.Text );
      TipoDeGastos( sAux );


      QLGastosProveedor.lblTipoGastos.Caption:= 'Facturas Seleccionadas: ' + sAux;
      if eCliente.Text <> '' then
        QLGastosProveedor.lblCliente.Caption:= eCliente.Text + ' ' + stCliente.Caption
      else
        QLGastosProveedor.lblCliente.Caption:= '';
      QLGastosProveedor.bndCabecera.Height:= 90;

      Preview(QLGastosProveedor);
    end
    else
    begin
      FreeAndNil(QLGastosProveedor);
    end;
  except
    FreeAndNil(QLGastosProveedor);
    Raise;
  end;
end;

procedure TFLGastosProveedor.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLGastosProveedor.EHastaExit(Sender: TObject);
begin
  if StrToDate(EHasta.Text) < StrToDate(EDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    EDesde.SetFocus;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLGastosProveedor.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCalendar:
      begin
        if EDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

//                     *** PROCEDIMIENTOS PRIVADOS ***


function TFLGastosProveedor.ConsultaGastosEntregas( var ATiposdeGastos: integer ): Boolean;
begin
  if ConfiguraGastosEntregas( ATiposdeGastos ) then
  begin
    with QLCompGastosEntregas do
    begin
      Close;
      ParamByName('empresa').AsString := eEmpresa.Text;
      if eCliente.Text <> '' then
        ParamByName('proveedor').AsString := eCliente.Text;
      ParamByName('desde').AsDate := StrToDate(EDesde.Text);
      ParamByName('hasta').AsDate := StrToDate(EHasta.Text);
      if edtProducto.Text <> '' then
        ParamByName('producto').AsString := edtProducto.Text;
      try
        Open;
      except
        on E: EDBEngineError do
        begin
          ShowError(E);
          raise;
        end;
      end;
    end;

    if QLCompGastosEntregas.IsEmpty then
    begin
      ShowMessage('Sin datos para los parametros seleccionados.');
      QLCompGastosEntregas.Close;
      result:= False;
    end
    else
    begin
      result:= True;
    end;
  end
  else
  begin
    ShowMessage('Por favor, seleccione un gasto.');
    result:= False;
  end;
end;

function TFLGastosProveedor.ParametrosCorrectos: boolean;
var
  dIni, dFin: TDateTime;
begin
  result:= False;
  if Trim( eEmpresa.Text ) = '' then
  begin
    ShowMessage('El código de la empresa es de obligada inserción.');
    eEmpresa.SetFocus;
  end
  else
  if not TryStrToDate( EDesde.Text, dIni ) then
  begin
    ShowMessage('Fecha de incio incorrecta.');
    EDesde.SetFocus;
  end
  else
  if not TryStrToDate( EHasta.Text, dFin ) then
  begin
    ShowMessage('Fecha de fin incorrecta.');
    EHasta.SetFocus;
  end
  else
  if dIni > dFin then
  begin
    ShowMessage('Rango de fechas incorrecto.');
    EDesde.SetFocus;
  end
  else
  if STCliente.Caption = '' then
  begin
    ShowMessage('Proveedor incorrecto.');
    eCliente.SetFocus;
  end
  else
  if txtProducto.Caption = '' then
  begin
    ShowMessage('Producto incorrecto.');
    edtProducto.SetFocus;
  end
  else
  begin
    result:= true;
  end;
end;

procedure TFLGastosProveedor.eEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(eEmpresa.Text);
end;

procedure TFLGastosProveedor.VerTiposDeGastos;
var
  i: integer;
begin
  clbGastosTransito.Items.Clear;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_tipo_gastos ');
    SQL.Add(' where gasto_transito_tg = 2 ');
    SQL.Add(' order by tipo_tg ');
    Open;
    i:= 0;
    while not EOF do
    begin
      if ( FieldByName('tipo_tg').AsString = '110' ) or
         ( FieldByName('tipo_tg').AsString = '128' ) then
      begin
        clbGastosTransito.Items.Add(FieldByName('tipo_tg').AsString + ':' + FieldByName('descripcion_tg').AsString);
        clbGastosTransito.Checked[i]:= True;
        Inc(i);
      end;
      Next;
    end;
    Close;
    clbGastosTransito.Enabled:= clbGastosTransito.Items.Count > 0;
  end;
end;

procedure TFLGastosProveedor.eClienteChange(Sender: TObject);
begin
  if eCliente.Text <> '' then
    STCliente.Caption := desProveedor(eEmpresa.Text, eCliente.Text)
  else
    STCliente.Caption := 'Vacio todos los proveedores.';
end;

procedure TFLGastosProveedor.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text <> '' then
    txtProducto.Caption := desProducto(eEmpresa.Text, edtProducto.Text)
  else
    txtProducto.Caption := 'Vacio todos los productos.';
end;

end.
