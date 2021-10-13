unit LFVentasNetoSem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt;

type
  TFLVentasSem = class(TForm)
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
    Query1: TQuery;
    Table1: TTable;
    Query2: TQuery;
    Label3: TLabel;
    eProducto: TBEdit;
    cbCompare: TCheckBox;
    Label5: TLabel;
    cbEnvase: TCheckBox;
    cbPromedio: TCheckBox;
    Label4: TLabel;
    eCategoria: TBEdit;
    Label6: TLabel;
    lbl1: TLabel;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
      {private declarations}
    Desde, Hasta, Desde2, Hasta2: string;
    sMoneda: string;

    procedure Proceder;

    function CamposVacios: boolean;
    function CrearTemporal: boolean;
    function IniTemporal: boolean;
    function ConsultaImporteSalida: boolean;
    function ConsultaGastos: boolean;
    function ConsultaKilos: boolean;

    function ConsultaImporteSalida2: boolean;
    function ConsultaGastos2: boolean;
    function ConsultaKilos2: boolean;

    function Grabar_(filtro, campo: string; valor: real): boolean;
    function GrabarGasto(filtro, campo: string; valor: currency;
      empresa, centro, fecha, albaran: string): boolean;
    procedure tGrabar(const semana, campo, valor: string);

    function Imprimir: boolean;
    function Borrar: boolean;

      //Roberto 7/5/2003
{      function ConsultaGastosCtaVta :boolean;
      function ConsultaGastosCtaVta2 :boolean;
}

  public
    { Public declarations }
    bSinDatosActual: boolean;
    envase, sProducto, sProductoAux: string;
  end;


implementation


uses CVariables, CAuxiliar, UDMAuxDB, Principal, CAuxiliarDB, CReportes,
  LVentasNetoSem, DPreview, UDMBaseDatos, bSQLUtils, bTimeUtils;

{$R *.DFM}

procedure TFLVentasSem.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  MEDesde.Text := DateToStr(Date-7);
  MEHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  ECliente.Tag := kCliente;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  EEmpresa.Text := gsDefEmpresa;
  ECliente.Text := gsDefCliente;
  eProducto.Text := gsDefProducto;


  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  table1.TableName := 'TMP_VENTAS_NETO';

  CrearTemporal;
end;

procedure TFLVentasSem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BorrarTemporal('tmp_ventas_neto');
  Action := caFree;
end;

procedure TFLVentasSem.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLVentasSem.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

procedure TFLVentasSem.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLVentasSem.Proceder;
begin
  with query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' DELETE FROM TMP_VENTAS_NETO WHERE 1 = 1 ');
    try
      ExecSQl;
    except
      exit;
    end;
  end;

     //Inicializar la temporal con las semanas del rango de fechas
  if not IniTemporal then Exit;

  if not ConsultaKilos then
  begin
    Exit;
  end;
  if not ConsultaImporteSalida then
  begin
    Exit;
  end;
  if not ConsultaGastos then
  begin
    Exit;
  end;

     ///////////////////////////////////////////////////////
     //MONEDA
  with DMAuxDB.QAux.SQL do
  begin
    clear;
    Add(' SELECT moneda_sc ');
    Add(' FROM  FRF_SALIDAS_c ');
    Add(' WHERE EMPRESA_Sc = ' + QuotedStr(EEmpresa.Text));
    Add('  AND   CLIENTE_fac_Sc = ' + QuotedStr(ECliente.Text));
    Add('  AND   FECHA_Sc BETWEEN ' + QuotedStr(MEDesde.Text) + ' AND ' + QuotedStr(MEHasta.Text));

  end;
  DMAuxDB.QAux.open;
  sMoneda := DMAuxDB.QAux.fields[0].asstring;
  DMAuxDB.QAux.Close;


     ////////////////////////////////
     // Ademas quita los gatos de cuenta de venta, lo pidio roberto
{     if not ConsultaGastosCtaVta then
      begin
       Exit;
      end;
}

  if cbCompare.Checked then
  begin
    if not ConsultaKilos2 then
    begin
      Exit;
    end;
    if not ConsultaImporteSalida2 then
    begin
      Exit;
    end;
    if not ConsultaGastos2 then
    begin
      Exit;
    end;
       ////////////////////////////////
     // Ademas quita los gatos de cuenta de venta, lo pidio roberto
{       if not ConsultaGastosCtaVta2 then
        begin
         Exit;
        end;}
  end;


  if not Imprimir then
  begin
    Exit;
  end;
  if not Borrar then
  begin
    Exit;
  end;
