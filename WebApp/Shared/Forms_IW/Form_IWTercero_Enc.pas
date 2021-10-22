unit Form_IWTercero_Enc;

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
  TFrIWTercero_Enc = class(TIWAppForm)
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
    IWModalWindow1: TIWModalWindow;
    BTNCODIGO: TIWImage;
    CODIGO_TERCERO: TIWDBLabel;
    BTNNOMBRE: TIWImage;
    NOMBRE: TIWDBLabel;
    BTNCONTACTO: TIWImage;
    CONTACTO: TIWDBLabel;
    BTNEMAIL: TIWImage;
    EMAIL: TIWDBLabel;
    TELEFONO_1: TIWDBLabel;
    TELEFONO_2: TIWDBLabel;
    BTNTELEFONO_2: TIWImage;
    BTNTELEFONO_1: TIWImage;
    lbNombre_Id_Activo: TIWLabel;
    BTNACTIVO: TIWImage;
    IWRegion_Navegador: TIWRegion;
    BTNCLIENTE: TIWImage;
    lbNombre_Id_Cliente: TIWLabel;
    BTNPROVEEDOR: TIWImage;
    lbNombre_Id_Proveedor: TIWLabel;
    IWLabel6: TIWLabel;
    BTNDIRECCION: TIWImage;
    DIRECCION: TIWDBLabel;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCONTACTOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEMAILAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNTELEFONO_1AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNTELEFONO_2AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PERFILAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCLIENTEAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNPROVEEDORAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNDIRECCIONAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;

    FQRMAESTRO : TMANAGER_DATA;

    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    FCODIGO_ACTUAL : String;

    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Perfil(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);

    procedure Resultado_Codigo(EventParams: TStringList);
    procedure Resultado_Nombre(EventParams: TStringList);
    procedure Resultado_Contacto(EventParams: TStringList);
    procedure Resultado_Direccion(EventParams: TStringList);
    procedure Resultado_Email(EventParams: TStringList);
    procedure Resultado_Telefono_1(EventParams: TStringList);
    procedure Resultado_Telefono_2(EventParams: TStringList);
    procedure Resultado_Id_Activo(EventParams: TStringList);
    procedure Resultado_Id_Cliente(EventParams: TStringList);
    procedure Resultado_Id_Proveedor(EventParams: TStringList);

    Procedure Release_Me;

    Function Existe_Tercero(Const pCODIGO_TERCERO : String): Boolean;

    Procedure Validar_Campos_Master(pSender: TObject);
    Function Documento_Activo: Boolean;

    Procedure NewRecordMaster(pSender: TObject);
    Procedure DsDataChangeMaster(pSender: TObject);
    Procedure DsStateMaster(Sender: TObject);

    Procedure SetLabel;
    Procedure Estado_Controles;
    Function AbrirMaestro(Const pDato: String = ''): Boolean;
  public
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

