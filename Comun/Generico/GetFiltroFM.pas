unit GetFiltroFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BEdit, BDEdit, Menus, Contnrs, Buttons, ExtCtrls;

type
  //EInputsType = (itInteger,itReal,itChar,itDate,itHour,itBoolean);

  TMiComboBox = class (TComboBox)
  private
    bDefaultValue: boolean;
    sTrue: string;
    sFalse: string;
  end;

  TFMGetFiltro = class(TForm)
    MiPopupMenu: TPopupMenu;
    mnuMayor: TMenuItem;
    mnuiMayorIgual: TMenuItem;
    mnuMenor: TMenuItem;
    mnuMenorIgual: TMenuItem;
    mnuLista: TMenuItem;
    mnuRango: TMenuItem;
    mnuIsNULL: TMenuItem;
    mnuIsNotNULL: TMenuItem;
    Igual1: TMenuItem;
    mnuContiene: TMenuItem;
    Diferente1: TMenuItem;
    Shape: TShape;
    lblTitulo: TLabel;
    Bevel: TBevel;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuClick(Sender: TObject);
    procedure MiPopupMenuPopup(Sender: TObject);

  private
    { Private declarations }
    ListaComponentes: TComponentList;
    iCamposCount, iMinCampos: Integer;

    function  GetFiltro( var AFiltro: string): boolean;
    procedure LimpiarCampos;

    procedure RepaintForm;
    procedure AddLabels( ANombre, ATitulo: string  );
    procedure AddMarca( AControl: TWinControl; ANombre: string; AObligatorio: boolean  );
    function  AddEdit( ANombre: string; AMaxLen, AMaxDecimals: integer;
                       ATipo: EInputsType; AObligatorio: boolean  ): TWinControl;
    function  AddCombo( ANombre: string; AObligatorio: boolean; ADefaultValues: Boolean;
                        ATrueValue, AFalseValue: String ): TWinControl;
    procedure ShowComponent( var AControl: TWinControl; ATitulo: string );
    procedure AddButton( ANombre, ATitulo: string );

    procedure OpcionClick(Sender: TObject);
    procedure PutOpcion( var AButton: TSpeedButton; const AOpcion: Integer );
    function  StrOpcion( const AOpcion: integer ): string;
    function  StrOperator( var AComponte: TBEdit ): string;
    function  StrSQLValue( var AComponte: TBEdit; const ATipo: Integer ): string;
    function  StrBoolean( var AComponte: TMiComboBox ): string;

  public
    { Public declarations }
    bAceptar: boolean;
    sFiltro: string;
    iAncho: integer;

    procedure Configurar( ATitulo: string; AMinCampos: integer );
    procedure AddInteger( ANombre, ATitulo: string; AMaxLen: integer;
                          AObligatorio: boolean  );
    procedure AddReal( ANombre, ATitulo: string; AMaxLen, ADecimales: integer;
                       AObligatorio: boolean  );
    procedure AddChar( ANombre, ATitulo: string;
                       AMaxLen: integer; AObligatorio: boolean  );
    procedure AddDate( ANombre, ATitulo: string; AObligatorio: boolean  );
    procedure AddHour( ANombre, ATitulo: string; AObligatorio: boolean  );
    procedure AddBoolean( ANombre, ATitulo: string; AObligatorio: boolean;
                        ADefaultValues: Boolean; ATrueValue, AFalseValue: String );

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
  iAncho:= Width;
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
    //ShowMessage( sFiltro );
    bAceptar:= True;
    Close;
  end;
end;

procedure TFMGetFiltro.FormShow(Sender: TObject);
begin
  TBEdit( ListaComponentes.Items[0] ).SetFocus;

  if Owner is TForm then
  begin
    Top:= ( Application.MainForm.Top + TForm( Owner ).Top ) + 100;
    Left:= ( Application.MainForm.Left + TForm( Owner ).Left ) + 10 ;
  end;
  if Width <> iAncho then
  begin
    Width:= iAncho;
    Shape.Width:= iAncho;
    lblTitulo.Width:= iAncho;
    btnCancelar.Left:= iAncho - btnCancelar.Width - 20;
    btnAceptar.Left:= btnCancelar.Left - btnAceptar.Width - 3;
  end;
end;

