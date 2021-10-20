unit UtilsIW.Permisos_App;

interface
Uses
  System.Classes,
  Generics.Collections;

Const
  CONST_ACCION_ERP_ADMINISTRADOR              = 0001;
  CONST_ACCION_DELIMITAR_CON_COMA             = 0003;
  CONST_ACCION_EDITAR_ENTRADAS                = 0004;
  CONST_ACCION_EDITAR_SALIDA                  = 0005;
  CONST_ACCION_EDITAR_DEVOLUCIONES            = 0006;
  CONST_OPCION_CAMBIO_DE_PASSWORD             = 0007;
  CONST_OPCION_VER_SESIONES_ACTIVAS           = 0008;
  CONST_OPCION_PERFIL                         = 0009;
  CONST_OPCION_USUARIO                        = 0010;
  CONST_OPCION_ADMINISTRACION_DE_DOCUMENTOS   = 0011;
  CONST_OPCION_AREA                           = 0012;
  CONST_OPCION_PROCESO                        = 0013;
  CONST_OPCION_PROYECTO                       = 0014;
  CONST_OPCION_TERCERO                        = 0015;
  CONST_OPCION_PRODUCTO                       = 0016;
  CONST_OPCION_ORDEN_PRODUCCION               = 0017;
  CONST_OPCION_INVENTARIO_ENTRADA             = 0018;
  CONST_OPCION_INVENTARIO_SALIDA              = 0019;
  CONST_OPCION_INVENTARIO_DEVOLUCION          = 0020;
  CONST_OPCION_SALIR                          = 0021;

Type
  TItem_App = Class
    Id_Int  : Integer;
    Id_Str  : String ;
    Caption : String ;
    Value   : Boolean;
  End;
  TItems_App = TList<TItem_App>;

  TPermisos_App = Class
    Private
      FINDEX : Integer;
      FItems_App : TItems_App;
      Procedure Add(Const pId_Int : Integer; Const pId_Str : String);
      Procedure Restart;
      Procedure Load;
      Function Is_ERP(Const pId_Int : Integer) : Boolean;
    Public
      Property Items_App : TItems_App Read FItems_App;
      Procedure SetEnabled(Const pId_Int : Integer; Const pValue : Boolean);
      Function IsEnabled(Const pId_Int : Integer) : Boolean;
      Function GetItem(Const pId_Int : Integer) : TItem_App;
      Constructor Create;
      Destructor Destroy;
  End;

implementation

Uses
  System.SysUtils,
  Generics.Defaults;

Procedure TPermisos_App.Add(Const pId_Int : Integer; Const pId_Str : String);
Var
  lItem : TItem_App;
Begin
  lItem := TItem_App.Create;
  FItems_App.Add(lItem);
  lItem.Id_Int  := pId_Int;
  lItem.Id_Str  := Trim(pId_Str);
  lItem.Value   := False;
  lItem.Caption := Trim(pId_Str);
  lItem.Caption := StringReplace(lItem.Caption, 'OPCION', '' , [rfReplaceAll]);
  lItem.Caption := StringReplace(lItem.Caption, 'ACCION', '' , [rfReplaceAll]);
  lItem.Caption := StringReplace(lItem.Caption, '_'     , ' ', [rfReplaceAll]);
  lItem.Caption := Trim(lItem.Caption);
End;

Procedure TPermisos_App.Restart;
Var
  lItem : TItem_App;
Begin
  For lItem In FItems_App Do
    lItem.Free;
  FItems_App.Clear;
End;

Procedure TPermisos_App.SetEnabled(Const pId_Int : Integer; Const pValue : Boolean);
Var
  Target: TItem_App;
  Comparer: IComparer<TItem_App>;
  Comparison: TComparison<TItem_App>;
Begin
  Target := TItem_App.Create;
  Target.Id_Int := pId_Int;
  Comparison := Function(const pLeft, pRight: TItem_App): Integer
                Begin
                  Result := pLeft.Id_Int - pRight.Id_Int;
                End;
  FItems_App.Sort(TComparer<TItem_App>.Construct(Comparison));
  Comparer := TComparer<TItem_App>.Construct(Comparison);
  If FItems_App.BinarySearch(Target, FINDEX, Comparer) Then
    FItems_App[FINDEX].Value := pValue;
  FreeAndNil(Target);
End;

Function TPermisos_App.Is_ERP(Const pId_Int : Integer) : Boolean;
Begin
  Result := pId_Int In [
                         CONST_ACCION_ERP_ADMINISTRADOR,
                         CONST_ACCION_DELIMITAR_CON_COMA,
                         CONST_ACCION_EDITAR_ENTRADAS,
                         CONST_ACCION_EDITAR_SALIDA,
                         CONST_ACCION_EDITAR_DEVOLUCIONES,
                         CONST_OPCION_CAMBIO_DE_PASSWORD,
                         CONST_OPCION_VER_SESIONES_ACTIVAS,
                         CONST_OPCION_PERFIL,
                         CONST_OPCION_USUARIO,
                         CONST_OPCION_ADMINISTRACION_DE_DOCUMENTOS,
                         CONST_OPCION_AREA,
                         CONST_OPCION_PROCESO,
                         CONST_OPCION_PROYECTO,
                         CONST_OPCION_TERCERO,
                         CONST_OPCION_PRODUCTO,
                         CONST_OPCION_ORDEN_PRODUCCION,
                         CONST_OPCION_INVENTARIO_ENTRADA,
                         CONST_OPCION_INVENTARIO_SALIDA,
                         CONST_OPCION_INVENTARIO_DEVOLUCION,
                         CONST_OPCION_SALIR
                       ];
