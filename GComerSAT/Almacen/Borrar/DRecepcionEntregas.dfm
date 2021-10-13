object FDRecepcionEntregas: TFDRecepcionEntregas
  Left = 540
  Top = 264
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    RECEPCI'#211'N DE ENTREGAS'
  ClientHeight = 226
  ClientWidth = 421
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
    Top = 24
    Width = 100
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 32
    Top = 48
    Width = 100
    Height = 21
    Caption = 'Centro LLegada'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 32
    Top = 119
    Width = 100
    Height = 21
    Caption = 'Fecha Carga'
    About = 'NB 0.1/20020725'
  end
  object nomEmpresa: TnbStaticText
    Left = 194
    Top = 24
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = empresa
    OnGetDescription = nomEmpresaGetDescription
  end
  object nomCentroLlegada: TnbStaticText
    Left = 194
    Top = 48
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = centroLlegada
    OnGetDescription = nomCentroLlegadaGetDescription
  end
  object btnOk: TSpeedButton
    Left = 196
    Top = 175
    Width = 99
    Height = 25
    Caption = 'Recibir (F1)'
    OnClick = BtnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 296
    Top = 175
    Width = 99
    Height = 25
    Caption = 'Cerrar (Esc)'
    OnClick = BtnCancelClick
  end
  object lblMessage: TLabel
    Left = 136
    Top = 151
    Width = 53
    Height = 13
    Caption = 'lblMessage'
  end
  object nbLabel4: TnbLabel
    Left = 32
    Top = 72
    Width = 100
    Height = 21
    Caption = 'Fecha LLegada'
    About = 'NB 0.1/20020725'
  end
  object nbLabel5: TnbLabel
    Left = 32
    Top = 96
    Width = 100
    Height = 21
    Caption = 'Factura Conduce'
    About = 'NB 0.1/20020725'
  end
  object btnEntregasPendientes: TSpeedButton
    Left = 229
    Top = 72
    Width = 155
    Height = 21
    Caption = 'Pendientes (F2)'
    OnClick = btnEntregasPendientesClick
  end
  object empresa: TnbDBSQLCombo
    Left = 136
    Top = 24
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
  object centroLlegada: TnbDBSQLCombo
    Left = 136
    Top = 48
    Width = 38
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = centroLlegadaChange
    TabOrder = 1
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnGetSQL = centroLlegadaGetSQL
    NumChars = 1
  end
  object fechaCarga: TnbDBCalendarCombo
    Left = 136
    Top = 119
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '26/07/2007'
    TabOrder = 4
  end
  object fechaLlegada: TnbDBCalendarCombo
    Left = 136
    Top = 72
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '27/02/2004'
    TabOrder = 2
  end
  object eFactura: TBEdit
    Left = 135
    Top = 96
    Width = 90
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 10
    TabOrder = 3
  end
  object dbgEntregasPendientes: TDBGrid
    Left = 136
    Top = 8
    Width = 278
    Height = 209
    DataSource = DMRecepcionEntregasForm.DSEntregasPendientes
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    OnDblClick = dbgEntregasPendientesDblClick
    OnExit = dbgEntregasPendientesExit
    OnKeyUp = dbgEntregasPendientesKeyUp
  end
end
