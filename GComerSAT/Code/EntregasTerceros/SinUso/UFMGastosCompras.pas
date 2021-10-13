unit UFMGastosCompras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  DError, CVariables, StrUtils, DBActns, StdActns;

type
  TFMGastosCompras = class(TForm)
    AGastos: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    PRejilla: TPanel;
    PBotones: TPanel;
    SBAceptar: TSpeedButton;
    SBCancelar: TSpeedButton;
    SBAnterior: TSpeedButton;
    SBPrimero: TSpeedButton;
    SBSiguiente: TSpeedButton;
    SBUltimo: TSpeedButton;
    SBSalir: TSpeedButton;
    SBModificar: TSpeedButton;
    ALocalizar: TAction;
    AModificar: TAction;
    ASalir: TAction;
    AAceptar: TAction;
    ACancelar: TAction;
    SBAltas: TSpeedButton;
    SBBorrar: TSpeedButton;
    ABorrar: TAction;
    STTipoGastos: TStaticText;
    LTipoGastos: TLabel;
    LImporte: TLabel;
    BGBTipoGastos: TBGridButton;
    AAlta: TAction;
    Label1: TLabel;
    STTotalGastos: TStaticText;
    rejilla: TDBGrid;
    tipo_gc: TBDEdit;
    importe_gc: TBDEdit;
    RejillaFlotante: TBGrid;
    APrimero: TAction;
    AAnterior: TAction;
    ASiguiente: TAction;
    AUltimo: TAction;
    ref_fac_gc: TBDEdit;
    LApunte: TLabel;
    DSGastosCompras: TDataSource;
    LProducto: TLabel;
    producto_gc: TBDEdit;
    BGBProducto: TBGridButton;
    stProducto: TStaticText;
    Label2: TLabel;
    fecha_fac_gc: TBDEdit;
    btnFecha_fac_gc: TBCalendarButton;
    Calendario: TBCalendario;
    Label3: TLabel;
    nota_gc: TBDEdit;
    pagado_gc: TDBCheckBox;
    QGastosCompras: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure ASalirExecute(Sender: TObject);
    procedure ABorrarExecute(Sender: TObject);
    procedure AAltaExecute(Sender: TObject);
    procedure AModificarExecute(Sender: TObject);
    procedure tipo_gcRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure APrimeroExecute(Sender: TObject);
    procedure AAnteriorExecute(Sender: TObject);
    procedure ASiguienteExecute(Sender: TObject);
    procedure AUltimoExecute(Sender: TObject);
    procedure rejillaDblClick(Sender: TObject);
    procedure tipo_gcChange(Sender: TObject);
    procedure producto_gcChange(Sender: TObject);
    procedure BGBProductoClick(Sender: TObject);
    procedure BGBTipoGastosClick(Sender: TObject);
    procedure rejillaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnFecha_fac_gcClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure QGastosComprasAfterPost(DataSet: TDataSet);
    procedure QGastosComprasAfterDelete(DataSet: TDataSet);


  private
    lRF: TBGrid;
    lCF: TBCalendario;
    { Private declarations }
    estado: TEstado;
    salir: boolean;

    sEmpresa, sCentro: string;
    iNumero: integer;
    bGastoModificado: boolean;

    procedure botoneraDespl;

    // procedure Modificar;
    function  ValidarDatos: boolean;
    procedure AceptarAltas;
    procedure AceptarModificar;
    procedure CancelarAltas;
    procedure CancelarModificar;
    procedure CambiarEstado(estad: TEstado);
    procedure CalculoGastos;

    procedure EuroConversorExecute;
  public
    { Public declarations }

    procedure Botones;
    procedure CargaParametros( const AEmpresa, ACentro: string; const ANumero: integer );
    function GastosModificados: boolean;

  end;

var
  FMGastosCompras: TFMGastosCompras;
  opcc: Integer;

implementation

uses bDialogs, UDMBaseDatos, CAuxiliarDB, Principal, bSQLUtils,
     DConversor, uDMAuxDB;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMGastosCompras.CargaParametros( const AEmpresa, ACentro: string;
                                            const ANumero: integer );
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iNumero:= ANumero;
  with QGastosCompras do
  begin
    ParamByName('empresa_c').AsString:= AEmpresa;
    ParamByName('centro_c').AsString:= ACentro;
    ParamByName('numero_c').AsInteger:= ANumero;
  end;
end;

