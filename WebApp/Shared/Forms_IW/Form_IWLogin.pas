unit Form_IWLogin;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWCompExtCtrls, IWCompButton, IWCompEdit,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  Vcl.Controls, Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompListbox, IWHTMLControls, UtConexion,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component;

type

  TFrIWLogin = class(TIWAppForm)
    IWLOGIN: TIWRegion;
    IWLabel1: TIWLabel;
    IWLabel2: TIWLabel;
    USUARIO: TIWEdit;
    PASSWORD: TIWEdit;
    BtnOK: TIWButton;
    IWLabel3: TIWLabel;
    CAPTCHA: TIWEdit;
    IWRegion1: TIWRegion;
    IWImageCaptcha: TIWImage;
    IWRegion2: TIWRegion;
    IWImage3: TIWImage;
    IWLabel4: TIWLabel;
    BtnCancel: TIWButton;
    BTNRECUPERAR: TIWButton;
    IWLabel43: TIWLabel;
    IWURL1: TIWURL;
    LBVERION: TIWLabel;
    IWFONDO: TIWImage;
    IWTimer1: TIWTimer;
    procedure IWImage3AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure BtnOKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnCancelAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNRECUPERARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWTimer1AsyncTimer(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FCaptcha : String;
    Procedure Mostrar_Mensaje_vencimiento;
    procedure Recuperar_Password(EventParams: TStringList);
    Procedure Verificar_Notificacion;
    Function Usuario_Valido : Boolean;
    Function Authentication_Validated : Boolean;
  public
    Constructor Create(pAowner : TComponent; pCnx : TConexion);
  end;

implementation
{$R *.dfm}
Uses
  UtCaptcha,
  UtFuncion,
  UtilsIW.Cfg,
  Criptografia,
  UtManager_Mail,
  ServerController,
  IW.Common.AppInfo,
  TBL000.Info_Tabla,
  IW.Browser.Browser,
  UtilsIW.ManagerLog,
  UtilsIW.Permisos_App;

Const
//  Const_Fecha_Aviso = '2022-04-23';
  Const_Fecha_Aviso = '2022-04-22';
  Const_Fecha_Vencimiento = '2022-04-26';


Procedure TFrIWLogin.Mostrar_Mensaje_vencimiento;
Begin
  If Trim(FormatDateTime('YYYY-MM-DD HH:NN:SS', Now)) > Const_Fecha_Vencimiento Then
  Begin
    UserSession.SetMessage('Por favor comuniquese con el soporte tecnico de A.S.E., ha caducado la ejecución de este aplicativo', True);
  End
  Else
  Begin
    If Trim(FormatDateTime('YYYY-MM-DD HH:NN:SS', Now)) >= Const_Fecha_Aviso  Then
    Begin
      UserSession.SetMessage('Por favor comuniquese con el soporte tecnico de A.S.E.', True);
    End;
  End;
End;


Procedure TFrIWLogin.Recuperar_Password(EventParams: TStringList);
var
  lEmail : String;
  lError : String;
  lNombre : String;
  Response : Boolean;
  lPassword : String;
  InputValue : string;
begin
  // Prompt callback has 2 main parameters:
  // RetValue (Boolean), indicates if the first button (Yes/OK/custom) was choosen
  // InputStr, contains the string entered in the input box
  Response := Result_Is_OK(EventParams.Values['RetValue']);
  InputValue := EventParams.Values['InputStr'];
  If Response Then
  Begin
    If IWServerController.GetPassword_Items(InputValue, lNombre, InputValue, lPassword, lError) Then
    Begin
      If UtManager_Mail_Send('', '', '',lEmail, 'AUTENTICACION DE USUARIO', Trim(lNombre) + ', su autenticacion es ' + lPassword, 0) Then
        WebApplication.ShowNotification('Recuperación realizada', TIWNotifyType.ntSuccess)
      Else
        WebApplication.ShowNotification('Hay problema para recuperar la contraseña', TIWNotifyType.ntError)
    End
    Else
      UserSession.SetMessage(lError, True);
  End
  Else
  Begin
    WebApplication.ShowNotification('Recuperación no realizada', TIWNotifyType.ntError);
  End;
End;

Procedure TFrIWLogin.Verificar_Notificacion;
Begin
  Try
    FCNX.SQL.Active := False;
    FCNX.SQL.SQL.Clear;
    FCNX.SQL.SQL.Add(' SELECT COUNT(*) AS REGISTROS ');
    FCNX.SQL.SQL.Add(' FROM ' + Info_TablaGet(Id_TBL_Notificacion_Producto).Name + ' ');
    FCNX.SQL.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(UserSession.USER_CODE)) + ' ');
    FCNX.SQL.SQL.Add(' AND '   + FCNX.Trim_Sentence('ID_ACTIVO') + ' = ' + QuotedStr(Trim('S')) + ' ');
    FCNX.SQL.Active := True;
    If FCNX.SQL.FieldByName('REGISTROS').AsInteger > 0 Then
      UserSession.ShowForm_Notificacion_Producto;

    FCNX.SQL.Active := False;
    FCNX.SQL.SQL.Clear;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE,  'Form_IWLogin', 'TFrIWLogin.Verificar_Notificacion', E.Message);
  End;
End;

Function TFrIWLogin.Usuario_Valido : Boolean;
Var
  lHash : String;
  lBrowser : TBrowser;
  lPassword : String;
