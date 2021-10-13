object FConsultaExpertaRem: TFConsultaExpertaRem
  Left = 283
  Top = 113
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Consulta Experta'
  ClientHeight = 344
  ClientWidth = 347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object cxEmpresa: TcxLabel
    Left = 68
    Top = 58
    AutoSize = False
    Caption = 'Empresa'
    ParentColor = False
    Style.BorderStyle = ebsNone
    Style.Color = clBtnFace
    Properties.Alignment.Horz = taRightJustify
    Height = 17
    Width = 50
    AnchorX = 118
  end
  object cx5: TcxLabel
    Left = 49
    Top = 107
    AutoSize = False
    Caption = 'Num. Remesa'
    Properties.Alignment.Horz = taRightJustify
    Height = 17
    Width = 70
    AnchorX = 119
  end
  object txEmpresa: TcxTextEdit
    Left = 120
    Top = 56
    TabOrder = 1
    Width = 121
  end
  object txNumRemesa: TcxTextEdit
    Left = 120
    Top = 104
    TabOrder = 4
    Width = 121
  end
  object lb1: TcxLabel
    Left = 68
    Top = 83
    AutoSize = False
    Caption = 'Cliente'
    Properties.Alignment.Horz = taRightJustify
    Height = 17
    Width = 50
    AnchorX = 118
  end
  object txCliente: TcxTextEdit
    Left = 120
    Top = 80
    TabOrder = 2
    Width = 121
  end
  object cxLabel1: TcxLabel
    Left = 28
    Top = 131
    AutoSize = False
    Caption = 'Fec. Vencimiento'
    Properties.Alignment.Horz = taRightJustify
    Height = 17
    Width = 90
    AnchorX = 118
  end
  object txFecVto: TcxTextEdit
    Left = 120
    Top = 128
    TabOrder = 8
    Width = 121
  end
  object cxLabel2: TcxLabel
    Left = 28
    Top = 155
    AutoSize = False
    Caption = 'Fec. Descuento'
    Properties.Alignment.Horz = taRightJustify
    Height = 17
    Width = 90
    AnchorX = 118
  end
  object txFecDes: TcxTextEdit
    Left = 120
    Top = 152
    TabOrder = 10
    Width = 121
  end
  object cxLabel3: TcxLabel
    Left = 28
    Top = 179
    AutoSize = False
    Caption = 'Banco'
    Properties.Alignment.Horz = taRightJustify
    Height = 17
    Width = 90
    AnchorX = 118
  end
  object txBanco: TcxTextEdit
    Left = 120
    Top = 176
    TabOrder = 15
    Width = 121
  end
  object dxBarManager: TdxBarManager
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
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blue'
    PopupMenuLinks = <>
    ShowShortCutInHint = True
    UseSystemFont = True
    Left = 304
    Top = 8
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Herramientas'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1910
      FloatTop = 207
      FloatClientWidth = 51
      FloatClientHeight = 24
      Images = DFactura.IFacturas
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
      ShowMark = False
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
      PaintStyle = psCaptionInMenu
      OnClick = dxAceptarClick
    end
    object dxCancelar: TdxBarButton
      Caption = 'Cancelar'
      Category = 0
      Hint = 'Cancelar'
      Visible = ivAlways
      ImageIndex = 4
      PaintStyle = psCaptionInMenu
      OnClick = dxCancelarClick
    end
  end
end
