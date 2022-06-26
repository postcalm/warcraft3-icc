
--- Возрождает юнита
---@return nil
function SaveSystem.UnitsRespawn()
    local unit = Unit(GetTriggerUnit())
    if unit:IsHero() then
        TriggerSleepAction(5)
        unit:Revive()
    end
end

--- Определяет способности выбранного класса
---@return nil
function SaveSystem.DefineAbilities()
    if SaveSystem.classid == CLASSES["paladin"] then
        SaveSystem.DefineAbilitiesPaladin()
    elseif SaveSystem.classid == CLASSES["priest"] then
        SaveSystem.DefineAbilitiesPriest()
    end
end

--- Определяет способности паладина
---@return nil
function SaveSystem.DefineAbilitiesPaladin()
    SaveSystem.abilities = {
        DIVINE_SHIELD,
        CONSECRATION,
        CONSECRATION_TR,
        HAMMER_RIGHTEOUS,
        JUDGEMENT_OF_LIGHT_TR,
        JUDGEMENT_OF_WISDOM_TR,
        SHIELD_OF_RIGHTEOUSNESS,
        AVENGERS_SHIELD,
        SPELLBOOK_PALADIN,
    }
    SaveSystem.spellbook = SPELLBOOK_PALADIN
end

--- Определяет способности приста
---@return nil
function SaveSystem.DefineAbilitiesPriest()
    SaveSystem.abilities = {
        FLASH_HEAL,
        RENEW,
        CIRCLE_OF_HEALING,
    }
    SaveSystem.spellbook = nil
end

--- Выдает герою способности
---@return nil
function SaveSystem.AddHeroAbilities(class)
    SaveSystem.classid = CLASSES[class]
    SaveSystem.DefineAbilities()
    local hero = Unit(udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())])
    hero:AddAbilities(table.unpack(SaveSystem.abilities))
    hero:AddSpellbook(SaveSystem.spellbook)
    hero:SetLevel(80)
end
