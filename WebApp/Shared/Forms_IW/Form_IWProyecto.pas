unit Form_IWProyecto;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompExtCtrls, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  IWCompTabControl, IWCompJQueryWidget, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, UtConexion, Data.DB, IWCompGrids, IWDBStdCtrls,
  IWCompEdit, IWCompCheckbox, IWCompMemo, IWDBExtCtrls, IWCompButton,
  IWCompListbox, IWCompGradButton, UtGrid_JQ, UtNavegador_ASE,
  UtilsIW.Busqueda;

type
  TFrIWProyecto = class(TIWAppForm)
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
    IWLabel2: TIWLabel;
    IWRegion_Navegador: TIWRegion;
    IWModalWindow1: TIWModalWindow;
    IWLabel3: TIWLabel;
    IWLabel4: TIWLabel;
    CODIGO_PROYECTO: TIWDBEdit;
    NOMBRE: TIWDBEdit;
    DESCRIPCION: TIWDBMemo;
    FECHA_INICIAL: TIWDBEdit;
    FECHA_FINAL: TIWDBEdit;
    ID_ACTIVO: TIWDBCheckBox;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FQRMAESTRO : TMANAGER_DATA;
    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
    Procedure Release_Me;

    Function Existe_Proyecto(Const pCODIGO_PROYECTO : String) : Boolean;

    Procedure Validar_Campos_Master(pSender: TObject);
    procedure NewRecordMaster(pSender: TObject);

    Function Documento_Activo : Boolean;

    Procedure DsDataChangeMaster(pSender: TObject);
    Procedure DsStateMaster(pSender: TObject);

    Procedure SetLabel;
    Procedure Estado_Controles;
    Function AbrirMaestro(Const pDato : String = '') : Boolean;
  public
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
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Procedure TFrIWProyecto.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_PROYECTOD']);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProyecto', 'TFrIWProyecto.Localizar_Registro', E.Message);
  End;
End;

procedure TFrIWProyecto.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProyecto', 'TFrIWProyecto.Buscar_Info', E.Message);
  End;
End;

