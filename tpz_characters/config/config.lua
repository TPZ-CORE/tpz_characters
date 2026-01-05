
Config = {}

Config.Debug   = true

-- Default Locales: EN, GR.
-- To create your own language, move to locales directory folder and create a new file as the existing ones.
Config.LANGUAGE = 'EN'

-- The specified notification colors are ONLY on the character creation.
Config.NotificationColors = { 
    ['error']   = "rgba(255, 0, 0, 0.79)",
    ['success'] = "rgba(0, 255, 0, 0.79)",
    ['info']    = "rgba(102, 178, 255, 0.79)"
}

---------------------------------------------------------------
--[[ General Settings ]]--
---------------------------------------------------------------

-- @BlacklistedNames : When creating a new character, the specified used words will be blacklisted.
-- (!) Remove * symbol, this symbol has been added by default for safety.
Config.BlacklistedNames = {
    'd*ck', '*sshole', 'motherf*cker', 
    'f*ck', 'sh*t', 'p*ssy', 'b*stard', 
    'p*nis', 'penn*s', 'f*cker', 
}

Config.ReloadCharacter = { 
    Enabled = true, 
    Command = "reloadskin", 
    Description = "Reload your current character skin",
    Cooldown = 120,
} -- 120 as default (equals to 2 minutes), time in seconds

-- Roleplay servers require a valid date for a character creation,
-- the default option allows players to have a date between 1800 - 1885 (we dont want server year either, the player is not a newborn).
Config.YearInputs = { min = 1800, max = 1885 }

---------------------------------------------------------------
--[[ Characters Creation ]]--
---------------------------------------------------------------

Config.OnCharacterCreate = {

    Modifications = {

        -- The player position for the character creation.
        SpawnPlayerPosition = { x = -558.20947265625, y = -3781.47314453125, z = 237.5975799560547, h = 96.01731872558594 },
        Weather      = { Type = "sunny", Transition = 20, Snow = false },  
        Timecycle    = { ModifierName = "Online_Character_Editor", Strenght = 1.0 },
        ClockTime    = { Hour = 10, Transition = 10 },
        Music        = 'REHR_START',

        MainCamera = {  x = -561.183, y = -3781.43, z = 239.2, rotx = 0.0, roty = 0.0, rotz = 269.35, fov = 32.0  },
    },

    CameraAdjustmentPromptDescription = "Camera Adjustments",

    CameraAdjustmentPrompts = {
        ['CHARACTER_ADJUSTMENT_LEFT_AND_RIGHT']       = {label = "LEFT & RIGHT ROTATIONS",                key1 = 0x7065027D, key2 = 0xB4E465B4}, -- Do not touch.
        ['CHARACTER_ADJUSTMENT_UP_AND_DOWN']          = {label = "UP & DOWN CAMERA ADJUSTMENTS",          key1 = 0x8FD015D8, key2 = 0xD27782E3}, -- Do not touch.
        ['CHARACTER_ADJUSTMENT_ZOOM_IN_AND_ZOOM_OUT'] = {label = "ZOOM IN & ZOOM OUT CAMERA ADJUSTMENTS", key1 = 0x62800C92, key2 = 0x8BDE7443}, -- Do not touch.
        ['CHARACTER_ADJUSTMENT_HANDS_UP']             = {label = "HANDS UP",                              key1 = 0x8CC9CD42, key2 = nil}, -- Do not touch.
    },
    
    HandsUpAnimation = {
        Dict = "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs",
        Body = "handsup_register_owner",
    },
    
    HeightScales = {
        { label = 'Short',  scale = 0.95 },
        { label = 'Normal', scale = 1.0  },
        { label = 'Tall',   scale = 1.05 },
    },
}

---------------------------------------------------------------
--[[ Characters Selection ]]--
---------------------------------------------------------------

