unit TBL006.Administrador_Documento;

interface
Uses
  UtConexion;

Function TBL006_Administrador_Documento_Execute(pCnx : TConexion) : Boolean;
//Function Retornar_Numero_Adm_Documento(pCnx : TConexion; pCodigo_Adm_Documento : String) : String;
//Function Actualizar_Numero_Adm_Documento(pCnx : TConexion; pCodigo_Adm_Documento, pValue : String) : Boolean;
//Function Retornar_Formato_Adm_Documento(pCnx : TConexion; pCodigo_Tercero, pCodigo_Sinonimo, pDocumento : String; pMain : Boolean; pOperacion : Boolean = False) : String; Overload;
//Function Retornar_Formato_Adm_Documento(pCnx : TConexion; pCodigo_Bodega, pTipo : String) : String;  Overload;
//Function Retornar_Formato_Adm_Documento(pCnx : TConexion; pTipo : String) : String; Overload;
//Function Retornar_Salida_Disponible(pCnx : TConexion; Const pCodigo_Bodega, pTipo : String; Var pNumero_Documento : String) : Boolean;
//Function Tablename_Adm_Documento_Get_Prefix_Number_Fenalco(pCnx : TConexion; Const pTipo : String; Var pPrefix, pNumber, pIdNumeration : String) : Boolean;
//Function Tablename_Adm_Documento_Update_Prefix_Number_Fenalco(pCnx : TConexion; Const pTipo, pNumber : String) : Boolean;

implementation