procedure TFMGastosCompras.FormShow(Sender: TObject);
begin
  QGastosCompras.Open;
  cambiarEstado(teLocalizar);
  CalculoGastos;
end;

procedure TFMGastosCompras.FormCreate(Sender: TObject);
begin
  Salir := false;

   //Teclas para las altas y bajas
  AAlta.ShortCut := vk_add; //mas numerico
  ABorrar.ShortCut := VK_SUBTRACT; //menos numerico
  ASalir.ShortCut := VK_ESCAPE;

  //Tamaño y posicion del formulario
  with QGastosCompras do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_gastos_compras ');
    SQL.Add(' where empresa_gc = :empresa_c ');
    SQL.Add('   and centro_gc = :centro_c ');
    SQL.Add('   and numero_gc = :numero_c ');
    SQL.Add(' order by producto_gc, tipo_gc ');
  end;
  //cambiarEstado(teLocalizar);
  lRF := gRF;
  lCF := gCF;
  gRF := RejillaFlotante;
  gCF := nil;
  Botones;

  Calendario.Date:= Date;
  bGastoModificado:= False;
end;


procedure TFMGastosCompras.FormActivate(Sender: TObject);
begin
  gRF := RejillaFlotante;
  gCF := nil;
end;


procedure TFMGastosCompras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if salir then
  begin
    QGastosCompras.Close;
    gRF := lRF;
    gCF := lCF;
    Action := caFree;
  end
  else
  begin
    Action := caNone;
  end;
end;

