unit RecadvFM;

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
  kModificandoDet = 6;
  kInsertandoDet = 7;
  kBorrandoDet = 8;

type
  TFMRecadv = class(TForm)
    DSMaestro: TDataSource;
    actlstRecadv: TActionList;
    TBBarraMaestroDetalle: TToolBar;
    btnLocalizar: TToolButton;
    TBMaestroDetalleSeparador1: TToolButton;
    btnImprimir: TToolButton;
    btnSepImprimir: TToolButton;
    btnPrimero: TToolButton;
    btnAnterior: TToolButton;
    btnSiguiente: TToolButton;
    btnUltimo: TToolButton;
    TBMaestroDetalleSeparador2: TToolButton;
    btnSalir: TToolButton;
    DSDetalle: TDataSource;
    ALocalizar: TAction;
    ASalir: TAction;
    APrimero: TAction;
    AAnterior: TAction;
    ASiguiente: TAction;
    AUltimo: TAction;
    AImprimir: TAction;
    pgControl: TPageControl;
    tsFicha: TTabSheet;
    tsBusqueda: TTabSheet;
    PMaestro: TPanel;
    lblCodigo: TLabel;
    lblConfirmacion: TLabel;
    lblFechaDocumento: TLabel;
    lblFechaRecepcion: TLabel;
    lblDestino: TLabel;
    lblOrigen: TLabel;
    edtidcab_ecr: TBDEdit;
    edtnumcon_ecr: TBDEdit;
    edtfuncion_ecr: TBDEdit;
    edttipo_ecr: TBDEdit;
    edtproveedor_ecr: TBDEdit;
    edtorigen_ecr: TBDEdit;
    edtnumped_ecr: TBDEdit;
    PDetalle: TPanel;
    dbgBusqueda: TDBGrid;
    lblFacturarA: TLabel;
    edtaqsfac_ecr: TBDEdit;
    lblTipo: TLabel;
    edtfecdoc_ecr: TBDEdit;
    lblFuncion: TLabel;
    edtdestino_ecr: TBDEdit;
    lblProveedor: TLabel;
    lblAlbaran: TLabel;
    lblPedido: TLabel;
    lblFechaCarga: TLabel;
    lblmatricula: TLabel;
    edtfecrec_ecr: TBDEdit;
    edtfcarga_ecr: TBDEdit;
    storigen_ecr: TStaticText;
    edtnumalb_ecr: TBDEdit;
    edtmatric_ecr: TBDEdit;
    stdestino_ecr: TStaticText;
    DSCantidades: TDataSource;
    dbgDetalle: TDBGrid;
    pnlLineas: TPanel;
    DSObservaciones: TDataSource;
    sttipo_ecr: TStaticText;
    stfuncion_ecr: TStaticText;
    stproveedor_ecr: TStaticText;
    staqsfac_ecr: TStaticText;
    pnlVerDetalle: TPanel;
    cbbVerDetalle: TComboBox;
    pgcControl: TPageControl;
    tsNotas: TTabSheet;
    tsAlbaran: TTabSheet;
    dbgObservaciones: TDBGrid;
    dbgCantidades: TDBGrid;
    dbgAlbaran: TDBGrid;
    DSAlbaranDet: TDataSource;
    procedure ALocalizarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure APrimeroExecute(Sender: TObject);
    procedure AAnteriorExecute(Sender: TObject);
    procedure ASiguienteExecute(Sender: TObject);
    procedure AUltimoExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AImprimirExecute(Sender: TObject);
    procedure dbgBusquedaDblClick(Sender: TObject);
    procedure tsBusquedaShow(Sender: TObject);
    procedure tsFichaShow(Sender: TObject);
    procedure ASalirExecute(Sender: TObject);
    procedure edttipo_ecrChange(Sender: TObject);
    procedure edtfuncion_ecrChange(Sender: TObject);
    procedure edtorigen_ecrChange(Sender: TObject);
    procedure edtproveedor_ecrChange(Sender: TObject);
    procedure edtdestino_ecrChange(Sender: TObject);
    procedure edtaqsfac_ecrChange(Sender: TObject);
    procedure cbbVerDetalleChange(Sender: TObject);
    procedure pgcControlChange(Sender: TObject);
  private
    { Private declarations }
    bFicha: Boolean;

    procedure EstadoBotones(const AEnabled: boolean);
    procedure BotonesDesplazamiento(const AEnabled: boolean);

  public
    { Public declarations }

    //Listado

  end;

implementation

uses Principal, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CAuxiliarDB,
     CReportes, bSQLUtils, RecadvDM, GetFiltroFM, CVariables, Recadv_QL;

{$R *.DFM}

var
  FMGetFiltro: TFMGetFiltro;

procedure TFMRecadv.FormCreate(Sender: TObject);
begin
  Top := 1;
  bFicha:= True;
  pgControl.ActivePage := tsFicha;
  DMRecadv := TDMRecadv.Create(self);
  DSMaestro.DataSet:= DMRecadv.QMaestro;
  DSDetalle.DataSet:= DMRecadv.QDetalle;
  DSMaestro.DataSet.Open;

  //PonEstado(kConjuntoResultado);
  BHDeshabilitar;
  FPrincipal.HabilitarMenu(false);

  FMGetFiltro := InicializarFiltro(self);
  FMGetFiltro.Configurar('Filtrar Recadv', 0);
  FMGetFiltro.AddChar('empresa_ecr', 'Empresa', 3, False);
  FMGetFiltro.AddChar('idcab_ecr', 'Código', 10, False);
  FMGetFiltro.AddChar('numalb_ecr', 'Albarán', 30, False);
  FMGetFiltro.AddInteger('fcarga_ecr', 'Fecha Carga', 3, False);
  FMGetFiltro.AddChar('numped_ecr', 'Pedido', 3, False);

  DMRecadv.CambiarSubDetalle( pgcControl.ActivePageIndex );
