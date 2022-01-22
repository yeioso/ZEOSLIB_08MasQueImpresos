object FrIWVisualizador_Log: TFrIWVisualizador_Log
  Left = 0
  Top = 0
  Width = 845
  Height = 488
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  OnCreate = IWAppFormCreate
  Background.Fixed = False
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  ProgressIndicator = IWProgressIndicator1
  DesignLeft = 2
  DesignTop = 2
  object ARCHIVOS: TIWListbox
    Left = 16
    Top = 160
    Width = 561
    Height = 310
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    OnAsyncDoubleClick = ARCHIVOSAsyncDoubleClick
    FriendlyName = 'ARCHIVOS'
    NoSelectionText = '-- Archivos con coincidencias ---'
  end
  object IWLabel1: TIWLabel
    Left = 16
    Top = 64
    Width = 93
    Height = 16
    Font.Color = clNone
    Font.Size = 10
    Font.Style = [fsBold]
    NoWrap = True
    HasTabOrder = False
    FriendlyName = 'IWLabel1'
    Caption = 'Fechas Inicial'
  end
  object IWLabel2: TIWLabel
    Left = 16
    Top = 101
    Width = 148
    Height = 16
    Font.Color = clNone
    Font.Size = 10
    Font.Style = [fsBold]
    NoWrap = True
    HasTabOrder = False
    FriendlyName = 'IWLabel2'
    Caption = 'Criterio de busqueda'
  end
  object DATO: TIWEdit
    Left = 160
    Top = 96
    Width = 417
    Height = 23
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'DATO'
    SubmitOnAsyncEvent = True
  end
  object FECHA_INICIAL: TIWEdit
    Left = 110
    Top = 61
    Width = 91
    Height = 21
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'FECHA_INICIAL'
    SubmitOnAsyncEvent = True
    Text = 'FECHA_INICIAL'
  end
  object IWLabel3: TIWLabel
    Left = 296
    Top = 64
    Width = 75
    Height = 16
    Font.Color = clNone
    Font.Size = 10
    Font.Style = [fsBold]
    NoWrap = True
    HasTabOrder = False
    FriendlyName = 'IWLabel3'
    Caption = 'Fecha Final'
  end
  object FECHA_FINAL: TIWEdit
    Left = 377
    Top = 61
    Width = 200
    Height = 21
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'FECHA_FINAL'
    SubmitOnAsyncEvent = True
    Text = 'FECHA_FINAL'
  end
  object BTNBUSCAR: TIWButton
    Left = 16
    Top = 124
    Width = 561
    Height = 30
    Cursor = crHandPoint
    Caption = 'BUSCAR COINCIDENCIAS'
    Color = clBtnFace
    Font.Color = clNone
    Font.Size = 10
    Font.Style = [fsBold]
    FriendlyName = 'BTNBUSCAR'
    OnAsyncClick = BTNBUSCARAsyncClick
  end
  object RREGRESAR: TIWRegion
    Left = 0
    Top = 0
    Width = 845
    Height = 50
    RenderInvisibleControls = True
    Align = alTop
    BorderOptions.NumericWidth = 0
    BorderOptions.Style = cbsNone
    object IMAGE_SALIR: TIWImage
      Left = 0
      Top = 0
      Width = 60
      Height = 50
      Cursor = crHandPoint
      Align = alLeft
      BorderOptions.Width = 0
      UseSize = True
      OnAsyncClick = IMAGE_SALIRAsyncClick
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000800000
        00800806000000C33E61CB000031E14944415478DAED9D079C14D7B5A74F55E7
        9EEEE9C991613203026582B250B084922D4B4842C8926C4BB22527D9CFCF6F7F
        FBF62D60EFBEE0B77EBBB665059413B6724039211042208124402411260F4C4E
        DDD3A9BAAAF69C7B6F5557CF0C08B0607A06DDA1E9545DD55DE7BBFF73CE4D25
        BD72FB0C5DD375B0C91224341DEC78AFE23DDE8106003248A0E31F3EC5FF81DD
        D3FFF41959C27B7A15FFD98CC7F41989EFCB26F16D55DABFC43FA9EA7CDFECB3
        9ACE3E41CF25891F970ADB16FF25B4E4B63A7E4E65C7496E2B89F7AC8F698709
        E318ECBB0318BF2FE53D89FF06FCC71ED347CDE38FB22D6D47DFDD2E7EE7F0CF
        D1FDB7EFDBCA7FE4382A120170F64DB7B3934A27D9BC370D3E3A00E66BEC241A
        8F35BE579DBF0E0208323437852E1EF33D180690CCED34B177B63376C225CB71
        34711C10C7E45F081F6BC963D17B9A30A4240C45DF4B92C47BE273FC3D7A4EA0
        E8FC4FD3CDDF45DB68E2F8C6EFE1EFE929BF190F0691DEBDD0B0BB717C03D0F3
        F172880D85C08E554C55930A60133585552E3A71128782A8A79AA28A134A8FD9
        C9C522939AA8F43EDFD650162A093C6154736C4269584D9245AD562D35901440
        7C0F63DFAA067C9F625B56EBC57E24715C5673ADCA2100A4DFA55BDE33BEBBAE
        258FC714807E8B2D753FFCF8FC7DBB9C540EE373D1B80A8DFB82DF00F00D00DF
        00F00D00E3AC8C0AC040280E8AA2B160C70880AC005031834066335D80020200
        100024033F3308D4F8E7681B72F9BA38464A10660D0285618D20CC660DBC80EF
        E72B01B00681D6E30BDF9E3CBEF82DA36C6B0D025D2E1BF8FC19004A7C6202D0
        D61546E3CB60F7B8CC9348BF2C1A4FC0E6A6FE4D1BF6F4EDC213A7B380914564
        EC64F30778AE249E25E8DCE6926E6C0BEC7CB39A4BDBE83CB0025DA80A65236C
        07B42FDA564B6ECB432F9D6D9BB27FE373C66301A76E1E431C54EC73D87BFCDB
        E377D3257EBCE1C7D7CE9B9AAD7B1C36DDE776E85EB74DB7E9FAB9B9250573F3
        727D10EDEC98B80078333321273B03A27C335643484AFB83D1F8D2B7F7DCB76C
        75D31A00D00FE2A61DE46BD6D70FF4BE483552B6D1BE623FDA571C43B3DCACCF
        D59FCC2D55F37D0E6D72815F9B9CE7D55DA02ECA2C2A5C9C93E99AF800E46779
        21A1C420E172633591452AA84370280E2FAE6B79FAF72FED787EA203306F7A8E
        5A12706A53CBB2B5A9257E3DCBA1230005C708000137A8F108E83607A8080148
        B291A44338A2C09AED5DABFFE9F18D7747152D31510128CF71A995B96E6DE694
        026D5655B65EEC85459985F9130C801B6F876E04208E00D80400194C01108068
        08B7B281EE7082EE74628466373F1C8D29B0BDB97FFB6F1EDFF49F2D3DE1C189
        0800DDA6E47BB4B9279468E74CCBD3CBFDD2227F5E2E03208200906B8C0800BE
        B3743C02F063AE00DDA3BA00042012E25B5228ECF4E0CD4179124B07E8D7C615
        15B70FEDFBE5C39FFDFBB6D6C1D6890B403102908F0000029067026055808907
        40402880B93542E0F20238EC203B934A403979CF4064E8B74F7FF11F6F6D6CDF
        32A101F02100F9130A80E908C01D08C0CBC300088C040078CE96B07B510C9C08
        810D8CDE01CAA0068231F5817776DF7DDF5BBB574C6C00C805B81180760B00A1
        630300A345CE9EE107CDEE04975BB803894310C20C61F9FAD6E7FF65D9E6C727
        1200E72200E7520CE0930400C315601C0370D681B28061002444AB1BEB45F3F8
        C0E9F582EC9058F3ACD15C388419C2DA1D9D1FFDF3939BFED839100B1FEB00E4
        3D9657A468CAB9033F18787AAC0D3E3A009805F47CB27F005CB92590C06050C5
        403F9ED0D8364A4207A75D06D98D3181DB0776A704B22DF9FB63B104EC6C1BDC
        F58B0736FCAEBE23D47BAC0250FA44695D5BB86D65BE3BFFBEAE9BBB7E3BD606
        1F01C072720137FE1815E015888543ACB3A3AD3B1500777E19D8BC7ECC7B5B20
        1A1A10630680771C51878EDD0D724600DC6E9977A488D3A06086D0D11BEEBEF3
        C14F17ADDFDDD3389100C8B6A68131159ADA470250F1D7F2BAE660CBCA226F51
        91A66B4BDA6F6A4F4F00CEFADE8F50015E3515602F01E04FB6031000CA6037D8
        734A21DED7013184C061E37D048AAAB34E1DD9E1047B662EC604122609490828
        43E81B8844FEF7B35BFEEDF9B52D1B2602003E5200FF4805B8F2FE240079F7FB
        CEECD5C3AFCEAF9A9FD519ED849DFD3B97ECBD716F9A0270C36DD0B3FEB51400
        3CFE643B80BBA00C12035D108FC520A3B81222837DA087FA58D7AE2ABA53A99B
        166C0E90FC79E04077E0728A7321FA10068351F5C9950D4BFFE3856DCBC73300
        930D177000004A96FACFEC96636F5E55F95D5F656615ACEB580BBB06762F69FD
        5E6B7A02702602D0FBC96BDC055801305C800020168D30F9F71494634C1084A1
        DE6E667CBB9CACF1D456A0FBF351091CE074A8207A01D9590D0DC5E0CD0D6DCB
        FF79D9A67BC33175B4E6E3B404A056A481070340D952FFD51D72ECC985B5D7BB
        A38908E47B0A604BEF16D83358BFA4F986E6340560E1ADD04B0A101EDA2F000A
        02A044A36C8C804396C19E37195DC12048E13E738C8061688D3A571102AFDF8B
        AE4249793F1C89C3E77B7AD6FFFCFE0DBF6BEF47A2C61100E730006051263504
        8D02C09DA734CFEF71EA4F61CDB7C7D518041321A84605F8A2670B34069B9634
        2C6C4857006E41005E3F2000F1FE2E50E3513628C281353E8E594046611948BA
        0AD1EE7D20C60298359E6509D905E0C1605296A26C8086A1129421B474041B6E
        BBE7E3FFFE655BB06B3C00402EE08C69394C0172F3F30500ED2CF52500EE4E34
        C3DFAA83891B6A6FB07747BB20AA4619F8557E0E404BA865C9EEEBF7A41F002F
        FFE838138038024051FCBB9DF9D09F7B325CE95C0D4E2DCA0088F675829E88B1
        21549218AE45696048F7805B1B62ED02CCC67272C8376DE3CDC903D99F0B6E1B
        B90FDD3C308D38EAEA0BF7FEE2C10DFF63CDF6AE2FD31B00B776C6F185DAA9D3
        73F42A9F6D51496E814803DBD96F7EC4BD171EC80B02067CD013EB46E3474012
        B4570905681D6A5DB26BC1EE3405E07A0460431280373A8A6020F724B8CAB112
        5C7A147DFE648808006473E89664AA059D0C63BC188B0565DE32C8DB0C64903C
        7EF0164C023B84F1F39A79701583C87ECC10FEFCEA97BFBFFFEDDDABD21200CC
        742B8B5CDA29330AB41367E4E8755EFBA2DA6C3E2024D2D10E7FCA6886E77263
        B0A0E63A68196AC1C0580110E6E70A500D9B7B49019A97EC5E90A60A70C6821F
        42DFA76F8C02C0FB08408CA5815174019A12C5804F863886FE0ED1E8D3DA1586
        5C3C19D40CCC8243CC0E303860FB2105304E84CD9D012E7CDF6547884031BF00
        352D07835178764DF3FDFFB26CD3B2B403C005EAA41297366346BE36F5B86CFD
        049763D14999450C80FF39B416DEC905B8BAEA2A680DB78E303E3DAECAAC4605
        F8029AC905A4AB029CB1E00708C09BFB05C0953F09E203DD2C06A0DAAD08F927
        2568ED1A82028C15E8739EE22A96F753C028C579133241404AC1DB0A5CE09F54
        83DB2A20EB51F34B103C3D7D61B8FBB52FFF78EF5BBB5F482700A46C492D99E4
        D56AA6E56815D3B2F49936C7A239DE82C57FC8DE05EBDC0A5C59F11DA80FD58B
        4931A9C6A778886280CDE90CC04B04C07508C0671C004AE95E470006F3920038
        F326B18620351E334707A3FD1908FB7AC25092EB613FDD5B5205E1F646B0E595
        833ED40F1A6608E4069CE8068C3E0487D301DEE21A90ED68F49E4EE81D88C0DE
        CE2034EF1D80E59F773CF251C3E023E9048063B2432D28F36A6553B2B4A2DA80
        3E1B6C8B5E77362EDE5B920D97955F0A0DA10673469424C64E1AC6A73F026053
        CF661604A6650CF0D26D04C0F71180B752148000F82E02E04600EC3925A0867A
        4157627C88B588F4E3340EA03F0A85396E665C5280584723828146CF9D842A30
        04E1FE1E735C3F9D1436AC1BDD4860CA4CB8EB811760281C4795D0D867D6B784
        1FF97C5F24AD00F09EE055734ABD5A4175A626554ADEADAE86E5550575732F28
        3D1FEA83F5C913398AF1A97005D80C0DC1C625F5D7A7611A48009C7EEDCDD0FF
        F9DB2301B073052000B4500F9E8E38977F56A33516F9F70E44210F5D009D3652
        00A5AB91199BD2441FA6894A2C06B1BE0EF380C678FDCCDA53E0DFFEF48CF97A
        BA0290754E961A4000ECD5B2674F69EB6B33F2A69F755EC9DC83323EFD4F59C0
        A6EECDAC21A87161533A02306D0400EFD7EB10F695C145453D2C0DE40AD00392
        1A673EDD61E38120D5ECAEBE08CB024805BDC59590E8696227414968ECDE9D5D
        083125012AC605BA3829F4B9F10240E1770A54B95A2AD857DBF1CC69C5734E3B
        0963A3E6A1268B91F76F7C10ED00044053BA66012F2200675C7333F411009121
        661C4AED320299AC66535F803D1B0118EAC5882ECE6A3DB5FB530D7761204031
        4096DFC1823C6F510568BD2DF8BECC5480FC3EA985EECB03BB1D93C0AE567650
        3B03E0D4710140FE4FF3F3BA6674BD8DC6AF3B54E3533100684ED7188000387D
        FE4DD0BFF11D5301F676270785D2380047B688015001C42C6B66600702405940
        96CFC9A4DD8D699ED2D3CA524492790A00A967904070F9B22134845984C28F91
        59730AFCFB9F9F4D6F006AA102FE019E9D577E715D494631B447DA0FC9F87457
        E9AF6600BCD7B662233EDD38D606DF0F00372200EF8E00801420114600728A51
        01FA581640C655C4BC3F3A012D9D435088A0D073776105843B9B78B48F70901B
        302656D2DCFFDEC11864232C760380BBD218805AA8815FC36BF3265F5C78B8C6
        A7FF2B510182F120340C3680B55364B4472081754F29FB49792EEDFF78A37F46
        1A7E18F6FF2B8DAF0900AEFE1EF46F7A1762E170723C8000400907C149412002
        906000C83CB513ED007BD1051467BBD977F22000B1EE66E61E9C762965F227C1
        D04700F80D004E46009E4B4F004E8713E59BE5A7E6575F55E8B43BA137D67B58
        C6A7F7B39DD99061F726ADCB5A4B93FB4AFDAC04E61ECDED24F37D49EC93BF2D
        99869552F62599DBD2FFB2F5B9B8B7C936C873E5C38FDEFF09482FDC4A00DC80
        00BC675180089B189287353B3E1404172A801EE967113D1B0EA6F2DC9EA78111
        E62A584B2002A0620CA0A8C999BB46431075980C0411000C185910587D12FCC7
        5F9E4F3F002E8739F215F233F3ABAEF2FDBDC6A7621A5B8C991CBEAF64ED944C
        431AFB4EEECBD8CE6868925261002B1496F7211516764FB39B65274CC99C06B7
        BD7F8715007201618B0B083005880D0D3200A4683F2A409CAF1B200241322EA5
        81593E178B093C85E5A0F7B70A83EA02120E4B389E80C1509C6D4B9F25007E7F
        F70BE905C03570B6F322E7130B6AAECD886B71185482C9610E47D5F81635308F
        391C0ECBBE21B96E43B235524ADDDE028BCB46004C450084029C76D542E8DFFC
        1E03C09E02800B6221528022906203A0D27C783DF983E931A58199190E3632C8
        83793F0CEC651D408A183C6A284024AE4130148340869329438000B8E7C5F401
        E066B8CC7996F3FE85B50BEC914484F5E55BEBD7DF6D7C1D46D460A3A41A6BB8
        F1471A3379EC240A56038F34BE759F12385101EA10805B9902DC42005C8F00AC
        482A400F8D090CA0B42300E402B28B00A203A0631AA88AD536787B0077177E04
        80523B37F519F4EE35FDBF24D4825423A6A84C0108007A3D507322FCE73D2FA5
        0700DF872B7C67FBEEB91E8DDF87921F66DDB947D7F8A68FDF9FF147D4788B6A
        583F6F317AB2E6A702E6945D5017980AB7ACB89D0330070118D8840044520160
        0A30C415806200595598B453844FCDB754D3290B28C0ED68750E4F411944BA5B
        F9AA1A6C2C6032F02545A09547482DE8A5AC6A04E0BE3400E076B8D537DBF7BB
        1B6A17823190C3306BBA187F6420C89FC8C38C6FDCCB29B23FDC0520003617BA
        803AB875052AC0F3B74CD54FFBAE50808870013D915400B20B410B0F80AC2784
        E12526F964641A425E94C5B300367AB8AFCDF4FF8AB1ADAA33E5E8172E804A56
        D509F07F96BE3CB600DC013FCE3B2D6F11067C2CCD5334C562FAB1307EEAF629
        5EFD108D3F3C6E307F9719040A0578FE8753F539DF5D00039BDFB72880C80228
        080C0D32055011009BAEA4ACFD43815F675F14F2339D3C084405D006DAB9FF17
        0B4F3A04089425501A18F039D8670308C01F962E1F3B007E018BF34ECDBB9506
        72B40EB508E38B13AC1F1DE3D32A4CAA86950A2B96AAA9407F9A4EA32E35760F
        C0D368BE3E61F2BBC8C37CBC4DB6834D92D94D966C6097ECFC5EE68FED32BFD1
        6BDC050C07E0CAEB60E08B95A900F833D9408F5838086E04801440C293642C04
        6513DDC194050458108800600C20873AC4E28CFC6C1BD9023DEF611903770181
        AAE3E10FF7BF323600FC02164D9E33F9D6CBCB2F83B6A15666006B6389D5B856
        D35907B71EAAF109B0981A83B81603058F4759065FC07274A3EEEF5E3E98D725
        39C5E71B8F6D0C0A3B64D8336046D60970C7CA3B417A8E00F8CEB530B0651507
        006BEE3E7201991C006A0770E7A00B880CE2A953D80ECDA565D9B4F028F8DC76
        BE7C406E2940B093D57E45741651614BC9A109BA090084857692553903FEF0C0
        AB4717003FDAEA5770D7E4BAC997D2408E86503DAB69C38DCF06B699D27C78C6
        57D0C0144F504611D5A2EC380765BC23647CE35E662EC00DD3B38F875F7DF0DF
        10801F900220005FAC1AE10272FC4ECC0C42E0C9296000E809452CCBC6FD3F95
        F6DE88D9BCEB4200629805507660AE3B6CA8013E2700685BE6021080FF7AF028
        02E0071B1AFF4F53A7D75D7A5EC979D0166EC5EFA65AFCA7615A7998BF353C71
        32FFB51ADF84874607A3B143983E861361DC772225104B17E3D39FCB8600641D
        0FBFFCE09F407AF60775290A900C020900172808801B01D0A383AC1D8022FFE4
        A2CA140446A080BA83F1CF93570A098C019815446391B19E9F2A00C84100E8FD
        40C574F8BF0FBD76740028020FFC033C725CC5B49917945E000DC17A8B5FB5D4
        6AB0B6B6598D6FA9FBC38C1F4349A706A350226802353C0A4F27E3D3762E4C03
        09803B3FF88D00E0DBD720001F403CCA5D80A100D46E4F9D41AEEC0290624148
        24E262A54C60411D9F481A815CBF03250F01C82D017BB83B45FE8D76007AAD67
        20860038181C9995C7C1FF7BE88D230F0037FEC3A7549F327376C14C1A9E6DD6
        6549447CC9A87978AB1A8C303EFDB17510D0E0FDF1010420BA5FA3A4A3F1B902
        B8E0B80001F08F1C80D957CC8781ADAB531420C3EF872C5400EA0E7667E583A4
        84201157F81C401107D08EC905647AED2CDA77E6148336D8C96A17CF02C0548A
        98A261C0489D410280F269F0C747DE3CB20094432E1AFFD1D3CA4F9B72F2F0BE
        7C6B8FDA411A9FFC787FAC1F06947E5EDB0F609474353EEF0BE00AF0F355BF36
        00B8DA042055013800AE401EC8CA1028E802924BB5F293D7D98F7E3DC3CE023D
        52002DD4C5E606F06D74F34B5067503F75060905F0974F853F3DFAD691036032
        1AFFD7F0C4DCAAB95535816AD817DECB0DA34BC2C860FE2719261F617CFE98D2
        B2BE581FF4C57BCD25F5C7ABF10D05981E98013F63007C7F8A058088250D140A
        101D0267661ED813439050E2FC4B887576E95477F445581A4893C59DD945200D
        F598FED318084A2E80FA02060400F4BA7FF254F8F3636F1F1900AAB1EEFF0A1E
        9C5735AFB434A3043A22ED29C6351A5C52CC2F255D4132E0D351E6FBD96C1F23
        5B18EFC69785024CCB420056FE0348CF8C02004B0311008AD80900873F171C5A
        1801E02D6546064035B9035D00E5F624F9D4609418EC62E7562C1C0E223B4205
        D04C0520F5F097D5C15D4FBCF3F503500D348AE7D1CBAB2ECBCFF3E44277B47B
        3FC6B79EB8D41A4FCFC34A18DA23FB305F57869DF8F16D7C4301A6A102FC74E5
        AF10809B0980AB10800F31088C24DB0198027000A21AFA784905AFCB66560E59
        18795F2F0F02E9B18762007401300C002A315280508CB503907A644C9A02773F
        F9EE1103E092CA79F92554FBA31D66BD367CB9BE1FE3D3431577458A3180359F
        52C289667C2306981A98CE01789A00B8FCBB30B08D03601700789802701740C6
        0C4614F07B1DE072DAC14893E88C930250644FAD821E54005BA407C4D441F3C4
        9375E20A0720E0E5B0644CAA85BB97BD77645C4005E4A30B78E4E2DA8BAACA7C
        65D019ED480DF82C35DD6A7CCAE12956E02D8313D3F8F4E7B439615AE60CF8C9
        CA5F0A002EBB12015893540034AAD7C715401500D0EFEC0D2AEC35B7D39E6C08
        A2F1001E3B0B8E5C598560C76049D38D683AE92AE2090E00650C54BCA5B570CF
        B2154706004B10787AF9E955A7E69F0C2D43CD906CB74B46FB42A8A00B212177
        C14FD2C4353E7D656A092405B8E3FD3B417AEA26528024004905F0310520008C
        5C9E4A4F48614DC42E878D5998A5816E1BEB22766615F0F90346638964F409F0
        8922830880DFC315C4535203F7FEEDFD230700DD9741007E0EF79C31E5F499A7
        149C0CADA156181EED536DA759BD9144F898303EFD3E8A01A6661E07B773006A
        F559A80083DB3E321B82F6F54651017C4201C2C94BC588D48E94A020DBCD72FF
        8E7ECC023C0EDE149C5D004AB09BA58AE655460C03930204E3E02300249A4656
        03F73D758401B034044DAF9C3EF3A249174253A8D194006ABA6D0E3571C93F46
        8C6FC40075010460C52F40FA1B0230FBD2EFC0C0F68F2C0A10050F0180598016
        0B03BFAE07BF248B26DAF5FBC30AE423043D34D297F9759DCD02D2C2BDA6FC1B
        4DC2ACA6A93C0BF0BBEDEC4BD03CC2FB9E5E75E401309A827F04FF35E3F8E917
        5D54F62D06415009D2844D96E31F4BC6A73F52803A54801FAFF8390270232AC0
        A5DF86C1ED6B2D59002A803FC30420D9059CBC30141FE0A18084AFE561164012
        4F9D46B668BF258B3682000100BA009FDB50806A587AB400B0740695D7955F7A
        C9E48B6075C70796D6BC63C7F8A60220003F5AF13390FE8A00CCBEE40A18D8B1
        6E9802240148F6ED4BE28290FC3941D0D91F83E21C37DBC611C803677CC06C00
        320240AB021800B88B2AE1FE67571F3D008CEEE01FC2BF16CD2C5C7076C999B0
        BD7F9BD9A47DAC18DF5400FF34B8CD0060D6BCCB615000608D0168F48E164328
        BC7E48C4A26C4088F006662D3746FFD27C405A28D216EB3715C3AA020C007417
        3C064017301600580684E49C927DEBF965E741FDE06E3658E358313E6DC70685
        664E835BDFFB2902F03D04E092CB53150001F0642415C0E1CF06D9E901659096
        8951CC9A6D047974A395C3ECFE5C80D88049870980CEAF17D82700A0BE0206C0
        731F8E0D0074FF33F8C7AC995977CE4377B07B702728BA724C189FFE9C42016E
        79EF271C8099F32E4305F8384501B80BC0E08E14C087006851B0B9FD10E9EFC1
        205015174F4E067A6CECBF4A63D31290E1B273062C2D82AA981B68A6818515F0
        C0F36BC60E00BABF1D6EF1CFF6FFEEE2C917C2DE481B7EFFC88437BE2414808D
        097C17015876430DBA80CB500110003436A570ED7D4201325001E21170F8B240
        52A3B85B3C77EE4CACE47DA069AA59C3E95E16097637B5F7FB5DE076D9535C80
        AA7200D8F0318A010ACBE1C1173E1A5B00E8FE36B8D17B9AF75FBF5D7999BD35
        DC622EF136518D2F019F19548B0AF0C377EF400016D6A0025C8A0AF0090740A6
        3EFE28B833B8021800C8B4F02146CDBC292913A2837D780A55762665030489CF
        05E81F52584FA2C765330131A691190A40003CF4E2DAB107806E37C2A5DEB9DE
        A5A80476EAEBA7C11E13D5F8461650EB9F0A3F78F776909E5C586D5180A85080
        C8E80A400000B7B4EEF2436CB09FB903598C0F302EB14AA50F53449A5C4A8D45
        F4E5180083D1641A5830191E7A695D7A0020A68639CE74DC7565D51519FD4A1F
        04138313D2F85C0110005F1D7C9F00788200B8F8520680128B266300AF970781
        4A140108809C88E14793B2CFEA35BA83E800CD9ED5F87C01895D935504893A2A
        4182CD2D703A647E612906808D7D319A44F2F0CB1FA70F0074BB14663BAE743C
        7349C5C5192AC4A12FDE37E18C6F6401357E04E09D1F0B002EBA0406BE441710
        E500B018000108D0004E0583C00C04408D2515C080805D45CC0F4AB00FE24A82
        B5145AC7D3901AF4A13BA0E9E37460A600860B40001E7AE963B065168023A714
        223D6DF0F1D686B4981E2E5D21FDED8ACA4B03B4B46D4FBC6742199FFE1C1403
        F8A6C2CDEFFC08A4C7AFAF1200ACB72800BA00AF88014801323241D2E20C8094
        163E01818CD941B0B7970589D2B0E174D42630804A9093E9647303FDA22FC09D
        5706CB1BDC9039F54C0887C3D0BD6535ACFEE083B107809ED7428DF46BE9954B
        2ABE55E871B8A13BD675D8C677C84EB0D38C1CAB81C53D8CF2FC40A0C996E7F4
        4F1EC5F823BF532A24F48F6606556454C14D6F1B007C6B1E03201E4B2A80DBEA
        02BC999806C6472A8028B4E244DCE60565A89F4781C30A6B364625A055457C1E
        1BFB22EEBC5278A531037CB573201C8940EFD60F61F5EAD5E90100DD8B25622E
        2C3BAF30DF9B0BEDD17D8755F3ABFC3590EFCE8794F97E92A194625BF19EF9BA
        B10FB042917CDDFCE428DBA74C459320E57548510E096E7CFB36901E5B400A70
        3102B0211904F623001E2F6F078873052000526380240924FD096A18B20486FC
        4B26B7A59820AA68E076F2F969EEBC49F072BD1BBCD5B32082AEA77FFB47B066
        CD9AF401806E35908710BC31B7ECDCBA49FE62D817693B64D9AFF455C3B6DE2F
        E183BD1F9A863B5019F5FD6153D646FFDCC847C6D3FDBD3710C340F7B1EBAAF4
        99175D84007C8A2E403404F5C5C02300485100485500C3C0C6AA2132A601AA23
        03E208012D0AA54A76D895288468B0176604226C09795A62968E41B3885EDCE5
        0067E5A910430006777D02EBD6AE4D2F0050BCB26FC9CAEB9BD9FFF6ECE29975
        27E44D87A6A1C643F2B76C95B02E5A2EBE6DC98E6B76FE16D2AC7000BEF52D18
        D8F9694A10C85C40062A00AD104E00E84A2A0096A660832B960EEA32E84E2F2A
        411F34E49F07EEEA3360CB962DD05BBF19263943901D6986CA1C27641597C1B3
        3B24B0959DC4AE4514AEFF14D6AF5F9F7600E45C94ADDA6AA4CCAEE37B5F9853
        3CEBAC13F28E8396708BF8BD5FED0E480136767D41835196ECB87657FA01F0E8
        7595FACC0B2FE200C486650126007EB0E9140324FDBB0100883366AC1FCC2682
        6260A8D9DCD033E737505B370D56AC58012DDB37801D83C58E752FC1B45C1D66
        9E500BCF6C0368D3B260C78E1D705A45003EFBECB3B403C037CBA76696BA357B
        8DEC69AEEE7C6D5AEED4B3CE2F3B071A43F5FC047E45B45FE9AB82CF3BBF80C6
        60E392DDD7D5A71F008F5C5BA9CFBAF05BD0BFF353330BB006811403D8BC3EB6
        36800CA300A0F333469D4874AF9A5D81126CABF931E41614C1E6CD9BA1A76527
        ACFDE45308A84198E28FC1BCD3EBE0F53D32EC8978A0ADAD15664EF2C1A64D9B
        D20E00D714979A5DE2D6F22AFD9AAD1ABCDB32DB9EA92DAE9B7741D95C68A295
        C2413F60AAC701D80C4DC1A6253BAF4BC3A562098099175C0803BB3E335D4007
        0190E161AB7910005C01147EB50F3D79F68D2660A33388023DC3FE5456254E80
        763D075A5B5B418F0E40B8A71D82DDDD50EE8DC2E5674C81F79A656856FCD0DB
        DB07D37365D8B41901D89B5E00D80A6D6A6E894B9B5413D00AABFD7AC94062D1
        EADC7D8BA3D3F2E0AA9A6F634CD03072EAB7257F27003EEBD8C4968AFD321D5D
        C0C3D754E8B310807E024028C02791C9102D9D05737A96831314B07B5001F0DE
        069AD9D46BCD04AC81A04DDC53E98CBB60E9160784C23138BB488150448186A6
        7D501AB0C1F9A756C35B8D1870422E048341A8F2C6D21200C800B5A0C8A9554F
        C9D6CA6A33F5F298BE283FE85EBCFCB84E68AE72C1FC9A2B1904E6620FC31A79
        2A30062000E892316919033CC400B8005DC0E7A60B5813A980F8A4D9705AD7F3
        E092120C003B24D0C8BA3922C8844017B37FC50521B812A4C24161624473C096
        FA4EE8606308ED70E2B44A7866AB025DF64288611058047DE909800DD4A23CBB
        366D6A8E56531BD06BECD2A222082CA661EE8FE47C097B8EF7C2C229D7C2BE28
        AD34A28E68E12305F8942940BA0230BF5CB880CFCD76808FA21C80399D060019
        60C77BEADBB38EF6D120D9156C5C11C4180A668D0F747132BA07E36C7A19F50D
        641514C3A39F47219653CBB6B775ED4C4F00F05696EDD04EA8CBD1A6D564EAD5
        5E7951556EE1E21802B0676733BC5AD50F9B4F76C24D531722046D625209A4B8
        800D1D1B990B48CB34F0C1ABCBB9021800C8044025280C80E71000AC046E2F9B
        1A260B17606D0348594C8181909C4340C5AA06348B28533405BBB20AE0D18DB1
        7101407996539B5D97A71D5FE5D7CB3CB0A86252C9E20CB71D766D6B80EE501C
        DE2C1D8075B324B869DA42E8577A21C6AE19C863820A0100B980EDE90AC0CCF3
        CF4700369A2E800150361B66773CC714800070CAE8E3748D9F7D4B0AC88DACB3
        9543C8D834F4CB5821DC0C12C56718005E1BFB8C1B01786C537C5C005091EDD4
        4E9F5AA0CDAC08E8456E7551C9A4E2C594227737B640EF90026DFD317835A70F
        369C0B895BA6DF6C1F50FAF8C211120150091BDA37B22B87A66510F8E05504C0
        79D0BF7BA39905AC8D55310066B51B0078C025F37362550043E6553DB91ED0C8
        D9F5C94C814D25F7F0A961AEAC7C7862B302510380CE1DB0E98B2FD212804A04
        E08C6985DAECCA805EEC5417E54D2A5A9C956187BEE65636AAB863200E5BDB86
        E0C96B42F3FBBDD25337D42DB0EBB202617508CA332A617DC7E7B067A03E3DDB
        011E6000CC4505D864BA8075028099FB9EE5310029808D52402D65D6AFE90AF4
        640C401788608B470C9B1B48DBB2A9E4A800F49C00789200F09782B36B3BC8C1
        76D8D016495B00CE4400E65465E94508404E69E1E22C2F0700C4DA073BF686E0
        37AFB749A577675CDDE5541EBD75FAF77D04419E3B1FD6B77F0E5FF6ED5CD270
        7D1A5E33E8FEEF4ED66721007D0880E1023EE974413C5006339D8D9806A202B8
        5001EC9801689AC8028C4522C8B2FCD2F109617443F6CD038881A16C51C9DE28
        0380CE2CAD3AF2CCAA1D7C3129B6F6B0061FD38090B40720B128A7A47031CD72
        EE6B6E61BF2FAAE8D0DA1D86DB5F6A61CC17DFEB3BB3C71E7FF37B5317F8A666
        D7C28AD60F607BEF8E254D0B5BD20F80A504C079E70A0062BC216820066EB71B
        48E668653002C08D0050078F51EB8DBCDF680330225F7207D65E402356A05EE2
        8EDE30DB277DCE8D003CFFE14EF38B28690E00B980D3AA027A21294071217301
        BD4DAD02000DDA7A222600547297FACEEC93C2AFDE3CF586AC7DE10ED8DAB375
        49CB0D6D6908C0956508002AC06E7401510E402701E071B1B9FC6C6938A10034
        B4DB30BEE1D78D74D02E275B028D5A6F00C0165EC03768B069360340C720300F
        5E1806C02708C06769084085A10018033017C01440B8002C94120E07804AD5DF
        2AEA1A83CD2B4B334A8A545D5DB2F77BFBD20F80FB0880B9E720009B59AF9C09
        80DBC59A825525C601B00900247175704B7E671818C47B4670684C2BA76898DE
        E731005F4B8014E0C58F76A500F071BA028069E099C771000A1DDC05504F696F
        534B8A02DCF172EB88CEFAD2274BEADA86F6AECCF7E4DDD7755377FA0170EF77
        9200A4BA0017EB0DD450011C2E1ADDCB2777D80C49D79353C68D944F12A3830D
        4858602896932117D06E0481B8AD27900B2FAEDD6D22C400681E4A5B000C1750
        8000E48A18A0976200E000ECED1D1D002AD98F661525B4C4B9C11F869E1E6B83
        8F02C0247DE6B9E7601A9854004A6B5200C0C70480C616801467484FB6FB5BC7
        0618C6B6C9A931025B4FA84728000320075E5A576F7E91F100C09CCA4C540075
        516E2977013D4D1C00EE02A2F093E5A30390CE45BAF7DB08C0DCB33108FCC2E2
        02E2E0723BD980108A019C1810DA659DF57AB18B426A6CC500734978BB58119C
        0D5C94B9DC1B81A1AA275B0669F9B96C8F2D09C0C70DE30880028B0B28620090
        0BA042FD02AD08C04F5F198700DC7305017016BA8051006041A08200D0859E74
        737958ABBFA7C7366338B858414416D9804D6C6BB804BAB844B6C750806C58FE
        49630A00EBD21480F22C070B02A921A8D09E482A40630BFBCDB400562B06B83F
        7BA56DFC0170370230EBDC33A177F7961400DC4201687148A7CB259688D5CD59
        4086C4D3CB3420D421B200E372B10A0303CC6B07D07E2957CE124DC19ECC6C78
        657DD3B801E08CA9DC0514D8D551016823005E1D8700FCE5F252130065580C90
        8D00280C002733A66CE6F4E27A019A6E5E49948CCFDC828D8F5F67355F288371
        A129528080313B38330B5ED9D03C3E00083844533001400A50240068E6310001
        D017839F8F5B00CE19A6008308001A9D4605D3B5021D4E54001B057DC9EE60A3
        0BD8C13A817433FAB7CA3E6D6B5C3CC22ED6200E780C05C882D73E6D31DB8B69
        A10902E0D37406A02215806E038004650151F8F96B7BC71F00775D56C201D833
        D2053005882BA0C936B64A280BF6343E0790F70A721A8CF180462145E09D4362
        D5707C2ECB92B9A41C0720135EFFBC2DF9993407807A03670900F227152DA6F5
        0E7B1A9A2D2E2006BF787D3C027069893EF39C331080ADCC05C8C30140174006
        8C691214065CCCB73B84FC1BD70332660053A1DAAF0A6530B6312E1F47630DFD
        6EBE58A3DB1780373625014820006BD3148062BF5D3BA922473B71924F2FF7EA
        8B2AAA27710530001069E09D6FEC1B7F00FCF99262548033A0C70A807001D92C
        0854D8195128D2C314D0EFB527D33F7101492A860AF0AB8A19AB70D22BC66251
        7C41A924007E786BF33EF38B28690C40AEC7A6D514FBB5EA3C8F7E5CB66DD1A9
        27563005E8AEB700800AF0CBF108C09F0880B34F4700B699412001E0703AF8F2
        6F71E35A7ABCD7CBEEB0B1E55E8DC61EF202C67840666E8932027E591959D47E
        E39EAE2D4000B015423232E1AD2F2C00882090BA84D30D00BF4BD64A73BC5A69
        C0A99F5CE05C74FE9C1A0E408335064000DE1C8700FC715EB15E5C560A43BD5D
        28C30996AF47E22AB850016811689A106AB6F0E183705C039FC7C156FFD00C1F
        AF894E20E0C6A6184151931982A1145D0840265B1F00C095E18377B6762401E0
        0AF00002F0C07E8C3F9AA187BF0EFBD9463BC063E333FB0342F5DA252D37D3A5
        E56538F5D34A5C8B4FABCB5FECC4DF34D437C07E34FD363A67BF7AB37DFC01B0
        BF37965D5F3D4755B50F5D36CD4E469644071019AF3FAA417EA68B4F35A62C00
        2C0088ED9219802EAE34AAB31820E0E68B321200EF6E1B01C03D08C03D16630E
        37241CC47B87F3DA815E4F816652964B733B247D32DED7E4BA74045AF7BBEDFA
        E2375B0C98C6553920B14F2EA8BA25A1241ECC70C9E20A60C2A868CC0846BE34
        7388823D9B654D602A8AC8147853306F33A0B6838E7E02C0C69E3B3C19B0627B
        67F233B8F38F9A86EE4300EEDD8F51861BE860DFFB3AE0D82F18974DCB8ABFB6
        BD3F31D6863CDCF29592F5C47595776989C4CF68691756AB85AC93D1075109E8
        CA622EBB6CC6009A9ECC028CF600A33005F018007811802EF31B2430C8440096
        AE6F0B2F3D0803011C9C210FF4DEDF0583D721272AB29DE16D9DD1E48CD97158
        BE128065D755D8B1B2BF81B1C085D4166048BC61708220D74F178E04736C2019
        D866C8BFD1642CD1B50562906500E0F6C0FB5FF698C7211780003C8000DC0F47
        C6E0077AEF505E238387F0665C667C5C97830A5AFEBAA0220F3380B5E8EE6A5C
        0ED9ECF7A7208FFAC2C3981DB0AB81018F011C32DFB511081A5711A585270C00
        6890C9CA9D3DE6972017B0A671E84104E0C1833002C0C1190B0EF3BDFDED9B0C
        3F68797FDC97838E5AD1154C5755759DCB2EF9DC76D96C10A2128EAB6CED109A
        F4616401647463D2A8D136400D4C4900DCB06A676F4A53302AC0439FB4861F86
        C3AFD95FF776C68D6A3B7E59888FB5C1BEEE724869CB93D7D75E1E8B465F0988
        A1DDA4047C2C204030A6B2AB86F85C7C0998B808048DDE43DAB66B3006391976
        A61236A70B56EFEE33F74D00AC691A7A0401A07680833520C09131B8F11AC93D
        062A101C6B431DA972C879EB23F3CB176338B8C4E3E4033B1CB264067A839104
        EB3360CDC03A3057600C1DA37B9A1B9847978FA74E230180F105C8057CD838F4
        2802F0181C9ABCC3616E7FA0ED28A5233ABB20D9563021CB61355C3C764DC5B3
        1814CEA7EB06C962CD1F634734558A1A8928333052469B081C7B8271C8F7F3AB
        87DB1C4EF8B0BEDFFC12A40008C0E31F7300A81CA8165B1F7FDDEA3084B7BD30
        4182BCAF2A8705C0B2EBCA7D68AFD5B2AE9F44337DED36CB45986849588420CF
        EF6401605C04829412120005991C00D9E1808FEA07CC7D0A0578E2E396F01370
        68D26F7DFCF7B80D6AF3A6DEA9DEB136CAD12C87DD74B9ECDAF20A34EE5A1481
        2292FCE415C2E8A64328A2F2390000664351775081420300BB03D6365A00409F
        B1BA31B40C015806872EE5A3BD76B06E83BE22B548D120FF719DD31F4EF9BBDA
        AE1FBFA6E2DC84AABEEB76C876E372F174C73B7F74E81B4A402EFA7C76208996
        92B72880CD0EEB9A92B11529C0EA86D05FD7B584FF2A5E3AD4540E0EF27DEB73
        4AE91A80CBFE3159FEEECE8BC7AE29BF05D3C307334423912C06805209616640
        2EC1EFE199412F0291EF1740D86CF04973C8DC0FC5001F3484FE86003C05475E
        FA49EE694C7AB233E2182D5F4BEF1542702F56F9DB33A89D5FCC0C32DA01A8AF
        9CE2003FBEC7560F3700409958DF92AC78A40008C0D36B9B1900548E84F4D38D
        FC3C197FDCB6DF7F9DE56B01E0C96BCBED18E4BD8381FF5C5202638C804DCC1C
        1A08ABAC4188064F9A0048326C68B30080A0AC6A083D83003C038717048EF69A
        F539A5753B6002E7F48753BEB6FE6B0C0A8BB0D6AF75D9A50A32B6A6F3360255
        7421F784F8DA39060044C6676D61F35B5010B8AA3EF8EC47CDE1E7E0F00D3EDA
        6BD47A47866F1DEB939D8EE56B1DC0F0C4B5E527624DFE909A8BA9CFC026279B
        814915A8DF8014C2289FEF8B985F811460657DE8F98F9A879E87C3F3EBC35FA3
        E89E261E6C876FE47EBFE56B1FC1F2F0D593AFD635EDB980E81730AF3A2A4929
        5DC35436B647CD2F41B1C2CA3DA117D6340FBD0887DFB2673CA65C7E13DEFAC7
        F6F4A67F392243981E9D3F79B10CFA125A1ADE2EC603DA6D230FB5C900400CAC
        7C7F4FE8C5354D432F89B7BF2AD01B6D9B18DE36E3AD714CCFEA382A476C0C1B
        42F0A2AEEB5792121863078797CD1D51F30B08005EFEB069E865F8EAF67E18B6
        0D35E0EC015EEB95313B9BE3B01C31009EB866B28F5A0A5D366986D7259B6D03
        D6B2A533D9DC4E41E07BBB83CB1180E5E2A583F5F7D461F3091C634DB85F5739
        A2A358975D3BB922A268EBFD6E5B1E750E0D2F5B3B63665C400A8000BCB2BA71
        E85538387F4FF47C8AB75DF04D39EC72C487313F7A75D90578903731FAB70F8F
        03B677C5CC6F4159C0BBBB82AF7DC001A0B23F0828BAA7B46E034CC0011A47BB
        1C9571EC8FCF9FFC53B4DD5F8C6B061A6547772C1903A80C80D757350CBD0EFB
        AFF5D4744B17DFE91EEB133751CA519BC8F0F8FCB207D0F6B7B2114302829D3D
        31F1252406C0DB3B836FAC6A08BD09236B3D3518D07566B78FF5099B68E5A801
        F0D76B27DB15557FDF6193CEF28AC6A0DDBD4905A7BE80B77606DF5A59CF00A0
        620CC9DA8A37BACCF837727F04CA519DCA8441615142D5D7BB1CF224B743863D
        7DF11417F0D697C1B7DFAF0FBD0DDCF87B3164785FD5BFE9B13B92E5A8CF657B
        ECEAB213F1EE438C077CCD838AA51D408737BF1C7C67457D68B9CF29AF0AC5B5
        2FC6FAE41C0B654C26333E7255D9754E9BF454774C339790C134B07BE3DEC8BF
        35F4C5EF59D7128E8DF5893956CA98CD667DF8AA49FFAB27AADD8E2EE125ACFD
        4F05E3EAAA3FACEEFAA6D3E62897FF0F0A95773698540BE00000000049454E44
        AE426082}
      FriendlyName = 'IMAGE_SALIR'
      TransparentColor = clNone
      JpegOptions.CompressionQuality = 90
      JpegOptions.Performance = jpBestSpeed
      JpegOptions.ProgressiveEncoding = False
      JpegOptions.Smoothing = True
    end
  end
  object IWProgressIndicator1: TIWProgressIndicator
    Mode = pimAsync
    ProgressTextSettings.Text = 'Espere por favor...'
    ProgressTextSettings.Font.Color = clNone
    ProgressTextSettings.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
    ProgressTextSettings.Font.Size = 12
    ProgressTextSettings.Font.Style = []
    Left = 640
    Top = 72
  end
end