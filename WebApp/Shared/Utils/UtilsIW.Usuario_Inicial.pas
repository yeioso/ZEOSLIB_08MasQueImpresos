unit UtilsIW.Usuario_Inicial;

interface
Uses
  UtConexion;

Function UtilsIW_Usuario_Inicial(pCnx : TConexion; Const pCodigo_Usuario, pNombre, pPassword, pEmail : String) : Boolean;
Function UtilsIW_Usuario_Existe(pCnx : TConexion) : Boolean;

implementation

Uses
  UtLog,
  UtFuncion,
  Criptografia,
  System.SysUtils,
  TBL000.Info_Tabla,
  UtilsIW.Permisos_App;

Type
  TUsuario_Inicial = Class
    Private
      FCNX : TConexion;
      FPERMISO : TPermisos_App;
      Function Exists : Boolean;
      Function Execute(Const pCodigo_Usuario, pNombre, pPassword, pEmail : String) : Boolean;
    Public
      Constructor Create;
      Destructor Destroy;
  End;

Constructor TUsuario_Inicial.Create;
Begin
  FPERMISO := TPermisos_App.Create;
End;

Destructor TUsuario_Inicial.Destroy;
Begin
  If Assigned(FPERMISO) Then
    FreeAndNil(FPERMISO);
End;

Function TUsuario_Inicial.Execute(Const pCodigo_Usuario, pNombre, pPassword, pEmail : String) : Boolean;
Var
  lHash : String;
  lPassword : String;
Begin
  FCNX.BeginTrans;
  Try
    FCNX.AUX.Active := False;
    FCNX.AUX.SQL.Clear;
    FCNX.AUX.SQL.Add(' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Permiso_App].Name + FCNX.No_Lock);
    FCNX.AUX.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('NOMBRE') + ' = ' + QuotedStr(Trim(FPERMISO.GetItem(CONST_ACCION_ERP_ADMINISTRADOR).Id_Str)));
    FCNX.AUX.Active := True;
    If FCNX.AUX.Active And (FCNX.AUX.RecordCount <= 0) Then
    Begin
      FCNX.TMP.Active := False;
      FCNX.TMP.SQL.Clear;
      FCNX.TMP.SQL.Add(' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Perfil].Name + FCNX.No_Lock);
      FCNX.TMP.Active := True;
      FCNX.TMP.Append;
      FCNX.TMP.FieldByName('CODIGO_PERFIL').AsString := Justificar('0', '0', FCNX.TMP.FieldByName('CODIGO_PERFIL').Size);
      FCNX.TMP.FieldByName('NOMBRE'       ).AsString := 'USUARIO ADMINISTRADOR';
      FCNX.TMP.FieldByName('ID_ACTIVO'    ).AsString := 'S';
      FCNX.TMP.Post;

      FCNX.AUX.Append;
      FCNX.AUX.FieldByName('CODIGO_PERFIL'  ).AsString := FCNX.TMP.FieldByName('CODIGO_PERFIL').AsString;
      FCNX.AUX.FieldByName('CONSECUTIVO'    ).AsString := Justificar('0', '0', FCNX.AUX.FieldByName('CONSECUTIVO').Size);
      FCNX.AUX.FieldByName('NOMBRE'         ).AsString := Trim(FPERMISO.GetItem(CONST_ACCION_ERP_ADMINISTRADOR).Id_Str);
      FCNX.AUX.FieldByName('HABILITA_OPCION').AsString := 'S';
      FCNX.AUX.Post;
    End;

    FCNX.SQL.Active := False;
    FCNX.SQL.SQL.Clear;
    FCNX.SQL.SQL.Add(' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Usuario].Name + FCNX.No_Lock);
    FCNX.SQL.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(pCodigo_Usuario)));
    FCNX.SQL.Active := True;
    If FCNX.SQL.Active Then
    Begin
      If FCNX.SQL.RecordCount <= 0 Then
      Begin
        FCNX.SQL.Append;
        FCNX.SQL.FieldByName('CODIGO_USUARIO').AsString := Justificar(pCodigo_Usuario, ' ', FCNX.SQL.FieldByName('CODIGO_USUARIO').Size);
        FCNX.SQL.FieldByName('NOMBRE'        ).AsString := AnsiUpperCase(Trim(pNombre));
      End
      Else
      Begin
        FCNX.SQL.Edit;
      End;
      FCNX.SQL.FieldByName('ID_ACTIVO').AsString := AnsiUpperCase(Trim('S'));
      FCNX.SQL.FieldByName('CODIGO_PERFIL').AsString := FCNX.AUX.FieldByName('CODIGO_PERFIL').AsString;
      FCNX.SQL.FieldByName('EMAIL').AsString := LowerCase(Trim(pEmail));
      lPassword := RetornarCodificado(Const_KEY, pPassword, lHash);
      FCNX.SQL.FieldByName('CONTRASENA').AsString := lPassword;
      FCNX.SQL.Post;
    End;
    FCNX.SQL.Active := False;
    FCNX.SQL.SQL.Clear;
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.AUX.Active := False;
    FCNX.AUX.SQL.Clear;
    Result := True;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TUsuario_Inicial.Execute, ' + E.Message);
    End;
  End;
  If Result Then
    FCNX.CommitTrans
  Else
    FCNX.RollbackTrans;
End;

Function TUsuario_Inicial.Exists : Boolean;
Var
  lHash : String;
  lPassword : String;
Begin
  Try
    FCNX.AUX.Active := False;
    FCNX.AUX.SQL.Clear;
    FCNX.AUX.SQL.Add(' SELECT ');
    FCNX.AUX.SQL.Add('     USUARIO.CODIGO_USUARIO ');
    FCNX.AUX.SQL.Add(' FROM ' + gInfo_Tablas[Id_TBL_Permiso_App].Name + ' PERMISOS ' + FCNX.No_Lock);
    FCNX.AUX.SQL.Add(' INNER JOIN ' + gInfo_Tablas[Id_TBL_Usuario].Name + ' USUARIO ' + FCNX.No_Lock);
    FCNX.AUX.SQL.Add(' ON USUARIO.CODIGO_PERFIL = PERMISOS.CODIGO_PERFIL ');
    FCNX.AUX.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('PERMISOS.NOMBRE') + ' = ' + QuotedStr(Trim(FPERMISO.GetItem(CONST_ACCION_ERP_ADMINISTRADOR).Id_Str)));
    FCNX.AUX.Active := True;
    Result := FCNX.AUX.Active And (FCNX.AUX.RecordCount > 0);
    FCNX.AUX.Active := False;
    FCNX.AUX.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TUsuario_Inicial.Exists, ' + E.Message);
    End;
  End;
End;

Function UtilsIW_Usuario_Inicial(pCnx : TConexion; Const pCodigo_Usuario, pNombre, pPassword, pEmail : String) : Boolean;
Var
  lUI : TUsuario_Inicial;
Begin
  lUI := TUsuario_Inicial.Create;
  lUI.FCNX := pCnx;
  Result := lUI.Execute(pCodigo_Usuario, pNombre, pPassword, pEmail);
  FreeAndNil(lUI);
End;

Function UtilsIW_Usuario_Existe(pCnx : TConexion) : Boolean;
Var
  lUI : TUsuario_Inicial;
Begin
  lUI := TUsuario_Inicial.Create;
  lUI.FCNX := pCnx;
  Result := lUI.Exists;
  FreeAndNil(lUI);
End;

end.

