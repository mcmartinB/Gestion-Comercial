object FMAgrupacionesEnvase: TFMAgrupacionesEnvase
  Left = 455
  Top = 283
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  AGRUPACIONES ARTICULO'
  ClientHeight = 356
  ClientWidth = 695
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
  object pnlIzq: TPanel
    Left = 0
    Top = 0
    Width = 281
    Height = 356
    Align = alLeft
    TabOrder = 0
    object PMaestro: TPanel
      Left = 1
      Top = 1
      Width = 279
      Height = 81
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
      object agrupacion_ae: TBDEdit
        Left = 112
        Top = 26
        Width = 113
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 10
        TabOrder = 0
        DataField = 'agrupacion_ae'
        DataSource = DSMaestro
      end
    end
    object dbgAgrupaciones: TDBGrid
      Left = 1
      Top = 82
      Width = 279
      Height = 273
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
          FieldName = 'agrupacion_ae'
          Title.Caption = 'Agrupac'#243'n Art'#237'culo'
          Width = 226
          Visible = True
        end>
    end
  end
  object pgcCostes: TPageControl
    Left = 281
    Top = 0
    Width = 414
    Height = 356
    ActivePage = tsCosProducto
    Align = alClient
    TabOrder = 1
    object tsCosProducto: TTabSheet
      Caption = 'Costes Producto'
      ImageIndex = 1
      object dbgrdCostes: TDBGrid
        Left = 0
        Top = 43
        Width = 406
        Height = 285
        TabStop = False
        Align = alBottom
        DataSource = dsCostesProducto
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object btnCostes: TButton
        Left = 326
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Costes'
        TabOrder = 1
        OnClick = btnCostesClick
      end
    end
  end
  object DSMaestro: TDataSource
    DataSet = QAgrupaciones
    Left = 216
    Top = 8
  end
  object ACosecheros: TActionList
    Left = 240
    Top = 48
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QAgrupaciones: TQuery
    AfterOpen = QAgrupacionesAfterOpen
    BeforeClose = QAgrupacionesBeforeClose
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_monedas '
      'ORDER BY moneda_m, descripcion_m')
    Left = 184
    Top = 9
  end
  object qryCostesProducto: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT * FROM frf_monedas '
      'ORDER BY moneda_m, descripcion_m')
    Left = 304
    Top = 145
  end
  object dsCostesProducto: TDataSource
    DataSet = qryCostesProducto
    Left = 336
    Top = 146
  end
end
