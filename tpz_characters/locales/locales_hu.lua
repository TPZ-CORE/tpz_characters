local locales = { -- <- DO NOT TOUCH, MOVE TO LAST SECTION FOR LOCALE CHECK.

    ['NUI_TITLE']                                      = "KARAKTERLÉTREHOZÁS",
    ['NUI_MAIN_PAGE_WELCOME']                          = "Üdvözlünk a < SZERVERED NEVE > szerveren.\n\n%s.\n\nKezdd a kalandot egy egyedi karakter megalkotásával. Válassz nevet, kinézetet és hátteret, hogy életre keltsd a történeted.",
    ['NUI_CLOSE']                                      = "Kilépés",
    ['NUI_ACCEPT_OUTFIT']                              = "Karakter Létrehozása",
    ['NUI_OUTFITS']                                    = "Ruházat",
    ['NUI_MAKEUP']                                     = "Smink",
    ['NUI_FACIALS']                                    = "Arcvonások",
    ['NUI_IDENTITY']                                   = "Személyazonosság",
    ['NUI_APPEARANCE']                                 = "Kinézet",

    ['DIALOG_SEX_TITLE']                               = "VÁLASZD KI KARAKTERED NEMÉT",
    ['DIALOG_SEX_DESCRIPTION']                         = "Válaszd ki karaktered nemét. Ez meghatározza az alap testtípust és a később testreszabható kinézeti opciókat.",
    ['DIALOG_SEX_INPUT_DESCRIPTION']                   = "Írd be a nemet: MALE vagy FEMALE",
    ['DIALOG_SEX_SELECT_BUTTON']                       = "KIVÁLASZTÁS",
    ['INVALID_SEX_INPUT']                              = "Kérlek érvényes nemet adj meg a karakteredhez.",

    ['DIALOG_TITLE']                                   = "KARAKTER SZEMÉLYI ADATAINAK MÓDOSÍTÁSA",
    ['DIALOG_SAVE_BUTTON']                             = "MENTÉS",

    ['INVALID_DATE_OF_BIRTH']                          = "Kérlek adj meg érvényes születési dátumot.",
    ['INVALID_FIRSTNAME_OR_LASTNAME']                  = "Kérlek adj meg érvényes vezeték- és keresztnevet.",

    ['NUI_RESET_OUTFIT_TYPE']                          = "Alapértelmezett ruházat visszaállítása",
    ['NUI_SELECT_TINT']                                = "Kiválasztott színárnyalat betöltése",
    ['NUI_SELECT_COMPONENT']                           = "Válassz komponenst",
    ['NUI_SELECT_PALETTE_TITLE']                       = "Paletta kiválasztása",
    ['NUI_SELECT_BUY']                                 = "Vásárlás",
    ['NUI_SELECT_BOUGHT']                              = "Megvásárolva",
    ['NUI_SELECT_COST']                                = "A(z) %s ára: ($%s) darabonként.",

    -- AGEING SECTION
    ['NUI_AGEING_INFO']                                = "Állítsd be karaktered életkorát, a fiataltól az idősig.",
    ['NUI_AGEING_TEXTURE_ID']                          = "Válaszd ki karaktered korát.",
    ['NUI_AGEING_OPACITY']                             = "Öregedés erőssége",

    -- APPEARANCE SECTION
    ['NUI_APPEARANCE_INFO']                            = "Állítsd be karaktered kinézetét a preferenciáid alapján.",
    ['NUI_APPEARANCE_BODY']                            = "Testtípusok",
    ['NUI_APPEARANCE_HERITAGE']                        = "Örökség",
    ['NUI_APPEARANCE_GROOM']                           = "Haj és szakáll",
    ['NUI_APPEARANCE_AGEING']                          = "Öregedés",
    ['NUI_APPEARANCE_HEIGHT']                          = "Magasság",
    ['NUI_APPEARANCE_EYES']                            = "Szemszín",
    ['NUI_APPEARANCE_BODY_FEATURES']                   = "Test és arc jellemzők",
    ['NUI_APPEARANCE_LIFESTYLE']                       = "Bőr részletei",
    ['NUI_APPEARANCE_MAKEUP']                          = "Smink",

    -- APPEARANCE BODY SECTION
    ['NUI_BODY_INFO']                                  = "Állítsd be a derekat, törzset és lábakat a kívánt testalkat eléréséhez.",
    ['NUI_BODY_TYPES']                                 = "Testtípusok",
    ['NUI_WAIST_TYPES']                                = "Derekak",
    ['NUI_TORSO_TYPES']                                = "Törzs",
    ['NUI_LEGS_TYPES']                                 = "Lábak",

    -- APPEARANCE HERITAGE SECTION
    ['NUI_HERITAGE_INFO']                              = "Állítsd be a fejtípust és az arcbőr színét.",
    ['NUI_HERITAGE_TYPES']                             = "Válaszd ki karaktered arcbőrszín típusát.",
    ['NUI_HERITAGE_COLORS']                            = "Válaszd ki karaktered arcformáját.",

    -- HAIR SECTION
    ['NUI_HAIR_BUTTON']                                = "Frizurák",
    ['NUI_HAIR_BEARD_BUTTON']                          = "Szakáll",
    ['NUI_HAIR_BEARD_STABBLE_BUTTON']                  = "Borosta",
    ['NUI_HAIR_EYEBROWS_BUTTON']                       = "Szemöldök",
    ['NUI_HAIR_OVERLAY_BUTTON']                        = "Borotvált",

    ['NUI_APPEARANCE_HEIGHT_TITLE']                    = "Magasság beállítása",
    ['NUI_APPEARANCE_HEIGHT_DESCRIPTION']              = "Válaszd ki a kívánt magasságot.",

    -- LIFESTYLE SECTION
    ['NUI_LIFESTYLES_INFO']                            = "Bőr részletek hozzáadása a realizmus érdekében.",
    ['NUI_LIFESTYLES_TEXTURE_TITLE']                   = "Textúra kiválasztása",
    ['NUI_LIFESTYLES_OPACITY_TITLE']                   = "Láthatóság",
    ['NUI_LIFESTYLES_MOLES']                           = 'Anyajegyek',
    ['NUI_LIFESTYLES_MOLES_INFO']                      = 'Kis bőrhibák, melyek egyediséget adnak.',
    ['NUI_LIFESTYLES_SPOTS']                           = 'Foltok',
    ['NUI_LIFESTYLES_SPOTS_INFO']                      = 'Apró bőrhibák a realizmus érdekében.',
    ['NUI_LIFESTYLES_COMPLEX']                         = 'Bőrtónus',
    ['NUI_LIFESTYLES_COMPLEX_INFO']                    = 'Bőrszín és textúra finomhangolása.',
    ['NUI_LIFESTYLES_ACNE']                            = 'Pattanások',
    ['NUI_LIFESTYLES_ACNE_INFO']                       = 'Fiatalos megjelenést adó bőrhibák.',
    ['NUI_LIFESTYLES_FRECKLES']                        = 'Szeplők',
    ['NUI_LIFESTYLES_FRECKLES_INFO']                   = 'Természetes, napcsókolta bőr hatás.',
    ['NUI_LIFESTYLES_DISCOLORATION']                   = 'Elszíneződés',
    ['NUI_LIFESTYLES_DISC_INFO']                       = 'Természetes bőrárnyalat különbségek.',
    ['NUI_LIFESTYLES_SCARS']                           = 'Hegek',
    ['NUI_LIFESTYLES_SCARS_INFO']                      = 'Korábbi sérülések nyomai.',
    ['NUI_LIFESTYLES_GRIME']                           = 'Kosz',
    ['NUI_LIFESTYLES_GRIME_INFO']                      = 'Kosz, por, harci nyomok.',

    -- BODY FEATURES
    ['NUI_BODYFEATURES_INFO']                          = "Arc- és testformák részletes testreszabása.",
    ['NUI_BODY_FEATURES_TEETH']                        = 'Fogak',
    ['NUI_BODY_FEATURES_TEETH_INFO']                   = 'Fogtípusok és mosoly formázása.',
    ['NUI_BODY_FEATURES_JAW']                          = 'Állkapocs',
    ['NUI_BODY_FEATURES_JAW_INFO']                     = 'Állkapocs szélességének és formájának beállítása.',
    ['NUI_BODY_FEATURES_CHIN']                         = 'Áll',
    ['NUI_BODY_FEATURES_CHIN_INFO']                    = 'Áll forma és méret módosítása.',
    ['NUI_BODY_FEATURES_HEAD']                         = 'Fej',
    ['NUI_BODY_FEATURES_HEAD_INFO']                    = 'Fej méretének és formájának kiválasztása.',
    ['NUI_BODY_FEATURES_NOSE']                         = 'Orr',
    ['NUI_BODY_FEATURES_NOSE_INFO']                    = 'Orr formájának részletes beállítása.',
    ['NUI_BODY_FEATURES_EARS']                         = 'Fülek',
    ['NUI_BODY_FEATURES_EARS_INFO']                    = 'Fül méret és forma beállítása.',
    ['NUI_BODY_FEATURES_MOUTHANDLIPS']                 = 'Száj és ajkak',
    ['NUI_BODY_FEATURES_MOUTHANDLIPS_INFO']            = 'Ajkak formájának finomhangolása.',
    ['NUI_BODY_FEATURES_CHEEK']                        = 'Arccsontok',
    ['NUI_BODY_FEATURES_CHEEK_INFO']                   = 'Arccsont magasságának és élességének állítása.',
    ['NUI_BODY_FEATURES_EYESANDBROWS']                 = 'Szemek és szemöldök',
    ['NUI_BODY_FEATURES_EYESANDBROWS_INFO']            = 'Szemforma, szemszín és szemöldök stílus beállítása.',
    ['NUI_BODY_FEATURES_UPPERBODY']                    = 'Felsőtest',
    ['NUI_BODY_FEATURES_UPPERBODY_INFO']               = 'Vállak, karok és mellkas formázása.',
    ['NUI_BODY_FEATURES_LOWERBODY']                    = 'Alsótest',
    ['NUI_BODY_FEATURES_LOWERBODY_INFO']               = 'Csípő, derék és lábak beállítása.',

    -- GROOM SECTION
    ['NUI_GROOM_INFO']                                 = "Részletes haj- és szakállrendszer természetes megjelenéssel.",
    ['NUI_GROOM_HAIR']                                 = "Haj",
    ['NUI_GROOM_HAIR_INFO']                            = "Hajstílus és hajszín testreszabása.",
    ['NUI_GROOM_HAIR_DESC']                            = "Haj",
    ['NUI_GROOM_HAIR_COLORS']                          = "Színek",
    ['NUI_GROOM_HAIR_OPACITY']                         = "Átlátszóság",

    ['NUI_GROOM_OVERLAY']                              = "Hajrétegek",
    ['NUI_GROOM_OVERLAY_INFO']                         = "Hajrétegek",
    ['NUI_GROOM_OVERLAY_DESC']                         = "Hajrétegek",
    ['NUI_GROOM_OVERLAY_COLORS']                       = "Színek",
    ['NUI_GROOM_OVERLAY_OPACITY']                      = "Átlátszóság",

    ['NUI_GROOM_BEARD']                                = "Szakáll",
    ['NUI_GROOM_BEARD_INFO']                           = "Válassz különböző szakállhosszakat és stílusokat.",
    ['NUI_GROOM_BEARD_DESC']                           = "Szakáll",
    ['NUI_GROOM_BEARD_COLORS']                         = "Színek",
    ['NUI_GROOM_BEARD_OPACITY']                        = "Átlátszóság",

    ['NUI_GROOM_BEARDSTABBLE']                         = "Borosta",
    ['NUI_GROOM_BEARDSTABBLE_INFO']                    = "Borosta",
    ['NUI_GROOM_BEARDSTABBLE_DESC']                    = "Borosta",
    ['NUI_GROOM_BEARDSTABBLE_COLORS']                  = "Színek",
    ['NUI_GROOM_BEARDSTABBLE_OPACITY']                 = "Átlátszóság",

    ['NUI_GROOM_BOW']                                  = "Csokor",
    ['NUI_GROOM_BOW_INFO']                             = "Csokor",
    ['NUI_GROOM_BOW_INFO_DESC']                        = "Csokor",
    ['NUI_GROOM_BOW_INFO_COLORS']                      = "Színek",
    ['NUI_GROOM_BOW_INFO_OPACITY']                     = "Átlátszóság",

    ['NUI_GROOM_EYEBROWS']                             = "Szemöldök",
    ['NUI_GROOM_EYEBROWS_INFO']                        = "Szemöldök formázása és színezése.",
    ['NUI_GROOM_EYEBROWS_DESC']                        = "Szemöldök",
    ['NUI_GROOM_EYEBROWS_COLORS']                      = "Színek",
    ['NUI_GROOM_EYEBROWS_OPACITY']                     = "Átlátszóság",

    -- MAKEUP
    ['NUI_MAKEUP_INFO']                                = "Smink testreszabása: alapozó, rúzs, árnyékok, tus és pirosító.",

    ['NUI_MAKEUP_FOUNDATION']                          = 'Alapozó',
    ['NUI_MAKEUP_FOUNDATION_DESC']                     = 'Bőregyenlítő alapréteg a sminkhez.',
    ['NUI_MAKEUP_FOUNDATION_TEXTURE']                  = 'Textúratípusok',
    ['NUI_MAKEUP_FOUNDATION_PRIMARY_COLOR']            = 'Elsődleges szín',
    ['NUI_MAKEUP_FOUNDATION_SECONDARY_COLOR']          = 'Másodlagos szín',
    ['NUI_MAKEUP_FOUNDATION_VARIANT']                  = 'Változatok',
    ['NUI_MAKEUP_FOUNDATION_OPACITY']                  = 'Átlátszóság',

    ['NUI_MAKEUP_LIPSTICKS']                           = 'Rúzs',
    ['NUI_MAKEUP_LIPSTICKS_DESC']                      = 'Kiemeli az ajkak formáját és színét.',
    ['NUI_MAKEUP_LIPSTICKS_TEXTURE']                   = 'Textúratípusok',
    ['NUI_MAKEUP_LIPSTICKS_PRIMARY_COLOR']             = 'Elsődleges szín',
    ['NUI_MAKEUP_LIPSTICKS_SECONDARY_COLOR']           = 'Másodlagos szín',
    ['NUI_MAKEUP_LIPSTICKS_VARIANT']                   = 'Változatok',
    ['NUI_MAKEUP_LIPSTICKS_OPACITY']                   = 'Átlátszóság',

    ['NUI_MAKEUP_SHADOWS']                             = 'Szemhéjárnyék',
    ['NUI_MAKEUP_SHADOWS_DESC']                        = 'Mélyebb és hangsúlyosabb szemsmink.',
    ['NUI_MAKEUP_SHADOWS_TEXTURE']                     = 'Textúratípusok',
    ['NUI_MAKEUP_SHADOWS_PRIMARY_COLOR']               = 'Elsődleges szín',
    ['NUI_MAKEUP_SHADOWS_SECONDARY_COLOR']             = 'Másodlagos szín',
    ['NUI_MAKEUP_SHADOWS_VARIANT']                     = 'Változatok',
    ['NUI_MAKEUP_SHADOWS_OPACITY']                     = 'Átlátszóság',

    ['NUI_MAKEUP_EYELINERS']                           = 'Szemhéjtus',
    ['NUI_MAKEUP_EYELINERS_DESC']                      = 'A szem formáját kiemelő tus.',
    ['NUI_MAKEUP_EYELINERS_TEXTURE']                   = 'Textúratípusok',
    ['NUI_MAKEUP_EYELINERS_PRIMARY_COLOR']             = 'Elsődleges szín',
    ['NUI_MAKEUP_EYELINERS_SECONDARY_COLOR']           = 'Másodlagos szín',
    ['NUI_MAKEUP_EYELINERS_VARIANT']                   = 'Változatok',
    ['NUI_MAKEUP_EYELINERS_OPACITY']                   = 'Átlátszóság',

    ['NUI_MAKEUP_BLUSH']                               = 'Pirosító',
    ['NUI_MAKEUP_BLUSH_DESC']                          = 'Friss, ragyogó arcszínt ad.',
    ['NUI_MAKEUP_BLUSH_TEXTURE']                       = 'Textúratípusok',
    ['NUI_MAKEUP_BLUSH_PRIMARY_COLOR']                 = 'Elsődleges szín',
    ['NUI_MAKEUP_BLUSH_SECONDARY_COLOR']               = 'Másodlagos szín',
    ['NUI_MAKEUP_BLUSH_VARIANT']                       = 'Változatok',
    ['NUI_MAKEUP_BLUSH_OPACITY']                       = 'Átlátszóság',

    -- EYES
    ['NUI_EYES_TITLE']                                 = "Szemszín",
    ['NUI_EYES_INFO']                                  = "Válaszd ki a megfelelő szemszínt és szemformát.",
    ['NUI_EYES_TEXTURE_ID_TITLE']                      = "Szemtextúra kiválasztása",

    -- CLOTHING
    ['NUI_CLOTHING_INFO']                              = "Karakter ruházatának teljes testreszabása.",
    ['NUI_CATEGORY_CLOTHING_COATCLOSED_TITLE']         = "Teljesen begombolt kabát, elegáns megjelenés.",
    ['NUI_CATEGORY_CLOTHING_COAT_TITLE']               = "Nyitott vagy részben gombolt kabát.",
    ['NUI_CATEGORY_CLOTHING_HAT_TITLE']                = "Kalap, amely a karakter sziluettjét meghatározza.",
    ['NUI_CATEGORY_CLOTHING_EYEWEAR_TITLE']            = "Szemüveg vagy védőszemüveg.",
    ['NUI_CATEGORY_CLOTHING_MASK_TITLE']               = "Arcot takaró maszk.",
    ['NUI_CATEGORY_CLOTHING_NECKWEAR_TITLE']           = "Nyakörvek, sálak vagy láncok.",
    ['NUI_CATEGORY_CLOTHING_NECKTIES_TITLE']           = "Nyakkendők vagy nyakszalagok.",
    ['NUI_CATEGORY_CLOTHING_SHIRT_TITLE']              = "Ingek különböző stílusokban.",
    ['NUI_CATEGORY_CLOTHING_SUSPENDER_TITLE']          = "Hózentrógerek, vintage stílushoz.",
    ['NUI_CATEGORY_CLOTHING_VEST_TITLE']               = "Mellények.",
    ['NUI_CATEGORY_CLOTHING_PONCHO_TITLE']             = "Poncsók.",
    ['NUI_CATEGORY_CLOTHING_CLOAK_TITLE']              = "Köpönyeg, hosszú felsőruházat.",
    ['NUI_CATEGORY_CLOTHING_GLOVE_TITLE']              = "Kesztyűk.",
    ['NUI_CATEGORY_CLOTHING_BELT_TITLE']               = "Övek.",
    ['NUI_CATEGORY_CLOTHING_PANT_TITLE']               = "Nadrágok.",
    ['NUI_CATEGORY_CLOTHING_BOOTS_TITLE']              = "Csizmák.",
    ['NUI_CATEGORY_CLOTHING_SPURS_TITLE']              = "Sarkantyúk.",
    ['NUI_CATEGORY_CLOTHING_BRACELET_TITLE']           = "Karkötők.",
    ['NUI_CATEGORY_CLOTHING_BUCKLE_TITLE']             = "Övcsatok.",
    ['NUI_CATEGORY_CLOTHING_CHAP_TITLE']               = "Csapszárak (chaps).",
    ['NUI_CATEGORY_CLOTHING_SPATS_TITLE']              = "Csizmaszárvédők.",
    ['NUI_CATEGORY_CLOTHING_GAUNTLETS_TITLE']          = "Karfedők.",
    ['NUI_CATEGORY_CLOTHING_DRESS_TITLE']              = "Ruhák.",
    ['NUI_CATEGORY_CLOTHING_HOLSTER_TITLE']            = "Fegyvertáska.",
    ['NUI_CATEGORY_CLOTHING_LOADOUTS_TITLE']           = "Felszerelés szettek.",
    ['NUI_CATEGORY_CLOTHING_ACCESSORIES_TITLE']        = "Kiegészítők.",
    ['NUI_CATEGORY_CLOTHING_SATCHELS_TITLE']           = "Táskák.",
    ['NUI_CATEGORY_CLOTHING_GUNBELT_TITLE']            = "Fegyverövek.",
    ['NUI_CATEGORY_CLOTHING_RINGRH_TITLE']             = "Gyűrű (jobb kéz).",
    ['NUI_CATEGORY_CLOTHING_RINGLH_TITLE']             = "Gyűrű (bal kéz).",
    ['NUI_TINT_1']                                     = "Egyedi árnyalat (1)",
    ['NUI_TINT_2']                                     = "Egyedi árnyalat (2)",
    ['NUI_TINT_3']                                     = "Egyedi árnyalat (3)",

    ['NUI_BACK']                                       = "Vissza",

    ['CUSTOMIZE_CLOTHING_DESCRIPTION']                 = "Új karakter ruházatának testreszabása",
    ['TOTAL_TYPES']                                    = "Típusok összesen: ",

    ['ACCEPT_BUTTON']                                  = "ELFOGADÁS",
    ['DECLINE_BUTTON']                                 = "ELUTASÍTÁS",

    ["CoatClosed"]                                     = "Zárt kabátok",
    ["Coat"]                                           = "Kabátok",
    ["Hat"]                                            = "Kalapok",
    ["EyeWear"]                                        = "Szemüvegek",
    ["Mask"]                                           = "Maszkok",
    ["NeckWear"]                                       = "Nyakviselet",
    ["NeckTies"]                                       = "Nyakkendők",
    ["Shirt"]                                          = "Ingek",
    ["Suspender"]                                      = "Hózentrógerek",
    ["Vest"]                                           = "Mellények",
    ["Poncho"]                                         = "Poncsók",
    ["Cloak"]                                          = "Köpönyegek",
    ["Glove"]                                          = "Kesztyűk",
    ["Belt"]                                           = "Övek",
    ["Pant"]                                           = "Nadrágok",
    ["Boots"]                                          = "Csizmák",
    ["Spurs"]                                          = "Sarkantyúk",
    ["Bracelet"]                                       = "Karkötők",
    ["Buckle"]                                         = "Csatok",
    ["Skirt"]                                          = "Szoknyák",
    ["Chap"]                                           = "Chaps",
    ["Spats"]                                          = "Csizmaszárvédők",
    ["GunbeltAccs"]                                    = "Fegyveröv kiegészítők",
    ["Gauntlets"]                                      = "Karfedők",
    ["Loadouts"]                                       = "Felszerelés szettek",
    ["Accessories"]                                    = "Kiegészítők",
    ["Satchels"]                                       = "Táskák",
    ["Dress"]                                          = "Ruhák",
    ["Holster"]                                        = "Bal oldali tok",
    ["Gunbelt"]                                        = "Fegyverövek",
    ["RingRh"]                                         = "Gyűrűk (jobb kéz)",
    ["RingLh"]                                         = "Gyűrűk (bal kéz)",

    ['CREATE_CHARACTER_INVALID_IDENTIFICATION']        = "A személyes adatok hiányosak vagy érvénytelenek.",
    ['CREATE_CHARACTER_INVALID_FIRSTNAME']             = "A keresztnév érvénytelen.",
    ['CREATE_CHARACTER_INVALID_LASTNAME']              = "A vezetéknév érvénytelen.",
    ['CREATE_CHARACTER_BLACKLISTED_FIRST_OR_LASTNAME'] = "A név tiltott szavakat tartalmaz.",
    ['CREATE_CHARACTER_NOT_PERMITTED_YEAR']            = "A megadott születési év nem elfogadható. Érvényes év: %s - %s.",

    ["CHARACTER_NOT_SELECTED"]                         = "~e~Nincs karakter kiválasztva",
    ["CHARACTER_RELOADED"]                             = "Karakter újratöltve!",
    ['CHARACTER_RELOAD_NOT_PERMITTED']                 = "Nem töltheted újra a karakter kinézetét.",

    ['DEVTOOLS_INJECTION_DETECTED_TITLE_LOG']          = "DevTools / Injekciós csalás észlelve!",
    ['DEVTOOLS_INJECTION_DETECTED']                    = "DevTools vagy injekciós csalás használata miatt ki lettél dobva.",

    ['RELOAD_CHARACTER_COMMAND_COOLDOWN']              = "~e~Nem használhatod újra még %s másodpercig.",
}

---------------------------------------------------------------
--[[ EDIT SELECTED LANGUAGE ]]--
---------------------------------------------------------------

Citizen.CreateThread(function()
    Wait(2000)

    if Config.LANGUAGE == 'HU' then
        Locales = locales
    end

end)
