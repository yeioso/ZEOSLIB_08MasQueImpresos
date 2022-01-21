unit TBL003.Perfil;

interface
Uses
  UtConexion;

Function TBL003_Perfil_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtError,
  SysUtils,
  UtFuncion,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function TBL003_Perfil_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  if Not pCnx.TableExists(Info_TablaGet(Id_TBL_Perfil).Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add(' CREATE TABLE ' + Info_TablaGet(Id_TBL_Perfil).Name + ' '                        );
      pCnx.TMP.SQL.Add(' (  '                                                                            );
      pCnx.TMP.SQL.Add('    CODIGO_PERFIL ' + pCNX.Return_Type(TYPE_VARCHAR ) + ' (004) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('    NOMBRE        ' + pCNX.Return_Type(TYPE_VARCHAR ) + ' (255) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('    ID_ACTIVO     ' + pCNX.Return_Type(TYPE_VARCHAR ) + ' (001) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('    TAG_INFO      ' + pCNX.Return_Type(TYPE_INT     ) + '       ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('    PRIMARY KEY (CODIGO_PERFIL) '                                 + ' '          );
      pCnx.TMP.SQL.Add(' )  ');
      pCnx.TMP.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        Utils_ManagerLog_Add('DATABASE', 'TBL003.Perfil', 'TBL003_Perfil_Create', E.Message);
      End;
    End;
  End;
End;

end.
