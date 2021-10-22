unit Form_IWUsuario_Enc;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompExtCtrls, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  IWCompTabControl, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  UtConexion, Data.DB, IWCompGrids, IWDBStdCtrls, IWCompEdit,
  IWCompCheckbox, IWCompMemo, IWDBExtCtrls, IWCompButton, IWCompListbox,
  UtGrid_JQ, UtNavegador_ASE, UtilsIW.Busqueda;

type
  TFrIWUsuario_Enc = class(TIWAppForm)
    RINFO: TIWRegion;
    lbInfo: TIWLabel;
    IWRegion1: TIWRegion;
    PAGINAS: TIWTabControl;
    PAG_00: TIWTabPage;
    PAG_01: TIWTabPage;
    RNAVEGADOR: TIWRegion;
    IWLabel1: TIWLabel;
    IWLabel8: TIWLabel;
    DATO: TIWEdit;
    IWLabel37: TIWLabel;
    IWLabel2: TIWLabel;
    IWLabel3: TIWLabel;
    IWLabel4: TIWLabel;
    IWLabel7: TIWLabel;
    IWLabel10: TIWLabel;
    IWRDETALLE: TIWRegion;
    IWRBOTONDETALLE: TIWRegion;
    BTNCONTRASENA: TIWImage;
    IWCambiarPassword: TIWRegion;
    IWLabel35: TIWLabel;
    MANAGER_PASSWORD: TIWEdit;
    BtnGrid: TIWImage;
    IWModalWindow1: TIWModalWindow;
    BTNCODIGO: TIWImage;
    CODIGO_USUARIO: TIWDBLabel;
    BTNNOMBRE: TIWImage;
    NOMBRE: TIWDBLabel;
    BTNDIRECCION: TIWImage;
    DIRECCION: TIWDBLabel;
    BTNEMAIL: TIWImage;
    EMAIL: TIWDBLabel;
    TELEFONO_1: TIWDBLabel;
    TELEFONO_2: TIWDBLabel;
    BTNTELEFONO_2: TIWImage;
    BTNTELEFONO_1: TIWImage;
    lbNombre_Activo: TIWLabel;
    BTNACTIVO: TIWImage;
    BTNCODIGO_PERFIL: TIWImage;
    CODIGO_PERFIL: TIWDBLabel;
    lbNombre_Perfil: TIWLabel;
    CONTRASENA: TIWDBEdit;
    IWRegion_Navegador: TIWRegion;
    GRID_DETALLE: TIWListbox;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCONTRASENAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNDIRECCIONAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEMAILAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNTELEFONO_1AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNTELEFONO_2AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PERFILAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FCODIGO_USUARIO : String;

    FQRMAESTRO : TMANAGER_DATA;

    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    FCODIGO_ACTUAL : String;

    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Perfil(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
    Procedure Asignar_Password(Sender: TObject;  EventParams: TStringList);

    procedure Resultado_Codigo(EventParams: TStringList);
    procedure Resultado_Nombre(EventParams: TStringList);
    procedure Resultado_Direccion(EventParams: TStringList);
    procedure Resultado_Email(EventParams: TStringList);
    procedure Resultado_Telefono_1(EventParams: TStringList);
    procedure Resultado_Telefono_2(EventParams: TStringList);
    procedure Resultado_Activo(EventParams: TStringList);

    Procedure Release_Me;

    Function Existe_Usuario(Const pCODIGO_USUARIO : String): Boolean;

    Procedure Validar_Campos_Master(pSender: TObject);
    Function Documento_Activo: Boolean;

    Procedure NewRecordMaster(pSender: TObject);
    Procedure DsDataChangeMaster(pSender: TObject);
    Procedure DsStateMaster(Sender: TObject);

    Procedure SetLabel;
    Procedure Estado_Controles;
    Function AbrirMaestro(Const pDato: String = ''): Boolean;
    Procedure AbrirDetalle(Sender: TObject; EventParams: TStringList);
    Procedure Cambiar_Password;
  public
    Constructor Create(AOwner: TComponent; Const pCodigo_Usuario : String);
  end;

implementation

{$R *.dfm}

Uses
  Math,
  UtLog,
  UtType,
  UtFecha,
  Variants,
  UtFuncion,
  Vcl.Graphics,
  Criptografia,
  Winapi.Windows,
  System.UITypes,
  System.StrUtils,
  ServerController,
  TBL000.Info_Tabla;

Procedure TFrIWUsuario_Enc.Resultado_Perfil(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString := EventParams.Values ['CODIGO_PERFIL' ];
    End;
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWUsuario_Enc.Resultado_Perfil, ' + e.Message);
  End;
End;

procedure TFrIWUsuario_Enc.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
Var
  lBusqueda : TBusqueda_MQI_WjQDBGrid;
begin
  Try
    lBusqueda := TBusqueda_MQI_WjQDBGrid.Create(Self);
    lBusqueda.Parent := Self;
    lBusqueda.SetComponents(FCNX, pEvent);
    lBusqueda.SetTSD(pSD);
    If lBusqueda.Abrir_Tabla Then
    Begin
      IWModalWindow1.Reset;
      IWModalWindow1.Buttons.CommaText := '&Cancelar';
      IWModalWindow1.Title := 'Busqueda de datos';
      IWModalWindow1.ContentElement := lBusqueda;
      IWModalWindow1.Autosize := True;
      IWModalWindow1.Draggable := True;
      IWModalWindow1.WindowTop := 10;
      IWModalWindow1.WindowLeft := 10;
      IWModalWindow1.WindowWidth := lBusqueda.Width + 20;
      IWModalWindow1.WindowHeight := lBusqueda.Height + 200;
      IWModalWindow1.OnAsyncClick := lBusqueda.Finish_Manager;
      IWModalWindow1.OnAsyncClose := lBusqueda.Finish_Manager;
      IWModalWindow1.SizeUnit := suPixel;
      IWModalWindow1.Show;
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.Buscar_Info, ' + e.Message);
  End;
End;

procedure TFrIWUsuario_Enc.Resultado_Codigo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString := Justificar(EventParams.Values['InputStr'], ' ', FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').Size);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.Resultado_Codigo, ' + e.Message);
  End;
End;

procedure TFrIWUsuario_Enc.Resultado_Nombre(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('NOMBRE').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.Resultado_Nombre, ' + e.Message);
  End;
End;

procedure TFrIWUsuario_Enc.Resultado_Direccion(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
      FQRMAESTRO.QR.FieldByName('DIRECCION').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.Resultado_Direccion, ' + e.Message);
  End;
End;

procedure TFrIWUsuario_Enc.Resultado_Email(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
      FQRMAESTRO.QR.FieldByName('EMAIL').AsString := LowerCase(Trim(EventParams.Values['InputStr']));
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.Resultado_Email, ' + e.Message);
  End;
End;

procedure TFrIWUsuario_Enc.Resultado_Telefono_1(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
      FQRMAESTRO.QR.FieldByName('TELEFONO_1').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.Resultado_Telefono_1, ' + e.Message);
  End;
End;

procedure TFrIWUsuario_Enc.Resultado_Telefono_2(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
      FQRMAESTRO.QR.FieldByName('TELEFONO_2').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.Resultado_Telefono_2, ' + e.Message);
  End;
End;

procedure TFrIWUsuario_Enc.Resultado_Activo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
      FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString := IfThen(Result_Is_OK(EventParams.Values['RetValue']), 'S', 'N');
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.Resultado_Activo, ' + e.Message);
  End;
End;

Procedure TFrIWUsuario_Enc.Asignar_Password(Sender: TObject;  EventParams: TStringList);
Var
  lHash : String;
Begin
  Case IWModalWindow1.ButtonIndex Of
    1 : Begin
          FQRMAESTRO.QR.FieldByName('CONTRASENA').AsString := Trim(RetornarCodificado(Const_KEY, Trim(MANAGER_PASSWORD.Text), lHash));
          CONTRASENA.Text := Trim(FQRMAESTRO.QR.FieldByName('CONTRASENA').AsString);
        End;
    3 : Begin
        End;
  End;
End;

Procedure TFrIWUsuario_Enc.Cambiar_Password;
Var
  lHash : String;
Begin
  MANAGER_PASSWORD.Text := RetornarDecodificado(Const_KEY, FQRMAESTRO.QR.FieldByName('CONTRASENA').AsString, lHash);
  IWModalWindow1.Reset;
  IWModalWindow1.Buttons.CommaText := '&Aceptar,&Cancelar';
  IWModalWindow1.Title := 'Cambio de Contrase�a';
  IWModalWindow1.ContentElement := IWCambiarPassword;
  IWModalWindow1.Autosize := True;
  IWModalWindow1.Draggable := True;
  IWModalWindow1.WindowTop := 10;
  IWModalWindow1.WindowLeft := 10;
  IWModalWindow1.WindowWidth := IWCambiarPassword.Width;
  IWModalWindow1.WindowHeight := IWCambiarPassword.Height;
  IWModalWindow1.OnAsyncClick := Asignar_Password;
  IWModalWindow1.SizeUnit := suPixel;
  IWModalWindow1.Show;
End;


Procedure TFrIWUsuario_Enc.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWUsuario_Enc.Existe_Usuario(Const pCODIGO_USUARIO : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(gInfo_Tablas[Id_TBL_Usuario].Name, ['CODIGO_USUARIO'], [pCODIGO_USUARIO]);
End;

Procedure TFrIWUsuario_Enc.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje: String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';

    CODIGO_USUARIO.BGColor := UserSession.COLOR_OK;
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CODIGO_PERFIL.BGColor := UserSession.COLOR_OK;
    CONTRASENA.BGColor := UserSession.COLOR_OK;

    If BTNCODIGO.Visible Then
    Begin
      If Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Usuario invalido';
        CODIGO_USUARIO.BGColor := UserSession.COLOR_ERROR;
      End
      Else
        If FCNX.Record_Exist(gInfo_Tablas[Id_TBL_Usuario].Name, ['CODIGO_USUARIO'], [FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString]) Then
        Begin
          lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Usuario ya existente';
          CODIGO_USUARIO.BGColor := UserSession.COLOR_ERROR;
        End;
    End;

    If BTNNOMBRE.Visible And Vacio(FQRMAESTRO.QR.FieldByName('NOMBRE').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Nombre invalido';
      NOMBRE.BGColor := UserSession.COLOR_ERROR;
    End;

    If BTNCONTRASENA.Visible And  Vacio(FQRMAESTRO.QR.FieldByName('CONTRASENA').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') +  'Contrase�a invalido';
      CONTRASENA.BGColor := UserSession.COLOR_ERROR;
    End;

    If BTNCODIGO_PERFIL.Visible And  Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') +  'Perfil invalido';
      CODIGO_PERFIL.BGColor := UserSession.COLOR_ERROR;
    End;

    FQRMAESTRO.ERROR := IfThen(Vacio(lMensaje), 0, -1);
    If FQRMAESTRO.ERROR <> 0 Then
    Begin
      FQRMAESTRO.LAST_ERROR := 'Datos invalidos, ' + lMensaje;
      UserSession.SetMessage(FQRMAESTRO.LAST_ERROR, True);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.Validar_Campos_Master, ' + E.Message);
  End;
End;

Procedure TFrIWUsuario_Enc.Estado_Controles;
Begin
  CONTRASENA.Enabled        := False;
  BTNCODIGO.Visible         :=  (FQRMAESTRO.DS.State In [dsInsert]) And Documento_Activo;
  BTNNOMBRE.Visible         := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNDIRECCION.Visible      := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNEMAIL.Visible          := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNTELEFONO_1.Visible     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNTELEFONO_2.Visible     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCONTRASENA.Visible     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCODIGO_PERFIL.Visible  := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNACTIVO.Visible         := FQRMAESTRO.Mode_Edition And Documento_Activo;
  IWRBOTONDETALLE.Visible   := FQRMAESTRO.ACTIVE And (Not FQRMAESTRO.Mode_Edition) And (FQRMAESTRO.QR.RecordCount > 0);
  DATO.Visible              := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible            := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible            := True;
End;

Procedure TFrIWUsuario_Enc.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
    lbNombre_Activo.Caption := IfThen(FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString = 'S', 'Esta activo', 'No esta activo');
    lbNombre_Perfil.Caption := FCNX.GetValue(gInfo_Tablas[Id_TBL_Perfil].Name, ['CODIGO_PERFIL'], [FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString], ['NOMBRE']);
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUsuario_Enc.SetLabel, ' + E.Message);
    End;
  End;
End;

Function TFrIWUsuario_Enc.Documento_Activo: Boolean;
Begin
  Try
    Result := True;
    // Result := (FQRMAESTRO.RecordCount >= 1) {And (Trim(FQRMAESTRO.FieldByName('ID_ANULADO').AsString) <> 'S')};
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUsuario_Enc.Documento_Activo, ' + E.Message);
    End;
  End;
End;

procedure TFrIWUsuario_Enc.DsDataChangeMaster(pSender: TObject);
begin

  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString + ', '+ FQRMAESTRO.QR.FieldByName('NOMBRE') .AsString + ' ] ';

  SetLabel;

  Try
    If (FCODIGO_ACTUAL <> FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString) And (Not FQRMAESTRO.Mode_Edition) Then
    Begin
      FCODIGO_ACTUAL := FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString;
      AbrirDetalle(Nil, Nil);
    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUsuario_Enc.DsDataChangeMaster, ' + E.Message);
    End;
  End;
end;

Procedure TFrIWUsuario_Enc.DsStateMaster(Sender: TObject);
Begin
  If Not FQRMAESTRO.Active Then
    Exit;

  Estado_Controles;
  If FQRMAESTRO.Mode_Edition Then
    PAGINAS.ActivePage := 1;
  Case FQRMAESTRO.QR.State Of
    dsInsert : Begin
//                 If CODIGO_USUARIO.Enabled Then
//                   CODIGO_USUARIO.SetFocus;
               End;
    dsEdit   : Begin
//                 If NOMBRE.Enabled Then
//                   NOMBRE.SetFocus;
               End;
  End;
End;

Function TFrIWUsuario_Enc.AbrirMaestro(Const pDato: String = ''): Boolean;
Begin
  FGRID_MAESTRO.Caption := gInfo_Tablas[Id_TBL_Usuario].Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.WHERE    := '';
    FQRMAESTRO.SENTENCE := ' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Usuario].Name + FCNX.No_Lock;
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := ' WHERE CODIGO_USUARIO LIKE ' + QuotedStr('%' + Trim(pDato) + '%');
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%');
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_USUARIO ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin
    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUsuario_Enc.AbrirMaestro, ' + E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

Procedure TFrIWUsuario_Enc.AbrirDetalle(Sender: TObject; EventParams: TStringList);
Begin
  GRID_DETALLE.Items.Clear;
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Permiso_App].Name + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' WHERE CODIGO_PERFIL = ' + QuotedStr(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString));
    FCNX.TMP.SQL.Add(' ORDER BY NOMBRE ');
    FCNX.TMP.Active := True;
    If FCNX.TMP.Active Then
    Begin
      FCNX.TMP.First;
      While Not FCNX.TMP.Eof Do
      Begin
        GRID_DETALLE.Items.Add(Trim(FCNX.TMP.FieldByName('NOMBRE').AsString)+ ': ' + IfThen(FCNX.TMP.FieldByName('HABILITA_OPCION').AsString = 'S', 'Habilitado', 'Desactivado'));
        FCNX.TMP.Next;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUsuario_Enc.AbrirDetalle, ' + E.Message);
    End;
  End;
End;


constructor TFrIWUsuario_Enc.Create(AOwner: TComponent; Const pCodigo_Usuario : String);
begin
  Inherited Create(AOwner);
  Try
    Self.FCODIGO_USUARIO := pCodigo_Usuario ;
    If AbrirMaestro(FCODIGO_USUARIO) Then
    Begin
    End
    Else
      Release_Me
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUsuario_Enc.IWAppFormCreate, ' + E.Message);
    End;
  End;
end;

procedure TFrIWUsuario_Enc.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'USUARIO' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  FCNX := UserSession.CNX;
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Codigo'    , Resultado_Codigo    );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Nombre'    , Resultado_Nombre    );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Direccion' , Resultado_Direccion );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Email'     , Resultado_Email     );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Telefono_1', Resultado_Telefono_1);
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Telefono_2', Resultado_Telefono_2);
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Activo'    , Resultado_Activo    );
  FCODIGO_ACTUAL := '';
  FINFO := UserSession.FULL_INFO + gInfo_Tablas[Id_TBL_Usuario].Caption;
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;

    FQRMAESTRO := UserSession.Create_Manager_Data(gInfo_Tablas[Id_TBL_Usuario].Name, gInfo_Tablas[Id_TBL_Usuario].Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;

    CODIGO_USUARIO.DataSource := FQRMAESTRO.DS;
    NOMBRE.DataSource         := FQRMAESTRO.DS;
    DIRECCION.DataSource      := FQRMAESTRO.DS;
    EMAIL.DataSource          := FQRMAESTRO.DS;
    TELEFONO_1.DataSource     := FQRMAESTRO.DS;
    TELEFONO_2.DataSource     := FQRMAESTRO.DS;
    CONTRASENA.DataSource     := FQRMAESTRO.DS;
    CODIGO_PERFIL.DataSource  := FQRMAESTRO.DS;
    CODIGO_PERFIL.DataSource  := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['CODIGO_USUARIO', 'NOMBRE'     ],
                                         ['Usuario'       , 'Nombre'     ],
                                         ['S'             , 'N'          ],
                                         [100             , 550          ],
                                         [taRightJustify  , taLeftJustify]);


    FNAVEGADOR               := TNavegador_ASE.Create(IWRegion_Navegador);
    FNAVEGADOR.Parent        := IWRegion_Navegador;
    FNAVEGADOR.SetNavegador(FQRMAESTRO, WebApplication, FGRID_MAESTRO);
    FNAVEGADOR.ACTION_SEARCH := BTNBUSCARAsyncClick ;
    FNAVEGADOR.ACTION_COPY   := BtnAcarreoAsyncClick;
    FNAVEGADOR.ACTION_EXIT   := BTNBACKAsyncClick   ;
    FNAVEGADOR.Top  := 1;
    FNAVEGADOR.Left := 1;
    IWRegion_Navegador.Width  := FNAVEGADOR.Width  + 1;
    IWRegion_Navegador.Height := FNAVEGADOR.Height + 1;

  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUsuario_Enc.IWAppFormCreate, ' + E.Message);
    End;
  End;
end;

procedure TFrIWUsuario_Enc.IWAppFormDestroy(Sender: TObject);
begin
  Try
    If Assigned(FQRMAESTRO) Then
    Begin
      FQRMAESTRO.Active := False;
      FreeAndNil(FQRMAESTRO);
    End;

    If Assigned(FGRID_MAESTRO) Then
      FreeAndNil(FGRID_MAESTRO);

    If Assigned(FNAVEGADOR) Then
      FreeAndNil(FNAVEGADOR);

  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.IWAppFormDestroy, ' + E.Message);
  End;
end;

procedure TFrIWUsuario_Enc.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString := 'S';
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUsuario_Enc.NewRecordMaster, ' + E.Message);
    End;
  End;
end;

procedure TFrIWUsuario_Enc.BtnAcarreoAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_USUARIO'], [FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString]);
end;


procedure TFrIWUsuario_Enc.BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowConfirm('Esta activo?', Self.Name + '.Resultado_Activo', 'Activo', 'S�', 'No')
end;

procedure TFrIWUsuario_Enc.BTNBACKAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

Procedure TFrIWUsuario_Enc.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_USUARIO']);
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.Localizar_Registro, ' + e.Message);
  End;
End;

procedure TFrIWUsuario_Enc.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Usuario, Localizar_Registro);
    End
    Else
    Begin
      AbrirMaestro(DATO.Text);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdm_Documento.BTNBUSCARAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWUsuario_Enc.BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el nombre del usuario', Self.Name + '.Resultado_Nombre', 'Nombre', FQRMAESTRO.QR.FieldByName('NOMBRE').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.BTNNOMBREAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWUsuario_Enc.BTNTELEFONO_1AsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el telefono 1 ', Self.Name + '.Resultado_Telefono_1', 'Telefono', FQRMAESTRO.QR.FieldByName('TELEFONO_1').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.BTNTELEFONO_1AsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWUsuario_Enc.BTNTELEFONO_2AsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el telefono 2', Self.Name + '.Resultado_Telefono_2', 'Telefono', FQRMAESTRO.QR.FieldByName('TELEFONO_2').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.BTNTELEFONO_2AsyncClick, ' + e.Message);
  End;
end;

Procedure TFrIWUsuario_Enc.BTNCODIGOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese la c�dula del usuario', Self.Name + '.Resultado_Codigo', 'C�dula', FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.BTNCODIGOAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWUsuario_Enc.BTNCODIGO_PERFILAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Perfil, Resultado_Perfil);
end;

procedure TFrIWUsuario_Enc.BTNCONTRASENAAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Cambiar_Password;
end;

procedure TFrIWUsuario_Enc.BTNDIRECCIONAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  ltmp : String;
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      ltmp := FQRMAESTRO.QR.FieldByName('DIRECCION').AsString;
      WebApplication.ShowPrompt('Ingrese la direcci�n', Self.Name + '.Resultado_Direccion', 'Direcci�n', ltmp);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.BTNDIRECCIONAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWUsuario_Enc.BTNEMAILAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el correo electronico', Self.Name + '.Resultado_Email', 'Correo electronico', FQRMAESTRO.QR.FieldByName('EMAIL').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUsuario_Enc.BTNEMAILAsyncClick, ' + e.Message);
  End;
end;


procedure TFrIWUsuario_Enc.BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  UserSession.ShowForm_Perfil_Enc(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString);
end;

end.
