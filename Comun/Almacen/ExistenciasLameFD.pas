unit ExistenciasLameFD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton,
  DBTables, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlueprint, dxSkinFoggy,
  dxSkinMoneyTwins, cxCheckBox, dxSkinBlue;

type
  TFDExistenciasLame = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    LEmpresa: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    stCentro: TStaticText;
    ELame: TBEdit;
    LProducto: TLabel;
    Label3: TLabel;
    ECentro: TBEdit;
    Label1: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    btnCentro: TBGridButton;
    lblCliente: TLabel;
    EReferencia: TBEdit;
    cxExistencias: TcxCheckBox;
    Label4: TLabel;
    EDua: TBEdit;
    Label5: TLabel;
    Eproducto: TBEdit;
    BGBProducto: TBGridButton;
    stProducto: TStaticText;
    Label8: TLabel;
    eAgrupacion: TBEdit;
    BGBAgrupacion: TBGridButton;
    STAgrupacion: TStaticText;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure EEmpresaChange(Sender: TObject);
    procedure ECentroChange(Sender: TObject);
    procedure EproductoChange(Sender: TObject);
    procedure eAgrupacionChange(Sender: TObject);

  private
    { Private declarations }
    function ValidarParametros: Boolean;
    procedure ObtenerDatos;
    procedure PrevisualizarInforme;
  public
    { Public declarations }
    sEmpresa, sCentro, sAgrupacion, sProducto, sReferencia, sLame, sDua: string;
    dIni, dFin: TDateTime;
  end;

implementation

uses  ExistenciasLameQR, DPreview, UDMAuxDB, Principal, UDMBaseDatos, CGlobal, CReportes, CVariables, bTimeUtils,
      CAuxiliarDB;


{$R *.DFM}

procedure TFDExistenciasLame.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFDExistenciasLame.eAgrupacionChange(Sender: TObject);
begin
  if Trim( eAgrupacion.Text ) = '' then
    STAgrupacion.Caption := 'TODAS LAS AGRUPACIONES'
  else
    STAgrupacion.Caption := desAgrupacion(eAgrupacion.Text);
end;

function TFDExistenciasLame.ValidarParametros: Boolean;
begin
  Result:= False;

  //Comprobar parametros de entrada
  if STEmpresa.Caption = '' then
  begin
    MessageDlg('Falta o código de empresa incorrecto', mtError, [mbOk], 0);
    EEmpresa.SetFocus;
    Exit;
  end;

  if stCentro.Caption = '' then
  begin
    MessageDlg('Código de centro incorrecto', mtError, [mbOk], 0);
    ECentro.SetFocus;
    Exit;
  end;

  if Trim( STAgrupacion.Caption ) = '' then
  begin
    MessageDlg('El código de agrupación es incorrecto', mtError, [mbOk], 0);
    EAgrupacion.SetFocus;
    Exit;
  end;

  if STProducto.Caption = '' then
  begin
    MessageDlg('Código de producto incorrecto.', mtError, [mbOk], 0);
    EProducto.SetFocus;
    Exit;
  end;

  if not TryStrToDate( MEDesde.Text, dIni ) then
  begin
    MessageDlg('Fecha de inicio incorrecta ...', mtError, [mbOk], 0);
    MEDesde.SetFocus;
    Exit;
  end;
  if not TryStrToDate( MEHasta.Text, dFin ) then
  begin
    MessageDlg('Fecha de fin incorrecta ...', mtError, [mbOk], 0);
    MEHasta.SetFocus;
    Exit;
  end;
  if dIni > dFin then
  begin
    MessageDlg('Rango de fechas incorrecto ...', mtError, [mbOk], 0);
    MEDesde.SetFocus;
    Exit;
  end;

  sempresa:= EEmpresa.Text;
  scentro:= ECentro.Text;
  sagrupacion:=eAgrupacion.Text;
  sproducto:= EProducto.Text;
  sReferencia:= EReferencia.Text;
  sLame:= ELame.Text;
  sDua:= EDua.Text;

  result:= True;
end;

procedure TFDExistenciasLame.PrevisualizarInforme;
var
  QRExistenciasLame: TQRExistenciasLame;
begin
  QRExistenciasLame:= TQRExistenciasLame.Create( Application );
  try
    QRExistenciasLame.qrlblPeriodo.Caption:= 'Del ' + MEDesde.Text + ' al ' + MEHasta.Text;
    PonLogoGrupoBonnysa( QRExistenciasLame );
    Preview( QRExistenciasLame );
  except
    FreeAndNil( QRExistenciasLame );
  end;
end;

