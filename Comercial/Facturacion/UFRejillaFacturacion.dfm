object FRejillaFacturacion: TFRejillaFacturacion
  Left = 398
  Top = 142
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'PROCESO DE FACTURACION'
  ClientHeight = 614
  ClientWidth = 803
  Color = clActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnl2: TPanel
    Left = 0
    Top = 42
    Width = 803
    Height = 572
    Align = alClient
    Color = clInactiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNone
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object cxGrid: TcxGrid
      Left = 1
      Top = 106
      Width = 801
      Height = 367
      Align = alTop
      BorderStyle = cxcbsNone
      TabOrder = 0
      OnEnter = cxGridEnter
      LevelTabs.Slants.Kind = skCutCorner
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'DevExpressStyle'
      object tvFacturas: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = DFactura.dsFacturas_Cab
        DataController.KeyFieldNames = 'fac_interno_fc'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object tvEmpresa: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'cod_empresa_fac_fc'
          MinWidth = 30
          Options.Editing = False
          Width = 30
        end
        object tvCliente: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'cod_cliente_fc'
          MinWidth = 30
          Options.Editing = False
          Width = 50
        end
        object tvDesCliente: TcxGridDBColumn
          Caption = 'Nombre'
          DataBinding.FieldName = 'des_cliente_fc'
          Options.Editing = False
          Width = 270
        end
        object tvImpuesto: TcxGridDBColumn
          Caption = 'Impuesto'
          DataBinding.FieldName = 'impuesto_fc'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Width = 50
        end
        object tvMoneda: TcxGridDBColumn
          Caption = 'Moneda'
          DataBinding.FieldName = 'moneda_fc'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Width = 50
        end
        object tvImporteNeto: TcxGridDBColumn
          Caption = 'Importe Neto'
          DataBinding.FieldName = 'importe_neto_fc'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Options.Editing = False
          Width = 100
        end
        object tvImporteImpuesto: TcxGridDBColumn
          Caption = 'Impuestos'
          DataBinding.FieldName = 'importe_impuesto_fc'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Options.Editing = False
          Width = 100
        end
        object tvImporteTotal: TcxGridDBColumn
          Caption = 'Importe Total'
          DataBinding.FieldName = 'importe_total_fc'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Options.Editing = False
          Width = 100
        end
      end
      object tvDetalle: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = DFactura.dsFacturas_Det
        DataController.DetailKeyFieldNames = 'fac_interno_fd'
        DataController.KeyFieldNames = 'fac_interno_fd'
        DataController.MasterKeyFieldNames = 'fac_interno_fc'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,0.00'
            Kind = skSum
            FieldName = 'importe_neto_fd'
            Column = tvImporteNetoDet
          end
          item
            Format = '#,0.00'
            Kind = skSum
            FieldName = 'importe_impuesto_fd'
            Column = tvImporteImpuestoDet
          end
          item
            Format = '#,0.00'
            Kind = skSum
            FieldName = 'importe_total_fd'
            Column = tvImporteTotalDet
            Sorted = True
          end
          item
            Format = '#,0.00'
            Kind = skSum
            FieldName = 'importe_linea_fd'
            Column = tvImporteLinea
          end
          item
            Format = '#,0.00'
            Kind = skSum
            FieldName = 'importe_total_descuento_fd'
            Column = tvImpDescuento
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object tvEmpresaAlb: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'cod_empresa_albaran_fd'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Width = 55
        end
        object tvCentroAlb: TcxGridDBColumn
          Caption = 'Centro'
          DataBinding.FieldName = 'cod_centro_albaran_fd'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Width = 45
        end
        object tvDirSuministro: TcxGridDBColumn
          Caption = 'Dir. Sum.'
          DataBinding.FieldName = 'cod_dir_sum_fd'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 60
        end
        object tvFechaAlbaran: TcxGridDBColumn
          Caption = 'Fecha Albaran'
          DataBinding.FieldName = 'fecha_albaran_fd'
          MinWidth = 30
          Options.Editing = False
          Width = 85
        end
        object tvAlbaran: TcxGridDBColumn
          Caption = 'Albaran'
          DataBinding.FieldName = 'n_albaran_fd'
          Options.Editing = False
          Width = 50
        end
        object tvProducto: TcxGridDBColumn
          Caption = 'Prod.'
          DataBinding.FieldName = 'cod_producto_fd'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Width = 40
        end
        object tvDesProducto: TcxGridDBColumn
          Caption = 'Descripcion'
          DataBinding.FieldName = 'des_producto_fd'
          Options.Editing = False
          Width = 150
        end
        object tvImporteLinea: TcxGridDBColumn
          Caption = 'Importe Linea'
          DataBinding.FieldName = 'importe_linea_fd'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Options.Editing = False
          Width = 90
        end
        object tvImpDescuento: TcxGridDBColumn
          Caption = 'Imp. Descuento'
          DataBinding.FieldName = 'importe_total_descuento_fd'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Options.Editing = False
          Width = 100
        end
        object tvImporteNetoDet: TcxGridDBColumn
          Caption = 'Importe Neto'
          DataBinding.FieldName = 'importe_neto_fd'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          Options.Editing = False
          Width = 100
        end
        object tvImporteImpuestoDet: TcxGridDBColumn
          Caption = 'Impuestos'
          DataBinding.FieldName = 'importe_impuesto_fd'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          Options.Editing = False
          Width = 100
        end
        object tvImporteTotalDet: TcxGridDBColumn
          Caption = 'Total'
          DataBinding.FieldName = 'importe_total_fd'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          Options.Editing = False
          Width = 100
        end
      end
      object tvGastos: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = DFactura.dsFacturas_Gas
        DataController.DetailKeyFieldNames = 'fac_interno_fg'
        DataController.KeyFieldNames = 'fac_interno_fg'
        DataController.MasterKeyFieldNames = 'fac_interno_fc'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,0.00'
            Kind = skSum
            FieldName = 'importe_neto_fg'
            Column = tvGasImporteNeto
          end
          item
            Format = '#,0.00'
            Kind = skSum
            FieldName = 'importe_impuesto_fg'
            Column = tvGasImpuesto
          end
          item
            Format = '#,0.00'
            Kind = skSum
            FieldName = 'importe_total_fg'
            Column = tvGasImporteTotal
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object tvGasEmpresaAlb: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'cod_empresa_albaran_fg'
          Options.Editing = False
          Width = 50
        end
        object tvGasCentroAlb: TcxGridDBColumn
          Caption = 'Centro'
          DataBinding.FieldName = 'cod_centro_albaran_fg'
          Options.Editing = False
          Width = 40
        end
        object tvGasFechaAlb: TcxGridDBColumn
          Caption = 'Fecha Albaran'
          DataBinding.FieldName = 'fecha_albaran_fg'
          Options.Editing = False
          Width = 70
        end
        object tvGasAlbaran: TcxGridDBColumn
          Caption = 'Albaran'
          DataBinding.FieldName = 'n_albaran_fg'
          Options.Editing = False
          Width = 50
        end
        object tvGasTipo: TcxGridDBColumn
          Caption = 'Gasto'
          DataBinding.FieldName = 'cod_tipo_gasto_fg'
          Options.Editing = False
          Width = 40
        end
        object tvGasDesTipo: TcxGridDBColumn
          Caption = 'Descripcion'
          DataBinding.FieldName = 'des_tipo_gasto_fg'
          Options.Editing = False
          Width = 150
        end
        object tvGasImporteNeto: TcxGridDBColumn
          Caption = 'Importe Neto'
          DataBinding.FieldName = 'importe_neto_fg'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Options.Editing = False
          Width = 100
        end
        object tvGasImpuesto: TcxGridDBColumn
          Caption = 'Impuestos'
          DataBinding.FieldName = 'importe_impuesto_fg'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Width = 100
        end
        object tvGasImporteTotal: TcxGridDBColumn
          Caption = 'Importe Total'
          DataBinding.FieldName = 'importe_total_fg'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Options.Editing = False
          Width = 100
        end
      end
      object lvFacturas: TcxGridLevel
        GridView = tvFacturas
        Options.DetailTabsPosition = dtpTop
        object lvDetalle: TcxGridLevel
          Caption = 'Detalle'
          GridView = tvDetalle
        end
        object lvGastos: TcxGridLevel
          Caption = 'Gastos'
          GridView = tvGastos
        end
      end
    end
    object btnAceptar: TcxButton
      Left = 510
      Top = 496
      Width = 137
      Height = 49
      Caption = 'Calcular Facturas'
      TabOrder = 1
      OnClick = btnAceptarClick
      OptionsImage.ImageIndex = 10
      OptionsImage.Images = DFactura.IFacturas
    end
    object btnCancelar: TcxButton
      Left = 653
      Top = 496
      Width = 137
      Height = 49
      Caption = 'Cancelar Proceso'
      TabOrder = 2
      OnClick = btnCancelarClick
      OptionsImage.ImageIndex = 4
      OptionsImage.Images = DFactura.IFacturas
    end
    object gbCriterio: TcxGroupBox
      Left = 1
      Top = 1
      Align = alTop
      Caption = 'Criterio de Facturaci'#243'n'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clNone
      Style.Font.Height = -11
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = []
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      TabOrder = 3
      Height = 105
      Width = 801
      object lb7: TcxLabel
        Left = 21
        Top = 24
        AutoSize = False
        Caption = 'Empresa Facturaci'#243'n'
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
        Width = 110
        AnchorX = 131
      end
      object txEmpresa: TcxTextEdit
        Left = 132
        Top = 22
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.Color = clBtnFace
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 1
        Width = 30
      end
      object txDesEmpresa: TcxTextEdit
        Left = 164
        Top = 22
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
        Width = 238
      end
      object lb8: TcxLabel
        Left = 21
        Top = 48
        AutoSize = False
        Caption = 'Cliente Facturaci'#243'n'
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
        Width = 110
        AnchorX = 131
      end
      object txCliente: TcxTextEdit
        Left = 132
        Top = 46
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.Color = clBtnFace
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 4
        Width = 30
      end
      object txDesCliente: TcxTextEdit
        Left = 164
        Top = 46
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
        Width = 316
      end
      object lb9: TcxLabel
        Left = 21
        Top = 72
        AutoSize = False
        Caption = 'Fecha Facturaci'#243'n'
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
        Width = 110
        AnchorX = 131
      end
      object txFechaFactura: TcxTextEdit
        Left = 132
        Top = 70
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.Color = clBtnFace
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 7
        Width = 80
      end
      object lb10: TcxLabel
        Left = 513
        Top = 24
        AutoSize = False
        Caption = 'Albar'#225'n de'
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
        Width = 100
        AnchorX = 613
      end
      object txDesdeAlbaran: TcxTextEdit
        Left = 614
        Top = 22
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.Color = clBtnFace
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 9
        Width = 65
      end
      object lb11: TcxLabel
        Left = 681
        Top = 24
        AutoSize = False
        Caption = 'a'
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
        Properties.Alignment.Horz = taCenter
        Height = 17
        Width = 20
        AnchorX = 691
      end
      object txHastaAlbaran: TcxTextEdit
        Left = 702
        Top = 22
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.Color = clBtnFace
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 11
        Width = 65
      end
      object lb12: TcxLabel
        Left = 513
        Top = 48
        AutoSize = False
        Caption = 'Facturar Desde'
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
        Width = 100
        AnchorX = 613
      end
      object txFechaDesde: TcxTextEdit
        Left = 614
        Top = 46
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.Color = clBtnFace
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 13
        Width = 65
      end
      object lb13: TcxLabel
        Left = 268
        Top = 72
        AutoSize = False
        Caption = 'Pedido'
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
        Width = 100
        AnchorX = 368
      end
      object txPedido: TcxTextEdit
        Left = 370
        Top = 70
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.Color = clBtnFace
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 15
        Width = 110
      end
      object cxLabel1: TcxLabel
        Left = 512
        Top = 72
        AutoSize = False
        Caption = 'N'#186' Factura Perdida'
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
        Width = 100
        AnchorX = 612
      end
      object txFactura: TcxTextEdit
        Left = 614
        Top = 70
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.Color = clBtnFace
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 17
        Width = 65
      end
      object txFechaHasta: TcxTextEdit
        Left = 702
        Top = 46
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.Color = clBtnFace
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 18
        Width = 65
      end
      object cxlbl1: TcxLabel
        Left = 681
        Top = 48
        AutoSize = False
        Caption = 'a'
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
        Properties.Alignment.Horz = taCenter
        Height = 17
        Width = 20
        AnchorX = 691
      end
      object cxLabel2: TcxLabel
        Left = 404
        Top = 24
        AutoSize = False
        Caption = 'Serie'
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
        Width = 44
        AnchorX = 448
      end
      object txSerie: TcxTextEdit
        Left = 450
        Top = 22
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.Color = clBtnFace
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 21
        Width = 30
      end
    end
  end
  object dxComponentPrinter: TdxComponentPrinter
    CurrentLink = dxComponentPrinterLink2
    Version = 0
    Left = 360
    Top = 248
    object dxComponentPrinterLink1: TdxCustomContainerReportLink
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      BuiltInReportLink = True
      HiddenComponents = {}
      ExcludedComponents = {}
      AggregatedReportLinks = {}
    end
    object dxComponentPrinterLink2: TdxGridReportLink
      Active = True
      Component = cxGrid
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 4000
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 17700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 44453.366847581020000000
      OptionsView.FilterBar = False
      BuiltInReportLink = True
    end
  end
  object actlst1: TActionList
    Left = 368
    object actExpandir: TAction
      Caption = 'actExpandir'
      OnExecute = actExpandirExecute
    end
    object actContraer: TAction
      Caption = 'actContraer'
      OnExecute = actContraerExecute
    end
    object actPreview: TAction
      Caption = 'actPreview'
      ImageIndex = 2
      OnExecute = actPreviewExecute
    end
    object actPrint: TAction
      Caption = 'actPrint'
      ImageIndex = 3
      OnExecute = actPrintExecute
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.HotImages = DFactura.IFacturas
    ImageOptions.LargeImages = DFactura.IFacturas
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blue'
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 328
    Top = 248
    DockControlHeights = (
      0
      0
      42
      0)
    object bmPrincipal: TdxBar
      Caption = 'Principal'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 2146
      FloatTop = 440
      FloatClientWidth = 62
      FloatClientHeight = 152
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      IsMainMenu = True
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxExpandir'
        end
        item
          Visible = True
          ItemName = 'dxContraer'
        end
        item
          Visible = True
          ItemName = 'dxPreview'
        end
        item
          Visible = True
          ItemName = 'dxPrint'
        end>
      MultiLine = True
      OneOnRow = True
      RotateWhenVertical = False
      Row = 0
      ShowMark = False
      UseOwnFont = True
      Visible = True
      WholeRow = False
    end
    object dxPreview: TdxBarLargeButton
      Action = actPreview
      Caption = 'Preview'
      Category = 0
      LargeImageIndex = 1
      HotImageIndex = 1
    end
    object dxPrint: TdxBarLargeButton
      Action = actPrint
      Caption = 'Imprimir'
      Category = 0
      LargeImageIndex = 2
      HotImageIndex = 2
    end
    object dxExpandir: TdxBarLargeButton
      Action = actExpandir
      Caption = 'Expandir'
      Category = 0
      LargeImageIndex = 0
      HotImageIndex = 0
    end
    object dxContraer: TdxBarLargeButton
      Action = actContraer
      Caption = 'Contraer'
      Category = 0
      LargeImageIndex = 3
      HotImageIndex = 3
    end
  end
end
