unit ListaCodigoValorCB;

interface

type
  RNodoLista = record
    sCodigo: String;
    rValor: Real;
  end;
  TListaCodigoValor= Array of RNodoLista;

function LimpiarLista( const ALista: TListaCodigoValor) : TListaCodigoValor;
function AnyadirNodo( const ALista: TListaCodigoValor; const ANodo: RNodoLista ): TListaCodigoValor;

implementation

function LimpiarLista( const ALista: TListaCodigoValor) : TListaCodigoValor;
begin
  result:= ALista;
  SetLength( result, 0 );
end;

function AnyadirNodo( const ALista: TListaCodigoValor; const ANodo: RNodoLista ): TListaCodigoValor;
var
  bFlag: Boolean;
  i: integer;
begin
  result:= ALista;
  bFlag:= False;
  i:= 0;
  while ( i < length( ALista ) ) and ( not bFlag )do
  begin
    if ALista[i].sCodigo = ANodo.sCodigo then
    begin
      bFlag:= True;
      ALista[i].rValor:= ALista[i].rValor + ANodo.rValor;
    end;
    inc( i );
  end;
  if not bFlag then
  begin
    i:= Length( result );
    SetLength( result, i +1 );
    result[i].sCodigo:= ANodo.sCodigo;
    result[i].rValor:= ANodo.rValor;
  end;
end;

end.
