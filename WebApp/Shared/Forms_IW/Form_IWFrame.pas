unit Form_IWFrame;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompButton, IWCompListbox, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls;

type
  TFrIWFrame = class(TFrame)
    IWFrameRegion: TIWRegion;
    IWLabel1: TIWLabel;
    INTERFAZ_ACTIVA: TIWSelect;
    BTNEJECUTAR: TIWButton;
    IWTimer1: TIWTimer;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure BTNEJECUTARAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    { Private declarations }
    Procedure Load_Actives;
    Function Launch_Show : Boolean;
  public
    { Public declarations }
    Procedure Sincronizar_Informacion;
  end;

implementation
{$R *.dfm}
Uses
  UtFuncion,
  IWAppForm,
  IWApplication,
  ServerController;

Procedure TFrIWFrame.Sincronizar_Informacion;
Begin
  Load_Actives;
End;

Procedure TFrIWFrame.Load_Actives;
Var
  lI : Integer;
  lN : String;
  lWA : TIWApplication;
Begin
  lWA := UserSession.WebApplication;
  INTERFAZ_ACTIVA.Items.Clear;
  For lI := 0 To lWA.FormCount-1 Do
  Begin
    If Assigned(lWA.Forms[lI]) Then
    Begin
      If lWA.Forms[lI] Is TIWAppForm Then
      Begin
        lN := (lWA.Forms[lI] As TIWAppForm).Title;
        If Vacio(lN) Then
          lN := (lWA.Forms[lI] As TIWAppForm).Name;
        If Vacio(lN) Then
          lN := (lWA.Forms[lI] As TIWAppForm).ClassName;
        INTERFAZ_ACTIVA.Items.AddObject(lN, lWA.Forms[lI]);
      End;
    End;
  End;
End;

Function TFrIWFrame.Launch_Show : Boolean;
Var
  lItem : TComponent;
Begin
  If INTERFAZ_ACTIVA.ItemIndex > -1 Then
  Begin
    lItem := TComponent(INTERFAZ_ACTIVA.Items.Objects[INTERFAZ_ACTIVA.ItemIndex]);
    If Assigned(lItem) And (lItem <> Nil)  Then
      If lItem Is TIWAppForm Then
        (lItem As TIWAppForm).Show;
    INTERFAZ_ACTIVA.ResetSelection;
  End;
End;

procedure TFrIWFrame.BTNEJECUTARAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Launch_Show;
end;

procedure TFrIWFrame.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Visible := True;
end;

end.
