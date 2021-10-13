object FInventario: TFInventario
  Left = 410
  Top = 168
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    INVENTARIO DE ALMAC'#201'N (Existencias a '#250'ltima hora del d'#237'a)'
  ClientHeight = 558
  ClientWidth = 749
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
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 749
    Height = 259
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object bvl3: TBevel
      Left = 28
      Top = 165
      Width = 689
      Height = 88
    end
    object Bevel5: TBevel
      Left = 28
      Top = 76
      Width = 152
      Height = 88
    end
    object LEmpresa_p: TLabel
      Left = 366
      Top = 22
      Width = 90
      Height = 19
      AutoSize = False
      Caption = 'Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LAno_semana_p: TLabel
      Left = 25
      Top = 46
      Width = 90
      Height = 19
      AutoSize = False
      Caption = 'Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 366
      Top = 44
      Width = 89
      Height = 19
      AutoSize = False
      Caption = 'Fecha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 96
      Top = 81
      Width = 75
      Height = 32
      Hint = 'Kilos Camara Entrada de Campo'
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Entrada Campo'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 25
      Top = 22
      Width = 90
      Height = 19
      AutoSize = False
      Caption = 'Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl_kilos_cim: TLabel
      Left = 249
      Top = 81
      Width = 75
      Height = 32
      Hint = 'Kilos Camara Intermedia Manual'
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Intermedia'#13#10'Manual'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
    end
    object lbl_kilos_cia: TLabel
      Left = 327
      Top = 81
      Width = 75
      Height = 32
      Hint = 'Kilos Camara Intermedia Autom'#225'tica'
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Intermedia '#13#10'Autom'#225'tica'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
    end
    object lbl_kilos_zd: TLabel
      Left = 635
      Top = 81
      Width = 75
      Height = 32
      Hint = 'Kilos Zona Destrios'
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Ajustes *'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
    end
    object lbl_kilos_cim_c1_ic: TLabel
      Left = 186
      Top = 116
      Width = 60
      Height = 21
      AutoSize = False
      Caption = 'Cat. I'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = False
      Layout = tlCenter
    end
    object lbl_kilos_zd_c3_ic: TLabel
      Left = 490
      Top = 116
      Width = 60
      Height = 21
      AutoSize = False
      Caption = 'Cat. III'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = False
      Layout = tlCenter
    end
    object lbl_kilos_cim_c2_ic: TLabel
      Left = 186
      Top = 138
      Width = 60
      Height = 21
      AutoSize = False
      Caption = 'Cat II'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = False
      Layout = tlCenter
    end
    object lbl_kilos_zd_d_ic: TLabel
      Left = 490
      Top = 138
      Width = 60
      Height = 21
      AutoSize = False
      Caption = 'Destrio'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 34
      Top = 170
      Width = 42
      Height = 20
      Hint = 'Kilos Camara Entrada de Campo'
      AutoSize = False
      Caption = 'NOTAS'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
    end
    object lbl_des_empresa: TnbStaticText
      Left = 139
      Top = 21
      Width = 218
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object lbl_des_producto: TnbStaticText
      Left = 139
      Top = 45
      Width = 218
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object lbl_des_centro: TnbStaticText
      Left = 484
      Top = 21
      Width = 218
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object lblAjustes: TLabel
      Left = 405
      Top = 81
      Width = 75
      Height = 32
      Hint = 'Kilos Camara Intermedia Autom'#225'tica'
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Ajustes *'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
    end
    object lbl1: TLabel
      Left = 179
      Top = 163
      Width = 312
      Height = 13
      Caption = 
        '* Para el ajuste de la merma, solo aplica en la fecha de fin cal' +
        'culo.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 553
      Top = 81
      Width = 75
      Height = 32
      Hint = 'Kilos Zona Destrios'
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Zona Destrio'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
    end
    object lbl3: TLabel
      Left = 34
      Top = 116
      Width = 60
      Height = 21
      AutoSize = False
      Caption = 'Entrada'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = False
      Layout = tlCenter
    end
    object lbl4: TLabel
      Left = 34
      Top = 138
      Width = 60
      Height = 21
      AutoSize = False
      Caption = 'Ajuste *'
      Color = cl3DLight
      ParentColor = False
      ParentShowHint = False
      ShowHint = False
      Layout = tlCenter
    end
    object bvl1: TBevel
      Left = 177
      Top = 76
      Width = 310
      Height = 88
    end
    object bvl2: TBevel
      Left = 485
      Top = 76
      Width = 232
      Height = 88
    end
    object centro_ic: TBDEdit
      Tag = 1
      Left = 442
      Top = 21
      Width = 15
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del banco. '
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 1
      OnChange = centro_icChange
      DataField = 'centro_ic'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object producto_ic: TBDEdit
      Left = 101
      Top = 45
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce la descripci'#243'n del banco.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 2
      OnChange = producto_icChange
      DataField = 'producto_ic'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object fecha_ic: TBDEdit
      Left = 442
      Top = 45
      Width = 75
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 3
      DataField = 'fecha_ic'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object kilos_cec_ic: TBDEdit
      Left = 96
      Top = 116
      Width = 75
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 4
      DataField = 'kilos_cec_ic'
      DataSource = DSMaestro
    end
    object empresa_ic: TBDEdit
      Tag = 1
      Left = 101
      Top = 21
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del banco. '
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_icChange
      DataField = 'empresa_ic'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object kilos_cim_c1_ic: TBDEdit
      Left = 249
      Top = 116
      Width = 75
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 5
      DataField = 'kilos_cim_c1_ic'
      DataSource = DSMaestro
    end
    object kilos_cia_c1_ic: TBDEdit
      Left = 327
      Top = 116
      Width = 75
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 6
      DataField = 'kilos_cia_c1_ic'
      DataSource = DSMaestro
    end
    object kilos_zd_c3_ic: TBDEdit
      Left = 553
      Top = 116
      Width = 75
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 8
      DataField = 'kilos_zd_c3_ic'
      DataSource = DSMaestro
    end
    object kilos_cim_c2_ic: TBDEdit
      Left = 248
      Top = 138
      Width = 75
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 11
      DataField = 'kilos_cim_c2_ic'
      DataSource = DSMaestro
    end
    object kilos_cia_c2_ic: TBDEdit
      Left = 327
      Top = 138
      Width = 75
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 12
      DataField = 'kilos_cia_c2_ic'
      DataSource = DSMaestro
    end
    object kilos_zd_d_ic: TBDEdit
      Left = 553
      Top = 138
      Width = 75
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 14
      DataField = 'kilos_zd_d_ic'
      DataSource = DSMaestro
    end
    object notas_ic: TDBMemo
      Left = 77
      Top = 182
      Width = 631
      Height = 65
      DataField = 'notas_ic'
      DataSource = DSMaestro
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      OnEnter = notas_icEnter
      OnExit = notas_icExit
    end
    object kilos_ajuste_c1_ic: TBDEdit
      Left = 405
      Top = 116
      Width = 75
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clBtnFace
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TabOrder = 7
      DataField = 'kilos_ajuste_c1_ic'
      DataSource = DSMaestro
    end
    object kilos_ajuste_c2_ic: TBDEdit
      Left = 405
      Top = 138
      Width = 75
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clBtnFace
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TabOrder = 13
      DataField = 'kilos_ajuste_c2_ic'
      DataSource = DSMaestro
    end
    object kilos_ajuste_c3_ic: TBDEdit
      Left = 635
      Top = 116
      Width = 75
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clBtnFace
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TabOrder = 9
      DataField = 'kilos_ajuste_c3_ic'
      DataSource = DSMaestro
    end
    object kilos_ajuste_cd_ic: TBDEdit
      Left = 635
      Top = 138
      Width = 75
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clBtnFace
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TabOrder = 15
      DataField = 'kilos_ajuste_cd_ic'
      DataSource = DSMaestro
    end
    object kilos_ajuste_campo_ic: TBDEdit
      Left = 96
      Top = 138
      Width = 75
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clBtnFace
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TabOrder = 10
      DataField = 'kilos_ajuste_campo_ic'
      DataSource = DSMaestro
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 259
    Width = 749
    Height = 299
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object PDetalle: TPanel
      Left = 1
      Top = 1
      Width = 747
      Height = 143
      Align = alTop
      TabOrder = 0
      object lblKilos2: TLabel
        Left = 345
        Top = 107
        Width = 89
        Height = 19
        Hint = 'Kilos Camara Entrada de Campo'
        AutoSize = False
        Caption = ' Kilos Cat. II'
        Color = cl3DLight
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        Layout = tlCenter
      end
      object lblKilos1: TLabel
        Left = 345
        Top = 85
        Width = 89
        Height = 19
        Hint = 'Kilos Camara Intermedia Manual'
        AutoSize = False
        Caption = ' Kilos Cat. I'
        Color = cl3DLight
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        Layout = tlCenter
      end
      object Label15: TLabel
        Left = 185
        Top = 38
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Art'#237'culo'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label16: TLabel
        Left = 24
        Top = 15
        Width = 140
        Height = 13
        Caption = 'C'#225'mara de Expediciones'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCajas2: TLabel
        Left = 185
        Top = 107
        Width = 89
        Height = 19
        Hint = 'Kilos Camara Entrada de Campo'
        AutoSize = False
        Caption = ' Cajas Cat. II'
        Color = cl3DLight
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        Layout = tlCenter
      end
      object lblCajas1: TLabel
        Left = 185
        Top = 85
        Width = 89
        Height = 19
        Hint = 'Kilos Camara Intermedia Manual'
        AutoSize = False
        Caption = ' Cajas Cat. I'
        Color = cl3DLight
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        Layout = tlCenter
      end
      object lblDesEnvase: TnbStaticText
        Left = 359
        Top = 38
        Width = 196
        Height = 21
        About = 'NB 0.1/20020725'
      end
      object lblCalibre: TLabel
        Left = 185
        Top = 62
        Width = 89
        Height = 19
        Hint = 'Kilos Camara Intermedia Manual'
        AutoSize = False
        Caption = ' Calibre'
        Color = cl3DLight
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        Layout = tlCenter
      end
      object lblCalibreIOptativo: TLabel
        Left = 345
        Top = 64
        Width = 79
        Height = 13
        Caption = '(Calibre optativo)'
      end
      object kilos_ce_c2_il: TBDEdit
        Left = 421
        Top = 105
        Width = 75
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 11
        TabOrder = 4
        DataField = 'kilos_ce_c2_il'
        DataSource = DSDetalle
      end
      object kilos_ce_c1_il: TBDEdit
        Left = 421
        Top = 84
        Width = 75
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 11
        TabOrder = 2
        DataField = 'kilos_ce_c1_il'
        DataSource = DSDetalle
      end
      object cajas_ce_c2_il: TBDEdit
        Left = 261
        Top = 105
        Width = 75
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 11
        TabOrder = 3
        OnChange = cajas_ce_c2_ilChange
        DataField = 'cajas_ce_c2_il'
        DataSource = DSDetalle
      end
      object cajas_ce_c1_il: TBDEdit
        Left = 261
        Top = 84
        Width = 75
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 11
        TabOrder = 1
        OnChange = cajas_ce_c1_ilChange
        DataField = 'cajas_ce_c1_il'
        DataSource = DSDetalle
      end
      object calibre_il: TBDEdit
        Left = 261
        Top = 61
        Width = 75
        Height = 21
        ColorEdit = clMoneyGreen
        CharCase = ecNormal
        MaxLength = 6
        TabOrder = 0
        OnChange = cajas_ce_c1_ilChange
        DataField = 'calibre_il'
        DataSource = DSDetalle
      end
      object envase_il: TcxDBTextEdit
        Left = 261
        Top = 38
        DataBinding.DataField = 'envase_il'
        DataBinding.DataSource = DSDetalle
        Properties.CharCase = ecUpperCase
        Properties.MaxLength = 9
        Properties.OnChange = envase_ilChange
        Style.BorderStyle = ebs3D
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfUltraFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfUltraFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 5
        OnExit = envase_ilExit
        Width = 75
      end
      object ssEnvase: TSimpleSearch
        Left = 336
        Top = 38
        Width = 21
        Height = 21
        Hint = 'B'#250'squeda de Art'#237'culo'
        TabOrder = 6
        TabStop = False
        LookAndFeel.NativeStyle = False
        LookAndFeel.SkinName = 'MoneyTwins'
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = FDM.ilxImagenes
        Titulo = 'Busqueda de Art'#237'culos'
        Tabla = 'frf_envases'
        Campos = <
          item
            Etiqueta = 'Art'#237'culo'
            Campo = 'envase_e'
            Ancho = 100
            Tipo = ctCadena
          end
          item
            Etiqueta = 'Descripci'#243'n'
            Campo = 'descripcion_e'
            Ancho = 400
            Tipo = ctCadena
          end>
        Database = 'BDProyecto'
        Join = 'fecha_baja_e is null'
        CampoResultado = 'envase_e'
        Enlace = envase_il
        Tecla = 'F2'
        AntesEjecutar = ssEnvaseAntesEjecutar
        Concatenar = False
      end
    end
    object RejillaDetalle: TDBGrid
      Left = 1
      Top = 144
      Width = 747
      Height = 154
      Align = alClient
      DataSource = DSDetalle
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
          FieldName = 'envase_il'
          Title.Caption = 'Art'#237'culo'
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'des_envase'
          Title.Caption = 'Descripci'#243'n'
          Width = 275
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'calibre_il'
          Title.Caption = 'Calibre'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cajas_ce_c1_il'
          Title.Caption = 'Cajas Cat. 1'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'kilos_ce_c1_il'
          Title.Caption = 'Cat. I'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cajas_ce_c2_il'
          Title.Caption = 'Cajas Cat. 2'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'kilos_ce_c2_il'
          Title.Caption = 'Cat II'
          Width = 58
          Visible = True
        end>
    end
  end
  object DSMaestro: TDataSource
    AutoEdit = False
    DataSet = DMInventario.QInventarioCab
    Left = 8
    Top = 64
  end
  object DSDetalle: TDataSource
    AutoEdit = False
    DataSet = DMInventario.QInventarioLin
    Left = 48
    Top = 64
  end
end
