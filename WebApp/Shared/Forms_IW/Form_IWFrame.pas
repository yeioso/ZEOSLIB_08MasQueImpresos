unit Form_IWFrame;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container;

type
  TFrIWFrame = class(TFrame)
    IWFrameRegion: TIWRegion;
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrIWFrame.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Visible := True;
end;

end.