unit AprovechaAjuste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, BEdit, nbLabels, DB, DBTables;

type
  TFAprovechaAjuste = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel1: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    des_empresa: TnbStaticText;
    des_producto: TnbStaticText;
    empresa: TBEdit;
    producto: TBEdit;
    fecha_desde: TBEdit;
    nbLabel2: TnbLabel;
    centro: TBEdit;
    des_centro: TnbStaticText;
    memo: TMemo;
    btnImprimir: TSpeedButton;
    nbLabel6: TnbLabel;
    fechaHasta: TBEdit;

    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure empresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fecha_desdeChange(Sender: TObject);

  private
    { Private declarations }
    informe: TStringList;
    sLunes, sDomingo: string;
    dDesde: TDateTime;

    function RangoValidos: Boolean;
    procedure ComprobarFechaLiquidacion;
(*
    function AprovechamientosPorcenMerma( const AEmpresa, ACentro, AProducto,
                                 AFechaIni, AFechaFin: string  ): Real;
*)

    function AjustarAprovechamientosSalida(const AEmpresa, Acentro, Aproducto,
      AfechaIni, AFechaFin: string): boolean;

    function  HayEntradas( const AEempresa, ACentro, AProducto: string;
                           const ADesde, AHasta: TDateTime;
                           var AMsg: string ): Boolean;

    procedure AjustePrevio( const AEmpresa, ACentro, AProducto: string; const ADesde, AHasta: TDateTime; const APorc1, APorc2, APorc3: real );
    procedure BajarCategoria( const AEmpresa, ACentro, AProducto: string; const ADesde, AHasta: TDateTime; const ACat: integer );
  public
    { Public declarations }
  end;

  (*SE USAN FUERA -->>*)
  function  PorcentajesDestrioPeninsula( const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string): real;
  (*<<-- SE USAN FUERA*)

  function TotalEntrada(const AEmpresa, ACentro, AProducto,
      AFechaIni, AFechaFin: string; var rKSelecC1, rKSelecC2, rKSelecC3: real ): real;
  procedure KilosEntrada(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
      var k1, k2, k3, kd, km: real);



  procedure SalvaAjuste( const QUpdate: Tquery;
    const AEmpresa, ACentro, AProducto: string;
    const c1, c2, c3, cd, cm: real);

implementation

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, UDMBaseDatos,
  bSQLUtils, bMath, bDialogs, TablaTmpFob, CReportes,
  DError, UEscandallosUC, UAjusteComun;

{$R *.dfm}

procedure TFAprovechaAjuste.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFAprovechaAjuste.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(informe);

  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure QueryUpdate;
begin
  if gbAjustarSeleccionado then
  begin
    dmBaseDatos.QTemp.SQL.Clear;
    dmBaseDatos.QTemp.SQL.add(' select ');
    dmBaseDatos.QTemp.SQL.add('    cosechero_e, plantacion_e, numero_entrada_e, fecha_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_primera_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_segunda_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_tercera_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_destrio_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_merma_e ');

    dmBaseDatos.QTemp.SQL.add(' from frf_escandallo ');

    dmBaseDatos.QTemp.SQL.add(' where empresa_e = :empresa ');
    dmBaseDatos.QTemp.SQL.add(' and centro_e = :centro ');
    dmBaseDatos.QTemp.SQL.add(' and fecha_e between :fechaini and :fechafin ');
    dmBaseDatos.QTemp.SQL.add(' and producto_e = :producto ');

    dmBaseDatos.QTemp.SQL.add(' group by cosechero_e, plantacion_e, numero_entrada_e, fecha_e, aporcen_primera_e, ');
    dmBaseDatos.QTemp.SQL.add('        aporcen_segunda_e, aporcen_tercera_e, aporcen_destrio_e, aporcen_merma_e  ');
    dmBaseDatos.QTemp.SQL.add(' order by numero_entrada_e ');
  end
  else
  begin
    dmBaseDatos.QTemp.SQL.Clear;
    dmBaseDatos.QTemp.SQL.add(' select ');
    dmBaseDatos.QTemp.SQL.add('    cosechero_e, plantacion_e, numero_entrada_e, fecha_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_primera_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_segunda_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_tercera_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_destrio_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_merma_e ');

    dmBaseDatos.QTemp.SQL.add('    from frf_entradas2_l, frf_escandallo, frf_entradas_tipo ' + #13 + #10 +
        '  where empresa_e2l = :empresa ' + #13 + #10 +
        '    and centro_e2l = :centro ' + #13 + #10 +
        '    and producto_e2l = :producto ' + #13 + #10 +
        '    and fecha_e2l between :fechaini and :fechafin ' + #13 + #10 +

        '    and empresa_e = :empresa ' + #13 + #10 +
        '    and centro_e = :centro ' + #13 + #10 +
        '    and producto_e = :producto ' + #13 + #10 +
        '    and fecha_e = fecha_e2l ' + #13 + #10 +
        '    and numero_entrada_e = numero_entrada_e2l ' + #13 + #10 +
        '    and cosechero_e = cosechero_e2l ' + #13 + #10 +
        '    and plantacion_e = plantacion_e2l '+ #13 + #10 +
        '    and anyo_semana_e = ano_sem_planta_e2l '+ #13 + #10 +

        '    and empresa_et = :empresa ' + #13 + #10 +
        '    and tipo_et = tipo_entrada_e ' + #13 + #10 +
        '    and ajuste_et = 1 ');

    dmBaseDatos.QTemp.SQL.add(' group by cosechero_e, plantacion_e, numero_entrada_e, fecha_e, aporcen_primera_e, ');
    dmBaseDatos.QTemp.SQL.add('        aporcen_segunda_e, aporcen_tercera_e, aporcen_destrio_e, aporcen_merma_e  ');
    dmBaseDatos.QTemp.SQL.add(' order by numero_entrada_e ');
  end;
end;

procedure TFAprovechaAjuste.FormCreate(Sender: TObject);
var
  fecha: TDate;
begin
  Top := 1;
  FormType := tfOther;
  BHFormulario;

  empresa.Text := '050';
  centro.Text := '1';
  producto.Text := 'T';

  fecha := date;
  while DayOfWeek(fecha) <> 1 do fecha := fecha - 1;
  fecha_desde.Text := DateToStr(fecha - 6);

    dmBaseDatos.QTemp.SQL.Clear;
    dmBaseDatos.QTemp.SQL.add(' select ');
    dmBaseDatos.QTemp.SQL.add('    cosechero_e, plantacion_e, numero_entrada_e, fecha_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_primera_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_segunda_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_tercera_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_destrio_e, ');
    dmBaseDatos.QTemp.SQL.add('    aporcen_merma_e ');

    dmBaseDatos.QTemp.SQL.add(' from frf_escandallo ');

    dmBaseDatos.QTemp.SQL.add(' where empresa_e = :empresa ');
    dmBaseDatos.QTemp.SQL.add(' and centro_e = :centro ');
    dmBaseDatos.QTemp.SQL.add(' and fecha_e between :fechaini and :fechafin ');
    dmBaseDatos.QTemp.SQL.add(' and producto_e = :producto ');

    dmBaseDatos.QTemp.SQL.add(' group by cosechero_e, plantacion_e, numero_entrada_e, fecha_e, aporcen_primera_e, ');
    dmBaseDatos.QTemp.SQL.add('        aporcen_segunda_e, aporcen_tercera_e, aporcen_destrio_e, aporcen_merma_e  ');
    dmBaseDatos.QTemp.SQL.add(' order by numero_entrada_e ');

  informe := TStringList.Create;
