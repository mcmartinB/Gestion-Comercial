unit DRecepcionEntregas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, Buttons, nbLabels, BEdit, Grids,
  DBGrids;

type
  TFDRecepcionEntregas = class(TForm)
    empresa: TnbDBSQLCombo;
    centroLlegada: TnbDBSQLCombo;
    fechaCarga: TnbDBCalendarCombo;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nomEmpresa: TnbStaticText;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    lblMessage: TLabel;
    nomCentroLlegada: TnbStaticText;
    nbLabel4: TnbLabel;
    fechaLlegada: TnbDBCalendarCombo;
    nbLabel5: TnbLabel;
    eFactura: TBEdit;
    btnEntregasPendientes: TSpeedButton;
    dbgEntregasPendientes: TDBGrid;
    procedure BtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function centroLlegadaGetSQL: String;
    function nomEmpresaGetDescription: String;
    procedure empresaChange(Sender: TObject);
    procedure centroLlegadaChange(Sender: TObject);
    function nomcentroLlegadaGetDescription: String;
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEntregasPendientesClick(Sender: TObject);
    procedure dbgEntregasPendientesDblClick(Sender: TObject);
    procedure dbgEntregasPendientesExit(Sender: TObject);
    procedure dbgEntregasPendientesKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function  ParametrosOK: boolean;
    procedure RecepcionFruta( const AEmpresa, ACentro: String;
                    const AFechaLlegada, AFechaCarga: TDate; const AConduce: String );
    procedure MostrarInforme( const AOks, AErrores, ADuplicados: integer; const AMsgErrores: string );
    procedure AceptarEntregaPendiente;
    procedure CancelarEntregaPendiente;

  public
    { Public declarations }
  end;

implementation

uses bSQLUtils, UDMAuxDB, UDMBaseDatos, DMRecepcionEntregas, DBTables, DB, bDialogs,
     CVariables, UDMConfig, bTextUtils;

{$R *.dfm}

var
  DMRecepcionEntregasForm: TDMRecepcionEntregasForm;

procedure TFDRecepcionEntregas.FormCreate(Sender: TObject);
var
  sMsg: string;
begin
  DMRecepcionEntregasForm:= TDMRecepcionEntregasForm.create( Application );
  empresa.Text:= gsDefEmpresa;
  centroLlegada.Text:= gsDefCentro;
  fechaLlegada.AsDate:= date;
  fechaCarga.AsDate:= date;
  lblMessage.Caption:= 'Zona para mensajes de información.';
  dbgEntregasPendientes.Visible:= False;
end;

procedure TFDRecepcionEntregas.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFDRecepcionEntregas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil( DMRecepcionEntregasForm );
  DMBaseDatos.BDCentral.Close;
  Action:= caFree;
end;

function TFDRecepcionEntregas.centroLlegadaGetSQL: String;
begin
  if empresa.Text <> '' then
  begin
    result:= ' select empresa_c, centro_c, descripcion_c from frf_centros ' +
             ' where empresa_c ' + SQLEqualS( empresa.Text );
  end
  else
  begin
    result:= ' select empresa_c, centro_c, descripcion_c from frf_centros ';
  end;
end;

function TFDRecepcionEntregas.nomEmpresaGetDescription: String;
begin
  result:= desEmpresa( empresa.Text );
end;

function TFDRecepcionEntregas.nomcentroLlegadaGetDescription: String;
begin
  result:= desCentro( empresa.Text, centroLlegada.Text );
end;

procedure TFDRecepcionEntregas.empresaChange(Sender: TObject);
begin
  nomEmpresa.Description;
  nomCentroLlegada.Description;
end;

procedure TFDRecepcionEntregas.centroLlegadaChange(Sender: TObject);
begin
  nomcentroLlegada.Description;
end;

function TFDRecepcionEntregas.ParametrosOK: boolean;
var
  dCarga, dLlegada: TDateTime;
