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
    ECentroSalida: TBEdit;
    EProductoD: TBEdit;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    Label3: TLabel;
    GBPrincipal: TGroupBox;
    EProductoH: TBEdit;
    BGBProductoH: TBGridButton;
    EClienteD: TBEdit;
    EClienteH: TBEdit;
    Label4: TLabel;
    Label6: TLabel;
    BGBClienteD: TBGridButton;
    BGBClienteH: TBGridButton;
    Bevel1: TBevel;
    RGMercado: TRadioGroup;
    cbxTomate: TCheckBox;
    ePais: TBEdit;
    btnPais: TBGridButton;
    Label5: TLabel;
    ECentroOrigen: TBEdit;
    BGridButton1: TBGridButton;
    cbxCliente: TCheckBox;
    Label1: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    chkPalet: TCheckBox;
    stCentroSalida: TStaticText;
    stCentroOrigen: TStaticText;
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
    procedure ECentroOrigenChange(Sender: TObject);
    procedure ECentroSalidaChange(Sender: TObject);
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
  ECentroSalida.Tag := kCentro;
  ECentroOrigen.Tag := kCentro;
  EProductoD.Tag := kProducto;
  EProductoH.Tag := kProducto;
  EClienteD.Tag := kCliente;
  EClienteH.Tag := kCliente;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  ePais.Tag := kPais;
  ePais.Text := 'GB';

  ECentroSalida.Text := '';
  ECentroOrigen.Text := '';
  EEmpresa.Text := gsDefEmpresa;
  PonNombre( EEmpresa );
  EProductoD.Text := '0';
  EProductoH.Text := 'Z';
  EClienteD.Text := '000';
  EClienteH.Text := 'ZZZ';
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  if not DMConfig.EsLaFont then
    RGMercado.ItemIndex:= 2;
  cbxTomate.Visible:= True;
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

  if EClienteD.Text = EClienteH.Text then
  begin
    cli := ' - ' + desCliente(EClienteD.Text);
  end
  else
  begin
    cli := ' de ' + EClienteD.Text + ' a ' + EClienteH.Text;
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

    if ECentroSalida.Text = '' then
    begin
      QRLSalidasEnvases2.qrlCentroSalida.Caption := 'SALIDA: TODOS LOS CENTROS';
    end
    else
    begin
      QRLSalidasEnvases2.qrlCentroSalida.Caption := 'SALIDA: ' + ECentroSalida.Text + '  ' +
                                             desCentro(EEmpresa.Text, ECentroSalida.Text);
    end;
    if ECentroOrigen.Text = '' then
    begin
      QRLSalidasEnvases2.qrlCentroOrigen.Caption := 'ORIGEN: TODOS LOS CENTROS';
    end
    else
    begin
      QRLSalidasEnvases2.qrlCentroOrigen.Caption := 'ORIGEN: ' + ECentroOrigen.Text + '  ' +
                                             desCentro(EEmpresa.Text, ECentroOrigen.Text);
    end;

    QRLSalidasEnvases2.LPeriodo.Caption := MEDesde.Text + ' a ' + MEHasta.Text;
    QRLSalidasEnvases2.empresa := EEmpresa.Text;

    (*
    if cbxTomate.Checked then
    begin
      sProducto:=  'case when producto_sl = "E" then "T" else producto_sl end producto_sl, ';
    end
    else
    begin
      sProducto:=  'producto_sl, ';
    end;
    *)

    if cbxCliente.Checked then
    begin
      QRLSalidasEnvases2.lblCliente.Caption:= 'Producto/Cliente/Envase';
    end
    else
    begin
      QRLSalidasEnvases2.lblCliente.Caption:= 'Producto/Envase';
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
        //Comprobar si los campos se han rellenado correctamente
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene el codigo de la empresa.');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if EProductoD.Text = '' then
  begin
    ShowError('Es necesario que rellene el código del producto.');
    EProductoD.SetFocus;
    Result := True;
    Exit;
  end;
  if EProductoH.Text = '' then EProductoH.Text := EProductoD.Text;

  if EClienteD.Text = '' then
  begin
    ShowError('Es necesario que rellene el código del cliente.');
    EClienteD.SetFocus;
    Result := True;
    Exit;
  end;
  if EClienteH.Text = '' then EClienteH.Text := EClienteD.Text;

  if stCentroSalida.Caption = '' then
  begin
    ShowError('El código del centro de salida es incorrecto.');
    ECentroSalida.SetFocus;
    Result := True;
    Exit;
  end;
  if stCentroOrigen.Caption = '' then
  begin
    ShowError('El código del centro de origen es incorrecto.');
    ECentroOrigen.SetFocus;
    Result := True;
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

    if cbxTomate.Checked then
    begin
      sProducto:=  'case when producto_sl = "E" then "T" else producto_sl end producto_sl, ';
    end
    else
    begin
      sProducto:=  'producto_sl, ';
    end;

    if cbxCliente.Checked then
    begin
      sCliente:=  'cliente_sl, ';
    end
    else
    begin
      sCliente:=  ''''' cliente_sl, ';
    end;

    if chkPalet.Checked then
    begin
      sPalet:=  'tipo_palets_sl, ';
    end
    else
    begin
      sPalet:=  ''''' tipo_palets_sl, ';
    end;

    SQL.Add(' SELECT empresa_sl, ');
    SQL.Add('       ' + sProducto );
    SQL.Add('       ' + sCliente );
    SQL.Add('        envase_sl, ');
    SQL.Add('       ' + sPalet );

    SQL.Add(' SUM(kilos_sl) kilos, SUM(cajas_sl) cajas, SUM(euros(moneda_sc, fecha_sc, importe_neto_sl)) neto' +
      ' FROM frf_salidas_c, frf_salidas_l ' + tab_cli +
      ' WHERE empresa_sc = :empresa ');
    if ECentroSalida.Text <> '' then
      SQL.Add(' AND centro_salida_sc = :centroSalida ');
    if ECentroOrigen.Text <> '' then
      SQL.Add(' AND centro_origen_sl = :centroOrigen ');

    SQL.Add(' and empresa_sc = empresa_sl ');
    SQL.Add(' and centro_salida_sc = centro_salida_sl ');
    SQL.Add(' and fecha_sc = fecha_sl ');
    SQL.Add(' and n_albaran_sc = n_albaran_sl ');
{
    if (((EProductoD.Text <= 'E') and ('E' <= EProductoH.Text)) or
      ((EProductoD.Text <= 'T') and ('T' <= EProductoH.Text))) and
      cbxTomate.Checked then
    begin
      SQL.Add(' AND ( producto_sl BETWEEN :producto AND :producto_h');
      SQL.Add(' OR ( producto_sl in ( ' +
        QUOTEDSTR('T') + ',' +
        QUOTEDSTR('E') + ' ) ) )');
    end
    else
    begin
}
      SQL.Add(' AND producto_sl BETWEEN :producto AND :producto_h');
