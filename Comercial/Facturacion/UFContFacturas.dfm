object FContFacturas: TFContFacturas
  Left = 596
  Top = 185
  BorderIcons = []
  BorderStyle = bsToolWindow
  ClientHeight = 505
  ClientWidth = 484
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
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
    TabOrder = 0
    Text = 'CONTABILIZACION DE FACTURAS'
    Height = 41
    Width = 484
  end
  object pnl1: TPanel
    Left = 0
    Top = 41
    Width = 484
    Height = 464
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object Gauge1: TGauge
      Left = 24
      Top = 408
      Width = 437
      Height = 21
      BorderStyle = bsNone
      ForeColor = clNavy
      Progress = 0
    end
    object gbCriterios: TcxGroupBox
      Left = 24
      Top = 16
      Caption = 'Seleccion de Facturas'
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
      Height = 241
      Width = 441
      object lb2: TcxLabel
        Left = 8
        Top = 161
        AutoSize = False
        Caption = 'Factura Desde'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 105
        AnchorX = 113
      end
      object txDesdeFactura: TcxTextEdit
        Left = 115
        Top = 159
        BeepOnEnter = False
        Properties.CharCase = ecUpperCase
        TabOrder = 10
        Width = 110
      end
      object lb3: TcxLabel
        Left = 236
        Top = 161
        AutoSize = False
        Caption = 'Hasta'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 80
        AnchorX = 316
      end
      object txHastaFactura: TcxTextEdit
        Left = 318
        Top = 159
        BeepOnEnter = False
        Properties.CharCase = ecUpperCase
        Style.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.Kind = lfFlat
        TabOrder = 11
        Width = 110
      end
      object lb4: TcxLabel
        Left = 8
        Top = 137
        AutoSize = False
        Caption = 'Fecha Desde'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 105
        AnchorX = 113
      end
      object deDesdeFecha: TcxDateEdit
        Left = 115
        Top = 135
        BeepOnEnter = False
        TabOrder = 7
        Width = 110
      end
      object lbCliente: TcxLabel
        Left = 8
        Top = 89
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
        Width = 105
        AnchorX = 113
      end
      object txCliente: TcxTextEdit
        Left = 114
        Top = 87
        BeepOnEnter = False
        Properties.CharCase = ecUpperCase
        Properties.MaxLength = 3
        Properties.OnChange = txClientePropertiesChange
        TabOrder = 5
        Width = 30
      end
      object txDesCliente: TcxTextEdit
        Left = 170
        Top = 87
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
        TabOrder = 6
        Width = 258
      end
      object lb5: TcxLabel
        Left = 8
        Top = 41
        AutoSize = False
        Caption = 'Empresa Facturaci'#243'n'
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
        Width = 105
        AnchorX = 113
      end
      object txEmpresa: TcxTextEdit
        Left = 114
        Top = 39
        BeepOnEnter = False
        Properties.CharCase = ecUpperCase
        Properties.MaxLength = 3
        Properties.OnChange = PonNombre
        TabOrder = 1
        Width = 30
      end
      object txDesEmpresa: TcxTextEdit
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
        Width = 258
      end
      object lb1: TcxLabel
        Left = 237
        Top = 137
        AutoSize = False
        Caption = 'Fecha Desde'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 80
        AnchorX = 317
      end
      object deHastaFecha: TcxDateEdit
        Left = 318
        Top = 135
        BeepOnEnter = False
        TabOrder = 8
        Width = 110
      end
      object cbRecargo: TcxCheckBox
        Left = 9
        Top = 191
        AutoSize = False
        Caption = 'Contabilizar facturas con Recargo de Equivalencia'
        TabOrder = 12
        Height = 21
        Width = 269
      end
      object cxLabel1: TcxLabel
        Left = 23
        Top = 65
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
        AnchorX = 113
      end
      object txSerie: TcxTextEdit
        Left = 114
        Top = 63
        BeepOnEnter = False
        Properties.CharCase = ecUpperCase
        Properties.MaxLength = 3
        TabOrder = 3
        Width = 30
      end
      object ssSerie: TSimpleSearch
        Left = 143
        Top = 63
        Width = 21
        Height = 21
        TabOrder = 4
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
    object btAceptar: TcxButton
      Left = 297
      Top = 326
      Width = 81
      Height = 39
      Hint = 'Pulse F1 para comenzar la contabilizaci'#243'n de facturas'
      Caption = 'Aceptar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TabStop = False
      OnClick = btAceptarClick
      OptionsImage.ImageIndex = 10
      OptionsImage.Images = DFactura.IFacturas
    end
    object btCancelar: TcxButton
      Left = 381
      Top = 326
      Width = 81
      Height = 39
      Hint = 'Pulse (ESC) para cancelar la contabilizaci'#243'n de facturas'
      Caption = 'Cancelar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = False
      OnClick = btCancelarClick
      OptionsImage.ImageIndex = 4
      OptionsImage.Images = DFactura.IFacturas
    end
    object lb7: TcxLabel
      Left = 23
      Top = 390
      AutoSize = False
      Caption = 'Progreso Contabilizaci'#243'n de Facturas'
      Properties.Alignment.Horz = taLeftJustify
      Height = 17
      Width = 180
    end
    object lbFacturas: TcxLabel
      Left = 362
      Top = 390
      AutoSize = False
      Caption = 'Total Facturas: 0'
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 100
      AnchorX = 462
    end
    object txRuta: TcxTextEdit
      Left = 148
      Top = 287
      ParentShowHint = False
      Properties.ReadOnly = False
      ShowHint = True
      TabOrder = 1
      Text = 'C:\Users\Propietario\Documents\Contabilidad\Datos\'
      Width = 290
    end
    object lb6: TcxLabel
      Left = 41
      Top = 289
      AutoSize = False
      Caption = 'Ubicaci'#243'n del fichero'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = [fsBold]
      Style.TextStyle = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      Height = 18
      Width = 107
      AnchorX = 148
    end
    object btnRuta: TcxButton
      Left = 435
      Top = 286
      Width = 27
      Height = 24
      TabOrder = 2
      OnClick = btnRutaClick
      OptionsImage.ImageIndex = 17
      OptionsImage.Images = DFactura.IFacturas
    end
  end
  object ssEmpresa: TSimpleSearch
    Left = 167
    Top = 102
    Width = 21
    Height = 21
    TabOrder = 2
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
    Top = 150
    Width = 21
    Height = 21
    TabOrder = 3
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
    Left = 446
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
