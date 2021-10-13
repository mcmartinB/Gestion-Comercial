unit TesoreriaClientesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB,
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit, BGrid,
  BSpeedButton, BGridButton;
                                                
type
  TFDTesoreriaClientes = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel3: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSTesoreria: TDataSource;
    btnBorrar: TSpeedButton;
    QTesoreria: TQuery;
    btnModificar: TSpeedButton;
    stProveedor: TStaticText;
    stProductor: TStaticText;
    empresa_ct: TBDEdit;
    lblProductor: TnbLabel;
    lbl1: TnbLabel;
    lbl3: TnbLabel;
    QTesoreriaAux: TQuery;
    cliente_ct: TBDEdit;
    dias_tesoreria_ct: TnbDBNumeric;
    lbl4: TnbLabel;
    banco_ct: TBDEdit;
    btnBanco: TBGridButton;
    stBanco: TStaticText;
    RejillaFlotante: TBGrid;
    btnEmpresa: TBGridButton;
    stEmpresa: TStaticText;
    stCliente: TStaticText;
    btnFormaPago: TBGridButton;
    stFormaPago: TStaticText;
    forma_pago_ct: TBDEdit;
    QTesoreriaempresa_ct: TStringField;
    QTesoreriacliente_ct: TStringField;
    QTesoreriabanco_ct: TStringField;
    QTesoreriaforma_pago_ct: TStringField;
    iQTesoreriadias_tesoreria_ct: TIntegerField;
    QTesoreriades_banco: TStringField;
    QTesoreriades_formapago: TStringField;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_ctChange(Sender: TObject);
    procedure cliente_ctChange(Sender: TObject);
    procedure banco_ctChange(Sender: TObject);
    procedure btnBancoClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure btnFormaPagoClick(Sender: TObject);
    procedure forma_pago_ctChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QTesoreriaCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    sEmpresa, sCliente: String;
    bAlta: boolean;
    dFechaIni: TDateTime;

    function  ValidarValues: boolean;
    function  ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;

  public
    { Public declarations }
    procedure LoadValues( const AEmpresa, ACliente: string );

  end;

  procedure ExecuteTesoreriaClientes( const AOwner: TComponent; const AEmpresa, ACliente: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB, CAuxiliarDB, CVariables, UFFormaPago,
  UDMConfig;

var
  FDTesoreriaClientes: TFDTesoreriaClientes;

procedure ExecuteTesoreriaClientes( const AOwner: TComponent; const AEmpresa, ACliente: string );
begin
  FDTesoreriaClientes:= TFDTesoreriaClientes.Create( AOwner );
  try
    FDTesoreriaClientes.LoadValues( AEmpresa, ACliente );
    FDTesoreriaClientes.ShowModal;
  finally
    FreeAndNil(FDTesoreriaClientes );
  end;
end;

procedure TFDTesoreriaClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QTesoreria.Close;
  Action:= caFree;
end;

procedure TFDTesoreriaClientes.FormCreate(Sender: TObject);
begin
  empresa_ct.Tag := kEmpresa;
  banco_ct.Tag := kBanco;
  forma_pago_ct. Tag := kFormaPago;
end;

procedure TFDTesoreriaClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_f1:
    begin
      Key:= 0;
      btnAceptar.Click;
    end;
    vk_f2:
    begin
      Key:=0;
      if empresa_ct.Focused then
        btnEmpresaClick(Self)
      else if banco_ct.Focused then
        btnBancoClick(Self)
      else if forma_pago_ct.Focused then
        btnFormaPagoClick(Self);
    end;
    vk_escape:
    begin
      Key:= 0;
      btnCancelar.Click;
    end;
    vk_add, ord('+'):
    begin
      Key:= 0;
      btnAnyadir.Click;
    end;
    vk_Return:
    begin
      Key := 0;
      PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
    end;
  end;
end;

procedure TFDTesoreriaClientes.LoadValues( const AEmpresa, ACliente: string );
begin
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  bAlta:= False; 

  with QTesoreria do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ct, cliente_ct, banco_ct, forma_pago_ct, dias_tesoreria_ct ');
    SQL.Add(' from frf_clientes_tes ');
    SQL.Add(' where cliente_ct = :cliente ');
    SQL.Add(' order by empresa_ct ');
    ParamByName('cliente').AsString:= ACliente;
    Open;
  end;

  with QTesoreriaAux do
  begin
    SQL.Clear;
    SQL.AddStrings( QTesoreria.SQL );
    ParamByName('cliente').AsString:= ACliente;
  end;
end;


procedure TFDTesoreriaClientes.QTesoreriaCalcFields(DataSet: TDataSet);
begin
  QTesoreria.FieldByName('des_banco').AsString:= desBanco(QTesoreria.FieldByName('banco_ct').AsString);
  QTesoreria.FieldByName('des_formapago').AsString:= desFormaPago(QTesoreria.FieldByName('forma_pago_ct').AsString);
end;

function TFDTesoreriaClientes.ValidarValues: boolean;
begin
// Comprobaciones
// Empresa
  result := true;
  if empresa_ct.Text = '' then
  begin
    raise Exception.Create('Falta introducir la empresa.');
    result := false;
  end;

  if stEmpresa.Caption = '' then
  begin
    raise Exception.Create('Empresa incorrecta.');
    result := false;
  end;

  //La forma de pago debe de existir
  if ( stFormaPago.Caption = '' ) then
  begin
    if forma_pago_ct.Text <> '' then
    begin
      raise Exception.Create('La forma de pago del cliente es incorrecta.');
      result := false;
    end
    else
    begin
      if MessageDlg( 'Falta grabar la forma de pago del cliente y esta es necesaria para contabilizar las facturas. ' + #13 + #10 +
                     '¿Seguro que desea continuar?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
         result := false;
         Abort;
    end;
  end;
end;

procedure TFDTesoreriaClientes.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QTesoreria.Insert;

  cliente_ct.Text:= sCliente;

  QTesoreria.FieldByName('cliente_ct').AsString:= sCliente;
  QTesoreria.FieldByName('empresa_ct').AsString:= '';
  QTesoreria.FieldByName('banco_ct').AsString:= '';
  QTesoreria.FieldByName('forma_pago_ct').AsString:= '';
  QTesoreria.FieldByName('dias_tesoreria_ct').AsString:= '';

  empresa_ct.Enabled:= True;
  banco_ct.Enabled:= True;
  forma_pago_ct.Enabled:= True;
  dias_tesoreria_ct.Enabled:= True;
  btnEmpresa.Enabled:=True;
  btnBanco.Enabled:=True;
  btnFormaPago.Enabled:=True;
  DBGrid.Enabled:= False;

  empresa_ct.SetFocus;
end;

procedure TFDTesoreriaClientes.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QTesoreria.IsEmpty then
  begin
    ShowMessage('No hay ficha para modificar');
  end
  else
  begin
    btnAceptar.Enabled:= True;
    btnCancelar.Caption:= 'Cancelar (Esc)';

    btnAnyadir.Enabled:= False;
    btnModificar.Enabled:= False;
    btnBorrar.Enabled:= False;

    QTesoreria.Edit;

    empresa_ct.Enabled:= True;
    banco_ct.Enabled:= True;
    forma_pago_ct.Enabled:= True;
    dias_tesoreria_ct.Enabled:= True;
    btnEmpresa.Enabled:=True;
    btnBanco.Enabled:=True;
    btnFormaPago.Enabled:=True;
    DBGrid.Enabled:= False;

    empresa_ct.SetFocus;
  end;
end;

procedure TFDTesoreriaClientes.cliente_ctChange(Sender: TObject);
begin
  stCliente.Caption:= desCliente( cliente_ct.Text );
end;

procedure TFDTesoreriaClientes.banco_ctChange(Sender: TObject);
begin
  stBanco.Caption := desBanco(banco_ct.Text);
end;

procedure TFDTesoreriaClientes.btnEmpresaClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnEmpresa);
end;

procedure TFDTesoreriaClientes.btnFormaPagoClick(Sender: TObject);
var sAux: String;
begin
//  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
//  DespliegaRejilla(btnFormaPago);
  if ( DMConfig.EsLaFont ) then
  begin
    sAux:= forma_pago_ct.Text;
    if UFFormaPago.SeleccionaFormaPago( self, forma_pago_ct,  sAux ) then
    begin
      forma_pago_ct.Text:= sAux;
    end;
  end;
end;

procedure TFDTesoreriaClientes.btnAceptarClick(Sender: TObject);
var
  dFechaFin: TDateTime;
begin
  if ValidarValues then
  begin
    QTesoreria.Post;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    empresa_ct.Enabled:= False;
    banco_ct.Enabled:= false;
    forma_pago_ct.Enabled:= False;
    dias_tesoreria_ct.Enabled:= false;
    btnEmpresa.Enabled:=False;
    btnBanco.Enabled:=False;
    btnFormaPago.Enabled:=False;

    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      QTesoreria.Close;
      QTesoreria.Open;
    end;

  end;
end;

procedure TFDTesoreriaClientes.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QTesoreria.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    empresa_ct.Enabled:= False;
    banco_ct.Enabled:= false;
    forma_pago_ct.Enabled:= False;
    dias_tesoreria_ct.Enabled:= false;
    btnEmpresa.Enabled:=False;
    btnBanco.Enabled:=False;
    btnFormaPago.Enabled:=False;

    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;
  end
  else
  begin
    Close;
  end;
end;

procedure TFDTesoreriaClientes.btnBancoClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnBanco, [empresa_ct.Text] );
end;

