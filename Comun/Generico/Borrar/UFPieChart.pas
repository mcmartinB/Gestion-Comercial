unit UFPieChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, OleCtrls, Chartfx3, VCFI, DB;

const
  kPieColors: array[0..9] of TColor = ( clRed, clGreen, clBlue, clYellow, clSilver,
                                        clPurple, clOlive, clTeal, clLime, clGray ) ;

type
  TForm1 = class(TForm)
    Image1: TImage;
    btnNombre1: TButton;
    e01: TEdit;
    e02: TEdit;
    e03: TEdit;
    e04: TEdit;
    e05: TEdit;
    e06: TEdit;
    e07: TEdit;
    e09: TEdit;
    e08: TEdit;
    e11: TEdit;
    e12: TEdit;
    e13: TEdit;
    e14: TEdit;
    e15: TEdit;
    e16: TEdit;
    e17: TEdit;
    e19: TEdit;
    e18: TEdit;
    e00: TEdit;
    e10: TEdit;
    eAncho: TEdit;
    lblNombre1: TLabel;
    cbxLeyenda: TComboBox;
    procedure btnNombre1Click(Sender: TObject);
  private
    { Private declarations }
    arValores: array of real;
    asLeyendas: array of string;

    procedure LoadData;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Math;

procedure Leyenda( VCanvas: TCanvas; const ARadio: integer;
                   const ALeyendas: array of string; const ATipoLeyenda: integer = 1 );
var
  i, iMax: integer;
  iSep, iAlto, iAncho: integer;
begin
  if ATipoLeyenda = 1 then
  begin
    iSep:= 10;
    iAncho:= ARadio * 2;
    iAlto:= ( ARadio * 2 ) div 10;

    iMax:= Length( ALeyendas );
    for i:= 0 to iMax - 1 do
    begin
      VCanvas.Pen.Color:= kPieColors[i mod 10];
      VCanvas.Brush.Color:= kPieColors[i mod 10];

      VCanvas.Rectangle( iAncho + iSep, ( i * iAlto ) + ( iAlto div 4 ),
                         iAncho + ( 2 * iSep ), ( i * iAlto ) + ( ( 3 * iAlto ) div 4 ) );

      VCanvas.Brush.Color:= clWhite;
      VCanvas.TextOut( iAncho + ( 3 * iSep ), ( i * iAlto ) + ( iAlto div 4 ), ALeyendas[i] );
    end;
  end;
end;

procedure PaintPieChart( VCanvas: TCanvas; const ARadio: integer;
                         const AValores: array of real;
                         const ALeyendas: array of string;
                         const ATipoLeyenda: integer = 1 );
var
  i, iMax: integer;
  rAux, rAcum: real;
  arRadianes: array of real;
  iAltura1, iAltura2, iAncho1, iAncho2: Integer;
begin
  //Limpiar zona de dibujo
  VCanvas.Pen.Color:= clWhite;
  VCanvas.Brush.Color:= clWhite;
  VCanvas.Rectangle( VCanvas.ClipRect );

  //Leyenda
  Leyenda( VCanvas, ARadio, ALeyendas, ATipoLeyenda );

  //Tarta
  rAcum:= 0;
  iMax:= Length( AValores );
  for i:= 0 to iMax - 1 do
  begin
    if AValores[i] > 0 then
    begin
      rAcum:= rAcum + AValores[i];
    end;
  end;

  SetLength( arRadianes, iMax + 1);
  rAux:= 0;
  if rAcum > 0 then
  begin
    for i:= 0 to iMax do
    begin
      arRadianes[i]:= SimpleRoundTo( ( rAux * 2 * pi ) / rAcum, -5 );
      if AValores[i] > 0 then
      begin
        rAux:= rAux + AValores[i];
      end;
    end;

    for i:= 0 to iMax - 1 do
    begin
      iAltura1:= ARadio - Trunc( Sin( arRadianes[i] ) * ARadio );
      iAncho1:= Trunc( Cos( arRadianes[i] ) * ARadio ) + ARadio;

      iAltura2:= ARadio - Trunc( Sin( arRadianes[i+1] ) * ARadio );
      iAncho2:= Trunc( Cos( arRadianes[i+1] ) * ARadio ) + ARadio;

      if ( iAncho1 <> iAncho2 ) or ( iAltura1 <> iAltura2 ) then
      begin
        VCanvas.Pen.Color:= kPieColors[i mod 10];
        VCanvas.Brush.Color:= kPieColors[i mod 10];
        VCanvas.Pie(0,0,ARadio*2,ARadio*2, iAncho1, iAltura1, iAncho2, iAltura2 );
      end;
    end;
  end
  else
  begin
    for i:= 0 to iMax do
    begin
      VCanvas.Pen.Color:= clBlack;
      VCanvas.Brush.Color:= clWhite;
      arRadianes[i]:= 0;
      VCanvas.Ellipse(0,0,ARadio*2,ARadio*2 );
    end;
  end;
