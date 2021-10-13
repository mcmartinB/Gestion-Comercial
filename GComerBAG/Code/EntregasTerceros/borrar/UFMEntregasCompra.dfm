object FMEntregasCompra: TFMEntregasCompra
  Left = 636
  Top = 213
  ActiveControl = dbgCompras
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '    SELECCIONAR COMPRA'
  ClientHeight = 470
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object btnBorrar: TButton
    Left = 0
    Top = 16
    Width = 140
    Height = 25
    Caption = 'Borrar [F5]'
    TabOrder = 0
    TabStop = False
    OnClick = btnBorrarClick
  end
  object btnCancelar: TButton
    Left = 145
    Top = 16
    Width = 78
    Height = 25
    Caption = 'Cancelar [Esc]'
    TabOrder = 1
    TabStop = False
    OnClick = btnCancelarClick
  end
  object btnAceptar: TButton
    Left = 228
    Top = 16
    Width = 77
    Height = 25
    Caption = 'Aceptar [F1]'
    TabOrder = 2
    TabStop = False
    OnClick = btnAceptarClick
  end
  object dbgCompras: TDBGrid
    Left = 0
    Top = 48
    Width = 305
    Height = 313
    TabStop = False
    DataSource = DSCompras
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbgComprasDblClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro'
        Title.Alignment = taCenter
        Title.Caption = 'CENTRO'
        Width = 57
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'codigo'
        Title.Alignment = taCenter
        Title.Caption = 'C'#211'DIGO'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'fecha'
        Title.Alignment = taCenter
        Title.Caption = 'FECHA'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'compra'
        Title.Alignment = taCenter
        Title.Caption = 'COMPRA'
        Width = 76
        Visible = True
      end>
  end
  object dbmmoNotas: TDBMemo
    Left = 0
    Top = 368
    Width = 305
    Height = 98
    HelpType = htKeyword
    TabStop = False
    DataField = 'Notas'
    DataSource = DSCompras
    ReadOnly = True
    TabOrder = 4
  end
  object QCompras: TQuery
    DatabaseName = 'BDProyecto'
    Left = 8
    Top = 80
  end
  object DSCompras: TDataSource
    DataSet = QCompras
    Left = 40
    Top = 80
  end
  object QDesligar: TQuery
    DatabaseName = 'BDProyecto'
    Left = 8
    Top = 112
  end
  object QLigar: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 112
  end
  object QDesasignarGastos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 72
    Top = 112
  end
  object QBorrarGastos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 104
    Top = 112
  end
end
