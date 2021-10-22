unit Form_IWReporte;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Vcl.Controls,
  Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  Vcl.Imaging.pngimage, IWCompEdit, IWCompProgressIndicator;

type
  TFrIWReporte = class(TIWAppForm)
    IWRegion_HEAD: TIWRegion;
    BTNBACK: TIWButton;
    IWModalWindow1: TIWModalWindow;
    IWRegion_PRODUCTO: TIWRegion;
    BTNCODIGO_PRODUCTO_INI: TIWImage;
    BTNCODIGO_PRODUCTO_FIN: TIWImage;
    CODIGO_PRODUCTO_INI: TIWEdit;
    CODIGO_PRODUCTO_FIN: TIWEdit;
    IWProgressIndicator1: TIWProgressIndicator;
    BTNPRODUCTO: TIWButton;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PRODUCTO_INIAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PRODUCTO_FINAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNPRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    Procedure Resultado_Codigo_Producto_Ini(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Codigo_Producto_Fin(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
  public
  end;

implementation
{$R *.dfm}
Uses
  UtLog,
  UtFuncion,
  UtilsIW.Busqueda,
  ServerController,
  TBL000.Info_Tabla,
  Report.Saldo_Inventario,
  Form_Plantilla_Documento;

procedure TFrIWReporte.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
Var
  lBusqueda : TBusqueda_MQI_WjQDBGrid;
begin
  Try
    lBusqueda := TBusqueda_MQI_WjQDBGrid.Create(Self);
    lBusqueda.Parent := Self;
    lBusqueda.SetComponents(UserSession.CNX, pEvent);
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
      UtLog_Execute('TFrIWReporte.Buscar_Info, ' + e.Message);
  End;
End;

procedure TFrIWReporte.BTNCODIGO_PRODUCTO_INIAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Producto, Resultado_Codigo_Producto_Ini);
end;

procedure TFrIWReporte.BTNPRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  lFin : String;
begin
  lFin := CODIGO_PRODUCTO_FIN.Text;
  If Vacio(lFin) Then
    lFin := Justificar('z', 'z', 20);
  If Report_Saldo_Inventario_Reporte(UserSession.CNX, CODIGO_PRODUCTO_INI.Text, lFin) Then
     If Not Form_Plantilla_Reporte_Generico(UserSession.WebApplication, lFin) Then
       UserSession.SetMessage(lFin, True);
end;

procedure TFrIWReporte.BTNCODIGO_PRODUCTO_FINAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Producto, Resultado_Codigo_Producto_Fin);
end;

Procedure TFrIWReporte.Resultado_Codigo_Producto_Ini(Sender: TObject; EventParams: TStringList);
Begin
  Try
    CODIGO_PRODUCTO_INI.Text := EventParams.Values ['CODIGO_PRODUCTO'];
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWReporte.Resultado_Codigo_Producto_Ini, ' + e.Message);
  End;
End;

Procedure TFrIWReporte.Resultado_Codigo_Producto_Fin(Sender: TObject; EventParams: TStringList);
Begin
  Try
    CODIGO_PRODUCTO_FIN.Text := EventParams.Values ['CODIGO_PRODUCTO'];
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWReporte.Resultado_Codigo_Producto_Fin, ' + e.Message);
  End;
End;



procedure TFrIWReporte.BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
Begin
  Self.Release;
End;

end.
