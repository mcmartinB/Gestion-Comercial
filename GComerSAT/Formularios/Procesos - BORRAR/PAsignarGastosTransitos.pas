unit PAsignarGastosTransitos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, Buttons, StdCtrls, Grids, DBGrids, BGrid,
  BSpeedButton, BGridButton, BEdit, ExtCtrls, Db, DBTables, BDEdit,
  ComCtrls, BCalendario, BCalendarButton;

type
  TFPAsignarGastosTransitos = class(TForm)
    ActionList1: TActionList;
    AAceptar: TAction;
    ACancelar: TAction;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    lblDescripcion: TLabel;
    lblEspere1: TLabel;
    eEmpresa: TBEdit;
    nEmpresa: TStaticText;
    stEmpresa: TStaticText;
    lblEspere2: TLabel;
    BCalendario1: TBCalendario;
    BGBEmpresa: TBGridButton;
    BGrid1: TBGrid;
    stHasta: TStaticText;
    BCBHasta: TBCalendarButton;
    BarraProgreso: TProgressBar;
    lblFase: TStaticText;
    eHasta: TBDEdit;
    StaticText1: TStaticText;
    eCentro: TBEdit;
    BGBCentro: TBGridButton;
    nCentro: TStaticText;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eEmpresaChange(Sender: TObject);
    procedure BGBEmpresaClick(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure BCBHastaClick(Sender: TObject);
    procedure eCentroChange(Sender: TObject);
  private
    { Private declarations }
    Error: boolean;

    procedure Accion;

    procedure CrearTablaTemporal;
    procedure DestruirTablaTemporal;
    procedure BorrarTablaTemporal;

    procedure ConfigBar(ACount: integer);
    procedure NextBar(ACount: integer);
    procedure LastBar(ACount: integer);

    function Comprobacion: boolean;
    //function SeleccionarTransitosVendidos: Boolean;
    procedure CrearGastosSalidas;
    procedure MoverTransitosVendidos;
    function HayGastosTransitos: Boolean;


    procedure AsignarGastos; overload;
    procedure AsignarGastos(const AAsignar: Boolean); overload;
    procedure AsignaGastosTransito(const AAsignar: Boolean);
    procedure PasarGastosTransito;
    procedure DesPasarGastosTransito;
    procedure MarcarGastosTransito(const AAsignar: Boolean);

  public
    { Public declarations }

    procedure Desasignar( const AEmpresa, ACentro: string; const ATransito:integer; const AFecha: TDateTime );
    procedure Asignar( const AEmpresa, ACentro: string; const ATransito:integer; const AFecha: TDateTime );

  protected

  end;

  procedure Desasignar( const AOwner: TComponent; const AEmpresa, ACentro: string; const ATransito:integer; const AFecha: TDateTime );
  procedure Asignar( const AOwner: TComponent; const AEmpresa, ACentro: string; const ATransito:integer; const AFecha: TDateTime );


implementation

uses DError, CAuxiliarDB, CGestionPrincipal, CVariables, UDMAuxDB, CReportes,
  DPreview, UDMBaseDatos,  bSQLUtils, bNumericUtils, Variants;

{$R *.DFM}
procedure TFPAsignarGastosTransitos.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: Integer;
begin
  //Al cerrar
  if BCalendario1.Visible then
  begin
    BCalendario1.DoExit;
    Action := caNone;
    Exit;
  end
  else
    if BGrid1.Visible then
    begin
      BGrid1.DoExit;
      Action := caNone;
      Exit;
    end;

  //Deshabilitamos menu
  for i := 0 to Application.MainForm.Menu.Items.Count - 1 do
  begin
    if Application.MainForm.Menu.Items[i].Visible then
      Application.MainForm.Menu.Items[i].Enabled := true;
  end;

  DestruirTablaTemporal;

  //Liberamos memoria
  Action := caFree;
end;

procedure TFPAsignarGastosTransitos.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  //Deshabilitamos menu
  for i := 0 to Application.MainForm.Menu.Items.Count - 1 do
  begin
    if Application.MainForm.Menu.Items[i].Visible then
      Application.MainForm.Menu.Items[i].Enabled := false;
  end;
  //Pa las rejillas
  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;

  //TEMPORAL
  eEmpresa.Text := '050';
  eCentro.Text := '';
  eHasta.Text := DateToStr(Date);
  BCalendario1.Date := Date;

  CrearTablaTemporal;
end;

procedure TFPAsignarGastosTransitos.ACancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TFPAsignarGastosTransitos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then
  begin
    Key := 0;
    PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
  end
  else
    if Key = vk_F2 then
    begin
      if eHasta.Focused then BCBHasta.Click
      else
        if eEmpresa.Focused then BGBEmpresa.Click
        else
          if eCentro.Focused then BGBCentro.Click;
    end
    else
end;

//Comprobar que esten todos los parametros

function TFPAsignarGastosTransitos.Comprobacion: Boolean;
begin
  if trim(nEmpresa.Caption) = '' then
  begin
    eEmpresa.SetFocus;
    ShowError('Falta el código de la empresa o es incorrecto.');
    Comprobacion := false;
    Exit;
  end;

  if trim(nCentro.Caption) = '' then
  begin
    eCentro.SetFocus;
    ShowError('Falta el código del centro o es incorrecto.');
    Comprobacion := false;
    Exit;
  end;

  try
    StrToDate(eHasta.text)
  except
    eHasta.SetFocus;
    ShowError('La fecha de fin es de obligada inserción.');
    Comprobacion := false;
    Exit;
  end;
  Comprobacion := true;
end;

procedure TFPAsignarGastosTransitos.eEmpresaChange(Sender: TObject);
begin
  nEmpresa.Caption := desEmpresa(eEmpresa.Text);
  eCentroChange( eCentro );
end;

procedure TFPAsignarGastosTransitos.eCentroChange(Sender: TObject);
begin
  if eCentro.Text = '' then
    nCentro.Caption := 'TODOS LOS CENTROS.'
  else
    nCentro.Caption := desCentro( eEmpresa.Text, eCentro.Text );
end;

procedure TFPAsignarGastosTransitos.BGBEmpresaClick(Sender: TObject);
begin
  DespliegaRejilla(BGBEmpresa);
end;

procedure TFPAsignarGastosTransitos.BCBHastaClick(Sender: TObject);
begin
  DespliegaCalendario(BCBHasta);
end;

procedure TFPAsignarGastosTransitos.AAceptarExecute(Sender: TObject);
begin
  Enabled := False;
  btnAceptar.Enabled := False;
  btnCancelar.Enabled := False;
  try
    Accion;
  finally
    btnAceptar.Enabled := True;
    btnCancelar.Enabled := True;
    enabled := True;
  end;
end;

function EstanGastosGrabados(const AEmpresa, ACentro, AReferencia, AFecha, ADestino: string;
                             var A011, A012, A037, A038: boolean ): boolean;
begin
  (*12/11/2016 Rosana pide que no se controle el gasto 012*)
  //011-012-037 centro 1 destino 6
  //011         centro 1 destino dif 6
  //011-012-038 centro 6
  A011:= false;
  if ACentro = '1' then
  begin
    if ADestino = '6' then
    begin
      A012:= True;//false;
      A037:= false;
      A038:= true;
    end
    else
    begin
      A012:= true;
      A037:= true;
      A038:= true;
    end;
  end
  else
  begin
    A012:= True;//false;
    A037:= true;
    A038:= false;
  end;

  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add(' select tipo_gt ');
    SQL.Add(' from frf_gastos_trans ');
    SQL.Add(' where empresa_gt = :empresa ');
    SQL.Add(' and centro_gt = :centro ');
    SQL.Add(' and fecha_gt = :fecha ');
    SQL.Add(' and referencia_gt = :transito ');
    SQL.Add(' and (tipo_gt in (''011'',''012'',''037'',''038'') ) ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('transito').AsString:= AReferencia;
    ParamByName('fecha').AsDateTime:= StrTodate( AFecha );
    Open;
    while not eof do
    begin
      if FieldByName('tipo_gt').AsString = '011' then
      begin
        A011:= True;
      end
      else
      (*
      if FieldByName('tipo_gt').AsString = '012' then
      begin
        A012:= True;
      end
      else
      *)
      if FieldByName('tipo_gt').AsString = '037' then
      begin
        A037:= True;
      end
      else
      if FieldByName('tipo_gt').AsString = '038' then
      begin
        A038:= True;
      end;
      Next;
    end;
    Close;
  end;
  result:= A011 and A012 and A037 and A038;
end;

function EsTransitoVendido(AEmpresa, ACentro, AReferencia, AFecha: string;
  AKilos: Real): boolean;
var
  kilos: real;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add(' select distinct centro_origen_tl');
    SQL.Add(' from   frf_transitos_l ');
    SQL.Add(' where empresa_tl ' + SQLEqualS(AEmpresa));
    SQL.Add('   and centro_tl ' + SQLEqualS(ACentro));
    SQL.Add('   and referencia_tl ' + SQLEqualN(AReferencia));
    SQL.Add('   and fecha_tl ' + SQLEqualD(AFecha));
    Open;

    first;
    kilos := 0;
    while not eof do
    begin
      DMBaseDatos.QAux.SQL.Clear;
      DMBaseDatos.QAux.SQL.Add(' select sum(kilos_sl) kilos_sl ');
      DMBaseDatos.QAux.SQL.Add(' from frf_salidas_l ');
      DMBaseDatos.QAux.SQL.Add(' where empresa_sl ' + SQLEqualS(AEmpresa));
      DMBaseDatos.QAux.SQL.Add('   and centro_origen_sl ' + SQLEqualS(Fields[0].AsString));
      DMBaseDatos.QAux.SQL.Add('   and ref_transitos_sl ' + SQLEqualN(AReferencia));
      DMBaseDatos.QAux.SQL.Add('   and fecha_sl ' + SQLEqualD(FormatDateTime('dd/mm/yyy', StrToDate( AFecha ) - 10), '>='));
      DMBaseDatos.QAux.Open;

      if not DMBaseDatos.QAux.IsEmpty then
      begin
        kilos := Kilos + DMBaseDatos.QAux.Fields[0].AsFloat;
      end;
      DMBaseDatos.QAux.Close;

      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add(' select sum(kilos_tl)');
    SQL.Add(' from   frf_transitos_l ');
    SQL.Add(' where empresa_tl ' + SQLEqualS(AEmpresa));
    SQL.Add('   and centro_origen_tl ' + SQLEqualS(ACentro));
    SQL.Add('   and ref_origen_tl ' + SQLEqualN(AReferencia));
    SQL.Add('   and fecha_origen_tl ' + SQLEqualD(AFecha));
    Open;

    kilos := Kilos + Fields[0].AsFloat;
    Close;
  end;

  {*DEJAR PASAR LOS QUE TIENEN SOBREPESO*}
  //result:= AKilos <= kilos;
  {*DEJAR PASAR LOS QUE HAN SIDO VENDIDOS CORRECTAMENTE*}
  result := AKilos = kilos;
end;

procedure InsertarTransito(AEmpresa, ACentro, AReferencia, AFecha: string;
  AKilos: Real);
var
  centro_origen, ref_origen, fecha_origen, producto: string;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add(' insert into tmp_transitos1 ');
    SQL.Add(' select empresa_tl, centro_tl, referencia_tl, fecha_tl, ');
    SQL.Add('        centro_origen_tl, ref_origen_tl, fecha_origen_tl, ');
    SQL.Add('        transporte_tc, vehiculo_tc, ');
    SQL.Add('        producto_tl, ' + SQLNumeric(AKilos) + ', sum(kilos_tl), ');
    SQL.Add('        tipo_tg, unidad_dist_tg, importe_gt, importe_gt ');
    SQL.Add(' from frf_transitos_l, frf_transitos_c, frf_gastos_trans, frf_tipo_gastos ');
    SQL.Add(' where empresa_tl ' + SQLEqualS(AEmpresa));
    SQL.Add('   and centro_tl ' + SQLEqualS(ACentro));
    SQL.Add('   and referencia_tl ' + SQLEqualN(AReferencia));
    SQL.Add('   and fecha_tl ' + SQLEqualD(AFecha));
    SQL.Add('   and empresa_tc ' + SQLEqualS(AEmpresa));
    SQL.Add('   and centro_tc ' + SQLEqualS(ACentro));
    SQL.Add('   and referencia_tc ' + SQLEqualN(AReferencia));
    SQL.Add('   and fecha_tc ' + SQLEqualD(AFecha));
    SQL.Add('   and empresa_gt ' + SQLEqualS(AEmpresa));
    SQL.Add('   and centro_gt ' + SQLEqualS(ACentro));
    SQL.Add('   and referencia_gt ' + SQLEqualN(AReferencia));
    SQL.Add('   and fecha_gt ' + SQLEqualD(AFecha));
    SQL.Add('   and tipo_tg = tipo_gt ');
    SQL.Add('   and producto_gt = producto_tl ');
    SQL.Add(' group by empresa_tl, centro_tl, referencia_tl, fecha_tl, ');
    SQL.Add('        centro_origen_tl, ref_origen_tl, fecha_origen_tl, ');
    SQL.Add('        transporte_tc, vehiculo_tc, producto_tl, tipo_tg, ');
    SQL.Add('        unidad_dist_tg, importe_gt ');
    ExecSQL;

    SQL.Clear;
    SQL.Add('  update tmp_transitos1 ');
    SQL.Add('  set timporte_producto_t =  ');
    SQL.Add('    round( (tkilos_producto_t / (select sum(kilos_tl) from frf_transitos_l ');
    SQL.Add('    where empresa_tl  =  tempresa_t ');
    SQL.Add('      and centro_tl  =  tcentro_t ');
    SQL.Add('      and referencia_tl  =  treferencia_t ');
    SQL.Add('      and fecha_tl  =  tfecha_t ');
    SQL.Add('      and producto_tl = tproducto_t) ) * timporte_producto_t, 2) ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' insert into tmp_transitos1 ');
    SQL.Add(' select empresa_tl, centro_tl, referencia_tl, fecha_tl, ');
    SQL.Add('        centro_origen_tl, ref_origen_tl, fecha_origen_tl, ');
    SQL.Add('        transporte_tc, vehiculo_tc, ');
    SQL.Add('        producto_tl, ' + SQLNumeric(AKilos) + ', sum(kilos_tl), ');
    //        producto_tl, 13070 transito, sum(kilos_tl) producto, sum(kilos_tl) linea,
    SQL.Add('        tipo_tg, unidad_dist_tg, importe_gt, ');
    SQL.Add('        ROUND((importe_gt * sum(kilos_tl)) ' +
      '/ ' + SQLNumeric(AKilos) + ',2) importeProducto');
    SQL.Add(' from frf_transitos_l, frf_transitos_c, frf_gastos_trans, frf_tipo_gastos ');
    SQL.Add(' where empresa_tl ' + SQLEqualS(AEmpresa));
    SQL.Add('   and centro_tl ' + SQLEqualS(ACentro));
    SQL.Add('   and referencia_tl ' + SQLEqualN(AReferencia));
    SQL.Add('   and fecha_tl ' + SQLEqualD(AFecha));
    SQL.Add('   and empresa_tc ' + SQLEqualS(AEmpresa));
    SQL.Add('   and centro_tc ' + SQLEqualS(ACentro));
    SQL.Add('   and referencia_tc ' + SQLEqualN(AReferencia));
    SQL.Add('   and fecha_tc ' + SQLEqualD(AFecha));
    SQL.Add('   and empresa_gt ' + SQLEqualS(AEmpresa));
    SQL.Add('   and centro_gt ' + SQLEqualS(ACentro));
    SQL.Add('   and referencia_gt ' + SQLEqualN(AReferencia));
    SQL.Add('   and fecha_gt ' + SQLEqualD(AFecha));
    SQL.Add('   and tipo_tg = tipo_gt ');
    SQL.Add('   and producto_gt is null ');
    SQL.Add(' group by empresa_tl, centro_tl, referencia_tl, fecha_tl, ');
    SQL.Add('        centro_origen_tl, ref_origen_tl, fecha_origen_tl, ');
    SQL.Add('        transporte_tc, vehiculo_tc, producto_tl, tipo_tg, ');
    SQL.Add('        unidad_dist_tg, importe_gt ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' insert into tmp_transitos ');
    SQL.Add(' select tempresa_t, tcentro_t, treferencia_t, tfecha_t, tcentro_origen_t, tref_origen_t, ');
    SQL.Add('         tfecha_origen_t, ttransporte_t, tvehiculo_t, tproducto_t, tkilos_transito_t, ');
    SQL.Add('         tkilos_producto_t, ttipo_gasto_t, tunidad_gasto_t ,sum(timporte_transito_t), ');
    SQL.Add('         sum(timporte_producto_t) ');
    SQL.Add('  from tmp_transitos1 t1 ');
    SQL.Add('  group by tempresa_t, tcentro_t, treferencia_t, tfecha_t, tcentro_origen_t, tref_origen_t, ');
    SQL.Add('         tfecha_origen_t, ttransporte_t, tvehiculo_t, tproducto_t, tkilos_transito_t, ');
    SQL.Add('         tkilos_producto_t, ttipo_gasto_t, tunidad_gasto_t  ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' update tmp_transitos ');
    SQL.Add(' set timporte_transito_t = ');
    SQL.Add(' ( ');
    SQL.Add('  select sum(importe_gt) ');
    SQL.Add('  from frf_gastos_trans ');
    SQL.Add('  where empresa_gt = tempresa_t ');
    SQL.Add('  and centro_gt = tcentro_t ');
    SQL.Add('  and referencia_gt = treferencia_t ');
    SQL.Add('  and fecha_gt = tfecha_t ');
    SQL.Add('  and tipo_gt = ttipo_gasto_t ');
    SQL.Add(' ) ');
    SQL.Add(' where tempresa_t ' + SQLEqualS(AEmpresa));
    SQL.Add('   and tcentro_t ' + SQLEqualS(ACentro));
    SQL.Add('   and treferencia_t ' + SQLEqualN(AReferencia));
    SQL.Add('   and tfecha_t ' + SQLEqualD(AFecha));
    ExecSQL;

    SQL.Clear;
    SQL.Add(' select tempresa_t, tcentro_t, treferencia_t, ');
    SQL.Add('        tfecha_t, ttipo_gasto_t, ');
    SQL.Add('        timporte_transito_t - sum(timporte_producto_t) diff ');
    SQL.Add(' from tmp_transitos ');
    SQL.Add(' where tempresa_t ' + SQLEqualS(AEmpresa));
    SQL.Add('   and tcentro_t ' + SQLEqualS(ACentro));
    SQL.Add('   and treferencia_t ' + SQLEqualN(AReferencia));
    SQL.Add('   and tfecha_t ' + SQLEqualD(AFecha));
    SQL.Add(' group by tempresa_t, tcentro_t, treferencia_t, tfecha_t, ');
    SQL.Add('          ttipo_gasto_t, timporte_transito_t ');
    SQL.Add(' having (timporte_transito_t - sum(timporte_producto_t)) <> 0 ');
    Open;

    while not Eof do
    begin
      DMBaseDatos.QAux.SQL.Clear;
      DMBaseDatos.QAux.SQL.Add(' select tcentro_origen_t, tref_origen_t, tfecha_origen_t, ');
      DMBaseDatos.QAux.SQL.Add('        tproducto_t ');
      DMBaseDatos.QAux.SQL.Add(' from tmp_transitos ');
      DMBaseDatos.QAux.SQL.Add(' where tempresa_t ' + SQLEqualS(AEmpresa));
      DMBaseDatos.QAux.SQL.Add('   and tcentro_t ' + SQLEqualS(ACentro));
      DMBaseDatos.QAux.SQL.Add('   and treferencia_t ' + SQLEqualN(AReferencia));
      DMBaseDatos.QAux.SQL.Add('   and tfecha_t ' + SQLEqualD(AFecha));
      DMBaseDatos.QAux.SQL.Add(' order by tcentro_origen_t, tref_origen_t, tfecha_origen_t, ');
      DMBaseDatos.QAux.SQL.Add('        tproducto_t ');
      DMBaseDatos.QAux.Open;

      centro_origen := DMBaseDatos.QAux.FieldByName('tcentro_origen_t').AsString;
      ref_origen := DMBaseDatos.QAux.FieldByName('tref_origen_t').AsString;
      fecha_origen := DMBaseDatos.QAux.FieldByName('tfecha_origen_t').AsString;
      producto := DMBaseDatos.QAux.FieldByName('tproducto_t').AsString;
      DMBaseDatos.QAux.Close;

      DMBaseDatos.QAux.SQL.Clear;
      DMBaseDatos.QAux.SQL.Add(' update tmp_transitos ');
      DMBaseDatos.QAux.SQL.Add(' set timporte_producto_t = timporte_producto_t + ' +
        SQLNumeric(FieldByName('diff').AsString));
      DMBaseDatos.QAux.SQL.Add(' where tempresa_t ' + SQLEqualS(AEmpresa));
      DMBaseDatos.QAux.SQL.Add('   and tcentro_t ' + SQLEqualS(ACentro));
      DMBaseDatos.QAux.SQL.Add('   and treferencia_t ' + SQLEqualN(AReferencia));
      DMBaseDatos.QAux.SQL.Add('   and tfecha_t ' + SQLEqualD(AFecha));
      DMBaseDatos.QAux.SQL.Add('   and tcentro_origen_t ' + SQLEqualS(centro_origen));
      DMBaseDatos.QAux.SQL.Add('   and tref_origen_t ' + SQLEqualN(ref_origen));
      DMBaseDatos.QAux.SQL.Add('   and tfecha_origen_t ' + SQLEqualD(fecha_origen));
      DMBaseDatos.QAux.SQL.Add('   and tproducto_t ' + SQLEqualS(producto));
      DMBaseDatos.QAux.SQL.Add('   and ttipo_gasto_t ' +
        SQLEqualS(FieldByName('ttipo_gasto_t').AsString));
      DMBaseDatos.QAux.ExecSQL;

      Next;
    end;
    Close;
  end;
end;


procedure TFPAsignarGastosTransitos.Accion;
var
  registro, registros, asignados, iSinVender, iSinGastos: integer;
  bVenta, bGastos, b011, b012, b037, b038: Boolean;
  sAux, sVentas, sGastos: string;
begin
  bVenta:= False;
  sVentas:= '';
  bGastos:= False;
  sGastos:= '';

  if Comprobacion then
  begin
    lblFase.Visible := true;
    lblEspere1.Visible := lblFase.Visible;
    lblEspere2.Visible := lblEspere1.Visible;
    lblFase.Caption := 'Espere, asignando gastos ';
    Application.ProcessMessages;


    with DMAuxDB.QAux do
    begin

      SQL.Clear;
      //Examinamos todos los transitos que no tengan los gastos asignados
      //dentro de un periodo de un año hasta la fecha introducida
      SQL.Add(' select empresa_tl, centro_tl, referencia_tl, fecha_tl, centro_destino_tc, ');
      SQL.Add('        sum(kilos_tl) kilos_tl ');
      SQL.Add(' from frf_transitos_c, frf_transitos_l ');
      SQL.Add(' where empresa_tc ' + SQLEqualS(eEmpresa.text));
      if eCentro.Text <> '' then
        SQL.Add('   and centro_tc ' + SQLEqualS(eCentro.text));
      SQL.Add('   and fecha_tc ' + SQLRangeD(DateToStr(StrToDate(eHasta.text) - 365), eHasta.text));
      SQL.Add('   and status_gastos_tc ' + SQLEqualS('N'));
      SQL.Add('   and empresa_tl ' + SQLEqualS(eEmpresa.text));
      SQL.Add('   and centro_tl = centro_tc ');
      SQL.Add('   and referencia_tl = referencia_tc ');
      SQL.Add('   and fecha_tl = fecha_tc ');
      SQL.Add('   and exists (select * from frf_gastos_trans ');
      SQL.Add('               where empresa_gt ' + SQLEqualS(eEmpresa.text));
      SQL.Add('                 and centro_gt = centro_tl ');
      SQL.Add('                 and referencia_gt = referencia_tl ');
      SQL.Add('                 and fecha_gt = fecha_tl )');
      SQL.Add(' group by empresa_tl, centro_tl, referencia_tl, fecha_tl, centro_destino_tc ');
      Open;

      First;
      registros := RecordCount;
      registro:= 1;
      asignados:= 0;
      iSinVender:= 0;
      iSinGastos:= 0;

      if IsEmpty then
      begin
        ShowMessage(' Sin transitos o todos ya han sido asignados. ');
      end
      else
      while not EOF do
      begin
        lblFase.Caption := 'Espere, asignando gastos transito nº ' + FieldByName('referencia_tl').AsString +
                           ' (' + IntToStr( registro ) + ' de ' + IntToStr( registros ) + ')';
        Application.ProcessMessages;
        registro:= registro + 1;

        BorrarTablaTemporal;
        if EsTransitoVendido( FieldByName('empresa_tl').AsString,
                              FieldByName('centro_tl').AsString,
                              FieldByName('referencia_tl').AsString,
                              FieldByName('fecha_tl').AsString,
                              FieldByName('kilos_tl').AsFloat) then
        begin
          if EstanGastosGrabados( FieldByName('empresa_tl').AsString,
                                  FieldByName('centro_tl').AsString,
                                  FieldByName('referencia_tl').AsString,
                                  FieldByName('fecha_tl').AsString,
                                  FieldByName('centro_destino_tc').AsString,
                                  b011, b012, b037, b038 ) then
          begin
            InsertarTransito( FieldByName('empresa_tl').AsString,
                              FieldByName('centro_tl').AsString,
                              FieldByName('referencia_tl').AsString,
                              FieldByName('fecha_tl').AsString,
                              FieldByName('kilos_tl').AsFloat);
            CrearGastosSalidas;
            MoverTransitosVendidos;
            while HayGastosTransitos do
            begin
             CrearGastosSalidas;
            end;
            AsignarGastos(True);
            asignados:= asignados + 1;
          end
          else
          begin
            bGastos:= True;
            sGastos:= sGastos + '(' + FieldByName('empresa_tl').AsString + ';' + FieldByName('centro_tl').AsString + ';' +
                                      FieldByName('referencia_tl').AsString + ';' + FieldByName('fecha_tl').AsString + ')  ->  [';
            sAux:= '';
            if not b011 then
            begin
              sAux:= '011';
            end;
            if not b012 then
            begin
              if sAux <> '' then
                sAux:= sAux + ',012'
              else
                sAux:= '012';
            end;
            if not b037 then
            begin
              if sAux <> '' then
                sAux:= sAux + ',037'
              else
                sAux:= '037';
            end;
            if not b038 then
            begin
              if sAux <> '' then
                sAux:= sAux + ',038'
              else
                sAux:= '038';
            end;

            sGastos:= sGastos + sAux + ']' + #13 + #10;
            iSinGastos:= iSinGastos + 1;
          end;
        end
        else
        begin
          bVenta:= True;
          sVentas:= sVentas + '(' + FieldByName('empresa_tl').AsString + ';' + FieldByName('centro_tl').AsString + ';' +
                                    FieldByName('referencia_tl').AsString + ';' + FieldByName('fecha_tl').AsString + ')' + #13 + #10;
          iSinVender:= iSinVender + 1;
        end;
        next;
      end;
      Close;

      if asignados > 0 then
      begin
        ShowMessage(' Proceso finalizado. Se han asignado gastos de ' + IntToStr( asignados ) + ' tránsitos.');
      end
      else
      begin
        if registros > 0 then
          ShowMessage(' Proceso finalizado. No se han asignado gastos de ningún tránsito.' );
      end;

      if bVenta then
      begin
        ShowMessage(' Hay ' + IntToStr( iSinVender ) + ' tránsitos que no han sido vendido completamente, estos no se pueden asignar.'  + #13 + #10 + sVentas );
      end;
      if bGastos then
      begin
        ShowMessage(' Hay ' + IntToStr( iSinGastos ) + ' tránsitos que no tienen todos los gastos grabados, estos no se pueden asignar.'  + #13 + #10 + sGastos );
      end;
    end;

    lblFase.Visible := false;
    lblEspere1.Visible := lblFase.Visible;
    lblEspere2.Visible := lblEspere1.Visible;
    lblFase.Caption := '';
    Application.ProcessMessages;

  end;
end;

procedure Desasignar( const AOwner: TComponent; const AEmpresa, ACentro: string; const ATransito:integer; const AFecha: TDateTime );
var
  FPAsignarGastosTransitos: TFPAsignarGastosTransitos;
begin
  FPAsignarGastosTransitos:= TFPAsignarGastosTransitos.Create( AOwner );
  try
    FPAsignarGastosTransitos.Height:= 1;
    FPAsignarGastosTransitos.Width:= 1;
    FPAsignarGastosTransitos.Left:= 1;
    FPAsignarGastosTransitos.Top:= 1;
    FPAsignarGastosTransitos.Desasignar( AEmpresa, ACentro, ATransito, AFecha );
    FPAsignarGastosTransitos.DestruirTablaTemporal;
  finally
    FreeAndNil( FPAsignarGastosTransitos );
  end;
end;

procedure Asignar( const AOwner: TComponent; const AEmpresa, ACentro: string; const ATransito:integer; const AFecha: TDateTime );
var
  FPAsignarGastosTransitos: TFPAsignarGastosTransitos;
begin
  FPAsignarGastosTransitos:= TFPAsignarGastosTransitos.Create( AOwner );
  try
    FPAsignarGastosTransitos.Height:= 1;
    FPAsignarGastosTransitos.Width:= 1;
    FPAsignarGastosTransitos.Left:= 1;
    FPAsignarGastosTransitos.Top:= 1;
    FPAsignarGastosTransitos.Asignar( AEmpresa, ACentro, ATransito, AFecha );
    FPAsignarGastosTransitos.DestruirTablaTemporal;
  finally
    FreeAndNil( FPAsignarGastosTransitos );
  end;
end;


procedure TFPAsignarGastosTransitos.Asignar( const AEmpresa, ACentro: string; const ATransito:integer; const AFecha: TDateTime );
var
  sAux: string;
  b011, b012, b037, b038: boolean;
begin
  begin
    with DMAuxDB.QAux do
    begin

      SQL.Clear;
      //Examinamos todos los transitos que no tengan los gastos asignados
      //dentro de un periodo de un año hasta la fecha introducida
      SQL.Add(' select empresa_tl, centro_tl, referencia_tl, fecha_tl, centro_destino_tc, ');
      SQL.Add('        sum(kilos_tl) kilos_tl ');
      SQL.Add(' from frf_transitos_c, frf_transitos_l ');
      SQL.Add(' where empresa_tc = :empresa ');
      SQL.Add('   and centro_tc = :centro ' );
      SQL.Add('   and fecha_tc = :fecha ');
      SQL.Add('   and referencia_tc = :referencia ');
      SQL.Add('   and status_gastos_tc ' + SQLEqualS('N'));
      SQL.Add('   and empresa_tl = :empresa ');
      SQL.Add('   and centro_tl = :centro ' );
      SQL.Add('   and referencia_tl = :referencia ');
      SQL.Add('   and fecha_tl = :fecha ');
      SQL.Add('   and exists (select * from frf_gastos_trans ');
      SQL.Add('               where empresa_gt = :empresa ');
      SQL.Add('                 and centro_gt = :centro ' );
      SQL.Add('                 and referencia_gt = :referencia ');
      SQL.Add('                 and fecha_gt = :fecha )');
      SQL.Add(' group by empresa_tl, centro_tl, referencia_tl, fecha_tl, centro_destino_tc ');

      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('referencia').AsInteger:= ATransito;
      ParamByName('fecha').AsDate:= AFecha;

      Open;

      if IsEmpty then
      begin
        ShowMessage(' Sin transitos o no han sido asignados. ');
      end
      else
      begin
        if EsTransitoVendido(FieldByName('empresa_tl').AsString,
                             FieldByName('centro_tl').AsString,
                             FieldByName('referencia_tl').AsString,
                             FieldByName('fecha_tl').AsString,
                             FieldByName('kilos_tl').AsFloat ) then
        begin
          if EstanGastosGrabados( FieldByName('empresa_tl').AsString,
                                  FieldByName('centro_tl').AsString,
                                  FieldByName('referencia_tl').AsString,
                                  FieldByName('fecha_tl').AsString,
                                  FieldByName('centro_destino_tc').AsString,
                                  b011, b012, b037, b038 ) then
          begin

            BorrarTablaTemporal;
            InsertarTransito( FieldByName('empresa_tl').AsString,
                              FieldByName('centro_tl').AsString,
                              FieldByName('referencia_tl').AsString,
                              FieldByName('fecha_tl').AsString,
                              FieldByName('kilos_tl').AsFloat);
            CrearGastosSalidas;
            MoverTransitosVendidos;
            while HayGastosTransitos do
            begin
             CrearGastosSalidas;
            end;
            AsignarGastos(True);
            ShowMessage(' Proceso finalizado.');
          end
          else
          begin
            sAux:= '';
            if not b011 then
            begin
              sAux:= '011';
            end;
            if not b012 then
            begin
              if sAux <> '' then
                sAux:= sAux + ',012'
              else
                sAux:= '012';
            end;
            if not b037 then
            begin
              if sAux <> '' then
                sAux:= sAux + ',037'
              else
                sAux:= '037';
            end;
            if not b038 then
            begin
              if sAux <> '' then
                sAux:= sAux + ',038'
              else
                sAux:= '038';
            end;

            ShowMessage('Falta grabar gastos  ->  [' + sAux + ']' );
          end;
        end
        else
        begin
          ShowMessage(' No se puede desasignar los gastos de un tránsito que no ha sido vendido completamente. ');
        end;
      end;
      Close;
    end;
  end;
end;

procedure TFPAsignarGastosTransitos.Desasignar( const AEmpresa, ACentro: string; const ATransito:integer; const AFecha: TDateTime );
var
  sAux: string;
  b011, b012, b037, b038: boolean;
begin
  begin
    with DMAuxDB.QAux do
    begin

      SQL.Clear;
      //Examinamos todos los transitos que no tengan los gastos asignados
      //dentro de un periodo de un año hasta la fecha introducida
      SQL.Add(' select empresa_tl, centro_tl, referencia_tl, fecha_tl, centro_destino_tc, ');
      SQL.Add('        sum(kilos_tl) kilos_tl ');
      SQL.Add(' from frf_transitos_c, frf_transitos_l ');
      SQL.Add(' where empresa_tc = :empresa ');
      SQL.Add('   and centro_tc = :centro ' );
      SQL.Add('   and fecha_tc = :fecha ');
      SQL.Add('   and referencia_tc = :referencia ');
      SQL.Add('   and status_gastos_tc ' + SQLEqualS('S'));
      SQL.Add('   and empresa_tl = :empresa ');
      SQL.Add('   and centro_tl = :centro ' );
      SQL.Add('   and referencia_tl = :referencia ');
      SQL.Add('   and fecha_tl = :fecha ');
      SQL.Add('   and exists (select * from frf_gastos_trans ');
      SQL.Add('               where empresa_gt = :empresa ');
      SQL.Add('                 and centro_gt = :centro ' );
      SQL.Add('                 and referencia_gt = :referencia ');
      SQL.Add('                 and fecha_gt = :fecha )');
      SQL.Add(' group by empresa_tl, centro_tl, referencia_tl, fecha_tl, centro_destino_tc ');

      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('referencia').AsInteger:= ATransito;
      ParamByName('fecha').AsDate:= AFecha;

      Open;

      if IsEmpty then
      begin
        ShowMessage(' Sin transitos o no han sido asignados. ');
      end
      else
      begin
        if EsTransitoVendido(FieldByName('empresa_tl').AsString,
                             FieldByName('centro_tl').AsString,
                             FieldByName('referencia_tl').AsString,
                             FieldByName('fecha_tl').AsString,
                             FieldByName('kilos_tl').AsFloat ) then
        begin

            BorrarTablaTemporal;
            InsertarTransito( FieldByName('empresa_tl').AsString,
                              FieldByName('centro_tl').AsString,
                              FieldByName('referencia_tl').AsString,
                              FieldByName('fecha_tl').AsString,
                              FieldByName('kilos_tl').AsFloat);
            CrearGastosSalidas;
            MoverTransitosVendidos;
            while HayGastosTransitos do
            begin
             CrearGastosSalidas;
            end;
            AsignarGastos(False);
            ShowMessage(' Proceso finalizado.');
        end
        else
        begin
          ShowMessage(' No se puede desasignar los gastos de un tránsito que no ha sido vendido completamente. ');
        end;
      end;
      Close;
    end;
  end;
end;

procedure TFPAsignarGastosTransitos.CrearTablaTemporal;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_transitos1 ( ');
    SQL.Add('   tempresa_t CHAR(3), ');
    SQL.Add('   tcentro_t CHAR(3), ');
    SQL.Add('   treferencia_t INTEGER, ');
    SQL.Add('   tfecha_t DATE, ');
    SQL.Add('   tcentro_origen_t CHAR(1), ');
    SQL.Add('   tref_origen_t INTEGER, ');
    SQL.Add('   tfecha_origen_t DATE, ');
    SQL.Add('   ttransporte_t INTEGER, ');
    SQL.Add('   tvehiculo_t CHAR(20), ');
    SQL.Add('   tproducto_t CHAR(3), ');
    SQL.Add('   tkilos_transito_t DECIMAL(10,2), ');
    SQL.Add('   tkilos_producto_t DECIMAL(10,2), ');
    SQL.Add('   ttipo_gasto_t CHAR(3), ');
    SQL.Add('   tunidad_gasto_t CHAR(7), ');
    SQL.Add('   timporte_transito_t DECIMAL(10,2), ');
    SQL.Add('   timporte_producto_t DECIMAL(10,2) ) ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_transitos ( ');
    SQL.Add('   tempresa_t CHAR(3), ');
    SQL.Add('   tcentro_t CHAR(3), ');
    SQL.Add('   treferencia_t INTEGER, ');
    SQL.Add('   tfecha_t DATE, ');
    SQL.Add('   tcentro_origen_t CHAR(1), ');
    SQL.Add('   tref_origen_t INTEGER, ');
    SQL.Add('   tfecha_origen_t DATE, ');
    SQL.Add('   ttransporte_t INTEGER, ');
    SQL.Add('   tvehiculo_t CHAR(20), ');
    SQL.Add('   tproducto_t CHAR(3), ');
    SQL.Add('   tkilos_transito_t DECIMAL(10,2), ');
    SQL.Add('   tkilos_producto_t DECIMAL(10,2), ');
    SQL.Add('   ttipo_gasto_t CHAR(3), ');
    SQL.Add('   tunidad_gasto_t CHAR(7), ');
    SQL.Add('   timporte_transito_t DECIMAL(10,2), ');
    SQL.Add('   timporte_producto_t DECIMAL(10,2) ) ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_salidas ( ');
    SQL.Add('   ttipo_s CHAR(1), ');
    SQL.Add('   tempresa_s CHAR(3),  ');
    SQL.Add('   tcentro_tran_s CHAR(3), ');
    SQL.Add('   tref_tran_s INTEGER, ');
    SQL.Add('   tfecha_tran_s DATE, ');
    SQL.Add('   tcentro_alba_s CHAR(1), ');
    SQL.Add('   tref_alba_s INTEGER, ');
    SQL.Add('   tfecha_alba_s DATE, ');
    SQL.Add('   tproducto_s CHAR(3), ');
    SQL.Add('   tcliente_s CHAR(3), ');
    SQL.Add('   ttransporte_s INTEGER, ');
    SQL.Add('   tvehiculo_s CHAR(20), ');
    SQL.Add('   tkilos_s DECIMAL(10,2), ');
    SQL.Add('   ttipo_gasto_s CHAR(3), ');
    SQL.Add('   timporte_euro_s DECIMAL(10,2), ');
    SQL.Add('   tmoneda_cliente_s CHAR(3), ');
    SQL.Add('   timporte_moneda_s DECIMAL(10,2), ');
    SQL.Add('   tasignado_s CHAR(1)) ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_tvendidos ( ');
    SQL.Add('   tempresa_t CHAR(3), ');
    SQL.Add('   tcentro_t CHAR(3), ');
    SQL.Add('   treferencia_t INTEGER, ');
    SQL.Add('   tfecha_t DATE, ');
    SQL.Add('   tcentro_origen_t CHAR(1), ');
    SQL.Add('   tref_origen_t INTEGER, ');
    SQL.Add('   tfecha_origen_t DATE, ');
    SQL.Add('   ttransporte_t INTEGER, ');
    SQL.Add('   tvehiculo_t CHAR(20), ');
    SQL.Add('   tproducto_t CHAR(3), ');
    SQL.Add('   ttipo_gasto_t CHAR(3), ');
    SQL.Add('   tunidad_gasto_t CHAR(7), ');
    SQL.Add('   tgasto_asignado_t CHAR(1) ) ');
    ExecSQL;
  end;
end;

procedure TFPAsignarGastosTransitos.DestruirTablaTemporal;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' drop table tmp_transitos1 ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' drop table tmp_transitos ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' drop table tmp_salidas ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' drop table tmp_tvendidos ');
    ExecSQL;
  end;
end;

procedure TFPAsignarGastosTransitos.BorrarTablaTemporal;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' delete from tmp_transitos1 where 1 = 1 ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' delete from tmp_transitos where 1 = 1 ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' delete from tmp_salidas where 1 = 1 ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' delete from tmp_tvendidos where 1 = 1 ');
    ExecSQL;
  end;
end;

procedure TFPAsignarGastosTransitos.ConfigBar(ACount: integer);
begin
  if ACount > 0 then
  begin
    BarraProgreso.Visible := true;
    BarraProgreso.Min := 1;
    BarraProgreso.Max := ACount;
    BarraProgreso.Position := 1;
  end
  else
  begin
    BarraProgreso.Visible := false;
    BarraProgreso.Min := 1;
    BarraProgreso.Max := 1;
    BarraProgreso.Position := 1;
  end;
end;

procedure TFPAsignarGastosTransitos.NextBar(ACount: integer);
begin
  if ACount <> -1 then
  begin
    BarraProgreso.StepIt;
  end;
  Application.ProcessMessages;
end;

procedure TFPAsignarGastosTransitos.LastBar(ACount: integer);
begin
  BarraProgreso.Visible := false;
end;
procedure TFPAsignarGastosTransitos.CrearGastosSalidas;
var
  registros: integer;
  aux, total, acum: Real;
begin
  with DMBaseDatos, DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    //Recorremos todos las transitos seleccionados en el paso anterior
    SQL.Add(' select ');
    SQL.Add('   tempresa_t, tcentro_t, treferencia_t, tfecha_t, ');
    SQL.Add('   tcentro_origen_t, tref_origen_t, tfecha_origen_t, ');
    SQL.Add('   tproducto_t, ttipo_gasto_t, tunidad_gasto_t, ');
    SQL.Add('   timporte_producto_t ');
    SQL.Add(' from tmp_transitos ');
    SQL.Add(' order by treferencia_t, ttipo_gasto_t ');
    Open;

    First;
    registros := RecordCount;
    ConfigBar(registros);

    while not Eof do
    begin

      //seleccionamos salidas que tienen datos del transito seleccionado
      //seleccionamos transitos que tienen datos del transito seleccionado
      QTemp.SQL.Clear;
      QTemp.SQL.Add('  select ' + SQLString('S') + '  tipo,');
      QTemp.SQL.Add('         ' + SQLString(FieldByName('tempresa_t').AsString) + ' empresa,');
      QTemp.SQL.Add('         ' + SQLString(FieldByName('tcentro_t').AsString) + ' centro_tran,');
      QTemp.SQL.Add('         ' + SQLNumeric(FieldByName('treferencia_t').AsString) + ' ref_tran,');
      QTemp.SQL.Add('         ' + SQLDate(FieldByName('tfecha_t').AsString) + ' fecha_tran,');
      QTemp.SQL.Add('         centro_salida_sl centro_alba, n_albaran_sl ref_alba, ');
      QTemp.SQL.Add('         fecha_sl fecha_alba, producto_sl producto, moneda_sc moneda, ');
      QTemp.SQL.Add('         cliente_sl cliente, transporte_sc transporte,');
      QTemp.SQL.Add('         vehiculo_sc vehiculo, ');
      QTemp.SQL.Add('         sum(cajas_sl) cajas,  ');
      QTemp.SQL.Add('         sum(kilos_sl) kilos,  ');
      QTemp.SQL.Add('         sum(importe_neto_sl) importe,  ');
      QTemp.SQL.Add('         nvl(sum(n_palets_sl),0) palets ');
      QTemp.SQL.Add(' from frf_salidas_l, frf_salidas_c');
      QTemp.SQL.Add(' where empresa_sl ' + SQLEqualS(FieldByName('tempresa_t').AsString));
      QTemp.SQL.Add('   and centro_origen_sl ' + SQLEqualS(FieldByName('tcentro_origen_t').AsString));
      QTemp.SQL.Add('   and ref_transitos_sl ' + SQLEqualN(FieldByName('treferencia_t').AsString));
      QTemp.SQL.Add('   and fecha_sl ' + SQLEqualD(FormatDateTime('dd/mm/yyy', FieldByName('tfecha_t').AsDateTime-10), '>='));
      QTemp.SQL.Add('   and producto_sl ' + SQLEqualS(FieldByName('tproducto_t').AsString));
      QTemp.SQL.Add('   and empresa_sc ' + SQLEqualS(FieldByName('tempresa_t').AsString));
      QTemp.SQL.Add('   and centro_salida_sc = centro_salida_sl ');
      QTemp.SQL.Add('   and n_albaran_sc = n_albaran_sl ');
      QTemp.SQL.Add('   and fecha_sc = fecha_sl ');
      QTemp.SQL.Add('  group by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, ');
      QTemp.SQL.Add('         producto_sl, moneda_sc, cliente_sl, transporte_sc, ');
      QTemp.SQL.Add('         vehiculo_sc ');

      QTemp.SQL.Add('  union ');

      QTemp.SQL.Add('  select ' + SQLString('T') + ',');
      QTemp.SQL.Add('         ' + SQLString(FieldByName('tempresa_t').AsString) + ',');
      QTemp.SQL.Add('         ' + SQLString(FieldByName('tcentro_t').AsString) + ',');
      QTemp.SQL.Add('         ' + SQLNumeric(FieldByName('treferencia_t').AsString) + ',');
      QTemp.SQL.Add('         ' + SQLDate(FieldByName('tfecha_t').AsString) + ',');
      QTemp.SQL.Add('         centro_tl, referencia_tl, fecha_tl, ');
      QTemp.SQL.Add('         producto_tl, ' + SQLString('EUR') + ', ');
      QTemp.SQL.Add('         centro_destino_tl, transporte_tc, vehiculo_tc, ');
      QTemp.SQL.Add('         sum(cajas_tl), ');
      QTemp.SQL.Add('         sum(kilos_tl), ');
      QTemp.SQL.Add('         0,0 ');
      QTemp.SQL.Add(' from frf_transitos_l, frf_transitos_c ');
      QTemp.SQL.Add(' where empresa_tl ' + SQLEqualS(FieldByName('tempresa_t').AsString));
      QTemp.SQL.Add('   and centro_origen_tl ' + SQLEqualS(FieldByName('tcentro_origen_t').AsString));
      QTemp.SQL.Add('   and ref_origen_tl ' + SQLEqualN(FieldByName('treferencia_t').AsString));
      QTemp.SQL.Add('   and fecha_origen_tl ' + SQLEqualD(FieldByName('tfecha_t').AsString));
      QTemp.SQL.Add('   and producto_tl ' + SQLEqualS(FieldByName('tproducto_t').AsString));
      QTemp.SQL.Add('   and empresa_tc ' + SQLEqualS(FieldByName('tempresa_t').AsString));
      QTemp.SQL.Add('   and centro_tc = centro_tl ');
      QTemp.SQL.Add('   and referencia_tc = referencia_tl ');
      QTemp.SQL.Add('   and fecha_tc = fecha_tl ');
      QTemp.SQL.Add(' group by centro_tl, referencia_tl, fecha_tl, producto_tl, ');
      QTemp.SQL.Add('       centro_destino_tl, transporte_tc, vehiculo_tc ');
      QTemp.Open;

      total := 0;
      QTemp.First;
      while not QTemp.Eof do
      begin
        total := total + QTemp.FieldByName('kilos').AsFloat;
        (*
        if FieldByName('tunidad_gasto_t').AsString = 'KILOS' then
        begin
          total := total + QTemp.FieldByName('kilos').AsFloat;
        end
        else
          if FieldByName('tunidad_gasto_t').AsString = 'IMPORTE' then
          begin
            total := total + QTemp.FieldByName('importe').AsFloat;
          end
          else
            if FieldByName('tunidad_gasto_t').AsString = 'CAJAS' then
            begin
              total := total + QTemp.FieldByName('cajas').AsFloat;
            end
            else
              if FieldByName('tunidad_gasto_t').AsString = 'PALETS' then
              begin
                total := total + QTemp.FieldByName('palets').AsFloat;
              end;
        *)
        QTemp.Next;
      end;

      acum := 0;
      QTemp.First;
      while not QTemp.Eof do
      begin
        //aux := 0;
        aux := QTemp.FieldByName('kilos').AsFloat;
        (*
        if FieldByName('tunidad_gasto_t').AsString = 'KILOS' then
        begin
          aux := QTemp.FieldByName('kilos').AsFloat;
        end
        else
          if FieldByName('tunidad_gasto_t').AsString = 'IMPORTE' then
          begin
            aux := QTemp.FieldByName('importe').AsFloat;
          end
          else
            if FieldByName('tunidad_gasto_t').AsString = 'CAJAS' then
            begin
              aux := QTemp.FieldByName('cajas').AsFloat;
            end
            else
              if FieldByName('tunidad_gasto_t').AsString = 'PALETS' then
              begin
                aux := QTemp.FieldByName('palets').AsFloat;
              end;
        *)
        if total <> 0 then
        begin
          aux := redondea(FieldByName('timporte_producto_t').AsFloat * aux / total, 2);
        end;
        acum := aux + acum;

        QAux.SQL.Clear;
        QAux.SQl.Add(' INSERT INTO tmp_salidas VALUES (');
        QAux.SQl.Add('       ' + SQLString(QTemp.FieldByName('tipo').AsString) + ',');
        QAux.SQl.Add('       ' + SQLString(QTemp.FieldByName('empresa').AsString) + ',');
        QAux.SQl.Add('       ' + SQLString(QTemp.FieldByName('centro_tran').AsString) + ',');
        QAux.SQl.Add('       ' + SQLNumeric(QTemp.FieldByName('ref_tran').AsString) + ',');
        QAux.SQl.Add('       ' + SQLDate(QTemp.FieldByName('fecha_tran').AsString) + ',');
        QAux.SQl.Add('       ' + SQLString(QTemp.FieldByName('centro_alba').AsString) + ',');
        QAux.SQl.Add('       ' + SQLNumeric(QTemp.FieldByName('ref_alba').AsString) + ',');
        QAux.SQl.Add('       ' + SQLDate(QTemp.FieldByName('fecha_alba').AsString) + ',');
        QAux.SQl.Add('       ' + SQLstring(QTemp.FieldByName('producto').AsString) + ',');
        QAux.SQl.Add('       ' + SQLstring(QTemp.FieldByName('cliente').AsString) + ',');
        QAux.SQl.Add('       ' + SQLNumeric(QTemp.FieldByName('transporte').AsString) + ',');
        QAux.SQl.Add('       ' + SQLString(QTemp.FieldByName('vehiculo').AsString) + ',');
        QAux.SQl.Add('       ' + SQLNumeric(QTemp.FieldByName('kilos').AsString) + ',');
        QAux.SQl.Add('       ' + SQLString(FieldByName('ttipo_gasto_t').AsString) + ',');
        QAux.SQl.Add('       ' + SQLNumeric(aux) + ',');
        QAux.SQl.Add('       ' + SQLString(QTemp.FieldByName('moneda').AsString) + ',');
        QAux.SQl.Add('       ' + SQLNumeric(aux) +
          '*CHANGE(' + SQLString(QTemp.FieldByName('moneda').AsString) +
          ',' + SQLDate(QTemp.FieldByName('fecha_alba').AsString) + '),');
        QAux.SQl.Add('       ' + SQLString('N'));
        QAux.SQl.Add(')');
        QAux.ExecSQL;

        QTemp.Next;
      end;

      //Ajustar cantidades
      if Round(FieldByName('timporte_producto_t').AsFloat * 100) <>
        Round(Acum * 100) then
      begin
        aux := (Round(FieldByName('timporte_producto_t').AsFloat * 100) - Round(Acum * 100)) / 100;
        QAux.SQL.Clear;
        QAux.SQl.Add(' UPDATE tmp_salidas ');
        QAux.SQl.Add(' SET timporte_euro_s = (timporte_euro_s + ' + SQLNumeric(aux) +
          ')*CHANGE(' + SQLString(QTemp.FieldByName('moneda').AsString) +
          ',' + SQLDate(QTemp.FieldByName('fecha_alba').AsString) + ')');
        QAux.SQl.Add(' WHERE ttipo_s ' + SQLEqualS(QTemp.FieldByName('tipo').AsString));
        QAux.SQl.Add(' AND tempresa_s ' + SQLEqualS(QTemp.FieldByName('empresa').AsString));
        QAux.SQl.Add(' AND tcentro_tran_s ' + SQLEqualS(QTemp.FieldByName('centro_tran').AsString));
        QAux.SQl.Add(' AND tref_tran_s ' + SQLEqualN(QTemp.FieldByName('ref_tran').AsString));
        QAux.SQl.Add(' AND tfecha_tran_s ' + SQLEqualD(QTemp.FieldByName('fecha_tran').AsString));
        QAux.SQl.Add(' AND tcentro_alba_s ' + SQLEqualS(QTemp.FieldByName('centro_alba').AsString));
        QAux.SQl.Add(' AND tref_alba_s ' + SQLEqualN(QTemp.FieldByName('ref_alba').AsString));
        QAux.SQl.Add(' AND tfecha_alba_s ' + SQLEqualD(QTemp.FieldByName('fecha_alba').AsString));
        QAux.SQl.Add(' AND ttipo_gasto_s ' + SQLEqualS(FieldByName('ttipo_gasto_t').AsString));
        QAux.SQl.Add(' AND tproducto_s ' + SQLEqualD(QTemp.FieldByName('producto').AsString));
        QAux.ExecSQL;
      end;
      QTemp.Close;

      //Repercutir nuevos transitos

      NextBar(registros);
      Next;
    end;
    LastBar(registros);
    Close;
  end;
end;

procedure TFPAsignarGastosTransitos.MoverTransitosVendidos;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' insert into tmp_tvendidos ');
    SQL.Add(' select tempresa_t, tcentro_t, treferencia_t, tfecha_t, tcentro_origen_t, ');
    SQL.Add('        tref_origen_t, tfecha_origen_t, ttransporte_t, tvehiculo_t, tproducto_t,');
    SQL.Add('        ttipo_gasto_t, tunidad_gasto_t, ' + SQLString('N'));
    SQL.Add(' from tmp_transitos ');
    SQL.Add(' group by tempresa_t, tcentro_t, treferencia_t, tfecha_t, tcentro_origen_t, ');
    SQL.Add('        tref_origen_t, tfecha_origen_t, ttransporte_t, tvehiculo_t, tproducto_t,');
    SQL.Add('        ttipo_gasto_t, tunidad_gasto_t ');
    ExecSQL;
  end;
end;

function TFPAsignarGastosTransitos.HayGastosTransitos: Boolean;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' delete from tmp_transitos where 1 = 1 ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' insert into tmp_transitos ');
    SQL.Add(' select tempresa_t, tcentro_t, treferencia_t, tfecha_t, ');
    SQL.Add('        tcentro_origen_t, tref_origen_t, tfecha_origen_t, ');
    SQL.Add('        ttransporte_t, ');
    SQL.Add('        tvehiculo_t, tproducto_t, tkilos_s, tkilos_s, ');
    SQL.Add('        ttipo_gasto_t, tunidad_gasto_t, timporte_euro_s, ');
    SQL.Add('        timporte_euro_s ');
    SQL.Add(' from tmp_salidas, tmp_tvendidos ');
    SQL.Add(' where tempresa_s = tempresa_t ');
    SQL.Add('   and tcentro_alba_s = tcentro_t ');
    SQL.Add('   and tref_alba_s = treferencia_t ');
    SQL.Add('   and tfecha_alba_s = tfecha_t ');
    SQL.Add('   and tproducto_s = tproducto_t ');
    SQL.Add('   and ttipo_gasto_s = ttipo_gasto_t ');
    SQL.Add('   and ttipo_s ' + SQLEQualS('T'));
    SQL.Add('   and tasignado_s ' + SQLEQualS('N'));
    ExecSQL;
    result := RowsAffected <> 0;

    SQL.Clear;
    SQL.Add(' update tmp_salidas ');
    SQL.Add(' set tasignado_s ' + SQLEQualS('S'));
    SQL.Add(' where ttipo_s ' + SQLEQualS('T'));
    SQL.Add('   and tasignado_s ' + SQLEQualS('N'));
    ExecSQL;
  end;
end;

procedure TFPAsignarGastosTransitos.AsignarGastos;
var
  registros: integer;
begin
  //Seleccionamos todos los transitos vendidos
  with DMBaseDatos do
  begin
    QGeneral.SQL.Clear;
    QGeneral.SQL.Add(' select tempresa_t, tcentro_t, treferencia_t, tfecha_t ');
    QGeneral.SQL.Add(' from tmp_tvendidos ');
    QGeneral.SQL.Add(' group by tempresa_t, tcentro_t, treferencia_t, tfecha_t ');
    QGeneral.Open;

    Error := false;
    QGeneral.First;
    registros := QGeneral.RecordCount;
    ConfigBar(registros);
    while (not QGeneral.Eof) and (not error) do
    begin
      //Seleccionamos todos los gastos que va a repercutir el transito
      QTemp.SQL.Clear;
      QTemp.SQL.Add(' select ttipo_s, tempresa_s, tcentro_alba_s, tref_alba_s, tfecha_alba_s, ');
      QTemp.SQL.Add('        ttipo_gasto_s, tproducto_s, SUM(timporte_moneda_s) timporte_moneda_s ');
      QTemp.SQL.Add(' from tmp_salidas ');
      QTemp.SQL.Add(' where tempresa_s ' + SQLEqualS(QGeneral.FieldByName('tempresa_t').AsString));
      QTemp.SQL.Add('   and tcentro_tran_s ' + SQLEqualS(QGeneral.FieldByName('tcentro_t').AsString));
      QTemp.SQL.Add('   and tref_tran_s ' + SQLEqualN(QGeneral.FieldByName('treferencia_t').AsString));
      QTemp.SQL.Add('   and tfecha_tran_s ' + SQLEqualD(QGeneral.FieldByName('tfecha_t').AsString));
      QTemp.SQL.Add(' group by ttipo_s, tempresa_s, tcentro_alba_s, tref_alba_s, tfecha_alba_s, ');
      QTemp.SQL.Add('        ttipo_gasto_s, tproducto_s ');
      QTemp.Open;

      QTemp.First;
      AsignaGastosTransito(true);
      QGeneral.Next;
      NextBar(registros);
    end;
    LastBar(registros);
  end;
end;

procedure TFPAsignarGastosTransitos.AsignaGastosTransito(const AAsignar: Boolean);
begin
  with DMBaseDatos do
  begin
    if not DBBaseDatos.InTransaction then
    begin
      DBBaseDatos.StartTransaction;
      try
        while not QTemp.Eof do
        begin
          if AAsignar then
          begin
            PasarGastosTransito;
          end
          else
          begin
            DesPasarGastosTransito;
          end;
          QTemp.Next;
        end;
        //Marcar el transito como asignado
        DBBaseDatos.Commit;
        MarcarGastosTransito(AAsignar);
      except
        DBBaseDatos.Rollback;
      end;
    end
    else
    begin
      ShowMessage(' Problemas para asegurar la integridad de la operación. ' + #13 + #10 +
        ' Por favor, intentelo mas tarde .');
      Error := true;
    end;
  end;
end;

procedure TFPAsignarGastosTransitos.PasarGastosTransito;
var
  gasto: real;
  bFlag: boolean;
begin
  //Si la salida tiene gastos de este tipo, actualizar, sino insertar nuevo gasto
  with DMBaseDatos do
  begin
    if QTemp.FieldByName('ttipo_s').AsString = 'S' then
    begin
      QAux.SQL.Clear;
      QAux.SQL.Add(' select importe_g ');
      QAux.SQL.Add(' from frf_gastos ');
      QAux.SQL.Add(' where empresa_g ' + SQLEqualS(QTemp.FieldByName('tempresa_s').AsString));
      QAux.SQL.Add('   and centro_salida_g ' + SQLEqualS(QTemp.FieldByName('tcentro_alba_s').AsString));
      QAux.SQL.Add('   and n_albaran_g ' + SQLEqualN(QTemp.FieldByName('tref_alba_s').AsString));
      QAux.SQL.Add('   and fecha_g ' + SQLEqualD(QTemp.FieldByName('tfecha_alba_s').AsString));
      QAux.SQL.Add('   and tipo_g ' + SQLEqualS(QTemp.FieldByName('ttipo_gasto_s').AsString));
      QAux.SQL.Add('   and producto_g ' + SQLEqualS(QTemp.FieldByName('tproducto_s').AsString));
      QAux.Open;
      gasto := QAux.FieldByName('importe_g').AsFloat;
      bFlag:= QAux.FieldByName('importe_g').Value = NULL;
      QAux.Close;
      QAux.SQL.Clear;

      if bFlag then
      begin
        //insertar nuevo registro
        QAux.SQL.Add(' insert into frf_gastos values ( ');
        QAux.SQL.Add(' ' + SQLString(QTemp.FieldByName('tempresa_s').AsString));
        QAux.SQL.Add(', ' + SQLString(QTemp.FieldByName('tcentro_alba_s').AsString));
        QAux.SQL.Add(', ' + SQLNumeric(QTemp.FieldByName('tref_alba_s').AsString));
        QAux.SQL.Add(', ' + SQLDate(QTemp.FieldByName('tfecha_alba_s').AsString));
        QAux.SQL.Add(', ' + SQLString(QTemp.FieldByName('ttipo_gasto_s').AsString));
        if QTemp.FieldByName('tproducto_s').AsString = '' then
          QAux.SQL.Add(', NULL ')
        else
          QAux.SQL.Add(',' + SQLString(QTemp.FieldByName('tproducto_s').AsString));
        QAux.SQL.Add(', ' + SQLNumeric(QTemp.FieldByName('timporte_moneda_s').AsFloat));
        QAux.SQL.Add(', NULL, NULL, NULL, NULL, 0, NULL, NULL ');
        QAux.SQL.Add(' )');
        QAux.ExecSQL;
      end
      else
      begin
        //ACTUALIZAR GASTO
        QAux.SQL.Clear;
        QAux.SQL.Add(' update frf_gastos ');
        QAux.SQL.Add(' set importe_g = ' + SQLNumeric(gasto + QTemp.FieldByName('timporte_moneda_s').AsFloat));
        QAux.SQL.Add(' where empresa_g ' + SQLEqualS(QTemp.FieldByName('tempresa_s').AsString));
        QAux.SQL.Add('   and centro_salida_g ' + SQLEqualS(QTemp.FieldByName('tcentro_alba_s').AsString));
        QAux.SQL.Add('   and n_albaran_g ' + SQLEqualN(QTemp.FieldByName('tref_alba_s').AsString));
        QAux.SQL.Add('   and fecha_g ' + SQLEqualD(QTemp.FieldByName('tfecha_alba_s').AsString));
        QAux.SQL.Add('   and tipo_g ' + SQLEqualS(QTemp.FieldByName('ttipo_gasto_s').AsString));
        if QTemp.FieldByName('tproducto_s').AsString = '' then
          QAux.SQL.Add('   and producto_g = NULL ')
        else
          QAux.SQL.Add('   and producto_g = ' + SQLString(QTemp.FieldByName('tproducto_s').AsString));
        QAux.ExecSQL;
      end;
    end
    else
    begin
      QAux.SQL.Clear;
      QAux.SQL.Add(' select importe_gt ');
      QAux.SQL.Add(' from frf_gastos_trans ');
      QAux.SQL.Add(' where empresa_gt ' + SQLEqualS(QTemp.FieldByName('tempresa_s').AsString));
      QAux.SQL.Add('   and centro_gt ' + SQLEqualS(QTemp.FieldByName('tcentro_alba_s').AsString));
      QAux.SQL.Add('   and referencia_gt ' + SQLEqualN(QTemp.FieldByName('tref_alba_s').AsString));
      QAux.SQL.Add('   and fecha_gt ' + SQLEqualD(QTemp.FieldByName('tfecha_alba_s').AsString));
      QAux.SQL.Add('   and tipo_gt ' + SQLEqualS(QTemp.FieldByName('ttipo_gasto_s').AsString));
      QAux.SQL.Add('   and producto_gt ' + SQLEqualS(QTemp.FieldByName('tproducto_s').AsString));
      QAux.Open;
      gasto := QAux.FieldByName('importe_gt').AsFloat;
      bFlag:= QAux.FieldByName('importe_gt').Value = NULL;
      QAux.Close;
      QAux.SQL.Clear;

      if bFlag then
      begin
        //insertar nuevo registro
        QAux.SQL.Add(' insert into frf_gastos_trans values ( ');
        QAux.SQL.Add(' ' + SQLString(QTemp.FieldByName('tempresa_s').AsString));
        QAux.SQL.Add(', ' + SQLString(QTemp.FieldByName('tcentro_alba_s').AsString));
        QAux.SQL.Add(', ' + SQLNumeric(QTemp.FieldByName('tref_alba_s').AsString));
        QAux.SQL.Add(', ' + SQLDate(QTemp.FieldByName('tfecha_alba_s').AsString));
        QAux.SQL.Add(', ' + SQLString(QTemp.FieldByName('ttipo_gasto_s').AsString));

        if QTemp.FieldByName('tproducto_s').AsString = '' then
          QAux.SQL.Add(', NULL ')
        else
          QAux.SQL.Add(', ' + SQLString(QTemp.FieldByName('tproducto_s').AsString));

        QAux.SQL.Add(', ' + SQLNumeric(QTemp.FieldByName('timporte_moneda_s').AsFloat));

        QAux.SQL.Add(', NULL, NULL, NULL, NULL, 0, NULL, NULL ');
        QAux.SQL.Add(' )');
        QAux.ExecSQL;
      end
      else
      begin
        //ACTUALIZAR GASTO
        QAux.SQL.Add(' update frf_gastos_trans ');
        QAux.SQL.Add(' set importe_gt = ' + SQLNumeric(gasto + QTemp.FieldByName('timporte_moneda_s').AsFloat));
        QAux.SQL.Add(' where empresa_gt ' + SQLEqualS(QTemp.FieldByName('tempresa_s').AsString));
        QAux.SQL.Add('   and centro_gt ' + SQLEqualS(QTemp.FieldByName('tcentro_alba_s').AsString));
        QAux.SQL.Add('   and referencia_gt ' + SQLEqualN(QTemp.FieldByName('tref_alba_s').AsString));
        QAux.SQL.Add('   and fecha_gt ' + SQLEqualD(QTemp.FieldByName('tfecha_alba_s').AsString));
        QAux.SQL.Add('   and tipo_gt ' + SQLEqualS(QTemp.FieldByName('ttipo_gasto_s').AsString));

        if QTemp.FieldByName('tproducto_s').AsString = '' then
          QAux.SQL.Add('   and producto_gt = NULL ')
        else
          QAux.SQL.Add('   and producto_gt = ' + SQLString(QTemp.FieldByName('tproducto_s').AsString));

        QAux.ExecSQL;
      end;
    end;
  end;
end;

procedure TFPAsignarGastosTransitos.MarcarGastosTransito(const AAsignar: Boolean);
begin
  with DMBaseDatos do
  begin
    QAux.Close;
    QAux.SQL.Clear;
    QAux.SQL.Add(' update frf_transitos_c ');
    if AAsignar then
    begin
      QAux.SQL.Add(' set status_gastos_tc ' + SQLEqualS('S'));
    end
    else
    begin
      QAux.SQL.Add(' set status_gastos_tc ' + SQLEqualS('N'));
    end;
    QAux.SQL.Add(' where empresa_tc ' + SQLEqualS(QGeneral.FieldByName('tempresa_t').AsString));
    QAux.SQL.Add('   and centro_tc ' + SQLEqualS(QGeneral.FieldByName('tcentro_t').AsString));
    QAux.SQL.Add('   and referencia_tc ' + SQLEqualN(QGeneral.FieldByName('treferencia_t').AsString));
    QAux.SQL.Add('   and fecha_tc ' + SQLEqualD(QGeneral.FieldByName('tfecha_t').AsString));
    QAux.ExecSQL;

    QAux.SQL.Clear;
    QAux.SQL.Add(' update tmp_tvendidos ');
    QAux.SQL.Add(' set tgasto_asignado_t ' + SQLEqualS('S'));
    QAux.SQL.Add(' where tempresa_t ' + SQLEqualS(QGeneral.FieldByName('tempresa_t').AsString));
    QAux.SQL.Add('   and tcentro_t ' + SQLEqualS(QGeneral.FieldByName('tcentro_t').AsString));
    QAux.SQL.Add('   and treferencia_t ' + SQLEqualN(QGeneral.FieldByName('treferencia_t').AsString));
    QAux.SQL.Add('   and tfecha_t ' + SQLEqualD(QGeneral.FieldByName('tfecha_t').AsString));
    QAux.ExecSQL;
  end;
end;

procedure TFPAsignarGastosTransitos.AsignarGastos(const AAsignar: Boolean);
begin
  //Seleccionamos todos los transitos vendidos
  with DMBaseDatos do
  begin
    QGeneral.SQL.Clear;
    QGeneral.SQL.Add(' select tempresa_t, tcentro_t, treferencia_t, tfecha_t ');
    QGeneral.SQL.Add(' from tmp_tvendidos ');
    QGeneral.SQL.Add(' group by tempresa_t, tcentro_t, treferencia_t, tfecha_t ');
    QGeneral.Open;

    Error := false;
    QGeneral.First;
    while (not QGeneral.Eof) and (not error) do
    begin
      //Seleccionamos todos los gastos que va a repercutir el transito
      QTemp.SQL.Clear;
      QTemp.SQL.Add(' select ttipo_s, tempresa_s, tcentro_alba_s, tref_alba_s, tfecha_alba_s, ');
      QTemp.SQL.Add('        ttipo_gasto_s, tproducto_s, SUM(timporte_moneda_s) timporte_moneda_s ');
      QTemp.SQL.Add(' from tmp_salidas ');
      QTemp.SQL.Add(' where tempresa_s ' + SQLEqualS(QGeneral.FieldByName('tempresa_t').AsString));
      QTemp.SQL.Add('   and tcentro_tran_s ' + SQLEqualS(QGeneral.FieldByName('tcentro_t').AsString));
      QTemp.SQL.Add('   and tref_tran_s ' + SQLEqualN(QGeneral.FieldByName('treferencia_t').AsString));
      QTemp.SQL.Add('   and tfecha_tran_s ' + SQLEqualD(QGeneral.FieldByName('tfecha_t').AsString));
      QTemp.SQL.Add(' group by ttipo_s, tempresa_s, tcentro_alba_s, tref_alba_s, tfecha_alba_s, ');
      QTemp.SQL.Add('        ttipo_gasto_s, tproducto_s ');
      QTemp.Open;

      QTemp.First;
      AsignaGastosTransito(AAsignar);
      QGeneral.Next;
    end;
  end;
end;

procedure TFPAsignarGastosTransitos.DesPasarGastosTransito;
var
  gasto: real;
begin
  with DMBaseDatos do
  begin
    if QTemp.FieldByName('ttipo_s').AsString = 'S' then
    begin
      QAux.SQL.Clear;
      QAux.SQL.Add(' select importe_g ');
      QAux.SQL.Add(' from frf_gastos ');
      QAux.SQL.Add(' where empresa_g ' + SQLEqualS(QTemp.FieldByName('tempresa_s').AsString));
      QAux.SQL.Add('   and centro_salida_g ' + SQLEqualS(QTemp.FieldByName('tcentro_alba_s').AsString));
      QAux.SQL.Add('   and n_albaran_g ' + SQLEqualN(QTemp.FieldByName('tref_alba_s').AsString));
      QAux.SQL.Add('   and fecha_g ' + SQLEqualD(QTemp.FieldByName('tfecha_alba_s').AsString));
      QAux.SQL.Add('   and tipo_g ' + SQLEqualS(QTemp.FieldByName('ttipo_gasto_s').AsString));
      QAux.SQL.Add('   and producto_g ' + SQLEqualS(QTemp.FieldByName('tproducto_s').AsString));
      QAux.Open;
      gasto := QAux.FieldByName('importe_g').AsFloat;
      QAux.Close;
      QAux.SQL.Clear;

      //Si coincide el gasto borrar, sino actualizar
      if QTemp.FieldByName('timporte_moneda_s').AsFloat = gasto then
      begin
        //Borrar registro
        QAux.Close;
        QAux.SQL.Clear;
        QAux.SQL.Add(' delete from frf_gastos  ');
        QAux.SQL.Add(' where empresa_g ' + SQLEqualS(QTemp.FieldByName('tempresa_s').AsString));
        QAux.SQL.Add('   and centro_salida_g ' + SQLEqualS(QTemp.FieldByName('tcentro_alba_s').AsString));
        QAux.SQL.Add('   and n_albaran_g ' + SQLEqualN(QTemp.FieldByName('tref_alba_s').AsString));
        QAux.SQL.Add('   and fecha_g ' + SQLEqualD(QTemp.FieldByName('tfecha_alba_s').AsString));
        QAux.SQL.Add('   and tipo_g ' + SQLEqualS(QTemp.FieldByName('ttipo_gasto_s').AsString));
        QAux.SQL.Add('   and producto_g = ' + SQLString(QTemp.FieldByName('tproducto_s').AsString));
        QAux.ExecSQL;
      end
      else
      begin
        //ACTUALIZAR GASTO
        QAux.Close;
        QAux.SQL.Clear;
        QAux.SQL.Add(' update frf_gastos ');
        if gasto - QTemp.FieldByName('timporte_moneda_s').AsFloat > 0 then
          QAux.SQL.Add(' set importe_g = ' + SQLNumeric(gasto - QTemp.FieldByName('timporte_moneda_s').AsFloat))
        else
          QAux.SQL.Add(' set importe_g = 0 ' );
        QAux.SQL.Add(' where empresa_g ' + SQLEqualS(QTemp.FieldByName('tempresa_s').AsString));
        QAux.SQL.Add('   and centro_salida_g ' + SQLEqualS(QTemp.FieldByName('tcentro_alba_s').AsString));
        QAux.SQL.Add('   and n_albaran_g ' + SQLEqualN(QTemp.FieldByName('tref_alba_s').AsString));
        QAux.SQL.Add('   and fecha_g ' + SQLEqualD(QTemp.FieldByName('tfecha_alba_s').AsString));
        QAux.SQL.Add('   and tipo_g ' + SQLEqualS(QTemp.FieldByName('ttipo_gasto_s').AsString));
        QAux.SQL.Add('   and producto_g = ' + SQLString(QTemp.FieldByName('tproducto_s').AsString));
        QAux.ExecSQL;
      end;
    end
    else
    begin
      QAux.SQL.Clear;
      QAux.SQL.Add(' select importe_gt ');
      QAux.SQL.Add(' from frf_gastos_trans ');
      QAux.SQL.Add(' where empresa_gt ' + SQLEqualS(QTemp.FieldByName('tempresa_s').AsString));
      QAux.SQL.Add('   and centro_gt ' + SQLEqualS(QTemp.FieldByName('tcentro_alba_s').AsString));
      QAux.SQL.Add('   and referencia_gt ' + SQLEqualN(QTemp.FieldByName('tref_alba_s').AsString));
      QAux.SQL.Add('   and fecha_gt ' + SQLEqualD(QTemp.FieldByName('tfecha_alba_s').AsString));
      QAux.SQL.Add('   and tipo_gt ' + SQLEqualS(QTemp.FieldByName('ttipo_gasto_s').AsString));
      QAux.SQL.Add('   and producto_gt = ' + SQLString(QTemp.FieldByName('tproducto_s').AsString));
      QAux.Open;
      gasto := QAux.FieldByName('importe_gt').AsFloat;
      QAux.Close;
      QAux.SQL.Clear;

      if QTemp.FieldByName('timporte_moneda_s').AsFloat = gasto then
      begin
        //insertar nuevo registro
        QAux.SQL.Add(' delete from frf_gastos_trans  ');
        QAux.SQL.Add(' where empresa_gt ' + SQLEqualS(QTemp.FieldByName('tempresa_s').AsString));
        QAux.SQL.Add('   and centro_gt ' + SQLEqualS(QTemp.FieldByName('tcentro_alba_s').AsString));
        QAux.SQL.Add('   and referencia_gt ' + SQLEqualN(QTemp.FieldByName('tref_alba_s').AsString));
        QAux.SQL.Add('   and fecha_gt ' + SQLEqualD(QTemp.FieldByName('tfecha_alba_s').AsString));
        QAux.SQL.Add('   and tipo_gt ' + SQLEqualS(QTemp.FieldByName('ttipo_gasto_s').AsString));
        QAux.SQL.Add('   and producto_gt = ' + SQLString(QTemp.FieldByName('tproducto_s').AsString));
        QAux.ExecSQL;
      end
      else
      begin
        //ACTUALIZAR GASTO
        QAux.SQL.Add(' update frf_gastos_trans ');
        if gasto - QTemp.FieldByName('timporte_moneda_s').AsFloat > 0 then
          QAux.SQL.Add(' set importe_gt = ' + SQLNumeric(gasto - QTemp.FieldByName('timporte_moneda_s').AsFloat))
        else
          QAux.SQL.Add(' set importe_gt = 0 ' );
        QAux.SQL.Add(' where empresa_gt ' + SQLEqualS(QTemp.FieldByName('tempresa_s').AsString));
        QAux.SQL.Add('   and centro_gt ' + SQLEqualS(QTemp.FieldByName('tcentro_alba_s').AsString));
        QAux.SQL.Add('   and referencia_gt ' + SQLEqualN(QTemp.FieldByName('tref_alba_s').AsString));
        QAux.SQL.Add('   and fecha_gt ' + SQLEqualD(QTemp.FieldByName('tfecha_alba_s').AsString));
        QAux.SQL.Add('   and tipo_gt ' + SQLEqualS(QTemp.FieldByName('ttipo_gasto_s').AsString));
        QAux.SQL.Add('   and producto_gt = ' + SQLString(QTemp.FieldByName('tproducto_s').AsString));
        QAux.ExecSQL;
      end;
    end;
  end;
end;

function KilosTransitos(const AEmpresa, ACentro, AReferencia, AFecha: string): real;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_tl) from frf_transitos_l ');
    SQL.Add(' where empresa_tl ' + SQLEqualS(AEmpresa));
    SQL.Add('   and centro_tl ' + SQLEqualS(ACentro));
    SQL.Add('   and referencia_tl ' + SQLEqualN(AReferencia));
    SQL.Add('   and fecha_tl ' + SQLEqualD(AFecha));
    Open;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

end.
