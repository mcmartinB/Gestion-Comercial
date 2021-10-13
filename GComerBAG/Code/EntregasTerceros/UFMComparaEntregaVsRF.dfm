object FMComparaEntregaVsRF: TFMComparaEntregaVsRF
  Left = 376
  Top = 276
  Width = 693
  Height = 367
  Caption = 'COMPARA LA ORDER ENTREGA DE PROVEEDOR CON SU RADIOFRECUENCIA'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblEntrega: TLabel
    Left = 16
    Top = 33
    Width = 45
    Height = 13
    Caption = 'Entrega'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblRF: TLabel
    Left = 16
    Top = 168
    Width = 97
    Height = 13
    Caption = 'RadioFrecuencia'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblMsg: TLabel
    Left = 16
    Top = 9
    Width = 607
    Height = 13
    Caption = 
      'Existen diferencias entre los datos del albar'#225'n entrega y su rad' +
      'iofrecuencia asociada. Por favor corrigalos.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object dbgEntrega: TDBGrid
    Left = 16
    Top = 48
    Width = 649
    Height = 105
    DataSource = DSEntrega
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object dbgRF: TDBGrid
    Left = 16
    Top = 184
    Width = 649
    Height = 105
    DataSource = DSRF
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object btnCerrar: TButton
    Left = 592
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Cerrar'
    TabOrder = 2
    OnClick = btnCerrarClick
  end
  object DSEntrega: TDataSource
    DataSet = QEntrega
    Left = 96
    Top = 88
  end
  object DSRF: TDataSource
    DataSet = QRF
    Left = 104
    Top = 224
  end
  object QEntrega: TQuery
    DatabaseName = 'BDProyecto'
    Left = 64
    Top = 80
  end
  object QRF: TQuery
    DatabaseName = 'BDProyecto'
    Left = 72
    Top = 216
  end
end
