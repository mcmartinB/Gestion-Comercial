object FDConfigMailFactura: TFDConfigMailFactura
  Left = 679
  Top = 247
  ActiveControl = MMensaje
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'FACTURA DE VENTA -  ENV'#205'O DE CORREO '
  ClientHeight = 520
  ClientWidth = 652
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 356
    Width = 652
    Height = 145
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 2
    object MMensaje: TMemo
      Left = 1
      Top = 1
      Width = 650
      Height = 143
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 652
    Height = 89
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 14
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Direcci'#243'n: '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 19
      Top = 38
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Asunto: '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object SBEnviar: TSpeedButton
      Left = 554
      Top = 13
      Width = 86
      Height = 22
      Action = AEnvio
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
        000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
        FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
        FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
        9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
        0000777777777777777733333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object SBSalir: TSpeedButton
      Left = 554
      Top = 36
      Width = 86
      Height = 22
      Action = ASalir
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FFBFFF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00
        FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FFBF0000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
        0000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FFBF00000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00
        FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FFBFFF00
        FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
    object lblCopia: TLabel
      Left = 19
      Top = 60
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Copia: '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnACancelar: TSpeedButton
      Left = 554
      Top = 58
      Width = 86
      Height = 22
      Caption = 'Cancelar'
      Visible = False
      OnClick = btnACancelarClick
    end
    object EDireccion: TEdit
      Left = 111
      Top = 13
      Width = 306
      Height = 21
      TabOrder = 0
      OnChange = EDireccionChange
    end
    object EAsunto: TEdit
      Left = 111
      Top = 36
      Width = 306
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object edtCopia: TEdit
      Left = 111
      Top = 58
      Width = 306
      Height = 21
      TabOrder = 2
    end
    object chkTextoFijoAsunto: TCheckBox
      Left = 420
      Top = 38
      Width = 128
      Height = 17
      Caption = 'Texto Fijo en Asunto'
      TabOrder = 3
      OnClick = chkTextoFijoAsuntoClick
    end
  end
  object SBEstado: TStatusBar
    Left = 0
    Top = 501
    Width = 652
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Panel3: TPanel
    Left = 0
    Top = 89
    Width = 652
    Height = 267
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object ListView1: TListView
      Left = 2
      Top = 33
      Width = 648
      Height = 232
      Align = alClient
      Columns = <>
      GridLines = True
      IconOptions.Arrangement = iaLeft
      IconOptions.WrapText = False
      LargeImages = ILImages
      SmallImages = ILImages
      StateImages = ILImages
      TabOrder = 0
      ViewStyle = vsSmallIcon
      OnDblClick = ListView1DblClick
    end
    object Panel4: TPanel
      Left = 2
      Top = 2
      Width = 648
      Height = 31
      Align = alTop
      TabOrder = 1
      object Label3: TLabel
        Left = 16
        Top = 8
        Width = 105
        Height = 19
        AutoSize = False
        Caption = ' Archivos Adjuntos: '
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object sbVerUlt: TSpeedButton
        Left = 454
        Top = 4
        Width = 90
        Height = 22
        Caption = 'Ver 10 '#250'ltimos'
        OnClick = sbVerUltClick
      end
      object sbOcultarUlt: TSpeedButton
        Left = 550
        Top = 4
        Width = 90
        Height = 22
        Caption = 'Ocultar 10 '#250'ltimos'
        Enabled = False
        OnClick = sbOcultarUltClick
      end
      object btn1: TButton
        Left = 360
        Top = 4
        Width = 90
        Height = 22
        Caption = 'A'#241'adir'
        TabOrder = 0
        OnClick = btn1Click
      end
    end
    object SGEnviados: TStringGrid
      Left = 2
      Top = 33
      Width = 648
      Height = 232
      Align = alClient
      DefaultRowHeight = 20
      FixedCols = 0
      RowCount = 11
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goRowSelect]
      TabOrder = 2
      Visible = False
      ColWidths = (
        62
        66
        210
        181
        253)
    end
  end
  object ILImages: TImageList
    Left = 424
    Top = 152
    Bitmap = {
      494C010102000500440010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00008484840084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60084848400C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C60084848400C6C6C60000000000C6C6C60000000000C6C6C6000000
      0000C6C6C60084848400C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600000000000000FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C6000000FF00C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C6000000FF000000FF000000FF008484
      84000000FF00C6C6C600C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000FF00C6C6
      C600C6C6C600C6C6C600C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000FF00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000FF00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF00848484008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000084848400848484008484840084848400848484000000FF00848484008484
      8400C6C6C600C6C6C600C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF0084848400FFFFFF0000000000FFFFFF00FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF008484
      8400C6C6C600C6C6C600C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF0084848400FFFFFF0000000000FFFFFF00FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000FF000000FF00FFFFFF000000
      FF000000FF000000FF00FFFFFF00FFFFFF000000FF000000FF000000FF008484
      8400C6C6C600C6C6C600C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400FFFFFF00FFFF
      FF0084848400FFFFFF0000000000FFFFFF00FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000FF000000FF00FFFFFF000000
      FF000000FF000000FF00FFFFFF00FFFFFF000000FF000000FF000000FF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084848400848484008484
      8400848484008484840000000000848484008484840084848400000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00C6C6
      C600000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484000000000084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF008000F000000000000000E00000000000
      0000E000000000000000E000000000000000E000000000000000E00000000000
      0000E000000000000000E000000000000000E000000000000000E00000000000
      0000E00000000000000000000000000000280000000000000018000100000000
      00380001000000000018E0030000000000000000000000000000000000000000
      000000000000}
  end
  object ActionList1: TActionList
    Left = 480
    Top = 193
    object AEnvio: TAction
      Caption = '&Enviar'
      ShortCut = 112
      OnExecute = SBEnviarClick
    end
    object ASalir: TAction
      Caption = '&Salir'
      ShortCut = 27
      OnExecute = SBSalirClick
    end
  end
  object QGuardarEnviados: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'select cod_empresa_tfc, cod_cliente_fac_tfc, factura_tfc, fecha_' +
        'tfc'
      'from tmp_facturas_c'
      'where usuario_tfc = :usuario'
      'order by factura_tfc')
    Left = 448
    Top = 185
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'usuario'
        ParamType = ptUnknown
      end>
  end
  object QPDFs: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * from frf_pdfs where nombre_p = "###"')
    Left = 8
    Top = 8
    object QPDFsnombre_p: TStringField
      FieldName = 'nombre_p'
      Origin = 'frf_pdfs.nombre_p'
      Size = 60
    end
    object QPDFspdf_p: TBlobField
      FieldName = 'pdf_p'
      Origin = 'frf_pdfs.pdf_p'
      Size = 1
    end
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 200
    Top = 105
  end
  object IdSMTP: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AuthType = satSASL
    Host = 'smtp.office365.com'
    Password = 'co1234'
    Port = 587
    SASLMechanisms = <
      item
        SASL = IdSASLLogin1
      end>
    UseTLS = utUseExplicitTLS
    Left = 168
    Top = 105
  end
  object dlgOpen: TOpenDialog
    Left = 344
    Top = 233
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = 'smtp.office365.com:587'
    Host = 'smtp.office365.com'
    MaxLineAction = maException
    Port = 587
    DefaultPort = 0
    SSLOptions.Method = sslvTLSv1_2
    SSLOptions.SSLVersions = [sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 238
    Top = 108
  end
  object IdSASLLogin1: TIdSASLLogin
    UserPassProvider = IdUserPassProvider1
    Left = 276
    Top = 106
  end
  object IdUserPassProvider1: TIdUserPassProvider
    Left = 309
    Top = 107
  end
end
