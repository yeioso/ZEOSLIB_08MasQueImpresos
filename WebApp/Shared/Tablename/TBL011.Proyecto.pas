unit TBL011.Proyecto;

interface
Uses
  UtConexion;

Function TBL011_Proyecto_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtError,
  SysUtils,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function TBL011_Proyecto_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  if Not pCnx.TableExists(Info_TablaGet(Id_TBL_Proyecto).Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + Info_TablaGet(Id_TBL_Proyecto).Name + ' '                       );
      pCnx.TMP.SQL.Add('   (  '                                                                             );
      pCnx.TMP.SQL.Add('      CODIGO_PROYECTO ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NOMBRE '          + pCNX.Return_Type(TYPE_VARCHAR) + ' (255) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DESCRIPCION '     + pCNX.Return_Type(TYPE_TEXT   ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      FECHA_INICIAL '   + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      FECHA_FINAL '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_ACTIVO '       + pCNX.Return_Type(TYPE_VARCHAR) + ' (001) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TAG_INFO  '       + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_PROYECTO) '                                               );
      pCnx.TMP.SQL.Add('   ) ');
      pCnx.TMP.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        Utils_ManagerLog_Add('DATABASE', 'TBL011.Proyecto', 'TBL011_Proyecto_Create', E.Message);
      End;
    End;
  End;
End;

end.
