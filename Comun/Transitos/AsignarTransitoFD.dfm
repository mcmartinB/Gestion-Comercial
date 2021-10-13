object FDAsignarTransito: TFDAsignarTransito
  Left = 334
  Top = 252
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Asignar Tr'#225'nsito'
  ClientHeight = 355
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblKilosSal: TLabel
    Left = 645
    Top = 11
    Width = 70
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosSal'
  end
  object lblKilosTra: TLabel
    Left = 645
    Top = 27
    Width = 70
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosSal'
  end
  object lblKilosPuedo: TLabel
    Left = 645
    Top = 58
    Width = 70
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosPuedo'
  end
  object lbl1: TLabel
    Left = 541
    Top = 11
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Kilos Salida'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 541
    Top = 27
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Kilos Transitos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 541
    Top = 58
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Puedo Asignar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 541
    Top = 74
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Cajas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCajas: TLabel
    Left = 645
    Top = 74
    Width = 70
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosPuedo'
  end
  object lbl6: TLabel
    Left = 541
    Top = 90
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Palets'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPalets: TLabel
    Left = 645
    Top = 90
    Width = 70
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosPuedo'
  end
  object lbl8: TLabel
    Left = 541
    Top = 105
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Neto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblImporte: TLabel
    Left = 645
    Top = 105
    Width = 70
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosPuedo'
  end
  object lbl10: TLabel
    Left = 541
    Top = 121
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Iva'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblIva: TLabel
    Left = 645
    Top = 121
    Width = 70
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosPuedo'
  end
  object lbl12: TLabel
    Left = 541
    Top = 137
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotal: TLabel
    Left = 645
    Top = 137
    Width = 70
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosPuedo'
  end
  object dbgrdTransitos: TDBGrid
    Left = 0
    Top = 0
    Width = 547
    Height = 355
    Align = alLeft
    DataSource = dsTransitos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object btnClose: TButton
    Left = 635
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = btnCloseClick
  end
  object btnAplicar: TButton
    Left = 635
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Aplicar'
    TabOrder = 2
    OnClick = btnAplicarClick
  end
  object dsTransitos: TDataSource
    DataSet = qryTransitos
    Left = 440
    Top = 16
  end
  object qryTransitos: TQuery
    AfterScroll = qryTransitosAfterScroll
    DatabaseName = 'BDProyecto'
    Left = 408
    Top = 16
  end
  object qrySalidas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 408
    Top = 56
  end
  object qryEnvase: TQuery
    DatabaseName = 'BDProyecto'
    Left = 408
    Top = 96
  end
end
