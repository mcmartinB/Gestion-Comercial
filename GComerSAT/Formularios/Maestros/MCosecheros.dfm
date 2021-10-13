object FMCosecheros: TFMCosecheros
  Left = 292
  Top = 233
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  COSECHEROS'
  ClientHeight = 370
  ClientWidth = 487
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
    Width = 487
    Height = 370
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
      Left = 43
      Top = 77
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Nombre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 43
      Top = 33
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 259
      Top = 55
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Nif'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 43
      Top = 99
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Domicilio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 43
      Top = 121
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Poblaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 43
      Top = 143
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo Postal'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 43
      Top = 55
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Cosechero'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa: TBGridButton
      Left = 166
      Top = 31
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
      Control = empresa_c
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 137
    end
    object BGBTipoVia: TBGridButton
      Left = 166
      Top = 97
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
      ParentShowHint = False
      ShowHint = True
      Control = tipo_via_c
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 137
    end
    object Label4: TLabel
      Left = 43
      Top = 166
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Federacion'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBFederacion: TBGridButton
      Left = 166
      Top = 164
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
      ParentShowHint = False
      ShowHint = True
      Control = federacion_c
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 137
    end
    object Label12: TLabel
      Left = 43
      Top = 230
      Width = 74
      Height = 19
      AutoSize = False
      Caption = ' Gastos'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label11: TLabel
      Left = 43
      Top = 252
      Width = 74
      Height = 19
      AutoSize = False
      Caption = ' Contable'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 43
      Top = 209
      Width = 174
      Height = 19
      AutoSize = False
      Caption = ' Cuentas Contables'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object nombre_c: TBDEdit
      Left = 128
      Top = 76
      Width = 306
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 4
      DataField = 'nombre_c'
      DataSource = DSMaestro
    end
    object empresa_c: TBDEdit
      Left = 128
      Top = 32
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_cExit
      DataField = 'empresa_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STNomEmpresa: TStaticText
      Left = 186
      Top = 34
      Width = 248
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object cosechero_c: TBDEdit
      Left = 128
      Top = 54
      Width = 49
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 2
      DataField = 'cosechero_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object nif_c: TBDEdit
      Left = 345
      Top = 54
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 12
      TabOrder = 3
      DataField = 'nif_c'
      DataSource = DSMaestro
    end
    object domicilio_c: TBDEdit
      Left = 186
      Top = 98
      Width = 248
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 6
      DataField = 'domicilio_c'
      DataSource = DSMaestro
    end
    object tipo_via_c: TBDEdit
      Left = 128
      Top = 98
      Width = 27
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 5
      DataField = 'tipo_via_c'
      DataSource = DSMaestro
    end
    object poblacion_c: TBDEdit
      Left = 128
      Top = 120
      Width = 244
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 7
      DataField = 'poblacion_c'
      DataSource = DSMaestro
    end
    object cod_postal_c: TBDEdit
      Left = 128
      Top = 142
      Width = 49
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 5
      TabOrder = 8
      OnChange = cod_postal_cChange
      DataField = 'cod_postal_c'
      DataSource = DSMaestro
    end
    object STProvincia: TStaticText
      Left = 186
      Top = 144
      Width = 248
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 9
    end
    object pertenece_grupo_c: TDBCheckBox
      Left = 128
      Top = 189
      Width = 129
      Height = 17
      Caption = 'Pertenece al grupo.'
      DataField = 'pertenece_grupo_c'
      DataSource = DSMaestro
      TabOrder = 12
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object ajustar_c: TDBCheckBox
      Left = 259
      Top = 189
      Width = 88
      Height = 17
      Caption = 'Aplicar Ajuste'
      DataField = 'ajustar_c'
      DataSource = DSMaestro
      TabOrder = 13
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object federacion_c: TBDEdit
      Left = 128
      Top = 165
      Width = 15
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 10
      OnChange = federacion_cChange
      DataField = 'federacion_c'
      DataSource = DSMaestro
    end
    object STFederacion: TStaticText
      Left = 186
      Top = 167
      Width = 248
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object cta_gastos_c: TBDEdit
      Left = 128
      Top = 229
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 8
      TabOrder = 14
      DataField = 'cta_gastos_c'
      DataSource = DSMaestro
    end
    object cta_contable_c: TBDEdit
      Left = 128
      Top = 251
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 8
      TabOrder = 15
      DataField = 'cta_contable_c'
      DataSource = DSMaestro
    end
  end
  object RejillaFlotante: TBGrid
    Left = 440
    Top = 8
    Width = 73
    Height = 41
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    ColumnFind = 1
  end
  object DSMaestro: TDataSource
    DataSet = QCosecheros
    Left = 40
  end
  object ACosecheros: TActionList
    Top = 104
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QCosecheros: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_cosecheros'
      'ORDER BY empresa_c, cosechero_c')
    Left = 8
  end
end