begin
  result:= True;
  if result and ( nomEmpresa.Caption = '' ) then
  begin
    ShowMessage('Código de empresa incorrecto.');
    empresa.SetFocus;
    result:= false;
  end;
  if result and ( nomCentroLlegada.Caption = '' ) then
  begin
    ShowMessage('Código de centro incorrecto.');
    centroLlegada.SetFocus;
    result:= false;
  end;
  if result and ( eFactura.Text = '' ) then
  begin
    ShowMessage('Falta factura conduce.');
    eFactura.SetFocus;
    result:= false;
  end;
  if result and ( not TryStrToDate( fechaLlegada.Text, dLlegada ) ) then
  begin
    ShowMessage('Fecha de llegada incorrecta.');
    fechaLlegada.SetFocus;
    result:= false;
  end;
  if result and ( not TryStrToDate( fechaCarga.Text, dCarga ) ) then
  begin
    ShowMessage('Fecha de carga incorrecta.');
    fechaCarga.SetFocus;
    result:= false;
  end;
  if result and ( dLlegada < dCarga ) then
  begin
    ShowMessage('La fecha de llegada no puede ser menor que la de carga.');
    fechaLlegada.SetFocus;
    result:= false;
  end;
end;

procedure TFDRecepcionEntregas.BtnOkClick(Sender: TObject);
begin
  if ParametrosOK then
  begin
    lblMessage.Caption:='Espere por favor ....';
    Application.ProcessMessages;
    lblMessage.Font.Color:= clBlack;
    try
      DMBaseDatos.BDCentral.Open;
      RecepcionFruta( empresa.Text, centroLlegada.Text, fechaLlegada.AsDate, fechaCarga.AsDate, eFactura.Text );
    except
      on e: Exception do
      begin
        lblMessage.Caption:='Se ha producido un error inesperado.';
        lblMessage.Font.Color:= clRed;
        DMBaseDatos.BDCentral.Close;
        ShowMessage( e.Message );
      end;
    end;
  end;
end;

procedure TFDRecepcionEntregas.RecepcionFruta( const AEmpresa, ACentro: String;
                    const AFechaLlegada, AFechaCarga: TDate; const AConduce: String );
var
  iOk, iError, iDuplicados: integer;
  slErrores: TStringList;
begin
  iOk:= 0;
  iError:= 0;
  iDuplicados:= 0;
  slErrores:= TStringList.Create;

  with DMRecepcionEntregasForm do
  begin
    if HayEntregas( AEmpresa, ACentro, AFechaCarga, AConduce ) then
    begin
      while not QEntregasCabRemoto.Eof do
      begin
        if not EstaGrabadaEntrega then
        begin
          if GrabarEntrega( fechaLlegada.AsDate ) then
          begin
            Inc( iOk );
          end
          else
          begin
            Inc( iError );
            slErrores.Add( MensajeError );
          end;
        end
        else
        begin
          Inc( iDuplicados );
        end;
        QEntregasCabRemoto.Next;
      end;
      QEntregasLin.Close;
      QEntregasCab.Close;
      QEntregasLinRemota.Close;
    end
    else
    begin
      ShowMessage('No hay entradas en el destino.');
    end;
    QEntregasCabRemoto.Close;
  end;

  if ( iOk + iError + iDuplicados ) > 0 then
  begin
    MostrarInforme( iOk, iError, iDuplicados, slErrores.Text );
  end;
  FreeAndNil( slErrores );
end;

procedure TFDRecepcionEntregas.MostrarInforme( const AOks, AErrores, ADuplicados: integer;
                                               const AMsgErrores: string );
var
  slAux: TStringList;
