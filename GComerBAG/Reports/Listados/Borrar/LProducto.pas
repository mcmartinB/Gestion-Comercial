unit LProducto;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, db,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLProducto = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    fecha: TQRSysData;
    bandaProducto: TQRBand;
    empresa_p: TQRDBText;
    producto_p: TQRDBText;
    bandaTituloProducto: TQRBand;
    LEmpresa: TQRLabel;
    LProducto: TQRLabel;
    estomate_p: TQRDBText;
    LTomate: TQRLabel;
    calibre_c: TQRLabel;
    cabeceraSubDetalle: TQRBand;
    LCalibre: TQRLabel;
    detalleSubDetalle: TQRSubDetail;
    QRBand5: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    color_c: TQRLabel;
    descripcion_color: TQRLabel;
    categoria_c: TQRLabel;
    descripcion_c: TQRLabel;
    pieSubDetalle: TQRBand;
    PsQRDBText1: TQRDBText;
    PsQRLabel1: TQRLabel;
    qrlblPais: TQRLabel;
    qrlblPais2: TQRLabel;
    QRLabel4: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlblvariedad: TQRLabel;
    qrlbl_variedad: TQRLabel;
    qrlbl_ejercicio: TQRLabel;
    qrlblejercicio: TQRLabel;
    procedure detalleSubDetalleNeedData(Sender: TObject;
      var MoreData: Boolean);
    procedure calibre_cPrint(sender: TObject; var Value: string);
    procedure descripcion_cPrint(sender: TObject; var Value: string);
    procedure categoria_cPrint(sender: TObject; var Value: string);
    procedure color_cPrint(sender: TObject; var Value: string);
    procedure descripcion_colorPrint(sender: TObject; var Value: string);
    procedure detalleSubDetalleAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRLProductoBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure estomate_pPrint(sender: TObject; var Value: string);
    procedure producto_pPrint(sender: TObject; var Value: string);
    procedure PsQRDBText1Print(sender: TObject; var Value: string);
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure qrlblPaisPrint(sender: TObject; var Value: String);
    procedure qrlblPais2Print(sender: TObject; var Value: String);
    procedure qrlblvariedadPrint(sender: TObject; var Value: String);
    procedure qrlbl_variedadPrint(sender: TObject; var Value: String);
    procedure qrlbl_ejercicioPrint(sender: TObject; var Value: String);
    procedure qrlblejercicioPrint(sender: TObject; var Value: String);
  private

  public
    ColorDataSet: TDataSet;
    CalibreDataSet: TDataSet;
    CategoriaDataSet: TDataSet;
    PaisDataSet: TDataSet;
    VariedadDataSet: TDataSet;
    EjercicioDataSet: TDataSet;
  end;

var
  QRLProducto: TQRLProducto;

implementation

{$R *.DFM}

uses UDMAuxDB, Dialogs;

procedure TQRLProducto.QRLProductoBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  i: integer;
begin
  inherited;

  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TQRDBText then
    begin
      TQRDBText(Components[i]).DataSet := DataSet;
    end;
  end;

  if not CalibreDataSet.Active and
    not CategoriaDataSet.Active and
    not ColorDataSet.Active and
    not VariedadDataSet.Active and
    not EjercicioDataSet.Active and
    not PaisDataSet.Active  then
  begin
    bandaTituloProducto.Color := clWhite;
    bandaProducto.Color := clWhite;
    detalleSubDetalle.Enabled := False;
    cabeceraSubDetalle.Enabled := False;
    pieSubDetalle.Enabled := False;
  end else begin
    bandaTituloProducto.Color := $00DEDCDA;
    bandaProducto.Color := $00DEDCDA;
    detalleSubDetalle.Enabled := True;
    cabeceraSubDetalle.Enabled := True;
    pieSubDetalle.Enabled := True;
  end;
end;

procedure TQRLProducto.detalleSubDetalleNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData := not (CalibreDataSet.EOF and
    CategoriaDataSet.EOF and
    ColorDataSet.EOF and
    VariedadDataSet.EOF and
    EjercicioDataSet.EOF and
    PaisDataSet.EOF);
end;

