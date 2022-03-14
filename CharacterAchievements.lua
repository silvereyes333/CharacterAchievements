-- Character Achievements Addon for Elder Scrolls Online
-- Author: silvereyes

CharacterAchievements = {
    name = "CharacterAchievements",
    title = "Character Achievements",
    version = "1.0.1",
    author = "silvereyes",
}

-- Local declarations
local addon = CharacterAchievements



---------------------------------------
--
--          Public Members
-- 
---------------------------------------

if LibChatMessage then
    addon.Chat = LibChatMessage(addon.name, "CharAchvmts")
end



---------------------------------------
--
--          Private Methods
-- 
---------------------------------------



