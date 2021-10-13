unit AlbaranSalidaEnvasesQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables,
  jpeg;

type
  TQRAlbaranSalidaEnvases = class(TQuickRep)
    BonnyBand: TQRBand;
    BandaDatos: TQRBand;
    CabeceraTabla: TQRBand;
    producto: TQRDBText;
    lin1: TQRShape;
    lin2: TQRShape;
    lin7: TQRShape;
    QRBand1: TQRBand;
    QRGroup1: TQRGroup;
    LPalets: TQRLabel;
    LCajas: TQRLabel;
    MemoCajas: TQRMemo;
    MemoPalets: TQRMemo;
    bndcObservaciones: TQRChildBand;
    LObservaciones: TQRLabel;
    mmoObservaciones: TQRMemo;
    QRBand2: TQRBand;
    PsQRShape16: TQRShape;
    PsQRShape17: TQRShape;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRLabel10: TQRLabel;
    LCentro: TQRLabel;
    PsQRLabel11: TQRLabel;
    PsQRLabel12: TQRLabel;
    LTransporte: TQRLabel;
    PsQRShape20: TQRShape;
    PsQRShape23: TQRShape;
    PsQRShape24: TQRShape;
    PsQRShape25: TQRShape;
    PsQRShape26: TQRShape;
    PsQRShape22: TQRShape;
    PsQRShape21: TQRShape;
    PsQRShape27: TQRShape;
    PsQRShape19: TQRShape;
    PsQRShape18: TQRShape;
    PsQRLabel22: TQRLabel;
    PsQRLabel23: TQRLabel;
    PsQRLabel27: TQRLabel;
    PsQRLabel28: TQRLabel;
    PsQRLabel29: TQRLabel;
    PsQRShape29: TQRShape;
    PsQRShape30: TQRShape;
    PsQRShape31: TQRShape;
    PsQRShape35: TQRShape;
    LTransporteDir1: TQRLabel;
    descripcion2_e: TQRDBText;
    qrlNAlbaran: TQRLabel;
    LFecha: TQRLabel;
    LHora: TQRLabel;
    LPedido: TQRLabel;
    LVehiculo: TQRLabel;
    PsEmpresa: TQRLabel;
    PsNif: TQRLabel;
    PsDireccion: TQRLabel;
    QRImageCab: TQRImage;
    bndcFirma: TQRChildBand;
    qrmDireccion: TQRMemo;
    qrlNAlbaran2: TQRLabel;
    PsQRShape9: TQRShape;
    PsQRShape10: TQRShape;
    psEtiqueta: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel19: TQRLabel;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    QRImgFirma: TQRImage;
    qrmReponsabilidadEnvase: TQRMemo;
    qrshp1: TQRShape;
    qrdbtxtpalet: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    procedure PsQRLabel19Print(sender: TObject; var Value: string);
    procedure bndcObservacionesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndcFirmaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    bOriginal: boolean;
    sFirma: string;
    empresa, cliente: string;
    codProveedor: string;


    procedure GetCodigoProveedor(const AEmpresa, ACliente: string);
    procedure Configurar(Empresa: string);
    
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses UDMAuxDB, CVariables, StrUtils, UDMBaseDatos, bTextUtils, bSQLUtils,
     Dialogs, UDMConfig, bMath;

{$R *.DFM}

constructor TQRAlbaranSalidaEnvases.Create(AOwner: TComponent);
begin
  inherited;

  bOriginal:= True;
end;

destructor TQRAlbaranSalidaEnvases.Destroy;
begin

  inherited;
end;

procedure TQRAlbaranSalidaEnvases.GetCodigoProveedor(const AEmpresa, ACliente: string);
begin
    DMBaseDatos.QTemp.SQL.Clear;
    DMBaseDatos.QTemp.SQL.Add(' SELECT codigo_ean_e  ' +
      ' FROM    frf_empresas ' +
      ' WHERE empresa_e = :empresa ');
    DMBaseDatos.QTemp.ParamByName('empresa').AsString := AEmpresa;
    DMBaseDatos.QTemp.open;
    codProveedor := DMBaseDatos.QTemp.FieldByName('codigo_ean_e').AsString;
    DMBaseDatos.QTemp.Close;
end;

procedure TQRAlbaranSalidaEnvases.Configurar(Empresa: string);
var
  ssEmpresa, sAux: string;
begin
  ssEmpresa:= 'BAG';

  if FileExists( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf') then
  begin
    QRImageCab.Top:= -18; //-20
    QRImageCab.Left:= -37; //-20
    QRImageCab.Width:= 763; //-30
    QRImageCab.Height:= 1102; //-20
    QRImageCab.Stretch:= True;
    QRImageCab.Enabled:= True;
    QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');

    PsDireccion.Enabled:= False;
    PsEmpresa.Enabled:= False;
    PsNif.Enabled:= False;
  end
  else
  begin
    QRImageCab.Enabled:= False;
    ConsultaOpen(DMAuxDB.QAux,
      ' select nombre_e,nif_e,tipo_via_e,domicilio_e,cod_postal_e, ' +
      '        poblacion_e,nombre_p ' +
      ' from frf_empresas,frf_provincias ' +
      ' where empresa_e=' + QuotedStr(Trim(ssEmpresa)) +
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

    PsDireccion.Enabled:= True;
    PsEmpresa.Enabled:= True;
    PsNif.Enabled:= True;
  end;
end;

procedure TQRAlbaranSalidaEnvases.PsQRLabel19Print(sender: TObject;
  var Value: string);
begin
  if codProveedor <> '' then
  begin
    Value := 'COD. PROVEEDOR: ' + codProveedor;
  end
  else
  begin
    Value := '';
  end;
end;

procedure TQRAlbaranSalidaEnvases.bndcObservacionesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := mmoObservaciones.Lines.Count <> 0;
end;

procedure TQRAlbaranSalidaEnvases.bndcFirmaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bOriginal then
  begin
    case Tag of
      0: psEtiqueta.Caption := '';
      1: psEtiqueta.Caption := 'ORIGINAL EMPRESA';
      2: psEtiqueta.Caption := 'ORIGINAL CLIENTE';
      3: psEtiqueta.Caption := 'COPIA 1';
      4: psEtiqueta.Caption := 'COPIA 2';
      5: psEtiqueta.Caption := 'COPIA 3';
      else psEtiqueta.Caption := 'COPIA ' + IntToStr(Tag - 2);
    end;
  end
  else
  begin
    case Tag of
      0: psEtiqueta.Caption := '';
      1: psEtiqueta.Caption := 'ORIGINAL CLIENTE';
      2: psEtiqueta.Caption := 'COPIA 1';
      3: psEtiqueta.Caption := 'COPIA 2';
      4: psEtiqueta.Caption := 'COPIA 3';
      else psEtiqueta.Caption := 'COPIA ' + IntToStr(Tag - 1);
    end;
  end;


  //Carga firma si la tiene
  try
    If FileExists( sFirma ) then
    begin
      QRImgFirma.Enabled:= True;
      QRImgFirma.Stretch:= True;
      QRImgFirma.Picture.LoadFromFile( sFirma );
    end;
  except
    ShowMessage('Fichero de firma incorrecto: ' + sFirma );
  end;
end;

end.
