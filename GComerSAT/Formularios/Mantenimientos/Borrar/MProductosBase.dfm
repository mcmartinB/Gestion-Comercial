object FMProductosBase: TFMProductosBase
  Left = 331
  Top = 200
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '   PRODUCTO BASE'
  ClientHeight = 272
  ClientWidth = 402
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeydown
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
    Width = 402
    Height = 128
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LPlantacion_p: TLabel
      Left = 35
      Top = 55
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEmpresa_p: TLabel
      Left = 35
      Top = 81
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 35
      Top = 29
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object producto_base_pb: TBDEdit
      Left = 98
      Top = 54
      Width = 21
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 2
      TabOrder = 1
      DataField = 'producto_base_pb'
      DataSource = DMBaseDatos.DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_pb: TBDEdit
      Tag = 1
      Left = 98
      Top = 80
      Width = 246
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 2
      DataField = 'descripcion_pb'
      DataSource = DMBaseDatos.DSMaestro
    end
    object empresa_pb: TBDEdit
      Left = 98
      Top = 28
      Width = 31
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'empresa_pb'
      DataSource = DMBaseDatos.DSMaestro
      Modificable = False
      PrimaryKey = True
    end
  end
  object PGrid: TPanel
    Left = 0
    Top = 128
    Width = 402
    Height = 144
    Align = alBottom
    TabOrder = 1
    object DBGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 400
      Height = 142
      TabStop = False
      Align = alClient
      DataSource = DSGrid
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'empresa'
          Title.Alignment = taCenter
          Title.Caption = 'EMPRESA'
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'producto'
          Title.Alignment = taCenter
          Title.Caption = 'PRODUCTO'
          Width = 74
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descripcion'
          Title.Alignment = taCenter
          Title.Caption = 'DESCRIPCION'
          Width = 210
          Visible = True
        end>
    end
  end
  object QGrid: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DMBaseDatos.DSMaestro
    SQL.Strings = (
      
        'select empresa_p Empresa, producto_p Producto, descripcion_p Des' +
        'cripcion'
      'from frf_productos '
      'order by empresa_p, producto_p')
    Left = 256
    Top = 16
  end
  object DSGrid: TDataSource
    DataSet = QGrid
    Left = 296
    Top = 16
  end
end
