object FMEmpresas: TFMEmpresas
  Left = 474
  Top = 200
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  EMPRESAS'
  ClientHeight = 514
  ClientWidth = 651
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
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 514
    Align = alClient
    BevelInner = bvLowered
    Locked = True
    TabOrder = 0
    object Label1: TLabel
      Left = 38
      Top = 27
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 297
      Top = 27
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Nombre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 40
      Top = 50
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Nif'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 38
      Top = 73
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Domicilio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 38
      Top = 96
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Poblaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 297
      Top = 96
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo Postal'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBTipoVia: TBGridButton
      Left = 147
      Top = 72
      Width = 13
      Height = 20
      Action = ARejillaDespegable
      Control = tipo_via_e
      Grid = RejillaFlotante
      GridAlignment = taUpRight
      GridWidth = 230
      GridHeigth = 95
    end
    object Label11: TLabel
      Left = 297
      Top = 50
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo EAN13'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 18
      Top = 387
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Relaci'#243'n Facturas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label14: TLabel
      Left = 229
      Top = 387
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Referencia Cobros'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 440
      Top = 387
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Contador Entregas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 18
      Top = 410
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Contador Giros'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 229
      Top = 410
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Remesas Giro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl1: TLabel
      Left = 39
      Top = 123
      Width = 80
      Height = 19
      AutoSize = False
      Caption = 'EORI'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl2: TLabel
      Left = 39
      Top = 150
      Width = 80
      Height = 19
      Hint = 'N'#250'mero de exportador autorizado'
      AutoSize = False
      Caption = 'Exportador. aut.'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
    end
    object cod_postal_e: TBDEdit
      Left = 382
      Top = 95
      Width = 49
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 5
      TabOrder = 7
      OnChange = cod_postal_eChange
      DataField = 'cod_postal_e'
      DataSource = DSMaestro
    end
    object poblacion_e: TBDEdit
      Left = 122
      Top = 95
      Width = 162
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 6
      DataField = 'poblacion_e'
      DataSource = DSMaestro
    end
    object domicilio_e: TBDEdit
      Left = 160
      Top = 72
      Width = 219
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 5
      DataField = 'domicilio_e'
      DataSource = DSMaestro
    end
    object tipo_via_e: TBDEdit
      Left = 122
      Top = 72
      Width = 23
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 4
      DataField = 'tipo_via_e'
      DataSource = DSMaestro
    end
    object nif_e: TBDEdit
      Left = 122
      Top = 49
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 12
      TabOrder = 2
      DataField = 'nif_e'
      DataSource = DSMaestro
    end
    object empresa_e: TBDEdit
      Left = 122
      Top = 26
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'empresa_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STProvincia: TStaticText
      Left = 432
      Top = 97
      Width = 169
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 8
    end
    object codigo_ean_e: TBDEdit
      Left = 382
      Top = 49
      Width = 99
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 13
      TabOrder = 3
      DataField = 'codigo_ean_e'
      DataSource = DSMaestro
    end
    object ref_cobros_e: TBDEdit
      Left = 334
      Top = 387
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El contador de referencia de cobros es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 7
      TabOrder = 13
      DataField = 'ref_cobros_e'
      DataSource = DSMaestro
    end
    object cont_relfac_e: TBDEdit
      Left = 123
      Top = 387
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El contador de relaciones de factura es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 7
      TabOrder = 12
      DataField = 'cont_relfac_e'
      DataSource = DSMaestro
    end
    object cont_entregas_e: TBDEdit
      Left = 546
      Top = 387
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El contador de referencia de cobros es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 7
      TabOrder = 14
      DataField = 'cont_entregas_e'
      DataSource = DSMaestro
    end
    object dbgContadores: TDBGrid
      Left = 18
      Top = 204
      Width = 617
      Height = 172
      TabStop = False
      Color = clBtnFace
      DataSource = dsContadores
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 11
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'cod_serie_fs'
          Title.Caption = 'Serie'
          Width = 48
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'anyo_fs'
          Title.Caption = 'A'#241'o'
          Width = 48
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fac_iva_fs'
          Title.Caption = 'N.Fact.IVA'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha_fac_iva_fs'
          Title.Caption = 'F.Fact.IVA'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'abn_iva_fs'
          Title.Caption = 'N.Abn.IVA'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha_abn_iva_fs'
          Title.Caption = 'F.Abn.IVA'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fac_igic_fs'
          Title.Caption = 'N.Fact.IGIC'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha_fac_igic_fs'
          Title.Caption = 'F.Fact.IGIC'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'abn_igic_fs'
          Title.Caption = 'N.Abn.IGIC'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha_abn_igic_fs'
          ImeName = 'fecha_abn_igic_fs'
          Title.Caption = 'F.Abn.IGIC'
          Width = 58
          Visible = True
        end>
    end
    object nombre_e: TBDEdit
      Left = 382
      Top = 26
      Width = 233
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El nombre de la empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 1
      DataField = 'nombre_e'
      DataSource = DSMaestro
    end
    object cont_giros_e: TBDEdit
      Left = 123
      Top = 410
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El contador de relaciones de factura es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 7
      TabOrder = 15
      DataField = 'cont_giros_e'
      DataSource = DSMaestro
    end
    object cont_remesas_giro_e: TBDEdit
      Left = 334
      Top = 410
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El contador de referencia de cobros es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 7
      TabOrder = 16
      DataField = 'cont_remesas_giro_e'
      DataSource = DSMaestro
    end
    object BDEdit1: TBDEdit
      Left = 123
      Top = 122
      Width = 162
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 17
      TabOrder = 9
      DataField = 'eori_empresa_e'
      DataSource = DSMaestro
    end
    object BDEdit2: TBDEdit
      Left = 123
      Top = 149
      Width = 162
      Height = 21
      Hint = 'N'#250'mero de exportador autorizado'
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 14
      TabOrder = 10
      DataField = 'num_exp_autorizado_e'
      DataSource = DSMaestro
    end
  end
  object pnl1: TPanel
    Left = 450
    Top = 121
    Width = 185
    Height = 23
    BevelOuter = bvNone
    TabOrder = 2
    object btnContadores: TBitBtn
      Left = 88
      Top = 0
      Width = 97
      Height = 23
      Caption = 'Contadores'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = btnContadoresClick
    end
  end
  object RejillaFlotante: TBGrid
    Left = 318
    Top = 15
    Width = 25
    Height = 17
    Color = clInfoBk
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    ColumnFind = 1
  end
  object DSMaestro: TDataSource
    DataSet = QEmpresas
    Left = 42
    Top = 5
  end
  object ActionList1: TActionList
    Left = 8
    Top = 35
    object ARejillaDespegable: TAction
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaDespegableExecute
    end
  end
  object QEmpresas: TQuery
    AfterOpen = QEmpresasAfterOpen
    BeforeClose = QEmpresasBeforeClose
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_empresas '
      'ORDER BY nombre_e')
    Left = 8
    Top = 5
  end
  object qryContadores: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select * from frf_empresas_contadores ')
    Left = 33
    Top = 245
  end
  object dsContadores: TDataSource
    DataSet = qryContadores
    Left = 65
    Top = 245
  end
end
