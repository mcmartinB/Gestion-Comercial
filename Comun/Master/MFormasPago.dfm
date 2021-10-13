object FMFormaPago: TFMFormaPago
  Left = 572
  Top = 344
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = ' FORMAS DE PAGO'
  ClientHeight = 282
  ClientWidth = 576
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 37
    Top = 75
    Width = 90
    Height = 19
    AutoSize = False
    Caption = 'Empresa'
    Color = cl3DLight
    ParentColor = False
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 576
    Height = 282
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LCodigo_fp: TLabel
      Left = 40
      Top = 20
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LDias_cobro_fp: TLabel
      Left = 40
      Top = 230
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' D'#237'as cobro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LDescripcion_fp: TLabel
      Left = 40
      Top = 45
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 355
      Top = 230
      Width = 129
      Height = 19
      AutoSize = False
      Caption = ' Forma de Pago ADONIX'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object codigo_fp: TBDEdit
      Left = 138
      Top = 19
      Width = 31
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 0
      DataField = 'codigo_fp'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object dias_cobro_fp: TBDEdit
      Left = 138
      Top = 229
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 10
      DataField = 'dias_cobro_fp'
      DataSource = DSMaestro
    end
    object descripcion_fp: TBDEdit
      Tag = 1
      Left = 138
      Top = 44
      Width = 383
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 55
      TabOrder = 1
      DataField = 'descripcion_fp'
      DataSource = DSMaestro
    end
    object descripcion2_fp: TBDEdit
      Left = 138
      Top = 64
      Width = 383
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 55
      TabOrder = 2
      DataField = 'descripcion2_fp'
      DataSource = DSMaestro
    end
    object descripcion3_fp: TBDEdit
      Left = 138
      Top = 84
      Width = 383
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 55
      TabOrder = 3
      DataField = 'descripcion3_fp'
      DataSource = DSMaestro
    end
    object descripcion4_fp: TBDEdit
      Left = 138
      Top = 103
      Width = 383
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 55
      TabOrder = 4
      DataField = 'descripcion4_fp'
      DataSource = DSMaestro
    end
    object descripcion5_fp: TBDEdit
      Left = 138
      Top = 123
      Width = 383
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 55
      TabOrder = 5
      DataField = 'descripcion5_fp'
      DataSource = DSMaestro
    end
    object descripcion6_fp: TBDEdit
      Left = 138
      Top = 143
      Width = 383
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 55
      TabOrder = 6
      DataField = 'descripcion6_fp'
      DataSource = DSMaestro
    end
    object forma_pago_adonix_fp: TBDEdit
      Left = 493
      Top = 229
      Width = 28
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 11
      DataField = 'forma_pago_adonix_fp'
      DataSource = DSMaestro
    end
    object descripcion7_fp: TBDEdit
      Left = 138
      Top = 163
      Width = 383
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 55
      TabOrder = 7
      DataField = 'descripcion7_fp'
      DataSource = DSMaestro
    end
    object descripcion8_fp: TBDEdit
      Left = 138
      Top = 184
      Width = 383
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 55
      TabOrder = 8
      DataField = 'descripcion8_fp'
      DataSource = DSMaestro
    end
    object descripcion9_fp: TBDEdit
      Left = 138
      Top = 205
      Width = 383
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 55
      TabOrder = 9
      DataField = 'descripcion9_fp'
      DataSource = DSMaestro
    end
  end
  object DSMaestro: TDataSource
    DataSet = QFormaPago
    Left = 40
    Top = 80
  end
  object QFormaPago: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_forma_pago'
      'ORDER BY  codigo_fp')
    Left = 8
    Top = 8
  end
end
