unit EnvasesSinCosteEnvasadoReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQREnvasesSinCosteEnvasado = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    lblPeriodo: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    codigo: TQRExpr;
    QRGroup1: TQRGroup;
    PsQRExpr2: TQRExpr;
    descripcion: TQRExpr;
    coste: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    lblCentro: TQRLabel;
    QRMarca: TQRShape;
    secciones: TQRExpr;
    QRLabel1: TQRLabel;
    qrxGeneral: TQRExpr;
    qrlGeneral: TQRLabel;
    qrlTotal: TQRLabel;
    qrxTotal: TQRExpr;
    procedure PsQRExpr5Print(sender: TObject; var Value: string);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure costePrint(sender: TObject; var Value: string);
    procedure descripcionPrint(sender: TObject; var Value: string);
    procedure seccionesPrint(sender: TObject; var Value: String);
    procedure qrxGeneralPrint(sender: TObject; var Value: String);
    procedure qrxTotalPrint(sender: TObject; var Value: String);
  private

  public
    Empresa: string;
  end;

procedure QREnvasesSinCostePrint(const AEmpresa, ACentro, AProducto: string; const AAnyo, AMes: Integer );

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMAuxDB, Dialogs,
     bTimeUtils, Variants, EnvasesSinCosteEnvasadoData;

procedure QREnvasesSinCostePrint(const AEmpresa, ACentro, AProducto: string; const AAnyo, AMes: Integer );
var
  QREnvasesSinCosteEnvasado: TQREnvasesSinCosteEnvasado;
  DMEnvasesSinCosteEnvasado: TDMEnvasesSinCosteEnvasado;
begin
  try
    DMEnvasesSinCosteEnvasado:= TDMEnvasesSinCosteEnvasado.Create( nil );
    //if DMEnvasesSinCosteEnvasado.QREnvasesSinCosteData( AEmpresa, ACentro, AProducto, AAnyo, AMes ) then
    begin
      QREnvasesSinCosteEnvasado := TQREnvasesSinCosteEnvasado.Create(nil);
      PonLogoGrupoBonnysa(QREnvasesSinCosteEnvasado, AEmpresa);
      QREnvasesSinCosteEnvasado.Empresa := AEmpresa;
      QREnvasesSinCosteEnvasado.lblPeriodo.Caption := IntToStr( AMes ) + ' (' + desMes(AMes) + ') de ' + IntToStr( AAnyo );
      QREnvasesSinCosteEnvasado.lblCentro.Caption := desCentro(AEmpresa, ACentro);
      Preview(QREnvasesSinCosteEnvasado);
    end;
    (*
    else
    begin
      ShowMessage('Listado sin datos.');
    end;
    *)
  finally
    //DMEnvasesSinCosteEnvasado.CloseData;
    FreeAndNil( DMEnvasesSinCosteEnvasado );
  end;
end;

procedure TQREnvasesSinCosteEnvasado.PsQRExpr5Print(sender: TObject;
  var Value: string);
begin
  Value := desProductoBase(Empresa, Value);
end;

procedure TQREnvasesSinCosteEnvasado.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if ( ( DataSet.FieldByName('material').Value = NULL ) and
       ( DataSet.FieldByName('personal').Value = NULL ) and
       ( DataSet.FieldByName('general').Value = NULL ) ) then
  begin
    codigo.Font.Style := codigo.Font.Style + [fsItalic];
    descripcion.Font.Style := codigo.Font.Style + [fsItalic];
    coste.Font.Style := codigo.Font.Style + [fsItalic];
    secciones.Font.Style := codigo.Font.Style + [fsItalic];
    QRMarca.Enabled:= True;
  end
  else
  begin
    codigo.Font.Style := codigo.Font.Style - [fsItalic];
    descripcion.Font.Style := codigo.Font.Style - [fsItalic];
    coste.Font.Style := codigo.Font.Style - [fsItalic];
    Self.Font.Style := codigo.Font.Style - [fsItalic];
    QRMarca.Enabled:= False;
  end;
end;

procedure TQREnvasesSinCosteEnvasado.costePrint(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('material').Value = NULL then
    Value := '';
end;

procedure TQREnvasesSinCosteEnvasado.seccionesPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('personal').Value = NULL then
    Value := '';
end;

procedure TQREnvasesSinCosteEnvasado.descripcionPrint(sender: TObject;
  var Value: string);
begin

  Value := Trim(desEnvasePBase(Empresa, value, DataSet.FieldByName('producto_base_p').AsString));
end;

procedure TQREnvasesSinCosteEnvasado.qrxGeneralPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('general').Value = NULL then
    Value := '';
end;

procedure TQREnvasesSinCosteEnvasado.qrxTotalPrint(sender: TObject;
  var Value: String);
begin
  if ( DataSet.FieldByName('material').Value = NULL ) and
     ( DataSet.FieldByName('personal').Value = NULL ) and
     ( DataSet.FieldByName('general').Value = NULL ) then
    Value := '';
end;

end.