procedure TFMGastosCompras.FormKeyDown(Sender: TObject; var Key: Word;
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
    vk_f8:
      begin
        Key := 0;
        EuroConversorExecute;
      end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************


//***************************************************************
//Procedimientos de los botones, acciones, desplazamientos, etc..
//***************************************************************

procedure TFMGastosCompras.AAceptarExecute(Sender: TObject);
begin
  if RejillaFlotante.Visible then
  begin
    RejillaFlotante.DblClick;
    Exit;
  end;
  if Calendario.Visible then
  begin
    Calendario.DblClick;
    Calendario.BControl.SetFocus;
    Exit;
  end;

  if Estado = teAlta then
    AceptarAltas;
  if Estado = teModificar then
    AceptarModificar;
  CalculoGastos;
end;

procedure TFMGastosCompras.ACancelarExecute(Sender: TObject);
var
  sAux: string;
begin
  if RejillaFlotante.Visible then
  begin
    RejillaFlotante.Hide;
    Exit;
  end;
  if Calendario.Visible then
  begin
    sAux:= Calendario.BControl.Text;
    Calendario.DblClick;
    Calendario.BControl.Text:= sAux;
    Calendario.BControl.SetFocus;
    Exit;
  end;

  CalculoGastos;
  if estado = teModificar then
  begin
    CancelarModificar;
    Exit;
  end;
  if estado = teAlta then
  begin
    CancelarAltas;
    Exit;
  end;
end;

procedure TFMGastosCompras.ASalirExecute(Sender: TObject);
begin
  if Salir then
    Close;
end;

function  TFMGastosCompras.ValidarDatos: boolean;
begin
  result:= false;
  if stProducto.Caption = '' then
  begin
    MessageDlg('Debe introducir un producto valido o dejarlo vacio...', mtError, [mbOK], 0);
    producto_gc.SetFocus;
  end
  else
  if STTipoGastos.Caption = '' then
  begin
    MessageDlg('Debe introducir un tipo de gasto valido ...', mtError, [mbOK], 0);
    tipo_gc.SetFocus;
  end
  else
  if importe_gc.Text = '' then
  begin
    MessageDlg('Debe introducir el importe del Gasto...', mtError, [mbOK], 0);
    importe_gc.SetFocus;
  end
  else
  begin
    //El gasto debe ser de entregas
    with DMAuxDB.QAux do
    begin
      if Active then Close;
      SQL.Clear;
      SQL.Add('SELECT count(*) As cuenta FROM frf_tipo_gastos ');
      SQL.Add('WHERE tipo_tg = ' + QuotedStr(tipo_gc.Text));
      SQL.Add('AND gasto_transito_tg = 2');
      Open;
      if (FieldByName('cuenta').AsInteger = 0) then
      begin
        MessageDlg('El Tipo de Gastos introducido no es de compras o no existe ...', mtError, [mbOK], 0);
        tipo_gc.SetFocus;
      end
      else
      begin
        result:= True;
      end;
     Close;
    end;
  end;
end;

procedure TFMGastosCompras.AceptarAltas;
var
  sProducto, stipo: string;
begin
  if ValidarDatos then
  begin
    QGastosCompras.Post;
    QGastosCompras.DisableControls;
    try
      sProducto:= Trim(QGastosCompras.FieldByname('producto_gc').AsString);
      sTipo:= QGastosCompras.FieldByname('tipo_gc').AsString;
      QGastosCompras.Close;
      QGastosCompras.Open;
      While ( ( QGastosCompras.FieldByname('producto_gc').AsString <> sProducto ) OR ( QGastosCompras.FieldByname('tipo_gc').AsString <> sTipo ) ) AND
        not QGastosCompras.Eof do
        QGastosCompras.Next;
    finally
      QGastosCompras.EnableControls;
    end;

    cambiarEstado(teLocalizar);
  end;
end;

procedure TFMGastosCompras.CancelarAltas;
begin
  QGastosCompras.Cancel;
  cambiarEstado(teLocalizar);
end;

procedure TFMGastosCompras.AceptarModificar;
begin
  if ValidarDatos then
  begin
    QGastosCompras.Post;
    cambiarEstado(teLocalizar);
  end;
end;

procedure TFMGastosCompras.CancelarModificar;
begin
  QGastosCompras.Cancel;
  cambiarEstado(teLocalizar);
end;

// ******************************************************************
// **                  OBTENCIÓN DE DATOS                          **
// ******************************************************************

procedure TFMGastosCompras.ABorrarExecute(Sender: TObject);
begin
  QGastosCompras.Delete;
  cambiarEstado(teConjuntoResultado);
end;

procedure TFMGastosCompras.cambiarEstado(estad: TEstado);
var
  vis: Boolean;
begin
  estado := estad;
  vis := ( estad = teAlta ) or ( estad = teModificar );

  LTipoGastos.Visible := vis;
  tipo_gc.Visible := vis;
  BGBTipoGastos.Visible := vis;
  STTipoGastos.Visible := vis;
  LImporte.Visible := vis;
  importe_gc.Visible := vis;
  ref_fac_gc.Visible := vis;
  nota_gc.Visible := vis;
  LApunte.Visible := vis;
  LProducto.Visible := vis;
  Producto_gc.Visible := vis;
  stProducto.Visible := vis;
  BGBProducto.Visible := vis;

  if vis then
  begin
    rejilla.Top := 136;
    rejilla.Height := 122;
    rejilla.Enabled:= False;
  end
  else
  begin
    rejilla.Top := 48;
    rejilla.Height := 210;
    rejilla.Enabled:= True;
  end;


  case estad of
    teAlta:
      begin
        APrimero.Enabled := False;
        ASiguiente.Enabled := False;
        AAnterior.Enabled := False;
        AUltimo.Enabled := False;
      end;
    teModificar:
      begin
        APrimero.Enabled := False;
        ASiguiente.Enabled := False;
        AAnterior.Enabled := False;
        AUltimo.Enabled := false;
      end;
    teLocalizar:
      begin
        botoneraDespl;
      end;
  end;
  Botones;
end;

procedure TFMGastosCompras.Botones;
begin
  case estado of
    teAlta:
      begin
        Salir := false;
        ASalir.ShortCut := 0;
        ACancelar.ShortCut := VK_ESCAPE;

        AModificar.Enabled := False;
        AAlta.Enabled := False;
        ABorrar.Enabled := FAlse;

        AAceptar.Enabled := True;
        ACancelar.Enabled := True;

        ASalir.Enabled := false;

        ARejillaFlotante.Enabled := true;
      end;
    teModificar:
      begin
        Salir := false;
        ASalir.ShortCut := 0;
        ACancelar.ShortCut := VK_ESCAPE;

        AModificar.Enabled := False;
        AAlta.Enabled := False;
        ABorrar.Enabled := False;

        AAceptar.Enabled := True;
        ACancelar.Enabled := True;

        ASalir.Enabled := false;

        ARejillaFlotante.Enabled := true;
      end;
    teLocalizar:
      begin
        Salir := true;
        ASalir.ShortCut := VK_ESCAPE;
        ACancelar.ShortCut := 0;

        if not QGastosCompras.IsEmpty then
        begin
          AModificar.Enabled := true;
          ABorrar.Enabled := true;
        end
        else
        begin
          AModificar.Enabled := false;
          ABorrar.Enabled := false;
        end;
        AAlta.Enabled := true;

        AAceptar.Enabled := false;
        ACancelar.Enabled := false;


        ASalir.Enabled := true;

        ARejillaFlotante.Enabled := true;

      end;
  end;
end;

procedure TFMGastosCompras.AAltaExecute(Sender: TObject);
begin
  cambiarEstado(teAlta);
  QGastosCompras.Insert;
  QGastosCompras.FieldByname('empresa_gc').AsString := sEmpresa;
  QGastosCompras.FieldByname('centro_gc').AsString := sCentro;
  QGastosCompras.FieldByname('numero_gc').AsInteger := iNumero;
  QGastosCompras.FieldByname('pagado_gc').AsInteger := 0;
  producto_gc.SetFocus;
  producto_gc.Change;
  tipo_gc.Change;
end;

procedure TFMGastosCompras.AModificarExecute(Sender: TObject);
begin
  cambiarEstado(teModificar);
  QGastosCompras.Edit;
  importe_gc.SetFocus;
  producto_gc.Change;
  tipo_gc.Change;
end;

procedure TFMGastosCompras.CalculoGastos;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select sum(importe_gc) importe ');
    SQL.Add(' from frf_gastos_compras ');
    SQL.Add(' where empresa_gc = :empresa ');
    SQL.Add('   and centro_gc = :centro ');
    SQL.Add('   and numero_gc = :numero ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('numero').AsInteger:= iNumero;
    try
      Open;
      STTotalGastos.Caption := FieldByName('importe').AsString;
    finally
      Close;
    end;
  end;
end;

procedure TFMGastosCompras.tipo_gcRequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
  isTime := false;
  if TBEdit(Sender).CanFocus then
  begin
    if (Estado = teLocalizar) then
      Exit;
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
    isTime := true;
  end;
end;

procedure TFMGastosCompras.APrimeroExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.First;
  botoneraDespl;
end;

procedure TFMGastosCompras.AAnteriorExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Prior;
  botoneraDespl;
end;

procedure TFMGastosCompras.ASiguienteExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Next;
  botoneraDespl;
end;

procedure TFMGastosCompras.AUltimoExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Last;
  botoneraDespl;
end;

procedure TFMGastosCompras.botoneraDespl;
begin
  if ((not rejilla.DataSource.DataSet.Active) or
    (rejilla.DataSource.DataSet.RecordCount <= 0)) then
  begin
    APrimero.Enabled := False;
    AAnterior.Enabled := False;
    ASiguiente.Enabled := False;
    AUltimo.Enabled := False;
    Exit;
  end;


  if rejilla.DataSource.DataSet.Bof then
  begin
    APrimero.Enabled := False;
    AAnterior.Enabled := False;
  end
  else
  begin
    APrimero.Enabled := True;
    AAnterior.Enabled := True;
  end;

  if rejilla.DataSource.DataSet.Eof then
  begin
    ASiguiente.Enabled := False;
    AUltimo.Enabled := False;
  end
  else
  begin
    ASiguiente.Enabled := True;
    AUltimo.Enabled := True;
  end;
end;

procedure TFMGastosCompras.EuroConversorExecute;
var
  aux: string;
begin
  aux := DConversor.Execute(self, Date, 'EUR', 'GBP');
  if ActiveControl is TBEdit then
  begin
    if Trim(aux) <> '' then
      TBEdit(ActiveControl).Text := aux;
  end;
end;

procedure TFMGastosCompras.rejillaDblClick(Sender: TObject);
begin
  SBModificar.Click;
end;

procedure TFMGastosCompras.tipo_gcChange(Sender: TObject);
begin
  STTipoGastos.Caption:= desTipoGastos(tipo_gc.Text );
end;

procedure TFMGastosCompras.producto_gcChange(Sender: TObject);
begin
  stProducto.Caption:= desProducto(sEmpresa, producto_gc.Text );
  if stProducto.Caption = '' then
    stProducto.Caption:= 'Vacio = Todos los productos';
end;

procedure TFMGastosCompras.ARejillaFlotanteExecute(Sender: TObject);
begin
  if producto_gc.Focused then
    BGBProducto.Click
  else
  if Tipo_gc.Focused then
    BGBTipoGastos.Click
  else
  if Fecha_fac_gc.Focused then
    btnFecha_fac_gc.Click;
end;

procedure TFMGastosCompras.BGBProductoClick(Sender: TObject);
begin
  if DMBaseDatos.QDespegables.Active then
    DMBaseDatos.QDespegables.Close;
  DMBaseDatos.QDespegables.SQL.Clear;

  RejillaFlotante.BControl := producto_gc;
  DMBaseDatos.QDespegables.SQL.Add(' select producto_p, descripcion_p ');
  DMBaseDatos.QDespegables.SQL.Add(' from frf_productos ');
  DMBaseDatos.QDespegables.SQL.Add(' where empresa_p = :empresa ');
  DMBaseDatos.QDespegables.SQL.Add(' order by producto_p, descripcion_p ');

  DMBaseDatos.QDespegables.ParamByName('empresa').AsString:= sEmpresa;

  DMBaseDatos.QDespegables.Open;
  BGBTipoGastos.GridShow;
end;

procedure TFMGastosCompras.BGBTipoGastosClick(Sender: TObject);
begin
  if DMBaseDatos.QDespegables.Active then
    DMBaseDatos.QDespegables.Close;
  DMBaseDatos.QDespegables.SQL.Clear;

  RejillaFlotante.BControl := tipo_gc;
  DMBaseDatos.QDespegables.SQL.Add(' select tipo_tg, descripcion_tg ');
  DMBaseDatos.QDespegables.SQL.Add(' from frf_tipo_gastos ');
  DMBaseDatos.QDespegables.SQL.Add(' where gasto_transito_tg = 2 ');
  DMBaseDatos.QDespegables.SQL.Add(' and not exists ');
  DMBaseDatos.QDespegables.SQL.Add(' ( ');
  DMBaseDatos.QDespegables.SQL.Add('   select * ');
  DMBaseDatos.QDespegables.SQL.Add('   from frf_gastos_compras ');
  DMBaseDatos.QDespegables.SQL.Add('   where empresa_gc = :empresa ');
  DMBaseDatos.QDespegables.SQL.Add('     and centro_gc = :centro ');
  DMBaseDatos.QDespegables.SQL.Add('     and numero_gc = :numero ');
  DMBaseDatos.QDespegables.SQL.Add('   and tipo_gc = tipo_tg ');
  if producto_gc.Text <> '' then
  begin
    DMBaseDatos.QDespegables.SQL.Add('and producto_gc = :producto ');
  end;
  DMBaseDatos.QDespegables.SQL.Add(' ) ');
  DMBaseDatos.QDespegables.SQL.Add(' order by tipo_tg, descripcion_tg ');

  if producto_gc.Text <> '' then
  begin
    DMBaseDatos.QDespegables.ParamByName('producto').AsString:= producto_gc.Text;
  end;
  DMBaseDatos.QDespegables.ParamByName('empresa').AsString:= sEmpresa;
  DMBaseDatos.QDespegables.ParamByName('centro').AsString:= sCentro;
  DMBaseDatos.QDespegables.ParamByName('numero').AsInteger:= iNumero;

  DMBaseDatos.QDespegables.Open;
  BGBTipoGastos.GridShow;
end;

procedure TFMGastosCompras.rejillaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  sAux: string;
begin
  if DataCol = 1 then
  begin
    sAux:= desTipoGastos( Column.Field.AsString );

    if gdSelected in State then
      rejilla.Canvas.Brush.Color := clMenuHighlight;
    if gdFocused in State then
      rejilla.Canvas.Font.Color := clMenuHighlight;

    rejilla.Canvas.TextRect(Rect,Rect.Left, Rect.Top,sAux);

  end
  else
    rejilla.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFMGastosCompras.btnFecha_fac_gcClick(Sender: TObject);
var
  dFecha: TDate;
begin
  dFecha:= StrToDateDef( fecha_fac_gc.Text, Date );
  Calendario.BControl:= fecha_fac_gc;
  Calendario.Date:= dFecha;
  btnFecha_fac_gc.CalendarShow;
end;

procedure TFMGastosCompras.QGastosComprasAfterPost(DataSet: TDataSet);
begin
  //Poner status_gastos_c de la compra a 0 para indicar que tenemos que volver a
  //asignar gastos
  bGastoModificado:= True;
end;

procedure TFMGastosCompras.QGastosComprasAfterDelete(DataSet: TDataSet);
begin
  bGastoModificado:= True;
end;

function TFMGastosCompras.GastosModificados: boolean;
begin
  result:= bGastoModificado;
end;

end.


