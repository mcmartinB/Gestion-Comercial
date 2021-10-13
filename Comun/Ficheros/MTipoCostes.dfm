object FMTipoCostes: TFMTipoCostes
  Left = 738
  Top = 266
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  TIPO DE COSTES PROVEEDOR'
  ClientHeight = 177
  ClientWidth = 494
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
    Width = 494
    Height = 177
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 427
    ExplicitHeight = 243
    object LCodigo_tp: TLabel
      Left = 40
      Top = 39
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LDescripcion_tp: TLabel
      Left = 40
      Top = 62
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre12: TLabel
      Left = 218
      Top = 107
      Width = 201
      Height = 19
      AutoSize = False
      Caption = '(Marcado Ayuda -- Desmarcado Coste)'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEsPlastico: TLabel
      Left = 40
      Top = 107
      Width = 108
      Height = 19
      AutoSize = False
      Caption = 'Ayuda'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object codigo_tc: TBDEdit
      Left = 156
      Top = 39
      Width = 31
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 0
      DataField = 'codigo_tc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_tc: TBDEdit
      Tag = 1
      Left = 156
      Top = 62
      Width = 300
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 1
      DataField = 'descripcion_tc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object es_ayuda_tc: TDBCheckBox
      Left = 154
      Top = 109
      Width = 59
      Height = 17
      DataField = 'es_ayuda_tc'
      DataSource = DSMaestro
      TabOrder = 2
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = es_ayuda_tcClick
    end
  end
  object DSMaestro: TDataSource
    DataSet = QTipoCostes
    Left = 56
    Top = 8
  end
  object QTipoCostes: TQuery
    AfterOpen = QTipoCostesAfterOpen
    AfterScroll = QTipoCostesAfterScroll
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_tipo_costes'
      'ORDER BY codigo_tc')
    Left = 24
    Top = 8
  end
end
