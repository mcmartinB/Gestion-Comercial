unit CFDTransitosAduanaSalidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, DB, DBCtrls, nbLabels, Grids,
  DBGrids, Buttons, ExtCtrls;

type
  TFDTransitosAduanaSalidas = class(TForm)
    DSSalidasDatosAduana: TDataSource;
    DSAlbaranes: TDataSource;
    pnlSuperior: TPanel;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    lblEmpresa: TLabel;
    lblDVD: TLabel;
    lblCliente: TnbLabel;
    lblSuministro: TnbLabel;
    stCliente: TLabel;
    stSuministro: TLabel;
    pnlMedio: TPanel;
    dbgAlbaranes_: TDBGrid;
    pnlInferior: TPanel;
    nbLabel6: TnbLabel;
    nbLabel7: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    kilos_das: TnbDBNumeric;
    btnGuardar: TButton;
    btnSalir: TButton;
    fecha_das: TnbDBCalendarCombo;
    n_albaran_das: TnbDBNumeric;
    frigorifico_das: TnbDBNumeric;
    lblFactura: TnbLabel;
    lblOperador_transporte_das: TnbLabel;
    Operador_transporte_das: TnbDBSQLCombo;
    stOperador_transporte_das: TnbStaticText;
    lbltransporte_das: TnbLabel;
    transporte_das: TnbDBSQLCombo;
    sttransporte_das: TnbStaticText;
    lblVehiculo_das: TnbLabel;
    lbln_cmr_das: TnbLabel;
    n_cmr_das: TnbDBAlfa;
    vehiculo_das: TnbDBAlfa;
    n_factura_das: TnbDBAlfa;
    lbln_pedido_das: TnbLabel;
    n_pedido_das: TnbDBAlfa;
    nbLabel5: TnbLabel;
    centro_salida_das: TnbDBSQLCombo;
    stCentro: TnbStaticText;
    lblKilosFaltan: TLabel;
    lblSeleccionable: TLabel;
    procedure btnSalirClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure centro_salida_dasChange(Sender: TObject);
    function stOperadorGetDescription: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbgAlbaranes_CellClick(Column: TColumn);
    function sttransporte_dasGetDescription: String;
    procedure transporte_dasChange(Sender: TObject);
    function Operador_transporte_dasGetSQL: String;
    function transporte_dasGetSQL: String;
    function centro_salida_dasGetSQL: String;
    function stCentroGetDescription: String;
    procedure Operador_transporte_dasChange(Sender: TObject);
  private
    { Private declarations }
    iCodigo, iLinea: integer;
    sEmpresa, sCentro, sDVD, sDestino, sCliente, sSuministro: string;
    dFechaTransito, dFechaDetalle: TDate;
    rKilos, rKilosTransito, rKilosDetalle, rKilosSalida,
                            rKilosDetalleSalidas, rKilosFaltan: Real;
    rCosteKilo: real;

    procedure IniciarForm( const ACodigo, ALinea: integer; const AEmpresa, ACentro, ADVD: String;
                           const AFecha: TDate; const AKilosTransito: real );
    procedure DatosGrid( const AEnable: Boolean );
    procedure DatosDetalleModificar;
    procedure DatosDetalleAlta( const ADestino, ACliente, ASuministro: string; const AFechaDetalle: TDateTime; const AKilosDetalle: real );
    function  TieneAlgunDatoPendiente: boolean;
    function  MiPost: boolean;
    function  ValidarDatos: boolean;
  public
    { Public declarations }
  end;

  procedure Modificacion( const AOwner: TComponent; const ACodigo, ALinea: integer;
                  const AEmpresa, ACentro, ADVD: String; const AFecha: TDate; const AKilosTransito: real );

  procedure Alta( const AOwner: TComponent; const ACodigo, ALinea: integer;
                  const AEmpresa, ACentro, ADVD: String; const AFecha: TDate;
                  const AKilosTransito: real; const ADestino, ACliente, ASuministrio: String;
                  const AFechaDetalle: TDate; const AKilosDetalle: real );

implementation

{$R *.dfm}

uses
  CDDTransitosAduana, UDMAuxDB, DBTables, bMath;