Config.OnCharacterSelector = {

    Prompts = {
        ['PREVIOUS_CHARACTER']  = {label = "Previous Character", key = 0xA65EBAB4, hold = 1},
        ['NEXT_CHARACTER']      = {label = "Next Character", key = 0xDEB34313, hold = 1 },
        
        ['SELECT_CHARACTER']    = {label = "Select", key = 0xD9D0E1C0, hold = 1500 },
        ['CREATE_CHARACTER']    = {label = "Create New Character", key = 0x156F7119, hold = 1500 },

        ['DELETE_CHARACTER']    = {label = "Delete Permanently", key = 0xC7B5340A, hold = 2500 },
    },

    -- Randomly selecting a location when player has joined to the server for selecting or creating new characters.
    Locations = {

        [1] = {
            Index = 1, -- Index is required (Must be the same as @Locations Index)

            Modifications = {

                -- The player position (do not add close to the characters selection)
                SpawnPlayerPosition = { x = 3291.271, y = -720.341, z = 42.460 },

                Weather      = { Type = "sunny", Transition = 19, Snow = false },  
                Timecycle    = { ModifierName = "teaser_trainShot", Strenght = 1.0 },
                ClockTime    = { Hour = 19, Transition = 10 },
                Music        = 'REHR_START',

                -- Camera location when no characters are selected.
                MainCamera = { x = 3299.27, y = -705.08, z = 44.55, rotx = 0.0, roty = 0.0, rotz = 130.0, fov = 60.0  },
            },

            CharacterPositions = {
                [1] = {
                    SpawnPosition = { x = 3294.5927734375, y = -709.4757690429688, z = 43.47323608398437, h = -46.73543930053711 },
                    Camera        = { x = 3297.212, y = -708.690, z = 43.871, rotx = 0.0, roty = 0.0, rotz = 90.0, fov = 60.0 },
                 
                    Scenarios = {

                        ['female'] = {
                            "WORLD_HUMAN_SMOKE_CARRYING",
                            "MP_LOBBY_SCENARIO_08",
                            "WORLD_HUMAN_SMOKE_CARRYING"
                        },

                        ['male'] = {
                            "WORLD_HUMAN_SMOKE_CARRYING",
                            "MP_LOBBY_SCENARIO_08",
                            "WORLD_HUMAN_SMOKE_CARRYING"
                        },

                    },

                },

                [2] = {
                    SpawnPosition = { x = 3294.02294921875, y = -713.1904296875, z = 43.20399551391601, h = -32.87755966186523 },
                    Camera        = { x = 3296.312, y = -709.560, z = 43.552, rotx = 0.0, roty = 0.0, rotz = 145.0, fov = 40.0 },
                  
                    Scenarios = {

                        ['female'] = {
                            "MP_LOBBY_SCENARIO_02",
                            "MP_LOBBY_SCENARIO_04",
                            "MP_LOBBY_SCENARIO_07",
                            "WORLD_HUMAN_SMOKE_CARRYING"
                        },

                        ['male'] = {
                            "MP_LOBBY_SCENARIO_02",
                            "MP_LOBBY_SCENARIO_04",
                            "MP_LOBBY_SCENARIO_07",
                            "WORLD_HUMAN_SMOKE_CARRYING"
                        },

                    },
                },

                [3] = {
                    SpawnPosition = { x = 3286.9814453125, y = -707.7363891601562, z = 43.29147720336914, h = -86.77998352050781 },
                    Camera        = { x = 3290.69, y = -709.61, z = 43.52, rotx = 0.0, roty = 0.0, rotz = 60.0, fov = 60.0 },
                 
                    Scenarios = {

                        ['female'] = {
                            "WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK",
                            "MP_LOBBY_CROUCHING_B",
                            "WORLD_HUMAN_SIT_DRINK",
                            "WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER"
                        },

                        ['male'] = {
                            "WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK",
                            "MP_LOBBY_CROUCHING_B",
                            "WORLD_HUMAN_SIT_DRINK",
                            "WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER"
                        },

                    },

                },

            },
         
        }
    },

}

---------------------------------------------------------------
--[[ Webhooks ]]--
---------------------------------------------------------------

Config.Webhooks = {

    ["DEVTOOLS_INJECTION_CHEAT"] = {
        Enabled = false,
        Url = "",
        Color = 10038562,
    },

}

