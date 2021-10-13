object FMProvincias: TFMProvincias
  Left = 305
  Top = 194
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  PROVINCIAS'
  ClientHeight = 140
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
    Height = 140
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
      Left = 40
      Top = 45
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEmpresa_p: TLabel
      Left = 40
      Top = 75
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Provincia'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object codigo_p: TBDEdit
      Left = 119
      Top = 44
      Width = 58
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 2
      TabOrder = 0
      DataField = 'codigo_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object nombre_p: TBDEdit
      Tag = 1
      Left = 119
      Top = 74
      Width = 246
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 1
      DataField = 'nombre_p'
      DataSource = DSMaestro
    end
  end
  object DSMaestro: TDataSource
    DataSet = QProvincias
    Left = 32
    Top = 8
  end
  object QProvincias: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT codigo_p, nombre_p'
      'FROM frf_provincias Frf_provincias'
      'ORDER BY codigo_p')
    Left = 8
    Top = 9
    Data = {464D50616C6574735665}
  end
end
