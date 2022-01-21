unit Form_IWUsuario_Inicial;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, UtConexion,
  IWCompEdit, Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, IWCompButton, IWCompProgressIndicator;

type
  TFrIWUsuario_Inicial = class(TIWAppForm)
    IWLabel1: TIWLabel;
    CODIGO_USUARIO: TIWEdit;
    IWLabel2: TIWLabel;
    NOMBRE: TIWEdit;
    IWLabel3: TIWLabel;
    PASWORD: TIWEdit;
    btnAceptar: TIWButton;
    BtnCancelar: TIWButton;
    IWProgressIndicator1: TIWProgressIndicator;
    IWLabel4: TIWLabel;
    EMAIL: TIWEdit;
    procedure IWAppFormCreate(Sender: TObject);
    procedure BtnCancelarAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnAceptarAsyncClick(Sender: TObject; EventParams: TStringList);
  Private
     FCNX : TConexion;
     Function Validar : Boolean;
  Public
    Constructor Create(pAowner : TComponent; pCnx : TConexion);
  End;

implementation
{$R *.dfm}

Uses
  UtFuncion,
  ServerController,
  UtilsIW.ManagerLog,
  UtilsIW.Usuario_Inicial;

procedure TFrIWUsuario_Inicial.btnAceptarAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  if UtilsIW_Usuario_Inicial(UserSession.CNX, CODIGO_USUARIO.Text, NOMBRE.Text, PASWORD.Text, EMAIL.Text) Then
  Begin
    UserSession.ShowForm_Login;
    Self.Release;
  End;
end;

procedure TFrIWUsuario_Inicial.BtnCancelarAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.Terminate('Gracias por usar la plataforma');
  Self.Release;
end;

Procedure TFrIWUsuario_Inicial.IWAppFormCreate(Sender: TObject);
Begin
  Self.Name := 'TFrIWUsuario_Inicial' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000) );
End;

Constructor TFrIWUsuario_Inicial.Create(pAowner : TComponent; pCnx : TConexion);
Begin
  Inherited Create(pAowner);
  FCNX := pCNX;
End;

Function TFrIWUsuario_Inicial.Validar : Boolean;
Begin
  Result := False;
  Try
    If Vacio(CODIGO_USUARIO.Text) Or
       Vacio(NOMBRE.Text        ) Or
       Vacio(PASWORD.Text       ) Then
    Begin

    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Inicial', 'TFrIWUsuario_Inicial.Validar', E.Message);
    End;
  End;
End;

end.
