unit TBL002.Update_Field;

interface
Uses
  UtConexion;

Procedure TBL002_Update_Field_Execute(pCnx : TConexion);

implementation
Uses
  Classes,
  SysUtils,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function Tabla_Existe(pCnx : TConexion; pId : String) : Boolean;
Begin
  Result := pCnx.TableExists(pId);
End;

Function Exist_Field(pCnx : TConexion; pTable, pField : String) : Boolean;
Var
  lI : Integer;
  lLista : TStringList;
Begin
  Result := False;
  lLista := TStringList.Create;
  lLista := pCnx.LoadFieldsnames(pTable);
  lI := 0;
  While (lI < lLista.Count) And (Not Result) Do
  Begin
    Result := Trim(UpperCase(pField)) = Trim(UpperCase(lLista[lI]));
    Inc(lI);
  End;
  lLista.Free;
End;

Procedure Actualizar_Estructura(pCnx : TConexion; pTable, pField : String; pType : TTIPO_CAMPO; pSize : Integer);
Var
  lSQL : TQuery;
  lTexto : String;
Begin
  If Not pCnx.TableExists(pTable) Then
    Exit;

  If Not Exist_Field(pCnx, pTable, pField) Then
  Begin
    Try
      lSQL := TQuery.Create(Nil);
      lSQL.Connection := pCNX;

      If pSize <= 0 Then
        lTexto := 'ALTER TABLE ' + pTable + ' ADD ' + pField + ' '+ pCNX.Return_Type(pType) + ' '
      Else
        lTexto := 'ALTER TABLE ' + pTable + ' ADD ' + pField + ' '+ pCNX.Return_Type(pType) + '(' + IntToStr(pSize) + ')';
      lSQL.SQL.Add(lTexto);
      lSQL.ExecSQL;
      lSQL.Free;
    Except
      On E : Exception Do
        Utils_ManagerLog_Add('UPDATEFIELD', 'TBL002.Update_Field', 'Actualizar_Estructura', 'Actualizar_Estructura, ' + E.Message + ', ' + lTexto);
    End;
  End;
End;

Procedure TBL002_Update_Field_Execute(pCnx : TConexion);
Var
  lI : Integer;
  lTableName : String;
Begin
  If (pCnx = Nil) Or (Not pCnx.Connected) Then
    Exit;
//  Actualizar_Estructura(pCnx, Info_TablaGet(Id_TBL_Usuario           ).Name, 'ID_NOTIFICA_PRODUCTO', TYPE_VARCHAR, 001);
//  Actualizar_Estructura(pCnx, Info_TablaGet(Id_TBL_Producto          ).Name, 'ID_SERVICIO'         , TYPE_VARCHAR, 001);
//  Actualizar_Estructura(pCnx, Info_TablaGet(Id_TBL_Tercero           ).Name, 'D_VERIFICACION'      , TYPE_VARCHAR, 001);
//  Actualizar_Estructura(pCnx, Info_TablaGet(Id_TBL_Producto          ).Name, 'ID_FACTOR'           , TYPE_VARCHAR, 001);
//  Actualizar_Estructura(pCnx, Info_TablaGet(Id_TBL_Producto          ).Name, 'FACTOR_01'           , TYPE_FLOAT  , 000);
//  Actualizar_Estructura(pCnx, Info_TablaGet(Id_TBL_Producto          ).Name, 'FACTOR_02'           , TYPE_FLOAT  , 000);
//  Actualizar_Estructura(pCnx, Info_TablaGet(Id_TBL_Producto          ).Name, 'FACTOR_03'           , TYPE_FLOAT  , 000);
//  Actualizar_Estructura(pCnx, Info_TablaGet(Id_TBL_Explosion_Material).Name, 'VALOR_UNITARIO'      , TYPE_FLOAT  , 000);
End;

end.
