unit FichaCalidadProductorFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB,
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit;

type
  TFDFichaCalidadProductor = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    fecha_ini_pac: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    nbLabel5: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSFichaCalidad: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    fecha_fin_pac: TnbDBCalendarCombo;
    lblProductor_: TnbLabel;
    cortar_manojos_pac: TDBCheckBox;
    lblCajasReutilizables: TnbLabel;
    cajas_reutilizables_pac: TDBCheckBox;
    lblColorHomogeneo: TnbLabel;
    color_homogeneo_pac: TDBCheckBox;
    QFichaCalidad: TQuery;
    btnModificar: TSpeedButton;
    stPlanta: TStaticText;
    stProveedor: TStaticText;
    stProductor: TStaticText;
    empresa_pac: TBDEdit;
    proveedor_pac: TBDEdit;
    almacen_pac: TBDEdit;
    lblProductor: TnbLabel;
    penaliza_productor_pac: TnbDBNumeric;
    lblProduct_o: TLabel;
    QFichaCalidadAux: TQuery;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_pacChange(Sender: TObject);
    procedure proveedor_pacChange(Sender: TObject);
    procedure almacen_pacChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sProveedor, sAlmacen: String;
    bAlta: boolean;
    dFechaIni: TDateTime;

    function  ValidarValues: boolean;
    function  ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;

  public
    { Public declarations }
    procedure LoadValues( const AEmpresa, AProveedor, AProductor: string );

  end;

  procedure ExecuteFichaCalidadProductor( const AOwner: TComponent; const AEmpresa, AProveedor, AProductor: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB;

var
  FDFichaCalidadProductor: TFDFichaCalidadProductor;

procedure ExecuteFichaCalidadProductor( const AOwner: TComponent; const AEmpresa, AProveedor, AProductor: string );
begin
  FDFichaCalidadProductor:= TFDFichaCalidadProductor.Create( AOwner );
  try
    FDFichaCalidadProductor.LoadValues( AEmpresa, AProveedor, AProductor );
    FDFichaCalidadProductor.ShowModal;
  finally
    FreeAndNil(FDFichaCalidadProductor );
  end;
end;

procedure TFDFichaCalidadProductor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QFichaCalidad.Close;
  Action:= caFree;
end;

procedure TFDFichaCalidadProductor.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDFichaCalidadProductor.LoadValues( const AEmpresa, AProveedor, AProductor: string );
begin
  sEmpresa:= AEmpresa;
  sProveedor:= AProveedor;
  sAlmacen:= AProductor;
  bAlta:= False;

  with QFichaCalidad do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_proveedores_almacen_calidad ');
    SQL.Add(' where empresa_pac = :planta ');
    SQL.Add(' and proveedor_pac = :proveedor ');
    SQL.Add(' and almacen_pac = :productor ');
    SQL.Add(' order by fecha_ini_pac ');
    ParamByName('planta').AsString:= AEmpresa;
    ParamByName('proveedor').AsString:= AProveedor;
    ParamByName('productor').AsInteger:= StrToIntDef( AProductor, 0 );
    Open;
  end;

  with QFichaCalidadAux do
  begin
    SQL.Clear;
    SQL.AddStrings( QFichaCalidad.SQL );
    ParamByName('planta').AsString:= AEmpresa;
    ParamByName('proveedor').AsString:= AProveedor;
    ParamByName('productor').AsInteger:= StrToIntDef( AProductor, 0 );
  end;
end;


function TFDFichaCalidadProductor.ValidarValues: boolean;
begin
  if not cortar_manojos_pac.Checked  then
    QFichaCalidad.FieldByName('cortar_manojos_pac').AsInteger:= 0;
  if not cajas_reutilizables_pac.Checked then
    QFichaCalidad.FieldByName('cajas_reutilizables_pac').AsInteger:= 0;
  if not color_homogeneo_pac.Checked then
    QFichaCalidad.FieldByName('color_homogeneo_pac').AsInteger:= 0;

  if TryStrToDate( fecha_ini_pac.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_pac.SetFocus;
    ValidarValues:= False;
  end;
end;

procedure TFDFichaCalidadProductor.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QFichaCalidad.Insert;

  empresa_pac.Text:= sEmpresa;
  proveedor_pac.Text:= sProveedor;
  almacen_pac.Text:= sAlmacen;
  fecha_ini_pac.Text:= DateToStr( date );

  QFichaCalidad.FieldByName('empresa_pac').AsString:= sEmpresa;
  QFichaCalidad.FieldByName('proveedor_pac').AsString:= sProveedor;
  QFichaCalidad.FieldByName('almacen_pac').AsString:= sAlmacen;
  QFichaCalidad.FieldByName('fecha_ini_pac').AsDateTime:= Date;

  cortar_manojos_pac.Checked:= False;
  cajas_reutilizables_pac.Checked:= False;
  color_homogeneo_pac.Checked:= False;

  QFichaCalidad.FieldByName('cortar_manojos_pac').AsInteger:= 0;
  QFichaCalidad.FieldByName('cajas_reutilizables_pac').AsInteger:= 0;
  QFichaCalidad.FieldByName('color_homogeneo_pac').AsInteger:= 0;


  fecha_ini_pac.Enabled:= True;
  penaliza_productor_pac.Enabled:= True;
  cortar_manojos_pac.Enabled:= True;
  cajas_reutilizables_pac.Enabled:= True;
  color_homogeneo_pac.Enabled:= True;
  DBGrid.Enabled:= False;

  fecha_ini_pac.SetFocus;
end;

procedure TFDFichaCalidadProductor.btnModificarClick(Sender: TObject);
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

    fecha_ini_pac.Enabled:= False;
    QFichaCalidad.Edit;

    penaliza_productor_pac.Enabled:= True;
    cortar_manojos_pac.Enabled:= True;
    cajas_reutilizables_pac.Enabled:= True;
    color_homogeneo_pac.Enabled:= True;
    DBGrid.Enabled:= False;

    cortar_manojos_pac.SetFocus;
  end;
end;

procedure TFDFichaCalidadProductor.btnAceptarClick(Sender: TObject);
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
        QFichaCalidad.FieldByName('fecha_fin_pac').AsDateTime:= dFechaFin;
      end;
    end;
    QFichaCalidad.Post;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    fecha_ini_pac.Enabled:= False;
    penaliza_productor_pac.Enabled:= false;
    cortar_manojos_pac.Enabled:= False;
    cajas_reutilizables_pac.Enabled:= False;
    color_homogeneo_pac.Enabled:= False;
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
        if QFichaCalidad.FieldByName('fecha_ini_pac').AsDateTime = dFechaIni then
          Break;
        QFichaCalidad.Next;
      end;
    end;
  end;
end;

procedure TFDFichaCalidadProductor.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QFichaCalidad.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    fecha_ini_pac.Enabled:= False;
    penaliza_productor_pac.Enabled:= False;
    cortar_manojos_pac.Enabled:= False;
    cajas_reutilizables_pac.Enabled:= False;
    color_homogeneo_pac.Enabled:= False;
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

procedure TFDFichaCalidadProductor.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QFichaCalidad.IsEmpty then
  begin
    if qFichaCalidad.FieldByName('fecha_fin_pac').AsString = '' then
    begin
      qFichaCalidad.Delete;
      if not qFichaCalidad.IsEmpty then
      begin
        qFichaCalidad.Edit;
        qFichaCalidad.FieldByName('fecha_fin_pac').AsString:= '';
        qFichaCalidad.Post;
      end;
    end
    else
    begin
      qFichaCalidad.Delete;
      dIniAux:=  qFichaCalidad.FieldByName('fecha_ini_pac').AsDateTime;
      qFichaCalidad.Prior;
      if dIniAux <> qFichaCalidad.FieldByName('fecha_ini_pac').AsDateTime then
      begin
        qFichaCalidad.Edit;
        qFichaCalidad.FieldByName('fecha_fin_pac').AsDateTime:= dIniAux - 1;
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

procedure TFDFichaCalidadProductor.empresa_pacChange(Sender: TObject);
begin
  stPlanta.Caption:= desEmpresa( empresa_pac.Text );
end;

procedure TFDFichaCalidadProductor.proveedor_pacChange(Sender: TObject);
begin
  stProveedor.Caption:= desProveedor( empresa_pac.Text, proveedor_pac.Text );
end;

procedure TFDFichaCalidadProductor.almacen_pacChange(Sender: TObject);
begin
  stProductor.Caption:= desProveedorAlmacen( empresa_pac.Text, proveedor_pac.Text, almacen_pac.Text );
end;

function TFDFichaCalidadProductor.ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  QFichaCalidadAux.Open;
  try
    if not QFichaCalidadAux.IsEmpty then
    begin
      while ( QFichaCalidadAux.FieldByName('fecha_ini_pac').AsDateTime < VFechaFin ) and
            ( not QFichaCalidadAux.Eof ) do
      begin
        bAnt:= True;
        QFichaCalidadAux.Next;
      end;
      if QFichaCalidadAux.FieldByName('fecha_ini_pac').AsDateTime <> VFechaFin then
      begin
        if QFichaCalidadAux.Eof then
        begin
          //Estoy en
          QFichaCalidadAux.Edit;
          QFichaCalidadAux.FieldByName('fecha_fin_pac').AsDateTime:= VFechaFin - 1;
          QFichaCalidadAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QFichaCalidadAux.Prior;
            QFichaCalidadAux.Edit;
            QFichaCalidadAux.FieldByName('fecha_fin_pac').AsDateTime:= VFechaFin - 1;
            QFichaCalidadAux.Post;
            QFichaCalidadAux.Next;
          end;
          //Hay siguiente
          if not QFichaCalidadAux.Eof then
          begin
            VFechaFin:= QFichaCalidadAux.FieldByName('fecha_ini_pac').AsDateTime - 1;
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


