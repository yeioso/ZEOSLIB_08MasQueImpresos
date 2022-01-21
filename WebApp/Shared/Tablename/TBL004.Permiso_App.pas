unit TBL004.Permiso_App;

interface
Uses
  UtConexion;

Function TBL004_Permiso_App_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtError,
  SysUtils,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function TBL004_Permiso_App_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  if Not pCnx.TableExists(Info_TablaGet(Id_TBL_Permiso_App).Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add(' CREATE TABLE ' + Info_TablaGet(Id_TBL_Permiso_App).Name + ' '                     );
      pCnx.TMP.SQL.Add(' ( '                                                                               );
      pCnx.TMP.SQL.Add('  CODIGO_PERFIL      ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (004) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('  CONSECUTIVO        ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (004) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('  NOMBRE             ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (050) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('  HABILITA_OPCION    ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (001) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('  TAG_INFO           ' + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('  PRIMARY KEY (CONSECUTIVO), '                                                     );
      pCnx.TMP.SQL.Add('  '+ pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Permiso_App).Fk[1],'CODIGO_PERFIL', Info_TablaGet(Id_TBL_Perfil).Name, 'CODIGO_PERFIL') + '  ');
      pCnx.TMP.SQL.Add(' ) '                                                                               );
      pCnx.TMP.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        Utils_ManagerLog_Add('DATABASE', 'TBL004.Permiso_App', 'TBL004_Permiso_App_Create', E.Message);
      End;
    End;
  End;
End;

end.