End;


Function TPermisos_App.IsEnabled(Const pId_Int : Integer) : Boolean;
Var
  Target : TItem_App;
  lFindIt : Boolean;
  Comparer : IComparer<TItem_App>;
  Comparison : TComparison<TItem_App>;
Begin
  Result := False;
  Target := TItem_App.Create;
  Target.Id_Int := pId_Int;
  Comparison := Function(const pLeft, pRight: TItem_App): Integer
                Begin
                  Result := pLeft.Id_Int - pRight.Id_Int;
                End;
  FItems_App.Sort(TComparer<TItem_App>.Construct(Comparison));
  Comparer := TComparer<TItem_App>.Construct(Comparison);
  lFindIt := FItems_App.BinarySearch(Target, FINDEX, Comparer);
  FreeAndNil(Target);
  If lFindIt And Is_ERP(pId_Int) Then
  Begin
    Result := FItems_App[FINDEX].Value Or (GetItem(CONST_ACCION_ERP_ADMINISTRADOR).Value);
  End;
End;

Function TPermisos_App.GetItem(Const pId_Int : Integer) : TItem_App;
Var
  Target: TItem_App;
  Comparer: IComparer<TItem_App>;
  Comparison: TComparison<TItem_App>;
Begin
  Result := Nil;
  Target := TItem_App.Create;
  Target.Id_Int := pId_Int;
  Comparison := Function(const pLeft, pRight: TItem_App): Integer
                Begin
                  Result := pLeft.Id_Int - pRight.Id_Int;
                End;
  FItems_App.Sort(TComparer<TItem_App>.Construct(Comparison));
  Comparer := TComparer<TItem_App>.Construct(Comparison);
  If FItems_App.BinarySearch(Target, FINDEX, Comparer) Then
    Result := FItems_App[FINDEX];
  FreeAndNil(Target);
End;

Procedure TPermisos_App.Load;
Begin
  Add(CONST_ACCION_ERP_ADMINISTRADOR           , 'ACCION_ERP_ADMINISTRADOR'           );
  Add(CONST_ACCION_DELIMITAR_CON_COMA          , 'ACCION_DELIMITAR_CON_COMA'          );
  Add(CONST_ACCION_EDITAR_ENTRADAS             , 'ACCION_EDITAR_ENTRADAS'             );
  Add(CONST_ACCION_EDITAR_SALIDA               , 'ACCION_EDITAR_SALIDA'               );
  Add(CONST_ACCION_EDITAR_DEVOLUCIONES         , 'ACCION_EDITAR_DEVOLUCIONES'         );
  Add(CONST_OPCION_CAMBIO_DE_PASSWORD          , 'OPCION_CAMBIO_DE_PASSWORD'          );
  Add(CONST_OPCION_VER_SESIONES_ACTIVAS        , 'OPCION_VER_SESIONES_ACTIVAS'        );
  Add(CONST_OPCION_PERFIL                      , 'OPCION_PERFIL'                      );
  Add(CONST_OPCION_USUARIO                     , 'OPCION_USUARIO'                     );
  Add(CONST_OPCION_ADMINISTRACION_DE_DOCUMENTOS, 'OPCION_ADMINISTRACION_DE_DOCUMENTOS');
  Add(CONST_OPCION_AREA                        , 'OPCION_AREA'                        );
  Add(CONST_OPCION_PROCESO                     , 'OPCION_PROCESO'                     );
  Add(CONST_OPCION_TERCERO                     , 'OPCION_TERCERO'                     );
  Add(CONST_OPCION_PRODUCTO                    , 'OPCION_PRODUCTO'                    );
  Add(CONST_OPCION_PROYECTO                    , 'OPCION_PROYECTO'                    );
  Add(CONST_OPCION_ORDEN_PRODUCCION            , 'OPCION_ORDEN_PRODUCCION'            );
  Add(CONST_OPCION_INVENTARIO_ENTRADA          , 'OPCION_INVENTARIO_ENTRADA'          );
  Add(CONST_OPCION_INVENTARIO_SALIDA           , 'OPCION_INVENTARIO_SALIDA'           );
  Add(CONST_OPCION_INVENTARIO_DEVOLUCION       , 'OPCION_INVENTARIO_DEVOLUCION'       );
  Add(CONST_OPCION_SALIR                       , 'OPCION_SALIR'                       );
End;

{ TPermisos_App }
Constructor TPermisos_App.Create;
Begin
  FItems_App := TItems_App.Create;
  Load;
End;

Destructor TPermisos_App.Destroy;
Begin
  Restart;
  FreeAndNil(FItems_App);
End;

End.
