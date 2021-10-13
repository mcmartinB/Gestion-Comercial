unit SignatureForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wgssSTU_TLB, ExtCtrls, ActiveX, Math;

type TMyPenData = class
  public
    rdy: WordBool;
    sw: Byte;
    pressure: Word;
    x: Word;
    y: Word;
    Constructor Create(penData: IPenData);
end;

type
  TForm2 = class(TForm)
    Image1: TImage;
  procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    sRuta: string;
    AnchoFirma: Integer;

    function Connect_(usbDevice: IUsbDevice; var AMsg: string ): boolean;
    procedure onPenData(ASender: TObject; const pPenData: IPenData);
    procedure onGetReportException(ASender: TObject; const pException: ITabletEventsException);
    procedure clearScreen();
    function tabletToScreen(penData: TMyPenData) : TPoint;
    function contains(bounds: TRect; point: TPoint) : boolean;
    procedure clickAccept();
    procedure clickClear();
    procedure clickCancel();
    procedure DrawAntialisedLine(Canvas: TCanvas; const AX1, AY1, AX2, AY2: real; const LineColor: TColor);
    procedure saveImage();
    procedure freePoints();

    procedure Limpiar;
  public
    procedure Connect(usbDevice: IUsbDevice);
    function  SilentConnect(usbDevice: IUsbDevice; var AMsg: string): boolean;

end;

TOnClickButton = procedure() of object;

type TMyButton = class
  public
    Bounds : TRect;
    Text   : String;
    Click  : TOnClickButton;
end;

function SignSave( const AOwner: TComponent;const ARuta: string; var AMsg: string ): boolean;

var
  Form2: TForm2;
  Tablet: TTablet;
  Capability: ICapability;
  Information: IInformation;
  screenBmp : TBitmap;
  bitmapData : PSafeArray;
  Buttons: Array of TMyButton;
  encodingMode : byte;
  m_isDown : Integer;
  points : TList;

implementation

{$R *.dfm}

uses
  Jpeg;

function ValidarRuta( const ARutaIn: string; var ARutaOut: string ): boolean;
var
  sFilename: string;
begin
  ARutaOut:= ExtractFilePath( ARutaIn );
  if ARutaOut <> '' then
  begin
    if not DirectoryExists( ARutaOut ) then
    begin
      ARutaOut:= 'ERROR: No existe el directorio "' + ARutaOut + '".';
      Result:= False;
    end
    else
    begin
      if Copy( ARutaOut, Length( ARutaOut ), 1 ) <> '\' then
        ARutaOut:= ARutaOut + '\';
      Result:= True;
    end;
  end
  else
  begin
    Result:= True;
  end;

  if Result then
  begin
    sFilename:= ExtractFileName( ARutaIn );
    if sFilename = '' then
    begin
      sFilename:= 'Sign' + FormatDateTime('yyyymmddhhmmss', Now ) + '.jpg';
    end
    else
    begin
      if Pos( 'JPG', UpperCase(ExtractFileExt(sFilename)) ) = 0 then
      begin
        sFilename:= sFilename + '.jpg';
      end;
    end;
    ARutaOut:= ARutaOut + sFilename;
  end;
end;

function SignSave( const AOwner: TComponent;const ARuta: string; var AMsg: string ): boolean;
var
  usbDevices : IUsbDevices;
  usbDevice  : IUsbDevice;
begin
  Result:= False;
  Form2:= TForm2.Create( AOwner );
  try
    if not ValidarRuta( ARuta, Form2.sRuta ) then
    begin
      AMsg:= Form2.sRuta;
    end
    else
    begin
      usbDevices := CoUsbDevices.Create();
      if (usbDevices.Count > 0) then
      begin
        try
          begin
            usbDevice := usbDevices.Item[0]; //select the first device
            if Form2.SilentConnect(usbDevice, AMsg ) then
            begin
              Form2.ShowModal();
              Result:= True;
            end;
          end;
        except
          on e : Exception do
            AMsg:= e.Message;
        end;
      end
      else
      begin
        AMsg:= 'No encuentro ningun dispositivo STU conectado al equipo.';
      end;
    end;
  finally
    Form2.Limpiar;
    FreeAndNil( Form2 );
  end;
