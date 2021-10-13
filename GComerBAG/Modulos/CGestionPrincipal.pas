unit CGestionPrincipal;

interface
uses Principal, CVariables, SysUtils, CMaestroDetalle, CMaestro,
  dbtables, ComCtrls, ActnList, Dialogs;

var
     //Formularios activos
  M: TMaestro;
  MD: TMaestroDetalle;
  FormType: TFormulario;

     //Botones activos
  btnAltasActive, btnModificarActive, btnBorrarActive, btnLocalizarActive: Boolean;
  btnAltasActiveDet, btnModificarActiveDet, btnBorrarActiveDet: Boolean;

//Barra de Heramientas activa del formulario
procedure BHFormulario;
procedure BHMaestroDeshabilitar(estado: Boolean);
procedure BHMaestroDetalleDeshabilitar(estado: Boolean);
procedure BHDeshabilitar;
procedure BHRestaurar;

//botones activos de la Barra de Herramientas activa
procedure BHEstado;
procedure BHGrupoDesplazamientoMaestro(estado: TPosicionCursor);
procedure BHGrupoDesplazamientoDetalle(estado: TPosicionCursor);
procedure BHGrupoAccionMaestro(estado: TEstado);
procedure BHGrupoAccionDetalle(estado: TEstado; estadoD: TEstadoDetalle);
procedure BHGrupoDecision(estado: Boolean);
procedure BHGrupoImpresion(estado: Boolean);

//texto de la Barra de Estado del formulario
procedure BETexto(panel1, panel2: string);
procedure BEEstado;
procedure BERegistros;
procedure BEMensajes(msg: string);

  //**************************************************************
  //Comprueba que no esten las rejillas desplegadas antes de
  //intentar cerrar el formulario
function CerrarForm(aceptar: boolean): boolean;


////////////////////////////////////////////////////////////////
//IMPLEMENTACION
////////////////////////////////////////////////////////////////

implementation

uses UDMConfig;

var
  BotonesBarra: array of boolean;

function CerrarForm(aceptar: boolean): Boolean;
begin
     //Esta la rejilla desplegada
  CerrarForm := false;
  if aceptar then
  begin
          //Esta la rejilla desplegada
    if (gRF <> nil) then
    begin
      try
        if (esVisible( gRF )) then
        begin
          gRF.DblClick;
          Exit;
        end;
      except
      end;
    end;
          //Esta el calendario desplegada
    if (gCF <> nil) then
    begin
      try
        if (esVisible( gCF )) then
        begin
          gCF.DblClick;
          Exit;
        end;
      except
      end;
    end;
  end
  else
  begin
    if (gRF <> nil) then
    begin
      try
        if (esVisible( gRF )) then
        begin
          gRF.DoExit;
          Exit;
        end;
      except
      end;
    end;
          //Esta el calendario desplegada
    if (gCF <> nil) then
    begin
      try
        if (esVisible( gCF )) then
        begin
          gCF.DoExit;
          Exit;
        end;
      except
      end;
    end;
  end;
  CerrarForm := true;
end;


procedure BHFormulario;
begin
  with FPrincipal do
    if (FormType = tfDirector) then
    begin
      // Barra Maestro - Ocultar
      TBBarraMaestro.Hide;
      BHMaestroDeshabilitar(true);
      // Barra Detalle - Ocultar
      TBBarraMaestroDetalle.Hide;
      BHMaestroDetalleDeshabilitar(true);
      // Menu principal - Habilitar
      HabilitarMenu(true);
      //Escape salir del program
      FPrincipal.ACerrar.ShortCut := $1B;
      FPrincipal.AMDCancelar.ShortCut := $0;
      FPrincipal.AMDSalir.ShortCut := $0;
    end
    else
      if (FormType = tfMaestro) then
      begin
        if TBBarraMaestroDetalle.Visible = true then
          TBBarraMaestroDetalle.Hide;
      // Barra Maestro - Mostrar
        TBBarraMaestro.Top := 2;
        TBBarraMaestro.Left := 11;
        TBBarraMaestro.Width := 414;
        BHMaestroDeshabilitar(false);
        TBBarraMaestro.Show;
      // Menu principal - DesHabilitar
        HabilitarMenu(False);
      end
      else if (FormType = tfMaestroDetalle) then
      begin
        if TBBarraMaestro.Visible = true then
          TBBarraMaestro.Hide;
      // Barra Maestro/Detalle - Mostrar
        TBBarraMaestroDetalle.Top := 2;
        TBBarraMaestroDetalle.Left := 11;
        TBBarraMaestroDetalle.Width := 582;
        BHMaestroDeshabilitar(False);
        BHMaestroDetalleDeshabilitar(False);
        TBBarraMaestroDetalle.Show;
      // Menu principal - DesHabilitar
        HabilitarMenu(False);
      end
      else if (FormType = tfOther) then
      begin
        if TBBarraMaestroDetalle.Visible = true then
          TBBarraMaestroDetalle.Hide;
        if TBBarraMaestro.Visible = true then
          TBBarraMaestro.Hide;
        HabilitarMenu(False);
        FPrincipal.AIPrevisualizar.Enabled := false;
      end;