end;

procedure TFLVentasSem.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;
  if CamposVacios then Exit;

  envase := '';
  sProducto:= eProducto.Text;

  if cbEnvase.Checked then
  begin
    with DMBaseDatos.QTemp do
    begin
      SQL.Clear;
      SQL.Add(' select envase_sl, producto_sl ');
      SQl.Add(' from frf_salidas_c, frf_salidas_l ');
      SQL.Add(' where empresa_sl = :empresa ');
      if Trim(sProducto) <> '' then
        SQL.Add(' AND producto_sl = ' + QuotedStr(sProducto ) );
      //SQL.Add( ' and centro_origen_sl = :centro ');
      SQL.Add(' and cliente_sl = :cliente ');
      SQL.Add(' and fecha_sl between :fechaDesde and :fechaHasta');
      SQL.Add(' and empresa_sc = empresa_sl ');
      SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      SQL.Add(' and n_albaran_sc = n_albaran_sl ');
      SQL.Add(' and fecha_sc = fecha_sl ');
      SQL.Add(' and es_transito_sc <> 2 ');                     //Tipo Salida: Devolucion

      if Trim( eCategoria.Text ) <> '' then
        SQL.Add(' and categoria_sl = ' + QuotedStr( eCategoria.Text ) );
      SQL.Add(' group by 1, 2 ');

      ParamByName('empresa').AsString := EEmpresa.Text;
      ParamByName('cliente').AsString := ECliente.Text;
      ParamByName('fechaHasta').AsString := MEHasta.Text;
      ParamByName('fechaDesde').AsString := MEDesde.Text;
      Open;
      while not eof do
      begin
        envase := Fields[0].asstring;
        sProductoAux:= Fields[1].asstring;

        Proceder;

        next;
      end;
      Close;
    end;
  end
  else
  begin
    Proceder;
  end;
end;

