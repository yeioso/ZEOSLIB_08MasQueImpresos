unit Form_IWUnidad_Medida;

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
  TFrIWUnidad_Medida = class(TIWAppForm)
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
    DESCRIPCION: TIWDBMemo;
    BTNNOMBRE: TIWImage;
    NOMBRE: TIWDBLabel;
    CODIGO_UNIDAD_MEDIDA: TIWDBLabel;
    BTNCODIGO: TIWImage;
    BTNDESCRIPCION: TIWImage;
    BTNACTIVO: TIWImage;
    lbNombre_Activo: TIWLabel;
    IWRegion_Navegador: TIWRegion;
    IWModalWindow1: TIWModalWindow;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure CODIGO_UNIDAD_MEDIDAAsyncExit(Sender: TObject;  EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNDESCRIPCIONAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FQRMAESTRO : TMANAGER_DATA;
    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
    Procedure Release_Me;

    Function Existe_Unidad_Medida(Const pCODIGO_UNIDAD_MEDIDA : String) : Boolean;

    Procedure Validar_Campos_Master(pSender: TObject);
    procedure NewRecordMaster(pSender: TObject);

    procedure Resultado_Codigo(EventParams: TStringList);
    procedure Resultado_Nombre(EventParams: TStringList);
    procedure Resultado_Descripcion(EventParams: TStringList);
    procedure Resultado_Activo(EventParams: TStringList);

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
  UtLog,
  UtFecha,
  Variants,
  UtFuncion,
  Vcl.Graphics,
  Winapi.Windows,
  System.UITypes,
  System.StrUtils,
  ServerController,
  TBL000.Info_Tabla;

Procedure TFrIWUnidad_Medida.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_UNIDAD_MEDIDA']);
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUnidad_Medida.Localizar_Registro, ' + e.Message);
  End;
End;

procedure TFrIWUnidad_Medida.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
Var
  lBusqueda : TBusqueda_Ercol_WjQDBGrid;
begin
  Try
    lBusqueda := TBusqueda_Ercol_WjQDBGrid.Create(Self);
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
      UtLog_Execute('TFrIWUnidad_Medida.Buscar_Info, ' + e.Message);
  End;
End;

Procedure TFrIWUnidad_Medida.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWUnidad_Medida.Existe_Unidad_Medida(Const pCODIGO_UNIDAD_MEDIDA : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(gInfo_Tablas[Id_TBL_Unidad_Medida].Name, ['CODIGO_UNIDAD_MEDIDA'], [pCODIGO_UNIDAD_MEDIDA]);
End;

procedure TFrIWUnidad_Medida.Resultado_Codigo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString := Justificar(EventParams.Values['InputStr'], '0', FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').Size);
      FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString := AnsiUpperCase(FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUnidad_Medida.Resultado_Codigo, ' + e.Message);
  End;
End;

procedure TFrIWUnidad_Medida.Resultado_Nombre(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('NOMBRE').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUnidad_Medida.Resultado_Nombre, ' + e.Message);
  End;
End;

procedure TFrIWUnidad_Medida.Resultado_Descripcion(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('DESCRIPCION').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUnidad_Medida.Resultado_Descripcion, ' + e.Message);
  End;
End;

procedure TFrIWUnidad_Medida.Resultado_Activo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
      FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString := IfThen(Result_Is_OK(EventParams.Values['RetValue']), 'S', 'N');
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUnidad_Medida.Resultado_Activo, ' + E.Message);
  End;
End;


Procedure TFrIWUnidad_Medida.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje : String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';
    FQRMAESTRO.LAST_ERROR := '';
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CODIGO_UNIDAD_MEDIDA.BGColor := UserSession.COLOR_OK;

    If BTNCODIGO.Visible And (Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString) Or Existe_Unidad_Medida(FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString)) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Codigo de Unidad_Medida no valido o ya existe';
      CODIGO_UNIDAD_MEDIDA.BGColor := UserSession.COLOR_ERROR;
    End;

    If BTNNOMBRE.Visible And Vacio(FQRMAESTRO.QR.FieldByName('NOMBRE').AsString) Then
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
      UtLog_Execute('TFrIWUnidad_Medida_Enc.Validar_Campos_Master, ' + E.Message);
  End;
End;

procedure TFrIWUnidad_Medida.CODIGO_UNIDAD_MEDIDAAsyncExit(Sender: TObject;  EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition And (Not Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString)) Then
    FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString := Justificar(FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString, '0', FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').Size);
end;

Procedure TFrIWUnidad_Medida.Estado_Controles;
Begin
  BTNCODIGO.Visible      := (FQRMAESTRO.DS.State In [dsInsert]) And Documento_Activo;
  BTNNOMBRE.Visible      := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNDESCRIPCION.Visible := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNACTIVO.Visible      := FQRMAESTRO.Mode_Edition And Documento_Activo;
//BtnAcarreo.Visible     := FQRMAESTRO.Active And (Not FQRMAESTRO.Mode_Edition) And (FQRMAESTRO.QR.RecordCount > 0);
  DATO.Visible           := (Not FQRMAESTRO.Mode_Edition);
//BTNBUSCAR.Visible      := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible         := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible         := True;
End;

Procedure TFrIWUnidad_Medida.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
    lbNombre_Activo.Caption := IfThen(FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString = 'S', 'Unidad_Medida activo', 'Unidad_Medida inactivo');
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUnidad_Medida.SetLabel, ' + E.Message);
    End;
  End;
End;

Function TFrIWUnidad_Medida.Documento_Activo : Boolean;
Begin
  Try
    Result := True;
    //Result := (FQRMAESTRO.RecordCount >= 1) {And (Trim(FQRMAESTRO.FieldByName('ID_ANULADO').AsString) <> 'S')};
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUnidad_Medida.Documento_Activo, ' + E.Message);
    End;
  End;
End;

procedure TFrIWUnidad_Medida.DsDataChangeMaster(pSender: TObject);
begin
  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString + ',' + FQRMAESTRO.QR.FieldByName('NOMBRE').AsString + ' ] ';

  SetLabel;
  Try
//    If FQRMAESTRO.Mode_Edition Then
//      Prellenar_Informacion_Master(Nil, Nil);
//    If FNEW_RECORD And Modo_Edicion_Master Then
//      UserSession.PutInfoData(FQRMAESTRO);
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUnidad_Medida.DsDataChangeMaster, ' + E.Message);
    End;
  End;
end;

Procedure TFrIWUnidad_Medida.DsStateMaster(pSender: TObject);
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Estado_Controles;
  If FQRMAESTRO.Mode_Edition Then
    PAGINAS.ActivePage := 1;
  Case FQRMAESTRO.DS.State Of
    dsInsert : Begin
//                 If CODIGO_UNIDAD_MEDIDA.Enabled Then
//                   CODIGO_UNIDAD_MEDIDA.SetFocus;
               End;
    dsEdit   : Begin
//                 If NOMBRE.Enabled Then
//                   NOMBRE.SetFocus;
               End;
  End;
End;

Function TFrIWUnidad_Medida.AbrirMaestro(Const pDato : String = '') : Boolean;
Begin
  FGRID_MAESTRO.Caption := gInfo_Tablas[Id_TBL_Unidad_Medida].Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.SENTENCE := ' SELECT ' + FCNX.Top_Sentence(Const_Max_Record) + ' * FROM ' + gInfo_Tablas[Id_TBL_Unidad_Medida].Name + ' ';
    FQRMAESTRO.WHERE := '';
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := ' WHERE CODIGO_UNIDAD_MEDIDA LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_UNIDAD_MEDIDA ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin

    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUnidad_Medida.AbrirMaestro, ' + E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

procedure TFrIWUnidad_Medida.IWAppFormCreate(Sender: TObject);
Var
  lI : Integer;
begin
  FINFO := UserSession.FULL_INFO + gInfo_Tablas[Id_TBL_Unidad_Medida].Caption;
  Randomize;
  Self.Name := gInfo_Tablas[Id_TBL_Unidad_Medida].Name + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000) );
  FCNX := UserSession.CNX;
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Codigo'     , Resultado_Codigo     );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Nombre'     , Resultado_Nombre     );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Descripcion', Resultado_Descripcion);
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Activo'     , Resultado_Activo     );
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;


    FQRMAESTRO := UserSession.Create_Manager_Data(gInfo_Tablas[Id_TBL_Unidad_Medida].Name, gInfo_Tablas[Id_TBL_Unidad_Medida].Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;

    CODIGO_UNIDAD_MEDIDA.DataSource := FQRMAESTRO.DS;
    NOMBRE.DataSource               := FQRMAESTRO.DS;
    DESCRIPCION.DataSource          := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['CODIGO_UNIDAD_MEDIDA' , 'NOMBRE'     ],
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
      UtLog_Execute('TFrIWUnidad_Medida_Enc.IWAppFormCreate, ' + E.Message);
    End;
  End;
end;

procedure TFrIWUnidad_Medida.IWAppFormDestroy(Sender: TObject);
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
      UtLog_Execute('TFrIWUnidad_Medida_Enc.IWAppFormDestroy, ' + e.Message);
  End;
end;

procedure TFrIWUnidad_Medida.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString := FCNX.Next(gInfo_Tablas[Id_TBL_Unidad_Medida].Name, '0', ['CODIGO_UNIDAD_MEDIDA'], [],[], FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').Size);
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO'  ).AsString := 'S';
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWUnidad_Medida.NewRecordMaster, ' + E.Message);
    End;
  End;
End;

procedure TFrIWUnidad_Medida.BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_UNIDAD_MEDIDA'], [FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString]);
//  If Not FQRMAESTRO.ACARREO Then
//    BtnAcarreo.Caption := 'Acarreo Inactivo'
//  Else
//    BtnAcarreo.Caption := 'Acarreo Activo';
end;

procedure TFrIWUnidad_Medida.BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowConfirm('Está seguro(a) de activar el registro?', Self.Name + '.Resultado_Activo', 'Activar', 'Sí', 'No')
end;

Procedure TFrIWUnidad_Medida.BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition  Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

procedure TFrIWUnidad_Medida.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Unidad_Medida, Localizar_Registro)
    End
    Else
    Begin
      AbrirMaestro(DATO.Text);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.BTNBUSCARAsyncClick, ' + e.Message);
  End;
//AbrirMaestro(DATO.Text);
end;

procedure TFrIWUnidad_Medida.BTNCODIGOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el codigo del Unidad_Medida', Self.Name + '.Resultado_Codigo', 'Unidad de Medida', FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUnidad_Medida.BTNCODIGOAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWUnidad_Medida.BTNDESCRIPCIONAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  ltmp : String;
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      ltmp := FQRMAESTRO.QR.FieldByName('DESCRIPCION').AsString;
      WebApplication.ShowPrompt('Ingrese la descripción', Self.Name + '.Resultado_Descripcion', 'Descripción', ltmp);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUnidad_Medida.BTNDESCRIPCIONAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWUnidad_Medida.BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el nombre del Unidad_Medida', Self.Name + '.Resultado_Nombre', 'Nombre', FQRMAESTRO.QR.FieldByName('NOMBRE').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWUnidad_Medida.BTNNOMBREAsyncClick, ' + e.Message);
  End;
end;

end.
