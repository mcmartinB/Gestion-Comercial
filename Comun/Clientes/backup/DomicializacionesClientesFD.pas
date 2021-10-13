unit DomicializacionesClientesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB, 
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit;
                                                
type
  TFDDomicializacionesClientes = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    fecha_ini_cmd: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSDescuentos: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    fecha_fin_cmd: TnbDBCalendarCombo;
    QDomicializaciones: TQuery;
    btnModificar: TSpeedButton;
    stPlanta: TStaticText;
    stProveedor: TStaticText;
    empresa_cmd: TBDEdit;
    lblProductor: TnbLabel;
    lbl1: TnbLabel;
    adeudos_cmd: TnbDBNumeric;
    lbl3: TnbLabel;
    QDomicializacionesAux: TQuery;
    cliente_cmd: TBDEdit;
    lblCodigo1: TnbLabel;
    lblCodeBIC: TnbLabel;
    lblCodigoIBAN: TnbLabel;
    fecha_mandato_cmd: TnbDBCalendarCombo;
    mandato_cmd: TBDEdit;
    iban_cliente_cmd: TBDEdit;
    code_bic_cliente_cmd: TBDEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_cmdChange(Sender: TObject);
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

  procedure ExecuteDomicializacionClientes( const AOwner: TComponent; const AEmpresa, ACliente: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB;

var
  FDDomicializacionesClientes: TFDDomicializacionesClientes;

procedure ExecuteDomicializacionClientes( const AOwner: TComponent; const AEmpresa, ACliente: string );
begin
  FDDomicializacionesClientes:= TFDDomicializacionesClientes.Create( AOwner );
  try
    FDDomicializacionesClientes.LoadValues( AEmpresa, ACliente );
    FDDomicializacionesClientes.ShowModal;
  finally
    FreeAndNil(FDDomicializacionesClientes );
  end;
end;

procedure TFDDomicializacionesClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QDomicializaciones.Close;
  Action:= caFree;
end;

procedure TFDDomicializacionesClientes.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDDomicializacionesClientes.LoadValues( const AEmpresa, ACliente: string );
begin
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  bAlta:= False;

  with QDomicializaciones do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_clientes_mandato_domicializacion ');
    SQL.Add(' where empresa_cmd = :empresa ');
    SQL.Add(' and cliente_cmd = :cliente ');
    SQL.Add(' order by fecha_ini_cmd ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    Open;
  end;

  with QDomicializacionesAux do
  begin
    SQL.Clear;
    SQL.AddStrings( QDomicializaciones.SQL );
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
  end;
end;


function TFDDomicializacionesClientes.ValidarValues: boolean;
begin
  if TryStrToDate( fecha_ini_cmd.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_cmd.SetFocus;
    ValidarValues:= False;
  end;
end;

procedure TFDDomicializacionesClientes.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QDomicializaciones.Insert;

  empresa_cmd.Text:= sEmpresa;
  cliente_cmd.Text:= sCliente;
  fecha_ini_cmd.Text:= DateToStr( date );
  adeudos_cmd.Text:= '0';

  QDomicializaciones.FieldByName('empresa_cmd').AsString:= sEmpresa;
  QDomicializaciones.FieldByName('cliente_cmd').AsString:= sCliente;
  QDomicializaciones.FieldByName('adeudos_cmd').AsInteger:= 0;
  QDomicializaciones.FieldByName('fecha_ini_cmd').AsDateTime:= Date;

  fecha_ini_cmd.Enabled:= True;
  adeudos_cmd.Enabled:= True;
  mandato_cmd.Enabled:= True;
  fecha_mandato_cmd.Enabled:= True;
  iban_cliente_cmd.Enabled:= True;
  code_bic_cliente_cmd.Enabled:= True;
  DBGrid.Enabled:= False;

  fecha_ini_cmd.SetFocus;
end;

procedure TFDDomicializacionesClientes.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QDomicializaciones.IsEmpty then
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

    fecha_ini_cmd.Enabled:= False;
    QDomicializaciones.Edit;

    adeudos_cmd.Enabled:= True;
    mandato_cmd.Enabled:= True;
    fecha_mandato_cmd.Enabled:= True;
    iban_cliente_cmd.Enabled:= True;
    code_bic_cliente_cmd.Enabled:= True;
    DBGrid.Enabled:= False;

    mandato_cmd.SetFocus;
  end;
end;

procedure TFDDomicializacionesClientes.btnAceptarClick(Sender: TObject);
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
        QDomicializaciones.FieldByName('fecha_fin_cmd').AsDateTime:= dFechaFin;
      end;
    end;
    QDomicializaciones.Post;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    fecha_ini_cmd.Enabled:= False;
    mandato_cmd.Enabled:= False;
    fecha_mandato_cmd.Enabled:= False;
    iban_cliente_cmd.Enabled:= False;
    code_bic_cliente_cmd.Enabled:= False;
    adeudos_cmd.Enabled:= False;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      QDomicializaciones.Close;
      QDomicializaciones.Open;
      while not QDomicializaciones.Eof do
      begin
        if QDomicializaciones.FieldByName('fecha_ini_cmd').AsDateTime = dFechaIni then
          Break;
        QDomicializaciones.Next;
      end;
    end;
  end;
end;

procedure TFDDomicializacionesClientes.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QDomicializaciones.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    fecha_ini_cmd.Enabled:= False;
    mandato_cmd.Enabled:= False;
    fecha_mandato_cmd.Enabled:= False;
    iban_cliente_cmd.Enabled:= False;
    code_bic_cliente_cmd.Enabled:= False;
    adeudos_cmd.Enabled:= False;
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

procedure TFDDomicializacionesClientes.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QDomicializaciones.IsEmpty then
  begin
    if QDomicializaciones.FieldByName('fecha_fin_cmd').AsString = '' then
    begin
      QDomicializaciones.Delete;
      if not QDomicializaciones.IsEmpty then
      begin
        QDomicializaciones.Edit;
        QDomicializaciones.FieldByName('fecha_fin_cmd').AsString:= '';
        QDomicializaciones.Post;
      end;
    end
    else
    begin
      QDomicializaciones.Delete;
      dIniAux:=  QDomicializaciones.FieldByName('fecha_ini_cmd').AsDateTime;
      QDomicializaciones.Prior;
      if dIniAux <> QDomicializaciones.FieldByName('fecha_ini_cmd').AsDateTime then
      begin
        QDomicializaciones.Edit;
        QDomicializaciones.FieldByName('fecha_fin_cmd').AsDateTime:= dIniAux - 1;
        QDomicializaciones.Post;
      end;
    end;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDDomicializacionesClientes.empresa_cmdChange(Sender: TObject);
begin
  stPlanta.Caption:= desEmpresa( empresa_cmd.Text );
end;

function TFDDomicializacionesClientes.ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  QDomicializacionesAux.Open;
  try
    if not QDomicializacionesAux.IsEmpty then
    begin
      while ( QDomicializacionesAux.FieldByName('fecha_ini_cmd').AsDateTime < VFechaFin ) and
            ( not QDomicializacionesAux.Eof ) do
      begin
        bAnt:= True;
        QDomicializacionesAux.Next;
      end;
      if QDomicializacionesAux.FieldByName('fecha_ini_cmd').AsDateTime <> VFechaFin then
      begin
        if QDomicializacionesAux.Eof then
        begin
          //Estoy en
          QDomicializacionesAux.Edit;
          QDomicializacionesAux.FieldByName('fecha_fin_cmd').AsDateTime:= VFechaFin - 1;
          QDomicializacionesAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QDomicializacionesAux.Prior;
            QDomicializacionesAux.Edit;
            QDomicializacionesAux.FieldByName('fecha_fin_cmd').AsDateTime:= VFechaFin - 1;
            QDomicializacionesAux.Post;
            QDomicializacionesAux.Next;
          end;
          //Hay siguiente
          if not QDomicializacionesAux.Eof then
          begin
            VFechaFin:= QDomicializacionesAux.FieldByName('fecha_ini_cmd').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QDomicializacionesAux.Close;
  end;
end;

end.


