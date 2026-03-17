---@author meiso

function LowerTierTrashSpawn()
    ---@type Unit
    local trash
    local owner = PLAYERS[1]
    local damned_points = {
        { 660, -8160, -90 },
        { 1060, -8160, -90 },
        { 1420, -6160, 180 },
        { -2170, -6260 },
        { -1760, -6180 },
        { -1690, -6420 },
        { 3750, -6220 },
        { 3900, -6240 },
        { 3850, -6480 },
        { -1870, -2180 },
        { -1950, -2000 },
        { -1850, -1810 },
        { -1580, -1810 },
        { 2500, -2450 },
        { 3080, -1810 },
        { 3400, -1780 },
        { 3640, -2030 },
    }
    local servants_points = {
        { -1000, -5570, 0 },
        { 860, -3350, -90 },
        { 850, -1940, -90 },
        { 150, -1230, -90 },
        { 1520, -1260, -90 },
        { -200, 2300, -90 },
        { 1870, 2280, -90 },
    }
    local broodkeeper_points = {
        { 360, -3640, -90 },
        { 1340, -3660, -90 },
        { 2870, -3420, 180 },
        { -1060, -3340, 0 },
        { 470, -1500, -90 },
        { 1190, -1500, -90 },
        { 350, 1880, -90 },
        { 1310, 1880, -90 },
    }
    local skeletal_points = {
        { 680, 1440, -90 },
        { 1120, 1440, -90 },
        { 50, -3870, -90 },
        { 1670, -3870, -90 },
    }
    -- TODO: добавить точки ловушек
    local ward_points = {
        { -3260, -4510, 0 },
        { 4930, -4510, 180 },
        { -900, 1280, 0 },
        { 2560, 1280, 180 },
    }
    for _, i in pairs(damned_points) do
        trash = Unit(owner, THE_DAMNED, Location(i[1], i[2]), i[3])
        trash:AutoRegen()
    end
    for _, i in pairs(servants_points) do
        trash = Unit(owner, SERVANT_OF_THE_THRONE, Location(i[1], i[2]), i[3])
        trash:AutoRegen()
    end
    for _, i in pairs(broodkeeper_points) do
        trash = Unit(owner, NERUBAR_BROODKEEPER, Location(i[1], i[2]), i[3])
        trash:AutoRegen()
    end
    for _, i in pairs(skeletal_points) do
        trash = Unit(owner, ANCIENT_SKELETAL_SOLDIER, Location(i[1], i[2]), i[3])
        trash:AutoRegen()
    end
    for _, i in pairs(ward_points) do
        trash = Unit(owner, DEATHBOUND_WARD, Location(i[1], i[2]), i[3])
        trash:AutoRegen()
    end
end
