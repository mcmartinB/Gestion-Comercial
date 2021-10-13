unit EcoembesEnvasesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB,
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit;
                                                
type
  TFDEcoembesEnvases = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    fecha_ini_eco: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSEcoembes: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    fecha_fin_eco: TnbDBCalendarCombo;
    QEcoembes: TQuery;
    btnModificar: TSpeedButton;
    stPlanta: TStaticText;
    txtEnvase: TStaticText;
    empresa_eco: TBDEdit;
    lblProductor: TnbLabel;
    lbl3: TnbLabel;
    QEcoembesAux: TQuery;
    envase_eco: TBDEdit;
    ecoembes_eco: TDBCheckBox;
    txtProducto: TStaticText;
    producto_base_eco: TBDEdit;
    lblProducto: TnbLabel;
    lblImporte: TnbLabel;
    importe_eco: TBDEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_ecoChange(Sender: TObject);
    procedure envase_ecoChange(Sender: TObject);
    procedure producto_base_ecoChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sEnvase, sProducdoBase: String;
    bAlta: boolean;
    dFechaIni: TDateTime;

    function  ValidarValues: boolean;
    function  ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;

  public
    { Public declarations }
    procedure LoadValues( const AEmpresa, AEnvase, AProductoBase: string );

  end;

  procedure ExecuteEcoembesEnvases( const AOwner: TComponent; const AEmpresa, AEnvase, AProductoBase: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB;

var
  FDEcoembesEnvases: TFDEcoembesEnvases;


procedure ExecuteEcoembesEnvases( const AOwner: TComponent; const AEmpresa, AEnvase, AProductoBase: string );
begin
  FDEcoembesEnvases:= TFDEcoembesEnvases.Create( AOwner );
  try
    FDEcoembesEnvases.LoadValues( AEmpresa, AEnvase, AProductoBase );
    FDEcoembesEnvases.ShowModal;
  finally
    FreeAndNil(FDEcoembesEnvases );
  end;
end;

procedure TFDEcoembesEnvases.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QEcoembes.Close;
  Action:= caFree;
end;

procedure TFDEcoembesEnvases.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDEcoembesEnvases.LoadValues( const AEmpresa, AEnvase, AProductoBase: string );
begin
  sEmpresa:= AEmpresa;
  sEnvase:= AEnvase;
  sProducdoBase:= AProductoBase;
  bAlta:= False;

  with QEcoembes do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_eco, envase_eco, producto_base_eco, fecha_ini_eco, fecha_fin_eco, ecoembes_eco, importe_eco ');
    SQL.Add(' from frf_ecoembes ');
    SQL.Add(' where empresa_eco = :empresa ');
    SQL.Add(' and envase_eco = :envase ');
    SQL.Add(' and producto_base_eco = :producto_base ');
    SQL.Add(' order by fecha_ini_eco ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('envase').AsString:= AEnvase;
    ParamByName('producto_base').AsString:= AProductoBase;
    Open;
  end;

  with QEcoembesAux do
  begin
    SQL.Clear;
    SQL.AddStrings( QEcoembes.SQL );
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('envase').AsString:= AEnvase;
    ParamByName('producto_base').AsString:= AProductoBase;
  end;
end;


function TFDEcoembesEnvases.ValidarValues: boolean;
begin
  if TryStrToDate( fecha_ini_eco.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_eco.SetFocus;
    ValidarValues:= False;
  end;
end;

procedure TFDEcoembesEnvases.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QEcoembes.Insert;

  empresa_eco.Text:= sEmpresa;
  envase_eco.Text:= sEnvase;
  producto_base_eco.Text:= sProducdoBase;
  fecha_ini_eco.Text:= DateToStr( date );
  ecoembes_eco.Checked:= True;

  QEcoembes.FieldByName('empresa_eco').AsString:= sEmpresa;
  QEcoembes.FieldByName('envase_eco').AsString:= sEnvase;
  QEcoembes.FieldByName('producto_base_eco').AsString:= sProducdoBase;
  QEcoembes.FieldByName('ecoembes_eco').AsInteger:= 1;
  QEcoembes.FieldByName('fecha_ini_eco').AsDateTime:= Date;

  fecha_ini_eco.Enabled:= True;
  ecoembes_eco.Enabled:= True;
  importe_eco.Enabled:= True;
  DBGrid.Enabled:= False;

  fecha_ini_eco.SetFocus;
end;

procedure TFDEcoembesEnvases.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QEcoembes.IsEmpty then
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

    fecha_ini_eco.Enabled:= False;
    QEcoembes.Edit;

    ecoembes_eco.Enabled:= True;
    importe_eco.Enabled:= True;
    DBGrid.Enabled:= False;

    ecoembes_eco.SetFocus;
  end;
end;

procedure TFDEcoembesEnvases.btnAceptarClick(Sender: TObject);
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
        QEcoembes.FieldByName('fecha_fin_eco').AsDateTime:= dFechaFin;
      end;
    end;
    QEcoembes.Post;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    fecha_ini_eco.Enabled:= False;
    ecoembes_eco.Enabled:= False;
    importe_eco.Enabled:= False;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      QEcoembes.Close;
      QEcoembes.Open;
      while not QEcoembes.Eof do
      begin
        if QEcoembes.FieldByName('fecha_ini_eco').AsDateTime = dFechaIni then
          Break;
        QEcoembes.Next;
      end;
    end;
  end;
end;

procedure TFDEcoembesEnvases.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QEcoembes.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    fecha_ini_eco.Enabled:= False;
    ecoembes_eco.Enabled:= false;
    importe_eco.Enabled:= false;
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

procedure TFDEcoembesEnvases.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QEcoembes.IsEmpty then
  begin
    if QEcoembes.FieldByName('fecha_fin_eco').AsString = '' then
    begin
      QEcoembes.Delete;
      if not QEcoembes.IsEmpty then
      begin
        QEcoembes.Edit;
        QEcoembes.FieldByName('fecha_fin_eco').AsString:= '';
        QEcoembes.Post;
      end;
    end
    else
    begin
      QEcoembes.Delete;
      dIniAux:=  QEcoembes.FieldByName('fecha_ini_eco').AsDateTime;
      QEcoembes.Prior;
      if dIniAux <> QEcoembes.FieldByName('fecha_ini_eco').AsDateTime then
      begin
        QEcoembes.Edit;
        QEcoembes.FieldByName('fecha_fin_eco').AsDateTime:= dIniAux - 1;
        QEcoembes.Post;
      end;
    end;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDEcoembesEnvases.empresa_ecoChange(Sender: TObject);
begin
  stPlanta.Caption:= desEmpresa( empresa_eco.Text );
  producto_base_eco.Change;
end;

procedure TFDEcoembesEnvases.envase_ecoChange(Sender: TObject);
begin
  txtEnvase.Caption:= desEnvasePBase( empresa_eco.Text, envase_eco.Text, producto_base_eco.Text )
end;

procedure TFDEcoembesEnvases.producto_base_ecoChange(Sender: TObject);
begin
  txtProducto.Caption:= desProductoBase( empresa_eco.Text, producto_base_eco.Text );
  envase_eco.Change;
end;

function TFDEcoembesEnvases.ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  QEcoembesAux.Open;
  try
    if not QEcoembesAux.IsEmpty then
    begin
      while ( QEcoembesAux.FieldByName('fecha_ini_eco').AsDateTime < VFechaFin ) and
            ( not QEcoembesAux.Eof ) do
      begin
        bAnt:= True;
        QEcoembesAux.Next;
      end;
      if QEcoembesAux.FieldByName('fecha_ini_eco').AsDateTime <> VFechaFin then
      begin
        if QEcoembesAux.Eof then
        begin
          //Estoy en
          QEcoembesAux.Edit;
          QEcoembesAux.FieldByName('fecha_fin_eco').AsDateTime:= VFechaFin - 1;
          QEcoembesAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QEcoembesAux.Prior;
            QEcoembesAux.Edit;
            QEcoembesAux.FieldByName('fecha_fin_eco').AsDateTime:= VFechaFin - 1;
            QEcoembesAux.Post;
            QEcoembesAux.Next;
          end;
          //Hay siguiente
          if not QEcoembesAux.Eof then
          begin
            VFechaFin:= QEcoembesAux.FieldByName('fecha_ini_eco').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QEcoembesAux.Close;
  end;
end;

end.


