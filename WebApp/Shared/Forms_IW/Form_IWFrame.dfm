object FrIWFrame: TFrIWFrame
  Left = 0
  Top = 0
  Width = 903
  Height = 83
  Align = alTop
  TabOrder = 0
  object IWFrameRegion: TIWRegion
    Left = 0
    Top = 0
    Width = 903
    Height = 83
    RenderInvisibleControls = True
    Align = alClient
    OnCreate = IWFrameRegionCreate
    object IWLabel1: TIWLabel
      Left = 9
      Top = 1
      Width = 108
      Height = 16
      Font.Color = clNone
      Font.Size = 10
      Font.Style = [fsBold]
      NoWrap = True
      HasTabOrder = False
      FriendlyName = 'IWLabel1'
      Caption = 'Interfaz Activa'
    end
    object INTERFAZ_ACTIVA: TIWSelect
      Left = 12
      Top = 20
      Width = 880
      Height = 25
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      ItemIndex = -1
      FriendlyName = 'INTERFAZ_ACTIVA'
      NoSelectionText = '-- No Selection --'
    end
    object BTNEJECUTAR: TIWButton
      Left = 11
      Top = 51
      Width = 100
      Height = 25
      Cursor = crHandPoint
      Caption = 'EJECUTAR'
      Color = clBtnFace
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'BTNEJECUTAR'
      OnAsyncClick = BTNEJECUTARAsyncClick
    end
  end
  object IWTimer1: TIWTimer
    Enabled = True
    Interval = 500
    ShowAsyncLock = False
    Left = 608
    Top = 32
  end
end
