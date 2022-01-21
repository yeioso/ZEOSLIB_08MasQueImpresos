unit Form_IWCambio_Password;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompExtCtrls, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  IWCompButton, IWCompListbox, IWCompProgressIndicator, IWCompEdit,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, UtConexion;

type
  TFrIWCambio_Password = class(TIWAppForm)
    RREGRESAR: TIWRegion;
    IMAGE_SALIR: TIWImage;
    BTNEJECUTAR: TIWImage;
    IWLabel1: TIWLabel;
    IWCambiarPassword: TIWRegion;
    IWLabel35: TIWLabel;
    IWLabel36: TIWLabel;
    IWLabel37: TIWLabel;
    ACTUAL: TIWEdit;
    NUEVO: TIWEdit;
    CONFIRMACION: TIWEdit;
    IWLabel38: TIWLabel;
    NOMBRE_USUARIO: TIWEdit;
    IWLabel42: TIWLabel;
    EMAIL: TIWEdit;
    procedure IWAppFormCreate(Sender: TObject);
    procedure BTNEJECUTARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure IMAGE_SALIRAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    Procedure Release_Me;
    Function Password_Valido : Boolean;
    Function Actualizar_Password : Boolean;
    Procedure Cargar_informacion;
    procedure Ejecutar_Cambiar_Password(EventParams: TStringList);
  public
  end;

implementation
{$R *.dfm}
Uses
  UtFuncion,
  Criptografia,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Procedure TFrIWCambio_Password.Cargar_informacion;
Begin
  Try
    NOMBRE_USUARIO.Text := AnsiUpperCase(Trim(UserSession.USER_NAME));
    EMAIL.Text          := FCNX.GetValue(Info_TablaGet(Id_TBL_Usuario).Name, ['CODIGO_USUARIO'], [UserSession.USER_CODE], ['EMAIL']);
    EMAIL.Text          := Trim(LowerCase(EMAIL.Text));
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWCambio_Password', 'TFrIWCambio_Password.Cargar_informacion', E.Message);
  End;
End;

Function TFrIWCambio_Password.Password_Valido : Boolean;
Var
  lHash : String;
  lPassword : String;
Begin
  Result := False;
  If Vacio(ACTUAL.Text) Or Vacio(NUEVO.Text) Or Vacio(CONFIRMACION.Text) Then
  Begin
    UserSession.SetMessage('Debe ingresar todos los campos para proceder con el cambio de contraseña', True);
    Exit;
  End;

  If Trim(NUEVO.Text) <> Trim(CONFIRMACION.Text) Then
  Begin
    UserSession.SetMessage('La contraseña nueva y la confirmaciòn no coinciden', True);
    Exit;
  End;

  Try
    Try
      FCNX.AUX.Active := False;
      FCNX.AUX.SQL.Clear;
      FCNX.AUX.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Usuario).Name + ' ' + FCNX.No_Lock);
      FCNX.AUX.SQL.Add(' WHERE ID_SISTEMA = ' + QuotedStr('S'));
      FCNX.AUX.SQL.Add(' AND ' + FCNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(UserSession.USER_CODE)));
      FCNX.AUX.Active := True;
      If FCNX.AUX.Active And (FCNX.AUX.RecordCount > 0) Then
      Begin
        lPassword := RetornarDecodificado(Const_KEY, FCNX.AUX.FieldByName('CONTRASENA').AsString, lHash);
        Result := Trim(AnsiUpperCase(lPassword)) = Trim(AnsiUpperCase(ACTUAL.Text));
        If Not Result Then
          UserSession.SetMessage('Autenticación no valida', True)
      End
      Else
        UserSession.SetMessage('Usuario no existe', True);
      FCNX.AUX.Active := False;
    Except
      On E: Exception Do
        Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWCambio_Password', 'TFrIWCambio_Password.Password_Valido, A: ', E.Message);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWCambio_Password', 'TFrIWCambio_Password.Password_Valido, B: ', E.Message);
  End;
End;

Function TFrIWCambio_Password.Actualizar_Password : Boolean;
Var
  lHash : String;
  lPassword : String;
Begin
  Try
    Try
      FCNX.AUX.Active := False;
      FCNX.AUX.SQL.Clear;
      FCNX.AUX.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Usuario).Name + FCNX.No_Lock);
      FCNX.AUX.SQL.Add(' WHERE ID_SISTEMA = ' + QuotedStr('S'));
      FCNX.AUX.SQL.Add(' AND ' + FCNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(UserSession.USER_CODE)));
      FCNX.AUX.Active := True;
      If FCNX.AUX.Active And (FCNX.AUX.RecordCount > 0) Then
      Begin
        lPassword := RetornarCodificado(Const_KEY, Trim(CONFIRMACION.Text), lHash);
        FCNX.AUX.Edit;
        FCNX.AUX.FieldByName('CONTRASENA').AsString := Trim(lPassword);
        FCNX.AUX.FieldByName('NOMBRE'    ).AsString := Trim(AnsiUpperCase(NOMBRE_USUARIO.Text));
        FCNX.AUX.FieldByName('EMAIL'     ).AsString := Trim(LowerCase    (EMAIL.Text         ));
        UserSession.SetUSER_NAME(AnsiUpperCase(NOMBRE_USUARIO.Text));
        FCNX.AUX.Post;
        Result := True;
        ACTUAL.Text       := '';
        NUEVO.Text        := '';
        CONFIRMACION.Text := '';
        UserSession.SetUSER_NAME(NOMBRE_USUARIO.Text);
        UserSession.Update_Menu;
      End
      Else
        UserSession.SetMessage('Usuario no existe', True);
      FCNX.AUX.Active := False;
    Except
      On E: Exception Do
        Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWCambio_Password', 'TFrIWCambio_Password.Actualizar_Password, A: ', E.Message);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWCambio_Password', 'TFrIWCambio_Password.Actualizar_Password, B: ', E.Message);
  End;
End;

procedure TFrIWCambio_Password.BTNEJECUTARAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  If Password_Valido Then
    WebApplication.ShowConfirm('Está seguro(a) de realizar el cambio de contraseña?', Self.Name + '.Ejecutar_Cambiar_Password', 'Cambiar de bodega', 'Sí', 'No');
end;

Procedure TFrIWCambio_Password.Ejecutar_Cambiar_Password(EventParams: TStringList);
Begin
  If Result_Is_OK(EventParams.Values['RetValue']) Then
    If Actualizar_Password Then
      Release_Me;
End;

procedure TFrIWCambio_Password.IMAGE_SALIRAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Release_Me;
end;

procedure TFrIWCambio_Password.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'TFrIWCambio_Password' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  FCNX := UserSession.CNX;
  Cargar_informacion;
  WebApplication.RegisterCallBack(Self.Name + '.Ejecutar_Cambiar_Password', Ejecutar_Cambiar_Password);
end;

procedure TFrIWCambio_Password.IWAppFormDestroy(Sender: TObject);
begin
  WebApplication.UnregisterCallBack(Self.Name + '.Ejecutar_Cambiar_Password');
end;

Procedure TFrIWCambio_Password.Release_Me;
Begin
  Self.Release;
End;


end.
