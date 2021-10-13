unit PaisesFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, Buttons, ActnList, BGrid,
  BSpeedButton, Grids, DBGrids, BGridButton, BDEdit, BCalendarButton, ComCtrls,
  BCalendario, BEdit, dbTables, DError, ToolWin, Menus;

const
   kConjuntoResultado = 1;
   kLocalizando = 2;
   kModificandoCab = 3;
   kInsertandoCab = 4;
   kBorrandoCab = 5;

type
  TFMPaises = class(TForm)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    TBBarraMaestroDetalle: TToolBar;
    btnLocalizar: TToolButton;
    btnModificarCab: TToolButton;
    btnBorrarCab: TToolButton;
    btnInsertarCab: TToolButton;
    TBMaestroDetalleSeparador3: TToolButton;
    btnImprimir: TToolButton;
    ToolButton4: TToolButton;
    btnPrimero: TToolButton;
    btnAnterior: TToolButton;
    btnSiguiente: TToolButton;
    btnUltimo: TToolButton;
    TBMaestroDetalleSeparador2: TToolButton;
    btnAceptar: TToolButton;
    btnCancelar: TToolButton;
    TBMaestroDetalleSeparador5: TToolButton;
    btnSalir: TToolButton;
    ALocalizar: TAction;
    ASalir: TAction;
    AAceptar: TAction;
    ACancelar: TAction;
    AInsertarCab: TAction;
    AModificarCab: TAction;
    ABorrarCab: TAction;
    APrimero: TAction;
    AAnterior: TAction;
    ASiguiente: TAction;
    AUltimo: TAction;
    ADespegable: TAction;
    AImprimir: TAction;
    PMaestro: TPanel;
    Label4: TLabel;
    btnMoneda: TBGridButton;
    Label10: TLabel;
    pais_p: TBDEdit;
    stMoneda: TStaticText;
    descripcion_p: TBDEdit;
    gridMaestro: TDBGrid;
    Label1: TLabel;
    moneda_p: TBDEdit;
    Label2: TLabel;
    original_name_p: TBDEdit;
    Label3: TLabel;
    comunitario_p: TDBCheckBox;
    BGrid1: TBGrid;
    lblFob: TLabel;
    fob_plataforma_p: TBDEdit;
    lblFob2: TLabel;
    procedure ALocalizarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ASalirExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AInsertarCabExecute(Sender: TObject);
    procedure ABorrarCabExecute(Sender: TObject);
    procedure APrimeroExecute(Sender: TObject);
    procedure AAnteriorExecute(Sender: TObject);
    procedure ASiguienteExecute(Sender: TObject);
    procedure AUltimoExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADespegableExecute(Sender: TObject);
    procedure AImprimirExecute(Sender: TObject);
    procedure DescripcionMaestro(Sender: TObject);
    procedure AModificarCabExecute(Sender: TObject);
    procedure gridMaestroDblClick(Sender: TObject);
  private
    { Private declarations }
    iEstado: integer;

    procedure PonEstado( const AEstado: Integer );
    procedure EstadoBotones( const AEnabled: boolean );
    procedure BotonesDesplazamiento( const AEnabled: boolean );

    procedure AceptarModificarCab;
    procedure CancelarModificarCab;

    procedure AceptarInsertarCab;
    procedure CancelarInsertarCab;

    procedure LimpiarDescripcionMaestro;

  public
    { Public declarations }

    //Listado

  end;

implementation

uses Principal, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CAuxiliarDB,CReportes,
     bSQLUtils, CVariables, PaisesDM, GetFiltroFM, SincronizacionBonny;

var
  FMGetFiltro: TFMGetFiltro;

{$R *.DFM}

procedure TFMPaises.FormCreate(Sender: TObject);
begin
  DMPaises:= TDMPaises.Create( self );
  PonEstado( kConjuntoResultado );
  DSMaestro.DataSet.Open;
  BHDeshabilitar;
  FPrincipal.HabilitarMenu(false);

  moneda_p.Tag := kmoneda;

  FMGetFiltro:= InicializarFiltro ( self );
  FMGetFiltro.Configurar('Filtrar Paises', 0);
  FMGetFiltro.AddChar('pais_p', 'Código', 2, False );
  FMGetFiltro.AddChar('descripcion_p', 'Nombre Español', 30, False );
  FMGetFiltro.AddChar('original_name_p', 'Nombre Original', 30, False );
  FMGetFiltro.AddChar('moneda_p', 'Moneda', 3, False );

  //FMGetFiltro.AddCampo('comunitario_p', 'Comunitario', itChekBox, 0, 0, False );
