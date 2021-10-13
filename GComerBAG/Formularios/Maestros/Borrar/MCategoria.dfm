object FMCategoria: TFMCategoria
  Left = 242
  Top = 111
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  CATEGORÍAS '
  ClientHeight = 386
  ClientWidth = 448
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
    Caption = 'Categoría'
    Color = cl3DLight
    ParentColor = False
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 448
    Height = 386
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
      Left = 38
      Top = 115
      Width = 376
      Height = 3
      Style = bsRaised
    end
    object LEmpresa_p: TLabel
      Left = 40
      Top = 45
      Width = 69
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LProducto_p: TLabel
      Left = 40
      Top = 74
      Width = 69
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LCategoria: TLabel
      Left = 40
      Top = 139
      Width = 69
      Height = 19
      AutoSize = False
      Caption = ' Categoría'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object STEmpresa_c: TStaticText
      Left = 120
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
      Left = 120
      Top = 74
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
    object descripcion_c: TBDEdit
      Left = 145
      Top = 138
      Width = 263
      Height = 21
      ColorEdit = 12639424
      MaxLength = 10
      TabOrder = 3
      DataField = 'descripcion_c'
      DataSource = FMProductos.DSCategory
    end
    object categoria_c: TBDEdit
      Left = 119
      Top = 138
      Width = 24
      Height = 21
      ColorEdit = 12639424
      MaxLength = 2
      TabOrder = 2
      DataField = 'categoria_c'
      DataSource = FMProductos.DSCategory
    end
  end
  object DBGrid1: TDBGrid
    Left = 44
    Top = 180
    Width = 365
    Height = 158
    DataSource = FMProductos.DSCategory
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
        FieldName = 'categoria_c'
        Title.Alignment = taCenter
        Title.Caption = 'Categoría'
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
        FieldName = 'descripcion_c'
        Title.Caption = 'Descripción'
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
