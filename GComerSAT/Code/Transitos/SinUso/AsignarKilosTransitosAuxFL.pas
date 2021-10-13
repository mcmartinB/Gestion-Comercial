unit AsignarKilosTransitosAuxFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils;

type
  TFLAsignarKilosTransitosAux = class(TForm)
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    pSuperior: TPanel;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    pCentral: TPanel;
    lblNombre1: TLabel;
    btnEmpresa: TBGridButton;
    Desde: TLabel;
    btnFechaDesde: TBCalendarButton;
    lblNombre3: TLabel;
    lblNombre4: TLabel;
    btnCentro: TBGridButton;
    eEmpresa: TBEdit;
    lEmpresa: TStaticText;
    eFecha: TBEdit;
    eReferencia: TBEdit;
    eCentro: TBEdit;
    lCentro: TStaticText;
    pInferior: TPanel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    function CamposVacios: boolean;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private

    function CantidadKilosOk( var AAsignar: boolean ): boolean;
  public
    bAceptar: boolean;
  end;

  function ExecuteAsignarKilos( const AOwner: TComponent;
                                const AEmpresa, ACentro: string;
                                const AFecha: TDateTime;
                                const ATransito: Integer ): boolean;

implementation

uses UDMAuxDB, Principal, CVariables, CAuxiliarDB, UDMBaseDatos,
  AsignarKilosTransitosDL;

{$R *.DFM}

function ExecuteAsignarKilos( const AOwner: TComponent; const AEmpresa, ACentro: string;
                              const AFecha: TDateTime; const ATransito: Integer ): boolean;
var
  FLAsignarKilosTransitosAux: TFLAsignarKilosTransitosAux;
begin
  FLAsignarKilosTransitosAux:= TFLAsignarKilosTransitosAux.Create( AOwner );
  try
    if AOwner is TForm then
    begin
      ShowWindow(TForm(AOwner).Handle, SW_HIDE);
      //CGestionPrincipal.BHDeshabilitar;
    end;

    FLAsignarKilosTransitosAux.eEmpresa.Text:= AEmpresa;
    FLAsignarKilosTransitosAux.eCentro.Text:= ACentro;
    FLAsignarKilosTransitosAux.eFecha.Text:= DateToStr( AFecha );
    FLAsignarKilosTransitosAux.eReferencia.Text:= IntToStr( ATransito );

    with DLAsignarKilosTransitos.QTransitoPendiente do
    begin
      ParamByName('empresa_tc').AsString:= AEmpresa;
      ParamByName('centro_tc').AsString:= ACentro;
      ParamByName('fecha_tc').AsDateTime:= AFecha;
      ParamByName('referencia_tc').AsInteger:= ATransito;
      Open;
    end;

    DLAsignarKilosTransitos.QDetalleTransito.Open;
    DLAsignarKilosTransitos.QSalidasTransito.Open;
    DLAsignarKilosTransitos.QSalidasPendiente.Open;
    DLAsignarKilosTransitos.tProductoPendiente.Open;

    FLAsignarKilosTransitosAux.ShowModal;
    result:= FLAsignarKilosTransitosAux.bAceptar;

  finally
    DLAsignarKilosTransitos.tProductoPendiente.Close;
    DLAsignarKilosTransitos.QDetalleTransito.Close;
    DLAsignarKilosTransitos.QSalidasTransito.Close;
    DLAsignarKilosTransitos.QSalidasPendiente.Close;
    DLAsignarKilosTransitos.QTransitoPendiente.Close;

    FreeAndNil( FLAsignarKilosTransitosAux );

    if AOwner is TForm then
    begin
      ShowWindow(TForm(AOwner).Handle, SW_SHOW);
      //CGestionPrincipal.BHRestaurar;
    end;
  end;
end;

//                          **** FORMULARIO ****

procedure TFLAsignarKilosTransitosAux.FormCreate(Sender: TObject);
begin
  bAceptar:= false;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;
  CalendarioFlotante.Date := Date - 1;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eFecha.Tag := kCalendar;

  PonNombre( eEmpresa );
  PonNombre( eCentro );

  AsignarKilosTransitosDL.CrearModuloDatos( self );
end;

procedure TFLAsignarKilosTransitosAux.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  AsignarKilosTransitosDL.DestruirModuloDatos;

  gRF := nil;
  gCF := nil;
  Action := caHide;
end;

procedure TFLAsignarKilosTransitosAux.FormKeyDown(Sender: TObject; var Key: Word;
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
    vk_f1:
      begin
        Key := 0;
        btnAceptar.Click;
      end;
  end;
end;

procedure TFLAsignarKilosTransitosAux.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        Key := 0;
        btnCancelar.Click;
      end;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLAsignarKilosTransitosAux.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro,[eEmpresa.Text]);
    kCalendar: DespliegaCalendario(btnFechaDesde);
  end;
end;

procedure TFLAsignarKilosTransitosAux.PonNombre(Sender: TObject);
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
      lEmpresa.Caption := desEmpresa(eEmpresa.Text);
    end;
    kCentro:
    begin
      lCentro.Caption := desCentro(eEmpresa.Text, eCentro.Text );
    end;
  end;
end;

function TFLAsignarKilosTransitosAux.CamposVacios: boolean;
var
  dIni: TDateTime;
