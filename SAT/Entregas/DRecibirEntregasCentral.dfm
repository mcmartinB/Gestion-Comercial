object FDRecibirEntregasCentral: TFDRecibirEntregasCentral
  Left = 470
  Top = 237
  ActiveControl = fechaHasta
  BorderIcons = [biHelp]
  BorderStyle = bsSingle
  Caption = '    RECEPCI'#211'N DE ENTREGAS'
  ClientHeight = 429
  ClientWidth = 419
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
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object nbLabel1: TnbLabel
    Left = 32
    Top = 48
    Width = 100
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nomEmpresa: TnbStaticText
    Left = 194
    Top = 48
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = empresa
    OnGetDescription = nomEmpresaGetDescription
  end
  object btnOk: TSpeedButton
    Left = 138
    Top = 17
    Width = 127
    Height = 25
    Caption = 'Recibir Pendientes (F1)'
    OnClick = BtnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 264
    Top = 15
    Width = 120
    Height = 25
    Caption = 'Cerrar (Esc)'
    OnClick = BtnCancelClick
  end
  object nbLabel2: TnbLabel
    Left = 146
    Top = 144
    Width = 90
    Height = 21
    Caption = 'C'#243'digo'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 146
    Top = 168
    Width = 90
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 146
    Top = 192
    Width = 90
    Height = 21
    Caption = 'Almac'#233'n'
    About = 'NB 0.1/20020725'
  end
  object nbLabel5: TnbLabel
    Left = 146
    Top = 216
    Width = 90
    Height = 21
    Caption = 'Albar'#225'n'
    About = 'NB 0.1/20020725'
  end
  object nbLabel6: TnbLabel
    Left = 146
    Top = 240
    Width = 90
    Height = 21
    Caption = 'Fecha Carga'
    About = 'NB 0.1/20020725'
  end
  object nbLabel7: TnbLabel
    Left = 146
    Top = 264
    Width = 90
    Height = 21
    Caption = 'Fecha LLegada'
    About = 'NB 0.1/20020725'
  end
  object nbLabel8: TnbLabel
    Left = 146
    Top = 288
    Width = 90
    Height = 21
    Caption = 'Fact. Conduce'
    About = 'NB 0.1/20020725'
  end
  object nbLabel9: TnbLabel
    Left = 146
    Top = 312
    Width = 90
    Height = 21
    Caption = 'Veh'#237'culo'
    About = 'NB 0.1/20020725'
  end
  object DBText1: TDBText
    Left = 239
    Top = 146
    Width = 145
    Height = 17
    DataField = 'codigo'
    DataSource = DSEntregasPendientes
  end
  object DBText2: TDBText
    Left = 239
    Top = 170
    Width = 145
    Height = 17
    DataField = 'proveedor'
    DataSource = DSEntregasPendientes
  end
  object DBText3: TDBText
    Left = 239
    Top = 194
    Width = 145
    Height = 17
    DataField = 'almacen'
    DataSource = DSEntregasPendientes
  end
  object DBText4: TDBText
    Left = 239
    Top = 218
    Width = 145
    Height = 17
    DataField = 'albaran'
    DataSource = DSEntregasPendientes
  end
  object DBText5: TDBText
    Left = 239
    Top = 242
    Width = 145
    Height = 17
    DataField = 'carga'
    DataSource = DSEntregasPendientes
  end
  object DBText6: TDBText
    Left = 239
    Top = 266
    Width = 145
    Height = 17
    DataField = 'llegada'
    DataSource = DSEntregasPendientes
  end
  object DBText7: TDBText
    Left = 239
    Top = 290
    Width = 145
    Height = 17
    DataField = 'conduce'
    DataSource = DSEntregasPendientes
  end
  object DBText8: TDBText
    Left = 239
    Top = 314
    Width = 145
    Height = 17
    DataField = 'vehiculo'
    DataSource = DSEntregasPendientes
  end
  object nbLabel10: TnbLabel
    Left = 32
    Top = 120
    Width = 352
    Height = 21
    Caption = 'Seleccione entregas pendientes que quiere recibir'
    About = 'NB 0.1/20020725'
  end
  object nbLabel11: TnbLabel
    Left = 32
    Top = 97
    Width = 100
    Height = 21
    Caption = 'Fecha llegada desde'
    About = 'NB 0.1/20020725'
  end
  object nbLabel12: TnbLabel
    Left = 229
    Top = 97
    Width = 62
    Height = 21
    Caption = 'Hasta'
    About = 'NB 0.1/20020725'
  end
  object nbLabel13: TnbLabel
    Left = 32
    Top = 72
    Width = 100
    Height = 21
    Caption = 'Centro'
    About = 'NB 0.1/20020725'
  end
  object btnCentro: TBGridButton
    Left = 167
    Top = 70
    Width = 21
    Height = 21
    Action = ADesplegarRejilla
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
    Control = centro
    Grid = RejillaFlotante
    GridAlignment = taDownCenter
    GridWidth = 280
    GridHeigth = 200
  end
  object nomCentro: TnbStaticText
    Left = 194
    Top = 70
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object empresa: TnbDBSQLCombo
    Left = 136
    Top = 48
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = empresaChange
    TabOrder = 0
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    FillAuto = True
    NumChars = 3
  end
  object clbEntregas: TCheckListBox
    Left = 32
    Top = 144
    Width = 110
    Height = 192
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 3
    OnClick = clbEntregasClick
  end
  object fechaDesde: TnbDBCalendarCombo
    Left = 136
    Top = 97
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '10/03/2009'
    TabOrder = 1
  end
  object fechaHasta: TnbDBCalendarCombo
    Left = 294
    Top = 97
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '10/03/2009'
    TabOrder = 2
  end
  object centro: TBEdit
    Left = 136
    Top = 69
    Width = 31
    Height = 21
    ColorEdit = clMoneyGreen
    ColorDisable = clBtnFace
    Zeros = True
    Required = True
    MaxLength = 1
    TabOrder = 4
    OnChange = centroChange
  end
  object RejillaFlotante: TBGrid
    Left = 395
    Top = 169
    Width = 120
    Height = 135
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object QEntregasPendientes: TQuery
    DatabaseName = 'BDCentral'
    Left = 88
    Top = 192
  end
  object DSEntregasPendientes: TDataSource
    DataSet = QEntregasPendientes
    Left = 120
    Top = 192
  end
  object PopupMenu1: TPopupMenu
    Left = 40
    Top = 160
    object SeleccionarTodo1: TMenuItem
      Caption = 'Seleccionar Todo'
      OnClick = SeleccionarTodo1Click
    end
    object DesmarcarSeleccion1: TMenuItem
      Caption = 'Desmarcar Selecci'#243'n'
      OnClick = DesmarcarSeleccion1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MarcarEntregaSeleccionadaComoEnviada1: TMenuItem
      Caption = 'Marcar Entregas Seleccionadas Como Recibidas'
      OnClick = MarcarEntregaSeleccionadaComoEnviada1Click
    end
  end
  object ListaAcciones: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 27
    Top = 13
    object BAceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
    end
    object BCancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
    end
    object ADesplegarRejilla: TAction
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ADesplegarRejillaExecute
    end
  end
end
