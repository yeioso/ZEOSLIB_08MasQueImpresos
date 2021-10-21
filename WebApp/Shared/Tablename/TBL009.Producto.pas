unit TBL009.Producto;

interface
Uses
  UtConexion;

Function TBL009_Producto_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtLog,
  UtError,
  SysUtils,
  TBL000.Info_Tabla;

Function TBL009_Producto_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  if Not pCnx.TableExists(gInfo_Tablas[Id_TBL_Producto].Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + gInfo_Tablas[Id_TBL_Producto].Name + ' '                             );
      pCnx.TMP.SQL.Add('   (  '                                                                                  );
      pCnx.TMP.SQL.Add('      CODIGO_PRODUCTO '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_AREA '          + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_UNIDAD_MEDIDA ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      NOMBRE '               + pCNX.Return_Type(TYPE_VARCHAR) + ' (255) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DESCRIPCION '          + pCNX.Return_Type(TYPE_TEXT   ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      VALOR_UNITARIO '       + pCNX.Return_Type(TYPE_FLOAT  ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      STOCK_MINIMO '         + pCNX.Return_Type(TYPE_FLOAT  ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      STOCK_MAXIMO '         + pCNX.Return_Type(TYPE_FLOAT  ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_ACTIVO '            + pCNX.Return_Type(TYPE_VARCHAR) + ' (001) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TAG_INFO  '            + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_PRODUCTO), '                                              );
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(gInfo_Tablas[Id_TBL_Producto].Fk[1], 'CODIGO_AREA', gInfo_Tablas[Id_TBL_Area].Name, 'CODIGO_AREA') + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(gInfo_Tablas[Id_TBL_Producto].Fk[2], 'CODIGO_UNIDAD_MEDIDA', gInfo_Tablas[Id_TBL_Unidad_Medida].Name, 'CODIGO_UNIDAD_MEDIDA') + ' ');
      pCnx.TMP.SQL.Add('   ) ');
      pCnx.TMP.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        UtLog_Execute(MessageError(IE_ERROR_CREATE) + ' Tabla ' + gInfo_Tablas[Id_TBL_Producto].Name + ', TBL009_Producto_Create, ' + E.Message);
      End;
    End;
  End;
End;

end.
