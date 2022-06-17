
--- Сохранаяет информацию о характеристиках, способностях и предметах
---@param i integer Текущий итератор
---@param u unitid Сохраняемый юнит
---@return integer Следующий итератор
function SaveSystem.SaveUnitData(i, u)
    local ability_count = 0
    local item_count = 0
    local max_slots = 5

    if IsUnitType(u, UNIT_TYPE_HERO) == true then
        -- сохраняем инфу: опыт, сила, ловкость, интеллект
        udg_SaveUnit_data[i] = SaveSystem.scope.state
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroXP(u)
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroStr(u, false)
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroAgi(u, false)
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroInt(u, false)
        i = i + 1
        udg_SaveUnit_data[i] = SaveSystem.scope.abilities
        i = i + 1
        local ability_index = i
        i = i + 1

        -- сохраняем способности
        for k = 1, #SaveSystem.abilities do
            local ability_level = GetUnitAbilityLevel(u, SaveSystem.abilities[k])
            if ability_level > 0 then
                ability_count = ability_count + 1
                udg_SaveUnit_data[i] = SaveSystem.abilities[k]
                i = i + 1
                udg_SaveUnit_data[i] = ability_level
                i = i + 1
            end
        end
        udg_SaveUnit_data[ability_index] = ability_count
        udg_SaveUnit_data[i] = SaveSystem.scope.items
        i = i + 1
        local item_index = i
        i = i + 1
        -- сохраняем предметы
        for item_iter = 1, max_slots do
            local item_id = UnitItemInSlot(u, item_iter)
            if item_id ~= nil then
                item_count = item_count + 1
                udg_SaveUnit_data[i] = GetItemTypeId(item_id)
                i = i + 1
                udg_SaveUnit_data[i] = GetItemCharges(item_id)
                i = i + 1
            end
        end
        udg_SaveUnit_data[item_index] = item_count
    end
    return i
end

--- Сохранаяет информацию о местоположении игрока, хп, мп, кол-во вкаченных навыков
---@param i integer Текущий итератор
---@param u unitid Сохраняемый юнит
---@param world rect Текущий игровой мир
---@return integer Следующий итератор
function SaveSystem.SaveBaseState(i, u, world)

    if u ~= nil then
        local rect_min_x = R2I(GetRectMinX(world))
        local rect_max_x = R2I(GetRectMaxX(world))
        local rect_min_y = R2I(GetRectMinY(world))
        local rect_max_y = R2I(GetRectMaxY(world))
        local map_number = udg_SaveUnit_map_number
        local unit_type_id = GetUnitTypeId(u)

        local hero_position_x = R2I((GetUnitX(u) - rect_min_x) * (I2R(SaveSystem.magic_number.one) / (rect_max_x - rect_min_x)))
        local hero_position_y = R2I((GetUnitY(u) - rect_min_y) * (I2R(SaveSystem.magic_number.one) / (rect_max_y - rect_min_y)))
        local hero_facing = R2I(GetUnitFacing(u) * (SaveSystem.magic_number.one / 360.))

        local health = R2I(GetUnitState(u, UNIT_STATE_LIFE) * (SaveSystem.magic_number.one / GetUnitState(u, UNIT_STATE_MAX_LIFE)))
        local mana = R2I(GetUnitState(u, UNIT_STATE_MANA) * (SaveSystem.magic_number.one / GetUnitState(u, UNIT_STATE_MAX_MANA)))
        local count_gold = GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_GOLD)
        local count_lumber = GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
        udg_SaveUnit_data[i] = SaveSystem.scope.map
        i = i + 1
        udg_SaveUnit_data[i] = map_number
        i = i + 1
        udg_SaveUnit_data[i] = SaveSystem.scope.hero_data
        i = i + 1
        udg_SaveUnit_data[i] = unit_type_id
        i = i + 1
        udg_SaveUnit_data[i] = hero_position_x
        i = i + 1
        udg_SaveUnit_data[i] = hero_position_y
        i = i + 1
        udg_SaveUnit_data[i] = hero_facing
        i = i + 1
        udg_SaveUnit_data[i] = health
        i = i + 1
        udg_SaveUnit_data[i] = mana
        i = i + 1
        --udg_SaveUnit_data[i] = SaveSystem.classid
        --i = i + 1
        udg_SaveUnit_data[i] = SaveSystem.scope.resources
        i = i + 1
        udg_SaveUnit_data[i] = count_gold
        i = i + 1
        udg_SaveUnit_data[i] = count_lumber
        i = i + 1
        udg_SaveUnit_data[i] = SaveSystem.scope.hero_skill
        i = i + 1
    end
    return i
end

