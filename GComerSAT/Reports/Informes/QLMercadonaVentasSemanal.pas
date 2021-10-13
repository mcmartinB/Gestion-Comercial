unit QLMercadonaVentasSemanal;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DBClient, Provider, DB,
  DBTables;

type
  TQRLMercadonaVentasSemanal = class(TQuickRep)
    Query1: TQuery;
    Query2: TQuery;
    QRSubDetail1: TQRSubDetail;
    ColumnHeaderBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    QRLabel25: TQRLabel;
    ChildBand1: TQRChildBand;
    lblCliente: TQRLabel;
    ChildBand3: TQRChildBand;
    lblSemana: TQRLabel;
    QRLabel17: TQRLabel;
    SemanaAnterior: TQRLabel;
    QRLabel19: TQRLabel;
    SemanaActual: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel20: TQRLabel;
    QRLblDescripcion: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText1: TQRDBText;
    QRShape1: TQRShape;
    lblKilosAnt: TQRLabel;
    lblPrecioAnt: TQRLabel;
    lblKilosAct: TQRLabel;
    lblPrecioAct: TQRLabel;
    lblDifKilos: TQRLabel;
    lblPorcenKilos: TQRLabel;
    lblDifPrecio: TQRLabel;
    lblPorcenPrecio: TQRLabel;
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
    procedure QRSubDetail1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRLblDescripcionPrint(sender: TObject; var Value: string);
    procedure QRDBText2Print(sender: TObject; var Value: string);
    procedure QRDBText1Print(sender: TObject; var Value: string);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr1Print(sender: TObject; var Value: String);
  private
    orden: integer;
    bSeparaPlatano, bUnirTyE: boolean;
    iSeparador: integer;

    kilosAnt, kilosAct, importeAnt, importeAct: Real;

    procedure ComparaDatos;
    function DesVentaMercadona: string;
    procedure PrintTotales;
    //function ImprimirTotales: integer;
  public
    procedure PreparaQuery( const ASuministro, AProducto: string; const AUnirTyE: Boolean );
    procedure AbrirQuery1( const ACliente, ASuministro, AProducto: string; const AFechaIni, AFechaFin: TDateTime );
    procedure AbrirQuery2( const ACliente, ASuministro, AProducto: string; const AFechaIni, AFechaFin: TDateTime );

  end;

var
  QRLMercadonaVentasSemanal: TQRLMercadonaVentasSemanal;

implementation

{$R *.DFM}

uses UDMbaseDatos, UDMAuxDB, CVariables, bMath, UDMConfig;


procedure TQRLMercadonaVentasSemanal.AbrirQuery1( const ACliente, ASuministro, AProducto: string; const AFechaIni, AFechaFin: TDateTime );
begin
  Query1.ParamByName('cliente').AsString := ACliente;
  Query1.ParamByName('fechaini').AsDate := AFechaIni;
  Query1.ParamByName('fechafin').AsDate := AFechaFin;
  if ASuministro <> '' then
    Query1.ParamByName('suministro').AsString := ASuministro;
  if AProducto <> '' then
    Query1.ParamByName('producto').AsString := AProducto;
end;

procedure TQRLMercadonaVentasSemanal.AbrirQuery2( const ACliente, ASuministro, AProducto: string; const AFechaIni, AFechaFin: TDateTime );
begin
  Query2.ParamByName('cliente').AsString := ACliente;
  Query2.ParamByName('fechaini').AsDate := AFechaIni;
  Query2.ParamByName('fechafin').AsDate := AFechaFin;
  if ASuministro <> '' then
    Query2.ParamByName('suministro').AsString := ASuministro;
  if AProducto <> '' then
    Query2.ParamByName('producto').AsString := AProducto;
end;

