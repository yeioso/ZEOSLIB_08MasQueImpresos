unit TBL999.Usuario_Reporte;

interface
Uses
  UtConexion;

Function TBL999_Usuario_Reporte_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtError,
  SysUtils,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function TBL999_Usuario_Reporte_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  if Not pCnx.TableExists(Info_TablaGet(Id_TBL_Usuario_Reporte).Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + Info_TablaGet(Id_TBL_Usuario_Reporte).Name + '  '              );
      pCnx.TMP.SQL.Add('   (  '                                                                            );
      pCnx.TMP.SQL.Add('      CODIGO_USUARIO '  + pCnx.Return_Type(TYPE_VARCHAR) + '(020)'  + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      LINEA '           + pCnx.Return_Type(TYPE_VARCHAR) + '(005)'  + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CONTENIDO '       + pCnx.Return_Type(TYPE_VARCHAR) + '(255)'  + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_USUARIO, LINEA), '                                       );
      pCnx.TMP.SQL.Add(' ' + pCnx.FOREINGKEY(Info_TablaGet(Id_TBL_Usuario_Reporte).Fk[1], 'CODIGO_USUARIO', Info_TablaGet(Id_TBL_Usuario).Name, 'CODIGO_USUARIO') + ' ');
      pCnx.TMP.SQL.Add('   ) '                                                                             );
      pCnx.TMP.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        Utils_ManagerLog_Add('DATABASE', 'TBL999.Usuario_Reporte', 'TBL999_Usuario_Reporte_Create', E.Message);
      End;
    End;
  End;
End;

end.
