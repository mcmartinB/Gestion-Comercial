object FMDesProductosCentros: TFMDesProductosCentros
  Left = 354
  Top = 286
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  DESCRIPCI'#211'N ENVASES TR'#193'NSITO'
  ClientHeight = 181
  ClientWidth = 439
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
    Width = 439
    Height = 181
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 40
      Top = 66
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Centro Destino'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 40
      Top = 111
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 40
      Top = 44
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnEmpresa: TBGridButton
      Left = 161
      Top = 43
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      Control = empresa_dpc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 130
    end
    object btnCentro: TBGridButton
      Left = 161
      Top = 65
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      Control = centro_dpc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 100
    end
    object Label4: TLabel
      Left = 40
      Top = 88
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Envase'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnEnvase: TBGridButton
      Left = 161
      Top = 87
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      Control = envase_dpc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 70
    end
    object empresa_dpc: TBDEdit
      Left = 128
      Top = 43
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'C'#243'digo de empresa obligatorio.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'empresa_dpc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object stEmpresa: TStaticText
      Left = 176
      Top = 45
      Width = 215
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object descripcion_dpc: TBDEdit
      Left = 128
      Top = 110
      Width = 265
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Descripci'#243'n de envase obligatorio.'
      OnRequiredTime = RequiredTime
      TabOrder = 6
      DataField = 'descripcion_dpc'
      DataSource = DSMaestro
    end
    object centro_dpc: TBDEdit
      Left = 128
      Top = 65
      Width = 17
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'C'#243'digo de centro obligatorio.'
      OnRequiredTime = RequiredTime
      TabOrder = 2
      DataField = 'centro_dpc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object stCentro: TStaticText
      Left = 176
      Top = 67
      Width = 215
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object envase_dpc: TBDEdit
      Left = 128
      Top = 87
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'C'#243'digo de envase obligatorio.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      DataField = 'envase_dpc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object stEnvase: TStaticText
      Left = 176
      Top = 89
      Width = 215
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
  end
  object RejillaFlotante: TBGrid
    Left = 391
    Top = 10
    Width = 73
    Height = 71
    Color = clInfoBk
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    BControl = empresa_dpc
  end
  object DSMaestro: TDataSource
    DataSet = QDesProductosCentro
    OnDataChange = DSMaestroDataChange
    Left = 200
    Top = 8
  end
  object ACosecheros: TActionList
    Left = 344
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QDesProductosCentro: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * '
      'FROM frf_centros'
      'ORDER BY centro_c')
    Left = 168
    Top = 9
  end
end
