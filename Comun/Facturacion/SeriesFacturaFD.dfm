object FDSeriesFactura: TFDSeriesFactura
  Left = 548
  Top = 277
  ActiveControl = cod_serie_fs
  Caption = '    SERIES CONTADORES FACTURAS'
  ClientHeight = 207
  ClientWidth = 706
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnAceptar: TSpeedButton
    Left = 338
    Top = 167
    Width = 105
    Height = 28
    Caption = 'Aceptar (F1)'
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
    Left = 231
    Top = 167
    Width = 105
    Height = 28
    Caption = 'Cancelar (Esc)'
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
  object pnlMaestro: TPanel
    Left = 8
    Top = 12
    Width = 659
    Height = 149
    TabOrder = 0
    object nbLabel2: TnbLabel
      Left = 203
      Top = 64
      Width = 100
      Height = 21
      Caption = 'Fecha Abono IVA'
      About = 'NB 0.1/20020725'
    end
    object nbLabel3: TnbLabel
      Left = 33
      Top = 9
      Width = 100
      Height = 21
      Caption = 'Serie'
      About = 'NB 0.1/20020725'
    end
    object lblFechaFinal: TnbLabel
      Left = 203
      Top = 38
      Width = 100
      Height = 21
      Caption = 'Fecha Factura IVA'
      About = 'NB 0.1/20020725'
    end
    object lbl1: TnbLabel
      Left = 203
      Top = 9
      Width = 100
      Height = 21
      Caption = 'A'#241'o'
      About = 'NB 0.1/20020725'
    end
    object lblCodigo1: TnbLabel
      Left = 33
      Top = 38
      Width = 100
      Height = 21
      Caption = 'Factura IVA'
      About = 'NB 0.1/20020725'
    end
    object lblCodigo2: TnbLabel
      Left = 33
      Top = 64
      Width = 100
      Height = 21
      Caption = 'Abono IVA'
      About = 'NB 0.1/20020725'
    end
    object lblCodigo3: TnbLabel
      Left = 203
      Top = 116
      Width = 100
      Height = 21
      Caption = 'Fecha Abono IGIC'
      About = 'NB 0.1/20020725'
    end
    object lblCodigo4: TnbLabel
      Left = 203
      Top = 90
      Width = 100
      Height = 21
      Caption = 'Fecha Factura IGIC'
      About = 'NB 0.1/20020725'
    end
    object lblCodigo5: TnbLabel
      Left = 33
      Top = 90
      Width = 100
      Height = 21
      Caption = 'Factura IGIC'
      About = 'NB 0.1/20020725'
    end
    object lblCodigo6: TnbLabel
      Left = 33
      Top = 116
      Width = 100
      Height = 21
      Caption = 'Abono IGIC'
      About = 'NB 0.1/20020725'
    end
    object nbLabel1: TnbLabel
      Left = 433
      Top = 38
      Width = 100
      Height = 21
      Caption = 'Prefijo Factura IVA'
      About = 'NB 0.1/20020725'
    end
    object nbLabel4: TnbLabel
      Left = 433
      Top = 64
      Width = 100
      Height = 21
      Caption = 'Prefijo Abono IVA'
      About = 'NB 0.1/20020725'
    end
    object nbLabel5: TnbLabel
      Left = 433
      Top = 90
      Width = 100
      Height = 21
      Caption = 'Prefijo Factura IGIC'
      About = 'NB 0.1/20020725'
    end
    object nbLabel6: TnbLabel
      Left = 433
      Top = 116
      Width = 100
      Height = 21
      Caption = 'Prefijo Abono IGIC'
      About = 'NB 0.1/20020725'
    end
    object cod_serie_fs: TBDEdit
      Left = 138
      Top = 9
      Width = 41
      Height = 21
      TabStop = False
      MaxLength = 3
      TabOrder = 0
      DataField = 'cod_serie_fs'
      DataSource = dsContadores
    end
    object fecha_abn_iva_fs: TnbDBCalendarCombo
      Left = 308
      Top = 64
      Width = 100
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 6
      DataField = 'fecha_abn_iva_fs'
      DataSource = dsContadores
      DBLink = True
    end
    object fecha_fac_iva_fs: TnbDBCalendarCombo
      Left = 308
      Top = 38
      Width = 100
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 3
      DataField = 'fecha_fac_iva_fs'
      DataSource = dsContadores
      DBLink = True
    end
    object fac_iva_fs: TnbDBNumeric
      Left = 138
      Top = 38
      Width = 49
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 2
      DataField = 'fac_iva_fs'
      DataSource = dsContadores
      DBLink = True
      NumIntegers = 6
    end
    object abn_iva_fs: TnbDBNumeric
      Left = 138
      Top = 64
      Width = 49
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 5
      DataField = 'abn_iva_fs'
      DataSource = dsContadores
      DBLink = True
      NumIntegers = 6
    end
    object fecha_abn_igic_fs: TnbDBCalendarCombo
      Left = 308
      Top = 116
      Width = 100
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 12
      DataField = 'fecha_abn_igic_fs'
      DataSource = dsContadores
      DBLink = True
    end
    object fecha_fac_igic_fs: TnbDBCalendarCombo
      Left = 308
      Top = 90
      Width = 100
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 9
      DataField = 'fecha_fac_igic_fs'
      DataSource = dsContadores
      DBLink = True
    end
    object fac_igic_fs: TnbDBNumeric
      Left = 138
      Top = 90
      Width = 49
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 8
      DataField = 'fac_igic_fs'
      DataSource = dsContadores
      DBLink = True
      NumIntegers = 6
    end
    object abn_igic_fs: TnbDBNumeric
      Left = 138
      Top = 116
      Width = 49
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 11
      DataField = 'abn_igic_fs'
      DataSource = dsContadores
      DBLink = True
      NumIntegers = 6
    end
    object pre_fac_iva_fs: TBDEdit
      Left = 542
      Top = 38
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El prefijo de facturaci'#243'n es de obligada inserci'#243'n'
      MaxLength = 3
      TabOrder = 4
      DataField = 'pre_fac_iva_fs'
      DataSource = dsContadores
      Modificable = False
      PrimaryKey = True
    end
    object pre_abn_iva_fs: TBDEdit
      Left = 542
      Top = 64
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El prefijo de facturaci'#243'n es de obligada inserci'#243'n'
      MaxLength = 3
      TabOrder = 7
      DataField = 'pre_abn_iva_fs'
      DataSource = dsContadores
      Modificable = False
      PrimaryKey = True
    end
    object pre_fac_igic_fs: TBDEdit
      Left = 542
      Top = 90
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El prefijo de facturaci'#243'n es de obligada inserci'#243'n'
      MaxLength = 3
      TabOrder = 10
      DataField = 'pre_fac_igic_fs'
      DataSource = dsContadores
      Modificable = False
      PrimaryKey = True
    end
    object pre_abn_igic_fs: TBDEdit
      Left = 542
      Top = 116
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El prefijo de facturaci'#243'n es de obligada inserci'#243'n'
      MaxLength = 3
      TabOrder = 13
      DataField = 'pre_abn_igic_fs'
      DataSource = dsContadores
      Modificable = False
      PrimaryKey = True
    end
    object anyo_fs: TBDEdit
      Left = 308
      Top = 9
      Width = 49
      Height = 21
      MaxLength = 4
      TabOrder = 1
      DataField = 'anyo_fs'
      DataSource = dsContadores
      PrimaryKey = True
    end
  end
  object QContadores: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * from frf_empresas_contadores ')
    Left = 31
    Top = 163
  end
  object dsContadores: TDataSource
    DataSet = QContadores
    Left = 67
    Top = 164
  end
end
