unit CostesAgrupaProductoFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB, 
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit, BGrid,
  BSpeedButton, BGridButton;
                                                
type
  TFDCostesAgrupaProducto = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    fecha_ini_cap: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    dsCostes: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    fecha_fin_cap: TnbDBCalendarCombo;
    qryCostes: TQuery;
    btnModificar: TSpeedButton;
    empresa_cap: TBDEdit;
    lblProductor: TnbLabel;
    lbl1: TnbLabel;
    coste_material_cap: TnbDBNumeric;
    lbl3: TnbLabel;
    qryCostesAux: TQuery;
    agrupacion_cap: TBDEdit;
    coste_directo_cap: TnbDBNumeric;
    coste_seccion_cap: TnbDBNumeric;
    lbl4: TnbLabel;
    RejillaFlotante: TBGrid;
    btnProducto: TBGridButton;
    txtProducto: TStaticText;
    lblProducto: TnbLabel;
    producto_cap: TBDEdit;
    txtEmpresa: TStaticText;
    btnEmpresa: TBGridButton;
    lblCentro: TnbLabel;
    centro_cap: TBDEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_capChange(Sender: TObject);
    procedure btnProductoClick(Sender: TObject);
    procedure producto_capChange(Sender: TObject);
    procedure btnCentroClick(Sender: TObject);
    procedure centro_capChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sAgrupacion, sCentro, sProducto: String;
    bAlta: boolean;
    dFechaIni: TDateTime;

    function  ValidarValues: boolean;
    function  ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;

  public
    { Public declarations }
    procedure LoadValues( const AAgrupacion, AEmpresa, ACentro, AProducto: string );

  end;

  procedure ExecuteCosteAgrupacion( const AOwner: TComponent; const AAgrupacion, AEmpresa, ACentro, AProducto: string );
  procedure ExecuteCosteProducto( const AOwner: TComponent; const AEmpresa, AProducto, AAgrupacion, ACentro: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB, CAuxiliarDB, SeleccionarCentroProductoFD, SeleccionarCentroAgrupacionFD;

var
  FDCostesAgrupaProducto: TFDCostesAgrupaProducto;

procedure ExecuteCosteAgrupacion( const AOwner: TComponent; const AAgrupacion, AEmpresa, ACentro, AProducto: string );
var
  sEmpresa, sProducto, sCentro: string;
begin
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  sCentro:= ACentro;
  if SeleccionarCentroProducto( sEmpresa, sCentro, sProducto ) then
  begin
    FDCostesAgrupaProducto:= TFDCostesAgrupaProducto.Create( AOwner );
    try
      FDCostesAgrupaProducto.LoadValues( AAgrupacion, sEmpresa, sCentro, sProducto );
      FDCostesAgrupaProducto.ShowModal;
    finally
      FreeAndNil(FDCostesAgrupaProducto );
    end;
  end;
end;

procedure ExecuteCosteProducto( const AOwner: TComponent; const AEmpresa, AProducto, AAgrupacion, ACentro: string );
var
   sEmpresa, sCentro, sAgrupa: string;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sAgrupa:= AAgrupacion;
  if SeleccionarCentroAgrupacion( sEmpresa, sCentro, sAgrupa ) then
  begin
    FDCostesAgrupaProducto:= TFDCostesAgrupaProducto.Create( AOwner );
    try
      FDCostesAgrupaProducto.LoadValues( sAgrupa, AEmpresa, ACentro, AProducto );
      FDCostesAgrupaProducto.ShowModal;
    finally
      FreeAndNil(FDCostesAgrupaProducto );
    end;
  end;
end;

procedure TFDCostesAgrupaProducto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryCostes.Close;
  Action:= caFree;
end;

procedure TFDCostesAgrupaProducto.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDCostesAgrupaProducto.LoadValues( const AAgrupacion, AEmpresa, ACentro, AProducto: string );
begin
  sEmpresa:= AEmpresa;
  sAgrupacion:= AAgrupacion;
  sProducto:= AProducto;
  sCentro:= ACentro;
  bAlta:= False;

  with qryCostes do
  begin
    SQL.Clear;
    SQL.Add(' select agrupacion_cap, empresa_cap, centro_cap, producto_cap, ');
    SQL.Add('   fecha_ini_cap, fecha_fin_cap, ');
    SQL.Add('   coste_directo_cap, coste_material_cap, coste_seccion_cap ');
    SQL.Add(' from frf_costes_agrupa_prod ');
    SQL.Add(' where agrupacion_cap = :agrupacion ');
    SQL.Add(' and empresa_cap = :empresa ');
    SQL.Add(' and producto_cap = :producto ');
    SQL.Add(' and centro_cap = :centro ');
    SQL.Add(' order by fecha_ini_cap  ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('agrupacion').AsString:= AAgrupacion;
    ParamByName('centro').AsString:= ACentro;
    Open;
  end;

  with qryCostesAux do
  begin
    SQL.Clear;
    SQL.AddStrings( qryCostes.SQL );
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('agrupacion').AsString:= AAgrupacion;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('centro').AsString:= ACentro;
  end;
end;


function TFDCostesAgrupaProducto.ValidarValues: boolean;
begin
  if TryStrToDate( fecha_ini_cap.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_cap.SetFocus;
    ValidarValues:= False;
  end;
  if coste_directo_cap.Text = '' then
  begin
    qryCostes.FieldByName('coste_directo_cap').AsFloat:= 0;
  end;
  if coste_material_cap.Text = '' then
  begin
    qryCostes.FieldByName('coste_material_cap').AsFloat:= 0;
  end;
  if coste_seccion_cap.Text = '' then
  begin
    qryCostes.FieldByName('coste_seccion_cap').AsFloat:= 0;
  end;
end;

procedure TFDCostesAgrupaProducto.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  qryCostes.Insert;

  empresa_cap.Text:= sEmpresa;
  agrupacion_cap.Text:= sAgrupacion;
  fecha_ini_cap.Text:= DateToStr( date );


  qryCostes.FieldByName('empresa_cap').AsString:= sEmpresa;
  qryCostes.FieldByName('agrupacion_cap').AsString:= sAgrupacion;
  qryCostes.FieldByName('producto_cap').AsString:= sProducto;
  qryCostes.FieldByName('centro_cap').AsString:= sCentro;
  qryCostes.FieldByName('coste_material_cap').AsInteger:= 0;
  qryCostes.FieldByName('coste_directo_cap').AsInteger:= 0;
  qryCostes.FieldByName('coste_seccion_cap').AsInteger:= 0;
  qryCostes.FieldByName('fecha_ini_cap').AsDateTime:= Date;

  fecha_ini_cap.Enabled:= True;
  coste_material_cap.Enabled:= True;
  coste_directo_cap.Enabled:= True;
  coste_seccion_cap.Enabled:= True;
  DBGrid.Enabled:= False;

  fecha_ini_cap.SetFocus;
end;

procedure TFDCostesAgrupaProducto.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if qryCostes.IsEmpty then
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

    fecha_ini_cap.Enabled:= False;
    qryCostes.Edit;

    coste_material_cap.Enabled:= True;
    coste_directo_cap.Enabled:= True;
    coste_seccion_cap.Enabled:= True;
    DBGrid.Enabled:= False;

    coste_directo_cap.SetFocus;
  end;
end;

procedure TFDCostesAgrupaProducto.btnAceptarClick(Sender: TObject);
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
        qryCostes.FieldByName('fecha_fin_cap').AsDateTime:= dFechaFin;
      end;
    end;
    qryCostes.Post;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    fecha_ini_cap.Enabled:= False;
    coste_material_cap.Enabled:= false;
    coste_directo_cap.Enabled:= False;
    coste_seccion_cap.Enabled:= false;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      qryCostes.Close;
      qryCostes.Open;
      while not qryCostes.Eof do
      begin
        if qryCostes.FieldByName('fecha_ini_cap').AsDateTime = dFechaIni then
          Break;
        qryCostes.Next;
      end;
    end;
  end;
end;

procedure TFDCostesAgrupaProducto.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    qryCostes.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    fecha_ini_cap.Enabled:= False;
    coste_material_cap.Enabled:= false;
    coste_directo_cap.Enabled:= False;
    coste_seccion_cap.Enabled:= false;
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

procedure TFDCostesAgrupaProducto.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not qryCostes.IsEmpty then
  begin
    if qryCostes.FieldByName('fecha_fin_cap').AsString = '' then
    begin
      qryCostes.Delete;
      if not qryCostes.IsEmpty then
      begin
        qryCostes.Edit;
        qryCostes.FieldByName('fecha_fin_cap').AsString:= '';
        qryCostes.Post;
      end;
    end
    else
    begin
      qryCostes.Delete;
      dIniAux:=  qryCostes.FieldByName('fecha_ini_cap').AsDateTime;
      qryCostes.Prior;
      if dIniAux <> qryCostes.FieldByName('fecha_ini_cap').AsDateTime then
      begin
        qryCostes.Edit;
        qryCostes.FieldByName('fecha_fin_cap').AsDateTime:= dIniAux - 1;
        qryCostes.Post;
      end;
    end;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDCostesAgrupaProducto.empresa_capChange(Sender: TObject);
begin
  txtEmpresa.Caption:= desEmpresa( empresa_cap.Text );
  producto_capChange(producto_cap);
  centro_capChange(centro_cap);
end;

function TFDCostesAgrupaProducto.ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  qryCostesAux.Open;
  try
    if not qryCostesAux.IsEmpty then
    begin
      while ( qryCostesAux.FieldByName('fecha_ini_cap').AsDateTime < VFechaFin ) and
            ( not qryCostesAux.Eof ) do
      begin
        bAnt:= True;
        qryCostesAux.Next;
      end;
      if qryCostesAux.FieldByName('fecha_ini_cap').AsDateTime <> VFechaFin then
      begin
        if qryCostesAux.Eof then
        begin
          //Estoy en
          qryCostesAux.Edit;
          qryCostesAux.FieldByName('fecha_fin_cap').AsDateTime:= VFechaFin - 1;
          qryCostesAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            qryCostesAux.Prior;
            qryCostesAux.Edit;
            qryCostesAux.FieldByName('fecha_fin_cap').AsDateTime:= VFechaFin - 1;
            qryCostesAux.Post;
            qryCostesAux.Next;
          end;
          //Hay siguiente
          if not qryCostesAux.Eof then
          begin
            VFechaFin:= qryCostesAux.FieldByName('fecha_ini_cap').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    qryCostesAux.Close;
  end;
end;

procedure TFDCostesAgrupaProducto.btnProductoClick(Sender: TObject);
begin
  DespliegaRejilla(btnProducto, [empresa_cap.Text] );
end;

procedure TFDCostesAgrupaProducto.producto_capChange(Sender: TObject);
begin
  txtProducto.Caption:= desProducto(empresa_cap.Text, producto_cap.Text );
end;

procedure TFDCostesAgrupaProducto.btnCentroClick(Sender: TObject);
begin
  DespliegaRejilla(btnCentro, [empresa_cap.Text] );
end;

procedure TFDCostesAgrupaProducto.centro_capChange(Sender: TObject);
begin
  txtCentro.Caption:= desCentro(empresa_cap.Text, centro_cap.Text );
end;

end.


