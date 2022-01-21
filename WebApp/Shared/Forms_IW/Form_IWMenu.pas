unit Form_IWMenu;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Vcl.Controls,
  Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, Vcl.Imaging.pngimage, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompExtCtrls, IWCompButton,
  IWCompLabel, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompListbox, IWHTMLControls, UtType, IWCompProgressIndicator,
  IWjQPageControl;

Type

  TFrIWMenu = class(TIWAppForm)
    IWREGION_TITULO: TIWRegion;
    LBINFO: TIWLabel;
    IWLabel43: TIWLabel;
    IWURL1: TIWURL;
    IWModalWindow1: TIWModalWindow;
    PAGINAS: TIWjQPageControl;
    PAG_MAESTROS: TIWjQTabPage;
    PAG_INVENTARIOS: TIWjQTabPage;
    PAG_MOVIMIENTOS: TIWjQTabPage;
    IMAGE_MAESTROS: TIWImage;
    IMAGE_INVENTARIOS: TIWImage;
    IMAGE_MOVIMIENTOS: TIWImage;
    PAG_FACTURACION: TIWjQTabPage;
    IMAGE_FACTURACION: TIWImage;
    PAG_TRANSFERENCIAS: TIWjQTabPage;
    PAG_PROCESOS: TIWjQTabPage;
    IMAGE_PROCESOS: TIWImage;
    PAG_INFORMES: TIWjQTabPage;
    IMAGE_INFORME: TIWImage;
    PAG_UTILIDADES: TIWjQTabPage;
    IMAGE_UTILIDADES: TIWImage;
    PAG_SALIR: TIWjQTabPage;
    IMAGE_SALIR: TIWImage;
    RG_MAESTROS: TIWRadioGroup;
    RG_INVENTARIOS: TIWRadioGroup;
    RG_MOVIMIENTOS: TIWRadioGroup;
    RG_FACTURACION: TIWRadioGroup;
    RG_TRANSFERENCIAS: TIWRadioGroup;
    RG_PROCESOS: TIWRadioGroup;
    RG_INFORMES: TIWRadioGroup;
    RG_UTILIDADES: TIWRadioGroup;
    RG_SALIR: TIWRadioGroup;
    BTNEJECUTAR_MAESTRO: TIWButton;
    BTNEJECUTAR_INVENTARIOS: TIWButton;
    BTNEJECUTAR_MOVIMIENTOS: TIWButton;
    BTNEJECUTAR_FACTURACION: TIWButton;
    BTNEJECUTAR_PROCESOS: TIWButton;
    BTNEJECUTAR_INFORMES: TIWButton;
    BTNEJECUTAR_UTILIDADES: TIWButton;
    BTNEJECUTAR_SALIR: TIWButton;
    IMAGE_TRANSFERENCIAS: TIWImage;
    BTNEJECUTAR_TRANSFERENCIAS: TIWButton;
    IWProgressIndicator1: TIWProgressIndicator;
    BTNAYUDA: TIWImage;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNEJECUTAR_MAESTROAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEJECUTAR_INVENTARIOSAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEJECUTAR_MOVIMIENTOSAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEJECUTAR_TRANSFERENCIASAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEJECUTAR_FACTURACIONAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEJECUTAR_PROCESOSAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEJECUTAR_INFORMESAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEJECUTAR_UTILIDADESAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEJECUTAR_SALIRAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNAYUDAAsyncClick(Sender: TObject; EventParams: TStringList);
  Private
    Procedure Validar_Carga_Opciones(pOptions : TIWRadioGroup; Const pId : Integer);
    Procedure Cargar_Opciones(pOptions : TIWRadioGroup);
    Procedure Ejecutar_Item(pOption : TIWRadioGroup);
    Procedure Launch_Option(Const pItem_App : TObject);
    procedure Ejecutar_Salida(EventParams: TStringList);
  public
    Procedure Actualizar_Info;
    Constructor Create(aOwner: TComponent); override;
  end;

