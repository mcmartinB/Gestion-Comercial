object FConsultaRem: TFConsultaRem
  Left = 286
  Top = 86
  BorderIcons = []
  BorderStyle = bsSizeToolWin
  Caption = 'Selecci'#243'n de Remesa'
  ClientHeight = 400
  ClientWidth = 845
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 38
    Width = 845
    Height = 362
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Foggy'
    object tvRemesas: TcxGridDBTableView
      OnDblClick = tvRemesasDblClick
      Navigator.Buttons.CustomButtons = <>
      DataController.DataModeController.SmartRefresh = True
      DataController.DataSource = ds
      DataController.KeyFieldNames = 'empresa_remesa_rc;n_remesa_rc'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object tvEmpresa: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'empresa_remesa_rc'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.MaxLength = 3
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.Editing = False
        Width = 50
      end
      object tvCliente: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'cod_cliente_rc'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.MaxLength = 3
        HeaderGlyphAlignmentHorz = taCenter
        MinWidth = 30
        Options.Editing = False
        Width = 30
      end
      object tvDesCliente: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'desCliente'
        PropertiesClassName = 'TcxTextEditProperties'
        Options.Editing = False
      end
      object tvBanco: TcxGridDBColumn
        Caption = 'Banco'
        DataBinding.FieldName = 'cod_banco_rc'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.MaxLength = 15
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 40
      end
      object tvDesBanco: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'desBanco'
        PropertiesClassName = 'TcxTextEditProperties'
        Options.Editing = False
      end
      object tvRemesa: TcxGridDBColumn
        Caption = 'Remesa'
        DataBinding.FieldName = 'n_remesa_rc'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 100
      end
      object tvFecVto: TcxGridDBColumn
        Caption = 'Fecha Vencimiento'
        DataBinding.FieldName = 'fecha_vencimiento_rc'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Editing = False
        Width = 105
      end
      object tvFecDes: TcxGridDBColumn
        Caption = 'Fecha Descuento'
        DataBinding.FieldName = 'fecha_descuento_rc'
        PropertiesClassName = 'TcxDateEditProperties'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Editing = False
        Width = 100
      end
      object tvImporteTotal: TcxGridDBColumn
        Caption = 'Importe Remesa '
        DataBinding.FieldName = 'importe_cobro_rc'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Editing = False
        Width = 100
      end
      object tvImporteFacturas: TcxGridDBColumn
        Caption = 'Importe Facturas'
        DataBinding.FieldName = 'importeFacturas'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 100
      end
    end
    object lvRemesas: TcxGridLevel
      GridView = tvRemesas
    end
  end
  object ds: TDataSource
    Left = 531
    Top = 8
  end
  object bmx1: TdxBarManager
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
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blue'
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 491
    Top = 8
    DockControlHeights = (
      0
      0
      38
      0)
    object bmx1Bar1: TdxBar
      AllowQuickCustomizing = False
      BorderStyle = bbsNone
      Caption = 'Principal'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 270
      FloatTop = 124
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxAceptar'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxCancelar'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxAceptar: TdxBarLargeButton
      Caption = 'Aceptar'
      Category = 0
      Hint = 'Aceptar'
      Visible = ivAlways
      LargeImageIndex = 10
      OnClick = dxAceptarClick
    end
    object dxCancelar: TdxBarLargeButton
      Caption = 'Cancelar'
      Category = 0
      Hint = 'Cancelar'
      Visible = ivAlways
      LargeImageIndex = 4
      OnClick = dxCancelarClick
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
