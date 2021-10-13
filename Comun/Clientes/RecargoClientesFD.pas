unit RecargoClientesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB,
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit;
                                                
type
  TFDRecargoClientes = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    fecha_ini_irc: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSRecargo: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    fecha_fin_irc: TnbDBCalendarCombo;
    QRecargo: TQuery;
    btnModificar: TSpeedButton;
    stPlanta: TStaticText;
    stProveedor: TStaticText;
    stProductor: TStaticText;
    empresa_irc: TBDEdit;
    lblProductor: TnbLabel;
    lbl3: TnbLabel;
    QRecargoAux: TQuery;
    cliente_irc: TBDEdit;
    recargo_irc: TDBCheckBox;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_ircChange(Sender: TObject);
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

  procedure ExecuteRecargoClientes( const AOwner: TComponent; const AEmpresa, ACliente: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB;

var
  FDRecargoClientes: TFDRecargoClientes;

procedure ExecuteRecargoClientes( const AOwner: TComponent; const AEmpresa, ACliente: string );
begin
  FDRecargoClientes:= TFDRecargoClientes.Create( AOwner );
  try
    FDRecargoClientes.LoadValues( AEmpresa, ACliente );
    FDRecargoClientes.ShowModal;
  finally
    FreeAndNil(FDRecargoClientes );
  end;
end;

procedure TFDRecargoClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QRecargo.Close;
  Action:= caFree;
end;

procedure TFDRecargoClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_f1:
    begin
      Key:= 0;
      btnAceptar.Click;
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
  end;
end;

procedure TFDRecargoClientes.LoadValues( const AEmpresa, ACliente: string );
begin
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  bAlta:= False; 

  with QRecargo do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_irc, cliente_irc, recargo_irc, fecha_ini_irc, fecha_fin_irc ');
    SQL.Add(' from frf_impuestos_recargo_cli ');
    SQL.Add(' where cliente_irc = :cliente ');
    SQL.Add(' order by empresa_irc, fecha_ini_irc ');
    ParamByName('cliente').AsString:= ACliente;
    Open;
  end;

  with QRecargoAux do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_irc, cliente_irc, recargo_irc, fecha_ini_irc, fecha_fin_irc ');
    SQL.Add(' from frf_impuestos_recargo_cli ');
    SQL.Add(' where empresa_irc = :empresa ');
    SQL.Add('   and cliente_irc = :cliente ');
    SQL.Add(' order by fecha_ini_irc ');
  end;
end;


function TFDRecargoClientes.ValidarValues: boolean;
begin
  if TryStrToDate( fecha_ini_irc.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_irc.SetFocus;
    ValidarValues:= False;
  end;
end;

procedure TFDRecargoClientes.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QRecargo.Insert;

  empresa_irc.Text:= sEmpresa;
  cliente_irc.Text:= sCliente;
  empresa_irc.Enabled := True;
  fecha_ini_irc.Text:= DateToStr( date );
  recargo_irc.Checked:= False;

  QRecargo.FieldByName('empresa_irc').AsString:= sEmpresa;
  QRecargo.FieldByName('cliente_irc').AsString:= sCliente;
  QRecargo.FieldByName('recargo_irc').AsInteger:= 0;
  QRecargo.FieldByName('fecha_ini_irc').AsDateTime:= Date;

  fecha_ini_irc.Enabled:= True;
  recargo_irc.Enabled:= True;
  DBGrid.Enabled:= False;

  empresa_irc.SetFocus;
end;

procedure TFDRecargoClientes.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QRecargo.IsEmpty then
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

    fecha_ini_irc.Enabled:= False;
    QRecargo.Edit;

    empresa_irc.Enabled := True;
    recargo_irc.Enabled:= True;
    DBGrid.Enabled:= False;

    recargo_irc.SetFocus;
  end;
end;

procedure TFDRecargoClientes.btnAceptarClick(Sender: TObject);
var
  dFechaFin: TDateTime;
  bookMark: TBookMark;
begin
  if ValidarValues then
  begin
    if bAlta then
    begin
      dFechaFin:= dFechaIni;
      if ActualizarFechaFinAlta( dFechaFin ) then
      begin
        QRecargo.FieldByName('fecha_fin_irc').AsDateTime:= dFechaFin;
      end;
    end;
    QRecargo.Post;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    empresa_irc.Enabled := False;
    fecha_ini_irc.Enabled:= False;
    recargo_irc.Enabled:= False;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      QRecargo.Close;
      QRecargo.Open;
      while not QRecargo.Eof do
      begin
        if QRecargo.FieldByName('fecha_ini_irc').AsDateTime = dFechaIni then
          Break;
        QRecargo.Next;
      end;
    end;
  end;
end;

procedure TFDRecargoClientes.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QRecargo.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    empresa_irc.Enabled := False;
    fecha_ini_irc.Enabled:= False;
    recargo_irc.Enabled:= false;
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

procedure TFDRecargoClientes.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QRecargo.IsEmpty then
  begin
    if QRecargo.FieldByName('fecha_fin_irc').AsString = '' then
    begin
      QRecargo.Delete;
      if not QRecargo.IsEmpty then
      begin
        QRecargo.Edit;
        QRecargo.FieldByName('fecha_fin_irc').AsString:= '';
        QRecargo.Post;
      end;
    end
    else
    begin
      QRecargo.Delete;
      dIniAux:=  QRecargo.FieldByName('fecha_ini_irc').AsDateTime;
      QRecargo.Prior;
      if dIniAux <> QRecargo.FieldByName('fecha_ini_irc').AsDateTime then
      begin
        QRecargo.Edit;
        QRecargo.FieldByName('fecha_fin_irc').AsDateTime:= dIniAux - 1;
        QRecargo.Post;
      end;
    end;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDRecargoClientes.empresa_ircChange(Sender: TObject);
begin
  stPlanta.Caption:= desEmpresa( empresa_irc.Text );
end;

function TFDRecargoClientes.ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  QRecargoAux.ParamByName('empresa').AsString := QRecargo.Fieldbyname('empresa_irc').AsString;
  QRecargoAux.ParamByName('cliente').AsString := QRecargo.Fieldbyname('cliente_irc').AsString;
  QRecargoAux.Open;
  try
    if not QRecargoAux.IsEmpty then
    begin
      while ( QRecargoAux.FieldByName('fecha_ini_irc').AsDateTime < VFechaFin ) and
            ( not QRecargoAux.Eof ) do
      begin
        bAnt:= True;
        QRecargoAux.Next;
      end;
      if QRecargoAux.FieldByName('fecha_ini_irc').AsDateTime <> VFechaFin then
      begin
        if QRecargoAux.Eof then
        begin
          //Estoy en
          QRecargoAux.Edit;
          QRecargoAux.FieldByName('fecha_fin_irc').AsDateTime:= VFechaFin - 1;
          QRecargoAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QRecargoAux.Prior;
            QRecargoAux.Edit;
            QRecargoAux.FieldByName('fecha_fin_irc').AsDateTime:= VFechaFin - 1;
            QRecargoAux.Post;
            QRecargoAux.Next;
          end;
          //Hay siguiente
          if not QRecargoAux.Eof then
          begin
            VFechaFin:= QRecargoAux.FieldByName('fecha_ini_irc').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QRecargoAux.Close;
  end;
end;

end.


