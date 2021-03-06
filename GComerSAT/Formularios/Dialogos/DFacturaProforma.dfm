object FDFacturaProforma: TFDFacturaProforma
  Left = 297
  Top = 219
  Width = 771
  Height = 469
  BorderIcons = []
  Caption = '   FACTURA PROFORMA'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 153
    Width = 763
    Height = 282
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 388
      Top = 14
      Width = 23
      Height = 13
      Caption = 'Neto'
    end
    object labelIva: TLabel
      Left = 502
      Top = 14
      Width = 17
      Height = 13
      Caption = 'IVA'
    end
    object Label3: TLabel
      Left = 616
      Top = 14
      Width = 24
      Height = 13
      Caption = 'Total'
    end
    object LMoneda: TLabel
      Left = 731
      Top = 31
      Width = 39
      Height = 13
      Caption = 'Moneda'
    end
    object Label4: TLabel
      Left = 731
      Top = 55
      Width = 23
      Height = 13
      Caption = 'EUR'
    end
    object Label5: TLabel
      Left = 27
      Top = 14
      Width = 36
      Height = 13
      Caption = 'Factura'
    end
    object Label6: TLabel
      Left = 141
      Top = 14
      Width = 30
      Height = 13
      Caption = 'Fecha'
    end
    object Label7: TLabel
      Left = 255
      Top = 14
      Width = 32
      Height = 13
      Caption = 'Cliente'
    end
    object Label8: TLabel
      Left = 388
      Top = 89
      Width = 48
      Height = 13
      Caption = 'Suministro'
    end
    object Label9: TLabel
      Left = 502
      Top = 89
      Width = 33
      Height = 13
      Caption = 'Pedido'
    end
    object Label10: TLabel
      Left = 616
      Top = 89
      Width = 43
      Height = 13
      Caption = 'Veh'#237'culo'
    end
    object Label2: TLabel
      Left = 27
      Top = 153
      Width = 71
      Height = 13
      Caption = 'Observaciones'
    end
    object Label11: TLabel
      Left = 654
      Top = 175
      Width = 46
      Height = 13
      Caption = 'N. Copias'
    end
    object lblIcoterm: TLabel
      Left = 388
      Top = 131
      Width = 41
      Height = 13
      Caption = 'Incoterm'
    end
    object MemoObservaciones: TMemo
      Left = 27
      Top = 171
      Width = 603
      Height = 87
      Color = 14737632
      Lines.Strings = (
        'MemoObservaciones')
      ReadOnly = True
      TabOrder = 12
    end
    object memoDireccion: TMemo
      Left = 27
      Top = 51
      Width = 341
      Height = 97
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 6
    end
    object BitBtn1: TBitBtn
      Left = 654
      Top = 201
      Width = 75
      Height = 25
      ModalResult = 1
      TabOrder = 15
      TabStop = False
      OnClick = BitBtn1Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 654
      Top = 233
      Width = 75
      Height = 25
      TabOrder = 16
      TabStop = False
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
    object exNeto: TEdit
      Left = 388
      Top = 29
      Width = 113
      Height = 21
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 3
    end
    object exIva: TEdit
      Left = 502
      Top = 29
      Width = 113
      Height = 21
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 4
    end
    object exTotal: TEdit
      Left = 616
      Top = 29
      Width = 113
      Height = 21
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 5
    end
    object exTotalEUR: TEdit
      Left = 616
      Top = 51
      Width = 113
      Height = 21
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 7
    end
    object exFactura: TEdit
      Left = 27
      Top = 29
      Width = 113
      Height = 21
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 0
      Text = 'PROFORMA'
    end
    object exFecha: TEdit
      Left = 141
      Top = 29
      Width = 113
      Height = 21
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 1
    end
    object exCliente: TEdit
      Left = 255
      Top = 29
      Width = 113
      Height = 21
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 2
    end
    object exSuministro: TEdit
      Left = 388
      Top = 104
      Width = 113
      Height = 21
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 8
    end
    object exPedido: TEdit
      Left = 502
      Top = 104
      Width = 113
      Height = 21
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 9
    end
    object exVehiculo: TEdit
      Left = 616
      Top = 104
      Width = 113
      Height = 21
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 10
    end
    object nCopias: TnbDBNumeric
      Left = 712
      Top = 171
      Width = 17
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      Text = '3'
      TabOrder = 13
      NumIntegers = 1
    end
    object UpDown1: TUpDown
      Left = 729
      Top = 171
      Width = 16
      Height = 21
      Associate = nCopias
      Min = 0
      Max = 9
      Position = 3
      TabOrder = 14
      Wrap = False
    end
    object edtIncoterm: TEdit
      Left = 440
      Top = 127
      Width = 288
      Height = 21
      TabStop = False
      Color = 14737632
      ReadOnly = True
      TabOrder = 11
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 763
    Height = 153
    Align = alClient
    Color = 14737632
    ColCount = 8
    DefaultColWidth = 10
    DefaultRowHeight = 18
    FixedColor = clScrollBar
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnSelectCell = StringGrid1SelectCell
    OnSetEditText = StringGrid1SetEditText
    ColWidths = (
      10
      165
      125
      185
      64
      37
      63
      65)
  end
end
