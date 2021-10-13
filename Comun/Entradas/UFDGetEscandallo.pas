unit UFDGetEscandallo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BEdit;

type
  TFDGetEscandallo = class(TForm)
    Label2: TLabel;
    LEmpresa_p: TLabel;
    Label11: TLabel;
    lblDestrio: TLabel;
    lblTotal: TLabel;
    lblTotal1: TLabel;
    btnAceptar: TButton;
    btnCancelar: TButton;
    edtPrimera: TBEdit;
    edtSegunda: TBEdit;
    edtTercera: TBEdit;
    edtDestrio: TBEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    procedure edtPrimeraChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    rPrimera, rSegunda, rTercera, rDestrio, rFalta: Real;
  public
    { Public declarations }
  end;

  function GetEscandallo( var APrimera, ASegunda, ATercera, ADestrio: Real ): Boolean;


implementation

{$R *.dfm}

uses
  bMath;

var
  FDGetEscandallo: TFDGetEscandallo;

function GetEscandallo( var APrimera, ASegunda, ATercera, ADestrio: Real ): Boolean;
begin
  FDGetEscandallo:= TFDGetEscandallo.Create( Application );
  try
    if FDGetEscandallo.ShowModal = mrOk then
    begin
      Result:= True;
      APrimera:= FDGetEscandallo.rPrimera;
      ASegunda:= FDGetEscandallo.rSegunda;
      ATercera:= FDGetEscandallo.rTercera;
      ADestrio:= FDGetEscandallo.rDestrio;
    end
    else
    begin
      Result:= False;
      APrimera:= 0;
      ASegunda:= 0;
      ATercera:= 0;
      ADestrio:= 0;
    end;
  finally
    FreeAndNil( FDGetEscandallo );
  end;
end;

procedure TFDGetEscandallo.edtPrimeraChange(Sender: TObject);
begin
  rPrimera:= StrToFloatDef(edtPrimera.Text,0);
  rSegunda:= StrToFloatDef(edtSegunda.Text,0);
  rTercera:= StrToFloatDef(edtTercera.Text,0);
  rDestrio:= StrToFloatDef(edtDestrio.Text,0);
  rFalta:=  broundTo( 100 - ( rPrimera + rSegunda +  rTercera +  rDestrio ), 2);
  lblTotal1.Caption:= FormatFloat( '##0.00', rFalta )
end;

procedure TFDGetEscandallo.FormCreate(Sender: TObject);
begin
  rPrimera:= 0;
  rSegunda:= 0;
  rTercera:= 0;
  rDestrio:= 0;
  rFalta:= 100;
end;

procedure TFDGetEscandallo.btnAceptarClick(Sender: TObject);
begin
  if rFalta = 0 then
    ModalResult:= mrOk
  else
    ShowMessage('La suma de los diferentes porcentajes debe dar 100');
end;

procedure TFDGetEscandallo.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFDGetEscandallo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
  end;
end;

procedure TFDGetEscandallo.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F1:
      begin
        btnAceptar.Click;
      end;
  end;
end;

end.
