object DMWEB: TDMWEB
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 430
  Top = 176
  Height = 442
  Width = 815
  object BDWEB: TDatabase
    AliasName = 'reclama'
    DatabaseName = 'BDWEB'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=bonnysa'
      'PASSWORD=mysql1q2w')
    SessionName = 'Default'
    Left = 40
    Top = 200
  end
  object QNumReclamacionesRemoto: TQuery
    DatabaseName = 'BDWEB'
    Left = 224
    Top = 184
  end
  object QReclamacionesRemoto: TQuery
    DatabaseName = 'BDWEB'
    SQL.Strings = (
      'select *'
      'from frf_reclamaciones')
    Left = 224
    Top = 232
    object QReclamacionesRemotoempresa_r: TStringField
      FieldName = 'empresa_r'
      Origin = 'BDWEB.frf_reclamaciones.empresa_r'
      FixedChar = True
      Size = 3
    end
    object QReclamacionesRemotocliente_r: TStringField
      DisplayWidth = 3
      FieldName = 'cliente_r'
      Origin = 'BDWEB.frf_reclamaciones.cliente_r'
      FixedChar = True
      Size = 3
    end
    object QReclamacionesRemoton_reclamacion_r: TSmallintField
      FieldName = 'n_reclamacion_r'
      Origin = 'BDWEB.frf_reclamaciones.n_reclamacion_r'
    end
    object QReclamacionesRemotoemail_r: TStringField
      DisplayWidth = 40
      FieldName = 'email_r'
      Origin = 'BDWEB.frf_reclamaciones.email_r'
      FixedChar = True
      Size = 40
    end
    object QReclamacionesRemotonombre_r: TStringField
      DisplayWidth = 30
      FieldName = 'nombre_r'
      Origin = 'BDWEB.frf_reclamaciones.nombre_r'
      FixedChar = True
      Size = 30
    end
    object QReclamacionesRemotofecha_r: TDateField
      FieldName = 'fecha_r'
      Origin = 'BDWEB.frf_reclamaciones.fecha_r'
    end
    object QReclamacionesRemotohora_r: TTimeField
      FieldName = 'hora_r'
      Origin = 'BDWEB.frf_reclamaciones.hora_r'
    end
    object QReclamacionesRemoton_pedido_r: TIntegerField
      FieldName = 'n_pedido_r'
      Origin = 'BDWEB.frf_reclamaciones.n_pedido_r'
    end
    object QReclamacionesRemoton_albaran_r: TIntegerField
      FieldName = 'n_albaran_r'
      Origin = 'BDWEB.frf_reclamaciones.n_albaran_r'
    end
    object QReclamacionesRemotofecha_albaran_r: TDateField
      FieldName = 'fecha_albaran_r'
      Origin = 'BDWEB.frf_reclamaciones.fecha_albaran_r'
    end
    object QReclamacionesRemotoproducto_r: TStringField
      FieldName = 'producto_r'
      Origin = 'BDWEB.frf_reclamaciones.producto_r'
      FixedChar = True
      Size = 1
    end
    object QReclamacionesRemotoidioma_r: TStringField
      DisplayWidth = 3
      FieldName = 'idioma_r'
      Origin = 'BDWEB.frf_reclamaciones.idioma_r'
      FixedChar = True
      Size = 3
    end
    object QReclamacionesRemotocaj_kgs_uni_r: TStringField
      FieldName = 'caj_kgs_uni_r'
      Origin = 'BDWEB.frf_reclamaciones.caj_kgs_uni_r'
      FixedChar = True
      Size = 1
    end
    object QReclamacionesRemotocantidad_r: TSmallintField
      FieldName = 'cantidad_r'
      Origin = 'BDWEB.frf_reclamaciones.cantidad_r'
    end
    object QReclamacionesRemotoporc_rajado_r: TSmallintField
      FieldName = 'porc_rajado_r'
      Origin = 'BDWEB.frf_reclamaciones.porc_rajado_r'
    end
    object QReclamacionesRemotoporc_mancha_r: TSmallintField
      FieldName = 'porc_mancha_r'
      Origin = 'BDWEB.frf_reclamaciones.porc_mancha_r'
    end
    object QReclamacionesRemotoporc_blando_r: TSmallintField
      FieldName = 'porc_blando_r'
      Origin = 'BDWEB.frf_reclamaciones.porc_blando_r'
    end
    object QReclamacionesRemotoporc_moho_r: TSmallintField
      FieldName = 'porc_moho_r'
      Origin = 'BDWEB.frf_reclamaciones.porc_moho_r'
    end
    object QReclamacionesRemotoporc_color_r: TSmallintField
      FieldName = 'porc_color_r'
      Origin = 'BDWEB.frf_reclamaciones.porc_color_r'
    end
    object QReclamacionesRemotoporc_otros_r: TSmallintField
      FieldName = 'porc_otros_r'
      Origin = 'BDWEB.frf_reclamaciones.porc_otros_r'
    end
    object QReclamacionesRemotodescripcion_otros_r: TStringField
      DisplayWidth = 255
      FieldName = 'descripcion_otros_r'
      Origin = 'BDWEB.frf_reclamaciones.descripcion_otros_r'
      FixedChar = True
      Size = 255
    end
    object QReclamacionesRemoton_devolucion_r: TSmallintField
      FieldName = 'n_devolucion_r'
      Origin = 'BDWEB.frf_reclamaciones.n_devolucion_r'
    end
    object QReclamacionesRemotot_devolucion_r: TStringField
      DisplayWidth = 255
      FieldName = 't_devolucion_r'
      Origin = 'BDWEB.frf_reclamaciones.t_devolucion_r'
      FixedChar = True
      Size = 255
    end
    object QReclamacionesRemoton_reseleccion_r: TSmallintField
      FieldName = 'n_reseleccion_r'
      Origin = 'BDWEB.frf_reclamaciones.n_reseleccion_r'
    end
    object QReclamacionesRemotot_reseleccion_r: TStringField
      DisplayWidth = 255
      FieldName = 't_reseleccion_r'
      Origin = 'BDWEB.frf_reclamaciones.t_reseleccion_r'
      FixedChar = True
      Size = 255
    end
    object QReclamacionesRemoton_reventa_r: TSmallintField
      FieldName = 'n_reventa_r'
      Origin = 'BDWEB.frf_reclamaciones.n_reventa_r'
    end
    object QReclamacionesRemotot_reventa_r: TStringField
      DisplayWidth = 255
      FieldName = 't_reventa_r'
      Origin = 'BDWEB.frf_reclamaciones.t_reventa_r'
      FixedChar = True
      Size = 255
    end
    object QReclamacionesRemoton_otros_r: TSmallintField
      FieldName = 'n_otros_r'
      Origin = 'BDWEB.frf_reclamaciones.n_otros_r'
    end
    object QReclamacionesRemotot_otros_r: TStringField
      DisplayWidth = 255
      FieldName = 't_otros_r'
      Origin = 'BDWEB.frf_reclamaciones.t_otros_r'
      FixedChar = True
      Size = 255
    end
    object QReclamacionesRemotoobservacion_r: TStringField
      FieldName = 'observacion_r'
      Origin = 'BDWEB.frf_reclamaciones.observacion_r'
      FixedChar = True
      Size = 127
    end
    object QReclamacionesRemotostatus_r: TStringField
      FieldName = 'status_r'
      Origin = 'BDWEB.frf_reclamaciones.status_r'
      FixedChar = True
      Size = 1
    end
    object QReclamacionesRemotodescargado_r: TStringField
      FieldName = 'descargado_r'
      Origin = 'BDWEB.frf_reclamaciones.descargado_r'
      FixedChar = True
      Size = 1
    end
  end
  object QClientesWEBLocal: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * from frf_web_clientes')
    Left = 368
    Top = 32
    object QClientesWEBLocalcliente_wcl: TStringField
      FieldName = 'cliente_wcl'
      Origin = 'COMERCIALIZACION.frf_web_clientes.cliente_wcl'
      FixedChar = True
      Size = 3
    end
    object QClientesWEBLocalnombre_cliente_wcl: TStringField
      FieldName = 'nombre_cliente_wcl'
      Origin = 'COMERCIALIZACION.frf_web_clientes.nombre_cliente_wcl'
      FixedChar = True
      Size = 30
    end
    object QClientesWEBLocalusuario_wcl: TStringField
      FieldName = 'usuario_wcl'
      Origin = 'COMERCIALIZACION.frf_web_clientes.usuario_wcl'
      FixedChar = True
      Size = 6
    end
    object QClientesWEBLocalpassword_wcl: TStringField
      FieldName = 'password_wcl'
      Origin = 'COMERCIALIZACION.frf_web_clientes.password_wcl'
      FixedChar = True
      Size = 6
    end
    object QClientesWEBLocalnombre_usuario_wcl: TStringField
      FieldName = 'nombre_usuario_wcl'
      Origin = 'COMERCIALIZACION.frf_web_clientes.nombre_usuario_wpd'
      FixedChar = True
      Size = 30
    end
    object QClientesWEBLocalemail_wcl: TStringField
      FieldName = 'email_wcl'
      Origin = 'COMERCIALIZACION.frf_web_clientes.email_wcl'
      FixedChar = True
      Size = 100
    end
    object QClientesWEBLocalidioma_wcl: TStringField
      FieldName = 'idioma_wcl'
      Origin = 'COMERCIALIZACION.frf_web_clientes.idioma_wcl'
      FixedChar = True
      Size = 3
    end
  end
  object QClientesWEBRemoto: TQuery
    DatabaseName = 'BDWEB'
    RequestLive = True
    SQL.Strings = (
      'select *'
      'from frf_clientes_web')
    Left = 376
    Top = 184
    object QClientesWEBRemotousuario_cw: TStringField
      DisplayWidth = 6
      FieldName = 'usuario_cw'
      Origin = 'BDWEB.frf_clientes_web.usuario_cw'
      FixedChar = True
      Size = 6
    end
    object QClientesWEBRemotopassword_cw: TStringField
      FieldName = 'password_cw'
      Origin = 'BDWEB.frf_clientes_web.password_cw'
      FixedChar = True
      Size = 6
    end
    object QClientesWEBRemotocliente_cw: TStringField
      FieldName = 'cliente_cw'
      Origin = 'BDWEB.frf_clientes_web.cliente_cw'
      FixedChar = True
      Size = 3
    end
    object QClientesWEBRemotonombre_cliente_cw: TStringField
      FieldName = 'nombre_cliente_cw'
      Origin = 'BDWEB.frf_clientes_web.nombre_cliente_cw'
      FixedChar = True
      Size = 30
    end
    object QClientesWEBRemotonombre_usuario_cw: TStringField
      DisplayWidth = 30
      FieldName = 'nombre_usuario_cw'
      Origin = 'BDWEB.frf_clientes_web.nombre_usuario_cw'
      FixedChar = True
      Size = 30
    end
    object QClientesWEBRemotoemail_cw: TStringField
      DisplayWidth = 100
      FieldName = 'email_cw'
      Origin = 'BDWEB.frf_clientes_web.email_cw'
      FixedChar = True
      Size = 100
    end
    object QClientesWEBRemotoidioma_cw: TStringField
      DisplayWidth = 3
      FieldName = 'idioma_cw'
      Origin = 'BDWEB.frf_clientes_web.idioma_cw'
      FixedChar = True
      Size = 3
    end
  end
  object QProductosWEBLocal: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * from frf_web_productos')
    Left = 512
    Top = 32
    object QProductosWEBLocalproducto_wpd: TStringField
      FieldName = 'producto_wpd'
      Origin = 'COMERCIALIZACION.frf_web_productos.producto_wpd'
      FixedChar = True
      Size = 1
    end
    object QProductosWEBLocalidioma_wpd: TStringField
      FieldName = 'idioma_wpd'
      Origin = 'COMERCIALIZACION.frf_web_productos.idioma_wpd'
      FixedChar = True
      Size = 3
    end
    object QProductosWEBLocaldescripcion_wpd: TStringField
      FieldName = 'descripcion_wpd'
      Origin = 'COMERCIALIZACION.frf_web_productos.descripcion_wpd'
      FixedChar = True
    end
  end
  object QProductosWEBRemoto: TQuery
    DatabaseName = 'BDWEB'
    RequestLive = True
    SQL.Strings = (
      'select *'
      'from frf_productos_web')
    Left = 520
    Top = 184
    object QProductosWEBRemotoproducto_pw: TStringField
      FieldName = 'producto_pw'
      Origin = 'BDWEB.frf_productos_web.producto_pw'
      FixedChar = True
      Size = 1
    end
    object QProductosWEBRemotoidioma_pw: TStringField
      DisplayWidth = 3
      FieldName = 'idioma_pw'
      Origin = 'BDWEB.frf_productos_web.idioma_pw'
      FixedChar = True
      Size = 3
    end
    object QProductosWEBRemotodescripcion_pw: TStringField
      DisplayWidth = 20
      FieldName = 'descripcion_pw'
      Origin = 'BDWEB.frf_productos_web.descripcion_pw'
      FixedChar = True
    end
  end
  object QMarcarReclamaRemoto: TQuery
    DatabaseName = 'BDWEB'
    SQL.Strings = (
      'select *'
      'from frf_reclamaciones')
    Left = 224
    Top = 280
  end
  object IdFTP: TIdFTP
    Left = 40
    Top = 256
  end
  object QImagenesRemoto: TQuery
    DatabaseName = 'BDWEB'
    SQL.Strings = (
      'select *'
      'from frf_reclamaciones')
    Left = 224
    Top = 328
  end
  object QReclamaciones: TQuery
    BeforePost = QReclamacionesBeforePost
    AfterPost = QReclamacionesAfterPost
    AfterCancel = QReclamacionesAfterCancel
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_reclamaciones')
    Left = 216
    Top = 32
    object QReclamacionesempresa_rcl: TStringField
      FieldName = 'empresa_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.empresa_rcl'
      FixedChar = True
      Size = 3
    end
    object QReclamacionescliente_rcl: TStringField
      FieldName = 'cliente_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.cliente_rcl'
      FixedChar = True
      Size = 3
    end
    object QReclamacionesn_reclamacion_rcl: TSmallintField
      FieldName = 'n_reclamacion_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.n_reclamacion_rcl'
    end
    object QReclamacionesemail_rcl: TStringField
      FieldName = 'email_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.email_rcl'
      FixedChar = True
      Size = 100
    end
    object QReclamacionesnombre_rcl: TStringField
      FieldName = 'nombre_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.nombre_rcl'
      FixedChar = True
      Size = 30
    end
    object QReclamacionesfecha_rcl: TDateField
      FieldName = 'fecha_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.fecha_rcl'
    end
    object QReclamacioneshora_rcl: TStringField
      FieldName = 'hora_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.hora_rcl'
      FixedChar = True
      Size = 8
    end
    object QReclamacionesn_pedido_rcl: TIntegerField
      FieldName = 'n_pedido_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.n_pedido_rcl'
    end
    object QReclamacionesn_albaran_rcl: TIntegerField
      FieldName = 'n_albaran_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.n_albaran_rcl'
    end
    object QReclamacionesfecha_albaran_rcl: TDateField
      FieldName = 'fecha_albaran_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.fecha_albaran_rcl'
    end
    object QReclamacionesproducto_rcl: TStringField
      FieldName = 'producto_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.producto_rcl'
      FixedChar = True
      Size = 1
    end
    object QReclamacionesidioma_rcl: TStringField
      FieldName = 'idioma_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.idioma_rcl'
      FixedChar = True
      Size = 3
    end
    object QReclamacionescaj_kgs_uni_rcl: TStringField
      FieldName = 'caj_kgs_uni_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.caj_kgs_uni_rcl'
      FixedChar = True
      Size = 1
    end
    object QReclamacionescantidad_rcl: TSmallintField
      FieldName = 'cantidad_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.cantidad_rcl'
    end
    object QReclamacionesporc_rajado_rcl: TSmallintField
      FieldName = 'porc_rajado_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.porc_rajado_rcl'
    end
    object QReclamacionesporc_mancha_rcl: TSmallintField
      FieldName = 'porc_mancha_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.porc_mancha_rcl'
    end
    object QReclamacionesporc_blando_rcl: TSmallintField
      FieldName = 'porc_blando_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.porc_blando_rcl'
    end
    object QReclamacionesporc_moho_rcl: TSmallintField
      FieldName = 'porc_moho_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.porc_moho_rcl'
    end
    object QReclamacionesporc_color_rcl: TSmallintField
      FieldName = 'porc_color_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.porc_color_rcl'
    end
    object QReclamacionesporc_otros_rcl: TSmallintField
      FieldName = 'porc_otros_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.porc_otros_rcl'
    end
    object QReclamacionesdescripcion_otros_rcl: TStringField
      FieldName = 'descripcion_otros_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.descripcion_otros_rcl'
      FixedChar = True
      Size = 255
    end
    object QReclamacionesn_devolucion_rcl: TSmallintField
      FieldName = 'n_devolucion_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.n_devolucion_rcl'
    end
    object QReclamacionest_devolucion_rcl: TStringField
      FieldName = 't_devolucion_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.t_devolucion_rcl'
      FixedChar = True
      Size = 255
    end
    object QReclamacionesn_reseleccion_rcl: TSmallintField
      FieldName = 'n_reseleccion_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.n_reseleccion_rcl'
    end
    object QReclamacionest_reseleccion_rcl: TStringField
      FieldName = 't_reseleccion_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.t_reseleccion_rcl'
      FixedChar = True
      Size = 255
    end
    object QReclamacionesn_reventa_rcl: TSmallintField
      FieldName = 'n_reventa_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.n_reventa_rcl'
    end
    object QReclamacionest_reventa_rcl: TStringField
      FieldName = 't_reventa_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.t_reventa_rcl'
      FixedChar = True
      Size = 255
    end
    object QReclamacionesn_otros_rcl: TSmallintField
      FieldName = 'n_otros_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.n_otros_rcl'
    end
    object QReclamacionest_otros_rcl: TStringField
      FieldName = 't_otros_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.t_otros_rcl'
      FixedChar = True
      Size = 255
    end
    object QReclamacionesobservacion_rcl: TStringField
      FieldName = 'observacion_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.observacion_rcl'
      FixedChar = True
      Size = 255
    end
    object QReclamacionesstatus_r: TStringField
      FieldName = 'status_r'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.status_r'
      FixedChar = True
      Size = 1
    end
    object QReclamacionesdescargado_r: TStringField
      FieldName = 'descargado_r'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.descargado_r'
      FixedChar = True
      Size = 1
    end
    object QReclamacionesnotas_exporta_rcl: TStringField
      FieldName = 'notas_exporta_rcl'
      Origin = 'COMERCIALIZACION.frf_reclamaciones.notas_exporta_rcl'
      FixedChar = True
      Size = 250
    end
  end
  object QReclamaFotos: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_reclama_fotos')
    Left = 216
    Top = 80
    object QReclamaFotosempresa_rft: TStringField
      FieldName = 'empresa_rft'
      Origin = 'COMERCIALIZACION.frf_reclama_fotos.empresa_rft'
      FixedChar = True
      Size = 3
    end
    object QReclamaFotoscliente_rft: TStringField
      FieldName = 'cliente_rft'
      Origin = 'COMERCIALIZACION.frf_reclama_fotos.cliente_rft'
      FixedChar = True
      Size = 3
    end
    object QReclamaFotosn_reclamacion_rft: TSmallintField
      FieldName = 'n_reclamacion_rft'
      Origin = 'COMERCIALIZACION.frf_reclama_fotos.n_reclamacion_rft'
    end
    object QReclamaFotosfichero_rft: TStringField
      FieldName = 'fichero_rft'
      Origin = 'COMERCIALIZACION.frf_reclama_fotos.fichero_rft'
      FixedChar = True
      Size = 15
    end
  end
  object QDesCliente: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT *'
      'FROM frf_reclama_fotos')
    Left = 372
    Top = 88
  end
  object QDesProducto: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT *'
      'FROM frf_reclama_fotos')
    Left = 508
    Top = 80
  end
  object QListado: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT *'
      'FROM frf_reclamaciones')
    Left = 40
    Top = 88
  end
  object QMaestro: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_reclamaciones')
    Left = 40
    Top = 40
  end
  object QParamLocal: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * from frf_web_parametros')
    Left = 672
    Top = 32
    object QParamLocalcontador_wpr: TSmallintField
      FieldName = 'contador_wpr'
      Origin = 'COMERCIALIZACION.frf_web_parametros.contador_wpr'
    end
    object QParamLocalemail_wpr: TStringField
      FieldName = 'email_wpr'
      Origin = 'COMERCIALIZACION.frf_web_parametros.email_wpr'
      FixedChar = True
      Size = 100
    end
    object QParamLocalruta_imagenes_wpr: TStringField
      FieldName = 'ruta_imagenes_wpr'
      Origin = 'COMERCIALIZACION.frf_web_parametros.ruta_imagenes_wpr'
      FixedChar = True
      Size = 255
    end
  end
  object QParamRemoto: TQuery
    DatabaseName = 'BDWEB'
    RequestLive = True
    SQL.Strings = (
      'select *'
      'from frf_parametros')
    Left = 672
    Top = 184
    object QParamRemotocontador_p: TSmallintField
      FieldName = 'contador_p'
      Origin = 'BDWEB.frf_parametros.contador_p'
    end
    object QParamRemotoemail_p: TStringField
      DisplayWidth = 100
      FieldName = 'email_p'
      Origin = 'BDWEB.frf_parametros.email_p'
      FixedChar = True
      Size = 100
    end
  end
end
