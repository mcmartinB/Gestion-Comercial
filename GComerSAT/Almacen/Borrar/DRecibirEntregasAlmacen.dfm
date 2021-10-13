object FDRecibirEntregasAlmacen: TFDRecibirEntregasAlmacen
  Left = 535
  Top = 297
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    RECEPCI'#211'N DE ENTREGAS'
  ClientHeight = 339
  ClientWidth = 512
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
  object btnOk: TSpeedButton
    Left = 231
    Top = 15
    Width = 127
    Height = 25
    Caption = 'Recibir Pendientes (F1)'
    OnClick = BtnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 359
    Top = 15
    Width = 120
    Height = 25
    Caption = 'Cerrar (Esc)'
    OnClick = BtnCancelClick
  end
  object nbLabel2: TnbLabel
    Left = 242
    Top = 118
    Width = 90
    Height = 21
    Caption = 'C'#243'digo'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 242
    Top = 142
    Width = 90
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 242
    Top = 166
    Width = 90
    Height = 21
    Caption = 'Almac'#233'n'
    About = 'NB 0.1/20020725'
  end
  object nbLabel5: TnbLabel
    Left = 242
    Top = 190
    Width = 90
    Height = 21
    Caption = 'Albar'#225'n'
    About = 'NB 0.1/20020725'
  end
  object nbLabel6: TnbLabel
    Left = 242
    Top = 214
    Width = 90
    Height = 21
    Caption = 'Fecha Carga'
    About = 'NB 0.1/20020725'
  end
  object nbLabel7: TnbLabel
    Left = 242
    Top = 238
    Width = 90
    Height = 21
    Caption = 'Fecha LLegada'
    About = 'NB 0.1/20020725'
  end
  object nbLabel8: TnbLabel
    Left = 242
    Top = 262
    Width = 90
    Height = 21
    Caption = 'Fact. Conduce'
    About = 'NB 0.1/20020725'
  end
  object nbLabel9: TnbLabel
    Left = 242
    Top = 286
    Width = 90
    Height = 21
    Caption = 'Veh'#237'culo'
    About = 'NB 0.1/20020725'
  end
  object DBText1: TDBText
    Left = 335
    Top = 120
    Width = 145
    Height = 17
    DataField = 'codigo'
    DataSource = DSEntregasPendientes
  end
  object DBText2: TDBText
    Left = 335
    Top = 144
    Width = 145
    Height = 17
    DataField = 'proveedor'
    DataSource = DSEntregasPendientes
  end
  object DBText3: TDBText
    Left = 335
    Top = 168
    Width = 145
    Height = 17
    DataField = 'almacen'
    DataSource = DSEntregasPendientes
  end
  object DBText4: TDBText
    Left = 335
    Top = 192
    Width = 145
    Height = 17
    DataField = 'albaran'
    DataSource = DSEntregasPendientes
  end
  object DBText5: TDBText
    Left = 335
    Top = 216
    Width = 145
    Height = 17
    DataField = 'carga'
    DataSource = DSEntregasPendientes
  end
  object DBText6: TDBText
    Left = 335
    Top = 240
    Width = 145
    Height = 17
    DataField = 'llegada'
    DataSource = DSEntregasPendientes
  end
  object DBText7: TDBText
    Left = 335
    Top = 264
    Width = 145
    Height = 17
    DataField = 'conduce'
    DataSource = DSEntregasPendientes
  end
  object DBText8: TDBText
    Left = 335
    Top = 288
    Width = 145
    Height = 17
    DataField = 'vehiculo'
    DataSource = DSEntregasPendientes
  end
  object nbLabel10: TnbLabel
    Left = 32
    Top = 94
    Width = 448
    Height = 21
    Caption = 'Seleccione entregas pendientes que quiere recibir'
    About = 'NB 0.1/20020725'
  end
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
    Width = 285
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = eEmpresa
    OnGetDescription = nomEmpresaGetDescription
  end
  object nbLabel11: TnbLabel
    Left = 32
    Top = 71
    Width = 100
    Height = 21
    Caption = 'Centro LLegada'
    About = 'NB 0.1/20020725'
  end
  object nomCentro: TnbStaticText
    Left = 194
    Top = 71
    Width = 285
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = eCentro
    OnGetDescription = nomCentroGetDescription
  end
  object clbEntregas: TCheckListBox
    Left = 32
    Top = 118
    Width = 201
    Height = 192
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnClick = clbEntregasClick
  end
  object eEmpresa: TnbDBSQLCombo
    Left = 136
    Top = 48
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eEmpresaChange
    TabOrder = 1
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    FillAuto = True
    NumChars = 3
  end
  object eCentro: TnbDBSQLCombo
    Left = 136
    Top = 71
    Width = 38
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eCentroChange
    TabOrder = 2
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    FillAuto = True
    NumChars = 1
  end
  object QEntregasPendientes: TQuery
    DatabaseName = 'BDCentral'
    Left = 88
    Top = 166
  end
  object DSEntregasPendientes: TDataSource
    DataSet = QEntregasPendientes
    Left = 120
    Top = 166
  end
  object PopupMenu1: TPopupMenu
    Left = 40
    Top = 134
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
end