Procedure TFrIWProyecto.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWProyecto.Existe_Proyecto(Const pCODIGO_PROYECTO : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(Info_TablaGet(Id_TBL_Proyecto).Name, ['CODIGO_PROYECTO'], [pCODIGO_PROYECTO]);
End;

Procedure TFrIWProyecto.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje : String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';
    FQRMAESTRO.LAST_ERROR := '';
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CODIGO_PROYECTO.BGColor := UserSession.COLOR_OK;

    If FQRMAESTRO.Mode_Insert And (Not Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString)) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString := Justificar(FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString, '0', FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').Size);
      FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString := Copy(FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString, 1, FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').Size);
    End;

    If FQRMAESTRO.Mode_Insert And (Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString) Or Existe_Proyecto(FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString)) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Codigo del Proyecto no valido o ya existe';
      CODIGO_PROYECTO.BGColor := UserSession.COLOR_ERROR;
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProyecto', 'TFrIWProyecto_Enc.Validar_Campos_Master', E.Message);
  End;
End;

Procedure TFrIWProyecto.Estado_Controles;
Begin
  CODIGO_PROYECTO.Enabled  := FQRMAESTRO.Mode_Insert  And Documento_Activo;
  NOMBRE.Enabled           := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DESCRIPCION.Enabled      := FQRMAESTRO.Mode_Edition And Documento_Activo;
  FECHA_INICIAL.Enabled    := FQRMAESTRO.Mode_Edition And Documento_Activo;
  FECHA_FINAL.Enabled      := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Enabled        := FQRMAESTRO.Mode_Edition And Documento_Activo;

  CODIGO_PROYECTO.Editable := FQRMAESTRO.Mode_Insert  And Documento_Activo;
  NOMBRE.Editable          := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DESCRIPCION.Editable     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  FECHA_INICIAL.Editable   := FQRMAESTRO.Mode_Edition And Documento_Activo;
  FECHA_FINAL.Editable     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Editable       := FQRMAESTRO.Mode_Edition And Documento_Activo;

  DATO.Visible            := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible          := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible          := True;
End;

Procedure TFrIWProyecto.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try

  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProyecto', 'TFrIWProyecto.SetLabel', E.Message);
    End;
  End;
End;

Function TFrIWProyecto.Documento_Activo : Boolean;
Begin
  Try
    Result := True;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProyecto', 'TFrIWProyecto.Documento_Activo', E.Message);
    End;
  End;
End;

procedure TFrIWProyecto.DsDataChangeMaster(pSender: TObject);
begin
  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString + ',' + FQRMAESTRO.QR.FieldByName('NOMBRE').AsString + ' ] ';
  Self.Title := Info_TablaGet(Id_TBL_Proyecto).Caption + ', ' + lbInfo.Caption;
  SetLabel;
  Try
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProyecto', 'TFrIWProyecto.DsDataChangeMaster', E.Message);
    End;
  End;
end;

Procedure TFrIWProyecto.DsStateMaster(pSender: TObject);
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Estado_Controles;
  If FQRMAESTRO.Mode_Edition Then
    PAGINAS.ActivePage := 1;
  Case FQRMAESTRO.DS.State Of
    dsInsert : Begin
               End;
    dsEdit   : Begin
               End;
  End;
End;

Function TFrIWProyecto.AbrirMaestro(Const pDato : String = '') : Boolean;
Begin
  FGRID_MAESTRO.Caption := Info_TablaGet(Id_TBL_Proyecto).Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.SENTENCE := ' SELECT ' + FCNX.Top_Sentence(Const_Max_Record) + ' * FROM ' + Info_TablaGet(Id_TBL_Proyecto).Name + ' ';
    FQRMAESTRO.WHERE := '';
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := ' WHERE CODIGO_PROYECTO LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_PROYECTO ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin

    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProyecto', 'TFrIWProyecto.AbrirMaestro', E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

procedure TFrIWProyecto.IWAppFormCreate(Sender: TObject);
Var
  lI : Integer;
begin
  FINFO := UserSession.FULL_INFO + Info_TablaGet(Id_TBL_Proyecto).Caption;
  Randomize;
  Self.Name := 'TFrIWProyecto' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000) );
  Self.Title := Info_TablaGet(Id_TBL_Proyecto).Caption;
  FCNX := UserSession.CNX;
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;


    FQRMAESTRO := UserSession.Create_Manager_Data(Info_TablaGet(Id_TBL_Proyecto).Name, Info_TablaGet(Id_TBL_Proyecto).Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;

    CODIGO_PROYECTO.DataSource := FQRMAESTRO.DS;
    NOMBRE.DataSource          := FQRMAESTRO.DS;
    DESCRIPCION.DataSource     := FQRMAESTRO.DS;
    FECHA_INICIAL.DataSource   := FQRMAESTRO.DS;
    FECHA_FINAL.DataSource     := FQRMAESTRO.DS;
    ID_ACTIVO.DataSource       := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['CODIGO_PROYECTO', 'NOMBRE'     ],
                                         ['Código'         , 'Nombre'     ],
                                         ['S'              , 'N'          ],
                                         [100              , 550          ],
                                         [taRightJustify, taLeftJustify]);

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

    If AbrirMaestro Then
    Begin
    End
    Else
      Release_Me
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProyecto', 'TFrIWProyecto_Enc.IWAppFormCreate', E.Message);
    End;
  End;
end;

procedure TFrIWProyecto.IWAppFormDestroy(Sender: TObject);
begin
  Try
    If Assigned(FQRMAESTRO) Then
    Begin
      FQRMAESTRO.Active := False;
      FreeAndNil(FQRMAESTRO);
    End;

    If Assigned(FNAVEGADOR) Then
      FreeAndNil(FNAVEGADOR);

    If Assigned(FGRID_MAESTRO) Then
      FreeAndNil(FGRID_MAESTRO);

  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProyecto', 'TFrIWProyecto_Enc.IWAppFormDestroy', E.Message);
  End;
end;

procedure TFrIWProyecto.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString := FCNX.Next(Info_TablaGet(Id_TBL_Proyecto).Name, '0', ['CODIGO_PROYECTO'], [],[], FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').Size);
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO'  ).AsString := 'S';
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProyecto', 'TFrIWProyecto.NewRecordMaster', E.Message);
    End;
  End;
End;

procedure TFrIWProyecto.BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_PROYECTO'], [FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString]);
end;

Procedure TFrIWProyecto.BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition  Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

procedure TFrIWProyecto.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Proyecto, Localizar_Registro)
    End
    Else
    Begin
      AbrirMaestro(DATO.Text);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProyecto', 'TFrIWProyecto.BTNBUSCARAsyncClick', E.Message);
  End;
end;

end.
