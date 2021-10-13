object FDFacturaManual: TFDFacturaManual
  Left = 202
  Top = 177
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '    MANTENIMIENTO FACTURA  -  CONCEPTO FACTURA MANUAL'
  ClientHeight = 512
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object DBMemo: TDBMemo
    Left = 0
    Top = 72
    Width = 700
    Height = 440
    Align = alBottom
    DataField = 'texto_fm'
    DataSource = DSFacManual
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    WantTabs = True
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 700
    Height = 72
    Align = alClient
    TabOrder = 1
    object LEmpresa_f: TLabel
      Left = 16
      Top = 12
      Width = 81
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LCliente_fac_f: TLabel
      Left = 16
      Top = 37
      Width = 81
      Height = 19
      AutoSize = False
      Caption = ' Cliente factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LN_Factura_f: TLabel
      Left = 312
      Top = 37
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LFecha_factura_f: TLabel
      Left = 312
      Top = 12
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Fecha factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object empresaText: TStaticText
      Left = 130
      Top = 12
      Width = 168
      Height = 19
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 0
    end
    object cliente_facText: TStaticText
      Left = 130
      Top = 37
      Width = 168
      Height = 19
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object fechaText: TStaticText
      Left = 408
      Top = 12
      Width = 121
      Height = 21
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 2
    end
    object empresa: TBDEdit
      Left = 98
      Top = 11
      Width = 31
      Height = 21
      Enabled = False
      TabOrder = 3
      DataField = 'empresa_fm'
      DataSource = DSFacManual
    end
    object fecha: TBDEdit
      Left = 408
      Top = 11
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 4
      DataField = 'fecha_fm'
      DataSource = DSFacManual
    end
    object factura: TBDEdit
      Left = 408
      Top = 36
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 5
      DataField = 'factura_fm'
      DataSource = DSFacManual
    end
    object cliente: TBEdit
      Left = 98
      Top = 36
      Width = 31
      Height = 21
      Enabled = False
      TabOrder = 6
    end
    object BitBtn1: TBitBtn
      Left = 544
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Aceptar'
      TabOrder = 7
      TabStop = False
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 544
      Top = 35
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 8
      TabStop = False
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
  end
  object TFacManual: TTable
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'empresa_fm;factura_fm;fecha_fm'
    MasterFields = 'empresa_f;n_factura_f;fecha_factura_f'
    MasterSource = DSFactura
    TableName = 'frf_fac_manual'
    Left = 40
    Top = 112
  end
  object DSFacManual: TDataSource
    DataSet = TFacManual
    Left = 72
    Top = 112
  end
  object DSFactura: TDataSource
    Left = 8
    Top = 112
  end
end
