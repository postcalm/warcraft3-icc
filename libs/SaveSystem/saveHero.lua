-- Copyright (c) 2022 meiso

function SaveSystem.SaveHero()
    SaveSystem.unit = udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())]
    udg_SaveUnit_user_data[1] = 1
    SaveSystem.Save()
end

function SaveSystem.InitSaveEvent()
    local event = EventsPlayer()
    event:RegisterChatEvent("-save")
    event:AddAction(SaveSystem.SaveHero)
end