end;

procedure TFMRecadv.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DSMaestro.DataSet.Close;
  FreeAndNil(DMRecadv);
  BHRestaurar;
  FPrincipal.HabilitarMenu(True);
  FinalizarFiltro(FMGetFiltro);

  Action := CaFree;
end;

procedure TFMRecadv.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMRecadv.EstadoBotones(const AEnabled: boolean);
var
  bEnabled: boolean;
begin
  bEnabled := AEnabled;
  ALocalizar.Enabled := bEnabled;
  AImprimir.Enabled := bEnabled and not DSMaestro.DataSet.IsEmpty;
  BotonesDesplazamiento(bEnabled and bFicha);
  ASalir.Enabled := bEnabled;
end;

procedure TFMRecadv.BotonesDesplazamiento(const AEnabled: boolean);
begin
  APrimero.Enabled := AEnabled and not DSMaestro.DataSet.IsEmpty and not
    DSMaestro.DataSet.BOF;
  AAnterior.Enabled := AEnabled and not DSMaestro.DataSet.IsEmpty and not
    DSMaestro.DataSet.BOF;
  ASiguiente.Enabled := AEnabled and not DSMaestro.DataSet.IsEmpty and not
    DSMaestro.DataSet.EOF;
  AUltimo.Enabled := AEnabled and not DSMaestro.DataSet.IsEmpty and not
    DSMaestro.DataSet.EOF;
end;

procedure TFMRecadv.tsBusquedaShow(Sender: TObject);
begin
  bFicha:= False;
  EstadoBotones(True);
end;

procedure TFMRecadv.tsFichaShow(Sender: TObject);
begin
  bFicha:= True;
  EstadoBotones(True);
end;

procedure TFMRecadv.APrimeroExecute(Sender: TObject);
begin
  DSMaestro.DataSet.First;
  BotonesDesplazamiento(True);
end;

procedure TFMRecadv.AAnteriorExecute(Sender: TObject);
begin
  DSMaestro.DataSet.Prior;
  BotonesDesplazamiento(True);
end;

procedure TFMRecadv.ASiguienteExecute(Sender: TObject);
begin
  DSMaestro.DataSet.Next;
  BotonesDesplazamiento(True);
end;

procedure TFMRecadv.AUltimoExecute(Sender: TObject);
begin
  DSMaestro.DataSet.Last;
  BotonesDesplazamiento(True);
end;

procedure TFMRecadv.ALocalizarExecute(Sender: TObject);
var
  sFiltro: string;
begin
  sFiltro := '';
  if FMGetFiltro.Filtro(sFiltro) then
  begin
    DMRecadv.Localizar( sFiltro );
    //PonEstado( kConjuntoResultado );
    pgControl.ActivePage:= tsBusqueda;
  end;
end;

procedure TFMRecadv.AImprimirExecute(Sender: TObject);
begin
  VerFichaRecadv( SELF, edtidcab_ecr.Text );
end;

procedure TFMRecadv.dbgBusquedaDblClick(Sender: TObject);
begin
  pgControl.ActivePage := tsFicha;
end;

procedure TFMRecadv.ASalirExecute(Sender: TObject);
begin
  Close;
end;

procedure TFMRecadv.edttipo_ecrChange(Sender: TObject);
begin
  sttipo_ecr.Caption:= GetTipo( edttipo_ecr.Text );
end;

procedure TFMRecadv.edtfuncion_ecrChange(Sender: TObject);
begin
  stfuncion_ecr.Caption:= GetFuncion( edtfuncion_ecr.Text);
end;

procedure TFMRecadv.edtorigen_ecrChange(Sender: TObject);
begin
  storigen_ecr.Caption:= DMRecadv.DesOrigen( edtorigen_ecr.Text );
end;

procedure TFMRecadv.edtproveedor_ecrChange(Sender: TObject);
begin
  stproveedor_ecr.Caption:= DMRecadv.DesProveedor( edtproveedor_ecr.Text );
end;

procedure TFMRecadv.edtdestino_ecrChange(Sender: TObject);
begin
  stdestino_ecr.Caption:= DMRecadv.DesProveedor( edtdestino_ecr.Text );
end;

procedure TFMRecadv.edtaqsfac_ecrChange(Sender: TObject);
begin
  staqsfac_ecr.Caption:= DMRecadv.DesFacturarA( edtaqsfac_ecr.Text );
end;

procedure TFMRecadv.cbbVerDetalleChange(Sender: TObject);
begin
  DMRecadv.AplicaFiltroDetalle( cbbVerDetalle.ItemIndex );
end;

procedure TFMRecadv.pgcControlChange(Sender: TObject);
begin
  DMRecadv.CambiarSubDetalle( pgcControl.ActivePageIndex );
end;

end.
