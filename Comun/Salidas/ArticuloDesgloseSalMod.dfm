object FArticuloDesgloseSalMod: TFArticuloDesgloseSalMod
  Left = 263
  Top = 13
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Modificacion Desglose de Producto en Albaranes Salida'
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
  OnKeyDown = FormKeyDown
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
      Top = 153
      Width = 801
      Height = 240
      Align = alTop
      BorderStyle = cxcbsNone
      TabOrder = 0
      LevelTabs.Slants.Kind = skCutCorner
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'DevExpressStyle'
      object tvArticuloDesgloseSal: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsQSalidasL2
        DataController.KeyFieldNames = 
          'empresa_sl2;centro_salida_sl2;n_albaran_sl2;fecha_sl2;id_linea_a' +
          'lbaran_sl2;producto_desglose_sl2'
        DataController.Options = []
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00 %'
            Kind = skSum
            FieldName = 'porcentaje_sl2'
            Column = tvPorcentajeDesglose
          end
          item
            Kind = skSum
            FieldName = 'kilos_desglose_sl2'
            Column = tvKilosDesglose
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object tvProductoDesglose: TcxGridDBColumn
          Caption = 'Producto Desglose'
          DataBinding.FieldName = 'producto_desglose_sl2'
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
          DataBinding.FieldName = 'porcentaje_sl2'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00 %'
          Properties.OnEditValueChanged = tvPorcentajeDesglosePropertiesEditValueChanged
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.Filtering = False
          Options.AutoWidthSizable = False
          Width = 64
        end
        object tvKilosDesglose: TcxGridDBColumn
          Caption = 'Kilos Desglose'
          DataBinding.FieldName = 'kilos_desglose_sl2'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
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
      Caption = 'Datos Albaran Salida'
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
      Height = 152
      Width = 801
      object lb7: TcxLabel
        Left = 44
        Top = 22
        AutoSize = False
        Caption = 'Empresa'
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
        Width = 61
        AnchorX = 105
      end
      object txtEmpresa: TcxTextEdit
        Left = 108
        Top = 22
        TabStop = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = True
        Style.BorderStyle = ebs3D
        Style.Color = clWindow
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = ''
        Style.Shadow = False
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = ''
        StyleFocused.LookAndFeel.Kind = lfUltraFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.SkinName = ''
        StyleHot.LookAndFeel.Kind = lfUltraFlat
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.SkinName = ''
        TabOrder = 1
        Width = 38
      end
      object txtDesEmpresa: TcxTextEdit
        Left = 147
        Top = 22
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
        Width = 242
      end
      object lb8: TcxLabel
        Left = 44
        Top = 72
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
        Top = 71
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
        Width = 74
      end
      object txtDesArticulo: TcxTextEdit
        Left = 183
        Top = 71
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
        Width = 206
      end
      object lb9: TcxLabel
        Left = 9
        Top = 111
        AutoSize = False
        Caption = 'Kilos a Desglosar'
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
        Height = 17
        Width = 92
        AnchorX = 101
      end
      object txtKilosTotal: TcxTextEdit
        Left = 107
        Top = 110
        TabStop = False
        Properties.Alignment.Horz = taRightJustify
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
        TabOrder = 7
        Width = 80
      end
      object lb10: TcxLabel
        Left = 426
        Top = 22
        AutoSize = False
        Caption = 'Centro'
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
        AnchorX = 486
      end
      object txtCentro: TcxTextEdit
        Left = 492
        Top = 21
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
        TabOrder = 9
        Width = 38
      end
      object txtDesCentro: TcxTextEdit
        Left = 531
        Top = 21
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
        TabOrder = 10
        Width = 200
      end
      object cxLabel1: TcxLabel
        Left = 41
        Top = 48
        AutoSize = False
        Caption = 'Albar'#225'n'
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
        AnchorX = 101
      end
      object txtAlbaran: TcxTextEdit
        Left = 108
        Top = 47
        TabStop = False
        Properties.Alignment.Horz = taRightJustify
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
        TabOrder = 12
        Width = 74
      end
      object cxLabel2: TcxLabel
        Left = 237
        Top = 48
        AutoSize = False
        Caption = ' Fecha Albar'#225'n'
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
        Width = 75
        AnchorX = 312
      end
      object txtFechaAlb: TcxTextEdit
        Left = 315
        Top = 47
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
        TabOrder = 14
        Width = 74
      end
      object cxLabel3: TcxLabel
        Left = 428
        Top = 72
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
        Top = 71
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
        TabOrder = 16
        Width = 38
      end
      object txtDesProducto: TcxTextEdit
        Left = 531
        Top = 71
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
        TabOrder = 17
        Width = 200
      end
      object cxLabel4: TcxLabel
        Left = 414
        Top = 47
        AutoSize = False
        Caption = 'N'#186' de Linea'
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
        Width = 75
        AnchorX = 489
      end
      object txtIdAlbaran: TcxTextEdit
        Left = 492
        Top = 46
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
        TabOrder = 19
        Width = 38
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
      ReportDocument.CreationDate = 43754.538979027780000000
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
  object dsQSalidasL2: TDataSource
    OnDataChange = dsQSalidasL2DataChange
    Left = 704
    Top = 9
  end
end
