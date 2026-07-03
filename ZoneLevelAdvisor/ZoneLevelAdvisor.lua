local DISPLAY_NAME = "Zone Level Advisor"
local COMMAND = "zla"
local MAX_ZONE_ROWS = 5
local MAX_DUNGEON_ROWS = 5
local FRAME_WIDTH = 640
local FRAME_HEIGHT = 570
local CONTENT_WIDTH = 570
local ROW_SPACING = 38

local zones = {
    -- Alliance starting and early leveling routes.
    { name = "Azuremyst Isle", min = 1, max = 10, faction = "Alliance", continent = "Kalimdor", note = "Draenei starting zone" },
    { name = "Dun Morogh", min = 1, max = 10, faction = "Alliance", continent = "Eastern Kingdoms", note = "Dwarf and gnome starting zone" },
    { name = "Elwynn Forest", min = 1, max = 10, faction = "Alliance", continent = "Eastern Kingdoms", note = "Human starting zone" },
    { name = "Teldrassil", min = 1, max = 10, faction = "Alliance", continent = "Kalimdor", note = "Night elf starting zone" },
    { name = "Bloodmyst Isle", min = 10, max = 20, faction = "Alliance", continent = "Kalimdor", note = "Draenei follow-up zone" },
    { name = "Darkshore", min = 10, max = 20, faction = "Alliance", continent = "Kalimdor", note = "Night elf follow-up zone" },
    { name = "Loch Modan", min = 10, max = 20, faction = "Alliance", continent = "Eastern Kingdoms", note = "Dwarf and gnome follow-up zone" },
    { name = "Westfall", min = 10, max = 20, faction = "Alliance", continent = "Eastern Kingdoms", note = "Human follow-up zone" },
    { name = "Redridge Mountains", min = 15, max = 25, faction = "Alliance", continent = "Eastern Kingdoms", note = "Stormwind quest hub" },
    { name = "Duskwood", min = 18, max = 30, faction = "Alliance", continent = "Eastern Kingdoms", note = "Stormwind quest hub" },
    { name = "Wetlands", min = 20, max = 30, faction = "Alliance", continent = "Eastern Kingdoms", note = "Alliance travel hub" },

    -- Horde starting and early leveling routes.
    { name = "Durotar", min = 1, max = 10, faction = "Horde", continent = "Kalimdor", note = "Orc and troll starting zone" },
    { name = "Eversong Woods", min = 1, max = 10, faction = "Horde", continent = "Eastern Kingdoms", note = "Blood elf starting zone" },
    { name = "Mulgore", min = 1, max = 10, faction = "Horde", continent = "Kalimdor", note = "Tauren starting zone" },
    { name = "Tirisfal Glades", min = 1, max = 10, faction = "Horde", continent = "Eastern Kingdoms", note = "Undead starting zone" },
    { name = "Ghostlands", min = 10, max = 20, faction = "Horde", continent = "Eastern Kingdoms", note = "Blood elf follow-up zone" },
    { name = "Silverpine Forest", min = 10, max = 20, faction = "Horde", continent = "Eastern Kingdoms", note = "Undercity follow-up zone" },
    { name = "The Barrens", min = 10, max = 25, faction = "Horde", continent = "Kalimdor", note = "Large Horde leveling route" },

    -- Shared Classic zones.
    { name = "Stonetalon Mountains", min = 15, max = 27, faction = "Both", continent = "Kalimdor", note = "Contested Kalimdor route" },
    { name = "Ashenvale", min = 18, max = 30, faction = "Both", continent = "Kalimdor", note = "Contested forest route" },
    { name = "Hillsbrad Foothills", min = 20, max = 30, faction = "Both", continent = "Eastern Kingdoms", note = "Contested foothills route" },
    { name = "Thousand Needles", min = 25, max = 35, faction = "Both", continent = "Kalimdor", note = "Good bridge into the 30s" },
    { name = "Alterac Mountains", min = 30, max = 40, faction = "Both", continent = "Eastern Kingdoms", note = "Optional contested route" },
    { name = "Arathi Highlands", min = 30, max = 40, faction = "Both", continent = "Eastern Kingdoms", note = "Contested quest hubs" },
    { name = "Desolace", min = 30, max = 40, faction = "Both", continent = "Kalimdor", note = "Wide questing route" },
    { name = "Stranglethorn Vale", min = 30, max = 45, faction = "Both", continent = "Eastern Kingdoms", note = "Dense but contested questing" },
    { name = "Badlands", min = 35, max = 45, faction = "Both", continent = "Eastern Kingdoms", note = "Good mid-30s route" },
    { name = "Dustwallow Marsh", min = 35, max = 45, faction = "Both", continent = "Kalimdor", note = "Quest hub for both factions" },
    { name = "Swamp of Sorrows", min = 35, max = 45, faction = "Both", continent = "Eastern Kingdoms", note = "Optional mid-30s route" },
    { name = "Feralas", min = 40, max = 50, faction = "Both", continent = "Kalimdor", note = "Strong 40s route" },
    { name = "Tanaris", min = 40, max = 50, faction = "Both", continent = "Kalimdor", note = "Strong 40s route" },
    { name = "The Hinterlands", min = 40, max = 50, faction = "Both", continent = "Eastern Kingdoms", note = "Faction hubs on both sides" },
    { name = "Searing Gorge", min = 43, max = 50, faction = "Both", continent = "Eastern Kingdoms", note = "Compact questing route" },
    { name = "Azshara", min = 45, max = 55, faction = "Both", continent = "Kalimdor", note = "Optional late-40s route" },
    { name = "Blasted Lands", min = 45, max = 55, faction = "Both", continent = "Eastern Kingdoms", note = "Leads toward Outland" },
    { name = "Felwood", min = 48, max = 55, faction = "Both", continent = "Kalimdor", note = "Good bridge to the Plaguelands" },
    { name = "Un'Goro Crater", min = 48, max = 55, faction = "Both", continent = "Kalimdor", note = "Dense questing route" },
    { name = "Burning Steppes", min = 50, max = 58, faction = "Both", continent = "Eastern Kingdoms", note = "Late Classic route" },
    { name = "Western Plaguelands", min = 51, max = 58, faction = "Both", continent = "Eastern Kingdoms", note = "Late Classic route" },
    { name = "Eastern Plaguelands", min = 53, max = 60, faction = "Both", continent = "Eastern Kingdoms", note = "Late Classic route" },
    { name = "Winterspring", min = 53, max = 60, faction = "Both", continent = "Kalimdor", note = "Late Classic route" },
    { name = "Silithus", min = 55, max = 60, faction = "Both", continent = "Kalimdor", note = "Optional late Classic route" },

    -- Outland.
    { name = "Hellfire Peninsula", min = 58, max = 63, faction = "Both", continent = "Outland", note = "First Outland zone" },
    { name = "Zangarmarsh", min = 60, max = 64, faction = "Both", continent = "Outland", note = "Early Outland route" },
    { name = "Terokkar Forest", min = 62, max = 65, faction = "Both", continent = "Outland", note = "Mid Outland route" },
    { name = "Nagrand", min = 64, max = 67, faction = "Both", continent = "Outland", note = "Strong mid Outland route" },
    { name = "Blade's Edge Mountains", min = 65, max = 68, faction = "Both", continent = "Outland", note = "Late Outland route" },
    { name = "Netherstorm", min = 67, max = 70, faction = "Both", continent = "Outland", note = "Late Outland route" },
    { name = "Shadowmoon Valley", min = 67, max = 70, faction = "Both", continent = "Outland", note = "Late Outland route" },

    -- Northrend.
    { name = "Borean Tundra", min = 68, max = 72, faction = "Both", continent = "Northrend", note = "First Northrend zone" },
    { name = "Howling Fjord", min = 68, max = 72, faction = "Both", continent = "Northrend", note = "First Northrend zone" },
    { name = "Dragonblight", min = 71, max = 74, faction = "Both", continent = "Northrend", note = "Central Northrend route" },
    { name = "Grizzly Hills", min = 73, max = 75, faction = "Both", continent = "Northrend", note = "Mid Northrend route" },
    { name = "Zul'Drak", min = 74, max = 77, faction = "Both", continent = "Northrend", note = "Late Northrend route" },
    { name = "Sholazar Basin", min = 76, max = 78, faction = "Both", continent = "Northrend", note = "Dense late Northrend route" },
    { name = "The Storm Peaks", min = 77, max = 80, faction = "Both", continent = "Northrend", note = "Endgame leveling route" },
    { name = "Icecrown", min = 77, max = 80, faction = "Both", continent = "Northrend", note = "Endgame leveling route" },
}

