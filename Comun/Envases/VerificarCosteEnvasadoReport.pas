unit VerificarCosteEnvasadoReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRVerificarCosteEnvasado = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    lblPeriodo: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    codigo: TQRExpr;
    QRGroup1: TQRGroup;
    descripcion: TQRExpr;
    envasado: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    lblCentro: TQRLabel;
    QRMarca: TQRShape;
    secciones: TQRExpr;
    QRLabel1: TQRLabel;
    qrlbl1: TQRLabel;
    material: TQRExpr;
    qrxpr1: TQRExpr;
    qrlbl2: TQRLabel;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    procedure PsQRExpr5Print(sender: TObject; var Value: string);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure envasadoPrint(sender: TObject; var Value: string);
    procedure descripcionPrint(sender: TObject; var Value: string);
    procedure seccionesPrint(sender: TObject; var Value: String);
    procedure materialPrint(sender: TObject; var Value: String);
  private

  public
    iTipoCoste: integer;
    Empresa: string;
  end;

procedure QRVerificarCosteEnvasadoPrint(const AEmpresa, ACentro, AAnyo, AMes: string;
                                        const ATipoCoste: integer );

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMAuxDB, Dialogs,
  bTimeUtils, Variants, VerificarCosteEnvasadoData;


procedure QRVerificarCosteEnvasadoPrint(const AEmpresa, ACentro, AAnyo, AMes: string;
                                        const ATipoCoste: integer );
var
  QRVerificarCosteEnvasado: TQRVerificarCosteEnvasado;
begin
  QRVerificarCosteEnvasado := TQRVerificarCosteEnvasado.Create(nil);
  PonLogoGrupoBonnysa(QRVerificarCosteEnvasado, AEmpresa);
  QRVerificarCosteEnvasado.Empresa := AEmpresa;
  QRVerificarCosteEnvasado.iTipoCoste := ATipoCoste;
  QRVerificarCosteEnvasado.lblPeriodo.Caption :=
    AMes + ' (' + desMes(AMes) + ') de ' + AAnyo;
  QRVerificarCosteEnvasado.lblCentro.Caption := 'SALIDA: ' + desCentro(AEmpresa, ACentro);
  Preview(QRVerificarCosteEnvasado);
end;

procedure TQRVerificarCosteEnvasado.PsQRExpr5Print(sender: TObject;
  var Value: string);
begin
  Value := desProducto(Empresa, Value);
end;

procedure TQRVerificarCosteEnvasado.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if ( ( DataSet.FieldByName('envasado').Value = NULL ) and ( ( iTipoCoste = 0 ) or ( iTipoCoste = 1 ) ) ) or
     ( ( DataSet.FieldByName('material').Value = NULL ) and ( ( iTipoCoste = 0 ) or ( iTipoCoste = 2 ) ) ) or
     ( ( DataSet.FieldByName('secciones').Value = NULL ) and ( ( iTipoCoste = 0 ) or ( iTipoCoste = 3 ) ) ) then
  begin
    codigo.Font.Style := codigo.Font.Style + [fsItalic];
    descripcion.Font.Style := codigo.Font.Style + [fsItalic];
    envasado.Font.Style := codigo.Font.Style + [fsItalic];
    material.Font.Style := codigo.Font.Style + [fsItalic];
    secciones.Font.Style := codigo.Font.Style + [fsItalic];
    QRMarca.Enabled:= True;
  end
  else
  begin
    codigo.Font.Style := codigo.Font.Style - [fsItalic];
    descripcion.Font.Style := codigo.Font.Style - [fsItalic];
    envasado.Font.Style := codigo.Font.Style - [fsItalic];
    material.Font.Style := codigo.Font.Style - [fsItalic];
    secciones.Font.Style := codigo.Font.Style - [fsItalic];
    QRMarca.Enabled:= False;
  end;
end;

procedure TQRVerificarCosteEnvasado.envasadoPrint(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('envasado').Value = NULL then
    Value := '';
end;

procedure TQRVerificarCosteEnvasado.materialPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('material').Value = NULL then
    Value := '';
end;

procedure TQRVerificarCosteEnvasado.seccionesPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('secciones').Value = NULL then
    Value := '';
end;

procedure TQRVerificarCosteEnvasado.descripcionPrint(sender: TObject;
  var Value: string);
begin
  Value := Trim(desEnvase(Empresa, value));
end;

end.
