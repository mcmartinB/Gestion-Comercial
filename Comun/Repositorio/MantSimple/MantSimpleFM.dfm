object FMMantSimple: TFMMantSimple
  Left = 366
  Top = 145
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  TRANSPORTISTAS'
  ClientHeight = 179
  ClientWidth = 466
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
    Width = 466
    Height = 179
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
      Top = 29
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_csp: TBGridButton
      Left = 174
      Top = 27
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = empresa_csp
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 240
      GridHeigth = 70
    end
    object LAno_semana_p: TLabel
      Left = 39
      Top = 54
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Transporte'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 39
      Top = 78
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Cliente'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 39
      Top = 102
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Dir. Suministro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 39
      Top = 126
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Importe del Porte'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object RejillaFlotante: TBGrid
      Left = 317
      Top = 51
      Width = 83
      Height = 70
      Color = clInfoBk
      FixedColor = clInfoText
      Options = [dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Visible = False
    end
    object empresa_csp: TBDEdit
      Tag = 1
      Left = 140
      Top = 28
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombre
      DataField = 'empresa_csp'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa_csp: TStaticText
      Left = 189
      Top = 30
      Width = 211
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 2
    end
    object transporte_csp: TBDEdit
      Left = 140
      Top = 53
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del transporte es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 1
      DataField = 'transporte_csp'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object cliente_csp: TBDEdit
      Left = 140
      Top = 77
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del transporte es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      DataField = 'cliente_csp'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object dir_sum_csp: TBDEdit
      Left = 140
      Top = 101
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del transporte es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 5
      DataField = 'dir_sum_csp'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object importe_csp: TBDEdit
      Left = 140
      Top = 125
      Width = 77
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del transporte es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 10
      TabOrder = 6
      DataField = 'importe_csp'
      DataSource = DSMaestro
      PrimaryKey = True
    end
  end
  object DSMaestro: TDataSource
    DataSet = DMMantSimple.QMaestro
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
      OnExecute = ARejillaFlotanteExecute
    end
  end
end
