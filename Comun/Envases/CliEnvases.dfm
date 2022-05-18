object FCliEnvases: TFCliEnvases
  Left = 390
  Top = 241
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = '    UNIDAD DE FACTURACI'#211'N POR CLIENTE'
  ClientHeight = 607
  ClientWidth = 911
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 29
    Width = 911
    Height = 276
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 1
    object nbLabel1: TnbLabel
      Left = 8
      Top = 29
      Width = 100
      Height = 21
      Caption = 'Empresa'
      About = 'NB 0.1/20020725'
    end
    object lblEmpresa: TnbStaticText
      Left = 149
      Top = 29
      Width = 276
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object nbLabel4: TnbLabel
      Left = 8
      Top = 6
      Width = 100
      Height = 21
      Caption = 'Cliente'
      About = 'NB 0.1/20020725'
    end
    object lblCliente: TnbStaticText
      Left = 149
      Top = 6
      Width = 276
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object nbLabel5: TnbLabel
      Left = 6
      Top = 102
      Width = 100
      Height = 21
      Caption = 'Descripci'#243'n Envase'
      About = 'NB 0.1/20020725'
    end
    object nbLabel6: TnbLabel
      Left = 8
      Top = 222
      Width = 100
      Height = 21
      Caption = 'Unidad Facturaci'#243'n'
      About = 'NB 0.1/20020725'
    end
    object nbLabel3: TnbLabel
      Left = 6
      Top = 77
      Width = 100
      Height = 21
      Caption = ' Art'#237'culo'
      About = 'NB 0.1/20020725'
    end
    object lblEnvase: TnbStaticText
      Left = 214
      Top = 77
      Width = 211
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object nbLabel7: TnbLabel
      Left = 329
      Top = 222
      Width = 60
      Height = 21
      Caption = 'N'#186' Palets'
      About = 'NB 0.1/20020725'
    end
    object nbLabel8: TnbLabel
      Left = 537
      Top = 222
      Width = 60
      Height = 21
      Caption = 'KGS Palet'
      About = 'NB 0.1/20020725'
    end
    object nbLabel2: TnbLabel
      Left = 8
      Top = 246
      Width = 100
      Height = 21
      Caption = 'D'#237'as Caducidad'
      About = 'NB 0.1/20020725'
    end
    object nbLabel9: TnbLabel
      Left = 289
      Top = 246
      Width = 100
      Height = 21
      Caption = 'Min. en plataforma'
      About = 'NB 0.1/20020725'
    end
    object nbLabel10: TnbLabel
      Left = 498
      Top = 246
      Width = 100
      Height = 21
      Caption = 'Max. en plataforma'
      About = 'NB 0.1/20020725'
    end
    object lbl1: TLabel
      Left = 427
      Top = 105
      Width = 223
      Height = 13
      Caption = '( Dejar vacio para usar el gen'#233'rico del envase )'
    end
    object nbLabel11: TnbLabel
      Left = 8
      Top = 53
      Width = 100
      Height = 21
      Caption = 'Producto'
      About = 'NB 0.1/20020725'
    end
    object lblProducto: TnbStaticText
      Left = 149
      Top = 53
      Width = 276
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object nbLabel12: TnbLabel
      Left = 8
      Top = 126
      Width = 100
      Height = 21
      Caption = 'Variedad'
      About = 'NB 0.1/20020725'
    end
    object nbLabel13: TnbLabel
      Left = 8
      Top = 150
      Width = 98
      Height = 21
      Caption = 'Ref. Cliente'
      About = 'NB 0.1/20020725'
    end
    object nbLabel15: TnbLabel
      Left = 253
      Top = 150
      Width = 55
      Height = 21
      Caption = 'DUN 14'
      About = 'NB 0.1/20020725'
    end
    object BGBCentro: TBGridButton
      Left = 155
      Top = 173
      Width = 13
      Height = 22
      Action = ARejillaFlotante
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
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      Control = centro_ce
      Grid = RejillaFlotante
      GridAlignment = taUpRight
      GridWidth = 250
      GridHeigth = 100
    end
    object nbLabel16: TnbLabel
      Left = 8
      Top = 174
      Width = 100
      Height = 21
      Caption = 'Centro'
      About = 'NB 0.1/20020725'
    end
    object nbLabel18: TnbLabel
      Left = 8
      Top = 198
      Width = 100
      Height = 21
      Caption = 'Tipo Palet'
      About = 'NB 0.1/20020725'
    end
    object BGBTipoPalet: TBGridButton
      Left = 155
      Top = 197
      Width = 13
      Height = 22
      Action = ARejillaFlotante
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
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      Control = tipo_palet_ce
      Grid = RejillaFlotante
      GridAlignment = taUpRight
      GridWidth = 250
      GridHeigth = 100
    end
    object nbLabel19: TnbLabel
      Left = 525
      Top = 198
      Width = 73
      Height = 21
      Caption = 'Cajas x Palet'
      About = 'NB 0.1/20020725'
    end
    object empresa: TnbDBAlfa
      Left = 112
      Top = 29
      Width = 33
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = empresaChange
      TabOrder = 1
      DataField = 'empresa_ce'
      DataSource = DataSource
      DBLink = True
      NumChars = 3
    end
    object cliente: TnbDBAlfa
      Left = 112
      Top = 6
      Width = 33
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = clienteChange
      TabOrder = 0
      DataField = 'cliente_ce'
      DataSource = DataSource
      DBLink = True
      NumChars = 3
    end
    object unidad_fac_ce: TComboBox
      Left = 112
      Top = 222
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 14
      Text = 'KGS'
      Items.Strings = (
        'KGS'
        'UND'
        'CAJ')
    end
    object descripcion: TnbDBAlfa
      Left = 112
      Top = 102
      Width = 313
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 5
      DataField = 'descripcion_ce'
      DataSource = DataSource
      DBLink = True
      NumChars = 30
    end
    object n_palets_ce: TnbDBAlfa
      Left = 393
      Top = 222
      Width = 33
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 15
      DataField = 'n_palets_ce'
      DataSource = DataSource
      DBLink = True
      OnlyNumbers = True
      NumChars = 3
    end
    object kgs_palet_ce: TnbDBAlfa
      Left = 599
      Top = 222
      Width = 33
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 16
      DataField = 'kgs_palet_ce'
      DataSource = DataSource
      DBLink = True
      OnlyNumbers = True
      NumChars = 4
    end
    object min_vida_cliente_ce: TnbDBAlfa
      Left = 393
      Top = 246
      Width = 33
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 18
      DataField = 'min_vida_cliente_ce'
      DataSource = DataSource
      DBLink = True
      OnlyNumbers = True
      NumChars = 3
    end
    object max_vida_cliente_ce: TnbDBAlfa
      Left = 599
      Top = 246
      Width = 33
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 19
      DataField = 'max_vida_cliente_ce'
      DataSource = DataSource
      DBLink = True
      OnlyNumbers = True
      NumChars = 4
    end
    object caducidad_cliente_ce: TnbDBAlfa
      Left = 112
      Top = 246
      Width = 33
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 17
      DataField = 'caducidad_cliente_ce'
      DataSource = DataSource
      DBLink = True
      OnlyNumbers = True
      NumChars = 3
    end
    object producto_ce: TnbDBAlfa
      Left = 112
      Top = 53
      Width = 33
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = producto_ceChange
      TabOrder = 2
      DataField = 'producto_ce'
      DataSource = DataSource
      DBLink = True
      NumChars = 3
    end
    object envase: TcxDBTextEdit
      Left = 112
      Top = 77
      DataBinding.DataField = 'envase_ce'
      DataBinding.DataSource = DataSource
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 9
      Properties.OnChange = envaseChange
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 3
      OnExit = envaseExit
      Width = 75
    end
    object ssEnvase: TSimpleSearch
      Left = 188
      Top = 77
      Width = 21
      Height = 21
      Hint = 'B'#250'squeda de Art'#237'culo'
      TabOrder = 4
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
      Enlace = envase
      Tecla = 'F2'
      AntesEjecutar = ssEnvaseAntesEjecutar
      Concatenar = False
    end
    object variedad: TnbDBAlfa
      Left = 112
      Top = 126
      Width = 313
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 6
      DataField = 'variedad_ce'
      DataSource = DataSource
      DBLink = True
      NumChars = 30
    end
    object ref_cliente_ce: TnbDBAlfa
      Left = 112
      Top = 150
      Width = 115
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 7
      DataField = 'ref_cliente_ce'
      DataSource = DataSource
      DBLink = True
      NumChars = 30
    end
    object dun14_ce: TnbDBAlfa
      Left = 310
      Top = 150
      Width = 115
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 8
      DataField = 'dun14_ce'
      DataSource = DataSource
      DBLink = True
      NumChars = 30
    end
    object centro_ce: TBDEdit
      Tag = 1
      Left = 112
      Top = 174
      Width = 42
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 1
      TabOrder = 9
      OnChange = ponNombre
      DataField = 'centro_ce'
      DataSource = DataSource
    end
    object lblDesCentro: TStaticText
      Left = 171
      Top = 174
      Width = 254
      Height = 21
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 10
    end
    object RejillaFlotante: TBGrid
      Left = 777
      Top = 6
      Width = 42
      Height = 57
      Color = clInfoBk
      DataSource = DMBaseDatos.DSQDespegables
      FixedColor = clInfoText
      Options = [dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 20
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Visible = False
    end
    object tipo_palet_ce: TBDEdit
      Tag = 1
      Left = 112
      Top = 198
      Width = 42
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 2
      TabOrder = 11
      OnChange = ponNombre
      DataField = 'tipo_palet_ce'
      DataSource = DataSource
    end
    object lblDesTipoPalet: TStaticText
      Left = 171
      Top = 198
      Width = 254
      Height = 21
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 12
    end
    object cajas_palet_ce: TnbDBAlfa
      Left = 599
      Top = 198
      Width = 33
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 13
      DataField = 'cajas_palet_ce'
      DataSource = DataSource
      DBLink = True
      OnlyNumbers = True
      NumChars = 4
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 911
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 50
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 0
    object btnAlta: TToolButton
      Left = 0
      Top = 0
      Caption = 'A'#241'adir'
      OnClick = AAnyadirExecute
    end
    object btnModificar: TToolButton
      Left = 50
      Top = 0
      Caption = 'Modificar'
      OnClick = AModificarExecute
    end
    object btnBorrar: TToolButton
      Left = 100
      Top = 0
      Caption = 'Borrar'
      OnClick = ABorrarExecute
    end
    object ToolButton4: TToolButton
      Left = 150
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object btnAceptar: TToolButton
      Left = 158
      Top = 0
      Caption = 'Aceptar'
      Enabled = False
      OnClick = AAceptarExecute
    end
    object btnCancelar: TToolButton
      Left = 208
      Top = 0
      Caption = 'Cancelar'
      Enabled = False
      OnClick = ACancelarExecute
    end
    object ToolButton8: TToolButton
      Left = 258
      Top = 0
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object btnCerrar: TToolButton
      Left = 266
      Top = 0
      Caption = 'Cerrar'
      OnClick = ACerrarExecute
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 311
    Width = 911
    Height = 296
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnEnter = cxGrid1Enter
    OnExit = cxGrid1Exit
    LockedStateImageOptions.AssignedValues = [lsiavFont]
    LockedStateImageOptions.Font.Charset = DEFAULT_CHARSET
    LockedStateImageOptions.Font.Color = clWindowText
    LockedStateImageOptions.Font.Height = -11
    LockedStateImageOptions.Font.Name = 'MS Sans Serif'
    LockedStateImageOptions.Font.Style = []
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = 'DevExpressStyle'
    object tvDetalle: TcxGridDBTableView
      Navigator.Buttons.ConfirmDelete = True
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      DataController.DataSource = DataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object tvEmpresa: TcxGridDBColumn
        Caption = 'Emp'
        DataBinding.FieldName = 'empresa_ce'
        Options.Focusing = False
        Width = 40
      end
      object tvProducto: TcxGridDBColumn
        Caption = 'Prod.'
        DataBinding.FieldName = 'producto_ce'
        Options.Focusing = False
        Width = 40
      end
      object tvEnvase: TcxGridDBColumn
        Caption = 'Art'#237'culo'
        DataBinding.FieldName = 'envase_ce'
        Options.Focusing = False
        Width = 80
      end
      object tvCliente: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'cliente_ce'
        Options.Focusing = False
        Width = 50
      end
      object tvDescripcion: TcxGridDBColumn
        Caption = 'Descripcion'
        DataBinding.FieldName = 'des_envase'
        Options.Focusing = False
        Width = 156
      end
      object tvVariedad: TcxGridDBColumn
        Caption = 'Variedad'
        DataBinding.FieldName = 'variedad_ce'
        Options.Focusing = False
        Width = 60
      end
      object tvRefCliente: TcxGridDBColumn
        Caption = 'Ref. Cliente'
        DataBinding.FieldName = 'ref_cliente_ce'
        Options.Focusing = False
        Width = 100
      end
      object tvDun14: TcxGridDBColumn
        Caption = 'DUN14'
        DataBinding.FieldName = 'dun14_ce'
        Width = 100
      end
      object tvCentro: TcxGridDBColumn
        Caption = 'Centro'
        DataBinding.FieldName = 'centro_ce'
        Width = 50
      end
      object tvComercial: TcxGridDBColumn
        Caption = 'Comercial'
        DataBinding.FieldName = 'comercial_ce'
        Width = 50
      end
      object tvTipoPalet: TcxGridDBColumn
        Caption = 'Tipo Palet'
        DataBinding.FieldName = 'tipo_palet_ce'
        Width = 60
      end
      object tvCajaPalet: TcxGridDBColumn
        Caption = 'CajasxPalet'
        DataBinding.FieldName = 'cajas_palet_ce'
      end
      object tvUndFacturacion: TcxGridDBColumn
        Caption = 'Und. Fac.'
        DataBinding.FieldName = 'unidad_fac_ce'
        Options.Focusing = False
        Width = 55
      end
      object tvCaducidad: TcxGridDBColumn
        Caption = 'Caduc.'
        DataBinding.FieldName = 'caducidad_cliente_ce'
        Options.Focusing = False
        Width = 45
      end
      object tvMinVida: TcxGridDBColumn
        Caption = 'Min. Vida'
        DataBinding.FieldName = 'min_vida_cliente_ce'
        Options.Focusing = False
      end
      object tvMaxVida: TcxGridDBColumn
        Caption = 'Max.Vida'
        DataBinding.FieldName = 'max_vida_cliente_ce'
        Options.Focusing = False
      end
      object tvPalets: TcxGridDBColumn
        Caption = 'N Palets'
        DataBinding.FieldName = 'n_palets_ce'
        Options.Focusing = False
      end
      object tvKgPalets: TcxGridDBColumn
        Caption = 'Kg. Paltes'
        DataBinding.FieldName = 'kgs_palet_ce'
        Options.Focusing = False
      end
    end
    object lvDetalle: TcxGridLevel
      GridView = tvDetalle
    end
  end
  object Query: TQuery
    BeforePost = QueryBeforePost
    OnCalcFields = QueryCalcFields
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select *'
      'from frf_clientes_env')
    Left = 480
    Top = 25
    object Queryempresa_ce: TStringField
      FieldName = 'empresa_ce'
      Origin = 'COMERCIALIZACION.frf_clientes_env.empresa_ce'
      FixedChar = True
      Size = 3
    end
    object Queryenvase_ce: TStringField
      DisplayWidth = 9
      FieldName = 'envase_ce'
      Origin = 'COMERCIALIZACION.frf_clientes_env.envase_ce'
      FixedChar = True
      Size = 9
    end
    object Querycliente_ce: TStringField
      FieldName = 'cliente_ce'
      Origin = 'COMERCIALIZACION.frf_clientes_env.cliente_ce'
      FixedChar = True
      Size = 3
    end
    object Queryproducto_ce: TStringField
      FieldName = 'producto_ce'
      Origin = 'BDPROYECTO.frf_clientes_env.producto_ce'
      FixedChar = True
      Size = 3
    end
    object Queryunidad_fac_ce: TStringField
      FieldName = 'unidad_fac_ce'
      Origin = 'COMERCIALIZACION.frf_clientes_env.unidad_fac_ce'
      FixedChar = True
      Size = 1
    end
    object Querydescripcion_ce: TStringField
      FieldName = 'descripcion_ce'
      Origin = 'COMERCIALIZACION.frf_clientes_env.descripcion_ce'
      Size = 30
    end
    object Queryref_cliente_ce: TStringField
      FieldName = 'ref_cliente_ce'
      Size = 13
    end
    object Queryvariedad_ce: TStringField
      FieldName = 'variedad_ce'
      Size = 35
    end
    object Queryn_palets_ce: TSmallintField
      FieldName = 'n_palets_ce'
      Origin = '"COMER.DESARROLLO".frf_clientes_env.n_palets_ce'
    end
    object Querykgs_palet_ce: TSmallintField
      FieldName = 'kgs_palet_ce'
      Origin = '"COMER.DESARROLLO".frf_clientes_env.kgs_palet_ce'
    end
    object intgrfldQuerycaducidad_cliente_ce: TIntegerField
      FieldName = 'caducidad_cliente_ce'
      Origin = 'BDPROYECTO.frf_clientes_env.caducidad_cliente_ce'
    end
    object intgrfldQuerymin_vida_cliente_ce: TIntegerField
      FieldName = 'min_vida_cliente_ce'
      Origin = 'BDPROYECTO.frf_clientes_env.min_vida_cliente_ce'
    end
    object intgrfldQuerymax_vida_cliente_ce: TIntegerField
      FieldName = 'max_vida_cliente_ce'
      Origin = 'BDPROYECTO.frf_clientes_env.max_vida_cliente_ce'
    end
    object strngfldQuerydes_envase: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_envase'
      Size = 50
      Calculated = True
    end
    object Querycentro_ce: TStringField
      FieldName = 'centro_ce'
      Size = 1
    end
    object Querydun14_ce: TStringField
      FieldName = 'dun14_ce'
      Size = 14
    end
    object Querycajas_palet_ce: TIntegerField
      FieldName = 'cajas_palet_ce'
    end
    object Querytipo_palet_ce: TStringField
      FieldName = 'tipo_palet_ce'
      Size = 2
    end
  end
  object DataSource: TDataSource
    AutoEdit = False
    DataSet = Query
    OnDataChange = DataSourceDataChange
    Left = 528
    Top = 25
  end
  object ActionList: TActionList
    Left = 664
    Top = 72
    object AAnyadir: TAction
      Caption = 'A'#241'adir'
      OnExecute = AAnyadirExecute
    end
    object ABorrar: TAction
      Caption = 'Borrar'
      OnExecute = ABorrarExecute
    end
    object AModificar: TAction
      Caption = 'Modificar'
      OnExecute = AModificarExecute
    end
    object AAceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
      OnExecute = AAceptarExecute
    end
    object ACancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = ACancelarExecute
    end
    object ACerrar: TAction
      Caption = 'Cerrar'
      OnExecute = ACerrarExecute
    end
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
end
