unit LProductividadPlantaciones;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ActnList, ComCtrls, Db,
  CGestionPrincipal, BEdit, BCalendarButton, BSpeedButton, BGridButton,
  BCalendario, BGrid, DError, QuickRpt, Grids, DBGrids, DBTables;

type
  TFLProductividadPlantaciones = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GBEmpresa: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    BGBEmpresa: TBGridButton;
    BGBProducto: TBGridButton;
    EProducto: TBEdit;
    EEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STProducto: TStaticText;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    ACancelar: TAction;
    Label3: TLabel;
    EProvincia: TBEdit;
    BGBProvincia: TBGridButton;
    STProvincia: TStaticText;
    Desde: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    MEHasta: TBEdit;
    Label14: TLabel;
    BCBHasta: TBCalendarButton;
    Label4: TLabel;
    Query: TQuery;
    Label5: TLabel;
    eAnoSemana: TBEdit;
    Label6: TLabel;
    cbxComprimir: TCheckBox;
    Query2: TQuery;
    Label7: TLabel;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);

  private
    { Public declarations }
    desgloseCosecheros: boolean;
    fechaDesde, fechaHasta: TDate;

    function ValidarParametros: Boolean;
    procedure SeleccionarDatos;
    procedure GenerarListado;
{    procedure SectoresPunto;}
  end;

var
  Autorizado: boolean;

implementation

uses Principal, CVariables, CAuxiliarDB, UDMAuxDB, DPreview, CReportes,
  UDMBaseDatos, LProductividadPlantacionesQR, bTimeUtils;

{$R *.DFM}

(*SACAR POR SEMANAS, ROBERTO 12/13/2004*)
(*
procedure TFLProductividadPlantaciones.BBAceptarClick(Sender: TObject);
var
  dini, dfin: TDateTime;
  listado: TQLProductividadPlantacionesQR;
  ini,fin: string;
begin
  if not CerrarForm(true) then Exit;

  ini:= MEDesde.Text;
  dini:= StrToDate( ini );
  fin:= MEHasta.Text;
  dfin:= StrToDate( fin );

  while dini < dfin do
  begin
    fechaDesde:= dini;
    MEDesde.Text:= DateToStr( fechaDesde );
    fechaHasta:= dini + 6;
    MEHasta.Text:= DateToStr( fechaHasta );
    dini:= dini + 7;

    SeleccionarDatos;
    if not Query.IsEmpty then
    begin
      listado:= TQLProductividadPlantacionesQR.Create(Self);
      try
        listado.lblPeriodoProd.Caption:= 'Periodo desde el '+
                                 FormatDateTime('dd/mm/yy',fechaDesde)+' al '+
                                 FormatDateTime('dd/mm/yy',fechaHasta);
        listado.lblProducto.Caption:= EProducto.Text + ' - ' + stProducto.Caption;
        listado.lblSemana.Caption:= 'Semana Nº: ' + IntToStr(Semana(fechaDesde));

        listado.compressReport:= cbxComprimir.Checked;
        PonLogoGrupoBonnysa(Listado,EEmpresa.Text);
        listado.Print;
      finally
        listado.Free;
      end;
    end;
    Query.Close;
  end;

  MEDesde.Text:= ini;
  MEHasta.Text:= fin;
end;
*)

procedure TFLProductividadPlantaciones.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;
  if ValidarParametros then
  begin
    SeleccionarDatos;
    if not Query.IsEmpty then
    begin
      GenerarListado;
    end
    else
    begin
      ShowMessage('No existen datos grabados para los parametros indicados.');
    end;
    Query.Close;
  end;
end;

procedure TFLProductividadPlantaciones.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;

  if Query.Active then Query.Close;
  if Query2.Active then Query2.Close;

  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  Action := caFree;
end;

procedure TFLProductividadPlantaciones.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.text:= gsDefEmpresa;
  EProducto.text:= gsDefProducto;
  MEDesde.Text := DateTostr(Date);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  EProducto.Tag := kProducto;
  EProvincia.Tag := kProvincia;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  desgloseCosecheros := false;
end;

procedure TFLProductividadPlantaciones.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLProductividadPlantaciones.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kProvincia: DespliegaRejilla(BGBProvincia);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLProductividadPlantaciones.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
    kProducto: STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
    kProvincia: STProvincia.Caption := desProvincia(EProvincia.Text);
  end;
end;

procedure TFLProductividadPlantaciones.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := EEmpresa;
end;

