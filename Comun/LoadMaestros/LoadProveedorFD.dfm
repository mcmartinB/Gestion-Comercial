object FDLoadProveedor: TFDLoadProveedor
  Left = 435
  Top = 227
  Caption = '    Alta Proveedor'
  ClientHeight = 132
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lbl2: TLabel
    Left = 36
    Top = 42
    Width = 79
    Height = 19
    AutoSize = False
    Caption = ' C'#243'digo'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl3: TLabel
    Left = 36
    Top = 18
    Width = 331
    Height = 13
    Caption = 
      'Introduzca el c'#243'digo del proveedor que quiere descargar de la ce' +
      'ntral.'
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
    Top = 92
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    ModalResult = 6
    TabOrder = 3
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 323
    Top = 92
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 7
    TabOrder = 4
  end
  object txtProveedor: TStaticText
    Left = 177
    Top = 43
    Width = 209
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 2
  end
  object edtCodigo: TBEdit
    Left = 121
    Top = 41
    Width = 30
    Height = 21
    MaxLength = 3
    TabOrder = 1
    OnChange = edtCodigoChange
  end
end