local dungeons = {
    -- Classic dungeons.
    { name = "Ragefire Chasm", min = 13, max = 18, faction = "Horde", continent = "Kalimdor", note = "Orgrimmar dungeon" },
    { name = "The Deadmines", min = 17, max = 24, faction = "Alliance", continent = "Eastern Kingdoms", note = "Westfall dungeon" },
    { name = "Wailing Caverns", min = 17, max = 24, faction = "Both", continent = "Kalimdor", note = "Very convenient for Horde" },
    { name = "Shadowfang Keep", min = 18, max = 25, faction = "Both", continent = "Eastern Kingdoms", note = "Very convenient for Horde" },
    { name = "The Stockade", min = 22, max = 30, faction = "Alliance", continent = "Eastern Kingdoms", note = "Stormwind dungeon" },
    { name = "Blackfathom Deeps", min = 23, max = 30, faction = "Both", continent = "Kalimdor", note = "Ashenvale coast dungeon" },
    { name = "Gnomeregan", min = 24, max = 34, faction = "Alliance", continent = "Eastern Kingdoms", note = "Alliance-friendly dungeon" },
    { name = "Razorfen Kraul", min = 30, max = 40, faction = "Both", continent = "Kalimdor", note = "Southern Barrens dungeon" },
    { name = "Scarlet Monastery: Graveyard", min = 28, max = 34, faction = "Both", continent = "Eastern Kingdoms", note = "Early Scarlet Monastery wing" },
    { name = "Scarlet Monastery: Library", min = 32, max = 38, faction = "Both", continent = "Eastern Kingdoms", note = "Mid Scarlet Monastery wing" },
    { name = "Scarlet Monastery: Armory", min = 35, max = 40, faction = "Both", continent = "Eastern Kingdoms", note = "Mid Scarlet Monastery wing" },
    { name = "Scarlet Monastery: Cathedral", min = 38, max = 44, faction = "Both", continent = "Eastern Kingdoms", note = "Final Scarlet Monastery wing" },
    { name = "Uldaman", min = 35, max = 45, faction = "Both", continent = "Eastern Kingdoms", note = "Badlands dungeon" },
    { name = "Razorfen Downs", min = 40, max = 50, faction = "Both", continent = "Kalimdor", note = "Thousand Needles dungeon" },
    { name = "Maraudon", min = 40, max = 52, faction = "Both", continent = "Kalimdor", note = "Desolace dungeon" },
    { name = "Zul'Farrak", min = 44, max = 54, faction = "Both", continent = "Kalimdor", note = "Tanaris dungeon" },
    { name = "Sunken Temple", min = 50, max = 55, faction = "Both", continent = "Eastern Kingdoms", note = "Swamp of Sorrows dungeon" },
    { name = "Blackrock Depths", min = 52, max = 60, faction = "Both", continent = "Eastern Kingdoms", note = "Large late Classic dungeon" },
    { name = "Lower Blackrock Spire", min = 55, max = 60, faction = "Both", continent = "Eastern Kingdoms", note = "Late Classic dungeon" },
    { name = "Dire Maul", min = 55, max = 60, faction = "Both", continent = "Kalimdor", note = "Late Classic dungeon hub" },
    { name = "Scholomance", min = 58, max = 60, faction = "Both", continent = "Eastern Kingdoms", note = "Late Classic dungeon" },
    { name = "Stratholme", min = 58, max = 60, faction = "Both", continent = "Eastern Kingdoms", note = "Late Classic dungeon" },

    -- Outland dungeons.
    { name = "Hellfire Ramparts", min = 58, max = 63, faction = "Both", continent = "Outland", note = "First Outland dungeon" },
    { name = "The Blood Furnace", min = 60, max = 65, faction = "Both", continent = "Outland", note = "Hellfire Citadel dungeon" },
    { name = "The Slave Pens", min = 62, max = 66, faction = "Both", continent = "Outland", note = "Coilfang Reservoir dungeon" },
    { name = "The Underbog", min = 63, max = 67, faction = "Both", continent = "Outland", note = "Coilfang Reservoir dungeon" },
    { name = "Mana-Tombs", min = 64, max = 68, faction = "Both", continent = "Outland", note = "Auchindoun dungeon" },
    { name = "Auchenai Crypts", min = 65, max = 69, faction = "Both", continent = "Outland", note = "Auchindoun dungeon" },
    { name = "Old Hillsbrad Foothills", min = 66, max = 68, faction = "Both", continent = "Kalimdor", note = "Caverns of Time dungeon" },
    { name = "Sethekk Halls", min = 67, max = 70, faction = "Both", continent = "Outland", note = "Auchindoun dungeon" },
    { name = "The Steamvault", min = 68, max = 70, faction = "Both", continent = "Outland", note = "Coilfang Reservoir dungeon" },
    { name = "The Mechanar", min = 69, max = 70, faction = "Both", continent = "Outland", note = "Tempest Keep dungeon" },
    { name = "The Botanica", min = 70, max = 70, faction = "Both", continent = "Outland", note = "Tempest Keep dungeon" },
    { name = "The Arcatraz", min = 70, max = 70, faction = "Both", continent = "Outland", note = "Tempest Keep dungeon" },
    { name = "Shadow Labyrinth", min = 69, max = 70, faction = "Both", continent = "Outland", note = "Auchindoun dungeon" },
    { name = "The Shattered Halls", min = 70, max = 70, faction = "Both", continent = "Outland", note = "Hellfire Citadel dungeon" },
    { name = "The Black Morass", min = 68, max = 70, faction = "Both", continent = "Kalimdor", note = "Caverns of Time dungeon" },
    { name = "Magisters' Terrace", min = 70, max = 70, faction = "Both", continent = "Eastern Kingdoms", note = "Isle of Quel'Danas dungeon" },

    -- Northrend dungeons.
    { name = "Utgarde Keep", min = 68, max = 72, faction = "Both", continent = "Northrend", note = "First Northrend dungeon" },
    { name = "The Nexus", min = 68, max = 72, faction = "Both", continent = "Northrend", note = "First Northrend dungeon" },
    { name = "Azjol-Nerub", min = 70, max = 74, faction = "Both", continent = "Northrend", note = "Dragonblight dungeon" },
    { name = "Ahn'kahet: The Old Kingdom", min = 71, max = 75, faction = "Both", continent = "Northrend", note = "Dragonblight dungeon" },
    { name = "Drak'Tharon Keep", min = 72, max = 76, faction = "Both", continent = "Northrend", note = "Grizzly Hills dungeon" },
    { name = "The Violet Hold", min = 73, max = 77, faction = "Both", continent = "Northrend", note = "Dalaran dungeon" },
    { name = "Gundrak", min = 74, max = 78, faction = "Both", continent = "Northrend", note = "Zul'Drak dungeon" },
    { name = "Halls of Stone", min = 75, max = 79, faction = "Both", continent = "Northrend", note = "Storm Peaks dungeon" },
    { name = "The Oculus", min = 77, max = 80, faction = "Both", continent = "Northrend", note = "Borean Tundra dungeon" },
    { name = "Halls of Lightning", min = 77, max = 80, faction = "Both", continent = "Northrend", note = "Storm Peaks dungeon" },
    { name = "Utgarde Pinnacle", min = 78, max = 80, faction = "Both", continent = "Northrend", note = "Howling Fjord dungeon" },
    { name = "The Culling of Stratholme", min = 78, max = 80, faction = "Both", continent = "Northrend", note = "Caverns of Time dungeon" },
    { name = "Trial of the Champion", min = 80, max = 80, faction = "Both", continent = "Northrend", note = "Level 80 dungeon" },
    { name = "The Forge of Souls", min = 80, max = 80, faction = "Both", continent = "Northrend", note = "Icecrown Citadel dungeon" },
    { name = "Pit of Saron", min = 80, max = 80, faction = "Both", continent = "Northrend", note = "Icecrown Citadel dungeon" },
    { name = "Halls of Reflection", min = 80, max = 80, faction = "Both", continent = "Northrend", note = "Icecrown Citadel dungeon" },
}

