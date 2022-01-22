object FrIWUsuario_Enc: TFrIWUsuario_Enc
  Left = 0
  Top = 0
  Width = 1341
  Height = 593
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  OnCreate = IWAppFormCreate
  OnDestroy = IWAppFormDestroy
  OnShow = IWAppFormShow
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
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    RenderInvisibleControls = True
    Align = alTop
    BorderOptions.NumericWidth = 0
    Color = clWebMEDIUMBLUE
    object lbInfo: TIWLabel
      Left = 0
      Top = 0
      Width = 1341
      Height = 26
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
      ExplicitWidth = 1339
      ExplicitHeight = 24
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
          Top = 36
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
        object IWLabel37: TIWLabel
          Left = 10
          Top = 62
          Width = 57
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'Direcci'#243'n'
        end
        object IWLabel2: TIWLabel
          Left = 10
          Top = 88
          Width = 34
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'Email'
        end
        object IWLabel3: TIWLabel
          Left = 10
          Top = 113
          Width = 67
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'Telefono 1'
        end
        object IWLabel4: TIWLabel
          Left = 10
          Top = 139
          Width = 67
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'Telefono 2'
        end
        object CODIGO_USUARIO: TIWDBEdit
          Left = 89
          Top = 6
          Width = 148
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Alignment = taRightJustify
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'CODIGO_USUARIO'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'CODIGO_USUARIO'
          PasswordPrompt = False
        end
        object NOMBRE: TIWDBEdit
          Left = 89
          Top = 32
          Width = 445
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
        object DIRECCION: TIWDBEdit
          Left = 89
          Top = 59
          Width = 445
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'DIRECCION'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'DIRECCION'
          PasswordPrompt = False
        end
        object EMAIL: TIWDBEdit
          Left = 89
          Top = 85
          Width = 445
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'EMAIL'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'EMAIL'
          PasswordPrompt = False
        end
        object TELEFONO_1: TIWDBEdit
          Left = 89
          Top = 112
          Width = 148
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'TELEFONO_1'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'TELEFONO_1'
          PasswordPrompt = False
        end
        object TELEFONO_2: TIWDBEdit
          Left = 89
          Top = 138
          Width = 148
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'TELEFONO_2'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'TELEFONO_2'
          PasswordPrompt = False
        end
        object IWLabel7: TIWLabel
          Left = 10
          Top = 191
          Width = 31
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'Perfil'
        end
        object IWLabel10: TIWLabel
          Left = 10
          Top = 165
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
          Caption = 'Contrase'#241'a'
        end
        object BTNCODIGO_PERFIL: TIWImage
          Left = 245
          Top = 192
          Width = 22
          Height = 21
          Cursor = crHandPoint
          Hint = 'Buscar'
          ParentShowHint = True
          BorderOptions.Width = 0
          UseSize = True
          OnAsyncClick = BTNCODIGO_PERFILAsyncClick
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
            00180806000000E0773DF80000042C4944415478DAED94DB4F9B7518C79FA727
            DAB77DE9017AA087C8A914282301A21820960D10861A25E30225BBDA96A8376A
            624C3CFC01CE7557A2DECC1997186346614EC93615641886BAB5890ED8686530
            683B2CB495B7941EDEBEFDF9838B65C60577A157EE9BBCF9E5CDEFF0799EEFEF
            F73C08FFB1F021E07F0C709F70BF98CD64DC335452A9B477E4DC287FEF7C7FDF
            21659EE4C7DADADAAAC562F14BAFBCF6EAE80303DE7BF7B83DB5BD7DF5D2B7DF
            A843A130A9ADA9A9BB70E9E2FCBD6B7A7B0EBA66E7E7266D561B1CECE9898845
            A2E637DF797B794FC087431F18BC3EEF5193D1D4CFF37CC3E4E424B02C4B3639
            6E4822919ECE643303C5C57A9E650B3F5B5D597EABB0903D9C4824A0B3A393C8
            A4D2AB80385CED709C1A187C21FE37C0A867C44E871FA80C1CC741201000A552
            09347D585B5B03111D556C2168B55A48D0F9782C0A269309B27C1652A914D439
            EBA0A9A9094A4CA6D53C21AD4F3DF374F02F80F3E7BE1C4BA7D3BD13DF4F80D7
            EB25740AA51209102AA432984AA0BBB363F7FFFCD763B8F9479CECEC1789443B
            DB894C26C327BBBAA0D6E9241A8DE673D7FEF6C1BB8091614F4530185CA05688
            16177F03BFDF0FA15008D46A35A8942AE07339D068B4D0EE7285552A9574D8E3
            D167D229A097BF1BDCCED8D5D909E5E5E5749D6627B64C369B2D7DB6EFB9DF77
            01A74F7DECC9E7F37DC15010E3F1382C2EDE22D7BCD71029DF68341025A3C41C
            85E404E1239A82961E3840ADDBCD8CA600399E27D41EDC399C5132C462B1608E
            CF8D1C3976F4109E3CE16E189F18F7E636D7C16E2B4156AB83709423533FFB50
            A160805A405A5B5B7179690962B1D8108D476B369B07AD362BF12FF8D1A0D703
            7D18C456A4C20AAB0954851A128C72C86504D271A0A309EBF7D59FB1CA85C38A
            AD355262D4A3C6500232AD910456EEE0959BAB5069AF24DDDDDD18F007C0E7F3
            1DA1004D4B4BCB49BBDD4EA6A7A7D11FF0039B8A1096A4B1D46A8622A389C8B5
            46BC7E7B0D7C81E0A758EF746ED9B221A6AA98018B560952050B495E80782607
            677F8980B9B4728AFABE9A4C2667E92370D33B1629148AD7E957452DB345C32B
            072A251C382D3AD0A9E42097CB21B69D05DF62187C898224565755C55A549C76
            9FBE80A8E56204B10C42F12D12E4789C8AC9000A548FDFB879E3A7FB15649DD3
            D92C15323F36C83952AA91A155C7020A59B2C5E7F1D7481A2EDE11C5B1ACB4EC
            78A55AFCC6F365481C163DF228865BE108F92AC0E192C8B090CB0975B373B3B9
            FB011C550E092DB0B91AD9A6BDA74C89E5663D4889401642EB78C69F85DBDBE8
            C6A6C64629ADDAF76D72E158239340097D571B8C19562586D9C8FA46FF959919
            FF5ECDACB1A1D1A166959E5A45AAF6118C834010AE0BC56439899FD0E05EBE5B
            68FB5DAE8AA2A2A227185ABED4EBF9583476F9BB8971E1413A66F3A38F49743A
            6DBBD16874320CB31D8D6E5CFEE2ECB07FCF6EFA6FE921E01FF5277ADCC83C3A
            4D1F7A0000000049454E44AE426082}
          FriendlyName = 'BTNCODIGO_PERFIL'
          TransparentColor = clNone
          JpegOptions.CompressionQuality = 90
          JpegOptions.Performance = jpBestSpeed
          JpegOptions.ProgressiveEncoding = False
          JpegOptions.Smoothing = True
        end
        object CODIGO_PERFIL: TIWDBLabel
          Left = 91
          Top = 192
          Width = 148
          Height = 21
          Alignment = taRightJustify
          BGColor = cl3DLight
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          AutoSize = False
          DataField = 'CODIGO_PERFIL'
          FriendlyName = 'CODIGO_PERFIL'
        end
        object lbNombre_Perfil: TIWLabel
          Left = 275
          Top = 194
          Width = 111
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clWebNAVY
          Font.Size = 10
          Font.Style = [fsBold]
          HasTabOrder = False
          FriendlyName = 'lbNombre_Perfil'
          Caption = 'lbNombre_Perfil'
        end
        object CONTRASENA: TIWDBEdit
          Left = 89
          Top = 165
          Width = 410
          Height = 21
          StyleRenderOptions.RenderBorder = False
          BGColor = cl3DLight
          Editable = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'CONTRASENA'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'CONTRASENA'
          PasswordPrompt = True
          DataType = stPassword
        end
        object BTNCONTRASENA: TIWImage
          Left = 505
          Top = 167
          Width = 22
          Height = 21
          Cursor = crHandPoint
          Hint = 'Contrase'#241'a'
          ParentShowHint = True
          BorderOptions.Width = 0
          UseSize = True
          OnAsyncClick = BTNCONTRASENAAsyncClick
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
            00180806000000E0773DF80000042C4944415478DAED94DB4F9B7518C79FA727
            DAB77DE9017AA087C8A914282301A21820960D10861A25E30225BBDA96A8376A
            624C3CFC01CE7557A2DECC1997186346614EC93615641886BAB5890ED8686530
            683B2CB495B7941EDEBEFDF9838B65C60577A157EE9BBCF9E5CDEFF0799EEFEF
            F73C08FFB1F021E07F0C709F70BF98CD64DC335452A9B477E4DC287FEF7C7FDF
            21659EE4C7DADADAAAC562F14BAFBCF6EAE80303DE7BF7B83DB5BD7DF5D2B7DF
            A843A130A9ADA9A9BB70E9E2FCBD6B7A7B0EBA66E7E7266D561B1CECE9898845
            A2E637DF797B794FC087431F18BC3EEF5193D1D4CFF37CC3E4E424B02C4B3639
            6E4822919ECE643303C5C57A9E650B3F5B5D597EABB0903D9C4824A0B3A393C8
            A4D2AB80385CED709C1A187C21FE37C0A867C44E871FA80C1CC741201000A552
            09347D585B5B03111D556C2168B55A48D0F9782C0A269309B27C1652A914D439
            EBA0A9A9094A4CA6D53C21AD4F3DF374F02F80F3E7BE1C4BA7D3BD13DF4F80D7
            EB25740AA51209102AA432984AA0BBB363F7FFFCD763B8F9479CECEC1789443B
            DB894C26C327BBBAA0D6E9241A8DE673D7FEF6C1BB8091614F4530185CA05688
            16177F03BFDF0FA15008D46A35A8942AE07339D068B4D0EE7285552A9574D8E3
            D167D229A097BF1BDCCED8D5D909E5E5E5749D6627B64C369B2D7DB6EFB9DF77
            01A74F7DECC9E7F37DC15010E3F1382C2EDE22D7BCD71029DF68341025A3C41C
            85E404E1239A82961E3840ADDBCD8CA600399E27D41EDC399C5132C462B1608E
            CF8D1C3976F4109E3CE16E189F18F7E636D7C16E2B4156AB83709423533FFB50
            A160805A405A5B5B7179690962B1D8108D476B369B07AD362BF12FF8D1A0D703
            7D18C456A4C20AAB0954851A128C72C86504D271A0A309EBF7D59FB1CA85C38A
            AD355262D4A3C6500232AD910456EEE0959BAB5069AF24DDDDDD18F007C0E7F3
            1DA1004D4B4BCB49BBDD4EA6A7A7D11FF0039B8A1096A4B1D46A8622A389C8B5
            46BC7E7B0D7C81E0A758EF746ED9B221A6AA98018B560952050B495E80782607
            677F8980B9B4728AFABE9A4C2667E92370D33B1629148AD7E957452DB345C32B
            072A251C382D3AD0A9E42097CB21B69D05DF62187C898224565755C55A549C76
            9FBE80A8E56204B10C42F12D12E4789C8AC9000A548FDFB879E3A7FB15649DD3
            D92C15323F36C83952AA91A155C7020A59B2C5E7F1D7481A2EDE11C5B1ACB4EC
            78A55AFCC6F365481C163DF228865BE108F92AC0E192C8B090CB0975B373B3B9
            FB011C550E092DB0B91AD9A6BDA74C89E5663D4889401642EB78C69F85DBDBE8
            C6A6C64629ADDAF76D72E158239340097D571B8C19562586D9C8FA46FF959919
            FF5ECDACB1A1D1A166959E5A45AAF6118C834010AE0BC56439899FD0E05EBE5B
            68FB5DAE8AA2A2A227185ABED4EBF9583476F9BB8971E1413A66F3A38F49743A
            6DBBD16874320CB31D8D6E5CFEE2ECB07FCF6EFA6FE921E01FF5277ADCC83C3A
            4D1F7A0000000049454E44AE426082}
          FriendlyName = 'BTNCONTRASENA'
          TransparentColor = clNone
          JpegOptions.CompressionQuality = 90
          JpegOptions.Performance = jpBestSpeed
          JpegOptions.ProgressiveEncoding = False
          JpegOptions.Smoothing = True
        end
        object ID_NOTIFICA_PRODUCTO: TIWDBCheckBox
          Left = 10
          Top = 222
          Width = 183
          Height = 21
          Caption = 'Notificaci'#243'n de productos'
          Editable = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          SubmitOnAsyncEvent = True
          Style = stNormal
          AutoEditable = False
          DataField = 'ID_NOTIFICA_PRODUCTO'
          FriendlyName = 'ID_NOTIFICA_PRODUCTO'
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object ID_ACTIVO: TIWDBCheckBox
          Left = 474
          Top = 222
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
        object IWCambiarPassword: TIWRegion
          Left = 606
          Top = 18
          Width = 314
          Height = 44
          Visible = False
          RenderInvisibleControls = True
          object IWLabel35: TIWLabel
            Left = 10
            Top = 12
            Width = 71
            Height = 16
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            NoWrap = True
            HasTabOrder = False
            FriendlyName = 'IWLabel1'
            Caption = 'Contrase'#241'a'
          end
          object MANAGER_PASSWORD: TIWEdit
            Left = 87
            Top = 11
            Width = 204
            Height = 21
            StyleRenderOptions.RenderBorder = False
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            FriendlyName = 'MANAGER_PASSWORD'
            SubmitOnAsyncEvent = True
            TabOrder = 3
            PasswordPrompt = True
            DataType = stPassword
          end
        end
        object IWRDETALLE: TIWRegion
          Left = 13
          Top = 249
          Width = 533
          Height = 166
          HorzScrollBar.Visible = False
          VertScrollBar.Visible = False
          RenderInvisibleControls = True
          object GRID_DETALLE: TIWListbox
            Left = 1
            Top = 1
            Width = 485
            Height = 164
            Align = alLeft
            Font.Color = clNone
            Font.Size = 10
            Font.Style = []
            FriendlyName = 'GRID_DETALLE'
            NoSelectionText = '-- No Selection --'
          end
          object IWRBOTONDETALLE: TIWRegion
            Left = 492
            Top = 1
            Width = 40
            Height = 164
            RenderInvisibleControls = True
            Align = alRight
            object BtnGrid: TIWImage
              Left = 8
              Top = 73
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
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    RenderInvisibleControls = True
    Align = alTop
    BorderOptions.NumericWidth = 0
    Color = clWebMEDIUMBLUE
    object DATO: TIWEdit
      Left = 400
      Top = 0
      Width = 121
      Height = 32
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
      Left = 0
      Top = 0
      Width = 400
      Height = 32
      HorzScrollBar.Visible = False
      VertScrollBar.Visible = False
      RenderInvisibleControls = True
      Align = alLeft
      BorderOptions.NumericWidth = 0
      Color = clWebMEDIUMBLUE
    end
  end
  object IWModalWindow1: TIWModalWindow
    Left = 640
    Top = 16
  end
end
