object FMWebClientes: TFMWebClientes
  Left = 249
  Top = 318
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  CLIENTES INTERNET'
  ClientHeight = 258
  ClientWidth = 532
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
    Width = 532
    Height = 258
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
      Caption = ' Cliente'
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
    object Label1: TLabel
      Left = 39
      Top = 97
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Usuario'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Password: TLabel
      Left = 236
      Top = 97
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Clave'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 39
      Top = 145
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' E-Mail'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 39
      Top = 121
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Nombre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object cliente_wcl: TBDEdit
      Tag = 1
      Left = 140
      Top = 31
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'cliente_wcl'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object idioma_wcl: TBDEdit
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
      OnChange = idioma_wclChange
      DataField = 'idioma_wcl'
      DataSource = DSMaestro
    end
    object usuario_wcl: TBDEdit
      Left = 140
      Top = 96
      Width = 69
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 8
      TabOrder = 4
      DataField = 'usuario_wcl'
      DataSource = DSMaestro
    end
    object password_wcl: TBDEdit
      Left = 336
      Top = 96
      Width = 69
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 8
      TabOrder = 5
      DataField = 'password_wcl'
      DataSource = DSMaestro
    end
    object email_wcl: TBDEdit
      Left = 140
      Top = 144
      Width = 357
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      CharCase = ecNormal
      MaxLength = 100
      TabOrder = 7
      DataField = 'email_wcl'
      DataSource = DSMaestro
    end
    object nombre_cliente_wcl: TBDEdit
      Tag = 1
      Left = 176
      Top = 31
      Width = 265
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 1
      DataField = 'nombre_cliente_wcl'
      DataSource = DSMaestro
    end
    object nombre_usuario_wcl: TBDEdit
      Tag = 1
      Left = 140
      Top = 120
      Width = 265
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 6
      DataField = 'nombre_usuario_wcl'
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
    Left = 71
    Top = 198
    Width = 389
    Height = 25
    Caption = 'Sincronizar Clientes Intenet.'
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
