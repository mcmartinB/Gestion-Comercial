object FFacturacion: TFFacturacion
  Left = 384
  Top = 39
  Width = 675
  Height = 648
  Caption = 'Procesar Facturas Anteriores'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mmxEmpresa: TcxMemo
    Left = 0
    Top = 198
    TabStop = False
    Align = alLeft
    Lines.Strings = (
      '')
    Properties.ReadOnly = True
    Properties.ScrollBars = ssVertical
    Style.LookAndFeel.NativeStyle = False
    Style.LookAndFeel.SkinName = 'Foggy'
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.SkinName = 'Foggy'
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.SkinName = 'Foggy'
    StyleHot.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.SkinName = 'Foggy'
    TabOrder = 0
    Height = 394
    Width = 235
  end
  object gbCabecera: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    Style.LookAndFeel.NativeStyle = False
    Style.LookAndFeel.SkinName = 'Foggy'
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.SkinName = 'Foggy'
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.SkinName = 'Foggy'
    StyleHot.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.SkinName = 'Foggy'
    TabOrder = 2
    Height = 198
    Width = 662
    object btFacturacion: TcxButton
      Left = 497
      Top = 114
      Width = 141
      Height = 25
      Caption = 'Proceso Facturacion'
      TabOrder = 0
      OnClick = btFacturacionClick
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Foggy'
    end
    object btIniciar: TcxButton
      Left = 557
      Top = 35
      Width = 75
      Height = 25
      Caption = 'Iniciar Datos'
      TabOrder = 1
      OnClick = btIniciarClick
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Foggy'
    end
    object cxLabel4: TcxLabel
      Left = 123
      Top = 19
      Caption = 'Grupo'
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
    end
    object txGrupo: TcxTextEdit
      Left = 156
      Top = 16
      Properties.ReadOnly = False
      Properties.OnChange = txGrupoPropertiesChange
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      TabOrder = 3
      OnExit = txGrupoExit
      Width = 50
    end
    object txDesGrupo: TcxTextEdit
      Left = 243
      Top = 16
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
      TabOrder = 4
      Width = 267
    end
    object gb2: TcxGroupBox
      Left = 25
      Top = 44
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      TabOrder = 5
      Height = 96
      Width = 470
      object cxLabel1: TcxLabel
        Left = 18
        Top = 41
        Caption = 'Empresa'
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
      end
      object txEmpresa: TcxTextEdit
        Left = 63
        Top = 39
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Properties.OnChange = txEmpresaPropertiesChange
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
        TabOrder = 1
        Width = 50
      end
      object cxLabel2: TcxLabel
        Left = 39
        Top = 68
        Caption = 'A'#241'o'
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
      end
      object txAno: TcxTextEdit
        Left = 63
        Top = 66
        Properties.ReadOnly = True
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
        TabOrder = 2
        Width = 50
      end
      object cbEmpresa: TcxCheckBox
        Left = 14
        Top = 8
        AutoSize = False
        Caption = 'Procesar solo una empresa / A'#241'o'
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
        TabOrder = 0
        OnClick = cbEmpresaClick
        Height = 24
        Width = 186
      end
      object txDesEmpresa: TcxTextEdit
        Left = 133
        Top = 39
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
        TabOrder = 6
        Width = 254
      end
      object cxLabel3: TcxLabel
        Left = 133
        Top = 68
        Caption = 'Factura'
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
      end
      object txFactura: TcxTextEdit
        Left = 174
        Top = 66
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
        TabOrder = 3
        Width = 70
      end
      object ssEmpresa: TSimpleSearch
        Left = 111
        Top = 39
        Width = 21
        Height = 21
        TabOrder = 8
        TabStop = False
        LookAndFeel.NativeStyle = False
        LookAndFeel.SkinName = 'MoneyTwins'
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = FDM.ilxImagenes
        Titulo = 'Busqueda Empresa'
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
        AntesEjecutar = ssEmpresaAntesEjecutar
      end
      object cxLabel5: TcxLabel
        Left = 261
        Top = 68
        AutoSize = False
        Caption = 'Fecha F.'
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
        Height = 17
        Width = 50
      end
      object txFecha: TcxTextEdit
        Left = 312
        Top = 66
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
        TabOrder = 10
        Width = 76
      end
    end
    object cbxBox: TcxComboBox
      Left = 22
      Top = 17
      Properties.Items.Strings = (
        'Desarrollo'
        'Producci'#243'n')
      Properties.ReadOnly = False
      Properties.OnChange = cbxBoxPropertiesChange
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      TabOrder = 6
      Text = 'Desarrollo'
      Width = 85
    end
    object ssGrupo: TSimpleSearch
      Left = 206
      Top = 16
      Width = 21
      Height = 21
      TabOrder = 7
      TabStop = False
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'MoneyTwins'
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = FDM.ilxImagenes
      Titulo = 'Busqueda de Grupo Empresa'
      Tabla = 'tempresas'
      Campos = <
        item
          Etiqueta = 'Empresa'
          Campo = 'empresa_emp'
          Ancho = 100
          Tipo = ctCadena
        end
        item
          Etiqueta = 'Descripci'#243'n'
          Campo = 'nombre_emp'
          Ancho = 400
          Tipo = ctCadena
        end>
      Database = 'BDProyecto'
      CampoResultado = 'empresa_emp'
      Enlace = txGrupo
      Tecla = 'F2'
      AntesEjecutar = ssGrupoAntesEjecutar
    end
    object gb3: TcxGroupBox
      Left = 25
      Top = 142
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      TabOrder = 8
      Height = 45
      Width = 470
      object lb1: TcxLabel
        Left = 155
        Top = 13
        Caption = 'Fecha Desde'
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
      end
      object txFechaDesde: TcxTextEdit
        Left = 228
        Top = 11
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Properties.OnChange = txEmpresaPropertiesChange
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
        TabOrder = 1
        Width = 73
      end
      object cbFechas: TcxCheckBox
        Left = 14
        Top = 8
        AutoSize = False
        Caption = 'Procesar entre fechas'
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
        TabOrder = 0
        OnClick = cbFechasClick
        Height = 24
        Width = 129
      end
      object lb2: TcxLabel
        Left = 307
        Top = 14
        Caption = 'Fecha Hasta'
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
      end
      object txFechaHasta: TcxTextEdit
        Left = 380
        Top = 12
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Properties.OnChange = txEmpresaPropertiesChange
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'Foggy'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'Foggy'
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = 'Foggy'
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = 'Foggy'
        TabOrder = 4
        Width = 73
      end
    end
  end
  object gb1: TcxGroupBox
    Left = 235
    Top = 198
    Align = alRight
    PanelStyle.Active = True
    ParentBackground = False
    Style.LookAndFeel.NativeStyle = False
    Style.LookAndFeel.SkinName = 'Foggy'
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.SkinName = 'Foggy'
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.SkinName = 'Foggy'
    StyleHot.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.SkinName = 'Foggy'
    TabOrder = 1
    Height = 394
    Width = 427
    object mmxErrores: TcxMemo
      Left = 2
      Top = 180
      TabStop = False
      Align = alBottom
      Lines.Strings = (
        '')
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      TabOrder = 0
      Height = 212
      Width = 423
    end
    object mmxFacturas: TcxMemo
      Left = 2
      Top = 2
      TabStop = False
      Align = alTop
      Lines.Strings = (
        '')
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      TabOrder = 1
      Height = 225
      Width = 423
    end
  end
end