begin
        //Comprobamos que los campos esten todos con datos
  if lEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto');
    //EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if ECentro.Text = '' then
  begin
    ShowError('Falta el código del centro o es incorrecto');
    //ECentro.SetFocus;
    Result := True;
    Exit;
  end;

  if eReferencia.Text = '' then
  begin
    ShowError('Falta la referencia del tránsito o es incorrecta');
    //eReferencia.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDate( eFecha.Text, dIni ) then
  begin
    ShowError('Falta la fecha o es incorrecta.');
    //eFecha.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;

procedure TFLAsignarKilosTransitosAux.btnCancelarClick(Sender: TObject);
begin
  ShowMessage('Operación cancelada');
  bAceptar:= False;
  Close;
end;

procedure TFLAsignarKilosTransitosAux.btnAceptarClick(Sender: TObject);
var
  bAsignar: boolean;
  rKilos: real;
begin
  if CantidadKilosOk ( bAsignar ) then
  begin
    if bAsignar then
    begin
      bAceptar:= True;
      with DLAsignarKilosTransitos do
      begin
        tProductoPendiente.First;
        while not tProductoPendiente.Eof do
        begin
          rKilos:= tProductoPendiente.FieldByName('kilos').AsFloat;
          (*TODO*)
          if not AsignarKilosTransito(
              QTransitoPendiente.FieldByName('empresa_tc').AsString,
              QTransitoPendiente.FieldByName('centro_tc').AsString,
              QTransitoPendiente.FieldByName('centro_destino_tc').AsString,
              'Origen',
              QTransitoPendiente.FieldByName('fecha_tc').AsDateTime,
              QTransitoPendiente.FieldByName('referencia_tc').AsInteger,
              tProductoPendiente.FieldByName('producto').AsString, rKilos ) then
          begin
            ShowMessage('No se han podido asignar todos los kilos de producto "' +
                        tProductoPendiente.FieldByName('producto').AsString + '"' );
            bAceptar:= False;
          end;
          tProductoPendiente.Next;
        end;
      end;
    end;
  end
  else
  begin
    ShowMessage('No hay suficientes salidas para asignar todos los kilos del tránsito.');
    bAceptar:= False;
  end;
  Close;
end;

function TFLAsignarKilosTransitosAux.CantidadKilosOk( var AAsignar: boolean ): boolean;
var
  sProducto: string;
  rKilos, rKilosAux: Real;
  bCompleto: Boolean;
  slFalta: TStringList;
begin
  slFalta:= TStringList.Create;
  with DLAsignarKilosTransitos do
  begin
    if not QDetalleTransito.IsEmpty then
    begin
      bCompleto:= True;
      QDetalleTransito.First;
      QSalidasTransito.First;

      while not QDetalleTransito.Eof do
      begin
        sProducto:= QDetalleTransito.FieldByName('producto').AsString;

        rKilos:= QDetalleTransito.FieldByName('kilos').AsFloat;

        //Kilos y asignados
        while ( not QSalidasTransito.Eof ) and ( sProducto <> QSalidasTransito.FieldByName('producto').AsString ) do
        begin
          QSalidasTransito.Next;
        end;
        if sProducto = QSalidasTransito.FieldByName('producto').AsString then
        begin
          rKilos:= rKilos - QSalidasTransito.FieldByName('kilos').AsFloat;
        end;
        if rKilos <> 0 then
        begin
          bCompleto:= False;
          //rKilosAux son los kilos que me quedan por asignar
          rKilosAux:= rKilos;

          while ( not QSalidasPendiente.Eof ) and ( sProducto <> QSalidasPendiente.FieldByName('producto').AsString ) do
          begin
            QSalidasPendiente.Next;
          end;
          if sProducto = QSalidasPendiente.FieldByName('producto').AsString then
          begin
            rKilos:= rKilos - QSalidasPendiente.FieldByName('kilos').AsFloat;
          end;
        end
        else
        begin
          rKilosAux:= 0;
        end;

        if rKilos > 0 then
        begin
          //No tengo suficientes kilos
          slFalta.Add( sProducto + ' -> ' + FormatFloat( '#,##0.00', rKilos ) );
        end
        else
        if ( rKilos <= 0 ) and ( rKilosAux <> 0 )then
        begin
          //Almaceno los kilos pendientes
          tProductoPendiente.Insert;
          tProductoPendiente.FieldByName('producto').AsString:= sProducto;
          tProductoPendiente.FieldByName('kilos').AsFloat:= rKilosAux;
          tProductoPendiente.Open;
        end;
        QDetalleTransito.Next;
      end;

      if bCompleto then
      begin
        ShowMessage('Este tránsito ya estaba asignado completamente.');
        AAsignar:= False;
        Result:= True;
      end
      else
      begin
        if Trim( slFalta.Text ) <> '' then
        begin
          ShowMessage( 'No hay suficientes kilos para poder asignar el tránsito completamente.'  + #13 + #10 +
                       'FALTAN:'  + #13 + #10 + slFalta.Text );
          AAsignar:= False;
          Result:= False;
        end
        else
        begin
          //Todo OK
          AAsignar:= True;
          Result:= True;
        end;
      end;
    end
    else
    begin
      ShowMessage('Tránsito sin líneas de producto');
      AAsignar:= False;
      Result:= False;
    end
  end;
  FreeAndNil( slFalta );
end;

end.
