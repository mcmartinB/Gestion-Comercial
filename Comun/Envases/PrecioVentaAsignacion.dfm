object FPrecioVentaAsignacion: TFPrecioVentaAsignacion
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Introducion Precio Venta'
  ClientHeight = 279
  ClientWidth = 548
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    Style.BorderStyle = ebsOffice11
    Style.LookAndFeel.NativeStyle = False
    Style.LookAndFeel.SkinName = 'Foggy'
    Style.TextStyle = [fsBold]
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.SkinName = 'Foggy'
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.SkinName = 'Foggy'
    StyleHot.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.SkinName = 'Foggy'
    TabOrder = 0
    Height = 279
    Width = 548
    object stCliente: TnbStaticText
      Left = 189
      Top = 93
      Width = 316
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object stenvase: TnbStaticText
      Left = 234
      Top = 118
      Width = 271
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object stMoneda: TnbStaticText
      Left = 201
      Top = 169
      Width = 155
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object ssEnvase: TSimpleSearch
      Left = 209
      Top = 117
      Width = 21
      Height = 21
      Hint = 'B'#250'squeda de Art'#237'culo'
      TabOrder = 5
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
      Enlace = eEnvase
      Tecla = 'F2'
      AntesEjecutar = ssEnvaseAntesEjecutar
      Concatenar = False
    end
    object btAceptar: TcxButton
      Left = 341
      Top = 210
      Width = 81
      Height = 39
      Hint = 'Pulse F1 para comenzar el proceso de Facturaci'#243'n.'
      Caption = 'Aceptar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
      TabStop = False
      OnClick = btAceptarClick
      OptionsImage.ImageIndex = 10
      OptionsImage.Images = DFactura.IFacturas
    end
    object btCancelar: TcxButton
      Left = 424
      Top = 210
      Width = 81
      Height = 39
      Hint = 'Pulse Esc para cancelar el proceso de Facturaci'#243'n.'
      Caption = 'Cerrar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      TabStop = False
      OnClick = btCancelarClick
      OptionsImage.ImageIndex = 4
      OptionsImage.Images = DFactura.IFacturas
    end
    object ssCliente: TSimpleSearch
      Left = 164
      Top = 93
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
      CampoResultado = 'eCliente'
      Enlace = eCliente
      Tecla = 'F2'
      Concatenar = False
    end
    object ssMoneda: TSimpleSearch
      Left = 177
      Top = 168
      Width = 21
      Height = 21
      TabOrder = 9
      TabStop = False
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'MoneyTwins'
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = FDM.ilxImagenes
      Titulo = 'Busqueda de Monedas'
      Tabla = 'frf_monedas'
      Campos = <
        item
          Etiqueta = 'Moneda'
          Campo = 'moneda_m'
          Ancho = 100
          Tipo = ctCadena
        end
        item
          Etiqueta = 'Descripci'#243'n'
          Campo = 'descripcion_m'
          Ancho = 400
          Tipo = ctCadena
        end>
      Database = 'BDProyecto'
      CampoResultado = 'moneda_m'
      Enlace = eMoneda
      Tecla = 'F2'
      Concatenar = False
    end
    object eCliente: TcxTextEdit
      Left = 134
      Top = 93
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      Properties.OnChange = eClientePropertiesChange
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 2
      Width = 30
    end
    object eEnvase: TcxTextEdit
      Left = 134
      Top = 117
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 9
      Properties.OnChange = eEnvasePropertiesChange
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 4
      OnExit = eEnvaseExit
      Width = 75
    end
    object eMoneda: TcxTextEdit
      Left = 134
      Top = 169
      AutoSize = False
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      Properties.OnChange = eMonedaPropertiesChange
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 8
      Height = 21
      Width = 43
    end
    object eFechaInicio: TcxDateEdit
      Left = 134
      Top = 47
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 0
      Width = 90
    end
    object ePrecio: TcxCurrencyEdit
      Left = 134
      Top = 143
      Properties.AssignedValues.MinValue = True
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = ',0.0000'
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 6
      Width = 64
    end
    object eFechaFin: TcxDateEdit
      Left = 415
      Top = 47
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 1
      Width = 90
    end
    object lbFechaIni: TcxLabel
      Left = 37
      Top = 49
      AutoSize = False
      Caption = 'Fecha Inicio '
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clBtnFace
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 80
      AnchorX = 117
    end
    object lbFechaFin: TcxLabel
      Left = 316
      Top = 49
      AutoSize = False
      Caption = 'Fecha Fin '
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clBtnFace
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 80
      AnchorX = 396
    end
    object lbCliente: TcxLabel
      Left = 37
      Top = 94
      AutoSize = False
      Caption = 'Cliente '
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clBtnFace
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 80
      AnchorX = 117
    end
    object lbEnvase: TcxLabel
      Left = 37
      Top = 118
      AutoSize = False
      Caption = 'Art'#237'culo '
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clBtnFace
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 80
      AnchorX = 117
    end
    object lbPrecio: TcxLabel
      Left = 37
      Top = 144
      AutoSize = False
      Caption = 'Precio Venta '
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clBtnFace
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 80
      AnchorX = 117
    end
    object lbMoneda: TcxLabel
      Left = 38
      Top = 170
      AutoSize = False
      Caption = 'Moneda '
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clBtnFace
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 80
      AnchorX = 118
    end
    object eUnidadPrecio: TcxComboBox
      Left = 357
      Top = 143
      Properties.Items.Strings = (
        'CAJ'
        'KGS'
        'UND')
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 7
      Text = 'UND'
      Width = 57
    end
    object lbUnidadFacturacion: TcxLabel
      Left = 234
      Top = 144
      AutoSize = False
      Caption = 'Unidad Facturacion '
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clBtnFace
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 110
      AnchorX = 344
    end
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
