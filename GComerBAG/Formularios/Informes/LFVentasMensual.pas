unit LFVentasMensual;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt;

type
  TFLVentasMensual = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LCliente: TLabel;
    BGBCliente: TBGridButton;
    STCliente: TStaticText;
    STEmpresa: TStaticText;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ADesplegarRejilla: TAction;
    EEmpresa: TBEdit;
    ECliente: TBEdit;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    BCBHasta: TBCalendarButton;
    MEHasta: TBEdit;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    GBDatos: TGroupBox;
    EProducto: TBEdit;
    LProducto: TLabel;
    BGBProducto: TBGridButton;
    STProducto: TStaticText;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
  private
      {private declarations}
    lista: TList;
    objeto: TObject;

    moneda: string;

    QInsertar, QGastos: TQuery;
    (*
    //querys dos monedas
    QSalidas, QKilos: TQuery;
    *)

      //procedimientos y funciones generales
    function CamposVacios: boolean;
    function EjecutarConsulta(texto: string): boolean;
    procedure BorrarTemporal;
    procedure Vaciartemporal;
    procedure Imprimir;
    function Temporal: boolean;
    function ConsMoneda: boolean;
    function Abrir(var Consulta: TQuery): boolean;

      //procedimientos y funciones de moneda unica
    function ConsSalidas: boolean;
    function ConsGastos: boolean;
    function ConsKilos: boolean;
    function InsertarGastos: boolean;
    function DatosInforme: boolean;

  public
    { Public declarations }
    consulta: Tquery;
  end;


implementation


uses CVariables, UDMAuxDB, Principal, CAuxiliarDB, UDMCambioMoneda,
  DPreview, UDMBaseDatos, LVentasMensualCat, CReportes;

{$R *.DFM}

procedure TFLVentasMensual.FormCreate(Sender: TObject);
begin

  FormType := tfOther;
  BHFormulario;

  MEDesde.Text := DateToStr(Date - 7);
  MEHasta.Text := DateTostr(Date - 1);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  ECliente.Tag := kCliente;
  EProducto.tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  EEmpresa.Text := gsDefEmpresa;
  ECliente.Text := gsDefCliente;
  EProducto.Text := gsDefProducto;

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;

  Lista := TList.Create;
  GBDatos.GetTabOrderList(Lista);
end;

procedure TFLVentasMensual.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;

  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFLVentasMensual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
  end;
end;

procedure TFLVentasMensual.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