begin
  if ( AErrores + ADuplicados ) =  0 then
  begin
    ShowMessage('Recepcion de datos OK. ' + #13 + #10 +
                'Pasadas todas las entregas de un total de ' + IntToStr(AOks) );
  end
  else
  if AErrores = 0 then
  begin
    //HAY DUPLICADOS
    if AOks = 0 then
    begin
      //TODOS DUPLICADOS
      ShowMessage('Recepcion de datos innecesaria. ' + #13 + #10 +
                  'Todas las entregas estaban duplicadas (' + IntToStr(ADuplicados) + ')' );
    end
    else
    begin
      //HABIA ALGUN REGISTRO NUEVO
      ShowMessage('Recepcion de datos OK. ' + #13 + #10 +
                  'Pasadas ' + IntToStr(AOks) + ' entregas de ' + IntToStr(AOks+ADuplicados) + ' totales.' );
    end;
  end
  else
  begin
    //HAY ERRORES
    slAux:= TStringList.Create;
    slAux.Add( '');
    slAux.Add( '----------------------------------------------');
    slAux.Add( '- INFORME RECEPCIÓN DE ENTREGAS (' + DateToStr(Date) + ') -' );
    slAux.Add( '----------------------------------------------');
    slAux.Add( '');
    slAux.Add( 'PASADOS DUPLICADOS ERRONEOS   TOTAL');
    slAux.Add( '-----------------------------------');
    slAux.Add( Rellena( IntToStr( AOks ), 7, ' ',  taLeftJustify ) + ' ' +
             Rellena( IntToStr( ADuplicados ), 10, ' ',  taLeftJustify ) + ' ' +
             Rellena( IntToStr( AErrores ), 8, ' ',  taLeftJustify ) + ' ' +
             Rellena( IntToStr( AOks + ADuplicados + AErrores ), 7, ' ',  taLeftJustify ) );
    slAux.Add( '');

    slAux.Add( '-    ENTREGA MSG.ERROR');
    slAux.Add( AMsgErrores );
    slAux.Add( '');

    try
      slAux.SaveToFile( gsDirActual + '\temp\informe_recepcion_entregas.txt');
      WinExec( PChar( 'NOTEPAD ' + gsDirActual + '\temp\informe_recepcion_entregas.txt' ), SW_SHOWNORMAL);
    except
      ShowMessage( slAux.Text );
    end;
  end;

  FreeAndNil( slAux );
end;

procedure TFDRecepcionEntregas.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f2:btnEntregasPendientes.Click;
    vk_f1:btnOk.Click;
    vk_escape:btnCancel.Click;
  end;
end;

procedure TFDRecepcionEntregas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDRecepcionEntregas.btnEntregasPendientesClick(Sender: TObject);
begin
  if nomEmpresa.Caption = '' then
  begin
    ShowMessage('Código de empresa incorrecto.');
    empresa.SetFocus;
  end
  else
  if nomCentroLlegada.Caption = '' then
  begin
    ShowMessage('Código de centro incorrecto.');
    centroLlegada.SetFocus;
  end
  else
  begin
    DMRecepcionEntregasForm.EntregasPendientes( empresa.Text, centroLlegada.Text );
    if DMRecepcionEntregasForm.QEntregasPendientes.IsEmpty then
    begin
      ShowMessage('Sin entregas pendiendes de recibir.');
      eFactura.SetFocus;
    end
    else
    begin
      btnOk.Enabled:= False;
      btnCancel.Enabled:= False;
      dbgEntregasPendientes.Visible:= True;
      dbgEntregasPendientes.SetFocus;
      KeyPreview:= False;
    end;
  end;
end;

procedure TFDRecepcionEntregas.AceptarEntregaPendiente;
begin
  dbgEntregasPendientes.Visible:= False;
  with DMRecepcionEntregasForm.QEntregasPendientes do
  begin
    eFactura.Text:= FieldByName('fact_conduce').AsString;
    fechaCarga.Text:= FieldByName('fecha_carga').AsString;
  end;
  btnOk.Enabled:= true;
  btnCancel.Enabled:= true;
  eFactura.SetFocus;
  KeyPreview:= True;
end;

procedure TFDRecepcionEntregas.CancelarEntregaPendiente;
begin
  dbgEntregasPendientes.Visible:= False;
  btnOk.Enabled:= true;
  btnCancel.Enabled:= true;
  KeyPreview:= True;
end;

procedure TFDRecepcionEntregas.dbgEntregasPendientesDblClick(
  Sender: TObject);
begin
  AceptarEntregaPendiente;
end;

procedure TFDRecepcionEntregas.dbgEntregasPendientesExit(Sender: TObject);
begin
  CancelarEntregaPendiente;
end;

procedure TFDRecepcionEntregas.dbgEntregasPendientesKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_return, vk_f1:
    begin
      AceptarEntregaPendiente;
      key:= 0;
    end;
    vk_escape:
    begin
       CancelarEntregaPendiente;
       key:= 0;
    end;
  end;
end;

end.
