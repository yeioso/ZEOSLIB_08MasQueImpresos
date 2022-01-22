unit Form_IWPerfil_Enc;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompExtCtrls, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  IWCompTabControl, IWCompJQueryWidget, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, UtConexion, Data.DB, IWCompGrids, IWDBStdCtrls,
  IWCompEdit, IWCompCheckbox, IWCompMemo, IWDBExtCtrls, IWCompButton,
  IWCompListbox, IWCompGradButton, UtGrid_JQ, UtNavegador_ASE, Form_IWFrame;

type
  TFrIWPerfil_Enc = class(TIWAppForm)
    RINFO: TIWRegion;
    lbInfo: TIWLabel;
    IWRegion1: TIWRegion;
    PAGINAS: TIWTabControl;
    PAG_00: TIWTabPage;
    PAG_01: TIWTabPage;
    RNAVEGADOR: TIWRegion;
    DATO: TIWEdit;
    IWLabel1: TIWLabel;
    IWLabel8: TIWLabel;
    IWRegion_Navegador: TIWRegion;
    IWModalWindow1: TIWModalWindow;
    CODIGO_PERFIL: TIWDBEdit;
    NOMBRE: TIWDBEdit;
    IWRDETALLE: TIWRegion;
    DETALLE_PERFIL: TIWListbox;
    IWRBOTONDETALLE: TIWRegion;
    BtnGrid: TIWImage;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormShow(Sender: TObject);
  private
    FCNX : TConexion;
    FINFO : String;
    FFRAME : TFrIWFrame;
    FQRMAESTRO : TMANAGER_DATA;

    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    FQRDETALLE : TMANAGER_DATA;

    FCODIGO_ACTUAL : String;
    FCODIGO_PERFIL : String;

    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);

    Procedure Release_Me;

    Function Existe_Perfil(Const pCodigo_Perfil : String) : Boolean;

    Procedure Validar_Campos_Master (pSender: TObject);
    Function Documento_Activo : Boolean;

    Procedure NewRecordMaster(pSender: TObject);
    Procedure DsDataChangeMaster(pSender: TObject);
    Procedure DsStateMaster(pSender: TObject);

    Procedure SetLabel;
    Procedure Estado_Controles;
    Function AbrirMaestro(Const pDato : String = '') : Boolean;
    Function AbrirDetalle(Const pCodigo_Perfil : String) : Boolean;
  public
    Constructor Create(AOwner: TComponent; Const pCodigo_Perfil : String);
  end;


