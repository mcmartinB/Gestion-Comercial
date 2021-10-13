object FMFederaciones: TFMFederaciones
  Left = 318
  Top = 220
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    FEDERACIONES'
  ClientHeight = 185
  ClientWidth = 352
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
    Width = 352
    Height = 185
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
      Left = 68
      Top = 67
      Width = 76
      Height = 19
      AutoSize = False
      Caption = ' Federación'
      Color = cl3DLight
      ParentColor = False
    end
    object LEmpresa_p: TLabel
      Left = 68
      Top = 91
      Width = 76
      Height = 19
      AutoSize = False
      Caption = ' Descripción'
      Color = cl3DLight
      ParentColor = False
    end
    object codigo_f: TBDEdit
      Left = 154
      Top = 66
      Width = 17
      Height = 21
      ColorEdit = 12639424
      MaxLength = 1
      TabOrder = 1
      DataField = 'codigo_f'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object provincia_f: TBDEdit
      Tag = 1
      Left = 153
      Top = 90
      Width = 109
      Height = 21
      ColorEdit = 12639424
      MaxLength = 10
      TabOrder = 0
      DataField = 'provincia_f'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
  end
  object DSMaestro: TDataSource
    DataSet = QFederaciones
    Left = 72
    Top = 8
  end
  object QFederaciones: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * from frf_federaciones')
    Left = 48
  end
end
