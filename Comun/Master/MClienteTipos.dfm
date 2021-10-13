object FMClienteTipos: TFMClienteTipos
  Left = 572
  Top = 344
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = ' TIPOS DE CLIENTE'
  ClientHeight = 114
  ClientWidth = 576
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
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
    Width = 576
    Height = 114
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LCodigo_fp: TLabel
      Left = 40
      Top = 30
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LDescripcion_fp: TLabel
      Left = 40
      Top = 55
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object codigo_ctp: TBDEdit
      Left = 138
      Top = 29
      Width = 31
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 0
      DataField = 'codigo_ctp'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_ctp: TBDEdit
      Tag = 1
      Left = 138
      Top = 54
      Width = 383
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 55
      TabOrder = 1
      DataField = 'descripcion_ctp'
      DataSource = DSMaestro
    end
  end
  object DSMaestro: TDataSource
    DataSet = qryClienteTipos
    Left = 40
    Top = 80
  end
  object qryClienteTipos: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_forma_pago'
      'ORDER BY  codigo_fp')
    Left = 8
    Top = 8
  end
end
