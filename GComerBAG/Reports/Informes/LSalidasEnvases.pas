unit LSalidasEnvases;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLSalidasEnvases = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRSysData1: TQRSysData;
    QRBCabeceraGrupo1: TQRGroup;
    QRBCabeceraGrupo2: TQRGroup;
    QRBPieGrupo1: TQRBand;
    QRBPieGrupo2: TQRBand;
    SummaryBand1: TQRBand;
    BDesglose: TQRChildBand;
    PsQRExpr1: TQRExpr;
    QRDBCliente: TQRDBText;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    lblPeriodo: TQRLabel;
    PsQRLabel15: TQRLabel;
    ChildBand1: TQRChildBand;
    PsQRLabel2: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    PsQRDBText8: TQRDBText;
    QSalidasEnvases: TQuery;
    QRLDesLogifruit: TQRLabel;
    ChildBand2: TQRChildBand;
    ChildBand3: TQRChildBand;
    QRMLogifruit: TQRMemo;
    QRLTotalLogifruit: TQRLabel;
    QRLabel2: TQRLabel;
    lblClientes: TQRLabel;
    qrlblOperador: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    procedure QRLSalidasEnvasesBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBClientePrint(sender: TObject; var Value: string);
    procedure PsQRLabel15Print(sender: TObject; var Value: string);
    procedure PsQRDBText3Print(sender: TObject; var Value: string);
    procedure BDesgloseBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRDBText4Print(sender: TObject; var Value: string);
    procedure PsQRLabel13Print(sender: TObject; var Value: string);
    procedure PsQRDBText6Print(sender: TObject; var Value: string);
    procedure PsQRDBText7Print(sender: TObject; var Value: string);
    procedure PsQRDBText8Print(sender: TObject; var Value: string);
    procedure QRBCabeceraGrupo2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
  private
    cli, dir, dir_ant, cod: string;
    direcciones: TStringList;
    matriz: array of array of integer;
    impreso: boolean;
    //para que no se repita la direccion de suministro, albaran y fecha
    direccion, albaran, fecha: string;

    caja1, caja2, caja3, caja4, caja5, caja6, caja7: integer;
  public
    sEmpresa: string;
    iDirecciones: integer;

    destructor Destroy; override;
  end;

var
  QRLSalidasEnvases: TQRLSalidasEnvases;

implementation



uses LFSalidasEnvases, UDMAuxDB, bTextUtils;

{$R *.DFM}

destructor TQRLSalidasEnvases.Destroy;
begin
  QSalidasEnvases.Close;
  inherited;
end;

//******************************  REPORT  *************************************

procedure TQRLSalidasEnvases.QRLSalidasEnvasesBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  cli := '';
  dir := '';
  dir_ant := '';
     //para que no se repita la direccion de suministro, el albaran y la fecha
  direccion := '';
  albaran := '';
  fecha := '';
     //aqui guardo las direcciones de suministro
  direcciones := TSTringList.Create;
     //direcciones.Sorted:=True;
     //direcciones.Duplicates:=dupIgnore;
     //almacena los valores para cada direccion de suministro y para cada codigo de caja
  SetLength(matriz, iDirecciones, 7);

  QRBCabeceraGrupo2.Height := 0;
end;

//************************  CABECERA GRUPO 1  *********************************

procedure TQRLSalidasEnvases.QRDBClientePrint(sender: TObject;
  var Value: string);
begin
  cli := Value;
end;

procedure TQRLSalidasEnvases.PsQRLabel15Print(sender: TObject;
  var Value: string);
begin
  Value := desCliente(cli);
end;

//************************  CABECERA GRUPO 2  *********************************
//esta cabecera de grupo tiene la propiedad Height a 0 para que no se vea

procedure TQRLSalidasEnvases.QRBCabeceraGrupo2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  direccion := '';
  fecha := '';
  albaran := '';
  if QSalidasEnvases.FieldByName('dir_sum_sc').AsString <> dir then
  begin
    direcciones.Add(QSalidasEnvases.FieldByName('dir_sum_sc').AsString);
    dir := QSalidasEnvases.FieldByName('dir_sum_sc').AsString;
  end;
end;

//******************************  DETALLE  ************************************

procedure TQRLSalidasEnvases.PsQRDBText6Print(sender: TObject;
  var Value: string);
begin
  if value = direccion then
    value := ''
  else
    direccion := value;

end;

procedure TQRLSalidasEnvases.PsQRDBText7Print(sender: TObject;
  var Value: string);
begin
  if albaran = value then
    value := ''
  else
    albaran := value;
end;

procedure TQRLSalidasEnvases.PsQRDBText8Print(sender: TObject;
  var Value: string);
begin
  if fecha = value then
    value := ''
  else
    fecha := value;
end;

procedure TQRLSalidasEnvases.PsQRDBText4Print(sender: TObject;
  var Value: string);
begin
  cod := Rellena( Value, 5, '0', taLeftJustify );
end;

procedure TQRLSalidasEnvases.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end
end;

procedure TQRLSalidasEnvases.PsQRDBText3Print(sender: TObject;
  var Value: string);
