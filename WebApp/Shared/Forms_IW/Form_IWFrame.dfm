object FrIWFrame: TFrIWFrame
  Left = 0
  Top = 0
  Width = 501
  Height = 45
  Align = alTop
  TabOrder = 0
  object IWFrameRegion: TIWRegion
    Left = 0
    Top = 0
    Width = 501
    Height = 45
    RenderInvisibleControls = True
    Align = alClient
    OnCreate = IWFrameRegionCreate
    ExplicitHeight = 111
  end
end
