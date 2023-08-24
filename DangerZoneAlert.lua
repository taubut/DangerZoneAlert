local zoneLevels = {
    ["Elwynn Forest"] = {min=1, max=10},
    ["Westfall"] = {min=10, max=20},
    ["Redridge Mountains"] = {min=15, max=25},
    ["Duskwood"] = {min=18, max=30},
    ["Stranglethorn Vale"] = {min=30, max=45},
    ["Stormwind City"] = {min=1, max=60}, -- Cities are generally safe, but you can set them to your max level
        
    ["Dun Morogh"] = {min=1, max=10},
    ["Loch Modan"] = {min=10, max=20},
    ["Wetlands"] = {min=20, max=30},
    ["Ironforge"] = {min=1, max=60}, -- Cities are generally safe
        
    ["Tirisfal Glades"] = {min=1, max=10},
    ["Silverpine Forest"] = {min=10, max=20},
    ["Hillsbrad Foothills"] = {min=20, max=30},
    ["Hinterlands"] = {min=40, max=50},
    ["Undercity"] = {min=1, max=60}, -- Cities are generally safe
        
    ["Mulgore"] = {min=1, max=10},
    ["Durotar"] = {min=1, max=10},
    ["The Barrens"] = {min=10, max=25},
    ["Stonetalon Mountains"] = {min=15, max=27},
    ["Thousand Needles"] = {min=25, max=35},
    ["Tanaris"] = {min=40, max=50},
    ["Orgrimmar"] = {min=1, max=60}, -- Cities are generally safe
        
    ["Darkshore"] = {min=10, max=20},
    ["Ashenvale"] = {min=18, max=30},
    ["Desolace"] = {min=30, max=40},
    ["Feralas"] = {min=40, max=50},
    ["Teldrassil"] = {min=1, max=10},
    ["Darnassus"] = {min=1, max=60}, -- Cities are generally safe
        
    ["Eastern Plaguelands"] = {min=53, max=60},
    ["Western Plaguelands"] = {min=51, max=58},
    ["Arathi Highlands"] = {min=30, max=40},
    ["Alterac Mountains"] = {min=30, max=40},
    ["Stranglethorn Vale"] = {min=30, max=45},
    ["Dustwallow Marsh"] = {min=35, max=45},
    ["Badlands"] = {min=35, max=45},
    ["Blasted Lands"] = {min=45, max=55},
    ["Burning Steppes"] = {min=50, max=58},
    ["Deadwind Pass"] = {min=55, max=60},
    ["Felwood"] = {min=48, max=55},
    ["Moonglade"] = {min=1, max=60},
    ["Searing Gorge"] = {min=45, max=50},
    ["Azshara"] = {min=45, max=55},
    ["Silithus"] = {min=55, max=60},
    ["Swamp of Sorrows"] = {min=35, max=45},
    ["Un'Goro Crater"] = {min=48, max=55},
    ["Winterspring"] = {min=53, max=60}
}

local function checkZoneDanger()
    local playerLevel = UnitLevel("player")
    local currentZone = GetRealZoneText() 

    local zoneInfo = zoneLevels[currentZone]
    if zoneInfo then
        if playerLevel < zoneInfo.min then
            -- Display warning on screen
            UIErrorsFrame:AddMessage("WARNING: You are in a dangerous zone! Levels " .. zoneInfo.min .. " - " .. zoneInfo.max, 1, 0, 0, 1, 3)
        end
    end
end

--local function checkForDangerousMobs()
--    local playerLevel = UnitLevel("player")
--
--    for i = 1, 40 do
--        local unit = "nameplate" .. i
--        if UnitExists(unit) and not UnitIsPlayer(unit) then
--            local mobLevel = UnitLevel(unit)
--            if mobLevel - playerLevel >= 4 then
--                UIErrorsFrame:AddMessage("WARNING: A high-level mob is nearby!", 1, 0, 0, 1, 3)
--                break
--            end
--       end
--    end
--end

local elapsed = 0

local frame = CreateFrame("Frame")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnUpdate", function(self, delta)
    elapsed = elapsed + delta
    if elapsed > 1 then -- Check every second
        checkForDangerousMobs()
        elapsed = 0
    end
end)

frame:SetScript("OnEvent", function(self, event, ...)
    checkZoneDanger()
end)

