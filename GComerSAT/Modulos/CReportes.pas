unit CReportes;

interface

uses Principal, Dialogs, SysUtils, forms, extctrls, stdctrls, menus, Controls,
  CVariables, printers, registry, classes, windows, Messages,
  BDEdit, StrUtils, QrCtrls, buttons, UDMBasedatos, quickrpt,
  bMath;

procedure PonLogoGrupoBonnysa(AReport: TQuickRep ); Overload;
procedure PonLogoGrupoBonnysa(AReport: TQuickRep; const AEmpresa: string; const ATop: integer = 45 ); Overload;
procedure PonLogoFederacionesAgroalicante(AReport: TQuickRep);

function RangoCentros( const AEmpresa, AIni, AFin: string ): string;
function RangoProductos( const AEmpresa, AIni, AFin: string ): string;
function RangoFechas( const AIni, AFin: string ): string;
function RangoClientes( const AEmpresa, AIni, AFin: string ): string;

function  CrearPDF(rep: TQuickRep): boolean;

implementation

uses Graphics, UDMAuxDB, UDMConfig;

function CrearPDF(rep: TQuickRep): boolean;
var
  old_impresora: integer;
begin
  //Escoger impresora de PDF y crear el fichero
  old_impresora := Rep.PrinterSettings.PrinterIndex;

  if giPrintPDF > -1 then begin
    Rep.PrinterSettings.PrinterIndex := giPrintPDF;
    Rep.ShowProgress := False;
    Screen.Cursor := crHourGlass;
    try
      Rep.print;
    except
      Rep.PrinterSettings.PrinterIndex := old_impresora;
      Screen.Cursor := crDefault;
      Result := False;
      Application.ProcessMessages;
      Exit;
    end;
    Rep.PrinterSettings.PrinterIndex := old_impresora;
    Screen.Cursor := crDefault;
    Result := True;
    Application.ProcessMessages;

  end else begin
    Result := False;
  end;
end;

procedure PonLogoFederacionesAgroalicante(AReport: TQuickRep);
var
  logo: TQRImage;
begin
  if AReport.Bands.HasPageHeader then
  begin
    logo := TQRImage.Create(AReport);
    logo.Parent := AReport.Bands.PageHeaderBand;
    logo.Name:= 'Titlelogo';
    logo.Enabled := true;

    logo.Height := 65;
    logo.Width := 209;
    logo.AutoSize := False;
    logo.Stretch := true;
    logo.Left := 0;
    logo.Top := 0;

    if FileExists(gsDirActual + '\recursos\logoAgroalicante.bmp') then
      logo.Picture.LoadFromFile(gsDirActual + '\recursos\logoAgroalicante.bmp');
    logo.SendToBack;
  end;
end;

procedure PonPieGrupoBonnysa(AReport: TQuickRep; const AEmpresa: string = '050' );
var
  logoTitle, logoHeader: TQRImage;
  i, iAncho, iAlto: integer;
  bHeader: Boolean;
begin
  logoTitle:= nil;
  logoHeader:= nil;
  bHeader:= False;
  iAncho:= 0;
  iAlto:= 0;

  if ( AEmpresa = '050' ) or ( AEmpresa = '037' ) or ( AEmpresa = '073' ) or ( AEmpresa = '062' ) then
  begin

    if AReport.Bands.HasPageHeader then
    begin
      bHeader:= True;
      //Existe el componente
      i:= 0;
      logoHeader:= nil;
      while ( i < AReport.Bands.PageHeaderBand.ControlCount ) and ( logoHeader = nil ) do
      begin
        if AReport.Bands.PageHeaderBand.Controls[i].Name = AReport.Bands.PageHeaderBand.Name + 'PieHeader' then
        begin
          logoHeader:= TQRImage( AReport.Bands.PageHeaderBand.Controls[i] );
        end;
        inc(i);
      end;
      if logoHeader = nil then
      begin
        logoHeader := TQRImage.Create(AReport);
        logoHeader.Name:= AReport.Bands.PageHeaderBand.Name + 'PieHeader';
        logoHeader.Parent := AReport.Bands.PageHeaderBand;

        iAncho:= AReport.Bands.PageHeaderBand.Width;
        iAlto:= AReport.Bands.PageHeaderBand.Top;
      end;
    end;
    if AReport.Bands.HasTitle then
    begin
      //Existe el componente
      i:= 0;
      logoTitle:= nil;
      while ( i < AReport.Bands.TitleBand.ControlCount ) and ( logoTitle = nil ) do
      begin
        if AReport.Bands.TitleBand.Controls[i].Name = AReport.Bands.TitleBand.Name + 'PieTitle' then
        begin
          logoTitle:= TQRImage( AReport.Bands.TitleBand.Controls[i] );
        end;
        inc(i);
      end;
      if logoTitle = nil then
      begin
        logoTitle := TQRImage.Create(AReport);
        logoTitle.Name:= AReport.Bands.TitleBand.Name + 'PieTitle';
        logoTitle.Parent := AReport.Bands.TitleBand;
        if not bHeader then
        begin
          iAncho:= AReport.Bands.TitleBand.Width;
          iAlto:= AReport.Bands.TitleBand.Top;
        end;
      end;
    end;

    if logoTitle <> nil then
    begin
      logoTitle.Enabled := true;
      logoTitle.Height := 20;
      logoTitle.Width := 86;
      logoTitle.AutoSize := False;
      logoTitle.Stretch := true;
      logoTitle.Left := iAncho - logoTitle.Width;
      logoTitle.Top := AReport.Height - ( 2 * iAlto );
      if FileExists(gsDirActual + '\recursos\LogoGrupoBonnysa.emf') then
        logoTitle.Picture.LoadFromFile(gsDirActual + '\recursos\LogoGrupoBonnysa.emf');
    end;
    if logoHeader <> nil then
    begin
      logoHeader.Enabled := true;
      logoHeader.Height := 20;
      logoHeader.Width := 86;
      logoHeader.AutoSize := False;
      logoHeader.Stretch := true;
      logoHeader.Left := iAncho - logoHeader.Width;
      logoHeader.Top := AReport.Height - ( 2 * iAlto );
      if FileExists(gsDirActual + '\recursos\LogoGrupoBonnysa.emf') then
        logoHeader.Picture.LoadFromFile(gsDirActual + '\recursos\LogoGrupoBonnysa.emf');
    end;
  end;
