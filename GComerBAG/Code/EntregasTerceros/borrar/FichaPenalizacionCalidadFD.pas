unit FichaPenalizacionCalidadFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB,
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit;

type
  TFDFichaPenalizacionCalidad = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSFichaCalidad: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    QFichaCalidad: TQuery;
    btnModificar: TSpeedButton;
    stPlanta: TStaticText;
    empresa_pc: TBDEdit;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TnbLabel;
    lblCajasReutilizables: TnbLabel;
    lblColorHomogeneo: TnbLabel;
    cortar_manojos_pc: TnbDBNumeric;
    cajas_reutilizables_pc: TnbDBNumeric;
    color_homogeneo_pc: TnbDBNumeric;
    fecha_ini_pc: TnbDBCalendarCombo;
    fecha_fin_pc: TnbDBCalendarCombo;
    lbl2: TnbLabel;
    centro_pc: TBDEdit;
    stCentro: TStaticText;
    QFichaCalidadAux: TQuery;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_pcChange(Sender: TObject);
    procedure centro_pcChange(Sender: TObject);
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

  procedure ExecuteFichaPenalizacionCalidad( const AOwner: TComponent; const AEmpresa, AProveedor, AProductor: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB;

var
  FDFichaPenalizacionCalidad: TFDFichaPenalizacionCalidad;

  //penalizar calidad
procedure ExecuteFichaPenalizacionCalidad( const AOwner: TComponent; const AEmpresa, AProveedor, AProductor: string );
begin
  FDFichaPenalizacionCalidad:= TFDFichaPenalizacionCalidad.Create( AOwner );
  try
    FDFichaPenalizacionCalidad.LoadValues( AEmpresa, AProveedor, AProductor );
    FDFichaPenalizacionCalidad.ShowModal;
  finally
    FreeAndNil(FDFichaPenalizacionCalidad );
  end;
end;

procedure TFDFichaPenalizacionCalidad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QFichaCalidad.Close;
  Action:= caFree;
end;

procedure TFDFichaPenalizacionCalidad.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDFichaPenalizacionCalidad.LoadValues( const AEmpresa, APlanta, ACentro: string );
begin
  sEmpresa:= AEmpresa;
  sPlanta:= APlanta;
  sCentro:= ACentro;
  bAlta:= False;

  with QFichaCalidad do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_penalizacion_calidad ');
    SQL.Add(' where empresa_pc = :empresa ');
    SQL.Add(' and planta_pc = :planta ');
    SQL.Add(' and centro_pc = :centro ');
    SQL.Add(' order by fecha_ini_pc ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('planta').AsString:= APlanta;
    ParamByName('centro').AsString:= ACentro;
    Open;
  end;

  with QFichaCalidadAux do
  begin
    SQL.Clear;
    SQL.AddStrings( QFichaCalidad.SQL );
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('planta').AsString:= APlanta;
    ParamByName('centro').AsString:= ACentro;
  end;
end;


function TFDFichaPenalizacionCalidad.ValidarValues: boolean;
begin
  if cortar_manojos_pc.Text = '' then
    cortar_manojos_pc.Text:= '0';
  if cajas_reutilizables_pc.Text = '' then
    cajas_reutilizables_pc.Text:= '0';
  if color_homogeneo_pc.Text = '' then
    color_homogeneo_pc.Text:= '0';

  if TryStrToDate( fecha_ini_pc.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_pc.SetFocus;
    ValidarValues:= False;
  end;
end;

procedure TFDFichaPenalizacionCalidad.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QFichaCalidad.Insert;

  empresa_pc.Text:= sEmpresa;
  centro_pc.Text:= sCentro;
  fecha_ini_pc.Text:= DateToStr( date );

  QFichaCalidad.FieldByName('empresa_pc').AsString:= sEmpresa;
  QFichaCalidad.FieldByName('planta_pc').AsString:= sPlanta;
  QFichaCalidad.FieldByName('centro_pc').AsString:= sCentro;
  QFichaCalidad.FieldByName('fecha_ini_pc').AsDateTime:= Date;


  fecha_ini_pc.Enabled:= True;
  cortar_manojos_pc.Enabled:= True;
  cajas_reutilizables_pc.Enabled:= True;
  color_homogeneo_pc.Enabled:= True;
  DBGrid.Enabled:= False;

  fecha_ini_pc.SetFocus;
end;

procedure TFDFichaPenalizacionCalidad.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QFichaCalidad.IsEmpty then
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

    QFichaCalidad.Edit;

    fecha_ini_pc.Enabled:= True;
    cortar_manojos_pc.Enabled:= True;
    cajas_reutilizables_pc.Enabled:= True;
    color_homogeneo_pc.Enabled:= True;

    DBGrid.Enabled:= False;

    cortar_manojos_pc.SetFocus;
  end;
end;

procedure TFDFichaPenalizacionCalidad.btnAceptarClick(Sender: TObject);
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
        QFichaCalidad.FieldByName('fecha_fin_pc').AsDateTime:= dFechaFin;
      end;
    end;
    QFichaCalidad.Post;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    fecha_ini_pc.Enabled:= False;
    cortar_manojos_pc.Enabled:= False;
    cajas_reutilizables_pc.Enabled:= False;
    color_homogeneo_pc.Enabled:= False;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      QFichaCalidad.Close;
      QFichaCalidad.Open;
      while not QFichaCalidad.Eof do
      begin
        if QFichaCalidad.FieldByName('fecha_ini_pc').AsDateTime = dFechaIni then
          Break;
        QFichaCalidad.Next;
      end;
    end;
  end;
end;

procedure TFDFichaPenalizacionCalidad.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QFichaCalidad.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    fecha_ini_pc.Enabled:= False;
    cortar_manojos_pc.Enabled:= False;
    cajas_reutilizables_pc.Enabled:= False;
    color_homogeneo_pc.Enabled:= False;
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

procedure TFDFichaPenalizacionCalidad.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QFichaCalidad.IsEmpty then
  begin
    if qFichaCalidad.FieldByName('fecha_fin_pc').AsString = '' then
    begin
      qFichaCalidad.Delete;
      if not qFichaCalidad.IsEmpty then
      begin
        qFichaCalidad.Edit;
        qFichaCalidad.FieldByName('fecha_fin_pc').AsString:= '';
        qFichaCalidad.Post;
      end;
    end
    else
    begin
      qFichaCalidad.Delete;
      dIniAux:=  qFichaCalidad.FieldByName('fecha_ini_pc').AsDateTime;
      qFichaCalidad.Prior;
      if dIniAux <> qFichaCalidad.FieldByName('fecha_ini_pc').AsDateTime then
      begin
        qFichaCalidad.Edit;
        qFichaCalidad.FieldByName('fecha_fin_pc').AsDateTime:= dIniAux - 1;
        qFichaCalidad.Post;
      end;
    end;

    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDFichaPenalizacionCalidad.empresa_pcChange(Sender: TObject);
begin
  stPlanta.Caption:= desEmpresa( empresa_pc.Text );
  centro_pcChange( centro_pc );
end;

procedure TFDFichaPenalizacionCalidad.centro_pcChange(Sender: TObject);
begin
  stCentro.Caption:= desCentro( empresa_pc.Text, centro_pc.Text );
end;

function TFDFichaPenalizacionCalidad.ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  QFichaCalidadAux.Open;
  try
    if not QFichaCalidadAux.IsEmpty then
    begin
      while ( QFichaCalidadAux.FieldByName('fecha_ini_pc').AsDateTime < VFechaFin ) and
            ( not QFichaCalidadAux.Eof ) do
      begin
        bAnt:= True;
        QFichaCalidadAux.Next;
      end;
      if QFichaCalidadAux.FieldByName('fecha_ini_pc').AsDateTime <> VFechaFin then
      begin
        if QFichaCalidadAux.Eof then
        begin
          //Estoy en
          QFichaCalidadAux.Edit;
          QFichaCalidadAux.FieldByName('fecha_fin_pc').AsDateTime:= VFechaFin - 1;
          QFichaCalidadAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QFichaCalidadAux.Prior;
            QFichaCalidadAux.Edit;
            QFichaCalidadAux.FieldByName('fecha_fin_pc').AsDateTime:= VFechaFin - 1;
            QFichaCalidadAux.Post;
            QFichaCalidadAux.Next;
          end;
          //Hay siguiente
          if not QFichaCalidadAux.Eof then
          begin
            VFechaFin:= QFichaCalidadAux.FieldByName('fecha_ini_pc').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QFichaCalidadAux.Close;
  end;
end;

end.


