object FDRecibirEntregasCentral: TFDRecibirEntregasCentral
  Left = 538
  Top = 144
  BorderIcons = [biHelp]
  BorderStyle = bsSingle
  Caption = '    RECEPCI'#211'N DE ENTREGAS'
  ClientHeight = 400
  ClientWidth = 412
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbtxtCentro: TDBText
    Left = 239
    Top = 165
    Width = 90
    Height = 17
    DataField = 'des_Centro'
    DataSource = DSEntregasPendientes
  end
  object lblCentro: TnbLabel
    Left = 146
    Top = 165
    Width = 90
    Height = 21
    Caption = 'Centro Descarga'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 146
    Top = 190
    Width = 90
    Height = 21
    Caption = 'C'#243'digo'
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
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = empresa
    OnGetDescription = nomEmpresaGetDescription
  end
  object btnOk: TSpeedButton
    Left = 136
    Top = 15
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
  object nbLabel3: TnbLabel
    Left = 146
    Top = 214
    Width = 90
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object nbLabel5: TnbLabel
    Left = 146
    Top = 238
    Width = 90
    Height = 21
    Caption = 'Albar'#225'n'
    About = 'NB 0.1/20020725'
  end
  object nbLabel6: TnbLabel
    Left = 146
    Top = 286
    Width = 90
    Height = 21
    Caption = 'Fecha Carga'
    About = 'NB 0.1/20020725'
  end
  object nbLabel7: TnbLabel
    Left = 146
    Top = 310
    Width = 90
    Height = 21
    Caption = 'Fecha LLegada'
    About = 'NB 0.1/20020725'
  end
  object nbLabel8: TnbLabel
    Left = 146
    Top = 334
    Width = 90
    Height = 21
    Caption = 'Fact. Conduce'
    About = 'NB 0.1/20020725'
  end
  object nbLabel9: TnbLabel
    Left = 146
    Top = 358
    Width = 90
    Height = 21
    Caption = 'Veh'#237'culo'
    About = 'NB 0.1/20020725'
  end
  object DBText1: TDBText
    Left = 239
    Top = 192
    Width = 145
    Height = 17
    DataField = 'codigo'
    DataSource = DSEntregasPendientes
  end
  object DBText2: TDBText
    Left = 239
    Top = 216
    Width = 145
    Height = 17
    DataField = 'proveedor'
    DataSource = DSEntregasPendientes
  end
  object DBText4: TDBText
    Left = 239
    Top = 240
    Width = 145
    Height = 17
    DataField = 'albaran'
    DataSource = DSEntregasPendientes
  end
  object DBText5: TDBText
    Left = 239
    Top = 288
    Width = 145
    Height = 17
    DataField = 'carga'
    DataSource = DSEntregasPendientes
  end
  object DBText6: TDBText
    Left = 239
    Top = 312
    Width = 145
    Height = 17
    DataField = 'llegada'
    DataSource = DSEntregasPendientes
  end
  object DBText7: TDBText
    Left = 239
    Top = 336
    Width = 145
    Height = 17
    DataField = 'conduce'
    DataSource = DSEntregasPendientes
  end
  object DBText8: TDBText
    Left = 239
    Top = 360
    Width = 172
    Height = 17
    DataField = 'vehiculo'
    DataSource = DSEntregasPendientes
  end
  object nbLabel10: TnbLabel
    Left = 32
    Top = 141
    Width = 352
    Height = 21
    Caption = 'Seleccione entregas pendientes que quiere recibir'
    About = 'NB 0.1/20020725'
  end
  object nbLabel11: TnbLabel
    Left = 32
    Top = 95
    Width = 100
    Height = 21
    Caption = 'Fecha llegada desde'
    About = 'NB 0.1/20020725'
  end
  object nbLabel12: TnbLabel
    Left = 229
    Top = 95
    Width = 62
    Height = 21
    Caption = 'Hasta'
    About = 'NB 0.1/20020725'
  end
  object lblCentroLlegada: TnbLabel
    Left = 32
    Top = 71
    Width = 100
    Height = 21
    Caption = 'Centro LLegada'
    About = 'NB 0.1/20020725'
  end
  object stCentro: TnbStaticText
    Left = 194
    Top = 71
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = edtCentro
    OnGetDescription = stCentroGetDescription
  end
  object lblAnyoSemana: TnbLabel
    Left = 146
    Top = 262
    Width = 90
    Height = 21
    Caption = 'A'#241'o/Semana'
    About = 'NB 0.1/20020725'
  end
  object dlblAnyoSemana: TDBText
    Left = 239
    Top = 264
    Width = 145
    Height = 17
    HelpType = htKeyword
    DataField = 'anyo_semana'
    DataSource = DSEntregasPendientes
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
    OnlyNumbers = False
    NumChars = 3
  end
  object clbEntregas: TCheckListBox
    Left = 32
    Top = 165
    Width = 110
    Height = 215
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 5
    OnClick = clbEntregasClick
  end
  object edtCentro: TnbDBSQLCombo
    Left = 136
    Top = 71
    Width = 38
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtCentroChange
    TabOrder = 1
    SQL.Strings = (
      '')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnGetSQL = edtCentroGetSQL
    FillAuto = True
    NumChars = 1
  end
  object fechaHasta: TnbDBCalendarCombo
    Left = 294
    Top = 95
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '10/03/2009'
    TabOrder = 3
  end
  object fechaDesde: TnbDBCalendarCombo
    Left = 136
    Top = 95
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '10/03/2009'
    TabOrder = 2
  end
  object chkFechaDefinitiva: TCheckBox
    Left = 136
    Top = 120
    Width = 161
    Height = 17
    Caption = 'Fecha Definitiva Marcada'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object QEntregasPendientes: TQuery
    DatabaseName = 'BDCentral'
    Left = 88
    Top = 213
  end
  object DSEntregasPendientes: TDataSource
    DataSet = QEntregasPendientes
    Left = 120
    Top = 213
  end
  object PopupMenu1: TPopupMenu
    Left = 40
    Top = 181
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