procedure TFLVentasSem.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente: DespliegaRejilla(BGBCliente, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLVentasSem.PonNombre(Sender: TObject);
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
  end;
end;

function toLunes(const AFecha: TDate): TDate;
var
  dia: integer;
begin
  dia := DayOfWeek(AFecha);
  case dia of
    1: //domingo
      result := AFecha - 6;
    2: //lunes
      result := AFecha;
  else
    result := AFecha - (dia - 2);
  end;
end;

function isLunes(const AFecha: TDate): Boolean;
begin
  result := DayOfWeek(AFecha) = 2;
end;

function TFLVentasSem.CamposVacios: boolean;
var
  aux1, aux2: TDate;
  anyo, mes, dia: word;
begin
  result := (EEmpresa.Text = '') and (ECliente.Text = '') and
    (MEDesde.Text = '') and (MEHasta.Text = '');
  if result then
  begin
    ShowMessage('Faltan datos de obligada inserción.');
    Exit;
  end;

  try
    aux1 := StrToDate(MEDesde.Text);
    aux2 := StrToDate(MEHasta.Text);
  except
    result := true;
    ShowMessage('Fechas incorrectas.');
    Exit;
  end;

  if aux2 < aux1 then
  begin
    result := true;
    ShowMessage('Rango de fechas incorrectas.');
    Exit;
  end;
  if not isLunes(aux1) then
  begin
    aux1 := toLunes(aux1);
  end;

  Desde := DateToStr(aux1);
  MEDesde.Text := Desde;
  DecodeDate(aux1, anyo, mes, dia);
  Desde2 := DateToStr(EncodeDate(anyo - 1, mes, dia));

  Hasta := DateToStr(aux2);
  DecodeDate(aux2, anyo, mes, dia);
  if (mes = 2) and (dia = 29) then
  begin
    Hasta2 := DateToStr(EncodeDate(anyo - 1, 3, 1));
  end
  else
  begin
    Hasta2 := DateToStr(EncodeDate(anyo - 1, mes, dia));
  end;
end;

//Tabla temporal donde se almacenaran los datos por semana de la distintas consultas

function TFLVentasSem.CrearTemporal: boolean;
begin
  with query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('CREATE TEMP TABLE TMP_VENTAS_NETO (' +
      ' SEMANA CHAR(6) , ' +
      ' KILOS DECIMAL(10,2) DEFAULT 0, ' +
      ' IMPORTE DECIMAL(10,2) DEFAULT 0, ' +
      ' GASTOS DECIMAL(10,2) DEFAULT 0, ' +
      ' KILOS2 DECIMAL(10,2) DEFAULT 0, ' +
      ' IMPORTE2 DECIMAL(10,2) DEFAULT 0, ' +
      ' GASTOS2 DECIMAL(10,2) DEFAULT 0,' +
                //***********************************
      ' GASTOS_CV DECIMAL(10,2) DEFAULT 0,' +
      ' GASTOS_CV2 DECIMAL(10,2) DEFAULT 0)');
    try
      ExecSQl;
    except
      result := false;
      exit;
    end;
    result := True;
    Borrar;
  end;
  Table1.IndexFieldNames := 'semana';
end;

function TFLVentasSem.IniTemporal: boolean;
var
  aux: string;
  ini, fin: TDate;
begin
  result := True;
  ini := StrToDate(MEDesde.Text);
  fin := StrToDate(MEHasta.Text);

  while ini <= fin do
  begin
    aux := AnyoSemana(ini);
    query1.Close;
    query1.SQL.Clear;
    query1.SQL.Add('INSERT INTO TMP_VENTAS_NETO (SEMANA) VALUES(' + QuotedStr(aux) + ')');
    try
      ejecutarConsulta(query1);
    except
      result := false;
      exit;
    end;
    ini := ini + 7;
  end;
end;

function TFLVentasSem.ConsultaKilos: boolean;
begin
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT SUM(KILOS_SL) KILOS, YearAndWeek(FECHA_SC) FECHA ');
    SQL.Add(' FROM FRF_SALIDAS_C, FRF_SALIDAS_L ' +
      ' WHERE EMPRESA_SC = ' + QuotedStr(EEmpresa.Text) +
      ' AND   CLIENTE_SAL_SC = ' + QuotedStr(ECliente.Text) +
      ' AND   FECHA_SC BETWEEN ' + QuotedStr(MEDesde.Text) + ' AND ' + QuotedStr(MEHasta.Text));

    if envase <> '' then
    begin
      SQL.Add(' AND   ENVASE_SL ' + SQLEqualS(envase));
      SQL.Add(' AND   producto_SL ' + SQLEqualS(sproductoaux));
    end
    else
    begin
      if Trim(sProducto) <> '' then
        SQL.Add(' AND producto_sl = ' + QuotedStr(sProducto ) );
    end;


    SQL.Add(' AND   EMPRESA_SC = EMPRESA_SL ' +
      ' AND   CENTRO_SALIDA_SC = CENTRO_SALIDA_SL ' +
      ' AND   N_ALBARAN_SC = N_ALBARAN_SL ' +
      ' AND   FECHA_SC = FECHA_SL ');

    if Trim( eCategoria.Text ) <> '' then
      SQL.Add(' and categoria_sl = ' + QuotedStr( eCategoria.Text ) );

    SQL.Add(' and es_transito_sc <> 2 ');                           //Tipo Salida: Devolucion  

    SQL.Add(' GROUP BY 2 ' +
      ' ORDER BY 2');
    try
      abrirconsulta(query1);
    except
      result := false;
      Exit;
    end;

    bSinDatosActual := IsEmpty;
    if not cbCompare.Checked and bSinDatosActual then
    begin
      ShowError('No existen datos que listar para los parámetro introducidos');
      result := false;
      exit;
    end;

    while not Eof do
    begin
      Grabar_(fields[1].AsString, 'kilos', fields[0].AsFloat);
      Next;
    end;
    result := true;
  end;
end;

function TFLVentasSem.ConsultaKilos2: boolean;
begin
  result := true;
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SUBSTR(YEARANDWEEK(FECHA_SL),1,4) AÑO, ' +
      '       SUBSTR(YEARANDWEEK(FECHA_SL),5,2) SEMANA, ' +
      '       SUM(KILOS_SL) KILOS ' +
      ' FROM  FRF_SALIDAS_C, FRF_SALIDAS_L ' +
      ' WHERE EMPRESA_SL = ' + QuotedStr(EEmpresa.Text) +
      ' AND   CLIENTE_SL = ' + QuotedStr(ECliente.Text));
                //' AND CLIENTE_Sl NOT IN("MER","AL","CF","D","DW","ED","FG","FN","GL","HB","HBA","HSP","IB","LE","PL","UL","WS") AND Categoria_sl = "1" ' +
    if envase <> '' then
    begin
      SQL.Add(' AND   ENVASE_SL ' + SQLEqualS(envase));
      SQL.Add(' AND   producto_SL ' + SQLEqualS(sproductoAux));
    end
    else
    begin
      if Trim(sProducto) <> '' then
        SQL.Add(' AND producto_sl = ' + QuotedStr(sProducto ) );
    end;

    SQL.Add('  AND   FECHA_SL BETWEEN ' + QuotedStr(Desde2) + ' AND ' + QuotedStr(Hasta2));

    if Trim( eCategoria.Text ) <> '' then
      SQL.Add(' and categoria_sl = ' + QuotedStr( eCategoria.Text ) );

    SQL.Add(' and empresa_sc = empresa_sl ');
      SQL.Add(' and centro_salida_sc = centro_salida_sl ');
    SQL.Add('   and n_albaran_sc = n_albaran_sl ');
    SQL.Add('   and fecha_sc = fecha_sl ');
    SQL.Add('   and es_transito_sc <> 2 ');                         //Tipo Salida: Devolucion

    SQL.Add(' GROUP BY 1,2  ORDER BY 1,2');

    try
      Open;
    except
      result := false;
      Exit;
    end;

    if IsEmpty and bSinDatosActual then
    begin
      ShowError('No existen datos que listar para los parámetro introducidos');
      Close;
      result := false;
      exit;
    end;

    First;
    while not Eof do
    begin
      tGrabar(IntToStr(Fields[0].AsInteger + 1) + Fields[1].AsString, 'kilos2', Fields[2].AsString);
      next;
    end;
    Close;
  end;
