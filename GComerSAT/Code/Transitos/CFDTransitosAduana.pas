unit CFDTransitosAduana;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, DB, DBCtrls, nbLabels, Grids,
  DBGrids, Mask, Buttons, BSpeedButton, BGridButton, BEdit, BDEdit, BGrid,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, dxSkinsCore,
  dxSkinBlueprint, dxSkinFoggy, dxSkinMoneyTwins, cxButtons, dError, DBTables, UDMConfig,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TFDTransitosAduana = class(TForm)
    btnGuardar: TButton;
    btnSalir: TButton;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    nbLabel5: TnbLabel;
    nbLabel7: TnbLabel;
    nbLabel8: TnbLabel;
    DSDatosAduana: TDataSource;
    dvd_dac: TnbDBAlfa;
    embarque_dac: TnbDBAlfa;
    dua_exporta_dac: TnbDBAlfa;
    flete_dac: TnbDBNumeric;
    factura_dac: TnbDBAlfa;
    rappel_dac: TnbDBNumeric;
    manipulacion_dac: TnbDBNumeric;
    Concepto: TnbLabel;
    nbLabel21: TnbLabel;
    btnBorrar: TButton;
    btnImprimirFicha: TButton;
    nbLabel10: TnbLabel;
    nbLabel11: TnbLabel;
    lblFlete: TnbLabel;
    lblEmpresa: TLabel;
    lblTransito: TLabel;
    lblCentro: TLabel;
    lblFecha: TLabel;
    nbLabel14: TnbLabel;
    lblKilosTransito: TLabel;
    nbLabel15: TnbLabel;
    mercancia_dac: TnbDBNumeric;
    nbLabel16: TnbLabel;
    combustible_dac: TnbDBNumeric;
    nbLabel17: TnbLabel;
    seguridad_dac: TnbDBNumeric;
    nbLabel18: TnbLabel;
    frigorifico_dac: TnbDBNumeric;
    teus40_dac: TnbDBNumeric;
    lblCodigo1: TnbLabel;
    lblCodigo2: TnbLabel;
    metros_lineales_dac: TnbDBNumeric;
    lblCodigo3: TnbLabel;
    puerto_salida_dac: TBDEdit;
    btnpuerto_salida_dac: TBGridButton;
    stpuerto_salida_dac: TStaticText;
    bgrdRejillaFlotante: TBGrid;
    kilos_netos_dac: TnbDBNumeric;
    kilos_brutos_dac: TnbDBNumeric;
    lblKilosNetos_: TnbLabel;
    lblKilosBrutos_: TnbLabel;
    lblKilosNetos: TLabel;
    lblKilosBrutos: TLabel;
    naviera_dac: TBDEdit;
    lbl1: TnbLabel;
    lblNaviera: TLabel;
    lblPuertoDestino: TnbLabel;
    puerto_destino_dac: TBDEdit;
    btnPuertoDestino: TBGridButton;
    txtPuertoDestino: TStaticText;
    desPuertoDestino: TLabel;
    teus45_dac: TnbDBNumeric;
    nbLabel6: TnbLabel;
    nbLabel9: TnbLabel;
    cont_lame_dac: TBDEdit;
    btnAsignarLame: TcxButton;
    btnCancelarLame: TcxButton;
    procedure btnSalirClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnImprimirFichaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGDetalleDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure teus40_dacChange(Sender: TObject);
    procedure metros_lineales_dacChange(Sender: TObject);
    procedure puerto_salida_dacChange(Sender: TObject);
    procedure btnpuerto_salida_dacClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure puerto_destino_dacChange(Sender: TObject);
    procedure btnPuertoDestinoClick(Sender: TObject);
    procedure teus45_dacChange(Sender: TObject);
    procedure btnAsignarLameClick(Sender: TObject);
    procedure btnCancelarLameClick(Sender: TObject);
  private
    { Private declarations }
    iResult: integer;
    sEmpresa, sCentro: String;
    dFecha: TDateTime;
    iTransito: Integer;
    iKilosTransito, iKilosBruto: real;
    rMetrosLinealesDef: real;

    function  TieneAlgunDatoPendiente: boolean;
    procedure MiPost;
    procedure BorrarDeposito;
    function GetContadorLame( empresa, centro: string; actualiza: Boolean ): integer;
    procedure ActualizarContadorLame( empresa, centro: string; lame: integer );

  public
    { Public declarations }
    procedure MetrosLinealesDef;
    procedure GetNavieraPuerto;
  end;

  function Ejecutar( const AOwner: TComponent; const AEsTransito: boolean;
                      const AEmpresa, ACentro: String;
                      const AFecha: TDateTime;
                      const ATransito: Integer ): integer;

  var bFactura: boolean = False;

