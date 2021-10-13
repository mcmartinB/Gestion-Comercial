object FDImportarPlantaciones: TFDImportarPlantaciones
  Left = 602
  Top = 243
  ActiveControl = empresa_p
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'IMPORTAR PLANTACIONES BD REMOTA'
  ClientHeight = 488
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblNombre6: TLabel
    Left = 9
    Top = 47
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' Empresa'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object btnEmpresa: TBGridButton
    Left = 164
    Top = 46
    Width = 13
    Height = 19
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000001F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    OnClick = btnEmpresaClick
    Control = empresa_p
    Grid = bgrdRejillaFlotante
    GridAlignment = taDownCenter
    GridWidth = 280
    GridHeigth = 200
  end
  object lblNombre7: TLabel
    Left = 9
    Top = 111
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' Plantaci'#243'n'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl1: TLabel
    Left = 9
    Top = 132
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' A'#241'o/Semana'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl2: TLabel
    Left = 9
    Top = 68
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' Producto'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl3: TLabel
    Left = 9
    Top = 89
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' Cosechero'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object btnImportar: TButton
    Left = 8
    Top = 9
    Width = 100
    Height = 25
    Caption = 'Importar Plantaci'#243'n'
    TabOrder = 1
    OnClick = btnImportarClick
  end
  object btnAceptar: TButton
    Left = 192
    Top = 8
    Width = 100
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 0
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 295
    Top = 9
    Width = 100
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object bgrdRejillaFlotante: TBGrid
    Left = 324
    Top = 56
    Width = 113
    Height = 49
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object empresa_p: TBEdit
    Left = 121
    Top = 46
    Width = 41
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 3
    OnChange = empresa_pChange
  end
  object txtEmpresa: TStaticText
    Left = 180
    Top = 46
    Width = 215
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 4
  end
  object plantacion_p: TBEdit
    Left = 121
    Top = 109
    Width = 41
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 9
  end
  object dbgrdPlantacion: TDBGrid
    Left = 270
    Top = 75
    Width = 187
    Height = 66
    DataSource = dsPlantacion
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    OnCellClick = dbgrdPlantacionCellClick
  end
  object mmoIzq: TMemo
    Left = 13
    Top = 154
    Width = 148
    Height = 325
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    WordWrap = False
  end
  object mmoDer: TMemo
    Left = 168
    Top = 154
    Width = 227
    Height = 325
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    WordWrap = False
  end
  object ano_semana_p: TBEdit
    Left = 121
    Top = 130
    Width = 72
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 6
    TabOrder = 10
  end
  object producto_p: TBEdit
    Left = 121
    Top = 66
    Width = 41
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 6
  end
  object cosechero_p: TBEdit
    Left = 121
    Top = 87
    Width = 41
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 8
  end
  object qryPlantacion: TQuery
    DatabaseName = 'BDCentral'
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 283
    Top = 187
  end
  object dsPlantacion: TDataSource
    DataSet = qryPlantacion
    Left = 314
    Top = 188
  end
end
