object DMLServiciosTransporteEntregas: TDMLServiciosTransporteEntregas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 745
  Top = 255
  Height = 385
  Width = 313
  object QListado: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        '--ANSI== SELECT Frf_productos.descripcion_p, Frf_envases.descrip' +
        'cion_e, Frf_marcas.descripcion_m, Frf_color.descripcion_c, Frf_s' +
        'alidas_l.calibre_sl, Frf_salidas_l.cajas_sl, Frf_salidas_l.kilos' +
        '_sl, Frf_salidas_l.precio_sl, Frf_salidas_l.unidad_precio_sl, Fr' +
        'f_salidas_l.precio_neto_sl, Frf_tipo_palets.descripcion_tp'
      
        '--ANSI== FROM frf_salidas_l Frf_salidas_l, frf_productos Frf_pro' +
        'ductos, frf_envases Frf_envases, frf_marcas Frf_marcas, frf_colo' +
        'r Frf_color'
      '--ANSI==    LEFT OUTER JOIN frf_tipo_palets Frf_tipo_palets'
      
        '--ANSI==    ON  (Frf_salidas_l.tipo_palets_sl = Frf_tipo_palets.' +
        'codigo_tp)  '
      
        '--ANSI== WHERE  (Frf_salidas_l.empresa_sl = Frf_productos.empres' +
        'a_p)  '
      
        '--ANSI==    AND  (Frf_salidas_l.producto_sl = Frf_productos.prod' +
        'ucto_p)  '
      
        '--ANSI==    AND  (Frf_salidas_l.envase_sl = Frf_envases.envase_e' +
        ')  '
      
        '--ANSI==    AND  (Frf_salidas_l.marca_sl = Frf_marcas.codigo_m) ' +
        ' '
      
        '--ANSI==    AND  (Frf_salidas_l.empresa_sl = Frf_color.empresa_c' +
        ')  '
      
        '--ANSI==    AND  (Frf_salidas_l.producto_sl = Frf_color.producto' +
        '_c)  '
      '--ANSI==    AND  (Frf_salidas_l.color_sl = Frf_color.color_c)  '
      ''
      
        'SELECT Frf_productos.descripcion_p, Frf_envases.descripcion_e, F' +
        'rf_marcas.descripcion_m, Frf_color.descripcion_c, Frf_salidas_l.' +
        'calibre_sl, Frf_salidas_l.cajas_sl, Frf_salidas_l.kilos_sl, Frf_' +
        'salidas_l.precio_sl, Frf_salidas_l.unidad_precio_sl, Frf_salidas' +
        '_l.precio_neto_sl, Frf_tipo_palets.descripcion_tp'
      
        'FROM frf_salidas_l Frf_salidas_l, frf_productos Frf_productos, f' +
        'rf_envases Frf_envases, frf_marcas Frf_marcas, frf_color Frf_col' +
        'or, OUTER frf_tipo_palets Frf_tipo_palets'
      'WHERE  (Frf_salidas_l.empresa_sl = Frf_productos.empresa_p)  '
      '   AND  (Frf_salidas_l.producto_sl = Frf_productos.producto_p)  '
      '   AND  (Frf_salidas_l.envase_sl = Frf_envases.envase_e)  '
      '   AND  (Frf_salidas_l.marca_sl = Frf_marcas.codigo_m)  '
      '   AND  (Frf_salidas_l.empresa_sl = Frf_color.empresa_c)  '
      '   AND  (Frf_salidas_l.producto_sl = Frf_color.producto_c)  '
      '   AND  (Frf_salidas_l.color_sl = Frf_color.color_c)  '
      
        '   AND  (Frf_salidas_l.tipo_palets_sl = Frf_tipo_palets.codigo_t' +
        'p)  ')
    Left = 63
    Top = 41
  end
  object mtListado: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 64
    Top = 104
  end
end
