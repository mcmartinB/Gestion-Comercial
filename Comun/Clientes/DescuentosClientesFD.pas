unit DescuentosClientesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB,
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit, BSpeedButton,
  BGridButton, BGrid;
                                                
type
  TFDDescuentosClientes = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    fecha_ini_dc: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSDescuentos: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    fecha_fin_dc: TnbDBCalendarCombo;
    QDescuentos: TQuery;
    btnModificar: TSpeedButton;
    stPlanta: TStaticText;
    stProveedor: TStaticText;
    stProductor: TStaticText;
    empresa_dc: TBDEdit;
    lblProductor: TnbLabel;
    lbl1: TnbLabel;
    no_fact_bruto_dc: TnbDBNumeric;
    lbl3: TnbLabel;
    QDescuentosAux: TQuery;
    cliente_dc: TBDEdit;
    facturable_dc: TnbDBNumeric;
    lbl2: TnbLabel;
    eurkg_no_facturable_dc: TnbDBNumeric;
    eurkg_facturable_dc: TnbDBNumeric;
    lbl4: TnbLabel;
    btnEmpresa: TBGridButton;
    stEmpresa: TStaticText;
    RejillaFlotante: TBGrid;
    nbLabel1: TnbLabel;
    no_fact_neto_dc: TnbDBNumeric;
    nbLabel4: TnbLabel;
    eurpale_facturable_dc: TnbDBNumeric;
    nbLabel5: TnbLabel;
    eurpale_no_facturable_dc: TnbDBNumeric;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_dcChange(Sender: TObject);
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
  bMath, UDMBaseDatos, UDMAuxDB, CAuxiliarDB, CVariables, SincronizacionBonny;

var
  FDDescuentosClientes: TFDDescuentosClientes;

procedure ExecuteDescuentosClientes( const AOwner: TComponent; const AEmpresa, ACliente: string );
begin
  FDDescuentosClientes:= TFDDescuentosClientes.Create( AOwner );
  try
    FDDescuentosClientes.LoadValues( AEmpresa, ACliente );
    FDDescuentosClientes.ShowModal;
  finally
    FreeAndNil(FDDescuentosClientes );
  end;
end;

procedure TFDDescuentosClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QDescuentos.Close;
  Action:= caFree;
end;

procedure TFDDescuentosClientes.FormCreate(Sender: TObject);
begin
  empresa_dc.Tag := kEmpresa;
end;

