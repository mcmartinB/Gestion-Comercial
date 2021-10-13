object DMPaises: TDMPaises
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 960
  Top = 145
  Height = 148
  Width = 243
  object QMaestro: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_paises')
    Left = 40
    Top = 32
    object QMaestropais_p: TStringField
      FieldName = 'pais_p'
      Origin = 'BDPROYECTO.frf_paises.pais_p'
      FixedChar = True
      Size = 2
    end
    object QMaestrodescripcion_p: TStringField
      FieldName = 'descripcion_p'
      Origin = 'BDPROYECTO.frf_paises.descripcion_p'
      FixedChar = True
      Size = 30
    end
    object QMaestrooriginal_name_p: TStringField
      FieldName = 'original_name_p'
      Origin = 'BDPROYECTO.frf_paises.original_name_p'
      FixedChar = True
      Size = 30
    end
    object QMaestromoneda_p: TStringField
      FieldName = 'moneda_p'
      Origin = 'BDPROYECTO.frf_paises.moneda_p'
      FixedChar = True
      Size = 3
    end
    object QMaestrocomunitario_p: TSmallintField
      FieldName = 'comunitario_p'
      Origin = 'BDPROYECTO.frf_paises.comunitario_p'
    end
  end
  object QListado: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * '
      'from frf_paises')
    Left = 120
    Top = 32
    object QListadopais_p: TStringField
      FieldName = 'pais_p'
      Origin = 'BDPROYECTO.frf_paises.pais_p'
      FixedChar = True
      Size = 2
    end
    object QListadodescripcion_p: TStringField
      FieldName = 'descripcion_p'
      Origin = 'BDPROYECTO.frf_paises.descripcion_p'
      FixedChar = True
      Size = 30
    end
    object QListadooriginal_name_p: TStringField
      FieldName = 'original_name_p'
      Origin = 'BDPROYECTO.frf_paises.original_name_p'
      FixedChar = True
      Size = 30
    end
    object QListadomoneda_p: TStringField
      FieldName = 'moneda_p'
      Origin = 'BDPROYECTO.frf_paises.moneda_p'
      FixedChar = True
      Size = 3
    end
    object QListadocomunitario_p: TSmallintField
      FieldName = 'comunitario_p'
      Origin = 'BDPROYECTO.frf_paises.comunitario_p'
    end
  end
end