---
function SaveSystem.LoadUnitData()
    if SaveSystem.unit ~= nil then
        local current_unit = SaveSystem.unit
        local unit_loc_x = GetUnitX(current_unit)
        local unit_loc_y = GetUnitY(current_unit)
        local current_case = -1
        local i = 2
        local maximum_data = udg_SaveUnit_data[1]
        while i < maximum_data do
            current_case = udg_SaveUnit_data[i]
            -- выдаем предметы
            if current_case == SaveSystem.scope.items then
                local max_count_data = udg_SaveUnit_data[i + 1]
                local j = i + 2
                while max_count_data >= 0 do
                    local current_item = CreateItem(udg_SaveUnit_data[j], unit_loc_x, unit_loc_y)
                    UnitAddItem(current_unit, current_item)
                    SetItemCharges(current_item, udg_SaveUnit_data[j + 1])
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end

            -- проставляем статы
            if current_case == SaveSystem.scope.state then
                SetHeroXP(current_unit, udg_SaveUnit_data[i + 1], false)
                if GetHeroStr(current_unit, false) < udg_SaveUnit_data[i + 2] then
                    SetHeroStr(current_unit, udg_SaveUnit_data[i + 2], false)
                end
                if GetHeroAgi(current_unit, false) < udg_SaveUnit_data[i + 3] then
                    SetHeroAgi(current_unit, udg_SaveUnit_data[i + 3], false)
                end
                if GetHeroInt(current_unit, false) < udg_SaveUnit_data[i + 4] then
                    SetHeroInt(current_unit, udg_SaveUnit_data[i + 4], false)
                end
            end

            -- выдаем юниту его навыки
            if current_case == SaveSystem.scope.hero_skill then
                local max_count_data = udg_SaveUnit_data[i + 1]
                local j = i + 2
                while max_count_data >= 0 do
                    local count_level = udg_SaveUnit_data[j + 1]
                    while count_level >= 0 do
                        SelectHeroSkill(current_unit, udg_SaveUnit_data[j])
                        count_level = count_level - 1
                    end
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end

            -- выдаем способности
            if current_case == SaveSystem.scope.abilities then
                -- сколько всего способностей было сохранено
                local max_count_data = udg_SaveUnit_data[i + 1]
                -- индекс, по которому лежит способность
                local j = i + 2
                while max_count_data >= 0 do
                    UnitAddAbility(current_unit, udg_SaveUnit_data[j])
                    SetUnitAbilityLevel(current_unit, udg_SaveUnit_data[j], udg_SaveUnit_data[j + 1])
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end
            i = SaveSystem.next_scope(i, current_case)
        end
    end
end

--- Загрузка общих данных об игроке и его юните
---@param pl playerid Локальный игрок
function SaveSystem.LoadBaseState(pl)
    local unit_x
    local unit_y
    local unit_face
    local count_gold
    local count_lumber
    local unit_id
    local health
    local mana
    if udg_SaveUnit_data[1] > 0 then
        -- размеры карты
        local rect_min_x = R2I(GetRectMinX(GetWorldBounds()))
        local rect_max_x = R2I(GetRectMaxX(GetWorldBounds()))
        local rect_min_y = R2I(GetRectMinY(GetWorldBounds()))
        local rect_max_y = R2I(GetRectMaxY(GetWorldBounds()))
        -- номер карты
        local map_number = -1
        local i = 2
        local case = -1
        -- макс. кол-во записанных данных
        local n = udg_SaveUnit_data[1]

        while i < n do
            case = udg_SaveUnit_data[i]
            if case == SaveSystem.scope.map then
                map_number = udg_SaveUnit_data[i + 1]
            end

            if case == SaveSystem.scope.resources then
                count_gold = udg_SaveUnit_data[i + 1]
                count_lumber = udg_SaveUnit_data[i + 2]
            end

            if case == SaveSystem.scope.hero_data then
                unit_id = udg_SaveUnit_data[i + 1]
                -- местоположение игрока в месте, где он сохранялся
                unit_x = rect_min_x + (rect_max_x - rect_min_x) * (I2R(udg_SaveUnit_data[i + 2]) / SaveSystem.magic_number.one)
                unit_y = rect_min_y + (rect_max_y - rect_min_y) * (I2R(udg_SaveUnit_data[i + 3]) / SaveSystem.magic_number.one)
                unit_face = 360. * (I2R(udg_SaveUnit_data[i + 4]) / SaveSystem.magic_number.one)
                health = udg_SaveUnit_data[i + 5]
                mana = udg_SaveUnit_data[i + 6]
                --SaveSystem.classid = udg_SaveUnit_data[i + 7]
            end
            i = SaveSystem.next_scope(i, case)
        end

        if map_number ~= udg_SaveUnit_map_number then
            unit_x = udg_SaveUnit_x
            unit_y = udg_SaveUnit_y
        end

        --SaveSystem.AddHeroAbilities(SaveSystem.classid)
        local unit_obj = CreateUnit(pl, unit_id, unit_x, unit_y, unit_face)
        SaveSystem.unit = unit_obj

        if unit_obj ~= nil then
            SetUnitState(unit_obj, UNIT_STATE_LIFE, GetUnitState(unit_obj, UNIT_STATE_MAX_LIFE) * (I2R(health) / SaveSystem.magic_number.one))
            SetUnitState(unit_obj, UNIT_STATE_MANA, GetUnitState(unit_obj, UNIT_STATE_MAX_MANA) * (I2R(mana) / SaveSystem.magic_number.one))
            SetPlayerState(pl, PLAYER_STATE_RESOURCE_GOLD, count_gold)
            SetPlayerState(pl, PLAYER_STATE_RESOURCE_LUMBER, count_lumber)
        end
    end
end