var
  FDTransitosAduanaSalidas: TFDTransitosAduanaSalidas;

procedure Modificacion( const AOwner: TComponent; const ACodigo, ALinea: integer;
                  const AEmpresa, ACentro, ADVD: String; const AFecha: TDate;
                  const AKilosTransito: real );
begin
  FDTransitosAduanaSalidas:= TFDTransitosAduanaSalidas.Create( AOwner );
  FDTransitosAduanaSalidas.IniciarForm( ACodigo, ALinea, AEmpresa, Acentro, ADVD, AFecha, AKilosTransito);
  try
    FDTransitosAduanaSalidas.DatosDetalleModificar;
    FDTransitosAduanaSalidas.DatosGrid( False );

    FDTransitosAduanaSalidas.DSSalidasDatosAduana.DataSet.Edit;

    FDTransitosAduanaSalidas.ShowModal;
  finally
    TQuery( FDTransitosAduanaSalidas.DSAlbaranes.DataSet ).Filtered:= False;
    TQuery( FDTransitosAduanaSalidas.DSAlbaranes.DataSet ).Close;
    FreeAndNil( FDTransitosAduanaSalidas );
  end;
end;

procedure Alta( const AOwner: TComponent; const ACodigo, ALinea: integer;
                const AEmpresa, ACentro, ADVD: String; const AFecha: TDate;
                const AKilosTransito: real; const ADestino, ACliente, ASuministrio: String;
                const AFechaDetalle: TDate; const AKilosDetalle: real );
begin
  FDTransitosAduanaSalidas:= TFDTransitosAduanaSalidas.Create( AOwner );
  FDTransitosAduanaSalidas.IniciarForm( ACodigo, ALinea, AEmpresa, ACentro, ADVD, AFecha, AKilosTransito);
  try

    FDTransitosAduanaSalidas.DatosDetalleAlta( ADestino, ACliente, ASuministrio, AFechaDetalle, AKilosDetalle );
    FDTransitosAduanaSalidas.DatosGrid( True );

    FDTransitosAduanaSalidas.DSSalidasDatosAduana.DataSet.Insert;

    FDTransitosAduanaSalidas.ShowModal;
  finally
    TQuery( FDTransitosAduanaSalidas.DSAlbaranes.DataSet ).Filtered:= False;
    TQuery( FDTransitosAduanaSalidas.DSAlbaranes.DataSet ).Close;
    FreeAndNil( FDTransitosAduanaSalidas );
  end;
end;

procedure TFDTransitosAduanaSalidas.IniciarForm( const ACodigo, ALinea: integer; const AEmpresa, ACentro, ADVD: String;
                                                 const AFecha: TDate; const AKilosTransito: real );
begin
  iCodigo:= ACodigo;
  iLinea:= ALinea;

  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sDVD:= ADVD;
  dFechaTransito:= AFecha;
  rKilosTransito:= AKilosTransito;

  lblEmpresa.Caption:= sEmpresa + ' ' + desEmpresa( sEmpresa );
  lblDVD.Caption:= sDVD;
end;

procedure TFDTransitosAduanaSalidas.DatosGrid( const AEnable: Boolean );
begin
  if AEnable  then
  begin
    TQuery( DSAlbaranes.DataSet ).ParamByName('empresa').AsString:= sEmpresa;
    TQuery( DSAlbaranes.DataSet ).ParamByName('centro').AsString:= sCentro;
    if SDestino <> '' then
      TQuery( DSAlbaranes.DataSet ).ParamByName('cliente').AsString:= SDestino
    else
      TQuery( DSAlbaranes.DataSet ).ParamByName('cliente').AsString:= sCliente;
    TQuery( DSAlbaranes.DataSet ).ParamByName('fecha').AsDateTime:= dFechaDetalle;
    TQuery( DSAlbaranes.DataSet ).Open;
    TQuery( DSAlbaranes.DataSet ).Filtered:= True;
    self.Height:= 634;
  end
  else
  begin
    self.Height:= 420;
  end;
  pnlMedio.Visible:= AEnable;
  centro_salida_das.Enabled:= AEnable;
  n_albaran_das.Enabled:= AEnable;
  fecha_das.Enabled:= AEnable;
end;

