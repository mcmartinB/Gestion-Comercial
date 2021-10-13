unit DAlbaranesFactura;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids, QuickRpt,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError;

type
  TFDAlbaranesFactura = class(TForm)
    Panel2: TPanel;
    SBAceptar: TSpeedButton;
    SBCancelar: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    STEmpresa: TStaticText;
    ADesplegarRejilla: TAction;
    EEmpresa: TBEdit;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    GBDatos: TGroupBox;
    LAviso: TLabel;
    Query1: TQuery;
    lblFactura: TLabel;
    edtFactura: TBEdit;
    Label1: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
  private
      {private declarations}
    sEmpresa: string;
    iFactura: Integer;
    dFecha: TDateTime;
    function CamposVacios: boolean;

  public
    { Public declarations }
  end;

var
  FDAlbaranesFactura: TFDAlbaranesFactura;

implementation

uses DPreview, CVariables, Principal, CAuxiliarDB, Printers,
  UDMAuxDB, LAlbaranesSalida, FileCtrl, StrUtils,
  UDMBaseDatos, bSQLUtils;

{$R *.DFM}

procedure TFDAlbaranesFactura.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  MEDesde.Text := DateToStr(Date);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  MEDesde.Tag := kCalendar;

  EEmpresa.Text := gsDefEmpresa;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;
end;

procedure TFDAlbaranesFactura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFDAlbaranesFactura.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDAlbaranesFactura.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFDAlbaranesFactura.BBAceptarClick(Sender: TObject);
begin
  if not CamposVacios then
    LAlbaranesSalida.PreviewAlbaranesFactura( sEmpresa, iFactura, dFecha );;
end;

procedure TFDAlbaranesFactura.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa:
      DespliegaRejilla(BGBEmpresa);
    kCalendar:
      DespliegaCalendario(BCBDesde)
  end;
end;

procedure TFDAlbaranesFactura.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
  end;
end;

function TFDAlbaranesFactura.CamposVacios: boolean;
begin
  Result := True;
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    EEmpresa.SetFocus;
  end
  else
  begin
    if edtFactura.Text = '' then
    begin
      ShowError('Es necesario que rellene todos los campos de edición.');
      edtFactura.SetFocus;
    end
    else
    begin
      if MEDesde.Text = '' then
      begin
        ShowError('Es necesario que rellene todos los campos de edición.');
        MEDesde.SetFocus;
      end
      else
      begin
        Result := False;
        sEmpresa:= EEmpresa.Text;
        iFactura:= StrToInt( edtFactura.Text );
        dFecha:= StrToDate(MEDesde.Text);
      end;
    end;
  end;
end;



end.
