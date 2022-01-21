unit Form_IWArea;

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
  UtilsIW.Busqueda, Form_IWFrame;

type
  TFrIWArea = class(TIWAppForm)
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
    CODIGO_AREA: TIWDBEdit;
    NOMBRE: TIWDBEdit;
    DESCRIPCION: TIWDBMemo;
    ID_ACTIVO: TIWDBCheckBox;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FFRAME : TFrIWFrame;
    FQRMAESTRO : TMANAGER_DATA;
    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
    Procedure Release_Me;

    Function Existe_Area(Const pCODIGO_AREA : String) : Boolean;

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

Procedure TFrIWArea.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_AREAD']);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWArea', 'TFrIWArea.Localizar_Registro', E.Message);
  End;
End;

procedure TFrIWArea.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWArea', 'TFrIWArea.Buscar_Info', E.Message);
  End;
End;

Procedure TFrIWArea.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWArea.Existe_Area(Const pCODIGO_AREA : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(Info_TablaGet(Id_TBL_Area).Name, ['CODIGO_AREA'], [pCODIGO_AREA]);
End;

Procedure TFrIWArea.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje : String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';
    FQRMAESTRO.LAST_ERROR := '';
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CODIGO_AREA.BGColor := UserSession.COLOR_OK;

    If FQRMAESTRO.Mode_Insert And (Not Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString)) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString := Justificar(FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString, '0', FQRMAESTRO.QR.FieldByName('CODIGO_AREA').Size);
      FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString := Copy(FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString, 1, FQRMAESTRO.QR.FieldByName('CODIGO_AREA').Size);
    End;

    If FQRMAESTRO.Mode_Insert And (Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString) Or Existe_Area(FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString)) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Codigo del area no valido o ya existe';
      CODIGO_AREA.BGColor := UserSession.COLOR_ERROR;
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWArea', 'TFrIWArea_Enc.Validar_Campos_Master', E.Message);
  End;
End;

Procedure TFrIWArea.Estado_Controles;
Begin
  CODIGO_AREA.Enabled  := FQRMAESTRO.Mode_Insert  And Documento_Activo;
  NOMBRE.Enabled       := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DESCRIPCION.Editable := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Enabled    := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DATO.Visible        := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible      := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible      := True;
End;

Procedure TFrIWArea.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWArea', 'TFrIWArea.SetLabel', E.Message);
    End;
  End;
End;

Function TFrIWArea.Documento_Activo : Boolean;
Begin
  Try
    Result := True;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWArea', 'TFrIWArea.Documento_Activo', E.Message);
    End;
  End;
End;

procedure TFrIWArea.DsDataChangeMaster(pSender: TObject);
begin
  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString + ',' + FQRMAESTRO.QR.FieldByName('NOMBRE').AsString + ' ] ';

  SetLabel;
  Try
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWArea', 'TFrIWArea.DsDataChangeMaster', E.Message);
    End;
  End;
end;

Procedure TFrIWArea.DsStateMaster(pSender: TObject);
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

Function TFrIWArea.AbrirMaestro(Const pDato : String = '') : Boolean;
Begin
  FGRID_MAESTRO.Caption := Info_TablaGet(Id_TBL_Area).Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.SENTENCE := ' SELECT ' + FCNX.Top_Sentence(Const_Max_Record) + ' * FROM ' + Info_TablaGet(Id_TBL_Area).Name + ' ';
    FQRMAESTRO.WHERE := '';
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := ' WHERE CODIGO_AREA LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_AREA ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin

    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWArea', 'TFrIWArea.AbrirMaestro', E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

procedure TFrIWArea.IWAppFormCreate(Sender: TObject);
Var
  lI : Integer;
begin
  FINFO := UserSession.FULL_INFO + Info_TablaGet(Id_TBL_Area).Caption;
  Randomize;
  Self.Name := 'TFrIWArea' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000) );
  FCNX := UserSession.CNX;
  FFRAME := TFrIWFrame.Create(Self);
  FFRAME.Parent := Self;

  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;

    FQRMAESTRO := UserSession.Create_Manager_Data(Info_TablaGet(Id_TBL_Area).Name, Info_TablaGet(Id_TBL_Area).Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;

    CODIGO_AREA.DataSource := FQRMAESTRO.DS;
    NOMBRE.DataSource               := FQRMAESTRO.DS;
    DESCRIPCION.DataSource          := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['CODIGO_AREA' , 'NOMBRE'     ],
                                         ['Código'      , 'Nombre'     ],
                                         ['S'           , 'N'          ],
                                         [100           , 550          ],
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWArea', 'TFrIWArea_Enc.IWAppFormCreate', E.Message);
    End;
  End;
end;

procedure TFrIWArea.IWAppFormDestroy(Sender: TObject);
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

    If Assigned(FFRAME) Then
      FreeAndNil(FFRAME);

  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWArea', 'TFrIWArea_Enc.IWAppFormDestroy', E.Message);
  End;
end;

procedure TFrIWArea.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString := FCNX.Next(Info_TablaGet(Id_TBL_Area).Name, '0', ['CODIGO_AREA'], [],[], FQRMAESTRO.QR.FieldByName('CODIGO_AREA').Size);
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO'  ).AsString := 'S';
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWArea', 'TFrIWArea.NewRecordMaster', E.Message);
    End;
  End;
End;

procedure TFrIWArea.BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_AREA'], [FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString]);
end;

Procedure TFrIWArea.BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition  Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

procedure TFrIWArea.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Area, Localizar_Registro)
    End
    Else
    Begin
      AbrirMaestro(DATO.Text);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWArea', 'TFrIWArea.BTNBUSCARAsyncClick', E.Message);
  End;
end;

end.