end;

procedure TForm2.Limpiar;
begin
  FreeAndNil( screenBmp );
  freePoints();
  try
    if tablet.isConnected = True then
    begin
      tablet.setClearScreen;
      tablet.disconnect1;
    end;
  except
    on e : Exception do
      ShowMessage(e.Message);
  end;
end;

procedure TForm2.Connect(usbDevice: IUsbDevice);
var
  sMsg: string;
begin
  if not Connect_(usbDevice, sMsg ) then
    raise Exception.Create( sMsg );
end;

function TForm2.SilentConnect(usbDevice: IUsbDevice; var AMsg: string): boolean;
var
  sMsg: string;
begin
  Result:= Connect_(usbDevice, sMsg );
end;

function TForm2.Connect_(usbDevice: IUsbDevice; var AMsg: string ): boolean;
var
  errorCode  : IErrorCode;
  w1, w2, w3 : Integer;
  x, y, h, w : Integer;
  h1, h2, h3 : Integer;
  i : Integer;
  ProtocolHelper: IProtocolHelper;
  bArray : Array of Byte;
  ms : TMemoryStream;
  useColor : boolean;
  fontSize : Integer;
begin
  errorCode := Tablet.usbConnect(usbDevice, True);
  if (errorCode.value = 0) then
  begin
    AMsg:= 'OK';
    Result:= True;
    Capability := Tablet.getCapability();
    Information := Tablet.getInformation();

    Form2.AutoSize := true;
    Image1.Width  := Capability.screenWidth;
    Image1.Height := Capability.screenHeight;

    // Add the delagate that receives pen data.
    Tablet.OnonPenData := onPenData;
    Tablet.OnonGetReportException := onGetReportException;

    SetLength(Buttons, 3);
    for i := 0 to 2 do
      Buttons[i] := TMyButton.Create;

    if (usbDevice.idProduct <> $000a2) then
    begin
      w2 := Capability.screenWidth div 3;
      w3 := Capability.screenWidth div 3;
      w1 := Capability.screenWidth - w2 - w3;
      y  := Capability.screenHeight * 6 div 7;
      h  := Capability.screenHeight - y;

      AnchoFirma:= Capability.screenWidth - w1;

      Buttons[0].Bounds := Rect(0, y, w1, y + h);
      Buttons[1].Bounds := Rect(w1, y, w1 + w2, y + h);
      Buttons[2].Bounds := Rect(w1 + w2, y, w1 + w2 + w3, y + h);

      fontSize := 25;
    end
    else
    begin
      // The STU-300 is very shallow, so it is better to utilise
      // the buttons to the side of the display instead.

      x := Capability.screenWidth * 3 div 4;
      w := Capability.screenWidth - x;

      h2 := Capability.screenHeight div 3;
      h3 := Capability.screenHeight div 3;
      h1 := Capability.screenHeight - h2 - h3;

      Buttons[0].Bounds := Rect(x, 0, x + w, h1);
      Buttons[1].Bounds := Rect(x, h1, x + w, h1 + h2);
      Buttons[2].Bounds := Rect(x, h1 + h2, x + w, h1 + h2 + h3);

      fontSize := 15;
    end;

    Buttons[0].Text := 'OK';
    Buttons[1].Text := 'Clear';
    Buttons[2].Text := 'Cancel';

    Buttons[0].Click := clickAccept;
    Buttons[1].Click := clickClear;
    Buttons[2].Click := clickCancel;

    useColor := (usbDevice.idProduct = $a3); // Only the STU-520A supports colour!

    // Disable color if the STU-520 bulk driver isn't installed.
    // This isn't necessary, but uploading colour images with out the driver
    // is very slow.
    useColor := useColor and Tablet.supportsWrite();

    // Calculate the encodingMode that will be used to update the image
    if (useColor) then
    begin
      if (Tablet.supportsWrite()) then
      begin
        encodingMode := (EncodingMode_16bit_565 or EncodingMode_Bulk);
      end
      else
      begin
        encodingMode := (EncodingMode_16bit_565 or EncodingMode_Raw);
      end
    end
    else
    begin
      encodingMode := EncodingMode_Raw;
    end;

    screenBmp := TBitmap.Create;
    screenBmp.PixelFormat := pf24bit;
    screenBmp.Width := Capability.screenWidth;
    screenBmp.Height := Capability.screenHeight;

    screenBmp.Canvas.Font.Name := 'Courier New';
    screenBmp.Canvas.Font.Color := clBlack;
    screenBmp.Canvas.Font.Size := fontSize;

    with screenBmp.Canvas do
      begin
        Brush.Color := clWhite;
        FillRect(Rect(0, 0, Capability.screenWidth, Capability.screenHeight));

        for i := 0 to 2 do
          begin
            if (useColor) then
            begin
              Brush.Color := clSilver;
            end;  
            rectangle(Buttons[i].Bounds);
            DrawText(Handle, PChar(Buttons[i].Text), Length(Buttons[i].Text), Buttons[i].Bounds, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
          end;
    end;

    // Finally, use this bitmap for the window background.
    Image1.Picture.Bitmap := screenBmp;

    // Now the bitmap has been created, it needs to be converted to device-native
    // format.
    ProtocolHelper := CoProtocolHelper.Create;

    // Unfortunately it is not possible for the native COM component to
    // understand Delphi bitmaps. We have therefore convert the Delphi bitmap
    // into a memory blob that will be understood by COM.
    ms := TMemoryStream.Create;
    try
      screenBmp.SaveToStream(ms);
      ms.Seek(0, 0);
      SetLength(bArray, ms.Size);
      ms.ReadBuffer(bArray[0], Length(bArray));
    finally
      FreeAndNil( ms );
    end;

    bitmapData := ProtocolHelper.resizeAndFlatten(bArray, 0, 0, screenBmp.Width, screenBmp.Height, Capability.screenWidth, Capability.screenHeight, useColor, Scale_Fit, 0, 0);
    protocolHelper := nil;

    // Initialize the screen
    clearScreen();

    // Enable the pen data on the screen (if not already)
    Tablet.setInkingMode(1);

  end
  else
  begin
    AMsg:= errorCode.message;
    Result:= True;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
  Tablet := TTablet.Create(self);
  m_isDown := 0;
  points := TList.Create;
end;

procedure TForm2.onPenData(ASender: TObject; const pPenData: IPenData);
var
  pt     : TPoint;
  prev   : TPoint;
  btn    : Integer;
  i      : Integer;
  isDown : boolean;
begin
  btn := 0; // will be +ve if the pen is over a button.
  pt   := tabletToScreen(TMyPenData.Create(pPenData));

  for i := 0 to 2 do
  begin
    if (contains(Buttons[i].Bounds, pt)) then
    begin
      btn := i+1;
      Break;
    end;
  end;

  isDown := (pPenData.sw <> 0);

  // This code uses a model of four states the pen can be in:
  // down or up, and whether this is the first sample of that state.

  if (isDown) then
  begin
    if (m_isDown = 0) then
    begin
      // transition to down
      if (btn > 0) then
      begin
        // We have put the pen down on a button.
        // Track the pen without inking on the client.
        m_isDown := btn;
      end
      else
      begin
        m_isDown := -1;
      end;
    end
    else
    begin
      // already down, keep doing what we're doing!
    end;

    // draw
    if ((points.Count > 0) and (m_isDown = -1)) then
    begin
      // Draw a line from the previous down point to this down point.
      // This is the simplist thing you can do; a more sophisticated program
      // can perform higher quality rendering than this!

      if (pPenData.sw > 0) then
      begin
        prev := tabletToScreen(TMyPenData(points.Last()));
        DrawAntialisedLine(Image1.Canvas, prev.X, prev.Y, pt.X, pt.Y, clBlack);
      end;
    end;

    // The pen is down, store it for use later.
    if (m_isDown = -1) then
    begin
      points.Add(TMyPenData.Create(pPenData));
    end;
  end
  else
  begin
    if (m_isDown <> 0) then
    begin
      // transition to up
      if (btn > 0) then
      begin
        // The pen is over a button
        if (btn = m_isDown) then
        begin
          // The pen was pressed down over the same button as is was lifted now.
          // Consider that as a click!
          Buttons[btn - 1].Click();
        end;
      end;
      m_isDown := 0;
    end
    else
    begin
      // still up
    end;

    // Add up data once we have collected some down data.
    if (points.Count > 0) then
      points.Add(TMyPenData.Create(pPenData));
  end;

end;

procedure TForm2.clearScreen();
begin
  // note: There is no need to clear the tablet screen prior to writing an image.
  Tablet.writeImage(encodingMode, bitmapData);
  Image1.Picture.Bitmap := screenBmp;
  freePoints();
end;

function TForm2.tabletToScreen(penData: TMyPenData) : TPoint;
begin
  Result := Point(penData.x * Capability.screenWidth div Capability.tabletMaxX, penData.y * Capability.screenHeight div Capability.tabletMaxY);
end;

function TForm2.contains(bounds: TRect; point: TPoint) : boolean;
begin
  if (((point.X >= bounds.Left) and (point.X <= bounds.Right)) and ((point.Y >= bounds.Top) and (point.Y <= bounds.Bottom))) then
  begin
      Result := true;
  end
  else
  begin
    Result := false;
  end
end;

procedure TForm2.clickAccept();
begin
  // You probably want to add additional processing here.
  if (points.Count > 0) then
  begin
    try
      saveImage();
    finally
      Form2.Close;
    end;
  end;
end;

procedure TForm2.clickClear();
begin
  if (points.Count > 0) then
  begin
    clearScreen();
  end;
end;

procedure TForm2.clickCancel();
begin
  // You probably want to add additional processing here.
  Form2.Close;
end;

procedure TForm2.onGetReportException(ASender: TObject; const pException: ITabletEventsException);
begin
  try
    pException.getException;
  except
    on e : Exception do
    begin
      Form2.Close();
    end;
  end;
end;

Constructor TMyPenData.Create(penData: IPenData);
begin
  self.rdy      := penData.rdy;
  self.sw       := penData.sw;
  self.pressure := penData.pressure;
  self.x        := penData.x;
  self.y        := penData.y;
end;


procedure TForm2.DrawAntialisedLine(Canvas: TCanvas; const AX1, AY1, AX2, AY2: real; const LineColor: TColor);

var
  swapped: boolean;

  procedure plot(const x, y, c: real);
  var
    resclr: TColor;
  begin
    if swapped then
      resclr := Canvas.Pixels[round(y), round(x)]
    else
      resclr := Canvas.Pixels[round(x), round(y)];
      resclr := RGB(round(GetRValue(resclr) * (1-c) + GetRValue(LineColor) * c),
                    round(GetGValue(resclr) * (1-c) + GetGValue(LineColor) * c),
                    round(GetBValue(resclr) * (1-c) + GetBValue(LineColor) * c));
    if swapped then
      Canvas.Pixels[round(y), round(x)] := resclr
    else
      Canvas.Pixels[round(x), round(y)] := resclr;
  end;

  function rfrac(const x: real): real;
  begin
    rfrac := 1 - frac(x);
  end;

  procedure swap(var a, b: real);
  var
    tmp: real;
  begin
    tmp := a;
    a := b;
    b := tmp;
  end;

var
  x1, x2, y1, y2, dx, dy, gradient, xend, yend, xgap, xpxl1, ypxl1,
  xpxl2, ypxl2, intery: real;
  x: integer;

begin

  x1 := AX1;
  x2 := AX2;
  y1 := AY1;
  y2 := AY2;

  dx := x2 - x1;
  dy := y2 - y1;
  swapped := abs(dx) < abs(dy);
  if swapped then
  begin
    swap(x1, y1);
    swap(x2, y2);
    swap(dx, dy);
  end;
  if x2 < x1 then
  begin
    swap(x1, x2);
    swap(y1, y2);
  end;

  if (dx <> 0) then
  begin
    gradient := dy / dx;
  end
  else
  begin
    gradient := 0;
  end;

  xend := round(x1);
  yend := y1 + gradient * (xend - x1);
  xgap := rfrac(x1 + 0.5);
  xpxl1 := xend;
  ypxl1 := floor(yend);
  plot(xpxl1, ypxl1, rfrac(yend) * xgap);
  plot(xpxl1, ypxl1 + 1, frac(yend) * xgap);
  intery := yend + gradient;

  xend := round(x2);
  yend := y2 + gradient * (xend - x2);
  xgap := frac(x2 + 0.5);
  xpxl2 := xend;
  ypxl2 := floor(yend);
  plot(xpxl2, ypxl2, rfrac(yend) * xgap);
  plot(xpxl2, ypxl2 + 1, frac(yend) * xgap);

  for x := round(xpxl1) + 1 to round(xpxl2) - 1 do
  begin
    plot(x, floor(intery), rfrac(intery));
    plot(x, floor(intery) + 1, frac(intery));
    intery := intery + gradient;
  end;

end;

procedure CropBitmap(InBitmap, OutBitMap : TBitmap; X, Y, W, H :Integer);
begin
  OutBitMap.PixelFormat := InBitmap.PixelFormat;
  OutBitMap.Width  := W;
  OutBitMap.Height := H;
  BitBlt(OutBitMap.Canvas.Handle, 0, 0, W, H, InBitmap.Canvas.Handle, X, Y, SRCCOPY);
end;

procedure TForm2.saveImage();
var
  i: Integer;
  act, prev: TMyPenData;
  bmp, outBmp: TBitmap;
  point1, point2: TPoint;
  JpegImg: TJpegImage;
begin
  with bmp do
  begin
    bmp := TBitmap.Create;
    bmp.PixelFormat := pf24bit;
    bmp.Width := Capability.screenWidth;
    bmp.Height := Capability.screenHeight;
    bmp.Canvas.Font.Color := clBlack;
  end;

  with bmp.Canvas do
  begin
    Brush.Color := clWhite;
    FillRect(Rect(0, 0, Capability.screenWidth, Capability.screenHeight));
  end;

  for i := 1 to points.Count do
  begin
    prev := TMyPenData(points[i-1]);
    if (prev.sw <> 0) then
    begin
      act  := TMyPenData(points[i]);
      point1 := tabletToScreen(prev);
      point2 := tabletToScreen(act);
      DrawAntialisedLine(bmp.Canvas, point1.x, point1.y, point2.x, point2.y, clBlack);
    end;
  end;
  try
    outBmp := TBitmap.Create;
    JpegImg := TJpegImage.Create;

    CropBitmap(bmp, outBmp, 0,0, 300, 100);
    JpegImg.Assign(outBmp) ;

    try
      JpegImg.SaveToFile(sRuta);
    except
      on e: Exception do
      begin
        ShowMessage('ERROR: No puedo grabar el archivo "' + sRuta + '".' + #13 + #10 + e.Message );
        Abort;
      end;
    end;
  finally
    FreeAndNil( JpegImg );
    FreeAndNil( outBmp );
    FreeAndNil( bmp );
  end;
end;

procedure TForm2.freePoints();
var
  i: Integer;
begin
for i := 1 to points.Count do
  begin
    TMyPenData(points[i-1]).Free;
  end;
  points.Clear();
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FreeAndNil( tablet );
  FreeAndNil( points );
end;

procedure TForm2.Image1Click(Sender: TObject);
var
  pt1, pt2 : TPoint;
  i        : Integer;
begin
  pt1 := Mouse.CursorPos;
  pt2 := Point(pt1.x - Image1.ClientOrigin.x,pt1.y - Image1.ClientOrigin.y);

  for i := 0 to 2 do
  begin
    if (contains(Buttons[i].Bounds, pt2)) then
    begin
      Buttons[i].Click();
      Break;
    end;
  end;
end;

end.
