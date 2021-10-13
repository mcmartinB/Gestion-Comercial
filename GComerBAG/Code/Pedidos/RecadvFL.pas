unit RecadvFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, DB, Grids,
  DBGrids, Mask, DBCtrls;

type
  TFLRecadv = class(TForm)
    btnCerrar: TBitBtn;
    btnImportar: TBitBtn;
    btnBuscar: TBitBtn;
    DBGcab: TDBGrid;
    DSCab: TDataSource;
    DBGrid1: TDBGrid;
    DSLin: TDataSource;
    dbgAlbaran: TDBGrid;
    DSAlbaranDet: TDataSource;
    lblNombre1: TLabel;
    lblAlbaranPedido: TLabel;
    DSAlbaranCab: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DSObs: TDataSource;
    BitBtn1: TBitBtn;
    dbgCajasLogifruit: TDBGrid;
    DSCajasLogifruit: TDataSource;
    dbgPalets: TDBGrid;
    DSPalets: TDataSource;
    cbbVer: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBuscarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure cbbVerChange(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, UDMConfig,  RecadvFilterFL,
     RecadvDL, RecadvQL, RecadvImportarDL;

var
  FLRecadvFilter: TFLRecadvFilter;

procedure TFLRecadv.FormCreate(Sender: TObject);
begin
  DLRecadv:= TDLRecadv.Create( self );
  FLRecadvFilter:= TFLRecadvFilter.Create( self );

  DLRecadv.VisualizarRecepcion( '''VACIO''' );

  FormType:=tfOther;
  BHFormulario;
end;

procedure TFLRecadv.FormShow(Sender: TObject);
begin
  left:= 0;
  Top:= 0;
end;

procedure TFLRecadv.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil( DLRecadv );
  FreeAndNil( FLRecadvFilter );

  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLRecadv.btnCerrarClick(Sender: TObject);
begin
  if btnCerrar.Enabled then
    Close;
end;


procedure TFLRecadv.btnImportarClick(Sender: TObject);
var
  sCodeList, sMsg: string;
begin
  if btnImportar.Enabled then
  begin
    RecadvImportarDL.ImportarRecadv( self, sCodeList, sMsg );
    ShowMessage(sMsg);
    if sCodeList <> '' then
    begin
      DLRecadv.VisualizarRecepcion( sCodeList );
    end;
  end;
end;


procedure TFLRecadv.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImportar.Click;
    ord('L'):btnBuscar.Click;
  end;
end;

procedure TFLRecadv.btnBuscarClick(Sender: TObject);
begin
  if btnBuscar.Enabled then
  begin
    if FLRecadvFilter.Execute then
    begin
      //DLRecadv.VisualizarRecepcion( '' );
      DLRecadv.FiltrarRecepcion( FLRecadvFilter.sEmpresa, FLRecadvFilter.sAlbaran,
                                 FLRecadvFilter.sPedido, FLRecadvFilter.sMatricula,
                                 FLRecadvFilter.dFechaIni, FLRecadvFilter.dFechaFin );
    end;
  end
end;

procedure TFLRecadv.BitBtn1Click(Sender: TObject);
begin
  if not DLRecadv.QCab.IsEmpty then
  begin
    RecadvQL.VerListadoRecadv( self );
  end;
end;

procedure TFLRecadv.cbbVerChange(Sender: TObject);
begin
  if not DSCab.DataSet.IsEmpty then
  begin
    DLRecadv.VerDetalleRecadv( cbbVer.ItemIndex );
    dbgAlbaran.Visible:= cbbVer.ItemIndex = 0;
    dbgCajasLogifruit.Visible:= cbbVer.ItemIndex = 1;
    dbgPalets.Visible:= cbbVer.ItemIndex = 2;
  end;
end;

end.
