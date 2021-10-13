unit CFPDescargaEntrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons;

type
  TFPDescargaEntrega = class(TForm)
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    eAlbaran: TnbDBAlfa;
    eFecha: TnbDBCalendarCombo;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    bAceptar: Boolean;

    function ValidarValues: boolean;
  public
    { Public declarations }
    procedure LoadValues( const AAlbaran, AFecha: string );
    function UnloadValues( var AAlbaran, AFecha: string ): boolean;
  end;

  function ExecuteDescargarEntrega( const AOwner: TComponent; var AAlbaran, AFecha: string ): boolean;

implementation

{$R *.dfm}

var
  FPDescargaEntrega: TFPDescargaEntrega;

function ExecuteDescargarEntrega( const AOwner: TComponent; var AAlbaran, AFecha: string ): boolean;
begin
  FPDescargaEntrega:= TFPDescargaEntrega.Create( AOwner );
  try
    FPDescargaEntrega.LoadValues( AAlbaran, AFecha );
    FPDescargaEntrega.ShowModal;
  finally
    result:= FPDescargaEntrega.UnloadValues( AAlbaran, AFecha );
    FreeAndNil(FPDescargaEntrega );
  end;
end;

procedure TFPDescargaEntrega.FormCreate(Sender: TObject);
begin
  bAceptar:= False;
end;

procedure TFPDescargaEntrega.SpeedButton2Click(Sender: TObject);
begin
  if ValidarValues then
  begin
    bAceptar:= True;
    Close;
  end;
end;

procedure TFPDescargaEntrega.SpeedButton1Click(Sender: TObject);
begin
   bAceptar:= False;
   Close;
end;

procedure TFPDescargaEntrega.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFPDescargaEntrega.LoadValues( const AAlbaran, AFecha: string );
begin
  eAlbaran.Text:= AAlbaran;
  eFecha.AsDate:= StrToDateDef( AFecha, Date );
end;

function TFPDescargaEntrega.UnloadValues( var AAlbaran, AFecha: string ): boolean;
begin
  result:= bAceptar;
  if Result then
  begin
    AAlbaran:= eAlbaran.Text;
    AFecha:= eFecha.Text;
  end;
end;

function TFPDescargaEntrega.ValidarValues: boolean;
var
  dFecha: TDateTime;
begin
  result:= False;
  if Trim( eAlbaran.Text ) = '' then
  begin
    ShowMessage('Falta el numero de albarán.');
  end
  else
  if not TryStrToDate( eFecha.Text, dFEcha ) then
  begin
    ShowMessage('Fecha incorrecta.');
  end
  else
  begin
    result:= True;
  end;
end;

end.


