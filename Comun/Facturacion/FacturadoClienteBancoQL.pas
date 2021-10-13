unit FacturadoClienteBancoQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, kbmMemTable, DB, DBTables;

type
  TQLFacturadoClienteBanco = class(TQuickRep)
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel6: TQRLabel;
    qrecod_cliente: TQRDBText;
    qrdbtxtbanco: TQRDBText;
    qrdbtxtdes_banco: TQRDBText;
    qrdbtxtcta_banco: TQRDBText;
    TitleBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblFechas: TQRLabel;
    qrenom_cliente: TQRDBText;
    QListado: TQuery;
    qretotal: TQRDBText;
    qrl3: TQRLabel;
    bndSumario: TQRBand;
    qrxTotal: TQRExpr;
    qrgrpExporta: TQRGroup;
    qrbndPiePais: TQRBand;
    qrxpr2: TQRExpr;
    qrdbtxtpais: TQRDBText;
    qrgrpPais: TQRGroup;
    qrbndPieExporta: TQRBand;
    qrlbl1: TQRLabel;
    qrdbtxttipo_exporta: TQRDBText;
    QRExpr2: TQRExpr;
    qrshp1: TQRShape;
    qrdbtxttipo_exporta1: TQRDBText;
    qrdbtxtpais1: TQRDBText;
    qrdbtxtpais2: TQRDBText;
    qrdbtxttipo_exporta2: TQRDBText;
    qrlbl2: TQRLabel;
    procedure qrdbtxtpaisPrint(sender: TObject; var Value: String);
    procedure qrdbtxttipo_exportaPrint(sender: TObject; var Value: String);
    procedure qrgrpPaisBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrpExportaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxttipo_exporta2Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtpais2Print(sender: TObject; var Value: String);
    procedure PsQRLabel3Print(sender: TObject; var Value: String);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure qrbndPiePaisBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieExportaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndSumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

    function HayDatos( const AEmpresa, ACliente, APais: string ;
                       const AFechaIni, AFechaFin: TDateTime;
                       const ASeguro: integer ): boolean;
    //procedure CrearListado;
    procedure VerListado;
    //procedure Importes( var VNeto, VTotal: Real );

  public
    sEmpresa: String;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  function VisualizarInforme( const AEmpresa, ACliente, APais: string ;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ASeguro: integer ): boolean;

implementation

uses UDMAuxDB, DPreview, CReportes, Math;

{$R *.DFM}

var
  QLFacturadoClienteBanco: TQLFacturadoClienteBanco;

function VisualizarInforme( const AEmpresa, ACliente, APais: string ;
                            const AFechaIni, AFechaFin: TDateTime;
                            const ASeguro: integer ): boolean;
begin
  QLFacturadoClienteBanco:= TQLFacturadoClienteBanco.Create( nil );
  try
    with QLFacturadoClienteBanco do
    begin
      if HayDatos( AEmpresa, ACliente, APais, AFechaIni, AFechaFin, ASeguro ) then
      begin
        sEmpresa:= AEmpresa;
        lblFechas.Caption := 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );
        PonLogoGrupoBonnysa(QLFacturadoClienteBanco, sEmpresa );

        VerListado;
        result:= True;
      end
      else
      begin
        result:= False;
      end;
    end;
  except
    FreeAndNil( QLFacturadoClienteBanco );
    raise;
  end;
end;

constructor TQLFacturadoClienteBanco.Create(AOwner: TComponent);
begin
  inherited;
(*
  with mtListado do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('tipo_exporta', ftString, 12, False);
    FieldDefs.Add('pais', ftString, 30, False);
    FieldDefs.Add('cod_cliente', ftString, 3, False);
    FieldDefs.Add('nom_cliente', ftString, 35, False);
    FieldDefs.Add('cod_pago', ftString, 3, False);
    FieldDefs.Add('tipo_pago', ftString, 3, False);
    FieldDefs.Add('dias_pago', ftInteger, 0, False);
    FieldDefs.Add('neto', ftFloat, 0, False);
    FieldDefs.Add('total', ftFloat, 0, False);
    CreateTable;
    Open;
  end;
*)
end;

destructor TQLFacturadoClienteBanco.Destroy;
begin
  (*
  with mtListado do
  begin
    Close;
    DeleteTable;
  end;
  *)
  QListado.Close;
  inherited;
end;

