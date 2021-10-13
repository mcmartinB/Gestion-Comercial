object FDTransitosAduanaSalidas: TFDTransitosAduanaSalidas
  Left = 608
  Top = 175
  Width = 595
  Height = 634
  Caption = '   ALBARANES SALIDA ADUANA DEL TRANSITO'
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
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlSuperior: TPanel
    Left = 0
    Top = 0
    Width = 587
    Height = 119
    Align = alTop
    TabOrder = 0
    object nbLabel1: TnbLabel
      Left = 40
      Top = 36
      Width = 113
      Height = 21
      Caption = 'Empresa'
      About = 'NB 0.1/20020725'
    end
    object nbLabel2: TnbLabel
      Left = 40
      Top = 11
      Width = 113
      Height = 21
      Caption = 'DVD'
      About = 'NB 0.1/20020725'
    end
    object lblEmpresa: TLabel
      Left = 160
      Top = 42
      Width = 51
      Height = 13
      Caption = 'lblEmpresa'
    end
    object lblDVD: TLabel
      Left = 160
      Top = 15
      Width = 33
      Height = 13
      Caption = 'lblDVD'
    end
    object lblCliente: TnbLabel
      Left = 40
      Top = 61
      Width = 113
      Height = 21
      Caption = 'Cliente'
      About = 'NB 0.1/20020725'
    end
    object lblSuministro: TnbLabel
      Left = 40
      Top = 86
      Width = 113
      Height = 21
      Caption = 'Suministro'
      About = 'NB 0.1/20020725'
    end
    object stCliente: TLabel
      Left = 160
      Top = 65
      Width = 51
      Height = 13
      Caption = 'lblEmpresa'
    end
    object stSuministro: TLabel
      Left = 160
      Top = 90
      Width = 51
      Height = 13
      Caption = 'lblEmpresa'
    end
    object lblKilosFaltan: TLabel
      Left = 440
      Top = 15
      Width = 139
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Kilos faltan'
    end
    object lblSeleccionable: TLabel
      Left = 414
      Top = 104
      Width = 165
      Height = 13
      Alignment = taRightJustify
      Caption = 'Producto Seleccionable: '#39'T'#39', '#39'E'#39', '#39'Q'#39
    end
  end
  object pnlMedio: TPanel
    Left = 0
    Top = 119
    Width = 587
    Height = 226
    Align = alTop
    Caption = 'pnlMedio'
    TabOrder = 1
    object dbgAlbaranes_: TDBGrid
      Left = 1
      Top = 1
      Width = 585
      Height = 224
      Align = alClient
      DataSource = DSAlbaranes
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = dbgAlbaranes_CellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'cliente'
          Title.Caption = 'Cliente'
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'suministro'
          Title.Caption = 'Suministro'
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'centro'
          Title.Caption = 'Centro'
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'pedido'
          Title.Caption = 'Pedido'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha'
          Title.Caption = 'Fecha'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'albaran'
          Title.Caption = 'Albaran'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'kilos'
          Title.Caption = 'Kilos'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'kilos_asignados'
          Title.Caption = 'Asignados'
          Width = 65
          Visible = True
        end>
    end
  end
  object pnlInferior: TPanel
    Left = 0
    Top = 345
    Width = 587
    Height = 262
    Align = alClient
    TabOrder = 2
    object nbLabel6: TnbLabel
      Left = 360
      Top = 33
      Width = 113
      Height = 21
      Caption = 'Fecha Albar'#225'n'
      About = 'NB 0.1/20020725'
    end
    object nbLabel7: TnbLabel
      Left = 23
      Top = 33
      Width = 113
      Height = 21
      Caption = 'N'#186' Albar'#225'n'
      About = 'NB 0.1/20020725'
    end
    object nbLabel3: TnbLabel
      Left = 23
      Top = 153
      Width = 113
      Height = 21
      Caption = 'Kilos'
      About = 'NB 0.1/20020725'
    end
    object nbLabel4: TnbLabel
      Left = 23
      Top = 177
      Width = 113
      Height = 21
      Caption = 'Coste Plat. Frigorifica'
      About = 'NB 0.1/20020725'
    end
    object lblFactura: TnbLabel
      Left = 23
      Top = 201
      Width = 113
      Height = 21
      Caption = 'N'#186' Factura'
      About = 'NB 0.1/20020725'
    end
    object lblOperador_transporte_das: TnbLabel
      Left = 23
      Top = 81
      Width = 113
      Height = 21
      Caption = 'Operador Transporte'
      About = 'NB 0.1/20020725'
    end
    object stOperador_transporte_das: TnbStaticText
      Left = 211
      Top = 81
      Width = 246
      Height = 21
      About = 'NB 0.1/20020725'
      OnGetDescription = stOperadorGetDescription
    end
    object lbltransporte_das: TnbLabel
      Left = 23
      Top = 105
      Width = 113
      Height = 21
      Caption = 'Transportista'
      About = 'NB 0.1/20020725'
    end
    object sttransporte_das: TnbStaticText
      Left = 211
      Top = 105
      Width = 246
      Height = 21
      About = 'NB 0.1/20020725'
      OnGetDescription = sttransporte_dasGetDescription
    end
    object lblVehiculo_das: TnbLabel
      Left = 23
      Top = 129
      Width = 113
      Height = 21
      Caption = 'Vehiculo'
      About = 'NB 0.1/20020725'
    end
    object lbln_cmr_das: TnbLabel
      Left = 360
      Top = 57
      Width = 113
      Height = 21
      Caption = 'N'#186' CMR'
      About = 'NB 0.1/20020725'
    end
    object lbln_pedido_das: TnbLabel
      Left = 23
      Top = 57
      Width = 113
      Height = 21
      Caption = 'N'#186' Pedido'
      About = 'NB 0.1/20020725'
    end
    object nbLabel5: TnbLabel
      Left = 23
      Top = 9
      Width = 113
      Height = 21
      Caption = 'Centro Salida'
      About = 'NB 0.1/20020725'
    end
    object stCentro: TnbStaticText
      Left = 211
      Top = 9
      Width = 246
      Height = 21
      About = 'NB 0.1/20020725'
      OnGetDescription = stCentroGetDescription
    end
    object kilos_das: TnbDBNumeric
      Left = 143
      Top = 153
      Width = 90
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 8
      DataField = 'kilos_das'
      DataSource = DSSalidasDatosAduana
      DBLink = True
      NumIntegers = 10
      NumDecimals = 2
    end
    object btnGuardar: TButton
      Left = 352
      Top = 218
      Width = 105
      Height = 25
      Caption = 'Guardar (F1)'
      TabOrder = 11
      TabStop = False
      OnClick = btnGuardarClick
    end
    object btnSalir: TButton
      Left = 463
      Top = 218
      Width = 105
      Height = 25
      Caption = 'Salir (Esc)'
      TabOrder = 12
      TabStop = False
      OnClick = btnSalirClick
    end
    object fecha_das: TnbDBCalendarCombo
      Left = 478
      Top = 33
      Width = 90
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 2
      DataField = 'fecha_das'
      DataSource = DSSalidasDatosAduana
      DBLink = True
    end
    object n_albaran_das: TnbDBNumeric
      Left = 143
      Top = 33
      Width = 90
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 1
      DataField = 'n_albaran_das'
      DataSource = DSSalidasDatosAduana
      DBLink = True
      NumIntegers = 6
    end
    object frigorifico_das: TnbDBNumeric
      Left = 143
      Top = 177
      Width = 90
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 9
      DataField = 'frigorifico_das'
      DataSource = DSSalidasDatosAduana
      DBLink = True
      NumIntegers = 10
      NumDecimals = 2
    end
    object Operador_transporte_das: TnbDBSQLCombo
      Left = 143
      Top = 81
      Width = 65
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = Operador_transporte_dasChange
      TabOrder = 5
      DataField = 'Operador_transporte_das'
      DataSource = DSSalidasDatosAduana
      DBLink = True
      DatabaseName = 'BDProyecto'
      OnGetSQL = Operador_transporte_dasGetSQL
      OnlyNumbers = False
      NumChars = 1
    end
    object transporte_das: TnbDBSQLCombo
      Left = 143
      Top = 105
      Width = 65
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = transporte_dasChange
      TabOrder = 6
      DataField = 'transporte_das'
      DataSource = DSSalidasDatosAduana
      DBLink = True
      DatabaseName = 'BDProyecto'
      OnGetSQL = transporte_dasGetSQL
      OnlyNumbers = False
      NumChars = 1
    end
    object n_cmr_das: TnbDBAlfa
      Left = 478
      Top = 57
      Width = 90
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 4
      DataField = 'n_cmr_das'
      DataSource = DSSalidasDatosAduana
      DBLink = True
      NumChars = 10
    end
    object vehiculo_das: TnbDBAlfa
      Left = 143
      Top = 129
      Width = 180
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 7
      DataField = 'vehiculo_das'
      DataSource = DSSalidasDatosAduana
      DBLink = True
      NumChars = 20
    end
    object n_factura_das: TnbDBAlfa
      Left = 143
      Top = 201
      Width = 180
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 10
      DataField = 'n_factura_das'
      DataSource = DSSalidasDatosAduana
      DBLink = True
      NumChars = 20
    end
    object n_pedido_das: TnbDBAlfa
      Left = 143
      Top = 57
      Width = 120
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 3
      DataField = 'n_pedido_das'
      DataSource = DSSalidasDatosAduana
      DBLink = True
      NumChars = 15
    end
    object centro_salida_das: TnbDBSQLCombo
      Left = 143
      Top = 9
      Width = 40
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = centro_salida_dasChange
      TabOrder = 0
      DataField = 'centro_salida_das'
      DataSource = DSSalidasDatosAduana
      DBLink = True
      DatabaseName = 'BDProyecto'
      OnGetSQL = centro_salida_dasGetSQL
      OnlyNumbers = False
      NumChars = 1
    end
  end
  object DSSalidasDatosAduana: TDataSource
    DataSet = DDTransitosAduana.QDatosAduanaSalidas
    Left = 14
    Top = 362
  end
  object DSAlbaranes: TDataSource
    DataSet = DDTransitosAduana.QKilosPendientes
    Left = 32
    Top = 152
  end
end
