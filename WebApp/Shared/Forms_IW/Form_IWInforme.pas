unit Form_IWInforme;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompExtCtrls, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  IWCompButton, IWCompListbox, IWCompProgressIndicator, IWCompEdit,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  UtilsIW.Busqueda;

type
  TFrIWInforme = class(TIWAppForm)
    RREGRESAR: TIWRegion;
    BTNBACK: TIWImage;
    IWLabel1: TIWLabel;
    IWRegion1: TIWRegion;
    IWProgressIndicator1: TIWProgressIndicator;
    IWModalWindow1: TIWModalWindow;
    IWRegion2: TIWRegion;
    lbFechaIni: TIWLabel;
    lbFechaFin: TIWLabel;
    FECHAINI: TIWEdit;
    FECHAFIN: TIWEdit;
    lbTercero: TIWLabel;
    CODIGO_TERCERO: TIWEdit;
    BTNTERCERO: TIWImage;
    BTNCONSULTAR: TIWImage;
    IWLabel2: TIWLabel;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure BTNTERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCONSULTARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormShow(Sender: TObject);
  private
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
    Procedure Release_Me;
    procedure Asignar_Tercero(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation
{$R *.dfm}
Uses
  
  TBL00.Info_Tabla,
  ServerController,
  Form_Plantilla_Ercol,
  UtInventario_Consolidado;

procedure TFrIWInforme.Buscar_Info(pSD : TSD; pEvent : TIWAsyncEvent);
Var
  lBusqueda : TBusqueda_Ercol_WjQDBGrid;
begin
  Try
    lBusqueda := TBusqueda_Ercol_WjQDBGrid.Create(Self);
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
      Utils_ManagerLog_Add('TFrIWSI_Bodega.Buscar_Info, ' + e.Message);
  End;
End;

procedure TFrIWInforme.BTNBACKAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Release_Me;
end;

procedure TFrIWInforme.BTNCONSULTARAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  lOK : Boolean;
  lError : String;
begin
  lOK := UtInventario_Consolidado_Execute(FECHAINI.Text, FECHAFIN.Text, CODIGO_TERCERO.Text, lError);
  If lOK And (Not Form_Plantilla_Reporte_Ercol(WebApplication, lError)) Then
     UserSession.SetMessage(lError, True);
end;

procedure TFrIWInforme.Asignar_Tercero(Sender: TObject; EventParams: TStringList);
begin
  CODIGO_TERCERO.Text := EventParams.Values['CODIGO_TERCERO' ];
end;

procedure TFrIWInforme.BTNTERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(TSD.TSD_Tercero, Asignar_Tercero);
end;

procedure TFrIWInforme.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'TFrIWInforme' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  FECHAINI.Text := '1900-01-01';
  FECHAFIN.Text := FormatDateTime('YYYY-MM-DD', Now);
end;

procedure TFrIWInforme.IWAppFormShow(Sender: TObject);
begin
  If Assigned(FFRAME) Then
    FFRAME.Sincronizar_Informacion;
end;

Procedure TFrIWInforme.Release_Me;
Begin
  Self.Release;
End;


end.
