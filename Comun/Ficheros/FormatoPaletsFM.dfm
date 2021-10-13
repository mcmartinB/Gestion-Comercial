object FMFormatoPalets: TFMFormatoPalets
  Left = 315
  Top = 208
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  FORMATOS PALETS'
  ClientHeight = 515
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object TBBarraMaestroDetalle: TToolBar
    Left = 0
    Top = 0
    Width = 781
    Height = 22
    ButtonWidth = 24
    Caption = 'TBBarraMaestroDetalle'
    Images = DMBaseDatos.ImgBarraHerramientas
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Wrapable = False
    object btnLocalizar: TToolButton
      Left = 0
      Top = 0
      Action = ALocalizar
      ParentShowHint = False
      ShowHint = True
    end
    object btnModificarCab: TToolButton
      Left = 24
      Top = 0
      Action = AModificarCab
      ParentShowHint = False
      ShowHint = True
    end
    object btnBorrarCab: TToolButton
      Left = 48
      Top = 0
      Action = ABorrarCab
      ParentShowHint = False
      ShowHint = True
    end
    object btnInsertarCab: TToolButton
      Left = 72
      Top = 0
      Action = AInsertarCab
      ParentShowHint = False
      ShowHint = True
    end
    object TBMaestroDetalleSeparador3: TToolButton
      Left = 96
      Top = 0
      Width = 24
      Caption = 'TBMaestroDetalleSeparador3'
      ImageIndex = 25
      ParentShowHint = False
      ShowHint = True
      Style = tbsDivider
    end
    object btnModificarDet: TToolButton
      Left = 120
      Top = 0
      Action = AModificarDet
      ParentShowHint = False
      ShowHint = True
    end
    object btnBorrarDet: TToolButton
      Left = 144
      Top = 0
      Action = ABorrarDet
      ParentShowHint = False
      ShowHint = True
    end
    object btnInsertarDet: TToolButton
      Left = 168
      Top = 0
      Action = AInsertarDet
      ParentShowHint = False
      ShowHint = True
    end
    object TBMaestroDetalleSeparador1: TToolButton
      Left = 192
      Top = 0
      Width = 24
      Caption = 'TBMaestroDetalleSeparador1'
      ParentShowHint = False
      ShowHint = True
      Style = tbsDivider
    end
    object btnImprimir: TToolButton
      Left = 216
      Top = 0
      Action = AImprimir
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton4: TToolButton
      Left = 240
      Top = 0
      Width = 24
      Caption = 'ToolButton4'
      ImageIndex = 19
      Style = tbsDivider
    end
    object btnPrimero: TToolButton
      Left = 264
      Top = 0
      Action = APrimero
      ParentShowHint = False
      ShowHint = True
    end
    object btnAnterior: TToolButton
      Left = 288
      Top = 0
      Action = AAnterior
      ParentShowHint = False
      ShowHint = True
    end
    object btnSiguiente: TToolButton
      Left = 312
      Top = 0
      Action = ASiguiente
      ParentShowHint = False
      ShowHint = True
    end
    object btnUltimo: TToolButton
      Left = 336
      Top = 0
      Action = AUltimo
      ParentShowHint = False
      ShowHint = True
    end
    object TBMaestroDetalleSeparador2: TToolButton
      Left = 360
      Top = 0
      Width = 24
      Caption = 'TBMaestroDetalleSeparador2'
      ParentShowHint = False
      ShowHint = True
      Style = tbsDivider
    end
    object btnAceptar: TToolButton
      Left = 384
      Top = 0
      Action = AAceptar
      ParentShowHint = False
      ShowHint = True
    end
    object btnCancelar: TToolButton
      Left = 408
      Top = 0
      Action = ACancelar
      ParentShowHint = False
      ShowHint = True
    end
    object TBMaestroDetalleSeparador5: TToolButton
      Left = 432
      Top = 0
      Width = 24
      Caption = 'TBMaestroDetalleSeparador5'
      ImageIndex = 21
      ParentShowHint = False
      ShowHint = True
      Style = tbsDivider
    end
    object btnSalir: TToolButton
      Left = 456
      Top = 0
      Action = ASalir
      ParentShowHint = False
      ShowHint = True
    end
  end
  object pgControl: TPageControl
    Left = 0
    Top = 22
    Width = 781
    Height = 493
    ActivePage = tsFicha
    Align = alClient
    TabOrder = 1
    TabStop = False
    TabWidth = 100
    object tsFicha: TTabSheet
      Caption = 'FICHA'
      OnShow = tsFichaShow
      object PMaestro: TPanel
        Left = 0
        Top = 0
        Width = 773
        Height = 281
        Align = alTop
        BevelInner = bvLowered
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object LEmpresa_p: TLabel
          Left = 39
          Top = 16
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Empresa'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object btnEmpresa: TBGridButton
          Left = 174
          Top = 14
          Width = 13
          Height = 22
          Action = ADespegable
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          Control = empresa_f
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 240
          GridHeigth = 70
        end
        object LAno_semana_p: TLabel
          Left = 39
          Top = 38
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Formato Palet'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label1: TLabel
          Left = 39
          Top = 99
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Producto'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label2: TLabel
          Left = 39
          Top = 122
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' EAN13'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label3: TLabel
          Left = 386
          Top = 122
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Tipo Palet'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object btnProducto: TBGridButton
          Left = 174
          Top = 98
          Width = 13
          Height = 22
          Action = ADespegable
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          Control = productop_f
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 240
          GridHeigth = 100
        end
        object btnPalet: TBGridButton
          Left = 501
          Top = 120
          Width = 13
          Height = 22
          Action = ADespegable
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          Control = palet_f
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 240
          GridHeigth = 100
        end
        object Label5: TLabel
          Left = 39
          Top = 212
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Fecha Alta'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label6: TLabel
          Left = 386
          Top = 212
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Fecha Baja'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label7: TLabel
          Left = 39
          Top = 189
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Num. Cajas'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label8: TLabel
          Left = 386
          Top = 189
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Num. Paletas Pie'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label9: TLabel
          Left = 39
          Top = 59
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Descripci'#243'n'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label4: TLabel
          Left = 386
          Top = 100
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Art'#237'culo'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label10: TLabel
          Left = 39
          Top = 234
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Notas'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label16: TLabel
          Left = 39
          Top = 144
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Marca'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label17: TLabel
          Left = 39
          Top = 167
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Calibre'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label18: TLabel
          Left = 386
          Top = 167
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Color'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object btnMarca: TBGridButton
          Left = 174
          Top = 143
          Width = 13
          Height = 22
          Action = ADespegable
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          Control = marca_f
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 240
          GridHeigth = 100
        end
        object btnColor: TBGridButton
          Left = 501
          Top = 165
          Width = 13
          Height = 22
          Action = ADespegable
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          Control = color_f
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 240
          GridHeigth = 100
        end
        object Label19: TLabel
          Left = 386
          Top = 145
          Width = 90
          Height = 19
          AutoSize = False
          Caption = ' Categoria'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object btnCategoria: TBGridButton
          Left = 501
          Top = 144
          Width = 13
          Height = 22
          Action = ADespegable
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          Control = categoria_f
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 240
          GridHeigth = 170
        end
        object btnCalibre: TBGridButton
          Left = 224
          Top = 166
          Width = 13
          Height = 22
          Action = ADespegable
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          Control = calibre_f
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 240
          GridHeigth = 100
        end
        object descripcion_f: TDBMemo
          Left = 140
          Top = 59
          Width = 337
          Height = 38
          DataField = 'descripcion_f'
          DataSource = DSMaestro
          MaxLength = 255
          TabOrder = 3
          OnEnter = descripcion_fEnter
          OnExit = descripcion_fExit
        end
        object empresa_f: TBDEdit
          Tag = 1
          Left = 140
          Top = 15
          Width = 33
          Height = 21
          ColorEdit = clMoneyGreen
          Zeros = True
          MaxLength = 3
          TabOrder = 0
          OnChange = DescripcionMaestro
          DataField = 'empresa_f'
          DataSource = DSMaestro
          Modificable = False
          PrimaryKey = True
        end
        object stEmpresa: TStaticText
          Left = 189
          Top = 17
          Width = 211
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 14
        end
        object codigo_f: TBDEdit
          Left = 140
          Top = 37
          Width = 46
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 5
          TabOrder = 1
          OnEnter = codigo_fEnter
          DataField = 'codigo_f'
          DataSource = DSMaestro
          Modificable = False
          PrimaryKey = True
        end
        object productop_f: TBDEdit
          Left = 140
          Top = 98
          Width = 33
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 3
          TabOrder = 4
          OnChange = DescripcionMaestro
          DataField = 'productop_f'
          DataSource = DSMaestro
          Modificable = False
        end
        object nombre_f: TBDEdit
          Left = 189
          Top = 37
          Width = 288
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 50
          TabOrder = 2
          DataField = 'nombre_f'
          DataSource = DSMaestro
          Modificable = False
        end
        object palet_f: TBDEdit
          Left = 475
          Top = 121
          Width = 24
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 2
          TabOrder = 8
          OnChange = DescripcionMaestro
          DataField = 'palet_f'
          DataSource = DSMaestro
        end
        object stProducto: TStaticText
          Left = 189
          Top = 101
          Width = 190
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 15
        end
        object stTipoPalet: TStaticText
          Left = 516
          Top = 123
          Width = 246
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 16
        end
        object fecha_alta_f: TBDEdit
          Left = 140
          Top = 211
          Width = 109
          Height = 21
          ColorEdit = clMoneyGreen
          InputType = itDate
          MaxLength = 10
          TabOrder = 11
          DataField = 'fecha_alta_f'
          DataSource = DSMaestro
          Modificable = False
        end
        object fecha_baja_f: TBDEdit
          Left = 475
          Top = 211
          Width = 109
          Height = 21
          ColorEdit = clMoneyGreen
          InputType = itDate
          MaxLength = 10
          TabOrder = 12
          DataField = 'fecha_baja_f'
          DataSource = DSMaestro
          Modificable = False
        end
        object n_cajas_f: TBDEdit
          Left = 140
          Top = 188
          Width = 44
          Height = 21
          ColorEdit = clMoneyGreen
          InputType = itInteger
          MaxLength = 3
          TabOrder = 9
          DataField = 'n_cajas_f'
          DataSource = DSMaestro
          Modificable = False
        end
        object n_palets_pie_f: TBDEdit
          Left = 475
          Top = 188
          Width = 44
          Height = 21
          ColorEdit = clMoneyGreen
          InputType = itInteger
          MaxLength = 3
          TabOrder = 10
          DataField = 'n_palets_pie_f'
          DataSource = DSMaestro
          Modificable = False
        end
        object ean13_f: TBDEdit
          Tag = 1
          Left = 140
          Top = 121
          Width = 100
          Height = 21
          ColorEdit = clMoneyGreen
          Zeros = True
          MaxLength = 13
          TabOrder = 7
          DataField = 'ean13_f'
          DataSource = DSMaestro
          Modificable = False
          PrimaryKey = True
        end
        object stEnvase: TStaticText
          Left = 572
          Top = 99
          Width = 190
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 17
        end
        object notas_f: TDBMemo
          Left = 140
          Top = 234
          Width = 337
          Height = 38
          DataField = 'notas_f'
          DataSource = DSMaestro
          MaxLength = 255
          TabOrder = 13
          OnEnter = descripcion_fEnter
          OnExit = descripcion_fExit
        end
        object marca_f: TBDEdit
          Left = 140
          Top = 143
          Width = 24
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 2
          TabOrder = 18
          OnChange = DescripcionMaestro
          DataField = 'marca_f'
          DataSource = DSMaestro
          Modificable = False
        end
        object color_f: TBDEdit
          Left = 475
          Top = 166
          Width = 24
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 2
          TabOrder = 19
          OnChange = DescripcionMaestro
          DataField = 'color_f'
          DataSource = DSMaestro
        end
        object stMarca: TStaticText
          Left = 189
          Top = 146
          Width = 190
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 20
        end
        object stColor: TStaticText
          Left = 516
          Top = 168
          Width = 190
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 21
        end
        object calibre_f: TBDEdit
          Tag = 1
          Left = 140
          Top = 166
          Width = 83
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 10
          TabOrder = 22
          DataField = 'calibre_f'
          DataSource = DSMaestro
          Modificable = False
          PrimaryKey = True
        end
        object categoria_f: TBDEdit
          Tag = 1
          Left = 475
          Top = 145
          Width = 24
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 2
          TabOrder = 23
          OnChange = DescripcionMaestro
          DataField = 'categoria_f'
          DataSource = DSMaestro
          Modificable = False
          PrimaryKey = True
        end
        object stCategoria: TStaticText
          Left = 516
          Top = 146
          Width = 246
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 24
        end
        object ssEnvase: TSimpleSearch
          Left = 550
          Top = 98
          Width = 21
          Height = 21
          Hint = 'B'#250'squeda de Art'#237'culo'
          TabOrder = 6
          TabStop = False
          LookAndFeel.NativeStyle = False
          LookAndFeel.SkinName = 'MoneyTwins'
          OptionsImage.ImageIndex = 2
          OptionsImage.Images = FDM.ilxImagenes
          Titulo = 'Busqueda de Art'#237'culos'
          Tabla = 'frf_envases'
          Campos = <
            item
              Etiqueta = 'Art'#237'culo'
              Campo = 'envase_e'
              Ancho = 100
              Tipo = ctCadena
            end
            item
              Etiqueta = 'Descripci'#243'n'
              Campo = 'descripcion_e'
              Ancho = 400
              Tipo = ctCadena
            end>
          Database = 'BDProyecto'
          Join = 'fecha_baja_e is null'
          CampoResultado = 'envase_e'
          Enlace = envase_f
          Tecla = 'F2'
          AntesEjecutar = ssEnvaseAntesEjecutar
          Concatenar = False
        end
        object envase_f: TcxDBTextEdit
          Left = 475
          Top = 98
          DataBinding.DataField = 'envase_f'
          DataBinding.DataSource = DSMaestro
          Properties.CharCase = ecUpperCase
          Properties.MaxLength = 9
          Properties.OnChange = DescripcionMaestro
          Style.BorderStyle = ebs3D
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 5
          OnExit = envase_fExit
          Width = 75
        end
      end
      object PDetalle: TPanel
        Left = 0
        Top = 281
        Width = 773
        Height = 184
        Align = alClient
        TabOrder = 1
        object PDatosDetalle: TPanel
          Left = 1
          Top = 1
          Width = 771
          Height = 104
          Align = alTop
          TabOrder = 0
          object Label11: TLabel
            Left = 24
            Top = 52
            Width = 90
            Height = 19
            AutoSize = False
            Caption = ' Formato Cliente'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object Label12: TLabel
            Left = 24
            Top = 10
            Width = 90
            Height = 19
            AutoSize = False
            Caption = ' Cliente'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object btnCliente: TBGridButton
            Left = 159
            Top = 8
            Width = 13
            Height = 22
            Action = ADespegable
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
              0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            Control = cliente_fc
            Grid = RejillaFlotante
            GridAlignment = taDownRight
            GridWidth = 240
            GridHeigth = 170
          end
          object Label13: TLabel
            Left = 24
            Top = 31
            Width = 90
            Height = 19
            AutoSize = False
            Caption = ' Suministro'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object btnSuministro: TBGridButton
            Left = 159
            Top = 29
            Width = 13
            Height = 22
            Action = ADespegable
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
              0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            Control = suministro_fc
            Grid = RejillaFlotante
            GridAlignment = taDownRight
            GridWidth = 240
            GridHeigth = 170
          end
          object Label14: TLabel
            Left = 24
            Top = 74
            Width = 90
            Height = 19
            AutoSize = False
            Caption = ' Unidad Pedido'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object Label15: TLabel
            Left = 145
            Top = 77
            Width = 163
            Height = 13
            Caption = '( C: Cajas - U: Unidades - K: Kilos )'
          end
          object formato_cliente_fc: TBDEdit
            Left = 125
            Top = 51
            Width = 100
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 16
            TabOrder = 2
            DataField = 'formato_cliente_fc'
            DataSource = DSDetalle
            Modificable = False
            PrimaryKey = True
          end
          object descripcion_fc: TBDEdit
            Left = 229
            Top = 51
            Width = 274
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 30
            TabOrder = 3
            DataField = 'descripcion_fc'
            DataSource = DSDetalle
            Modificable = False
          end
          object cliente_fc: TBDEdit
            Tag = 1
            Left = 125
            Top = 9
            Width = 33
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 3
            TabOrder = 0
            OnChange = DescripcionDetalle
            DataField = 'cliente_fc'
            DataSource = DSDetalle
            Modificable = False
          end
          object stCliente: TStaticText
            Left = 174
            Top = 11
            Width = 220
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 5
          end
          object suministro_fc: TBDEdit
            Tag = 1
            Left = 125
            Top = 30
            Width = 33
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 3
            TabOrder = 1
            OnChange = suministro_fcChange
            DataField = 'suministro_fc'
            DataSource = DSDetalle
            Modificable = False
          end
          object stSuministro: TStaticText
            Left = 174
            Top = 32
            Width = 220
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 6
          end
          object unidad_pedido_fc: TBDEdit
            Tag = 1
            Left = 125
            Top = 73
            Width = 15
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 1
            TabOrder = 4
            OnChange = DescripcionMaestro
            DataField = 'unidad_pedido_fc'
            DataSource = DSDetalle
            Modificable = False
          end
        end
        object gridDetalle: TDBGrid
          Left = 1
          Top = 105
          Width = 771
          Height = 78
          Align = alClient
          DataSource = DSDetalle
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = AModificarDetExecute
          Columns = <
            item
              Expanded = False
              FieldName = 'cliente_fc'
              ImeName = 'cliente_fc'
              Title.Caption = 'Cliente'
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'suministro_fc'
              Title.Caption = 'Suminis.'
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'formato_cliente_fc'
              Title.Caption = 'F. Cliente'
              Width = 124
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'descripcion_fc'
              Title.Caption = 'Descripci'#243'n'
              Width = 202
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'unidad_pedido_fc'
              Title.Caption = 'Unidad'
              Width = 50
              Visible = True
            end>
        end
      end
    end
    object tsBusqueda: TTabSheet
      Caption = 'BUSQUEDA'
      ImageIndex = 1
      OnShow = tsBusquedaShow
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 773
        Height = 465
        Align = alClient
        DataSource = DSMaestro
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'empresa_f'
            Title.Caption = 'Empresa'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'codigo_f'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'productop_f'
            Title.Caption = 'Producto'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nombre_f'
            Title.Caption = 'Formato'
            Width = 248
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'palet_f'
            Title.Caption = 'Palet'
            Visible = True
          end>
      end
    end
  end
  object RejillaFlotante: TBGrid
    Left = 487
    Top = 54
    Width = 83
    Height = 70
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object DSMaestro: TDataSource
    DataSet = DMFormatoPalets.QMaestro
    Left = 336
    Top = 80
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBarraHerramientas
    Left = 384
    Top = 280
    object ASalir: TAction
      Caption = 'Salir'
      ImageIndex = 18
      OnExecute = ASalirExecute
    end
    object AAceptar: TAction
      Caption = 'Aceptar'
      ImageIndex = 16
      ShortCut = 116
      OnExecute = AAceptarExecute
    end
    object ACancelar: TAction
      Caption = 'Cancelar'
      ImageIndex = 17
      OnExecute = ACancelarExecute
    end
    object ALocalizar: TAction
      Caption = 'ALocalizar'
      ImageIndex = 8
      ShortCut = 76
      OnExecute = ALocalizarExecute
    end
    object AModificarCab: TAction
      Caption = 'Modificar'
      ImageIndex = 9
      ShortCut = 77
      OnExecute = AModificarCabExecute
    end
    object ABorrarCab: TAction
      Caption = 'Borrar'
      ImageIndex = 10
      ShortCut = 66
      OnExecute = ABorrarCabExecute
    end
    object AInsertarCab: TAction
      Caption = 'Insertar'
      ImageIndex = 11
      ShortCut = 65
      OnExecute = AInsertarCabExecute
    end
    object AModificarDet: TAction
      Caption = 'Modificar'
      ImageIndex = 13
      ShortCut = 8269
      OnExecute = AModificarDetExecute
    end
    object ABorrarDet: TAction
      Caption = 'Borrar'
      ImageIndex = 14
      ShortCut = 8258
      OnExecute = ABorrarDetExecute
    end
    object AInsertarDet: TAction
      Caption = 'Insertar'
      ImageIndex = 15
      ShortCut = 8257
      OnExecute = AInsertarDetExecute
    end
    object APrimero: TAction
      Caption = 'Primero'
      ImageIndex = 0
      ShortCut = 36
      OnExecute = APrimeroExecute
    end
    object AAnterior: TAction
      Caption = 'Anterior'
      ImageIndex = 1
      OnExecute = AAnteriorExecute
    end
    object ASiguiente: TAction
      Caption = 'Siguiente'
      ImageIndex = 2
      OnExecute = ASiguienteExecute
    end
    object AUltimo: TAction
      Caption = 'Ultimo'
      ImageIndex = 3
      ShortCut = 35
      OnExecute = AUltimoExecute
    end
    object AImprimir: TAction
      Caption = 'Imprimir'
      ImageIndex = 19
      ShortCut = 73
      OnExecute = AImprimirExecute
    end
    object ADespegable: TAction
      ImageIndex = 24
      ShortCut = 113
      OnExecute = ADespegableExecute
    end
  end
  object DSDetalle: TDataSource
    DataSet = DMFormatoPalets.QDetalle
    Left = 352
    Top = 280
  end
end