implementation

{$R *.dfm}

uses
  CDDTransitosAduana, {CFDTransitosAduanaDetalle, CFDTransitosAduanaSalidas,}
  UDMAuxDB, CAuxiliarDB, CVariables, UDMTransitos, UDMBaseDatos;

var
  FDTransitosAduana: TFDTransitosAduana;

function Ejecutar( const AOwner: TComponent; const AEsTransito: boolean;
                   const AEmpresa, ACentro: String;
                   const AFecha: TDateTime;
                   const ATransito: Integer ): integer;
begin
  FDTransitosAduana:= TFDTransitosAduana.Create( AOwner );

  FDTransitosAduana.sEmpresa:= AEmpresa;
  FDTransitosAduana.sCentro:= ACentro;
  FDTransitosAduana.dFecha:=  AFecha;
  FDTransitosAduana.iTransito:= ATransito;

  FDTransitosAduana.lblEmpresa.Caption:= AEmpresa;
  FDTransitosAduana.lblCentro.Caption:= ACentro;
  FDTransitosAduana.lblFecha.Caption:=  DateToStr( AFecha );
  FDTransitosAduana.lblTransito.Caption:= IntToStr( ATransito );
  FDTransitosAduana.puerto_salida_dac.Tag:= kAduana;
  FDTransitosAduana.puerto_destino_dac.Tag:= kAduana;

  DDTransitosAduana_:= TDDTransitosAduana.Create( FDTransitosAduana );

  try
    if AEsTransito then
      DMTransitos.PesosTransito( AEmpresa, ACentro, ATransito, AFecha, FDTransitosAduana.iKilosTransito, FDTransitosAduana.iKilosBruto )
    else
      DMTransitos.PesosVenta( AEmpresa, ACentro, ATransito, AFecha, FDTransitosAduana.iKilosTransito, FDTransitosAduana.iKilosBruto );

    FDTransitosAduana.lblKilosTransito.Caption:=
      FormatFloat( '#,##0.00', FDTransitosAduana.iKilosTransito );
    FDTransitosAduana.lblKilosNetos.Caption:=
      FormatFloat( '#,##0', FDTransitosAduana.iKilosTransito );
    FDTransitosAduana.lblKilosBrutos.Caption:=
      FormatFloat( '#,##0', FDTransitosAduana.iKilosBruto );




    if DDTransitosAduana_.GetDatosAduana( AEmpresa, ACentro, AFecha, ATransito ) then
    begin
      DDTransitosAduana_.QDatosAduana.Edit;
      if AEsTransito then
      begin
        FDTransitosAduana.GetNavieraPuerto;
      end
      else
      begin
        FDTransitosAduana.naviera_dac.Visible:= True;
        FDTransitosAduana.puerto_destino_dac.Visible:= True;
        FDTransitosAduana.btnPuertoDestino.Visible:= True;
        FDTransitosAduana.txtPuertoDestino.Visible:= True;
      end;
    end
    else
    begin
      DDTransitosAduana_.QDatosAduana.Insert;

      if ( ACentro = '6' ) and ( ( AEmpresa = '050' ) or ( AEmpresa = '080' ) ) then
        FDTransitosAduana.puerto_salida_dac.Text:= '38'; //Tenerife

      if AEsTransito then
      begin
        FDTransitosAduana.rMetrosLinealesDef:= DDTransitosAduana_.MetrosLineales( AEmpresa, ACentro, AFecha, ATransito );
        FDTransitosAduana.MetrosLinealesDef;
        FDTransitosAduana.GetNavieraPuerto;
      end
      else
      begin
        FDTransitosAduana.naviera_dac.Visible:= True;
        FDTransitosAduana.puerto_destino_dac.Visible:= True;
        FDTransitosAduana.btnPuertoDestino.Visible:= True;
        FDTransitosAduana.txtPuertoDestino.Visible:= True;
        FDTransitosAduana.puerto_destino_dac.Text:= '28'; //peninsula
      end;
    end;

    if AEsTransito then
      FDTransitosAduana.activeControl:= FDTransitosAduana.dvd_dac
    else
      FDTransitosAduana.activeControl:= FDTransitosAduana.naviera_dac;
      
    FDTransitosAduana.ShowModal;
    result:= FDTransitosAduana.iResult;
  finally
    FreeAndNil( DDTransitosAduana_ );
    FreeAndNil( FDTransitosAduana );
  end;
