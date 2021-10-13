object FDObservaciones: TFDObservaciones
  Left = 227
  Top = 164
  ActiveControl = Memo
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '  OBSERVACIONES (Max 3 lineas)'
  ClientHeight = 134
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 120
    Top = 88
    Width = 75
    Height = 25
    Caption = '&Imprimir'
    TabOrder = 0
    Kind = bkYes
  end
  object BitBtn2: TBitBtn
    Left = 200
    Top = 88
    Width = 75
    Height = 25
    Caption = '&Salir'
    TabOrder = 1
    Kind = bkCancel
  end
  object Memo: TMemo
    Left = 16
    Top = 24
    Width = 369
    Height = 49
    TabOrder = 2
  end
end
