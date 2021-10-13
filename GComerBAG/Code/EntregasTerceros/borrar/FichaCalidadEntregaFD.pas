unit FichaCalidadEntregaFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB,
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit;

type
  TFDFichaCalidadEntrega = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel3: TnbLabel;
    nbLabel5: TnbLabel;
    DSFichaCalidad: TDataSource;
    cortar_manojos_efc: TDBCheckBox;
    lblCajasReutilizables: TnbLabel;
    cajas_reutilizables_efc: TDBCheckBox;
    lblColorHomogeneo: TnbLabel;
    color_homogeneo_efc: TDBCheckBox;
    lblManojos: TLabel;
    lblCajas: TLabel;
    lblColor: TLabel;
    QFichaCalidad: TQuery;
    codigo_efc: TBDEdit;
    QFichaProductor: TQuery;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure cortar_manojos_efcClick(Sender: TObject);
    procedure cajas_reutilizables_efcClick(Sender: TObject);
    procedure color_homogeneo_efcClick(Sender: TObject);
  private
    { Private declarations }
    sEntrega: String;

    bManojos, bCajas, bColor: boolean;
    rManojos, rCajas, rColor: real;

  public
    { Public declarations }
    procedure LoadValues( const AEntrega: string );
    function LoadImportes( const AEmpresa, APlanta, ACentro, AProveedor, AProductor: string; const AFecha: TDateTime): boolean;

  end;

  procedure ExecuteFichaCalidadProductor( const AOwner: TComponent; const AEntrega: string;
                                          const AEmpresa, APlanta, ACentro, AProveedor, AProductor: string; const AFecha: TDateTime);

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB;

var
  FDFichaCalidadEntrega: TFDFichaCalidadEntrega;

procedure ExecuteFichaCalidadProductor( const AOwner: TComponent; const AEntrega: string;
                                          const AEmpresa, APlanta, ACentro, AProveedor, AProductor: string; const AFecha: TDateTime);
begin
  FDFichaCalidadEntrega:= TFDFichaCalidadEntrega.Create( AOwner );
  try
    if not FDFichaCalidadEntrega.LoadImportes( AEmpresa, APlanta, ACentro, AProveedor, AProductor, AFecha ) then
    begin
      ShowMessage('Falta grabar la ficha de calidad del productor.')
    end;
    FDFichaCalidadEntrega.LoadValues( AEntrega );
    FDFichaCalidadEntrega.ShowModal;
  finally
    FreeAndNil(FDFichaCalidadEntrega );
  end;
end;

procedure TFDFichaCalidadEntrega.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QFichaCalidad.Close;
  Action:= caFree;
end;

procedure TFDFichaCalidadEntrega.FormKeyDown(Sender: TObject; var Key: Word;
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
  end;
end;

function TFDFichaCalidadEntrega.LoadImportes( const AEmpresa, APlanta, ACentro, AProveedor, AProductor: string; const AFecha: TDateTime): boolean;
begin
  //Valores por defecto
  with QFichaProductor do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_proveedores_almacen_calidad ');
    SQL.Add(' where empresa_pac = :empresa ');
    SQL.Add(' and proveedor_pac = :proveedor ');
    SQL.Add(' and almacen_pac = :productor ');
    SQL.Add(' and :fecha between fecha_ini_pac and nvl( fecha_fin_pac, today ) ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('proveedor').AsString:= AProveedor;
    ParamByName('productor').AsInteger:= StrToInt( AProductor );
    ParamByName('fecha').AsDateTime:= AFecha;

    Open;
    if IsEmpty then
    begin
      bManojos:= false;
      bCajas:= false;
      bColor:= false;
    end
    else
    begin
      bManojos:= FieldByname('cortar_manojos_pac').AsInteger = 1;
      bCajas:= FieldByname('cajas_reutilizables_pac').AsInteger = 1;
      bColor:= FieldByname('color_homogeneo_pac').AsInteger = 1;
    end;
    Close;
  end;

  //importes penalizacion
  with QFichaProductor do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_penalizacion_calidad ');
    SQL.Add(' where empresa_pc = :empresa ');
    SQL.Add(' and planta_pc = :planta ');
    SQL.Add(' and centro_pc = :centro ');
    SQL.Add(' and :fecha between fecha_ini_pc and nvl( fecha_fin_pc, today ) ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('planta').AsString:= APlanta;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;

    Open;
    if IsEmpty then
    begin
      result:= False;
      rManojos:= 0;
      rCajas:= 0;
      rColor:= 0;
    end
    else
    begin
      result:= True;
      rManojos:= FieldByname('cortar_manojos_pc').AsFloat;
      rCajas:= FieldByname('cajas_reutilizables_pc').AsFloat;
      rColor:= FieldByname('color_homogeneo_pc').AsFloat;
    end;
    Close;
  end;
end;

procedure TFDFichaCalidadEntrega.LoadValues( const AEntrega: string );
begin
  sEntrega:= AEntrega;

  with QFichaCalidad do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entregas_ficha_calidad ');
    SQL.Add(' where codigo_efc = :entrega ');
    ParamByName('entrega').AsString:= AEntrega;
    Open;

    if IsEmpty then
    begin
      Insert;
      codigo_efc.Text:= AEntrega;
      FieldByName('codigo_efc').AsString:= AEntrega;
      if bManojos then
        FieldByName('cortar_manojos_efc').AsInteger:= 1
      else
        FieldByName('cortar_manojos_efc').AsInteger:= 0;
      if bCajas then
        FieldByName('cajas_reutilizables_efc').AsInteger:= 1
      else
        FieldByName('cajas_reutilizables_efc').AsInteger:= 0;
      if bColor then
        FieldByName('color_homogeneo_efc').AsInteger:= 1
      else
        FieldByName('color_homogeneo_efc').AsInteger:= 0;

      cortar_manojos_efc.OnClick( cortar_manojos_efc );
      cajas_reutilizables_efc.OnClick( cajas_reutilizables_efc );
      color_homogeneo_efc.OnClick( color_homogeneo_efc );
    end
    else
    begin
      Edit;
    end;
  end;
end;

procedure TFDFichaCalidadEntrega.btnAceptarClick(Sender: TObject);
begin
  QFichaCalidad.Post;
  ShowMessage('Cambios grabados');
  Close;
end;

procedure TFDFichaCalidadEntrega.btnCancelarClick(Sender: TObject);
begin
  QFichaCalidad.Cancel;
  ShowMessage('Acción cancelada');
  Close;
end;

procedure TFDFichaCalidadEntrega.cortar_manojos_efcClick(
  Sender: TObject);
begin
  if cortar_manojos_efc.Checked then
    lblManojos.Caption:= FormatFloat( '0.000', rManojos ) + ' Eur/kg'
  else
    lblManojos.Caption:= '0.000 Eur/kg';
end;

procedure TFDFichaCalidadEntrega.cajas_reutilizables_efcClick(
  Sender: TObject);
begin
  if cajas_reutilizables_efc.Checked then
    lblCajas.Caption:= FormatFloat( '0.000', rCajas ) + ' Eur/kg'
  else
    lblCajas.Caption:= '0.000 Eur/kg';
end;

procedure TFDFichaCalidadEntrega.color_homogeneo_efcClick(
  Sender: TObject);
begin
  if color_homogeneo_efc.Checked then
    lblColor.Caption:= FormatFloat( '0.000', rColor ) + ' Eur/kg'
  else
    lblColor.Caption:= '0.000 Eur/kg';
end;

end.


