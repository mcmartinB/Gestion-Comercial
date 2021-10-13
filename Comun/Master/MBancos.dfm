object FMBancos: TFMBancos
  Left = 606
  Top = 320
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = '  BANCOS'
  ClientHeight = 308
  ClientWidth = 457
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  Visible = True
  OnActivate = FormActivate
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
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
    Width = 457
    Height = 308
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Lcomision: TLabel
      Left = 43
      Top = 174
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Comisi'#243'n Cambio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEmpresa_p: TLabel
      Left = 43
      Top = 57
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LAno_semana_p: TLabel
      Left = 43
      Top = 84
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Banco'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 258
      Top = 172
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' D'#237'as Valor'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 43
      Top = 114
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Poblaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 43
      Top = 144
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Cta. Bancaria'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 43
      Top = 205
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Cta. Contable'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 250
      Top = 205
      Width = 114
      Height = 19
      AutoSize = False
      Caption = ' Secci'#243'n Gastos Finan.'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object comision_cambio_b: TBDEdit
      Left = 143
      Top = 173
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce la comisi'#243'n de cambio'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      ShowDecimals = True
      MaxLength = 5
      TabOrder = 5
      DataField = 'comision_cambio_b'
      DataSource = DSMaestro
    end
    object banco_b: TBDEdit
      Tag = 1
      Left = 144
      Top = 56
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del banco. '
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'banco_b'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_b: TBDEdit
      Left = 144
      Top = 83
      Width = 265
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce la descripci'#243'n del banco.'
      OnRequiredTime = RequiredTime
      MaxLength = 35
      TabOrder = 1
      DataField = 'descripcion_b'
      DataSource = DSMaestro
    end
    object dias_valor_b: TBDEdit
      Left = 373
      Top = 171
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 4
      DataField = 'dias_valor_b'
      DataSource = DSMaestro
    end
    object poblacion_b: TBDEdit
      Left = 144
      Top = 113
      Width = 226
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 2
      DataField = 'poblacion_b'
      DataSource = DSMaestro
    end
    object cta_bancaria_b: TBDEdit
      Left = 144
      Top = 143
      Width = 226
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 31
      TabOrder = 3
      DataField = 'cta_bancaria_b'
      DataSource = DSMaestro
    end
    object cta_contable_b: TBDEdit
      Left = 144
      Top = 204
      Width = 76
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 8
      TabOrder = 6
      DataField = 'cta_contable_b'
      DataSource = DSMaestro
    end
    object seccion_b: TBDEdit
      Left = 373
      Top = 204
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 3
      TabOrder = 7
      DataField = 'seccion_b'
      DataSource = DSMaestro
    end
  end
  object DSMaestro: TDataSource
    DataSet = QBancos
    Left = 48
    Top = 8
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 352
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
    end
  end
  object QBancos: TQuery
    BeforeDelete = QBancosBeforeDelete
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_bancos'
      'order by empresa_b,banco_b')
    Left = 16
    Top = 9
    object QBancosbanco_b: TStringField
      FieldName = 'banco_b'
      Origin = 'frf_bancos.banco_b'
      Size = 3
    end
    object QBancosdescripcion_b: TStringField
      FieldName = 'descripcion_b'
      Origin = 'frf_bancos.descripcion_b'
      Size = 30
    end
    object QBancospoblacion_b: TStringField
      FieldName = 'poblacion_b'
      Origin = 'frf_bancos.poblacion_b'
      Size = 30
    end
    object QBancoscta_bancaria_b: TStringField
      DisplayWidth = 31
      FieldName = 'cta_bancaria_b'
      Origin = 'frf_bancos.cta_bancaria_b'
      Size = 31
    end
    object QBancoscomision_cambio_b: TFloatField
      FieldName = 'comision_cambio_b'
      Origin = 'frf_bancos.comision_cambio_b'
    end
    object QBancosdias_valor_b: TSmallintField
      FieldName = 'dias_valor_b'
      Origin = 'frf_bancos.dias_valor_b'
    end
    object QBancoscta_contable_b: TStringField
      FieldName = 'cta_contable_b'
      Origin = 'frf_bancos.cta_contable_b'
      Size = 8
    end
    object QBancosseccion_b: TStringField
      FieldName = 'seccion_b'
      Origin = 'frf_bancos.seccion_b'
      Size = 3
    end
  end
end