procedure TFDExistenciasLame.ObtenerDatos;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_dac, centro_dac, referencia_dac, fecha_dac, cont_lame_dac, dua_exporta_dac,                          ');
    SQL.Add('        case when producto_sl is not null then producto_sl else producto_tl end producto,                            ');
    SQL.Add('        sum(case when cajas_sl is not null then cajas_sl else cajas_tl end) cajas,                                   ');
    SQL.Add('        sum(case when kilos_sl is not null then kilos_sl else kilos_tl end) kilos                                    ');
    SQL.Add(' from frf_depositos_aduana_c                                                                                         ');
    SQL.Add(' left join frf_salidas_l on empresa_sl = empresa_dac and centro_salida_sl = centro_dac                               ');
    SQL.Add('                        and n_albaran_sl = referencia_dac and fecha_sl = fecha_dac                                   ');
    SQL.Add(' left join frf_transitos_l on empresa_tl = empresa_dac and centro_tl = centro_dac                                    ');
    SQL.Add('                          and referencia_tl = referencia_dac and fecha_tl = fecha_dac                                ');
    SQL.Add(' where cont_lame_dac > 1           ');  // Contador LAME nº = 1 error, es una incidencia
    SQL.Add('   and fecha_dac between :fechaini and  :fechafin ');
    SQL.Add('   and centro_dac = :centro ');


    if ( sEmpresa = 'SAT' ) then
      SQL.Add(' and (empresa_dac = ''050'' or empresa_dac = ''080'' ) ')
    else if ( sEmpresa = 'BAG' ) then
      SQL.Add(' and empresa_dac[1,1] = ''F''  ')
    else
      SQL.Add(' and empresa_dac = :empresa ');

    if Trim( sAgrupacion ) <> '' then
    begin
      SQL.Add(' and ( producto_sl in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) or                      ');
      SQL.Add('       producto_tl in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) )                       ');
    end;

    if sProducto <> '' then
      SQL.Add(' and (producto_sl = :producto or producto_tl = :producto) ');
    

    if sReferencia <> '' then
      SQL.Add(' and referencia_dac = :referencia ');

    if sLame <> '' then
      SQL.Add(' and cont_lame_dac = :lame ');

    if sDua <> '' then
      SQL.Add(' and dua_exporta_dac = :dua ');

    if cxExistencias.Checked then
      SQL.Add(' and dua_exporta_dac is null ');

    SQL.Add(' group by 1,2,3,4,5,6,7          ');
    SQL.Add(' order by 1,2,5,6,7          ');

    if ( sEmpresa <> 'BAG' ) and  ( sEmpresa <> 'SAT' ) then
      ParamByName('empresa').AsString:= sEmpresa;

    ParamByName('centro').AsString:= sCentro;
    ParamByName('fechaini').AsDateTime:= dIni;
    ParamByName('fechafin').AsDateTime:= dFin;
    if sAgrupacion <> '' then
      ParamByName('agrupacion').AsString:= sAgrupacion;
    if sProducto <> '' then
      ParamByName('producto').AsString:= sProducto;
    if sReferencia <> '' then
      ParamByName('referencia').AsString:= sReferencia;
    if sLame <> '' then
      ParamByName('lame').AsString := sLame;
    if sDua <> '' then
      ParamByName('dua').AsString := sDua;

    Open;
    try
      if IsEmpty then
      begin
        ShowMessage('Sin datos para los parametros seleccionados.');
      end
      else
      begin
        PrevisualizarInforme;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TFDExistenciasLame.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if ValidarParametros then
    ObtenerDatos;
end;

procedure TFDExistenciasLame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFDExistenciasLame.FormCreate(Sender: TObject);
var
  dFecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  EProducto.Tag := kProducto;
  EAgrupacion.Tag := kAgrupacion;
  ECentro.Tag := kCentro;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

  EProducto.Text := '';
  EReferencia.Text:= '';
  ELame.Text := '';
  EDua.Text := '';

  dFecha:= LunesAnterior( Date ) - 7;
  MEDesde.Text:= DateToStr( dFEcha );
  MEHasta.Text:= DateToStr( dFEcha + 6 );

  if CGlobal.gProgramVersion = CGlobal.pvBAG then
  begin
    EEmpresa.Text := 'F17';
    ECentro.Text := '1';  //gsDefCentro;
  end
  else
  begin
    EEmpresa.Text := '050';
    ECentro.Text := '6';  //gsDefCentro;
  end;

  eAgrupacionChange(eagrupacion);
  EProductoChange( EProducto );

end;

procedure TFDExistenciasLame.FormKeyDown(Sender: TObject; var Key: Word;
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
  end;
end;

procedure TFDExistenciasLame.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kAgrupacion: DespliegaRejilla(BGBAgrupacion);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFDExistenciasLame.EEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  ECentroChange( ECentro );
end;

procedure TFDExistenciasLame.EproductoChange(Sender: TObject);
begin
  if EProducto.Text <> '' then
    stProducto.Caption := desProducto( Eempresa.Text, EProducto.Text )
  else
    stProducto.Caption := 'TODOS LOS PRODUCTOS';
end;

procedure TFDExistenciasLame.ECentroChange(Sender: TObject);
begin
 stCentro.Caption := desCentro( Eempresa.Text, ECentro.Text )
end;

end.
