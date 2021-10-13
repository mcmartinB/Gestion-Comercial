object DMAprovecha: TDMAprovecha
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 237
  Top = 173
  Height = 150
  Width = 347
  object QAprovechaDiario: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * from frf_escandallo')
    Left = 48
    Top = 16
  end
  object QVerificaGrabados: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'Select fecha_e2l, numero_entrada_e2l, cosechero_e2l, plantacion_' +
        'e2l'
      'From frf_entradas2_l'
      'Where not exists  '
      '  (Select * from frf_escandallo'
      '  where empresa_e2l = '#39'050'#39
      '    and centro_e2l = '#39'1'#39
      '    and fecha_e2l = fecha_e'
      '    and numero_entrada_e2l = numero_entrada_e'
      '    and cosechero_e2l = cosechero_e'
      '    and plantacion_e2l = plantacion_e)'
      'and empresa_e2l = '#39'050'#39
      'and centro_e2l = '#39'1'#39
      'and fecha_e2l between '#39'4/8/2003'#39' and '#39'31/8/2003'#39
      'and producto_e2l = '#39'T'#39
      'order by 1,3,4,2')
    Left = 152
    Top = 16
  end
end
