object FCDesgloseTransitos: TFCDesgloseTransitos
  Left = 223
  Top = 213
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    DESGLOSE DEL TR'#193'NSITO'
  ClientHeight = 435
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 63
    Height = 16
    Caption = 'Empresa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 40
    Top = 43
    Width = 46
    Height = 16
    Caption = 'Centro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 40
    Top = 62
    Width = 83
    Height = 16
    Caption = 'N'#186' Tr'#225'nsito '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 436
    Top = 74
    Width = 108
    Height = 16
    Caption = 'Kgs del tr'#225'nsito'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 436
    Top = 92
    Width = 82
    Height = 16
    Caption = 'Kgs salidos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 436
    Top = 111
    Width = 108
    Height = 16
    Caption = 'Kgs pendientes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText1: TDBText
    Left = 144
    Top = 26
    Width = 42
    Height = 13
    AutoSize = True
    DataField = 'empresa'
    DataSource = DSKilosTransito
  end
  object DBText2: TDBText
    Left = 144
    Top = 45
    Width = 42
    Height = 13
    AutoSize = True
    DataField = 'centro_salida'
    DataSource = DSKilosTransito
  end
  object DBText3: TDBText
    Left = 144
    Top = 64
    Width = 42
    Height = 13
    AutoSize = True
    DataField = 'transito'
    DataSource = DSKilosTransito
  end
  object Label7: TLabel
    Left = 40
    Top = 82
    Width = 44
    Height = 16
    Caption = 'Fecha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText7: TDBText
    Left = 144
    Top = 84
    Width = 42
    Height = 13
    AutoSize = True
    DataField = 'fecha'
    DataSource = DSKilosTransito
  end
  object DBText4: TDBText
    Left = 597
    Top = 74
    Width = 100
    Height = 17
    Alignment = taRightJustify
    DataField = 'kilos_transito'
    DataSource = DSKilosTransito
  end
  object DBText5: TDBText
    Left = 597
    Top = 92
    Width = 100
    Height = 17
    Alignment = taRightJustify
    DataField = 'kilos_salidos'
    DataSource = DSKilosTransito
  end
  object DBText6: TDBText
    Left = 597
    Top = 111
    Width = 100
    Height = 17
    Alignment = taRightJustify
    DataField = 'kilos_pendientes'
    DataSource = DSKilosTransito
  end
  object Label8: TLabel
    Left = 40
    Top = 142
    Width = 338
    Height = 13
    Caption = 'Salidas - El contenido depende del producto seleccionado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 40
    Top = 279
    Width = 280
    Height = 13
    Caption = 'Tr'#225'nsitos  - Depende del producto seleccionado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 423
    Top = 279
    Width = 64
    Height = 13
    Caption = 'Productos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label11: TLabel
    Left = 40
    Top = 108
    Width = 63
    Height = 16
    Caption = 'Producto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBGrid2: TDBGrid
    Left = 40
    Top = 154
    Width = 657
    Height = 120
    DataSource = DSSalidasTransito
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'empresa_sl'
        Title.Caption = 'Emp.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'centro_salida_sl'
        Title.Caption = 'C.Salida'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'n_albaran_sl'
        Title.Caption = 'N'#186'Albar'#225'n'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_sl'
        Title.Caption = 'Fecha'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliente_sal_sc'
        Title.Caption = 'Cliente'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dir_sum_sc'
        Title.Caption = 'Suminis.'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'producto_sl'
        Title.Caption = 'Prod.'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'envase_sl'
        Title.Caption = 'Envase'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'categoria_sl'
        Title.Caption = 'Cat.'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'calibre_sl'
        Title.Caption = 'Calibre'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'n_factura_sc'
        Title.Caption = 'N'#186'Factura'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_factura_sc'
        Title.Caption = 'Fecha Fac.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'kilos_sl'
        Title.Caption = 'Kilos'
        Visible = True
      end>
  end
  object DBGrid3: TDBGrid
    Left = 40
    Top = 290
    Width = 373
    Height = 120
    DataSource = DSTransitosTransito
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'empresa_tl'
        Title.Caption = 'Empresa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'centro_tl'
        Title.Caption = 'Centro'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'referencia_tl'
        Title.Caption = 'Referencia'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_tl'
        Title.Caption = 'Fecha'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'producto_tl'
        Title.Caption = 'Prod.'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'kilos_tl'
        Title.Caption = 'Kilos'
        Visible = True
      end>
  end
  object DBGrid4: TDBGrid
    Left = 423
    Top = 290
    Width = 272
    Height = 120
    Color = clBtnFace
    DataSource = DSKilosTransitoAux
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'producto'
        Title.Caption = 'Prod.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'kilos_transito'
        Title.Caption = 'Kgs Tr'#225'nsito'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'kilos_salidos'
        Title.Caption = 'Kgs Salidos'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'kilos_pendientes'
        Title.Caption = 'Kgs Pendient.'
        Width = 64
        Visible = True
      end>
  end
  object cbxProductos: TComboBox
    Left = 144
    Top = 104
    Width = 241
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 3
    Text = 'cbxProductos'
    OnChange = cbxProductosChange
  end
  object btnImprimir: TBitBtn
    Left = 513
    Top = 20
    Width = 91
    Height = 25
    Caption = 'Imprimir (F1)'
    TabOrder = 4
    OnClick = btnImprimir_Click
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00FF0000000000BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000000000000000BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD000000000000000000BDBD
      BD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF000000FF00FFFFFF000000000000000000FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FFFFFF0000000000000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FFFFFF0000000000BDBDBD00FFFFFF0000000000FFFF
      FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000000000000000000000000000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
  end
  object btnCerrar: TBitBtn
    Left = 606
    Top = 20
    Width = 91
    Height = 25
    Caption = 'Cerrar (Esc)'
    TabOrder = 5
    OnClick = btnCerrar_Click
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFF
      00007B7B0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFF
      00007B7B00007B7B0000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF
      00007B7B00007B7B00007B7B0000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF0000FFFF
      00007B7B00007B7B00007B7B00007B7B7B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000007B7B7B007B7B7B007B7B7B00FFFF
      00007B7B00007B7B00007B7B00007B7B7B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000007B7B7B007B7B7B007B7B7B00FFFF
      00007B7B00007B7B00007B7B00007B7B7B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000007B7B7B007B7B7B007B7B7B007B7B7B00FFFF
      000000000000000000007B7B00007B7B7B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000007B7B7B007B7B7B007B7B7B00FFFF
      00007B7B0000000000007B7B00007B7B7B00FF00FF00FF00FF00000000000000
      000000000000000000000000000000000000000000007B7B7B007B7B7B00FFFF
      00007B7B00007B7B00007B7B00007B7B7B00FF00FF00FF00FF00000000000000
      000000000000000000000000000000000000000000007B7B7B007B7B7B00FFFF
      00007B7B00007B7B00007B7B00007B7B7B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000007B7B7B007B7B7B007B7B7B00FFFF
      00007B7B00007B7B00007B7B00007B7B7B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000007B7B7B007B7B7B007B7B7B007B7B7B00FFFF
      FF007B7B00007B7B00007B7B00007B7B7B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000007B7B7B007B7B7B007B7B7B007B7B
      7B00FFFFFF007B7B00007B7B00007B7B7B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B00FFFFFF007B7B00007B7B7B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
      0000000000000000000000000000FF00FF00FF00FF00FF00FF00}
  end
  object DSKilosTransito: TDataSource
    AutoEdit = False
    DataSet = DMDesgloseTransitos.mtTransito
    Left = 256
    Top = 80
  end
  object DSSalidasTransito: TDataSource
    AutoEdit = False
    DataSet = DMDesgloseTransitos.mtSalidasTransito
    Left = 664
    Top = 200
  end
  object DSTransitosTransito: TDataSource
    AutoEdit = False
    DataSet = DMDesgloseTransitos.mtTransitosTransito
    Left = 336
    Top = 336
  end
  object DSKilosTransitoAux: TDataSource
    AutoEdit = False
    DataSet = DMDesgloseTransitos.mtTransitoAux
    Left = 632
    Top = 352
  end
end
