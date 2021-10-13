object FBusFacturas: TFBusFacturas
  Left = 371
  Top = 98
  BorderIcons = []
  BorderStyle = bsSizeToolWin
  Caption = 'B'#250'squeda de Facturas para Remesar'
  ClientHeight = 392
  ClientWidth = 751
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 38
    Width = 751
    Height = 354
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Foggy'
    object tvFacturas: TcxGridDBTableView
      OnDblClick = tvFacturasDblClick
      Navigator.Buttons.CustomButtons = <>
      DataController.DataModeController.SmartRefresh = True
      DataController.DataSource = DS
      DataController.KeyFieldNames = 'cod_factura_fc'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object tvCodEmpresa: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'cod_empresa_fac_fc'
        FooterAlignmentHorz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Editing = False
      end
      object tvCliente: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'cod_cliente_fc'
        MinWidth = 60
        Width = 60
      end
      object tvCodFactura: TcxGridDBColumn
        Caption = 'C'#243'digo Factura'
        DataBinding.FieldName = 'cod_factura_fc'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 0
        SortOrder = soDescending
        Width = 100
      end
      object tvTipo: TcxGridDBColumn
        DataBinding.FieldName = 'tipo_factura_fc'
        Visible = False
        Options.Editing = False
        IsCaptionAssigned = True
      end
      object tvAnulacion: TcxGridDBColumn
        DataBinding.FieldName = 'anulacion_fc'
        Visible = False
        Options.Editing = False
        IsCaptionAssigned = True
      end
      object tvTipoFactura: TcxGridDBColumn
        Caption = 'Tipo Factura'
        DataBinding.ValueType = 'String'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = tvTipoFacturaGetDisplayText
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
      end
      object tvNumeroFactura: TcxGridDBColumn
        Caption = 'Numero Factura'
        DataBinding.FieldName = 'n_factura_fc'
        PropertiesClassName = 'TcxTextEditProperties'
        Options.Editing = False
      end
      object tvFechaFactura: TcxGridDBColumn
        Caption = 'Fecha Factura'
        DataBinding.FieldName = 'fecha_factura_fc'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 100
      end
      object tvImporteFactura: TcxGridDBColumn
        Caption = 'Importe Factura'
        DataBinding.FieldName = 'importe_total_fc'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 100
      end
      object tvImporteCobrado: TcxGridDBColumn
        Caption = 'Importe Cobrado'
        DataBinding.ValueType = 'Currency'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 100
      end
      object tvImportePdte: TcxGridDBColumn
        Caption = 'Importe Pendiente'
        DataBinding.ValueType = 'Currency'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 100
      end
    end
    object lvFacturas: TcxGridLevel
      GridView = tvFacturas
    end
  end
  object DS: TDataSource
    Left = 384
    Top = 8
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
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blue'
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 432
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
      FloatLeft = 339
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
      SyncImageIndex = False
      ImageIndex = 4
    end
  end
end