procedure TFLProductividadPlantaciones.ACancelarExecute(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFLProductividadPlantaciones.ValidarParametros: Boolean;
var
  msgError: string;
  focusFisrtError: TWinControl;
  numErrors: Integer;
begin
  msgError := '';
  focusFisrtError := nil;
  numErrors := 0;

  //Comprobamos que los campos esten todos con datos
  if Trim(EEmpresa.Text) = '' then
  begin
    focusFisrtError := EEmpresa;
    msgError := 'El código de la empresa es de obligada insercion.';
    Inc(numErrors);
  end;

  if Trim(EProducto.Text) = '' then
  begin
    if focusFisrtError = nil then
      focusFisrtError := EProducto;
    if msgError <> '' then
      msgError := msgError + #13 + #10;
    msgError := msgError + 'El código del producto es de obligada insercion.';
    Inc(numErrors);
  end;

  try
    fechaDesde := StrToDate(MEDesde.Text);
  except
    fechaDesde := 0;
    if focusFisrtError = nil then
      focusFisrtError := MEDesde;
    if msgError <> '' then
      msgError := msgError + #13 + #10;
    msgError := msgError + 'Falta o es incorrecta la fecha de inicio.';
    Inc(numErrors);
  end;

  try
    fechaHasta := StrToDate(MEHasta.Text);
  except
    fechaHasta := 0;
    if focusFisrtError = nil then
      focusFisrtError := MEHasta;
    if msgError <> '' then
      msgError := msgError + #13 + #10;
    msgError := msgError + 'Falta o es incorrecta la fecha de fin.';
    Inc(numErrors);
  end;

  if (fechaDesde <> 0) and (fechaHasta <> 0) then
    if fechaDesde > fechaHasta then
    begin
      if focusFisrtError = nil then
        focusFisrtError := MEDesde;
      if msgError <> '' then
        msgError := msgError + #13 + #10;
      msgError := msgError + 'Rango de fechas incorrecto.';
      Inc(numErrors);
    end;

  if numErrors > 0 then
  begin
    if numErrors > 1 then
    begin
      msgError := 'Se han encontrado ' + IntToStr(numErrors) + ' errores:' +
        #13 + #10 + msgError;
    end;
    ShowError(msgError);
    ActiveControl := focusFisrtError;
  end;

  Result := numErrors = 0;
end;


procedure TFLProductividadPlantaciones.SeleccionarDatos;
begin
  //SACAR DATOS
  with Query do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add(' SELECT ');
    SQL.Add('        cod_postal_c[1,2] provincia, ano_semana_p, ');
    SQL.Add('        empresa_p, producto_p, cosechero_p, plantacion_p, ');
    SQL.Add('        descripcion_p, superficie_p, plantas_p, ');
    SQL.Add('        SUM(CASE WHEN fecha_e2l >= :fechaDesde ');
    SQL.Add('                 THEN total_kgs_e2l ');
    SQL.Add('                 ELSE 0 END) kilosPeriodo, ');
    SQL.Add('        SUM(total_kgs_e2l) kilosAcumulados ');

    SQL.Add(' FROM  frf_cosecheros, frf_plantaciones, frf_entradas2_l ');

    SQL.Add(' WHERE empresa_c = :empresa ');
    if Trim(EProvincia.Text) <> '' then
    begin
      SQL.Add('   and cod_postal_c[1, 2] = :provincia ');
    end;

    SQL.Add('   and empresa_p = :empresa ');
    SQL.Add('   AND producto_p = :producto ');
    SQL.Add('   and cosechero_p = cosechero_c ');
    if trim(eAnoSemana.Text) <> '' then
    begin
      SQL.Add('   and ano_semana_p >= :anoSemana ');
    end;
    SQL.Add('   and ( fecha_fin_p is null or fecha_fin_p >= :fechaDesde ) ');

    SQL.Add('   AND empresa_e2l = :empresa ');
    SQL.Add('   AND producto_e2l = :producto ');
    SQL.Add('   AND cosechero_e2l = cosechero_p ');
    SQL.Add('   AND plantacion_e2l = plantacion_p ');
    SQL.Add('   AND ano_sem_planta_e2l = ano_semana_p ');
    SQL.Add('   AND fecha_e2l <= :fechahasta ');
    SQL.Add('   AND ( sectores_e2l[1,1] <> ' + QuotedStr('.') +
      '                           OR sectores_e2l IS NULL) ');

    SQL.Add(' GROUP BY ');
    SQL.Add('          cod_postal_c,ano_semana_p, empresa_p, producto_p, ');
    SQL.Add('          cosechero_p, plantacion_p, descripcion_p, superficie_p, ');
    SQL.Add('          plantas_p ');


    {Añadir campos: fecha_inicio_p, fecha_fin_p. Roberto 23-04-2003}
    //SQl.Add('        ,fecha_inicio_p, fecha_fin_p');

    SQL.Add(' order by ');
    SQL.Add('          provincia, ano_semana_p, cosechero_p, plantacion_p ');


    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('producto').AsString := EProducto.Text;
    if Trim(EProvincia.Text) <> '' then
    begin
      ParamByName('provincia').AsString := Trim(EProvincia.Text);
    end;
    ParamByName('fechaDesde').AsDateTime := fechaDesde;
    ParamByName('fechaHasta').AsDateTime := fechaHasta;
    if trim(eAnoSemana.Text) <> '' then
    begin
      ParamByName('anoSemana').AsString := Trim(eAnoSemana.Text);
    end;

    Open;
  end;
end;

procedure TFLProductividadPlantaciones.GenerarListado;
var
  listado: TQLProductividadPlantacionesQR;
 // listado: TQLProductividadPlantacionesQR2;
begin
  listado := TQLProductividadPlantacionesQR.Create(Self);
  //listado:= TQLProductividadPlantacionesQR2.Create(Self);
  try
    listado.lblPeriodoProd.Caption := 'Periodo desde el ' +
      FormatDateTime('dd/mm/yy', fechaDesde) + ' al ' +
      FormatDateTime('dd/mm/yy', fechaHasta) + ' - ' +
      'Semana Nº: ' + IntToStr(Semana(fechaDesde));
    listado.lblProducto.Caption := EProducto.Text + ' - ' + stProducto.Caption;

    listado.compressReport := cbxComprimir.Checked;


    PonLogoGrupoBonnysa(Listado, EEmpresa.Text);
    Preview(listado);
  except
    listado.Free;
  end;
end;

end.
