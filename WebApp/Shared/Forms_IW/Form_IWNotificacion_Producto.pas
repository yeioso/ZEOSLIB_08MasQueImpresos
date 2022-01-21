unit Form_IWNotificacion_Producto;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Form_IWFrame,
  UtConexion, Generics.Collections, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWjQGrid, IWCompButton;

Type
  TProducto = Class
    Private
      FCODIGO_PRODUCTO : String;
      FFECHA_REGISTRO  : String;
      FHORA_REGISTRO   : String;
      FNOMBRE          : String;
      FCANTIDAD        : Double;
      FID_ACTIVO       : String;
    Public
      Property CODIGO_PRODUCTO : String Read FCODIGO_PRODUCTO;
      Property FECHA_REGISTRO  : String Read FFECHA_REGISTRO ;
      Property HORA_REGISTRO   : String Read FHORA_REGISTRO  ;
      Property NOMBRE          : String Read FNOMBRE         ;
      Property CANTIDAD        : Double Read FCANTIDAD       ;
      Property ID_ACTIVO       : String Read FID_ACTIVO      ;
  End;
  TProductos = TList<TProducto>;

  TFrIWNotificacion_Producto = class(TIWAppForm)
    IWRegion_Head: TIWRegion;
    IWRegion_Detalle: TIWRegion;
    IWjQGrid1: TIWjQGrid;
    BTNCERRAR: TIWButton;
    BTNGUARDAR: TIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNCERRARAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FFRAME : TFrIWFrame;
    FProductos : TProductos;
    Procedure Load_Items;
    Procedure Restart;
  public
  end;

implementation
{$R *.dfm}
Uses
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Procedure TFrIWNotificacion_Producto.Load_Items;
Var
  lItem : TProducto;
Begin
  Try
//    FCNX.TMP.SQL.Add('SELECT * FROM ' + );
    For lItem In FProductos Do
      lItem.Free;
    FProductos.Clear;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.Load_Items', E.Message);
  End;
End;

Procedure TFrIWNotificacion_Producto.Restart;
Var
  lItem : TProducto;
Begin
  Try
    For lItem In FProductos Do
      lItem.Free;
    FProductos.Clear;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.Restart', E.Message);
  End;
End;

procedure TFrIWNotificacion_Producto.BTNCERRARAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Self.Release;
end;

procedure TFrIWNotificacion_Producto.IWAppFormCreate(Sender: TObject);
begin
  Try
    Randomize;
    Self.Name := 'TFrIWNotificacion_Producto' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
    FCNX := UserSession.CNX;
    FFRAME := TFrIWFrame.Create(Self);
    FFRAME.Parent := Self;
    FProductos := TProductos.Create;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.IWAppFormCreate', E.Message);
  End;
end;

procedure TFrIWNotificacion_Producto.IWAppFormDestroy(Sender: TObject);
begin
  Try
    If Assigned(FProductos) Then
    Begin
      Restart;
      FreeAndNil(FProductos);
    End;

    If Assigned(FFRAME) Then
      FreeAndNil(FFRAME);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.IWAppFormDestroy', E.Message);
  End;
end;

end.