implementation
{$R *.dfm}
Uses
  UtFuncion,
  IWAppCache,
  UtConexion,
  IWMimeTypes,
  Criptografia,
  System.IOUtils,
  IW.CacheStream,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog,
  UtilsIW.Permisos_App,
  UtilsIW.Sesiones_Activas;

Procedure TFrIWMenu.Actualizar_Info;
Begin
  lbInfo.Caption := ' Bienvenido(a) ' + Trim(UserSession.USER_NAME) + ', ' + Const_Version;
End;

Procedure TFrIWMenu.Launch_Option(Const pItem_App : TObject);
Var
  lItem_App : TItem_App;
Begin
  If (Not Assigned(pItem_App)) Or (Not (pItem_App Is TItem_App)) Then
    Exit;
  lItem_App := pItem_App AS TItem_App;
  Try
    Case lItem_App.Id_Int Of
      CONST_OPCION_PERFIL                       : UserSession.ShowForm_Perfil_Enc       ;
      CONST_OPCION_USUARIO                      : UserSession.ShowForm_Usuario_Enc      ;
      CONST_OPCION_CAMBIO_DE_PASSWORD           : UserSession.ShowForm_Cambio_Password  ;
      CONST_OPCION_VER_SESIONES_ACTIVAS         : UtilsIW_Sesiones_Activas_Execute(WebApplication, UserSession.CNX, UserSession.USER_CODE);
      CONST_OPCION_ADMINISTRACION_DE_DOCUMENTOS : UserSession.ShowForm_Administrador_Documento;
      CONST_OPCION_AREA                         : UserSession.ShowForm_Area             ;
      CONST_OPCION_UNIDAD_MEDIDA                : UserSession.ShowForm_Unidad_Medida    ;
      CONST_OPCION_PRODUCTO                     : UserSession.ShowForm_Producto         ;
      CONST_OPCION_TERCERO                      : UserSession.ShowForm_Tercero          ;
      CONST_OPCION_PROYECTO                     : UserSession.ShowForm_Proyecto         ;
      CONST_OPCION_ORDEN_PRODUCCION             : UserSession.ShowForm_Orden_Produccion(UserSession.DOCUMENTO_ORDEN_DE_PRODUCCION     );
      CONST_OPCION_INVENTARIO_ENTRADA           : UserSession.ShowForm_Movto_Inventario(UserSession.DOCUMENTO_ENTRADA_DE_INVENTARIO   );
      CONST_OPCION_INVENTARIO_SALIDA            : UserSession.ShowForm_Movto_Inventario(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO    );
      CONST_OPCION_INVENTARIO_DEVOLUCION        : UserSession.ShowForm_Movto_Inventario(UserSession.DOCUMENTO_DEVOLUCION_AL_INVENTARIO);
      CONST_OPCION_REPORTE                      : UserSession.ShowForm_Reporte;
      CONST_OPCION_SALIR                        : WebApplication.ShowConfirm('Está seguro(a) de salir?', Self.Name + '.Ejecutar_Salida', 'Salir', 'Sí', 'No');
      Else UserSession.SetMessage('Opcion no disponible', True);
    End;
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.Launch_Option', E.Message);
  End;
End;

Procedure TFrIWMenu.Ejecutar_Item(pOption : TIWRadioGroup);
Var
  lItem_App : TItem_App;
Begin
  Try
    If pOption.ItemIndex <= -1 Then
     Begin
       UserSession.SetMessage('Debe elegir una opción', True);
       Exit;
     End;
     lItem_App := TItem_App(pOption.Items.Objects[pOption.ItemIndex]);
     If Assigned(lItem_App) Then
       Launch_Option(lItem_App);
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.Ejecutar_Item', E.Message);
  End;
End;

procedure TFrIWMenu.BTNAYUDAAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  lF : String;
  lURL : String;
  lDestino : String;
begin
  lF := IWServerController.PATH_FILES + ChangeFileExt(ExtractFileName(GetModuleName(HInstance)), '.PDF');
  If FileExists(lF) Then
  Begin
    lDestino := IncludeTrailingBackslash(ExtractFilePath(TIWAppCache.NewTempFileName('.pdf'))) + ExtractFileName(lF);
    If Not FileExists(lDestino) Then
      TFile.Copy(lF, lDestino);
    Sleep(500);
    If FileExists(lDestino) Then
    Begin
      lURL := TIWAppCache.AddFileToCache(WebApplication, lDestino, TIWMimeTypes.GetAsString(mtPDF), ctSession);
      WebApplication.NewWindow(lURL);
    End;
  End;
