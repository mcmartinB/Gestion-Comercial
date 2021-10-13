object FProductosProveedor: TFProductosProveedor
  Left = 396
  Top = 304
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = ' Seleccione valor ...'
  ClientHeight = 261
  ClientWidth = 510
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
  object Bevel2: TBevel
    Left = 235
    Top = 0
    Width = 274
    Height = 22
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 125
    Height = 21
    Visible = False
  end
  object btnFiltrar: TSpeedButton
    Left = 486
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
    Left = 239
    Top = 4
    Width = 102
    Height = 13
    Caption = 'Filtro Descripci'#243'n (F2)'
  end
  object bntNuevo: TSpeedButton
    Left = 98
    Top = 0
    Width = 23
    Height = 23
    Hint = 'Insertar un nuevo producto.'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
      00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
      F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
      0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
      FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
      FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
      0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
      00333377737FFFFF773333303300000003333337337777777333}
    NumGlyphs = 2
    Visible = False
    OnClick = bntNuevoClick
  end
  object Label2: TLabel
    Left = 1
    Top = 4
    Width = 93
    Height = 13
    Caption = 'Nuevo Producto (+)'
    Visible = False
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 22
    Width = 510
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
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'proveedor'
        Title.Alignment = taCenter
        Title.Caption = 'Proveedor'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'producto'
        Title.Alignment = taCenter
        Title.Caption = 'Producto'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'variedad'
        Title.Alignment = taCenter
        Title.Caption = 'Variedad'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion'
        Title.Caption = 'Descripcion'
        Visible = True
      end>
  end
  object edtFiltro: TEdit
    Left = 344
    Top = 0
    Width = 142
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
    OnKeyUp = edtFiltroKeyUp
  end
  object Query: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT DISTINCT proveedor_pp Proveedor, producto_pp Producto, va' +
        'riedad_pp Variedad, descripcion_pp Descripcion '
      'FROM frf_productos_proveedor')
    Left = 220
    Top = 48
    object Queryproveedor: TStringField
      FieldName = 'proveedor'
      Origin = '"COMER.DESARROLLO".frf_productos_proveedor.proveedor_pp'
      FixedChar = True
      Size = 3
    end
    object Queryproducto: TStringField
      DisplayWidth = 3
      FieldName = 'producto'
      Origin = '"COMER.DESARROLLO".frf_productos_proveedor.producto_pp'
      FixedChar = True
      Size = 3
    end
    object Queryvariedad: TIntegerField
      FieldName = 'variedad'
      Origin = '"COMER.DESARROLLO".frf_productos_proveedor.variedad_pp'
    end
    object Querydescripcion: TStringField
      FieldName = 'descripcion'
      Origin = '"COMER.DESARROLLO".frf_productos_proveedor.descripcion_pp'
      FixedChar = True
      Size = 50
    end
  end
  object DataSource: TDataSource
    AutoEdit = False
    DataSet = Query
    Left = 188
    Top = 48
  end
end
