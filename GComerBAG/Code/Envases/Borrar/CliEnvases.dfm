?
 TFCLIENVASES 0?  TPF0TFCliEnvasesFCliEnvasesLeft? Top? ActiveControlDBGridBorderIconsbiSystemMenu BorderStylebsDialogCaption&       UNIDAD DE FACTURACIÓN POR CLIENTEClientHeight?ClientWidth?Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style OldCreateOrderPositionpoScreenCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TnbLabelnbLabel5LeftTop? WidthdHeightCaption   Descripción EnvaseAboutNB 0.1/20020725  TnbLabelnbLabel6LeftTop? WidthdHeightCaption   Unidad FacturaciónAboutNB 0.1/20020725  TnbLabelnbLabel2LeftTopzWidthdHeightCaptionProducto BaseAboutNB 0.1/20020725  TnbLabelnbLabel3LeftTop? WidthdHeightCaptionEnvaseAboutNB 0.1/20020725  TnbStaticTextlblProductoBaseLeft? TopzWidth? HeightAboutNB 0.1/20020725  TnbStaticText	lblEnvaseLeft? Top? Width? HeightAboutNB 0.1/20020725  TnbLabelnbLabel7LeftTopzWidthPHeightCaption
   Nº PaletsAboutNB 0.1/20020725  TnbLabelnbLabel8LeftTop? WidthPHeightCaption	KGS PaletAboutNB 0.1/20020725  	TnbDBAlfaenvaseLeft? Top? Width!HeightAboutNB 0.1/20020725CharCaseecUpperCaseOnChangeenvaseChangeTabOrder	DataField	envase_ce