procedure TFDTransitosAduanaSalidas.DatosDetalleModificar;
begin
  DDTransitosAduana_.QDatosAduanaDetalleAux.ParamByName('codigo').AsInteger:=  iCodigo;
  DDTransitosAduana_.QDatosAduanaDetalleAux.ParamByName('linea').AsInteger:= iLinea;

  DDTransitosAduana_.QDatosAduanaDetalleAux.Open;
  rKilosDetalle:= DDTransitosAduana_.QDatosAduanaDetalleAux.FieldByName('kilos_dal').AsFloat;
  dFechaDetalle:= DDTransitosAduana_.QDatosAduanaDetalleAux.FieldByName('fecha_dal').AsDateTime;
  sCliente:= DDTransitosAduana_.QDatosAduanaDetalleAux.FieldByName('cliente_dal').AsString;
  sDestino:= DDTransitosAduana_.QDatosAduanaDetalleAux.FieldByName('centro_destino_dal').AsString;
  sSuministro:= DDTransitosAduana_.QDatosAduanaDetalleAux.FieldByName('dir_sum_dal').AsString;
  DDTransitosAduana_.QDatosAduanaDetalleAux.Close;

  if sDestino <> '' then
  begin
    stCliente.Caption:= sDestino + ' ' + desCentro( sEmpresa, sDestino );
    lblCliente.Caption:= 'Centro Destino';
    stSuministro.Caption:= '';
    lblSuministro.Caption:= '';
    DSAlbaranes.DataSet:= DDTransitosAduana_.QKilosPendientesT;
  end
  else
  begin
    stCliente.Caption:= sCliente + ' ' + desCliente( sEmpresa, sCliente );
    stSuministro.Caption:= sSuministro + ' ' + desSuministro( sEmpresa, sCliente, sSuministro );
    DSAlbaranes.DataSet:= DDTransitosAduana_.QKilosPendientes;
  end;

  //
  DSSalidasDatosAduana.DataSet:= DDTransitosAduana_.QDatosAduanaSalidas;
  rKilosSalida:= DSSalidasDatosAduana.DataSet.FieldByName('kilos_das').AsFloat;

  //
  DDTransitosAduana_.QKilosDetalleSalidas.ParamByName('codigo').AsInteger:= iCodigo;
  DDTransitosAduana_.QKilosDetalleSalidas.ParamByName('linea').AsInteger:= iLinea;

  DDTransitosAduana_.QKilosDetalleSalidas.Open;
  rKilosDetalleSalidas:= DDTransitosAduana_.QKilosDetalleSalidas.FieldByName('kilos_das').AsFloat;
  DDTransitosAduana_.QKilosDetalleSalidas.Close;

  rKilosFaltan:= ( rKilosDetalle + rKilosSalida ) - rKilosDetalleSalidas;
  if rKilosFaltan = 0 then
    lblKilosFaltan.Caption:= 'Todos los kilos asignados.'
  else
    lblKilosFaltan.Caption:= FormatFloat( 'Faltan #,##0.00 kg.', rKilosFaltan );
end;

procedure TFDTransitosAduanaSalidas.DatosDetalleAlta( const ADestino, ACliente, ASuministro: string;
                                      const AFechaDetalle: TDateTime; const AKilosDetalle: real );
