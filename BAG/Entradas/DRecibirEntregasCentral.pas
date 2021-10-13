unit DRecibirEntregasCentral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, Buttons, nbLabels, BEdit, Grids,
  DBGrids, DB, DBTables, CheckLst, DBCtrls, Menus;

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
    nbLabel5: TnbLabel;
    nbLabel6: TnbLabel;
    nbLabel7: TnbLabel;
    nbLabel8: TnbLabel;
    nbLabel9: TnbLabel;
    DBText1: TDBText;
    DBText2: TDBText;
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
    nbLabel11: TnbLabel;
    nbLabel12: TnbLabel;
    lblCentroLlegada: TnbLabel;
    edtCentro: TnbDBSQLCombo;
    stCentro: TnbStaticText;
    fechaHasta: TnbDBCalendarCombo;
    fechaDesde: TnbDBCalendarCombo;
    lblAnyoSemana: TnbLabel;
    dlblAnyoSemana: TDBText;
    lblCentro: TnbLabel;
    dbtxtCentro: TDBText;
    chkFechaDefinitiva: TCheckBox;
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
    procedure edtCentroChange(Sender: TObject);
    function stCentroGetDescription: String;
    function edtCentroGetSQL: String;
    procedure FormShow(Sender: TObject);
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
begin
  with QEntregasPendientes do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ec codigo, proveedor_ec proveedor, albaran_ec albaran, anyo_Semana_ec anyo_Semana, ');
    SQL.Add('        fecha_carga_ec carga, fecha_llegada_ec llegada, adjudicacion_ec conduce, vehiculo_ec vehiculo, ');
    SQL.Add('        centro_llegada_ec centro, descripcion_c des_Centro ');
    SQL.Add(' from frf_entregas_c join frf_Centros on empresa_ec = empresa_c and centro_llegada_ec = centro_c ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and fecha_llegada_ec between :inicio and :fin ');
    SQL.Add(' and centro_llegada_ec = :centro ');
    SQL.Add('   and status_ec = 0 ');
    SQL.Add(' order by 1 desc');
  end;


  FDMRecibirEntregasCentral:= TFDMRecibirEntregasCentral.create( Application );
  empresa.Text:= gsDefEmpresa;
  edtCentro.Text:= gsDefCentro;
  fechaDesde.AsDate:= Date - 7;
  fechaHasta.AsDate:= Date + 2;
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
    edtCentro.Enabled:= True;
    chkFechaDefinitiva.Enabled:= True;
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

procedure TFDRecibirEntregasCentral.FormShow(Sender: TObject);
var SAux: String;
begin
  sAux := Valortmensajes;
  if sAux <> '' then
  begin
    ShowMessage(SAux);
    btnOk.Enabled := false;
  end
  else
    btnOk.enabled := true;
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
  stCentro.Description;
end;

function TFDRecibirEntregasCentral.ParametrosOK: boolean;
begin
  result:= True;
  if result and ( nomEmpresa.Caption = '' ) then
  begin
    ShowMessage('Código de empresa incorrecto.');
    empresa.SetFocus;
    result:= false;
  end;
  if result and ( stCentro.Caption = '' ) then
  begin
    ShowMessage('Código de centro incorrecto.');
    edtCentro.SetFocus;
    result:= false;
  end;
  if fechaDesde.AsDate > fechaHasta.AsDate then
  begin
    ShowMessage('Rango de fechas incorrecto.');
    fechaDesde.SetFocus;
    result:= false;
  end;
  if Result then
  begin
    with QEntregasPendientes do
    begin
      SQL.Clear;
      SQL.Add(' select codigo_ec codigo, proveedor_ec proveedor, albaran_ec albaran, anyo_Semana_ec anyo_Semana, ');
      SQL.Add('        fecha_carga_ec carga, fecha_llegada_ec llegada, adjudicacion_ec conduce, vehiculo_ec vehiculo, ');
      SQL.Add('        centro_llegada_ec centro, descripcion_c des_Centro ');
      SQL.Add(' from frf_entregas_c join frf_Centros on empresa_ec = empresa_c and centro_llegada_ec = centro_c ');
      SQL.Add(' where empresa_ec = :empresa ');
      SQL.Add(' and fecha_llegada_ec between :inicio and :fin ');
      if edtCentro.Text <> '' then
        SQL.Add(' and centro_llegada_ec = :centro ');
      if chkFechaDefinitiva.Checked then
        SQL.Add(' and fecha_llegada_definitiva_ec = 1 ')
      else
        SQL.Add(' and fecha_llegada_definitiva_ec = 0 ');
      SQL.Add(' and status_ec = 0 ');
      SQL.Add(' order by 1 desc');
    end;
  end;

