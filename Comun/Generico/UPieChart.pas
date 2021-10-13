unit UPieChart;

interface

uses
  Graphics;

procedure PaintPieChart( VCanvas: TCanvas; const ARadio: integer;
                         const AValores: array of real;
                         const ALeyendas: array of string;
                         const ATipoLeyenda: integer = 1 );

implementation

uses
  bMath;

const
  kPieColors: array[0..9] of TColor = ( clYellow, clGreen, clAqua, clRed, clSilver,
                                        clPurple, clOlive, clTeal, clLime, clGray ) ;

procedure Leyenda( VCanvas: TCanvas; const ARadio: integer;
                   const ALeyendas: array of string );
var
  i, iMax: integer;
  iSep, iAlto, iAncho: integer;
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


procedure DrawChart( VCanvas: TCanvas; const ARadio: integer;
                         const AValores: array of real );
var
  i, iMax: integer;
  rAux, rAcum: real;
  arRadianes: array of real;
  iAltura1, iAltura2, iAncho1, iAncho2: Integer;
begin
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
      arRadianes[i]:= bRoundTo( ( rAux * 2 * pi ) / rAcum, -5 );
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

procedure PaintPieChart( VCanvas: TCanvas; const ARadio: integer;
                         const AValores: array of real;
                         const ALeyendas: array of string;
                         const ATipoLeyenda: integer = 1 );
var
  SaveFont: TFont;
  SavePen: TPen;
  SaveBrush: TBrush;
begin
  Savefont  := TFont.Create;
  SavePen   := TPen.Create;
  SaveBrush := TBrush.Create;

  try
    {store Canvas properties}
    Savefont.Assign(VCanvas.Font);
    SavePen.Assign(VCanvas.Pen);
    SaveBrush.Assign(VCanvas.Brush);

    //Limpiar zona de dibujo
    VCanvas.Pen.Color:= clWhite;
    VCanvas.Brush.Color:= clWhite;
    VCanvas.Rectangle( VCanvas.ClipRect );

    //Leyenda
    if ATipoLeyenda = 1 then
      Leyenda( VCanvas, ARadio, ALeyendas );

    //Tarta
    DrawChart( VCanvas, ARadio, AValores );

    {restore old Canvas properties}
    VCanvas.Font.Assign(savefont);
    VCanvas.Pen.Assign(SavePen);
    VCanvas.Brush.Assign(SaveBrush);
  finally
    Savefont.Free;
    SavePen.Free;
    SaveBrush.Free;
  end;
end;

end.

