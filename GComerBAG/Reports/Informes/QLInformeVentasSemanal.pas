unit QLInformeVentasSemanal;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DBClient, Provider, DB,
  DBTables;

type
  TQRLInformeVentasSemanal = class(TQuickRep)
    Query1: TQuery;
    Query2: TQuery;
    QRSubDetail1: TQRSubDetail;
    empresa: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    envase: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    SummaryBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel25: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel17: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel18: TQRLabel;
    SemanaAnterior: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    SemanaActual: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    lblCliente: TQRLabel;
    lblCategoria: TQRLabel;
    lblSemana: TQRLabel;
    producto: TQRDBText;
    procedure QRSubDetail1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure empresaPrint(sender: TObject; var Value: string);
    procedure productoPrint(sender: TObject; var Value: string);
    procedure envasePrint(sender: TObject; var Value: string);
    procedure QRDBText5Print(sender: TObject; var Value: string);
    procedure QRDBText6Print(sender: TObject; var Value: string);
    procedure QRDBText7Print(sender: TObject; var Value: string);
    procedure QRDBText8Print(sender: TObject; var Value: string);
    procedure QRDBText9Print(sender: TObject; var Value: string);
    procedure QRDBText10Print(sender: TObject; var Value: string);
    procedure des_envasePrint(sender: TObject; var Value: string);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRLabel4Print(sender: TObject; var Value: string);
    procedure QRLabel5Print(sender: TObject; var Value: string);
    procedure QRLabel6Print(sender: TObject; var Value: string);
    procedure QRLabel7Print(sender: TObject; var Value: string);
    procedure QRLabel8Print(sender: TObject; var Value: string);
    procedure QRLabel9Print(sender: TObject; var Value: string);
    procedure QRLabel1Print(sender: TObject; var Value: string);
    procedure QRLabel2Print(sender: TObject; var Value: string);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText1Print(sender: TObject; var Value: String);
  private
    flag1, flag2: boolean;
    orden: integer;
    grupo, aux_grupo: string;

    acum_kilos_ant, acum_kilos_act, acum_importe_ant, acum_importe_act: real;

    procedure ComparaDatos;
  public

    constructor Create(AOwner: TComponent); override;
    procedure   CargaSQL(const ACategoria: Boolean );
  end;

var
  QRLInformeVentasSemanal: TQRLInformeVentasSemanal;

implementation

{$R *.DFM}

uses UDMbaseDatos, UDMAuxDB;

