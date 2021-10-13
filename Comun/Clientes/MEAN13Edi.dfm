object FMEAN13Edi: TFMEAN13Edi
  Left = 418
  Top = 269
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    C'#211'DIGOS FACTURACI'#211'N EDI'
  ClientHeight = 617
  ClientWidth = 914
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
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RejillaFlotante: TBGrid
    Left = 487
    Top = 8
    Width = 137
    Height = 25
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object pnlConsulta: TPanel
    Left = 0
    Top = 38
    Width = 914
    Height = 109
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 1
    OnEnter = pnlConsultaEnter
    object gbCriterios: TcxGroupBox
      Left = 19
      Top = 13
      Caption = 'Selecci'#243'n Cliente'
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
      Height = 84
      Width = 957
      object stCliente: TnbStaticText
        Left = 168
        Top = 34
        Width = 225
        Height = 19
        About = 'NB 0.1/20020725'
      end
      object cxLabel1: TcxLabel
        Left = 6
        Top = 34
        AutoSize = False
        Caption = 'Cliente '
        Properties.Alignment.Horz = taRightJustify
        Height = 17
        Width = 80
        AnchorX = 86
      end
      object edtCliente: TcxTextEdit
        Left = 92
        Top = 33
        Properties.CharCase = ecUpperCase
        Properties.MaxLength = 3
        Properties.OnChange = edtClientePropertiesChange
        TabOrder = 0
        Width = 51
      end
      object ssCliente: TSimpleSearch
        Left = 145
        Top = 33
        Width = 21
        Height = 21
        TabOrder = 1
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
        Enlace = edtCliente
        Tecla = '<Ninguna>'
        Concatenar = False
      end
    end
  end
  object pnlDatos: TPanel
    Left = 0
    Top = 147
    Width = 914
    Height = 470
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlDatos'
    TabOrder = 4
    object dbgDetalle: TDBGrid
      Left = 0
      Top = 0
      Width = 914
      Height = 470
      Align = alClient
      DataSource = DS
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = dbgDetalleDblClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'envase_ee'
          Title.Alignment = taCenter
          Title.Caption = 'Articulo'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'calProductoCod'
          Title.Alignment = taCenter
          Title.Caption = 'Producto'
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descripcion_ee'
          Title.Alignment = taCenter
          Title.Caption = 'Descripci'#243'n'
          Width = 243
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'empresa_ee'
          Title.Alignment = taCenter
          Title.Caption = 'Empresa'
          Width = 52
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'centro_ee'
          Title.Alignment = taCenter
          Title.Caption = 'Centro'
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'calCentroDes'
          Title.Alignment = taCenter
          Title.Caption = 'Centro'
          Width = 142
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ean13_ee'
          Title.Alignment = taCenter
          Title.Caption = 'EAN13'
          Width = 89
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dun14_ee'
          Title.Alignment = taCenter
          Title.Caption = 'DUN14'
          Width = 89
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'comercial_ee'
          Title.Alignment = taCenter
          Title.Caption = 'Comercial'
          Width = 56
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'calComercialDes'
          Title.Alignment = taCenter
          Title.Caption = 'Comercial'
          Width = 217
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha_baja_ee'
          Title.Alignment = taCenter
          Title.Caption = 'Fecha baja'
          Width = 72
          Visible = True
        end>
    end
  end
  object DS: TDataSource
    Left = 6
    Top = 167
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
    Left = 239
    Top = 6
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
      Caption = 'Alta'
      Category = 0
      Hint = 'Alta'
      Visible = ivAlways
      LargeImageIndex = 12
      OnClick = dxAltaClick
      AutoGrayScale = False
    end
    object dxBaja: TdxBarLargeButton
      Caption = 'Baja'
      Category = 0
      Hint = 'Baja'
      Visible = ivAlways
      LargeImageIndex = 13
      OnClick = dxBajaClick
      AutoGrayScale = False
    end
  end
end
