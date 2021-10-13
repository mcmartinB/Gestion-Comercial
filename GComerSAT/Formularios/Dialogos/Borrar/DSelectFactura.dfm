object FDSelectFactura: TFDSelectFactura
  Left = 822
  Top = 233
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'SELECCIONE LA FACTURA'
  ClientHeight = 167
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 143
    Width = 431
    Height = 24
    Align = alBottom
    TabOrder = 0
    object sbAceptar: TSpeedButton
      Left = 271
      Top = 1
      Width = 160
      Height = 22
      Action = AAceptar
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF000000FF0000000080FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF000000FF000000FF000000FF0000000000FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF000000FF000000FF000000FF0000000000FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF000000FF000000FF000000FF000000FF000000FF0000000080FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF000000FF000000FF000000FF000000FF000000FF000000FF0000000080FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF3F7F7F
        7F000000FF000000FF0000000080FF00FF000000FF000000FF000000FF000000
        0000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF007F7F7F000000
        FF0000000080FF00FF00FF00FF80FF00FF00FF00FF000000FF000000FF000000
        0000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF000000FF000000FF000000
        FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF000000FF000000
        FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF000000
        FF000000FF0000000000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF007F7F7F000000FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF3F7F7F7F000000FF0000000000FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF000000FF000000FF0000000000FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
        FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00}
    end
  end
  object Grid: TDBGrid
    Left = 0
    Top = 0
    Width = 431
    Height = 143
    Align = alClient
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = GridDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'empresa_f'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Width = 49
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'n_factura_f'
        Title.Alignment = taCenter
        Title.Caption = 'Factura'
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_factura_f'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha'
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tipo_factura_f'
        Title.Alignment = taCenter
        Title.Caption = 'Tipo'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliente_fac_f'
        Title.Alignment = taCenter
        Title.Caption = 'Cliente'
        Width = 41
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'importe_neto_f'
        Title.Alignment = taCenter
        Title.Caption = 'Importe Neto'
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tipo_impuesto_f'
        Title.Alignment = taCenter
        Title.Caption = 'Impuesto'
        Width = 55
        Visible = True
      end>
  end
  object ActionList1: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 128
    Top = 8
    object AAceptar: TAction
      Caption = 'Aceptar'
      Hint = 'Acepta operaciones realizadas y cierra el formulario.'
      ImageIndex = 1
      ShortCut = 112
      OnExecute = AAceptarExecute
    end
  end
  object DataSource: TDataSource
    DataSet = DMBaseDatos.QAux
    Left = 160
    Top = 16
  end
end
