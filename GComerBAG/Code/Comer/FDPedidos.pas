unit FDPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons;

type
  TfrmDPedidos = class(TForm)
    DBGrid: TDBGrid;
    Query: TQuery;
    DataSource: TDataSource;
    edtFiltro: TEdit;
    btnFiltrar: TSpeedButton;
    Label1: TLabel;
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFiltrarClick(Sender: TObject);
    procedure edtFiltroKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    procedure FiltrarPedidos;
  public
    { Public declarations }
    bFlag: boolean;
    sEmpresa: string;
  end;

  procedure InicializaModulo( const ABaseDatos: string );
  procedure FinalizaModulo;


  function SeleccionaPedido( const AForm: TForm; const AControl: TControl;
                             const AEmpresa, AFecha: string;
                             var   VEmpresa, VCentro, VCliente, VSuministro, VPedido, VFecha: string ): Boolean;

implementation

{$R *.dfm}

var
  frmDPedidos: TfrmDPedidos;

procedure InicializaModulo( const ABaseDatos: string );
begin
  frmDPedidos:= TfrmDPedidos.Create( Application );
  frmDPedidos.Query.DatabaseName:= ABaseDatos;
end;

procedure FinalizaModulo;
begin
  FreeAndNil( frmDPedidos );
end;

function SeleccionaPedido( const AForm: TForm; const AControl: TControl;
                           const AEmpresa, AFecha: string;
                           var   VEmpresa, VCentro, VCliente, VSuministro, VPedido, VFecha: string ): Boolean;
begin
  frmDPedidos:= TfrmDPedidos.Create( AForm );

  frmDPedidos.Left:= AControl.ClientOrigin.X;
  frmDPedidos.Top:= AControl.ClientOrigin.Y + AControl.Height;

  frmDPedidos.sEmpresa:= AEmpresa;
  frmDPedidos.edtFiltro.Text:= AFecha;
  frmDPedidos.FiltrarPedidos;

  try
    frmDPedidos.ShowModal;
    result:= frmDPedidos.bFlag;
    if result then
    begin
      VEmpresa:= frmDPedidos.Query.Fields[0].AsString;
      VCentro:= frmDPedidos.Query.Fields[1].AsString;
      VCliente:= frmDPedidos.Query.Fields[2].AsString;
      VSuministro:= frmDPedidos.Query.Fields[3].AsString;
      VPedido:= frmDPedidos.Query.Fields[4].AsString;
      VFecha:= frmDPedidos.Query.Fields[5].AsString;
    end;
  finally
    FreeAndNil( frmDPedidos );
  end;
end;


procedure TfrmDPedidos.DBGridDblClick(Sender: TObject);
begin
  bFlag:= True;
  Close;
end;

procedure TfrmDPedidos.FormShow(Sender: TObject);
begin
  bFlag:= False;
end;

procedure TfrmDPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TfrmDPedidos.FiltrarPedidos;
var
  aFecha: TDatetime;
begin
  with frmDPedidos.Query do
  begin
    DisableControls;
    Close;
    SQL.Clear;

    SQL.Add(' select DISTINCT empresa_pdc Empresa, centro_pdc Centro, cliente_pdc Cliente, ');
    SQL.Add('        dir_suministro_pdc suministro, ref_pedido_pdc Pedido, fecha_pdc Fecha ');
    SQL.Add(' from frf_pedido_cab ');
    if Trim(sEmpresa) <> '' then
    begin
      SQL.Add('WHERE empresa_pdc = :empresa ');
      if Length( edtFiltro.Text ) = 10 then
      begin
        if TryStrToDate( edtFiltro.Text, aFecha ) then
        begin
          SQL.Add('and  fecha_pdc = ' + QuotedStr( edtFiltro.Text ) );
        end
        else
        begin
          ShowMessage('Fecha incorrecta.');
        end;
      end;
      ParamByName('empresa').AsString:= sEmpresa;
    end
    else
    if Length( edtFiltro.Text ) = 10 then
    begin
      if TryStrToDate( edtFiltro.Text, aFecha ) then
      begin
        SQL.Add('Where fecha_pdc = ' + QuotedStr( edtFiltro.Text ) );
      end
      else
      begin
        ShowMessage('Fecha incorrecta.');
      end;
    end;

    SQL.Add('ORDER BY empresa_pdc, centro_pdc, cliente_pdc, dir_suministro_pdc, ref_pedido_pdc ');
    try
      Open;
    finally
      EnableControls;
    end;
  end;
end;

procedure TfrmDPedidos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_return:
      begin
        bFlag:= True;
        Close;
      end;
    vk_escape:
      begin
        Close;
      end;
    vk_f2:
      begin
        btnFiltrar.Click;
      end;
  end;
end;

procedure TfrmDPedidos.btnFiltrarClick(Sender: TObject);
begin
  FiltrarPedidos;
end;

procedure TfrmDPedidos.edtFiltroKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_up:
      begin
        Query.Prior;
      end;
    vk_down:
      begin
        Query.Next;
      end;
  end;
end;

end.
