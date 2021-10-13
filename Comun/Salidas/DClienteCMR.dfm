object FDClienteCMR: TFDClienteCMR
  Left = 273
  Top = 573
  Caption = 'FDClienteCMR'
  ClientHeight = 253
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 131
    Width = 109
    Height = 13
    Caption = 'Casilla 2: Consignatario'
  end
  object Label2: TLabel
    Left = 16
    Top = 24
    Width = 93
    Height = 13
    Caption = 'Casilla 1: Remitente'
  end
  object lblEntrega: TLabel
    Left = 368
    Top = 131
    Width = 126
    Height = 13
    Caption = 'Casilla 3: Lugar de entrega'
  end
  object lblcarga: TLabel
    Left = 368
    Top = 24
    Width = 114
    Height = 13
    Caption = 'Casilla 4:Lugar de carga'
  end
  object MemoOrigen: TMemo
    Left = 16
    Top = 40
    Width = 345
    Height = 89
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'DAI FRUITS GROUP'
      'CTRA. DE BARCELONA N'#186' 24 B'
      'C.P. 46530 (PUZOL)'
      'VALENCIA '
      '')
    ParentFont = False
    TabOrder = 1
  end
  object MemoCliente: TMemo
    Left = 16
    Top = 148
    Width = 345
    Height = 89
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 594
    Top = 7
    Width = 175
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 0
    Kind = bkOK
  end
  object mmoEntrega: TMemo
    Left = 368
    Top = 148
    Width = 401
    Height = 89
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssHorizontal
    TabOrder = 4
    WordWrap = False
  end
  object mmoCarga: TMemo
    Left = 368
    Top = 40
    Width = 401
    Height = 89
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'BONNYSA S.A.T. N'#186' 9359'
      'ESPA'#209'A')
    ParentFont = False
    TabOrder = 2
  end
  object qryCliente: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * '
      'from frf_clientes')
    Left = 256
    Top = 7
  end
  object qryEmpresa: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * '
      'from frf_clientes')
    Left = 216
    Top = 7
  end
end
