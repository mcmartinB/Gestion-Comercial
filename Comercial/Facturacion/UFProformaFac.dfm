object FProformaFac: TFProformaFac
  Left = 299
  Top = 68
  BorderIcons = []
  BorderStyle = bsToolWindow
  ClientHeight = 477
  ClientWidth = 518
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 103
    Width = 518
    Height = 354
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object gbCriterios: TcxGroupBox
      Left = 24
      Top = 12
      Caption = 'Criterios de Facturaci'#243'n'
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsOffice11
      Style.Color = clBtnFace
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = []
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      Style.Shadow = False
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = True
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      TabOrder = 0
      Height = 233
      Width = 473
      object lb2: TcxLabel
        Left = 13
        Top = 133
        AutoSize = False
        Caption = 'Desde Albaran'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 100
        AnchorX = 113
      end
      object txDesdeAlbaran: TcxTextEdit
        Left = 115
        Top = 131
        BeepOnEnter = False
        Properties.CharCase = ecUpperCase
        TabOrder = 6
        Width = 110
      end
      object lb3: TcxLabel
        Left = 258
        Top = 133
        AutoSize = False
        Caption = 'Hasta Albaran'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 100
        AnchorX = 358
      end
      object txHastaAlbaran: TcxTextEdit
        Left = 360
        Top = 131
        BeepOnEnter = False
        Properties.CharCase = ecUpperCase
        Style.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.Kind = lfFlat
        TabOrder = 8
        Width = 100
      end
      object lb4: TcxLabel
        Left = 13
        Top = 157
        AutoSize = False
        Caption = 'Facturar Hasta'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 100
        AnchorX = 113
      end
      object deFechaFacturar: TcxDateEdit
        Left = 115
        Top = 155
        BeepOnEnter = False
        TabOrder = 11
        Width = 110
      end
      object lbCliente: TcxLabel
        Left = 13
        Top = 41
        AutoSize = False
        Caption = 'Cliente Facturaci'#243'n'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = [fsBold]
        Style.TextStyle = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 100
        AnchorX = 113
      end
      object txCliente: TcxTextEdit
        Left = 114
        Top = 39
        BeepOnEnter = False
        Properties.CharCase = ecUpperCase
        Properties.MaxLength = 3
        Properties.OnChange = txClientePropertiesChange
        TabOrder = 1
        Width = 30
      end
      object txDesCliente: TcxTextEdit
        Left = 170
        Top = 39
        TabStop = False
        Properties.ReadOnly = True
        Style.Color = clBtnFace
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = ''
        Style.Shadow = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = ''
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = ''
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = ''
        TabOrder = 2
        Width = 289
      end
      object lb1: TcxLabel
        Left = 13
        Top = 65
        AutoSize = False
        Caption = 'Fecha Facturacion'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = [fsBold]
        Style.TextStyle = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 100
        AnchorX = 113
      end
      object deFechaFactura: TcxDateEdit
        Left = 114
        Top = 63
        BeepOnEnter = False
        TabOrder = 3
        Width = 110
      end
      object cxlb9: TcxLabel
        Left = 24
        Top = 197
        AutoSize = False
        Caption = 'N'#250'mero Pedido'
        Style.TextStyle = []
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 90
        AnchorX = 114
      end
      object txPedido: TcxTextEdit
        Left = 115
        Top = 195
        ParentFont = False
        Properties.CharCase = ecUpperCase
        Properties.OnChange = PonNombre
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 13
        Width = 110
      end
      object rgTipo: TcxRadioGroup
        Left = 15
        Top = 96
        Properties.Columns = 2
        Properties.Items = <
          item
            Caption = 'Por Factura'
            Value = 'F'
          end
          item
            Caption = 'Por Pedido'
            Value = 'P'
          end>
        Properties.OnChange = rgTipoFactura1PropertiesChange
        ItemIndex = 0
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
        TabOrder = 4
        Height = 25
        Width = 209
      end
    end
    object btAceptar: TcxButton
      Left = 331
      Top = 299
      Width = 81
      Height = 39
      Hint = 'Pulse F1 para comenzar el proceso de Facturaci'#243'n.'
      Caption = 'Aceptar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      OnClick = btAceptarClick
      OnKeyDown = FormKeyDown
      OptionsImage.ImageIndex = 10
      OptionsImage.Images = DFactura.IFacturas
    end
    object btCancelar: TcxButton
      Left = 415
      Top = 299
      Width = 81
      Height = 39
      Hint = 'Pulse Esc para cancelar el proceso de Facturaci'#243'n.'
      Caption = 'Cerrar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      OnClick = btCancelarClick
      OptionsImage.ImageIndex = 4
      OptionsImage.Images = DFactura.IFacturas
    end
  end
  object st1: TdxStatusBar
    Left = 0
    Top = 457
    Width = 518
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
  end
  object tx1: TcxTextEdit
    Left = 0
    Top = 0
    TabStop = False
    Align = alTop
    AutoSize = False
    Enabled = False
    Properties.Alignment.Horz = taCenter
    Properties.ReadOnly = True
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    Style.LookAndFeel.SkinName = 'Blueprint'
    Style.TextStyle = [fsBold]
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.SkinName = 'Blueprint'
    StyleDisabled.TextColor = clWindow
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.SkinName = 'Blueprint'
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.SkinName = 'Blueprint'
    TabOrder = 2
    Text = 'FACTURA INFORMATIVA / PROFORMA'
    Height = 41
    Width = 518
  end
  object gbPrincipal: TcxGroupBox
    Left = 0
    Top = 41
    Align = alTop
    Style.LookAndFeel.NativeStyle = False
    Style.LookAndFeel.SkinName = 'Foggy'
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.SkinName = 'Foggy'
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.SkinName = 'Foggy'
    StyleHot.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.SkinName = 'Foggy'
    TabOrder = 3
    Height = 62
    Width = 518
    object cxEmpresa: TcxLabel
      Left = 15
      Top = 12
      AutoSize = False
      Caption = 'Empresa'
      ParentColor = False
      ParentFont = False
      Style.Color = clBtnFace
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = [fsBold]
      Style.TextStyle = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 90
      AnchorX = 105
    end
    object txEmpresa: TcxTextEdit
      Left = 107
      Top = 10
      BeepOnEnter = False
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      Properties.OnChange = PonNombre
      TabOrder = 1
      Width = 30
    end
    object txDesEmpresa: TcxTextEdit
      Left = 162
      Top = 10
      TabStop = False
      Properties.ReadOnly = True
      Style.BorderStyle = ebsFlat
      Style.Color = clBtnFace
      Style.LookAndFeel.Kind = lfFlat
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = ''
      Style.Shadow = False
      Style.TransparentBorder = True
      StyleDisabled.LookAndFeel.Kind = lfFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = ''
      StyleFocused.LookAndFeel.Kind = lfFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = ''
      StyleHot.LookAndFeel.Kind = lfFlat
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = ''
      TabOrder = 2
      Width = 322
    end
    object cxLabel1: TcxLabel
      Left = 15
      Top = 38
      AutoSize = False
      Caption = 'Serie Factura'
      ParentColor = False
      ParentFont = False
      Style.Color = clBtnFace
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = [fsBold]
      Style.TextStyle = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 90
      AnchorX = 105
    end
    object txSerie: TcxTextEdit
      Left = 107
      Top = 36
      BeepOnEnter = False
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      TabOrder = 4
      Width = 30
    end
    object ssSerie: TSimpleSearch
      Left = 136
      Top = 36
      Width = 21
      Height = 21
      TabOrder = 5
      TabStop = False
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'MoneyTwins'
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = FDM.ilxImagenes
      Titulo = 'Busqueda de Serie'
      Tabla = 'frf_empresas_serie'
      Campos = <
        item
          Etiqueta = 'Serie'
          Campo = 'cod_serie_es'
          Ancho = 100
          Tipo = ctCadena
        end
        item
          Etiqueta = 'A'#241'o'
          Campo = 'anyo_es'
          Ancho = 50
          Tipo = ctNumero
        end>
      Database = 'BDProyecto'
      CampoResultado = 'cod_serie_es'
      Enlace = txSerie
      Tecla = 'F2'
      AntesEjecutar = ssSerieAntesEjecutar
      Concatenar = False
    end
  end
  object ssEmpresa: TSimpleSearch
    Left = 136
    Top = 51
    Width = 21
    Height = 21
    TabOrder = 4
    TabStop = False
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'MoneyTwins'
    OptionsImage.ImageIndex = 2
    OptionsImage.Images = FDM.ilxImagenes
    Titulo = 'Busqueda de Empresa'
    Tabla = 'frf_empresas'
    Campos = <
      item
        Etiqueta = 'Empresa'
        Campo = 'empresa_e'
        Ancho = 100
        Tipo = ctCadena
      end
      item
        Etiqueta = 'Descripci'#243'n'
        Campo = 'nombre_e'
        Ancho = 400
        Tipo = ctCadena
      end>
    Database = 'BDProyecto'
    CampoResultado = 'empresa_e'
    Enlace = txEmpresa
    Tecla = 'F2'
    Concatenar = False
  end
  object ssCliente: TSimpleSearch
    Left = 167
    Top = 160
    Width = 21
    Height = 21
    TabOrder = 5
    TabStop = False
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'MoneyTwins'
    OptionsImage.ImageIndex = 2
    OptionsImage.Images = FDM.ilxImagenes
    Titulo = 'Busqueda de Clientes'
    Tabla = 'frf_clientes'
    Campos = <
      item
        Etiqueta = 'Cliente'
        Campo = 'cliente_c'
        Ancho = 100
        Tipo = ctCadena
      end
      item
        Etiqueta = 'Descripci'#243'n'
        Campo = 'nombre_c'
        Ancho = 400
        Tipo = ctCadena
      end>
    Database = 'BDProyecto'
    CampoResultado = 'empresa_c'
    Enlace = txCliente
    Tecla = 'F2'
    Concatenar = False
  end
  object ActionList: TActionList
    Left = 479
    Top = 7
    object ACancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = ACancelarExecute
    end
    object AAceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
      OnExecute = AAceptarExecute
    end
  end
end
