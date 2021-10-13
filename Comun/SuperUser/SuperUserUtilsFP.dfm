object FPSuperUserUtils: TFPSuperUserUtils
  Left = 622
  Top = 181
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = '    UTILIDADES DEL ADMINISTRADOR'
  ClientHeight = 373
  ClientWidth = 825
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
  object lblEmpresa: TLabel
    Left = 24
    Top = 16
    Width = 41
    Height = 13
    Caption = 'Empresa'
  end
  object lblDesEmpresa: TLabel
    Left = 128
    Top = 16
    Width = 70
    Height = 13
    Caption = 'lblDesEmpresa'
  end
  object btnCerrar: TButton
    Left = 745
    Top = 5
    Width = 75
    Height = 25
    Caption = 'Cerrar'
    TabOrder = 0
    OnClick = btnCerrarClick
  end
  object edtEmpresa: TEdit
    Left = 72
    Top = 12
    Width = 41
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
    OnChange = edtEmpresaChange
  end
  object pgcMain: TPageControl
    Left = 0
    Top = 48
    Width = 825
    Height = 325
    ActivePage = tsRFSinAlmacen
    Align = alBottom
    TabOrder = 2
    TabWidth = 100
    OnChange = pgcMainChange
    object tsRFSinAlmacen: TTabSheet
      Caption = 'RF Sin Almacen'
      ImageIndex = 2
      object btnRFSinAlmacen: TButton
        Left = 29
        Top = 22
        Width = 96
        Height = 25
        Caption = 'RF Sin Almacen'
        TabOrder = 0
        OnClick = btnRFSinAlmacenClick
      end
    end
    object tsPesoBrutoTan: TTabSheet
      Caption = 'tsPesoBrutoTan'
      ImageIndex = 3
      object lbl1: TLabel
        Left = 31
        Top = 17
        Width = 195
        Height = 13
        Caption = 'Peso bruto en el campo notas del transito'
      end
      object btn1: TButton
        Left = 315
        Top = 85
        Width = 75
        Height = 25
        Caption = 'btn1'
        TabOrder = 0
        OnClick = btn1Click
      end
    end
    object tsPaletInSinLineaIn: TTabSheet
      Caption = 'tsPaletInSinLineaIn'
      ImageIndex = 4
      object btn2: TButton
        Left = 56
        Top = 40
        Width = 75
        Height = 25
        Caption = 'btn2'
        TabOrder = 0
        OnClick = btn2Click
      end
    end
    object tsFacturaX3Origen: TTabSheet
      Caption = 'tsFacturaX3Origen'
      ImageIndex = 5
      object lblAbono: TLabel
        Left = 48
        Top = 32
        Width = 41
        Height = 13
        Caption = 'lblAbono'
      end
      object lblFacturaX3: TLabel
        Left = 272
        Top = 32
        Width = 59
        Height = 13
        Caption = 'lblFacturaX3'
      end
      object edtAbono: TEdit
        Left = 48
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'edtAbono'
      end
      object btnFacturaX3Origen: TButton
        Left = 184
        Top = 46
        Width = 75
        Height = 25
        Caption = 'X3 Origen'
        TabOrder = 0
        OnClick = btnFacturaX3OrigenClick
      end
      object edtFactura: TEdit
        Left = 272
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 2
        Text = 'edtFacturaX3'
      end
    end
    object tsTransitos: TTabSheet
      Caption = 'tsTransitos'
      ImageIndex = 6
      object lbl2: TLabel
        Left = 64
        Top = 45
        Width = 81
        Height = 13
        Caption = 'Selecciona lunes'
      end
      object btn3: TButton
        Left = 200
        Top = 62
        Width = 281
        Height = 25
        Caption = 'Asigna kilos salidas a transitos (una semana)'
        TabOrder = 0
        OnClick = btn3Click
      end
      object dtpAsignaKilosTransitos: TDateTimePicker
        Left = 64
        Top = 64
        Width = 129
        Height = 21
        Date = 42817.635622662030000000
        Time = 42817.635622662030000000
        TabOrder = 1
      end
      object btn4: TButton
        Left = 224
        Top = 160
        Width = 177
        Height = 25
        Caption = 'Rellena Tercera Liq'
        TabOrder = 3
        OnClick = btn4Click
      end
      object edtProdLiq: TEdit
        Left = 80
        Top = 208
        Width = 121
        Height = 21
        TabOrder = 5
        Text = 'Y'
      end
      object edTCentroLiq: TEdit
        Left = 80
        Top = 184
        Width = 121
        Height = 21
        TabOrder = 4
        Text = '1'
      end
      object edtLiqIni: TEdit
        Left = 80
        Top = 232
        Width = 121
        Height = 21
        TabOrder = 6
        Text = '01/04/2017'
      end
      object edtLiqFin: TEdit
        Left = 80
        Top = 256
        Width = 121
        Height = 21
        TabOrder = 7
        Text = '30/04/2017'
      end
      object edtEmpresaLiq: TEdit
        Left = 80
        Top = 160
        Width = 121
        Height = 21
        TabOrder = 2
        Text = '050'
      end
    end
  end
end
