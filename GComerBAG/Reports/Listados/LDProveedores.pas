unit LDProveedores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TFDProveedores = class(TForm)
    cbxSeleccion: TComboBox;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    bOk: Boolean;
  public
    { Public declarations }
  end;

  function VisualizarDetalle( const AOwner: TComponent; var AAlmacenes, AProductos: boolean ): boolean;



implementation

{$R *.dfm}

function VisualizarDetalle( const AOwner: TComponent; var AAlmacenes, AProductos: boolean ): boolean;
var
  FDProveedores: TFDProveedores;
begin
  FDProveedores:= TFDProveedores.Create( AOwner );
  try
    with FDProveedores do
    begin
      ShowModal;
      result:= bOk;
      if result then
      begin
        case cbxSeleccion.ItemIndex of
          0:
          begin
            AAlmacenes:= False;
            AProductos:= False;
          end;
          1:
          begin
            AAlmacenes:= True;
            AProductos:= False;
          end;
          2:
          begin
            AAlmacenes:= False;
            AProductos:= True;
          end;
          3:
          begin
            AAlmacenes:= True;
            AProductos:= True;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil( FDProveedores );
  end;
end;

procedure TFDProveedores.SpeedButton1Click(Sender: TObject);
begin
  bOk:= true;
  Close;
end;

procedure TFDProveedores.SpeedButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TFDProveedores.FormCreate(Sender: TObject);
begin
  bOk:= false;
end;

end.