procedure TFDTesoreriaClientes.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QTesoreria.IsEmpty then
  begin
    QTesoreria.Delete;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDTesoreriaClientes.empresa_ctChange(Sender: TObject);
begin
  stEmpresa.Caption:= desEmpresa( empresa_ct.Text );
end;

procedure TFDTesoreriaClientes.forma_pago_ctChange(Sender: TObject);
begin
  stFormaPago.Caption := desFormaPago(forma_pago_ct.Text);
end;

function TFDTesoreriaClientes.ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
{
  bAnt:= False;
  result:= False;
  QTesoreriaAux.Open;
  try
    if not QTesoreriaAux.IsEmpty then
    begin
      while ( QTesoreriaAux.FieldByName('fecha_ini_dc').AsDateTime < VFechaFin ) and
            ( not QTesoreriaAux.Eof ) do
      begin
        bAnt:= True;
        QTesoreriaAux.Next;
      end;
      if QTesoreriaAux.FieldByName('fecha_ini_dc').AsDateTime <> VFechaFin then
      begin
        if QTesoreriaAux.Eof then
        begin
          //Estoy en
          QTesoreriaAux.Edit;
          QDescuentosAux.FieldByName('fecha_fin_dc').AsDateTime:= VFechaFin - 1;
          QDescuentosAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QDescuentosAux.Prior;
            QDescuentosAux.Edit;
            QDescuentosAux.FieldByName('fecha_fin_dc').AsDateTime:= VFechaFin - 1;
            QDescuentosAux.Post;
            QDescuentosAux.Next;
          end;
          //Hay siguiente
          if not QDescuentosAux.Eof then
          begin
            VFechaFin:= QDescuentosAux.FieldByName('fecha_ini_dc').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QDescuentosAux.Close;
  end;
  }
end;

end.


