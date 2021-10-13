unit SelecFotosFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFDSelecFotos = class(TForm)
    Image0: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    cbxImage0: TCheckBox;
    cbxImage1: TCheckBox;
    cbxImage3: TCheckBox;
    cbxImage2: TCheckBox;
    cbxImage4: TCheckBox;
    cbxImage5: TCheckBox;
    cbxImage6: TCheckBox;
    cbxImage8: TCheckBox;
    cbxImage7: TCheckBox;
    cbxImage9: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    bImprimir: boolean;
    procedure CargaFotos;
    procedure CargaImagen( var AImagen: TImage );
  end;

procedure ImprimirFotosReclama( const ATitulo: string; var AImprimir: Boolean;
  var AImagenes: array of boolean );


implementation

uses WEBDM, bMath;

{$R *.dfm}


procedure TFDSelecFotos.CargaImagen( var AImagen: TImage );
var
  sAux: string;
  imageAux: TPicture;
  rel: real;
  val: integer;
begin
  sAux:= kLocalDir + DMWEB.QReclamaFotos.FieldByName('fichero_rft').AsString + '.jpg';
  if FileExists( sAux ) then
  begin
    try
      imageAux:= TPicture.Create;
      imageAux.LoadFromFile( sAux );
      //Relacion de la imagen ancho/alto
      rel:= bRoundTo( imageAux.Width / imageAux.Height, -2 );
      //Fijamos ancho maximo a 105 para calcular el alto
      val:= Trunc( 105 / rel );
      //Alto maximo de 80
      if val > 80 then
      begin
        val:= Trunc( 80 * rel );
        AImagen.Height:= 80;
        AImagen.Width:= val;
      end
      else
      begin
        AImagen.Height:= val;
        AImagen.Width:= 105;
      end;

      AImagen.Picture.LoadFromFile( sAux );
      AImagen.Visible:= True;
    finally
      FreeAndNil( imageAux );
    end;
  end;
end;

procedure TFDSelecFotos.CargaFotos;
begin
  DMWEB.QReclamaFotos.First;
  if not DMWEB.QReclamaFotos.EOF then
  begin
    CargaImagen( Image0 );
    cbxImage0.Enabled:= true;
    cbxImage0.Checked:= true;
  end
  else
  begin
    Image0.Visible:= False;
    cbxImage0.Enabled:= false;
    cbxImage0.Checked:= false;
  end;
  DMWEB.QReclamaFotos.Next;
  if not DMWEB.QReclamaFotos.EOF then
  begin
    CargaImagen( Image1 );
    cbxImage1.Enabled:= true;
    cbxImage1.Checked:= true;
  end
  else
  begin
    Image1.Visible:= False;
    cbxImage1.Enabled:= false;
    cbxImage1.Checked:= false;
  end;
  DMWEB.QReclamaFotos.Next;
  if not DMWEB.QReclamaFotos.EOF then
  begin
    CargaImagen( Image2 );
    cbxImage2.Enabled:= true;
    cbxImage2.Checked:= true;
  end
  else
  begin
    Image2.Visible:= False;
    cbxImage2.Enabled:= false;
    cbxImage2.Checked:= false;
  end;
  DMWEB.QReclamaFotos.Next;
  if not DMWEB.QReclamaFotos.EOF then
  begin
    CargaImagen( Image3 );
    cbxImage3.Enabled:= true;
    cbxImage3.Checked:= true;
  end
  else
  begin
    Image3.Visible:= False;
    cbxImage3.Enabled:= false;
    cbxImage3.Checked:= false;
  end;
  DMWEB.QReclamaFotos.Next;
  if not DMWEB.QReclamaFotos.EOF then
  begin
    CargaImagen( Image4 );
    cbxImage4.Enabled:= true;
    cbxImage4.Checked:= true;
  end
  else
  begin
    Image4.Visible:= False;
    cbxImage4.Enabled:= false;
    cbxImage4.Checked:= false;
  end;
  DMWEB.QReclamaFotos.Next;
  if not DMWEB.QReclamaFotos.EOF then
  begin
    CargaImagen( Image5 );
    cbxImage5.Enabled:= true;
    cbxImage5.Checked:= true;
  end
  else
  begin
    Image5.Visible:= False;
    cbxImage5.Enabled:= false;
    cbxImage5.Checked:= false;
  end;
  DMWEB.QReclamaFotos.Next;
  if not DMWEB.QReclamaFotos.EOF then
  begin
    CargaImagen( Image6 );
    cbxImage6.Enabled:= true;
    cbxImage6.Checked:= true;
  end
  else
  begin
    Image6.Visible:= False;
    cbxImage6.Enabled:= false;
    cbxImage6.Checked:= false;
  end;
  DMWEB.QReclamaFotos.Next;
  if not DMWEB.QReclamaFotos.EOF then
  begin
    CargaImagen( Image7 );
    cbxImage7.Enabled:= true;
    cbxImage7.Checked:= true;
  end
  else
  begin
    Image7.Visible:= False;
    cbxImage7.Enabled:= false;
    cbxImage7.Checked:= false;
  end;
  DMWEB.QReclamaFotos.Next;
  if not DMWEB.QReclamaFotos.EOF then
  begin
    CargaImagen( Image8 );
    cbxImage8.Enabled:= true;
    cbxImage8.Checked:= true;
  end
  else
  begin
    Image8.Visible:= False;
    cbxImage8.Enabled:= false;
    cbxImage8.Checked:= false;
  end;
  DMWEB.QReclamaFotos.Next;
  if not DMWEB.QReclamaFotos.EOF then
  begin
    CargaImagen( Image9 );
    cbxImage9.Enabled:= true;
    cbxImage9.Checked:= true;
  end
  else
  begin
    Image9.Visible:= False;
    cbxImage9.Enabled:= false;
    cbxImage9.Checked:= false;
  end;
