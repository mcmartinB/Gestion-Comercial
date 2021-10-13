unit CFLFacturasDepositoAduanas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils, DBCtrls;

type
  TFLFacturasDepositoAduanas = class(TForm)
    ListaAcciones: TActionList;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label1: TLabel;
    eEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    BCBDesde: TBCalendarButton;
    eFechaDesde: TBEdit;
    Desde: TLabel;
    Label14: TLabel;
    eFechaHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    btnBDFacturas: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lblNombre1: TLabel;
    eCentro: TBEdit;
    BGBCentro: TBGridButton;
    stCentro: TStaticText;
    lblCarpeta: TLabel;
    edtCarpeta: TBEdit;
    btnBAceptar: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnBAceptarClick(Sender: TObject);
    procedure btnBDFacturasClick(Sender: TObject);

  private
    sCarpeta: string;
    sEmpresa, sCentro: string;
    dFechaDesde, dFechaHasta: TDateTime;

    function  LeerParametros: Boolean;
  public

  end;

var
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview, CAuxiliarDB, UDMBaseDatos, bDialogs,
    bMath, bTimeUtils, CDLFacturasDepositoAduanas, CRLFacturasDepositoAduanas,
    CRLFacturasDepositoAduanasExtend;

{$R *.DFM}

//                       ****  BOTONES  ****

function  TFLFacturasDepositoAduanas.LeerParametros: Boolean;
begin
  result:= False;
  if stEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
    Exit;
  end;
  sEmpresa := Trim(eEmpresa.Text);

  if stCentro.Caption = '' then
  begin
    ShowMessage('Falta el código del centro o es incorrecto.');
    Exit;
  end;
  sCentro := eCentro.Text;

  sCarpeta:= Trim( edtCarpeta.Text );

  if not TryStrToDate( eFechaDesde.Text, dFechaDesde ) then
  begin
    ShowMessage('Fecha de inicio incorrecta');
    Exit;
  end;
  if not TryStrToDate( eFechaHasta.Text, dFechaHasta ) then
  begin
    ShowMessage('Fecha de fin incorrecta');
    Exit;
  end;
  if dFechaDesde > dFechaHasta then
  begin
    if dFechaDesde < StrToDate('1/7/2001') then
    begin
      ShowMessage('La fecha de fin debe ser mayor que ''1/7/2001''. ');
      Exit;
    end
    else
    begin
      ShowMessage('La fecha de fin debe ser meyor que la de inicio. ');
      Exit;
    end;
  end;

  result:= True;
end;

procedure TFLFacturasDepositoAduanas.btnBDFacturasClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if LeerParametros then
  begin
    //Recoger datos
    if DLFacturasDepositoAduanas.AbrirQuery( sEmpresa, sCentro, dFechaDesde, dFechaHasta, sCarpeta ) then
    begin
      //Previsualizar informe
      try
        CRLFacturasDepositoAduanas.Previsualizar( self, sEmpresa, sCentro, dFechaDesde, dFechaHasta );
      finally
        DLFacturasDepositoAduanas.CerrarQuery;
      end;
    end
    else
    begin
      ShowMessage('Sin datos para los paremtros seleccionados.' );
      DLFacturasDepositoAduanas.CerrarQuery;
    end;
  end;
end;

procedure TFLFacturasDepositoAduanas.btnBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if LeerParametros then
  begin
    //Recoger datos
    if DLFacturasDepositoAduanas.AbrirQueryExtend( sEmpresa, sCentro, dFechaDesde, dFechaHasta, sCarpeta ) then
    begin
      //Previsualizar informe
      try
        CRLFacturasDepositoAduanasExtend.Previsualizar( self, sEmpresa, sCentro, dFechaDesde, dFechaHasta );
      finally
        DLFacturasDepositoAduanas.CerrarQueryExtend;
      end;
    end
    else
    begin
      ShowMessage('Sin datos para los paremtros seleccionados.' );
      DLFacturasDepositoAduanas.CerrarQueryExtend;
    end;
  end;
end;

procedure TFLFacturasDepositoAduanas.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLFacturasDepositoAduanas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CalendarioFlotante.Date := Date;
    gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;


  eEmpresa.Text := '050';
  eCentro.Text := '6';
  eFechaDesde.Text := DateTostr( Date - 7);
  eFechaHasta.Text := DateTostr( Date - 1);
  (*
  eFechaDesde.Text := DateTostr(LunesAnterior(Date) - 7);
  eFechaHasta.Text := DateTostr(LunesAnterior(Date) - 1);
  *)


  PonNombre( eEmpresa );

  DLFacturasDepositoAduanas:= TDLFacturasDepositoAduanas.Create( self );
end;

procedure TFLFacturasDepositoAduanas.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TFLFacturasDepositoAduanas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
  end;
end;

procedure TFLFacturasDepositoAduanas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');

  FreeAndNil( DLFacturasDepositoAduanas );
  Action := caFree;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLFacturasDepositoAduanas.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(BGBCentro, [eEmpresa.Text]);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLFacturasDepositoAduanas.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
    begin
      STEmpresa.Caption := desEmpresa(eEmpresa.Text);
      PonNombre( eCentro );
    end;
    kCentro:
    begin
      stCentro.Caption := desCentro(eEmpresa.Text, eCentro.Text);
    end;
  end;
end;

end.