end;

procedure TFrIWMenu.BTNEJECUTAR_FACTURACIONAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    Ejecutar_Item(RG_FACTURACION);
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.BTNEJECUTAR_FACTURACIONAsyncClick', E.Message);
  End;
end;

procedure TFrIWMenu.BTNEJECUTAR_INFORMESAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    Ejecutar_Item(RG_INFORMES);
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.BTNEJECUTAR_INFORMESAsyncClick', E.Message);
  End;
end;

procedure TFrIWMenu.BTNEJECUTAR_INVENTARIOSAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    Ejecutar_Item(RG_INVENTARIOS);
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.BTNEJECUTAR_INVENTARIOSAsyncClick', E.Message);
  End;
end;

procedure TFrIWMenu.BTNEJECUTAR_MAESTROAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    Ejecutar_Item(RG_MAESTROS);
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.BTNEJECUTAR_MAESTROAsyncClick', E.Message);
  End;
End;

procedure TFrIWMenu.BTNEJECUTAR_MOVIMIENTOSAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    Ejecutar_Item(RG_MOVIMIENTOS);
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.BTNEJECUTAR_MOVIMIENTOSAsyncClick', E.Message);
  End;
end;

procedure TFrIWMenu.BTNEJECUTAR_PROCESOSAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    Ejecutar_Item(RG_PROCESOS);
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.BTNEJECUTAR_PROCESOSAsyncClick', E.Message);
  End;
end;

procedure TFrIWMenu.BTNEJECUTAR_SALIRAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    Ejecutar_Item(RG_SALIR);
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.BTNEJECUTAR_SALIRAsyncClick', E.Message);
  End;
end;

procedure TFrIWMenu.BTNEJECUTAR_TRANSFERENCIASAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    Ejecutar_Item(RG_TRANSFERENCIAS);
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.BTNEJECUTAR_TRANSFERENCIASAsyncClick', E.Message);
  End;
end;

procedure TFrIWMenu.BTNEJECUTAR_UTILIDADESAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    Ejecutar_Item(RG_UTILIDADES);
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.BTNEJECUTAR_UTILIDADESAsyncClick', E.Message);
  End;
end;

Procedure TFrIWMenu.Validar_Carga_Opciones(pOptions : TIWRadioGroup; Const pId : Integer);
Var
  lPermiso : TPERMISOS_APP;
Begin
  lPermiso := UserSession.PERMISOS_APP;
  If lPermiso.IsEnabled(pId) Then
    pOptions.Items.AddObject(lPermiso.GetItem(pId).Caption, lPermiso.GetItem(pId));
End;

