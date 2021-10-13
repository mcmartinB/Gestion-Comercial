unit DesgloseTransitosFC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBCtrls, Buttons;

type
  TFCDesgloseTransitos = class(TForm)
    DSKilosTransito: TDataSource;
    DSSalidasTransito: TDataSource;
    DSTransitosTransito: TDataSource;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    cbxProductos: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    Label7: TLabel;
    DBText7: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    Label8: TLabel;
    Label9: TLabel;
    DSKilosTransitoAux: TDataSource;
    Label10: TLabel;
    Label11: TLabel;
    btnImprimir: TBitBtn;
    btnCerrar: TBitBtn;
    procedure btnImprimir_Click(Sender: TObject);
    procedure cbxProductosChange(Sender: TObject);
    procedure btnCerrar_Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure ConsultaTransito( const AOwner: TComponent;
    const AEmpresa, ACentroSalida: string;
    const AReferencia: integer;
    const AFecha: TDateTime );

implementation

{$R *.dfm}

uses DesgloseTransitosDM, CGestionPrincipal;

var
  FCDesgloseTransitos: TFCDesgloseTransitos;
  DMDesgloseTransitos: TDMDesgloseTransitos;

(*
    myHandle := AHandle;
    ShowWindow(myHandle, SW_HIDE);
    if myHandle <> 0 then ShowWindow(myHandle, SW_SHOW);
*)

procedure ConsultaTransito( const AOwner: TComponent; const AEmpresa, ACentroSalida: string;
    const AReferencia: integer; const AFecha: TDateTime );
var
  slLista: TStringList;
begin
  DMDesgloseTransitos:= TDMDesgloseTransitos.Create( AOwner );

  try
    if DMDesgloseTransitos.ConsultaTransito( AEmpresa, ACentroSalida, AReferencia, AFecha ) then
    begin
      FCDesgloseTransitos:= TFCDesgloseTransitos.Create( AOwner );
      try
        if AOwner is TForm then
        begin
          ShowWindow(TForm(AOwner).Handle, SW_HIDE);
          CGestionPrincipal.BHDeshabilitar;
        end;

        DMDesgloseTransitos.Filtro( '' );
        slLista:= TStringList.Create;
        DMDesgloseTransitos.ListaProductos( slLista );
        FCDesgloseTransitos.cbxProductos.Items.AddStrings( slLista );
        FCDesgloseTransitos.cbxProductos.ItemIndex:= 0;
        FCDesgloseTransitos.Show;
      finally
        //FreeAndNil( FCDesgloseTransitos );
        FreeAndNil( slLista );
      end;
    end;
  finally
    //FreeAndNil( DMDesgloseTransitos );
  end;
end;

procedure TFCDesgloseTransitos.btnCerrar_Click(Sender: TObject);
begin
  Close;
end;

procedure TFCDesgloseTransitos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Owner is TForm then
  begin
    ShowWindow(TForm(Owner).Handle, SW_SHOW);
    CGestionPrincipal.BHRestaurar;
  end;
  FreeAndNil( DMDesgloseTransitos );
  Action:= caFree;
end;

procedure TFCDesgloseTransitos.btnImprimir_Click(Sender: TObject);
begin
  DMDesgloseTransitos.Previsualizar;
end;

procedure TFCDesgloseTransitos.cbxProductosChange(Sender: TObject);
begin
  if cbxProductos.itemIndex > 0 then
  begin
    DMDesgloseTransitos.Filtro( copy(cbxProductos.Items[cbxProductos.itemIndex],1,1 ) );
  end
  else
  begin
    DMDesgloseTransitos.Filtro( '' );
  end;
end;

procedure TFCDesgloseTransitos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_f1:      btnImprimir.Click;
    vk_escape:  btnCerrar.click;
  end;
end;

end.
