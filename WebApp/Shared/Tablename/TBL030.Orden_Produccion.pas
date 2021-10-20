unit TBL030.Orden_Produccion;

interface
Uses
  UtConexion;

Function TBL030_Orden_Produccion_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtLog,
  UtError,
  SysUtils,
  TBL000.Info_Tabla;

Function TBL030_Orden_Produccion_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  If Not pCnx.TableExists(gInfo_Tablas[Id_TBL_Orden_Produccion].Name) Then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + gInfo_Tablas[Id_TBL_Orden_Produccion].Name + ' '                   );
      pCnx.TMP.SQL.Add('   (  '                                                                                );
      pCnx.TMP.SQL.Add('      CODIGO_DOCUMENTO '   + pCNX.Return_Type(TYPE_VARCHAR) + ' (030) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NUMERO  '            + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_TERCERO '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_PROYECTO '    + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_USUARIO '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      FECHA_REGISTRO '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      HORA_REGISTRO '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NOMBRE '             + pCNX.Return_Type(TYPE_VARCHAR) + ' (255) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DESCRIPCION '        + pCNX.Return_Type(TYPE_TEXT   ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_ACTIVO '          + pCNX.Return_Type(TYPE_VARCHAR) + ' (001) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TAG_INFO  '          + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_DOCUMENTO, NUMERO), '                                        );
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(gInfo_Tablas[Id_TBL_Orden_Produccion].Fk[1],'CODIGO_DOCUMENTO', gInfo_Tablas[Id_TBL_Administrador_Documento].Name, 'CODIGO_DOCUMENTO') + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(gInfo_Tablas[Id_TBL_Orden_Produccion].Fk[2],'CODIGO_TERCERO'  , gInfo_Tablas[Id_TBL_Tercero                ].Name, 'CODIGO_TERCERO'  ) + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(gInfo_Tablas[Id_TBL_Orden_Produccion].Fk[3],'CODIGO_PROYECTO' , gInfo_Tablas[Id_TBL_Proyecto               ].Name, 'CODIGO_PROYECTO' ) + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(gInfo_Tablas[Id_TBL_Orden_Produccion].Fk[4],'CODIGO_USUARIO'  , gInfo_Tablas[Id_TBL_Usuario                ].Name, 'CODIGO_USUARIO'  ) + '  ');

      pCnx.TMP.SQL.Add('   ) ');
      pCnx.TMP.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        UtLog_Execute(MessageError(IE_ERROR_CREATE) + ' Tabla ' + gInfo_Tablas[Id_TBL_Orden_Produccion].Name + ', TBL030_Orden_Produccion_Create, ' + E.Message);
      End;
    End;
  End;
End;

end.
