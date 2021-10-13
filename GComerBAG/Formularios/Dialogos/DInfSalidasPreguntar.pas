unit DInfSalidasPreguntar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFDInfSalidasPreguntar = class(TForm)
    lblMsg: TLabel;
    btnSi: TButton;
    btnNo: TButton;
    lblImpresora: TLabel;
    cbxImpresora: TComboBox;
    cbxFirma: TCheckBox;
    cbxOriginalEmpresa: TCheckBox;
    procedure btnSiClick(Sender: TObject);
    procedure btnNoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    bResult: Boolean;
  end;

  function Preguntar( const AOpcion: integer; var AVersion: integer; var AFirma, AOriginal: Boolean ): boolean;

implementation

{$R *.dfm}

uses UDMConfig, CVariables;

function Preguntar( const AOpcion: integer; var AVersion: integer; var AFirma, AOriginal: Boolean ): boolean;
var
  FDInfSalidasPreguntar: TFDInfSalidasPreguntar;
begin
  FDInfSalidasPreguntar:= TFDInfSalidasPreguntar.Create( Nil );
  with FDInfSalidasPreguntar do
  begin
    bResult:= False;
    case AOpcion  of
      0: begin
           lblMsg.Caption:= '¿DESEA IMPRIMIR EL ALBARÁN DE SALIDA?';
           lblImpresora.Visible:= False;
           cbxImpresora.Visible:= False;
           cbxImpresora.ItemIndex:= 0;
           cbxFirma.Visible:= CVariables.gbFirmar;
           cbxFirma.Checked:= False;
           if cbxFirma.Visible = False then
           begin
             cbxOriginalEmpresa.Top:=  cbxImpresora.Top;
           end;
           cbxOriginalEmpresa.Visible:= DMConfig.EsChanita;
           cbxOriginalEmpresa.Checked:= not cbxOriginalEmpresa.Visible;
           if cbxOriginalEmpresa.Visible = False then
           begin
             cbxFirma.Top:=  cbxImpresora.Top;
           end;
         end;
      1: begin
           lblMsg.Caption:= '¿DESEA IMPRIMIR LA CMR?';
           lblImpresora.Visible:= True;
           cbxImpresora.Visible:= True;
           cbxImpresora.ItemIndex:= 0;
           cbxFirma.Visible:= False;
           cbxFirma.Checked:= False;
           cbxOriginalEmpresa.Visible:= False;
           cbxOriginalEmpresa.Checked:= True;
         end;
      2: begin
           lblMsg.Caption:= '¿DESEA IMPRIMIR LA FACTURA PROFORMA?';
           lblImpresora.Visible:= False;
           cbxImpresora.Visible:= False;
           cbxImpresora.ItemIndex:= 0;
           cbxFirma.Visible:= False;
           cbxFirma.Checked:= False;
           cbxOriginalEmpresa.Visible:= False;
           cbxOriginalEmpresa.Checked:= True;
         end;
      3: begin
           lblMsg.Caption:= '¿DESEA IMPRIMIR LA CARTA DE PORTE ?';
           lblImpresora.Visible:= False;
           cbxImpresora.Visible:= False;
           cbxImpresora.ItemIndex:= 0;
           cbxFirma.Visible:= False;
           cbxFirma.Checked:= False;
           cbxOriginalEmpresa.Visible:= False;
           cbxOriginalEmpresa.Checked:= True;
         end;
    end;
    ShowModal;
    result:= bResult;
    AFirma:= cbxFirma.Checked;
    AOriginal:= cbxOriginalEmpresa.Checked;
    AVersion:= cbxImpresora.ItemIndex;
  end;
  FreeAndNil( FDInfSalidasPreguntar );
end;

procedure TFDInfSalidasPreguntar.btnSiClick(Sender: TObject);
begin
  bResult:= True;
  Close;
end;

procedure TFDInfSalidasPreguntar.btnNoClick(Sender: TObject);
begin
  bResult:= False;
  Close;
end;

procedure TFDInfSalidasPreguntar.FormKeyDown(Sender: TObject;
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
