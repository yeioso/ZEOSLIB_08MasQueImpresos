unit TBL030.Orden_Produccion;

interface
Uses
  UtConexion;

Function TBL030_Orden_Produccion_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtError,
  SysUtils,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function TBL030_Orden_Produccion_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  If Not pCnx.TableExists(Info_TablaGet(Id_TBL_Orden_Produccion).Name) Then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + Info_TablaGet(Id_TBL_Orden_Produccion).Name + ' '                    );
      pCnx.TMP.SQL.Add('   (  '                                                                                  );
      pCnx.TMP.SQL.Add('      CODIGO_DOCUMENTO '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (030) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NUMERO  '              + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_TERCERO '       + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_PROYECTO '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_USUARIO '       + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      FECHA_REGISTRO '       + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      HORA_REGISTRO '        + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NOMBRE '               + pCNX.Return_Type(TYPE_VARCHAR) + ' (255) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      FECHA_INICIAL '        + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      FECHA_FINAL '          + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DOCUMENTO_REFERENCIA ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DESCRIPCION '          + pCNX.Return_Type(TYPE_TEXT   ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      CANTIDAD  '            + pCNX.Return_Type(TYPE_FLOAT  ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_ACTIVO '            + pCNX.Return_Type(TYPE_VARCHAR) + ' (001) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TAG_INFO  '            + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_DOCUMENTO, NUMERO), '                                        );
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Orden_Produccion).Fk[1],'CODIGO_DOCUMENTO', Info_TablaGet(Id_TBL_Administrador_Documento).Name, 'CODIGO_DOCUMENTO') + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Orden_Produccion).Fk[2],'CODIGO_TERCERO'  , Info_TablaGet(Id_TBL_Tercero                ).Name, 'CODIGO_TERCERO'  ) + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Orden_Produccion).Fk[3],'CODIGO_PROYECTO' , Info_TablaGet(Id_TBL_Proyecto               ).Name, 'CODIGO_PROYECTO' ) + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Orden_Produccion).Fk[4],'CODIGO_USUARIO'  , Info_TablaGet(Id_TBL_Usuario                ).Name, 'CODIGO_USUARIO'  ) + '  ');
      pCnx.TMP.SQL.Add('   ) ');
      pCnx.TMP.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        Utils_ManagerLog_Add('DATABASE', 'TBL030.Orden_Produccion', 'TBL030_Orden_Produccion_Create',  E.Message);
      End;
    End;
  End;
End;

end.

