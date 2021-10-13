object FDNoEuro: TFDNoEuro
  Left = 802
  Top = 247
  Width = 441
  Height = 266
  BorderIcons = []
  Caption = 'CONVERSION DIVISAS  ZONA NO EURO'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object BCalendarButton1: TBCalendarButton
    Left = 233
    Top = 29
    Width = 13
    Height = 23
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000001F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    OnClick = BCalendarButton1Click
    Control = BEdit1
    Calendar = BCalendario1
    CalendarAlignment = taDownCenter
    CalendarWidth = 217
    CalendarHeigth = 173
  end
  object EdInput: TEdit
    Left = 32
    Top = 29
    Width = 88
    Height = 23
    TabOrder = 0
    Text = '1'
    OnKeyPress = EdInputKeyPress
  end
  object BtnConvert: TButton
    Left = 256
    Top = 28
    Width = 141
    Height = 25
    Caption = '&Igual '
    TabOrder = 1
    OnClick = BtnConvertClick
  end
  object RGSeleccion: TRadioGroup
    Left = 32
    Top = 52
    Width = 88
    Height = 28
    TabOrder = 2
    OnClick = RGCurrencyClick
  end
  object GBResultados: TGroupBox
    Left = 127
    Top = 52
    Width = 270
    Height = 28
    TabOrder = 3
  end
  object BEdit1: TBEdit
    Left = 127
    Top = 29
    Width = 106
    Height = 23
    InputType = itDate
    TabOrder = 4
  end
  object BCalendario1: TBCalendario
    Left = 112
    Top = 54
    Width = 217
    Height = 173
    AutoSize = True
    Date = 37124.3913841782
    TabOrder = 5
    Visible = False
    WeekNumbers = True
    BControl = BEdit1
  end
  object ActionList1: TActionList
    Left = 328
    Top = 88
    object ACancelar: TAction
      Caption = 'ACancelar'
      ShortCut = 27
      OnExecute = ACancelarExecute
    end
  end
end