procedure TQRLMercadonaVentasSemanal.PreparaQuery( const ASuministro, AProducto: string; const AUnirTyE: Boolean );
begin
  bUnirTyE:= AUnirTyE;
    with Query1 do
    begin
      SQL.Clear;
      SQL.Add(' select  ');
      //SQL.Add('        case when empresa_sl = ''037''  then 50 else 0 end +  ');
      SQL.Add('        case when empresa_sl = ''037''  then 201 ');
      SQL.Add('             when empresa_sl = ''073''  then 101 ');
      SQL.Add('             else 0 end +  ');

      SQL.Add('        case when empresa_sl = ''050'' AND producto_sl = ''TOM'' then 1 ');
      SQL.Add('             when empresa_sl = ''050'' AND producto_sl = ''TCH'' then 2 ');
      SQL.Add('             when empresa_sl = ''050'' AND producto_sl = ''TCP'' then 3 ');
      SQL.Add('             when empresa_sl = ''050'' AND producto_sl = ''TPE'' then 4 ');
      SQL.Add('             when empresa_sl = ''050'' AND producto_sl = ''RAM'' then 5 ');
      SQL.Add('             when empresa_sl = ''050'' AND producto_sl = ''RAF'' then 6 ');
      SQL.Add('             when empresa_sl = ''050'' AND producto_sl = ''TVA'' then 7 ');

      SQL.Add('             when empresa_sl = ''037'' AND producto_sl = ''PLA'' then 1 ');
      SQL.Add('             when empresa_sl = ''037'' AND producto_sl = ''BAN'' then 2 ');

      SQL.Add('             else 10 + producto_base_p');
      SQL.Add('        end orden, ');


      (* MODIFICADO POR PETICION VANESSA 17/04/2009
         para tomate M con envase 422 nueva grupo de tomate RAF GRANEL
      *)
      (* MODIFICADO POR PETICION ROSANA 20/04/2009
         para banana B con envase 312 nueva grupo de BANANA GRANEL
         -> Se anula por la siguiente modificacion
         SQL.Add('             when ( empresa_sl = ''037'' and producto_sl = ''B'' AND envase_sl = 312 ) then ''G'' ');
      *)
      (* MODIFICADO POR PETICION ROSANA 8/06/2009
         para Maset se genera un nuevo grupo GRANEL para todos los envases que tengan la palabra
         GRANEL en su descripcion
      *)
      (* MODIFICADO POR PETICION CAROLINA 13/07/2009
         429 PERA GRANEL
         431 415 434 ENSALADA GRANEL
         428 MADURO
         423 424 CANARIO GRANEL
      *)
      (* MODIFICADO POR PETICION CAROLINA 23/07/2009
         437 TOMATE MIXTO GRANEL
         317 319 320 321 PLATANO GRANEL

         MODIFICADO POR PETICION CAROLINA 27/07/2009 y 29/07/2009
         436 TOMATE MIXTO GRANEL
         438 TOMATE MADURO

         MODIFICADO POR PETICION ROSANA 11/08/2009
         442 TOMATE ENTREVERADO
      *)
      (* MODIFICADO POR PETICION CAROLINA 24/09/2009
         para Maset se genera un nuevo grupo GRANEL para todos los envases que tengan la palabra
         GRANEL en su descripcion
      *)
      (* MODIFICADO POR PETICION SARAH/TERESA 09/08/2010
         //- unificar productos, solo separar en ensalada/canario
      *)
      SQL.Add('        case  ');
      SQL.Add('             when ( empresa_sl = ''050'' AND envase_sl IN ( 442 ) )  then ''EV'' ');
      //-SQL.Add('             when ( empresa_sl = ''050'' AND envase_sl IN ( 431, 415, 434 ) )  then ''EG'' ');
      SQL.Add('             when ( empresa_sl = ''050'' AND envase_sl IN ( 428, 438 ) )  then ''M'' ');
      SQL.Add('             when ( empresa_sl = ''050'' AND envase_sl IN ( 436, 437 ) )  then ''MG'' ');
      //-SQL.Add('             when ( empresa_sl = ''050'' AND envase_sl IN ( 302 ) )  then ''CM'' ');
      //-SQL.Add('             when ( empresa_sl = ''050'' AND envase_sl IN ( 423, 424, 435, 439, 440 ) )  then ''CG'' ');
      SQL.Add('             when ( empresa_sl = ''050'' and ( producto_sl = ''TOM'' OR producto_sl = ''TOM'' ) ) AND UPPER(descripcion_e) like ''%ENS%'' AND categoria_sl = ''1''  then ''TOM'' ');
      SQL.Add('             when ( empresa_sl = ''050'' and ( producto_sl = ''TOM'' OR producto_sl = ''TOM'' ) ) AND (UPPER(descripcion_e) like ''%CAN%'' or UPPER(descripcion_e)like ''%UNTAR%'' ) AND categoria_sl = ''1'' then ''TCH'' ');
      //-SQL.Add('             when ( empresa_sl = ''050'' AND ( (UPPER(descripcion_e) like ''%GRANEL%'') ) OR ');
      //-SQL.Add('                                               (envase_sl IN ( 422, 429, 432 ) ) )  then ''G'' ');
      SQL.Add('             else ''O'' ');
      SQL.Add('        end grupo, ');
      SQL.Add('        case when producto_sl = ''TOM'' or producto_sl = ''TOM'' then categoria_sl else ''I'' end categoria, ');
      SQL.Add('        empresa_sl empresa, ');
      if AUnirTyE then
      begin
        SQL.Add('        case when producto_sl = ''TOM'' then ''TOM'' ');
        SQL.Add('             else producto_sl ');
        SQL.Add('        end producto, ');
      end
      else
      begin
        SQL.Add('        producto_sl producto, ');
      end;

      (* MODIFICADO POR PETICION CAROLINA 23/03/2009
      SQL.Add('        case when ( empresa_sl <> ''050'' and producto_sl <> ''P'' and producto_sl <> ''B'') then ''U'' ');
      SQL.Add('             else ''K'' end ');
      SQL.Add('        unidad, ');
      SQL.Add('        sum( case when ( empresa_sl <> ''050'' and producto_sl <> ''P'' and producto_sl <> ''B'') then ( cajas_sl * unidades_caja_sl ) ');
      SQL.Add('             else ( kilos_sl ) end ) ');
      SQL.Add('        kilos, ');
      *)
      SQL.Add('        case when empresa_sl = ''073'' then ''U'' else ''K'' end unidad, ');
      SQL.Add('        sum( case when empresa_sl = ''073'' then cajas_sl * unidades_caja_sl else kilos_sl end ) kilos, ');

      SQL.Add('        sum(importe_neto_sl) importe ');

      SQL.Add(' from frf_salidas_c, frf_salidas_l, frf_productos, frf_envases ');

      SQL.Add(' where cliente_sal_sc = :cliente ');
      SQL.Add(' and fecha_sc between :fechaini and :fechafin ');

      SQL.Add(' and empresa_sc = empresa_sl ');
      SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      SQL.Add(' and fecha_sc = fecha_sl ');
      SQL.Add(' and n_albaran_sc = n_albaran_sl ');

      if ASuministro <> '' then
        SQL.Add(' and dir_sum_sc = :suministro ');
      if AProducto <> '' then
        SQL.Add(' and producto_sl = :producto ');

      SQL.Add(' and not ( empresa_sl = ''050'' and ( producto_sl = ''B'' or producto_sl = ''H'' ) )');

      SQL.Add(' and producto_p = producto_sl ');

      SQL.Add(' and producto_e = producto_p ');
      SQL.Add(' and envase_e = envase_sl ');

      SQL.Add(' group by 1, 2, 3, 4, 5, 6  ');
      SQL.Add(' order by 1, 2 desc, 3  ');
    end;
  with Query2 do
  begin
    SQL.Clear;
    SQL.Add(Query1.SQL.Text);
  end;
