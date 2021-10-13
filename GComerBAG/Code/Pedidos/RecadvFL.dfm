object FLRecadv: TFLRecadv
  Left = 457
  Top = 167
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    RECADV - Confirmaci'#243'n de Recepci'#243'n de Mercancias EDI'
  ClientHeight = 657
  ClientWidth = 905
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  DesignSize = (
    905
    657)
  PixelsPerInch = 96
  TextHeight = 13
  object lblNombre1: TLabel
    Left = 8
    Top = 16
    Width = 115
    Height = 32
    Caption = 'RECADV'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblAlbaranPedido: TLabel
    Left = 8
    Top = 397
    Width = 281
    Height = 32
    Caption = 'ALBAR'#193'N DE VENTA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object btnCerrar: TBitBtn
    Left = 807
    Top = 14
    Width = 90
    Height = 25
    Anchors = []
    Caption = 'Cerrar (Esc)'
    TabOrder = 0
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnImportar: TBitBtn
    Left = 134
    Top = 24
    Width = 90
    Height = 25
    Anchors = []
    Caption = 'Importar (F1)'
    ModalResult = 1
    TabOrder = 1
    TabStop = False
    OnClick = btnImportarClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF007F7F
      7F00000000007F7F7F007F7F7F007F7F7F0000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000BFBFBF007F7F
      7F00000000007F7F7F00000000000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF007F7F7F00000000007F7F7F00FF00FF0000000000000000000000
      00007F7F7F007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000000007F7F7F00000000000000000000000000BFBFBF00BFBF
      BF007F7F7F0000000000000000007F7F7F00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007F7F7F0000000000000000007F7F7F007F7F7F007F7F7F000000
      000000000000000000007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000007F7F7F007F7F7F00000000007F7F7F000000
      0000FF00FF007F7F7F00000000007F7F7F00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000BFBFBF00000000007F7F7F00000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000007F7F7F007F7F7F00BFBFBF0000000000BFBFBF00FF00FF00FF00
      FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000BFBFBF00000000007F7F7F00000000007F7F
      7F00FF00FF00000000007F7F7F0000000000FF00FF007F7F7F00000000007F7F
      7F00FF00FF00FF00FF00000000007F7F7F00BFBFBF00000000007F7F7F000000
      000000000000000000007F7F7F000000000000000000000000007F7F7F000000
      0000FF00FF007F7F7F0000000000000000007F7F7F00BFBFBF00000000000000
      00007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F0000000000000000007F7F
      7F00FF00FF00000000007F7F7F00000000000000000000000000000000007F7F
      7F007F7F7F000000000000000000000000007F7F7F007F7F7F0000000000FF00
      FF00FF00FF007F7F7F00000000007F7F7F00FF00FF000000000000000000BFBF
      BF00000000007F7F7F007F7F7F007F7F7F00000000007F7F7F00000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000007F7F7F00BFBF
      BF0000000000BFBFBF00000000007F7F7F00000000007F7F7F007F7F7F007F7F
      7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000BFBF
      BF00000000007F7F7F00BFBFBF007F7F7F00000000007F7F7F00000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000007F7F
      7F00BFBFBF000000000000000000000000007F7F7F007F7F7F0000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
  end
  object btnBuscar: TBitBtn
    Left = 714
    Top = 14
    Width = 90
    Height = 25
    Anchors = []
    Caption = 'Buscar (L)'
    ModalResult = 1
    TabOrder = 2
    TabStop = False
    OnClick = btnBuscarClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008484840000000000000000000000000084848400FF00FF0000FF
      FF008484840000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000008484840084848400848484008484840084848400000000000000
      000000FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      000084848400FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00848484000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00848484008484
      8400FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF008484
      840084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008484
      8400C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C6008484
      840000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008484
      8400FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF008484
      840000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008484
      8400C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C6008484
      840000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00848484008484
      8400FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF008484
      840084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      000084848400FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00848484000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0000000000848484008484840084848400848484008484840000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008484840000000000000000000000000084848400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
  end
  object DBGcab: TDBGrid
    Left = 8
    Top = 56
    Width = 441
    Height = 150
    DataSource = DSCab
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'empresa'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Width = 51
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'fecha'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha'
        Width = 75
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Albaran'
        Title.Alignment = taCenter
        Title.Caption = 'Albar'#225'n'
        Width = 75
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'pedido'
        Title.Alignment = taCenter
        Title.Caption = 'Pedido'
        Width = 75
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Matricula'
        Title.Alignment = taCenter
        Title.Caption = 'Matr'#237'cula'
        Width = 113
        Visible = True
      end>
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 207
    Width = 577
    Height = 186
    DataSource = DSLin
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'codigo_cli'
        Title.Alignment = taCenter
        Title.Caption = 'Cod. Cliente'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion_cli'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n Cli.'
        Width = 214
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'unidades_caja'
        Title.Alignment = taCenter
        Title.Caption = 'Unds. Caja'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'cajas'
        Title.Alignment = taCenter
        Title.Caption = 'Cajas'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'unidades'
        Title.Alignment = taCenter
        Title.Caption = 'Unidades'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'unidad_cli'
        Title.Alignment = taCenter
        Title.Caption = 'Unidad'
        Width = 43
        Visible = True
      end>
  end
  object dbgAlbaran: TDBGrid
    Left = 8
    Top = 426
    Width = 633
    Height = 231
    DataSource = DSAlbaranDet
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'envase'
        Title.Alignment = taCenter
        Title.Caption = 'Envase'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion'
        Title.Alignment = taCenter
        Title.Caption = 'Descripcion Cli.'
        Width = 200
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'palets'
        Title.Alignment = taCenter
        Title.Caption = 'Palets'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'cajas'
        Title.Alignment = taCenter
        Title.Caption = 'Cajas'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'kilos'
        Title.Alignment = taCenter
        Title.Caption = 'Kilos'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'unidades'
        Title.Alignment = taCenter
        Title.Caption = 'Unidades'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'unidad_factura'
        Title.Alignment = taCenter
        Title.Caption = 'Unidad'
        Visible = True
      end>
  end
  object DBEdit1: TDBEdit
    Left = 464
    Top = 56
    Width = 433
    Height = 21
    TabStop = False
    DataField = 'texto1_eor'
    DataSource = DSObs
    ReadOnly = True
    TabOrder = 6
  end
  object DBEdit2: TDBEdit
    Left = 464
    Top = 80
    Width = 433
    Height = 21
    TabStop = False
    DataField = 'texto2_eor'
    DataSource = DSObs
    ReadOnly = True
    TabOrder = 7
  end
  object DBEdit3: TDBEdit
    Left = 464
    Top = 104
    Width = 433
    Height = 21
    TabStop = False
    DataField = 'texto3_eor'
    DataSource = DSObs
    ReadOnly = True
    TabOrder = 8
  end
  object DBEdit4: TDBEdit
    Left = 464
    Top = 128
    Width = 433
    Height = 21
    TabStop = False
    DataField = 'texto5_eor'
    DataSource = DSObs
    ReadOnly = True
    TabOrder = 9
  end
  object DBEdit5: TDBEdit
    Left = 464
    Top = 152
    Width = 433
    Height = 21
    TabStop = False
    DataField = 'texto5_eor'
    DataSource = DSObs
    ReadOnly = True
    TabOrder = 10
  end
  object BitBtn1: TBitBtn
    Left = 622
    Top = 14
    Width = 90
    Height = 25
    Anchors = []
    Caption = 'Imprimir (I)'
    Enabled = False
    ModalResult = 1
    TabOrder = 11
    TabStop = False
    Visible = False
    OnClick = BitBtn1Click
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
  object dbgCajasLogifruit: TDBGrid
    Left = 8
    Top = 426
    Width = 369
    Height = 231
    DataSource = DSCajasLogifruit
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 12
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'codigo'
        ImeName = 'codigo'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion'
        Title.Alignment = taCenter
        Title.Caption = 'Descripcion Cli.'
        Width = 201
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cajas'
        Title.Alignment = taCenter
        Title.Caption = 'Cajas'
        Width = 57
        Visible = True
      end>
  end
  object dbgPalets: TDBGrid
    Left = 8
    Top = 426
    Width = 369
    Height = 231
    DataSource = DSPalets
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 13
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'codigo'
        ImeName = 'codigo'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion'
        Title.Alignment = taCenter
        Title.Caption = 'Descripcion Cli.'
        Width = 201
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Palets'
        Title.Alignment = taCenter
        Width = 57
        Visible = True
      end>
  end
  object cbbVer: TComboBox
    Left = 600
    Top = 208
    Width = 297
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 14
    Text = 'Albar'#225'n'
    OnChange = cbbVerChange
    Items.Strings = (
      'Albar'#225'n'
      'Cajas Logifruit'
      'Palets')
  end
  object DSCab: TDataSource
    DataSet = DLRecadv.QCab
    Left = 112
    Top = 96
  end
  object DSLin: TDataSource
    DataSet = DLRecadv.QLin
    Left = 112
    Top = 256
  end
  object DSAlbaranDet: TDataSource
    DataSet = DLRecadv.QAlbaranDet
    Left = 176
    Top = 472
  end
  object DSAlbaranCab: TDataSource
    Left = 120
    Top = 472
  end
  object DSObs: TDataSource
    DataSet = DLRecadv.QObs
    Left = 536
    Top = 72
  end
  object DSCajasLogifruit: TDataSource
    DataSet = DLRecadv.QCajasLogifruit
    Left = 704
    Top = 504
  end
  object DSPalets: TDataSource
    DataSet = DLRecadv.QPalets
    Left = 752
    Top = 280
  end
end