begin
  sDestino:= ADestino;
  sCliente:= ACliente;
  sSuministro:= ASuministro;
  dFechaDetalle:= AFechaDetalle;
  rKilosDetalle:= AKilosDetalle;

  if sDestino <> '' then
  begin
    stCliente.Caption:= sDestino + ' ' + desCentro( sEmpresa, sDestino );
    lblCliente.Caption:= 'Centro Destino';
    stSuministro.Caption:= '';
    lblSuministro.Caption:= '';
    DSAlbaranes.DataSet:= DDTransitosAduana_.QKilosPendientesT;
  end
  else
  begin
    stCliente.Caption:= sCliente + ' ' + desCliente( sEmpresa, sCliente );
    stSuministro.Caption:= sSuministro + ' ' + desSuministro( sEmpresa, sCliente, sSuministro );
    DSAlbaranes.DataSet:= DDTransitosAduana_.QKilosPendientes;
  end;

  DSSalidasDatosAduana.DataSet:= DDTransitosAduana_.QDatosAduanaSalidasAux;
  rKilosSalida:= 0;

  DDTransitosAduana_.QKilosDetalleSalidas.ParamByName('codigo').AsInteger:= iCodigo;
  DDTransitosAduana_.QKilosDetalleSalidas.ParamByName('linea').AsInteger:= iLinea;

  DDTransitosAduana_.QKilosDetalleSalidas.Open;
  rKilosDetalleSalidas:= DDTransitosAduana_.QKilosDetalleSalidas.FieldByName('kilos_das').AsFloat;
  DDTransitosAduana_.QKilosDetalleSalidas.Close;

  rKilosFaltan:= ( rKilosDetalle + rKilosSalida ) - rKilosDetalleSalidas;
  if rKilosFaltan = 0 then
    lblKilosFaltan.Caption:= 'Todos los kilos asignados.'
  else
    lblKilosFaltan.Caption:= FormatFloat( 'Faltan #,##0.00 kg.', rKilosFaltan );  
end;

procedure TFDTransitosAduanaSalidas.FormShow(Sender: TObject);
begin
  stCentro.Description;
  stOperador_transporte_das.Description;
  sttransporte_das.Description;
end;

procedure TFDTransitosAduanaSalidas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

function TFDTransitosAduanaSalidas.TieneAlgunDatoPendiente: boolean;
begin
  result:= DSSalidasDatosAduana.DataSet.Modified;
end;

function TFDTransitosAduanaSalidas.ValidarDatos: boolean;
var
  dAux: TDateTime;
  iAux: Integer;
  rKilosAlbaran, rKilosAsignados: real;
begin
  result:= false;
  if stCentro.Caption = '' then
  begin
    ShowMessage('Falta o centro salida incorrecto.');
    centro_salida_das.SetFocus;
    Exit;
  end;

  if not TryStrToInt( n_albaran_das.Text, iAux ) then
  begin
    ShowMessage('Falta o número de albaran incorrecto.');
    n_albaran_das.SetFocus;
    Exit;
  end;

  if not TryStrToDate( fecha_das.Text, dAux ) then
  begin
    ShowMessage('Falta o fecha incorrecta.');
    fecha_das.SetFocus;
    Exit;
  end;
  if dAux < dFechaTransito then
  begin
    ShowMessage('La fecha de la salida no puede ser inferior a la fecha del transito.');
    fecha_das.SetFocus;
    Exit;
  end;

  if not TryStrToFloat( kilos_das.Text, double(rKilos) ) then
  begin
    ShowMessage('Falta o kilos incorrectos.');
    kilos_das.SetFocus;
    Exit;
  end;

  if sDestino = '' then
  begin
    //Comprobar que existe el albaran y que no se superan sus kilos
    if DDTransitosAduana_.GetKilosAlbaran( sEmpresa, centro_salida_das.Text, dAux, iAux, rKilosAlbaran, rKilosAsignados ) then
    begin
      if rKilos > ( ( rKilosAlbaran + rKilosSalida ) - rKilosAsignados ) then
      begin
        if MessageDlg('Hemos sobrepasado el número máximo de kilos que quedan en el albarán de salida ' +
                    '(Max:'+FormatFloat('#,##0.00', ( ( rKilosAlbaran + rKilosSalida ) - rKilosAsignados ) ) +' kgs).'
                    + #13 + #10 + '¿Esta seguro de querer continuar?',
                  mtConfirmation, [mbYes, mbCancel], 0 ) <> mrYes then
        begin
          kilos_das.SetFocus;
          Exit;
        end;
      end;
    end
    else
    begin
      if MessageDlg(' Albarán de salida incorrecto.' + #13 + #10 + '¿Esta seguro de querer continuar?',
                  mtConfirmation, [mbYes, mbCancel], 0 ) <> mrYes then
      begin
        centro_salida_das.SetFocus;
        Exit;
      end;
    end;
  end
  else
  begin
    //Comprobar que existe el transito y que no se superan sus kilos
    if DDTransitosAduana_.GetKilosTransito( sEmpresa, centro_salida_das.Text, dAux, iAux, rKilosAlbaran, rKilosAsignados, True ) then
    begin
      if rKilos > ( ( rKilosAlbaran + rKilosSalida ) - rKilosAsignados ) then
      begin
        if MessageDlg('Hemos sobrepasado el número máximo de kilos que quedan en el tránsito de salida ' +
                    '(Max:'+FormatFloat('#,##0.00', ( ( rKilosAlbaran + rKilosSalida ) - rKilosAsignados ) ) +' kgs).'
                    + #13 + #10 + '¿Esta seguro de querer continuar?',
                  mtConfirmation, [mbYes, mbCancel], 0 ) <> mrYes then
        begin
          kilos_das.SetFocus;
          Exit;
        end;
      end;
    end
    else
    begin
      if MessageDlg(' Tránsito de salida incorrecto.' + #13 + #10 + '¿Esta seguro de querer continuar?',
                  mtConfirmation, [mbYes, mbCancel], 0 ) <> mrYes then
      begin
        centro_salida_das.SetFocus;
        Exit;
      end;
    end;
  end;


  //Que no se superen los kilos del detalle
  if bRoundTo( rKilos, 2 ) > bRoundTo( rKilosFaltan, 2 ) then
  begin
    ShowMessage('Hemos sobrepasado el número máximo de kilos que quedan en el detalle de consumo seleccionado.' +
                '(Max:'+FormatFloat('#,##0.00', rKilosFaltan )+' kgs).' );
    kilos_das.SetFocus;
    Exit;
  end;
  result:= True;
