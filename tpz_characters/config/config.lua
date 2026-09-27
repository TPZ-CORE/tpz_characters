
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
    
    -- Randomly selecting a location when player has joined to the server for selecting or creating new characters.
    Locations = {

        [1] = {
            Index = 1, -- Index is required (Must be the same as @Locations Index)

            Modifications = {

                Weather      = { Type = "sunny", Transition = 19, Snow = false },  
                Timecycle    = { ModifierName = "teaser_trainShot", Strenght = 1.0 },
                ClockTime    = { Hour = 20, Transition = 10 },
                Music        = 'REHR_START',
            },


            CharacterPositions = {
                [1] = {
                    SpawnPosition = { x = 1779.639, y = -810.236, z = 187.45, h = 130.942245483},
                    Camera        = { x = 1777.250, y = -810.463, z = 189.459, rotx = -9.368, roty = 0.000, rotz = 258.341, fov = 50.0 },

                    -- There's must be a chair next to the player spawn coords for performing a chair scenario.
                    PerformChairSeatScenario = true, -- 2.0.8

                    Scenarios = { -- THIS IS FUNCTIONAL ONLY IF @PerformChairSeatScenario = false

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
                    SpawnPosition = { x = 1780.008, y = -806.291, z = 187.95, h = 233.2605438 },
                    Camera        = { x = 1783.223, y = -807.291, z = 189.559, rotx = -14.569, roty = 0.000, rotz = 95.330, fov = 50.0 } ,
            
                    -- There's must be a chair next to the player spawn coords for performing a chair scenario.
                    PerformChairSeatScenario = true, -- 2.0.8

                    Scenarios = { -- THIS IS FUNCTIONAL ONLY IF @PerformChairSeatScenario = false

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

                [3] = {
                    SpawnPosition = { x = 1789.315, y = -804.189, z = 187.95, h = 89.5257644653 },
                    Camera        = { x = 1786.116, y = -802.832, z = 189.359, rotx = -6.749, roty = 0.000, rotz = 226.478, fov = 50.0 },
                 
                    -- There's must be a chair next to the player spawn coords for performing a chair scenario.
                    PerformChairSeatScenario = true, -- 2.0.8

                    Scenarios = { -- THIS IS FUNCTIONAL ONLY IF @PerformChairSeatScenario = false

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

            },
         
        }
    },

}
