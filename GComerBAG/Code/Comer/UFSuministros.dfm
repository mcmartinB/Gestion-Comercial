object FSuministros: TFSuministros
  Left = 566
  Top = 550
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = ' Seleccione valor ...'
  ClientHeight = 261
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnFiltrar: TSpeedButton
    Left = 298
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
    Left = 3
    Top = 4
    Width = 157
    Height = 13
    Caption = 'Filtrar dir. suministro por ...     (F2) '
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 22
    Width = 321
    Height = 239
    Align = alBottom
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGridDblClick
  end
  object edtFiltro: TEdit
    Left = 136
    Top = 0
    Width = 162
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
    OnKeyUp = edtFiltroKeyUp
  end
  object Query: TQuery
    DatabaseName = 'BDProyecto'
    Left = 220
    Top = 48
  end
  object DataSource: TDataSource
    AutoEdit = False
    DataSet = Query
    Left = 188
    Top = 48
  end
end