end;

procedure TFMPaises.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FinalizarFiltro( FMGetFiltro );

  DSMaestro.DataSet.Close;
  FreeAndNil( DMPaises );
  BHRestaurar;
  FPrincipal.HabilitarMenu(True);
  Action:= CaFree;
end;

procedure TFMPaises.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= iEstado = kConjuntoResultado;
end;

procedure TFMPaises.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMPaises.ADespegableExecute(Sender: TObject);
begin
  if moneda_p.Focused then
    DespliegaRejilla( btnMoneda );
end;

procedure TFMPaises.DescripcionMaestro(Sender: TObject);
begin
  if ( DSMaestro.DataSet.State = dsInsert ) or ( DSMaestro.DataSet.State = dsEdit ) then
  begin
    if moneda_p.Focused then
    begin
      stMoneda.Caption := desMoneda(moneda_p.Text);
    end;
  end
  else
  begin
    stMoneda.Caption := desMoneda(moneda_p.Text);
  end;
end;

procedure TFMPaises.LimpiarDescripcionMaestro;
begin
    stMOneda.Caption := '';
end;

procedure TFMPaises.EstadoBotones( const AEnabled: boolean );
var
  bDecision, bEnabled: boolean;
begin
  bEnabled:= AEnabled;
  bDecision:= ( iEstado = kConjuntoResultado );

  ALocalizar.Enabled:= bEnabled and bDecision;
  AInsertarCab.Enabled:= bEnabled and bDecision;
  AModificarCab.Enabled:= bEnabled and bDecision and not DSMaestro.DataSet.IsEmpty;
  ABorrarCab.Enabled:= bEnabled and bDecision and not DSMaestro.DataSet.IsEmpty;

  AImprimir.Enabled:= bEnabled and bDecision and not DSMaestro.DataSet.IsEmpty;

  BotonesDesplazamiento( bEnabled and bDecision );

  AAceptar.Enabled:= bEnabled and not bDecision;
  ACancelar.Enabled:= bEnabled and not bDecision;
  ASalir.Enabled:= bEnabled and bDecision;
  if bDecision then
  begin
    ACancelar.ShortCut:= 0;
    ASalir.ShortCut:= vk_escape;
  end
  else
  begin
    ACancelar.ShortCut:= vk_escape;
    ASalir.ShortCut:= 0;
  end;
end;

procedure TFMPaises.BotonesDesplazamiento( const AEnabled: boolean );
begin
  APrimero.Enabled:= AEnabled and not DSMaestro.DataSet.IsEmpty and not DSMaestro.DataSet.BOF;
  AAnterior.Enabled:= AEnabled and not DSMaestro.DataSet.IsEmpty and not DSMaestro.DataSet.BOF;
  ASiguiente.Enabled:= AEnabled and not DSMaestro.DataSet.IsEmpty and not DSMaestro.DataSet.EOF;
  AUltimo.Enabled:= AEnabled and not DSMaestro.DataSet.IsEmpty and not DSMaestro.DataSet.EOF;
end;

procedure TFMPaises.APrimeroExecute(Sender: TObject);
begin
  DSMaestro.DataSet.First;
  BotonesDesplazamiento( True );
end;

procedure TFMPaises.AAnteriorExecute(Sender: TObject);
begin
  DSMaestro.DataSet.Prior;
  BotonesDesplazamiento( True );
end;

procedure TFMPaises.ASiguienteExecute(Sender: TObject);
begin
  DSMaestro.DataSet.Next;
  BotonesDesplazamiento( True );
end;

procedure TFMPaises.AUltimoExecute(Sender: TObject);
begin
  DSMaestro.DataSet.Last;
  BotonesDesplazamiento( True );
