local locales = { -- <- DO NOT TOUCH, MOVE TO LAST SECTION FOR LOCALE CHECK.

    ['NUI_TITLE']                                      = "CHARACTER CREATION",
    ['NUI_MAIN_PAGE_WELCOME']                          = "Welcome to the Daisy Town Roleplay.\n\nMr./Ms. %s.\n\nBegin your journey by designing a unique character. Choose a name, appearance, and background to bring your story to life.", -- %s returns player first and last name.
    ['NUI_CLOSE']                                      = "Exit",
    ['NUI_ACCEPT_OUTFIT']                              = "Create Character",
    ['NUI_OUTFITS']                                    = "Clothing",
    ['NUI_MAKEUP']                                     = "Makeup",
    ['NUI_FACIALS']                                    = "Facials",
    ['NUI_IDENTITY']                                   = "Identity Information",
    ['NUI_APPEARANCE']                                 = "Character Appearance",

    ['DIALOG_SEX_TITLE']                               = "SELECT YOUR NEW CHARACTER GENDER",
    ['DIALOG_SEX_DESCRIPTION']                         = "Choose your character’s gender. This will define the base body type and appearance options you can customize later properly.",
    ['DIALOG_SEX_INPUT_DESCRIPTION']                   = "Please type your gender below, such as: MALE or FEMALE",
    ['DIALOG_SEX_SELECT_BUTTON']                       = "SELECT",
    ['INVALID_SEX_INPUT']                              = "Please select a valid gender for your character.",

    ['DIALOG_TITLE']                                   = "MODIFY YOUR CHARACTER IDENTITY INFORMATION",
    ['DIALOG_SAVE_BUTTON']                             = "SAVE IDENTITY",

    ['INVALID_DATE_OF_BIRTH']                          = "Please insert a valid date of birth.", -- supports \n for new line.
    ['INVALID_FIRSTNAME_OR_LASTNAME']                  = "Please insert a valid firstname or lastname.", -- supports \n for new line.

    ['NUI_RESET_OUTFIT_TYPE']                          = "Reset Outfit To Default",
    ['NUI_SELECT_TINT']                                = "Load Selected Tints",
    ['NUI_SELECT_COMPONENT']                           = "Select Component",
    ['NUI_SELECT_PALETTE_TITLE']                       = "Select Palette",
    ['NUI_SELECT_BUY']                                 = "Buy Now",
    ['NUI_SELECT_BOUGHT']                              = "Purchased",
    ['NUI_SELECT_COST']                                = "The cost for buying %s is at ($%s) dollars per item.",

    -- AGEING SECTION
    ['NUI_AGEING_INFO']                                = "Customize your character’s age, adjusting their appearance from youth to old age.",
    ['NUI_AGEING_TEXTURE_ID']                          = "Choose the age of your character.",
    ['NUI_AGEING_OPACITY']                             = "Select the opacity of your character’s age.",

    -- APPEARANCE SECTION
    ['NUI_APPEARANCE_INFO']                            = "Adjust your character’s appearance based on your preferences.",
    ['NUI_APPEARANCE_BODY']                            = "Body Types",
    ['NUI_APPEARANCE_HERITAGE']                        = "Heritage",
    ['NUI_APPEARANCE_GROOM']                           = "Groom",
    ['NUI_APPEARANCE_AGEING']                          = "Ageing",
    ['NUI_APPEARANCE_HEIGHT']                          = "Height Adjustment",
    ['NUI_APPEARANCE_BODY_FEATURES']                   = "Body Features",
    ['NUI_APPEARANCE_LIFESTYLE']                       = "Lifestyle",
    ['NUI_APPEARANCE_MAKEUP']                          = "Makeup",

    -- APPEARANCE BODY SECTION
    ['NUI_BODY_INFO']                                  = "Adjust waist, torso, and legs for shape, size, and definition to build a unique physique.",
    ['NUI_BODY_TYPES']                                 = "Body Types",
    ['NUI_WAIST_TYPES']                                = "Waists",
    ['NUI_TORSO_TYPES']                                = "Torso",
    ['NUI_LEGS_TYPES']                                 = "Legs",

    -- APPEARANCE HERITAGE SECTION

    ['NUI_HERITAGE_INFO']                              = "Adjust your character’s head type and head color types.",
    ['NUI_HERITAGE_TYPES']                             = "Choose the type of your character’s skin face color.",
    ['NUI_HERITAGE_COLORS']                            = "Choose the type of your character’s face.",

    -- APPEARANCE HAIR SECTION
    ['NUI_HAIR_BUTTON']                                = "Hair Styles",
    ['NUI_HAIR_BEARD_BUTTON']                          = "Facial Hair (Beard)",
    ['NUI_HAIR_BEARD_STABBLE_BUTTON']                  = "Beard Stabble Styles",
    ['NUI_HAIR_EYEBROWS_BUTTON']                       = "Eyebrows",
    ['NUI_HAIR_OVERLAY_BUTTON']                        = "Shaved",
 
    ['NUI_APPEARANCE_HEIGHT_TITLE']                    = "Height Adjustment",
    ['NUI_APPEARANCE_HEIGHT_DESCRIPTION']              = "Select the desired height adjustment for your new character.",

    -- APPEARANCE LIFESTYLE SECTION
    ['NUI_LIFESTYLES_INFO']                            = "Customize your character’s skin details with realistic features.",
    ['NUI_LIFESTYLES_TEXTURE_TITLE']                   = "Select A Texture",
    ['NUI_LIFESTYLES_OPACITY_TITLE']                   = "Opacity - Visibility",
    ['NUI_LIFESTYLES_MOLES']                           = 'Moles',
    ['NUI_LIFESTYLES_MOLES_INFO']                      = 'Small, natural skin marks that add individuality and realism to your character.',

    ['NUI_LIFESTYLES_SPOTS']                           = 'Spots',
    ['NUI_LIFESTYLES_SPOTS_INFO']                      = 'Minor blemishes or marks that suggest skin texture and imperfection.',
    
    ['NUI_LIFESTYLES_COMPLEX']                         = 'Complex',
    ['NUI_LIFESTYLES_COMPLEX_INFO']                    = 'Adjust overall skin tone, texture, and clarity for a unique appearance.',
    
    ['NUI_LIFESTYLES_ACNE']                            = 'Acne',
    ['NUI_LIFESTYLES_ACNE_INFO']                       = 'Visible pimples or breakouts that bring a touch of realism and youthfulness.',
    
    ['NUI_LIFESTYLES_FRECKLES']                        = 'Freckles',
    ['NUI_LIFESTYLES_FRECKLES_INFO']                   = 'Light, scattered spots that give a sun-kissed or charming look.',
    
    ['NUI_LIFESTYLES_DISCOLORATION']                   = 'Discoloration',
    ['NUI_LIFESTYLES_DISC_INFO']                       = 'Subtle tone variations that reflect natural skin diversity or aging.',
    
    ['NUI_LIFESTYLES_SCARS']                           = 'Scars',
    ['NUI_LIFESTYLES_SCARS_INFO']                      = 'Healed wounds or scratches that tell a story of past experiences.',

    ['NUI_LIFESTYLES_GRIME']                           = 'Grime',
    ['NUI_LIFESTYLES_GRIME_INFO']                      = 'Dirt, smudges, or stains that add a rugged, lived-in feel to your character.',

    -- APPEARANCE BODY FEATURES SECTION
    ['NUI_BODYFEATURES_INFO']                          = "Adjust features for a unique face and body that truly fits your vision.",
   
    ['NUI_BODY_FEATURES_TEETH']                        = 'Teeth',
    ['NUI_BODY_FEATURES_TEETH_INFO']                   = 'Shape your character’s smile with different tooth styles and details.',

    ['NUI_BODY_FEATURES_JAW']                          = 'Jaw',
    ['NUI_BODY_FEATURES_JAW_INFO']                     = 'Adjust the width and structure to define your character’s facial profile.',

    ['NUI_BODY_FEATURES_CHIN']                         = 'Chin',
    ['NUI_BODY_FEATURES_CHIN_INFO']                    = 'Refine the chin’s size and shape for a balanced or bold look.',

    ['NUI_BODY_FEATURES_HEAD']                         = 'Head',
    ['NUI_BODY_FEATURES_HEAD_INFO']                    = 'Choose overall head shape, size, and proportions to set the base of your character.',

    ['NUI_BODY_FEATURES_NOSE']                         = 'Nose',
    ['NUI_BODY_FEATURES_NOSE_INFO']                    = 'Customize length, width, and bridge for a distinct facial expression.',

    ['NUI_BODY_FEATURES_EARS']                         = 'Ears',
    ['NUI_BODY_FEATURES_EARS_INFO']                    = 'Modify size, angle, and style to match your character’s personality.',

    ['NUI_BODY_FEATURES_MOUTHANDLIPS']                 = 'Mouth & Lips',
    ['NUI_BODY_FEATURES_MOUTHANDLIPS_INFO']            = 'Adjust fullness, curvature, and expression to craft the perfect smile or smirk.',

    ['NUI_BODY_FEATURES_CHEEK']                        = 'Cheek Bones',
    ['NUI_BODY_FEATURES_CHEEK_INFO']                   = 'Fine-tune cheekbone height and definition for subtle or striking contours.',
    
    ['NUI_BODY_FEATURES_EYESANDBROWS']                 = 'Eyes & Eyebrows',
    ['NUI_BODY_FEATURES_EYESANDBROWS_INFO']            = 'Define eye shape, color, and brow style to give your character unique emotion and depth.',
    
    ['NUI_BODY_FEATURES_UPPERBODY']                    = 'Upper Body',
    ['NUI_BODY_FEATURES_UPPERBODY_INFO']               = 'Sculpt torso, shoulders, and arms to create the desired build and posture.',
    
    ['NUI_BODY_FEATURES_LOWERBODY']                    = 'Lower Body',
    ['NUI_BODY_FEATURES_LOWERBODY_INFO']               = 'Adjust waist, hips, and legs to complete your character’s physique.',
   
    -- APPEARANCE GROOM SECTION
    ['NUI_GROOM_INFO']                                 = "A detailed hair and beard system designed to give natural flow, texture, and expression to the character.",
   
    ['NUI_GROOM_HAIR']                                 = "Hair",
    ['NUI_GROOM_HAIR_INFO']                            = "Customize your character’s hair style and color with adjustable length, texture, and highlights.",
    ['NUI_GROOM_HAIR_DESC']                            = "Hair",
    ['NUI_GROOM_HAIR_COLORS']                          = "Component Colors",
    ['NUI_GROOM_HAIR_OPACITY']                         = "Opacity",
    
    ['NUI_GROOM_OVERLAY']                              = "Hair Overlays",
    ['NUI_GROOM_OVERLAY_INFO']                         = "Hair Overlays",
    ['NUI_GROOM_OVERLAY_DESC']                         = "Hair Overlays",
    ['NUI_GROOM_OVERLAY_COLORS']                       = "Component Colors",
    ['NUI_GROOM_OVERLAY_OPACITY']                      = "Opacity",

    ['NUI_GROOM_BEARD']                                = "Beard",
    ['NUI_GROOM_BEARD_INFO']                           = "Choose from different styles and lengths. Control thickness and color for a detailed appearance.",
    ['NUI_GROOM_BEARD_DESC']                           = "Beard",
    ['NUI_GROOM_BEARD_COLORS']                         = "Component Colors",
    ['NUI_GROOM_BEARD_OPACITY']                        = "Opacity",

    ['NUI_GROOM_BEARDSTABBLE']                         = "Beard Stabble",
    ['NUI_GROOM_BEARDSTABBLE_INFO']                    = "Beard Stabble",
    ['NUI_GROOM_BEARDSTABBLE_DESC']                    = "Beard Stabble",
    ['NUI_GROOM_BEARDSTABBLE_COLORS']                  = "Component Colors",
    ['NUI_GROOM_BEARDSTABBLE_OPACITY']                 = "Opacity",

    ['NUI_GROOM_BOW']                                  = "Bow",
    ['NUI_GROOM_BOW_INFO']                             = "Bow",
    ['NUI_GROOM_BOW_INFO_DESC']                        = "Bow",
    ['NUI_GROOM_BOW_INFO_COLORS']                      = "Component Colors",
    ['NUI_GROOM_BOW_INFO_OPACITY']                     = "Opacity",

    ['NUI_GROOM_EYEBROWS']                             = "Eyebrows",
    ['NUI_GROOM_EYEBROWS_INFO']                        = "Edit eyebrow shape, size, and color to fit your character’s face.",
    ['NUI_GROOM_EYEBROWS_DESC']                        = "Eyebrows",
    ['NUI_GROOM_EYEBROWS_COLORS']                      = "Component Colors",
    ['NUI_GROOM_EYEBROWS_OPACITY']                     = "Opacity",

    -- APPEARANCE MAKEUP SECTION
    ['NUI_MAKEUP_INFO']                                = "Customize your character’s makeup such as foundation, lipsticks, shadows, eyeliners and blush.",

    ['NUI_MAKEUP_FOUNDATION']                          = 'Foundation',
    ['NUI_MAKEUP_FOUNDATION_DESC']                     = 'Smooths and evens out skin tone, creating a flawless base for your makeup look.',
    ['NUI_MAKEUP_FOUNDATION_TEXTURE']                  = 'Texture Types',
    ['NUI_MAKEUP_FOUNDATION_PRIMARY_COLOR']            = 'Primary Color',
    ['NUI_MAKEUP_FOUNDATION_SECONDARY_COLOR']          = 'Secondary Color',
    ['NUI_MAKEUP_FOUNDATION_VARIANT']                  = 'Variants',
    ['NUI_MAKEUP_FOUNDATION_OPACITY']                  = 'Opacity',

    ['NUI_MAKEUP_LIPSTICKS']                           = 'Lipsticks',
    ['NUI_MAKEUP_LIPSTICKS_DESC']                      = 'Adds rich color and definition to your lips, enhancing your natural beauty.',
    ['NUI_MAKEUP_LIPSTICKS_TEXTURE']                   = 'Texture Types',
    ['NUI_MAKEUP_LIPSTICKS_PRIMARY_COLOR']             = 'Primary Color',
    ['NUI_MAKEUP_LIPSTICKS_SECONDARY_COLOR']           = 'Secondary Color',
    ['NUI_MAKEUP_LIPSTICKS_VARIANT']                   = 'Variants',
    ['NUI_MAKEUP_LIPSTICKS_OPACITY']                   = 'Opacity',


    ['NUI_MAKEUP_SHADOWS']                             = 'Shadows',
    ['NUI_MAKEUP_SHADOWS_DESC']                        = 'Brings color and depth to your eyes, perfect for both soft and bold looks.',
    ['NUI_MAKEUP_SHADOWS_TEXTURE']                     = 'Texture Types',
    ['NUI_MAKEUP_SHADOWS_PRIMARY_COLOR']               = 'Primary Color',
    ['NUI_MAKEUP_SHADOWS_SECONDARY_COLOR']             = 'Secondary Color',
    ['NUI_MAKEUP_SHADOWS_VARIANT']                     = 'Variants',
    ['NUI_MAKEUP_SHADOWS_OPACITY']                     = 'Opacity',
 
    ['NUI_MAKEUP_EYELINERS']                           = 'Eyeliners',
    ['NUI_MAKEUP_EYELINERS_DESC']                      = 'Defines and accentuates your eyes, giving them sharp or subtle emphasis.',    
    ['NUI_MAKEUP_EYELINERS_TEXTURE']                   = 'Texture Types',
    ['NUI_MAKEUP_EYELINERS_PRIMARY_COLOR']             = 'Primary Color',
    ['NUI_MAKEUP_EYELINERS_SECONDARY_COLOR']           = 'Secondary Color',
    ['NUI_MAKEUP_EYELINERS_VARIANT']                   = 'Variants',
    ['NUI_MAKEUP_EYELINERS_OPACITY']                   = 'Opacity',
    
    ['NUI_MAKEUP_BLUSH']                               = 'Blush',
    ['NUI_MAKEUP_BLUSH_DESC']                          = 'Adds a fresh, radiant touch to your cheeks for a healthy, glowing finish.',
    ['NUI_MAKEUP_BLUSH_TEXTURE']                       = 'Texture Types',
    ['NUI_MAKEUP_BLUSH_PRIMARY_COLOR']                 = 'Primary Color',
    ['NUI_MAKEUP_BLUSH_SECONDARY_COLOR']               = 'Secondary Color',
    ['NUI_MAKEUP_BLUSH_VARIANT']                       = 'Variants',
    ['NUI_MAKEUP_BLUSH_OPACITY']                       = 'Opacity',

    -- CLOTHING SECTION
    ['NUI_CLOTHING_INFO']                              = "Customize your character’s clothing outfit based on your preferences.",
    ['NUI_CATEGORY_CLOTHING_COATCLOSED_TITLE']         = "A fully buttoned or fastened coat that gives a formal, refined look.",
    ['NUI_CATEGORY_CLOTHING_COAT_TITLE']               = "An open or partially fastened outer garment worn over other clothes.",
    ['NUI_CATEGORY_CLOTHING_HAT_TITLE']                = "A head accessory defining silhouette and personality.",
    ['NUI_CATEGORY_CLOTHING_EYEWEAR_TITLE']            = "Glasses, goggles, or shades adding function or mystery.",
    ['NUI_CATEGORY_CLOTHING_MASK_TITLE']               = "Covers the face partially or fully for disguise or protection.",
    ['NUI_CATEGORY_CLOTHING_NECKWEAR_TITLE']           = "Scarves, necklaces, or wraps worn around the neck.",
    ['NUI_CATEGORY_CLOTHING_NECKTIES_TITLE']           = "Formal or decorative ties that complement shirts and vests.",
    ['NUI_CATEGORY_CLOTHING_SHIRT_TITLE']              = "The base upper-body clothing, available in various styles and materials.",
    ['NUI_CATEGORY_CLOTHING_SUSPENDER_TITLE']          = "Straps that attach to pants, giving a vintage or working-class look.",
    ['NUI_CATEGORY_CLOTHING_VEST_TITLE']               = "A sleeveless garment worn over a shirt, adding extra style or protection.",
    ['NUI_CATEGORY_CLOTHING_PONCHO_TITLE']             = "A loose, draped garment providing weather protection or a rugged look.",
    ['NUI_CATEGORY_CLOTHING_CLOAK_TITLE']              = "A long, flowing outer garment often used for dramatic flair or concealment.",
    ['NUI_CATEGORY_CLOTHING_GLOVE_TITLE']              = "Handwear for warmth, grip, or style.",
    ['NUI_CATEGORY_CLOTHING_BELT_TITLE']               = "Secures pants and adds detail or ornamentation.",
    ['NUI_CATEGORY_CLOTHING_PANT_TITLE']               = "Standard legwear; sets the base style for the lower half.",
    ['NUI_CATEGORY_CLOTHING_BOOTS_TITLE']              = "Sturdy footwear defining character posture and style.",
    ['NUI_CATEGORY_CLOTHING_SPURS_TITLE']              = "Metal attachments on boots used by riders; add a western or rugged touch.",
    ['NUI_CATEGORY_CLOTHING_BRACELET_TITLE']           = "Wrist accessory that adds detail or personal flair.",
    ['NUI_CATEGORY_CLOTHING_BUCKLE_TITLE']             = "The decorative or functional clasp of a belt or strap.",
    ['NUI_CATEGORY_CLOTHING_CHAP_TITLE']               = "Leather leg coverings worn over pants, often used by riders.",
    ['NUI_CATEGORY_CLOTHING_SPATS_TITLE']              = "Fabric or leather coverings for the tops of boots, adding polish or flair.",
    ['NUI_CATEGORY_CLOTHING_GAUNTLETS_TITLE']          = "Extended gloves that cover part of the forearm; often armored or decorative.",
    ['NUI_CATEGORY_CLOTHING_DRESS_TITLE']              = "A full-body garment often associated with elegance or formal wear.",
    ['NUI_CATEGORY_CLOTHING_HOLSTER_TITLE']            = "A holder for weapons or tools, typically worn at the hip or chest.",
    ['NUI_CATEGORY_CLOTHING_LOADOUTS_TITLE']           = "Complete gear sets defining a character’s functional or thematic style.",
    ['NUI_CATEGORY_CLOTHING_ACCESSORIES_TITLE']        = "Miscellaneous decorative or functional add-ons.",
    ['NUI_CATEGORY_CLOTHING_SATCHELS_TITLE']           = "Shoulder bags or pouches for carrying items.",
    ['NUI_CATEGORY_CLOTHING_HOLSTER_TITLE']            = "A holder for weapons or tools, typically worn at the hip or chest.",
    ['NUI_CATEGORY_CLOTHING_GUNBELT_TITLE']            = "A specialized belt designed to carry holsters and ammunition.",
    ['NUI_CATEGORY_CLOTHING_RINGRH_TITLE']             = "Ring worn on the right hand.",
    ['NUI_CATEGORY_CLOTHING_RINGLH_TITLE']             = "Ring worn on the left hand.",
    ['NUI_TINT_1']                                     = "Custom Tint (1)",
    ['NUI_TINT_2']                                     = "Custom Tint (2)",
    ['NUI_TINT_3']                                     = "Custom Tint (3)",

    ['NUI_BACK']                                       = "Back",
    
    ['CUSTOMIZE_CLOTHING_DESCRIPTION']                 = "Customize new character outfits", 
    ['TOTAL_TYPES']                                    = "Total Types: ",

    ['ACCEPT_BUTTON']                                  = "ACCEPT",
    ['DECLINE_BUTTON']                                 = "DECLINE",

    ["CoatClosed"]                                     = "Coats Closed",
    ["Coat"]                                           = "Coats",
    ["Hat"]                                            = "Hats",
    ["EyeWear"]                                        = "Eye wear",
    ["Mask"]                                           = "Masks",
    ["NeckWear"]                                       = "Neck wear",
    ["NeckTies"]                                       = "Neck Ties",
    ["Shirt"]                                          = "Shirts",
    ["Suspender"]                                      = "Suspenders",
    ["Vest"]                                           = "Vests",
    ["Poncho"]                                         = "Ponchos",
    ["Cloak"]                                          = "Cloaks",
    ["Glove"]                                          = "Gloves",
    ["Belt"]                                           = "Belts",
    ["Pant"]                                           = "Pants",
    ["Boots"]                                          = "Boots",
    ["Spurs"]                                          = "Spurs",
    ["Bracelet"]                                       = "Bracelets",
    ["Buckle"]                                         = "Belt Buckles",
    ["Skirt"]                                          = "Skirts",
    ["Chap"]                                           = "Chaps",
    ["Spats"]                                          = "Spats",
    ["GunbeltAccs"]                                    = "Gun Belts Accessories",
    ["Gauntlets"]                                      = "Gaunlets",
    ["Loadouts"]                                       = "Loadouts",
    ["Accessories"]                                    = "Accessories",
    ["Satchels"]                                       = "Satchels",
    ["Dress"]                                          = "Dresses",
    ["Holster"]                                        = "Left Holster",
    ["Gunbelt"]                                        = "Gun Belts",
    ["RingRh"]                                         = "Rings Right",
    ["RingLh"]                                         = "Rings Left",

    ['CREATE_CHARACTER_INVALID_IDENTIFICATION']        = "Your personal identity information is invalid or missing.",
    ['CREATE_CHARACTER_INVALID_FIRSTNAME']             = "Your firstname is invalid, please insert a valid firstname for your character.",
    ['CREATE_CHARACTER_INVALID_LASTNAME']              = "Your lastname is invalid, please insert a valid lastname for your character.",
    ['CREATE_CHARACTER_BLACKLISTED_FIRST_OR_LASTNAME'] = "Your firstname or lastname has inappropriate words, please be respectful.",
    ['CREATE_CHARACTER_NOT_PERMITTED_YEAR']            = "The date of birth identification input - (year) cannot be accepted, select a year between %s - %s.",

    ["CHARACTER_NOT_SELECTED"]                         = "~e~Character not selected", -- not translatable for many languages.
    ["CHARACTER_RELOADED"]                             = "Character reloaded!", -- not translatable for many languages.
    ['CHARACTER_RELOAD_NOT_PERMITTED']                 = "You are not allowed to reload player skin.", -- not translatable for many languages.

    ['DEVTOOLS_INJECTION_DETECTED_TITLE_LOG']          = "DevTools / Injection Cheat Found!",
    ['DEVTOOLS_INJECTION_DETECTED']                    = "You have been kicked due to cheating by using DevTools or Injection cheat.",

    ['RELOAD_CHARACTER_COMMAND_COOLDOWN']              = "~e~You can't do that for the next %s seconds.", -- not translatable for many languages.

}

---------------------------------------------------------------
--[[ EDIT SELECTED LANGUAGE ]]--
---------------------------------------------------------------

-- [ README ]
-- #1 IN CASE THE LANGUAGE IS NOT SUPPORTED, YOU HAVE TO REPLACE THE USED FONTS FROM THE CSS FILES.
-- THE USED FONT IS crock.ttf

-- #2 THERE ARE SOME TEXTS THAT ARE NOT TRANSLATABLE THROUGH THIS FILE, CHECKOUT components_config 
-- and index.html

Citizen.CreateThread(function()
    Wait(2000)

    if Config.LANGUAGE == 'EN' then -- <- MODIFY 'EN' TO DESIRED LANGUAGE OPTION TO BE USED ON Config.LANGUAGE
        Locales = locales
    end

end)