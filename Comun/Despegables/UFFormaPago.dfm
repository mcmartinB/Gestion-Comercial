object FFormaPago: TFFormaPago
  Left = 555
  Top = 258
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = ' Seleccione valor ...'
  ClientHeight = 261
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnFiltrar: TSpeedButton
    Left = 317
    Top = 0
    Width = 23
    Height = 23
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
      333333333337FF3333333333330003333333333333777F333333333333080333
      3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
      33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
      B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
      BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
      B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
      3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
      333333333337F33333333333333B333333333333333733333333}
    NumGlyphs = 2
    OnClick = btnFiltrarClick
  end
  object Label1: TLabel
    Left = 22
    Top = 5
    Width = 123
    Height = 13
    Caption = 'Filtrar forma pago por (F2) '
  end
  object dlbldescripcion6_fp: TDBText
    Left = 246
    Top = 122
    Width = 261
    Height = 13
    DataField = 'descripcion6_fp'
    DataSource = dsFormaPago
  end
  object dlbldescripcion5_fp: TDBText
    Left = 246
    Top = 106
    Width = 261
    Height = 13
    DataField = 'descripcion5_fp'
    DataSource = dsFormaPago
  end
  object dlbldescripcion8_fp: TDBText
    Left = 246
    Top = 154
    Width = 261
    Height = 13
    DataField = 'descripcion8_fp'
    DataSource = dsFormaPago
  end
  object dlbldescripcion7_fp: TDBText
    Left = 246
    Top = 138
    Width = 261
    Height = 13
    DataField = 'descripcion7_fp'
    DataSource = dsFormaPago
  end
  object dlbldescripcion2_fp: TDBText
    Left = 246
    Top = 57
    Width = 261
    Height = 13
    DataField = 'descripcion2_fp'
    DataSource = dsFormaPago
  end
  object dlbldescripcion_fp: TDBText
    Left = 246
    Top = 41
    Width = 261
    Height = 13
    DataField = 'descripcion_fp'
    DataSource = dsFormaPago
  end
  object dlbldescripcion4_fp: TDBText
    Left = 246
    Top = 89
    Width = 261
    Height = 13
    DataField = 'descripcion4_fp'
    DataSource = dsFormaPago
  end
  object dlbldescripcion3_fp: TDBText
    Left = 246
    Top = 73
    Width = 261
    Height = 13
    DataField = 'descripcion3_fp'
    DataSource = dsFormaPago
  end
  object dlbldescripcion9_fp: TDBText
    Left = 246
    Top = 170
    Width = 261
    Height = 13
    DataField = 'descripcion9_fp'
    DataSource = dsFormaPago
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 28
    Width = 239
    Height = 232
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGridDblClick
  end
  object edtFiltro: TEdit
    Left = 155
    Top = 0
    Width = 162
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 0
    OnKeyUp = edtFiltroKeyUp
  end
  object Query: TQuery
    AfterOpen = QueryAfterOpen
    BeforeClose = QueryBeforeClose
    DatabaseName = 'BDProyecto'
    Left = 155
    Top = 46
  end
  object DataSource: TDataSource
    AutoEdit = False
    DataSet = Query
    Left = 188
    Top = 48
  end
  object qryFormaPago: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DataSource
    Left = 157
    Top = 79
  end
  object dsFormaPago: TDataSource
    AutoEdit = False
    DataSet = qryFormaPago
    Left = 189
    Top = 84
  end
end
