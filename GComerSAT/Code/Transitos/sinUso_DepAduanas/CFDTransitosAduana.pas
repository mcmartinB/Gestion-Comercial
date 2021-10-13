unit CFDTransitosAduana;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, DB, DBCtrls, nbLabels, Grids,
  DBGrids, Mask, Buttons, BSpeedButton, BGridButton, BEdit, BDEdit, BGrid;

type
  TFDTransitosAduana = class(TForm)
    btnGuardar: TButton;
    btnSalir: TButton;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    nbLabel5: TnbLabel;
    nbLabel6: TnbLabel;
    nbLabel7: TnbLabel;
    nbLabel8: TnbLabel;
    DSDatosAduana: TDataSource;
    dvd_fa: TnbDBAlfa;
    fecha_entrada_dda_dac: TnbDBCalendarCombo;
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
    DBGDetalle: TDBGrid;
    DBGSalidas: TDBGrid;
    btnAltaDetalle: TButton;
    btnEditarDetalle: TButton;
    btnBorrarDetalle: TButton;
    nbLabel9: TnbLabel;
    nbLabel13: TnbLabel;
    btnAltaSalida: TButton;
    btnEditarSalida: TButton;
    btnBorrarSalida: TButton;
    DSDetalle: TDataSource;
    DSSalidas: TDataSource;
    nbLabel14: TnbLabel;
    lblKilosTransito: TLabel;
    DSKilosDetalle: TDataSource;
    DSKilosSalidas: TDataSource;
    nbLabel15: TnbLabel;
    mercancia_dac: TnbDBNumeric;
    nbLabel16: TnbLabel;
    combustible_dac: TnbDBNumeric;
    nbLabel17: TnbLabel;
    seguridad_dac: TnbDBNumeric;
    nbLabel18: TnbLabel;
    frigorifico_dac: TnbDBNumeric;
    lblFaltaConsumo: TLabel;
    dbedtkilos_dal: TDBEdit;
    dbedt1: TDBEdit;
    lblFaltaAlbaranesTotal: TLabel;
    lblFaltaAlbaranesSalida: TLabel;
    eKilosSalidasDetalle: TDBEdit;
    btnFactura: TButton;
    btnPrecios: TButton;
    teus40_dac: TnbDBNumeric;
    lblCodigo1: TnbLabel;
    lblCodigo2: TnbLabel;
    metros_lineales_dac: TnbDBNumeric;
    lblCodigo3: TnbLabel;
    puerto_salida_dac: TBDEdit;
    btnpuerto_salida_dac: TBGridButton;
    stpuerto_salida_dac: TStaticText;
    bgrdRejillaFlotante: TBGrid;
    procedure btnSalirClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnImprimirFichaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAltaDetalleClick(Sender: TObject);
    procedure btnEditarDetalleClick(Sender: TObject);
    procedure btnBorrarDetalleClick(Sender: TObject);
    procedure DBGDetalleDblClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAltaSalidaClick(Sender: TObject);
    procedure btnEditarSalidaClick(Sender: TObject);
    procedure btnBorrarSalidaClick(Sender: TObject);
    procedure DBGSalidasDblClick(Sender: TObject);
    procedure DBGDetalleDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGSalidasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGDetalleCellClick(Column: TColumn);
    procedure dbedtkilos_dalChange(Sender: TObject);
    procedure dbedt1Change(Sender: TObject);
    procedure btnFacturaClick(Sender: TObject);
    procedure btnPreciosClick(Sender: TObject);
    procedure teus40_dacChange(Sender: TObject);
    procedure metros_lineales_dacChange(Sender: TObject);
    procedure puerto_salida_dacChange(Sender: TObject);
    procedure btnpuerto_salida_dacClick(Sender: TObject);
  private
    { Private declarations }
    iResult: integer;
    sEmpresa, sCentro: String;
    dFecha: TDateTime;
    iTransito: Integer;
    rKilosTransito: real;
    rMetrosLinealesDef: real;

    function  TieneAlgunDatoPendiente: boolean;
    procedure MiPost;
    procedure BorrarDeposito;
    procedure BotonesDetalle( ABotones: Boolean );
  public
    { Public declarations }
    procedure MetrosLinealesDef;
  end;

  function Ejecutar( const AOwner: TComponent;
                      const AEmpresa, ACentro: String;
                      const AFecha: TDateTime;
                      const ATransito: Integer ): integer;

  var bFactura: boolean = False;

implementation

{$R *.dfm}

uses
  CDDTransitosAduana, CFDTransitosAduanaDetalle, CFDTransitosAduanaSalidas,
  DepositoAduanaImportesFD, UDMAuxDB, CAuxiliarDB, CVariables;

var
  FDTransitosAduana: TFDTransitosAduana;