Uses
  DB,
  Math,
  UtError,
  Classes,
  SysUtils,
  StrUtils,
  Variants,
  UtFuncion,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function TBL006_Administrador_Documento_Execute(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  if Not pCnx.TableExists(Info_TablaGet(Id_TBL_Administrador_Documento).Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + Info_TablaGet(Id_TBL_Administrador_Documento).Name + ' '           );
      pCnx.TMP.SQL.Add('   (  '                                                                                );
      pCnx.TMP.SQL.Add('      CODIGO_DOCUMENTO '  + pCNX.Return_Type(TYPE_VARCHAR) + ' (030)  ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NOMBRE '            + pCNX.Return_Type(TYPE_VARCHAR) + ' (255)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DOCUMENTO_INICIAL ' + pCNX.Return_Type(TYPE_INT    ) + ' '        + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DOCUMENTO_ACTUAL  ' + pCNX.Return_Type(TYPE_INT    ) + ' '        + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DOCUMENTO_FINAL   ' + pCNX.Return_Type(TYPE_INT    ) + ' '        + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DESCRIPCION '       + pCNX.Return_Type(TYPE_TEXT   ) + ' '        + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_ACTIVO '         + pCNX.Return_Type(TYPE_VARCHAR) + ' (001) '  + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TAG_INFO '          + pCNX.Return_Type(TYPE_INT    ) + ' '        + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_DOCUMENTO) '                                                 );
      pCnx.TMP.SQL.Add('   )   '                                                                               );
      pCnx.TMP.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        Utils_ManagerLog_Add('DATABASE', 'TBL006.Administrador_Documento', 'TBL006_Administrador_Documento_Execute', E.Message);
      End;
    End;
  End;
End;

//Function Retornar_Numero_Adm_Documento(pCnx : TConexion; pCodigo_Adm_Documento : String) : String;
//Var
//  lSQL : TQuery;
//Begin
//  Result := ID_SIN_DOCTO;
//  Try
//    lSQL := TQuery.Create(Nil);
//    lSQL.Active := False;
//    lSQL.Connection := pCnx;
//    lSQL.SQL.Clear;
//    lSQL.SQL.Add(' SELECT  * FROM ' + Retornar_Info_Tabla(Id_Adm_Documento).Name + ' (nolock) ');
//    lSQL.SQL.Add(' WHERE ' + pCnx.Trim_Sentence('CODIGO_ADM_DOCUMENTO') + ' =' + #39 + Trim(pCodigo_Adm_Documento) + #39 + ' ');
//    lSQL.Active := True;
//    If lSQL.Active And (lSQL.RecordCount > 0) Then
//    Begin
//      Result := lSQL.FieldByName('DOCUMENTO_ACTUAL').AsString;
//      Next_Value(Result);
//    End;
//    lSQL.Active := False;
//    lSQL.Free;
//  Except
//    On E : Exception Do
//      Utils_ManagerLog_Add('Tablename_Adm_Documento, Retornar_Numero_Adm_Documento, ' + E.Message);
//  End;
//End;
//
//Function Actualizar_Numero_Adm_Documento(pCnx : TConexion; pCodigo_Adm_Documento, pValue : String) : Boolean;
//Var
//  lSQL : TQuery;
//Begin
//  Result := False;
//  Try
//    lSQL := TQuery.Create(Nil);
//    lSQL.Active := False;
//    lSQL.Connection := pCnx;
//    lSQL.SQL.Add(' SELECT  * FROM ' + Retornar_Info_Tabla(Id_Adm_Documento).Name + ' ' + ' (nolock) ');
//    lSQL.SQL.Add(' WHERE ' + pCNX.Trim_Sentence('CODIGO_ADM_DOCUMENTO') + ' =' + #39 + Trim(pCodigo_Adm_Documento) + #39 + ' ');
//    lSQL.Active := True;
//    If lSQL.Active And (lSQL.RecordCount > 0) Then
//    Begin
//      lSQL.Edit;
//      lSQL.FieldByName('DOCUMENTO_ACTUAL').AsString := pValue;
//      lSQL.Post;
//      Result := True;
//    End;
//    lSQL.Active := False;
//    lSQL.Free;
//  Except
//    On E : Exception Do
//      Utils_ManagerLog_Add('Tablename_Adm_Documento, Retornar_Numero_Adm_Documento, ' + E.Message);
//  End;
//End;
//
//Procedure Tablename_Adm_Documento_Validate_Path(Const pInp : String; Var pOut : String);
//Var
//  lI : Integer;
//  lSL : TStringList;
//Begin
//  pOut := pInp;
//  lSL := TStringList.Create;
//  Desglosar_Texto_Caracter(pInp, ',', lSL);
//  For lI := 0 To lSL.Count-1 Do
//  Begin
//    lSL[lI] := Trim(lSL[lI]);
//    If FileExists(lSL[lI]) Then
//    Begin
//      Utils_ManagerLog_Add('Tablename_Adm_Documento, Tablename_Adm_Documento_Validate_Path, existe ' + lSL[lI]);
//      pOut := lSL[lI];
//    End
//    Else
//    Begin
//      Utils_ManagerLog_Add('Tablename_Adm_Documento, Tablename_Adm_Documento_Validate_Path, no existe ' + lSL[lI]);
//    End;
//  End;
//  lSL.Clear;
//  FreeAndNil(lSL);
//End;
//
//Function Retornar_Formato_Adm_Documento(pCnx : TConexion; pCodigo_Tercero, pCodigo_Sinonimo, pDocumento : String; pMain : Boolean; pOperacion : Boolean = False) : String;
//Var
//  lSQL : TQuery;
//  lBodega : String;
//Begin
//  Result := '';
//  lBodega := pCnx.GetValue(Retornar_Info_Tabla(Id_Tercero_Sinonimo).Name,['CODIGO_TERCERO', 'CODIGO_SINONIMO'], [pCodigo_Tercero, pCodigo_Sinonimo], ['CODIGO_BODEGA']);
//  If Vacio(lBodega) Then
//    lBodega := pCnx.GetValue(Retornar_Info_Tabla(Id_Tercero).Name,['CODIGO_TERCERO'], [pCodigo_Tercero], ['CODIGO_BODEGA']);
//  Try
//    lSQL := TQuery.Create(Nil);
//    lSQL.Active := False;
//    lSQL.Connection := pCnx;
//    lSQL.SQL.Add(' SELECT  * FROM ' + Retornar_Info_Tabla(Id_Adm_Documento).Name + ' ' + ' (nolock) ');
//    lSQL.SQL.Add(' WHERE ' + pCNX.Trim_Sentence('CODIGO_ADM_DOCUMENTO') + ' =' + #39 + Trim(lBodega + pDocumento) + #39 + ' ');
//    lSQL.Active := True;
//    If lSQL.Active And (lSQL.RecordCount > 0) Then
//    Begin
//      Result := lSQL.FieldByName('FORMATO').AsString;
//      If pMain And (Not Vacio(lSQL.FieldByName('FORMATO2').AsString)) Then
//        Result := lSQL.FieldByName('FORMATO2').AsString;
//      If pOperacion And (Not Vacio(lSQL.FieldByName('FORMATO3').AsString)) Then
//        Result := lSQL.FieldByName('FORMATO3').AsString;
//      Tablename_Adm_Documento_Validate_Path(Result, Result);
//    End;
//    lSQL.Active := False;
//    lSQL.Free;
//  Except
//    On E : Exception Do
//      Utils_ManagerLog_Add('Tablename_Adm_Documento, Retornar_Formato_Adm_Documento, ' + E.Message);
//  End;
//End;
//
//Function Retornar_Formato_Adm_Documento(pCnx : TConexion; pCodigo_Bodega, pTipo : String) : String;
//Var
//  lSQL : TQuery;
//Begin
//  Result := '';
//  Try
//    lSQL := TQuery.Create(Nil);
//    lSQL.Active := False;
//    lSQL.Connection := pCnx;
//    lSQL.SQL.Add(' SELECT  * FROM ' + Retornar_Info_Tabla(Id_Adm_Documento).Name + ' ' + ' (nolock) ');
//    lSQL.SQL.Add(' WHERE ' + pCNX.Trim_Sentence('CODIGO_ADM_DOCUMENTO') + ' =' + #39 + Trim(pCodigo_Bodega + pTipo) + #39 + ' ');
//    lSQL.Active := True;
//    If lSQL.Active And (lSQL.RecordCount > 0) Then
//    Begin
//      Result := lSQL.FieldByName('FORMATO').AsString;
//      If Vacio(Result) And (Not Vacio(lSQL.FieldByName('FORMATO2').AsString)) Then
//        Result := lSQL.FieldByName('FORMATO2').AsString;
//      If Vacio(Result) And (Not Vacio(lSQL.FieldByName('FORMATO3').AsString)) Then
//        Result := lSQL.FieldByName('FORMATO3').AsString;
//      Tablename_Adm_Documento_Validate_Path(Result, Result);
//    End;
//    lSQL.Active := False;
//    lSQL.Free;
//  Except
//    On E : Exception Do
//      Utils_ManagerLog_Add('Tablename_Adm_Documento, Retornar_Formato_Adm_Documento, ' + E.Message);
//  End;
//End;
//
//Function Retornar_Formato_Adm_Documento(pCnx : TConexion; pTipo : String) : String;
//Var
//  lSQL : TQuery;
//Begin
//  Result := '';
//  Try
//    lSQL := TQuery.Create(Nil);
//    lSQL.Active := False;
//    lSQL.Connection := pCnx;
//    lSQL.SQL.Add(' SELECT  * FROM ' + Retornar_Info_Tabla(Id_Adm_Documento).Name + ' ' + ' (nolock) ');
//    lSQL.SQL.Add(' WHERE ' + pCNX.Trim_Sentence('CODIGO_ADM_DOCUMENTO') + ' =' + #39 + Trim(pTipo) + #39 + ' ');
//    lSQL.Active := True;
//    If lSQL.Active And (lSQL.RecordCount > 0) Then
//    Begin
//      Result := lSQL.FieldByName('FORMATO').AsString;
//      If Vacio(Result) And (Not Vacio(lSQL.FieldByName('FORMATO2').AsString)) Then
//        Result := lSQL.FieldByName('FORMATO2').AsString;
//      If Vacio(Result) And (Not Vacio(lSQL.FieldByName('FORMATO3').AsString)) Then
//        Result := lSQL.FieldByName('FORMATO3').AsString;
//      Tablename_Adm_Documento_Validate_Path(Result, Result);
//    End;
//    lSQL.Active := False;
//    lSQL.Free;
//  Except
//    On E : Exception Do
//      Utils_ManagerLog_Add('Tablename_Adm_Documento, Retornar_Formato_Adm_Documento, ' + E.Message);
//  End;
//End;
//
//Function Retornar_Salida_Disponible(pCnx : TConexion; Const pCodigo_Bodega, pTipo : String; Var pNumero_Documento : String) : Boolean;
//Var
//  lDoc : TQuery;
//  lTable_C : TQuery;
//  lTable_H : TQuery;
//Begin
//  Result := False;
//  pNumero_Documento := '';
//  Try
//    lDoc := TQuery.Create(Nil);
//    lDoc.Active := False;
//    lDoc.Connection := pCnx;
//    lDoc.SQL.Add(' SELECT  * FROM ' + Retornar_Info_Tabla(Id_Disponible).Name + ' ' + ' (nolock) ');
//    lDoc.SQL.Add(' WHERE ' + pCNX.Trim_Sentence('CODIGO_BODEGA') + ' =' + #39 + Trim(pCodigo_Bodega) + #39 + ' ');
//    If pTipo = 'SA' Then
//      lDoc.SQL.Add(' AND (' + pCNX.Trim_Sentence('TIPO') + ' =' + QuotedStr(Trim('')) + 'OR ' + pCNX.Trim_Sentence('TIPO') + ' =' + QuotedStr(Trim(pTipo)) + ' OR TIPO IS NULL )')
//    Else
//      lDoc.SQL.Add(' AND ' + pCNX.Trim_Sentence('TIPO') + ' =' + #39 + Trim(pTipo) + #39 + ' ');
//    lDoc.Active := True;
//    If lDoc.Active And (lDoc.RecordCount > 0) Then
//    Begin
//      lTable_C := TQuery.Create(Nil);
//      lTable_C.Active := False;
//      lTable_C.Connection := pCnx;
//      lTable_C.SQL.Add(' SELECT  * FROM ' + Retornar_Info_Tabla(IfThen(pTipo = 'SA', Id_Salida_Enc, Id_Entrada_Enc)).Name + ' ');
//      lTable_C.Active := True;
//
//      lTable_H := TQuery.Create(Nil);
//      lTable_H.Active := False;
//      lTable_H.Connection := pCnx;
//      lTable_H.SQL.Add(' SELECT  * FROM ' + Retornar_Info_Tabla(IfThen(pTipo = 'SA', Id_Salida_Enc_H, Id_Entrada_Enc_H)).Name + ' ');
//      lTable_H.Active := True;
//      lDoc.First;
//      While (Not lDoc.Eof) And (Not Result) Do
//      Begin
//        If (Not (lTable_C.Locate(IfThen(pTipo = 'SA', 'CODIGO_SALIDA', 'CODIGO_ENTRADA'), lDoc.FieldByName('NUMERO_DOCUMENTO').AsString, [loCaseInsensitive]))) And
//           (Not (lTable_H.Locate(IfThen(pTipo = 'SA', 'CODIGO_SALIDA', 'CODIGO_ENTRADA'), lDoc.FieldByName('NUMERO_DOCUMENTO').AsString, [loCaseInsensitive]))) Then
//        Begin
//          pNumero_Documento := lDoc.FieldByName('NUMERO_DOCUMENTO').AsString;
//          Result := True;
//        End
//        Else
//          lDoc.Next;
//      End;
//      lTable_H.Active := False;
//      lTable_H.DisposeOf;
//
//      lTable_C.Active := False;
//      lTable_C.DisposeOf;
//    End;
//    lDoc.Active := False;
//    lDoc.DisposeOf;
//  Except
//    On E : Exception Do
//      Utils_ManagerLog_Add('Tablename_Adm_Documento, Retornar_Disponible_Adm_Documento, ' + E.Message);
//  End;
//End;
//
//Function Tablename_Adm_Documento_Get_Prefix_Number_Fenalco(pCnx : TConexion; Const pTipo : String; Var pPrefix, pNumber, pIdNumeration : String) : Boolean;
//Var
//  lSQL : TQuery;
//Begin
//  Result := False;
//  pPrefix := '';
//  pNumber := '';
//  pIdNumeration := '';
//  Try
//    lSQL := TQuery.Create(Nil);
//    lSQL.Active := False;
//    lSQL.Connection := pCnx;
//    lSQL.SQL.Add(' SELECT  * FROM ' + Retornar_Info_Tabla(Id_Adm_Documento).Name + ' ' + ' (nolock) ');
//    lSQL.SQL.Add(' WHERE ' + pCNX.Trim_Sentence('CODIGO_ADM_DOCUMENTO') + ' =' + #39 + Trim(pTipo) + #39 + ' ');
//    lSQL.Active := True;
//    If lSQL.Active And (lSQL.RecordCount > 0) Then
//    Begin
//      pPrefix := Trim(lSQL.FieldByName('FENALCO_PREFIJO').AsString);
//      pNumber := Trim(lSQL.FieldByName('FENALCO_NUMERO').AsString);
//      pIdNumeration := Trim(lSQL.FieldByName('FENALCO_IDNUMERACION').AsString);
//      Result := True;
//    End;
//    lSQL.Active := False;
//    lSQL.Free;
//  Except
//    On E : Exception Do
//      Utils_ManagerLog_Add('Tablename_Adm_Documento_Get_Prefix_Number_Fenalco, ' + E.Message);
//  End;
//End;
//
//Function Tablename_Adm_Documento_Update_Prefix_Number_Fenalco(pCnx : TConexion; Const pTipo, pNumber : String) : Boolean;
//Var
//  lSQL : TQuery;
//Begin
//  Result := False;
//  Try
//    lSQL := TQuery.Create(Nil);
//    lSQL.Active := False;
//    lSQL.Connection := pCnx;
//    lSQL.SQL.Add(' SELECT  * FROM ' + Retornar_Info_Tabla(Id_Adm_Documento).Name + ' ' + ' (nolock) ');
//    lSQL.SQL.Add(' WHERE ' + pCNX.Trim_Sentence('CODIGO_ADM_DOCUMENTO') + ' =' + #39 + Trim(pTipo) + #39 + ' ');
//    lSQL.Active := True;
//    If lSQL.Active And (lSQL.RecordCount > 0) Then
//    Begin
//      lSQL.Edit;
//      lSQL.FieldByName('FENALCO_NUMERO').AsString := pNumber;
//      lSQL.Post;
//      Result := True;
//    End;
//    lSQL.Active := False;
//    lSQL.Free;
//  Except
//    On E : Exception Do
//      Utils_ManagerLog_Add('Tablename_Adm_Documento_Update_Prefix_Number_Fenalco, ' + E.Message);
//  End;
//End;

end.
