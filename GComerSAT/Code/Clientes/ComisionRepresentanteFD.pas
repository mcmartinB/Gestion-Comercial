unit ComisionRepresentanteFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB, 
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit;
                                                
type
  TFDComisionRepresentante = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    fecha_ini_rc: TnbDBCalendarCombo;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSComision: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    fecha_fin_rc: TnbDBCalendarCombo;
    QComisiones: TQuery;
    btnModificar: TSpeedButton;
    stPlanta: TStaticText;
    stProveedor: TStaticText;
    stProductor: TStaticText;
    lblProductor: TnbLabel;
    lbl1: TnbLabel;
    comision_rc: TnbDBNumeric;
    QComisionesAux: TQuery;
    representante_rc: TBDEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
    sRepresentante: String;
    bAlta: boolean;
    dFechaIni: TDateTime;

    function  ValidarValues: boolean;
    function  ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;

  public
    { Public declarations }
    procedure LoadValues( const ARepresentante: string );

  end;

  procedure ExecuteComisionRepresentante( const AOwner: TComponent; const ARepresentante: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB;

var
  FDComisionRepresentante: TFDComisionRepresentante;

procedure ExecuteComisionRepresentante( const AOwner: TComponent; const ARepresentante: string );
begin
  FDComisionRepresentante:= TFDComisionRepresentante.Create( AOwner );
  try
    FDComisionRepresentante.LoadValues( ARepresentante );
    FDComisionRepresentante.ShowModal;
  finally
    FreeAndNil(FDComisionRepresentante );
  end;
end;

procedure TFDComisionRepresentante.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QComisiones.Close;
  Action:= caFree;
end;

procedure TFDComisionRepresentante.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDComisionRepresentante.LoadValues( const ARepresentante: string );
begin
  sRepresentante:= ARepresentante;
  bAlta:= False;

  with QComisiones do
  begin
    SQL.Clear;
    SQL.Add(' select representante_rc, fecha_ini_rc, fecha_fin_rc, comision_rc ');
    SQL.Add(' from frf_representantes_comision ');
    SQL.Add(' where representante_rc = :representante ');
    SQL.Add(' order by fecha_ini_rc ');
    ParamByName('representante').AsString:= ARepresentante;
    Open;
  end;

  with QComisionesAux do
  begin
    SQL.Clear;
    SQL.AddStrings( QComisiones.SQL );
    ParamByName('representante').AsString:= ARepresentante;
  end;
end;


function TFDComisionRepresentante.ValidarValues: boolean;
begin
  if TryStrToDate( fecha_ini_rc.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_rc.SetFocus;
    ValidarValues:= False;
  end;
end;

procedure TFDComisionRepresentante.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QComisiones.Insert;

  representante_rc.Text:= sRepresentante;
  fecha_ini_rc.Text:= DateToStr( date );

  QComisiones.FieldByName('representante_rc').AsString:= sRepresentante;
  QComisiones.FieldByName('fecha_ini_rc').AsDateTime:= Date;

  fecha_ini_rc.Enabled:= True;
  comision_rc.Enabled:= True;
  DBGrid.Enabled:= False;

  fecha_ini_rc.SetFocus;
end;

procedure TFDComisionRepresentante.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QComisiones.IsEmpty then
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

    fecha_ini_rc.Enabled:= False;
    QComisiones.Edit;

    comision_rc.Enabled:= True;
    DBGrid.Enabled:= False;

    comision_rc.SetFocus;
  end;
end;

procedure TFDComisionRepresentante.btnAceptarClick(Sender: TObject);
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
        QComisiones.FieldByName('fecha_fin_rc').AsDateTime:= dFechaFin;
      end;
    end;
    QComisiones.Post;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    fecha_ini_rc.Enabled:= False;
    comision_rc.Enabled:= false;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      QComisiones.Close;
      QComisiones.Open;
      while not QComisiones.Eof do
      begin
        if QComisiones.FieldByName('fecha_ini_rc').AsDateTime = dFechaIni then
          Break;
        QComisiones.Next;
      end;
    end;
  end;
end;

procedure TFDComisionRepresentante.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QComisiones.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    fecha_ini_rc.Enabled:= False;
    comision_rc.Enabled:= False;
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

procedure TFDComisionRepresentante.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QComisiones.IsEmpty then
  begin
    if QComisiones.FieldByName('fecha_fin_rc').AsString = '' then
    begin
      QComisiones.Delete;
      if not QComisiones.IsEmpty then
      begin
        QComisiones.Edit;
        QComisiones.FieldByName('fecha_fin_rc').AsString:= '';
        QComisiones.Post;
      end;
    end
    else
    begin
      QComisiones.Delete;
      dIniAux:=  QComisiones.FieldByName('fecha_ini_rc').AsDateTime;
      QComisiones.Prior;
      if dIniAux <> QComisiones.FieldByName('fecha_ini_rc').AsDateTime then
      begin
        QComisiones.Edit;
        QComisiones.FieldByName('fecha_fin_rc').AsDateTime:= dIniAux - 1;
        QComisiones.Post;
      end;
    end;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;


function TFDComisionRepresentante.ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  QComisionesAux.Open;
  try
    if not QComisionesAux.IsEmpty then
    begin
      while ( QComisionesAux.FieldByName('fecha_ini_rc').AsDateTime < VFechaFin ) and
            ( not QComisionesAux.Eof ) do
      begin
        bAnt:= True;
        QComisionesAux.Next;
      end;
      if QComisionesAux.FieldByName('fecha_ini_rc').AsDateTime <> VFechaFin then
      begin
        if QComisionesAux.Eof then
        begin
          //Estoy en
          QComisionesAux.Edit;
          QComisionesAux.FieldByName('fecha_fin_rc').AsDateTime:= VFechaFin - 1;
          QComisionesAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QComisionesAux.Prior;
            QComisionesAux.Edit;
            QComisionesAux.FieldByName('fecha_fin_rc').AsDateTime:= VFechaFin - 1;
            QComisionesAux.Post;
            QComisionesAux.Next;
          end;
          //Hay siguiente
          if not QComisionesAux.Eof then
          begin
            VFechaFin:= QComisionesAux.FieldByName('fecha_ini_rc').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QComisionesAux.Close;
  end;
end;

end.