end;

procedure BHMaestroDeshabilitar(estado: Boolean);
begin
     //Des/Habilitamos acciones segun sean necesarias
  with FPrincipal do
  begin
    AMAnterior.Enabled := not estado;
    AMSiguiente.Enabled := not estado;
    AMPrimero.Enabled := not estado;
    AMUltimo.Enabled := not estado;

    AMAltas.Enabled := (not estado) and gbEscritura and btnAltasActive;
    AMModificar.Enabled := (not estado) and gbEscritura and btnModificarActive;
    AMBorrar.Enabled := (not estado) and gbEscritura and btnBorrarActive;
    AMLocalizar.Enabled := not estado and btnLocalizarActive;

    AMDAceptar.Enabled := not estado;
    AMDCancelar.Enabled := not estado;
    AMDSalir.Enabled := not estado;
  end;
end;

procedure DeshabilitarBarra(var ABarra: TToolBar);
var
  i: integer;
begin
  SetLength(BotonesBarra, ABarra.ButtonCount);
  i := 0;
  while i < ABarra.ButtonCount do
  begin
    BotonesBarra[i] := ABarra.Buttons[i].Enabled;
    if Assigned(ABarra.Buttons[i].Action) then
      TAction(ABarra.Buttons[i].Action).Enabled := False;
    inc(i);
  end;
end;

procedure RestaurarBarra(var ABarra: TToolBar);
var
  i: integer;
begin
  i := 0;
  while i < Length(BotonesBarra) do
  begin
    if Assigned(ABarra.Buttons[i].Action) then
      TAction(ABarra.Buttons[i].Action).Enabled := BotonesBarra[i];
    inc(i);
  end;
end;

procedure BHDeshabilitar;
begin
  if FPrincipal.TBBarraMaestro.Visible then
    DeshabilitarBarra(FPrincipal.TBBarraMaestro)
  else
    DeshabilitarBarra(FPrincipal.TBBarraMaestroDetalle);
end;

procedure BHRestaurar;
begin
  if FPrincipal.TBBarraMaestro.Visible then
    RestaurarBarra(FPrincipal.TBBarraMaestro)
  else
    RestaurarBarra(FPrincipal.TBBarraMaestroDetalle);
end;

procedure BHMaestroDetalleDeshabilitar(estado: Boolean);
begin
     //Des/Habilitamos acciones segun sean necesarias
  with FPrincipal do
  begin
    ADAnterior.Enabled := not estado;
    ADSiguiente.Enabled := not estado;

    ADAltas.Enabled := not estado and btnAltasActiveDet;
    ADModificar.Enabled := not estado and btnModificarActiveDet;
    ADBorrar.Enabled := not estado and btnBorrarActiveDet;
  end;
end;

procedure BHGrupoImpresion(estado: Boolean);
begin
     //Des/Habilitamos acciones segun sean necesarias
  with FPrincipal do
  begin
    AIPrevisualizar.Enabled := estado;
  end;
end;


