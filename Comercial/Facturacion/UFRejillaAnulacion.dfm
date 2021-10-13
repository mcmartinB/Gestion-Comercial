object FRejillaAnulacion: TFRejillaAnulacion
  Left = 267
  Top = 25
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'PROCESO DE ANULACI'#211'N'
  ClientHeight = 614
  ClientWidth = 896
  Color = clActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl2: TPanel
    Left = 0
    Top = 42
    Width = 896
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
      Top = 130
      Width = 894
      Height = 337
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
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = DFactura.dsFacturas_Cab
        DataController.KeyFieldNames = 'cod_factura_fc'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsSelection.MultiSelect = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object tvMarca: TcxGridDBColumn
          DataBinding.ValueType = 'Boolean'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayChecked = 'False'
          Properties.DisplayUnchecked = 'True'
          Properties.DisplayGrayed = 'False'
          Properties.ImmediatePost = True
          Properties.MultiLine = True
          Properties.NullStyle = nssUnchecked
          Properties.ValueGrayed = 'False'
          Properties.OnChange = tvMarcaPropertiesChange
          MinWidth = 30
          Width = 30
        end
        object tvEmpresa: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'cod_empresa_fac_fc'
          MinWidth = 30
          Options.Editing = False
          Width = 50
        end
        object tvSerie: TcxGridDBColumn
          Caption = 'Serie'
          DataBinding.FieldName = 'cod_serie_fac_fc'
          Options.Editing = False
          Width = 50
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
        object tvFecha: TcxGridDBColumn
          Caption = 'Fecha Factura'
          DataBinding.FieldName = 'fecha_factura_fc'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
        end
        object tvCodigoFac: TcxGridDBColumn
          Caption = 'C'#243'digo Factura'
          DataBinding.FieldName = 'cod_factura_fc'
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
        end
        object tvImpuesto: TcxGridDBColumn
          Caption = 'Impuesto'
          DataBinding.FieldName = 'impuesto_fc'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Visible = False
          Options.Editing = False
          Width = 50
        end
        object tvDesImpuesto: TcxGridDBColumn
          Caption = 'Impuesto'
          DataBinding.ValueType = 'String'
          OnGetDisplayText = tvDesImpuestoGetDisplayText
          HeaderAlignmentHorz = taCenter
        end
        object tvMoneda: TcxGridDBColumn
          Caption = 'Moneda'
          DataBinding.FieldName = 'moneda_fc'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Editing = False
          Width = 55
        end
        object tvImporteNeto: TcxGridDBColumn
          Caption = 'Importe Neto'
          DataBinding.FieldName = 'importe_neto_fc'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 100
        end
        object tvImporteImpuesto: TcxGridDBColumn
          Caption = 'Impuestos'
          DataBinding.FieldName = 'importe_impuesto_fc'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 100
        end
        object tvImporteTotal: TcxGridDBColumn
          Caption = 'Importe Total'
          DataBinding.FieldName = 'importe_total_fc'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 100
        end
      end
      object tvDetalle: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = DFactura.dsFacturas_Det
        DataController.DetailKeyFieldNames = 'cod_factura_fd'
        DataController.KeyFieldNames = 'cod_factura_fd'
        DataController.MasterKeyFieldNames = 'cod_factura_fc'
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
        DataController.DetailKeyFieldNames = 'cod_factura_fg'
        DataController.KeyFieldNames = 'cod_factura_fg'
        DataController.MasterKeyFieldNames = 'cod_factura_fc'
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
      Left = 576
      Top = 496
      Width = 137
      Height = 49
      Caption = 'Anular Facturas'
      TabOrder = 1
      OnClick = btnAceptarClick
      OptionsImage.ImageIndex = 10
      OptionsImage.Images = DFactura.IFacturas
    end
    object btnCancelar: TcxButton
      Left = 715
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
      Caption = 'Criterio de Anulaci'#243'n'
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
      Width = 894
      object lb7: TcxLabel
        Left = 24
        Top = 25
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
        AnchorX = 134
      end
      object txEmpresa: TcxTextEdit
        Left = 140
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
        Left = 172
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
        Width = 269
      end
      object lb8: TcxLabel
        Left = 29
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
        AnchorX = 139
      end
      object txCliente: TcxTextEdit
        Left = 140
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
        Left = 172
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
        Width = 269
      end
      object lb9: TcxLabel
        Left = 29
        Top = 72
        AutoSize = False
        Caption = 'Fecha Factura'
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
        AnchorX = 139
      end
      object txFechaFactura: TcxTextEdit
        Left = 140
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
      object cxLabel1: TcxLabel
        Left = 472
        Top = 25
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
        Width = 38
        AnchorX = 510
      end
      object txSerie: TcxTextEdit
        Left = 516
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
        Width = 30
      end
    end
    object cxTabControl: TcxTabControl
      Left = 1
      Top = 106
      Width = 894
      Height = 24
      Align = alTop
      Color = clBtnFace
      ParentColor = False
      TabOrder = 4
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 7
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Blueprint'
      ClientRectBottom = 23
      ClientRectLeft = 1
      ClientRectRight = 893
      ClientRectTop = 1
      object btnMarcar: TcxButton
        Left = 3
        Top = -1
        Width = 130
        Height = 25
        Hint = 'Seleccionar Todo'
        Caption = 'Seleccionar Todo'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnMarcarClick
        LookAndFeel.NativeStyle = True
        LookAndFeel.SkinName = 'Blueprint'
        OptionsImage.ImageIndex = 10
        OptionsImage.Images = DFactura.IFacturas
      end
      object btnDesmarcar: TcxButton
        Left = 132
        Top = -1
        Width = 130
        Height = 25
        Caption = 'Deseleccionar Todo'
        TabOrder = 1
        OnClick = btnDesmarcarClick
        LookAndFeel.NativeStyle = True
        LookAndFeel.SkinName = 'Blueprint'
        OptionsImage.ImageIndex = 4
        OptionsImage.Images = DFactura.IFacturas
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
      PrinterPage.Orientation = poLandscape
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
      ReportDocument.CreationDate = 43892.489838344910000000
      OptionsView.FilterBar = False
      BuiltInReportLink = True
    end
  end
  object actlst1: TActionList
    Left = 368
    object actExpandir: TAction
      Caption = 'actExpandir'
      ShortCut = 69
      OnExecute = actExpandirExecute
    end
    object actContraer: TAction
      Caption = 'actContraer'
      ShortCut = 67
      OnExecute = actContraerExecute
    end
    object actPreview: TAction
      Caption = 'actPreview'
      ImageIndex = 2
      ShortCut = 80
      OnExecute = actPreviewExecute
    end
    object actPrint: TAction
      Caption = 'actPrint'
      ImageIndex = 3
      ShortCut = 73
      OnExecute = actPrintExecute
    end
    object actCancelar: TAction
      Caption = 'actCancelar'
      ShortCut = 27
      OnExecute = actCancelarExecute
    end
    object actAceptar: TAction
      Caption = 'actAceptar'
      ShortCut = 112
      OnExecute = actAceptarExecute
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
