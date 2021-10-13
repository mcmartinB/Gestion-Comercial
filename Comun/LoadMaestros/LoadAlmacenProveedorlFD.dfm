object FDLoadAlmacenProveedor: TFDLoadAlmacenProveedor
  Left = 437
  Top = 245
  Caption = '    Alta Almac'#233'n Proveedor'
  ClientHeight = 178
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lbl2: TLabel
    Left = 36
    Top = 58
    Width = 79
    Height = 19
    AutoSize = False
    Caption = ' Proveedor'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl3: TLabel
    Left = 36
    Top = 18
    Width = 389
    Height = 13
    Caption = 
      'Introduzca el c'#243'digo del almac'#233'n de proveedor que quiere descarg' +
      'ar de la central.'
  end
  object lblAlmacen: TLabel
    Left = 36
    Top = 80
    Width = 79
    Height = 19
    AutoSize = False
    Caption = ' Almac'#233'n'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object btnProveedor: TBGridButton
    Left = 163
    Top = 57
    Width = 13
    Height = 21
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    OnClick = btnGridClick
    Control = btnProveedor
    Grid = bgrdRejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 160
  end
  object lbl4: TLabel
    Left = 36
    Top = 104
    Width = 242
    Height = 13
    Caption = 'NOTA: Si existen los almacenes se sobrescribiran.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object bgrdRejillaFlotante: TBGrid
    Left = 380
    Top = 27
    Width = 94
    Height = 41
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQGeneral
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    ColumnFind = 1
  end
  object btnAceptar: TButton
    Left = 246
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    ModalResult = 6
    TabOrder = 5
  end
  object btnCancelar: TButton
    Left = 323
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 7
    TabOrder = 6
  end
  object txtProveedor: TStaticText
    Left = 177
    Top = 59
    Width = 209
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 2
  end
  object edtCodigo: TBEdit
    Left = 121
    Top = 57
    Width = 30
    Height = 21
    MaxLength = 3
    TabOrder = 1
    OnChange = edtCodigoChange
  end
  object edtAlmacen: TBEdit
    Left = 121
    Top = 79
    Width = 30
    Height = 21
    MaxLength = 3
    TabOrder = 3
    OnChange = edtAlmacenChange
  end
  object txtAlmacen: TStaticText
    Left = 177
    Top = 81
    Width = 209
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 4
  end
end
