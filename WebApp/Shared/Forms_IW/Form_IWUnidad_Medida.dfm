object FrIWUnidad_Medida: TFrIWUnidad_Medida
  Left = 0
  Top = 0
  Width = 1341
  Height = 593
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  OnCreate = IWAppFormCreate
  OnDestroy = IWAppFormDestroy
  Background.Fixed = False
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  DesignLeft = 2
  DesignTop = 2
  object RINFO: TIWRegion
    Left = 0
    Top = 0
    Width = 1341
    Height = 26
    RenderInvisibleControls = True
    Align = alTop
    Color = clWebMEDIUMBLUE
    object lbInfo: TIWLabel
      Left = 1
      Top = 1
      Width = 1339
      Height = 24
      Align = alClient
      Alignment = taCenter
      Font.Color = clWebWHITE
      Font.Size = 12
      Font.Style = [fsBold]
      NoWrap = True
      HasTabOrder = False
      FriendlyName = 'lbInfo'
      Caption = 'lbInfo'
      ExplicitLeft = 2
      ExplicitTop = 4
    end
  end
  object IWRegion1: TIWRegion
    Left = 0
    Top = 58
    Width = 1341
    Height = 535
    RenderInvisibleControls = True
    Align = alClient
    object PAGINAS: TIWTabControl
      Left = 1
      Top = 1
      Width = 1339
      Height = 533
      RenderInvisibleControls = True
      ActiveTabFont.Color = clWebWHITE
      ActiveTabFont.FontFamily = 'Arial, Sans-Serif, Verdana'
      ActiveTabFont.Size = 10
      ActiveTabFont.Style = [fsBold]
      InactiveTabFont.Color = clWebBLACK
      InactiveTabFont.FontFamily = 'Arial, Sans-Serif, Verdana'
      InactiveTabFont.Size = 10
      InactiveTabFont.Style = []
      ActiveTabColor = clWebDARKGRAY
      InactiveTabColor = clWebLIGHTGRAY
      ActivePage = 0
      Align = alClient
      BorderOptions.NumericWidth = 0
      BorderOptions.Style = cbsNone
      Color = clWebSILVER
      ClipRegion = False
      TabPadding = 10
      TabRowHeight = 30
      TabHeight = 40
      TabBorderRadius = 10
      ActiveTabBorder.Color = clWebBLACK
      ActiveTabBorder.Width = 0
      InactiveTabBorder.Color = clWebBLACK
      InactiveTabBorder.Width = 0
      DesignSize = (
        1339
        533)
      object PAG_01: TIWTabPage
        Left = 0
        Top = 30
        Width = 1339
        Height = 503
        RenderInvisibleControls = True
        TabOrder = 1
        Title = '[          Datos B'#225'sicos          ]'
        BorderOptions.NumericWidth = 0
        BorderOptions.Style = cbsNone
        Color = clWebWHITE
        object IWLabel1: TIWLabel
          Left = 10
          Top = 11
          Width = 42
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'C'#243'digo'
        end
        object IWLabel8: TIWLabel
          Left = 10
          Top = 34
          Width = 49
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'Nombre'
        end
        object IWLabel2: TIWLabel
          Left = 10
          Top = 82
          Width = 71
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'Descripci'#243'n'
        end
        object CODIGO_UNIDAD_MEDIDA: TIWDBEdit
          Left = 87
          Top = 7
          Width = 161
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Alignment = taRightJustify
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'CODIGO_UNIDAD_MEDIDA'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'CODIGO_UNIDAD_MEDIDA'
          PasswordPrompt = False
        end
        object NOMBRE: TIWDBEdit
          Left = 87
          Top = 33
          Width = 447
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'NOMBRE'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'NOMBRE'
          PasswordPrompt = False
        end
        object DESCRIPCION: TIWDBMemo
          Left = 87
          Top = 60
          Width = 447
          Height = 66
          StyleRenderOptions.RenderBorder = False
          BGColor = clNone
          Editable = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          InvisibleBorder = False
          HorizScrollBar = False
          VertScrollBar = True
          Required = False
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'DESCRIPCION'
          FriendlyName = 'DESCRIPCION'
        end
        object ID_ACTIVO: TIWDBCheckBox
          Left = 3
          Top = 132
          Width = 121
          Height = 21
          Caption = 'Activo'
          Editable = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          SubmitOnAsyncEvent = True
          Style = stNormal
          AutoEditable = False
          DataField = 'ID_ACTIVO'
          FriendlyName = 'ID_ACTIVO'
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object PAG_00: TIWTabPage
        Left = 0
        Top = 30
        Width = 1339
        Height = 503
        RenderInvisibleControls = True
        Title = '[          Registros          ]'
        BorderOptions.NumericWidth = 0
        BorderOptions.Style = cbsNone
        Color = clWebWHITE
      end
    end
  end
  object RNAVEGADOR: TIWRegion
    Left = 0
    Top = 26
    Width = 1341
    Height = 32
    VertScrollBar.Visible = False
    RenderInvisibleControls = True
    Align = alTop
    Color = clWebMEDIUMBLUE
    object DATO: TIWEdit
      Left = 401
      Top = 1
      Width = 121
      Height = 30
      Hint = 'Busqueda del dato'
      Align = alLeft
      ParentShowHint = True
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'DATO'
      SubmitOnAsyncEvent = True
      TabOrder = 2
      ExplicitLeft = 513
      ExplicitTop = 6
      ExplicitHeight = 21
    end
    object IWRegion_Navegador: TIWRegion
      Left = 1
      Top = 1
      Width = 400
      Height = 30
      HorzScrollBar.Visible = False
      VertScrollBar.Visible = False
      RenderInvisibleControls = True
      Align = alLeft
      BorderOptions.NumericWidth = 0
      Color = clWebMEDIUMBLUE
    end
  end
  object IWModalWindow1: TIWModalWindow
    WindowLeft = 100
    WindowTop = 200
    Autosize = False
    CloseOnClick = True
    Left = 61
    Top = 11
  end
end
