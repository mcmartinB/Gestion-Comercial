object FDContadoresEmpresa: TFDContadoresEmpresa
  Left = 352
  Top = 202
  Caption = '    SERIES CONTADORES FACTURAS'
  ClientHeight = 532
  ClientWidth = 1068
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
  object btnAceptar: TSpeedButton
    Left = 185
    Top = 269
    Width = 148
    Height = 28
    Caption = 'Asignar Serie (F1)'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF000000FF0000000080FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF000000FF000000FF000000FF0000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF000000FF000000FF000000FF0000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF000000FF000000FF000000FF000000FF000000FF0000000080FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000080FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF3F7F7F
      7F000000FF000000FF0000000080FF00FF000000FF000000FF000000FF000000
      0000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF007F7F7F000000
      FF0000000080FF00FF00FF00FF80FF00FF00FF00FF000000FF000000FF000000
      0000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF000000FF000000FF000000
      FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF000000FF000000
      FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF000000
      FF000000FF0000000000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF007F7F7F000000FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF3F7F7F7F000000FF0000000000FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF000000FF000000FF0000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00}
    OnClick = btnAceptarClick
  end
  object btnCancelar: TSpeedButton
    Left = 489
    Top = 6
    Width = 146
    Height = 28
    Caption = 'Cerrar (Esc)'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FFBFFF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00
      FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
      FFBF0000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
      0000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
      FFBF00000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00
      FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FFBFFF00
      FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    OnClick = btnCancelarClick
  end
  object btnAnyadir: TSpeedButton
    Left = 339
    Top = 269
    Width = 146
    Height = 28
    Caption = 'Nueva Serie'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000000000000000000000000000FF000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000000000000000000000000000FF000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    OnClick = btnAnyadirClick
  end
  object btnModificar: TSpeedButton
    Left = 491
    Top = 269
    Width = 148
    Height = 28
    Caption = 'Modificar Serie'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF0000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FF00FF00FF00FF007B7B7B007B7B7B0000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000FF00FF007B7B7B0000FFFF0000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000007B7B7B0000FFFF007B7B7B007B7B7B000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000007B7B7B0000FFFF007B7B7B000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000FFFF007B7B7B0000FFFF007B7B
      7B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FFFF007B7B7B007B7B
      7B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000007B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000007B7B7B000000
      7B007B7B7B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000007B007B7B
      7B0000007B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    OnClick = btnModificarClick
  end
  object lblCodigo1: TnbLabel
    Left = 29
    Top = 39
    Width = 100
    Height = 21
    Caption = 'A'#241'o'
    About = 'NB 0.1/20020725'
  end
  object lblEmpresa: TnbLabel
    Left = 29
    Top = 13
    Width = 100
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object lblDesEmpresa: TLabel
    Left = 187
    Top = 13
    Width = 70
    Height = 13
    Caption = 'lblDesEmpresa'
  end
  object lblCodigo3: TnbLabel
    Left = 29
    Top = 175
    Width = 304
    Height = 21
    Caption = 'SERIES POSIBLES'
    About = 'NB 0.1/20020725'
  end
  object btnDesasignar: TSpeedButton
    Left = 185
    Top = 87
    Width = 148
    Height = 28
    Caption = 'Desasignar Serie'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF000000FF0000000080FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF000000FF000000FF000000FF0000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF000000FF000000FF000000FF0000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF000000FF000000FF000000FF000000FF000000FF0000000080FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000080FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF3F7F7F
      7F000000FF000000FF0000000080FF00FF000000FF000000FF000000FF000000
      0000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF007F7F7F000000
      FF0000000080FF00FF00FF00FF80FF00FF00FF00FF000000FF000000FF000000
      0000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF000000FF000000FF000000
      FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF000000FF000000
      FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF000000
      FF000000FF0000000000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF007F7F7F000000FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF3F7F7F7F000000FF0000000000FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF000000FF000000FF0000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00}
    OnClick = btnDesasignarClick
  end
  object dbgContadores: TDBGrid
    Left = 0
    Top = 121
    Width = 1068
    Height = 142
    TabStop = False
    Color = clBtnFace
    DataSource = dsContador
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbgContadoresDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'cod_serie_fs'
        Title.Caption = 'Serie'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'anyo_fs'
        Title.Caption = 'A'#241'o'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fac_iva_fs'
        Title.Caption = 'Factura IVA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_fac_iva_fs'
        Title.Caption = 'Fec. Factura IVA'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pre_fac_iva_fs'
        Title.Caption = 'Pref. Fact. IVA'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'abn_iva_fs'
        Title.Caption = 'Abono IVA'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_abn_iva_fs'
        Title.Caption = 'Fec . Abono IVA'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pre_abn_iva_fs'
        Title.Caption = 'Pref. Abono IVA'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fac_igic_fs'
        Title.Caption = 'Factura IGIC'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_fac_igic_fs'
        Title.Caption = 'Fec. Factura IGIC'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pre_fac_igic_fs'
        Title.Caption = 'Pref. Fact. IGIC'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'abn_igic_fs'
        Title.Caption = 'Abono IGIC'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_abn_igic_fs'
        Title.Caption = 'Fec. Abono IGIC'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pre_abn_igic_fs'
        Title.Caption = 'Pref. Abono IGIC'
        Width = 88
        Visible = True
      end>
  end
  object btnFiltrar: TButton
    Left = 187
    Top = 36
    Width = 148
    Height = 28
    Caption = 'Filtrar'
    TabOrder = 1
    OnClick = btnFiltrarClick
  end
  object edtAnyo: TEdit
    Left = 137
    Top = 39
    Width = 38
    Height = 21
    MaxLength = 4
    TabOrder = 2
  end
  object edtEmpresa: TEdit
    Left = 137
    Top = 13
    Width = 38
    Height = 21
    Enabled = False
    MaxLength = 3
    ReadOnly = True
    TabOrder = 0
    OnChange = edtEmpresaChange
  end
  object dbgrd1: TDBGrid
    Left = 0
    Top = 314
    Width = 1068
    Height = 218
    TabStop = False
    Align = alBottom
    Color = clBtnFace
    DataSource = dsContadores
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbgContadoresDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'cod_serie_Fs'
        Title.Caption = 'Serie'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'anyo_fs'
        Title.Caption = 'A'#241'o'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fac_iva_fs'
        Title.Caption = 'Factura IVA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_fac_iva_fs'
        Title.Caption = 'Factura IVA'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pre_fac_iva_fs'
        Title.Caption = 'Pref. Fact. IVA'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'abn_iva_fs'
        Title.Caption = 'Abono IVA'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_abn_iva_fs'
        Title.Caption = 'Abono IVA'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pre_abn_iva_fs'
        Title.Caption = 'Pref. Abono IVA'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fac_igic_fs'
        Title.Caption = 'Factura IGIC'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_fac_igic_fs'
        Title.Caption = 'Factura IGIC'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pre_fac_igic_fs'
        Title.Caption = 'Pref. Fact. IGIC'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'abn_igic_fs'
        Title.Caption = 'Abono IGIC'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_abn_igic_fs'
        Title.Caption = 'Abono IGIC'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pre_abn_igic_fs'
        Title.Caption = 'Pref. Abono IGIC'
        Width = 88
        Visible = True
      end>
  end
  object QContadores: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * from frf_empresas_contadores ')
    Left = 70
    Top = 210
  end
  object dsContadores: TDataSource
    DataSet = QContadores
    Left = 103
    Top = 210
  end
  object QContador: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * from frf_empresas_contadores ')
    Left = 101
    Top = 134
  end
  object dsContador: TDataSource
    DataSet = QContador
    Left = 134
    Top = 134
  end
  object qryAsignar: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * from frf_empresas_contadores ')
    Left = 291
    Top = 211
  end
  object qryDesasignar: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * from frf_empresas_contadores ')
    Left = 323
    Top = 211
  end
end