end;

procedure TQRLMercadonaVentasSemanal.QRSubDetail1NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData := not (Query1.EOF and Query2.EOF);
end;

procedure TQRLMercadonaVentasSemanal.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  rPrecio: real;
begin
  ComparaDatos;
  if (orden = 1) or (orden = 0) then
  begin
    kilosAct := kilosAct + Query1.FieldByName('kilos').AsFloat;
    if Query1.FieldByName('kilos').AsFloat = 0 then
      rPrecio:= 0
    else
      rPrecio:= bRoundTo( Query1.FieldByName('importe').AsFloat / Query1.FieldByName('kilos').AsFloat, -3 );
    importeAct := importeAct + ( rPrecio * Query1.FieldByName('kilos').AsFloat);
  end;
  if (orden = 2) or (orden = 0) then
  begin
    kilosAnt := kilosAnt + Query2.FieldByName('kilos').AsFloat;
    if Query2.FieldByName('kilos').AsFloat = 0 then
      rPrecio:= 0
    else
      rPrecio:= bRoundTo( Query2.FieldByName('importe').AsFloat / Query2.FieldByName('kilos').AsFloat, -3 );
    importeAnt := importeAnt + ( rPrecio * Query2.FieldByName('kilos').AsFloat);
  end;
end;

procedure TQRLMercadonaVentasSemanal.ComparaDatos;
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
        if Query1.FieldByName('orden').AsString <> Query2.FieldByName('orden').AsString then
        begin
          if Query1.FieldByName('orden').AsInteger < Query2.FieldByName('orden').AsInteger then
            orden := 1
          else
            orden := 2;
        end
        else
            if Query1.FieldByName('grupo').AsString <> Query2.FieldByName('grupo').AsString then
            begin
              if Query1.FieldByName('grupo').AsString > Query2.FieldByName('grupo').AsString then
                orden := 1
              else
                orden := 2;
            end
            else
                if Query1.FieldByName('categoria').AsString <> Query2.FieldByName('categoria').AsString then
                begin
                  if Query1.FieldByName('categoria').AsString < Query2.FieldByName('categoria').AsString then
                    orden := 1
                  else
                    orden := 2;
                end;
