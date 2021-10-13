object FMAgrupacionesGasto: TFMAgrupacionesGasto
  Left = 723
  Top = 341
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  AGRUPACIONES GASTO'
  ClientHeight = 353
  ClientWidth = 281
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
    Width = 281
    Height = 73
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
      Top = 27
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object agrupacion_ag: TBDEdit
      Left = 112
      Top = 26
      Width = 113
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 10
      TabOrder = 0
      DataField = 'agrupacion_ag'
      DataSource = DSMaestro
    end
  end
  object dbgAgrupaciones: TDBGrid
    Left = 0
    Top = 73
    Width = 281
    Height = 280
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
        FieldName = 'agrupacion_ag'
        Title.Caption = 'Agrupac'#243'n Envase'
        Width = 226
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    DataSet = QAgrupaciones
    Left = 216
    Top = 8
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
  object QAgrupaciones: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_monedas '
      'ORDER BY moneda_m, descripcion_m')
    Left = 184
    Top = 9
  end
end