procedure TFMGetFiltro.btnCancelarClick(Sender: TObject);
begin
  bAceptar:= False;
  Close;
end;

procedure TFMGetFiltro.Configurar( ATitulo: string; AMinCampos: integer );
begin
  Caption:= '    ' + UpperCase( ATitulo );
  lblTitulo.Caption:= UpperCase( ATitulo );
  iMinCampos:= AMinCampos;
end;

function Longitud( const ATipo: EInputsType; const AMaxLen: integer ): integer;
begin
  result:= 100;
  case ATipo of
    itInteger,
    itReal:    case AMaxLen of
                 0: result:= 100;
                 else result:= 14 + ( ( AMaxLen - 1 ) * 7 );
               end;
    itChar:    case AMaxLen of
                 0: result:= 100;
                 1: result:= 16;
                 2: result:= 25;
                 3: result:= 34;
                 else result:= 34 + ( ( AMaxLen - 3 ) * 7 );
               end;
    itDate:    result:= 67;
    itHour:    result:= 50;
    itBoolean: result:= 14;
  end;
end;

procedure TFMGetFiltro.AddInteger( ANombre, ATitulo: string; AMaxLen: integer; AObligatorio: boolean  );
var
  eAux: TWinControl;
begin
  AddLabels( ANombre, ATitulo  );
  eAux:= AddEdit( ANombre, AMaxLen, 0, itInteger, AObligatorio );
  ShowComponent( eAux, ATitulo );
  AddMarca( eAux, ANombre, AObligatorio  );
  AddButton( ANombre, ATitulo );
  RepaintForm;
end;

procedure TFMGetFiltro.AddReal( ANombre, ATitulo: string; AMaxLen, ADecimales: integer; AObligatorio: boolean  );
var
  eAux: TWinControl;
begin
  AddLabels( ANombre, ATitulo );
  eAux:= AddEdit( ANombre, AMaxLen, ADecimales, itReal, AObligatorio );
  ShowComponent( eAux, ATitulo );
  AddMarca( eAux, ANombre, AObligatorio  );
  AddButton( ANombre, ATitulo );
  RepaintForm;
end;

procedure TFMGetFiltro.AddChar( ANombre, ATitulo: string; AMaxLen: integer; AObligatorio: boolean  );
var
  eAux: TWinControl;
begin
  AddLabels( ANombre, ATitulo  );
  eAux:= AddEdit( ANombre, AMaxLen, 0, itChar, AObligatorio );
  ShowComponent( eAux, ATitulo );
  AddMarca( eAux, ANombre, AObligatorio  );
  AddButton( ANombre, ATitulo );
  RepaintForm;
end;

procedure TFMGetFiltro.AddDate( ANombre, ATitulo: string; AObligatorio: boolean  );
var
  eAux: TWinControl;
begin
  AddLabels( ANombre, ATitulo  );
  eAux:= AddEdit( ANombre, 10, 0, itDate, AObligatorio );
  ShowComponent( eAux, ATitulo );
  AddMarca( eAux, ANombre, AObligatorio  );
  AddButton( ANombre, ATitulo );
  RepaintForm;
end;

procedure TFMGetFiltro.AddHour( ANombre, ATitulo: string; AObligatorio: boolean  );
var
  eAux: TWinControl;
begin
  AddLabels( ANombre, ATitulo  );
  eAux:= AddEdit( ANombre, 8, 0, itHour, AObligatorio );
  ShowComponent( eAux, ATitulo );
  AddMarca( eAux, ANombre, AObligatorio  );
  AddButton( ANombre, ATitulo );
  RepaintForm;
end;

procedure TFMGetFiltro.AddBoolean( ANombre, ATitulo: string; AObligatorio: boolean;
                                   ADefaultValues: Boolean; ATrueValue, AFalseValue: String );
var
  eAux: TWinControl;
begin
  AddLabels( ANombre, ATitulo );
  eAux:= AddCombo( ANombre, AObligatorio, ADefaultValues, ATrueValue, AFalseValue );
  ShowComponent( eAux, ATitulo );
  RepaintForm;
end;

function TFMGetFiltro.AddEdit( ANombre: string; AMaxLen, AMaxDecimals: integer;
                               ATipo: EInputsType; AObligatorio: boolean  ): TWinControl;
