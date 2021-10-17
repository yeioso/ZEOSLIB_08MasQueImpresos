unit TBL005.Usuario;

interface
Uses
  UtConexion;

Function TBL005_Usuario_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtLog,
  UtError,
  SysUtils,
  TBL000.Info_Tabla;

Function TBL005_Usuario_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;

  if Not pCnx.TableExists(gInfo_Tablas[Id_TBL_Usuario].Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + gInfo_Tablas[Id_TBL_Usuario].Name + '  '                        );
      pCnx.TMP.SQL.Add('   (  '                                                                             );
      pCnx.TMP.SQL.Add('      CODIGO_USUARIO ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (020)  ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NOMBRE '         + pCNX.Return_Type(TYPE_VARCHAR) + ' (255)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      CONTRASENA '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (100)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DIRECCION '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (100)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TELEFONO_1 '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (020)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TELEFONO_2 '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (020)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      CODIGO_PERFIL '  + pCNX.Return_Type(TYPE_VARCHAR) + ' (004)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_ACTIVO '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (001)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      EMAIL '          + pCNX.Return_Type(TYPE_VARCHAR) + ' (255)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      GRAFICO '        + pCNX.Return_Type(TYPE_IMAGE  ) + ' '        + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TAG_INFO '       + pCNX.Return_Type(TYPE_INT    ) + ' '        + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_USUARIO), '                                               );
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(gInfo_Tablas[Id_TBL_Usuario].Fk[1], 'CODIGO_PERFIL', gInfo_Tablas[Id_TBL_Perfil].Name, 'CODIGO_PERFIL') + '  ');
      pCnx.TMP.SQL.Add('   )   ');
      pCnx.TMP.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        UtLog_Execute(MessageError(IE_ERROR_CREATE) + ' Tabla ' + gInfo_Tablas[Id_TBL_Usuario].Name + ', TBL005_Usuario_Create, ' + E.Message);
      End;
    End;
  End;
End;

end.
