unit TBL005.Usuario;

interface
Uses
  UtConexion;

Function TBL005_Usuario_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtError,
  SysUtils,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function TBL005_Usuario_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;

  if Not pCnx.TableExists(Info_TablaGet(Id_TBL_Usuario).Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + Info_TablaGet(Id_TBL_Usuario).Name + '  '                            );
      pCnx.TMP.SQL.Add('   (  '                                                                                  );
      pCnx.TMP.SQL.Add('      CODIGO_USUARIO '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (020)  ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NOMBRE '              + pCNX.Return_Type(TYPE_VARCHAR) + ' (255)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      CONTRASENA '          + pCNX.Return_Type(TYPE_VARCHAR) + ' (100)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DIRECCION '           + pCNX.Return_Type(TYPE_VARCHAR) + ' (100)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TELEFONO_1 '          + pCNX.Return_Type(TYPE_VARCHAR) + ' (020)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TELEFONO_2 '          + pCNX.Return_Type(TYPE_VARCHAR) + ' (020)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      CODIGO_PERFIL '       + pCNX.Return_Type(TYPE_VARCHAR) + ' (004)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_NOTIFICA_PRODUCTO '+ pCNX.Return_Type(TYPE_VARCHAR) + ' (001)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_ACTIVO '           + pCNX.Return_Type(TYPE_VARCHAR) + ' (001)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      EMAIL '               + pCNX.Return_Type(TYPE_VARCHAR) + ' (255)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      GRAFICO '             + pCNX.Return_Type(TYPE_IMAGE  ) + ' '        + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TAG_INFO '            + pCNX.Return_Type(TYPE_INT    ) + ' '        + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_USUARIO), '                                                    );
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Usuario).Fk[1], 'CODIGO_PERFIL', Info_TablaGet(Id_TBL_Perfil).Name, 'CODIGO_PERFIL') + '  ');
      pCnx.TMP.SQL.Add('   )   ');
      pCnx.TMP.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        Utils_ManagerLog_Add('DATABASE', 'TBL005.Usuario', 'TBL005_Usuario_Create', E.Message);
      End;
    End;
  End;
End;

end.
