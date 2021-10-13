unit ItemSincronizable;

interface

uses
  DB,
  DBTables,
  WideStrings,
  SqlExpr,

  DBClient,
  SimpleDS,
  Classes,

  ConexionAWSAurora
  ;


type
 TItemSincronizable = class

  private
    //FQSincPendiente: TQuery;
    FBdOrigen: TDatabase;
    FBdDestino: TConexionAWSAurora;

    FQOrigen: TQuery;
    FQDestino: TSimpleDataset;

    FTablaOrigen: String;
    FTablaDestino: String;

    FListaCamposClave: String;

    FCamposClave: TStringList;

  protected
    // procedure GuardarSincronizacionPendiente
    procedure CopyRecord(Source: TDataSet; Destination: TDataset; const ACamposClave: TStringList; EsAlta: boolean = false);

  public
    constructor Create(ABdOrigen: TDatabase; ATablaOrigen: String; ABdDestino: TConexionAWSAurora; ATablaDestino: String; AListaCamposClave: String);
    destructor Destroy; override;

    procedure Sincroniza(const AValoresClave: array of const);
  end;

implementation

uses
  SysUtils;

{ TItemSincronizable }

procedure TItemSincronizable.CopyRecord(Source, Destination: TDataset; const ACamposClave: TStringList; EsAlta: boolean = false);
var
  Ind:longint;
  SField, DField: TField;
  i: integer;
  esCampoClave: boolean;
begin
  for Ind:=0 to Source.FieldCount - 1 do
   begin
     SField := Source.Fields[ Ind ];
     DField := Destination.FindField( SField.FieldName );

     if not EsAlta then
     begin
       esCampoClave := false;
       for i := 0 to ACamposClave.Count-1 do
         if DField.FieldName = ACamposClave.Strings[i] then
         begin
          esCampoClave := True;
          Break;
         end;

       if esCampoClave then
        Continue;
     end;

     if (DField <> nil) and (DField.FieldKind = fkData) and
        not DField.ReadOnly then
        if (SField.DataType = ftString) or
           (SField.DataType <> DField.DataType) then
           DField.AsString := Trim(SField.AsString)
        else
           DField.Assign( SField )
   end;
end;

constructor TItemSincronizable.Create(ABdOrigen: TDatabase;
  ATablaOrigen: String; ABdDestino: TConexionAWSAurora; ATablaDestino,
  AListaCamposClave: String);
var
  strWhere: String;
  i: Integer;
begin
  FBdOrigen := ABdOrigen;
  FBdDestino := ABdDestino;

  FTAblaOrigen := ATablaOrigen;
  FTablaDestino := ATablaDestino;

  FListaCamposClave := AListaCamposClave;

  // Descomponer la lista de campos clave y generer el where de las SQL

  FCamposClave := TStringList.Create;
  FCamposClave.CommaText := FListaCamposClave;

  if FCamposClave.Count = 0 then
    raise Exception.CreateFmt('La lista de campos clave está vacía', [])

  else if FCamposClave.Count = 1 then
  begin
    strWhere := Format('%s=:%s', [ FCamposClave.Strings[0], FCamposClave.Strings[0] ]);
  end
  else
  begin
    strWhere := Format('%s=:%s', [ FCamposClave.Strings[0], FCamposClave.Strings[0] ]);
    for i := 1 to FCamposClave.Count - 1 do
      strWhere := Format('%s and %s=:%s', [ strWhere, FCamposClave.Strings[i], FCamposClave.Strings[i] ]);
  end;

  FQOrigen := TQuery.Create(nil);
  FQOrigen.DatabaseName := FBdOrigen.DatabaseName;
  FQOrigen.SQL.Add(Format('select * from %s where %s', [ FTablaOrigen, strWhere ]));


  FQDestino := TSimpleDataset.Create(nil);
  FQDestino.Connection := FBdDestino;
  FQDestino.DataSet.CommandText := Format('select * from %s where %s', [ FTablaDestino, strWhere ]);

end;

destructor TItemSincronizable.Destroy;
begin
  FCamposClave.Free;
end;

procedure TItemSincronizable.Sincroniza(const AValoresClave: array of const);
var
  i: integer;
begin

  { TODO : Comprobor que el numero de campos clave coincide con el numero de valores }

  for i := 0 to FCamposClave.Count - 1 do
  begin
    FQOrigen.ParamByName(FCamposClave.Strings[i]).AsString := AValoresClave[i].VPChar;
    FQDestino.Dataset.Params.ParamByName(FCamposClave.Strings[i]).AsString := AValoresClave[i].VPChar;
  end;

  FQOrigen.Open;
  FQDestino.Open;

  // Delete
  if FQOrigen.isEmpty then
  begin
    if not FQDestino.IsEmpty then
    begin
      FQDestino.Edit;
      FQDestino.Fields.FieldByName('deleted_at').asDateTime := FBdDestino.GetCurrentTimestamp;
      FQDestino.Post;
    end;
  end
  // Insert
  else if FQDestino.isEmpty then
  begin
    FQDestino.Append;
    CopyRecord(FQOrigen, FQDestino, FCamposClave, True);
    FQDestino.Fields.FieldByName('id').asInteger := 0;
    FQDestino.Fields.FieldByName('created_at').asDateTime := FBdDestino.GetCurrentTimestamp;
  end
  // Update
  else
  begin
    FQDestino.Edit;
    CopyRecord(FQOrigen, FQDestino, FCamposClave);
    FQDestino.Fields.FieldByName('updated_at').asDateTime := FBdDestino.GetCurrentTimestamp;
    FQDestino.Post;
  end;

  FQDestino.ApplyUpdates(-1);
  FQOrigen.Close;
  FQDestino.Close;
end;

end.

