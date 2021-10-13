unit GetPrecioDiarioEnvases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits;

type
  TFDGetPrecioDiarioEnvases = class(TForm)
    lblMsg: TLabel;
    btnSi: TButton;
    btnNo: TButton;
    cbbUnidadFact: TComboBox;
    ePrecio: TnbDBNumeric;
    lblUnidad: TLabel;
    lblPrecio: TLabel;
    lblPvp: TLabel;
    ePvp: TnbDBNumeric;
    procedure btnSiClick(Sender: TObject);
    procedure btnNoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    rPrecio, rPvp: double;
    sUnidad: string;
  public
    { Public declarations }
    bResult: Boolean;
  end;

  function Preguntar( const ACaption, AMsg: string; var APrecio, APvp: Double; var AUnidad: String ): boolean;

implementation

{$R *.dfm}

uses UDMConfig, CVariables;

function Preguntar( const ACaption, AMsg: string; var APrecio, APvp: Double; var AUnidad: String ): boolean;
var
  FDGetPrecioDiarioEnvases: TFDGetPrecioDiarioEnvases;
begin
  FDGetPrecioDiarioEnvases:= TFDGetPrecioDiarioEnvases.Create( Nil );
  try
    with FDGetPrecioDiarioEnvases do
    begin
      bResult:= False;
      lblMsg.Caption:= AMsg;
      Caption:= ACaption;

      ePrecio.Text:= FloatToStr( APrecio );
      ePvp.Text:= FloatToStr( APvp );

      if AUnidad = 'K' then
      begin
        cbbUnidadFact.ItemIndex:= 1;
      end
      else
      if AUnidad = 'U' then
      begin
        cbbUnidadFact.ItemIndex:= 2;
      end
      else
      begin
        cbbUnidadFact.ItemIndex:= 0;
      end;

      ShowModal;
      result:= bResult;
      if result then
      begin
        APrecio:= rPrecio;
        APvp:= rPvp;
        AUnidad:= sUnidad;
      end;
    end;
  finally
    FreeAndNil( FDGetPrecioDiarioEnvases );
  end;
end;

procedure TFDGetPrecioDiarioEnvases.btnSiClick(Sender: TObject);
begin
  sUnidad:= cbbUnidadFact.Text;
  bResult:= TryStrToFloat( ePrecio.Text, rPrecio );
  if bResult then
  begin
    bResult:= TryStrToFloat( ePvp.Text, rPvp );
    if bResult then
      Close
    else
      ShowMessage('Pvp incorrecto.');
  end
  else
    ShowMessage('Precio incorrecto.');
end;

procedure TFDGetPrecioDiarioEnvases.btnNoClick(Sender: TObject);
begin
  bResult:= False;
  Close;
end;

procedure TFDGetPrecioDiarioEnvases.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    key:= 0;
    btnSi.Click;
  end
  else
  if key = VK_ESCAPE then
  begin
    key:= 0;
    btnNo.Click;
  end;
end;

end.