end;

function TFLVentasSem.ConsultaImporteSalida: boolean;
begin
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SUM(IMPORTE_TOTAL_SL) IMPORTE, YEARANDWEEK(FECHA_SC) FECHA ' +
      ' FROM FRF_SALIDAS_C, FRF_SALIDAS_L' +
      ' WHERE EMPRESA_SC = ' + QuotedStr(EEmpresa.Text) +
      ' AND   CLIENTE_SAL_SC = ' + QuotedStr(ECliente.Text));

    if envase <> '' then
    begin
      SQL.Add(' AND   ENVASE_SL ' + SQLEqualS(envase));
      SQL.Add(' AND   producto_SL ' + SQLEqualS(sproductoAux));
    end
    else
    begin
      if Trim(sProducto) <> '' then
        SQL.Add(' AND producto_sl = ' + QuotedStr(sProducto ) );
    end;
    
    SQL.Add('  AND   FECHA_SC BETWEEN ' + QuotedStr(MEDesde.Text) + ' AND ' + QuotedStr(MEHasta.Text) +
      ' AND   EMPRESA_SC = EMPRESA_SL ' +
      ' AND   N_ALBARAN_SC = N_ALBARAN_SL ' +
      ' AND   CENTRO_SALIDA_SC = CENTRO_SALIDA_SL' +
      ' AND   FECHA_SC = FECHA_SL ');

    if Trim( eCategoria.Text ) <> '' then
      SQL.Add(' and categoria_sl = ' + QuotedStr( eCategoria.Text ) );

    SQL.Add(' and es_transito_sc <> 2 ');                           //Tipo Salida: Devolucion  

    SQL.Add(' GROUP BY 2 ' +
      ' ORDER BY 2');
    try
      abrirconsulta(query1);
    except
      result := false;
      Exit;
    end;

        (*
        if Bof and Eof then
         begin
           ShowError('No existen datos que listar para los parámetro introducidos');
           result:=false;
           exit;
         end;
        *)

    while not Eof do
    begin
      Grabar_(fields[1].AsString, 'importe', fields[0].AsFloat);
      Next;
    end;
    result := true;
  end;
(*
        //Recorrer y volcar en tmp_ventas_neto(restale la comision)
        ant:=Semana(FieldByName('fecha').AsDateTime);
        act:=ant;
        fech:=FieldByName('fecha').AsDateTime;
        sumimporte:=0;
        while not Eof do
        begin
         if ant <> act then
          begin
           //Grabar con el filtro de la semana anterior
           if not Grabar(IntToStr(ant),'importe',(sumimporte),fech) then
            begin
             Result:=False;
             Exit;
            end;
           sumimporte:=0;
           ant:=act;
          end;
         sumimporte:=sumimporte + FieldByName('importe').AsFloat;
         fech:=FieldByName('fecha').AsDateTime;
         Next;
         Act:=Semana(FieldByName('fecha').AsDateTime);
        end;

        if not Grabar(IntToStr(act), 'importe',sumimporte,fech) then
         begin
          Result:=False;
          Exit;
         end;
        result:=true;
      end;
*)
end;

