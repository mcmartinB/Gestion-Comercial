unit VerificarSobrepesoEnvasadoReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRVerificarSobrepesoEnvasado = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    periodo: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    codigo: TQRExpr;
    QRGroup1: TQRGroup;
    PsQRExpr2: TQRExpr;
    descripcion: TQRExpr;
    sobrepeso: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    QRMarca: TQRShape;
    procedure periodo2Print(sender: TObject; var Value: string);
    procedure PsQRExpr5Print(sender: TObject; var Value: string);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure sobrepesoPrint(sender: TObject; var Value: String);
  private

  public
    Empresa: string;
  end;

procedure QRVerificarSobrepesoEnvasadoPrint(const AEmpresa, AAnyo, AMes: string);

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants;

function PreparaQuery(const AEmpresa, AAnyo, AMes: string): Boolean;
begin
  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    SQL.Add(' select distinct producto_p, envase_sl, ');
    SQL.Add('        (select descripcion_e ');
    SQL.Add('         from frf_envases ');
    SQL.Add('         where envase_e = envase_sl) descripcion, ');
    SQL.Add('        (select peso_es ');
    SQL.Add('         from frf_env_sobrepeso ');
    SQL.Add('         where anyo_es ' + SQLEqualN(AAnyo));
    SQL.Add('         and mes_es ' + SQLEqualN(AMes));
    SQL.Add('         and empresa_es ' + SQLEqualS(AEmpresa));
    SQL.Add('         and producto_es = producto_p ');
    SQL.Add('         and envase_es = envase_sl) sobrepeso ');
    SQL.Add(' from   frf_salidas_l, frf_productos ');
    SQL.Add(' where empresa_sl ' + SQLEqualS(AEmpresa));
    SQL.Add(' and YEAR(fecha_sl) ' + SQLEqualN(AAnyo));
    SQL.Add(' and MONTH(fecha_sl) ' + SQLEqualN(AMes));
    SQL.Add(' and producto_p = producto_sl ');
    SQL.Add(' order by 1,2,3 ');

    Open;
    result := not IsEmpty;
    if not Result then Close
  end;
end;

procedure QRVerificarSobrepesoEnvasadoPrint(const AEmpresa, AAnyo, AMes: string);
var
  QRVerificarSobrepesoEnvasado: TQRVerificarSobrepesoEnvasado;
begin
  if PreparaQuery(AEmpresa, AAnyo, AMes) then
  begin
    QRVerificarSobrepesoEnvasado := TQRVerificarSobrepesoEnvasado.Create(nil);
    PonLogoGrupoBonnysa(QRVerificarSobrepesoEnvasado, AEmpresa);
    QRVerificarSobrepesoEnvasado.Empresa := AEmpresa;
    QRVerificarSobrepesoEnvasado.periodo.Caption :=
      AMes + ' (' + desMes(AMes) + ') de ' + AAnyo;
    Preview(QRVerificarSobrepesoEnvasado);
    DMBaseDatos.QListado.Close;
  end
  else
  begin
    ShowMessage('Listado sin datos.');
  end;
end;

procedure TQRVerificarSobrepesoEnvasado.periodo2Print(sender: TObject;
  var Value: string);
begin
  Value := periodo.Caption;
end;

procedure TQRVerificarSobrepesoEnvasado.PsQRExpr5Print(sender: TObject;
  var Value: string);
begin
  Value := desProducto(Empresa, Value);
end;

procedure TQRVerificarSobrepesoEnvasado.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if DMBaseDatos.QListado.FieldByName('sobrepeso').Value = NULL then
  begin
    codigo.Font.Style := codigo.Font.Style + [fsItalic];
    descripcion.Font.Style := codigo.Font.Style + [fsItalic];
    sobrepeso.Font.Style := codigo.Font.Style + [fsItalic];
    QRMarca.Enabled:= True;
  end
  else
  begin
    codigo.Font.Style := codigo.Font.Style - [fsItalic];
    descripcion.Font.Style := codigo.Font.Style - [fsItalic];
    sobrepeso.Font.Style := codigo.Font.Style - [fsItalic];
    QRMarca.Enabled:= False;
  end;
end;

procedure TQRVerificarSobrepesoEnvasado.sobrepesoPrint(sender: TObject;
  var Value: String);
begin
  if DMBaseDatos.QListado.FieldByName('sobrepeso').Value = NULL then
  begin
    Value:= '';
  end;
end;

end.
