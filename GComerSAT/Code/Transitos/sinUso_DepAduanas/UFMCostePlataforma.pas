unit UFMCostePlataforma;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, BCalendario, Buttons, BSpeedButton, BCalendarButton,
  StdCtrls, BEdit, DB, Grids, DBGrids, ExtCtrls;

type
  TFMCostePlataforma = class(TForm)
    lblFecha: TLabel;
    edtFecha: TBEdit;
    btnFecha: TBCalendarButton;
    lblTransito: TLabel;
    edtMatricula: TBEdit;
    CalendarioFlotante: TBCalendario;
    dbgSalidasDeposito: TDBGrid;
    DSSalidasDeposito: TDataSource;
    btnSalidas: TButton;
    lblFactura: TLabel;
    edtFactura: TBEdit;
    lblImporte: TLabel;
    edtImporte: TBEdit;
    dbgSalidas: TDBGrid;
    DSSalidas: TDataSource;
    btnAlta: TButton;
    DSCostePlataforma: TDataSource;
    dbgCostePlataforma: TDBGrid;
    btnAplicar: TButton;
    btnCancelar: TButton;
    btnCerrar: TButton;
    bvl1: TBevel;
    lbl1: TLabel;
    lblSalidasDeposito: TLabel;
    lbl3: TLabel;
    btnTransitos: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnFechaClick(Sender: TObject);
    procedure btnSalidasClick(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnAltaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAplicarClick(Sender: TObject);
    procedure dbgSalidasDepositoDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgSalidasCellClick(Column: TColumn);
    procedure dbgSalidasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgSalidasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnTransitosClick(Sender: TObject);
  private
    { Private declarations }
    sFactura: string;
    rImporte: Extended;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CAuxiliarDB,
  UDMCostePlataforma;

var
  FMCostePlataforma: TFMCostePlataforma;


procedure TFMCostePlataforma.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFMCostePlataforma.FormDestroy(Sender: TObject);
begin
  FreeAndNil( DMCostePlataforma );
end;

procedure TFMCostePlataforma.FormCreate(Sender: TObject);
begin
  DMCostePlataforma:= TDMCostePlataforma.Create( self );

  edtFecha.Text:= DateToStr( Date );
  CalendarioFlotante.Date:= Date;
  edtMatricula.Text:= '';

  (*
  edtFecha.Text:= '17/11/2010';
  edtMatricula.Text:= '1731';
  *)
end;

procedure TFMCostePlataforma.btnFechaClick(Sender: TObject);
begin
  DespliegaCalendario( btnFecha );
end;

procedure TFMCostePlataforma.btnSalidasClick(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if TryStrToDate( edtFecha.Text, dFecha ) then
    DMCostePlataforma.BuscarSalidas( dFecha, edtMatricula.Text );
end;

procedure TFMCostePlataforma.btnTransitosClick(Sender: TObject);
var
  dFecha: TDateTime;
begin
  (*
  if TryStrToDate( edtFecha.Text, dFecha ) then
    DMCostePlataforma.BuscarTransitos( dFecha, edtMatricula.Text );
  *)
end;

procedure TFMCostePlataforma.btnCerrarClick(Sender: TObject);
begin
  if DMCostePlataforma.Puedosalir then
  begin
    Close;
  end
  else
  begin
    ShowMessage('Antes de cerrar aplique o cancele los cambios pendientes.');
  end;
end;

procedure TFMCostePlataforma.btnAltaClick(Sender: TObject);
var
  rKilosCamion, rKilosDeposito, rImporteDeposito: real;
begin
  if edtFactura.Text = '' then
  begin
    ShowMessage('Falta el código de la factura.');
  end
  else
  begin
    sFactura:= edtFactura.Text;
    if TryStrToFloat( edtImporte.Text, rImporte ) then
    begin
      if DMCostePlataforma.AltaLineas( sFactura, rImporte, rKilosCamion, rKilosDeposito, rImporteDeposito ) then
      begin
        lblSalidasDeposito.Caption:= 'SALIDAS DEPOSITO MODIFICADAS   ' +
                                     'Camion ' + FormatFloat( '#,##0.00', rKilosCamion ) + 'Kgs' +
                                     ' -- Deposito ' + FormatFloat( '#,##0.00', rKilosDeposito ) + 'Kgs' +
                                     ' / ' + FormatFloat( '#,##0.00', rImporteDeposito ) + 'Eur';
        edtFactura.Enabled:= False;
        edtImporte.Enabled:= False;
      end;
    end
    else
    begin
      ShowMessage('Falta el importe de la factura o es incorrecto.');
    end;
  end;
end;

procedure TFMCostePlataforma.btnCancelarClick(Sender: TObject);
begin
  DMCostePlataforma.Cancelar;
  edtFactura.Enabled:= True;
  edtImporte.Enabled:= True;
  lblSalidasDeposito.Caption:= 'SALIDAS DEPOSITO MODIFICADAS   ';
end;

procedure TFMCostePlataforma.btnAplicarClick(Sender: TObject);
begin
  if DMCostePlataforma.Aplicar then
  begin
    ShowMessage('Asignación del coste de la platforma correcta.' );
    edtFactura.Enabled:= True;
    edtImporte.Enabled:= True;
    lblSalidasDeposito.Caption:= 'SALIDAS DEPOSITO MODIFICADAS   ';
  end;
end;

procedure TFMCostePlataforma.dbgSalidasDepositoDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  grid : TDBGrid;
begin
  grid := sender as TDBGrid;
  begin
    if ( grid.DataSource.DataSet.FieldByname('albaran').AsString =
         dbgSalidas.DataSource.DataSet.FieldByname('albaran').AsString ) and
         not grid.DataSource.DataSet.IsEmpty then
    begin
      grid.Canvas.Font.Color := clGreen;
      grid.Canvas.Font.Style := grid.Canvas.Font.Style + [fsBold] + [fsItalic];
    end;
  end;

  grid.DefaultDrawColumnCell(Rect, DataCol, Column, State) ;
end;

procedure TFMCostePlataforma.dbgSalidasCellClick(Column: TColumn);
begin
  dbgSalidasDeposito.Refresh;
end;

procedure TFMCostePlataforma.dbgSalidasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  dbgSalidasDeposito.Refresh;
end;

procedure TFMCostePlataforma.dbgSalidasDrawColumnCell(Sender: TObject;
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
  grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