var
  eAux: TBEdit;
begin
  eAux:= TBEdit.Create( self );
  eAux.Parent:= self;
  eAux.Name:= ANombre;

  eAux.InputType:= ATipo;
  eAux.MaxLength:= AMaxLen;
  eAux.MaxDecimals:= AMaxDecimals;
  eAux.PopupMenu:= MiPopupMenu;

  if AObligatorio then
     eAux.Tag:= 1
  else
    eAux.Tag:= 0;

  result:= eAux;
  ListaComponentes.Add( eAux );
end;

function TFMGetFiltro.AddCombo( ANombre: string; AObligatorio: boolean; ADefaultValues: Boolean;
                                ATrueValue, AFalseValue: String  ): TWinControl;
var
  eAux: TMiComboBox;
begin
  eAux:= TMiComboBox.Create( self );
  eAux.Parent:= self;
  eAux.Name:= ANombre;

  eAux.Items.Add('SI');
  eAux.Items.Add('NO');
  
  eAux.Style:= csDropDownList;
  if AObligatorio then
  begin
    eAux.ItemIndex:= 0;
    eAux.Tag:= 1;
  end
  else
  begin
    eAux.Items.Add('INDIFERENTE');
    eAux.ItemIndex:= 2;
    eAux.Tag:= 0;
  end;

  eAux.bDefaultValue:= ADefaultValues;
  if not ADefaultValues then
  begin
    eAux.sTrue:= ATrueValue;
    eAux.sFalse:= AFalseValue;
  end;

  result:= eAux;
  ListaComponentes.Add( eAux );
end;

procedure TFMGetFiltro.ShowComponent( var AControl: TWinControl; ATitulo: string  );
begin
  AControl.Top:= 40 + ( iCamposCount * 25 );
  AControl.Left:= 140;
  if AControl is TBEdit then
  begin
    if TBEdit( AControl ).MaxLength > 50 then
      AControl.Width:= Longitud( TBEdit( AControl ).InputType, 50 )
    else
      AControl.Width:= Longitud( TBEdit( AControl ).InputType, TBEdit( AControl ).MaxLength );
  end
  else
  begin
    AControl.Width:= 100;
  end;

  if iAncho < AControl.Left + AControl.Width + 20 then
    iAncho:= AControl.Left + AControl.Width + 20;

  AControl.Hint:= ATitulo;
  AControl.ShowHint:= True;
  TMiComboBox( AControl ).Show;
end;

procedure TFMGetFiltro.AddLabels( ANombre, ATitulo: string );
begin
  with TLabel.Create( self ) do
  begin
    Parent:= self;
    AutoSize:= False;
    Top:= 40 + ( iCamposCount * 25 );
    Left:= 10;
    Width:= 100;
    Height:= 21;
    Name:= 'lbl' + ANombre;
    Caption:= ' ' + ATitulo;
    Layout:= tlCenter;
    color:= clAppWorkSpace;
    Show;
  end;
end;

procedure TFMGetFiltro.AddMarca( AControl: TWinControl; ANombre: string; AObligatorio: boolean  );
begin
  if AObligatorio then
  begin
    with TLabel.Create( self ) do
    begin
      Parent:= self;
      Top:= 40 + ( iCamposCount * 25 );
      Left:= AControl.Left + AControl.Width + 1;
      Name:= 'lbl' + ANombre + '_asterisco';
      Caption:= '*';
      Font.Color:= clRed;
      Font.Style:= Font.Style + [fsBold];
      Show;
    end;
  end;
end;

procedure TFMGetFiltro.AddButton( ANombre, ATitulo: string );
begin
  with TSpeedButton.Create( self ) do
  begin
    Parent:= self;
    Top:= 40 + ( iCamposCount * 25 );
    Left:= 112 + 1;
    Width:= 24;
    Height:= 21;
    Name:= 'btn' + ANombre + '_opcion';
    Caption:= '=';
    Font.Color:= clNavy;
    Font.Style:= Font.Style + [fsBold];
    Flat:= True;
    OnClick:= OpcionClick;
    Show;
  end;
end;