end;

procedure TFAprovechaAjuste.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    vk_escape:
      begin
        btnCancelar.Click
      end;
    vk_f1:
      begin
        btnAceptar.Click
      end;
  end;
end;


procedure TFAprovechaAjuste.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFAprovechaAjuste.productoChange(Sender: TObject);
begin
  des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFAprovechaAjuste.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

function TFAprovechaAjuste.RangoValidos: Boolean;
begin
  result := false;
  //Comprobar que las fechas sean correctas
  try
    dDesde := StrToDate(fecha_desde.Text);
  except
    fecha_desde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  if DayOfWeek(dDesde) <> 2 then
  begin
    fecha_desde.SetFocus;
    ShowMessage('El dia de inicio debe ser Lunes.');
    Exit;
  end;
  sLunes:= fecha_desde.Text;
  sDomingo:= DateToStr( dDesde + 6 );
  result := true;
end;

procedure TFAprovechaAjuste.FormActivate(Sender: TObject);
begin
  Top := 10;
end;

procedure TFAprovechaAjuste.ComprobarFechaLiquidacion;
var
  dFecha, dLiquida: TDateTime;
begin
  dFecha:= StrToDate( fecha_desde.Text );
  dLiquida:= GetFechaUltimaLiquidacion( empresa.Text, centro.Text, producto.Text );
  if dFecha < dLiquida then
  begin
    ShowMessage('No se puede inicializar reajustar las entradas con fecha anterior a la ultima liquidación definitiva (' +
                DateToStr( dLiquida ) +  ').');
    Abort;
  end;
end;

function  TFAprovechaAjuste.HayEntradas( const AEempresa, ACentro, AProducto: string;
                           const ADesde, AHasta: TDateTime;
                           var AMsg: string ): Boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_entradas_c');
    SQL.Add('where empresa_ec = :empresa ');
    SQL.Add('and centro_ec = :centro ');
    SQL.Add('and producto_ec = :producto ');
    SQL.Add('and fecha_ec between :fechaini and :fechafin ');
    ParamByName('empresa').AsString:= AEempresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fechaini').AsDateTime:= ADesde;
    ParamByName('fechafin').AsDateTime:= AHasta;
    Open;
    Result:= not IsEmpty;
    Close;

    if Result then
    begin
      SQL.Clear;
      SQL.Add('select * from frf_salidas_l');
      SQL.Add('where empresa_sl = :empresa ');
      SQL.Add('and centro_salida_sl = :centro ');
      SQL.Add('and producto_sl = :producto ');
      SQL.Add('and fecha_sl between :fechaini and :fechafin ');
      SQL.Add('and producto_sl = :producto ');
      SQL.Add('and ref_transitos_sl is null ');
      ParamByName('empresa').AsString:= AEempresa;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('producto').AsString:= AProducto;
      ParamByName('fechaini').AsDateTime:= ADesde;
      ParamByName('fechafin').AsDateTime:= AHasta;
      Open;
      Result:= not IsEmpty;
      Close;

      if not Result then
      begin
        SQL.Clear;
        SQL.Add('select * from frf_transitos_l');
        SQL.Add('where empresa_tl = :empresa ');
        SQL.Add('and centro_tl = :centro ');
        SQL.Add('and producto_tl = :producto ');
        SQL.Add('and fecha_tl between :fechaini and :fechafin ');
        SQL.Add('and producto_tl = :producto ');
        SQL.Add('and ref_origen_tl is null ');
        ParamByName('empresa').AsString:= AEempresa;
        ParamByName('centro').AsString:= ACentro;
        ParamByName('producto').AsString:= AProducto;
        ParamByName('fechaini').AsDateTime:= ADesde;
        ParamByName('fechafin').AsDateTime:= AHasta;
        Open;
        Result:= not IsEmpty;
        if not Result then
        begin
          AMsg:= ' No hay salidas o transitos para el rango de fecha seleccinado.';
        end;
        Close;
      end;
    end
    else
    begin
      AMsg:= ' No hay entradas para el rango de fechas seleccinado.';
    end;
  end;
end;

procedure TFAprovechaAjuste.btnAceptarClick(Sender: TObject);
var
  iFaltan: integer;
  sMsg: string;
begin
  if RangoValidos then
  begin
    ComprobarFechaLiquidacion;

    if HayEntradas( empresa.Text, centro.Text, producto.Text, dDesde, dDesde + 6, sMsg ) then
    begin
      if EstaEscandalloGrabado(empresa.Text, centro.Text, producto.Text, dDesde, iFaltan) then
      begin
        if EstaMermaGrabada(empresa.Text, centro.Text, producto.Text, dDesde) then
        begin
          BEMensajes('Ajustando los aprovechamientos ...');
          if AjustarAprovechamientosSalida(empresa.Text, centro.Text, producto.Text, sLunes, sDomingo) then
            Informar('Proceso finalizado con éxito.')
          else
            Informar('Proceso finalizado con errores.')
        end
        else
        begin
          MessageBox(self.Handle,
            ' Falta calcular y ajustar aprovechamientos con respecto a la merma' +
            #13 + #10 + ' o alguna escandallo tiene todos los porcentajes a 0.',
            'APROVECHAMIENTOS',
            MB_OK + MB_ICONEXCLAMATION);
        end;
      end
      else
      begin
        MessageBox(self.Handle,
          ' Falta grabar aprovechamientos para alguna entrada de fruta.',
          'APROVECHAMIENTOS',
          MB_OK + MB_ICONEXCLAMATION);
      end;
    end
    else
    begin
        MessageBox(self.Handle,
          PChar( sMsg ),
          'APROVECHAMIENTOS',
          MB_OK + MB_ICONEXCLAMATION);
    end;
  end;
  BEMensajes('');
end;

