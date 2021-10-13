unit CFLComSemVen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, BCalendarButton, Buttons, BSpeedButton, BGridButton,
  BEdit, ActnList, Grids, DBGrids, BGrid, ComCtrls,
  BCalendario, DBTables, Db, DateUtils;

type
  TDFLComSemVen = class(TForm)
    Panel1: TPanel;
    grupo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Empresa: TBEdit;
    Producto: TBEdit;
    Cliente: TBEdit;
    BGBEmpresa: TBGridButton;
    BGBProducto: TBGridButton;
    BGBCliente: TBGridButton;
    STEmpresa: TStaticText;
    STProducto: TStaticText;
    STCliente: TStaticText;
    SBAceptar: TSpeedButton;
    SBCancelar: TSpeedButton;
    ActionList1: TActionList;
    Aceptar: TAction;
    Cancelar: TAction;
    DesplegarRejilla: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    cbClienteSalida: TComboBox;
    BCBHasta: TBCalendarButton;
    Hasta: TBEdit;
    BCBDesde: TBCalendarButton;
    Desde: TBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    cbCentroSalida: TComboBox;
    ECentro: TBEdit;
    BGBCentro: TBGridButton;
    STCentro: TStaticText;
    Bevel1: TBevel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ECategoria: TBEdit;
    EEnvase: TBEdit;
    procedure PonNombre(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure DesplegarRejillaExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure SBAceptarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbClienteSalidaChange(Sender: TObject);
  private
    { Private declarations }
    bCategoria, bEnvase, bCentro, bCentroOrigen, bCliente, bPais: Boolean;
    fechaini1, fechaini2, fechafin1, fechafin2: string;
    bUnicaMoneda: boolean;
    sMoneda: string;
    sListaCliente: string;

    procedure CargaQuerys;
    procedure OpenQuerys;

    function MonedaCliente(var AMoneda: string): Boolean;
    function ListaClientesPais(const AEmpresa, APais: string): string;
  public

  end;

//var
//  FLHisVentas: TFLHisVentas;

implementation

uses bDialogs, UDMAuxDB, CVariables, CAuxiliarDB, CGestionPrincipal, Principal,
  UDMBaseDatos, DError, DPreview, bTimeUtils, bSQLUtils,
  CReportes, bMath, CQLComSemVen;

{$R *.DFM}

var
  DQLComSemVen: TDQLComSemVen;

procedure TDFLComSemVen.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Empresa.Text);
    kProducto: STProducto.Caption := desProducto(Empresa.Text, Producto.Text);
    kCliente: STCliente.Caption := desCliente(Cliente.Text);
    kPais: STCliente.Caption := desPais(Cliente.Text);
    kCentro: STCentro.Caption := desCentro(Empresa.Text, ECentro.Text);
  end;
end;

procedure TDFLComSemVen.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CalendarioFlotante.Date := Date;

  Empresa.Tag := kEmpresa;
  Cliente.Tag := kCliente;
  Producto.Tag := kProducto;
  ECentro.Tag := kCentro;
  Desde.Tag := kCalendar;
  Hasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  Empresa.Text := gsDefEmpresa;
  Producto.Text := gsDefProducto;
  Desde.Text := DateToStr( date - 7 );
  Hasta.Text := DateToStr( date - 1);

     //Crear tabla temporal
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_salidas_l ( ');
    SQL.Add('   fecha_sl DATE, ');
    SQL.Add('   moneda_sl CHAR( 3 ), ');
    SQL.Add('   kilos_sl DECIMAL( 10, 2), ');
    SQL.Add('   importe_neto_sl DECIMAL( 10, 2) ');
    SQL.Add(' ) ');
    ExecSQL;
  end;

end;

procedure TDFLComSemVen.FormDestroy(Sender: TObject);
begin
  //Crear tabla temporal
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' DROP TABLE tmp_salidas_l ');
    ExecSQL;
  end;
end;