Procedure TFrIWMenu.Cargar_Opciones(pOptions : TIWRadioGroup);
Begin
  Try
    pOptions.Items.Clear;
    If pOptions = RG_MAESTROS Then
    Begin
      Validar_Carga_Opciones(pOptions, CONST_OPCION_ADMINISTRACION_DE_DOCUMENTOS);
      Validar_Carga_Opciones(pOptions, CONST_OPCION_AREA                        );
      Validar_Carga_Opciones(pOptions, CONST_OPCION_UNIDAD_MEDIDA               );
      Validar_Carga_Opciones(pOptions, CONST_OPCION_PRODUCTO                    );
      Validar_Carga_Opciones(pOptions, CONST_OPCION_TERCERO                     );
      Validar_Carga_Opciones(pOptions, CONST_OPCION_PROYECTO                    );
      PAG_MAESTROS.Visible := RG_MAESTROS.Items.Count > 0;
    End;

    If pOptions = RG_INVENTARIOS Then
    Begin
      PAG_INVENTARIOS.Visible := RG_INVENTARIOS.Items.Count > 0;
    End;

    If pOptions = RG_MOVIMIENTOS Then
    Begin
      Validar_Carga_Opciones(pOptions, CONST_OPCION_ORDEN_PRODUCCION            );
      Validar_Carga_Opciones(pOptions, CONST_OPCION_INVENTARIO_ENTRADA          );
      Validar_Carga_Opciones(pOptions, CONST_OPCION_INVENTARIO_SALIDA           );
      Validar_Carga_Opciones(pOptions, CONST_OPCION_INVENTARIO_DEVOLUCION       );
      PAG_MOVIMIENTOS.Visible := RG_MOVIMIENTOS.Items.Count > 0;
    End;

    If pOptions = RG_TRANSFERENCIAS Then
    Begin
      PAG_TRANSFERENCIAS.Visible := RG_TRANSFERENCIAS.Items.Count > 0;
    End;

    If pOptions = RG_FACTURACION Then
    Begin
      PAG_FACTURACION.Visible := RG_FACTURACION.Items.Count > 0;
    End;

    If pOptions = RG_PROCESOS Then
    Begin
      PAG_PROCESOS.Visible := RG_PROCESOS.Items.Count > 0;
    End;

    If pOptions = RG_INFORMES Then
    Begin
      Validar_Carga_Opciones(pOptions, CONST_OPCION_REPORTE);
      PAG_INFORMES.Visible := RG_INFORMES.Items.Count > 0;
    End;

    If pOptions = RG_UTILIDADES Then
    Begin
      Validar_Carga_Opciones(pOptions, CONST_OPCION_CAMBIO_DE_PASSWORD          );
      Validar_Carga_Opciones(pOptions, CONST_OPCION_VER_SESIONES_ACTIVAS        );
      Validar_Carga_Opciones(pOptions, CONST_OPCION_PERFIL                      );
      Validar_Carga_Opciones(pOptions, CONST_OPCION_USUARIO                     );
      PAG_UTILIDADES.Visible := RG_UTILIDADES.Items.Count > 0;
    End;

    If pOptions = RG_SALIR Then
    Begin
      Validar_Carga_Opciones(pOptions, CONST_OPCION_SALIR                       );
    End;

  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.Cargar_Opciones', E.Message);
  End;
End;


procedure TFrIWMenu.Ejecutar_Salida(EventParams: TStringList);
begin
  Try
    If Result_Is_OK(EventParams.Values['RetValue']) Then
      WebApplication.Terminate('Gracias por utilizar la plataforma');
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMenu', 'TFrIWMenu.Ejecutar_Salida', E.Message);
  End;
end;

constructor TFrIWMenu.Create(aOwner: TComponent);
begin
  inherited;
end;

Procedure SetNameCompontent(pComponent : TComponent);
Var
  lI : Integer;
Begin
  If Not Assigned(pComponent) Then
    Exit;
  If Vacio(pComponent.Name) Then
  Begin
    Sleep(10);
    pComponent.Name := pComponent.ClassName + '_' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now); //+ '_' + IntToStr(GetTickCount);
  End;
  For lI := 0 To pComponent.ComponentCount-1 Do
    SetNameCompontent(pComponent.Components[lI]);
End;

procedure TFrIWMenu.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'TFrIWMenu' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  WebApplication.RegisterCallBack(Self.Name + '.Ejecutar_Salida', Ejecutar_Salida);
  Actualizar_Info;
  Cargar_Opciones(RG_MAESTROS      );
  Cargar_Opciones(RG_INVENTARIOS   );
  Cargar_Opciones(RG_MOVIMIENTOS   );
  Cargar_Opciones(RG_TRANSFERENCIAS);
  Cargar_Opciones(RG_FACTURACION   );
  Cargar_Opciones(RG_PROCESOS      );
  Cargar_Opciones(RG_INFORMES      );
  Cargar_Opciones(RG_UTILIDADES    );
  Cargar_Opciones(RG_SALIR         );
  SetNameCompontent(Self);
End;

procedure TFrIWMenu.IWAppFormDestroy(Sender: TObject);
begin
  WebApplication.UnregisterCallBack(Self.Name + '.Ejecutar_Salida');
end;

end.
