object FEscandallo: TFEscandallo
  Left = 363
  Top = 176
  ActiveControl = primera
  BorderStyle = bsDialog
  Caption = '    ESCANDALLO'
  ClientHeight = 187
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object nbLabel1: TnbLabel
    Left = 75
    Top = 34
    Width = 110
    Height = 21
    Caption = 'Primera'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 75
    Top = 58
    Width = 110
    Height = 21
    Caption = 'Segunda'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 75
    Top = 82
    Width = 110
    Height = 21
    Caption = 'Tercera'
    About = 'NB 0.1/20020725'
  end
  object Label1: TLabel
    Left = 248
    Top = 38
    Width = 22
    Height = 13
    Caption = 'KGS'
  end
  object Label2: TLabel
    Left = 248
    Top = 86
    Width = 22
    Height = 13
    Caption = 'KGS'
  end
  object Label3: TLabel
    Left = 248
    Top = 62
    Width = 22
    Height = 13
    Caption = 'KGS'
  end
  object lblDestrio: TnbLabel
    Left = 75
    Top = 106
    Width = 110
    Height = 21
    Caption = 'Tercera'
    About = 'NB 0.1/20020725'
  end
  object lblDestrio2: TLabel
    Left = 248
    Top = 110
    Width = 22
    Height = 13
    Caption = 'KGS'
  end
  object btnAceptar: TBitBtn
    Left = 286
    Top = 138
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 3
    OnClick = btnAceptarClick
  end
  object primera: TnbDBNumeric
    Left = 187
    Top = 34
    Width = 56
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '0'
    TabOrder = 0
    NumIntegers = 5
    NumDecimals = 2
  end
  object segunda: TnbDBNumeric
    Left = 187
    Top = 58
    Width = 56
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '0'
    TabOrder = 1
    NumIntegers = 5
    NumDecimals = 2
  end
  object tercera: TnbDBNumeric
    Left = 187
    Top = 82
    Width = 56
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '0'
    TabOrder = 2
    NumIntegers = 5
    NumDecimals = 2
  end
  object destrio: TnbDBNumeric
    Left = 187
    Top = 106
    Width = 56
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '0'
    TabOrder = 4
    NumIntegers = 5
    NumDecimals = 2
  end
end