function SQLKilosEscandallo: string;
begin
  result :=
    ' select ' + #13 + #10 +
    ' round(sum(porcen_primera_e * (select total_kgs_e2l ' + #13 + #10 +
    ' from frf_entradas2_l ' + #13 + #10 +
    ' where empresa_e2l = empresa_e ' + #13 + #10 +
    ' and centro_e2l = centro_e ' + #13 + #10 +
    ' and numero_entrada_e2l = numero_entrada_e ' + #13 + #10 +
    ' and fecha_e2l = fecha_e ' + #13 + #10 +
    ' and cosechero_e2l = cosechero_e ' + #13 + #10 +
    ' and plantacion_e2l = plantacion_e ' + #13 + #10 +
    ' and producto_e2l = producto_e )) / 100 , 2 ) kgs_c1_escandallo, ' + #13 + #10 +
    ' ' + #13 + #10 +
    ' round(sum(porcen_segunda_e *(select total_kgs_e2l ' + #13 + #10 +
    ' from frf_entradas2_l ' + #13 + #10 +
    ' where empresa_e2l = empresa_e ' + #13 + #10 +
    ' and centro_e2l = centro_e ' + #13 + #10 +
    ' and numero_entrada_e2l = numero_entrada_e ' + #13 + #10 +
    ' and fecha_e2l = fecha_e ' + #13 + #10 +
    ' and cosechero_e2l = cosechero_e ' + #13 + #10 +
    ' and plantacion_e2l = plantacion_e ' + #13 + #10 +
    ' and producto_e2l = producto_e )) / 100 , 2 ) kgs_c2_escandallo, ' + #13 + #10 +
    ' ' + #13 + #10 +
    ' round(sum(porcen_tercera_e * (select total_kgs_e2l ' + #13 + #10 +
    ' from frf_entradas2_l ' + #13 + #10 +
    ' where empresa_e2l = empresa_e ' + #13 + #10 +
    ' and centro_e2l = centro_e ' + #13 + #10 +
    ' and numero_entrada_e2l = numero_entrada_e ' + #13 + #10 +
    ' and fecha_e2l = fecha_e ' + #13 + #10 +
    ' and cosechero_e2l = cosechero_e ' + #13 + #10 +
    ' and plantacion_e2l = plantacion_e ' + #13 + #10 +
    ' and producto_e2l = producto_e )) / 100 , 2 ) kgs_c3_escandallo, ' + #13 + #10 +
    ' ' + #13 + #10 +
    ' round(sum(porcen_destrio_e * (select total_kgs_e2l ' + #13 + #10 +
    ' from frf_entradas2_l ' + #13 + #10 +
    ' where empresa_e2l = empresa_e ' + #13 + #10 +
    ' and centro_e2l = centro_e ' + #13 + #10 +
    ' and numero_entrada_e2l = numero_entrada_e ' + #13 + #10 +
    ' and fecha_e2l = fecha_e ' + #13 + #10 +
    ' and cosechero_e2l = cosechero_e ' + #13 + #10 +
    ' and plantacion_e2l = plantacion_e ' + #13 + #10 +
    ' and producto_e2l = producto_e )) / 100 , 2 ) kgs_destrio_escandallo, ' + #13 + #10 +
    ' ' + #13 + #10 +
    ' round(sum((select total_kgs_e2l ' + #13 + #10 +
    ' from frf_entradas2_l ' + #13 + #10 +
    ' where empresa_e2l = empresa_e ' + #13 + #10 +
    ' and centro_e2l = centro_e ' + #13 + #10 +
    ' and numero_entrada_e2l = numero_entrada_e ' + #13 + #10 +
    ' and fecha_e2l = fecha_e ' + #13 + #10 +
    ' and cosechero_e2l = cosechero_e ' + #13 + #10 +
    ' and plantacion_e2l = plantacion_e ' + #13 + #10 +
    ' and producto_e2l = producto_e )) , 2 ) kgs_total ' + #13 + #10 +
    ' ' + #13 + #10 +
    ' from frf_escandallo ' + #13 + #10 +
    ' where empresa_e = :empresa ' + #13 + #10 +
    '   and centro_e = :centro ' + #13 + #10 +
    '   and producto_e = :producto ' + #13 + #10 +
    '   and fecha_e between :fechaini and :fechafin ';
end;

procedure PorcentajeEntradaInicial(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
  var c1, c2, c3, cd: real);
var
  total, cm: real;
begin
  cm := 0;
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(SQLKilosEscandallo);
    ParamByName('fechaini').AsString := AFechaIni;
    ParamByName('fechafin').AsString := AFechaFin;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    //Kilos;
    c1 := fields[0].AsFloat;
    c2 := fields[1].AsFloat;
    c3 := fields[2].AsFloat;
    cd := fields[3].AsFloat;
    total := fields[4].AsFloat;
    Close;
    Ajustar(c1, c2, c3, cd, cm, total);
    //Porcentajes;
    c1 := c1 * 100 / total;
    c2 := c2 * 100 / total;
    c3 := c3 * 100 / total;
    cd := cd * 100 / total;
    cm := 0;
    Ajustar(c1, c2, c3, cd, cm, 100);
  end;
end;


function PorcentajesDestrioPeninsula(
  const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string): real;
var
  rAux: real;
begin
  result:= 100;
  if ( AEmpresa = '050' ) and ( ACentro = '6' ) and ( AProducto = 'E' ) then
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    //SALIDAS DIRECTAS
    SQL.Add(' select sum( case when categoria_sl in ( ''2B'',''3B'' ) then kilos_sl else 0 end ) kilos_cat_d ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and fecha_sc between :fechaini and :fechafin ');

    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');

    SQL.Add(' and producto_sl = :producto ');
    SQL.Add(' and ref_transitos_sl is null  ');
    SQL.Add(' and nvl(es_transito_sc,0) = 0 ');    
    SQL.Add(' and categoria_sl <> ''B''  ');

    ParamByName('fechaini').AsString := AFechaIni;
    ParamByName('fechafin').AsString := AFechaFin;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;

    rAux := Fields[0].AsFloat;
    Close;

    SQL.Clear;
    //--SALIDAS INDIRECTAS
    SQL.Add(' select  sum( case when categoria_sl in ( ''2B'',''3B'' ) then kilos_sl else 0 end ) kilos_cat_d ');
    SQL.Add(' from frf_salidas_l ');

    SQL.Add(' where empresa_sl ' + SQLEqualS(AEmpresa));
    SQL.Add(' and fecha_sl >= :fechainisal ');
    SQL.Add(' and producto_sl ' + SQLEqualS(AProducto));
    SQL.Add(' and centro_origen_sl ' + SQLEqualS(ACentro));
    SQL.Add(' and categoria_sl <> ''B''  ');

    SQL.Add(' and ref_transitos_sl in ');
    SQL.Add(' (select referencia_tl ');
    SQL.Add('  from frf_transitos_l ');
    SQL.Add('  where empresa_tl ' + SQLEqualS(AEmpresa));
    SQL.Add('  and fecha_tl between :fechaini and :fechafin ');
    SQL.Add('  and producto_tl ' + SQLEqualS(AProducto));
    SQL.Add('  and centro_tl ' + SQLEqualS(ACentro));
    SQL.Add('  and ref_origen_tl is null ');
    SQL.Add(' ) ');

    ParamByName('fechaini').AsDate:= StrToDate( AFechaIni );
    ParamByName('fechainisal').AsDate:= StrToDate( AFechaIni ) - 60;
    ParamByName('fechafin').AsDate:= StrToDate( AFechaFin );

    Open;
    if Fields[0].AsFloat + rAux <> 0 then
    begin
      //Hay destrio
      result:= bRoundTo( ( Fields[0].AsFloat * 100 ) / ( Fields[0].AsFloat + rAux ), -2 );
    end;
    Close;
  end;
