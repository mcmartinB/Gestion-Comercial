unit CFLIntrastat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Provider, DB, DBClient, DBTables, Grids,
  DBGrids, EnvasesFOBData, ActnList, ComCtrls, BCalendario, BGrid, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, nbEdits, nbCombos, nbButtons,
  ExtCtrls;

type
  TFLIntrastat = class(TForm)
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Desde: TLabel;
    Label14: TLabel;
    STEmpresa: TStaticText;
    STProducto: TStaticText;
    empresa: TnbDBSQLCombo;
    producto: TnbDBSQLCombo;
    fechaDesde: TnbDBCalendarCombo;
    fechaHasta: TnbDBCalendarCombo;
    lbl1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    function productoGetSQL: string;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
  private
    { Private declarations }
    DMEnvasesFOBData: TDMEnvasesFOBData;

    procedure Previsualizar;
    function  ParametrosOK: boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CQLIntrastat, UDMConfig, DPreview, Principal, CVariables, CGestionPrincipal,
     UDMAuxDB, CReportes, bTimeUtils, CDMTablaFOB;

procedure TFLIntrastat.FormCreate(Sender: TObject);
var
  iYear, iMonth, iDay: Word;
  dAux: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;
  DMEnvasesFOBData := TDMEnvasesFOBData.Create(self);

  empresa.Text := 'BAG';
  producto.Text := '';
  DecodeDate( Date, iYear, iMonth, iDay );
  dAux:= EncodeDate( iYear, iMonth, 1 );
  fechaDesde.AsDate := IncMonth( dAux, -1 );
  fechaHasta.AsDate := dAux - 1;
end;

procedure TFLIntrastat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');

  //Liberamos memoria
  FreeAndNil(DMEnvasesFOBData);
  Action := caFree;
end;

function TFLIntrastat.ParametrosOK: boolean;
var
  dIni, dFin: TDateTime;
begin
  result:= false;
  if STEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto');
    empresa.SetFocus;
  end
  else
  if STProducto.Caption = '' then
  begin
    ShowMessage('El código del producto es incorrecto');
    producto.SetFocus;
  end
  else
  if not TryStrToDate( fechaDesde.Text, dIni ) then
  begin
    ShowMessage('La fecha de inicio es incorrecta');
    fechaDesde.SetFocus;
  end
  else
  if not TryStrToDate( fechaHasta.Text, dFin ) then
  begin
    ShowMessage('La fecha de fin es incorrecta');
    fechaHasta.SetFocus;
  end
  else
  if dIni > dFin then
  begin
    ShowMessage('Rango de fechas incorrecto');
    fechaDesde.SetFocus;
  end
  else
  begin
    result:= TRue;
  end;
end;

procedure TFLIntrastat.btnOkClick(Sender: TObject);
var
  DMTablaFOB: TDMTablaFOB;
begin
  if ParametrosOK then
  begin
    try
      DMTablaFOB:= TDMTablaFOB.Create( Self );
      if DMTablaFOB.ObtenerDatos( empresa.Text, '', '', fechaDesde.Text, fechaHasta.Text, '', '', producto.Text, 'EXTRANJERO','',
                                1, 1, -1, false ) then
      begin
        DMTablaFOB.ListadoIntrastat;
        Previsualizar;
      end
      else
      begin
        ShowMessage('Sin Datos.');
      end;
    finally
      FreeAndNil( DMTablaFOB );
    end;
  end;
end;

procedure TFLIntrastat.Previsualizar;
var
  QLIntrastat: TQLIntrastat;
begin
  QLIntrastat := TQLIntrastat.Create(Application);
  PonLogoGrupoBonnysa(QLIntrastat, empresa.Text);

  if not DMConfig.EsLaFont then
  begin
    QLIntrastat.lblTitulo.Caption:= 'INFORME INTRASTAT';
  end;

  QLIntrastat.sEmpresa := empresa.Text;
  QLIntrastat.LPeriodo.Caption := fechaDesde.Text + ' a ' + fechaHasta.Text;

  Preview(QLIntrastat);
end;

procedure TFLIntrastat.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TFLIntrastat.productoGetSQL: string;
begin
  result := 'select producto_p, descripcion_p from frf_productos order by producto_p ';
end;

procedure TFLIntrastat.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f1 then btnOk.Click else
    if Key = vk_escape then btnCancel.Click;
end;

procedure TFLIntrastat.empresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(empresa.Text);
  productoChange( producto );
end;

procedure TFLIntrastat.productoChange(Sender: TObject);
begin
  if producto.Text = '' then
  begin
    STProducto.Caption := 'TODOS LOS PRODUCTOS.';
  end
  else
  begin
    STProducto.Caption := desProducto(empresa.Text, producto.Text);
  end;
end;

end.