end;

function TFDTransitosAduana.TieneAlgunDatoPendiente: boolean;
begin
  result:= DDTransitosAduana_.QDatosAduana.Modified;
  (*
  if DDTransitosAduana_.QDatosAduana.Modified then
  begin
    result:= ( dvd_fa.Text <> '' );
  end
  else
  begin
    result:= false;
  end;
  *)
end;

procedure TFDTransitosAduana.MiPost;
var
  iAux: Integer;
  rAux: Real;
begin
//Comento la transaccion por problemas al actualizar el sinonimo en la BBDD. 11_05_2020
{
  if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
  begin
    ShowError(' En este momento no se puede modificar los datos de Depositos de Aduanas, por favor intentelo mas tarde.');
    exit;
  end;
}
  try
    if DDTransitosAduana_.QDatosAduana.State = dsInsert then
    begin
      DDTransitosAduana_.QDatosAduana.FieldByName('empresa_dac').AsString:= sEmpresa;
      DDTransitosAduana_.QDatosAduana.FieldByName('centro_dac').AsString:= sCentro;
      DDTransitosAduana_.QDatosAduana.FieldByName('fecha_dac').AsDateTime:= dFecha;
      DDTransitosAduana_.QDatosAduana.FieldByName('referencia_dac').AsInteger:= iTransito;
    end;

    iAux:= StrToIntDef( teus40_dac.Text, 0 );
    if iAux <> 0 then
    begin
      DDTransitosAduana_.QDatosAduana.FieldByName('teus40_dac').AsInteger:= 1;
      DDTransitosAduana_.QDatosAduana.FieldByName('metros_lineales_dac').AsFloat:= 0;
    end
    else
    begin
      rAux:= StrToFloatDef( metros_lineales_dac.Text, 0 );
      DDTransitosAduana_.QDatosAduana.FieldByName('teus40_dac').AsInteger:= 0;
      DDTransitosAduana_.QDatosAduana.FieldByName('metros_lineales_dac').AsFloat:= rAux;
    end;
  {
    if stpuerto_salida_dac.Caption = '' then
    begin
      puerto_salida_dac.SetFocus;
      raise Exception.Create('El puerto de salida es obligatorio.');
    end;
  }

    DDTransitosAduana_.QDatosAduana.Post;
  except
  on e: EDBEngineError do
    begin
//      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      ShowError(e);
      Exit;
    end;
  end;
//  AceptarTransaccion(DMBaseDatos.DBBaseDatos);

end;


