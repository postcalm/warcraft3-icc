---@author meiso

AREAS = {
    START_SPAWN = nil,
    LORD_MARROW_SPAWN = nil,
    LADY_DEATH_SPAWN = nil,
    LORD_MARROW_ARENA = nil,

    init = function ()
        AREAS.START_SPAWN = gg_rct_StartSpawn
        AREAS.LORD_MARROW_SPAWN = gg_rct_LordMarrowSpawn
        AREAS.LADY_DEATH_SPAWN = gg_rct_LadyDeathSpawn
        AREAS.LORD_MARROW_ARENA = gg_rct_LordMarrowArena
    end
}