//    end;
    SQL.Add(' AND cliente_sal_sc BETWEEN :cliente_d AND :cliente_h' +
      ' AND fecha_sc BETWEEN :desde AND :hasta ' +
      mercado +
      '  and es_transito_sc <> 2 ' +                  // Tipo Salida: Devolucion

      ' GROUP BY  1, 2, 3, 4, 5' +
      ' ORDER BY 2, 3, 4, 5' );


    ParamByName('empresa').AsString := EEmpresa.Text;
    if ECentroSalida.Text <> '' then
      ParamByName('centroSalida').AsString := ECentroSalida.Text;
    if ECentroOrigen.Text <> '' then
      ParamByName('centroOrigen').AsString := ECentroOrigen.Text;
    ParamByName('producto').AsString := EProductoD.Text;
    ParamByName('producto_h').AsString := EProductoH.Text;
    ParamByName('cliente_d').AsString := EClienteD.Text;
    ParamByName('cliente_h').AsString := EClienteH.Text;
    ParamByName('desde').AsDateTime := StrToDate(MEDesde.Text);
    ParamByName('hasta').AsDateTime := StrToDate(MEHasta.Text);
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
    kProducto:
      begin
        if EProductoD.Focused then
          DespliegaRejilla(BGBProductoD, [EEmpresa.Text])
        else
          DespliegaRejilla(BGBProductoH, [EEmpresa.Text]);
      end;
    kCliente:
      begin
        if EClienteD.Focused then
          DespliegaRejilla(BGBClienteD, [EEmpresa.Text])
        else
          DespliegaRejilla(BGBClienteH, [EEmpresa.Text])
      end;
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
      ECentroSalidaChange( ECentroSalida );
      ECentroOrigenChange( ECentroOrigen );
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

procedure TFLSalidasEnvases2.ECentroOrigenChange(Sender: TObject);
begin
  if (gRF <> nil) then
    if esVisible( gRF ) then
      Exit;
  if (gCF <> nil) then
    if esVisible( gCF ) then
      Exit;
  if ECentroOrigen.Text = '' then
  begin
    stCentroOrigen.Caption:= 'VACIO TODOS LOS CENTROS';
  end
   else
  begin
    stCentroOrigen.Caption:= desCentro( EEmpresa.Text, ECentroOrigen.Text );
  end;
end;

procedure TFLSalidasEnvases2.ECentroSalidaChange(Sender: TObject);
begin
  if (gRF <> nil) then
    if esVisible( gRF ) then
      Exit;
  if (gCF <> nil) then
    if esVisible( gCF ) then
      Exit;
  if ECentroSalida.Text = '' then
  begin
    stCentroSalida.Caption:= 'VACIO TODOS LOS CENTROS';
  end
  else
  begin
    stCentroSalida.Caption:= desCentro( EEmpresa.Text, ECentroSalida.Text );
  end;
end;

end.