end;

function SQLKilosAprovechamiento: string;
begin
  result :=
    ' select ' + #13 + #10 +
    ' round(sum( aporcen_primera_e * total_kgs_e2l ) / 100 , 2 ) kgs_c1_escandallo, ' + #13 + #10 +
    ' round(sum( aporcen_segunda_e * total_kgs_e2l ) / 100 , 2 ) kgs_c2_escandallo, ' + #13 + #10 +
    ' round(sum( aporcen_tercera_e * total_kgs_e2l ) / 100 , 2 ) kgs_c3_escandallo, ' + #13 + #10 +
    ' round(sum( aporcen_destrio_e * total_kgs_e2l ) / 100 , 2 ) kgs_destrio_escandallo, ' + #13 + #10 +
    ' round(sum( aporcen_merma_e * total_kgs_e2l ) / 100 , 2 ) kgs_merma_escandallo, ' + #13 + #10 +
    ' sum( total_kgs_e2l ) kgs_total ' + #13 + #10;

    (*
    ' select ' + #13 + #10 +
    ' round(sum(aporcen_primera_e * (select total_kgs_e2l ' + #13 + #10 +
    ' from frf_entradas2_l ' + #13 + #10 +
    ' where empresa_e2l = empresa_e ' + #13 + #10 +
    ' and centro_e2l = centro_e ' + #13 + #10 +
    ' and numero_entrada_e2l = numero_entrada_e ' + #13 + #10 +
    ' and fecha_e2l = fecha_e ' + #13 + #10 +
    ' and cosechero_e2l = cosechero_e ' + #13 + #10 +
    ' and plantacion_e2l = plantacion_e ' + #13 + #10 +
    ' and producto_e2l = producto_e )) / 100 , 2 ) kgs_c1_escandallo, ' + #13 + #10 +
    ' ' + #13 + #10 +
    ' round(sum(aporcen_segunda_e *(select total_kgs_e2l ' + #13 + #10 +
    ' from frf_entradas2_l ' + #13 + #10 +
    ' where empresa_e2l = empresa_e ' + #13 + #10 +
    ' and centro_e2l = centro_e ' + #13 + #10 +
    ' and numero_entrada_e2l = numero_entrada_e ' + #13 + #10 +
    ' and fecha_e2l = fecha_e ' + #13 + #10 +
    ' and cosechero_e2l = cosechero_e ' + #13 + #10 +
    ' and plantacion_e2l = plantacion_e ' + #13 + #10 +
    ' and producto_e2l = producto_e )) / 100 , 2 ) kgs_c2_escandallo, ' + #13 + #10 +
    ' ' + #13 + #10 +
    ' round(sum(aporcen_tercera_e * (select total_kgs_e2l ' + #13 + #10 +
    ' from frf_entradas2_l ' + #13 + #10 +
    ' where empresa_e2l = empresa_e ' + #13 + #10 +
    ' and centro_e2l = centro_e ' + #13 + #10 +
    ' and numero_entrada_e2l = numero_entrada_e ' + #13 + #10 +
    ' and fecha_e2l = fecha_e ' + #13 + #10 +
    ' and cosechero_e2l = cosechero_e ' + #13 + #10 +
    ' and plantacion_e2l = plantacion_e ' + #13 + #10 +
    ' and producto_e2l = producto_e )) / 100 , 2 ) kgs_c3_escandallo, ' + #13 + #10 +
    ' ' + #13 + #10 +
    ' round(sum(aporcen_destrio_e * (select total_kgs_e2l ' + #13 + #10 +
    ' from frf_entradas2_l ' + #13 + #10 +
    ' where empresa_e2l = empresa_e ' + #13 + #10 +
    ' and centro_e2l = centro_e ' + #13 + #10 +
    ' and numero_entrada_e2l = numero_entrada_e ' + #13 + #10 +
    ' and fecha_e2l = fecha_e ' + #13 + #10 +
    ' and cosechero_e2l = cosechero_e ' + #13 + #10 +
    ' and plantacion_e2l = plantacion_e ' + #13 + #10 +
    ' and producto_e2l = producto_e )) / 100 , 2 ) kgs_destrio_escandallo, ' + #13 + #10 +
    ' ' + #13 + #10 +
    ' round(sum(aporcen_merma_e * (select total_kgs_e2l ' + #13 + #10 +
    ' from frf_entradas2_l ' + #13 + #10 +
    ' where empresa_e2l = empresa_e ' + #13 + #10 +
    ' and centro_e2l = centro_e ' + #13 + #10 +
    ' and numero_entrada_e2l = numero_entrada_e ' + #13 + #10 +
    ' and fecha_e2l = fecha_e ' + #13 + #10 +
    ' and cosechero_e2l = cosechero_e ' + #13 + #10 +
    ' and plantacion_e2l = plantacion_e ' + #13 + #10 +
    ' and producto_e2l = producto_e )) / 100 , 2 ) kgs_merma_escandallo, ' + #13 + #10 +
    ' ' + #13 + #10 +
    ' round(sum((select total_kgs_e2l ' + #13 + #10 +
    ' from frf_entradas2_l ' + #13 + #10 +
    ' where empresa_e2l = empresa_e ' + #13 + #10 +
    ' and centro_e2l = centro_e ' + #13 + #10 +
    ' and numero_entrada_e2l = numero_entrada_e ' + #13 + #10 +
    ' and fecha_e2l = fecha_e ' + #13 + #10 +
    ' and cosechero_e2l = cosechero_e ' + #13 + #10 +
    ' and plantacion_e2l = plantacion_e ' + #13 + #10 +
    ' and producto_e2l = producto_e )) , 2 ) kgs_total ' + #13 + #10 +
    ' ' + #13 + #10;
    *)

    if gbAjustarSeleccionado then
    begin
      (*
      result := result +
        ' from frf_escandallo ' + #13 + #10 +
        ' where empresa_e = :empresa ' + #13 + #10 +
        '   and centro_e = :centro ' + #13 + #10 +
        '   and producto_e = :producto ' + #13 + #10 +
        '   and fecha_e between :fechaini and :fechafin ';
      *)
      result := result +
        ' from frf_entradas_c, frf_entradas2_l, frf_escandallo ' + #13 + #10 +
        '  where empresa_ec = :empresa ' + #13 + #10 +
        '    and centro_ec = :centro ' + #13 + #10 +
        '    and producto_ec = :producto ' + #13 + #10 +
        '    and fecha_ec between :fechaini and :fechafin ' + #13 + #10 +

        '    and empresa_e2l = :empresa ' + #13 + #10 +
        '    and centro_e2l = :centro ' + #13 + #10 +
        '    and producto_e2l = :producto ' + #13 + #10 +
        '    and fecha_e2l = fecha_ec ' + #13 + #10 +
        '    and numero_entrada_e2l = numero_entrada_ec ' + #13 + #10 +

        '    and empresa_e = :empresa ' + #13 + #10 +
        '    and centro_e = :centro ' + #13 + #10 +
        '    and producto_e = :producto ' + #13 + #10 +
        '    and fecha_e = fecha_e2l ' + #13 + #10 +
        '    and numero_entrada_e = numero_entrada_e2l ' + #13 + #10 +
        '    and cosechero_e = cosechero_e2l ' + #13 + #10 +
        '    and plantacion_e = plantacion_e2l '+ #13 + #10 +
        '    and anyo_semana_e = ano_sem_planta_e2l ';
    end
    else
    begin
      result := result +
        ' from frf_entradas2_l, frf_escandallo, frf_entradas_tipo ' + #13 + #10 +
        '  where empresa_e2l = :empresa ' + #13 + #10 +
        '    and centro_e2l = :centro ' + #13 + #10 +
        '    and producto_e2l = :producto ' + #13 + #10 +
        '    and fecha_e2l between :fechaini and :fechafin ' + #13 + #10 +

        '    and empresa_e = :empresa ' + #13 + #10 +
        '    and centro_e = :centro ' + #13 + #10 +
        '    and producto_e = :producto ' + #13 + #10 +
        '    and fecha_e = fecha_e2l ' + #13 + #10 +
        '    and numero_entrada_e = numero_entrada_e2l ' + #13 + #10 +
        '    and cosechero_e = cosechero_e2l ' + #13 + #10 +
        '    and plantacion_e = plantacion_e2l '+ #13 + #10 +
        '    and anyo_semana_e = ano_sem_planta_e2l '+ #13 + #10 +

        '    and empresa_et = :empresa ' + #13 + #10 +
        '    and tipo_et = tipo_entrada_e ' + #13 + #10 +
        '    and ajuste_et = 1 ';

    end;
