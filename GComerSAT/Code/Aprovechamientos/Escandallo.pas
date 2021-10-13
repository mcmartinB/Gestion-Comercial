unit Escandallo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, nbEdits, nbLabels;

type
  TFEscandallo = class(TForm)
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    primera: TnbDBNumeric;
    segunda: TnbDBNumeric;
    tercera: TnbDBNumeric;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnAceptar: TBitBtn;
    lblDestrio: TnbLabel;
    destrio: TnbDBNumeric;
    lblDestrio2: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    escandallo: boolean;
    pprimera, psegunda, ptercera, pdestrio: real;
  end;

  procedure GetEscandallo( var APrimera, ASegunda, ATercera, ADestrio: string );

implementation

uses bMath;

{$R *.dfm}

procedure GetEscandallo( var APrimera, ASegunda, ATercera, ADestrio: string );
var
  Escandallo: TFEscandallo;
begin
  Escandallo:= TFEscandallo.Create( Application );
  Escandallo.ShowModal;
  if Escandallo.escandallo then
  begin
    APrimera:= FormatFloat( '###.00', Escandallo.pprimera );
    ASegunda:= FormatFloat( '###.00', Escandallo.psegunda );
    ATercera:= FormatFloat( '###.00', Escandallo.ptercera );
    ADestrio:= FormatFloat( '###.00', Escandallo.pdestrio );
  end
  else
  begin
    APrimera:= '0';
    ASegunda:= '0';
    ATercera:= '0';
    ADestrio:= '0';
  end;
  FreeAndNil( Escandallo );
end;

procedure TFEscandallo.btnAceptarClick(Sender: TObject);
var
  total: real;
  aux: Real;
begin
  total:= StrTofloat( primera.Text ) + StrTofloat( segunda.Text ) +
          StrTofloat( tercera.Text );
  if total <> 0 then
  begin
    escandallo:= True;
    pprimera:= bRoundTo( ( StrTofloat( primera.Text ) * 100 ) / total, -2 );
    psegunda:= bRoundTo( ( StrTofloat( segunda.Text ) * 100 ) / total, -2 );
    ptercera:= bRoundTo( ( StrTofloat( tercera.Text ) * 100 ) / total, -2 );
    pdestrio:= bRoundTo( ( StrTofloat( destrio.Text ) * 100 ) / total, -2 );

    total:= pprimera + psegunda + ptercera + pdestrio;
    if total <> 100 then
    begin
      aux:= pdestrio + (100 - total);
      if ( aux < 0 ) or ( aux > 100 ) then
      begin
        aux:= ptercera + (100 - total);
        if ( aux < 0 ) or ( aux > 100 ) then
        begin
         aux:= psegunda + (100 - total);
         if ( psegunda < 0 ) or ( psegunda > 100 ) then
         begin
           pprimera:= pprimera + (100 - total);
         end
         else
         begin
           psegunda:= aux;
         end;
        end
        else
        begin
          ptercera:= aux;
        end;
      end
      else
      begin
        pdestrio:= aux;
      end;
    end;
  end;
  Close;
end;

procedure TFEscandallo.FormCreate(Sender: TObject);
begin
  pprimera:= 0;
  psegunda:= 0;
  ptercera:= 0;
  pdestrio:= 0;
  primera.Text:= FloatToStr( pprimera );
  segunda.Text:= FloatToStr( psegunda );
  tercera.Text:= FloatToStr( ptercera );
  destrio.Text:= FloatToStr( pdestrio );
  escandallo:= False;
end;

procedure TFEscandallo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f1:
    begin
      Key := 0;
      btnAceptar.Click;
    end;
  end;
end;

procedure TFEscandallo.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
    begin
      Key := 0;
      pprimera:= 0;
      psegunda:= 0;
      ptercera:= 0;
      pdestrio:= 0;
      close;
    end;
  end;
end;

end.
