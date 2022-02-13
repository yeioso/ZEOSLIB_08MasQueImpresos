unit TBL010.Tercero;

interface
Uses
  UtConexion;

Function TBL010_Tercero_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtError,
  SysUtils,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function TBL010_Tercero_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;

  if Not pCnx.TableExists(Info_TablaGet(Id_TBL_Tercero).Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + Info_TablaGet(Id_TBL_Tercero).Name + '  '                       );
      pCnx.TMP.SQL.Add('   (  '                                                                             );
      pCnx.TMP.SQL.Add('      CODIGO_TERCERO ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (020)  ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      D_VERIFICACION ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (001)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      NOMBRE '         + pCNX.Return_Type(TYPE_VARCHAR) + ' (255)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      CONTACTO '       + pCNX.Return_Type(TYPE_VARCHAR) + ' (255)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DIRECCION '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (255)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TELEFONO_1 '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (020)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TELEFONO_2 '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (020)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      EMAIL '          + pCNX.Return_Type(TYPE_VARCHAR) + ' (255)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_CLIENTE '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (001)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_PROVEEDOR '   + pCNX.Return_Type(TYPE_VARCHAR) + ' (001)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_EMPLEADO '    + pCNX.Return_Type(TYPE_VARCHAR) + ' (001)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      CONTRASENA '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (100)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_ACTIVO '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (001)  ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TAG_INFO '       + pCNX.Return_Type(TYPE_INT    ) + ' '        + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_TERCERO) '                                                );
      pCnx.TMP.SQL.Add('   )   '                                                                            );
      pCnx.TMP.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        Utils_ManagerLog_Add('DATABASE', 'TBL010.Tercero', 'TBL010_Tercero_Create', E.Message);
      End;
    End;
  End;
End;

end.
