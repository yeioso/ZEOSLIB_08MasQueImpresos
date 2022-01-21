unit TBL001.Create_Tabla;

interface
Uses
  UtConexion;

Function TBL001_Create_Tabla_CheckTables(pCnx : TConexion) : Boolean;

implementation
Uses
  UtilsIW.ManagerLog,
  SysUtils,
  TBL002.Update_Field,
  TBL003.Perfil,
  TBL004.Permiso_App,
  TBL005.Usuario,
  TBL006.Administrador_Documento,
  TBL007.Area,
  TBL008.Unidad_Medida,
  TBL009.Producto,
  TBL010.Tercero,
  TBL011.Proyecto,
  TBL030.Orden_Produccion,
  TBL031.Explosion_Material,
  TBL032.Movto_Inventario,
  TBL033.Notificacion_Producto,
  TBL999.Usuario_Reporte;

Function TBL001_Create_Tabla_Execute(pCnx : TConexion) : Boolean;
Begin
  Try
    Result := TBL003_Perfil_Create(pCnx);
    If Result Then
      Result := TBL004_Permiso_App_Create(pCnx);
    If Result Then
      Result := TBL005_Usuario_Create(pCnx);
    If Result Then
      Result := TBL006_Administrador_Documento_Execute(pCnx);
    If Result Then
      Result := TBL007_Area_Create(pCnx);
   If Result Then
      Result := TBL008_Unidad_Medida_Create(pCnx);
   If Result Then
      Result := TBL009_Producto_Create(pCnx);
    If Result Then
      Result := TBL010_Tercero_Create(pCnx);
     If Result Then
      Result := TBL011_Proyecto_Create(pCnx);
    If Result Then
      Result := TBL030_Orden_Produccion_Create(pCnx);
    If Result Then
      Result := TBL031_Explosion_Material_Create(pCnx);
    If Result Then
      Result := TBL032_Movto_Inventario_Create(pCnx);
    If Result Then
      Result := TBL033_Notificacion_Producto_Create(pCnx);
    If Result Then
      Result := TBL999_Usuario_Reporte_Create(pCnx);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add('DATABASE', 'TBL001.Create_Tabla', 'TBL001_Create_Tabla_Execute', E.Message);
    End;
  End;
End;

Function TBL001_Create_Tabla_CheckTables(pCnx : TConexion) : Boolean;
Begin
  Result := TBL001_Create_Tabla_Execute(pCnx);
  If Result Then
    TBL002_Update_Field_Execute(pCnx);
End;

end.