Procedure TFrIWTercero_Enc.Resultado_Perfil(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString := EventParams.Values ['CODIGO_PERFIL' ];
    End;
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWTercero_Enc.Resultado_Perfil, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
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
      UtLog_Execute('TFrIWTercero_Enc.Buscar_Info, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.Resultado_Codigo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString := Justificar(EventParams.Values['InputStr'], ' ', FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').Size);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.Resultado_Codigo, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.Resultado_Nombre(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('NOMBRE').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.Resultado_Nombre, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.Resultado_Contacto(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CONTACTO').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.Resultado_Contacto, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.Resultado_Direccion(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
      FQRMAESTRO.QR.FieldByName('DIRECCION').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.Resultado_Direccion, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.Resultado_Email(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
      FQRMAESTRO.QR.FieldByName('EMAIL').AsString := LowerCase(Trim(EventParams.Values['InputStr']));
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.Resultado_Email, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.Resultado_Telefono_1(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
      FQRMAESTRO.QR.FieldByName('TELEFONO_1').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.Resultado_Telefono_1, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.Resultado_Telefono_2(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
      FQRMAESTRO.QR.FieldByName('TELEFONO_2').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.Resultado_Telefono_2, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.Resultado_Id_Activo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
      FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString := IfThen(Result_Is_OK(EventParams.Values['RetValue']), 'S', 'N');
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.Resultado_Id_Activo, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.Resultado_Id_Cliente(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
      FQRMAESTRO.QR.FieldByName('ID_CLIENTE').AsString := IfThen(Result_Is_OK(EventParams.Values['RetValue']), 'S', 'N');
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.Resultado_Id_Cliente, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.Resultado_Id_Proveedor(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
      FQRMAESTRO.QR.FieldByName('ID_PROVEEDOR').AsString := IfThen(Result_Is_OK(EventParams.Values['RetValue']), 'S', 'N');
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.Resultado_Id_Proveedor, ' + e.Message);
  End;
End;


Procedure TFrIWTercero_Enc.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWTercero_Enc.Existe_Tercero(Const pCODIGO_TERCERO : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(gInfo_Tablas[Id_TBL_Tercero].Name, ['CODIGO_TERCERO'], [pCODIGO_TERCERO]);
End;

Procedure TFrIWTercero_Enc.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje: String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';
    CODIGO_TERCERO.BGColor := UserSession.COLOR_OK;
    NOMBRE.BGColor := UserSession.COLOR_OK;
    If BTNCODIGO.Visible Then
    Begin
      If Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Tercero invalido';
        CODIGO_TERCERO.BGColor := UserSession.COLOR_ERROR;
      End
      Else
        If FCNX.Record_Exist(gInfo_Tablas[Id_TBL_Tercero].Name, ['CODIGO_TERCERO'], [FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString]) Then
        Begin
          lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Tercero ya existente';
          CODIGO_TERCERO.BGColor := UserSession.COLOR_ERROR;
        End;
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
      UtLog_Execute('TFrIWTercero_Enc.Validar_Campos_Master, ' + E.Message);
  End;
End;

Procedure TFrIWTercero_Enc.Estado_Controles;
Begin
  BTNCODIGO.Visible         :=  (FQRMAESTRO.DS.State In [dsInsert]) And Documento_Activo;
  BTNNOMBRE.Visible         := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCONTACTO.Visible       := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNDIRECCION.Visible      := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNEMAIL.Visible          := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNTELEFONO_1.Visible     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNTELEFONO_2.Visible     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCLIENTE.Visible        := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNPROVEEDOR.Visible      := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNACTIVO.Visible         := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DATO.Visible              := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible            := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible            := True;
End;

Procedure TFrIWTercero_Enc.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
    lbNombre_Id_Activo.Caption := IfThen(FQRMAESTRO.QR.FieldByName('ID_ACTIVO'  ).AsString = 'S', 'Esta activo', 'No esta activo');
    lbNombre_Id_Cliente.Caption := IfThen(FQRMAESTRO.QR.FieldByName('ID_CLIENTE').AsString = 'S', 'Es cliente', 'No es cliente');
    lbNombre_Id_Proveedor.Caption := IfThen(FQRMAESTRO.QR.FieldByName('ID_PROVEEDOR').AsString = 'S', 'Es proveedor', 'No es proveedor');
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWTercero_Enc.SetLabel, ' + E.Message);
    End;
  End;
End;

Function TFrIWTercero_Enc.Documento_Activo: Boolean;
Begin
  Try
    Result := True;
    // Result := (FQRMAESTRO.RecordCount >= 1) {And (Trim(FQRMAESTRO.FieldByName('ID_ANULADO').AsString) <> 'S')};
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWTercero_Enc.Documento_Activo, ' + E.Message);
    End;
  End;
End;

procedure TFrIWTercero_Enc.DsDataChangeMaster(pSender: TObject);
begin

  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString + ', '+ FQRMAESTRO.QR.FieldByName('NOMBRE') .AsString + ' ] ';

  SetLabel;

  Try
    If (FCODIGO_ACTUAL <> FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString) And (Not FQRMAESTRO.Mode_Edition) Then
    Begin
      FCODIGO_ACTUAL := FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString;
    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWTercero_Enc.DsDataChangeMaster, ' + E.Message);
    End;
  End;
end;

Procedure TFrIWTercero_Enc.DsStateMaster(Sender: TObject);
Begin
  If Not FQRMAESTRO.Active Then
    Exit;

  Estado_Controles;
  If FQRMAESTRO.Mode_Edition Then
    PAGINAS.ActivePage := 1;
  Case FQRMAESTRO.QR.State Of
    dsInsert : Begin
//                 If CODIGO_TERCERO.Enabled Then
//                   CODIGO_TERCERO.SetFocus;
               End;
    dsEdit   : Begin
//                 If NOMBRE.Enabled Then
//                   NOMBRE.SetFocus;
               End;
  End;
End;

Function TFrIWTercero_Enc.AbrirMaestro(Const pDato: String = ''): Boolean;
Begin
  FGRID_MAESTRO.Caption := gInfo_Tablas[Id_TBL_Tercero].Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.WHERE    := '';
    FQRMAESTRO.SENTENCE := ' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Tercero].Name + FCNX.No_Lock;
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := ' WHERE CODIGO_TERCERO LIKE ' + QuotedStr('%' + Trim(pDato) + '%');
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%');
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_TERCERO ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin
    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWTercero_Enc.AbrirMaestro, ' + E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

procedure TFrIWTercero_Enc.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'Tercero' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  FCNX := UserSession.CNX;
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Codigo'      , Resultado_Codigo      );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Nombre'      , Resultado_Nombre      );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Contacto'    , Resultado_Contacto    );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Direccion'   , Resultado_Direccion   );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Email'       , Resultado_Email       );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Telefono_1'  , Resultado_Telefono_1  );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Telefono_2'  , Resultado_Telefono_2  );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Id_Activo'   , Resultado_Id_Activo   );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Id_Cliente'  , Resultado_Id_Cliente  );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Id_Proveedor', Resultado_Id_Proveedor);
  FCODIGO_ACTUAL := '';
  FINFO := UserSession.FULL_INFO + gInfo_Tablas[Id_TBL_Tercero].Caption;
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;

    FQRMAESTRO := UserSession.Create_Manager_Data(gInfo_Tablas[Id_TBL_Tercero].Name, gInfo_Tablas[Id_TBL_Tercero].Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;

    CODIGO_TERCERO.DataSource := FQRMAESTRO.DS;
    NOMBRE.DataSource         := FQRMAESTRO.DS;
    CONTACTO.DataSource       := FQRMAESTRO.DS;
    DIRECCION.DataSource      := FQRMAESTRO.DS;
    EMAIL.DataSource          := FQRMAESTRO.DS;
    TELEFONO_1.DataSource     := FQRMAESTRO.DS;
    TELEFONO_2.DataSource     := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['CODIGO_TERCERO', 'NOMBRE'     ],
                                         ['Tercero'       , 'Nombre'     ],
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
    AbrirMaestro;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWTercero_Enc.IWAppFormCreate, ' + E.Message);
    End;
  End;
end;

procedure TFrIWTercero_Enc.IWAppFormDestroy(Sender: TObject);
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
      UtLog_Execute('TFrIWTercero_Enc.IWAppFormDestroy, ' + E.Message);
  End;
end;

procedure TFrIWTercero_Enc.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString := 'S';
    FQRMAESTRO.QR.FieldByName('ID_CLIENTE').AsString := 'S';
    FQRMAESTRO.QR.FieldByName('ID_PROVEEDOR').AsString := 'S';
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWTercero_Enc.NewRecordMaster, ' + E.Message);
    End;
  End;
end;

procedure TFrIWTercero_Enc.BtnAcarreoAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_TERCERO'], [FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString]);
end;


procedure TFrIWTercero_Enc.BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowConfirm('Esta activo?', Self.Name + '.Resultado_Id_Activo', 'Activo', 'Sí', 'No')
end;

procedure TFrIWTercero_Enc.BTNBACKAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

Procedure TFrIWTercero_Enc.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_TERCERO']);
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.Localizar_Registro, ' + e.Message);
  End;
End;

procedure TFrIWTercero_Enc.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Tercero, Localizar_Registro);
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

procedure TFrIWTercero_Enc.BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el nombre del Tercero', Self.Name + '.Resultado_Nombre', 'Nombre', FQRMAESTRO.QR.FieldByName('NOMBRE').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.BTNNOMBREAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWTercero_Enc.BTNPROVEEDORAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowConfirm('Es proveedor?', Self.Name + '.Resultado_Id_Proveedor', 'Proveedor', 'Sí', 'No')
end;

procedure TFrIWTercero_Enc.BTNTELEFONO_1AsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el telefono 1 ', Self.Name + '.Resultado_Telefono_1', 'Telefono', FQRMAESTRO.QR.FieldByName('TELEFONO_1').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.BTNTELEFONO_1AsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWTercero_Enc.BTNTELEFONO_2AsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el telefono 2', Self.Name + '.Resultado_Telefono_2', 'Telefono', FQRMAESTRO.QR.FieldByName('TELEFONO_2').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.BTNTELEFONO_2AsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWTercero_Enc.BTNCLIENTEAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowConfirm('Es cliente?', Self.Name + '.Resultado_Id_Cliente', 'Cliente', 'Sí', 'No')
end;

Procedure TFrIWTercero_Enc.BTNCODIGOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese la cédula del Tercero', Self.Name + '.Resultado_Codigo', 'Cédula', FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.BTNCODIGOAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWTercero_Enc.BTNCODIGO_PERFILAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Perfil, Resultado_Perfil);
end;

procedure TFrIWTercero_Enc.BTNCONTACTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el contacto', Self.Name + '.Resultado_Contacto', 'Contacto', FQRMAESTRO.QR.FieldByName('CONTACTO').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.BTNCONTACTOAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWTercero_Enc.BTNDIRECCIONAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  ltmp : String;
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      ltmp := FQRMAESTRO.QR.FieldByName('DIRECCION').AsString;
      WebApplication.ShowPrompt('Ingrese la dirección', Self.Name + '.Resultado_Direccion', 'Dirección', ltmp);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.BTNDIRECCIONAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWTercero_Enc.BTNEMAILAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el correo electronico', Self.Name + '.Resultado_Email', 'Correo electronico', FQRMAESTRO.QR.FieldByName('EMAIL').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.BTNEMAILAsyncClick, ' + e.Message);
  End;
end;


procedure TFrIWTercero_Enc.BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  UserSession.ShowForm_Perfil_Enc(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString);
end;

end.
