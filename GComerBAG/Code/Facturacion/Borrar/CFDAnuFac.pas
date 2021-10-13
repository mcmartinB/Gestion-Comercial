unit CFDAnuFac;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ActnList, StdCtrls, Db, DBTables, ComCtrls, BEdit, BSpeedButton,
  ExtCtrls, nbLabels, bMath, BGridButton, BCalendarButton, BCalendario,
  Grids, DBGrids, BGrid;

const
  kExtension= '.TXT';

type
  TDFDAnuFac = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    empresa: TBEdit;
    fechaFactura: TBEdit;
    lblEmpresa: TnbLabel;
    nbLabel5: TnbLabel;
    btnEmpresa: TBGridButton;
    btnFechaFactura: TBCalendarButton;
    RejillaFlotante: TBGrid;
    Calendario: TBCalendario;
    stEmpresa: TnbStaticText;
    Label1: TLabel;
    nbLabel1: TnbLabel;
    factura: TBEdit;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    abono: TBEdit;
    fechaAbono: TBEdit;
    btnFechaAbono: TBCalendarButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure GetNumeroAbono(Sender: TObject);

  private
    dFechaMinima: TDateTime;

    function  ComprobarParametros( var AMsg: string ):Boolean;
  public

  end;

implementation

uses CGestionPrincipal, CVariables, DPreview, UDMBaseDatos, UDMAuxDB, FileCtrl,
     CAuxiliarDB, IniFiles, CMDAnuFac, UDMConfig;

{$R *.DFM}

procedure TDFDAnuFac.FormCreate(Sender: TObject);
begin
        //Caracteristicas del formulario
  FormType := tfOther;
  BHFormulario;

  empresa.Text := gsDefEmpresa;
  empresa.Tag:= kEmpresa;
  fechaFactura.Tag:= kCalendar;
  fechaAbono.Tag:= kCalendar;
  fechaAbono.Text:= DateToStr( Date );
  Calendario.Date:= Date;

  gRF := RejillaFlotante;
  gCF := Calendario;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  DMDAnuFac:= TDMDAnuFac.Create( self );

  Empresa.ReadOnly:= not DMConfig.EsLaFont;
  if Empresa.Enabled then
    Empresa.Text:= gsDefEmpresa;
end;

procedure TDFDAnuFac.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormType := tfDirector;
  BHFormulario;
  BEMensajes('');
  Action := caFree;

  //Variables globales
  gRF := nil;
  gCF := nil;

  FreeAndNil( DMDAnuFac );
end;

procedure TDFDAnuFac.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    vk_f1:
      begin
        btnAceptar.Click;
      end;
    vk_f2:
      begin
        if empresa.Focused then
          btnEmpresa.Click
        else
        if fechaFactura.Focused then
        begin
          btnFechaFactura.Click;
        end
        else
        begin
          btnFechaAbono.Click;
        end;
      end;
  end;
end;

procedure TDFDAnuFac.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        if (RejillaFlotante.Visible) then
          RejillaFlotante.Hide
        else
          btnCancelar.Click;
      end;
  end;
end;

function TDFDAnuFac.ComprobarParametros( var AMsg: string ):Boolean;
var
  dIni, dFin: TDateTime;
  iIni: integer;

  procedure PonFoco( const AControl: TWinControl );
  begin
    if AControl.CanFocus then
      AControl.SetFocus;
  end;
begin
  result:= False;
  //Empresa
  if Trim( Empresa.Text ) = '' then
  begin
    AMsg:= 'Falta el código de la empresa.';
    PonFoco( Empresa );
    Exit;
  end;
  if STEmpresa.Caption = '' then
  begin
    AMsg:= 'Código de empresa incorrecto.';
    PonFoco( Empresa );
    Exit;
  end;

  //Numero Factura
  if Trim(factura.Text) = '' then
  begin
    AMsg:= 'Falta el número de la factura.';
    PonFoco( factura );
    Exit;
  end;
  if not tryStrToInt( factura.Text, iIni ) then
  begin
    AMsg:= 'Número de la factura a anular incorrecta.';
    PonFoco( factura );
    Exit;
  end;

  //Numero abono
  if Trim(abono.Text) = '' then
  begin
    AMsg:= 'Falta el número del abono, seguramente la factura sea incorrecta.';
    PonFoco( factura );
    Exit;
  end;

  //Rango Fechas
   if Trim(fechaFactura.Text) = '' then
  begin
    AMsg:= 'Falta la fecha de la factura.';
    PonFoco( fechaFactura );
    Exit;
  end;
  if not tryStrToDate( fechaFactura.Text, dIni ) then
  begin
    AMsg:= 'Fecha de la factura a anular incorrecta.';
    PonFoco( fechaFactura );
    Exit;
  end;
  if Trim(fechaAbono.Text) = '' then
  begin
    AMsg:= 'Falta la fecha del abono.';
    PonFoco( fechaAbono );
    Exit;
  end;
  if not tryStrToDate( fechaAbono.Text, dFin ) then
  begin
    AMsg:= 'Fecha del abono a anular incorrecta.';
    PonFoco( fechaAbono );
    Exit;
  end;
  if dFin < dIni then
  begin
    AMsg:= 'La fecha del abono no puede ser menor que la fecha de la factura.';
    PonFoco( fechaFactura );
    Exit;
  end;
  if dFin < dFechaMinima then
  begin
    AMsg:= 'La fecha del abono no puede ser menor que la del ultimo abono grabado (' +
           DateToStr( dFechaMinima) + ').';
    PonFoco( fechaAbono );
    Exit;
  end;

  Result:= true;
  AMsg:= 'Parametros OK';
end;

procedure TDFDAnuFac.btnClick(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;

  case ActiveControl.Tag of
    kEmpresa:
      DespliegaRejilla(btnEmpresa);
    kCalendar:
      if fechaFactura.Focused then
      begin
        DespliegaCalendario(btnFechaFactura);
      end
      else
      begin
        DespliegaCalendario(btnFechaAbono);
      end;
  end;
end;

procedure TDFDAnuFac.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if ComprobarParametros( sMsg ) then
  begin
    if DMDAnuFac.Anular( empresa.Text, StrToInt( factura.Text ), StrToDate( fechaFactura.text ),
                       StrToDate( fechaAbono.text ), sMsg ) then
    begin
      ShowMessage( sMsg );
    end
    else
    begin
      ShowMessage( 'ERROR: ' + sMsg );
    end;
  end
  else
  begin
    ShowMessage( 'ERROR: ' + sMsg );
  end;
end;

procedure TDFDAnuFac.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TDFDAnuFac.empresaChange(Sender: TObject);
begin
  stEmpresa.Caption:= desEmpresa( empresa.Text );
  GetNumeroAbono( sender );
end;

procedure TDFDAnuFac.GetNumeroAbono(Sender: TObject);
var
  dAux: TDateTime;
  iAux: integer;
begin
  if Length( Trim( Empresa.Text ) ) < 3 then
  begin
    abono.Text:= '';
    Exit;
  end;

  if not tryStrToDate( fechaFactura.Text, dAux ) then
  begin
    abono.Text:= '';
    Exit;
  end;

  if not tryStrToInt( factura.Text, iAux ) then
  begin
    abono.Text:= '';
    Exit;
  end;

  iAux:= DMDAnuFac.NumeroAbono( Empresa.Text, iAux, dAux, dFechaMinima);
  if iAux  = -1 then
  begin
    abono.Text:= '';
    Exit;
  end
  else
  begin
    abono.Text:= IntToStr( iAux );
  end;
end;

end.
