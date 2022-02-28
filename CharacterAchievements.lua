-- Character Achievements Addon for Elder Scrolls Online
-- Author: silvereyes

CharacterAchievements = {
    name = "CharacterAchievements",
    title = "Character Achievements",
    version = "1.0.0",
    author = "silvereyes",
}

-- Local declarations
local addon = CharacterAchievements
local onAddonLoaded



---------------------------------------
--
--          Public Methods
-- 
---------------------------------------


---------------------------------------
--
--          Private Methods
-- 
---------------------------------------

function onAddonLoaded(event, name)
    if name ~= addon.name then return end
    EVENT_MANAGER:UnregisterForEvent(addon.name, EVENT_ADD_ON_LOADED)
    
    if GetAPIVersion() >= 101033 then
        addon.Events:Initialize()
    else
        addon.Backup:SaveAllAchievements()
    end
end




-- Register addon
EVENT_MANAGER:RegisterForEvent(addon.name, EVENT_ADD_ON_LOADED, onAddonLoaded)