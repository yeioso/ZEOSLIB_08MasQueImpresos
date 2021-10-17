unit TBL000.Info_Tabla;

interface
Uses
  Classes,
  Generics.Collections;

Const
  Id_TBL_Perfil                  = 000;
  Id_TBL_Permiso_App             = 001;
  Id_TBL_Usuario                 = 002;
  Id_TBL_Administrador_Documento = 003;
  Id_TBL_Area                    = 004;
  Id_TBL_Proceso                 = 005;
  Id_TBL_Tercero                 = 006;
  Id_TBL_Producto                = 007;
  Id_TBL_Movto_Inventario        = 008;
  Id_TBL_Usuario_Reporte         = 009;

Type
 TA_PK = Array Of String;
 TInfo_Tabla = Class
   Id        : Integer;
   Name      : String ;
   Caption   : String ;
   Fk        : Array[1..15] Of String;
   Pk        : TA_PK;
 End;
 TInfo_Tablas = TList<TInfo_Tabla>;

Var
  gInfo_Tablas : TInfo_Tablas;

implementation

Uses
  SysUtils,
  UtFuncion;

Procedure Cargar_Tablas(pId : Integer; pName, pCaption : String; pPK : TA_PK);
Var
  lI : Integer;
  lK : TInfo_Tabla;
Begin
  lK := TInfo_Tabla.Create;
  gInfo_Tablas.Add(lK);
  lK.Id        := pId          ;
  lK.Name      := 'TBL' + Justificar(IntToStr(pId), '0', 3) + '_' + pName;
  lK.Caption   := pCaption     ;
  lK.Pk        := pPK          ;
  For lI := Low(lK.Fk) To High(lK.Fk) Do
    lK.Fk[lI] := 'FK' + IntToStr(pId) + '_' + IntToStr(lI) + IntToStr(Random(100));
End;

Procedure Preparar_Tablas;
Begin
  Cargar_Tablas(Id_TBL_Perfil                 , 'PERFIL'                 , 'Perfiles'                  , ['CODIGO_PERFIL']);
  Cargar_Tablas(Id_TBL_Permiso_App            , 'PERMISO_APP'            , 'Permisos de Aplicación'    , ['CODIGO_PERFIL', 'CONSECUTIVO']);
  Cargar_Tablas(Id_TBL_Usuario                , 'USUARIO'                , 'Usuario'                   , ['CODIGO_USUARIO']);
  Cargar_Tablas(Id_TBL_Administrador_Documento, 'ADM_DOCUMENTO'          , 'Administrador de Documento', ['PREFIJO']);
  Cargar_Tablas(Id_TBL_Area                   , 'AREA'                   , 'Area'                      , ['CODIGO_AREA']);
  Cargar_Tablas(Id_TBL_Proceso                , 'PROCESO'                , 'Proceso'                   , ['CODIGO_PROCESO']);
  Cargar_Tablas(Id_TBL_Tercero                , 'TERCERO'                , 'Tercero'                   , ['CODIGO_TERCERO']);
  Cargar_Tablas(Id_TBL_Producto               , 'PRODUCTO'               , 'Producto'                  , ['CODIGO_PRODUCTO']);
  Cargar_Tablas(Id_TBL_Movto_Inventario       , 'MOVTO_INV'              , 'Movimiento'                , ['PREFIJO', 'NUMERO']);
  Cargar_Tablas(Id_TBL_Usuario_Reporte        , 'USUARIO_REP'            , 'Reporte de Usuarios'       , ['CODIGO_USUARIO', 'LINEA']);
End;


Initialization
  gInfo_Tablas := TInfo_Tablas.Create;
  Preparar_Tablas;

end.
