object FMGetFiltro: TFMGetFiltro
  Left = 558
  Top = 163
  Width = 436
  Height = 310
  Caption = 'FILTRO PAISES'
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
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnAceptar: TButton
    Left = 248
    Top = 231
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 0
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 328
    Top = 231
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = btnCancelarClick
  end
  object MiPopupMenu: TPopupMenu
    Left = 352
    Top = 16
    object mnuMayor: TMenuItem
      Caption = 'Mayor [>]'
    end
    object mnuiMayorIgual: TMenuItem
      Caption = 'Mayor Igual [>=]'
    end
    object mnuMenor: TMenuItem
      Caption = 'Menor [<]'
    end
    object mnuMenorIgual: TMenuItem
      Caption = 'Menor Igual [<=]'
    end
    object mnuLista: TMenuItem
      Caption = 'Lista [;]'
    end
    object mnuRango: TMenuItem
      Caption = 'Rango [:]'
    end
    object mnuIsNULL: TMenuItem
      Caption = 'IS NULL'
    end
    object mnuNotIsNULL: TMenuItem
      Caption = 'NOT IS NULL'
    end
  end
end
