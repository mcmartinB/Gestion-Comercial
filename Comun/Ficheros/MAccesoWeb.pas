unit MAccesoWeb;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db, ExtCtrls,
  StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BSpeedButton, Grids,
  DBGrids, BGridButton, BGrid, BDEdit, ComCtrls, BEdit, dbTables, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlue, dxSkinFoggy, Menus, cxButtons, cxLabel,
  dxGDIPlusClasses, dxSkinBlueprint, dxSkinMoneyTwins;

type
  TFMAccesoWeb = class(TMaestro)
    Panel: TPanel;
    cxLabel1: TcxLabel;
    cxAcceso: TcxButton;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure cxAccesoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cxImage1Click(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;

  public
    { Public declarations }

  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CReportes,
  CAuxiliarDB, Principal, LBancos, DError, DPreview, bSQLUtils, UrlMon;

{$R *.DFM}

procedure TFMAccesoWeb.Button1Click(Sender: TObject);
var sDireccion : String;
begin
  sDireccion := 'http://comer.bonnysa.net';
  HLinkNavigateString(NIL, PWideChar(WideString(sDireccion)) );
end;

procedure TFMAccesoWeb.cxAccesoClick(Sender: TObject);
var sDireccion : String;
begin
  sDireccion := 'http://comer.bonnysa.net';
  HLinkNavigateString(NIL, PWideChar(WideString(sDireccion)) );
  Close;
end;

procedure TFMAccesoWeb.cxImage1Click(Sender: TObject);
begin

end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMAccesoWeb.FormCreate(Sender: TObject);
begin

     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
//  PanelMaestro := PMaestro;


     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
end;

{+ CUIDADIN }

procedure TFMAccesoWeb.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_SHOWNORMAL);
     //Formulario activo
  M := self;
  MD := nil;
     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMAccesoWeb.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMAccesoWeb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Liberamos recursos
  Lista.Free;

     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMAccesoWeb.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
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
  end;
end;


{+}//Sustituir por funcion generica

procedure TFMAccesoWeb.ValidarEntradaMaestro;
var i: Integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Required and (Trim(Text) = '') then
        begin
          if Trim(RequiredMsg) <> '' then
            raise Exception.Create(RequiredMsg)
          else
            raise Exception.Create('Faltan datos de obligada inserción.');
        end;

      end;
    end;
  end;
end;


procedure TFMAccesoWeb.RequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
  isTime := false;
  if TBEdit(Sender).CanFocus then
  begin
    if (Estado = teLocalizar) then
      Exit;
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
    isTime := true;
  end;
end;

procedure TFMAccesoWeb.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewHeight < 35 then
  begin
    ShowWindow(Application.Handle, SW_SHOWMINNOACTIVE);
    Resize := False;
  end;
end;

end.
