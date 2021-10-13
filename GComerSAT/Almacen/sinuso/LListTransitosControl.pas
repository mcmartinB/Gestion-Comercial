unit LListTransitosControl;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls,  Db, DBTables;

type
  TQLListTransitosControl = class(TQuickRep)
    DetailBand1: TQRBand;
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QListado: TQuery;
    QRLabel9: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    lbllPeriodo: TQRLabel;
    QRSysData2: TQRSysData;
    SummaryBand1: TQRBand;
    QRExpr2: TQRExpr;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
  private

  public

    Destructor Destroy; Override;

  end;

procedure Listado( const AWhere, ARange: string);

var
  QLListTransitosControl: TQLListTransitosControl;

implementation

uses UDMAuxDB, CVariables, DPreview, CReportes;

{$R *.DFM}

destructor TQLListTransitosControl.Destroy;
begin
  if QListado.Active then QListado.Close;
  inherited;
end;

procedure Listado( const AWhere, ARange: string);
var QueryStr:string;
begin
     QueryStr:=' select empresa_tc, centro_tc, fecha_tc, referencia_tc, ' +
               '        buque_tc, vehiculo_tc, fecha_duaent_tc, ' +
               '        sum(kilos_tl) kilos_tc ' +
               ' from frf_transitos_c,frf_transitos_l ';

     if AWhere<>'' then QueryStr:=QueryStr+AWhere+' and empresa_tc=empresa_tl '
     else QueryStr:=QueryStr+' where empresa_tc=empresa_tl ';

     QueryStr:=QueryStr+' and centro_tc=centro_tl '+
               ' and fecha_tc=fecha_tl '+
               ' and referencia_tc=referencia_tl '+
               ' group by empresa_tc, centro_tc, fecha_tc, referencia_tc, ' +
               '        buque_tc, vehiculo_tc, fecha_duaent_tc ' +
               ' order by empresa_tc,centro_tc,fecha_tc,referencia_tc ';

     QLListTransitosControl:=TQLListTransitosControl.Create(Application);
     ConsultaOpen(QLListTransitosControl.QListado,QueryStr,False,False);
     PonLogoGrupoBonnysa(QLListTransitosControl);
     QLListTransitosControl.lbllPeriodo.Caption:= ARange;

     DPreview.Preview(QLListTransitosControl);
end;

end.
