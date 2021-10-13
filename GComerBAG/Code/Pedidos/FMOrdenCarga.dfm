object frmOrdenCarga: TfrmOrdenCarga
  Left = 442
  Top = 192
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = '  BANCOS'
  ClientHeight = 503
  ClientWidth = 837
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  Visible = True
  OnActivate = FormActivate
  OnCanResize = FormCanResize
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
    Width = 837
    Height = 503
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object BGrid1: TBGrid
    Left = 406
    Top = 13
    Width = 50
    Height = 25
    Color = clInfoBk
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object DSMaestro: TDataSource
    DataSet = QBancos
    OnDataChange = DSMaestroDataChange
    Left = 48
    Top = 8
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 352
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QBancos: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_bancos'
      'order by empresa_b,banco_b')
    Left = 16
    Top = 9
    object QBancosempresa_b: TStringField
      FieldName = 'empresa_b'
      Origin = 'frf_bancos.empresa_b'
      Size = 3
    end
    object QBancosbanco_b: TStringField
      FieldName = 'banco_b'
      Origin = 'frf_bancos.banco_b'
      Size = 3
    end
    object QBancosdescripcion_b: TStringField
      FieldName = 'descripcion_b'
      Origin = 'frf_bancos.descripcion_b'
      Size = 30
    end
    object QBancospoblacion_b: TStringField
      FieldName = 'poblacion_b'
      Origin = 'frf_bancos.poblacion_b'
      Size = 30
    end
    object QBancoscta_bancaria_b: TStringField
      DisplayWidth = 31
      FieldName = 'cta_bancaria_b'
      Origin = 'frf_bancos.cta_bancaria_b'
      Size = 31
    end
    object QBancoscomision_cambio_b: TFloatField
      FieldName = 'comision_cambio_b'
      Origin = 'frf_bancos.comision_cambio_b'
    end
    object QBancosdias_valor_b: TSmallintField
      FieldName = 'dias_valor_b'
      Origin = 'frf_bancos.dias_valor_b'
    end
    object QBancoscta_contable_b: TStringField
      FieldName = 'cta_contable_b'
      Origin = 'frf_bancos.cta_contable_b'
      Size = 8
    end
    object QBancosseccion_b: TStringField
      FieldName = 'seccion_b'
      Origin = 'frf_bancos.seccion_b'
      Size = 3
    end
  end
end