end;

procedure KilosEntrada(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
  var k1, k2, k3, kd, km: real);
var
  total: real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(SQLKilosAprovechamiento);
    ParamByName('fechaini').AsString := AFechaIni;
    ParamByName('fechafin').AsString := AFechaFin;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    k1 := fields[0].AsFloat;
    k2 := fields[1].AsFloat;
    k3 := fields[2].AsFloat;
    kd := fields[3].AsFloat;
    km := fields[4].AsFloat;
    total := fields[5].AsFloat;
    Close;
    Ajustar(k1, k2, k3, kd, km, total);
(*
    informe.Add('ESCANDALLO');
    informe.Add(FloatToStr(k1)+ ' ' + FloatToStr(k2)+ ' ' + FloatToStr(k3)+ ' ' + FloatToStr(kd)+ ' ' + FloatToStr(km)+ ' ' );
*)
  end;
end;

function TotalEntrada(const AEmpresa, ACentro, AProducto,
  AFechaIni, AFechaFin: string; var rKSelecC1, rKSelecC2, rKSelecC3: real ): real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(
        ' select sum(total_kgs_e2l) ' + #13 + #10 +
        ' from frf_entradas2_l ' + #13 + #10 +
        ' where empresa_e2l = :empresa ' + #13 + #10 +
        '   and centro_e2l = :centro ' + #13 + #10 +
        '   and producto_e2l = :producto ' + #13 + #10 +
        '   and fecha_e2l between :fechaini and :fechafin ');
    ParamByName('fechaini').AsString := AFechaIni;
    ParamByName('fechafin').AsString := AFechaFin;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    result := fields[0].AsFloat;
    Close;

    SQL.Clear;
    SQL.Add(
        ' select sum(round((porcen_primera_e * total_kgs_e2l)/100,2)) kilos_primera, ' + #13 + #10 +
        '        sum(round((porcen_segunda_e * total_kgs_e2l)/100,2)) kilos_segunda, ' + #13 + #10 +
        '        sum(round((porcen_tercera_e * total_kgs_e2l)/100,2)) kilos_tercera ' + #13 + #10 +
        '  from frf_entradas2_l, frf_escandallo, frf_entradas_tipo  ' + #13 + #10 +
        '  where empresa_e2l = :empresa ' + #13 + #10 +
        '    and centro_e2l = :centro ' + #13 + #10 +
        '    and producto_e2l = :producto ' + #13 + #10 +
        '    and fecha_e2l between :fechaini and :fechafin ' + #13 + #10 +

        '    and empresa_e = :empresa ' + #13 + #10 +
        '    and centro_e = :centro ' + #13 + #10 +
        '    and producto_e = :producto ' + #13 + #10 +
        '    and fecha_e = fecha_e2l ' + #13 + #10 +
        '    and numero_entrada_e = numero_entrada_e2l  ' + #13 + #10 +
        '    and cosechero_e = cosechero_e2l  ' + #13 + #10 +
        '    and plantacion_e = plantacion_e2l  ' + #13 + #10 +
        '    and anyo_semana_e = ano_sem_planta_e2l  ' + #13 + #10 +

        '    and empresa_et = :empresa ' + #13 + #10 +
        '    and tipo_et = tipo_entrada_e ' + #13 + #10 +
        '    and ajuste_et = 0 ');

    ParamByName('fechaini').AsString := AFechaIni;
    ParamByName('fechafin').AsString := AFechaFin;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    rKSelecC1:= fields[0].AsFloat;
    rKSelecC2:= fields[1].AsFloat;
    rKSelecC3:= fields[2].AsFloat;
    Close;
  end;

  if not gbAjustarSeleccionado then
    result:= result - ( rKSelecC1 + rKSelecC2 + rKSelecC3 );
  //informe.Add('TOTAL ENTRADA : ' + FloatToStr(result));
end;

procedure SalvaAjuste( const QUpdate: Tquery;
  const AEmpresa, ACentro, AProducto: string;
  const c1, c2, c3, cd, cm: real);
