unit QLFactSuministro;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQFactSuministro = class(TQuickRep)
    Query: TQuery;
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRDBText3: TQRDBText;
    PsQRExpr1: TQRExpr;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRShape1: TQRShape;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    lblCliente: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblFecha: TQRLabel;
    PageFooterBand1: TQRBand;
    PsQRLabel9: TQRLabel;
    procedure FormatValue(sender: TObject; var Value: string);
  private

  public
    destructor Destroy; override;
    constructor Create(Owner: TComponent); override;
  end;

var
  QFactSuministro: TQFactSuministro;

implementation

{$R *.DFM}

destructor TQFactSuministro.Destroy;
begin
  if Query.Active then
  begin
    Query.Cancel;
    Query.Close;
  end;
  inherited;
end;

constructor TQFactSuministro.Create(Owner: TComponent);
begin
  inherited;

  Query.SQL.Add(' select centro_salida_sc origen, descripcion_c desOrigen, ' +
    '        dir_sum_sc destino, nombre_ds desDestino, ' +
    '        sum(importe_euros_f) importe ' +
    ' from frf_facturas, frf_salidas_c, frf_dir_sum, frf_centros ' +
    ' where fecha_factura_f between :fechadesde and :fechahasta ' +
    '   and empresa_f= :empresa ' +
    '   and empresa_sc = empresa_f ' +
    '   and cliente_sal_sc = :cliente ' +
    '   and n_factura_sc = n_factura_f ' +
    '   and fecha_factura_sc = fecha_factura_f ' +
//    '   and empresa_sc = empresa_ds ' +
    '   and cliente_sal_sc = cliente_ds ' +
    '   and dir_sum_sc = dir_sum_ds ' +
    '   and empresa_sc = empresa_c ' +
    '   and centro_salida_sc = centro_c ' +
    '   and es_transito_sc <> 2 ' +                             //Tipo Salida: Devolucion
    ' group by 1,2,3,4 order by 1,3 ');
end;

procedure TQFactSuministro.FormatValue(sender: TObject;
  var Value: string);
begin
  try
    Value := FormatFloat('#,##0.00', StrToFloat(Value));
  except
  end;
end;

end.
