unit TBL003.Perfil;

interface
Uses
  UtConexion;

Function TBL003_Perfil_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtLog,
  UtError,
  SysUtils,
  UtFuncion,
  TBL000.Info_Tabla;

Function TBL003_Perfil_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  if Not pCnx.TableExists(gInfo_Tablas[Id_TBL_Perfil].Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add(' CREATE TABLE ' + gInfo_Tablas[Id_TBL_Perfil].Name + ' '                         );
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
        UtLog_Execute(MessageError(IE_ERROR_CREATE) + ' Tabla ' + gInfo_Tablas[Id_TBL_Perfil].Name + ', TBL003_Perfil_Create, ' + E.Message);
      End;
    End;
  End;
End;

end.
