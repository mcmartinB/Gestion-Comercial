object FMEntregasFacturasPlatano: TFMEntregasFacturasPlatano
  Left = 633
  Top = 216
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
    Left = 9
    Top = 272
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
    Left = 9
    Top = 7
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
  object rejilla: TDBGrid
    Left = 9
    Top = 32
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
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -8
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = rejillaDblClick
  end
  object DBGrid1: TDBGrid
    Left = 9
    Top = 297
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
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -8
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object btnCerrar: TButton
    Left = 621
    Top = 427
    Width = 121
    Height = 25
    Caption = 'Cerrar'
    TabOrder = 6
    OnClick = btnCerrarClick
  end
  object btnAnyadir: TButton
    Left = 621
    Top = 5
    Width = 121
    Height = 25
    Caption = 'A'#241'adir'
    TabOrder = 0
    OnClick = btnAnyadirClick
  end
  object btnBorrar: TButton
    Left = 621
    Top = 270
    Width = 121
    Height = 25
    Caption = 'Borrar'
    TabOrder = 4
    OnClick = btnBorrarClick
  end
  object eFiltro: TEdit
    Left = 497
    Top = 7
    Width = 121
    Height = 21
    TabOrder = 2
    OnChange = eFiltroChange
  end
  object cbxFiltro: TComboBox
    Left = 350
    Top = 7
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Filtro Conduce'
    OnChange = cbxFiltroChange
    Items.Strings = (
      'Filtro Conduce'
      'Filtro Entrega'
      'Filtro Albar'#225'n')
  end
  object DSEntregasPosibles: TDataSource
    DataSet = QEntregasPosibles
    Left = 442
    Top = 216
  end
  object QEntregasPosibles: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 402
    Top = 217
  end
  object QEntregasSeleccionadas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 74
    Top = 97
  end
  object DSEntregasSeleccionadas: TDataSource
    DataSet = QEntregasSeleccionadas
    Left = 106
    Top = 96
  end
  object QBorrar: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 74
    Top = 137
  end
  object QAnyadir: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 402
    Top = 256
  end
end