local uiFrame
local summaryLine
local zoneHeaderLine
local dungeonHeaderLine
local zoneRowLines = {}
local dungeonRowLines = {}

local function Print(message)
    DEFAULT_CHAT_FRAME:AddMessage("|cffffd200" .. DISPLAY_NAME .. ":|r " .. message)
end

local function GetPlayerFaction()
    local faction = UnitFactionGroup("player")

    if faction == "Alliance" or faction == "Horde" then
        return faction
    end

    return "Both"
end

local function MatchesFaction(entry, faction)
    return entry.faction == "Both" or entry.faction == faction or faction == "Both"
end

local function GetFitText(entry, level)
    if level < entry.min then
        return "Soon at level " .. entry.min
    end

    if level > entry.max then
        return "Easy now"
    end

    if level <= entry.min + 1 then
        return "Good starter"
    end

    if level >= entry.max - 1 then
        return "Finish soon"
    end

    return "Strong fit"
end

local function BuildCandidate(entry, level, group)
    local midpoint = (entry.min + entry.max) / 2
    local score = math.abs(level - midpoint)

    if group == "future" then
        score = entry.min - level
    elseif group == "past" then
        score = level - entry.max
    end

    return {
        entry = entry,
        group = group,
        score = score,
    }
end

local function CandidateSort(a, b)
    if a.score == b.score then
        if a.entry.min == b.entry.min then
            return a.entry.name < b.entry.name
        end

        return a.entry.min < b.entry.min
    end

    return a.score < b.score