function TFDTransitosAduana.GetContadorLame(empresa, centro: string; actualiza: Boolean): integer;
begin
  with DMAuxDB.QDescripciones do
  begin
    SQL.Text := ' select cont_lame_c from frf_centros ' +
      ' where empresa_c=' + QuotedStr(empresa) + ' ' +
      ' and centro_c=' + QuotedStr(centro);
    try
      try
        Open;
        if IsEmpty then Result := 1
        else Result := Fields[0].AsInteger;
      except
        Result := 1;
      end;
    finally
      Cancel;
      Close;
    end;
  end;

  if actualiza then
  begin
    with DMAuxDB.QDescripciones do
    begin
      SQL.Text := ' update  frf_centros  set cont_lame_c = ' + IntToStr(Result + 1) +
        ' where empresa_c=' + QuotedStr(empresa) + ' ' +
        ' and centro_c=' + QuotedStr(centro);
      ExecSQL;
    end;
  end;
end;

procedure TFDTransitosAduana.ActualizarContadorLame(empresa, centro: string; lame: integer);
begin
  with DMAuxDB.QDescripciones do
  try
    SQL.Text := ' update  frf_centros  set cont_lame_c = ' + IntToStr(lame) +
      ' where empresa_c=' + QuotedStr(empresa) + ' ' +
      ' and centro_c=' + QuotedStr(centro);
    ExecSQL;
  except
    raise;
  end;
end;

procedure TFDTransitosAduana.btnSalirClick(Sender: TObject);
var
  iBoton: integer;
begin
  if TieneAlgunDatoPendiente then
  begin
    iBoton:= MessageDlg('?Antes de salir desea guardar los cambios realizados?', mtConfirmation, [mbYes, mbNo, mbCancel], 0 );
    if iBoton = mrYes then
    begin
      MiPost;
      iResult:= 0;
      Close;
    end
    else
    if iBoton = mrNo then
    begin
      DDTransitosAduana_.QDatosAduana.Cancel;
      iResult:= 0;
      Close;
    end;
  end
  else
  begin
    DDTransitosAduana_.QDatosAduana.Cancel;
    iResult:= 0;
    Close;
  end;
end;

procedure TFDTransitosAduana.btnGuardarClick(Sender: TObject);
begin
  if TieneAlgunDatoPendiente then
  begin
    MiPost;
    ShowMessage('Datos guardados correctamente.');
    DDTransitosAduana_.QDatosAduana.Edit;
  end
  else
  begin
    if DDTransitosAduana_.QDatosAduana.State = dsInsert then
    begin
      ShowMessage('Sin datos');
    end
    else
    begin
      ShowMessage('Datos guardados correctamente.');
    end;
  end;
end;

procedure TFDTransitosAduana.btnAsignarLameClick(Sender: TObject);
var iLame: integer;
begin
  if DDTransitosAduana_.QDatosAduana.FieldByName('cont_lame_dac').AsString <> '' then exit;

  iLame := GetContadorLame(lblEmpresa.Caption, lblCentro.Caption, true);
  DDTransitosAduana_.QDatosAduana.FieldByName('cont_lame_dac').AsInteger := iLame;
end;

