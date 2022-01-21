object FrIWPerfil_Enc: TFrIWPerfil_Enc
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
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'C'#243'digo'
        end
        object IWLabel8: TIWLabel
          Left = 10
          Top = 35
          Width = 49
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'Nombre'
        end
        object CODIGO_PERFIL: TIWDBEdit
          Left = 65
          Top = 4
          Width = 128
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Alignment = taRightJustify
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'CODIGO_PERFIL'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'CODIGO_PERFIL'
          PasswordPrompt = False
        end
        object NOMBRE: TIWDBEdit
          Left = 65
          Top = 34
          Width = 468
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
        object IWRDETALLE: TIWRegion
          Left = 10
          Top = 61
          Width = 524
          Height = 228
          HorzScrollBar.Visible = False
          VertScrollBar.Visible = False
          RenderInvisibleControls = True
          object DETALLE_PERFIL: TIWListbox
            Left = 1
            Top = 1
            Width = 464
            Height = 226
            Align = alLeft
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            FriendlyName = 'DETALLE_PERFIL'
            NoSelectionText = '-- No Selection --'
          end
          object IWRBOTONDETALLE: TIWRegion
            Left = 483
            Top = 1
            Width = 40
            Height = 226
            RenderInvisibleControls = True
            Align = alRight
            object BtnGrid: TIWImage
              Left = 7
              Top = 97
              Width = 24
              Height = 24
              Cursor = crHandPoint
              RenderSize = False
              StyleRenderOptions.RenderSize = False
              BorderOptions.Width = 0
              UseSize = False
              OnAsyncClick = BtnGridAsyncClick
              Picture.Data = {
                0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
                00180806000000E0773DF8000004154944415478DA9D550D4CD465187F9EE3FE
                DCF7417C2425AC31294C27444D57237094CD2B191F170DB4D2D50CE6A5C6CA0F
                96A08202614DD111B842998251AB1D0BB059169BB39AD46C4B57E9CA61E65C0C
                0F0CC1FBBEA7E7FFBFFFC17990F3DFB3DBEDD973F7BEBFF7F77B9EF7F7626B4D
                C59244E7E5CFF43109C940012400FE00207F22F3F05AA88EAA281ABBFA3BC4A5
                A4235120F87F8E89B191BF1C105382E973F4F91FB735F53EB8B4187C5E27F236
                24AFE61C6ECFC36B529D506388A3937BCAC1B2ED303AFEBC401323C370DF824C
                FCF5CB6E5A5D595780E9F7EA8ABADB9A7A1E58B20CBCCE71207939F2F122F3F0
                5AA86E889B0B03FB364276452D9CFDF4105CF9F10CE4BEFE260C5F380BE5D52D
                C5CC4057F4514B833D393307DCCE715E72F712893F991292E9F4C12A48CDC9C7
                F3FD3DE4F77820362505754681D6371EB54A005DFB77D9E7CCCF02F7C43FD300
                2C07D1ED79782D1884E6A4541A3C520F82D98814F093741CFE728E8ED0B623A7
                AD5312CD7B321FBCAE49501AFA9844F8FA3D1B3C56B68967C407DC748650C1A5
                EF7B616DCDFEE210803D2DA7107CAE496E9B8229E2B66BCD09F4D59EB5F06C75
                274E38AE52B4CE0C5A53029EEBFB8056D9AA82121DDDBBC33E77D113E0B9352E
                EF119A4288CCC36B924486F8FBE9DB0FAB61C5F62E9C1CBD460203E8CC22403B
                036C0D021C3BB0BB27F5710B78DD93F21E771B246E0603CD1BC1F27607DCBA31
                0C1203733C9CEF6B8795B6ADD3123D9457023E8F73B653DF8101F03D88A5130D
                AFC0335B0EA2FBE6A8CC203E8C810C307F5919F8BD2E85371951D099E844FD1A
                78FAADF7D1337963160096E870E3667BD2C38BF9A24D286480A88F4DA4C163EF
                C0F2AA76E4F50C609A09D0DDDAD4B3D0B206FC3EB7C2214510347A385EF722E4
                BDB1579418A2B5A6D97BB070F9CB0CE0E18B445386159987D74275416B201160
                E9FA7731E0F3FE3783452B5E05BFDFAB50208428410BFDB56590BBAE51322A41
                6B9CC9A07D77257B512EF83D2E653DE02EF358720F1A21AFB21955A822194066
                50254F516B933DA3A01C0201EF0CFF09CF23BD4894284A1D4DFD3B4B21675D03
                E71A49228D3E167FFEBC8D564E8D294B9451C8002C9132BB6689D4D170BC7615
                8FB853E2267951941ADC37C760FB273F0425EA6CDE695F60590DE4F7291E5355
                945AF6A22EBC3E7491C81F008DD188577E3A492F6DA80E32E868DA624FCBB532
                807F9673DF99834A2DD0A9D64D90FD5A1D7EB36F075DBF7C091E292A65600FF1
                83336DD759D60D0AEFC074F4D63C0F59A536181A3C057FFFF60B641695C0B573
                67C0B6EB90F8A2E90BC5299A975D80D2ABABD08BC4577AB0B31E92321663407C
                702492808EA18BAECD2D7D2F608231FAD1ECB4D80AD65FC3EC9558694824A9A9
                187E04CE7C011CF9EE0F47075A9F7BCA60FF62E01E2E0AFF5BA3992142790A73
                33C7FE0588483847F735FFAE0000000049454E44AE426082}
              FriendlyName = 'BtnGrid'
              TransparentColor = clNone
              JpegOptions.CompressionQuality = 90
              JpegOptions.Performance = jpBestSpeed
              JpegOptions.ProgressiveEncoding = False
              JpegOptions.Smoothing = True
            end
          end
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
      Width = 164
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
      ExplicitLeft = 301
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
    Left = 117
    Top = 11
  end
end
