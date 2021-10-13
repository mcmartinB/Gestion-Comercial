unit GetFiltroFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BEdit, BDEdit, Menus, Contnrs;

type
  //EInputsType = (itInteger,itReal,itChar,itDate,itHour,itBoolean);

  TFMGetFiltro = class(TForm)
    btnAceptar: TButton;
    btnCancelar: TButton;
    MiPopupMenu: TPopupMenu;
    mnuMayor: TMenuItem;
    mnuiMayorIgual: TMenuItem;
    mnuMenor: TMenuItem;
    mnuMenorIgual: TMenuItem;
    mnuLista: TMenuItem;
    mnuRango: TMenuItem;
    mnuIsNULL: TMenuItem;
    mnuNotIsNULL: TMenuItem;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes: TComponentList;
    iCamposCount, iMinCampos: Integer;

    function  GetFiltro( var AFiltro: string): boolean;
    procedure LimpiarCampos;

  public
    { Public declarations }
    bAceptar: boolean;
    sFiltro: string;

    procedure Configurar( ATitulo: string; AMinCampos: integer );
    procedure AddCampo( ANombre, ATitulo: string;
                        ATipo: EInputsType;
                        AMaxLen, ADecimales: integer;
                        AObligatorio: boolean  );
    function  Filtro( var AFiltro: string ): boolean;
  end;

  function  InicializarFiltro ( const AOwner: TComponent ): TFMGetFiltro;
  procedure FinalizarFiltro ( var AFiltro: TFMGetFiltro );


implementation

{$R *.dfm}


function  InicializarFiltro ( const AOwner: TComponent ): TFMGetFiltro;
begin
  result:= TFMGetFiltro.Create( AOwner );
end;

procedure FinalizarFiltro ( var AFiltro: TFMGetFiltro );
begin
  FreeAndNil( AFiltro );
end;

procedure TFMGetFiltro.FormCreate(Sender: TObject);
begin
  bAceptar:= False;
  iCamposCount:= 0;
  ListaComponentes:= TComponentList.Create;
end;

procedure TFMGetFiltro.FormDestroy(Sender: TObject);
begin
  FreeAndNil( ListaComponentes );
end;

procedure TFMGetFiltro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFMGetFiltro.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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
    vk_f5:
      begin
        Key := 0;
        btnAceptar.Click;
      end;
    vk_escape:
      begin
        Key := 0;
        btnCancelar.Click;
      end;
  end;
end;

procedure TFMGetFiltro.btnAceptarClick(Sender: TObject);
begin
  if GetFiltro( sFiltro ) then
  begin
    bAceptar:= True;
    Close;
  end;
end;

procedure TFMGetFiltro.FormShow(Sender: TObject);
begin
  TBEdit( ListaComponentes.Items[0] ).SetFocus;
end;

procedure TFMGetFiltro.btnCancelarClick(Sender: TObject);
begin
  bAceptar:= False;
  Close;
end;

procedure TFMGetFiltro.Configurar( ATitulo: string; AMinCampos: integer );
begin
  Caption:= '    ' + UpperCase( ATitulo );
  iMinCampos:= AMinCampos;
end;

procedure TFMGetFiltro.AddCampo( ANombre, ATitulo: string;
                                 ATipo: EInputsType;
                                 AMaxLen, ADecimales: integer;
                                 AObligatorio: boolean  );
var
  eAux: TBEdit;
begin
  with TLabel.Create( self ) do
  begin
    Parent:= self;
    Top:= 10 + ( iCamposCount * 25 );
    Left:= 10;
    Name:= 'lbl' + ANombre;
    Caption:= ATitulo;
    color:= cl3DLight;
    Width:= 90;
    Show;
  end;
  eAux:= TBEdit.Create( self );
  with eAux do
  begin
    Parent:= self;
    Top:= 10 + ( iCamposCount * 25 );
    Left:= 110;
    Name:= ANombre;
    RequiredMsg:= ATitulo;
    PopupMenu:= MiPopupMenu;
    InputType:= ATipo;
    case ATipo of
      itInteger: MaxLength:= AMaxLen;
      itReal:    begin
                   MaxLength:= AMaxLen;
                   MaxDecimals:= ADecimales;
                 end;
      itChar:    MaxLength:= AMaxLen;
      itDate:    ;//Nada
      itHour:    ;//Nada
      itBoolean: ;//Nada
    end;
    if AObligatorio then
      Tag:= 1
    else
      Tag:= 0;
    Show;
  end;
  ListaComponentes.Add( eAux );
  Inc( iCamposCount );
end;

function TFMGetFiltro.Filtro( var AFiltro: string ): boolean;
begin
  LimpiarCampos;
  ShowModal;
  result:= bAceptar;
  AFiltro:= sFiltro;
end;

procedure TFMGetFiltro.LimpiarCampos;
var
  i: integer;
begin
  for i:= 0 to ListaComponentes.Count - 1 do
  begin
    TBEdit( ListaComponentes.Items[i] ).Text:= '';
  end;
end;


function TFMGetFiltro.GetFiltro( var AFiltro: string): boolean;
var
  eAux: TBEdit;
  i, iCampos: integer;
  sAux: string;
begin
  (* FALTA IMPLEMENTAR CODIGO PARA FILTRO AVANZADO *)
  (* MAYOR/MENOR IGUAL, RANGO, LISTA, NULL, .... *)
  result:= False;
  AFiltro:= '';
  sAux:= '';
  iCampos:= 0;

  for i:= 0 to ListaComponentes.Count - 1 do
  begin
    eAux:= TBEdit( ListaComponentes.Items[i] );
    if Trim( eAux.Text ) <> '' then
    begin
      inc( iCampos );
      if result then
        AFiltro:= AFiltro + ' and ' + eAux.Name + ' = ' + QuotedStr( eAux.Text )
      else
        AFiltro:= ' Where ' + eAux.Name + ' = ' + QuotedStr( eAux.Text );
    end
    else
    if eAux.Tag = 1 then
    begin
      sAux:= sAux + 'El campo ' + eAux.RequiredMsg + ' es de obligada inserción.' + #13 + #10;
    end;
  end;

  if ( sAux <> '' ) or ( iCampos < iMinCampos ) then
  begin
    if iCampos < iMinCampos then
    begin
      sAux:= sAux + 'Es necesario que ponga valor como minimo a ' + IntToStr( iMinCampos ) + ' campos.' + #13 + #10;
    end;
    ShowMessage( sAux );
  end
  else
  begin
    result:= True;
  end;
end;

end.
