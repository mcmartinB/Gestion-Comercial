unit LFSalidasEnvases2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt;

type
  TFLSalidasEnvases2 = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LProducto: TLabel;
    LCentro: TLabel;
    BGBProductoD: TBGridButton;
    BGBCentro: TBGridButton;
    STEmpresa: TStaticText;
    ADesplegarRejilla: TAction;
    EEmpresa: TBEdit;
    edtCentro: TBEdit;
    edtProducto: TBEdit;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    Label3: TLabel;
    GBPrincipal: TGroupBox;
    edtCliente: TBEdit;
    BGBClienteD: TBGridButton;
    RGMercado: TRadioGroup;
    ePais: TBEdit;
    btnPais: TBGridButton;
    cbxCliente: TCheckBox;
    Label1: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    chkPalet: TCheckBox;
    stProducto: TStaticText;
    stCentro: TStaticText;
    stCliente: TStaticText;
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
    procedure RGMercadoClick(Sender: TObject);
  private
      {private declarations}
    tab_cli, mercado, cli: string;
    function CamposVacios: boolean;
    function PrepararConsulta: boolean;

  public
    { Public declarations }
    empresa, centro, producto, sem: string;
  end;

implementation

uses CVariables, Principal, CAuxiliarDB, CReportes, bSQLUtils,
  LSalidasEnvases2, UDMAuxDB, DPreview, UDMBaseDatos, UDMConfig;

{$R *.DFM}

procedure TFLSalidasEnvases2.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  MEDesde.Text := DateToStr(Date);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  edtProducto.Tag := kProducto;
  edtCliente.Tag := kCliente;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  ePais.Tag := kPais;
  ePais.Text := 'GB';

  EEmpresa.Text := 'BAG';
  edtCentro.Text := '';
  edtProducto.Text := '';
  edtCliente.Text := '';
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  if not DMConfig.EsLaFont then
    RGMercado.ItemIndex:= 2;
end;

procedure TFLSalidasEnvases2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAuxQuerys;
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

procedure TFLSalidasEnvases2.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLSalidasEnvases2.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLSalidasEnvases2.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if CamposVacios then Exit;

  if edtCliente.Text = '' then
  begin
    cli := 'TODOS LOS CLIENTES';
  end
  else
  begin
    cli := desCliente(edtCliente.Text);
  end;

  case RGMercado.ItemIndex of
    0: begin
        tab_cli := ',frf_clientes ';
        mercado := ' AND cliente_c = cliente_sl AND pais_c = ' + QuotedStr('ES');
        cli := 'NACIONAL ' + cli;
      end;
    1: begin
        tab_cli := ',frf_clientes ';
        mercado := ' AND cliente_c = cliente_sl AND pais_c <> ' + QuotedStr('ES');
        cli := 'EXPORTACIÓN ' + cli;
      end;
    2: begin
        tab_cli := '';
        mercado := '';
        cli := 'CLIENTES ' + cli;
      end;
    3: begin
        tab_cli := ',frf_clientes ';
        mercado := ' AND cliente_c = cliente_sl ' +
          ' AND pais_c = ' + QuotedStr(ePais.Text);
        cli := desPais(ePais.Text) + cli;
      end;
  end;

  if not PrepararConsulta then
  begin
    DMBaseDatos.QListado.Close;
    ShowMessage('Sin datos para los parametros introducidos.');
    Exit;
  end;

  try
    QRLSalidasEnvases2 := TQRLSalidasEnvases2.Create(Application);
    PonLogoGrupoBonnysa(QRLSalidasEnvases2, eempresa.Text);

    QRLSalidasEnvases2.LCliente.Caption := cli;
    if edtCentro.Text <> '' then
    begin
      QRLSalidasEnvases2.LCentro.Caption := edtCentro.Text + '  ' +
        desCentro(EEmpresa.Text, edtCentro.Text);
    end
    else
    begin
      QRLSalidasEnvases2.LCentro.Caption := 'TODOS LOS CENTROS';
    end;
    QRLSalidasEnvases2.LPeriodo.Caption := MEDesde.Text + ' a ' + MEHasta.Text;
    QRLSalidasEnvases2.empresa := EEmpresa.Text;

    if cbxCliente.Checked then
    begin
      QRLSalidasEnvases2.lblCliente.Caption:= 'Producto/Cliente/Artículo';
    end
    else
    begin
      QRLSalidasEnvases2.lblCliente.Caption:= 'Producto/Artículo';
    end;

    if chkPalet.Checked then
    begin
      QRLSalidasEnvases2.lblPalet.Caption:= 'Tipo Palet';
    end
    else
    begin
      QRLSalidasEnvases2.lblPalet.Caption:= '';
    end;

    Preview(QRLsalidasEnvases2);
  finally
    DMBaseDatos.QListado.Close;
  end;

end;

function TFLSalidasEnvases2.CamposVacios: boolean;
begin
  Result := True;
  
        //Comprobar si los campos se han rellenado correctamente
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    EEmpresa.SetFocus;
    Exit;
  end;

  if stCentro.Caption = '' then
  begin
    ShowError('Falta o código del centro incorrecto.');
    edtCentro.SetFocus;
    Exit;
  end;

  if stCliente.Caption = '' then
  begin
    ShowError('Falta o código del cliente incorrecto.');
    edtCliente.SetFocus;
    Exit;
  end;

  if stProducto.Caption = '' then
  begin
    ShowError('Falta o código del producto incorrecto.');
    edtProducto.SetFocus;
    Exit;
  end;

  Result := False;
