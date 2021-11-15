unit LIntrastat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils, CGlobal;

type
  TFLIntrastat = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    RGComunitario: TRadioGroup;
    Label1: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    Desde: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label14: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    cbbEmpresa: TComboBox;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function CamposVacios: boolean;
    procedure cbbEmpresaChange(Sender: TObject);

  private
    //Guardo el texto de la query original que es la agrupada
    rango: boolean;

    procedure Periodo;

  public
    { Public declarations }
    producto, factura, mes, anyo: string;
  end;

var
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview,
  CAuxiliarDB, UDMBaseDatos, bTimeUtils, QLIntrastat;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFLIntrastat.BBAceptarClick(Sender: TObject);
//var
//  i: cardinal;
begin
  if not CerrarForm(true) then
    Exit;
  Self.ActiveControl := nil;
  if not Rango then
    Exit;

     //Self.ActiveControl:=Nil;

  periodo;

  if cbbEmpresa.ItemIndex = 1 then
  begin
    if STEmpresa.Caption = '' then
    begin
      ShowMessage('Falta el código de la empresa o es incorrecto.');
      Exit;
    end;
  end;

     //Comunitario o no comunitario
     //Esto eleccion conlleva un cambio en la forma de realizar la consulta
     //Si es es comunitario se agrupa por centro de salida y pais
     //si no es comunitario se agrupa sólo por pais
  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    SQL.Add(' SELECT empresa_sl empresa, ');
    case RGComunitario.ItemIndex of
      0: SQL.add(' centro_salida_sl centro,');
      else SQL.add(' ''1'' centro,');
    end;
