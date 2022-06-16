-- Copyright (c) 2022 meiso

function SaveSystem.AddNewHero()
    local text = GetEventPlayerChatString()
    local unit
    if text:find("paladin") then
        unit = Unit(GetTriggerPlayer(), PALADIN, GetRectCenter(gg_rct_RespawZone), GetRandomDirectionDeg())
        udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())] = unit:GetId()
        udg_SaveUnit_spellbook = SPELLBOOK_PALADIN
        SaveSystem.AddHeroAbilities("paladin")
    elseif text:find("priest") then
        unit = Unit(GetTriggerPlayer(), PRIEST, GetRectCenter(gg_rct_RespawZone), GetRandomDirectionDeg())
        udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())] = unit:GetId()
        SaveSystem.AddHeroAbilities("priest")
    end
end

function SaveSystem.InitNewHeroEvent()
    local event = EventsPlayer()
    event:RegisterChatEvent("-new")
    event:AddCondition(SaveSystem.IsHeroNotCreated)
    event:AddAction(SaveSystem.AddNewHero)
end