end;

function TFDTransitosAduanaSalidas.MiPost: boolean;
begin
  if ValidarDatos then
  begin
    if DSSalidasDatosAduana.DataSet.State = dsInsert then
    begin
      DSSalidasDatosAduana.DataSet.FieldByName('codigo_das').AsInteger:= iCodigo;
      DSSalidasDatosAduana.DataSet.FieldByName('empresa_das').AsString:= sEmpresa;
      if sDestino <> '' then
        DSSalidasDatosAduana.DataSet.FieldByName('es_transito_das').AsInteger:= 1
      else
        DSSalidasDatosAduana.DataSet.FieldByName('es_transito_das').AsInteger:= 0;
    end;
    DSSalidasDatosAduana.DataSet.Post;
    //rKilosSalida:= rKilosSalida + rKilos;
    result:= true;
  end
  else
  begin
    result:= False;
  end;
end;

procedure TFDTransitosAduanaSalidas.btnSalirClick(Sender: TObject);
var
  iBoton: integer;
begin
  if DSSalidasDatosAduana.DataSet.State = dsInsert then
  begin
    DSSalidasDatosAduana.DataSet.Cancel;
    Close;
  end
  else
  begin
    if TieneAlgunDatoPendiente then
    begin
      iBoton:= MessageDlg('¿Antes de salir desea guardar los cambios realizados?', mtConfirmation, [mbYes, mbNo, mbCancel], 0 );
      if iBoton = mrYes then
      begin
        if MiPost then
          Close;
      end
      else
      if iBoton = mrNo then
      begin
        DSSalidasDatosAduana.DataSet.Cancel;
        Close;
      end;
    end
    else
    begin
      DSSalidasDatosAduana.DataSet.Cancel;
      Close;
    end;
  end;
end;

procedure TFDTransitosAduanaSalidas.btnGuardarClick(Sender: TObject);
begin
  if TieneAlgunDatoPendiente then
  begin
    if DSSalidasDatosAduana.DataSet.State = dsInsert then
    begin
      if MiPost then
      begin
        ShowMessage('Registro guardado.');
        Close;
        (*
        DSAlbaranes.DataSet.Close;
        DSAlbaranes.DataSet.Open;
        DSSalidasDatosAduana.DataSet.Insert;
        centro_salida_das.SetFocus;
        *)
      end;
    end
    else
    begin
      if MiPost then
      begin
        ShowMessage('Registro modificado.');
        Close;
      end;
    end;
  end
  else
  begin
    Close;
  end;
end;


