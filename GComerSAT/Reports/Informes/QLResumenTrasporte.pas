unit QLResumenTrasporte;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, Qrctrls, CVariables, Db,
  DBTables, jpeg;

type
  TQResumenTrasporte = class(TQuickRep)
    QRBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    DBCajas: TQRDBText;
    DBKilos: TQRDBText;
    QRDBText9: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel10: TQRLabel;
    LCajas: TQRLabel;
    LKilos: TQRLabel;
    Lcos: TQRLabel;
    Lpla: TQRLabel;
    Lcaj: TQRLabel;
    Lkil: TQRLabel;
    QRSubDetail2: TQRSubDetail;
    codCosechero: TQRDBText;
    QRDBText11: TQRDBText;
    DBKilos2: TQRDBText;
    QRDBText13: TQRDBText;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    lblFecha: TQRLabel;
    lblCentro: TQRLabel;
    BonnyBand: TQRBand;
    QRImageCab: TQRImage;
    PsEmpresa: TQRLabel;
    PsDireccion: TQRLabel;
    PsNif: TQRLabel;
    lblProducto2: TQRLabel;
    producto: TQRDBText;
    lblProducto: TQRLabel;
    QRLabel7: TQRLabel;
    producto2: TQRDBText;
    procedure QRSubDetail1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRSubDetail2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRLAlbInputsTransportistasStartPage(Sender: TCustomQuickRep);
    procedure QRDBText3Print(sender: TObject; var Value: string);
    procedure codCosecheroPrint(sender: TObject; var Value: string);
    procedure QRDBText13Print(sender: TObject; var Value: string);
    procedure lblCentroPrint(sender: TObject; var Value: string);
  private
    cajas, detalles1, detalles2: Integer;
    kilos: Real;
    PrintCosechero: boolean;

  public
    empresa, centro: string;
    procedure Configurar(const AEmpresa: string);
  end;

var
  QResumenTrasporte: TQResumenTrasporte;

implementation

uses UDMAuxDB, LFResumenTransporte;

{$R *.DFM}

procedure TQResumenTrasporte.QRSubDetail1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
     //Actualizamos variables
  try
    cajas := cajas + TFLResumenTransporte(Owner).QAlbResumenD1.FieldByName('cajas').AsInteger;
    kilos := kilos + TFLResumenTransporte(Owner).QAlbResumenD1.FieldByName('kilos').AsFloat;
  except
        //No hacemos nada
  end;
end;

procedure TQResumenTrasporte.QRBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     //Inicializamos variables
  kilos := 0;
  cajas := 0;

  detalles1 := TFLResumenTransporte(Owner).QAlbResumenD1.RecordCount;
  detalles2 := TFLResumenTransporte(Owner).QAlbResumenD2.RecordCount;
  QRSubDetail1.Tag := 0;

  QRSubDetail2.Frame.DrawBottom := False;
  QRSubDetail2.Height := 22;
end;

procedure TQResumenTrasporte.ChildBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     //Imprimimos variables
  LCajas.Caption := IntToStr(cajas);
  LKilos.Caption := FloatToStrF(kilos, ffFixed, 12, 2);
end;

procedure TQResumenTrasporte.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     //Activamos banda hija con el ultimo registro
  QRSubDetail1.Tag := QRSubDetail1.Tag + 1;
  if QRSubDetail1.Tag = detalles1 then
    ChildBand1.Enabled := true
  else
    ChildBand1.Enabled := false;
end;

procedure TQResumenTrasporte.ChildBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
     //Ya hemos imprimido la cebecera
  ChildBand1.Enabled := false;
  QRSubDetail2.Tag := 0;
end;

procedure TQResumenTrasporte.QRSubDetail2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     //Pintamos Frame inferior en la ultima linea
  QRSubDetail2.Tag := QRSubDetail2.Tag + 1;
  if QRSubDetail2.Tag = detalles2 then
  begin
    QRSubDetail2.Frame.DrawBottom := true;
    QRSubDetail2.Height := QRSubDetail2.Height + 20;
  end;
end;

procedure TQResumenTrasporte.Configurar(const AEmpresa: string);
var
  bAux: Boolean;
  sAux, ssEmpresa: string;
begin
    if ( AEmpresa = '050' ) or ( AEmpresa = '080' ) then
      ssEmpresa:= 'SAT'
    else
      ssEmpresa:= AEmpresa;

  bAux:= FileExists( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
  if bAux then
  begin
    QRImageCab.Top:= -18; //-20
    QRImageCab.Left:= -37; //-20
    QRImageCab.Width:= 763; //-30
    QRImageCab.Height:= 1102; //-20
    QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
    QRImageCab.Stretch:= True;
    QRImageCab.Enabled:= True;
  end
  else
  begin
    QRImageCab.Enabled:= False;
    ConsultaOpen(DMAuxDB.QAux,
      ' select nombre_e,nif_e,tipo_via_e,domicilio_e,cod_postal_e, ' +
      '        poblacion_e,nombre_p ' +
      ' from frf_empresas,frf_provincias ' +
      ' where empresa_e=' + QuotedStr(Trim(AEmpresa)) +
      '   and cod_postal_e[1,2]=codigo_p');

    with DMAuxDB.QAux do
    begin
      PsEmpresa.Caption := FieldByName('nombre_e').AsString;
      PsNif.Caption := 'NIF: ' + FieldByName('nif_e').AsString;

      sAux := '';
      if Trim(FieldByName('tipo_via_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('tipo_via_e').AsString) + '. ';
      if Trim(FieldByName('domicilio_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('domicilio_e').AsString) + '      ';
      if Trim(FieldByName('cod_postal_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('cod_postal_e').AsString) + '  ';
      if Trim(FieldByName('poblacion_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('poblacion_e').AsString) + '      ';
      if Trim(FieldByName('cod_postal_e').AsString) <> '' then
       sAux := sAux + '(' + Trim(FieldByName('nombre_p').AsString) + ')  ';

      PsDireccion.Caption := sAux;

      Close;
    end;
  end;

  PsDireccion.Enabled:= not bAux;
  PsEmpresa.Enabled:= not bAux;
  PsNif.Enabled:= not bAux;
end;

procedure TQResumenTrasporte.QRSubDetail2AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if PrintCosechero then
  begin
    PrintCosechero := false;
    codCosechero.Enabled := false;
  end;
end;

procedure TQResumenTrasporte.QRLAlbInputsTransportistasStartPage(
  Sender: TCustomQuickRep);
begin
  PrintCosechero := true;
  codCosechero.Enabled := true;
end;

procedure TQResumenTrasporte.QRDBText3Print(sender: TObject;
  var Value: string);
begin
  Value := desCamion(Value);
end;

procedure TQResumenTrasporte.codCosecheroPrint(sender: TObject;
  var Value: string);
begin
  Value := Value + '  ' + desCosechero(empresa, Value);
end;

procedure TQResumenTrasporte.QRDBText13Print(sender: TObject;
  var Value: string);
begin
  Value := Value + '  ' + desPlantacionEx(empresa,
    codCosechero.DataSet.FieldByName('producto').AsString,
    codCosechero.DataSet.FieldByName('cosechero').AsString,
    Value,
    codCosechero.DataSet.FieldByName('fecha').AsString);
end;

procedure TQResumenTrasporte.lblCentroPrint(sender: TObject;
  var Value: string);
begin
  Value := desCentro(empresa, centro);
end;

end.