end;

procedure TFDSelecFotos.Button2Click(Sender: TObject);
begin
  bImprimir:= False;
  Close;
end;

procedure TFDSelecFotos.Button1Click(Sender: TObject);
begin
  bImprimir:= true;
  Close;
end;

procedure ImprimirFotosReclama( const ATitulo: string; var AImprimir: Boolean;
  var AImagenes: array of boolean );
var
  FDSelecFotos: TFDSelecFotos;
  maxLen: integer;
begin
  FDSelecFotos:= TFDSelecFotos.Create( Application );
  FDSelecFotos.Caption:= '    ' + ATitulo;
  try
    FDSelecFotos.CargaFotos;
    FDSelecFotos.ShowModal;
    AImprimir:= FDSelecFotos.bImprimir;
    maxLen:= length( AIMagenes );
    if maxLen > 0 then AImagenes[0]:= FDSelecFotos.cbxImage0.Checked;
    if maxLen > 1 then AImagenes[1]:= FDSelecFotos.cbxImage1.Checked;
    if maxLen > 2 then AImagenes[2]:= FDSelecFotos.cbxImage2.Checked;
    if maxLen > 3 then AImagenes[3]:= FDSelecFotos.cbxImage3.Checked;
    if maxLen > 4 then AImagenes[4]:= FDSelecFotos.cbxImage4.Checked;
    if maxLen > 5 then AImagenes[5]:= FDSelecFotos.cbxImage5.Checked;
    if maxLen > 6 then AImagenes[6]:= FDSelecFotos.cbxImage6.Checked;
    if maxLen > 7 then AImagenes[7]:= FDSelecFotos.cbxImage7.Checked;
    if maxLen > 8 then AImagenes[8]:= FDSelecFotos.cbxImage8.Checked;
    if maxLen > 9 then AImagenes[9]:= FDSelecFotos.cbxImage9.Checked;
  finally
    FreeAndNil( FDSelecFotos );
  end;
end;


end.