function TQLFacturadoClienteBanco.HayDatos( const AEmpresa, ACliente, APais: string ;
                       const AFechaIni, AFechaFin: TDateTime;
                       const ASeguro: integer ): boolean;
begin
  with QListado do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        case when pais_c = ''ES'' then ''INTERNO'' ');
    SQL.Add('             when pais_c <> ''ES'' and es_comunitario_c = ''S'' then ''COMUNITARIO'' ');
    SQL.Add('             else ''EXTRACOM.'' end tipo_exporta, ');
    SQL.Add('        ( select descripcion_p from frf_paises where pais_c = pais_p ) pais, ');
    SQL.Add('        cliente_c cod_cliente, nombre_c nom_cliente, ');

    SQL.Add('        sum( importe_euros_f ) total, ');

    SQL.Add('        banco_ct banco, ( select descripcion_b from frf_bancos where banco_b = banco_ct ) des_banco, ');
    SQL.Add('        ( select cta_bancaria_b from frf_bancos where banco_b = banco_ct ) cta_banco ');

    SQL.Add(' from frf_clientes, frf_facturas, outer(frf_clientes_rie), outer(frf_clientes_tes) ');

    SQL.Add(' where cliente_fac_f = cliente_c ');
    SQL.Add(' and fecha_factura_f between :fechaini and :fechafin ');

    SQL.Add(' and empresa_cr = :empresa ');
    SQL.Add(' and cliente_cr = cliente_c ');
    SQL.Add(' and fecha_fin_cr is null ');

    SQL.Add('  and empresa_ct = :empresa ');
    SQL.Add('  and cliente_ct = cliente_c ');

    if AEmpresa <> '' then
      SQL.Add(' and empresa_f = :empresa ');
    if ACliente <> '' then
    begin
      SQL.Add(' and cliente_fac_f = :cliente ');
    end
    else
    begin
      if APais <> '' then
        SQL.Add(' and pais_c = :pais ');
    end;
    case ASeguro of
      1: SQL.Add(' and seguro_cr <> 0 ');
      2: SQL.Add(' and seguro_cr = 0 ');
    end;

    SQL.Add(' group by 1,2,3,4,6,7,8 ');
    SQL.Add(' order by tipo_exporta desc, pais, cod_cliente ');


    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    if AEmpresa <> '' then
      ParamByName('empresa').AsString:= AEmpresa;
    if ACliente <> '' then
    begin
      ParamByName('cliente').AsString:= ACliente;
    end
    else
    begin
      if APais <> '' then
        ParamByName('pais').AsString:= APais;
    end;

    Open;
    result:= not IsEmpty;
    (*
    if result then
      CrearListado;
      Close;
    *)
  end;


end;


procedure TQLFacturadoClienteBanco.VerListado;
begin
  DPreview.Preview( QLFacturadoClienteBanco );
end;

procedure TQLFacturadoClienteBanco.qrdbtxtpaisPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + Value + ':';
end;

procedure TQLFacturadoClienteBanco.qrdbtxttipo_exportaPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + Value + ':';
end;

procedure TQLFacturadoClienteBanco.qrgrpPaisBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) then
  begin
    PrintBand:= False
  end
  else
  begin
    PrintBand:= True;
  end;
end;

procedure TQLFacturadoClienteBanco.qrgrpExportaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) then
  begin
    PrintBand:= False
  end
  else
  begin
    PrintBand:= True;
  end;
end;

procedure TQLFacturadoClienteBanco.qrdbtxttipo_exporta2Print(
  sender: TObject; var Value: String);
begin
  if not ( Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQLFacturadoClienteBanco.qrdbtxtpais2Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQLFacturadoClienteBanco.PsQRLabel3Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQLFacturadoClienteBanco.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) ) then
  begin
    Value:= 'País';
  end
  else
  begin
    Value:= 'Mercado';
  end;
end;

procedure TQLFacturadoClienteBanco.qrbndPiePaisBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) then
  begin
    PrintBand:= False
  end
  else
  begin
    PrintBand:= True;
  end;
end;

procedure TQLFacturadoClienteBanco.qrbndPieExportaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) then
  begin
    PrintBand:= False
  end
  else
  begin
    PrintBand:= True;
  end;
end;

procedure TQLFacturadoClienteBanco.bndSumarioBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) then
  begin
    PrintBand:= False
  end
  else
  begin
    PrintBand:= True;
  end;
end;

end.
