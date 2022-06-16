
--- Возрождает юнита
function SaveSystem.UnitsRespawn()
    local u = GetTriggerUnit()
    if IsUnitType(u, UNIT_TYPE_HERO) == true then
        TriggerSleepAction(5)
        ReviveHero(u, udg_SaveUnit_x, udg_SaveUnit_y, false)
    end
end

function SaveSystem.InitHeroAbilities(class)
    if class == CLASSES["paladin"] then
        SaveSystem.InitHeroAbilitiesPaladin()
    elseif class == CLASSES["priest"] then
        SaveSystem.InitHeroAbilitiesPriest()
    end
end

--- Инициализирует способности паладина
function SaveSystem.InitHeroAbilitiesPaladin()
    udg_SaveUnit_hero_ability[1] = DEVOTION_AURA
    udg_SaveUnit_hero_ability[2] = DIVINE_SHIELD
    udg_SaveUnit_hero_ability[3] = CONSECRATION
    udg_SaveUnit_hero_ability[4] = CONSECRATION_TR
    udg_SaveUnit_hero_ability[5] = HAMMER_RIGHTEOUS
    udg_SaveUnit_hero_ability[6] = JUDGEMENT_OF_LIGHT_TR
    udg_SaveUnit_hero_ability[7] = JUDGEMENT_OF_WISDOM_TR
    udg_SaveUnit_hero_ability[8] = SHIELD_OF_RIGHTEOUSNESS
    udg_SaveUnit_hero_ability[9] = SPELLBOOK_PALADIN
end

--- Инициализирует способности приста
function SaveSystem.InitHeroAbilitiesPriest()
    udg_SaveUnit_hero_ability[1] = FLASH_HEAL
    udg_SaveUnit_hero_ability[2] = RENEW
    udg_SaveUnit_hero_ability[3] = CIRCLE_OF_HEALING
end

--- Выдает герою способности
function SaveSystem.AddHeroAbilities(class)
    udg_SaveUnit_class = CLASSES[class]
    SaveSystem.InitHeroAbilities(udg_SaveUnit_class)
    local hero = Unit(udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())])
    hero:AddAbilities(table.unpack(udg_SaveUnit_hero_ability))
    hero:AddSpellbook(udg_SaveUnit_spellbook)
    hero:SetLevel(80)
end