//    SQL.add(' ( select nombre_a from frf_agrupacion where producto_a = producto_sl) descripcion,');
    SQL.add(' CASE WHEN ( select nombre_a from frf_agrupacion where producto_a = producto_sl) <> '''' THEN      ');
    SQL.add(' 	( select nombre_a from frf_agrupacion where producto_a = producto_sl)                           ');
    SQL.add('       ELSE                                                                                        ');
    SQL.add(' 	 ( select descripcion_p from frf_productos where producto_p = producto_sl)                      ');
    SQL.add('       END descripcion,                                                                            ');
    SQL.add(' ( select descripcion_p from frf_paises where pais_p = pais_c ) pais,  ');                       
    SQL.Add(' cliente_sl cliente, ');
    SQL.Add(' representante_c representante, ');
    SQL.Add(' fecha_sl fecha, ');
    SQL.Add(' n_albaran_sl referencia, ');
    SQL.Add(' producto_sl producto, ');
    SQL.Add(' SUM( cajas_sl) cajas, ');
    SQL.add(' SUM( kilos_sl ) kilos, ');
    SQL.Add(' SUM( n_palets_sl ) palets, ');
    SQL.add(' SUM( importe_neto_sl ) neto ');

//    SQL.Add(' SUM(  Round( NVL(importe_neto_sl,0)*                                                                 ');
//    SQL.Add('            (1-(GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 2 )/100)), 1) ) neto       ');

    SQL.add(' FROM Frf_salidas_c, Frf_salidas_l, Frf_clientes ');

    if cbbEmpresa.ItemIndex = 0 then
      SQL.add(' WHERE  ((empresa_sc = ''050'') or (empresa_sc = ''080'')) ')
    else if cbbEmpresa.ItemIndex = 1 then
      SQL.add(' WHERE  ((empresa_sc = ''F17'') or (empresa_sc = ''F18'') or (empresa_sc = ''F23'') or (empresa_sc = ''F42'')) ')
    else
      SQL.add(' WHERE  (empresa_sc = :empresa) ');

    SQL.add(' AND (fecha_sc BETWEEN :fechaini AND :fechafin) ');

    SQL.add(' and  (empresa_sl = empresa_sc) ');
    SQL.add(' AND (centro_salida_sl = centro_salida_sc ) ');
    SQL.add(' AND (fecha_sl = fecha_sc ) ');
    SQL.add(' AND (n_albaran_sl = n_albaran_sc ) ');

    (*TODO*)(*20070304*)
    SQL.add(' --SALIDAS PENINSULARES ');
    SQL.add(' AND centro_salida_sl <> ''6'' ');
    SQL.add(' --SALIDAS DIRECTAS ');
    SQL.add(' AND ( nvl(es_transito_sc,0) =  0 ) ');

      //NO QUIERO LAS LINEAS QUE VENGAN DE UN TRANSITO AL EXTANJERO
    SQL.add('  and not ( nvl(es_transito_sc,0) = 1 and (select pais_c from frf_clientes where cliente_sal_sc = cliente_c) <> ''ES'' ) ');

    SQL.add('  AND NOT EXISTS ');
    SQL.add('       (SELECT * FROM FRF_TRANSITOS_L  ');
    SQL.add('        WHERE EMPRESA_TL = empresa_sc   ');
    SQL.add('         AND CENTRO_ORIGEN_TL = CENTRO_ORIGEN_SL  ');
    SQL.add('         AND REFERENCIA_TL = REF_TRANSITOS_SL  ');
    SQL.add('         AND FECHA_TL between :fechatranini and :fechatranfin  ');
    SQL.add('         AND ( CENTRO_DESTINO_TL IN  ');
    SQL.add('               ( select centro_c from frf_centros where nvl(pais_c,''ES'') <> ''ES'' ) ) ) ');

    (*
    SQL.add(' --SALIDAS QUE NO PROVENGAN DE UN TRANSITO DE ALICANTE ');
    SQL.add('       ( not exists ( select * from frf_transitos_l ');
    SQL.add('                      where empresa_tl = empresa_sc ');
    SQL.add('                        and centro_tl = ''1'' ');
    SQL.add('                        and referencia_tl = ref_transitos_sl ');
    SQL.add('                        and fecha_tl between :fechatranini and :fechatranfin ');
    SQL.add('                        and centro_origen_tl = centro_origen_sl ) ');
    SQL.add('       ) ');
    SQL.add('     ) ');
    *)

    SQL.add(' AND (cliente_c = cliente_sl) ');
    SQL.add(' AND (es_comunitario_c = :escomunitario) ');
    SQL.add(' AND (pais_c <> ''ES'') ');

    if RGComunitario.ItemIndex = 0 then
    begin
      SQL.add(' GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9 ');
      SQL.add(' ');
      SQL.add(' UNION ');
      SQL.add(' ');
      SQL.add(' SELECT  ');
      SQL.add(' empresa_tl empresa, ''1'' centro, ');

      SQL.add(' (select case when estomate_p = ''S'' then ''TOMATES FRESCOS'' ');
      SQL.add(' else descripcion_p end ');
      SQL.add(' from frf_productos ');
      SQL.add(' where producto_p = producto_tl ');
      SQL.add(' ) descripcion, ');

      (*#HACER#20040718*)
      (*Pais del centro de suministro*)
      SQL.add(' ( select descripcion_p from frf_paises where pais_p = ');
      SQL.add('     ( select pais_c from frf_centros ');
      SQL.add('       where empresa_c = empresa_tl and centro_c = centro_destino_tl ) ) pais, ');
      SQL.Add(' centro_destino_tl cliente,  ');
      SQL.Add(' '''' reprensentante, ');
      SQL.Add(' fecha_tl fecha, ');
      SQL.Add(' referencia_tl referencia, ');
      SQL.Add(' producto_tl producto, ');

      SQL.add(' SUM( cajas_tl ) kilos, ');
      SQL.add(' SUM( kilos_tl ) kilos, ');
      SQL.add(' SUM( palets_tl ) kilos, ');
      SQL.Add(' 0 neto                 ');


      SQL.add(' FROM Frf_transitos_l ');
      SQL.add(' --TRANSITOS DE ALICANTE ');
      if cbbEmpresa.ItemIndex = 0 then
        SQL.add(' WHERE  ((empresa_tl = ''050'') or (empresa_tl = ''080'')) ')
      else if cbbEmpresa.ItemIndex = 1 then
        SQL.add(' WHERE  ((empresa_tl = ''F17'') or (empresa_tl = ''F18'') or (empresa_tl = ''F23'') or (empresa_tl = ''F42'')) ')
      else
        SQL.add(' WHERE  (empresa_tl = :empresa) ');

      SQL.add(' AND (fecha_tl BETWEEN :fechaini AND :fechafin) ');
      SQL.add(' and centro_tl = ''1'' ');
      (*#HACER#20040718*)
      (*Que el pais no sea españa*)
      SQL.add(' and ( select pais_c from frf_centros ');
      SQL.add('       where empresa_c = empresa_tl and centro_c = centro_destino_tl ) <> ''ES'' ');
    end;

    SQL.add(' GROUP BY 1, 2, 3, 4, 5 , 6, 7, 8, 9 ');
    SQL.add(' ORDER BY 1, 2, 3, 4, 5, 6, 7, 8 DESC, 9 ');
  end;

  //i:= GetTickCount;

  with DMBaseDatos.QListado do
  begin
    if cbbEmpresa.ItemIndex = 2 then
      ParamByName('empresa').AsString := EEmpresa.Text;
    case RGComunitario.ItemIndex of
      0: ParamByName('escomunitario').AsString := 'S';
      else ParamByName('escomunitario').AsString := 'N';
    end;
    ParamByName('fechaini').AsDate := StrToDate(MEDesde.Text);
    ParamByName('fechafin').AsDate := StrToDate(MEHasta.Text);
    ParamByName('fechatranini').AsDate := StrToDate(MEDesde.Text) - 60;
    ParamByName('fechatranfin').AsDate := StrToDate(MEHasta.Text) + 30;
    try
                                                          Open;
    except
      on E: Exception do
      begin
        ShowError('No se pueden abrir las tablas necesarias para elaborar el informe.');
        Exit;
      end;
    end;
  end;

  //ShowMessage( IntToStr( GetTickCount - i ) );

     //Comprobar que no este vacia la tabla
  if DMBaseDatos.QListado.IsEmpty then
  begin
    ShowError('No se han encontrado datos para los valores introducidos.');
//    EEmpresa.SetFocus; 
    Exit;
  end;

     //Llamamos al QReport
  QRLIntrastat := TQRLIntrastat.Create(Application);
  with QRLIntrastat do
  begin
    sMes := mes;
    sAnyo := anyo;
    bComunitario := (RGComunitario.ItemIndex = 0);
  end;
  Preview(QRLIntrastat);
  DMBaseDatos.QListado.Close;
end;

procedure TFLIntrastat.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLIntrastat.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  MEDesde.Text := DateTostr( PrimerDiaMes( IncMonth( Date, -1 ) ) );
  MEHasta.Text := DateTostr( UltimoDiaMes( IncMonth( Date, -1 ) ) );
  if gProgramVersion = pvSAT then
  begin
    EEmpresa.Text:= '050';
    cbbempresa.ItemIndex := 0;
  end
  else
  begin
    EEmpresa.Text:= 'F17';
    cbbempresa.ItemIndex := 1;
  end;
  CalendarioFlotante.Date := Date;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

     //La consulta esta hecha para que se agrupe por centro y pais si se elige
     //los clientes comunitarios, si no sólo se agrupa por pais
  rango := True;
end;

procedure TFLIntrastat.FormActivate(Sender: TObject);
begin
  ActiveControl := MEDesde;
end;

procedure TFLIntrastat.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLIntrastat.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  Action := caFree;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLIntrastat.MEHastaExit(Sender: TObject);
begin
  if CalendarioFlotante.Visible then Exit;
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
    Rango := False;
    Exit;
  end
  else
    Rango := True;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLIntrastat.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLIntrastat.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
  end;
end;

function TFLIntrastat.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if MEDesde.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    MEDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if MEHasta.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    MEHasta.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;

procedure TFLIntrastat.Periodo;
var d, m, a: word;
begin
  DecodeDate(StrToDate(MEDesde.Text), a, m, d);
  mes:= desMes( m );
  anyo := IntToStr(a);
end;

procedure TFLIntrastat.cbbEmpresaChange(Sender: TObject);
begin
  EEmpresa.Enabled:= cbbEmpresa.ItemIndex <> 0;
  BGBEmpresa.Enabled:= EEmpresa.Enabled;
  STEmpresa.Enabled:= EEmpresa.Enabled;
end;

end.