begin
  if bRoundTo( c1 + c2 +  c3 + cd + cm, 0 ) <> 100 then
  begin
    raise Exception.Create( 'Error entrada : ' + QUpdate.ParamByName('entrada').AsString );
  end
  else
  begin
    QUpdate.ParamByName('empresa').AsString := AEmpresa;
    QUpdate.ParamByName('centro').AsString := ACentro;
    QUpdate.ParamByName('producto').AsString := AProducto;
    QUpdate.ParamByName('entrada').AsInteger := dmBaseDatos.QTemp.fieldbyname('numero_entrada_e').asinteger;
    QUpdate.ParamByName('fecha').AsDate := dmBaseDatos.QTemp.fieldbyname('fecha_e').AsDateTime;
    QUpdate.ParamByName('cosechero').AsInteger := dmBaseDatos.QTemp.fieldbyname('cosechero_e').AsInteger;
    QUpdate.ParamByName('plantacion').AsInteger := dmBaseDatos.QTemp.fieldbyname('plantacion_e').AsInteger;
    QUpdate.ParamByName('pc1').AsFloat := c1;
    QUpdate.ParamByName('pc2').AsFloat := c2;
    QUpdate.ParamByName('pc3').AsFloat := c3;
    QUpdate.ParamByName('pcd').AsFloat := cd;
    QUpdate.ParamByName('pcm').AsFloat := cm;
    QUpdate.ExecSQL;
  end;
end;

function GetFactor(const v1, v2: real): real;
begin
  if v1 = 0 then
  begin
    result := 0;
  end
  else
    if v2 = 0 then
    begin
      result := 999;
    end
    else
    begin
      result := v1 / v2;
    end;
end;

function GetNewPorcentaje(const rPorcenIni, rFactor, rPorcenFin: real; const iPaso, iMaxPaso: integer): real;
begin
  if rFactor = 999 then
  begin
    result := bRoundTo( ( rPorcenFin * iPaso ) / IMaxPaso, -5 );
  end
  else
  begin
    result := bRoundTo( rPorcenIni * rFactor, -5 );
  end;
end;


procedure TFAprovechaAjuste.BajarCategoria( const AEmpresa, ACentro, AProducto: string; const ADesde, AHasta: TDateTime; const ACat: integer );
begin
  with UDMBaseDatos.DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('update frf_escandallo ');
    if ACat = 1 then
      SQL.Add('set porcen_segunda_e = porcen_primera_E + porcen_segunda_e, porcen_primera_e = 0 ');
    if ACat = 2 then
      SQL.Add('set porcen_tercera_e = porcen_segunda_E + porcen_tercera_e, porcen_segunda_e = 0 ');
    if ACat = 3 then
      SQL.Add('set porcen_destrio_e = porcen_tercera_E + porcen_destrio_e, porcen_tercera_e = 0 ');
    SQL.Add('where empresa_e = :empresa ');
    SQL.Add('and fecha_e between :fechaini and :fechafin ');
    SQL.Add('and centro_e = :centro ');
    SQL.Add('and producto_e = :producto ');
    SQL.Add('and tipo_entrada_e = 0 ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fechaini').AsDate:= ADesde;
    ParamByName('fechafin').AsDate:= AHasta;

    ExecSQL;
  end;
end;


procedure TFAprovechaAjuste.AjustePrevio( const AEmpresa, ACentro, AProducto: string; const ADesde, AHasta: TDateTime; const APorc1, APorc2, APorc3: real );
var
  rAux: real;
begin
  //Si no hay salidas de primera no debe haber escandallos de primera
  if  ( APorc1 = 0 ) then
  begin
    BajarCategoria( AEmpresa, ACentro, AProducto, ADesde, AHasta, 1 );
  end;
  //Si no hay salidas de segunda no debe haber escandallos de segunda
  if ( APorc2 = 0 ) then
  begin
    BajarCategoria( AEmpresa, ACentro, AProducto, ADesde, AHasta, 2 );
  end;
  //Si no hay salidas de tercera no debe haber escandallos de tercera
  if ( APorc3 = 0 ) then
  begin
    BajarCategoria( AEmpresa, ACentro, AProducto, ADesde, AHasta, 3 );
  end;
end;

function TFAprovechaAjuste.AjustarAprovechamientosSalida(const AEmpresa, Acentro, Aproducto,
  AfechaIni, AFechaFin: string): boolean;
var
  c1, c2, c3, cd, cm: real; //
  c1_, c2_, c3_, cd_, cm_: real; //
  k1e, k2e, k3e, kde, kme, totale: real; //kilos entrada
  p1s, p2s, p3s, pds: real; //porcentajes de salida
  k1o, k2o, k3o, kdo, kmo: real; //kilos objetivo
  fc1, fc2, fc3, fcd, fcm: real; //factor de correcion kilos_entrada-kilos_objetivo
  pm: real; //porcentaje de merma
  iter: integer;
  error: real;
  QUpdate: TQuery;
  rKSelecC1, rKSelecC2, rKSelecC3: real;
  rAux: real;
begin

  QueryUpdate;

  result:= True;
  QUpdate:= TQuery.Create( nil );
  try
  QUpdate.DatabaseName:= 'BDProyecto';
  QUpdate.SQL.Clear;
  QUpdate.SQL.add('   update frf_escandallo ');
  QUpdate.SQL.add(' set  aporcen_primera_e = :pc1, ');
  QUpdate.SQL.add('        aporcen_segunda_e = :pc2, ');
  QUpdate.SQL.add('        aporcen_tercera_e = :pc3, ');
  QUpdate.SQL.add('        aporcen_destrio_e = :pcd, ');
  QUpdate.SQL.add('        aporcen_merma_e = :pcm ');
  QUpdate.SQL.add(' where empresa_e = :empresa ');
  QUpdate.SQL.add(' and centro_e = :centro ');
  QUpdate.SQL.add(' and numero_entrada_e = :entrada ');
  QUpdate.SQL.add(' and fecha_e = :fecha ');
  QUpdate.SQL.add(' and cosechero_e = :cosechero ');
  QUpdate.SQL.add(' and plantacion_e = :plantacion ');
  QUpdate.SQL.add(' and producto_e = :producto ');
  QUpdate.Prepare;

  informe.Clear;

  informe.Add(' ');
  informe.Add('  PRIMERA' + '   SEGUNDA' + '   TERCERA' + '   DESTRIO' + '     MERMA');
  informe.Add(' --------' + '  --------' + '  --------' + '  --------' + '  --------');

  dmBaseDatos.QTemp.ParamByName('fechaini').AsString := AFechaIni;
  dmBaseDatos.QTemp.ParamByName('fechafin').AsString := AFechaFin;
  dmBaseDatos.QTemp.ParamByName('empresa').AsString := AEmpresa;
  dmBaseDatos.QTemp.ParamByName('centro').AsString := ACentro;
  dmBaseDatos.QTemp.ParamByName('producto').AsString := AProducto;

  rKSelecC1:= 0;
  rKSelecC2:= 0;
  rKSelecC3:= 0;
  totale := TotalEntrada(AEmpresa, ACentro, Aproducto, AfechaIni, AFechaFin, rKSelecC1, rKSelecC2, rKSelecC3);

  if totale = 0 then
  begin
    if ( rKSelecC1 + rKSelecC2 + rKSelecC3 ) > 0 then
      ShowMessage('Todo el producto es seleccionado, no es necesario ajustar.')
    else
      ShowMessage('No hay producto de entrada para los parametros seleccionados.');
    Exit;
  end;

  KilosEntrada(AEmpresa, ACentro, Aproducto, AfechaIni, AFechaFin, k1e, k2e, k3e, kde, kme);
  pm := bRoundTo((kme * 100) / (totale), -5);