procedure TDFLComSemVen.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TDFLComSemVen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
     //Vaciar la tabla que se utliza para sacar el listado
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  DMBaseDatos.DBBaseDatos.CloseDataSets;
  Action := caFree;
end;

procedure TDFLComSemVen.FormActivate(Sender: TObject);
begin
  ActiveControl := Empresa;
end;

procedure TDFLComSemVen.DesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [Empresa.Text]);
    kCliente: DespliegaRejilla(BGBCliente, [Empresa.Text]);
    kPais: DespliegaRejilla(BGBCliente, [Cliente.Text]);
    kCentro: DespliegaRejilla(BGBCentro, [Empresa.Text]);
    kCalendar:

      begin
        if Desde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TDFLComSemVen.CancelarExecute(Sender: TObject);
begin
  if RejillaFlotante.Visible then
  begin
    RejillaFlotante.Hide;
    Exit;
  end;
  if CalendarioFlotante.Visible then
  begin
    Exit;
  end;

  Close;
end;

function TDFLComSemVen.MonedaCliente(var AMoneda: string): Boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.add(' select distinct moneda_sc ');
    SQL.add(' from frf_salidas_c ');
    SQL.add(' where empresa_sc = :empresa ');
    if Trim(cliente.Text) <> '' then
    begin
      if sListaCliente <> '' then
        SQL.add(' and cliente_sal_sc IN ' + sListaCliente)
      else
        SQL.add(' and cliente_sal_sc = :cliente ');
    end;
    SQL.add(' and fecha_sc between :fechaini  and :fechafin ');

    ParamByName('empresa').AsString := Empresa.Text;
    if Trim(cliente.Text) <> '' then
    begin
      if sListaCliente = '' then
        ParamByName('cliente').AsString := Cliente.Text;
    end;
    ParamByName('fechaini').AsString := fechaini1;
    ParamByName('fechafin').AsString := Hasta.Text;

    Open;
    Next;
    result := EOF;
    if result then
      AMoneda := Fields[0].AsString
    else
      AMoneda := '';
    Close;
  end;
end;

function TDFLComSemVen.ListaClientesPais(const AEmpresa, APais: string): string;
begin
  result := '';
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.add(' select distinct cliente_c ');
    SQL.add(' from frf_clientes ');
    SQL.add(' where pais_c = :pais ');

    ParamByName('pais').AsString := APais;

    Open;
    if not IsEmpty then
    begin
      result := ' ( ' + QuotedStr(Fields[0].AsString);
      Next;
      while not EOF do
      begin
        result := result + ', ' + QuotedStr(Fields[0].AsString);
        Next;
      end;
      result := result + ' ) ';
    end;
    Close;
  end;
end;

procedure TDFLComSemVen.CargaQuerys;
var
  sQuery: string;
begin
  sQuery := ' select YEARANDWEEK( fecha_sl ) AnyoSemana, ' + #13 + #10 +
    '       sum( kilos_sl ) Kilos, ' + #13 + #10;
  if bUnicaMoneda and (sMoneda = 'EUR ') then
    sQuery := sQuery + '       sum( importe_neto_sl ) importe ' + #13 + #10
  else
    sQuery := sQuery + '       sum( EUROS( moneda_sl, fecha_sl, importe_neto_sl ) ) importe ' + #13 + #10;
    //sQuery:= sQuery + '       sum( importe_neto_sl / CurrChange( moneda_sl, fecha_sl ) ) importe ' + #13 + #10;
  sQuery := sQuery + ' from tmp_salidas_l ' + #13 + #10 +
    ' where fecha_sl between :fechaini  and :fechafin ' + #13 + #10 +
    ' group by 1 ' + #13 + #10 +
    ' order by 1 ' + #13 + #10;

  DQLComSemVen.QVentas1.Close;
  DQLComSemVen.QVentas1.SQL.Clear;
  DQLComSemVen.QVentas1.SQL.Add(sQuery);
  DQLComSemVen.QVentas2.Close;
  DQLComSemVen.QVentas2.SQL.Clear;
  DQLComSemVen.QVentas2.SQL.Add(sQuery);
  DQLComSemVen.QVentas3.Close;
  DQLComSemVen.QVentas3.SQL.Clear;
  DQLComSemVen.QVentas3.SQL.Add(sQuery);