end;

function TFLSalidasEnvases2.PrepararConsulta: boolean;
var
  sProducto, sCliente, sPalet: string;
begin
  with DMBaseDatos.QListado do
  begin
    SQL.Clear;

    sProducto:=  'producto_sl, ';

    if cbxCliente.Checked then
    begin
      sCliente:=  'cliente_sal_sc, ';
    end
    else
    begin
      sCliente:=  ''''' cliente_sal_sc, ';
    end;

    if chkPalet.Checked then
    begin
      sPalet:=  'tipo_palets_sl, ';
    end
    else
    begin
      sPalet:=  ''''' tipo_palets_sl, ';
    end;

    SQL.Add(' SELECT empresa_sc, ');
    SQL.Add('       ' + sProducto );
    SQL.Add('       ' + sCliente );
    SQL.Add('        envase_sl, ');
    SQL.Add('       ' + sPalet );

    //SQL.Add(' SUM(kilos_sl) kilos, SUM(cajas_sl) cajas, SUM(importe_neto_sl) neto' +
    //Arreglo ECOEMBES 14/5/2014
    //SQL.Add(' SUM(kilos_sl) kilos, SUM(cajas_sl) cajas, SUM(euros(moneda_sc, fecha_sc, importe_neto_sl)) - 220500 neto,');
    SQL.Add(' SUM(kilos_sl) kilos, SUM(cajas_sl) cajas, SUM(euros(moneda_sc, fecha_sc, importe_neto_sl))  neto,');
    SQL.Add('         sum( unidades_caja_sl * cajas_sl ) unidades ');
    SQL.Add(' FROM frf_salidas_c, frf_salidas_l ' + tab_cli );

    SQL.Add('  where fecha_sc BETWEEN :desde AND :hasta ');
    if EEmpresa.Text <> 'BAG' then
      SQL.Add(' and empresa_sc = :empresa ' )
    else
      SQL.Add(' and substr(empresa_sc,1,1) = ''F'' ' );

    if edtCentro.Text <> '' then
      SQL.Add('  AND centro_salida_sc = :centro');

   SQL.Add(' AND empresa_sl = empresa_sc');
   SQL.Add(' AND centro_salida_sl = centro_salida_sc');
   SQL.Add(' AND fecha_sl = fecha_sc');
   SQL.Add(' AND n_albaran_sl = n_albaran_sc');

   if edtProducto.Text <> '' then
      SQL.Add(' AND producto_sl = :producto ');
   if edtCliente.Text <> '' then
    SQL.Add(' AND cliente_sal_sc = :cliente' );

   SQL.Add(' and es_transito_sc <> 2 ');          //Tipo Salida: Devolucion 

   SQL.Add(   mercado +
      ' GROUP BY  1, 2, 3, 4, 5' +
      ' ORDER BY 2, 3, 1, 4, 5 ' );


    ParamByName('desde').AsDateTime := StrToDate(MEDesde.Text);
    ParamByName('hasta').AsDateTime := StrToDate(MEHasta.Text);
    if EEmpresa.Text <> 'BAG' then
      ParamByName('empresa').AsString := EEmpresa.Text;
    if edtCentro.Text <> '' then
      ParamByName('centro').AsString := edtCentro.Text;
    if edtCliente.Text <> '' then
      ParamByName('cliente').AsString := edtCliente.Text;
    if edtProducto.Text <> '' then
      ParamByName('producto').AsString := edtProducto.Text;
    try
      Open;
      Result := not IsEmpty;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        Result := False;
        Exit;
      end;
    end;
  end;
end;

procedure TFLSalidasEnvases2.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

procedure TFLSalidasEnvases2.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kPais: DespliegaRejilla(btnPais, []);
    kCentro: DespliegaRejilla(BGBCentro, [EEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProductoD, [EEmpresa.Text]);
    kCliente:
        DespliegaRejilla(BGBClienteD, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLSalidasEnvases2.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
    begin
      STEmpresa.Caption := desEmpresa(Eempresa.Text);
      PonNombre( edtCentro );
      PonNombre( edtCliente );
      PonNombre( edtProducto );
    end;
    kProducto:
    begin
      if edtProducto.Text = '' then
        stProducto.Caption := 'TODOS LOS PRODUCTOS'
      else
        stProducto.Caption := desProducto(Eempresa.Text, edtProducto.Text);
    end;
   kCentro:
    begin
      if edtCentro.Text <> '' then
      begin
        stCentro.Caption := desCentro(Eempresa.Text, edtCentro.Text);
      end
      else
      begin
        stCentro.Caption := 'TODOS LOS CENTROS';
      end;
    end;
   kCliente:
    begin
      if edtCliente.Text <> '' then
      begin
        stCliente.Caption := desCliente(edtCliente.Text);
      end
      else
      begin
        stCliente.Caption := 'TODOS LOS CLIENTES';
      end;
    end;
  end;
end;

procedure TFLSalidasEnvases2.FormActivate(Sender: TObject);
begin
  Self.top := 1;
end;

procedure TFLSalidasEnvases2.RGMercadoClick(Sender: TObject);
begin
  ePais.Enabled := RGMercado.ItemIndex = 3;
  btnPais.Enabled := ePais.Enabled;
end;

end.