end;

procedure TFDRecibirEntregasCentral.BtnOkClick(Sender: TObject);
begin
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
      edtCentro.Enabled:= True;
      chkFechaDefinitiva.Enabled:= True;
    end;
  end
  else
  begin
    if not ParametrosOK then
    begin
      Exit;
    end;
    QEntregasPendientes.ParamByName('empresa').AsString:= empresa.Text;
    QEntregasPendientes.ParamByName('inicio').AsDateTime:= fechaDesde.AsDate;
    QEntregasPendientes.ParamByName('fin').AsDateTime:= fechaHasta.AsDate;
    if edtCentro.Text <> '' then
        QEntregasPendientes.ParamByName('centro').AsString:= edtCentro.Text;
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
        edtCentro.Enabled:= False;
        chkFechaDefinitiva.Enabled:= False;
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
  iTotal, iMarcados: integer;
  slMsg: TStringList;
begin

  iTotal:= 0;
  slMsg:= TStringList.Create;

  try
    FDMRecibirEntregasCentral.RecibirEntregasMarcadas( clbEntregas, iTotal, iMarcados, slMsg );
    ShowMessage( slMsg.Text );
  finally
    FreeAndNil( slMsg );
  end;
end;

procedure TFDRecibirEntregasCentral.clbEntregasClick(Sender: TObject);
begin
  QEntregasPendientes.Locate('codigo',clbEntregas.Items[clbEntregas.ItemIndex],[]);
end;


procedure TFDRecibirEntregasCentral.MarcarEntregaSeleccionadaComoEnviada1Click(
  Sender: TObject);
var
  iTotal: integer;
  slMsg: TStringList;
begin
  iTotal:= 0;
  slMsg:= TStringList.Create;

  try
    if MessageDlg('¿Esta seguro de querer marcar como enviadas las entregas seleccionadas?',
                mtConfirmation, [mbYes, mbCancel], 0 ) = mrYes then
    begin
      FDMRecibirEntregasCentral.MarcarComoEnviadas( clbEntregas, iTotal, slMsg );
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
  QEntregasPendientes.ParamByName('centro').AsString:= DMConfig.sCentroInstalacion;
  QEntregasPendientes.Open;
  clbEntregas.Clear;

  if QEntregasPendientes.IsEmpty then
  begin
    QEntregasPendientes.Close;
    empresa.Enabled:= True;
    fechaDesde.Enabled:= True;
    fechaHasta.Enabled:= True;
    edtCentro.Enabled:= True;
    chkFechaDefinitiva.Enabled:= True;
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
      edtCentro.Enabled:= True;
      chkFechaDefinitiva.Enabled:= True;
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

procedure TFDRecibirEntregasCentral.edtCentroChange(Sender: TObject);
begin
  stCentro.Description;
end;

function TFDRecibirEntregasCentral.stCentroGetDescription: String;
begin
  if edtCentro.Text = '' then
    result:= 'TODOS LOS CENTROS'
  else
    result:= desCentro( empresa.Text, edtCentro.Text );
end;

function TFDRecibirEntregasCentral.edtCentroGetSQL: String;
begin
  if empresa.Text <> '' then
  begin
    Result:= ' select empresa_c, centro_c, descripcion_c ' +
             ' from frf_centros ' +
             ' where empresa_c = ' + QuotedStr( empresa.Text ) + ' ' +
             ' order by empresa_c, centro_c ';
  end
  else
  begin
    Result:= ' select empresa_c, centro_c, descripcion_c ' +
             ' from frf_centros ' +
             ' order by empresa_c, centro_c ';
  end;
end;

end.