function TFDTransitosAduanaSalidas.centro_salida_dasGetSQL: String;
begin
  result:= 'SELECT CENTRO_C, DESCRIPCION_C' + #13 + #10 +
           'FROM FRF_CENTROS' + #13 + #10 +
           'WHERE EMPRESA_C = ' + QuotedStr( sEmpresa ) + #13 + #10 +
           'ORDER BY CENTRO_C';
end;

function TFDTransitosAduanaSalidas.transporte_dasGetSQL: String;
begin
  result:= 'select transporte_t, descripcion_t' + #13 + #10 +
           'from frf_transportistas' + #13 + #10 +
           'where empresa_t = ' + QuotedStr( sEmpresa ) + #13 + #10 +
           'order by transporte_t';
end;

function TFDTransitosAduanaSalidas.Operador_transporte_dasGetSQL: String;
begin
  result:= 'select transporte_t, descripcion_t' + #13 + #10 +
           'from frf_transportistas' + #13 + #10 +
           'where empresa_t = ' + QuotedStr( sEmpresa ) + #13 + #10 +
           'order by transporte_t';
end;

procedure TFDTransitosAduanaSalidas.centro_salida_dasChange(Sender: TObject);
begin
  stCentro.Description;
end;

procedure TFDTransitosAduanaSalidas.Operador_transporte_dasChange(
  Sender: TObject);
begin
  stOperador_transporte_das.Description;
end;

procedure TFDTransitosAduanaSalidas.transporte_dasChange(Sender: TObject);
begin
  sttransporte_das.Description;
end;

function TFDTransitosAduanaSalidas.stCentroGetDescription: String;
begin
  result:= desCentro( sEmpresa, centro_salida_das.Text );
end;

function TFDTransitosAduanaSalidas.stOperadorGetDescription: String;
begin
  result:= desTransporte( sEmpresa, Operador_transporte_das.Text );
end;

function TFDTransitosAduanaSalidas.sttransporte_dasGetDescription: String;
begin
  result:= desTransporte( sEmpresa, transporte_das.Text );
end;

procedure TFDTransitosAduanaSalidas.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure TFDTransitosAduanaSalidas.dbgAlbaranes_CellClick(Column: TColumn);
var
  rAux: real;
begin
  DSSalidasDatosAduana.DataSet.FieldByName('centro_salida_das').AsString:= DSAlbaranes.DataSet.FieldByName('centro').AsString;
  DSSalidasDatosAduana.DataSet.FieldByName('n_albaran_das').AsString:=  DSAlbaranes.DataSet.FieldByName('albaran').AsString;
  DSSalidasDatosAduana.DataSet.FieldByName('fecha_das').AsDateTime:=  DSAlbaranes.DataSet.FieldByName('fecha').AsDateTime;

  if DSAlbaranes.DataSet.FieldByName('operador').AsString <> '' then
    DSSalidasDatosAduana.DataSet.FieldByName('operador_transporte_das').AsInteger:= DSAlbaranes.DataSet.FieldByName('operador').AsInteger
  else
    DSSalidasDatosAduana.DataSet.FieldByName('operador_transporte_das').AsInteger:= DSAlbaranes.DataSet.FieldByName('transporte').AsInteger;

  DSSalidasDatosAduana.DataSet.FieldByName('transporte_das').AsInteger:=  DSAlbaranes.DataSet.FieldByName('transporte').AsInteger;
  DSSalidasDatosAduana.DataSet.FieldByName('vehiculo_das').AsString:=  DSAlbaranes.DataSet.FieldByName('vehiculo').AsString;
  DSSalidasDatosAduana.DataSet.FieldByName('n_cmr_das').AsString:=  DSAlbaranes.DataSet.FieldByName('cmr').AsString;
  DSSalidasDatosAduana.DataSet.FieldByName('n_pedido_das').AsString:=  DSAlbaranes.DataSet.FieldByName('pedido').AsString;

  rAux:= DSAlbaranes.DataSet.FieldByName('kilos').AsFloat - DSAlbaranes.DataSet.FieldByName('kilos_asignados').AsFloat;
  if rAux > rKilosFaltan then
    DSSalidasDatosAduana.DataSet.FieldByName('kilos_das').AsFloat:= rKilosFaltan
  else
    DSSalidasDatosAduana.DataSet.FieldByName('kilos_das').AsFloat:= rAux;
end;

end.
