unit GastosClientesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB, 
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit, BSpeedButton,
  BGridButton, BGrid;
                                                
type
  TFDGastosClientes = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    fecha_ini_gc: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSGastos: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    fecha_fin_gc: TnbDBCalendarCombo;
    QGastos: TQuery;
    btnModificar: TSpeedButton;
    stPlanta: TStaticText;
    stProveedor: TStaticText;
    stProductor: TStaticText;
    empresa_gc: TBDEdit;
    lblProductor: TnbLabel;
    lbl3: TnbLabel;
    QGastosAux: TQuery;
    cliente_gc: TBDEdit;
    no_facturable_gc: TnbDBNumeric;
    btnEmpresa: TBGridButton;
    stEmpresa: TStaticText;
    RejillaFlotante: TBGrid;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_gcChange(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCliente: String;
    bAlta: boolean;
    dFechaIni: TDateTime;

    function  ValidarValues: boolean;                                                                                 
    function  ActualizarFechaFinAlta ( const AEmpresa: String; var VFechaFin: TDateTime ): boolean;

  public
    { Public declarations }
    procedure LoadValues( const AEmpresa, ACliente: string );

  end;

  procedure ExecuteDescuentosClientes( const AOwner: TComponent; const AEmpresa, ACliente: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB, CAuxiliarDB, CVariables;

var
  FDGastosClientes: TFDGastosClientes;

procedure ExecuteDescuentosClientes( const AOwner: TComponent; const AEmpresa, ACliente: string );
begin
  FDGastosClientes:= TFDGastosClientes.Create( AOwner );
  try
    FDGastosClientes.LoadValues( AEmpresa, ACliente );
    FDGastosClientes.ShowModal;
  finally
    FreeAndNil(FDGastosClientes );
  end;
end;

procedure TFDGastosClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QGastos.Close;
  Action:= caFree;
end;

procedure TFDGastosClientes.FormCreate(Sender: TObject);
begin
  empresa_gc.Tag := kEmpresa;
end;

procedure TFDGastosClientes.FormKeyDown(Sender: TObject; var Key: Word;
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
      if empresa_gc.Focused then
        btnEmpresaClick(Self) ;
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
      if empresa_gc.Focused then
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    end;

  end;
end;

procedure TFDGastosClientes.LoadValues( const AEmpresa, ACliente: string );
begin
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  bAlta:= False; 

  with QGastos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_gc, cliente_gc, no_facturable_gc, ');
    SQL.Add('        fecha_ini_gc, fecha_fin_gc ');
    SQL.Add(' from frf_gastos_cliente ');
    SQL.Add(' where cliente_gc = :cliente ');
    SQL.Add(' order by empresa_gc, fecha_ini_gc ');
    ParamByName('cliente').AsString:= ACliente;
    Open;
  end;

  with QGastosAux do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_gc, cliente_gc, no_facturable_gc, ');
    SQL.Add('        fecha_ini_gc, fecha_fin_gc ');
    SQL.Add(' from frf_gastos_cliente ');
    SQL.Add(' where empresa_gc = :empresa ');
    SQL.Add('   and cliente_gc = :cliente ');
    SQL.Add(' order by empresa_gc, fecha_ini_gc ');
  end;
end;


function TFDGastosClientes.ValidarValues: boolean;
begin
  if empresa_gc.Text = '' then
  begin
    ShowMessage('Falta introducir la empresa.');
    empresa_gc.SetFocus;
    ValidarValues:= False;
  end;

  if TryStrToDate( fecha_ini_gc.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_gc.SetFocus;
    ValidarValues:= False;
  end;
  if no_facturable_gc.Text = '' then
  begin
    QGastos.FieldByName('no_facturable_gc').AsFloat:= 0;
  end;
end;

procedure TFDGastosClientes.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QGastos.Insert;

  empresa_gc.Text:= sEmpresa;
  cliente_gc.Text:= sCliente;
  fecha_ini_gc.Text:= DateToStr( date );

  QGastos.FieldByName('empresa_gc').AsString:= sEmpresa;
  QGastos.FieldByName('cliente_gc').AsString:= sCliente;
  QGastos.FieldByName('no_facturable_gc').AsInteger:= 0;
  QGastos.FieldByName('fecha_ini_gc').AsDateTime:= Date;

  empresa_gc.Enabled:=True;
  btnEmpresa.Enabled:=True;
  fecha_ini_gc.Enabled:= True;
  no_facturable_gc.Enabled:= True;
  DBGrid.Enabled:= False;

  empresa_gc.SetFocus;
end;

procedure TFDGastosClientes.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QGastos.IsEmpty then
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

    fecha_ini_gc.Enabled:= False;
    QGastos.Edit;

    no_facturable_gc.Enabled:= True;
    DBGrid.Enabled:= False;

    no_facturable_gc.SetFocus;
  end;
end;

procedure TFDGastosClientes.btnAceptarClick(Sender: TObject);
var
  dFechaFin: TDateTime;
begin
  if ValidarValues then
  begin
    if bAlta then
    begin
      dFechaFin:= dFechaIni;
      if ActualizarFechaFinAlta( QGastos.FieldByName('empresa_gc').AsString, dFechaFin ) then
      begin
        QGastos.FieldByName('fecha_fin_gc').AsDateTime:= dFechaFin;
      end;
    end;
    QGastos.Post;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    empresa_gc.Enabled:=False;
    btnEmpresa.Enabled:=False;
    fecha_ini_gc.Enabled:= False;
    no_facturable_gc.Enabled:= False;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      QGastos.Close;
      QGastos.Open;
      while not QGastos.Eof do
      begin
        if QGastos.FieldByName('fecha_ini_gc').AsDateTime = dFechaIni then
          Break;
        QGastos.Next;
      end;
    end;
  end;
end;

procedure TFDGastosClientes.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QGastos.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    empresa_gc.Enabled:=False;
    btnEmpresa.Enabled:=False;
    fecha_ini_gc.Enabled:= False;
    no_facturable_gc.Enabled:= false;
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

procedure TFDGastosClientes.btnEmpresaClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnEmpresa);
end;

procedure TFDGastosClientes.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QGastos.IsEmpty then
  begin
    if QGastos.FieldByName('fecha_fin_gc').AsString = '' then
    begin
      QGastos.Delete;
      if not QGastos.IsEmpty then
      begin
        QGastos.Prior;    //Nos vamos al anterior
        QGastos.Edit;
        QGastos.FieldByName('fecha_fin_gc').AsString:= '';
        QGastos.Post;
      end;
    end
    else
    begin
      QGastos.Delete;
      dIniAux:=  QGastos.FieldByName('fecha_ini_gc').AsDateTime;
      QGastos.Prior;
      if dIniAux <> QGastos.FieldByName('fecha_ini_gc').AsDateTime then
      begin
        QGastos.Edit;
        QGastos.FieldByName('fecha_fin_gc').AsDateTime:= dIniAux - 1;
        QGastos.Post;
      end;
    end;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDGastosClientes.empresa_gcChange(Sender: TObject);
begin
  stEmpresa.Caption:= desEmpresa( empresa_gc.Text );
end;

function TFDGastosClientes.ActualizarFechaFinAlta ( const AEmpresa: String; var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;

  QGastosAux.ParamByName('empresa').AsString:= AEmpresa;
  QGastosAux.ParamByName('cliente').AsString:= sCliente;

  QGastosAux.Open;
  try
    if not QGastosAux.IsEmpty then
    begin
      while ( QGastosAux.FieldByName('fecha_ini_gc').AsDateTime < VFechaFin ) and
            ( not QGastosAux.Eof ) do
      begin
        bAnt:= True;
        QGastosAux.Next;
      end;
      if QGastosAux.FieldByName('fecha_ini_gc').AsDateTime <> VFechaFin then
      begin
        if QGastosAux.Eof then
        begin
          //Estoy en
          QGastosAux.Edit;
          QGastosAux.FieldByName('fecha_fin_gc').AsDateTime:= VFechaFin - 1;
          QGastosAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QGastosAux.Prior;
            QGastosAux.Edit;
            QGastosAux.FieldByName('fecha_fin_gc').AsDateTime:= VFechaFin - 1;
            QGastosAux.Post;
            QGastosAux.Next;
          end;
          //Hay siguiente
          if not QGastosAux.Eof then
          begin
            VFechaFin:= QGastosAux.FieldByName('fecha_ini_gc').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QGastosAux.Close;
  end;
end;

end.


