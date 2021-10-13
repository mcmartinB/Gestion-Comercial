object FDImportarPalet: TFDImportarPalet
  Left = 601
  Top = 269
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'IMPORTAR TIPO PALETS BD REMOTA'
  ClientHeight = 323
  ClientWidth = 669
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblNombre7: TLabel
    Left = 9
    Top = 49
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' C'#243'digo Palet'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblPalet: TLabel
    Left = 161
    Top = 52
    Width = 34
    Height = 13
    Caption = 'lblPalet'
  end
  object btnImportar: TButton
    Left = 8
    Top = 9
    Width = 100
    Height = 25
    Caption = 'Importar Palet'
    TabOrder = 1
    OnClick = btnImportarClick
  end
  object btnAceptar: TButton
    Left = 454
    Top = 8
    Width = 100
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 0
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 560
    Top = 9
    Width = 100
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object codigo_tp: TBEdit
    Left = 121
    Top = 48
    Width = 32
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 13
    TabOrder = 3
    OnChange = codigo_tpChange
  end
  object mmoIzq: TMemo
    Left = 13
    Top = 91
    Width = 172
    Height = 206
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    WordWrap = False
  end
  object mmoDer: TMemo
    Left = 192
    Top = 91
    Width = 457
    Height = 206
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    WordWrap = False
  end
  object qryPalet: TQuery
    DatabaseName = 'BDCentral'
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 283
    Top = 177
  end
  object dsPalet: TDataSource
    DataSet = qryPalet
    Left = 314
    Top = 178
  end
end