function Ejecutar( const AOwner: TComponent;
                    const AEmpresa, ACentro: String;
                    const AFecha: TDateTime;
                    const ATransito: Integer ): integer;
var
  rAux: real;
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

  DDTransitosAduana_:= TDDTransitosAduana.Create( FDTransitosAduana );

  try
    DDTransitosAduana_.GetKilosTransito( AEmpresa, ACentro, AFecha, ATransito, FDTransitosAduana.rKilosTransito, rAux, False );
    FDTransitosAduana.lblKilosTransito.Caption:=
      FormatFloat( '#,##0.00', FDTransitosAduana.rKilosTransito );

    if DDTransitosAduana_.GetDatosAduana( AEmpresa, ACentro, AFecha, ATransito ) then
    begin
      DDTransitosAduana_.QDatosAduana.Edit;
      FDTransitosAduana.BotonesDetalle( True );
    end
    else
    begin
      DDTransitosAduana_.QDatosAduana.Insert;
      FDTransitosAduana.BotonesDetalle( False );

      if ( ACentro = '6' ) and ( ( AEmpresa = '050' ) or ( AEmpresa = '080' ) ) then
        FDTransitosAduana.puerto_salida_dac.Text:= '38'; //Tenerife
      FDTransitosAduana.rMetrosLinealesDef:= DDTransitosAduana_.MetrosLineales( AEmpresa, ACentro, AFecha, ATransito );
      FDTransitosAduana.MetrosLinealesDef;
    end;

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

  if stpuerto_salida_dac.Caption = '' then
  begin
    puerto_salida_dac.SetFocus;
    raise Exception.Create('El puerto de salida es obligatorio.');
  end;


  DDTransitosAduana_.QDatosAduana.Post;
  BotonesDetalle( True );
end;


procedure TFDTransitosAduana.BotonesDetalle( ABotones: Boolean );
begin
  if btnAltaDetalle.Enabled = ABotones then
    Exit;
  btnAltaDetalle.Enabled:= ABotones;
  btnEditarDetalle.Enabled:= ABotones;
  btnBorrarDetalle.Enabled:= ABotones;

  btnAltaSalida.Enabled:= ABotones;
  btnEditarSalida.Enabled:= ABotones;
  btnBorrarSalida.Enabled:= ABotones;
end;

procedure TFDTransitosAduana.btnSalirClick(Sender: TObject);
var
  iBoton: integer;
begin
  if TieneAlgunDatoPendiente then
  begin
    iBoton:= MessageDlg('¿Antes de salir desea guardar los cambios realizados?', mtConfirmation, [mbYes, mbNo, mbCancel], 0 );
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

