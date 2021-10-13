object FDRecepcionTransitos: TFDRecepcionTransitos
  Left = 544
  Top = 263
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    RECEPCI'#211'N DE TR'#193'NSITOS'
  ClientHeight = 290
  ClientWidth = 438
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
  PixelsPerInch = 96
  TextHeight = 13
  object nbLabel1: TnbLabel
    Left = 32
    Top = 24
    Width = 126
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 32
    Top = 48
    Width = 126
    Height = 21
    Caption = 'Centro Origen'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 32
    Top = 72
    Width = 126
    Height = 21
    Caption = 'Fecha Transito'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 32
    Top = 96
    Width = 126
    Height = 21
    Caption = 'Ref. Tr'#225'nsito'
    About = 'NB 0.1/20020725'
  end
  object lblFechaRecepcion: TnbLabel
    Left = 32
    Top = 144
    Width = 126
    Height = 21
    Caption = 'Fecha/Hora Recepci'#243'n'
    About = 'NB 0.1/20020725'
  end
  object nomEmpresa: TnbStaticText
    Left = 218
    Top = 24
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = empresa
    OnGetDescription = nomEmpresaGetDescription
  end
  object nomCentroSalida: TnbStaticText
    Left = 218
    Top = 48
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = centro
    OnGetDescription = nomCentrosalidaGetDescription
  end
  object btnOk: TSpeedButton
    Left = 204
    Top = 238
    Width = 99
    Height = 25
    Caption = 'Copiar'
    OnClick = BtnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 309
    Top = 238
    Width = 99
    Height = 25
    Caption = 'Cerrar'
    OnClick = BtnCancelClick
  end
  object lblMessage: TLabel
    Left = 32
    Top = 219
    Width = 178
    Height = 13
    Caption = 'Fecha prevista entrada en el almac'#233'n'
  end
  object lbl1: TLabel
    Left = 182
    Top = 163
    Width = 68
    Height = 13
    Caption = '(dd/mm/aaaa)'
  end
  object lbl2: TLabel
    Left = 264
    Top = 163
    Width = 39
    Height = 13
    Caption = '(hh/mm)'
  end
  object lbl3: TLabel
    Left = 310
    Top = 139
    Width = 108
    Height = 26
    Caption = 'Fecha/hora prevista'#13#10'entrada en el almac'#233'n.'
  end
  object nbLabel5: TnbLabel
    Left = 32
    Top = 120
    Width = 126
    Height = 21
    Caption = 'Centro Destino'
    About = 'NB 0.1/20020725'
  end
  object nomCentroDestino: TnbStaticText
    Left = 218
    Top = 120
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = centroDestino
    OnGetDescription = nomCentroDestinoGetDescription
  end
  object empresa: TnbDBSQLCombo
    Left = 160
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
    NumChars = 3
  end
  object centro: TnbDBSQLCombo
    Left = 160
    Top = 48
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = centroChange
    TabOrder = 1
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnGetSQL = centroGetSQL
    NumChars = 1
  end
  object fechaSalida: TnbDBCalendarCombo
    Left = 160
    Top = 72
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '27/02/2004'
    TabOrder = 2
  end
  object fechaRecepcion: TnbDBCalendarCombo
    Left = 160
    Top = 144
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '27/02/2004'
    TabOrder = 5
  end
  object nReferencia: TnbDBNumeric
    Left = 160
    Top = 96
    Width = 89
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 3
  end
  object edtHora: TBEdit
    Left = 253
    Top = 144
    Width = 50
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 5
    TabOrder = 6
  end
  object centroDestino: TnbDBSQLCombo
    Left = 160
    Top = 120
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = centroDestinoChange
    TabOrder = 4
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnGetSQL = centroGetSQL
    NumChars = 1
  end
end
