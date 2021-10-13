object FMCentros: TFMCentros
  Left = 559
  Top = 184
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  CENTROS'
  ClientHeight = 451
  ClientWidth = 500
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
  OnKeyUp = FormKeyUp
  DesignSize = (
    500
    451)
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
    Width = 500
    Height = 451
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 40
      Top = 66
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 40
      Top = 89
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 40
      Top = 44
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 40
      Top = 135
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Direcci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_c: TBGridButton
      Left = 161
      Top = 43
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = empresa_c
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object Label7: TLabel
      Left = 40
      Top = 226
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Tipo Impuesto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 40
      Top = 157
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Poblaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 40
      Top = 180
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo Postal'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label11: TLabel
      Left = 219
      Top = 226
      Width = 138
      Height = 19
      AutoSize = False
      Caption = ' Secci'#243'n Diferencia Cambio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label14: TLabel
      Left = 40
      Top = 203
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Pa'#237's'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label15: TLabel
      Left = 40
      Top = 112
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' E-Mail'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object direccion_c: TBDEdit
      Left = 128
      Top = 134
      Width = 266
      Height = 21
      ColorEdit = clMoneyGreen
      TabOrder = 5
      DataField = 'direccion_c'
      DataSource = DSMaestro
    end
    object empresa_c: TBDEdit
      Left = 128
      Top = 43
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'empresa_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa_c: TStaticText
      Left = 176
      Top = 45
      Width = 215
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object descripcion_c: TBDEdit
      Left = 128
      Top = 88
      Width = 266
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      TabOrder = 3
      DataField = 'descripcion_c'
      DataSource = DSMaestro
    end
    object centro_c: TBDEdit
      Left = 128
      Top = 65
      Width = 17
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del centro es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      TabOrder = 2
      DataField = 'centro_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object GroupBox1: TGroupBox
      Left = 40
      Top = 267
      Width = 356
      Height = 126
      Caption = 'Contadores'
      TabOrder = 13
      object Label6: TLabel
        Left = 21
        Top = 64
        Width = 80
        Height = 19
        AutoSize = False
        Caption = ' Albaranes'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label5: TLabel
        Left = 21
        Top = 43
        Width = 80
        Height = 19
        AutoSize = False
        Caption = ' Entradas'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label8: TLabel
        Left = 21
        Top = 85
        Width = 80
        Height = 19
        AutoSize = False
        Caption = ' Tr'#225'nsitos'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label12: TLabel
        Left = 177
        Top = 64
        Width = 80
        Height = 19
        AutoSize = False
        Caption = ' Facturas Control'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lblMsgContadores: TLabel
        Left = 21
        Top = 23
        Width = 190
        Height = 13
        Caption = 'Indica el n'#250'mero del pr'#243'ximo documento'
      end
      object lblNombre1: TLabel
        Left = 177
        Top = 43
        Width = 80
        Height = 19
        AutoSize = False
        Caption = ' Compras'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object cont_entradas_c: TBDEdit
        Left = 102
        Top = 42
        Width = 71
        Height = 21
        ColorEdit = clMoneyGreen
        Required = True
        OnRequiredTime = RequiredTime
        TabOrder = 0
        DataField = 'cont_entradas_c'
        DataSource = DSMaestro
      end
      object cont_albaranes_c: TBDEdit
        Left = 102
        Top = 63
        Width = 71
        Height = 21
        ColorEdit = clMoneyGreen
        Required = True
        OnRequiredTime = RequiredTime
        TabOrder = 2
        DataField = 'cont_albaranes_c'
        DataSource = DSMaestro
      end
      object cont_transitos_c: TBDEdit
        Left = 102
        Top = 84
        Width = 71
        Height = 21
        ColorEdit = clMoneyGreen
        Required = True
        OnRequiredTime = RequiredTime
        InputType = itInteger
        TabOrder = 4
        DataField = 'cont_transitos_c'
        DataSource = DSMaestro
      end
      object cont_faccontrol_c: TBDEdit
        Left = 258
        Top = 63
        Width = 71
        Height = 21
        ColorEdit = clMoneyGreen
        Required = True
        OnRequiredTime = RequiredTime
        InputType = itInteger
        TabOrder = 3
        DataField = 'cont_faccontrol_c'
        DataSource = DSMaestro
      end
      object cont_compras_c: TBDEdit
        Left = 258
        Top = 42
        Width = 71
        Height = 21
        ColorEdit = clMoneyGreen
        Required = True
        OnRequiredTime = RequiredTime
        InputType = itInteger
        TabOrder = 1
        DataField = 'cont_compras_c'
        DataSource = DSMaestro
      end
    end
    object poblacion_c: TBDEdit
      Left = 128
      Top = 156
      Width = 162
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 6
      DataField = 'poblacion_c'
      DataSource = DSMaestro
    end
    object cod_postal_c: TBDEdit
      Left = 128
      Top = 179
      Width = 49
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 5
      TabOrder = 7
      DataField = 'cod_postal_c'
      DataSource = DSMaestro
    end
    object STProvincia: TStaticText
      Left = 179
      Top = 181
      Width = 185
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 8
    end
    object sec_dif_cambio_c: TBDEdit
      Left = 364
      Top = 225
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 12
      DataField = 'sec_dif_cambio_c'
      DataSource = DSMaestro
    end
    object tipo_impuesto_c: TComboBox
      Left = 128
      Top = 225
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 11
      Text = 'IVA'
      OnChange = tipo_impuesto_cChange
      OnEnter = tipo_impuesto_cEnter
      OnExit = tipo_impuesto_cExit
      Items.Strings = (
        'IVA'
        'IGIC'
        'EXENTO')
    end
    object pais_c: TBDEdit
      Left = 128
      Top = 202
      Width = 25
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 9
      OnChange = pais_cChange
      DataField = 'pais_c'
      DataSource = DSMaestro
    end
    object STPais: TStaticText
      Left = 157
      Top = 204
      Width = 185
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 10
    end
    object email_c: TBDEdit
      Left = 128
      Top = 111
      Width = 266
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      TabOrder = 4
      DataField = 'email_c'
      DataSource = DSMaestro
    end
  end
  object pnlBoton: TPanel
    Left = 405
    Top = 45
    Width = 81
    Height = 61
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 1
  end
  object RejillaFlotante: TBGrid
    Left = 359
    Top = 314
    Width = 73
    Height = 33
    Color = clInfoBk
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    BControl = empresa_c
  end
  object DSMaestro: TDataSource
    DataSet = QCentros
    OnDataChange = DSMaestroDataChange
    Left = 200
    Top = 8
  end
  object ACosecheros: TActionList
    Left = 344
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QCentros: TQuery
    AfterInsert = QCentrosAfterInsert
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * '
      'FROM frf_centros'
      'ORDER BY centro_c')
    Left = 168
    Top = 9
  end
end