function TFLVentasSem.ConsultaImporteSalida2: boolean;
begin
  result := true;
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SUBSTR(YEARANDWEEK(FECHA_SL),1,4) AÑO, ' +
      '       SUBSTR(YEARANDWEEK(FECHA_SL),5,2) SEMANA, ' +
      '       SUM(IMPORTE_TOTAL_SL) IMPORTE ' +
      ' FROM  FRF_SALIDAS_C, FRF_SALIDAS_L' +
      ' WHERE EMPRESA_SL = ' + QuotedStr(EEmpresa.Text) +
      ' AND   CLIENTE_SL = ' + QuotedStr(ECliente.Text));

    if envase <> '' then
    begin
      SQL.Add(' AND   ENVASE_SL ' + SQLEqualS(envase));
      SQL.Add(' AND   producto_SL ' + SQLEqualS(sproductoAux));
    end
    else
    begin
      if Trim(sProducto) <> '' then
        SQL.Add(' AND producto_sl = ' + QuotedStr(sProducto ) );
    end;

    SQL.Add('  AND   FECHA_SL BETWEEN ' + QuotedStr(Desde2) + ' AND ' + QuotedStr(Hasta2));

    if Trim( eCategoria.Text ) <> '' then
      SQL.Add(' and categoria_sl = ' + QuotedStr( eCategoria.Text ) );

    SQL.Add(' and empresa_sc = empresa_sl ');
    SQL.Add(' and centro_salida_sc = centro_salida_sl ');
    SQL.Add(' and n_albaran_sc = n_albaran_sl ');
    SQL.Add(' and fecha_sc = fecha_sl  ');
    SQL.Add(' and es_transito_sc <> 2  ');                      //Tipo Salida: Devolucion

    SQL.Add(' GROUP BY 1,2  ORDER BY 1,2');

    try
      Open;
    except
      result := false;
      Exit;
    end;

    First;
    while not Eof do
    begin
      tGrabar(IntToStr(Fields[0].AsInteger + 1) + Fields[1].AsString, 'importe2', Fields[2].AsString);
      next;
    end;
    Close;
  end;
end;

function TFLVentasSem.ConsultaGastos: boolean;
begin
  result := true;
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT EMPRESA_SC EMPRESA, CENTRO_SALIDA_SC CENTRO, FECHA_SC FECHA, ' +
      '       N_ALBARAN_SC ALBARAN, SUM(IMPORTE_G) GASTOS  ' +
      ' FROM FRF_SALIDAS_C, FRF_TIPO_GASTOS, FRF_GASTOS ' +
      ' WHERE EMPRESA_SC = ' + QuotedStr(EEmpresa.Text) +
      ' AND   CLIENTE_SAL_SC = ' + QuotedStr(ECliente.Text) +
                //' AND CLIENTE_SAL_SC NOT IN("MER","AL","CF","D","DW","ED","FG","FN","GL","HB","HBA","HSP","IB","LE","PL","UL","WS") ' +
      ' AND   FECHA_SC BETWEEN ' + QuotedStr(MEDesde.Text) + ' AND ' + QuotedStr(MEHasta.Text) +
      ' AND   FACTURABLE_TG = ' + QuotedStr('S') +
      ' AND   EMPRESA_SC = EMPRESA_G ' +
      ' AND   CENTRO_SALIDA_SC = CENTRO_SALIDA_G ' +
      ' AND   N_ALBARAN_SC = N_ALBARAN_G ' +
      ' AND   FECHA_SC = FECHA_G ' +
      ' AND   TIPO_G = TIPO_TG ');

    if ( Trim(sProducto) <> '' ) or ( Trim( eCategoria.Text ) <> '' ) or
      ( trim ( envase ) <> '' ) then
    begin
      SQL.Add(' AND   EXISTS (Select * from frf_salidas_l ' +
        '              where empresa_sl = empresa_sc ' +
        '                and centro_salida_sl = centro_salida_sc ' +
        '                and fecha_sl = fecha_sc ' +
        '                and n_albaran_sl = n_albaran_sc ');

      if Trim( eCategoria.Text ) <> '' then
        SQL.Add(' and categoria_sl = ' + QuotedStr( eCategoria.Text ) );

      if Trim( envase ) <> '' then
      begin
        SQL.Add(' AND   ENVASE_SL ' + SQLEqualS(envase));
        SQL.Add(' AND   producto_SL ' + SQLEqualS(sproductoAux));
      end
      else
      begin
      if Trim(sProducto) <> '' then
        SQL.Add(' AND producto_sl = ' + QuotedStr(sProducto ) );
      end;
      SQL.Add(' ) ');
    end;

    SQL.Add(' and es_transito_sc <> 2 ');                   //Tipo Salida: Devolucion
    
    SQL.Add(' GROUP BY EMPRESA_SC, CENTRO_SALIDA_SC, FECHA_SC, N_ALBARAN_SC ' +
      ' ORDER BY EMPRESA_SC, CENTRO_SALIDA_SC, FECHA_SC, N_ALBARAN_SC ');
    try
      abrirconsulta(query1);
    except
      result := false;
      Exit;
    end;
        //Recorrer y volcar en tmp_ventas_neto
    while not Eof do
    begin
           //Grabar con el filtro de la semana anterior
      GrabarGasto(IntToStr(Semana(FieldByName('fecha').AsDateTime)),
        'gastos',
        FieldByName('gastos').AsFloat,
        FieldByName('empresa').AsString,
        FieldByName('centro').AsString,
        FieldByName('fecha').AsString,
        FieldByName('albaran').AsString);
      Next;
    end;
    query1.Close;
  end;
