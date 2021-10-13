object FDImportarEnvases: TFDImportarEnvases
  Left = 488
  Top = 310
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'IMPORTAR ARTICULOS  BD REMOTA'
  ClientHeight = 488
  ClientWidth = 669
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
  object LEnvase_e: TLabel
    Left = 8
    Top = 74
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' C'#243'digo Art'#237'culo'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblNombre7: TLabel
    Left = 9
    Top = 51
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' Producto'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object btnProducto: TBGridButton
    Left = 164
    Top = 50
    Width = 13
    Height = 21
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
    Control = producto_e
    Grid = bgrdRejillaFlotante
    GridAlignment = taDownCenter
    GridWidth = 280
    GridHeigth = 200
  end
  object btnImportar: TButton
    Left = 8
    Top = 9
    Width = 100
    Height = 25
    Caption = 'Importar Art'#237'culo'
    TabOrder = 1
    OnClick = btnImportarClick
  end
  object btnAceptar: TButton
    Left = 454
    Top = 8
    Width = 100
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 0
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 560
    Top = 9
    Width = 100
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object bgrdRejillaFlotante: TBGrid
    Left = 468
    Top = 48
    Width = 113
    Height = 49
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object producto_e: TBEdit
    Left = 121
    Top = 50
    Width = 41
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 4
    OnChange = producto_eChange
  end
  object txtProducto: TStaticText
    Left = 183
    Top = 51
    Width = 251
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 5
  end
  object txtEnvase: TStaticText
    Left = 219
    Top = 75
    Width = 215
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 8
  end
  object dbgrdEnvClientes: TDBGrid
    Left = 261
    Top = 116
    Width = 397
    Height = 177
    DataSource = dsEnvClientes
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object mmoIzq: TMemo
    Left = 13
    Top = 116
    Width = 106
    Height = 351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    WordWrap = False
  end
  object mmoDer: TMemo
    Left = 123
    Top = 116
    Width = 134
    Height = 351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    WordWrap = False
  end
  object dbgrdEan: TDBGrid
    Left = 261
    Top = 290
    Width = 397
    Height = 177
    DataSource = dsEan
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 12
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object envase_e: TcxTextEdit
    Left = 121
    Top = 74
    Properties.CharCase = ecUpperCase
    Properties.MaxLength = 9
    Properties.OnChange = envase_eChange
    Style.BorderStyle = ebs3D
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 6
    OnExit = envase_eExit
    Width = 75
  end
  object ssEnvase: TSimpleSearch
    Left = 192
    Top = 74
    Width = 21
    Height = 21
    TabOrder = 7
    TabStop = False
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'MoneyTwins'
    OptionsImage.ImageIndex = 2
    OptionsImage.Images = FDM.ilxImagenes
    Titulo = 'Busqueda de Art'#237'culos'
    Tabla = 'frf_envases'
    Campos = <
      item
        Etiqueta = 'Art'#237'culo'
        Campo = 'envase_e'
        Ancho = 100
        Tipo = ctCadena
      end
      item
        Etiqueta = 'Descripci'#243'n'
        Campo = 'descripcion_e'
        Ancho = 400
        Tipo = ctCadena
      end>
    Database = 'BDProyecto'
    CampoResultado = 'envase_e'
    Enlace = envase_e
    Tecla = 'F2'
    AntesEjecutar = ssEnvaseAntesEjecutar
    Concatenar = False
  end
  object qryEnvases: TQuery
    DatabaseName = 'BDCentral'
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 28
    Top = 171
  end
  object qryEnvClientes: TQuery
    DatabaseName = 'BDCentral'
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 315
    Top = 166
  end
  object dsEnvClientes: TDataSource
    DataSet = qryEnvClientes
    Left = 346
    Top = 167
  end
  object qryEan: TQuery
    DatabaseName = 'BDCentral'
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 334
    Top = 316
  end
  object dsEan: TDataSource
    DataSet = qryEan
    Left = 365
    Top = 317
  end
end
