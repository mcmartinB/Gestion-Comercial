unit ReclamaFotosQD;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQDReclamaFotos = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    Image: TQRImage;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRSysData3: TQRSysData;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    bImprimirFotos: array [0..9] of Boolean;
    contador: integer;
  public
    procedure ImprimirFotos( const AImprimirFotos: array of boolean );
  end;

implementation

{$R *.DFM}

uses WEBDM, bMath;

procedure TQDReclamaFotos.ImprimirFotos( const AImprimirFotos: array of boolean );
var
  i: integer;
begin
  for i:= 0 to length( AImprimirFotos ) - 1 do
    bImprimirFotos[i]:= AImprimirFotos[i];

  for i:= length( AImprimirFotos )  to length( bImprimirFotos ) - 1 do
    bImprimirFotos[i]:= false;
end;

procedure TQDReclamaFotos.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  sAux: string;
  imageAux: TPicture;
  rel: Real;
  val: integer;
begin
  PrintBand:= bImprimirFotos[ contador ];
  Inc( contador );
  if PrintBand then
  begin
    Image.Visible:= false;
    if DMWEB.QReclamaFotos.Active and not DMWEB.QReclamaFotos.IsEmpty then
    begin
      sAux:= kLocalDir + DMWEB.QReclamaFotos.FieldByName('fichero_rft').AsString + '.jpg';
      if FileExists( sAux ) then
      begin
        try
          imageAux:= TPicture.Create;
          imageAux.LoadFromFile( sAux );
          //Relacion de la imagen ancho/alto
          rel:= bRoundTo( imageAux.Width / imageAux.Height, -2 );
          //Fijamos ancho maximo a 600 para calcular el alto
          val:= Trunc( 600 / rel );
          //Alto maximo de 430
          if val > 430 then
          begin
            val:= Trunc( 430 * rel );
            Image.Height:= 430;
            Image.Width:= val;
          end
          else
          begin
            Image.Height:= val;
            Image.Width:= 600;
          end;
          //Centrar la imagen
          if Image.Width <> 0 then
            Image.Left:= Trunc ( ( DetailBand1.Width - Image.Width ) / 2 );

          Image.Picture.LoadFromFile( sAux );
          Image.Visible:= True;
        finally
          FreeAndNil( imageAux );
        end;
      end;
    end;
  end;
end;

procedure TQDReclamaFotos.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  contador:= 0;
end;

end.