end;

function TFLVentasSem.ConsultaGastos2: boolean;
begin
  result := true;
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT EMPRESA_SC EMPRESA, CENTRO_SALIDA_SC CENTRO, FECHA_SC FECHA, ' +
      '       N_ALBARAN_SC ALBARAN, SUM(IMPORTE_G) GASTOS  ' +
      ' FROM FRF_SALIDAS_C, FRF_TIPO_GASTOS, FRF_GASTOS ' +
      ' WHERE EMPRESA_SC = ' + QuotedStr(EEmpresa.Text) +
      ' AND   CLIENTE_SAL_SC = ' + QuotedStr(ECliente.Text) +
                //' AND CLIENTE_SAL_SC NOT IN("MER","AL","CF","D","DW","ED","FG","FN","GL","HB","HBA","HSP","IB","LE","PL","UL","WS")  ' +
      ' AND   FECHA_SC BETWEEN ' + QuotedStr(Desde2) + ' AND ' + QuotedStr(Hasta2) +
      ' AND   FACTURABLE_TG = ' + QuotedStr('S') +
      ' AND   EMPRESA_SC = EMPRESA_G ' +
      ' AND   CENTRO_SALIDA_SC = CENTRO_SALIDA_G ' +
      ' AND   N_ALBARAN_SC = N_ALBARAN_G ' +
      ' AND   FECHA_SC = FECHA_G ' +
      ' AND   TIPO_G = TIPO_TG ');

    if ( Trim(sproducto) <> '' ) or ( Trim( eCategoria.Text ) <> '' ) or
      ( trim ( envase ) <> '' ) then
    begin
      SQL.Add(' AND   EXISTS (Select * from frf_salidas_l ' +
        '              where empresa_sl = empresa_sc ' +
        '                and centro_salida_sl = centro_salida_sc ' +
        '                and fecha_sl = fecha_sc ' +
        '                and n_albaran_sl = n_albaran_sc ');

      if Trim( eCategoria.Text ) <> '' then
        SQL.Add(' and categoria_sl = ' + QuotedStr( eCategoria.Text ) );

      if Trim( envase ) <> '' then
      begin
        SQL.Add(' AND   ENVASE_SL ' + SQLEqualS(envase));
        SQL.Add(' AND   producto_SL ' + SQLEqualS(sproductoAux));
      end
      else
      begin
      if Trim(sProducto) <> '' then
        SQL.Add(' AND producto_sl = ' + QuotedStr(sProducto ) );
      end;
      SQL.Add(' ) ');
    end;

    SQL.Add(' and es_transito_sc <> 2 ');                 //Tipo Salida: Devolucion
    
    SQL.Add(' GROUP BY EMPRESA_SC, CENTRO_SALIDA_SC, FECHA_SC, N_ALBARAN_SC ' +
      ' ORDER BY EMPRESA_SC, CENTRO_SALIDA_SC, FECHA_SC, N_ALBARAN_SC ');
    try
      abrirconsulta(query1);
    except
      result := false;
      Exit;
    end;
        //Recorrer y volcar en tmp_ventas_neto
    while not Eof do
    begin
           //Grabar con el filtro de la semana anterior
      GrabarGasto(IntToStr(Semana(FieldByName('fecha').AsDateTime)),
        'gastos2',
        FieldByName('gastos').AsFloat,
        FieldByName('empresa').AsString,
        FieldByName('centro').AsString,
        FieldByName('fecha').AsString,
        FieldByName('albaran').AsString);
      Next;
    end;
    query1.Close;

  end;
