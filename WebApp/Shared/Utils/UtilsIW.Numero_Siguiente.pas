unit UtilsIW.Numero_Siguiente;

interface

Uses
  UtConexion,
  System.Classes;

Function UtilsIW_Numero_Siguiente_Get(pCNX : TConexion; Const pCodigo_Documento : String) : Integer;
Function UtilsIW_Numero_Siguiente_Put(pCNX : TConexion; Const pCodigo_Documento : String; Const pNumero : Integer) : Integer;

implementation
Uses
  System.SysUtils,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Type
  TNumero_Siguiente = Class
    Private
      FCNX : TConexion;
    Public
      Function Siguiente_Get(Const pCodigo_Documento : String) : Integer;
      Function Siguiente_Put(Const pCodigo_Documento : String; Const pNumero : Integer) : Integer;
  End;

Function TNumero_Siguiente.Siguiente_Get(Const pCodigo_Documento : String) : Integer;
Begin
  Result := -1;
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Administrador_Documento).Name + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(pCodigo_Documento)));
    FCNX.TMP.Active := True;
    If FCNX.TMP.Active And (FCNX.TMP.RecordCount > 0) Then
      Result := FCNX.TMP.FieldByName('DOCUMENTO_ACTUAL').AsInteger + 1;
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'UtilsIW.Numero_Siguiente', 'TNumero_Siguiente.Siguiente_Get', E.Message);
    End;
  End;
End;

Function TNumero_Siguiente.Siguiente_Put(Const pCodigo_Documento : String; Const pNumero : Integer) : Integer;
Begin
  Result := -1;
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Administrador_Documento).Name + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(pCodigo_Documento)));
    FCNX.TMP.Active := True;
    If FCNX.TMP.Active And (FCNX.TMP.RecordCount > 0) Then
    Begin
      FCNX.TMP.Edit;
      FCNX.TMP.FieldByName('DOCUMENTO_ACTUAL').AsInteger := pNumero;
      FCNX.TMP.Post;
      Result := 0;
    End;
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'UtilsIW.Numero_Siguiente', 'TNumero_Siguiente.Siguiente_Put', E.Message);
    End;
  End;
End;

Function UtilsIW_Numero_Siguiente_Get(pCNX : TConexion; Const pCodigo_Documento : String) : Integer;
Var
  lNS : TNumero_Siguiente;
Begin
  Result := -1;
  lNS := TNumero_Siguiente.Create;
  lNS.FCNX := pCNX;
  Result := lNS.Siguiente_Get(pCodigo_Documento);
  FreeAndNil(lNS);
End;

Function UtilsIW_Numero_Siguiente_Put(pCNX : TConexion; Const pCodigo_Documento : String; Const pNumero : Integer) : Integer;
Var
  lNS : TNumero_Siguiente;
Begin
  Result := -1;
  lNS := TNumero_Siguiente.Create;
  lNS.FCNX := pCNX;
  Result := lNS.Siguiente_Put(pCodigo_Documento, pNumero);
  FreeAndNil(lNS);
End;

end.