end;

procedure TQRLMercadonaVentasSemanal.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  Query1.First;
  Query2.First;

  kilosAct := 0;
  kilosAnt := 0;
  importeAct := 0;
  importeAnt := 0;
  (*
  bFinTomate := false;
  bFinPlatano := false;
  *)
  ComparaDatos;
  iSeparador:= 1;
  bSeparaPlatano:= false;
end;

procedure TQRLMercadonaVentasSemanal.empresaPrint(sender: TObject;
  var Value: string);
begin
  if orden = 2 then
    Value := Query2.FieldByName('empresa').Text
  else
    Value := Query1.FieldByName('empresa').Text;
end;

procedure TQRLMercadonaVentasSemanal.productoPrint(sender: TObject;
  var Value: string);
begin
  if orden = 2 then
    Value := Query2.FieldByName('producto').Text
  else
    Value := Query1.FieldByName('producto').Text;
end;

procedure TQRLMercadonaVentasSemanal.envasePrint(sender: TObject;
  var Value: string);
begin
  if orden = 2 then
    Value := Query2.FieldByName('envase').Text
  else
    Value := Query1.FieldByName('envase').Text;
end;

procedure TQRLMercadonaVentasSemanal.QRDBText5Print(sender: TObject;
  var Value: string);
begin
  if orden = 1 then
    Value := '';
end;

procedure TQRLMercadonaVentasSemanal.QRDBText6Print(sender: TObject;
  var Value: string);
begin
  if orden = 1 then
    Value := ''
  else
  begin
    if Query2.FieldByName('kilos').AsFloat = 0 then
      Value := FormatFloat( '#,##0.000', 0 )
    else
      Value := FormatFloat( '#,##0.000', Query2.FieldByName('importe').AsFloat / Query2.FieldByName('kilos').AsFloat );
  end;
end;

procedure TQRLMercadonaVentasSemanal.QRDBText7Print(sender: TObject;
  var Value: string);
begin
  if orden = 2 then
    Value := '';
end;

procedure TQRLMercadonaVentasSemanal.QRDBText8Print(sender: TObject;
  var Value: string);
begin
  if orden = 2 then
    Value := ''
  else
  begin
    if Query1.FieldByName('kilos').AsFloat = 0 then
      Value := FormatFloat( '#,##0.000', 0 )
    else
      Value := FormatFloat( '#,##0.000', Query1.FieldByName('importe').AsFloat / Query1.FieldByName('kilos').AsFloat );
  end;
end;

procedure TQRLMercadonaVentasSemanal.QRDBText9Print(sender: TObject;
  var Value: string);
begin
  case orden of
    0: Value := FormatFloat('#,##0.00', Query1.FieldByName('kilos').AsFloat - Query2.FieldByName('kilos').AsFloat);
    1: Value := FormatFloat('#,##0.00', Query1.FieldByName('kilos').AsFloat);
    2: Value := FormatFloat('#,##0.00', -Query2.FieldByName('kilos').AsFloat);
  end;
