object FMEntregasCompras: TFMEntregasCompras
  Left = 631
  Top = 214
  ActiveControl = rejilla
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    SELECCIONAR ENTREGAS'
  ClientHeight = 459
  ClientWidth = 754
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
  object lblNombre4: TLabel
    Left = 136
    Top = 296
    Width = 221
    Height = 20
    AutoSize = False
    Caption = 'Entregas Seleccionadas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNombre1: TLabel
    Left = 136
    Top = 31
    Width = 221
    Height = 20
    AutoSize = False
    Caption = 'Entregas Pendientes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 361
    Top = 14
    Width = 100
    Height = 14
    AutoSize = False
    Caption = 'Filtro Entrega'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 465
    Top = 14
    Width = 100
    Height = 14
    AutoSize = False
    Caption = 'Filtro Albar'#225'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 567
    Top = 14
    Width = 100
    Height = 14
    AutoSize = False
    Caption = 'Filtro Matr'#237'cula'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object rejilla: TDBGrid
    Left = 9
    Top = 56
    Width = 733
    Height = 233
    TabStop = False
    Color = clBtnFace
    DataSource = DSEntregasPosibles
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = rejillaDblClick
  end
  object DBGrid1: TDBGrid
    Left = 9
    Top = 321
    Width = 733
    Height = 127
    TabStop = False
    DataSource = DSEntregasSeleccionadas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object btnCerrar: TButton
    Left = 672
    Top = 4
    Width = 78
    Height = 48
    Caption = 'Cerrar'
    TabOrder = 2
    OnClick = btnCerrarClick
  end
  object btnAnyadir: TButton
    Left = 9
    Top = 29
    Width = 121
    Height = 25
    Caption = 'A'#241'adir'
    TabOrder = 3
    OnClick = btnAnyadirClick
  end
  object btnBorrar: TButton
    Left = 9
    Top = 294
    Width = 121
    Height = 25
    Caption = 'Borrar'
    TabOrder = 4
    OnClick = btnBorrarClick
  end
  object edtEntrega: TEdit
    Left = 361
    Top = 30
    Width = 100
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 5
    OnChange = edtEntregaChange
  end
  object edtAlbaran: TEdit
    Left = 465
    Top = 31
    Width = 100
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 6
    OnChange = edtEntregaChange
  end
  object edtMatricula: TEdit
    Left = 567
    Top = 31
    Width = 100
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 7
    OnChange = edtEntregaChange
  end
  object DSEntregasPosibles: TDataSource
    DataSet = QEntregasPosibles
    Left = 442
    Top = 240
  end
  object QEntregasPosibles: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 402
    Top = 241
  end
  object QEntregasSeleccionadas: TQuery
    AfterPost = QEntregasseleccionadasAfterPost
    AfterDelete = QEntregasSeleccionadasAfterDelete
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 74
    Top = 121
  end
  object DSEntregasSeleccionadas: TDataSource
    DataSet = QEntregasSeleccionadas
    Left = 106
    Top = 120
  end
  object QBorrar: TQuery
    AfterPost = QEntregasseleccionadasAfterPost
    AfterDelete = QEntregasSeleccionadasAfterDelete
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 74
    Top = 161
  end
  object QAnyadir: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 402
    Top = 280
  end
end
