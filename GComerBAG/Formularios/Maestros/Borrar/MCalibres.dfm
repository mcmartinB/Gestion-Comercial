object FMCalibre: TFMCalibre
  Left = 250
  Top = 166
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  CALIBRES'
  ClientHeight = 345
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 37
    Top = 75
    Width = 90
    Height = 19
    AutoSize = False
    Caption = 'Empresa'
    Color = cl3DLight
    ParentColor = False
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 385
    Height = 345
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 26
      Top = 123
      Width = 331
      Height = 3
      Style = bsRaised
    end
    object LCalibre: TLabel
      Left = 135
      Top = 151
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' Calibre:'
      Color = cl3DLight
      ParentColor = False
    end
    object Lproducto: TLabel
      Left = 37
      Top = 67
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEmpresa_p: TLabel
      Left = 37
      Top = 43
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object STEmpresa_c: TStaticText
      Left = 120
      Top = 44
      Width = 225
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object STProducto_c: TStaticText
      Left = 120
      Top = 68
      Width = 225
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object calibre_c: TBDEdit
      Left = 204
      Top = 150
      Width = 85
      Height = 21
      Hint = 'Introduzca el c'#243'digo del calibre.'
      ColorEdit = clMoneyGreen
      CharCase = ecNormal
      MaxLength = 10
      TabOrder = 2
      DataField = 'calibre_c'
      DataSource = FMProductos.DSSize
    end
  end
  object gridCalibre: TDBGrid
    Left = 77
    Top = 184
    Width = 241
    Height = 118
    DataSource = FMProductos.DSSize
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = [dgTitles, dgIndicator, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'calibre_c'
        Title.Alignment = taCenter
        Title.Caption = 'Calibre'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 210
        Visible = True
      end>
  end
end