procedure TFMGetFiltro.RepaintForm;
begin
  //Tamaño formulario y posicion botones
  btnAceptar.Top:= 70 + ( iCamposCount * 25 );
  btnCancelar.Top:= 70 + ( iCamposCount * 25 );
  Height:= 120 + ( iCamposCount * 25 );

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
  cAux: TComponent;
begin
  for i:= 0 to ListaComponentes.Count - 1 do
  begin
    TBEdit( ListaComponentes.Items[i] ).Text:= '';
    cAux:= FindComponent( 'btn' + TBEdit( ListaComponentes.Items[i] ).Name + '_opcion' );
    if cAux <> nil then
    begin
      if cAux is TSpeedButton then
        PutOpcion( TSpeedButton( cAux ), 0 );
    end;
  end;
end;

function TFMGetFiltro.StrOperator( var AComponte: TBEdit ): string;
var
  cAux: TComponent;
begin
  cAux:= FindComponent( 'btn' + AComponte.Name + '_opcion' );
  if cAux <> nil then
  begin
    case cAux.Tag of
      0: //Igual
        result:= AComponte.Name + ' = ' + StrSQLValue( AComponte, 0 );
      1: //Distinto
        result:= AComponte.Name + ' <> ' + StrSQLValue( AComponte, 1 );
      2: //Mayor
        result:= AComponte.Name + ' > ' + StrSQLValue( AComponte, 2 );
      3: //Mayor-Igual
        result:= AComponte.Name + ' >= ' + StrSQLValue( AComponte, 3 );
      4: //Menor
        result:= AComponte.Name + ' < ' + StrSQLValue( AComponte, 4 );
      5: //Menor-Igual
        result:= AComponte.Name + ' <= ' + StrSQLValue( AComponte, 5 );
      6: //Lista
        result:= AComponte.Name + ' = ' + StrSQLValue( AComponte, 6 ) + ' OR' + AComponte.Name + ' = ' + StrSQLValue( AComponte, 5 );
      7: //Rango
        result:= AComponte.Name + ' BETWEEN ' + StrSQLValue( AComponte, 7 ) + ' AND ' + StrSQLValue( AComponte, 6 );
      8: //Contiene
        result:= AComponte.Name + ' LIKE ' + StrSQLValue( AComponte, 8 );
      9: //Is null
        result:= AComponte.Name + ' IS NULL ';
      10: //is not null
        result:= AComponte.Name + ' IS NOT NULL ';
    end;
  end;
end;

function TFMGetFiltro.StrSQLValue( var AComponte: TBEdit; const ATipo: Integer ): string;
begin
  case AComponte.InputType of
    itInteger, itReal:
      result:= Trim(AComponte.Text);
    itChar:
      if ATipo = 8 then
        result:= QuotedStr( '%' + Trim(AComponte.Text) + '%' )
      else
        result:= QuotedStr( Trim(AComponte.Text) );
    itDate, itHour:
      result:= QuotedStr( Trim(AComponte.Text) );
    itBoolean: ;//Nada
  end;

end;

function TFMGetFiltro.StrBoolean( var AComponte: TMiComboBox ): string;
begin
  if AComponte.bDefaultValue then
  begin
      if AComponte.Tag = 0 then
      begin
        result:= '1';
      end
      else
      if AComponte.Tag = 1 then
      begin
        result:= '0';
      end;
  end
  else
  begin
      if AComponte.Tag = 0 then
      begin
        result:= QuotedStr( AComponte.sTrue );
      end
      else
      if AComponte.Tag = 1 then
      begin
        result:= QuotedStr( AComponte.sFalse );
      end
  end;
  result:= ' ' + AComponte.Name + ' = ' + result;
end;