DataSource
DataSourceDBLink	NumChars  	TnbDBAlfaproductoBase_Left? TopzWidth!HeightAboutNB 0.1/20020725CharCaseecUpperCaseOnChangeproductoBase_ChangeTabOrder	DataFieldproducto_base_ce
DataSource
DataSourceDBLink	OnlyNumbers	NumChars  	TComboBoxunidad_fac_ceLeft? Top? WidthAHeightStylecsDropDownList
ItemHeight	ItemIndex TabOrderTextKGSItems.StringsKGSUNDCAJ   TPanelPanel1Left TopWidth?HeightRAlignalTop
BevelOuterbvNoneEnabledTabOrder  TnbLabelnbLabel1LeftTopWidthdHeightCaptionEmpresaAboutNB 0.1/20020725  TnbStaticText
lblEmpresaLeft? TopWidth? HeightAboutNB 0.1/20020725  TnbLabelnbLabel4LeftTop)WidthdHeightCaptionClienteAboutNB 0.1/20020725  TnbStaticText
lblClienteLeft? Top)Width? HeightAboutNB 0.1/20020725  	TnbDBAlfaempresaLeft? TopWidth!HeightAboutNB 0.1/20020725CharCaseecUpperCaseOnChangeempresaChangeTabOrder NumChars  	TnbDBAlfaclienteLeft? Top)Width!HeightAboutNB 0.1/20020725CharCaseecUpperCaseOnChangeclienteChangeTabOrderNumChars   	TnbDBAlfadescripcionLeft? Top? Width? HeightAboutNB 0.1/20020725CharCaseecUpperCaseEnabledTabOrder	DataFielddescripcion_ce
DataSource
DataSourceDBLink	NumChars  TDBGridDBGridLeftTop? Width?Height? TabStop
DataSource
DataSourceOptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgConfirmDeletedgCancelOnExit ReadOnly	TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height?TitleFont.NameMS Sans SerifTitleFont.Style Columns	AlignmenttaCenterExpanded	FieldNameproducto_base_ceTitle.AlignmenttaCenterTitle.CaptionProd.Width-Visible	 	AlignmenttaCenterExpanded	FieldName	envase_ceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style Title.AlignmenttaCenterTitle.CaptionEnvaseWidth0Visible	 Expanded	FieldNamedescripcion_ceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style Title.AlignmenttaCenterTitle.CaptionDescripcionWidth%Visible	 	AlignmenttaCenterExpanded	FieldNameunidad_fac_ceTitle.CaptionFacturar PorVisible	    TToolBarToolBar1Left Top Width?HeightButtonHeightButtonWidth2CaptionToolBar1ShowCaptions	TabOrder TToolButtonToolButton1Left TopActionAAnyadir  TToolButtonToolButton2Left2TopAction
AModificar  TToolButtonToolButton3LeftdTopActionABorrar  TToolButtonToolButton4Left? TopWidthCaptionToolButton4
ImageIndexStyletbsSeparator  TToolButtonToolButton5Left? TopActionAAceptar  TToolButtonToolButton6Left? TopAction	ACancelar  TToolButtonToolButton8LeftTopWidthCaptionToolButton8
ImageIndexStyletbsSeparator  TToolButtonToolButton7Left
TopActionACerrar   	TnbDBAlfan_palets_ceLeft\TopzWidth!HeightAboutNB 0.1/20020725CharCaseecUpperCaseOnChangeproductoBase_ChangeTabOrder	DataFieldn_palets_ce
DataSource
DataSourceDBLink	OnlyNumbers	NumChars  	TnbDBAlfakgs_palet_ceLeft\Top? Width!HeightAboutNB 0.1/20020725CharCaseecUpperCaseOnChangeenvaseChangeTabOrder		DataFieldkgs_palet_ce
DataSource
DataSourceDBLink	OnlyNumbers	NumChars  TDBGridDBGridPaletsLeft Top? Width}Height? 
DataSource
DataSourceOptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgConfirmDeletedgCancelOnExit TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height?TitleFont.NameMS Sans SerifTitleFont.Style ColumnsExpanded	FieldNamen_palets_ceTitle.AlignmenttaCenterTitle.CaptionPaletsWidth&Visible	 Expanded	FieldNamekgs_palet_ceTitle.AlignmenttaCenterTitle.CaptionKGSWidth+Visible	    TQueryQuery
BeforePostQueryBeforePostDatabaseName
BDProyectoRequestLive	SQL.Stringsselect *from frf_clientes_env LeftTopq TStringFieldQueryempresa_ce	FieldName
empresa_ceOrigin,COMERCIALIZACION.frf_clientes_env.empresa_ce	FixedChar	Size  TSmallintFieldQueryproducto_base_ce	FieldNameproducto_base_ceOrigin2COMERCIALIZACION.frf_clientes_env.producto_base_ce  TStringFieldQueryenvase_ce	FieldName	envase_ceOrigin+COMERCIALIZACION.frf_clientes_env.envase_ce	FixedChar	Size  TStringFieldQuerycliente_ce	FieldName
cliente_ceOrigin,COMERCIALIZACION.frf_clientes_env.cliente_ce	FixedChar	Size  TStringFieldQueryunidad_fac_ce	FieldNameunidad_fac_ceOrigin/COMERCIALIZACION.frf_clientes_env.unidad_fac_ce	FixedChar	Size  TStringFieldQuerydescripcion_ce	FieldNamedescripcion_ceOrigin0COMERCIALIZACION.frf_clientes_env.descripcion_ceSize  TSmallintFieldQueryn_palets_ce	FieldNamen_palets_ceOrigin/"COMER.DESARROLLO".frf_clientes_env.n_palets_ce  TSmallintFieldQuerykgs_palet_ce	FieldNamekgs_palet_ceOrigin0"COMER.DESARROLLO".frf_clientes_env.kgs_palet_ce   TDataSource
DataSourceAutoEditDataSetQueryLeft0Topq  TActionList
ActionListOnUpdateActionListUpdateLeft?Top?  TActionAAnyadirCaption   AñadirShortCut? 	OnExecuteAAnyadirExecute  TActionABorrarCaptionBorrarShortCuto	OnExecuteABorrarExecute  TAction
AModificarCaption	ModificarShortCutM	OnExecuteAModificarExecute  TActionAAceptarCaptionAceptarShortCutp	OnExecuteAAceptarExecute  TAction	ACancelarCaptionCancelarShortCut	OnExecuteACancelarExecute  TActionACerrarCaptionCerrar	OnExecuteACerrarExecute    