procedure TQRLInformeVentasSemanal.CargaSQL(const ACategoria: Boolean );
begin
  with Query1 do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl empresa, ');
    SQL.Add('        producto_sl producto, ');
    SQL.Add('        envase_sl envase, ');
    SQL.Add('        sum(kilos_sl) kilos, ');
    SQL.Add('        ROUND(sum(importe_neto_sl)/sum(kilos_sl),3) precio ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and cliente_sl = :cliente ');
    SQL.Add(' and fecha_sl between :fechaini and :fechafin ');
    SQl.Add(' and empresa_sc = empresa_sl ');
    SQl.Add(' and centro_salida_sc = centro_salida_sl ');
    SQl.Add(' and n_albaran_sc = n_albaran_sl ');
    SQl.Add(' and fecha_sc = fecha_sl ');
    SQl.Add(' and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion
    if ACategoria then
      SQL.Add(' and categoria_sl = :categoria ');
    SQL.Add(' group by 1, 2, 3 ');
    SQL.Add(' order by 1 desc, 2 desc, 3 ');
  end;

  with Query2 do
  begin
    SQL.Clear;
    SQL.Add(Query1.SQL.Text);
  end;
end;

constructor TQRLInformeVentasSemanal.Create(AOwner: TComponent);
begin
  inherited;
  CargaSQL( True );
end;

procedure TQRLInformeVentasSemanal.QRSubDetail1NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData := not (Query1.EOF and Query2.EOF);
end;

procedure TQRLInformeVentasSemanal.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  ComparaDatos;
  if (orden = 1) or (orden = 0) then
  begin
    acum_kilos_act := acum_kilos_act + Query1.FieldByName('kilos').AsFloat;
    acum_importe_act := acum_importe_act + (Query1.FieldByName('kilos').AsFloat * Query1.FieldByName('precio').AsFloat);
  end;
  if (orden = 2) or (orden = 0) then
  begin
    acum_kilos_ant := acum_kilos_ant + Query2.FieldByName('kilos').AsFloat;
    acum_importe_ant := acum_importe_ant + (Query2.FieldByName('kilos').AsFloat * Query2.FieldByName('precio').AsFloat);
  end;
end;

procedure TQRLInformeVentasSemanal.ComparaDatos;
begin
  orden := 0;
  if Query1.EOF and Query2.EOF then
  begin
    orden := 0;
  end
  else
    if Query1.EOF then
    begin
      orden := 2;
    end
    else
      if Query2.EOF then
      begin
        orden := 1;
      end
      else
        if Query1.FieldByName('empresa').AsString + Query1.FieldByName('producto').AsString <>
          Query2.FieldByName('empresa').AsString + Query2.FieldByName('producto').AsString then
        begin
          if Query1.FieldByName('empresa').AsString + Query1.FieldByName('producto').AsString >
            Query2.FieldByName('empresa').AsString + Query2.FieldByName('producto').AsString then
            orden := 1
          else
            orden := 2;
        end
        else
          if Query1.FieldByName('envase').AsString <> Query2.FieldByName('envase').AsString then
          begin
            if Query1.FieldByName('envase').AsString < Query2.FieldByName('envase').AsString then
              orden := 1
            else
              orden := 2;
          end;
end;

procedure TQRLInformeVentasSemanal.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  flag1 := false; //Para comprobar q eno estamos en el primer registro encara
  flag2 := false;

  Query1.First;
  Query2.First;

  acum_kilos_ant := 0;
  acum_kilos_act := 0;
  acum_importe_ant := 0;
  acum_importe_act := 0;

  ComparaDatos;
  if orden = 2 then
    grupo := Query2.FieldByName('empresa').AsString + Query2.FieldByName('producto').AsString
  else
    grupo := Query1.FieldByName('empresa').AsString + Query1.FieldByName('producto').AsString;
end;

procedure TQRLInformeVentasSemanal.empresaPrint(sender: TObject;
  var Value: string);
begin
  if orden = 2 then
    Value := Query2.FieldByName('empresa').Text
  else
    Value := Query1.FieldByName('empresa').Text;
end;

procedure TQRLInformeVentasSemanal.productoPrint(sender: TObject;
  var Value: string);
begin
  if orden = 2 then
    Value := Query2.FieldByName('producto').Text
  else
    Value := Query1.FieldByName('producto').Text;
end;

procedure TQRLInformeVentasSemanal.envasePrint(sender: TObject;
  var Value: string);
begin
  if orden = 2 then
    Value := Query2.FieldByName('envase').Text
  else
    Value := Query1.FieldByName('envase').Text;
end;

procedure TQRLInformeVentasSemanal.QRDBText5Print(sender: TObject;
  var Value: string);
begin
  if orden = 1 then
    Value := '';
end;

procedure TQRLInformeVentasSemanal.QRDBText6Print(sender: TObject;
  var Value: string);
begin
  if orden = 1 then
    Value := '';
end;

procedure TQRLInformeVentasSemanal.QRDBText7Print(sender: TObject;
  var Value: string);
begin
  if orden = 2 then
    Value := '';
end;

procedure TQRLInformeVentasSemanal.QRDBText8Print(sender: TObject;
  var Value: string);
begin
  if orden = 2 then
    Value := '';
end;

procedure TQRLInformeVentasSemanal.QRDBText9Print(sender: TObject;
  var Value: string);
begin
  case orden of
    0: Value := FormatFloat('#,##0.00', Query1.FieldByName('kilos').AsFloat - Query2.FieldByName('kilos').AsFloat);
    1: Value := FormatFloat('#,##0.00', Query1.FieldByName('kilos').AsFloat);
    2: Value := FormatFloat('#,##0.00', -Query2.FieldByName('kilos').AsFloat);
  end;
end;

procedure TQRLInformeVentasSemanal.QRDBText10Print(sender: TObject;
  var Value: string);
begin
  case orden of
    0: Value := FormatFloat('#,##0.000', Query1.FieldByName('precio').AsFloat - Query2.FieldByName('precio').AsFloat);
    1: Value := FormatFloat('#,##0.000', Query1.FieldByName('precio').AsFloat);
    2: Value := FormatFloat('#,##0.000', -Query2.FieldByName('precio').AsFloat);
  end;
end;

procedure TQRLInformeVentasSemanal.des_envasePrint(sender: TObject;
  var Value: string);
begin
  if orden = 2 then
    Value := Query2.FieldByName('envase').Text + ' ' + DesEnvaseP(Query2.FieldByName('empresa').AsString, Query2.FieldByName('envase').Text, Query2.FieldByName('producto').Text )
  else
    Value := Query1.FieldByName('envase').Text + ' ' + DesEnvaseP(Query1.FieldByName('empresa').AsString, Query1.FieldByName('envase').Text, Query1.FieldByName('producto').Text );
end;

procedure TQRLInformeVentasSemanal.ChildBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  actual: string;
begin
  case orden of
    0:
      begin
        if not Query1.Eof then
        begin
          Query1.Next;
          flag1 := true;
        end;
        if not Query2.Eof then
        begin
          Query2.Next;
          flag2 := true;
        end;
      end;
    1:
      if not Query1.Eof then
      begin
        Query1.Next;
        flag1 := true;
      end;
    2:
      if not Query2.Eof then
      begin
        Query2.Next;
        flag2 := true;
      end;
  end;
  ComparaDatos;
  if orden = 2 then
    actual := Query2.FieldByName('empresa').AsString + Query2.FieldByName('producto').AsString
  else
    actual := Query1.FieldByName('empresa').AsString + Query1.FieldByName('producto').AsString;

  if grupo <> actual then
  begin
    aux_grupo := grupo;
    grupo := actual;
    PrintBand := true;
  end
  else
  begin
    PrintBand := false;
  end;

  case orden of
    0:
      begin
        if not Query1.Eof then
        begin
          Query1.Prior;
        end;
        if not Query2.Eof then
        begin
          Query2.Prior;
        end;
      end;
    1:
      if not Query1.Eof then
      begin
        Query1.Prior;
      end;
    2:
      if not Query2.Eof then
      begin
        Query2.Prior;
      end;
  end;
end;

procedure TQRLInformeVentasSemanal.ChildBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if BandPrinted then
  begin
    acum_kilos_ant := 0;
    acum_kilos_act := 0;
    acum_importe_ant := 0;
    acum_importe_act := 0;
  end;
  case orden of
    0:
      begin
        if flag1 then
          Query1.Next;
        if flag2 then
          Query2.Next;
      end;
    1:
      if flag1 then
        Query1.Next;
    2:
      if flag2 then
        Query2.Next;
  end;
end;

procedure TQRLInformeVentasSemanal.QRLabel4Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', acum_kilos_ant);
end;

procedure TQRLInformeVentasSemanal.QRLabel5Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', acum_kilos_act);
end;

procedure TQRLInformeVentasSemanal.QRLabel6Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', acum_kilos_act - acum_kilos_ant);
end;

procedure TQRLInformeVentasSemanal.QRLabel7Print(sender: TObject;
  var Value: string);
begin
  if acum_kilos_ant = 0 then
    Value := '0'
  else
    Value := FormatFloat('#,##0.000', acum_importe_ant / acum_kilos_ant);
end;

procedure TQRLInformeVentasSemanal.QRLabel8Print(sender: TObject;
  var Value: string);
begin
  if acum_kilos_act = 0 then
    Value := '0'
  else
    Value := FormatFloat('#,##0.000', acum_importe_act / acum_kilos_act);
end;

procedure TQRLInformeVentasSemanal.QRLabel9Print(sender: TObject;
  var Value: string);
var
  aux1, aux2: real;
begin
  if (acum_kilos_act) = 0 then
    aux1 := 0
  else
    aux1 := acum_importe_act / acum_kilos_act;

  if (acum_kilos_ant) = 0 then
    aux2 := 0
  else
    aux2 := acum_importe_ant / acum_kilos_ant;

  Value := FormatFloat('#,##0.000', aux1 - aux2);
end;

procedure TQRLInformeVentasSemanal.QRLabel1Print(sender: TObject;
  var Value: string);
begin
  Value := 'FIN PRODUCTO ' + QuotedStr(Copy(aux_grupo, 4, 3));
end;

procedure TQRLInformeVentasSemanal.QRLabel2Print(sender: TObject;
  var Value: string);
begin
  Value := 'FIN PRODUCTO ' + QuotedStr(Copy(grupo, 4, 3));
end;

procedure TQRLInformeVentasSemanal.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := Grupo <> '';
end;

procedure TQRLInformeVentasSemanal.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( Query1.FieldByName('empresa').AsString, Value );
  if Trim(Value) <> 'TOMATE' then
  begin
    Value:= StringReplace( Value, 'TOMATE', 'T.', [] );
  end;
  Value:= Copy( Value, 1, 13 );
end;

end.
