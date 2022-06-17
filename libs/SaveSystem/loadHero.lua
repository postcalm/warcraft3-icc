-- Copyright (c) 2022 meiso

function SaveSystem.LoadHero()
    local i = GetConvertedPlayerId(GetTriggerPlayer())
    SaveSystem.Load()
    udg_My_index = i
    udg_My_hero[udg_My_index] = SaveSystem.unit
end

function SaveSystem.InitLoadEvent()
    local event = EventsPlayer()
    event:RegisterChatEvent("-load")
    event:AddCondition(SaveSystem.IsHeroNotCreated)
    event:AddAction(SaveSystem.LoadHero)
end
