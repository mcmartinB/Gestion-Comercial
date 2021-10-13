unit FichaPenalizacionDestrioFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB,
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit;

type
  TFDFichaPenalizacionDestrio = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    fecha_ini_pd: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    nbLabel5: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSFichaDestrio: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    fecha_fin_pd: TnbDBCalendarCombo;
    p020_pd: TnbDBNumeric;
    lblCajasReutilizables: TnbLabel;
    p025_pd: TnbDBNumeric;
    lblPapelProtector: TnbLabel;
    p035_pd: TnbDBNumeric;
    lblColorHomogeneo: TnbLabel;
    p040_pd: TnbDBNumeric;
    QFichaDestrio: TQuery;
    btnModificar: TSpeedButton;
    stPlanta: TStaticText;
    stCentro: TStaticText;
    empresa_pd: TBDEdit;
    centro_pd: TBDEdit;
    lblProductor: TnbLabel;
    p005_pd: TnbDBNumeric;
    lbl5: TnbLabel;
    p010_pd: TnbDBNumeric;
    lbl7: TnbLabel;
    lbl8: TnbLabel;
    lbl9: TnbLabel;
    lbl10: TnbLabel;
    p065_pd: TnbDBNumeric;
    p070_pd: TnbDBNumeric;
    p080_pd: TnbDBNumeric;
    p085_pd: TnbDBNumeric;
    lbl11: TnbLabel;
    p050_pd: TnbDBNumeric;
    lbl12: TnbLabel;
    p055_pd: TnbDBNumeric;
    lblNombre7: TLabel;
    lblNombre8: TLabel;
    p030_pd: TnbDBNumeric;
    p045_pd: TnbDBNumeric;
    p015_pd: TnbDBNumeric;
    lblNombre9: TLabel;
    lblNombre10: TLabel;
    lblNombre11: TLabel;
    p075_pd: TnbDBNumeric;
    p090_pd: TnbDBNumeric;
    p060_pd: TnbDBNumeric;
    lblNombre12: TLabel;
    lbl13: TnbLabel;
    lbl14: TnbLabel;
    p095_pd: TnbDBNumeric;
    p100_pd: TnbDBNumeric;
    lbl18: TnbLabel;
    lbl19: TnbLabel;
    lbl20: TnbLabel;
    lbl21: TnbLabel;
    lbl22: TnbLabel;
    lbl23: TnbLabel;
    lbl1: TLabel;
    QFichaDestrioAux: TQuery;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_pdChange(Sender: TObject);
    procedure centro_pdChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sPlanta, sCentro: String;
    bAlta: boolean;
    dFechaIni: TDateTime;

    function  ValidarValues: boolean;
    function  ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;

  public
    { Public declarations }
    procedure LoadValues( const AEmpresa, APlanta, ACentro: string );

  end;

  procedure ExecuteFichaPenalizacionDestrio( const AOwner: TComponent; const AEmpresa, AProveedor, AProductor: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB;

var
  FDFichaPenalizacionDestrio: TFDFichaPenalizacionDestrio;

  //penalizar calidad
procedure ExecuteFichaPenalizacionDestrio( const AOwner: TComponent; const AEmpresa, AProveedor, AProductor: string );
begin
  FDFichaPenalizacionDestrio:= TFDFichaPenalizacionDestrio.Create( AOwner );
  try
    FDFichaPenalizacionDestrio.LoadValues( AEmpresa, AProveedor, AProductor );
    FDFichaPenalizacionDestrio.ShowModal;
  finally
    FreeAndNil(FDFichaPenalizacionDestrio );
  end;
end;

procedure TFDFichaPenalizacionDestrio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QFichaDestrio.Close;
  Action:= caFree;
end;

procedure TFDFichaPenalizacionDestrio.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDFichaPenalizacionDestrio.LoadValues( const AEmpresa, APlanta, ACentro: string );
begin
  sEmpresa:= AEmpresa;
  sPlanta:= APlanta;
  sCentro:= ACentro;
  bAlta:= False;

  with QFichaDestrio do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_penalizacion_destrio ');
    SQL.Add(' where empresa_pd = :empresa ');
    SQL.Add(' and planta_pd = :planta ');
    SQL.Add(' and centro_pd = :centro ');
    SQL.Add(' order by fecha_ini_pD ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('planta').AsString:= APlanta;
    ParamByName('centro').AsString:= ACentro;
    Open;
  end;

  with QFichaDestrioAux do
  begin
    SQL.Clear;
    SQL.AddStrings( QFichaDestrio.SQL );
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('planta').AsString:= APlanta;
    ParamByName('centro').AsString:= ACentro;
  end;
end;


function TFDFichaPenalizacionDestrio.ValidarValues: boolean;
begin

  if p005_pd.Text = '' then
    p005_pd.Text:= '0';
  if p010_pd.Text = '' then
    p010_pd.Text:= p005_pd.Text;
  if p015_pd.Text = '' then
    p015_pd.Text:= p010_pd.Text;
  if p020_pd.Text = '' then
    p020_pd.Text:= p015_pd.Text;
  if p025_pd.Text = '' then
    p025_pd.Text:= p020_pd.Text;
  if p030_pd.Text = '' then
    p030_pd.Text:= p025_pd.Text;
  if p035_pd.Text = '' then
    p035_pd.Text:= p030_pd.Text;
  if p040_pd.Text = '' then
    p040_pd.Text:= p035_pd.Text;
  if p045_pd.Text = '' then
    p045_pd.Text:= p040_pd.Text;
  if p050_pd.Text = '' then
    p050_pd.Text:= p045_pd.Text;
  if p055_pd.Text = '' then
    p055_pd.Text:= p050_pd.Text;
  if p060_pd.Text = '' then
    p060_pd.Text:= p055_pd.Text;
  if p065_pd.Text = '' then
    p065_pd.Text:= p060_pd.Text;
  if p070_pd.Text = '' then
    p070_pd.Text:= p065_pd.Text;
  if p075_pd.Text = '' then
    p075_pd.Text:= p070_pd.Text;
  if p080_pd.Text = '' then
    p080_pd.Text:= p075_pd.Text;
  if p085_pd.Text = '' then
    p085_pd.Text:= p080_pd.Text;
  if p090_pd.Text = '' then
    p090_pd.Text:= p085_pd.Text;
  if p095_pd.Text = '' then
    p095_pd.Text:= p090_pd.Text;
  if p100_pd.Text = '' then
    p100_pd.Text:= p095_pd.Text;

  if TryStrToDate( fecha_ini_pd.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_pd.SetFocus;
    ValidarValues:= False;
  end;
end;

procedure TFDFichaPenalizacionDestrio.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QFichaDestrio.Insert;

  empresa_pd.Text:= sEmpresa;
  centro_pd.Text:= sCentro;
  fecha_ini_pd.Text:= DateToStr( date );

  QFichaDestrio.FieldByName('empresa_pd').AsString:= sEmpresa;
  QFichaDestrio.FieldByName('planta_pd').AsString:= sPlanta;
  QFichaDestrio.FieldByName('centro_pd').AsString:= sCentro;
  QFichaDestrio.FieldByName('fecha_ini_pd').AsDateTime:= Date;


  fecha_ini_pd.Enabled:= True;
  p005_pd.Enabled:= True;
  p010_pd.Enabled:= True;
  p015_pd.Enabled:= True;
  p020_pd.Enabled:= True;
  p025_pd.Enabled:= True;
  p030_pd.Enabled:= True;
  p035_pd.Enabled:= True;
  p040_pd.Enabled:= True;
  p045_pd.Enabled:= True;
  p050_pd.Enabled:= True;
  p055_pd.Enabled:= True;
  p060_pd.Enabled:= True;
  p065_pd.Enabled:= True;
  p070_pd.Enabled:= True;
  p075_pd.Enabled:= True;
  p080_pd.Enabled:= True;
  p085_pd.Enabled:= True;
  p090_pd.Enabled:= True;
  p095_pd.Enabled:= True;
  p100_pd.Enabled:= True;
  DBGrid.Enabled:= False;

  fecha_ini_pd.SetFocus;
end;

procedure TFDFichaPenalizacionDestrio.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QFichaDestrio.IsEmpty then
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

    QFichaDestrio.Edit;

    fecha_ini_pd.Enabled:= True;
    p005_pd.Enabled:= True;
    p010_pd.Enabled:= True;
    p015_pd.Enabled:= True;
    p020_pd.Enabled:= True;
    p025_pd.Enabled:= True;
    p030_pd.Enabled:= True;
    p035_pd.Enabled:= True;
    p040_pd.Enabled:= True;
    p045_pd.Enabled:= True;
    p050_pd.Enabled:= True;
    p055_pd.Enabled:= True;
    p060_pd.Enabled:= True;
    p065_pd.Enabled:= True;
    p070_pd.Enabled:= True;
    p075_pd.Enabled:= True;
    p080_pd.Enabled:= True;
    p085_pd.Enabled:= True;
    p090_pd.Enabled:= True;
    p095_pd.Enabled:= True;
    p100_pd.Enabled:= True;

    DBGrid.Enabled:= False;

    p005_pd.SetFocus;
  end;
end;

procedure TFDFichaPenalizacionDestrio.btnAceptarClick(Sender: TObject);
var
  dFechaFin: TDateTime;
begin
  if ValidarValues then
  begin
    if bAlta then
    begin
      dFechaFin:= dFechaIni;
      if ActualizarFechaFinAlta( dFechaFin ) then
      begin
        QFichaDestrio.FieldByName('fecha_fin_pd').AsDateTime:= dFechaFin;
      end;
    end;
    QFichaDestrio.Post;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    fecha_ini_pd.Enabled:= False;
    p005_pd.Enabled:= False;
    p010_pd.Enabled:= False;
    p015_pd.Enabled:= False;
    p020_pd.Enabled:= False;
    p025_pd.Enabled:= False;
    p030_pd.Enabled:= False;
    p035_pd.Enabled:= False;
    p040_pd.Enabled:= False;
    p045_pd.Enabled:= False;
    p050_pd.Enabled:= False;
    p055_pd.Enabled:= False;
    p060_pd.Enabled:= False;
    p065_pd.Enabled:= False;
    p070_pd.Enabled:= False;
    p075_pd.Enabled:= False;
    p080_pd.Enabled:= False;
    p085_pd.Enabled:= False;
    p090_pd.Enabled:= False;
    p095_pd.Enabled:= False;
    p100_pd.Enabled:= False;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      QFichaDestrio.Close;
      QFichaDestrio.Open;
      while not QFichaDestrio.Eof do
      begin
        if QFichaDestrio.FieldByName('fecha_ini_pd').AsDateTime = dFechaIni then
          Break;
        QFichaDestrio.Next;
      end;
    end;
  end;
end;

procedure TFDFichaPenalizacionDestrio.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QFichaDestrio.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    fecha_ini_pd.Enabled:= False;
    p005_pd.Enabled:= False;
    p010_pd.Enabled:= False;
    p015_pd.Enabled:= False;
    p020_pd.Enabled:= False;
    p025_pd.Enabled:= False;
    p030_pd.Enabled:= False;
    p035_pd.Enabled:= False;
    p040_pd.Enabled:= False;
    p045_pd.Enabled:= False;
    p050_pd.Enabled:= False;
    p055_pd.Enabled:= False;
    p060_pd.Enabled:= False;
    p065_pd.Enabled:= False;
    p070_pd.Enabled:= False;
    p075_pd.Enabled:= False;
    p080_pd.Enabled:= False;
    p085_pd.Enabled:= False;
    p090_pd.Enabled:= False;
    p095_pd.Enabled:= False;
    p100_pd.Enabled:= False;
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

procedure TFDFichaPenalizacionDestrio.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QFichaDestrio.IsEmpty then
  begin
    if qFichaDestrio.FieldByName('fecha_fin_pd').AsString = '' then
    begin
      qFichaDestrio.Delete;
      if not qFichaDestrio.IsEmpty then
      begin
        qFichaDestrio.Edit;
        qFichaDestrio.FieldByName('fecha_fin_pd').AsString:= '';
        qFichaDestrio.Post;
      end;
    end
    else
    begin
      qFichaDestrio.Delete;
      dIniAux:=  qFichaDestrio.FieldByName('fecha_ini_pd').AsDateTime;
      qFichaDestrio.Prior;
      if dIniAux <> qFichaDestrio.FieldByName('fecha_ini_pd').AsDateTime then
      begin
        qFichaDestrio.Edit;
        qFichaDestrio.FieldByName('fecha_fin_pd').AsDateTime:= dIniAux - 1;
        qFichaDestrio.Post;
      end;
    end;

    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDFichaPenalizacionDestrio.empresa_pdChange(Sender: TObject);
begin
  stPlanta.Caption:= desEmpresa( empresa_pd.Text );
  centro_pdChange( centro_pd );
end;

procedure TFDFichaPenalizacionDestrio.centro_pdChange(Sender: TObject);
begin
  stCentro.Caption:= desCentro( empresa_pd.Text, centro_pd.Text );
end;

function TFDFichaPenalizacionDestrio.ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  QFichaDestrioAux.Open;
  try
    if not QFichaDestrioAux.IsEmpty then
    begin
      while ( QFichaDestrioAux.FieldByName('fecha_ini_pd').AsDateTime < VFechaFin ) and
            ( not QFichaDestrioAux.Eof ) do
      begin
        bAnt:= True;
        QFichaDestrioAux.Next;
      end;
      if QFichaDestrioAux.FieldByName('fecha_ini_pd').AsDateTime <> VFechaFin then
      begin
        if QFichaDestrioAux.Eof then
        begin
          //Estoy en
          QFichaDestrioAux.Edit;
          QFichaDestrioAux.FieldByName('fecha_fin_pd').AsDateTime:= VFechaFin - 1;
          QFichaDestrioAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QFichaDestrioAux.Prior;
            QFichaDestrioAux.Edit;
            QFichaDestrioAux.FieldByName('fecha_fin_pd').AsDateTime:= VFechaFin - 1;
            QFichaDestrioAux.Post;
            QFichaDestrioAux.Next;
          end;
          //Hay siguiente
          if not QFichaDestrioAux.Eof then
          begin
            VFechaFin:= QFichaDestrioAux.FieldByName('fecha_ini_pd').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QFichaDestrioAux.Close;
  end;
end;

end.


