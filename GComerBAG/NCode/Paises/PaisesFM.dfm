object FMPaises: TFMPaises
  Left = 483
  Top = 160
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  PAISES'
  ClientHeight = 461
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
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
    Width = 440
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
    object btnImprimir: TToolButton
      Left = 120
      Top = 0
      Action = AImprimir
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton4: TToolButton
      Left = 144
      Top = 0
      Width = 24
      Caption = 'ToolButton4'
      ImageIndex = 19
      Style = tbsDivider
    end
    object btnPrimero: TToolButton
      Left = 168
      Top = 0
      Action = APrimero
      ParentShowHint = False
      ShowHint = True
    end
    object btnAnterior: TToolButton
      Left = 192
      Top = 0
      Action = AAnterior
      ParentShowHint = False
      ShowHint = True
    end
    object btnSiguiente: TToolButton
      Left = 216
      Top = 0
      Action = ASiguiente
      ParentShowHint = False
      ShowHint = True
    end
    object btnUltimo: TToolButton
      Left = 240
      Top = 0
      Action = AUltimo
      ParentShowHint = False
      ShowHint = True
    end
    object TBMaestroDetalleSeparador2: TToolButton
      Left = 264
      Top = 0
      Width = 24
      Caption = 'TBMaestroDetalleSeparador2'
      ParentShowHint = False
      ShowHint = True
      Style = tbsDivider
    end
    object btnAceptar: TToolButton
      Left = 288
      Top = 0
      Action = AAceptar
      ParentShowHint = False
      ShowHint = True
    end
    object btnCancelar: TToolButton
      Left = 312
      Top = 0
      Action = ACancelar
      ParentShowHint = False
      ShowHint = True
    end
    object TBMaestroDetalleSeparador5: TToolButton
      Left = 336
      Top = 0
      Width = 24
      Caption = 'TBMaestroDetalleSeparador5'
      ImageIndex = 21
      ParentShowHint = False
      ShowHint = True
      Style = tbsDivider
    end
    object btnSalir: TToolButton
      Left = 360
      Top = 0
      Action = ASalir
      ParentShowHint = False
      ShowHint = True
    end
  end
  object PMaestro: TPanel
    Left = 0
    Top = 22
    Width = 440
    Height = 150
    Align = alTop
    TabOrder = 1
    object Label4: TLabel
      Left = 39
      Top = 11
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnMoneda: TBGridButton
      Left = 174
      Top = 82
      Width = 13
      Height = 22
      Action = ADespegable
      Enabled = False
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
      Control = moneda_p
      GridAlignment = taDownRight
      GridWidth = 240
      GridHeigth = 70
    end
    object Label10: TLabel
      Left = 39
      Top = 35
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Nombre Espa'#241'ol'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 39
      Top = 83
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Moneda'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 39
      Top = 59
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Nombre Original'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 39
      Top = 107
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Comunitario'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object pais_p: TBDEdit
      Tag = 1
      Left = 140
      Top = 11
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      MaxLength = 2
      TabOrder = 0
      DataField = 'pais_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object stMoneda: TStaticText
      Left = 189
      Top = 84
      Width = 211
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 4
    end
    object descripcion_p: TBDEdit
      Tag = 1
      Left = 140
      Top = 35
      Width = 260
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      MaxLength = 30
      TabOrder = 1
      DataField = 'descripcion_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object moneda_p: TBDEdit
      Tag = 1
      Left = 140
      Top = 83
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      MaxLength = 3
      TabOrder = 3
      OnChange = DescripcionMaestro
      DataField = 'moneda_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object original_name_p: TBDEdit
      Tag = 1
      Left = 140
      Top = 59
      Width = 260
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      MaxLength = 30
      TabOrder = 2
      DataField = 'original_name_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object comunitario_p: TDBCheckBox
      Left = 140
      Top = 108
      Width = 97
      Height = 17
      DataField = 'comunitario_p'
      DataSource = DSMaestro
      TabOrder = 5
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  object gridMaestro: TDBGrid
    Left = 0
    Top = 172
    Width = 440
    Height = 289
    Align = alClient
    DataSource = DSMaestro
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = gridMaestroDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'pais_p'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion_p'
        Title.Caption = 'Nombre'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'moneda_p'
        Title.Caption = 'Moneda'
        Visible = True
      end>
  end
  object BGrid1: TBGrid
    Left = 190
    Top = 125
    Width = 50
    Height = 25
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    BControl = moneda_p
  end
  object DSMaestro: TDataSource
    DataSet = DMPaises.QMaestro
    Left = 336
    Top = 80
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBarraHerramientas
    Left = 360
    Top = 248
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
end