procedure BHEstado;
begin
  //Grupo desplazamiento inicial
  BHGrupoAccionMaestro(M.Estado);
  if FormType = tfMaestroDetalle then
    BHGrupoAccionDetalle(M.Estado, MD.EstadoDetalle);

  if M.Estado in [teConjuntoResultado] then
  begin
    BHGrupoImpresion(True);
    BHGrupoDecision(False);
    {BHGrupoDesplazamientoMaestro(pcInicio);
    if gFormulario=tfMaestroDetalle then
       BHGrupoDesplazamientoDetalle(pcInicio);
    }
  end
  else
    if M.Estado in [teEspera] then
    begin
      BHGrupoImpresion(False);
      BHGrupoDecision(False);
    {
    BHGrupoDesplazamientoMaestro(pcNulo);
    if gFormulario=tfMaestroDetalle then
       BHGrupoDesplazamientoDetalle(pcNulo);
    }
    end
    else
      if M.Estado in [teLocalizar, teModificar, teBorrar, teAlta, teOperacionDetalle] then
      begin
        BHGrupoImpresion(False);
        BHGrupoDecision(True);
        BHGrupoDesplazamientoMaestro(pcNulo);
        if FormType = tfMaestroDetalle then
          BHGrupoDesplazamientoDetalle(pcNulo);
      end;
end;


procedure BHGrupoDesplazamientoDetalle(estado: TPosicionCursor);
begin
{  if MD.PCDetalle=estado then
     Exit;
}
  if MD = nil then Exit;
  MD.PCDetalle := estado;
  with FPrincipal do
  begin
    ADSiguiente.Enabled := True;
    ADAnterior.Enabled := True;


    if (MD.PCDetalle = pcNulo) or (MD.PCDetalle = pcFin) then
      ADSiguiente.Enabled := False;

    if (MD.PCDetalle = pcNulo) or (MD.PCDetalle = pcInicio) then
      ADAnterior.Enabled := False;

  end;
end;

procedure BHGrupoDesplazamientoMaestro(estado: TPosicionCursor);
begin
  if M = nil then Exit;
  M.PCMaestro := estado;
  if estado = pcNulo then
  begin
    with FPrincipal do
    begin
      AMPrimero.Enabled := False;
      AMAnterior.Enabled := False;
      AMSiguiente.Enabled := False;
      AMUltimo.Enabled := False;
    end;
  end
  else
    if estado = pcMedio then
    begin
      with FPrincipal do
      begin
        AMPrimero.Enabled := True;
        AMAnterior.Enabled := True;
        AMSiguiente.Enabled := True;
        AMUltimo.Enabled := true;
      end;
    end
    else
      if estado = pcInicio then
      begin
        with FPrincipal do
        begin
          AMPrimero.Enabled := False;
          AMAnterior.Enabled := False;
          AMSiguiente.Enabled := True;
          AMUltimo.Enabled := True;
        end;
      end
      else
        if estado = pcFin then
        begin
          with FPrincipal do
          begin
            AMPrimero.Enabled := True;
            AMAnterior.Enabled := True;
            AMSiguiente.Enabled := False;
            AMUltimo.Enabled := False;
          end;
        end;
  Exit;
end;

procedure BHGrupoAccionMaestro(estado: TEstado);
begin
  with FPrincipal do
    if (estado = teLocalizar) or
      (estado = teModificar) or
      (estado = teBorrar) or
      (estado = teAlta) or
      (estado = teOperacionDetalle) then
    begin
    //Esperando Aceptar cancelar
      AMLocalizar.Enabled := False;
      AMModificar.Enabled := False;
      AMBorrar.Enabled := False;
      AMAltas.Enabled := False;
    end
    else
      if estado = teConjuntoResultado then
      begin
        AMLocalizar.Enabled := True and btnLocalizarActive;
        AMAltas.Enabled := True and gbEscritura and btnAltasActive;
        AMModificar.Enabled := True and gbEscritura and btnModificarActive;
        AMBorrar.Enabled := True and gbEscritura and btnBorrarActive;
      end
      else
        if estado = teEspera then
        begin
          AMLocalizar.Enabled := True and btnLocalizarActive;
          AMAltas.Enabled := True and gbEscritura and btnAltasActive;
          AMModificar.Enabled := False;
          AMBorrar.Enabled := False;
        end;
end;