procedure TFLVentasMensual.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente: DespliegaRejilla(BGBCliente, [EEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLVentasMensual.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
    kCliente: STCliente.Caption := desCliente(ECliente.Text);
    kProducto: STProducto.Caption := desProducto(EEmpresa.Text, EProducto.Text)
  end;
end;

procedure TFLVentasMensual.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
  begin
    BorrarTemporal;
    Close;
  end;
end;

procedure TFLVentasMensual.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;
  if CamposVacios then Exit;
  if not Temporal then Exit;

  if ConsMoneda then
  begin
    if not ConsSalidas then Exit;

    if not ConsKilos then Exit;

    ConsGastos;
    if not InsertarGastos then Exit;
       {if  then
       begin

       end;}

    if not DatosInforme then Exit;
    Imprimir;

  end;
  VaciarTemporal;
end;

function TFLVentasMensual.CamposVacios: boolean;
var i: Integer;
begin
  result := False;
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto do
      begin
        if (Trim(Text) = '') then
        begin
          raise Exception.Create('Faltan datos de obligada inserción.');
          result := true;
          Exit;
        end;
      end;
    end;
  end;
end;

function TFLVentasMensual.Abrir(var Consulta: TQuery): boolean;
begin
  try
    Consulta.open;
  except
    on E: EDBEngineError do
    begin
      ShowError(e);
      Result := False;
      Exit;
    end;
  end;
  if Consulta.Bof and Consulta.EOf then
  begin
    ShowError('No existen datos');
    result := false;
    exit;
  end;
  result := true;
end;

//Localizo la descripcion de la moneda, y si tiene mas de una moneda

function TFLVentasMensual.ConsMoneda: boolean;
begin
  moneda:= '';
  result:= False;

  with TQuery.Create(self) do
  begin
    DataBaseName := DMBaseDatos.DBBaseDatos.DatabaseName;
    SQL.Add('select distinct moneda_sc moneda ' +
      ' from frf_salidas_c ' +
      ' where empresa_sc = ' + QuotedStr(Eempresa.Text) +
      ' and   cliente_fac_sc = ' + QuotedStr(Ecliente.Text) +
      ' and   fecha_factura_sc between ' + QuotedStr(MEDesde.Text) +
      ' and ' + QuotedStr(MEHasta.Text) +
      ' and   n_factura_sc is not null ' +
      ' and es_transito_sc <> 2 ');         //Tipo Salida: Devolucion

    try
      open;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        result := False;
        Free;
        exit;
      end;
    end;

    if IsEmpty then
    begin
      ShowMessage('No hay datos para los parametros pasados.');
    end
    else
    begin
      Next;
      if Eof then
      begin
        //Solo hay una moneda
        result:= true;
        moneda:= desMoneda( Fieldbyname('moneda').AsString );
      end
      else
      begin
        ShowMessage('No se puede sacar el listado para clientes con monedas distintas dentro del periodo seleccionado.');
      end;
    end;
    Close;
  end;
end;

function TFLVentasMensual.EjecutarConsulta(texto: string): boolean;
begin
  with TQuery.Create(self) do
  begin
    DataBaseName := DMBaseDatos.DBBaseDatos.DatabaseName;
    SQL.Add(texto);
    try
      ExecSQL;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        result := False;
        Free;
        exit;
      end;
    end;
    result := true;
    Free;
  end;
end;

function TFLVentasMensual.Temporal: boolean;
var texto: string;
begin
  with TTable.Create(self) do
  begin
    DataBaseName := DMBaseDatos.DBBaseDatos.DatabaseName;
    TableName := 'ventas_mensual';
    if Exists then
    begin
      VaciarTemporal;
      result := true;
      Exit;
    end;
  end;
  texto := 'CREATE TEMP TABLE VENTAS_MENSUAL ( ' +
    ' ANYO INTEGER NOT NULL, ' + //año de la fecha de factura
    ' MES INTEGER NOT NULL, ' + //mes de la fecha de factura
    ' PRODUCTO CHAR(3) NOT NULL, ' + //producto seleccionado
    ' KILOS DECIMAL(12,3), ' + //kilos totales de todos los albaranes
    ' KILOS_PR DECIMAL (12,3), ' + //kilos del producto seleccionado
    ' BRUTO DECIMAL(12,3), ' + //precio bruto
    ' NETO DECIMAL (12,3), ' + //precio bruto - gastos
    ' IMPORTE DECIMAL (12,3) ' + //suma del importe total de las lineas del producto
                //**************************
  ' ,CATEGORIA CHAR(2))  ';
                //**************************
  result := EjecutarConsulta(texto);
end;

//Saco los kilos, y el importe neto del producto seleccionado
//agrupado por meses y años

function TFLVentasMensual.ConsSalidas: boolean;
var texto: string;
begin
      //añadir categoria
      //texto:='INSERT INTO VENTAS_MENSUAL (MES,ANYO,PRODUCTO,KILOS_PR,BRUTO,NETO,IMPORTE)'+
  texto := 'INSERT INTO VENTAS_MENSUAL (MES,ANYO,PRODUCTO,CATEGORIA,KILOS_PR,BRUTO,NETO,IMPORTE)' +
    ' select MONTH(fecha_factura_sc), YEAR(fecha_factura_sc) , ' +
    ' producto_sl , categoria_sl , SUM(kilos_sl), ' +
    ' (SUM(importe_neto_sl)/SUM(kilos_sl)) BRUTO,  ' +
    ' (SUM(importe_neto_sl)/SUM(kilos_sl)) NETO, ' +
    '  SUM(importe_neto_sl) ' +
    ' from frf_salidas_c, frf_salidas_l' +
    ' where empresa_sc = ' + QuotedStr(Eempresa.Text) +
    ' and   cliente_fac_sc = ' + QuotedStr(Ecliente.Text) +
    ' and   fecha_factura_sc between ' + QuotedStr(MEDesde.Text) +
    ' and ' + QuotedStr(MEHasta.Text) +
    ' and   producto_sl = ' + QuotedStr(EProducto.Text) +
              //************************************************
  ' and   categoria_sl between "1" and "3" ' +
              //************************************************
  ' and   n_factura_sc is not null ' +
    ' and   empresa_sc = empresa_sl ' +
    ' and   centro_salida_sc = centro_salida_sl ' +
    ' and   n_albaran_sc = n_albaran_sl ' +
    ' and   fecha_sc = fecha_sl ' +
    ' and es_transito_sc <> 2 ' +           //Tipo Salida: Devolucion
  ' group by 1,2,3,4 ';

  result := EjecutarConsulta(texto);
end;

//Inserto el total de kilos de todos los albaranes donde aparezca el producto seleccionado
//, para luego calcular el porcentaje de
//gastos que le corresponde al producto que hemos seleccionado.

function TFLventasMensual.ConsKilos: boolean;
var texto: string;
begin
  texto := 'UPDATE VENTAS_MENSUAL ' +
    ' SET KILOS = (select  SUM(kilos_sl)suma_kilos ' +
    ' from frf_salidas_c, frf_salidas_l ' +
    ' where mes = MONTH(fecha_factura_sc) ' +
    ' and   anyo = YEAR(fecha_factura_sc) ' +
    ' and   empresa_sc = ' + QuotedStr(Eempresa.Text) +
    ' and   cliente_fac_sc = ' + QuotedStr(Ecliente.Text) +
    ' and   fecha_factura_sc between ' + QuotedStr(MEDesde.Text) +
    ' and ' + QuotedStr(MEHasta.Text) +
    ' and   n_factura_sc is not null ' +
    ' and   empresa_sc = empresa_sl ' +
    ' and   centro_salida_sc = centro_salida_sl ' +
    ' and   n_albaran_sc = n_albaran_sl ' +
    ' and   fecha_sc = fecha_sl ' +
    ' and es_transito_sc <> 2 ' +           //Tipo Salida: Devolucion
    ' and   EXISTS (select * from frf_salidas_l ' +
    '                where empresa_sl = empresa_sc ' +
    '                and   centro_salida_sl = centro_salida_sc ' +
    '                and   fecha_sl = fecha_sc ' +
    '                and   n_albaran_sl = n_albaran_sc ' +
    '                and   producto_sl = ' + QuotedStr(EProducto.Text) + '))';
  result := EjecutarConsulta(texto);
end;

//Localizo los gastos de los albaranes por mes

function TFLVentasMensual.ConsGastos: boolean;
begin
  if QGastos = nil then
    QGastos := TQuery.Create(Self);
  with QGastos do
  begin
    Close;
    DatabaseName := DMBaseDatos.DBBaseDatos.DatabaseName;
    SQL.Clear;
    SQL.Add('select MONTH(fecha_factura_sc)MES, ' +
      ' SUM(importe_g) GASTOS, ' +
      ' YEAR(fecha_factura_sc)ANYO ' +
      ' from frf_salidas_c, frf_gastos ' +
      ' where empresa_sc = ' + QuotedStr(Eempresa.Text) +
      ' and   cliente_fac_sc = ' + QuotedStr(Ecliente.Text) +
      ' and   fecha_factura_sc between ' + QuotedStr(MEDesde.Text) +
      ' and ' + QuotedStr(MEHasta.Text) +
      ' and   n_factura_sc is not null ' +
      ' and   empresa_sc = empresa_g ' +
      ' and   centro_salida_sc = centro_salida_g ' +
      ' and   n_albaran_sc = n_albaran_g ' +
      ' and   fecha_sc = fecha_g ' +
      ' and es_transito_sc <> 2 ' +           //Tipo Salida: Devolucion
      ' and   EXISTS (select * from frf_Salidas_l ' +
      '       where empresa_sc = empresa_sl ' +
      '       and   centro_salida_sc = centro_salida_sl ' +
      '       and   n_albaran_sc = n_albaran_sl ' +
      '       and   fecha_sc = fecha_sl ' +
      '       and   producto_sl = ' + QuotedStr(EProducto.Text) + ')' +
      ' group by 1,3 ' +
      ' order by 3,1');
  end;

  try
    QGastos.open;
  except
    on E: EDBEngineError do
    begin
      ShowError(e);
      Result := False;
      Exit;
    end;
  end;
  if QGastos.IsEmpty then
  begin
    result := false;
    exit;
  end;
  result := true;
end;

//Recorro la tabla de gastos y calculo los gastos que le corresponde al producto
//seleccionado.

function TFLVentasMensual.InsertarGastos: boolean;
var mes, A: integer;
  gast: real;
begin
  if Qinsertar = nil then
  begin
    QInsertar := TQuery.Create(self);
    QInsertar.DatabaseName := DMBaseDatos.DBBaseDatos.DatabaseName;
  end;
  QGastos.First;
  while not QGastos.Eof do
  begin
    mes := QGastos.FieldByName('mes').Asinteger;
    gast := QGastos.FieldByName('gastos').AsFloat;
    A := QGastos.FieldByName('anyo').AsInteger;
    QInsertar.Close;
    QInsertar.SQl.Clear;
    QInsertar.SQL.Add('UPDATE VENTAS_MENSUAL ' +
      ' SET NETO = BRUTO -((:gastos)/KILOS) ' +
      ' WHERE MES = ' + IntToStr(MES) +
      ' AND  ANYO = ' + IntToStr(A));
    try
      QInsertar.ParamByName('gastos').AsFloat := gast;
      QInsertar.ExecSQL;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        Result := False;
        Exit;
      end;
    end;
    QGastos.Next;
  end;
  REsult := true;
end;

//Saco los datos de la temporal para mostrarlos en el informe.

function TFLVentasMensual.DatosInforme: boolean;
begin
  if Consulta = nil then
  begin
    Consulta := TQuery.Create(self);
    Consulta.DatabaseName := DMBaseDatos.DBBaseDatos.DatabaseName;
  end;
  with Consulta do
  begin
    Close;
    DatabaseName := DMBaseDatos.DBBaseDatos.DatabaseName;
    SQL.Clear;
        //SQL.Add('SELECT DISTINCT * FROM VENTAS_MENSUAL ORDER BY PRODUCTO,ANYO,MES');
    SQL.Add('SELECT DISTINCT * FROM VENTAS_MENSUAL ORDER BY CATEGORIA,ANYO,MES');
    result := Abrir(Consulta);
  end;
end;

procedure TFLVentasMensual.Imprimir;
begin
  try
     //QRLVentasMensual:=TQRLVentasMensual.Create(Application);
    QRLVentasMensualCat := TQRLVentasMensualCat.Create(Application);
     //with QRLVentasMensual do
    with QRLVentasMensualCat do
    begin
      LEmpresa.Caption := EEmpresa.Text + ' ' + STEmpresa.Caption;
      LCliente.Caption := ECliente.Text + ' ' + STCliente.Caption;
      LPeriodo.Caption := 'DEL ' + MEDesde.Text + ' AL ' + MEHasta.Text;
      lblProducto.Caption:= EProducto.Text + ' ' + STProducto.Caption;
      LMoneda.Caption := moneda;
      DataSet := Consulta;
      DBMes.DataSet := Consulta;

       //*************************
       //DBNeto.DataSet:=Consulta;
       //DBBruto.DataSet:=Consulta;
       //*************************

      DBKilos.DataSet := Consulta;
      DBAnyo.DataSet := Consulta;
      DBImporte.DataSet := Consulta;

       //****************************
      DBCategoria.DataSet := Consulta;
      QRGrupo.Expression := DBCategoria.Caption;
       //****************************
       //QRGrupo.Expression:=DBProducto.Caption;


    end;
      //Preview(QRLVentasMensual);
    PonLogoGrupoBonnysa( QRLVentasMensualCat, eEmpresa.Text );
    Preview(QRLVentasMensualCat);
  finally
     //QRLVentasMensual.Free;
    Application.ProcessMessages;
  end;
end;

procedure TFLVentasMensual.BorrarTemporal;
begin
      //EjecutarConsulta('DROP TABLE VENTAS_MENSUAL');
  with TQuery.Create(self) do
  begin
    DataBaseName := DMBaseDatos.DBBaseDatos.DatabaseName;
    SQL.Add('DROP TABLE VENTAS_MENSUAL');
    try
      ExecSQL;
    except
      on E: EDBEngineError do
      begin
        Free;
        exit;
      end;
    end;
    Free;
  end;
end;

procedure TFLventasMensual.VaciarTemporal;
begin
  EjecutarConsulta('Delete From ventas_mensual');
end;

end.
