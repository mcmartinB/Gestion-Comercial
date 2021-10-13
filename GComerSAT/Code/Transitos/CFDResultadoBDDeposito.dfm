object FDResultadoBDDeposito: TFDResultadoBDDeposito
  Left = 456
  Top = 268
  Width = 589
  Height = 326
  Caption = 'RESUMEN SALIDAS DEP'#211'SITO'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sgrdResultados: TStringGrid
    Left = 0
    Top = 33
    Width = 572
    Height = 253
    ColCount = 8
    DefaultColWidth = 70
    RowCount = 10
    TabOrder = 4
  end
  object btnCerrar: TButton
    Left = 487
    Top = 4
    Width = 85
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btnCerrarClick
  end
  object btnBaseDatos: TButton
    Left = 401
    Top = 4
    Width = 85
    Height = 25
    Caption = 'Informe+Excel'
    TabOrder = 1
    OnClick = btnBaseDatosClick
  end
  object btnInforme: TButton
    Left = 315
    Top = 4
    Width = 85
    Height = 25
    Caption = 'Solo Informe'
    TabOrder = 0
    OnClick = btnInformeClick
  end
  object chkIgnorarErrores: TCheckBox
    Left = 216
    Top = 8
    Width = 92
    Height = 17
    Caption = 'Ignorar Errores'
    TabOrder = 3
    OnClick = chkIgnorarErroresClick
  end
  object QAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 656
  end
end
