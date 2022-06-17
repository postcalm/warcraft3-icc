
--- Возрождает юнита
function SaveSystem.UnitsRespawn()
    local u = GetTriggerUnit()
    if IsUnitType(u, UNIT_TYPE_HERO) == true then
        TriggerSleepAction(5)
        ReviveHero(u, udg_SaveUnit_x, udg_SaveUnit_y, false)
    end
end

--- Определяет способности выбранного класса
---@param class classid
function SaveSystem.DefineAbilities(class)
    if class == CLASSES["paladin"] then
        SaveSystem.DefineAbilitiesPaladin()
    elseif class == CLASSES["priest"] then
        SaveSystem.DefineAbilitiesPriest()
    end
end

--- Определяет способности паладина
function SaveSystem.DefineAbilitiesPaladin()
    SaveSystem.abilities = {DEVOTION_AURA,
                            DIVINE_SHIELD,
                            CONSECRATION,
                            CONSECRATION_TR,
                            HAMMER_RIGHTEOUS,
                            JUDGEMENT_OF_LIGHT_TR,
                            JUDGEMENT_OF_WISDOM_TR,
                            SHIELD_OF_RIGHTEOUSNESS,
                            SPELLBOOK_PALADIN
    }
    SaveSystem.spellbook = SPELLBOOK_PALADIN
end

--- Определяет способности приста
function SaveSystem.DefineAbilitiesPriest()
    SaveSystem.abilities = {FLASH_HEAL,
                            RENEW,
                            CIRCLE_OF_HEALING,
    }
    SaveSystem.spellbook = nil
end

--- Выдает герою способности
function SaveSystem.AddHeroAbilities(class)
    SaveSystem.classid = CLASSES[class]
    SaveSystem.DefineAbilities(SaveSystem.classid)
    local hero = Unit(udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())])
    hero:AddAbilities(table.unpack(SaveSystem.abilities))
    hero:AddSpellbook(SaveSystem.spellbook)
    hero:SetLevel(80)
end
