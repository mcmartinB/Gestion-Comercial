object FLupas: TFLupas
  Left = 321
  Top = 71
  Caption = 'B'#250'squeda'
  ClientHeight = 444
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 26
    Width = 439
    Height = 398
    Align = alClient
    TabOrder = 1
    OnEnter = cxGridEnter
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Foggy'
    object tvGridLupa: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      OnCellDblClick = tvGridLupaCellDblClick
      DataController.DataSource = DS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Images = DFactura.IFacturas
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ShowEditButtons = gsebAlways
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.ShowColumnFilterButtons = sfbAlways
    end
    object lvGrid1Level1: TcxGridLevel
      GridView = tvGridLupa
    end
  end
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 424
    Width = 439
    Height = 20
    Panels = <>
    PaintStyle = stpsUseLookAndFeel
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Foggy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
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
    ImageOptions.Images = DFactura.IFacturas
    ImageOptions.LargeImages = DFactura.IFacturas2
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blue'
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 384
    Top = 8
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManager1Bar1: TdxBar
      AllowQuickCustomizing = False
      Caption = 'Botones'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1976
      FloatTop = 286
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxAceptar'
        end
        item
          Visible = True
          ItemName = 'dxCancelar'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxAceptar: TdxBarButton
      Caption = 'Aceptar'
      Category = 0
      Hint = 'Aceptar'
      Visible = ivAlways
      ImageIndex = 10
      ShortCut = 112
      OnClick = dxAceptarClick
    end
    object dxCancelar: TdxBarButton
      Caption = 'Cancelar'
      Category = 0
      Hint = 'Cancelar'
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 27
      OnClick = dxCancelarClick
    end
  end
  object DS: TDataSource
    DataSet = QBusqueda
    Left = 328
    Top = 10
  end
  object QBusqueda: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * from frf_empresas')
    Left = 295
    Top = 10
  end
end
