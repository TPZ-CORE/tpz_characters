
MP = {

    CustomizationTitle = "Customize your new character",

    DefaultCustomization = {
        ['male'] = {
            ["heads"]        = 0x89556A4D,
            ["hair"]         = 0x61EE957A,
            ["eyes"]         = 612262189,
            ["bodies_upper"] = 0x16e292a1,
            ["shirts_full"]  = 0x432D9454,
            ["coats"]        = 0xEF0E7141,
            ["legs"]         = 0xa615e02,
            ["pants"]        = 0xBA8C46C8,
        },

        ['female'] = {
            ["heads"]        = 0x1E6FDDFB,
            ["hair"]         = 0xFCC7C1BC,
            ["eyes"]         = 928002221,
            ["bodies_upper"] = 0x79D35251,
            ["shirts_full"]  = 0x60A8561A,
            ["coats"]        = 0x5655418F,
            ["legs"]         = 0xAA25ECA7,
            ["pants"]        = 0x0A750034,

        }
    },


    --Badge       = 0x3F7F3587,
    -- armor       = 0x72E6EF74,
    --RingLh      = 0xF16A1D23,
    --RingRh      = 0x7A6BBD0B,
    DefaultHashList = {

        ['gunbelts']          = 0x9B2C8B89,
        ['masks']             = 0x7505EF42,
        ['holsters_left']     = 0xB6B6122D,
        ['loadouts']          = 0x83887E88,
        ['coats']             = 0xE06D30CE,
        ['cloaks']            = 0x3C1A74CD,
        ['eyewear']           = 0x5E47CA6,
        ['jewelry_bracelets'] = 0x7BC10759,
        ['skirts']            = 0xA0E3AB7F,
        ['ponchos']           = 0xAF14310B,
        ['spats']             = 0x514ADCEA,
        ['neckties']          = 0x7A96FACA,
        ['boot_accessories']  = 0x18729F39,
        ['pants']             = 0x1D4C528A,
        ['suspenders']        = 0x877A2CF7,
        ['gloves']            = 0xEABE0032,
        ['satchels']          = 0x94504D26,
        ['gunbelt_accs']      = 0xF1542D11,
        ['coats_closed']      = 0x662AC34,
        ['belt_buckles']      = 0xFAE9107F,

        ['belts']             = 0xA6D134C6,
        ['accessories']       = 0x79D7DF96,
        ['shirts_full']       = 0x2026C46D,
        ['gauntlets']         = 0x91CE9B20,
        ['chaps']             = 0x3107499B,
        ['neckwear']          = 0x5FC29285,
        ['boots']             = 0x777EC6EF,
        ['vests']             = 0x485EE834,

        ['hats']              = 0x9925C067,
        ['dresses']           = 0xA2926F9B,
        ['hair']              = 0x864B03AE,
        ['beards_complete']   = 0xF8016BCA,
        ['hair_accessories']  = 0x8E84A2AA,
    },
    
    BlackListedHashDecSigns = {
        [970109184] = true, [1552938618] = true, [1992764136] = true, [-1752273802] = true, -- heads
        [1065163858] = true, [1559811913] = true, [1798796230] = true, [1986660907] = true, -- eyes
        [2105864149] = true, -- satchels
    },

    CustomizationOverlayElements = {
        moles = {
            label = "Moles",
            txt_id = "moles_tx_id",
            opacity = "moles_opacity",
            vis = "moles_visibility"
        },
        spots = {
            label = "Spots",
            txt_id = "spots_tx_id",
            opacity = "spots_opacity",
            vis = "spots_visibility"
        },
        complex = {
            label = "Complex",
            txt_id = "complex_tx_id",
            opacity = "complex_opacity",
            vis = "complex_visibility"
        },
        acne = {
            label = "Acne",
            txt_id = "acne_tx_id",
            opacity = "acne_opacity",
            vis = "acne_visibility"
        },
        freckles = {
            label = "Freckles",
            txt_id = "freckles_tx_id",
            opacity = "freckles_opacity",
            vis = "freckles_visibility"
        },
        disc = {
            label = "Disc",
            txt_id = "disc_tx_id",
            opacity = "disc_opacity",
            vis = "disc_visibility"
        },
        scars = {
            label = "Scars",
            txt_id = "scars_tx_id",
            opacity = "scars_opacity",
            vis = "scars_visibility",
        },

        eyebrows = {
            label = "Eyebrows",
            txt_id = "eyebrows_tx_id",
            opacity = "eyebrows_opacity",
            vis = "eyebrows_visibility",
            color = "eyebrows_color",
        },

        grime = {
            label = "Grime",
            txt_id = "grime_tx_id",
            opacity = "grime_opacity",
            vis = "grime_visibility"
        },

    },

    CustomizationElements = {
       {
            label = "Head Types",
            type = "slider",
            value = 0,
            min = 0,

            tag = "heads",

            action = "facials",
            
        },
    
        {
            label = "Body Types (Full)",
            type = "slider",
            value = 0,
            min = 1,
            tag = "bodies_full",

            action = "facials",
        },

        {
            label = "Body Types (Upper)",
            type = "slider",
            value = 0,
            min = 0,

            tag = "bodies_upper",

            action = "facials",
        },
        
        {
            label = "Body Types (Lower)",
            type = "slider",
            value = 0,
            min = 0,
            tag = "bodies_lower",

            action = "facials",
        },

        {
            label = "Waist Types",
            type = "slider",
            value = 0,
            min = 1,
            tag = "waist",

            action = "facials",
        },
    
    
        {
            label = "Hairs",
            type = "slider",
            value = 0,
            min = 0,
            tag = "hair",

            action = "facials",
        },

        {
            label = "Eyes",
            type = "slider",
            value = 0,
            min = 0,
            tag = "eyes",

            action = "facials",
        },

        {
            label = "Teeths",
            type = "slider",
            value = 0,
            min = 0,
            tag = "teeth",

            action = "facials",
        },

        {
            label = "Beards",
            type = "slider",
            value = 0,
            min = 0,
            tag = "beards_complete",

            sex = 0,

            action = "facials",
        },

        {
            label = "Hair Accessories",
            type = "slider",
            value = 0,
            min = 0,
            tag = "hair_accessories",

            sex = 1,

            action = "clothing",
        },

        {
            label = "Hats",
            type = "slider",
            value = 0,
            min = 0,
            tag = "hats",

            action = "clothing",
        },

        {
            label = "Masks",
            type = "slider",
            value = 0,
            min = 0,
            tag = "masks",

            action = "clothing",
        },

        {
            label = "Eyewear",
            type = "slider",
            value = 0,
            min = 0,
            tag = "eyewear",

            action = "clothing",
        },

        {
            label = "Neckties",
            type = "slider",
            value = 0,
            min = 0,
            tag = "neckties",

            action = "clothing",
        },

        {
            label = "Neckwear",
            type = "slider",
            value = 0,
            min = 0,
            tag = "neckwear",

            action = "clothing",
        },


        {
            label = "Vests",
            type = "slider",
            value = 0,
            min = 0,
            tag = "vests",

            action = "clothing",
        },
        
        {
            label = "Loadouts",
            type = "slider",
            value = 0,
            min = 0,
            tag = "loadouts",

            action = "clothing",
        },

        {
            label = "Suspenders",
            type = "slider",
            value = 0,
            min = 0,
            tag = "suspenders",

            action = "clothing",
        },

        {
            label = "Shirts (Full)",
            type = "slider",
            value = 0,
            min = 0,
            tag = "shirts_full",

            action = "clothing",
        },

        
        {
            label = "Dresses",
            type = "slider",
            value = 0,
            min = 0,
            tag = "dresses",

            action = "clothing",

            sex = 1,
        },

        {
            label = "Skirts",
            type = "slider",
            value = 0,
            min = 0,
            tag = "skirts",

            action = "clothing",

            sex = 1,
        },

        {
            label = "Coats",
            type = "slider",
            value = 0,
            min = 0,
            tag = "coats",

            action = "clothing",
        },

        {
            label = "Coats Closed",
            type = "slider",
            value = 0,
            min = 0,
            tag = "coats_closed",

            action = "clothing",
        },

        {
            label = "Cloaks",
            type = "slider",
            value = 0,
            min = 0,
            tag = "cloaks",

            action = "clothing",
        },

        {
            label = "Ponchos",
            type = "slider",
            value = 0,
            min = 0,
            tag = "ponchos",

            action = "clothing",
        },

        {
            label = "Bracelets",
            type = "slider",
            value = 0,
            min = 0,
            tag = "jewelry_bracelets",

            action = "clothing",
        },

        {
            label = "Gloves",
            type = "slider",
            value = 0,
            min = 0,
            tag = "gloves",

            action = "clothing",
        },

        {
            label = "Gauntlets",
            type = "slider",
            value = 0,
            min = 0,
            tag = "gauntlets",

            action = "clothing",
        },

        {
            label = "Gun Belts",
            type = "slider",
            value = 0,
            min = 0,
            tag = "gunbelts",

            action = "clothing",
        },

        {
            label = "Gun Belt Accessories",
            type = "slider",
            value = 0,
            min = 0,
            tag = "gunbelt_accs",

            action = "clothing",
        },

        {
            label = "Satchels",
            type = "slider",
            value = 0,
            min = 0,
            tag = "satchels",

            action = "clothing",
        },

        {
            label = "Belts",
            type = "slider",
            value = 0,
            min = 0,
            tag = "belts",

            action = "clothing",
        },

                
        {
            label = "Accessories",
            type = "slider",
            value = 0,
            min = 0,
            tag = "accessories",

            action = "clothing",
        },

        {
            label = "Belt Buckles",
            type = "slider",
            value = 0,
            min = 0,
            tag = "belt_buckles",

            action = "clothing",
        },

        {
            label = "Holsters Left",
            type = "slider",
            value = 0,
            min = 0,
            tag = "holsters_left",

            action = "clothing",
        },

        
        {
            label = "Chaps",
            type = "slider",
            value = 0,
            min = 0,
            tag = "chaps",

            action = "clothing",
        },

        {
            label = "Pants",
            type = "slider",
            value = 0,
            min = 0,
            tag = "pants",

            action = "clothing",
        },
    
        {
            label = "Boots",
            type = "slider",
            value = 0,
            min = 0,
            tag = "boots",

            action = "clothing",
        },

        {
            label = "Spats",
            type = "slider",
            value = 0,
            min = 0,
            tag = "spats",

            action = "clothing",
        },

        {
            label = "Spurs (Boot Accessories)",
            type = "slider",
            value = 0,
            min = 0,
            tag = "boot_accessories",

            action = "clothing",
        },

    },

    Overlays = {
        ['eyebrows']     = {
            { id = 0x07844317, albedo = 0xF81B2E66, normal = 0x7BC4288B, ma = 0x202674A1, },
            { id = 0x0A83CA6E, albedo = 0x8FA4286B, normal = 0xBD811948, ma = 0xB82C8FBB, },
            { id = 0x139A5CA3, albedo = 0x487ABE5A, normal = 0x22A9DDF9, ma = 0x78AA9401, },
            { id = 0x1832E474, albedo = 0x96FBB931, normal = 0x32FA2683, ma = 0xA1775B18, },
            { id = 0x216EF84C, albedo = 0x269CD8F8, normal = 0x2F54C727, ma = 0xCCBD1939, },
            { id = 0x2594304D, albedo = 0xA5A23CD1, normal = 0x8611B42C, ma = 0x0238302B, },
            { id = 0x33C39BC5, albedo = 0xF928E29B, normal = 0x46C268BD, ma = 0x4B92F13E, },
            { id = 0x443E3CBA, albedo = 0x6C83B571, normal = 0x2B191070, ma = 0xD551E623, },
            { id = 0x4F5052DE, albedo = 0x827EEF46, normal = 0x70E8C702, ma = 0xD97518F9, },
            { id = 0x5C049D35, albedo = 0x41E90506, normal = 0x7E47D163, ma = 0x54100288, },
            { id = 0x77A1546E, albedo = 0x43C4AE44, normal = 0x290FC7F7, ma = 0xD8FC26A9, },
            { id = 0x8A4B79C2, albedo = 0xAE6ED4E6, normal = 0x89B29E5A, ma = 0xFA0476E4, },
            { id = 0x9728137B, albedo = 0x23E65D35, normal = 0xEE39073F, ma = 0x218DD4C8, },
            { id = 0xA6DE8325, albedo = 0x7A93F649, normal = 0x22B33B65, ma = 0xEE6CCF11, },
            { id = 0xA8CCB6C4, albedo = 0x29AD8BF9, normal = 0x34ABB09D, ma = 0xCF206860, },
            { id = 0xB3F74D19, albedo = 0x3E2F71B1, normal = 0xD4809D11, ma = 0x9ABFA640, },
            { id = 0xBD38AFD9, albedo = 0x058A698E, normal = 0x9A732F86, ma = 0x2EF1D769, },
            { id = 0xCD0A4F7C, albedo = 0xED46998E, normal = 0xB5B73A38, ma = 0x15C5FB78, },
            { id = 0xD0EC86FF, albedo = 0x81B462A2, normal = 0x894F8744, ma = 0x51551810, },
            { id = 0xEB088A20, albedo = 0x0C6CDBDC, normal = 0x91A2496E, ma = 0xE639F138, },
            { id = 0xF0CA96FC, albedo = 0xAC3BCA3F, normal = 0x667FEFF8, ma = 0xDD8E5EFF, },
            { id = 0xF3351BD9, albedo = 0xC3286EA4, normal = 0x8BB9158A, ma = 0xFBBAE4D8, },
            { id = 0xF9052779, albedo = 0x8AEADE78, normal = 0x21BB2D97, ma = 0x75A0B928, },
            { id = 0xFE183197, albedo = 0x92B508CD, normal = 0x6AA92A3E, ma = 0xB4A436DB, },
        },
        ['scars']        = {
            { id = 0xC8E45B5B, albedo = 0x6245579F, normal = 0xD53A336F, },
            { id = 0x90D86B44, albedo = 0xA1538E6F, normal = 0xDFCB1159, },
            { id = 0x23190FC3, albedo = 0x39683ECE, normal = 0x249C1A0A, },
            { id = 0x7574B47D, albedo = 0x3AB2A0BB, normal = 0x7A70886A, },
            { id = 0x7FE8C965, albedo = 0xB81C8D16, normal = 0x7210971B, },
            { id = 0x083059FE, albedo = 0xC332710C, normal = 0x860EE45E, },
            { id = 0x19E9FD71, albedo = 0x40895310, normal = 0xB753C5C7, },
            { id = 0x4CAF62FB, albedo = 0xD80F2F64, normal = 0x00BBF225, },
            { id = 0xDE650668, albedo = 0x85F6BF71, normal = 0x3DD0B0AE, },
            { id = 0xC648562B, albedo = 0x6397E4D9, normal = 0x2B59CDA1, },
            { id = 0x484BAEF8, albedo = 0xBF2946DE, normal = 0xD3F2F2F6, },
            { id = 0x190F5080, albedo = 0xCBBDB741, normal = 0x9518FA34, },
            { id = 0x2B5DF51D, albedo = 0x0E05C415, normal = 0x8B8C57AC, },
            { id = 0xE490E784, albedo = 0x50853115, normal = 0xDA7F2A1E, },
            { id = 0x0ED23C06, albedo = 0xAEA45D76, normal = 0x364DAAA6, },
            { id = 0x5712CCB6, albedo = 0x9318AF61, normal = 0x98104C8C, },
        },
        ['eyeliners']    = {
            { id = 0x29A2E58F, albedo = 0xA952BF75, ma = 0xDD55AF2A, },
        },
        ['lipsticks']    = {
            { id = 0x887E11E0, albedo = 0x96A5E4FB, normal = 0x1C77591C, ma = 0x4255A5F4, },
        },
        ['acne']         = {
            { id = 0x96DD8F42, albedo = 0x1BA4244B, normal = 0xBA46CE92, },
        },
        ['shadows']      = {
            { id = 0x47BD7289, albedo = 0x5C5C98FC, ma = 0xE20345CC, },
        },
        ['beardstabble'] = {
            { id = 0x375D4807, albedo = 0xB5827817, normal = 0x5041B648, ma = 0x83F42340, },
        },
        ['paintedmasks'] = {
            { id = 0x5995AA6F, albedo = 0x99BCB03F, },
        },
        ['ageing']       = {
            { id = 0x96DD8F42, albedo = 0x1BA4244B, normal = 0xBA46CE92, },
            { id = 0x6D9DC405, albedo = 0xAFE82F0C, normal = 0x5CF8808E, },
            { id = 0x2761B792, albedo = 0x4105C6B3, normal = 0x8607CC56, },
            { id = 0x19009AD0, albedo = 0xEBC18618, normal = 0x9087AF96, },
            { id = 0xC29F6E07, albedo = 0xF9887FA7, normal = 0x1331C3C9, },
            { id = 0xA45F3187, albedo = 0x1C30961A, normal = 0x3CA2F3AE, },
            { id = 0x5E21250C, albedo = 0x01E35044, normal = 0x5A965FF0, },
            { id = 0x4FFE08C6, albedo = 0xA65757F2, normal = 0xC46CC005, },
            { id = 0x2DAD4485, albedo = 0x358DEFDA, normal = 0x55D317B4, },
            { id = 0x3F70680B, albedo = 0x7073A58F, normal = 0x33E73C5F, },
            { id = 0xD3310F8E, albedo = 0xD9E8A605, normal = 0x22297EA5, },
            { id = 0xF27A4C84, albedo = 0xE0F0971B, normal = 0x9F0E6718, },
            { id = 0x0044E819, albedo = 0xFD844ADF, normal = 0x315A6D56, },
            { id = 0xA648348D, albedo = 0xC329F765, normal = 0xE8CD7F20, },
            { id = 0x94F991F0, albedo = 0x8586D19B, normal = 0xCA334396, },
            { id = 0xCAACFD56, albedo = 0xD2D0BF4F, normal = 0xE0203BDA, },
            { id = 0xB9675ACB, albedo = 0x2387AF71, normal = 0x90A80AE1, },
            { id = 0x3C2CE03C, albedo = 0xC6DCBCCA, normal = 0x609B7EBD, },
            { id = 0xF2D64D90, albedo = 0xC6DCBCCA, normal = 0x609B7EBD, },
            { id = 0xE389AEF7, albedo = 0xDF591FF2, normal = 0x11D92A14, },
            { id = 0x89317A44, albedo = 0xB4640D19, normal = 0x2F56FDA5, },
            { id = 0x64B3347C, albedo = 0xFF2E8F96, normal = 0x45EE7B10, },
            { id = 0x9FFDAB10, albedo = 0x8F2950D9, normal = 0x85BDD7E8, },
            { id = 0x91D40EBD, albedo = 0x5DCD1D4E, normal = 0xA1B5F71F, },
            { id = 0x6B94C23F, albedo = 0xF17FE41C, normal = 0x0C480977, },
        },
        ['blush']        = {
            { id = 0x6DB440FA, albedo = 0x43B1AACA, },
            { id = 0x47617455, albedo = 0x9CAD2EF0, },
            { id = 0x114D082D, albedo = 0xA52E3B98, },
            { id = 0xEC6F3E72, albedo = 0xB5CED4CB, },
        },
        ['complex']      = {
            { id = 0xF679EDE7, albedo = 0xFAAE9FF0, },
            { id = 0x3FFB80ED, albedo = 0x1FDFD4A1, },
            { id = 0x31C0E478, albedo = 0xC72D0698, },
            { id = 0x2457C9A6, albedo = 0x98F1C76F, },
            { id = 0x16262D43, albedo = 0xE0D03293, },
            { id = 0x88F312DB, albedo = 0x2ECCC670, },
            { id = 0x785C71AE, albedo = 0xAE1C329F, },
            { id = 0x6D7D5BF0, albedo = 0x23201E55, },
            { id = 0x5F2FBF55, albedo = 0x94503F97, },
            { id = 0xBF38FF6A, albedo = 0x5F62F986, },
            { id = 0xF5656C26, albedo = 0x83417009, },
            { id = 0x03A408A3, albedo = 0x1BCC4185, },
            { id = 0x293453C3, albedo = 0x6C556574, },
            { id = 0x43150800, albedo = 0x1E486F85, },
        },
        ['disc']         = {
            { id = 0xD44A5ABA, albedo = 0x2D3AEB2F, },
            { id = 0xE2CF77C4, albedo = 0xB8945AC0, },
            { id = 0xCF57D0E9, albedo = 0xB15E4E47, },
            { id = 0xE0A8738A, albedo = 0x25A711DD, },
            { id = 0xABD109DC, albedo = 0xCEBED6D9, },
            { id = 0xB91C2472, albedo = 0xFDD6C9AB, },
            { id = 0x894844B7, albedo = 0x7E89B165, },
            { id = 0x96FAE01C, albedo = 0x458799CD, },
            { id = 0x86D3BFCE, albedo = 0x8F2F2826, },
            { id = 0x5488DB39, albedo = 0xB49A0275, },
            { id = 0x7DA5A5AE, albedo = 0x8200F51D, },
            { id = 0xE73778DC, albedo = 0x8D35AC90, },
            { id = 0xD83EDADF, albedo = 0x96B619CD, },
            { id = 0xE380F163, albedo = 0xAB7309F7, },
            { id = 0xB4611324, albedo = 0x26FEBDD4, },
            { id = 0xC6ABB7B9, albedo = 0xC162C835, },
        },
        ['foundation']   = {
            { id = 0xEF5AB280, albedo = 0xD9264247, ma = 0x1535C7C9, },
        },
        ['freckles']     = {
            { id = 0x1B794C51, albedo = 0x59B8159A, },
            { id = 0x29BFE8DE, albedo = 0x03FCF67B, },
            { id = 0x0EF6B34C, albedo = 0x21E2FD82, },
            { id = 0x64925E7E, albedo = 0x3FD45844, },
            { id = 0xF5F280FC, albedo = 0xE372E00E, },
            { id = 0x33B0FC78, albedo = 0x288810E0, },
            { id = 0x25675FE5, albedo = 0xEB8C0B1D, },
            { id = 0xD10F3736, albedo = 0x3885AC2A, },
            { id = 0x5126B75F, albedo = 0xB061C984, },
            { id = 0x6B8EEC2F, albedo = 0xE1D1113E, },
            { id = 0x0A9A26F7, albedo = 0xA1EC1AEA, },
            { id = 0xFDE40D8B, albedo = 0x6DBC9203, },
            { id = 0x7E338E44, albedo = 0x097D1D0A, },
            { id = 0x70F273C2, albedo = 0x81A25BCE, },
            { id = 0x61C7D56D, albedo = 0x197A1335, },
        },
        ['grime']        = {
            { id = 0xA2F30923, albedo = 0x16CDD724, normal = 0x136165B3, ma = 0xF3DFA7AC, },
            { id = 0xD5B1EEA0, albedo = 0x0E599D69, normal = 0x5C67FB68, ma = 0x40FEC59E, },
            { id = 0x7EC740CC, albedo = 0x0FAE8DC6, normal = 0x9E7A4B63, ma = 0xB48BF65A, },
            { id = 0xB08F245B, albedo = 0x98358521, normal = 0x1FAA4A84, ma = 0x81428E8F, },
            { id = 0x1A5E77F8, albedo = 0x8D3D2563, normal = 0x1FAA4A84, ma = 0x81428E8F, },
            { id = 0xE81B9373, albedo = 0xAE43378D, normal = 0x0CBEEF9B, ma = 0x92097B22, },
            { id = 0x3CFA3D2F, albedo = 0x7499570E, normal = 0xA27FF667, ma = 0x24B49749, },
            { id = 0x0B865A48, albedo = 0xB80F6B12, normal = 0x377319E3, ma = 0x3CDC25A9, },
            { id = 0x506DE416, albedo = 0x537BA522, normal = 0x006AF092, ma = 0x5CCEA9F8, },
            { id = 0x1F250185, albedo = 0x51BE975D, normal = 0x3F718027, ma = 0x5527ACCF, },
            { id = 0xE71930B0, albedo = 0x595D09A3, normal = 0xF4E08D43, ma = 0x60B91CE7, },
            { id = 0xDE571F2C, albedo = 0xE7FAFDFA, normal = 0xE6A18BBF, ma = 0xCB315A57, },
            { id = 0x0CA6FBCB, albedo = 0x0E27372E, normal = 0xD4894921, ma = 0xBF339D56, },
            { id = 0x21F62669, albedo = 0x693623F0, normal = 0xDB95176C, ma = 0xEA27B375, },
            { id = 0xFB09D881, albedo = 0xC4A40DA0, normal = 0xADD1DC3D, ma = 0xFD797A87, },
            { id = 0x11530513, albedo = 0x67C6D30F, normal = 0x26AA38C3, ma = 0x89C2FFE3, },
        },

        ['moles']        = {
            { id = 0x821FD077, albedo = 0xDFDA0798, normal = 0xE4E90C92, },
            { id = 0xCD38E6A8, albedo = 0xE9CF623E, normal = 0x43FAEA4B, },
            { id = 0x9F9D8B72, albedo = 0x27450B2F, normal = 0x0808DBFB, },
            { id = 0xE7179A39, albedo = 0x38638E0B, normal = 0x99346057, },
            { id = 0xBB094249, albedo = 0x763F8624, normal = 0x6975D6F9, },
            { id = 0x03AC5362, albedo = 0xEF158115, normal = 0xBA297751, },
            { id = 0x154FF6A9, albedo = 0xEE28E6F7, normal = 0xB7548307, },
            { id = 0x1E23084F, albedo = 0x566ACE2F, normal = 0x361237C6, },
            { id = 0x31DBAFC0, albedo = 0x0AB0CC2B, normal = 0xDBF55701, },
            { id = 0x3AC5C194, albedo = 0xC940CC25, normal = 0x41CB48FC, },
            { id = 0x4500D516, albedo = 0x3A1EEDB1, normal = 0x17BC19B0, },
            { id = 0x3695B840, albedo = 0x1D30222E, normal = 0xDA5FDF7E, },
            { id = 0x286C1BED, albedo = 0x4F0B4FA8, normal = 0x40333534, },
            { id = 0x934BF1AF, albedo = 0x4540A8D7, normal = 0x933ACF76, },
            { id = 0x84F55502, albedo = 0x47BE6D32, normal = 0xDCF7108E, },
            { id = 0xBD9A464B, albedo = 0x9DABB1B9, normal = 0x4A3B1739, },
        },
        ['spots']        = {
            { id = 0x5BBFF5F7, albedo = 0x24968425, normal = 0xA5D532AD, },
            { id = 0x65EC0A4F, albedo = 0x326A7845, normal = 0xC09B2354, },
            { id = 0x3F143CA0, albedo = 0x91D7E39E, normal = 0xD607DF75, },
            { id = 0x49675146, albedo = 0x2E6C3769, normal = 0xE6A21CD5, },
            { id = 0x07504D2D, albedo = 0x39F16CE6, normal = 0x5CB32D5C, },
            { id = 0xF161214F, albedo = 0x47C60FBA, normal = 0x19424C77, },
            { id = 0xE43286F2, albedo = 0xA7E86379, normal = 0x7C07E0B0, },
            { id = 0xDDDC7A46, albedo = 0x26D3DA64, normal = 0x5A69A9BB, },
            { id = 0xD086DF9B, albedo = 0x7D6FF58C, normal = 0x5A0D99C8, },
            { id = 0xBA51B331, albedo = 0xCB23CA55, normal = 0xA7720C6A, },
            { id = 0xE4CF097B, albedo = 0x51D0FBDA, normal = 0xB01F5202, },
            { id = 0xF70CADF6, albedo = 0xD0858DFC, normal = 0x7E067837, },
            { id = 0xC07F40DC, albedo = 0x3BAF1008, normal = 0x75030E1B, },
            { id = 0xD3B1E741, albedo = 0x97091388, normal = 0xA191AA56, },
            { id = 0xB494A903, albedo = 0x18025AE1, normal = 0x86F51AD1, },
            { id = 0xC6EE4DB6, albedo = 0xC9F3EBA4, normal = 0xE819AD33, },
        },
    },

    OverlayAllLayers = {
        {
            name = "eyebrows", -- dont change
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 0.0,
        },
        {
            name = "scars",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "eyeliners",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "lipsticks",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "acne",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "shadows",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "beardstabble",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },

        {
            name = "paintedmasks",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "ageing",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 0.0,
        },
        {
            name = "blush",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "complex",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "disc",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "foundation",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "freckles",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "grime",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },

        {
            name = "moles",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
        {
            name = "spots",
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 1.0,
        },
    },

    ColorPalettes = {
        eyebrows = {
            0x3F6E70FF, -- black
            0x0105607B, -- grey
            0x17CBCC83, -- red
            0x29F81B2A, --green
            0x3385C5DB, --pink
            0x37CD36D4, --dark red
            0x4101ED87, -- brown medium
            0x63838A81, -- red medium
            0x6765BC15, -- black medium
            0x8BA18876, -- grey light
            0x9AC34F34, -- blonde
            0x9E4803A0, -- purple dark
            0xA4CFABD0, --pink light
            0xAA65D8A3, -- blue dark
            0xB562025C, --pink dark
            0xB9E7F722, -- violet light
            0xBBF43EF8, -- light brown
            0xD1476963, -- violet
            0xD799E1C2, -- red pinkish
            0xDC6BC93B, -- grey dark
            0xDFB1F64C, -- brown
            0xF509C745, -- redish
            0xF93DB0C8, -- redish
            0xFB71527B, -- gray dark
            0xA4041CEF, --orange
    
        },
        beardstabble = {
            0x3F6E70FF,
            0x0105607B,
            0x17CBCC83,
            0x29F81B2A,
            0x3385C5DB,
            0x37CD36D4,
            0x4101ED87,
            0x63838A81,
            0x6765BC15,
            0x8BA18876,
            0x9AC34F34,
            0x9E4803A0,
            0xA4CFABD0,
            0xAA65D8A3,
            0xB562025C,
            0xB9E7F722,
            0xBBF43EF8,
            0xD1476963,
            0xD799E1C2,
            0xDC6BC93B,
            0xDFB1F64C,
            0xF509C745,
            0xF93DB0C8,
            0xFB71527B,
            0xA4041CEF,
        },

        shadows = {
            0x3F6E70FF,
            0x0105607B,
            0x17CBCC83,
            0x29F81B2A,
            0x3385C5DB,
            0x37CD36D4,
            0x4101ED87,
            0x63838A81,
            0x6765BC15,
            0x8BA18876,
            0x9AC34F34,
            0x9E4803A0,
            0xA4CFABD0,
            0xAA65D8A3,
            0xB562025C,
            0xB9E7F722,
            0xBBF43EF8,
            0xD1476963,
            0xD799E1C2,
            0xDC6BC93B,
            0xDFB1F64C,
            0xF509C745,
            0xF93DB0C8,
            0xFB71527B,
            0xA4041CEF,
        },
        lipsticks = {
            0x3F6E70FF,
            0x0105607B,
            0x17CBCC83,
            0x29F81B2A,
            0x3385C5DB,
            0x37CD36D4,
            0x4101ED87,
            0x63838A81,
            0x6765BC15,
            0x8BA18876,
            0x9AC34F34,
            0x9E4803A0,
            0xA4CFABD0,
            0xAA65D8A3,
            0xB562025C,
            0xB9E7F722,
            0xBBF43EF8,
            0xD1476963,
            0xD799E1C2,
            0xDC6BC93B,
            0xDFB1F64C,
            0xF509C745,
            0xF93DB0C8,
            0xFB71527B,
            0xA4041CEF,
        },
        eyeliners = {
            0x3F6E70FF,
            0x0105607B,
            0x17CBCC83,
            0x29F81B2A,
            0x3385C5DB,
            0x37CD36D4,
            0x4101ED87,
            0x63838A81,
            0x6765BC15,
            0x8BA18876,
            0x9AC34F34,
            0x9E4803A0,
            0xA4CFABD0,
            0xAA65D8A3,
            0xB562025C,
            0xB9E7F722,
            0xBBF43EF8,
            0xD1476963,
            0xD799E1C2,
            0xDC6BC93B,
            0xDFB1F64C,
            0xF509C745,
            0xF93DB0C8,
            0xFB71527B,
            0xA4041CEF,
        },
        blush = {
            0x3F6E70FF,
            0x0105607B,
            0x17CBCC83,
            0x29F81B2A,
            0x3385C5DB,
            0x37CD36D4,
            0x4101ED87,
            0x63838A81,
            0x6765BC15,
            0x8BA18876,
            0x9AC34F34,
            0x9E4803A0,
            0xA4CFABD0,
            0xAA65D8A3,
            0xB562025C,
            0xB9E7F722,
            0xBBF43EF8,
            0xD1476963,
            0xD799E1C2,
            0xDC6BC93B,
            0xDFB1F64C,
            0xF509C745,
            0xF93DB0C8,
            0xFB71527B,
            0xA4041CEF,
        }
    },

    TextureTypes = {
        ['male'] = {
            albedo = GetHashKey("head_fr1_sc08_soft_c0_001_ab"),
            normal = GetHashKey("mp_head_mr1_000_nm"),
            material = 0x50A4BBA9,
            color_type = 1,
            texture_opacity = 1.0,
            unk_arg = 0,
        },
        ['female'] = {
            albedo = GetHashKey("mp_head_fr1_sc08_c0_000_ab"),
            normal = GetHashKey("head_fr1_mp_002_nm"),
            material = 0x7FC5B1E1,
            color_type = 1,
            texture_opacity = 1.0,
            unk_arg = 0,
        }
    },

    MakeupOverlayTypes = {
        
        ['lipsticks'] = {
            label = "Lipsticks",
            txt_id = "lipsticks_tx_id",
            color = "lipsticks_palette_color_primary",
            color2 = "lipsticks_palette_color_secondary",
            color3 = "lipsticks_palette_color_tertiary",
            variant = "lipsticks_palette_id",
            varvalue = 7,
            opacity = "lipsticks_opacity",
            visibility = "lipsticks_visibility"
        },
        ['blush'] = {
            label = "Blush",
            txt_id = "blush_tx_id",
            color = "blush_palette_color_primary",
            opacity = "blush_opacity",
            visibility = "blush_visibility"
        },
        ['eyeliners'] = {
            label = "Eyeliners",
            txt_id = "eyeliner_tx_id",
            variant = "eyeliner_palette_id",
            varvalue = 15,
            color = "eyeliner_color_primary",
            opacity = "eyeliner_opacity",
            visibility = "eyeliner_visibility"
        },
        ['shadows'] = {
            label = "Shadows",
            txt_id = "shadows_tx_id",
            color = "shadows_palette_color_primary",
            color2 = "shadows_palette_color_secondary",
            color3 = "shadows_palette_color_tertiary",
            variant = "shadows_palette_id",
            varvalue = 5,
            opacity = "shadows_opacity",
            visibility = "shadows_visibility"
        },
    }
    
    
}