object FConTransitos: TFConTransitos
  Left = 382
  Top = 292
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  CONSULTA DE TR'#193'NSITOS'
  ClientHeight = 526
  ClientWidth = 683
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PSuperior: TPanel
    Left = 0
    Top = 0
    Width = 683
    Height = 42
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnLocalizar: TSpeedButton
      Left = 471
      Top = 6
      Width = 100
      Height = 30
      Caption = 'Consultar (F1)'
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
        FF00FF00FF008080800000000080000000000000000080808000FF00FF8000FF
        FF00808080BF00000080FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000008080800080808080808080808080808080808080000000800000
        000000FFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        000080808000FFFFFF80C0C0C0BFFFFFFF80C0C0C0BFFFFFFF80808080BF0000
        0080FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00808080008080
        8080FFFFFF80C0C0C0BFFFFFFF80C0C0C0BFFFFFFF80C0C0C0BFFFFFFF808080
        80BF80808080FF00FF80FF00FF00FF00FF00FF00FF00FF00FF00000000008080
        8000C0C0C080FFFFFF80C0C0C0BFFFFFFF80C0C0C0BFFFFFFF80C0C0C0BF8080
        808000000080FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008080
        8000FFFFFF80C0C0C0BFFFFFFF80C0C0C0BFFFFFFF80C0C0C0BFFFFFFF808080
        80BF00000080FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008080
        8000C0C0C080FFFFFF80C0C0C0BFFFFFFF80C0C0C0BFFFFFFF80C0C0C0BF8080
        808000000080FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00808080008080
        8080FFFFFF80C0C0C0BFFFFFFF80C0C0C0BFFFFFFF80C0C0C0BFFFFFFF808080
        80BF80808080FF00FF80FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        000080808000FFFFFF80C0C0C0BFFFFFFF80C0C0C0BFFFFFFF80808080BF0000
        0080FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000808080008080808080808080808080808080808000000080FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF008080800000000080000000000000000080808000FF00FF80FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = ALocalizarExecute
    end
    object btnSalir: TSpeedButton
      Left = 576
      Top = 6
      Width = 100
      Height = 30
      Caption = 'Cerrar (Esc)'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFF
        00007F7F00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFF
        00007F7F00BF7F7F0000FF00FF3FFF00FF00FF00FF00FF00FF00000000000000
        000000000000000000000000000000000000FFFF0000FFFF0000FFFF00BFFFFF
        00007F7F00BF7F7F00007F7F003F000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF00BFFFFF
        00007F7F00BF7F7F00007F7F003F7F7F7F00FF00FF3FFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000007F7F7F007F7F7F3F7F7F7F3FFFFF
        003F7F7F00BF7F7F00007F7F003F7F7F7F00FF00FF3FFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000007F7F7F007F7F7F3F7F7F7F3FFFFF
        003F7F7F00BF7F7F00007F7F003F7F7F7F00FF00FF3FFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000007F7F7F007F7F7F3F7F7F7F3F7F7F7F3FFFFF
        003F000000BF000000007F7F00007F7F7F00FF00FF3FFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000007F7F7F007F7F7F3F7F7F7F3FFFFF
        003F7F7F00BF000000007F7F00007F7F7F00FF00FF3FFF00FF00000000000000
        000000000000000000000000000000000000000000007F7F7F007F7F7F3FFFFF
        003F7F7F00BF7F7F00007F7F003F7F7F7F00FF00FF3FFF00FF00000000000000
        000000000000000000000000000000000000000000007F7F7F007F7F7F3FFFFF
        003F7F7F00BF7F7F00007F7F003F7F7F7F00FF00FF3FFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000007F7F7F007F7F7F3F7F7F7F3FFFFF
        003F7F7F00BF7F7F00007F7F003F7F7F7F00FF00FF3FFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000007F7F7F007F7F7F3F7F7F7F3F7F7F7F3FFFFF
        FF3F7F7F00BF7F7F00007F7F003F7F7F7F00FF00FF3FFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000007F7F7F007F7F7F3F7F7F7F3F7F7F
        7F3FFFFFFF3F7F7F00BF7F7F003F7F7F7F00FF00FF3FFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000007F7F7F007F7F7F3F7F7F7F3F7F7F
        7F3F7F7F7F3FFFFFFF3F7F7F00BF7F7F7F00FF00FF3FFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00}
      OnClick = ASalirExecute
    end
    object btnImprimir: TSpeedButton
      Left = 7
      Top = 6
      Width = 100
      Height = 30
      Caption = 'Imprimir (I)'
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C000000000000000000000000000000000000000000000000
        000000001F7C0000F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
        F75EF75E00000000F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
        F75EF75E00000000000000000000000000000000000000000000000000000000
        0000000000000000FF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7FF75E
        FF7FF75E00000000F75EFF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7F
        007CFF7F00000000FF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7FF75E
        FF7FF75E00000000000000000000000000000000000000000000000000000000
        0000000000001F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7F0000000000000000FF7F0000FF7F0000
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7F00000000FF7F00000000000000000000
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7F0000FF7FFF7F00001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7F0000F75EFF7F0000FF7F00001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7F000000001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0000000000000000000000001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      OnClick = AImprimirExecute
    end
    object cbxPendientes: TCheckBox
      Left = 128
      Top = 13
      Width = 97
      Height = 17
      Caption = 'Pendientes'
      TabOrder = 0
      OnClick = cbxEstadoChange
    end
    object cbxSobreventa: TCheckBox
      Left = 236
      Top = 13
      Width = 97
      Height = 17
      Caption = 'Sobreventa'
      TabOrder = 1
      OnClick = cbxEstadoChange
    end
    object cbxVendidos: TCheckBox
      Left = 344
      Top = 13
      Width = 97
      Height = 17
      Caption = 'Vendidos'
      TabOrder = 2
      OnClick = cbxEstadoChange
    end
  end
  object RResultado: TDBGrid
    Left = 0
    Top = 42
    Width = 683
    Height = 484
    Align = alClient
    DataSource = DSMaestro
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = PopupMenu
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = RResultadoDblClick
    OnTitleClick = RResultadoTitleClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'empresa_t'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_salida_t'
        Title.Alignment = taCenter
        Title.Caption = 'C.Salida'
        Width = 50
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_destino_t'
        Title.Alignment = taCenter
        Title.Caption = 'C.Destino'
        Width = 50
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'referencia_t'
        Title.Alignment = taCenter
        Title.Caption = 'Referencia'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'fecha_t'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha'
        Width = 94
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_origen_t'
        Title.Alignment = taCenter
        Title.Caption = 'Origen P.'
        Width = 50
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'kilos_entran_t'
        Title.Alignment = taCenter
        Title.Caption = 'Tr'#225'nsito'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'kilos_salen_t'
        Title.Alignment = taCenter
        Title.Caption = 'Salida'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'kilos_quedan_t'
        Title.Alignment = taCenter
        Title.Caption = 'Quedan'
        Width = 80
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    AutoEdit = False
    DataSet = QConTransitosC
    Left = 272
    Top = 92
  end
  object QConTransitosC: TTable
    DatabaseName = 'BDProyecto'
    Filter = 'kilos_quedan_t>0'
    Filtered = True
    IndexDefs = <
      item
        Name = 'QConTransitosCIndex1'
      end>
    IndexFieldNames = 'referencia_t'
    ReadOnly = True
    StoreDefs = True
    TableName = 'tmp_transitos'
    Left = 240
    Top = 94
  end
  object PopupMenu: TPopupMenu
    Left = 256
    Top = 168
    object mnuReferencia: TMenuItem
      Caption = 'Buscar Tr'#225'nsito por Cod. Referencia (B)'
      OnClick = mnuReferenciaClick
    end
  end
end
