unit Form_IWLogin;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWCompExtCtrls, IWCompButton, IWCompEdit,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  Vcl.Controls, Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompListbox, IWHTMLControls, UtConexion;

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
    procedure IWImage3AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure BtnOKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnCancelAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNRECUPERARAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FCaptcha : String;
    procedure Recuperar_Password(EventParams: TStringList);
    Function Usuario_Valido : Boolean;
    Function Authentication_Validated : Boolean;
  public
    Constructor Create(pAowner : TComponent; pCnx : TConexion);
  end;

implementation
{$R *.dfm}
Uses
  UtLog,
  UtCaptcha,
  UtFuncion,
  UtilsIW.Cfg,
  Criptografia,
  UtManager_Mail,
  ServerController,
  IW.Common.AppInfo,
  TBL000.Info_Tabla,
  IW.Browser.Browser,
  UtilsIW.Permisos_App;


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
    FCNX.AUX.SQL.Add(' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Usuario].Name + FCNX.No_Lock);
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
          UtLog_Execute('TFrIWLogin.Usuario_Valido, Autenticado: ' + UserSession.USER_CODE + ', ' + UserSession.USER_NAME);
          UtLog_Execute('TFrIWLogin.Usuario_Valido,IP: ' + UserSession.WebApplication.IP);
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
      UtLog_Execute('TFrIWLogin.Usuario_Valido, ' + E.Message);
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
  If Authentication_Validated Then
  Begin
    UserSession.ShowForm_Menu;
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
  Self.Name := 'LOGIN' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
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

initialization
  UtLog_Execute('Form_IWLogin, Preparando sesion...');
  TFrIWLogin.SetAsMainForm;

end.