end

local function PastSort(a, b)
    if a.entry.max == b.entry.max then
        return a.entry.name < b.entry.name
    end

    return a.entry.max > b.entry.max
end

local function GetRecommendations(entries, level, faction, limit)
    local active = {}
    local future = {}
    local past = {}
    local results = {}
    local i

    for i = 1, #entries do
        local entry = entries[i]

        if MatchesFaction(entry, faction) then
            if level >= entry.min and level <= entry.max then
                table.insert(active, BuildCandidate(entry, level, "active"))
            elseif level < entry.min then
                table.insert(future, BuildCandidate(entry, level, "future"))
            else
                table.insert(past, BuildCandidate(entry, level, "past"))
            end
        end
    end

    table.sort(active, CandidateSort)
    table.sort(future, CandidateSort)
    table.sort(past, PastSort)

    for i = 1, #active do
        table.insert(results, active[i].entry)
        if #results >= limit then
            return results
        end
    end

    for i = 1, #future do
        table.insert(results, future[i].entry)
        if #results >= limit then
            return results
        end
    end

    for i = 1, #past do
        table.insert(results, past[i].entry)
        if #results >= limit then
            return results
        end
    end

    return results
end

local function FormatRecommendationLine(index, entry, level)
    return index .. ". " .. entry.name .. " (" .. entry.min .. "-" .. entry.max .. ") - " .. entry.continent .. " - " .. GetFitText(entry, level)
