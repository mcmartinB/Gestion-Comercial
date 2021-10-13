object FMEntregasCompras: TFMEntregasCompras
  Left = 246
  Top = 206
  ActiveControl = rejilla
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    SELECCIONA LAS ENTREGAS DE LA COMPRA'
  ClientHeight = 453
  ClientWidth = 877
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
    Left = 12
    Top = 19
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
    Left = 425
    Top = 19
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
    Left = 426
    Top = 70
    Width = 443
    Height = 369
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
    Left = 12
    Top = 70
    Width = 410
    Height = 369
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
    Left = 748
    Top = 3
    Width = 121
    Height = 38
    Caption = 'Cerrar'
    TabOrder = 2
    OnClick = btnCerrarClick
  end
  object btnAnyadir: TButton
    Left = 425
    Top = 43
    Width = 173
    Height = 25
    Caption = 'A'#241'adir'
    TabOrder = 3
    OnClick = btnAnyadirClick
  end
  object btnBorrar: TButton
    Left = 12
    Top = 43
    Width = 173
    Height = 25
    Caption = 'Borrar'
    TabOrder = 4
    OnClick = btnBorrarClick
  end
  object eFiltro: TEdit
    Left = 748
    Top = 45
    Width = 121
    Height = 21
    TabOrder = 5
    OnChange = eFiltroChange
  end
  object cbxFiltro: TComboBox
    Left = 603
    Top = 45
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 6
    Text = 'Filtro Entrega'
    OnChange = cbxFiltroChange
    Items.Strings = (
      'Filtro Entrega'
      'Filtro Albar'#225'n')
  end
  object DSEntregasPosibles: TDataSource
    DataSet = QEntregasPosibles
    Left = 442
    Top = 254
  end
  object QEntregasPosibles: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 402
    Top = 255
  end
  object QEntregasSeleccionadas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 74
    Top = 135
  end
  object DSEntregasSeleccionadas: TDataSource
    DataSet = QEntregasSeleccionadas
    Left = 106
    Top = 134
  end
  object QBorrar: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 74
    Top = 175
  end
  object QAnyadir: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 402
    Top = 287
  end
end
