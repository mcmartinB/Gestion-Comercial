object FMCampos: TFMCampos
  Left = 197
  Top = 217
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  CAMPOS'
  ClientHeight = 180
  ClientWidth = 455
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
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 455
    Height = 180
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 54
      Top = 108
      Width = 65
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 54
      Top = 44
      Width = 65
      Height = 19
      AutoSize = False
      Caption = ' Campo '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCampo: TBGridButton
      Left = 221
      Top = 43
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
      Control = campo_c
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 90
      GridHeigth = 113
    end
    object Label2: TLabel
      Left = 54
      Top = 76
      Width = 65
      Height = 19
      AutoSize = False
      Caption = ' Tipo '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object descripcion_c: TBDEdit
      Left = 135
      Top = 107
      Width = 274
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = campo_cRequiredTime
      MaxLength = 30
      TabOrder = 3
      DataField = 'descripcion_c'
      DataSource = DSMaestro
    end
    object campo_c: TBDEdit
      Left = 135
      Top = 43
      Width = 87
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Dato de inserci'#243'n obligatoria.'
      OnRequiredTime = campo_cRequiredTime
      MaxLength = 10
      TabOrder = 0
      DataField = 'campo_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object RejillaFlotante: TBGrid
      Left = 222
      Top = 64
      Width = 85
      Height = 113
      Color = clInfoBk
      FixedColor = clInfoText
      Options = [dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Visible = False
      BControl = campo_c
    end
    object tipo_c: TBDEdit
      Left = 135
      Top = 75
      Width = 23
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Dato de inserci'#243'n obligatoria.'
      OnRequiredTime = campo_cRequiredTime
      MaxLength = 2
      TabOrder = 2
      DataField = 'tipo_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
  end
  object DSMaestro: TDataSource
    DataSet = QCampos
    Left = 64
    Top = 16
  end
  object ACosecheros: TActionList
    Left = 336
    Top = 48
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QCampos: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT campo_c, tipo_c, descripcion_c'
      'FROM frf_campos Frf_campos'
      'ORDER BY campo_c, tipo_c')
    Left = 24
    Top = 16
  end
end
