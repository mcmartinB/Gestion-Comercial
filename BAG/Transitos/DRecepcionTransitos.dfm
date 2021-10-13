object FDRecepcionTransitos: TFDRecepcionTransitos
  Left = 887
  Top = 262
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    RECEPCI'#211'N DE TR'#193'NSITOS'
  ClientHeight = 291
  ClientWidth = 422
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
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblPlantaOrigen: TnbLabel
    Left = 32
    Top = 24
    Width = 100
    Height = 21
    Caption = 'Planta Origen'
    About = 'NB 0.1/20020725'
  end
  object lblCentroOrigen: TnbLabel
    Left = 32
    Top = 48
    Width = 100
    Height = 21
    Caption = 'Centro Origen'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 32
    Top = 72
    Width = 100
    Height = 21
    Caption = 'Fecha Transito'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 32
    Top = 96
    Width = 100
    Height = 21
    Caption = 'Ref. Tr'#225'nsito'
    About = 'NB 0.1/20020725'
  end
  object stPlantaOrigen: TnbStaticText
    Left = 194
    Top = 24
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = edtPlantaOrigen
    OnGetDescription = stPlantaOrigenGetDescription
  end
  object stCentroOrigen: TnbStaticText
    Left = 194
    Top = 48
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = edtCentroOrigen
    OnGetDescription = stCentroOrigenGetDescription
  end
  object btnOk: TSpeedButton
    Left = 196
    Top = 223
    Width = 99
    Height = 25
    Caption = 'Copiar'
    OnClick = BtnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 296
    Top = 223
    Width = 99
    Height = 25
    Caption = 'Cerrar'
    OnClick = BtnCancelClick
  end
  object lblMessage: TLabel
    Left = 32
    Top = 201
    Width = 382
    Height = 13
    Caption = 'RECUERDE ACTIVAR EL TR'#193'NSITO CUANDO SE RECIBA EN EL ALMAC'#201'N.'
  end
  object lblPlantaDestino: TnbLabel
    Left = 32
    Top = 120
    Width = 100
    Height = 21
    Caption = 'Planta Destino'
    About = 'NB 0.1/20020725'
  end
  object lblCentroDestino: TnbLabel
    Left = 32
    Top = 144
    Width = 100
    Height = 21
    Caption = 'Centro Destino'
    About = 'NB 0.1/20020725'
  end
  object stPlantaDestino: TnbStaticText
    Left = 194
    Top = 120
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = edtPlantaDestino
    OnGetDescription = stPlantaDestinoGetDescription
  end
  object stCentroDestino: TnbStaticText
    Left = 194
    Top = 144
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = edtCentroDestino
    OnGetDescription = stCentroDestinoGetDescription
  end
  object edtPlantaOrigen: TnbDBSQLCombo
    Left = 136
    Top = 24
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtPlantaOrigenChange
    TabOrder = 0
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    OnlyNumbers = False
    NumChars = 3
  end
  object edtCentroOrigen: TnbDBSQLCombo
    Left = 136
    Top = 48
    Width = 38
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtCentroOrigenChange
    TabOrder = 1
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnGetSQL = edtCentroOrigenGetSQL
    NumChars = 1
  end
  object fechaSalida: TnbDBCalendarCombo
    Left = 136
    Top = 72
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '27/02/2004'
    TabOrder = 2
  end
  object nReferencia: TnbDBNumeric
    Left = 136
    Top = 96
    Width = 89
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 3
  end
  object edtPlantaDestino: TnbDBSQLCombo
    Left = 136
    Top = 120
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtPlantaDestinoChange
    TabOrder = 4
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    OnlyNumbers = False
    NumChars = 3
  end
  object edtCentroDestino: TnbDBSQLCombo
    Left = 136
    Top = 144
    Width = 38
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtCentroDestinoChange
    TabOrder = 5
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnGetSQL = edtCentroDestinoGetSQL
    NumChars = 1
  end
end
