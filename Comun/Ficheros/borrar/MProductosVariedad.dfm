object FMProductosVariedad: TFMProductosVariedad
  Left = 587
  Top = 229
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  VARIEDADES'
  ClientHeight = 370
  ClientWidth = 434
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 112
    Width = 90
    Height = 19
    AutoSize = False
    Caption = 'Categor'#237'a'
    Color = cl3DLight
    ParentColor = False
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 434
    Height = 370
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
      Left = 28
      Top = 118
      Width = 378
      Height = 3
      Style = bsRaised
    end
    object LEmpresa_p: TLabel
      Left = 40
      Top = 45
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LProducto_p: TLabel
      Left = 40
      Top = 75
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LCategoria: TLabel
      Left = 40
      Top = 136
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Variedad:'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object STEmpresa_c: TStaticText
      Left = 106
      Top = 45
      Width = 288
      Height = 21
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = 'STEmpresa_c'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object STProducto_c: TStaticText
      Left = 106
      Top = 75
      Width = 288
      Height = 21
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = 'STProducto_c'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object codigo_pv: TBDEdit
      Left = 106
      Top = 135
      Width = 24
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 2
      TabOrder = 2
      DataField = 'codigo_pv'
      DataSource = FMProductos.dsVariedad
    end
    object descripcion_pv: TBDEdit
      Left = 136
      Top = 135
      Width = 259
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 20
      TabOrder = 3
      DataField = 'descripcion_pv'
      DataSource = FMProductos.dsVariedad
    end
  end
  object gridColor: TDBGrid
    Left = 40
    Top = 172
    Width = 353
    Height = 158
    DataSource = FMProductos.dsVariedad
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
        FieldName = 'codigo_pv'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion_pv'
        Title.Caption = 'Descripci'#243'n'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 333
        Visible = True
      end>
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Top = 64
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
    end
    object ACampos: TAction
      Caption = 'Mantenimiento de Campos (F3)'
      ImageIndex = 3
      ShortCut = 114
    end
  end
end