(*
  pm:= AprovechamientosPorcenMerma( AEmpresa, ACentro, Aproducto, AfechaIni, AFechaFin );
*)
  informe.Add('');
  informe.Add( GetPorcentajesSalida(AEmpresa, ACentro, Aproducto, AfechaIni, AFechaFin,
               p1s, p2s, p3s, pds, pm, rKSelecC1, rKSelecC2, rKSelecC3 ) );

  pm:= bRoundTo( 100 - (p1s + p2s + p3s + pds ), -5);
  k1o := bRoundTo( totale * p1s / 100, -5 );
  k2o := bRoundTo( totale * p2s / 100, -5 );
  k3o := bRoundTo( totale * p3s / 100, -5 );
  kdo := bRoundTo( totale * pds / 100, -5 );
  kmo := bRoundTo( totale * pm / 100, -5 );
  Ajustar(k1o, k2o, k3o, kdo, kmo, totale);

  if ( k1o < 0 ) or ( k2o < 0 ) or ( k3o < 0 ) or ( kdo < 0 ) or ( kmo < 0 ) then
  begin
    informe.Add('');
    informe.Add('*****************************************************');
    informe.Add('ERRROR: ');
    informe.Add('*****************************************************');
    informe.Add('Los porcentajes de salida no pueden ser negativos.');
    informe.Add('Por favor compuebe que las salidas y los inventarios.');
    informe.Add('  sean correctos. ');
    informe.Add('*****************************************************');
    result:= false;
    memo.Clear;
    memo.Lines.AddStrings(informe);
    memo.SelStart := 0;
    memo.SelLength := 0;
    Exit;
  end;

  //informe.Add('OBJETIVO');
  //informe.Add(FloatToStr(k1o)+ ' ' + FloatToStr(k2o)+ ' ' + FloatToStr(k3o)+ ' ' + FloatToStr(kdo)+ ' ' + FloatToStr(kmo)+ ' ' );
  PorcentajeEntradaInicial(AEmpresa, ACentro, Aproducto, AfechaIni, AFechaFin,
    c1, c2, c3, cd);
  informe.Add(' ');
  informe.Add(FormatFloat('00.00000', c1) + '  ' +
    FormatFloat('00.00000', c2) + '  ' +
    FormatFloat('00.00000', c3) + '  ' +
    FormatFloat('00.00000', cd) + '  ' +
    '            % ENTRADA INICIAL');

  AjustePrevio( AEmpresa, ACentro, Aproducto, strTodate( AFechaIni ), strTodate( AFechaFin ),  p1s, p2s, p3s );

  iter := 0;
  while iter < 50 do
  begin
    Inc(iter);
    KilosEntrada(AEmpresa, ACentro, Aproducto, AfechaIni, AFechaFin, k1e, k2e, k3e, kde, kme);


    fc1 := GetFactor(k1o, k1e);
    fc2 := GetFactor(k2o, k2e);
    fc3 := GetFactor(k3o, k3e);
    fcd := GetFactor(kdo, kde);
    fcm := GetFactor(kmo, kme);

    error := Abs(1 - fc1) + Abs(1 - fc2) + Abs(1 - fc3) + Abs(1 - fcd) + Abs(1 - fcm);

    if iter = 1 then
    begin
      c1 := k1e * 100 / totale;
      c2 := k2e * 100 / totale;
      c3 := k3e * 100 / totale;
      cd := kde * 100 / totale;
      cm := kme * 100 / totale;
      Ajustar(c1, c2, c3, cd, cm, 100);
      informe.Add(' ');
      informe.Add(FormatFloat('00.00000', c1) + '  ' +
        FormatFloat('00.00000', c2) + '  ' +
        FormatFloat('00.00000', c3) + '  ' +
        FormatFloat('00.00000', cd) + '  ' +
        FormatFloat('00.00000', cm) + '  ' +
        '  % ENTRADA AJUSTE MERMA');
      //informe.Add('DATOS INICIALES');
      //informe.Add('KGS ENTRADA INICIAL');
      //informe.Add( FloatToStr(k1e)+ ' ' + FloatToStr(k2e)+ ' ' + FloatToStr(k3e)+ ' ' + FloatToStr(kde)+ ' ' + FloatToStr(kme)+ ' ' );
      //informe.Add('DESVIACION CON RESPECTO AL OBJETIVO');
      //informe.Add(FloatToStr(fc1)+ ' ' + FloatToStr(fc2)+ ' ' + FloatToStr(fc3)+ ' ' + FloatToStr(fcd)+ ' ' + FloatToStr(fcm)+ ' ' );
      //informe.Add('ERROR ['+FloatToStr(error)+']');
    end;

    if not OpenQuery(dmBaseDatos.QTemp) then abort;
    while not dmBaseDatos.QTemp.Eof do
    begin
      c1 := GetNewPorcentaje(dmBaseDatos.QTemp.FieldByName('aporcen_primera_e').AsFloat, fc1, p1s, iter, 10);
      c2 := GetNewPorcentaje(dmBaseDatos.QTemp.FieldByName('aporcen_segunda_e').AsFloat, fc2, p2s, iter, 10);
      c3 := GetNewPorcentaje(dmBaseDatos.QTemp.FieldByName('aporcen_tercera_e').AsFloat, fc3, p3s, iter, 10);
      cd := GetNewPorcentaje(dmBaseDatos.QTemp.FieldByName('aporcen_destrio_e').AsFloat, fcd, pds, iter, 10);
      cm := dmBaseDatos.QTemp.FieldByName('aporcen_merma_e').AsFloat;

      (*
      c1 := GetNewPorcentaje(dmBaseDatos.QTemp.FieldByName('aporcen_primera_e').AsFloat, fc1, p1s, iter, 10) + p1s;
      c2 := GetNewPorcentaje(dmBaseDatos.QTemp.FieldByName('aporcen_segunda_e').AsFloat, fc2, p2s, iter, 10) + p2s;
      c3 := GetNewPorcentaje(dmBaseDatos.QTemp.FieldByName('aporcen_tercera_e').AsFloat, fc3, p3s, iter, 10) + p3s;
      cd := GetNewPorcentaje(dmBaseDatos.QTemp.FieldByName('aporcen_destrio_e').AsFloat, fcd, pds, iter, 10) + pds;
      cm := dmBaseDatos.QTemp.FieldByName('aporcen_merma_e').AsFloat;

      rAux:= 200;
      if ( dmBaseDatos.QTemp.FieldByName('aporcen_segunda_e').AsFloat = 0 ) and
         ( dmBaseDatos.QTemp.FieldByName('aporcen_primera_e').AsFloat <> 0 ) then
      begin
        rAux:= rAux + 100;
        c1:= c1 + 100;
      end;
      if ( dmBaseDatos.QTemp.FieldByName('aporcen_tercera_e').AsFloat = 0 ) and
         ( dmBaseDatos.QTemp.FieldByName('aporcen_primera_e').AsFloat <> 0 ) then
      begin
        rAux:= rAux + 100;
        c1:= c1 + 100;
      end;
      if ( dmBaseDatos.QTemp.FieldByName('aporcen_destrio_e').AsFloat = 0 ) and
         ( dmBaseDatos.QTemp.FieldByName('aporcen_primera_e').AsFloat <> 0 ) then
      begin
        rAux:= rAux + 100;
        c1:= c1 + 100;
      end;
      Ajustar(c1, c2, c3, cd, cm, rAux );
      c1:= bRoundTo( c1/2, -5 );
      c2:= bRoundTo( c2/2, -5 );
      c3:= bRoundTo( c3/2, -5 );
      cd:= bRoundTo( cd/2, -5 );
      cm := dmBaseDatos.QTemp.FieldByName('aporcen_merma_e').AsFloat;
      *)

      if c1 + c2 + c3 + cd = 0 then
        cm:= 100;
      Ajustar(c1, c2, c3, cd, cm );
      SalvaAjuste(QUpdate, AEmpresa, Acentro, Aproducto, c1, c2, c3, cd, cm);
      dmBaseDatos.QTemp.Next;
    end;
    dmBaseDatos.QTemp.Close;
    //if (error < 0.001) then
    if (error < 1) then
    begin
      if gsCodigo = 'informix' then Informar('Iteraciones = ' + IntToStr(iter));
      break;
    end;
  end;

  informe.Add(' ');
  KilosEntrada(AEmpresa, ACentro, Aproducto, AfechaIni, AFechaFin, k1e, k2e, k3e, kde, kme);

  c1 := k1e * 100 / totale;
  c2 := k2e * 100 / totale;
  c3 := k3e * 100 / totale;
  cd := kde * 100 / totale;
  cm := kme * 100 / totale;
  Ajustar(c1, c2, c3, cd, cm, 100);


  if c1 + c2 + c3 + cd = 0 then
  begin
    informe.Add('');
    informe.Add('ERRROR: ');
    informe.Add('Los porcentajes de aprovechamiento no pueden ser ');
    informe.Add('  todos 0. Por favor revise el producto seleccionado ');
    informe.Add('  y los inventarios del almacén. ');
    informe.Add('');
    result:= false;
  end;


  if ( c1 < 0 ) or ( c2 < 0 ) or ( c3 < 0 ) or ( cd < 0 ) or ( cm < 0 ) then
  begin
    informe.Add('');
    informe.Add('ERRROR: ');
    informe.Add('Los porcentajes de aprovechamiento no pueden ser ');
    informe.Add('  negativos. Por favor pongase en contacto con ');
    informe.Add('  el departamento de informática. ');
    result:= false;
  end;

  informe.Add(FormatFloat('00.00000', c1) + '  ' +
    FormatFloat('00.00000', c2) + '  ' +
    FormatFloat('00.00000', c3) + '  ' +
    FormatFloat('00.00000', cd) + '  ' +
    FormatFloat('00.00000', cm) + '  ' +
    '  % ENTRADA FINAL');
  //informe.Add('DATOS FINALES DESPUES DE ' + IntToStr(iter) + ' ITERACIONES.');
  //informe.Add('ENTRADA');
  //informe.Add(FloatToStr(k1e)+ ' ' + FloatToStr(k2e)+ ' ' + FloatToStr(k3e)+ ' ' + FloatToStr(kde)+ ' ' + FloatToStr(kme)+ ' ' );
  //informe.Add('DESVIACION CON RESPECTO AL OBJETIVO');
  //informe.Add(FloatToStr(fc1)+ ' ' + FloatToStr(fc2)+ ' ' + FloatToStr(fc3)+ ' ' + FloatToStr(fcd)+ ' ' + FloatToStr(fcm)+ ' ' );
  //informe.Add('ERROR ['+FloatToStr(error)+']');
  memo.Clear;
  memo.Lines.AddStrings(informe);
  memo.SelStart := 0;
  memo.SelLength := 0;

  finally
  FreeAndNil( QUpdate );
  end;
