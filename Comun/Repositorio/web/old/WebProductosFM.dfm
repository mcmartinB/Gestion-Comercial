object FMWebProductos: TFMWebProductos
  Left = 231
  Top = 305
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  PRODUCTOS INTERNET'
  ClientHeight = 153
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 37
    Top = 75
    Width = 90
    Height = 19
    AutoSize = False
    Caption = 'Empresa'
    Color = cl3DLight
    ParentColor = False
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 484
    Height = 153
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LEmpresa_p: TLabel
      Left = 39
      Top = 32
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LAno_semana_p: TLabel
      Left = 39
      Top = 57
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Idioma'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object producto_wpd: TBDEdit
      Tag = 1
      Left = 140
      Top = 31
      Width = 16
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'producto_wpd'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object idioma_wpd: TBDEdit
      Left = 214
      Top = 56
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      Enabled = False
      Visible = False
      CharCase = ecLowerCase
      MaxLength = 3
      TabOrder = 3
      OnChange = idioma_wpdChange
      DataField = 'idioma_wpd'
      DataSource = DSMaestro
    end
    object descripcion_wpd: TBDEdit
      Tag = 1
      Left = 160
      Top = 31
      Width = 265
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 20
      TabOrder = 1
      DataField = 'descripcion_wpd'
      DataSource = DSMaestro
    end
    object cbxIdiomas: TComboBox
      Left = 140
      Top = 56
      Width = 80
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'ESPA'#209'OL'
      OnChange = cbxIdiomasChange
      Items.Strings = (
        'ESPA'#209'OL'
        'INGL'#201'S'
        'ALEM'#193'N')
    end
  end
  object btnSincronizar: TButton
    Left = 39
    Top = 110
    Width = 389
    Height = 25
    Caption = 'Sincronizar Productos Intenet.'
    TabOrder = 1
    OnClick = btnSincronizarClick
  end
  object DSMaestro: TDataSource
    DataSet = DMWEB.QMaestro
    Left = 48
    Top = 8
  end
  object ACosecheros: TActionList
    Left = 8
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
    end
  end
end
