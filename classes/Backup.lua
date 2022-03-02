local addon = CharacterAchievements
local class = addon.classes
local debug = false

local Backup = ZO_Object:Subclass()

function Backup:New(...)
    return ZO_Object.New(self)
end



---------------------------------------
--
--          Public Methods
-- 
---------------------------------------

--[[  ]]
function Backup:SaveAllAchievements()
    -- TODO: implement
end

---------------------------------------
--
--          Private Members
-- 
---------------------------------------

-- Create singleton
addon.Backup = Backup:New()