Begin
  Result := False;
  Try
    FCNX.AUX.Active := False;
    FCNX.AUX.SQL.Clear;
    FCNX.AUX.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Usuario).Name + FCNX.No_Lock);
    FCNX.AUX.SQL.Add(' WHERE ID_ACTIVO = ' + QuotedStr('S'));
    FCNX.AUX.SQL.Add(' AND ' );
    FCNX.AUX.SQL.Add(' ( ' );
    FCNX.AUX.SQL.Add(' '   + FCNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(USUARIO.Text)));
    FCNX.AUX.SQL.Add('  OR ');
    FCNX.AUX.SQL.Add('  ' + FCNX.Trim_Sentence('EMAIL'          ) + ' = ' + QuotedStr(Trim(USUARIO.Text)));
    FCNX.AUX.SQL.Add(' ) ' );
    FCNX.AUX.Active := True;
    If FCNX.AUX.Active And (FCNX.AUX.RecordCount > 0) Then
    Begin
      lPassword := RetornarDecodificado(Const_KEY, FCNX.AUX.FieldByName('CONTRASENA').AsString, lHash);
      Result := Trim(AnsiUpperCase(lPassword)) = Trim(AnsiUpperCase(PASSWORD.Text));
      If Not Result Then
        WebApplication.ShowMessage('Autenticación no valida')
      Else
      Begin
        lBrowser := UserSession.WebApplication.Browser;
        UserSession.WebApplication.SetUserNameAndPassword(USUARIO.Text, '');
        UserSession.SetUSER_CODE(FCNX.AUX.FieldByName('CODIGO_USUARIO').AsString);
        UserSession.SetCODE_PROFILE(FCNX.AUX.FieldByName('CODIGO_PERFIL').AsString);
        UserSession.SetUSER_NAME(Trim(FCNX.AUX.FieldByName('NOMBRE').AsString));
        UserSession.Validar_Perfil(UserSession.CODE_PROFILE);
        UserSession.SetAmbiente;
        If Result Then
        Begin
          FCNX.SetAppUser(UserSession.USER_CODE);
          UserSession.SetEstacion(UserSession.WebApplication.IP + ' - ' + UserSession.USER_NAME);
          FCNX.SetAppUser(UserSession.USER_CODE + ' - ' + UserSession.USER_NAME);
          FCNX.SetAppWorkStations(UserSession.WebApplication.IP + ' - ' + UserSession.USER_NAME);
          Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWLogin', 'TFrIWLogin.Usuario_Valido', 'Autenticado: ' + UserSession.USER_CODE + ', ' + UserSession.USER_NAME);
          Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWLogin', 'TFrIWLogin.Usuario_Valido' ,'IP: ' + UserSession.WebApplication.IP);
        End
        Else
        Begin
          WebApplication.ShowMessage('El usuario esta en nuestra base de datos, pero no tiene privilegios para usar esta plataforma, verifique la información');
        End;
      End;
    End
    Else
    Begin
      WebApplication.ShowMessage('Usuario no existe');
    End;
    FCNX.AUX.Active := False;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE,  'Form_IWLogin', 'TFrIWLogin.Usuario_Valido', E.Message);
  End;
End;

Function TFrIWLogin.Authentication_Validated : Boolean;
Begin
  Result := False;
  If Vacio(USUARIO.Text) Or Vacio(PASSWORD.Text) Then
  Begin
    WebApplication.ShowMessage('Debe ingresar el usuario y la contraseña');
    Exit;
  End;

  If Vacio(CAPTCHA.Text) Or (Not (AnsiUpperCase(Trim(FCaptcha)) = AnsiUpperCase(Trim(CAPTCHA.Text)))) Then
  Begin
    WebApplication.ShowMessage('Captcha invalido');
    Exit;
  End;

  Result := Usuario_Valido;
End;

procedure TFrIWLogin.BtnCancelAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.Terminate('Gracias por usar la plataforma');
end;

procedure TFrIWLogin.BtnOKAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  BtnOK.Enabled := False;

  If Trim(FormatDateTime('YYYY-MM-DD HH:NN:SS', Now)) > Const_Fecha_Vencimiento Then
  Begin
    WebApplication.ShowMessage('Por favor comuniquese con el soporte tecnico de A.S.E., ha caducado la ejecución de este aplicativo');
    BtnOK.Enabled := True;
    Exit;
  End
  Else
  Begin
    If Trim(FormatDateTime('YYYY-MM-DD HH:NN:SS', Now)) >= Const_Fecha_Aviso  Then
    Begin
      UserSession.SetMessage('Por favor comuniquese con el soporte tecnico de A.S.E.', True);
    End;
  End;


  If Authentication_Validated Then
  Begin
    UserSession.ShowForm_Menu;
    Verificar_Notificacion;
    Self.Release;
  End
  Else
    BtnOK.Enabled := True;
end;

procedure TFrIWLogin.BTNRECUPERARAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowPrompt('Identificación', Self.Name + '.Recuperar_Password', 'Digite su identificación', '', 'Recuperar', 'Cancelar');
end;

procedure TFrIWLogin.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'TFrIWLogin' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  LBVERION.Caption := Const_Version;
  WebApplication.RegisterCallBack(Self.Name + '.Recuperar_Password', Recuperar_Password);
  UtCaptcha_Generate(FCaptcha, IWImageCaptcha);
  {$IFDEF DEBUG}
    USUARIO.Text := '15458469';
    PASSWORD.Text := '0';
    CAPTCHA.Text := '0';
    FCaptcha := '0';
  {$ENDIF}
end;

Constructor TFrIWLogin.Create(pAowner : TComponent; pCnx : TConexion);
Begin
  Inherited Create(pAowner);
  FCNX := pCnx;
End;

procedure TFrIWLogin.IWImage3AsyncClick(Sender: TObject; EventParams: TStringList);
begin
  UtCaptcha_Generate(FCaptcha, IWImageCaptcha);
end;

procedure TFrIWLogin.IWTimer1AsyncTimer(Sender: TObject; EventParams: TStringList);
begin
  Mostrar_Mensaje_vencimiento;
end;

end.
