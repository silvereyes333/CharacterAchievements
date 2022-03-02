local addon = CharacterAchievements
local class = addon.classes
local debug = false
local ZONE_ACHIEVEMENTS, BOSS_ACHIEVEMENTS, DATA_DEFAULTS

local Data = ZO_Object:Subclass()

function Data:New(...)
    local instance = ZO_Object.New(self)
    self.Initialize(instance, ...)
    return instance
end

function Data:Initialize()
    
    self.save = LibSavedVars:NewCharacterSettings(addon.name .. "Data", {})
    self.esoui = {}
    self.esouiNames = {
        GetInfo = "GetAchievementInfo",
        GetTimestamp = "GetAchievementTimestamp",
        GetPersistenceLevel = "GetAchievementPersistenceLevel",
        GetCharIdForCompletedAchievement = "GetCharIdForCompletedAchievement"
    }
    
    for handlerName, methodName in pairs(self.esoui) do
        local method = _G[methodName]
        if method then
            self.esoui[methodName] = method
            _G[methodName] = self:Closure(handlerName)
        end
    end
end



---------------------------------------
--
--          Public Methods
-- 
---------------------------------------

--[[  ]]
function Data:Closure(functionName)
    return function(...)
        self[functionName](self, ...)
    end
end

--[[  ]]
function Data:GetInfo(achievementId)
    local name, description, points, icon, completed, date, time = self.esoui.GetAchievementInfo(achievementId)
    local timestamp = self.save[achievementId]
    if timestamp then
        date, time = FormatAchievementLinkTimestamp(timestamp)
        completed = true
    end
    return name, description, points, icon, completed, date, time
end

--[[  ]]
function Data:GetPersistenceLevel(achievementId)
    if self.save[achievementId] or not ACHIEVEMENT_PERSISTENCE_CHARACTER then
        return ACHIEVEMENT_PERSISTENCE_CHARACTER
    end
    return self.esoui.GetPersistenceLevel(achievementId)
end

--[[  ]]
function Data:GetCharIdForCompletedAchievement(achievementId)
    if self.save[achievementId] or not GetCharIdForCompletedAchievement then
        return GetCurrentCharacterId()
    end
    return self.esoui.GetCharIdForCompletedAchievement(achievementId)
end

--[[  ]]
function Data:GetTimestamp(achievementId)
    return self.save[achievementId] or GetAchievementTimestamp(achievementId)
end

--[[ Sets the given achievement id as completed by the current character at the given timestamp ]]
function Data:SetCompletedTimestamp(achievementId, timestamp)
    self.save[achievementId] = timestamp
end

---------------------------------------
--
--          Private Members
-- 
---------------------------------------

-- Create singleton
addon.Data = Data:New()