end;

procedure TQRLMercadonaVentasSemanal.QRDBText10Print(sender: TObject;
  var Value: string);
var
  rPrecio1, rPrecio2: real;
begin
  if Query1.FieldByName('kilos').AsFloat = 0 then
    rPrecio1:= 0
  else
    rPrecio1:= bRoundTo( Query1.FieldByName('importe').AsFloat / Query1.FieldByName('kilos').AsFloat, -3 );
  if Query2.FieldByName('kilos').AsFloat = 0 then
    rPrecio2:= 0
  else
    rPrecio2:= bRoundTo( Query2.FieldByName('importe').AsFloat / Query2.FieldByName('kilos').AsFloat, -3 );

  case orden of
    0: Value := FormatFloat('#,##0.000', rPrecio1 - rPrecio2);
    1: Value := FormatFloat('#,##0.000', rPrecio1);
    2: Value := FormatFloat('#,##0.000', -rPrecio2);
  end;
end;

procedure TQRLMercadonaVentasSemanal.QRSubDetail1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  case orden of
    0:
      begin
        Query1.Next;
        Query2.Next;
      end;
    1: Query1.Next;
    2: Query2.Next;
  end;
end;


function TQRLMercadonaVentasSemanal.DesVentaMercadona: string;
var
  aux: TQuery;
  sAux: string;
begin
  if orden = 2 then
    aux := Query2
  else
    aux := Query1;

  result := DesProducto(aux.FieldByName('empresa').Text, aux.FieldByName('producto').Text);
  if ( aux.FieldByName('producto').Text = 'TOM' ) or ( aux.FieldByName('producto').Text = 'TOM' ) then
  begin
    if bUnirTyE then
    begin
      sAux:= '';
    end
    else
    begin
      sAux:= aux.FieldByName('producto').Text + ' - ';
    end;

    if aux.FieldByName('categoria').Text = '2' then
    begin
      if aux.FieldByName('grupo').Text = 'M' then
        result := sAux + 'TOMATE MADURO GRANEL'
      else
        result := sAux + 'BELE';
    end
    else
    begin
      if aux.FieldByName('grupo').Text = 'EV' then
        result := sAux + 'TOMATE ENTREVERADO'
      else
      if aux.FieldByName('grupo').Text = 'M' then
        result := sAux + 'TOMATE MADURO GRANEL'
      else
      if aux.FieldByName('grupo').Text = 'EG' then
        result := sAux + 'TOMATE ENSALADA GRANEL'
      else
      if aux.FieldByName('grupo').Text = 'CG' then
        result := sAux + 'TOMATE CANARIO GRANEL'
      else
      if aux.FieldByName('grupo').Text = 'MG' then
        result := sAux + 'TOMATE MIXTO GRANEL'
      else
      if aux.FieldByName('grupo').Text = 'E' then
        result := sAux + 'TOMATE ENSALADA'
      else
      if aux.FieldByName('grupo').Text = 'C' then
        result := sAux + 'TOMATE CANARIO'
      else
      if aux.FieldByName('grupo').Text = 'CM' then
        result := sAux + 'TOMATE CANARIO MALLA';
    end;
  end;

  if aux.FieldByName('grupo').Text = 'G' then
    result := result + ' GRANEL';

  if aux.FieldByName('unidad').Text = 'U' then
  begin
    if ( aux.FieldByName('empresa').Text = '073' ) and
       ( aux.FieldByName('producto').Text = 'TOM' ) then
    begin
      result:= 'TOMATE RALLADO (POR UNIDAD)';
    end
    else
    begin
      result:= result + ' (POR UNIDAD)';
    end;
  end;
end;

procedure TQRLMercadonaVentasSemanal.QRLblDescripcionPrint(sender: TObject;
  var Value: string);
begin
  Value := DesVentaMercadona;
end;

procedure TQRLMercadonaVentasSemanal.QRDBText2Print(sender: TObject;
  var Value: string);
