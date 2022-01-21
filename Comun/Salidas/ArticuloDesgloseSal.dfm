object FArticuloDesgloseSal: TFArticuloDesgloseSal
  Left = 257
  Top = 55
  BorderIcons = []
  Caption = 'Desglose de Producto en Albaranes Salida'
  ClientHeight = 723
  ClientWidth = 889
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlConsulta: TPanel
    Left = 0
    Top = 38
    Width = 889
    Height = 181
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object gbCriterios: TcxGroupBox
      Left = 2
      Top = 2
      Align = alClient
      Caption = 'Selecci'#243'n de Salidas de Venta'
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsFlat
      Style.Color = clBtnFace
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = []
      Style.LookAndFeel.Kind = lfFlat
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      Style.Shadow = False
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = True
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.Kind = lfFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.Kind = lfFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.Kind = lfFlat
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      TabOrder = 0
      Height = 177
      Width = 885
      object stArticulo: TnbStaticText
        Left = 237
        Top = 84
        Width = 225
        Height = 19
        About = 'NB 0.1/20020725'
      end
      object stProducto: TnbStaticText
        Left = 166
        Top = 108
        Width = 225
        Height = 19
        About = 'NB 0.1/20020725'
      end
      object lbFechaIni: TcxLabel
        Left = 6
        Top = 33
        AutoSize = False
        Caption = 'Fecha Inicio '
        ParentColor = False
        Style.BorderStyle = ebsNone
        Style.Color = clBtnFace
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 80
        AnchorX = 86
      end
      object lbAlbaran: TcxLabel
        Left = 290
        Top = 57
        AutoSize = False
        Caption = 'Albaran'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 46
        AnchorX = 336
      end
      object lbArticulo: TcxLabel
        Left = 6
        Top = 83
        AutoSize = False
        Caption = 'Art'#237'culo '
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 80
        AnchorX = 86
      end
      object lbFecfin: TcxLabel
        Left = 250
        Top = 31
        AutoSize = False
        Caption = 'Fecha Fin '
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 80
        AnchorX = 330
      end
      object cxFechaIni: TcxDateEdit
        Left = 92
        Top = 30
        TabOrder = 1
        Width = 121
      end
      object cxFechaFin: TcxDateEdit
        Left = 341
        Top = 30
        TabOrder = 3
        Width = 121
      end
      object cxAlbaran: TcxTextEdit
        Left = 342
        Top = 56
        Properties.CharCase = ecUpperCase
        TabOrder = 8
        Width = 121
      end
      object cxArticulo: TcxTextEdit
        Left = 92
        Top = 82
        Properties.CharCase = ecUpperCase
        Properties.OnChange = cxArticuloPropertiesChange
        TabOrder = 9
        OnExit = cxArticuloExit
        Width = 121
      end
      object ssArticulo: TSimpleSearch
        Left = 214
        Top = 82
        Width = 21
        Height = 21
        TabOrder = 12
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
        CampoResultado = 'envase_e'
        Enlace = cxArticulo
        Tecla = 'F2'
        Concatenar = False
      end
      object lbEmpresa: TcxLabel
        Left = 6
        Top = 57
        AutoSize = False
        Caption = 'Empresa'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 80
        AnchorX = 86
      end
      object cxEmpresa: TcxTextEdit
        Left = 92
        Top = 56
        Properties.CharCase = ecUpperCase
        TabOrder = 5
        Width = 50
      end
      object lbCentro: TcxLabel
        Left = 158
        Top = 57
        AutoSize = False
        Caption = 'Centro'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 70
        AnchorX = 228
      end
      object cxCentro: TcxTextEdit
        Left = 234
        Top = 56
        Properties.CharCase = ecUpperCase
        TabOrder = 7
        Width = 50
      end
      object lbProducto: TcxLabel
        Left = 6
        Top = 107
        AutoSize = False
        Caption = 'Producto'
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 80
        AnchorX = 86
      end
      object cxProducto: TcxTextEdit
        Left = 92
        Top = 106
        Properties.CharCase = ecUpperCase
        Properties.OnChange = cxProductoPropertiesChange
        TabOrder = 14
        OnExit = cxArticuloExit
        Width = 50
      end
      object ssProducto: TSimpleSearch
        Left = 143
        Top = 106
        Width = 21
        Height = 21
        TabOrder = 15
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
        Enlace = cxProducto
        Tecla = 'F2'
        Concatenar = False
      end
    end
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 243
    Width = 889
    Height = 480
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Foggy'
    object tvArticuloDesgloseSal: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = tvArticuloDesgloseSalCellDblClick
      DataController.DataModeController.SmartRefresh = True
      DataController.DataSource = dsQArtDesglose
      DataController.DetailKeyFieldNames = 
        'empresa_sl;centro_salida_sl;n_albaran_sl;fecha_sl;id_linea_albar' +
        'an_sl;envase_sl'
      DataController.KeyFieldNames = 
        'empresa_sl;centro_salida_sl;n_albaran_sl;fecha_sl;id_linea_albar' +
        'an_sl;envase_sl'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
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
        Options.Filtering = False
        Width = 30
      end
      object tvEmpresa: TcxGridDBColumn
        Caption = 'Emp'
        DataBinding.FieldName = 'empresa_sl'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.Editing = False
        Options.Filtering = False
      end
      object tvCentro: TcxGridDBColumn
        Caption = 'Cen'
        DataBinding.FieldName = 'centro_salida_sl'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.Editing = False
        Options.Filtering = False
      end
      object tvAlbaran: TcxGridDBColumn
        Caption = 'Albar'#225'n'
        DataBinding.FieldName = 'n_albaran_sl'
        PropertiesClassName = 'TcxTextEditProperties'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.Editing = False
        Options.Filtering = False
        Width = 60
      end
      object tvFecha: TcxGridDBColumn
        Caption = 'Fecha'
        DataBinding.FieldName = 'fecha_sl'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Editing = False
        Options.Filtering = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 80
      end
      object tvIdLineaAlbaran: TcxGridDBColumn
        Caption = 'N'#186' Linea'
        DataBinding.FieldName = 'id_linea_albaran_sl'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Width = 65
      end
      object tvCliente: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'cliente_sl'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.MaxLength = 3
        HeaderGlyphAlignmentHorz = taCenter
        MinWidth = 30
        Options.Editing = False
        Options.Filtering = False
        Width = 51
      end
      object tvDesCliente: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.ValueType = 'String'
        OnGetDisplayText = tvDesClienteGetDisplayText
        Options.Editing = False
        Options.Filtering = False
        Width = 200
      end
      object tvArticulo: TcxGridDBColumn
        Caption = 'Art'#237'culo'
        DataBinding.FieldName = 'envase_sl'
        PropertiesClassName = 'TcxTextEditProperties'
        MinWidth = 30
        Options.Editing = False
        Options.Filtering = False
        Width = 75
      end
      object tvDesArticulo: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.ValueType = 'String'
        OnGetDisplayText = tvDesArticuloGetDisplayText
        MinWidth = 200
        Options.Editing = False
        Options.Filtering = False
        Width = 200
      end
      object tvProducto: TcxGridDBColumn
        Caption = 'Prod'
        DataBinding.FieldName = 'producto_sl'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.Editing = False
        Options.Filtering = False
      end
      object tvCajas: TcxGridDBColumn
        Caption = 'Cajas'
        DataBinding.FieldName = 'cajas_sl'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Width = 70
      end
      object tvKilos: TcxGridDBColumn
        Caption = 'Kilos'
        DataBinding.FieldName = 'kilos_sl'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
      end
    end
    object tvSalidasL2: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsQSalidasL2
      DataController.DetailKeyFieldNames = 
        'empresa_sl2;centro_salida_sl2;n_albaran_sl2;fecha_sl2;id_linea_a' +
        'lbaran_sl2;articulo_sl2'
      DataController.KeyFieldNames = 
        'empresa_sl2;centro_salida_sl2;n_albaran_sl2;fecha_sl2;id_linea_a' +
        'lbaran_sl2;articulo_sl2'
      DataController.MasterKeyFieldNames = 
        'empresa_sl;centro_salida_sl;n_albaran_sl;fecha_sl;id_linea_albar' +
        'an_sl;envase_sl'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object tvProductoDesglose: TcxGridDBColumn
        Caption = 'Prod.'
        DataBinding.FieldName = 'producto_desglose_sl2'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Width = 40
      end
      object tvDesProducto: TcxGridDBColumn
        Caption = 'Descripcion'
        DataBinding.ValueType = 'String'
        OnGetDisplayText = tvDesProductoDesGetDisplayText
        Options.Editing = False
        Options.Filtering = False
        Width = 225
      end
      object tvPorcentajeDesglose: TcxGridDBColumn
        Caption = 'Porcentaje (%)'
        DataBinding.FieldName = 'porcentaje_sl2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00'
        Options.Editing = False
        Options.Filtering = False
        Width = 75
      end
      object tvKilosDesglose: TcxGridDBColumn
        Caption = 'Kilos Desglose'
        DataBinding.FieldName = 'kilos_desglose_sl2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00'
        Options.Editing = False
        Options.Filtering = False
        Width = 100
      end
    end
    object lvArticuloDesgloseSal: TcxGridLevel
      GridView = tvArticuloDesgloseSal
      object lvSalidasL2: TcxGridLevel
        GridView = tvSalidasL2
      end
    end
  end
  object cxTabControl: TcxTabControl
    Left = 0
    Top = 219
    Width = 889
    Height = 24
    Align = alTop
    Color = clBtnFace
    ParentColor = False
    TabOrder = 2
    Properties.CustomButtons.Buttons = <>
    Properties.Style = 7
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blueprint'
    ClientRectBottom = 23
    ClientRectLeft = 1
    ClientRectRight = 888
    ClientRectTop = 1
    object btnVerDesglose: TcxButton
      Left = 257
      Top = -1
      Width = 130
      Height = 25
      Hint = 'Mostrar desglose de todos los albaranes'
      Caption = 'Ver Desglose'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnVerDesgloseClick
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'Blueprint'
      OptionsImage.ImageIndex = 0
      OptionsImage.Images = DFactura.IFacturas
    end
    object btnOcultarDesglose: TcxButton
      Left = 386
      Top = -1
      Width = 130
      Height = 25
      Hint = 'Ocultar desglose de todos los albaranes'
      Caption = 'Ocultar Desglose'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnOcultarDesgloseClick
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'Blueprint'
      OptionsImage.ImageIndex = 3
      OptionsImage.Images = DFactura.IFacturas
    end
    object btnSeleccionar: TcxButton
      Left = -1
      Top = -1
      Width = 130
      Height = 25
      Hint = 'Seleccionar Todo'
      Caption = 'Seleccionar Todo'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnSeleccionarClick
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'Blueprint'
      OptionsImage.ImageIndex = 10
      OptionsImage.Images = DFactura.IFacturas
    end
    object btnCancelar: TcxButton
      Left = 128
      Top = -1
      Width = 130
      Height = 25
      Caption = 'Deseleccionar Todo'
      TabOrder = 3
      OnClick = btnCancelarClick
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'Blueprint'
      OptionsImage.ImageIndex = 4
      OptionsImage.Images = DFactura.IFacturas
    end
  end
  object dsQArtDesglose: TDataSource
    Left = 672
    Top = 9
  end
  object bmxBarManager: TdxBarManager
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
    ImageOptions.LargeImages = DMBaseDatos.IFacturas
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blue'
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 600
    Top = 1
    DockControlHeights = (
      0
      0
      38
      0)
    object bmxPrincipal: TdxBar
      BorderStyle = bbsNone
      Caption = 'Principal'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 1
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 306
      FloatTop = 116
      FloatClientWidth = 51
      FloatClientHeight = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxLocalizar'
        end
        item
          Visible = True
          ItemName = 'dxLimpiar'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxModificar'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxModificarGrupo'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxImprimir'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxSalir'
        end>
      OneOnRow = True
      Row = 0
      ShowMark = False
      UseOwnFont = True
      Visible = True
      WholeRow = False
    end
    object dxLocalizar: TdxBarLargeButton
      Caption = 'Localizar (F1)'
      Category = 0
      Hint = 'Localizar Albaranes'
      Visible = ivAlways
      LargeImageIndex = 9
      ShortCut = 112
      OnClick = dxLocalizarClick
      AutoGrayScale = False
      SyncImageIndex = False
      ImageIndex = 9
    end
    object dxSalir: TdxBarLargeButton
      Caption = 'Salir'
      Category = 0
      Hint = 'Salir'
      Visible = ivAlways
      LargeImageIndex = 4
      ShortCut = 27
      OnClick = dxSalirClick
      AutoGrayScale = False
    end
    object dxModificar: TdxBarLargeButton
      Caption = 'Actualizar Albaran'
      Category = 0
      Hint = 'Actualizar Desglose para el Albaran seleccionado'
      Visible = ivAlways
      LargeImageIndex = 16
      OnClick = dxModificarClick
      AutoGrayScale = False
    end
    object dxLimpiar: TdxBarLargeButton
      Caption = 'Limpiar Datos'
      Category = 0
      Hint = 'Limpiar Datos'
      Visible = ivAlways
      LargeImageIndex = 20
      ShortCut = 113
      OnClick = dxLimpiarClick
      AutoGrayScale = False
    end
    object dxModificarGrupo: TdxBarLargeButton
      Caption = 'Actualizar Grupo Alb.'
      Category = 0
      Hint = 'Actualizar Desglose para un grupo de Albaranes'
      Visible = ivAlways
      LargeImageIndex = 20
      OnClick = dxModificarGrupoClick
      AutoGrayScale = False
    end
    object dxImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
      LargeImageIndex = 2
      OnClick = dxImprimirClick
    end
  end
  object dsQSalidasL2: TDataSource
    Left = 704
    Top = 9
  end
end