end;


procedure TFLVentasSem.tGrabar(const semana, campo, valor: string);
begin
  with Query2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' UPDATE TMP_VENTAS_NETO ');
    SQL.Add(' SET ' + Campo + ' ' + SQLEqualN(valor));
    SQL.Add(' WHERE (SEMANA ' + SQLEqualS(semana) + ')');
    try
      ExecSQL;
    except
    end;
  end;
end;

function TFLVentasSem.GrabarGasto(filtro, campo: string; valor: currency;
  empresa, centro, fecha, albaran: string): boolean;
var
  //a,m,d:word;
  kilos_t, kilos_p: currency;
begin
(*    DecodeDate( StrToDate(fecha),a,m,d);
    //Comprobar que el año se corresponde con la semana
    if (filtro = '1') and (m = 12)  then
     begin
      Inc(a);
     end;
    if (filtro > '51') and (m = 1)then
     begin
      Dec(a);
     end;

    //Le damos formato de 2 digitos a la semana y le añado el año
    if length(filtro) = 1 then filtro:='0'+filtro;
    filtro:=IntToStr(a)+filtro;
*)
  filtro := AnyoSemana(StrToDate(fecha));

    //Kilos albaran
  with Query2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' select sum(kilos_sl) ');
    SQL.Add(' from   frf_salidas_l ');
    SQL.Add(' where  empresa_sl ' + SQLEqualS(empresa));
    SQL.Add(' and    centro_salida_sl ' + SQLEqualS(centro));
    SQL.Add(' and    fecha_sl ' + SQLEqualD(fecha));
    SQL.Add(' and    n_albaran_sl ' + SQLEqualN(albaran));

    if Trim( eCategoria.Text ) <> '' then
      SQL.Add(' and categoria_sl = ' + QuotedStr( eCategoria.Text ) );

    if envase <> '' then
    begin
      SQL.Add(' AND   ENVASE_SL ' + SQLEqualS(envase));
      SQL.Add(' AND   producto_SL ' + SQLEqualS(sproductoAux));
    end
    else
    begin
      if Trim(sProducto) <> '' then
        SQL.Add(' AND producto_sl = ' + QuotedStr(sProducto ) );
    end;

    Open;
    kilos_p := Fields[0].AsCurrency;
    Close;

    SQL.Clear;
    SQL.Add(' select sum(kilos_sl) ');
    SQL.Add(' from   frf_salidas_l ');
    SQL.Add(' where  empresa_sl ' + SQLEqualS(empresa));
    SQL.Add(' and    centro_salida_sl ' + SQLEqualS(centro));
    SQL.Add(' and    fecha_sl ' + SQLEqualD(fecha));
    SQL.Add(' and    n_albaran_sl ' + SQLEqualN(albaran));

    if Trim( eCategoria.Text ) <> '' then
      SQL.Add(' and categoria_sl = ' + QuotedStr( eCategoria.Text ) );

    if envase <> '' then
    begin
      SQL.Add(' AND   ENVASE_SL ' + SQLEqualS(envase));
      SQL.Add(' AND   producto_SL ' + SQLEqualS(sproductoAux));
    end
    else
    begin
      if Trim(sProducto) <> '' then
        SQL.Add(' AND producto_sl = ' + QuotedStr(sProducto ) );
    end;

    Open;
    kilos_t := Fields[0].AsCurrency;
    Close;

    valor := (valor * kilos_p) / kilos_t;

  end;

  with Query2 do
  begin
    SQL.Clear;
    SQL.Add(' UPDATE TMP_VENTAS_NETO ' +
      ' SET ' + Campo + ' = :parametro + ' + Campo +
      '  WHERE (SEMANA = ' + QuotedStr(filtro) + ')');
    try
      ParamByName('parametro').AsFloat := valor;
      EjecutarConsulta(query2);
    except
      result := false;
      Exit;
    end;
    REsult := true;
  end;