end;

procedure TDFLComSemVen.OpenQuerys;
begin
  with DMAuxDB.QAux do
  begin
    if Trim(cliente.Text) <> '' then
    begin
      if cbClienteSalida.ItemIndex = 1 then
        sListaCliente := ListaClientesPais(Empresa.Text, Cliente.Text)
      else
        sListaCliente := '';
    end;
    bUnicaMoneda := MonedaCliente(sMoneda);

    CargaQuerys;

    SQL.Clear;
    SQL.add(' delete from tmp_salidas_l where 1 = 1 ');
    ExecSQL;

    SQL.Clear;
    SQL.add(' insert into tmp_salidas_l ');
    SQL.add(' select fecha_sl, ' + #13 + #10);

    if bUnicaMoneda then
      SQL.add('       ' + QuotedStr(sMoneda) + ' moneda_sl, ')
    else
      SQL.add('        (select moneda_sc ' + #13 + #10 +
        '           from frf_salidas_c ' + #13 + #10 +
        '           where empresa_sc = :empresa ' + #13 + #10 +
        '           and centro_salida_sc = centro_salida_sl ' + #13 + #10 +
        '           and n_albaran_sc = n_albaran_sl ' + #13 + #10 +
        '           and fecha_sc = fecha_sl) moneda_sl,  ' + #13 + #10);

    SQL.add('       sum(kilos_sl) kilos_sl, sum(importe_neto_sl) importe_neto_sl ');
    SQL.add(' from frf_salidas_l, frf_salidas_c ');
    SQL.add(' where empresa_sl = :empresa ');
    SQL.add(' and producto_sl = :producto1  ');
    SQL.Add(' and empresa_sc = empresa_sl ');
    SQL.Add(' and centro_salida_sc = centro_salida_sl ');
    SQL.Add(' and n_albaran_sc = n_albaran_sl ');
    SQL.Add(' and fecha_sc = fecha_sl'); 
    if bCliente then
    begin
      if sListaCliente <> '' then
        SQL.add(' and cliente_sl IN ' + sListaCliente)
      else
        SQL.add(' and cliente_sl = ' + QuotedStr(Cliente.Text));
    end;
    SQL.add(' and fecha_sl between :fechaini  and :fechafin ');
    SQL.Add(' and es_transito_sc <> 2 ');                                     //Tipo Salida: Devolucion
    if bCategoria then
      SQL.add(' and categoria_sl = :categoria ');
    if bEnvase then
      SQL.add(' and envase_sl = :envase ');
    if bCentro then
    begin
      if bCentroOrigen then
      begin
        SQL.add(' and centro_origen_sl = :centro ');
      end
      else
      begin
        SQL.add(' and centro_salida_sl = :centro ');
      end;
    end;
    SQL.add(' group by 1, 2 ');

    ParamByName('empresa').AsString := Empresa.Text;
    ParamByName('producto1').AsString := Producto.Text;

    ParamByName('fechaini').AsString := fechaini1;
    ParamByName('fechafin').AsString := Hasta.Text;
    if bCategoria then
      ParamByName('categoria').AsString := ECategoria.Text;
    if bEnvase then
      ParamByName('envase').AsString := EEnvase.Text;
    if bCentro then
      ParamByName('centro').AsString := ECentro.Text;

    ExecSQL;
  end;

  with DQLComSemVen.QVentas1 do
  begin
    ParamByName('fechaini').AsString := fechaini1;
    ParamByName('fechafin').AsString := fechafin1;
    Open;
  end;
  with DQLComSemVen.QVentas2 do
  begin
    ParamByName('fechaini').AsString := fechaini2;
    ParamByName('fechafin').AsString := fechafin2;
    Open;
  end;
  with DQLComSemVen.QVentas3 do
  begin
    ParamByName('fechaini').AsString := Desde.Text;
    ParamByName('fechafin').AsString := Hasta.Text;
    Open;
  end;
end;

procedure TDFLComSemVen.SBAceptarClick(Sender: TObject);
var
  anyo1, mes1, dia1: word;
  anyo2, mes2, dia2: word;
  //tiempo: cardinal;
begin
  bCategoria := ECategoria.Text <> '';
  bEnvase := EEnvase.Text <> '';
  bCentro := ECentro.Text <> '';
  bCentroOrigen := cbCentroSalida.ItemIndex = 1;
  bCliente := Cliente.Text <> '';
  bPais := cbClienteSalida.ItemIndex = 1;
  DQLComSemVen := TDQLComSemVen.Create(self);

  try
    DQLComSemVen.Periodo3.Caption := Desde.Text + ' - ' + Hasta.Text;
    DecodeDate(StrToDate(desde.Text), anyo1, mes1, dia1);
    DecodeDate(StrToDate(hasta.Text), anyo2, mes2, dia2);
    fechaini2 := DateToStr(EncodeDate(Anyo1 - 1, mes1, dia1));
    fechafin2 := DateToStr(EncodeDate(Anyo2 - 1, mes2, dia2));
    DQLComSemVen.Periodo2.Caption := fechaini2 + ' - ' + fechafin2;
    fechaini1 := DateToStr(EncodeDate(Anyo1 - 2, mes1, dia1));
    fechafin1 := DateToStr(EncodeDate(Anyo2 - 2, mes2, dia2));
    DQLComSemVen.Periodo1.Caption := fechaini1 + ' - ' + fechafin1;

    //tiempo:= GetTickCount;
    OpenQuerys;
    //tiempo:= GetTickCount - tiempo;
    //ShowMessage(IntToStr(tiempo));

    DQLComSemVen.PsProducto.Caption := Producto.Text + ' - ' + desProducto(Empresa.Text, Producto.Text);
    DQLComSemVen.psMoneda.Caption := 'EUROS';
    if bCategoria then
    begin
      DQLComSemVen.PsProducto.Caption:= DQLComSemVen.PsProducto.Caption + ' CAT. ' + ECategoria.Text + 'ª';
    end;
    if bEnvase then
      DQLComSemVen.lblEnvase.Caption := 'ENVASE: ' + EEnvase.Text
    else
      DQLComSemVen.lblEnvase.Caption := 'TODOS LOS ARTICULOS';
    if bCentro then
    begin
      if bCentroOrigen then
        DQLComSemVen.lblCentro.Caption := 'CENTRO ORIGEN: ' + ECentro.Text
      else
        DQLComSemVen.lblCentro.Caption := 'CENTRO SALIDA: ' + ECentro.Text;
    end
    else
      DQLComSemVen.lblCentro.Caption := 'TODOS LOS CENTROS';
    if bCliente then
    begin
      if bPais then
        DQLComSemVen.PsCliente.Caption := Cliente.Text + ' - ' + DesPais(Cliente.Text)
      else
        DQLComSemVen.PsCliente.Caption := Cliente.Text + ' - ' + DesCliente(Cliente.Text)
    end
    else
      DQLComSemVen.psCliente.Caption := 'TODOS LOS CLIENTES';


    PonLogoGrupoBonnysa(DQLComSemVen, Empresa.Text);

    DQLComSemVen.iAnySemInicial := StrToInt(AnyoSemana(StrToDate(Desde.Text)));

    Preview(DQLComSemVen);
    DQLComSemVen := nil;
  except
    FreeAndNil(DQLComSemVen);
  end;
end;

procedure TDFLComSemVen.cbClienteSalidaChange(Sender: TObject);
begin
  if cbClienteSalida.ItemIndex = 0 then
  begin
    Cliente.Tag := kCliente;
    PonNombre(cliente);
  end
  else
  begin
    Cliente.Tag := kPais;
    PonNombre(cliente);
  end;
end;

end.
