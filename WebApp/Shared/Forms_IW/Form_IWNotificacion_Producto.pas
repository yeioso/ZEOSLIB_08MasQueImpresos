unit Form_IWNotificacion_Producto;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  UtConexion, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, UtGrid_JQ, IWCompButton;

Type
  TGRID_JQ_NP = Class(TGRID_JQ)
    Private
    Public
      Update_Record : TNotifyEvent;
      Procedure GridAsyncDblClickRow(Sender: TObject; EventParams: TStringList; const RowID: string; const Row, Col: Integer); Override;
  End;

  TFrIWNotificacion_Producto = class(TIWAppForm)
    IWRegion_Head: TIWRegion;
    IWRegion_Detalle: TIWRegion;
    BTNCERRAR: TIWButton;
    BTNREFRESCAR: TIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNCERRARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNREFRESCARAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FQRDETALLE : TMANAGER_DATA;
    FREFERENCIA : String;
    FGRID_MAESTRO : TGRID_JQ_NP;
    Function AbrirDetalle(Const pDato : String  = '') : Boolean;
    Procedure Update_Record(pSender : TObject);
  public
  end;

implementation
{$R *.dfm}

Uses
  UtFuncion,
  System.StrUtils,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

{ TGRID_JQ_NP }
procedure TGRID_JQ_NP.GridAsyncDblClickRow(Sender: TObject; EventParams: TStringList; const RowID: string; const Row, Col: Integer);
begin
  inherited;
  If Find_It And Assigned(Update_Record) Then
    Update_Record(Sender);
end;

Procedure TFrIWNotificacion_Producto.Update_Record(pSender : TObject);
Begin
  Try
    If FQRDETALLE.ACTIVE Then
    Begin
      FQRDETALLE.QR.Edit;
      FQRDETALLE.QR.FieldByName('ID_ACTIVO'       ).AsString := IfThen(FQRDETALLE.QR.FieldByName('ID_ACTIVO').AsString = 'S', 'N', 'S');
      FQRDETALLE.QR.FieldByName('FECHA_CONFIRMADA').AsString := FormatDateTime('YYYY-MM-DD', Now);
      FQRDETALLE.QR.FieldByName('HORA_CONFIRMADA' ).AsString := FormatDateTime('HH:NN:SS.Z', Now);
      FQRDETALLE.QR.Post;
      FGRID_MAESTRO.RefreshData;
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.Update_Record', E.Message);
    End;
  End;
End;

Function TFrIWNotificacion_Producto.AbrirDetalle(Const pDato : String  = '') : Boolean;
Begin
  Result := False;
  Try
    FQRDETALLE.Active := False;
    FQRDETALLE.SENTENCE := ' SELECT * FROM ' + Info_TablaGet(Id_TBL_Notificacion_Producto).Name + FCNX.No_Lock;
    FQRDETALLE.WHERE    := ' WHERE ' + FCNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(UserSession.USER_CODE));
    FQRDETALLE.WHERE := FQRDETALLE.WHERE + ' AND ID_ACTIVO = ' + QuotedStr('S');
    FQRDETALLE.Active := True;
    Result := FQRDETALLE.Active;
    If Result Then
      FGRID_MAESTRO.RefreshData;
    FGRID_MAESTRO.Enabled := True;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.AbrirDetalle', E.Message);
    End;
  End;
End;

procedure TFrIWNotificacion_Producto.BTNCERRARAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Self.Release;
end;

procedure TFrIWNotificacion_Producto.BTNREFRESCARAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  AbrirDetalle;
end;

procedure TFrIWNotificacion_Producto.IWAppFormCreate(Sender: TObject);
begin
  Try
    Randomize;
    Self.Name := 'TFrIWNotificacion_Producto' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
    FCNX := UserSession.CNX;
    Self.Title := Info_TablaGet(Id_TBL_Notificacion_Producto).Caption;
    FGRID_MAESTRO        := TGRID_JQ_NP.Create(IWRegion_Detalle);
    FGRID_MAESTRO.Parent := IWRegion_Detalle;
    FGRID_MAESTRO.Update_Record := Self.Update_Record;

    FGRID_MAESTRO.Top    := IWRegion_Head.Top + IWRegion_Head.Height + 3;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 850;
    FGRID_MAESTRO.Height := 400;
    FQRDETALLE := UserSession.Create_Manager_Data(Info_TablaGet(Id_TBL_Explosion_Material).Name, Info_TablaGet(Id_TBL_Explosion_Material).Caption);

    FGRID_MAESTRO.VisibleRowCount := 15;
    FGRID_MAESTRO.SetGrid(FQRDETALLE.DS, ['CODIGO_PRODUCTO', 'FECHA_REGISTRO', 'HORA_REGISTRO', 'NOMBRE'     , 'CANTIDAD'    , 'ID_ACTIVO'   ],
                                         ['Producto'       , 'Fecha Registro', 'Hora Registro', 'Nombre'     , 'Cantidad'    , 'Pendiente'   ],
                                         ['S'              , 'S'             , 'S'            , 'N'          , 'N'           , 'N'           ],
                                         [150              , 100             , 100            , 250          , 100           , 100           ],
                                         [taRightJustify   , taLeftJustify   , taLeftJustify  , taLeftJustify, taRightJustify, taCenter      ]);
    AbrirDetalle;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.IWAppFormCreate', E.Message);
  End;
end;

procedure TFrIWNotificacion_Producto.IWAppFormDestroy(Sender: TObject);
begin
  Try
    If Assigned(FQRDETALLE) Then
    Begin
      FQRDETALLE.Active := False;
      FreeAndNil(FQRDETALLE);
    End;

    If Assigned(FGRID_MAESTRO) Then
      FreeAndNil(FGRID_MAESTRO);

  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.IWAppFormDestroy', E.Message);
  End;
end;



end.
