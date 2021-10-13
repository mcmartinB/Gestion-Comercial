unit CRLSalidasDDASinFactura;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRLSalidasDDASinFactura = class(TQuickRep)
    bndTitulo: TQRBand;
    bndResumen: TQRBand;
    bndDetalle: TQRBand;
    qrlTitulo: TQRLabel;
    lblCentro: TQRLabel;
    lblPeriodo: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    qrefecha_tc: TQRDBText;
    qrereferencia_tc: TQRDBText;
    qrekilos_dal: TQRDBText;
    qrekilos_das: TQRDBText;
    qrefecha_entrada_dda_dac: TQRDBText;
    qrecategoria: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrefecha_das: TQRDBText;
    qren_albaran_das: TQRDBText;
    qrecentro_salida_das: TQRDBText;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrefecha_dac: TQRDBText;
    qrevehiculo_das: TQRDBText;
    qrekilos_das1: TQRDBText;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrl8: TQRLabel;
    qrl9: TQRLabel;
    qrl10: TQRLabel;
    qrlFactura: TQRLabel;
    qrlImporte: TQRLabel;
    procedure qrecategoriaPrint(sender: TObject; var Value: String);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    bFacturaEstadistica: boolean;
  public

  end;

  procedure Previsualizar( const AEmpresa, ACentro: string;
                           const AFechainicio, AFechafin: TDateTime;
                           const AFacturaGrabada, APortePropio: integer;
                           const AFacturaEstadistica: boolean );

implementation

{$R *.DFM}

uses
  CDLSalidasDDASinFactura, UDMAUXDB, CReportes, DPreview, bTextUtils;

var
  RLSalidasDDASinFactura: TRLSalidasDDASinFactura;
  (*
  empresa_tc, centro_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc, ');
    SQL.Add('         sum(kilos_tl) kilos_tc
  *)
procedure Previsualizar( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime;
                         const AFacturaGrabada, APortePropio: integer;
                         const AFacturaEstadistica: boolean );
begin
  RLSalidasDDASinFactura:= TRLSalidasDDASinFactura.Create( nil );
  with RLSalidasDDASinFactura do
  begin

    case AFacturaGrabada of
      0:
        case APortePropio of
          0: qrlTitulo.Caption:= 'SALIDAS DDA';
          1: qrlTitulo.Caption:= 'SALIDAS DDA PORTES PROPIOS';
          2: qrlTitulo.Caption:= 'SALIDAS DDA PORTES TERCEROS';
        end;
      1:
        case APortePropio of
          0: qrlTitulo.Caption:= 'SALIDAS DDA CON FACTURA';
          1: qrlTitulo.Caption:= 'SALIDAS DDA CON FACTURA PORTES PROPIOS';
          2: qrlTitulo.Caption:= 'SALIDAS DDA CON FACTURA PORTES TERCEROS';
        end;
      2:
        case APortePropio of
          0: qrlTitulo.Caption:= 'SALIDAS DDA SIN FACTURA';
          1: qrlTitulo.Caption:= 'SALIDAS DDA SIN FACTURA PORTES PROPIOS';
          2: qrlTitulo.Caption:= 'SALIDAS DDA SIN FACTURA PORTES TERCEROS';
        end;
    end;

    bFacturaEstadistica:= AFacturaEstadistica;
    PonLogoGrupoBonnysa( RLSalidasDDASinFactura, AEmpresa );
    lblCentro.Caption:= ACentro + ' ' + DesCentro( AEmpresa, ACentro );
    lblPeriodo.Caption:= 'Del ' + DateToStr( AFechainicio ) + ' al ' + DateToStr( AFechafin ) + '.';
  end;
  try
    Preview( RLSalidasDDASinFactura );
  except
    FreeAndNil( RLSalidasDDASinFactura );
  end;
end;


function GetPrefijoFactura( const AEmpresa, ACentro: string; const AFecha: TDateTime ): string;
var
  iAnyo, iMes, iDia: word;
  sAux: string;
begin
  result:= 'ERROR ';
  DecodeDate( AFecha, iAnyo, iMes, iDia );
  sAux:= IntToStr( iAnyo );
  sAux:= Copy( sAux, 3, 2 );
  if ACentro = '6' then
  begin
    result:= 'FCT-' + AEmpresa + sAux + '-';
  end
  else
  begin
    result:= 'FCP-' + AEmpresa + sAux + '-';
  end;
end;

function NewContadorFactura( const AFactura: string ): string;
begin
  if StrToIntDef( AFactura, 0 ) > 99999 then
  begin
    result:= Copy( result, length( AFactura ) - 4, 5 );
  end
  else
  begin
    result:= Rellena( AFactura , 5, '0', taLeftJustify );
  end;
end;

function  NewCodigoFactura( const AEmpresa, ACentro, AFactura: string;
                            const AFecha: TDateTime ): string;
begin
  if ( AEmpresa = '501' ) or ( AEmpresa = '502' ) then
  begin
    result:= AFactura;
  end
  else
  begin
    result:= GetPrefijoFactura( AEmpresa, ACentro, AFecha ) +
             NewContadorFactura( AFactura );
  end;
end;

procedure TRLSalidasDDASinFactura.qrecategoriaPrint(sender: TObject;
  var Value: String);
begin
  Value:= desTransporte( DataSet.FieldByName('empresa_dac').AsString, Value );
end;

procedure TRLSalidasDDASinFactura.bndDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if bFacturaEstadistica then
  begin
    if dataset.fieldByName('n_factura_das').AsString = '' then
    begin
      if ( dataset.fieldByName('n_factura_estadistico').AsString <> '' ) then
      begin
        qrlFactura.caption:= NewCodigoFactura( dataset.fieldByName('empresa_dac').AsString, dataset.fieldByName('centro_salida_das').AsString,
                        Trim( dataset.fieldByName('n_factura_estadistico').AsString ), dataset.fieldByName('fecha_das').AsDateTime );
      end
      else
      begin
        qrlFactura.caption:= '';
      end;
      qrlImporte.caption:= FormatFloat( '#,##0.00', DataSet.fieldByName('importe_estadistico').AsFloat );
    end
    else
    begin
      qrlImporte.caption:= FormatFloat( '#,##0.00', DataSet.fieldByName('frigorifico_das').AsFloat );
      qrlFactura.caption:= dataset.fieldByName('n_factura_das').AsString;
    end;
  end
  else
  begin
    qrlImporte.caption:= FormatFloat( '#,##0.00', DataSet.fieldByName('frigorifico_das').AsFloat );
    qrlFactura.caption:= dataset.fieldByName('n_factura_das').AsString;
  end;
end;

end.
