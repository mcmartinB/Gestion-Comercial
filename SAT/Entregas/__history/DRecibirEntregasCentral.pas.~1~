unit DRecibirEntregasCentral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, Buttons, nbLabels, BEdit, Grids,
  DBGrids, DB, DBTables, CheckLst, DBCtrls, Menus, CAuxiliarDB, ActnList, BGrid,
  BSpeedButton, BGridButton;

type
  TFDRecibirEntregasCentral = class(TForm)
    empresa: TnbDBSQLCombo;
    nbLabel1: TnbLabel;
    nomEmpresa: TnbStaticText;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    QEntregasPendientes: TQuery;
    DSEntregasPendientes: TDataSource;
    clbEntregas: TCheckListBox;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    nbLabel5: TnbLabel;
    nbLabel6: TnbLabel;
    nbLabel7: TnbLabel;
    nbLabel8: TnbLabel;
    nbLabel9: TnbLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    nbLabel10: TnbLabel;
    PopupMenu1: TPopupMenu;
    SeleccionarTodo1: TMenuItem;
    DesmarcarSeleccion1: TMenuItem;
    N1: TMenuItem;
    MarcarEntregaSeleccionadaComoEnviada1: TMenuItem;
    fechaDesde: TnbDBCalendarCombo;
    nbLabel11: TnbLabel;
    nbLabel12: TnbLabel;
    fechaHasta: TnbDBCalendarCombo;
    nbLabel13: TnbLabel;
    btnCentro: TBGridButton;
    nomCentro: TnbStaticText;
    centro: TBEdit;
    RejillaFlotante: TBGrid;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    procedure BtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function nomEmpresaGetDescription: String;
    procedure empresaChange(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clbEntregasClick(Sender: TObject);
    procedure MarcarEntregaSeleccionadaComoEnviada1Click(Sender: TObject);
    procedure SeleccionarTodo1Click(Sender: TObject);
    procedure DesmarcarSeleccion1Click(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure ADesplegarRejillaExecute(Sender: TObject);
  private
    { Private declarations }
    function  ParametrosOK: boolean;
    procedure RecepcionFruta;
    procedure SeleccionarTodo( const AMarcar: boolean );
    procedure ReCargarDatos;

  public
    { Public declarations }
  end;

implementation

uses ShellAPI, bSQLUtils, UDMAuxDB, UDMBaseDatos,
     bDialogs, CVariables, UDMConfig,
     bTextUtils, DMRecibirEntregasCentral;

{$R *.dfm}

var
  FDMRecibirEntregasCentral: TFDMRecibirEntregasCentral;

procedure TFDRecibirEntregasCentral.FormCreate(Sender: TObject);
var
  sMsg: string;
begin
  with QEntregasPendientes do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ec codigo, proveedor_ec proveedor, almacen_ec almacen, albaran_ec albaran, ');
    SQL.Add('        fecha_carga_ec carga, fecha_llegada_ec llegada, adjudicacion_ec conduce, vehiculo_ec vehiculo ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and fecha_llegada_ec between :inicio and :fin ');
    SQL.Add(' and centro_llegada_ec = :centro ');
    SQL.Add(' and centro_origen_ec = :centro ');
    SQL.Add('   and nvl(envio_ec,0) = 0 ');
    SQL.Add(' order by 1 desc');
  end;


  FDMRecibirEntregasCentral:= TFDMRecibirEntregasCentral.create( Application );
  empresa.Text:= gsDefEmpresa;
  fechaDesde.AsDate:= Date - 7;
  fechaHasta.AsDate:= Date + 6;

  centro.Tag := kCentro;

end;

procedure TFDRecibirEntregasCentral.ADesplegarRejillaExecute(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  case ActiveControl.Tag of
    kCentro: DespliegaRejilla(btnCentro,[empresa.Text])
  end;
end;

procedure TFDRecibirEntregasCentral.BtnCancelClick(Sender: TObject);
begin
  if not QEntregasPendientes.Active then
  begin
    Close;
  end
  else
  begin
    QEntregasPendientes.Close;
    clbEntregas.Clear;
    btnOk.Caption:= 'Recibir Pendientes (F1)';
    btnCancel.Caption:= 'Cerrar (Esc)';
    empresa.Enabled:= True;
    fechaDesde.Enabled:= True;
    fechaHasta.Enabled:= True;
  end;
end;

procedure TFDRecibirEntregasCentral.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil( FDMRecibirEntregasCentral );
  DMBaseDatos.BDCentral.Close;
  Action:= caFree;
end;

procedure TFDRecibirEntregasCentral.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f1:btnOk.Click;
    vk_escape:btnCancel.Click;
  end;
end;

procedure TFDRecibirEntregasCentral.FormKeyDown(Sender: TObject; var Key: Word;
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
  end;
end;

function TFDRecibirEntregasCentral.nomEmpresaGetDescription: String;
begin
  result:= desEmpresa( empresa.Text );
end;

procedure TFDRecibirEntregasCentral.empresaChange(Sender: TObject);
begin
  nomEmpresa.Description;
end;

function TFDRecibirEntregasCentral.ParametrosOK: boolean;
var
  dCarga, dLlegada: TDateTime;
begin
  result:= True;
  if result and ( nomEmpresa.Caption = '' ) then
  begin
    ShowMessage('Código de empresa incorrecto.');
    empresa.SetFocus;
    result:= false;
  end;
  if fechaDesde.AsDate > fechaHasta.AsDate then
  begin
    ShowMessage('Rango de fechas incorrecto.');
    fechaDesde.SetFocus;
    result:= false;
  end;
end;

procedure TFDRecibirEntregasCentral.BtnOkClick(Sender: TObject);
begin
  if not ParametrosOK then
  begin
    Exit;
  end;
  if QEntregasPendientes.Active then
  begin
    try
      DMBaseDatos.BDCentral.Open;
      RecepcionFruta;
    finally
      DMBaseDatos.BDCentral.Close;
      QEntregasPendientes.Close;
      clbEntregas.Clear;
      btnOk.Caption:= 'Recibir Pendientes (F1)';
      btnCancel.Caption:= 'Cerrar (Esc)';
      empresa.Enabled:= True;
      fechaDesde.Enabled:= True;
      fechaHasta.Enabled:= True;
    end;
  end
  else
  begin
    QEntregasPendientes.ParamByName('empresa').AsString:= empresa.Text;
    QEntregasPendientes.ParamByName('inicio').AsDateTime:= fechaDesde.AsDate;
    QEntregasPendientes.ParamByName('fin').AsDateTime:= fechaHasta.AsDate;
    QEntregasPendientes.ParamByName('centro').AsString:= centro.Text;
    QEntregasPendientes.Open;
    if QEntregasPendientes.IsEmpty then
    begin
      ShowMessage('No hay entregas pendientes de recibir.');
      QEntregasPendientes.Close;
      clbEntregas.Clear;
    end
    else
    begin
      while not QEntregasPendientes.Eof do
      begin
        //if not FDMRecibirEntregasCentral.ExisteEntrega( QEntregasPendientes.FieldByName('codigo').AsString ) then
          clbEntregas.Items.Add(QEntregasPendientes.FieldByName('codigo').AsString );
        QEntregasPendientes.Next;
      end;
      if clbEntregas.Items.Count > 0 then
      begin
        empresa.Enabled:= False;
        fechaDesde.Enabled:= False;
        fechaHasta.Enabled:= False;
        btnOk.Caption:= 'Iniciar (F1)';
        btnCancel.Caption:= 'Cancelar (Esc)';
        SeleccionarTodo( False );
        clbEntregas.ItemIndex:= 0;
        QEntregasPendientes.First;
      end
      else
      begin
        ShowMessage('No hay entregas pendientes de recibir.');
        QEntregasPendientes.Close;
        clbEntregas.Clear;
      end;
    end;
  end;
end;

procedure TFDRecibirEntregasCentral.RecepcionFruta;
var
  iOk, iTotal, iMarcados: integer;
  slMsg: TStringList;
begin

  iTotal:= 0;
  slMsg:= TStringList.Create;

  try
    iOk:= FDMRecibirEntregasCentral.RecibirEntregasMarcadas( clbEntregas, iTotal, iMarcados, slMsg );
    ShowMessage( slMsg.Text );
  finally
    FreeAndNil( slMsg );
  end;
end;

procedure TFDRecibirEntregasCentral.centroChange(Sender: TObject);
begin
  nomCentro.Caption := desCentro(empresa.Text , centro.Text);
end;

procedure TFDRecibirEntregasCentral.clbEntregasClick(Sender: TObject);
begin
  QEntregasPendientes.Locate('codigo',clbEntregas.Items[clbEntregas.ItemIndex],[]);
end;


procedure TFDRecibirEntregasCentral.MarcarEntregaSeleccionadaComoEnviada1Click(
  Sender: TObject);
var
  iOk, iTotal, iMarcados: integer;
  slMsg: TStringList;
begin
  iTotal:= 0;
  slMsg:= TStringList.Create;

  try
    if MessageDlg('¿Esta seguro de querer marcar como enviadas las entregas seleccionadas?',
                mtConfirmation, [mbYes, mbCancel], 0 ) = mrYes then
    begin
      iOk:= FDMRecibirEntregasCentral.MarcarComoEnviadas( clbEntregas, iTotal, slMsg );
      ReCargarDatos;
      ShowMessage( slMsg.Text );
    end;

  finally
    FreeAndNil( slMsg );
  end;
end;

procedure TFDRecibirEntregasCentral.ReCargarDatos;
begin
  QEntregasPendientes.Close;
  QEntregasPendientes.ParamByName('empresa').AsString:= empresa.Text;
  QEntregasPendientes.ParamByName('inicio').AsDateTime:= fechaDesde.AsDate;
  QEntregasPendientes.ParamByName('fin').AsDateTime:= fechaHasta.AsDate;
  QEntregasPendientes.ParamByName('centro').AsString:= centro.Text;
  QEntregasPendientes.Open;
  clbEntregas.Clear;

  if QEntregasPendientes.IsEmpty then
  begin
    QEntregasPendientes.Close;
    empresa.Enabled:= True;
    fechaDesde.Enabled:= True;
    fechaHasta.Enabled:= True;
    btnOk.Caption:= 'Recibir Pendientes (F1)';
    btnCancel.Caption:= 'Cerrar (Esc)';
  end
  else
  begin
    while not QEntregasPendientes.Eof do
    begin
      //if not FDMRecibirEntregasCentral.ExisteEntrega( QEntregasPendientes.FieldByName('codigo').AsString ) then
        clbEntregas.Items.Add(QEntregasPendientes.FieldByName('codigo').AsString );
      QEntregasPendientes.Next;
    end;
    if clbEntregas.Items.Count > 0 then
    begin
      clbEntregas.ItemIndex:= 0;
      QEntregasPendientes.First;
    end
    else
    begin
      QEntregasPendientes.Close;
      empresa.Enabled:= True;
      fechaDesde.Enabled:= True;
      fechaHasta.Enabled:= True;
      btnOk.Caption:= 'Recibir Pendientes (F1)';
      btnCancel.Caption:= 'Cerrar (Esc)';
    end;
  end;
end;

procedure TFDRecibirEntregasCentral.SeleccionarTodo1Click(Sender: TObject);
begin
  SeleccionarTodo( True );
end;

procedure TFDRecibirEntregasCentral.DesmarcarSeleccion1Click(
  Sender: TObject);
begin
  SeleccionarTodo( false );
end;

procedure TFDRecibirEntregasCentral.SeleccionarTodo( const AMarcar: boolean );
var
  i: integer;
begin
  for i:= 0 to clbEntregas.Items.Count -1 do
  begin
    clbEntregas.Checked[i]:= AMarcar;
  end;
end;

end.