end;

procedure PonCabGrupoBonnysa(AReport: TQuickRep; const AEmpresa: string; const ATop: Integer );
var
  cabHeader: TQRLabel;
  sAux: String;
  i: integer;
begin
  sAux:= desEmpresa( AEmpresa );
  cabHeader:= nil;

  if AReport.Bands.HasPageHeader then
  begin
    //Existe el componente
    i:= 0;
    while ( i < AReport.Bands.PageHeaderBand.ControlCount ) and ( cabHeader = nil ) do
    begin
      if AReport.Bands.PageHeaderBand.Controls[i].Name = AReport.Bands.PageHeaderBand.Name + 'CabHeader' then
      begin
        cabHeader:= TQRLabel( AReport.Bands.PageHeaderBand.Controls[i] );
      end;
      inc(i);
    end;

    if cabHeader = nil then
    begin
      cabHeader := TQRLabel.Create(AReport);
      cabHeader.Name:= AReport.Bands.PageHeaderBand.Name + 'CabHeader';
      cabHeader.Parent := AReport.Bands.PageHeaderBand;

      cabHeader.Top:= 45;
      cabHeader.Left:= 5;
      cabHeader.Font.Name:= 'Arial';
      cabHeader.Font.Size:= 12;
      cabHeader.Font.Style:= cabHeader.Font.Style + [fsBold];
      cabHeader.Top:= ATop;
    end;
    cabHeader.Caption:= sAux;
  end;
end;

procedure PonLogoGrupoBonnysa(AReport: TQuickRep );
begin
  PonPieGrupoBonnysa( AReport );
end;

procedure PonLogoGrupoBonnysa(AReport: TQuickRep; const AEmpresa: string; const ATop: Integer = 45 );
begin
  PonCabGrupoBonnysa( AReport, AEmpresa, ATop );
  PonPieGrupoBonnysa( AReport, AEmpresa );
end;

function RangoCentros( const AEmpresa, AIni, AFin: string ): string;
begin
  if ( AIni = AFin ) or ( Trim( AFin ) = '' )  then
  begin
    result:= desCentro( AEmpresa, AIni );
  end
  else
  begin
    result:= 'CENTROS DE ' + AIni + ' A ' + AFin;
  end;
end;

function RangoProductos( const AEmpresa, AIni, AFin: string ): string;
begin
  if ( AIni = AFin ) or ( Trim( AFin ) = '' )  then
  begin
    result:= desProducto( AEmpresa, AIni );
  end
  else
  begin
    result:= 'PRODUCTOS DE ' + AIni + ' A ' + AFin;
  end;
end;

function RangoClientes( const AEmpresa, AIni, AFin: string ): string;
begin
  if ( AIni = AFin ) or ( Trim( AFin ) = '' ) then
  begin
    result:= desCliente( AIni );
  end
  else
  begin
    result:= 'CLIENTES DE ' + AIni + ' A ' + AFin;
  end;
end;

function RangoFechas( const AIni, AFin: string ): string;
begin
  if ( AIni = AFin ) or ( Trim( AFin ) = '' )  then
  begin
    result:= 'FECHA: ' + Aini;
  end
  else
  begin
    result:= 'DEL ' + AIni + ' A ' + AFin;
  end;
end;

end.