end

local function RefreshUI()
    if not uiFrame then
        return
    end

    local level = UnitLevel("player")
    local faction = GetPlayerFaction()
    local zoneRecommendations = GetRecommendations(zones, level, faction, MAX_ZONE_ROWS)
    local dungeonRecommendations = GetRecommendations(dungeons, level, faction, MAX_DUNGEON_ROWS)
    local i

    summaryLine:SetText("Level " .. level .. " " .. faction .. " character")
    zoneHeaderLine:SetText("Zones")
    dungeonHeaderLine:SetText("Dungeons")

    for i = 1, MAX_ZONE_ROWS do
        local zone = zoneRecommendations[i]

        if zone then
            zoneRowLines[i]:SetText(FormatRecommendationLine(i, zone, level) .. "\n|cffb0b0b0" .. zone.note .. "|r")
        else
            zoneRowLines[i]:SetText("")
        end
    end

    for i = 1, MAX_DUNGEON_ROWS do
        local dungeon = dungeonRecommendations[i]

        if dungeon then
            dungeonRowLines[i]:SetText(FormatRecommendationLine(i, dungeon, level) .. "\n|cffb0b0b0" .. dungeon.note .. "|r")
        else
            dungeonRowLines[i]:SetText("")
        end
    end
end

local function CreateUI()
    if uiFrame then
        return
    end

    local frame = CreateFrame("Frame", "ZoneLevelAdvisorWindow", UIParent)
    uiFrame = frame

    frame:SetWidth(FRAME_WIDTH)
    frame:SetHeight(FRAME_HEIGHT)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 },
    })
    frame:Hide()

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", frame, "TOP", 0, -18)
    title:SetText(DISPLAY_NAME)

    summaryLine = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    summaryLine:SetPoint("TOPLEFT", frame, "TOPLEFT", 28, -48)
    summaryLine:SetWidth(CONTENT_WIDTH)
    summaryLine:SetJustifyH("LEFT")

    zoneHeaderLine = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    zoneHeaderLine:SetPoint("TOPLEFT", frame, "TOPLEFT", 28, -78)
    zoneHeaderLine:SetWidth(CONTENT_WIDTH)
    zoneHeaderLine:SetJustifyH("LEFT")

    dungeonHeaderLine = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    dungeonHeaderLine:SetPoint("TOPLEFT", frame, "TOPLEFT", 28, -302)
    dungeonHeaderLine:SetWidth(CONTENT_WIDTH)
    dungeonHeaderLine:SetJustifyH("LEFT")

    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -6, -6)

    local refreshButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    refreshButton:SetWidth(80)
    refreshButton:SetHeight(22)
    refreshButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -24, 20)
    refreshButton:SetText("Refresh")
    refreshButton:SetScript("OnClick", RefreshUI)

    for i = 1, MAX_ZONE_ROWS do
        local row = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -102 - ((i - 1) * ROW_SPACING))
        row:SetWidth(CONTENT_WIDTH)
        row:SetJustifyH("LEFT")
        zoneRowLines[i] = row
    end

    for i = 1, MAX_DUNGEON_ROWS do
        local row = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -326 - ((i - 1) * ROW_SPACING))
        row:SetWidth(CONTENT_WIDTH)
        row:SetJustifyH("LEFT")
        dungeonRowLines[i] = row
    end
