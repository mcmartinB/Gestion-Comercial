object FMarcaAnulacion: TFMarcaAnulacion
  Left = 317
  Top = 137
  Width = 900
  Height = 500
  Caption = 'Marcar / Desmarcar Facturas para Anular'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
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
    ImageOptions.LargeImages = DFactura.IFacturas
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blue'
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 584
    Top = 8
    DockControlHeights = (
      0
      0
      38
      0)
    object bmxPrincipal: TdxBar
      AllowQuickCustomizing = False
      BorderStyle = bbsNone
      Caption = 'Principal'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 267
      FloatTop = 137
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxMarcar'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxDesmarcar'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxMarcar: TdxBarLargeButton
      Caption = 'Marcar Todo'
      Category = 0
      Hint = 'Marcar Todo'
      Visible = ivAlways
      LargeImageIndex = 10
    end
    object dxDesmarcar: TdxBarLargeButton
      Caption = 'Desmarcar Todo'
      Category = 0
      Hint = 'Desmarcar Todo'
      Visible = ivAlways
      LargeImageIndex = 4
    end
  end
end
