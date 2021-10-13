object FDReclamaFotos: TFDReclamaFotos
  Left = 216
  Top = 180
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'FOTOS DE LA RECLAMACI'#211'N'
  ClientHeight = 434
  ClientWidth = 662
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 662
    Height = 29
    Caption = 'ToolBar1'
    Images = DMBaseDatos.ImgBarraHerramientas
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton1'
      ImageIndex = 1
      OnClick = ToolButton1Click
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 2
      Caption = 'ToolButton2'
      ImageIndex = 2
      OnClick = ToolButton2Click
    end
    object ToolButton6: TToolButton
      Left = 46
      Top = 2
      Width = 591
      Caption = 'ToolButton6'
      ImageIndex = 19
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 637
      Top = 2
      Caption = 'ToolButton4'
      ImageIndex = 18
      OnClick = ToolButton4Click
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 415
    Width = 662
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 29
    Width = 662
    Height = 386
    Align = alClient
    TabOrder = 2
    object Image: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      AutoSize = True
    end
  end
  object DataSource1: TDataSource
    DataSet = DMWEB.QReclamaFotos
    Left = 184
    Top = 72
  end
end
