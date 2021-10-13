unit LTransitos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLTransitos = class(TQuickRep)
    DetailBand1: TQRBand;
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    QListado: TQuery;
    PsQRLabel9: TQRLabel;
    PsQRDBText8: TQRDBText;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    PsQRLabel12: TQRLabel;
    PsQRDBText9: TQRDBText;
    PsQRDBText10: TQRDBText;
    PsQRDBText11: TQRDBText;
    lbllPeriodo: TQRLabel;
    QRSysData1: TQRSysData;
    SummaryBand1: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel1: TQRLabel;
  private

  public

    destructor Destroy; override;

  end;

procedure Listado(const AWhere, ARange: string);

var
  QRLTransitos: TQRLTransitos;

implementation

uses UDMAuxDB, CVariables, DPreview, CReportes;

{$R *.DFM}

{ TQRLTransitos }

destructor TQRLTransitos.Destroy;
begin
  if QListado.Active then QListado.Close;
  inherited;
end;

procedure Listado(const AWhere, ARange: string);
var QueryStr: string;
begin
  QueryStr := ' select empresa_tc, centro_tc, fecha_tc, referencia_tc, ' +
    '        centro_destino_tc, ' +
    '        centro_origen_tl, ref_origen_tl, fecha_origen_tl, ' +
    '        producto_tl, ' +
    '        sum(cajas_tl) cajas_tl, sum(kilos_tl) kilos_tl ' +
    ' from frf_transitos_c,frf_transitos_l ';

  if AWhere <> '' then QueryStr := QueryStr + AWhere + ' and empresa_tc=empresa_tl '
  else QueryStr := QueryStr + ' where empresa_tc=empresa_tl ';

  QueryStr := QueryStr + ' and centro_tc=centro_tl ' +
    ' and fecha_tc=fecha_tl ' +
    ' and referencia_tc=referencia_tl ' +
    ' group by empresa_tc, centro_tc, fecha_tc, referencia_tc, ' +
    '        centro_destino_tc, ' +
    '        centro_origen_tl, ref_origen_tl, fecha_origen_tl, ' +
    '        producto_tl ' +
    ' order by empresa_tc,centro_tc,centro_destino_tc,fecha_tc,referencia_tc,producto_tl ';

  QRLTransitos := TQRLTransitos.Create(Application);
  ConsultaOpen(QRLTransitos.QListado, QueryStr, False, False);
  PonLogoGrupoBonnysa(QRLTransitos);
  QRLTransitos.lbllPeriodo.Caption := ARange;

  DPreview.Preview(QRLTransitos);
end;

end.
