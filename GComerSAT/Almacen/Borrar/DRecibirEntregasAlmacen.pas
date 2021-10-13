unit DRecibirEntregasAlmacen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, Buttons, nbLabels, BEdit, Grids,
  DBGrids, DB, DBTables, CheckLst, DBCtrls, Menus;

type
  TFDRecibirEntregasAlmacen = class(TForm)
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
    nbLabel1: TnbLabel;
    eEmpresa: TnbDBSQLCombo;
    nomEmpresa: TnbStaticText;
    nbLabel11: TnbLabel;
    eCentro: TnbDBSQLCombo;
    nomCentro: TnbStaticText;
    procedure BtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function nomEmpresaGetDescription: String;
    procedure eEmpresaChange(Sender: TObject);
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
    function nomCentroGetDescription: String;
    procedure eCentroChange(Sender: TObject);
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

uses bSQLUtils, UDMAuxDB, UDMBaseDatos,
     bDialogs, CVariables, UDMConfig,
     bTextUtils, DMRecibirEntregasAlmacen;

{$R *.dfm}

var
  FDMRecibirEntregasAlmacen: TFDMRecibirEntregasAlmacen;

procedure TFDRecibirEntregasAlmacen.FormCreate(Sender: TObject);
var
  sMsg: string;
begin
  with QEntregasPendientes do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ec codigo, proveedor_ec proveedor, almacen_ec almacen, albaran_ec albaran, ');
    SQL.Add('        fecha_carga_ec carga, fecha_llegada_ec llegada, adjudicacion_ec conduce, vehiculo_ec vehiculo ');
    SQL.Add(' from aux_entregas_c ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add('   and centro_llegada_ec = :centro ');
    SQL.Add(' order by adjudicacion_ec desc, codigo_ec desc');
  end;


  FDMRecibirEntregasAlmacen:= TFDMRecibirEntregasAlmacen.create( Application );
  eEmpresa.Text:= DMConfig.sEmpresaInstalacion;
  eCentro.Text:= DMConfig.sCentroInstalacion;
end;

procedure TFDRecibirEntregasAlmacen.BtnCancelClick(Sender: TObject);
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
    eEmpresa.Enabled:= True;
    eCentro.Enabled:= True;
  end;
end;

procedure TFDRecibirEntregasAlmacen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil( FDMRecibirEntregasAlmacen );
  DMBaseDatos.BDCentral.Close;
  Action:= caFree;
end;

procedure TFDRecibirEntregasAlmacen.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f1:btnOk.Click;
    vk_escape:btnCancel.Click;
  end;
end;

procedure TFDRecibirEntregasAlmacen.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFDRecibirEntregasAlmacen.nomEmpresaGetDescription: String;
begin
  result:= desEmpresa( eEmpresa.Text );
end;

function TFDRecibirEntregasAlmacen.nomCentroGetDescription: String;
begin
  result:= desCentro( eEmpresa.Text, eCentro.Text );
end;

procedure TFDRecibirEntregasAlmacen.eEmpresaChange(Sender: TObject);
begin
  nomEmpresa.Description;
end;

procedure TFDRecibirEntregasAlmacen.eCentroChange(Sender: TObject);
begin
  nomCentro.Description;
end;

function TFDRecibirEntregasAlmacen.ParametrosOK: boolean;
var
  dCarga, dLlegada: TDateTime;
begin
  result:= True;
  if ( nomEmpresa.Caption = '' ) then
  begin
    ShowMessage('Código de empresa incorrecto.');
    eEmpresa.SetFocus;
    result:= false;
  end;
  if result and ( nomCentro.Caption = '' ) then
  begin
    ShowMessage('Código de centro incorrecto.');
    eCentro.SetFocus;
    result:= false;
  end;
end;

procedure TFDRecibirEntregasAlmacen.BtnOkClick(Sender: TObject);
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
      eEmpresa.Enabled:= True;
      eCentro.Enabled:= True;
    end;
  end
  else
  begin
    QEntregasPendientes.ParamByName('empresa').AsString:= eEmpresa.Text;
    QEntregasPendientes.ParamByName('centro').AsString:= eCentro.Text;
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
        //if not FDMRecibirEntregasAlmacen.ExisteEntrega( QEntregasPendientes.FieldByName('codigo').AsString ) then
          clbEntregas.Items.Add( QEntregasPendientes.FieldByName('codigo').AsString + ' (Conduce:' +
                                 QEntregasPendientes.FieldByName('conduce').AsString + ')' );
        QEntregasPendientes.Next;
      end;
      if clbEntregas.Items.Count > 0 then
      begin
        eEmpresa.Enabled:= False;
        eCentro.Enabled:= False;
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

procedure TFDRecibirEntregasAlmacen.RecepcionFruta;
var
  iOk, iTotal, iMarcados: integer;
  slMsg: TStringList;
begin

  iTotal:= 0;
  slMsg:= TStringList.Create;

  try
    iOk:= FDMRecibirEntregasAlmacen.RecibirEntregasMarcadas( clbEntregas, iTotal, iMarcados, slMsg );
    ShowMessage( slMsg.Text );
  finally
    FreeAndNil( slMsg );
  end;
end;

procedure TFDRecibirEntregasAlmacen.clbEntregasClick(Sender: TObject);
begin
  QEntregasPendientes.Locate('codigo',copy( clbEntregas.Items[clbEntregas.ItemIndex], 1, 12 ),[]);
end;

procedure TFDRecibirEntregasAlmacen.MarcarEntregaSeleccionadaComoEnviada1Click(
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
      iOk:= FDMRecibirEntregasAlmacen.BorrarEntregasMarcadas( clbEntregas, iTotal, iMarcados, slMsg );
      ReCargarDatos;
      ShowMessage( slMsg.Text );
    end;

  finally
    FreeAndNil( slMsg );
  end;
end;

procedure TFDRecibirEntregasAlmacen.ReCargarDatos;
begin
  QEntregasPendientes.Close;
  QEntregasPendientes.ParamByName('empresa').AsString:= eEmpresa.Text;
  QEntregasPendientes.ParamByName('centro').AsString:= eCentro.Text;
  QEntregasPendientes.Open;
  clbEntregas.Clear;

  if QEntregasPendientes.IsEmpty then
  begin
    QEntregasPendientes.Close;
    eEmpresa.Enabled:= True;
    eCentro.Enabled:= True;
    btnOk.Caption:= 'Recibir Pendientes (F1)';
    btnCancel.Caption:= 'Cerrar (Esc)';
  end
  else
  begin
    while not QEntregasPendientes.Eof do
    begin
      //if not FDMRecibirEntregasAlmacen.ExisteEntrega( QEntregasPendientes.FieldByName('codigo').AsString ) then
        clbEntregas.Items.Add(QEntregasPendientes.FieldByName('codigo').AsString + ' (Conduce:' +
                                 QEntregasPendientes.FieldByName('conduce').AsString + ')' );
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
      eEmpresa.Enabled:= True;
      eCentro.Enabled:= True;
      btnOk.Caption:= 'Recibir Pendientes (F1)';
      btnCancel.Caption:= 'Cerrar (Esc)';
    end;
  end;
end;

procedure TFDRecibirEntregasAlmacen.SeleccionarTodo1Click(Sender: TObject);
begin
  SeleccionarTodo( True );
end;

procedure TFDRecibirEntregasAlmacen.DesmarcarSeleccion1Click(
  Sender: TObject);
begin
  SeleccionarTodo( false );
end;

procedure TFDRecibirEntregasAlmacen.SeleccionarTodo( const AMarcar: boolean );
var
  i: integer;
begin
  for i:= 0 to clbEntregas.Items.Count -1 do
  begin
    clbEntregas.Checked[i]:= AMarcar;
  end;
end;

end.
