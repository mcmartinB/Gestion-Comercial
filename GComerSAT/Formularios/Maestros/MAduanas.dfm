object FMAduanas: TFMAduanas
  Left = 328
  Top = 251
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  ADUANAS/PUERTOS'
  ClientHeight = 158
  ClientWidth = 476
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
    Width = 476
    Height = 158
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LDescripcion_m: TLabel
      Left = 40
      Top = 71
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LMoneda_m: TLabel
      Left = 40
      Top = 45
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre1: TLabel
      Left = 40
      Top = 97
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Precio DDP'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object descripcion_a: TBDEdit
      Left = 144
      Top = 70
      Width = 265
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 50
      TabOrder = 1
      DataField = 'descripcion_a'
      DataSource = DSMaestro
    end
    object codigo_a: TBDEdit
      Left = 144
      Top = 44
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo de la moneda es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 0
      DataField = 'codigo_a'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object precio_a: TBDEdit
      Left = 144
      Top = 96
      Width = 49
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 3
      MaxLength = 5
      TabOrder = 2
      DataField = 'precio_a'
      DataSource = DSMaestro
      PrimaryKey = True
    end
  end
  object DSMaestro: TDataSource
    DataSet = QAduanas
    Left = 216
    Top = 8
  end
  object ACosecheros: TActionList
    Left = 288
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QAduanas: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_aduanas '
      'ORDER BY codigo_a, descripcion_a')
    Left = 184
    Top = 9
  end
end
