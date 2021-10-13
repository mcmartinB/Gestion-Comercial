unit QLAsignacionFederaciones;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLLAsignacionFederaciones = class(TQuickRep)
    cabecera: TQRBand;
    detalle: TQRBand;
    pie: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    lblFecha: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRGroup2: TQRGroup;
    QRBand3: TQRBand;
    QRShape3: TQRShape;
    QRExpr5: TQRExpr;
    QRLabel6: TQRLabel;
    lblCentro: TQRLabel;
    lblProducto: TQRLabel;
    QRLabel8: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabel9: TQRLabel;
    SummaryBand1: TQRBand;
    lblTotalProducto: TQRLabel;
    QRExpr8: TQRExpr;
    QRMemo: TQRMemo;
    lblFederacion: TQRExpr;
    procedure QRLabel6Print(sender: TObject; var Value: String);
    procedure lblFederacionPrint(sender: TObject; var Value: String);
  private

  public
    provincia: string;
    fecha: string;
  end;

var
  QRLLAsignacionFederaciones: TQRLLAsignacionFederaciones;

implementation

uses UDMAuxDB, DLAsignacionFederaciones, DB, bTextUtils;

{$R *.DFM}

(*
select "T" tipo,
       federacion_tl,

       empresa_tl empresa,
       centro_tl centro,
       fecha_tl fecha,
       referencia_tl albaran,

       centro_origen_tl origen,
       centro_destino_tl destino,
       vehiculo_tc vehiculo,
       sum(kilos_tl) kilos

from frf_transitos_c, frf_transitos_l

where empresa_tc = '050'
and   fecha_tc between '11/2/2008' and '17/2/2008'
and   centro_tc = '1'

and centro_destino_tc in
(
 select centro_c
 from frf_centros
 where empresa_c = '050'
   and pais_c <> 'ES'
)

and empresa_tl = empresa_tc
and centro_tl = centro_tc
and referencia_tl = referencia_tc
and fecha_tl = fecha_tc

And producto_tl = 'T'
and   centro_origen_tl = '1'

group by 1,2,3,4,5,6,7,8,9
order by 1,2,3,4,5,6,7,8,9
*)

(*
select "S" tipo,
       federacion_sl,

       empresa_sl empresa,
       centro_salida_sl centro,
       fecha_sl fecha,
       n_albaran_sl albaran,

       centro_origen_sl origen,
       cliente_sal_sc destino,
       vehiculo_sc vehiculo,
       sum(kilos_sl) kilos

from frf_salidas_c, frf_salidas_l

where empresa_sc = '050'
and   fecha_sc between '11/2/2008' and '17/2/2008'
and   centro_salida_sc = '1'

and exists
(
 select *
 from frf_clientes
 where empresa_c = '050'
   and cliente_c = cliente_sl
   and pais_c <> 'ES'
)

and empresa_sl = empresa_sc
and centro_salida_sl = centro_salida_sc
and n_albaran_sl = n_albaran_sc
and fecha_sl = fecha_sc

And producto_sl = 'T'
and   centro_origen_sl = '1'

group by 1,2,3,4,5,6,7,8,9
order by 1,2,3,4,5,6,7,8,9
*)


procedure TQRLLAsignacionFederaciones.QRLabel6Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL FEDERACIÓN [' + DataSet.fieldByName('federacion').AsString + ']';
end;

(*
procedure TQRLLAsignacionFederaciones.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with DMLAsignacionFederaciones.mtResumen do
  begin
    Filter:= 'producto = ' + QuotedStr( DataSet.FieldByName('producto_p').AsString );
    Filtered:= True;
    if not IsEmpty then
    begin
      PrintBand:= True;
      QRMemo.Lines.Clear;
      QRMemo.Lines.Add( 'FEDERACIÓN    KILOS      %' );
      QRMemo.Lines.Add( '--------------------------' );

      First;
      while not EOF do
      begin
        ;
        QRMemo.Lines.Add( Rellena( FieldByName('federacion').AsString, 4, ' ', taRightJustify ) + ' ' +
                          Rellena( FormatFloat('#,##0.00', FieldByName('kilos').AsFloat ), 14, ' ', taLeftJustify ) + ' ' +
                          Rellena( FormatFloat('#,##0.00', FieldByName('porcentaje').AsFloat ), 6, ' ', taLeftJustify ));
        Next;
      end;
      QRMemo.Lines.Add( '--------------------------' );
      QRMemo.Lines.Add( Rellena( FormatFloat('#,##0.00', FieldByName('total').AsFloat ), 19, ' ', taLeftJustify ) + ' 100,00');
    end
    else
    begin
      PrintBand:= False;
    end;
  end;
end;
*)


procedure TQRLLAsignacionFederaciones.lblFederacionPrint(sender: TObject;
  var Value: String);
begin
  if ( Value = '' ) or ( Value = '0' ) then
  begin
    Value :=  '0 Sin Asignar Federacion ';
  end
  else
  begin
    Value :=  Value + ' ' + desFederacion( Value );
  end;

end;

end.