end;

procedure TFMPaises.PonEstado( const AEstado: Integer );
begin
  case AEstado of
    kConjuntoResultado:
    begin
      PMaestro.Visible:= False;
      gridMaestro.Enabled:= True;
    end;
    kLocalizando, kModificandoCab, kInsertandoCab:
    begin
      PMaestro.Visible:= True;
      gridMaestro.Enabled:= False;

      pais_p.SetFocus;
    end;
    kBorrandoCab:
    begin
      //Nada
    end;
  end;
  iEstado:= AEstado;
  EstadoBotones( true );
end;

procedure TFMPaises.ASalirExecute(Sender: TObject);
begin
  Close;
end;

procedure TFMPaises.AAceptarExecute(Sender: TObject);
begin
  case iEstado of
    kLocalizando, kBorrandoCab:
    begin
      //Nada;
    end;
    kModificandoCab:
    begin
      AceptarModificarCab;
    end;
    kInsertandoCab:
    begin
      AceptarInsertarCab;
    end;
  end;
end;

procedure TFMPaises.ACancelarExecute(Sender: TObject);
begin
  case iEstado of
    kLocalizando, kBorrandoCab:
    begin
      //Nada
    end;
    kModificandoCab:
    begin
      CancelarModificarCab;
    end;
    kInsertandoCab:
    begin
      CancelarInsertarCab;
    end;
  end;
end;


procedure TFMPaises.ALocalizarExecute(Sender: TObject);
var
  sFiltro: string;
begin
 sFiltro:= '';
 if FMGetFiltro.Filtro( sFiltro ) then
 begin
   try
     DMPaises.Localizar( sFiltro );
   except
     on E: exception do
     begin
       DSMaestro.DataSet.Cancel;
     end;
   end;
 end;
 PonEstado( kConjuntoResultado );
end;

procedure TFMPaises.ABorrarCabExecute(Sender: TObject);
var
  paisId: String;
begin
  if MessageDlg('¿Desea borrar la ficha seleccionada?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    paisId := DSMaestro.DataSet.FieldByName('pais_p').asString;
    DSMaestro.DataSet.Delete;
    PonEstado( kConjuntoResultado );
    SincroBonnyAurora.SincronizarPais(PaisId);
    SincroBonnyAurora.Sincronizar;
  end;
end;

procedure TFMPaises.AModificarCabExecute(Sender: TObject);
begin
  try
    DSMaestro.DataSet.Edit;
    PonEstado( kModificandoCab );
  except
    DSMaestro.DataSet.Cancel;
    PonEstado( kConjuntoResultado );
    raise;
  end;
end;

procedure TFMPaises.AceptarModificarCab;
begin
  DSMaestro.DataSet.Post;
  PonEstado( kConjuntoResultado );

  SincroBonnyAurora.SincronizarPais(DSMaestro.DataSet.FieldByName('pais_p').asString);
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMPaises.CancelarModificarCab;
begin
  DSMaestro.DataSet.Cancel;
  PonEstado( kConjuntoResultado );
end;

procedure TFMPaises.AInsertarCabExecute(Sender: TObject);
begin
  try
    DSMaestro.DataSet.Insert;
    PonEstado( kInsertandoCab );
    LimpiarDescripcionMaestro;
  except
    DSMaestro.DataSet.Cancel;
    PonEstado( kConjuntoResultado );
    raise;
  end;
end;

procedure TFMPaises.AceptarInsertarCab;
begin
  DSMaestro.DataSet.Post;
  PonEstado( kConjuntoResultado );

  SincroBonnyAurora.SincronizarPais(DSMaestro.DataSet.FieldByName('pais_p').asString);
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMPaises.CancelarInsertarCab;
begin
  DSMaestro.DataSet.Cancel;
  PonEstado( kConjuntoResultado );
end;

procedure TFMPaises.AImprimirExecute(Sender: TObject);
begin
  DMPaises.VisualizarListado( '' );
end;

procedure TFMPaises.gridMaestroDblClick(Sender: TObject);
begin
  if not DSMaestro.DataSet.IsEmpty then
  begin
    AModificarCab.Execute;
  end;
end;

end.