implementation
{$R *.dfm}
Uses
  Math,
  UtFecha,
  Variants,
  UtFuncion,
  Vcl.Graphics,
  Winapi.Windows,
  System.UITypes,
  System.StrUtils,
  ServerController,
  UtilsIW.Busqueda,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Procedure TFrIWPerfil_Enc.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWPerfil_Enc.Existe_Perfil(Const pCodigo_Perfil : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(Info_TablaGet(Id_TBL_Perfil).Name, ['CODIGO_PERFIL'], [pCodigo_Perfil]);
End;

Procedure  TFrIWPerfil_Enc.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje : String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CODIGO_PERFIL.BGColor := UserSession.COLOR_OK;
    If FQRMAESTRO.Mode_Insert And (Not Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString))  Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString := Justificar(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString, '0', FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').Size);
      FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString := Copy(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString, 01, FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').Size);
    End;

    If FQRMAESTRO.Mode_Insert And (Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString) Or Existe_Perfil(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString)) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Perfil invalido';
      CODIGO_PERFIL.BGColor := UserSession.COLOR_ERROR;
    End;

    If FQRMAESTRO.Mode_Edition And Vacio(FQRMAESTRO.QR.FieldByName('NOMBRE').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Nombre invalido';
      NOMBRE.BGColor := UserSession.COLOR_ERROR;
    End;

    FQRMAESTRO.ERROR := IfThen(Vacio(lMensaje), 0, -1);
    If FQRMAESTRO.ERROR <> 0 Then
    Begin
      FQRMAESTRO.LAST_ERROR := 'Datos invalidos, ' + lMensaje;
      UserSession.SetMessage(FQRMAESTRO.LAST_ERROR, True);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWPerfil_Enc.Validar_Campos_Master', E.Message);
  End;
End;

Procedure TFrIWPerfil_Enc.Estado_Controles;
Begin
  CODIGO_PERFIL.Enabled := FQRMAESTRO.Mode_Insert  And Documento_Activo;
  NOMBRE.Enabled        := FQRMAESTRO.Mode_Edition And Documento_Activo;

  IWRBOTONDETALLE.Visible := FQRMAESTRO.Active And (Not FQRMAESTRO.Mode_Edition) And (FQRMAESTRO.QR.RecordCount >= 1);

  DATO.Visible            := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible          := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible          := True;

End;

Procedure TFrIWPerfil_Enc.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try

  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWPerfil_Enc.SetLabel', E.Message);
    End;
  End;
End;

Function TFrIWPerfil_Enc.Documento_Activo : Boolean;
Begin
  Try
    Result := True;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWPerfil_Enc.Documento_Activo', E.Message);
    End;
  End;
End;

procedure TFrIWPerfil_Enc.DsDataChangeMaster(pSender: TObject);
Var
  lNumero_Documento : String;
begin
  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString + ', ' + FQRMAESTRO.QR.FieldByName('NOMBRE').AsString + ' ] ';

  Self.Title := Info_TablaGet(Id_TBL_Perfil).Caption + ', ' + lbInfo.Caption;
  SetLabel;

  Try
    If (FCODIGO_ACTUAL <> FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString) And (Not FQRMAESTRO.Mode_Edition) Then
    Begin
      FCODIGO_ACTUAL := FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString;
      AbrirDetalle(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString);
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWPerfil_Enc.DsDataChangeMaster', E.Message);
    End;
  End;
end;

Procedure TFrIWPerfil_Enc.DsStateMaster(pSender: TObject);
Begin
  Estado_Controles;
  If FQRMAESTRO.Mode_Edition Then
    PAGINAS.ActivePage := 1;
  Case FQRMAESTRO.DS.State Of
    dsInsert : Begin
//                 If CODIGO_PERFIL.Enabled Then
//                   CODIGO_PERFIL.SetFocus;
               End;
    dsEdit   : Begin
//                 If NOMBRE.Enabled Then
//                   NOMBRE.SetFocus;
               End;
  End;
End;


Function TFrIWPerfil_Enc.AbrirMaestro(Const pDato : String = '') : Boolean;
Begin
  FGRID_MAESTRO.Caption := Info_TablaGet(Id_TBL_Perfil).Caption;
  Result := False;
//  GRID_MAESTRO.Visible := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.SENTENCE := ' SELECT * FROM ' + Info_TablaGet(Id_TBL_Perfil).Name + ' '+ FCNX.No_Lock;
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := '  WHERE CODIGO_PERFIL LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE +  '  OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_PERFIL ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin

    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWPerfil_Enc.AbrirMaestro', E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

Function TFrIWPerfil_Enc.AbrirDetalle(Const pCodigo_Perfil : String) : Boolean;
Begin
//  GRID_DETALLE.Caption := Retornar_Info_Tabla(Id_Permiso_App).Caption;
  Result := False;
//  GRID_DETALLE.Visible := False;
  DETALLE_PERFIL.Items.Clear;
  Try
    FQRDETALLE.Active := False;
    FQRDETALLE.SENTENCE := ' SELECT * FROM ' + Info_TablaGet(Id_TBL_Perfil).Name + ' ' + FCNX.No_Lock;
    FQRDETALLE.WHERE    := ' WHERE ' + FCNX.Trim_Sentence('CODIGO_PERFIL') +' = ' + QuotedStr(Trim(pCodigo_Perfil));
    FQRDETALLE.Active := True;
    Result := FQRDETALLE.Active;
    If Result Then
    Begin
      FQRDETALLE.QR.First;
      While Not FQRDETALLE.QR.Eof Do
      Begin
        DETALLE_PERFIL.Items.Add(FQRDETALLE.QR.FieldByName('NOMBRE').AsString);
        FQRDETALLE.QR.Next;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWPerfil_Enc.AbrirDetalle', E.Message);
    End;
  End;
End;

constructor TFrIWPerfil_Enc.Create(AOwner: TComponent; Const pCodigo_Perfil : String);
begin
  Inherited Create(AOwner);
  Try
    Self.FCODIGO_PERFIL := pCodigo_Perfil ;
    If AbrirMaestro(FCODIGO_PERFIL) Then
    Begin
    End
    Else
      Release_Me
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWUsuario_Enc.IWAppFormCreate', E.Message);
    End;
  End;
end;

procedure TFrIWPerfil_Enc.IWAppFormCreate(Sender: TObject);
Var
  lI : Integer;
begin
  Randomize;
  Self.Name := 'TFrIWPerfil_Enc' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  FCNX := UserSession.CNX;
  Self.Title := Info_TablaGet(Id_TBL_Perfil).Caption + ', ' + lbInfo.Caption;
  FFRAME := TFrIWFrame.Create(Self);
  FFRAME.Parent := Self;
  FCODIGO_ACTUAL := '';
  FCODIGO_PERFIL := '';

  FINFO := UserSession.FULL_INFO + Info_TablaGet(Id_TBL_Perfil).Caption;
  Try

    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;

    FQRMAESTRO := UserSession.Create_Manager_Data(Info_TablaGet(Id_TBL_Perfil).Name, Info_TablaGet(Id_TBL_Perfil).Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;

    FQRDETALLE := UserSession.Create_Manager_Data(Info_TablaGet(Id_TBL_Permiso_App).Name, Info_TablaGet(Id_TBL_Permiso_App).Caption);

    CODIGO_PERFIL.DataSource := FQRMAESTRO.DS;
    NOMBRE.DataSource        := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['CODIGO_PERFIL' , 'NOMBRE'     ],
                                         ['Perfil'        , 'Nombre'     ],
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWPerfil_Enc.IWAppFormCreate', E.Message);
    End;
  End;
end;

procedure TFrIWPerfil_Enc.IWAppFormDestroy(Sender: TObject);
begin
    Try
      UserSession.SetAmbiente;
      If Assigned(FQRDETALLE) Then
      Begin
        FQRDETALLE.Active := False;
        FreeAndNil(FQRDETALLE);
      End;

      If Assigned(FQRMAESTRO) Then
      Begin
        FQRMAESTRO.Active := False;
        FreeAndNil(FQRMAESTRO);
      End;

      If Assigned(FNAVEGADOR) Then
        FreeAndNil(FNAVEGADOR);

      If Assigned(FGRID_MAESTRO) Then
        FreeAndNil(FGRID_MAESTRO);

    If Assigned(FFRAME) Then
      FreeAndNil(FFRAME);

    Except
      On E: Exception Do
        Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWPerfil_Enc.IWAppFormDestroy', E.Message);
    End;
end;

procedure TFrIWPerfil_Enc.IWAppFormShow(Sender: TObject);
begin
  If Assigned(FFRAME) Then
    FFRAME.Sincronizar_Informacion;
end;

procedure TFrIWPerfil_Enc.NewRecordMaster(pSender: TObject);
begin
  Try
    FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL' ).AsString := FCNX.Next(Info_TablaGet(Id_TBL_Perfil).Name, '0', ['CODIGO_PERFIL'], [],[], FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').Size);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWPerfil_Enc.NewRecordMaster', E.Message);
    End;
  End;
end;

procedure TFrIWPerfil_Enc.BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_PERFIL'], [FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString]);
end;


procedure TFrIWPerfil_Enc.BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

Procedure TFrIWPerfil_Enc.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_PERFIL']);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWPerfil_Enc.Localizar_Registro', E.Message);
  End;
End;

procedure TFrIWPerfil_Enc.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
Var
  lBusqueda : TBusqueda_MQI_WjQDBGrid;
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      lBusqueda := TBusqueda_MQI_WjQDBGrid.Create(Self);
      lBusqueda.Parent := Self;
      lBusqueda.SetComponents(FCNX, Localizar_Registro);
      lBusqueda.SetTSD(Id_TBL_Perfil);
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
    End
    Else
    Begin
      AbrirMaestro(DATO.Text);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWPerfil_Enc', 'TFrIWPerfil_Enc.BTNBUSCARAsyncClick', E.Message);
  End;
end;

procedure TFrIWPerfil_Enc.BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  UserSession.ShowForm_Perfil_Permiso(CODIGO_PERFIL.Text);
  Release_Me;
end;

end.