procedure TQRLProducto.detalleSubDetalleAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if not CalibreDataSet.EOF then CalibreDataSet.Next;
  if not CategoriaDataSet.EOF then CategoriaDataSet.Next;
  if not ColorDataSet.EOF then ColorDataSet.Next;
  if not PaisDataSet.EOF then PaisDataSet.Next;
  if not VariedadDataSet.EOF then VariedadDataSet.Next;
  if not EjercicioDataSet.EOF then EjercicioDataSet.Next;
end;

procedure TQRLProducto.calibre_cPrint(sender: TObject; var Value: string);
begin
  if not CalibreDataSet.EOF then
    Value := CalibreDataSet.FieldByName('calibre_c').AsString
  else Value := '';
end;

procedure TQRLProducto.descripcion_cPrint(sender: TObject;
  var Value: string);
begin
  if not CategoriaDataSet.EOF then
    Value := CategoriaDataSet.FieldByName('categoria_c').AsString
  else Value := '';
end;

procedure TQRLProducto.categoria_cPrint(sender: TObject;
  var Value: string);
begin
  if not CategoriaDataSet.EOF then
    Value := CategoriaDataSet.FieldByName('descripcion_c').AsString
  else Value := '';
end;

procedure TQRLProducto.color_cPrint(sender: TObject; var Value: string);
begin
  if not ColorDataSet.EOF then
    Value := ColorDataSet.FieldByName('color_c').AsString
  else Value := '';
end;

procedure TQRLProducto.descripcion_colorPrint(sender: TObject;
  var Value: string);
begin
  if not ColorDataSet.EOF then
    Value := ColorDataSet.FieldByName('descripcion_c').AsString
  else Value := '';
end;

procedure TQRLProducto.qrlblPaisPrint(sender: TObject; var Value: String);
begin
  if not PaisDataSet.EOF then
    Value := PaisDataSet.FieldByName('pais_psp').AsString
  else Value := '';
end;

procedure TQRLProducto.qrlblPais2Print(sender: TObject; var Value: String);
begin
  if not PaisDataSet.EOF then
    Value := DesPais( PaisDataSet.FieldByName('pais_psp').AsString )
  else Value := '';
end;

procedure TQRLProducto.estomate_pPrint(sender: TObject; var Value: string);
begin
  if Value = 'S' then Value := 'Si'
  else Value := 'No';
end;

procedure TQRLProducto.producto_pPrint(sender: TObject; var Value: string);
begin
  Value := Value + '  ' +
    QRLProducto.DataSet.fieldbyname('descripcion_p').AsSTring;
  if (QRLProducto.DataSet.fieldbyname('descripcion2_p').AsSTring <> '') then
  begin
    if (QRLProducto.DataSet.fieldbyname('descripcion_p').AsSTring <> '') then
    begin
      Value := Value + ' / ' +
        QRLProducto.DataSet.fieldbyname('descripcion2_p').AsSTring;
    end
    else
    begin
      Value := Value +
        QRLProducto.DataSet.fieldbyname('descripcion2_p').AsSTring;
    end;
  end;
end;

procedure TQRLProducto.PsQRDBText1Print(sender: TObject;
  var Value: string);
begin
  Value := Value + '  ' +
    desProductoBase(QRLProducto.DataSet.fieldbyname('empresa_p').AsSTring, Value);
end;

procedure TQRLProducto.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
  if Value = '1' then Value := 'Si'
  else Value := 'No';
end;

procedure TQRLProducto.qrlblvariedadPrint(sender: TObject;
  var Value: String);
begin
  if not VariedadDataSet.EOF then
    Value := VariedadDataSet.FieldByName('codigo_pv').AsString
  else Value := '';
end;


procedure TQRLProducto.qrlbl_variedadPrint(sender: TObject;
  var Value: String);
begin
  if not VariedadDataSet.EOF then
    Value := VariedadDataSet.FieldByName('descripcion_pv').AsString
  else Value := '';
end;



procedure TQRLProducto.qrlbl_ejercicioPrint(sender: TObject;
  var Value: String);
begin
  if not EjercicioDataSet.EOF then
    Value := EjercicioDataSet.FieldByName('centro_e').AsString
  else Value := '';
end;

procedure TQRLProducto.qrlblejercicioPrint(sender: TObject;
  var Value: String);
begin
  if not EjercicioDataSet.EOF then
    Value := EjercicioDataSet.FieldByName('ejercicio_e').AsString
  else Value := '';
end;

end.