procedure TFDTransitosAduana.btnBorrarClick(Sender: TObject);
begin
  if DDTransitosAduana_.QDatosAduana.FieldByName('cont_lame_dac').AsString <> '' then
  begin
    ShowMessage(' ATENCION! No se puede borrar un dep?sito con n?mero de entrada LAME asignado. ');
    exit;
  end;

  if MessageDlg('?Seguro que quiere borrar el dep?sito seleccionado?', mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
  begin
    if DDTransitosAduana_.QDatosAduana.State = dsInsert then
    begin
      DDTransitosAduana_.QDatosAduana.Cancel;
    end
    else
    begin
      DDTransitosAduana_.QDatosAduana.Cancel;
      BorrarDeposito;
    end;
    iResult:= 0;
    Close;
    (*
    DDTransitosAduana_.QDatosAduana.Insert;
    DDTransitosAduana_.QDatosAduana.FieldByName('empresa_dac').AsString:= sEmpresa;
    DDTransitosAduana_.QDatosAduana.FieldByName('centro_dac').AsString:= sCentro;
    DDTransitosAduana_.QDatosAduana.FieldByName('fecha_dac').AsDateTime:= dFecha;
    DDTransitosAduana_.QDatosAduana.FieldByName('referencia_dac').AsInteger:= iTransito;
    dvd_fa.SetFocus;
    *)
  end;
end;

procedure TFDTransitosAduana.btnCancelarLameClick(Sender: TObject);
var iLame: Integer;
begin
  if DDTransitosAduana_.QDatosAduana.FieldByName('cont_lame_dac').AsString = '' then exit;
  
  iLame := GetContadorLame(lblEmpresa.Caption, lblCentro.Caption, false) -1;
  if iLame <> DDTransitosAduana_.QDatosAduana.FieldByName('cont_lame_dac').AsInteger then
  begin
    ShowMessage(' ATENCION! No se puede cancelar la asignacion de LAME porque no es el ?ltimo numero. ');
    exit;
  end;
  ActualizarContadorLame ( lblEmpresa.Caption, lblCentro.Caption, iLame);
  DDTransitosAduana_.QDatosAduana.FieldByName('cont_lame_dac').AsString := '';
end;

procedure TFDTransitosAduana.BorrarDeposito;
begin
  DDTransitosAduana_.QDatosAduana.Delete;
end;

procedure TFDTransitosAduana.btnImprimirFichaClick(Sender: TObject);
var
  iBoton: integer;
begin
  if TieneAlgunDatoPendiente then
  begin
    iBoton:= MessageDlg('?Antes de salir desea guardar los cambios realizados?' + #13 + #10 +
                        'NOTA: Si pulsa que "NO" los cambios seran borrados.', mtConfirmation, [mbYes, mbNo, mbCancel], 0 );
    if iBoton = mrYes then
    begin
      MiPost;
    end
    else
    if iBoton = mrNo then
    begin
      DDTransitosAduana_.QDatosAduana.Cancel;
    end
    else
    begin
      Exit;
    end;
  end
  else
  begin
    if DDTransitosAduana_.QDatosAduana.State = dsInsert then
    begin
      ShowMessage('Sin datos');
      Exit;
    end;
    MiPost;
  end;
  bFactura:= False;
  iResult:= DDTransitosAduana_.QDatosAduana.FieldByName('codigo_dac').AsInteger;
  Close;
end;

procedure TFDTransitosAduana.FormCreate(Sender: TObject);
begin
   UDMTransitos.CreateDMTransitos( self );
   btnAsignarLame.Enabled := (DMConfig.EsLasMoradas = True);
   btnCancelarLame.Enabled := (DMConfig.EsLasMoradas = True);
end;

procedure TFDTransitosAduana.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  UDMTransitos.DestroyDMTransitos;
  Action:= caHide;
end;


procedure TFDTransitosAduana.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ssShift in Shift then
  begin
    if Key = Ord('B') then
    begin
      btnBorrar.Click;
      Key:= 0;
    end
    else
    if Key = Ord('I') then
    begin
      btnImprimirFicha.Click;
      Key:= 0;
    end
    else
  end;
end;

procedure TFDTransitosAduana.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f1 then
  begin
    btnGuardar.Click;
    Key:= 0;
  end
  else
  if Key = vk_escape then
  begin
    btnSalir.Click;
    Key:= 0;
  end;
end;

procedure TFDTransitosAduana.DBGDetalleDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  grid : TDBGrid;
begin
  grid := sender as TDBGrid;

  if NOT grid.Focused then
  begin
    if (gdSelected in State) then
    begin
      with grid.Canvas do
      begin
        Brush.Color := clHighlight;
        Font.Style := Font.Style + [fsBold];
        Font.Color := clHighlightText;
      end;
    end;
  end;
  grid.DefaultDrawColumnCell(Rect, DataCol, Column, State) ;
end;

procedure TFDTransitosAduana.teus40_dacChange(Sender: TObject);
var
  iAux, iAux2: Integer;
  rAux: Real;
begin
  iAux:= StrToIntDef( teus40_dac.Text, 0 );
  iAux2:= StrToIntDef( teus45_dac.Text, 0 );
  rAux:= StrToFloatDef( metros_lineales_dac.Text, 0 );
  if iAux <> 0 then
  begin
    if rAux <> 0 then
      metros_lineales_dac.Text:= '0';
    if iAux2 <> 0 then
      teus45_dac.Text := '0';
    teus40_dac.Text:= '1';
  end;
(*
  else
  begin
    if rAux = 0 then
      metros_lineales_dac.Text:= '14,2';
  end;
*)
end;

procedure TFDTransitosAduana.teus45_dacChange(Sender: TObject);
var iAux, iaux2: Integer;
    rAux: Real;
begin
  iAux:= StrToIntDef( teus45_dac.Text, 0 );
  iAux2:= StrToIntDef( teus40_dac.Text, 0 );
  rAux:= StrToFloatDef( metros_lineales_dac.Text, 0 );
  if iAux <> 0 then
  begin
    if rAux <> 0 then
      metros_lineales_dac.Text:= '0';
    if iaux2 <> 0 then
      teus40_dac.Text:= '0';
    teus45_dac.Text:= '1';
  end;
end;

procedure TFDTransitosAduana.metros_lineales_dacChange(Sender: TObject);
var
  rAux: Real;
  iAux, iAux2: Integer;
begin
  rAux:= StrToFloatDef( metros_lineales_dac.Text, 0 );
  iAux:= StrToIntDef( teus40_dac.Text, 0 );
  iAux2:= StrToIntDef( teus45_dac.Text, 0 );
  if rAux <> 0 then
  begin
    if iAux <> 0 then
      teus40_dac.Text:= '0';
    if iAux2 <> 0 then
      teus45_dac.Text:= '0';
  end;
(*
  else
  begin
    if iAux = 0 then
      teus40_dac.Text:= '1';
  end;
*)
end;

procedure TFDTransitosAduana.GetNavieraPuerto;
begin
  naviera_dac.Visible:= False;
  puerto_destino_dac.Visible:= False;
  btnPuertoDestino.Visible:= False;
  txtPuertoDestino.Visible:= False;
  with dmauxdb.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select naviera_tc, puerto_tc ');
    SQL.Add(' from frf_transitos_c ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc = :fecha ');
    SQL.Add(' and referencia_tc = :referencia ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('fecha').AsDateTime:= dFecha;
    ParamByName('referencia').AsInteger:= iTransito;

    Open;
    try
      lblNaviera.Caption:= FieldByName('naviera_tc').AsString;
      desPuertoDestino.Caption:= desAduana(FieldByName('puerto_tc').AsString);
    finally
      Close;
    end;
  end;
end;

procedure TFDTransitosAduana.MetrosLinealesDef;
begin
  if rMetrosLinealesDef = 0 then
  begin
    teus40_dac.Text:= '1';
    metros_lineales_dac.Text:= '0';
  end
  else
  begin
    FDTransitosAduana.teus40_dac.Text:= '0';
    FDTransitosAduana.metros_lineales_dac.Text:= FloatToStr( rMetrosLinealesDef );
  end;
end;

procedure TFDTransitosAduana.puerto_salida_dacChange(Sender: TObject);
begin
  stpuerto_salida_dac.Caption := desAduana(puerto_salida_dac.Text);
end;

procedure TFDTransitosAduana.btnpuerto_salida_dacClick(Sender: TObject);
begin
  DespliegaRejilla( btnpuerto_salida_dac, [] );
end;

procedure TFDTransitosAduana.puerto_destino_dacChange(Sender: TObject);
begin
  txtPuertoDestino.Caption := desAduana(puerto_destino_dac.Text);
end;

procedure TFDTransitosAduana.btnPuertoDestinoClick(Sender: TObject);
begin
  DespliegaRejilla( btnpuertodestino, [] );
end;

end.
