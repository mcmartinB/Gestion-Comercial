object FMTipoVia: TFMTipoVia
  Left = 119
  Top = 138
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  TIPOS DE V'#205'A'
  ClientHeight = 138
  ClientWidth = 407
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 407
    Height = 138
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 43
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Tipo V'#237'a'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 40
      Top = 74
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object descripcion_v: TBDEdit
      Left = 133
      Top = 73
      Width = 233
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 1
      DataField = 'descripcion_v'
      DataSource = DSMaestro
    end
    object via_v: TBDEdit
      Left = 133
      Top = 43
      Width = 39
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 2
      TabOrder = 0
      DataField = 'via_v'
      DataSource = DSMaestro
    end
  end
  object DSMaestro: TDataSource
    DataSet = QTipoVias
    Left = 56
    Top = 8
  end
  object QTipoVias: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_vias '
      'ORDER BY via_v')
    Left = 24
    Top = 8
  end
end
