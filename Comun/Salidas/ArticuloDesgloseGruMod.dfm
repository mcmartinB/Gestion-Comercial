object FArticuloDesgloseGruMod: TFArticuloDesgloseGruMod
  Left = 263
  Top = 13
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 
    'Modificacion Desglose de Producto en Albaranes de Salida - GRUPO' +
    ' -'
  ClientHeight = 520
  ClientWidth = 803
  Color = clActiveCaption
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl2: TPanel
    Left = 0
    Top = 22
    Width = 803
    Height = 498
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
      Top = 81
      Width = 801
      Height = 240
      Align = alTop
      BorderStyle = cxcbsNone
      TabOrder = 0
      LevelTabs.Slants.Kind = skCutCorner
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'DevExpressStyle'
      ExplicitTop = 153
      object tvArticuloDesgloseSal: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsArticuloDesglose
        DataController.KeyFieldNames = 'articulo_ad;producto_ad;producto_desglose_ad'
        DataController.Options = []
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00 %'
            Kind = skSum
            FieldName = 'porcentaje_ad'
            Column = tvPorcentajeDesglose
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object tvProductoDesglose: TcxGridDBColumn
          Caption = 'Producto Desglose'
          DataBinding.FieldName = 'producto_desglose_ad'
          PropertiesClassName = 'TcxTextEditProperties'
          MinWidth = 30
          Options.Editing = False
          Options.Filtering = False
          Options.AutoWidthSizable = False
          Width = 150
        end
        object tvDesProductoDes: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.ValueType = 'String'
          PropertiesClassName = 'TcxTextEditProperties'
          OnGetDisplayText = tvDesProductoDesGetDisplayText
          Options.Editing = False
          Options.Filtering = False
          Width = 250
        end
        object tvPorcentajeDesglose: TcxGridDBColumn
          Caption = 'Porcentaje'
          DataBinding.FieldName = 'porcentaje_ad'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00 %'
          Properties.OnEditValueChanged = tvPorcentajeDesglosePropertiesEditValueChanged
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.Filtering = False
          Options.AutoWidthSizable = False
          Width = 64
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
      object tvSalidasL2: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        object tvSalidasL2Column1: TcxGridDBColumn
        end
      end
      object lvArticuloDesgloseSal: TcxGridLevel
        GridView = tvArticuloDesgloseSal
        Options.DetailTabsPosition = dtpTop
      end
    end
    object btnAceptar: TcxButton
      Left = 510
      Top = 408
      Width = 137
      Height = 49
      Caption = 'Actualizar Cambios'
      TabOrder = 1
      OnClick = btnAceptarClick
      OptionsImage.ImageIndex = 10
      OptionsImage.Images = DMBaseDatos.IFacturas
    end
    object btnCancelar: TcxButton
      Left = 653
      Top = 408
      Width = 137
      Height = 49
      Caption = 'Cancelar Cambios'
      TabOrder = 2
      OnClick = btnCancelarClick
      OptionsImage.ImageIndex = 4
      OptionsImage.Images = DMBaseDatos.IFacturas
    end
    object gbCriterio: TcxGroupBox
      Left = 1
      Top = 1
      Align = alTop
      Caption = 'Datos Art'#237'culo Desglose'
      Enabled = False
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
      Height = 80
      Width = 801
      object lb8: TcxLabel
        Left = 44
        Top = 32
        AutoSize = False
        Caption = 'Art'#237'culo'
        ParentColor = False
        ParentFont = False
        Style.Color = clBtnFace
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.TextStyle = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        Height = 18
        Width = 60
        AnchorX = 104
      end
      object txtArticulo: TcxTextEdit
        Left = 108
        Top = 31
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.BorderStyle = ebs3D
        Style.Color = clWindow
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = ''
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = ''
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = ''
        StyleHot.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = ''
        TabOrder = 1
        Width = 74
      end
      object txtDesArticulo: TcxTextEdit
        Left = 183
        Top = 31
        TabStop = False
        Properties.ReadOnly = True
        Style.BorderStyle = ebs3D
        Style.Color = clWindow
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
        Width = 206
      end
      object cxLabel3: TcxLabel
        Left = 428
        Top = 32
        AutoSize = False
        Caption = 'Producto'
        ParentColor = False
        ParentFont = False
        Style.Color = clBtnFace
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.TextStyle = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        Height = 18
        Width = 60
        AnchorX = 488
      end
      object txtProducto: TcxTextEdit
        Left = 492
        Top = 31
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.BorderStyle = ebs3D
        Style.Color = clWindow
        Style.LookAndFeel.Kind = lfFlat
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = ''
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
        Width = 38
      end
      object txtDesProducto: TcxTextEdit
        Left = 531
        Top = 31
        TabStop = False
        Properties.ReadOnly = True
        Style.BorderStyle = ebs3D
        Style.Color = clWindow
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
        Width = 200
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
      PageNumberFormat = pnfNumeral
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
      ReportDocument.CreationDate = 43761.413279988420000000
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
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
    end
    object actPrint: TAction
      Caption = 'actPrint'
      ImageIndex = 3
    end
    object actPrevisualizar: TAction
      Caption = 'Previsualizar Facturas'
      ShortCut = 112
      OnExecute = actPrevisualizarExecute
    end
    object actCancelar: TAction
      Caption = 'Cancelar Proceso'
      ShortCut = 27
      OnExecute = actCancelarExecute
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
      22
      0)
    object bmPrincipal: TdxBar
      BorderStyle = bbsNone
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
      IsMainMenu = True
      ItemLinks = <>
      MultiLine = True
      OneOnRow = True
      Row = 0
      ShowMark = False
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
  end
  object dsArticuloDesglose: TDataSource
    OnDataChange = dsArticuloDesgloseDataChange
    Left = 528
    Top = 137
  end
  object kMemArtDesglose: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 664
    Top = 144
    object kMemArtDesgloseempresa_sl2: TStringField
      FieldName = 'empresa_sl2'
    end
    object kMemArtDesglosecentro_salida_sl2: TStringField
      FieldName = 'centro_salida_sl2'
    end
    object kMemArtDesglosen_albaran_sl2: TIntegerField
      FieldName = 'n_albaran_sl2'
    end
    object kMemArtDesglosefecha_sl2: TDateField
      FieldName = 'fecha_sl2'
    end
    object kMemArtDesgloseid_linea_albaran_sl2: TIntegerField
      FieldName = 'id_linea_albaran_sl2'
    end
  end
end
