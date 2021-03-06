object FAltaFacturas: TFAltaFacturas
  Left = 339
  Top = 186
  BorderIcons = []
  BorderStyle = bsSizeToolWin
  Caption = 'Alta Factura / Abono'
  ClientHeight = 601
  ClientWidth = 1004
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbCabecera: TcxGroupBox
    Left = 0
    Top = 22
    Align = alTop
    Caption = 'CABECERA FACTURA'
    Style.BorderStyle = ebs3D
    Style.LookAndFeel.NativeStyle = False
    Style.LookAndFeel.SkinName = 'Foggy'
    Style.TextStyle = [fsBold]
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.SkinName = 'Foggy'
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.SkinName = 'Foggy'
    StyleHot.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.SkinName = 'Foggy'
    TabOrder = 1
    Height = 155
    Width = 1004
    object lbEmpresa: TcxLabel
      Left = 5
      Top = 63
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
      Width = 60
      AnchorX = 65
    end
    object txDesEmpresa: TcxTextEdit
      Left = 123
      Top = 61
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
      Width = 214
    end
    object lbFechaFactura: TcxLabel
      Left = 479
      Top = 63
      AutoSize = False
      Caption = 'Fecha Factura'
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
      Width = 90
      AnchorX = 569
    end
    object lbNumeroFactura: TcxLabel
      Left = 710
      Top = 63
      AutoSize = False
      Caption = 'Numero Factura'
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
      AnchorX = 800
    end
    object lbCliente: TcxLabel
      Left = 5
      Top = 85
      AutoSize = False
      Caption = 'Cliente'
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
      Width = 60
      AnchorX = 65
    end
    object txDesCliente: TcxTextEdit
      Left = 123
      Top = 83
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
      TabOrder = 15
      Width = 338
    end
    object lb3: TcxLabel
      Left = 479
      Top = 85
      AutoSize = False
      Caption = 'Impuesto'
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 90
      AnchorX = 569
    end
    object txDesImpuesto: TcxTextEdit
      Left = 628
      Top = 83
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
      TabOrder = 18
      Width = 248
    end
    object lb4: TcxLabel
      Left = 5
      Top = 108
      AutoSize = False
      Caption = 'Moneda'
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 60
      AnchorX = 65
    end
    object txDesMoneda: TcxTextEdit
      Left = 123
      Top = 105
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
      TabOrder = 23
      Width = 338
    end
    object lb10: TcxLabel
      Left = 479
      Top = 107
      AutoSize = False
      Caption = 'Prevision Cobro'
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
      Width = 90
      AnchorX = 569
    end
    object edtEmpresa: TcxDBTextEdit
      Left = 66
      Top = 61
      DataBinding.DataField = 'cod_empresa_fac_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      Properties.OnChange = edtEmpresaPropertiesChange
      TabOrder = 2
      Width = 30
    end
    object edtCliente: TcxDBTextEdit
      Left = 66
      Top = 83
      DataBinding.DataField = 'cod_cliente_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      Properties.OnChange = edtClientePropertiesChange
      TabOrder = 13
      Width = 30
    end
    object edtMoneda: TcxDBTextEdit
      Left = 66
      Top = 105
      DataBinding.DataField = 'moneda_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      Properties.OnChange = edtMonedaPropertiesChange
      TabOrder = 21
      Width = 30
    end
    object edtImpuesto: TcxDBTextEdit
      Left = 571
      Top = 83
      DataBinding.DataField = 'tipo_impuesto_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      Properties.OnChange = edtImpuestoPropertiesChange
      TabOrder = 16
      Width = 30
    end
    object deFechaFactura: TcxDBDateEdit
      Left = 571
      Top = 61
      DataBinding.DataField = 'fecha_factura_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.OnChange = deFechaFacturaPropertiesChange
      TabOrder = 7
      Width = 110
    end
    object dePrevisionCobro: TcxDBDateEdit
      Left = 571
      Top = 105
      DataBinding.DataField = 'prevision_cobro_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.DateButtons = [btnClear]
      TabOrder = 24
      Width = 110
    end
    object edtNumeroFactura: TcxDBTextEdit
      Left = 801
      Top = 61
      DataBinding.DataField = 'n_factura_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      Properties.ReadOnly = True
      Style.Color = clBtnFace
      TabOrder = 8
      Width = 74
    end
    object rgTipoFactura: TcxDBRadioGroup
      Left = 7
      Top = 16
      DataBinding.DataField = 'tipo_factura_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.Columns = 2
      Properties.DefaultValue = '380'
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Factura'
          Value = '380'
        end
        item
          Caption = 'Abono'
          Value = '381'
        end>
      Properties.OnChange = rgTipoFacPropertiesChange
      TabOrder = 0
      Height = 41
      Width = 159
    end
    object gbPerdidas: TcxGroupBox
      Left = 183
      Top = 16
      TabOrder = 1
      Height = 41
      Width = 426
      object cbFacturasPerdidas: TcxCheckBox
        Left = 11
        Top = 11
        Caption = 'Contador de Facturas Perdidas'
        TabOrder = 0
        OnClick = cbFacturasPerdidasClick
        Width = 170
      end
      object lb15: TcxLabel
        Left = 246
        Top = 14
        AutoSize = False
        Caption = 'N'#186' Factura'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 60
        AnchorX = 306
      end
      object txFactura: TcxTextEdit
        Left = 308
        Top = 12
        BeepOnEnter = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = False
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.BorderColor = clWindowFrame
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = True
        TabOrder = 1
        Width = 100
      end
    end
    object ssEmpresa: TSimpleSearch
      Left = 97
      Top = 61
      Width = 21
      Height = 21
      TabOrder = 3
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
      Enlace = edtEmpresa
      Tecla = 'F2'
      Concatenar = False
    end
    object ssCliente: TSimpleSearch
      Left = 97
      Top = 83
      Width = 21
      Height = 21
      TabOrder = 14
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
        end
        item
          Etiqueta = 'NIF'
          Campo = 'nif_c'
          Ancho = 200
          Tipo = ctCadena
        end>
      Database = 'BDProyecto'
      CampoResultado = 'cliente_c'
      Enlace = edtCliente
      Tecla = 'F2'
      Concatenar = False
    end
    object ssMoneda: TSimpleSearch
      Left = 97
      Top = 105
      Width = 21
      Height = 21
      TabOrder = 22
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
      Enlace = edtMoneda
      Tecla = 'F2'
      Concatenar = False
    end
    object ssImpuesto: TSimpleSearch
      Left = 602
      Top = 83
      Width = 21
      Height = 21
      TabOrder = 17
      TabStop = False
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'MoneyTwins'
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = FDM.ilxImagenes
      Titulo = 'Busqueda de Impuestos'
      Tabla = 'frf_impuestos'
      Campos = <
        item
          Etiqueta = 'Impuesto'
          Campo = 'codigo_i'
          Ancho = 100
          Tipo = ctCadena
        end
        item
          Etiqueta = 'Descripci'#243'n'
          Campo = 'descripcion_i'
          Ancho = 400
          Tipo = ctCadena
        end>
      Database = 'BDProyecto'
      CampoResultado = 'codigo_i'
      Enlace = edtImpuesto
      Tecla = 'F2'
      Concatenar = False
    end
    object cxlbl1: TcxLabel
      Left = 687
      Top = 107
      AutoSize = False
      Caption = 'Tesoreria'
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
      Width = 76
      AnchorX = 763
    end
    object dePrevisionTeso: TcxDBDateEdit
      Left = 766
      Top = 105
      DataBinding.DataField = 'prevision_tesoreria_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.DateButtons = [btnClear]
      TabOrder = 25
      Width = 110
    end
    object cxlbl2: TcxLabel
      Left = 479
      Top = 129
      AutoSize = False
      Caption = 'Fecha Fac. Asoc.'
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
      Width = 90
      AnchorX = 569
    end
    object deFechaFacIni: TcxDBDateEdit
      Left = 571
      Top = 127
      DataBinding.DataField = 'fecha_fac_ini_fc'
      DataBinding.DataSource = dsCabFactura
      TabOrder = 29
      Width = 110
    end
    object cxlbl3: TcxLabel
      Left = 687
      Top = 129
      AutoSize = False
      Caption = 'Num. Fac. Asociada'
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
      Width = 98
      AnchorX = 785
    end
    object edtNumFacIni: TcxDBTextEdit
      Left = 784
      Top = 127
      DataBinding.DataField = 'cod_factura_anula_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      Properties.ReadOnly = True
      Style.Color = clBtnFace
      TabOrder = 30
      Width = 92
    end
    object cxLabel1: TcxLabel
      Left = 338
      Top = 62
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
      Width = 71
      AnchorX = 409
    end
    object edtSerie: TcxDBTextEdit
      Left = 409
      Top = 61
      DataBinding.DataField = 'cod_serie_fac_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      TabOrder = 5
      Width = 30
    end
    object ssSerie: TSimpleSearch
      Left = 440
      Top = 61
      Width = 21
      Height = 21
      TabOrder = 6
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
      Enlace = edtSerie
      Tecla = 'F2'
      AntesEjecutar = ssSerieAntesEjecutar
      Concatenar = False
    end
    object cbNumRegistroAcuerdo: TcxDBCheckBox
      Left = 63
      Top = 128
      Caption = 'N'#250'm. de registro acuerdo comercial'
      DataBinding.DataField = 'es_reg_acuerdo_fc'
      DataBinding.DataSource = dsCabFactura
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 31
      Width = 256
    end
  end
  object stStatusBar: TdxStatusBar
    Left = 0
    Top = 581
    Width = 1004
    Height = 20
    Panels = <>
    PaintStyle = stpsUseLookAndFeel
    SimplePanelStyle.Active = True
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Foggy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
  end
  object gbDetalle: TcxGroupBox
    Left = 0
    Top = 177
    Align = alClient
    PanelStyle.Active = True
    Style.LookAndFeel.NativeStyle = False
    Style.LookAndFeel.SkinName = 'Foggy'
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.SkinName = 'Foggy'
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.SkinName = 'Foggy'
    StyleHot.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.SkinName = 'Foggy'
    TabOrder = 3
    Height = 404
    Width = 1004
    object cxPageControl: TcxPageControl
      Left = 2
      Top = 2
      Width = 1000
      Height = 400
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = tsDetalleFactura
      Properties.CustomButtons.Buttons = <>
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Foggy'
      OnEnter = cxPageControlEnter
      ClientRectBottom = 395
      ClientRectLeft = 5
      ClientRectRight = 995
      ClientRectTop = 27
      object tsDetalleFactura: TcxTabSheet
        Caption = 'Lineas Factura'
        ImageIndex = 0
        object cxDetalle: TcxGrid
          Left = 0
          Top = 137
          Width = 990
          Height = 231
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvRaised
          BorderStyle = cxcbsNone
          TabOrder = 2
          LookAndFeel.Kind = lfStandard
          LookAndFeel.NativeStyle = False
          LookAndFeel.SkinName = 'Foggy'
          object tvLineasFactura: TcxGridDBTableView
            OnDblClick = tvLineasFacturaDblClick
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsDetFactura
            DataController.DetailKeyFieldNames = 'cod_factura_fd'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object tvEmpresaAlb: TcxGridDBColumn
              Caption = 'Emp'
              DataBinding.FieldName = 'cod_empresa_albaran_fd'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              MinWidth = 10
              Width = 10
            end
            object tvCenSalida: TcxGridDBColumn
              Caption = 'Centro'
              DataBinding.FieldName = 'cod_centro_albaran_fd'
              MinWidth = 10
              Width = 10
            end
            object tvAlbaran: TcxGridDBColumn
              Caption = 'Albaran'
              DataBinding.FieldName = 'n_albaran_fd'
              MinWidth = 15
              Width = 15
            end
            object tvFecAlbaran: TcxGridDBColumn
              Caption = 'Fecha Albaran'
              DataBinding.FieldName = 'fecha_albaran_fd'
              Width = 20
            end
            object tvProducto: TcxGridDBColumn
              Caption = 'Prod'
              DataBinding.FieldName = 'cod_producto_fd'
              MinWidth = 10
              Width = 10
            end
            object tvEnvase: TcxGridDBColumn
              Caption = 'Art'#237'culo'
              DataBinding.FieldName = 'cod_envase_fd'
              MinWidth = 12
              Width = 30
            end
            object tvCategoria: TcxGridDBColumn
              Caption = 'Categoria'
              DataBinding.FieldName = 'categoria_fd'
              MinWidth = 12
              Width = 12
            end
            object tvUnidades: TcxGridDBColumn
              Caption = 'Unds'
              DataBinding.FieldName = 'unidades_fd'
              MinWidth = 10
              Width = 10
            end
            object tvCajas: TcxGridDBColumn
              Caption = 'Cajas'
              DataBinding.FieldName = 'cajas_fd'
              MinWidth = 10
              Width = 10
            end
            object tvKilos: TcxGridDBColumn
              Caption = 'Kilos'
              DataBinding.FieldName = 'kilos_fd'
              MinWidth = 10
              Width = 15
            end
            object tvPrecio: TcxGridDBColumn
              Caption = 'Precio'
              DataBinding.FieldName = 'precio_fd'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DecimalPlaces = 4
              Properties.DisplayFormat = ',0.0000;-,0.0000'
              MinWidth = 15
              Width = 15
            end
            object tvUnidad: TcxGridDBColumn
              Caption = 'Und.'
              DataBinding.FieldName = 'unidad_facturacion_fd'
              MinWidth = 10
              Width = 10
            end
            object tvImporte: TcxGridDBColumn
              Caption = 'Importe'
              DataBinding.FieldName = 'importe_linea_fd'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = ',0.00;-,0.00'
              Width = 20
            end
            object tvImporteDes: TcxGridDBColumn
              Caption = 'Imp. Descuento'
              DataBinding.FieldName = 'importe_total_descuento_fd'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = ',0.00;-,0.00'
              Width = 22
            end
            object tvImporteNeto: TcxGridDBColumn
              Caption = 'Importe Neto'
              DataBinding.FieldName = 'importe_neto_fd'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = ',0.00;-,0.00'
              Width = 20
            end
            object tvImpuesto: TcxGridDBColumn
              Caption = '% IVA'
              DataBinding.FieldName = 'porcentaje_impuesto_fd'
              MinWidth = 10
              Width = 10
            end
            object tvImporteImpuesto: TcxGridDBColumn
              Caption = 'Imp. IVA'
              DataBinding.FieldName = 'importe_impuesto_fd'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = ',0.00;-,0.00'
              Width = 20
            end
            object tvImporteTotal: TcxGridDBColumn
              Caption = 'Importe Total'
              DataBinding.FieldName = 'importe_total_fd'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = ',0.00;-,0.00'
              Width = 20
            end
          end
          object lvLineasFactura: TcxGridLevel
            GridView = tvLineasFactura
          end
        end
        object pnlAltaLineas: TPanel
          Left = 0
          Top = 24
          Width = 990
          Height = 113
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          OnEnter = pnlAltaLineasEnter
          OnExit = pnlAltaLineasExit
          object lb1: TcxLabel
            Left = 291
            Top = 7
            AutoSize = False
            Caption = 'Centro Sal.'
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
            Width = 69
            AnchorX = 360
          end
          object edtCenSalida: TcxDBTextEdit
            Left = 361
            Top = 5
            DataBinding.DataField = 'cod_centro_albaran_fd'
            DataBinding.DataSource = dsDetFactura
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 3
            Properties.OnChange = edtCenSalidaPropertiesChange
            TabOrder = 3
            Width = 30
          end
          object txDesCentro: TcxTextEdit
            Left = 418
            Top = 5
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
            TabOrder = 5
            Width = 150
          end
          object lb2: TcxLabel
            Left = 591
            Top = 7
            AutoSize = False
            Caption = 'Num. Albaran'
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
            Width = 80
            AnchorX = 671
          end
          object edtNumAlbaran: TcxDBTextEdit
            Left = 673
            Top = 5
            DataBinding.DataField = 'n_albaran_fd'
            DataBinding.DataSource = dsDetFactura
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 0
            TabOrder = 6
            Width = 70
          end
          object lb5: TcxLabel
            Left = 760
            Top = 7
            AutoSize = False
            Caption = 'Fecha Albaran'
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
            Width = 90
            AnchorX = 850
          end
          object deFechaAlbaran: TcxDBDateEdit
            Left = 850
            Top = 5
            DataBinding.DataField = 'fecha_albaran_fd'
            DataBinding.DataSource = dsDetFactura
            TabOrder = 7
            Width = 110
          end
          object lb6: TcxLabel
            Left = 3
            Top = 31
            AutoSize = False
            Caption = 'Producto'
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
            Width = 69
            AnchorX = 72
          end
          object edtProducto: TcxDBTextEdit
            Left = 73
            Top = 30
            DataBinding.DataField = 'cod_producto_fd'
            DataBinding.DataSource = dsDetFactura
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 3
            Properties.OnChange = edtProductoPropertiesChange
            TabOrder = 18
            Width = 30
          end
          object txDesProducto: TcxTextEdit
            Left = 130
            Top = 29
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
            TabOrder = 13
            Width = 150
          end
          object lb7: TcxLabel
            Left = 288
            Top = 31
            AutoSize = False
            Caption = 'Art'#237'culo'
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
            Width = 69
            AnchorX = 357
          end
          object edtEnvase: TcxDBTextEdit
            Left = 363
            Top = 30
            DataBinding.DataField = 'cod_envase_fd'
            DataBinding.DataSource = dsDetFactura
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 9
            Properties.OnChange = edtEnvasePropertiesChange
            TabOrder = 19
            OnExit = edtEnvaseExit
            Width = 75
          end
          object txDesEnvase: TcxTextEdit
            Left = 464
            Top = 29
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
            TabOrder = 15
            Width = 150
          end
          object lb8: TcxLabel
            Left = 685
            Top = 32
            AutoSize = False
            Caption = 'Categoria'
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
            Width = 69
            AnchorX = 754
          end
          object edtCategoria: TcxDBTextEdit
            Left = 752
            Top = 29
            DataBinding.DataField = 'categoria_fd'
            DataBinding.DataSource = dsDetFactura
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 2
            Properties.OnChange = edtCategoriaPropertiesChange
            TabOrder = 20
            Width = 30
          end
          object txDesCategoria: TcxTextEdit
            Left = 810
            Top = 29
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
            TabOrder = 17
            Width = 150
          end
          object lb9: TcxLabel
            Left = 3
            Top = 7
            AutoSize = False
            Caption = 'Emp. Albaran'
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
            Width = 69
            AnchorX = 72
          end
          object edtEmpAlbaran: TcxDBTextEdit
            Left = 73
            Top = 5
            DataBinding.DataField = 'cod_empresa_albaran_fd'
            DataBinding.DataSource = dsDetFactura
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 3
            Properties.OnChange = edtEmpAlbaranPropertiesChange
            TabOrder = 0
            Width = 30
          end
          object txDesEmpAlbaran: TcxTextEdit
            Left = 130
            Top = 5
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
            Width = 150
          end
          object cxGroupBox1: TcxGroupBox
            Left = 3
            Top = 51
            TabOrder = 24
            Height = 56
            Width = 982
            object lb11: TcxLabel
              Left = 39
              Top = 32
              AutoSize = False
              Caption = 'Unidad Fact.'
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
              Width = 69
              AnchorX = 108
            end
            object cbxTipoUnidad: TcxComboBox
              Left = 114
              Top = 30
              Properties.CharCase = ecUpperCase
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                'IMPORTE'
                'UNIDADES'
                'CAJAS'
                'KILOS'
                'CANTIDAD')
              Properties.OnChange = cbxTipoUnidadPropertiesChange
              TabOrder = 7
              Text = 'CANTIDAD'
              Width = 81
            end
            object lb12: TcxLabel
              Left = 377
              Top = 14
              AutoSize = False
              Caption = 'Unidades'
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
              Properties.Alignment.Horz = taLeftJustify
              Height = 17
              Width = 70
            end
            object ceUnidades: TcxCurrencyEdit
              Left = 377
              Top = 31
              Properties.DecimalPlaces = 0
              Properties.DisplayFormat = ',0;-,0'
              Properties.EditFormat = ',0;-,0'
              Properties.ReadOnly = True
              Properties.ValidateOnEnter = False
              Properties.ValidationOptions = [evoRaiseException, evoShowErrorIcon]
              Properties.OnChange = ceUnidadesPropertiesChange
              Style.Color = clBtnFace
              Style.LookAndFeel.Kind = lfStandard
              Style.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.Kind = lfStandard
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.Kind = lfStandard
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.Kind = lfStandard
              StyleHot.LookAndFeel.NativeStyle = False
              TabOrder = 2
              Width = 70
            end
            object lb13: TcxLabel
              Left = 642
              Top = 14
              AutoSize = False
              Caption = 'Precio'
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
              Properties.Alignment.Horz = taLeftJustify
              Height = 17
              Width = 69
            end
            object ceImporte: TcxCurrencyEdit
              Left = 733
              Top = 31
              Properties.DecimalPlaces = 2
              Properties.DisplayFormat = ',0.00;-,0.00'
              Properties.EditFormat = ',0.00;-,0.00'
              Style.LookAndFeel.Kind = lfStandard
              Style.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.Kind = lfStandard
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.Kind = lfStandard
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.Kind = lfStandard
              StyleHot.LookAndFeel.NativeStyle = False
              TabOrder = 6
              Width = 90
            end
            object lb14: TcxLabel
              Left = 733
              Top = 12
              AutoSize = False
              Caption = 'Importe Linea'
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
              Width = 69
              AnchorX = 802
            end
            object cxLabel2: TcxLabel
              Left = 451
              Top = 14
              AutoSize = False
              Caption = 'Kilos'
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
              Properties.Alignment.Horz = taLeftJustify
              Height = 17
              Width = 90
            end
            object ceKilos: TcxCurrencyEdit
              Left = 451
              Top = 31
              Properties.AssignedValues.DisplayFormat = True
              Properties.DecimalPlaces = 2
              Properties.EditFormat = ',0.00;-,0.00'
              Properties.ValidationOptions = [evoRaiseException, evoShowErrorIcon]
              Properties.OnChange = ceKilosPropertiesChange
              Style.Color = clWindow
              Style.LookAndFeel.Kind = lfStandard
              Style.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.Kind = lfStandard
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.Kind = lfStandard
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.Kind = lfStandard
              StyleHot.LookAndFeel.NativeStyle = False
              TabOrder = 3
              Width = 90
            end
            object cxLabel3: TcxLabel
              Left = 545
              Top = 14
              AutoSize = False
              Caption = 'Und. Fact.'
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
              Properties.Alignment.Horz = taLeftJustify
              Height = 17
              Width = 70
            end
            object cxLabel4: TcxLabel
              Left = 313
              Top = 14
              AutoSize = False
              Caption = 'Unds. Caja'
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
              Properties.Alignment.Horz = taLeftJustify
              Height = 17
              Width = 60
            end
            object ceUndCaja: TcxCurrencyEdit
              Left = 313
              Top = 31
              Properties.DecimalPlaces = 0
              Properties.DisplayFormat = ',0'
              Properties.EditFormat = ',0'
              Properties.ValidationOptions = [evoRaiseException, evoShowErrorIcon]
              Properties.OnChange = ceUndCajaPropertiesChange
              Style.Color = clWindow
              Style.LookAndFeel.Kind = lfStandard
              Style.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.Kind = lfStandard
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.Kind = lfStandard
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.Kind = lfStandard
              StyleHot.LookAndFeel.NativeStyle = False
              TabOrder = 1
              Width = 60
            end
            object ceCajas: TcxCurrencyEdit
              Left = 247
              Top = 31
              Properties.DecimalPlaces = 0
              Properties.DisplayFormat = ',0'
              Properties.EditFormat = ',0'
              Properties.ValidationOptions = [evoRaiseException, evoShowErrorIcon]
              Properties.OnChange = ceCajasPropertiesChange
              Style.Color = clWindow
              Style.LookAndFeel.Kind = lfStandard
              Style.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.Kind = lfStandard
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.Kind = lfStandard
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.Kind = lfStandard
              StyleHot.LookAndFeel.NativeStyle = False
              TabOrder = 0
              Width = 60
            end
            object cxLabel5: TcxLabel
              Left = 247
              Top = 14
              AutoSize = False
              Caption = 'Cajas'
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
              Properties.Alignment.Horz = taLeftJustify
              Height = 17
              Width = 60
            end
            object ceUndFac: TcxTextEdit
              Left = 545
              Top = 31
              Properties.MaxLength = 3
              Style.LookAndFeel.Kind = lfStandard
              Style.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.Kind = lfStandard
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.Kind = lfStandard
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.Kind = lfStandard
              StyleHot.LookAndFeel.NativeStyle = False
              TabOrder = 4
              Text = 'ceUndFac'
              Width = 70
            end
            object cePrecio: TcxCurrencyEdit
              Left = 642
              Top = 31
              Properties.DecimalPlaces = 4
              Properties.DisplayFormat = ',0.0000'
              Properties.EditFormat = ',0.0000'
              Properties.ValidationOptions = [evoRaiseException, evoShowErrorIcon]
              Properties.OnChange = cePrecioPropertiesChange
              Style.Color = clWindow
              Style.LookAndFeel.Kind = lfStandard
              Style.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.Kind = lfStandard
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.Kind = lfStandard
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.Kind = lfStandard
              StyleHot.LookAndFeel.NativeStyle = False
              TabOrder = 5
              Width = 70
            end
          end
          object ssEmpAlbaran: TSimpleSearch
            Left = 104
            Top = 5
            Width = 21
            Height = 21
            TabOrder = 1
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
            Enlace = edtEmpAlbaran
            Tecla = 'F2'
            Concatenar = False
          end
          object ssCenSalida: TSimpleSearch
            Left = 392
            Top = 5
            Width = 21
            Height = 21
            TabOrder = 4
            TabStop = False
            LookAndFeel.NativeStyle = False
            LookAndFeel.SkinName = 'MoneyTwins'
            OptionsImage.ImageIndex = 2
            OptionsImage.Images = FDM.ilxImagenes
            Titulo = 'Busqueda de Centros'
            Tabla = 'frf_centros'
            Campos = <
              item
                Etiqueta = 'Centro'
                Campo = 'centro_c'
                Ancho = 100
                Tipo = ctCadena
              end
              item
                Etiqueta = 'Descripci'#243'n'
                Campo = 'descripcion_c'
                Ancho = 400
                Tipo = ctCadena
              end>
            Database = 'BDProyecto'
            CampoResultado = 'centro_c'
            Enlace = edtCenSalida
            Tecla = 'F2'
            AntesEjecutar = ssCenSalidaAntesEjecutar
            Concatenar = False
          end
          object ssProducto: TSimpleSearch
            Left = 104
            Top = 29
            Width = 21
            Height = 21
            TabOrder = 12
            TabStop = False
            LookAndFeel.NativeStyle = False
            LookAndFeel.SkinName = 'MoneyTwins'
            OptionsImage.ImageIndex = 2
            OptionsImage.Images = FDM.ilxImagenes
            Titulo = 'Busqueda de Productos'
            Tabla = 'frf_productos'
            Campos = <
              item
                Etiqueta = 'Producto'
                Campo = 'producto_p'
                Ancho = 100
                Tipo = ctCadena
              end
              item
                Etiqueta = 'Descripci'#243'n'
                Campo = 'descripcion_p'
                Ancho = 400
                Tipo = ctCadena
              end>
            Database = 'BDProyecto'
            Join = 'fecha_baja_p is null'
            CampoResultado = 'producto_p'
            Enlace = edtProducto
            Tecla = 'F2'
            AntesEjecutar = ssProductoAntesEjecutar
            Concatenar = False
          end
          object ssEnvase: TSimpleSearch
            Left = 437
            Top = 29
            Width = 21
            Height = 21
            TabOrder = 14
            TabStop = False
            LookAndFeel.NativeStyle = False
            LookAndFeel.SkinName = 'MoneyTwins'
            OptionsImage.ImageIndex = 2
            OptionsImage.Images = FDM.ilxImagenes
            Titulo = 'Busqueda de Envases'
            Tabla = 'frf_envases, frf_clientes_env, frf_productos'
            Campos = <
              item
                Etiqueta = 'Art'#237'culo'
                Campo = 'envase_e'
                Ancho = 100
                Tipo = ctCadena
              end
              item
                Etiqueta = 'Descrici'#243'n'
                Campo = 'descripcion_e'
                Ancho = 400
                Tipo = ctCadena
              end>
            Database = 'BDProyecto'
            Join = 
              'producto_p = producto_e and envase_ce = envase_e and producto_ce' +
              ' = producto_e and fecha_baja_e is null'
            CampoResultado = 'envase_e'
            Enlace = edtEnvase
            Tecla = 'F2'
            AntesEjecutar = ssEnvaseAntesEjecutar
            Concatenar = False
          end
          object ssCategoria: TSimpleSearch
            Left = 783
            Top = 29
            Width = 21
            Height = 21
            TabOrder = 16
            TabStop = False
            LookAndFeel.NativeStyle = False
            LookAndFeel.SkinName = 'MoneyTwins'
            OptionsImage.ImageIndex = 2
            OptionsImage.Images = FDM.ilxImagenes
            Titulo = 'Busqueda de Categorias'
            Tabla = 'frf_categorias'
            Campos = <
              item
                Etiqueta = 'Categoria'
                Campo = 'categoria_c'
                Ancho = 100
                Tipo = ctCadena
              end
              item
                Etiqueta = 'Descripci'#243'n'
                Campo = 'descripcion_c'
                Ancho = 400
                Tipo = ctCadena
              end>
            Database = 'BDProyecto'
            CampoResultado = 'categoria_c'
            Enlace = edtCategoria
            Tecla = 'F2'
            AntesEjecutar = ssCategoriaAntesEjecutar
            Concatenar = False
          end
        end
        object cxTabControl1: TcxTabControl
          Left = 0
          Top = 0
          Width = 990
          Height = 24
          Align = alTop
          Color = clBtnFace
          ParentColor = False
          TabOrder = 0
          Properties.CustomButtons.Buttons = <>
          Properties.Style = 7
          LookAndFeel.Kind = lfUltraFlat
          LookAndFeel.NativeStyle = False
          LookAndFeel.SkinName = 'Blueprint'
          ClientRectBottom = 23
          ClientRectLeft = 1
          ClientRectRight = 989
          ClientRectTop = 1
          object btnAltaLinea: TcxButton
            Left = -1
            Top = -1
            Width = 24
            Height = 25
            TabOrder = 0
            OnClick = btnAltaLineaClick
            LookAndFeel.NativeStyle = True
            LookAndFeel.SkinName = 'Blueprint'
            OptionsImage.ImageIndex = 12
            OptionsImage.Images = DFactura.IFacturas
          end
          object btnBajaLinea: TcxButton
            Left = 21
            Top = -1
            Width = 24
            Height = 25
            TabOrder = 1
            OnClick = btnBajaLineaClick
            LookAndFeel.NativeStyle = True
            LookAndFeel.SkinName = 'Blueprint'
            OptionsImage.ImageIndex = 13
            OptionsImage.Images = DFactura.IFacturas
          end
          object btnAceptarLinea: TcxButton
            Left = 51
            Top = 0
            Width = 24
            Height = 25
            TabOrder = 2
            OnClick = btnAceptarLineaClick
            LookAndFeel.NativeStyle = True
            LookAndFeel.SkinName = 'Blueprint'
            OptionsImage.ImageIndex = 10
            OptionsImage.Images = DFactura.IFacturas
          end
          object btnCancelarLinea: TcxButton
            Left = 73
            Top = -1
            Width = 24
            Height = 25
            TabOrder = 3
            OnClick = btnCancelarLineaClick
            LookAndFeel.NativeStyle = True
            LookAndFeel.SkinName = 'Blueprint'
            OptionsImage.ImageIndex = 4
            OptionsImage.Images = DFactura.IFacturas
          end
        end
      end
      object tsTextoFactura: TcxTabSheet
        Caption = 'Texto Factura'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object mmxNotas: TcxMemo
          Left = 0
          Top = 0
          Align = alClient
          TabOrder = 0
          Height = 368
          Width = 990
        end
      end
    end
  end
  object bmxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Principal'
      'Lineas')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = DFactura.IFacturas
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blue'
    MenusShowRecentItemsFirst = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 632
    DockControlHeights = (
      0
      0
      22
      0)
    object bmPrincipal: TdxBar
      BorderStyle = bbsNone
      Caption = 'Principal'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 1
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 261
      FloatTop = 128
      FloatClientWidth = 0
      FloatClientHeight = 0
      Images = DFactura.IFacturas
      IsMainMenu = True
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnAceptar'
        end
        item
          Visible = True
          ItemName = 'btnCancelar'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnGrabarFactura'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnSalir'
        end>
      MultiLine = True
      OneOnRow = True
      Row = 0
      ShowMark = False
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object btnAceptar: TdxBarButton
      Caption = 'Aceptar'
      Category = 0
      Hint = 'Aceptar Cabecera Factura'
      Visible = ivAlways
      ImageIndex = 10
      OnClick = btnAceptarClick
    end
    object btnCancelar: TdxBarButton
      Caption = 'Cancelar'
      Category = 0
      Hint = 'Cancelar Cabecera Factura'
      Visible = ivAlways
      ImageIndex = 4
      OnClick = btnCancelarClick
    end
    object btnGrabarFactura: TdxBarButton
      Caption = 'Generar Factura'
      Category = 0
      Hint = 'Generar Factura'
      Visible = ivAlways
      ImageIndex = 15
      OnClick = btnGrabarFacturaClick
    end
    object btnSalir: TdxBarButton
      Caption = 'Salir'
      Category = 0
      Hint = 'Salir'
      Visible = ivAlways
      ImageIndex = 14
      OnClick = btnSalirClick
    end
    object bbxAltaLinea: TdxBarButton
      Caption = 'Alta Linea'
      Category = 1
      Hint = 'Alta Linea'
      Visible = ivAlways
      ImageIndex = 12
    end
    object bbxBajaLinea: TdxBarButton
      Caption = 'Baja Linea'
      Category = 1
      Hint = 'Baja Linea'
      Visible = ivAlways
      ImageIndex = 13
    end
    object bbxAceptarLinea: TdxBarButton
      Caption = 'Aceptar Linea'
      Category = 1
      Hint = 'Aceptar Linea'
      Visible = ivAlways
      ImageIndex = 10
    end
    object bbxCancelarLinea: TdxBarButton
      Caption = 'Cancelar Linea'
      Category = 1
      Hint = 'Cancelar Linea'
      Visible = ivAlways
      ImageIndex = 4
    end
  end
  object dsCabFactura: TDataSource
    OnStateChange = dsCabFacturaStateChange
    Left = 744
    Top = 38
  end
  object dsDetFactura: TDataSource
    OnStateChange = dsDetFacturaStateChange
    OnDataChange = dsDetFacturaDataChange
    Left = 787
    Top = 37
  end
end