procedure BHGrupoAccionDetalle(estado: TEstado; estadoD: TEstadoDetalle);
begin
  with FPrincipal do
    if (estadoD = tedAlta) or
      (estadoD = tedAltaRegresoMaestro) or
      (estadoD = tedBorrar) or
      (estadoD = tedModificar) or
      (estadoD = tedOperacionMaestro) or
      (estadoD = tedEspera) then
    begin
      ADModificar.Enabled := False;
      ADBorrar.Enabled := False;
      ADAltas.Enabled := False;
    end
    else
      if estadoD = tedConjuntoResultado then
      begin
        ADAltas.Enabled := True and gbEscritura and btnAltasActiveDet;
        if MD.DataSourceDetalle.DataSet.CanModify then
          ADModificar.Enabled := true and gbEscritura and btnModificarActiveDet
        else
          ADModificar.Enabled := false;
        ADBorrar.Enabled := True and gbEscritura and btnBorrarActiveDet;
      end
      else
        if estadoD = tedNoConjuntoResultado then
        begin
          if (estado = teEspera) then
            ADAltas.Enabled := false
          else
            ADAltas.Enabled := True and gbEscritura and btnAltasActiveDet;
          ADModificar.Enabled := False;
          ADBorrar.Enabled := False;
        end;
end;

procedure BHGrupoDecision(estado: Boolean);
begin
  with FPrincipal do
  begin
    AMDAceptar.Enabled := estado;
    AMDCancelar.Enabled := estado;
    AMDSalir.Enabled := not estado;
  end;
  if estado then
  begin
    //Escape cancelar accion
    FPrincipal.ACerrar.ShortCut := $0;
    FPrincipal.AMDCancelar.ShortCut := $1B;
    FPrincipal.AMDSalir.ShortCut := $0;
  end
  else
  begin
    //Escape salir del formulario
    FPrincipal.ACerrar.ShortCut := $0;
    FPrincipal.AMDCancelar.ShortCut := $0;
    FPrincipal.AMDSalir.ShortCut := $1B;
  end;

end;

//********************************************************************
//MENSAJES BARRA DE ESTADO
//********************************************************************

procedure BETexto(panel1, panel2: string);
begin
  if panel1 <> 'Nil' then
    FPrincipal.SBBarraEstado.Panels[1].Text := panel1;
  if panel2 <> 'Nil' then
    FPrincipal.SBBarraEstado.Panels[2].Text := panel2;
  FPrincipal.Refresh;
end;

procedure BEEstado;
begin
  case M.Estado of
    teAlta:
      begin
        BETexto('Alta', '');
      end;
    teModificar:
      begin
        BETexto('Modificar', '');
      end;
    teLocalizar:
      begin
        BETexto('Localizar', '');
      end;
    teBorrar:
      begin
        BETexto('Borrar', '');
      end;
    teConjuntoResultado:
      begin
        BERegistros;
      end;
    teEspera:
      begin
        BETexto('', '');
      end;
    teOperacionDetalle:
      begin
        case MD.EstadoDetalle of
          tedAlta, tedAltaRegresoMaestro:
            begin
              BETexto('Alta', '');
            end;
          tedModificar:
            begin
              BETexto('Modificar', '');
            end;
          tedBorrar:
            begin
              BETexto('Borrar', '');
            end;
        end;
      end;
  end;
end;

procedure BERegistros;
var
  msgRegistros: string;
begin
  msgRegistros := '';
  case M.Estado of
    teConjuntoResultado:
      begin
        msgRegistros :=  '[' + IntToStr(M.Registro) + ':' + IntToStr(M.Registros) + ']';
        if FormType = tfMaestroDetalle then
        begin
            msgRegistros :=  msgRegistros + '[' + IntToStr(MD.Detalles)+ ']';
        end
      end;
  end;
  BETexto(MsgRegistros, '');
end;

procedure BEMensajes(msg: string);
begin
  BETexto('Nil', msg);
end;

initialization
  btnAltasActive := True;
  btnModificarActive := True;
  btnBorrarActive := True;
  btnLocalizarActive := True;

  btnAltasActiveDet := True;
  btnModificarActiveDet := True;
  btnBorrarActiveDet := True;

end.