begin
  case orden of
    0: Value := FormatFloat('#,##0.00', ((Query1.FieldByName('kilos').AsFloat - Query2.FieldByName('kilos').AsFloat) / Query2.FieldByName('kilos').AsFloat) * 100) + '%';
    1: Value := FormatFloat('#,##0.00', 100) + '%';
    2: Value := FormatFloat('#,##0.00', -100) + '%';
  end;
end;

procedure TQRLMercadonaVentasSemanal.QRDBText1Print(sender: TObject;
  var Value: string);
var
  rPrecio1, rPrecio2: real;
begin
  if Query1.FieldByName('kilos').AsFloat = 0 then
    rPrecio1:= 0
  else
    rPrecio1:= bRoundTo( Query1.FieldByName('importe').AsFloat / Query1.FieldByName('kilos').AsFloat, -3 );
  if Query2.FieldByName('kilos').AsFloat = 0 then
    rPrecio2:= 0
  else
    rPrecio2:= bRoundTo( Query2.FieldByName('importe').AsFloat / Query2.FieldByName('kilos').AsFloat, -3 );

  case orden of
    0: Value := FormatFloat('#,##0.00', ((rPrecio1 - rPrecio2) / rPrecio2) * 100) + '%';
    1: Value := FormatFloat('#,##0.00', 100) + '%';
    2: Value := FormatFloat('#,##0.00', -100) + '%';
  end;
end;


procedure TQRLMercadonaVentasSemanal.PrintTotales;
var
  precioAct, precioAnt: real;
begin
  lblKilosAct.Caption := FormatFloat('#,##0.00', kilosAct);
  lblKilosAnt.Caption := FormatFloat('#,##0.00', kilosAnt);

  if kilosAct = 0 then
  begin
    precioAct := 0;
  end
  else
  begin
    precioAct := importeAct / kilosAct;
  end;
  if kilosAnt = 0 then
  begin
    precioAnt := 0;
    lblPorcenKilos.Caption := FormatFloat('#,##0.00', 0) + '%';
    lblPorcenPrecio.Caption := FormatFloat('#,##0.00', 0) + '%';
  end
  else
  begin
    precioAnt := importeAnt / kilosAnt;
    lblPorcenKilos.Caption := FormatFloat('#,##0.00', ((kilosAct - kilosAnt) / kilosAnt) * 100) + '%';
    lblPorcenPrecio.Caption := FormatFloat('#,##0.00', ((precioAct - precioAnt) / precioAnt) * 100) + '%';
  end;

  lblPrecioAct.Caption := FormatFloat('#,##0.00', precioAct);
  lblPrecioAnt.Caption := FormatFloat('#,##0.00', precioAnt);

  lblDifKilos.Caption := FormatFloat('#,##0.00', kilosAct - kilosAnt);
  lblDifPrecio.Caption := FormatFloat('#,##0.00', precioAct - precioAnt);

  kilosAnt:= 0;
  kilosAct:= 0;
  importeAnt:= 0;
  importeAct:= 0;
end;

procedure TQRLMercadonaVentasSemanal.ChildBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  iOrdenAux: Integer;
begin
  if Query1.Eof and Query2.Eof then
  begin
    PrintBand:= True;
  end
  else
  begin
    if Query1.Eof then
    begin
      iOrdenAux:= Query2.FieldByName('orden').AsInteger;
    end
    else
    if Query2.Eof then
    begin
      iOrdenAux:= Query1.FieldByName('orden').AsInteger;
    end
    else
    if Query1.FieldByName('orden').AsInteger > Query2.FieldByName('orden').AsInteger then
    begin
      iOrdenAux:= Query2.FieldByName('orden').AsInteger;
    end
    else
    begin
      iOrdenAux:= Query1.FieldByName('orden').AsInteger;
    end;

    PrintBand:= ( iSeparador * 100 ) < iOrdenAux;
    if not bSeparaPlatano and not PrintBand then
    begin
      PrintBand:= iOrdenAux > 210;
      bSeparaPlatano:= PrintBand;
    end;
  end;

  if PrintBand then
  begin
    iSeparador:= iSeparador + 1;
    PrintTotales;
  end;
end;

procedure TQRLMercadonaVentasSemanal.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + DesEmpresa( value );
end;

end.
