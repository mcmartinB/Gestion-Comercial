unit RiesgoClientesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB, ExtCtrls, Grids,
  DBGrids, DBTables, DBCtrls, BEdit, BDEdit, BGrid, BSpeedButton, BGridButton;

type
  TFDRiesgoClientes = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel3: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    dsRiesgo: TDataSource;
    btnBorrar: TSpeedButton;
    btnModificar: TSpeedButton;
    stProveedor: TStaticText;
    stProductor: TStaticText;
    empresa_cr: TBDEdit;
    lblProductor: TnbLabel;
    lbl1: TnbLabel;
    lbl3: TnbLabel;
    QRiesgoAux: TQuery;
    cliente_cr: TBDEdit;
    max_riesgo_cr: TBDEdit;
    RejillaFlotante: TBGrid;
    btnEmpresa: TBGridButton;
    stEmpresa: TStaticText;
    stCliente: TStaticText;
    seguro_cr: TDBCheckBox;
    nbLabel1: TnbLabel;
    QRiesgo: TQuery;
    fecha_fin_cr: TnbDBCalendarCombo;
    nbLabel2: TnbLabel;
    fecha_riesgo_cr: TnbDBCalendarCombo;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_crChange(Sender: TObject);
    procedure cliente_crChange(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCliente: string;
    bAlta: boolean;
    dFechaIni: TDateTime;
    function ValidarValues: boolean;
    function  ActualizarFechaFinAlta ( const AEmpresa: String; var VFechaFin: TDateTime ): boolean;

  public
    { Public declarations }
    procedure LoadValues(const AEmpresa, ACliente: string);
  end;

procedure ExecuteRiesgoClientes(const AOwner: TComponent; const AEmpresa, ACliente: string);

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB, CAuxiliarDB, CVariables;

var
  FDRiesgoClientes: TFDRiesgoClientes;

procedure ExecuteRiesgoClientes(const AOwner: TComponent; const AEmpresa, ACliente: string);
begin
  FDRiesgoClientes := TFDRiesgoClientes.Create(AOwner);
  try
    FDRiesgoClientes.LoadValues(AEmpresa, ACliente);
    FDRiesgoClientes.ShowModal;
  finally
    FreeAndNil(FDRiesgoClientes);
  end;
end;

procedure TFDRiesgoClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QRiesgo.Close;
  Action := caFree;
end;

procedure TFDRiesgoClientes.FormCreate(Sender: TObject);
begin
  empresa_cr.Tag := kEmpresa;
end;

procedure TFDRiesgoClientes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    vk_f1:
      begin
        Key := 0;
        btnAceptar.Click;
      end;
    vk_f2:
      begin
        Key := 0;
        if empresa_cr.Focused then
          btnEmpresaClick(Self)
      end;
    vk_escape:
      begin
        Key := 0;
        btnCancelar.Click;
      end;
    vk_add, ord('+'):
      begin
        Key := 0;
        btnAnyadir.Click;
      end;
    vk_Return:
    begin
      Key := 0;
      PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
    end;

  end;
end;

procedure TFDRiesgoClientes.LoadValues(const AEmpresa, ACliente: string);
begin
  sEmpresa := AEmpresa;
  sCliente := ACliente;
  bAlta := False;

  with QRiesgo do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_cr, cliente_cr, max_riesgo_cr, fecha_riesgo_cr, fecha_fin_cr, seguro_cr ');
    SQL.Add(' from frf_clientes_rie ');
    SQL.Add(' where cliente_cr = :cliente ');
    SQL.Add(' order by empresa_cr ');
    ParamByName('cliente').AsString := ACliente;
    Open;
  end;

  with QRiesgoAux do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_cr, cliente_cr, max_riesgo_cr, fecha_riesgo_cr, fecha_fin_cr, seguro_cr ');
    SQL.Add(' from frf_clientes_rie ');
    SQL.Add(' where empresa_cr = :empresa ');
    SQL.Add('   and cliente_cr = :cliente ');
    SQL.Add(' order by empresa_cr ');
  end;
end;

function TFDRiesgoClientes.ValidarValues: boolean;
begin
  if empresa_cr.Text = '' then
  begin
    raise Exception.Create('Falta introducir la empresa.');
  end;

  if stEmpresa.Caption = '' then
  begin
    raise Exception.Create('Empresa incorrecta.');
  end;

  if max_riesgo_cr. Text = '' then
  begin
    raise Exception.Create('Falta introducir el riesgo del cliente.');
  end;
  
  if TryStrToDate( fecha_riesgo_cr.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_riesgo_cr.SetFocus;
    ValidarValues:= False;
  end;
end;

procedure TFDRiesgoClientes.btnAnyadirClick(Sender: TObject);
begin                                                                                    
  bAlta := True;
  btnAceptar.Enabled := True;
  btnCancelar.Caption := 'Cancelar (Esc)';

  btnAnyadir.Enabled := False;
  btnModificar.Enabled := False;
  btnBorrar.Enabled := False;

  QRiesgo.Insert;

  cliente_cr.Text := sCliente;
  empresa_cr.Text := sEmpresa;

  QRiesgo.FieldByName('cliente_cr').AsString := sCliente;
  QRiesgo.FieldByName('empresa_cr').AsString := sEmpresa;
  QRiesgo.FieldByName('max_riesgo_cr').AsFloat := 0;
  QRiesgo.FieldByName('fecha_riesgo_cr').AsDateTime := Date;
  QRiesgo.FieldByName('seguro_cr').AsInteger := 0;

  empresa_cr.Enabled := True;
  max_riesgo_cr.enabled := True;
  fecha_riesgo_cr.Enabled := True;
  seguro_cr.Enabled := True;

  btnEmpresa.Enabled := True;
  DBGrid.Enabled := False;

  empresa_cr.SetFocus;
end;

procedure TFDRiesgoClientes.btnModificarClick(Sender: TObject);
begin
  bAlta := False;
  if QRiesgo.IsEmpty then
  begin
    ShowMessage('No hay ficha para modificar');
  end
  else
  begin
    btnAceptar.Enabled := True;
    btnCancelar.Caption := 'Cancelar (Esc)';

    btnAnyadir.Enabled := False;
    btnModificar.Enabled := False;
    btnBorrar.Enabled := False;

    QRiesgo.Edit;

    empresa_cr.Enabled := False;
    fecha_riesgo_cr.Enabled := False;
    max_riesgo_cr.enabled := True;
    seguro_cr.Enabled := True;
    btnEmpresa.Enabled := True;
    DBGrid.Enabled := False;

    max_riesgo_cr.SetFocus;
  end;
end;

procedure TFDRiesgoClientes.cliente_crChange(Sender: TObject);
begin
  stCliente.Caption := desCliente(cliente_cr.Text);
end;

procedure TFDRiesgoClientes.btnEmpresaClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnEmpresa);
end;

procedure TFDRiesgoClientes.btnAceptarClick(Sender: TObject);
var
  dFechaFin: TDateTime;
begin
  if ValidarValues then
  begin
    if bAlta then
    begin
      dFechaFin:= dFechaIni;
      if ActualizarFechaFinAlta( QRiesgo.FieldByName('empresa_cr').AsString, dFechaFin ) then
      begin
        QRiesgo.FieldByName('fecha_fin_cr').AsDateTime:= dFechaFin;
      end;
    end;

    QRiesgo.Post;

    btnAceptar.Enabled := False;
    btnCancelar.Caption := 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    empresa_cr.Enabled := False;
    max_riesgo_cr.enabled := False;
    fecha_riesgo_cr.Enabled := False;
    seguro_cr.Enabled := False;
    btnEmpresa.Enabled := False;

    DBGrid.Enabled := True;

    btnAnyadir.Enabled := True;
    btnModificar.Enabled := True;
    btnBorrar.Enabled := True;

   if bAlta then
    begin
      QRiesgo.Close;
      QRiesgo.Open;
    end;
  end;
end;

procedure TFDRiesgoClientes.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QRiesgo.Cancel;
    btnAceptar.Enabled := False;
    btnCancelar.Caption := 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    empresa_cr.Enabled := False;
    max_riesgo_cr.Enabled := False;
    fecha_riesgo_cr.Enabled := False;
    seguro_cr.Enabled := False;

    DBGrid.Enabled := True;

    btnAnyadir.Enabled := True;
    btnModificar.Enabled := True;
    btnBorrar.Enabled := True;
  end
  else
  begin
    Close;
  end;
end;

procedure TFDRiesgoClientes.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QRiesgo.IsEmpty then
  begin
    if QRiesgo.FieldByName('fecha_fin_cr').AsString = '' then
    begin
      QRiesgo.Delete;
      if not QRiesgo.IsEmpty then
      begin
        QRiesgo.Prior;
        QRiesgo.Edit;
        QRiesgo.FieldByName('fecha_fin_cr').AsString:= '';
        QRiesgo.Post;
      end;
    end
    else
    begin
      QRiesgo.Delete;
      dIniAux:=  QRiesgo.FieldByName('fecha_riesgo_cr').AsDateTime;
      QRiesgo.Prior;
      if dIniAux <> QRiesgo.FieldByName('fecha_riesgo_cr').AsDateTime then
      begin
        QRiesgo.Edit;
        QRiesgo.FieldByName('fecha_fin_cr').AsDateTime:= dIniAux - 1;
        QRiesgo.Post;
      end;
    end;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDRiesgoClientes.empresa_crChange(Sender: TObject);
begin
  stEmpresa.Caption := desEmpresa(empresa_cr.Text);
end;

function TFDRiesgoClientes.ActualizarFechaFinAlta ( const AEmpresa: String; var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  QRiesgoAux.ParamByName('empresa').AsString := AEmpresa;
  QRiesgoAux.ParamByName('cliente').AsString := sCliente;
  QRiesgoAux.Open;
  try
    if not QRiesgoAux.IsEmpty then
    begin
      while ( QRiesgoAux.FieldByName('fecha_riesgo_cr').AsDateTime < VFechaFin ) and
            ( not QRiesgoAux.Eof ) do
      begin
        bAnt:= True;
        QRiesgoAux.Next;
      end;
      if QRiesgoAux.FieldByName('fecha_riesgo_cr').AsDateTime <> VFechaFin then
      begin
        if QRiesgoAux.Eof then
        begin
          //Estoy en
          QRiesgoAux.Edit;
          QRiesgoAux.FieldByName('fecha_fin_cr').AsDateTime:= VFechaFin - 1;
          QRiesgoAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QRiesgoAux.Prior;
            QRiesgoAux.Edit;
            QRiesgoAux.FieldByName('fecha_fin_cr').AsDateTime:= VFechaFin - 1;
            QRiesgoAux.Post;
            QRiesgoAux.Next;
          end;
          //Hay siguiente
          if not QRiesgoAux.Eof then
          begin
            VFechaFin:= QRiesgoAux.FieldByName('fecha_riesgo_cr').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QRiesgoAux.Close;
  end;
end;

end.

