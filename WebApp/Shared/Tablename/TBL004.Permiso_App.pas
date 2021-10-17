unit TBL004.Permiso_App;

interface
Uses
  UtConexion;

Function TBL004_Permiso_App_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtLog,
  UtError,
  SysUtils,
  TBL000.Info_Tabla;

Function TBL004_Permiso_App_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  if Not pCnx.TableExists(gInfo_Tablas[Id_TBL_Permiso_App].Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add(' CREATE TABLE ' + gInfo_Tablas[Id_TBL_Permiso_App].Name + ' '                      );
      pCnx.TMP.SQL.Add(' ( '                                                                               );
      pCnx.TMP.SQL.Add('  CODIGO_PERFIL      ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (004) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('  CONSECUTIVO        ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (004) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('  NOMBRE             ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (050) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('  HABILITA_OPCION    ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (001) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('  TAG_INFO           ' + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('  PRIMARY KEY (CONSECUTIVO), '                                                     );
      pCnx.TMP.SQL.Add('  '+ pCNX.FOREINGKEY(gInfo_Tablas[Id_TBL_Permiso_App].Fk[1],'CODIGO_PERFIL', gInfo_Tablas[Id_TBL_Perfil].Name, 'CODIGO_PERFIL') + '  ');
      pCnx.TMP.SQL.Add(' ) '                                                                               );
      pCnx.TMP.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        UtLog_Execute(MessageError(IE_ERROR_CREATE) + ' Tabla ' + gInfo_Tablas[Id_TBL_Permiso_App].Name + ', TBL004_Permiso_App_Create, ' + E.Message);
      End;
    End;
  End;
End;

end.