end

local function ShowWindow()
    CreateUI()
    RefreshUI()
    uiFrame:Show()
end

local function PrintRecommendationList(label, entries, limit)
    local level = UnitLevel("player")
    local faction = GetPlayerFaction()
    local recommendations = GetRecommendations(entries, level, faction, limit)
    local i

    Print(label .. " for level " .. level .. " " .. faction .. ":")

    for i = 1, #recommendations do
        local entry = recommendations[i]
        Print(FormatRecommendationLine(i, entry, level) .. " (" .. entry.note .. ")")
    end
end

local function PrintRecommendations()
    PrintRecommendationList("Zone recommendations", zones, 5)
    PrintRecommendationList("Dungeon recommendations", dungeons, 5)
end

local function PrintHelp()
    Print("/" .. COMMAND .. " - open the advisor window")
    Print("/" .. COMMAND .. " list - print zone and dungeon recommendations in chat")
    Print("/" .. COMMAND .. " zones - print only zone recommendations")
    Print("/" .. COMMAND .. " dungeons - print only dungeon recommendations")
    Print("/" .. COMMAND .. " hide - close the advisor window")
    Print("/" .. COMMAND .. " help - show this help")
end

local function HandleSlashCommand(message)
    message = string.lower(string.gsub(message or "", "^%s*(.-)%s*$", "%1"))

    if message == "list" then
        PrintRecommendations()
        return
    end

    if message == "zones" then
        PrintRecommendationList("Zone recommendations", zones, 8)
        return
    end

    if message == "dungeons" or message == "instances" then
        PrintRecommendationList("Dungeon recommendations", dungeons, 8)
        return
    end

    if message == "hide" then
        if uiFrame then
            uiFrame:Hide()
        end
        return
    end

    if message == "help" then
        PrintHelp()
        return
    end

    ShowWindow()
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function()
    SLASH_ZONELEVELADVISOR1 = "/" .. COMMAND
    SLASH_ZONELEVELADVISOR2 = "/zoneadvisor"
    SlashCmdList["ZONELEVELADVISOR"] = HandleSlashCommand

    Print("Loaded. Type /" .. COMMAND .. " for zone and dungeon recommendations.")
end)
