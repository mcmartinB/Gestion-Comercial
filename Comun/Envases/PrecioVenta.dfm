object FPrecioVenta: TFPrecioVenta
  Left = 257
  Top = 55
  BorderIcons = []
  ClientHeight = 641
  ClientWidth = 764
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
    Width = 764
    Height = 163
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object gbCriterios: TcxGroupBox
      Left = 19
      Top = 13
      Caption = 'Selecci'#243'n de Precios Venta'
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
      Height = 132
      Width = 957
      object stCliente: TnbStaticText
        Left = 237
        Top = 57
        Width = 225
        Height = 19
        About = 'NB 0.1/20020725'
      end
      object stArticulo: TnbStaticText
        Left = 237
        Top = 84
        Width = 225
        Height = 19
        About = 'NB 0.1/20020725'
      end
      object lbEmpresa: TcxLabel
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
      object lbCliente: TcxLabel
        Left = 6
        Top = 57
        AutoSize = False
        Caption = 'Cliente '
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 80
        AnchorX = 86
      end
      object lbImporteNeto: TcxLabel
        Left = 7
        Top = 83
        AutoSize = False
        Caption = 'Art'#237'culo '
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 80
        AnchorX = 87
      end
      object lbFecConta: TcxLabel
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
        TabOrder = 4
        Width = 121
      end
      object cxFechaFin: TcxDateEdit
        Left = 341
        Top = 30
        TabOrder = 5
        Width = 121
      end
      object cxCliente: TcxTextEdit
        Left = 92
        Top = 56
        Properties.CharCase = ecUpperCase
        Properties.OnChange = cxClientePropertiesChange
        TabOrder = 6
        Width = 121
      end
      object cxArticulo: TcxTextEdit
        Left = 92
        Top = 82
        Properties.CharCase = ecUpperCase
        Properties.OnChange = cxArticuloPropertiesChange
        TabOrder = 7
        OnExit = cxArticuloExit
        Width = 121
      end
      object ssArticulo: TSimpleSearch
        Left = 214
        Top = 82
        Width = 21
        Height = 21
        TabOrder = 8
        TabStop = False
        LookAndFeel.NativeStyle = False
        LookAndFeel.SkinName = 'MoneyTwins'
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = FDM.ilxImagenes
        Titulo = 'Busqueda de Art'#237'culos'
        Tabla = 'frf_articulos'
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
    end
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 225
    Width = 764
    Height = 416
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Foggy'
    object tvPrecioVenta: TcxGridDBTableView
      OnDblClick = tvPrecioVentaDblClick
      Navigator.Buttons.CustomButtons = <>
      DataController.DataModeController.SmartRefresh = True
      DataController.DataSource = dsQPrecioVenta
      DataController.KeyFieldNames = 'fecha_pv;cliente_pv;envase_pv'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
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
        Width = 30
      end
      object tvFecha: TcxGridDBColumn
        Caption = 'Fecha'
        DataBinding.FieldName = 'fecha_pv'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 100
      end
      object tvCliente: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'cliente_pv'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.MaxLength = 3
        HeaderGlyphAlignmentHorz = taCenter
        MinWidth = 30
        Options.Editing = False
        Width = 64
      end
      object tvDesCliente: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.ValueType = 'String'
        OnGetDisplayText = tvDesClienteGetDisplayText
        Options.Editing = False
        Width = 200
      end
      object tvArticulo: TcxGridDBColumn
        Caption = 'Art'#237'culo'
        DataBinding.FieldName = 'envase_pv'
        PropertiesClassName = 'TcxTextEditProperties'
      end
      object tvDesArticulo: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.ValueType = 'String'
        OnGetDisplayText = tvDesArticuloGetDisplayText
        Options.Editing = False
        Width = 200
      end
      object tvPrecio: TcxGridDBColumn
        Caption = 'Precio Venta'
        DataBinding.FieldName = 'precio_pv'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object tvUnidadPrecio: TcxGridDBColumn
        Caption = 'Und/Pre'
        DataBinding.FieldName = 'unidad_precio_pv'
        PropertiesClassName = 'TcxTextEditProperties'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object tvMoneda: TcxGridDBColumn
        Caption = 'Moneda'
        DataBinding.FieldName = 'moneda_pv'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.MaxLength = 3
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Width = 50
      end
    end
    object lvPrecioVenta: TcxGridLevel
      GridView = tvPrecioVenta
    end
  end
  object cxTabControl: TcxTabControl
    Left = 0
    Top = 201
    Width = 764
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
    ClientRectRight = 763
    ClientRectTop = 1
    object btnSeleccionar: TcxButton
      Left = 3
      Top = -1
      Width = 130
      Height = 25
      Hint = 'Seleccionar Todo'
      Caption = 'Seleccionar Todo'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnSeleccionarClick
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'Blueprint'
      OptionsImage.ImageIndex = 10
      OptionsImage.Images = DFactura.IFacturas
    end
    object btnCancelar: TcxButton
      Left = 132
      Top = -1
      Width = 130
      Height = 25
      Caption = 'Deseleccionar Todo'
      TabOrder = 1
      OnClick = btnCancelarClick
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'Blueprint'
      OptionsImage.ImageIndex = 4
      OptionsImage.Images = DFactura.IFacturas
    end
  end
  object ssCliente: TSimpleSearch
    Left = 233
    Top = 113
    Width = 21
    Height = 21
    TabOrder = 7
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
    CampoResultado = 'cliente_c'
    Enlace = cxCliente
    Tecla = 'F2'
    Concatenar = False
  end
  object dsQPrecioVenta: TDataSource
    Left = 696
    Top = 1
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
    ImageOptions.Images = DFactura.IFacturas
    ImageOptions.LargeImages = DFactura.IFacturas
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
          BeginGroup = True
          Visible = True
          ItemName = 'dxAlta'
        end
        item
          Visible = True
          ItemName = 'dxBaja'
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
      Hint = 'Localizar Facturas'
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
    object dxAlta: TdxBarLargeButton
      Caption = 'Alta Precios'
      Category = 0
      Hint = 'Alta Precios'
      Visible = ivAlways
      LargeImageIndex = 12
      OnClick = dxAltaClick
      AutoGrayScale = False
    end
    object dxBaja: TdxBarLargeButton
      Caption = 'Baja Precios'
      Category = 0
      Hint = 'Baja Precios'
      Visible = ivAlways
      LargeImageIndex = 13
      OnClick = dxBajaClick
      AutoGrayScale = False
    end
  end
end
