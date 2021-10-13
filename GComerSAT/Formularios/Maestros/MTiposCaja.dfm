object FMTiposCaja: TFMTiposCaja
  Left = 522
  Top = 167
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  TIPOS CAJA '
  ClientHeight = 422
  ClientWidth = 439
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
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 439
    Height = 105
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LDescripcion_m: TLabel
      Left = 24
      Top = 44
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblCodigo: TLabel
      Left = 24
      Top = 21
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblPeso: TLabel
      Left = 24
      Top = 67
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Peso'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object descripcion_tc: TBDEdit
      Left = 112
      Top = 43
      Width = 233
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 1
      DataField = 'descripcion_tc'
      DataSource = DSMaestro
    end
    object codigo_tc: TBDEdit
      Left = 112
      Top = 20
      Width = 74
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 9
      TabOrder = 0
      DataField = 'codigo_tc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object peso_tc: TBDEdit
      Left = 112
      Top = 66
      Width = 57
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 3
      MaxLength = 6
      TabOrder = 2
      DataField = 'peso_tc'
      DataSource = DSMaestro
    end
  end
  object dbgAgrupaciones: TDBGrid
    Left = 0
    Top = 105
    Width = 439
    Height = 317
    TabStop = False
    Align = alClient
    DataSource = DSMaestro
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo_tc'
        Title.Caption = 'C'#243'digo'
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion_tc'
        Title.Caption = 'Descripci'#243'n'
        Width = 262
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'peso_tc'
        Title.Alignment = taRightJustify
        Title.Caption = 'Peso'
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    DataSet = QTiposCajas
    Left = 280
    Top = 56
  end
  object ACosecheros: TActionList
    Left = 288
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QTiposCajas: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_monedas '
      'ORDER BY moneda_m, descripcion_m')
    Left = 248
    Top = 57
  end
end