procedure TFDDescuentosClientes.FormKeyDown(Sender: TObject; var Key: Word;
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
      if empresa_dc.Focused then
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
      if empresa_dc.Focused then
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    end;

  end;
end;

procedure TFDDescuentosClientes.LoadValues( const AEmpresa, ACliente: string );
begin
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  bAlta:= False; 

  with QDescuentos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_dc, cliente_dc, no_fact_bruto_dc, no_fact_neto_dc, facturable_dc, ');
    SQL.Add('        eurkg_no_facturable_dc, eurkg_facturable_dc, eurpale_no_facturable_dc, eurpale_facturable_dc, ');
    SQL.Add('        fecha_ini_dc, fecha_fin_dc ');
    SQL.Add(' from frf_descuentos_cliente ');
    SQL.Add(' where cliente_dc = :cliente ');
    SQL.Add(' order by empresa_dc, fecha_ini_dc ');
    ParamByName('cliente').AsString:= ACliente;
    Open;
  end;

  with QDescuentosAux do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_dc, cliente_dc, no_fact_bruto_dc, no_fact_neto_dc, facturable_dc, ');
    SQL.Add('        eurkg_no_facturable_dc, eurkg_facturable_dc, eurpale_no_facturable_dc, eurpale_facturable_dc, ');
    SQL.Add('        fecha_ini_dc, fecha_fin_dc ');
    SQL.Add(' from frf_descuentos_cliente ');
    SQL.Add(' where empresa_dc = :empresa ');
    SQL.Add('   and cliente_dc = :cliente ');
    SQL.Add(' order by empresa_dc, fecha_ini_dc ');
  end;
end;


function TFDDescuentosClientes.ValidarValues: boolean;
begin
  if empresa_dc.Text = '' then
  begin
    ShowMessage('Falta introducir la empresa.');
    empresa_dc.SetFocus;
    ValidarValues:= False;
    exit;
  end;

  if stEmpresa.Caption = '' then
  begin
    ShowMessage('Empresa incorrecta.');
    empresa_dc.SetFocus;
    ValidarValues:= False;
    exit;
  end;

  if TryStrToDate( fecha_ini_dc.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_dc.SetFocus;
    ValidarValues:= False;
  end;
end;

procedure TFDDescuentosClientes.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QDescuentos.Insert;

  empresa_dc.Text:= sEmpresa;
  cliente_dc.Text:= sCliente;
  fecha_ini_dc.Text:= DateToStr( date );

  QDescuentos.FieldByName('empresa_dc').AsString:= sEmpresa;
  QDescuentos.FieldByName('cliente_dc').AsString:= sCliente;
  QDescuentos.FieldByName('facturable_dc').AsInteger:= 0;
  QDescuentos.FieldByName('no_fact_bruto_dc').AsInteger:= 0;
  QDescuentos.FieldByName('no_fact_neto_dc').AsInteger:= 0;
  QDescuentos.FieldByName('eurkg_facturable_dc').AsInteger:= 0;
  QDescuentos.FieldByName('eurkg_no_facturable_dc').AsInteger:= 0;
  QDescuentos.FieldByName('eurpale_facturable_dc').AsInteger:= 0;
  QDescuentos.FieldByName('eurpale_no_facturable_dc').AsInteger:= 0;
  QDescuentos.FieldByName('fecha_ini_dc').AsDateTime:= Date;

  empresa_dc.Enabled:=True;
  btnEmpresa.Enabled:=True;
  fecha_ini_dc.Enabled:= True;
  facturable_dc.Enabled:= True;
  no_fact_bruto_dc.Enabled:= True;
  no_fact_neto_dc.Enabled:= True;
  eurkg_facturable_dc.Enabled:= True;
  eurkg_no_facturable_dc.Enabled:= True;
  eurpale_facturable_dc.Enabled:= True;
  eurpale_no_facturable_dc.Enabled:= True;
  DBGrid.Enabled:= False;

  empresa_dc.SetFocus;
end;

procedure TFDDescuentosClientes.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QDescuentos.IsEmpty then
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

    fecha_ini_dc.Enabled:= False;
    QDescuentos.Edit;

    facturable_dc.Enabled:= True;
    no_fact_bruto_dc.Enabled:= True;
    no_fact_neto_dc.Enabled:= True;
    eurkg_facturable_dc.Enabled:= True;
    eurkg_no_facturable_dc.Enabled:= True;
    eurpale_facturable_dc.Enabled:= True;
    eurpale_no_facturable_dc.Enabled:= True;
    DBGrid.Enabled:= False;

    facturable_dc.SetFocus;
  end;
end;

procedure TFDDescuentosClientes.btnAceptarClick(Sender: TObject);
var
  dFechaFin: TDateTime;
begin
  if no_fact_bruto_dc.Text = '' then
  begin
    QDescuentos.FieldByName('no_fact_bruto_dc').AsFloat:= 0;
  end;
  if no_fact_neto_dc.Text = '' then
  begin
    QDescuentos.FieldByName('no_fact_neto_dc').AsFloat:= 0;
  end;
  if facturable_dc.Text = '' then
  begin
    QDescuentos.FieldByName('facturable_dc').AsFloat:= 0;
  end;
  if eurkg_no_facturable_dc.Text = '' then
  begin
    QDescuentos.FieldByName('eurkg_no_facturable_dc').AsFloat:= 0;
  end;
  if eurkg_facturable_dc.Text = '' then
  begin
    QDescuentos.FieldByName('eurkg_facturable_dc').AsFloat:= 0;
  end;
  if eurpale_no_facturable_dc.Text = '' then
  begin
    QDescuentos.FieldByName('eurpale_no_facturable_dc').AsFloat:= 0;
  end;
  if eurpale_facturable_dc.Text = '' then
  begin
    QDescuentos.FieldByName('eurpale_facturable_dc').AsFloat:= 0;
  end;

  if ValidarValues then
  begin
    if bAlta then
    begin
      dFechaFin:= dFechaIni;
      if ActualizarFechaFinAlta( QDescuentos.FieldByName('empresa_dc').AsString, dFechaFin ) then
      begin
        QDescuentos.FieldByName('fecha_fin_dc').AsDateTime:= dFechaFin;
      end;
    end;
    QDescuentos.Post;
    SincroBonnyAurora.SincronizarDescuentoCliente(
      QDescuentos.FieldByName('empresa_dc').AsString,
      QDescuentos.FieldByName('cliente_dc').AsString,
      QDescuentos.FieldByName('fecha_ini_dc').AsDateTime
    );
    SincroBonnyAurora.Sincronizar;


    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    empresa_dc.Enabled:=False;
    btnEmpresa.Enabled:=False;
    fecha_ini_dc.Enabled:= False;
    facturable_dc.Enabled:= False;
    no_fact_bruto_dc.Enabled:= false;
    no_fact_neto_dc.Enabled:= false;
    eurkg_facturable_dc.Enabled:= False;
    eurkg_no_facturable_dc.Enabled:= false;
    eurpale_facturable_dc.Enabled:= False;
    eurpale_no_facturable_dc.Enabled:= false;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      QDescuentos.Close;
      QDescuentos.Open;
      while not QDescuentos.Eof do
      begin
        if QDescuentos.FieldByName('fecha_ini_dc').AsDateTime = dFechaIni then
          Break;
        QDescuentos.Next;
      end;
    end;
  end;
end;

procedure TFDDescuentosClientes.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QDescuentos.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    empresa_dc.Enabled:=False;
    btnEmpresa.Enabled:=False;
    fecha_ini_dc.Enabled:= False;
    facturable_dc.Enabled:= false;
    no_fact_bruto_dc.Enabled:= False;
    no_fact_neto_dc.Enabled:= False;
    eurkg_facturable_dc.Enabled:= false;
    eurkg_no_facturable_dc.Enabled:= False;
    eurpale_facturable_dc.Enabled:= false;
    eurpale_no_facturable_dc.Enabled:= False;
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

procedure TFDDescuentosClientes.btnEmpresaClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnEmpresa);
end;

procedure TFDDescuentosClientes.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QDescuentos.IsEmpty then
  begin
    if QDescuentos.FieldByName('fecha_fin_dc').AsString = '' then
    begin
      QDescuentos.Delete;
      SincroBonnyAurora.SincronizarDescuentoCliente(
        QDescuentos.FieldByName('empresa_dc').AsString,
        QDescuentos.FieldByName('cliente_dc').AsString,
        QDescuentos.FieldByName('fecha_ini_dc').AsDateTime
      );
      SincroBonnyAurora.Sincronizar;
      if not QDescuentos.IsEmpty then
      begin
        QDescuentos.Prior;    //Nos vamos al anterior
        QDescuentos.Edit;
        QDescuentos.FieldByName('fecha_fin_dc').AsString:= '';
        QDescuentos.Post;
        SincroBonnyAurora.SincronizarDescuentoCliente(
          QDescuentos.FieldByName('empresa_dc').AsString,
          QDescuentos.FieldByName('cliente_dc').AsString,
          QDescuentos.FieldByName('fecha_ini_dc').AsDateTime
        );
        SincroBonnyAurora.Sincronizar;

      end;
    end
    else
    begin
      QDescuentos.Delete;
      SincroBonnyAurora.SincronizarDescuentoCliente(
        QDescuentos.FieldByName('empresa_dc').AsString,
        QDescuentos.FieldByName('cliente_dc').AsString,
        QDescuentos.FieldByName('fecha_ini_dc').AsDateTime
      );
      SincroBonnyAurora.Sincronizar;

      dIniAux:=  QDescuentos.FieldByName('fecha_ini_dc').AsDateTime;
      QDescuentos.Prior;
      if dIniAux <> QDescuentos.FieldByName('fecha_ini_dc').AsDateTime then
      begin
        QDescuentos.Edit;
        QDescuentos.FieldByName('fecha_fin_dc').AsDateTime:= dIniAux - 1;
        QDescuentos.Post;
        SincroBonnyAurora.SincronizarDescuentoCliente(
          QDescuentos.FieldByName('empresa_dc').AsString,
          QDescuentos.FieldByName('cliente_dc').AsString,
          QDescuentos.FieldByName('fecha_ini_dc').AsDateTime
        );
        SincroBonnyAurora.Sincronizar;

      end;
    end;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDDescuentosClientes.empresa_dcChange(Sender: TObject);
begin
  stEmpresa.Caption:= desEmpresa( empresa_dc.Text );
end;

function TFDDescuentosClientes.ActualizarFechaFinAlta ( const AEmpresa: String; var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;

  QDescuentosAux.ParamByName('empresa').AsString:= AEmpresa;
  QDescuentosAux.ParamByName('cliente').AsString:= sCliente;

  QDescuentosAux.Open;
  try
    if not QDescuentosAux.IsEmpty then
    begin
      while ( QDescuentosAux.FieldByName('fecha_ini_dc').AsDateTime < VFechaFin ) and
            ( not QDescuentosAux.Eof ) do
      begin
        bAnt:= True;
        QDescuentosAux.Next;
      end;
      if QDescuentosAux.FieldByName('fecha_ini_dc').AsDateTime <> VFechaFin then
      begin
        if QDescuentosAux.Eof then
        begin
          //Estoy en
          QDescuentosAux.Edit;
          QDescuentosAux.FieldByName('fecha_fin_dc').AsDateTime:= VFechaFin - 1;
          QDescuentosAux.Post;
          SincroBonnyAurora.SincronizarDescuentoCliente(
            QDescuentosAux.FieldByName('empresa_dc').AsString,
            QDescuentosAux.FieldByName('cliente_dc').AsString,
            QDescuentosAux.FieldByName('fecha_ini_dc').AsDateTime
          );
          SincroBonnyAurora.Sincronizar;

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
            SincroBonnyAurora.SincronizarDescuentoCliente(
              QDescuentosAux.FieldByName('empresa_dc').AsString,
              QDescuentosAux.FieldByName('cliente_dc').AsString,
              QDescuentosAux.FieldByName('fecha_ini_dc').AsDateTime
            );
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
end;

end.