end;

procedure TForm1.btnNombre1Click(Sender: TObject);
begin
  LoadData;
  PaintPieChart( Image1.Canvas, ( StrToIntDef( eAncho.Text, 50 ) div 2),  arValores, asLeyendas, cbxLeyenda.ItemIndex );
end;

procedure TForm1.LoadData;
var
  i: integer;
begin
  i:= 0;
  if e00.Text <> '' then
  begin
    SetLength( arValores, i + 1 );
    arValores[i]:= StrToFloatDef( e00.Text, 0);
    SetLength( asLeyendas, i + 1 );
    asLeyendas[i]:= e10.Text;
    inc( i );
  end;

  if e01.Text <> '' then
  begin
    SetLength( arValores, i + 1 );
    arValores[i]:= StrToFloatDef( e01.Text, 0);
    SetLength( asLeyendas, i + 1 );
    asLeyendas[i]:= e11.Text;
    inc( i );
  end;

  if e02.Text <> '' then
  begin
    SetLength( arValores, i + 1 );
    arValores[i]:= StrToFloatDef( e02.Text, 0);
    SetLength( asLeyendas, i + 1 );
    asLeyendas[i]:= e12.Text;
    inc( i );
  end;

  if e03.Text <> '' then
  begin
    SetLength( arValores, i + 1 );
    arValores[i]:= StrToFloatDef( e03.Text, 0);
    SetLength( asLeyendas, i + 1 );
    asLeyendas[i]:= e13.Text;
    inc( i );
  end;

  if e04.Text <> '' then
  begin
    SetLength( arValores, i + 1 );
    arValores[i]:= StrToFloatDef( e04.Text, 0);
    SetLength( asLeyendas, i + 1 );
    asLeyendas[i]:= e14.Text;
    inc( i );
  end;


  if e05.Text <> '' then
  begin
    SetLength( arValores, i + 1 );
    arValores[i]:= StrToFloatDef( e05.Text, 0);
    SetLength( asLeyendas, i + 1 );
    asLeyendas[i]:= e15.Text;
    inc( i );
  end;

  if e06.Text <> '' then
  begin
    SetLength( arValores, i + 1 );
    arValores[i]:= StrToFloatDef( e06.Text, 0);
    SetLength( asLeyendas, i + 1 );
    asLeyendas[i]:= e16.Text;
    inc( i );
  end;

  if e07.Text <> '' then
  begin
    SetLength( arValores, i + 1 );
    arValores[i]:= StrToFloatDef( e07.Text, 0);
    SetLength( asLeyendas, i + 1 );
    asLeyendas[i]:= e17.Text;
    inc( i );
  end;

  if e08.Text <> '' then
  begin
    SetLength( arValores, i + 1 );
    arValores[i]:= StrToFloatDef( e08.Text, 0);
    SetLength( asLeyendas, i + 1 );
    asLeyendas[i]:= e18.Text;
    inc( i );
  end;

  if e09.Text <> '' then
  begin
    SetLength( arValores, i + 1 );
    arValores[i]:= StrToFloatDef( e09.Text, 0);
    SetLength( asLeyendas, i + 1 );
    asLeyendas[i]:= e19.Text;
  end;
end;

end.
