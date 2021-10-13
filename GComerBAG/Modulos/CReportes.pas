unit CReportes;

interface

uses Principal, Dialogs, SysUtils, forms, extctrls, stdctrls, menus, Controls,
  CVariables, printers, registry, classes, windows, Messages,
  BDEdit, StrUtils, QrCtrls, buttons, UDMBasedatos, quickrpt,
  bMath;

procedure PonLogoGrupoBonnysa(AReport: TQuickRep; const AEmpresa: string = 'BAG'; const ATop: integer = 45 ); Overload;
procedure PonLogoFederacionesAgroalicante(AReport: TQuickRep);

function RangoCentros( const AEmpresa, AIni, AFin: string ): string;
function RangoProductos( const AEmpresa, AIni, AFin: string ): string;
function RangoFechas( const AIni, AFin: string ): string;
function RangoClientes( const AEmpresa, AIni, AFin: string ): string;

function CrearPDF(rep: TQuickRep): boolean;

implementation

uses Graphics, UDMAuxDB, UDMConfig;

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



procedure PonCabGrupoBonnysa(AReport: TQuickRep; const AEmpresa: string; const ATop: Integer );
var
  cabHeader: TQRLabel;
  sAux: String;
  i: integer;
begin
  sAux:= desEmpresa( AEmpresa );
  if ( sAux <> '' ) and ( AReport.Bands.HasPageHeader ) then
  begin
    sAux:= AEmpresa + ' ' + sAux;
    cabHeader:= nil;

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

procedure PonLogoGrupoBonnysa(AReport: TQuickRep; const AEmpresa: string = 'BAG'; const ATop: Integer = 45 );
begin
  PonCabGrupoBonnysa( AReport, AEmpresa, ATop );
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
      //Rep.ReportTitle:= StringReplace(Trim(Rep.ReportTitle), ' ', '_', [rfReplaceAll]);
      Rep.ReportTitle:= Trim(Rep.ReportTitle);
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

end.