end;


procedure TFAprovechaAjuste.btnImprimirClick(Sender: TObject);
//var
  //i: integer;
  //IBMProPrinter: TIBMProPrinter;
begin
{
  if memo.Lines.Count = 0 then Exit;
  IBMProPrinter := TIBMProPrinter.create(nil);
  try
    IBMProPrinter.BeginDoc;
    IBMProPrinter.WriteLn(' ');
    IBMProPrinter.WriteLn('  AJUSTE DE APROVECHAMIENTOS POR APROVECHAMIENTO REAL');
    IBMProPrinter.WriteLn('');
    IBMProPrinter.WriteLn('  EMPRESA           = ' + empresa.Text + ' ' + des_empresa.Caption);
    IBMProPrinter.WriteLn('  CENTRO            = ' + centro.Text + ' ' + des_centro.Caption);
    IBMProPrinter.WriteLn('  PRODUCTO          = ' + producto.Text + ' ' + des_producto.Caption);
    IBMProPrinter.WriteLn('  SEMANA            = ' + sLunes + ' - ' + sDomingo);

    for i := 0 to memo.Lines.Count - 1 do
    begin
      IBMProPrinter.WriteLn(Memo.Lines[i]);
    end;
    IBMProPrinter.EndDoc;
  finally
    Freeandnil(IBMProPrinter);
  end;
}
end;

procedure TFAprovechaAjuste.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFAprovechaAjuste.fecha_desdeChange(Sender: TObject);
var
  dFecha: TDatetime;
begin
  if TryStrToDate( fecha_desde.Text, dFecha ) then
  begin
    fechaHasta.Text:= DateToStr( dFecha + 6 )
  end
  else
  begin
    fechaHasta.Text:= '';
  end;
end;

end.



