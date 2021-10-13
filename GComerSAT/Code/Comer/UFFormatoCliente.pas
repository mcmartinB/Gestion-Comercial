unit UFFormatoCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons;

type
  TFFormatoClientes = class(TForm)
    DBGrid: TDBGrid;
    Query: TQuery;
    DataSource: TDataSource;
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

  public
    { Public declarations }
    bFlag: boolean;
    sEmpresa: string;
  end;

  procedure InicializaModulo( const ABaseDatos: string );
  procedure FinalizaModulo;


  function SeleccionaFormatoCliente( const AForm: TForm; const AControl: TControl;
    const AEmpresa, AProducto, ACliente, ASuministro: string; var AResultado: string ): Boolean;

implementation

{$R *.dfm}

var
  FFormatoClientes: TFFormatoClientes;

procedure InicializaModulo( const ABaseDatos: string );
begin
  FFormatoClientes:= TFFormatoClientes.Create( Application );
  FFormatoClientes.Query.DatabaseName:= ABaseDatos;
end;

procedure FinalizaModulo;
begin
  FreeAndNil( FFormatoClientes );
end;

procedure TFFormatoClientes.DBGridDblClick(Sender: TObject);
begin
  bFlag:= True;
  Close;
end;

procedure TFFormatoClientes.FormShow(Sender: TObject);
begin
  bFlag:= False;
end;

procedure TFFormatoClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFFormatoClientes.FormKeyUp(Sender: TObject; var Key: Word;
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
  end;
end;

function QueryFormatoCliente( const AEmpresa, AProducto, ACliente, ASumnistro:string ): String;
var
  slAux: TStringList;
begin
  slAux:= TStringList.Create;
  slAux.Add(' select empresa_f, cliente_fc, suministro_fc, codigo_f, formato_cliente_fc, descripcion_fc ');
  slAux.Add(' from frf_formatos, frf_formatos_cli ');
  slAux.Add(' where empresa_fc = empresa_f ');
  slAux.Add(' and formato_fc = codigo_f ');
  slAux.Add(' and fecha_baja_f is null ');
  if Trim(AEmpresa) <> '' then
  begin
     slAux.Add(' and empresa_fc = :empresa ');
  end;
  if Trim(AProducto) <> '' then
  begin
     slAux.Add(' and productop_f = :producto ');
  end;
  if Trim(ACliente) <> '' then
  begin
     slAux.Add(' and cliente_fc = :cliente ');
  end;
  if Trim(ASumnistro) <> '' then
  begin
     slAux.Add(' and ( suministro_fc = ''*'' or suministro_fc = '''' or suministro_fc = :dirsum ) ');
  end;

  slAux.Add(' group by empresa_f, cliente_fc, suministro_fc, codigo_f, formato_cliente_fc, descripcion_fc ');
  slAux.Add(' order by empresa_f, codigo_f, formato_cliente_fc, cliente_fc, suministro_fc ');
  result:= slAux.Text;
  FreeAndNil( slAux );
end;

function SeleccionaFormatoCliente( const AForm: TForm; const AControl: TControl;
  const AEmpresa, AProducto, ACliente, ASuministro: string; var AResultado: string ): Boolean;
begin
  FFormatoClientes:= TFFormatoClientes.Create( AForm );

  FFormatoClientes.Left:= AControl.ClientOrigin.X;
  FFormatoClientes.Top:= AControl.ClientOrigin.Y + AControl.Height;

  with FFormatoClientes.Query do
  begin
    Close;
    SQL.Clear;
    (*TODO*)
    SQL.Add( QueryFormatoCliente ( AEmpresa, AProducto, ACliente, ASuministro ) );

    if Trim(AProducto) <> '' then
    begin
      ParamByName('producto').AsString:= AProducto;
    end;
    if Trim(AEmpresa) <> '' then
    begin
      ParamByName('empresa').AsString:= AEmpresa;
    end;
    if Trim(ACliente) <> '' then
    begin
      ParamByName('cliente').AsString:= ACliente;
    end;
    if Trim(ASuministro) <> '' then
    begin
      ParamByName('dirsum').AsString:= ASuministro;
    end;

    Open;
  end;

  try
    FFormatoClientes.ShowModal;
    result:= FFormatoClientes.bFlag;
    if result then
      AResultado:= FFormatoClientes.Query.Fields[4].AsString;
  finally
    FreeAndNil( FFormatoClientes );
  end;
end;

end.