function TFMGetFiltro.GetFiltro( var AFiltro: string): boolean;
var
  eAux: TWinControl;
  bAux: TBEdit;
  cAux: TMiComboBox;
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
    if eAux is TBEdit then
    begin
      bAux:= TBEdit( eAux );
      if Trim( bAux.Text ) <> '' then
      begin
        inc( iCampos );
        if result then
          AFiltro:= AFiltro + ' and ' +  StrOperator ( bAux )
        else
          AFiltro:= ' Where ' + StrOperator ( bAux );
        result:= True;
      end
      else
      if bAux.Tag = 1 then
      begin
        sAux:= sAux + 'El campo ' + bAux.Hint + ' es de obligada inserción.' + #13 + #10;
      end;
    end
    else
    if eAux is TMiComboBox then
    begin
       cAux:= TMiComboBox( eAux );
       if cAux.Tag < 2 then
       begin
         if result then
           AFiltro:= AFiltro + ' and ' +  StrBoolean ( cAux )
         else
           AFiltro:= ' Where ' + StrBoolean ( cAux );
         result:= True;
       end;
    end;
  end;

  if ( sAux <> '' ) or ( iCampos < iMinCampos ) then
  begin
    if iCampos < iMinCampos then
    begin
      sAux:= sAux + 'Es necesario que ponga valor como minimo a ' + IntToStr( iMinCampos ) + ' campos.' + #13 + #10;
    end;
    ShowMessage( sAux );
    result:= False;
  end
  else
  begin
    result:= True;
  end;
end;

function TFMGetFiltro.StrOpcion( const AOpcion: integer ): string;
begin
  case AOpcion of
    0: //Igual
      result:= '=';
    1: //Diferente
      result:= '<>';
    2: //Mayor
      result:= '>';
    3: //Mayor-Igual
      result:= '>=';
    4: //Menor
      result:= '<';
    5: //Menor-Igual
      result:= '<=';
    6: //Lista
      result:= ';';
    7: //Rango
      result:= ':';
    8: //Contiene
      result:= 'L';
    9: //Is null
      result:= '..';
    10: //is not null
      result:= '..';
  end;
end;

procedure TFMGetFiltro.PutOpcion( var AButton: TSpeedButton; const AOpcion: Integer );
begin
  AButton.Caption:= StrOpcion( AOpcion );
  AButton.Tag:= AOpcion;
end;

procedure TFMGetFiltro.mnuClick(Sender: TObject);
var
  cAux1: TComponent;
begin
  if ActiveControl <> nil then
  begin
    cAux1:= FindComponent( 'btn' + ActiveControl.Name + '_opcion' );
    if cAux1 <> nil then
    if cAux1 is TSpeedButton then
    begin
      PutOpcion( TSpeedButton( cAux1), TMenuItem( Sender ).Tag );
      if TMenuItem( Sender ).Tag = 9 then
      begin
         if ActiveControl is TBedit then
         begin
           TBEdit( ActiveControl ).Text:= 'IS NULL';
           TBEdit( ActiveControl ).ReadOnly:= True;
         end;
      end
      else
      if TMenuItem( Sender ).Tag = 10 then
      begin
         if ActiveControl is TBedit then
         begin
           TBEdit( ActiveControl ).Text:= 'IS NOT NULL';
           TBEdit( ActiveControl ).ReadOnly:= True;
         end;
      end
      else
      begin
         if ActiveControl is TBedit then
         begin
           TBEdit( ActiveControl ).ReadOnly:= False;
           //fgdf
         end;
      end;
    end;
  end;
end;

procedure TFMGetFiltro.MiPopupMenuPopup(Sender: TObject);
begin
  if ActiveControl <> nil then
  begin
    if ActiveControl is TBEdit then
    begin
      mnuContiene.Enabled:= (ActiveControl as TBEdit).InputType = itChar;
      mnuIsNULL.Enabled:= (ActiveControl as TBEdit).Tag = 0;
      mnuIsNotNULL.Enabled:= (ActiveControl as TBEdit).Tag = 0;
    end;
  end;
end;

procedure TFMGetFiltro.OpcionClick(Sender: TObject);
var
  punto: TPoint;
  sAux: string;
  cAux: TComponent;
begin
  sAux:= TSpeedButton( Sender ).Name;
  sAux:= StringReplace( sAux, 'btn', '', [] );
  sAux:= StringReplace( sAux, '_opcion', '', [] );
  cAux:= FindComponent( sAux );
  if cAux <> nil then
  begin
    if cAux is TBEdit then
    begin
      if TBEdit( cAux ).CanFocus then
      begin
        TBEdit( cAux ).SetFocus;
        punto.X:= TSpeedButton( Sender ).Left;
        punto.Y:= TSpeedButton( Sender ).Top;

        punto:= ClientToScreen( punto );
        MiPopupMenu.Popup( punto.X, punto.Y );
      end;
    end;
  end;
end;

end.