end;

function TFLVentasSem.Grabar_(filtro, campo: string; valor: real): boolean;
begin
  with Query2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE TMP_VENTAS_NETO ' +
      ' SET ' + Campo + ' = :parametro' +
      '  WHERE (SEMANA = ' + QuotedStr(filtro) + ')');
    try
      ParamByName('parametro').AsFloat := valor;
      EjecutarConsulta(query2);
    except
      result := false;
      Exit;
    end;
    REsult := true;
  end;
end;

function TFLVentasSem.Imprimir: boolean;
begin
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SEMANA, KILOS,((IMPORTE+GASTOS)-GASTOS_CV)TOTAL, ');
    SQL.Add('               KILOS2,((IMPORTE2+GASTOS2)-GASTOS_CV2)TOTAL2 ' +
      ' FROM TMP_VENTAS_NETO ORDER BY SEMANA ');

    try
      AbrirConsulta(query1);
    except
      Result := False;
      Exit;
    end;
  end;
  QRLVentasSem := TQRLVentasSem.Create(Application);
  QRLventasSem.bCompare := cbCompare.Checked;
  QRLventasSem.lblCliente.Caption := ECliente.text + ' / ' + STCliente.caption;
  QRLVentasSem.lblPeriodo.Caption := 'DEL ' + MEdesde.Text + ' AL ' + MEHasta.Text;
  QRLVentasSem.producto := sproducto; //desProducto(EEmpresa.text,eProducto.Text);
  QRLVentasSem.envase := envase;
  QRLVentasSem.lblEnvase.Caption := envase + ' / ' + desEnvaseP(EEmpresa.Text, envase, sproductoAux);
  QRLVentasSem.lblMoneda.Caption := 'MONEDA: ' + sMoneda;
  if Trim( eCategoria.Text ) <> '' then
    QRLVentasSem.lblCategoria.Caption:= 'Categoria ' + eCategoria.Text
  else
    QRLVentasSem.lblCategoria.Caption:= '';

  if cbPromedio.Checked then
  begin
    QRLVentasSem.eTotal.Expression := '[total2]/[kilos2]';
    QRLVentasSem.eTotal2.Expression := '[total]/[kilos]';
    QRLVentasSem.sTotal.Expression := 'sum([total2])/sum([kilos2])';
    QRLVentasSem.sTotal2.Expression := 'sum([total])/sum([kilos])';
    QRLVentasSem.lTotal.Caption := 'Promedio Facturado*';
    QRLVentasSem.lTotal2.Caption := 'Promedio Facturado*';
    QRLVentasSem.eTotal.Mask := '#,##0.00000';
    QRLVentasSem.eTotal2.Mask := '#,##0.00000';
    QRLVentasSem.sTotal.Mask := '#,##0.00000';
    QRLVentasSem.sTotal2.Mask := '#,##0.00000';
  end
  else
  begin
    QRLVentasSem.eTotal.Expression := '[total2]';
    QRLVentasSem.eTotal2.Expression := '[total]';
    QRLVentasSem.sTotal.Expression := 'sum([total2])';
    QRLVentasSem.sTotal2.Expression := 'sum([total])';
    QRLVentasSem.lTotal.Caption := 'Importe Facturado*';
    QRLVentasSem.lTotal2.Caption := 'Importe Facturado*';
    QRLVentasSem.eTotal.Mask := '#,##0.00';
    QRLVentasSem.eTotal2.Mask := '#,##0.00';
    QRLVentasSem.sTotal.Mask := '#,##0.00';
    QRLVentasSem.sTotal2.Mask := '#,##0.00';
  end;

  PonLogoGrupoBonnysa( QRLVentasSem, eEmpresa.Text );
  Preview(QRLVentasSem);
  Result := True;
end;

function TFLVentasSem.Borrar: boolean;
begin
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM TMP_VENTAS_NETO');
    try
      EjecutarConsulta(query1);
    except
      result := false;
      Exit;
    end;
    result := true;
  end;
end;

procedure TFLVentasSem.FormActivate(Sender: TObject);
begin
  Top := 10;
end;

end.
