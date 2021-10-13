unit PaletsVolcadosEntregaFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits;

type
  TFLPaletsVolcadosEntrega = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    stEmpresa: TLabel;
    stCentro: TLabel;
    empresa: TnbDBSQLCombo;
    centro: TnbDBSQLCombo;
    Label1: TLabel;
    Label2: TLabel;
    fechaIni: TnbDBCalendarCombo;
    nbLabel1: TnbLabel;
    nbLabel3: TnbLabel;
    producto: TnbDBSQLCombo;
    stProducto: TLabel;
    fechaFin: TnbDBCalendarCombo;
    nbLabel4: TnbLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function productoGetSQL: String;
    function centroGetSQL: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
  private
    { Private declarations }
    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB, DPreview,
     UDMBaseDatos, UDMConfig, StockFrutaPlantaQL, StockFrutaPlantaMasetNormalQL;

procedure TFLPaletsVolcadosEntrega.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  empresa.Text:= gsDefEmpresa;
  centro.Text:= gsDefCentro;
  fechaIni.Text:= DateToStr( Date );
  fechaFin.Text:= DateToStr( Date );
end;

procedure TFLPaletsVolcadosEntrega.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLPaletsVolcadosEntrega.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLPaletsVolcadosEntrega.ValidarCampos;
var
  dIni, dFin: TDateTime;
begin
  if Trim(empresa.Text) = '' then
  begin
    empresa.SetFocus;
    raise Exception.Create('Falta el codigo de la empresa que es de obligada inserción.');
  end;

  if Trim(centro.Text) = '' then
  begin
    centro.SetFocus;
    raise Exception.Create('Falta el codigo del centro que es de obligada inserción.');
  end;

  if not TryStrToDateTime( fechaini.Text, dIni ) then
  begin
    fechaini.SetFocus;
    raise Exception.Create('Falta la fecha de inicio o es incorrecta.');
  end;
  if not TryStrToDateTime( fechaFin.Text, dFin ) then
  begin
    fechaFin.SetFocus;
    raise Exception.Create('Falta la fecha de fin o es incorrecta.');
  end;
  if dIni > dFin then
  begin
    fechaini.SetFocus;
    raise Exception.Create('Rango de fechas incorrecto.');
  end;
end;


procedure TFLPaletsVolcadosEntrega.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;

  if DMConfig.EsMaset then
  begin
    if not StockFrutaPlantaMasetNormalQL.VerListadoVolcados( self, Trim(empresa.Text), Trim(centro.Text), Trim(producto.Text), fechaIni.AsDate, fechaFin.AsDate ) then
      ShowMEssage('Sin datos para los parametros usados.');
  end
  else
  begin
    if not StockFrutaPlantaQL.VerListadoVolcados( self, Trim(empresa.Text), Trim(centro.Text), Trim(producto.Text), fechaIni.AsDate, fechaFin.AsDate ) then
      ShowMEssage('Sin datos para los parametros usados.');
  end;
end;

function TFLPaletsVolcadosEntrega.productoGetSQL: String;
begin
  result:= 'select producto_p, descripcion_p from frf_productos order by producto_p';
end;



function TFLPaletsVolcadosEntrega.centroGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             Empresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

procedure TFLPaletsVolcadosEntrega.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLPaletsVolcadosEntrega.empresaChange(Sender: TObject);
begin
  if Trim(empresa.Text) = '' then
  begin
    stEmpresa.Caption:= '(Falta código de la empresa)';
  end
  else
  begin
    stEmpresa.Caption:= desEmpresa( empresa.Text );
  end;

  centroChange( centro );
end;

procedure TFLPaletsVolcadosEntrega.centroChange(Sender: TObject);
begin
  if Trim(centro.Text) = '' then
  begin
    stCentro.Caption:= '(Falta código del centro)';
  end
  else
  begin
    stCentro.Caption:= desCentro( empresa.Text, centro.Text );
  end;
end;

procedure TFLPaletsVolcadosEntrega.productoChange(Sender: TObject);
begin
  if Trim(producto.Text) = '' then
  begin
    stProducto.Caption:= '(Vacio = Todos los productos)';
  end
  else
  begin
    stProducto.Caption:= desProducto( empresa.Text, producto.Text );
  end;
end;

end.
