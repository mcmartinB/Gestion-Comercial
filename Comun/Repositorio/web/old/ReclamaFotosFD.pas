unit ReclamaFotosFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, DB;

type
  TFDReclamaFotos = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    DataSource1: TDataSource;
    StatusBar: TStatusBar;
    ScrollBox1: TScrollBox;
    Image: TImage;
    ToolButton6: TToolButton;
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CargarImagen;
  end;

implementation

uses UDMbaseDatos, WebDM, ReclamaFotosQD, DPreview;

{$R *.dfm}

procedure TFDReclamaFotos.ToolButton4Click(Sender: TObject);
begin
  Close;
end;

procedure TFDReclamaFotos.ToolButton2Click(Sender: TObject);
begin
  DMWEB.QReclamaFotos.Next;
  if DMWEB.QReclamaFotos.EOF then
    DMWEB.QReclamaFotos.First;
  CargarImagen;
end;

procedure TFDReclamaFotos.ToolButton1Click(Sender: TObject);
begin
  DMWEB.QReclamaFotos.Prior;
  if DMWEB.QReclamaFotos.BOF then
    DMWEB.QReclamaFotos.Last;
  CargarImagen;
end;

procedure TFDReclamaFotos.CargarImagen;
var
  sAux: string;
begin
  Image.Visible:= false;
  if DMWEB.QReclamaFotos.Active and not DMWEB.QReclamaFotos.IsEmpty then
  begin
    sAux:= kLocalDir + DMWEB.QReclamaFotos.FieldByName('fichero_rft').AsString + '.jpg';
    if FileExists( sAux ) then
    begin
      try
        Image.Picture.LoadFromFile( sAux );
        Image.Visible:= True;
      except
      end;
    end;
    StatusBar.SimpleText:= sAux;
  end;
end;

end.
