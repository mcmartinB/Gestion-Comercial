unit QListadoControlEntregasApaisado;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRListadoControlEntregasApaisado = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    termografo: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText11: TQRDBText;
    lblProducto: TQRLabel;
    PsQRLabel1: TQRLabel;
    lblFechas: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    QRSysData1: TQRSysData;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel8: TQRLabel;
    QRExpr1: TQRExpr;
    lblDatosVar: TQRLabel;
    QRDBText9: TQRDBText;
    QRLabel9: TQRLabel;
    QRExpr2: TQRExpr;
    QRLabel10: TQRLabel;
    puerto: TQRDBText;
    nomPuerto: TQRDBText;
    QRLabel11: TQRLabel;
    matricula: TQRDBText;
    QRLabel13: TQRLabel;
    qreProducto: TQRDBText;
    qrlProd: TQRLabel;
    qrenomProveedor: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrepalets: TQRDBText;
    qrlEntrega: TQRLabel;
    qreEntrega: TQRDBText;
    qrl3: TQRLabel;
    qrx1: TQRExpr;
    qrgrpGrupo: TQRGroup;
    qrbndPie: TQRBand;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrlbl1: TQRLabel;
    qrshp1: TQRShape;
    qrlblCrupo: TQRLabel;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure nomPuertoPrint(sender: TObject; var Value: String);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrpGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlblCrupoPrint(sender: TObject; var Value: String);
  private
    iAgrupar: integer;
  public
    procedure Agrupar( const AAgrupar: integer );

  end;

implementation

{$R *.DFM}

uses DMListadoControlEntregas, UDMauxDB;


procedure TQRListadoControlEntregasApaisado.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fechaCarga').AsDateTime );
end;

procedure TQRListadoControlEntregasApaisado.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fechaLlegada').AsDateTime );
end;

procedure TQRListadoControlEntregasApaisado.nomPuertoPrint(sender: TObject;
  var Value: String);
begin
  Value:= desAduana( Value );
end;

procedure TQRListadoControlEntregasApaisado.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRListadoControlEntregasApaisado.Agrupar( const AAgrupar:integer );
begin
  iAgrupar:= AAgrupar;
    if iAgrupar = 1 then
    begin
      qrgrpGrupo.Expression:= '[codProveedor] + [codAlmacen]';
    end
    else
    if iAgrupar = 2 then
    begin
      qrgrpGrupo.Expression:= '[producto]';
    end;
end;

procedure TQRListadoControlEntregasApaisado.qrgrpGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= ( iAgrupar > 0 ) and not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRListadoControlEntregasApaisado.qrlblCrupoPrint(
  sender: TObject; var Value: String);
begin
  if ( iAgrupar > 0 ) and not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    if iAgrupar = 1 then
    begin
      Value:= desProveedor( DataSet.FieldByName('empresa_ec').AsString, DataSet.FieldByName('codProveedor').AsString ) + ' / ' +
              desProveedorAlmacen( DataSet.FieldByName('empresa_ec').AsString, DataSet.FieldByName('codProveedor').AsString, DataSet.FieldByName('codAlmacen').AsString );
    end
    else
    if iAgrupar = 2 then
    begin
      Value:= DesProducto( DataSet.FieldByName('empresa_ec').AsString, DataSet.FieldByName('producto').AsString )
    end;
  end;
end;

end.