var i: integer;
begin
    //aqui ir acumulando los kilos por direccion de suministro y por codigo de caja
    //le asigno a la variable el numero de orden de la direccion que a la que se le acumulan las cajas
  if direcciones.Count = 0 then exit;
  i := direcciones.Count - 1;
  if cod = '03416' then
  begin
    matriz[i, 0] := matriz[i, 0] + StrToInt(Value);
    Value := FormatFloat('#,##0', StrToInt(Value));
  end
  else
    if cod = '06412' then
    begin
      matriz[i, 1] := matriz[i, 1] + StrToInt(Value);
      Value := FormatFloat('#,##0', StrToInt(Value));
    end
    else
      if cod = '06418' then
      begin
        matriz[i, 2] := matriz[i, 2] + StrToInt(Value);
        Value := FormatFloat('#,##0', StrToInt(Value));
      end
      else
        if cod = '06424' then
        begin
          matriz[i, 3] := matriz[i, 3] + StrToInt(Value);
          Value := FormatFloat('#,##0', StrToInt(Value));
        end
        else
          if cod = '00618' then
          begin
            matriz[i, 4] := matriz[i, 4] + StrToInt(Value);
            Value := FormatFloat('#,##0', StrToInt(Value));
          end
          else
            if cod = '00624' then
            begin
              matriz[i, 5] := matriz[i, 5] + StrToInt(Value);
              Value := FormatFloat('#,##0', StrToInt(Value));
            end
            else
              if cod = '00316' then
              begin
                matriz[i, 6] := matriz[i, 6] + StrToInt(Value);
                Value := FormatFloat('#,##0', StrToInt(Value));
              end;
end;

//*******************************  SUMARIO  ***********************************

procedure TQRLSalidasEnvases.BDesgloseBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  i: integer;
  sLinea: string;
begin
  if not impreso then
  begin
    caja1 := 0;
    caja2 := 0;
    caja3 := 0;
    caja4 := 0;
    caja5 := 0;
    caja6 := 0;
    caja7 := 0;
    impreso := true;

    QRMLogifruit.Lines.Clear;
    for i := 0 to Direcciones.Count - 1 do
    begin
      sLinea:= RellenaDer(direcciones.Strings[i] + '', 8) + ':';
      //para el tipo de caja 03416
      sLinea:= sLinea + RellenaIzq(FormatFloat('#,##0', matriz[i, 0]), 8);
      //para el tipo de caja 06412
      sLinea:= sLinea + RellenaIzq(FormatFloat('#,##0', matriz[i, 1]), 8);
      //para el tipo de caja 06418
      sLinea:= sLinea + RellenaIzq(FormatFloat('#,##0', matriz[i, 2]), 8);
      //para el tipo de caja 06424
      sLinea:= sLinea + RellenaIzq(FormatFloat('#,##0', matriz[i, 3]), 8);
      //para el tipo de caja 00618
      sLinea:= sLinea + RellenaIzq(FormatFloat('#,##0', matriz[i, 4]), 8);
      //para el tipo de caja 00624
      sLinea:= sLinea + RellenaIzq(FormatFloat('#,##0', matriz[i, 5]), 8);
      //para el tipo de caja 00316
      sLinea:= sLinea + RellenaIzq(FormatFloat('#,##0', matriz[i, 6]), 8);

      caja1 := caja1 + matriz[i, 0];
      caja2 := caja2 + matriz[i, 1];
      caja3 := caja3 + matriz[i, 2];
      caja4 := caja4 + matriz[i, 3];
      caja5 := caja5 + matriz[i, 4];
      caja6 := caja6 + matriz[i, 5];
      caja7 := caja7 + matriz[i, 6];

      QRMLogifruit.Lines.Add( sLinea );
    end;
    QRLDesLogifruit.Caption:= '            03416   06412   06418   06424   00618   00624   00316';
    QRLTotalLogifruit.Caption:= 'TOTAL   :';
    QRLTotalLogifruit.Caption:= QRLTotalLogifruit.Caption +  RellenaIzq(FormatFloat('#,##0', caja1), 8);
    QRLTotalLogifruit.Caption:= QRLTotalLogifruit.Caption +  RellenaIzq(FormatFloat('#,##0', caja2), 8);
    QRLTotalLogifruit.Caption:= QRLTotalLogifruit.Caption +  RellenaIzq(FormatFloat('#,##0', caja3), 8);
    QRLTotalLogifruit.Caption:= QRLTotalLogifruit.Caption +  RellenaIzq(FormatFloat('#,##0', caja4), 8);
    QRLTotalLogifruit.Caption:= QRLTotalLogifruit.Caption +  RellenaIzq(FormatFloat('#,##0', caja5), 8);
    QRLTotalLogifruit.Caption:= QRLTotalLogifruit.Caption +  RellenaIzq(FormatFloat('#,##0', caja6), 8);
    QRLTotalLogifruit.Caption:= QRLTotalLogifruit.Caption +  RellenaIzq(FormatFloat('#,##0', caja7), 8);
  end;
end;

procedure TQRLSalidasEnvases.PsQRLabel13Print(sender: TObject;
  var Value: string);
begin
  Value := 'Total  ' + Cli + ': ';
end;


end.