procedure TFDTransitosAduana.btnBorrarClick(Sender: TObject);
begin
  if MessageDlg('¿Seguro que quiere borrar el depósito seleccionado?', mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
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

procedure TFDTransitosAduana.BorrarDeposito;
begin
  while not DDTransitosAduana_.QDatosAduanaSalidas.IsEmpty do
  begin
    DDTransitosAduana_.QDatosAduanaSalidas.Delete;
  end;
  while not DDTransitosAduana_.QDatosAduanaDetalle.IsEmpty do
  begin
    DDTransitosAduana_.QDatosAduanaDetalle.Delete;
  end;
  DDTransitosAduana_.QDatosAduana.Delete;
end;

procedure TFDTransitosAduana.btnImprimirFichaClick(Sender: TObject);
var
  iBoton: integer;
begin
  if TieneAlgunDatoPendiente then
  begin
    iBoton:= MessageDlg('¿Antes de salir desea guardar los cambios realizados?' + #13 + #10 +
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

procedure TFDTransitosAduana.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
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
    if Key = Ord('I') then
    begin
      btnFactura.Click;
      Key:= 0;
    end;
  end
  else
  if ssCtrl in Shift then
  begin
    if Key = Ord('A') then
    begin
      btnAltaDetalle.Click;
      Key:= 0;
    end
    else
    if Key = Ord('M') then
    begin
      btnEditarDetalle.Click;
      Key:= 0;
    end
    else
    if Key = Ord('B') then
    begin
      btnBorrarDetalle.Click;
      Key:= 0;
    end;
  end
  else
  if ssAlt in Shift then
  begin
    if Key = Ord('A') then
    begin
      btnAltaSalida.Click;
      Key:= 0;
    end
    else
    if Key = Ord('M') then
    begin
      btnEditarSalida.Click;
      Key:= 0;
    end
    else
    if Key = Ord('B') then
    begin
      btnBorrarSalida.Click;
      Key:= 0;
    end;
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

procedure TFDTransitosAduana.btnAltaDetalleClick(Sender: TObject);
begin
  CFDTransitosAduanaDetalle.Alta( self, DSDatosAduana.DataSet.FieldByName('codigo_dac').AsInteger,
                                  DSDatosAduana.DataSet.FieldByName('empresa_dac').AsString,
                                  DSDatosAduana.DataSet.FieldByName('dvd_dac').AsString,
                                  dFecha, rKilosTransito,
                                  DSKilosDetalle.DataSet.FieldByName('kilos_dal').AsFloat );
  DSDetalle.DataSet.Close;
  DSDetalle.DataSet.Open;
  DSKilosDetalle.DataSet.Close;
  DSKilosDetalle.DataSet.Open;
end;

procedure TFDTransitosAduana.btnEditarDetalleClick(Sender: TObject);
begin
  if not DSDetalle.DataSet.IsEmpty then
  begin
    CFDTransitosAduanaDetalle.Modificacion( self, DSDatosAduana.DataSet.FieldByName('dvd_dac').AsString,
       dFecha, rKilosTransito, DSKilosDetalle.DataSet.FieldByName('kilos_dal').AsFloat );
    DSKilosDetalle.DataSet.Close;
    DSKilosDetalle.DataSet.Open;
  end
  else
  begin
    ShowMessage('Sin detalle.');
  end;
end;

procedure TFDTransitosAduana.btnBorrarDetalleClick(Sender: TObject);
begin
  if not DSDetalle.DataSet.IsEmpty then
  begin
    if MessageDlg('¿Seguro que quiere borrar el detalle seleccionado y sus salidas asociadas?', mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
    begin
      DSSalidas.DataSet.DisableControls;
      DSSalidas.DataSet.First;
      while not DSSalidas.DataSet.Eof do
      begin
        if DSSalidas.DataSet.FieldByName('linea_das').AsInteger =
           DSDetalle.DataSet.FieldByName('linea_dal').AsInteger then
        begin
           DSSalidas.DataSet.Delete;
        end
        else
        begin
          DSSalidas.DataSet.Next;
        end;
      end;
      DSSalidas.DataSet.First;
      DSSalidas.DataSet.EnableControls;

      DSDetalle.DataSet.Delete;
      DSKilosDetalle.DataSet.Close;
      DSKilosDetalle.DataSet.Open;
    end;
  end
  else
  begin
    ShowMessage('Sin detalle.');
  end;
end;

procedure TFDTransitosAduana.DBGDetalleDblClick(Sender: TObject);
begin
  btnEditarDetalle.Click;
end;

procedure TFDTransitosAduana.btnAltaSalidaClick(Sender: TObject);
begin
  if not DSDetalle.DataSet.IsEmpty then
  begin
    CFDTransitosAduanaSalidas.Alta( self, DSDatosAduana.DataSet.FieldByName('codigo_dac').AsInteger,
                                    DSDetalle.DataSet.FieldByName('linea_dal').AsInteger,
                                    DSDatosAduana.DataSet.FieldByName('empresa_dac').AsString,
                                    DSDatosAduana.DataSet.FieldByName('centro_dac').AsString,
                                    DSDatosAduana.DataSet.FieldByName('dvd_dac').AsString,
                                    dFecha, rKilosTransito,
                                    DSDetalle.DataSet.FieldByName('centro_destino_dal').AsString,
                                    DSDetalle.DataSet.FieldByName('cliente_dal').AsString,
                                    DSDetalle.DataSet.FieldByName('dir_sum_dal').AsString,
                                    DSDetalle.DataSet.FieldByName('fecha_dal').AsDateTime,
                                    DSDetalle.DataSet.FieldByName('kilos_dal').AsFloat );
    DSSalidas.DataSet.Close;
    DSSalidas.DataSet.Open;
    DSKilosSalidas.DataSet.Close;
    DSKilosSalidas.DataSet.Open;
  end
  else
  begin
    ShowMessage('Falta grabar los DUA de consumo.');
  end;
end;

procedure TFDTransitosAduana.btnEditarSalidaClick(Sender: TObject);
begin
  if not DSSalidas.DataSet.IsEmpty then
  begin
    CFDTransitosAduanaSalidas.Modificacion( self, DSDatosAduana.DataSet.FieldByName('codigo_dac').AsInteger,
                                    DSSalidas.DataSet.FieldByName('linea_das').AsInteger,
                                    DSDatosAduana.DataSet.FieldByName('empresa_dac').AsString,
                                    DSDatosAduana.DataSet.FieldByName('centro_dac').AsString,
                                    DSDatosAduana.DataSet.FieldByName('dvd_dac').AsString,
                                    dFecha, rKilosTransito );
    DSKilosSalidas.DataSet.Close;
    DSKilosSalidas.DataSet.Open;
  end
  else
  begin
    ShowMessage('Sin albaranes de salida.');
  end;
end;

procedure TFDTransitosAduana.btnBorrarSalidaClick(Sender: TObject);
begin
  if not DSSalidas.DataSet.IsEmpty then
  begin
    if MessageDlg('¿Seguro que quiere borrar el albarán de salida seleccionado?', mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
    begin
      DSSalidas.DataSet.Delete;
      DSKilosSalidas.DataSet.Close;
      DSKilosSalidas.DataSet.Open;
    end;
  end
  else
  begin
    ShowMessage('Sin albaranes de salida.');
  end;
end;


procedure TFDTransitosAduana.DBGSalidasDblClick(Sender: TObject);
begin
  btnEditarSalida.Click;
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

procedure TFDTransitosAduana.DBGSalidasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  grid : TDBGrid;
begin
  grid := sender as TDBGrid;
  begin
    if ( grid.DataSource.DataSet.FieldByname('linea_das').AsInteger =
           DSDetalle.DataSet.FieldByname('linea_dal').AsInteger )  and
         not grid.DataSource.DataSet.IsEmpty then
        grid.Canvas.Brush.Color := clSilver
    else
        grid.Canvas.Brush.Color := clWhite;

    grid.Canvas.Font.Color := clBlack;
    if (gdSelected in State) then
    begin
      grid.Canvas.Font.Style := Font.Style + [fsBold];
    end;
  end;

  grid.DefaultDrawColumnCell(Rect, DataCol, Column, State) ;
end;

procedure TFDTransitosAduana.DBGDetalleCellClick(Column: TColumn);
var
  rAux: real;
begin
  //DBGSalidas.Repaint;
  DBGSalidas.Refresh;
  IF DDTransitosAduana_.QKilosSalidasDetalle.Active then
  begin
    rAux:= DSDetalle.DataSet.FieldByName('kilos_dal').AsFloat - DDTransitosAduana_.QKilosSalidasDetalle.FieldByName('kilos_das').AsFloat;
    if rAux = 0 then
      lblFaltaAlbaranesSalida.Caption:= 'Todos los kilos asignados.'
    else
      lblFaltaAlbaranesSalida.Caption:= FormatFloat( 'Faltan #,##0.00 kg de la salida.', rAux );
  end;  
end;

procedure TFDTransitosAduana.dbedtkilos_dalChange(Sender: TObject);
var
  rAux: real;
begin
  IF DSKilosDetalle.DataSet.Active then
  begin
    rAux:= rKilosTransito - DSKilosDetalle.DataSet.FieldByName('kilos_dal').AsFloat;
    if rAux = 0 then
      lblFaltaConsumo.Caption:= 'Todos los kilos asignados.'
    else
      lblFaltaConsumo.Caption:= FormatFloat( 'Faltan #,##0.00 kg.', rAux );
  end;
end;

procedure TFDTransitosAduana.dbedt1Change(Sender: TObject);
var
  rAux: real;
begin
  IF DSKilosSalidas.DataSet.Active then
  begin
    rAux:= rKilosTransito - DSKilosSalidas.DataSet.FieldByName('kilos_das').AsFloat;
    if rAux = 0 then
      lblFaltaAlbaranesTotal.Caption:= 'Todos los kilos asignados.'
    else
      lblFaltaAlbaranesTotal.Caption:= FormatFloat( 'Faltan #,##0.00 kg del tránsito.', rAux );
  end;
end;

procedure TFDTransitosAduana.btnFacturaClick(Sender: TObject);
var
  iBoton: integer;
begin
  if TieneAlgunDatoPendiente then
  begin
    iBoton:= MessageDlg('¿Antes de salir desea guardar los cambios realizados?' + #13 + #10 +
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
  bFactura:= True;
  iResult:= DDTransitosAduana_.QDatosAduana.FieldByName('codigo_dac').AsInteger;
  Close;
end;

procedure TFDTransitosAduana.btnPreciosClick(Sender: TObject);
begin
  DepositoAduanaImportesFD.ExecuteDepositoAduanaImportes( self, sEmpresa );
end;

procedure TFDTransitosAduana.teus40_dacChange(Sender: TObject);
var
  iAux: Integer;
  rAux: Real;
begin
  iAux:= StrToIntDef( teus40_dac.Text, 0 );
  rAux:= StrToFloatDef( metros_lineales_dac.Text, 0 );
  if iAux <> 0 then
  begin
    if rAux <> 0 then
      metros_lineales_dac.Text:= '0';
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

procedure TFDTransitosAduana.metros_lineales_dacChange(Sender: TObject);
var
  rAux: Real;
  iAux: Integer;
begin
  rAux:= StrToFloatDef( metros_lineales_dac.Text, 0 );
  iAux:= StrToIntDef( teus40_dac.Text, 0 );
  if rAux <> 0 then
  begin
    if iAux <> 0 then
      teus40_dac.Text:= '0';
  end;
(*
  else
  begin
    if iAux = 0 then
      teus40_dac.Text:= '1';
  end;
*)
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

end.
