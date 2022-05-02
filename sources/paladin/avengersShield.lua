
function Paladin.AvengersShield()
    local target = GetSpellTargetUnit()
    local light_magic_damage = 1
    local factor = 0.07
    --т.к. силы атаки так таковой нет, считается она, как сила героя помноженная на 2
    local attack_power = GetHeroStr(GetTriggerUnit(), true) * 2

    local pal_loc = GetUnitLoc(GetTriggerUnit())
    local target_loc
    local target_point

    local damage = 0
    local shield_loc
    local shield_point
    local shield_unit
    local model_name = "Aegis.mdl"
    --local arrow = "Abilities\\Spells\\Other\\Aneu\\AneuCaster.mdl"
    local effect

    local exclude_targets = {}

    local function AddTarget(target_, exc)
        table.insert(exc, target_)
    end

    local function TargetTookDamage(target_, exc)
        for i = 1, #exc do
            if target_ == exc[i] then return true end
        end
        return false
    end

    local function GetTarget(target_, exc)
        local temp
        local group = GroupUnitsInRangeOfLocUnit(200, GetUnitLoc(target_))
        for _ = 1, CountUnitsInGroup(group) do
            TriggerSleepAction(0.)
            temp = GroupPickRandomUnit(group)
            if not TargetTookDamage(temp, exc) and
                    not IsUnitAlly(temp, GetOwningPlayer(GetTriggerUnit())) then
                return temp
            end
            GroupRemoveUnit(group, temp)
        end
        DestroyGroup(group)
        return 0
    end

    local function shield(location)
        local temp = Unit(GetTriggerPlayer(), SPELL_DUMMY, location, GetUnitFacing(GetTriggerUnit()))
        SetUnitMoveSpeed(temp:GetUnit(), 522.)
        return temp:GetUnit()
    end

    local i = 0
    shield_unit = shield(pal_loc)
    while i < 3 do
        effect = AddSpecialEffectTarget(model_name, shield_unit, "overhead")
        BlzSetSpecialEffectScale(effect, 0.7)
        --находим положения цели
        target_loc = GetUnitLoc(target)
        target_point = Point:new(GetLocationX(target_loc), GetLocationY(target_loc))
        --направляем юнита к месту цели
        IssuePointOrderLoc(shield_unit, "move", target_loc)
        TriggerSleepAction(0.)
        shield_loc = GetUnitLoc(shield_unit)
        shield_point = Point:new(GetLocationX(shield_loc), GetLocationY(shield_loc))
        if GetDyingUnit() == target then
            target = GetTarget(target, exclude_targets)
            KillUnit(shield_unit)
            shield_unit = shield(target_loc)
            if target == 0 then break end
            i = i + 1
        end
        if target_point:atPoint(shield_point) then
            damage = GetRandomInt(1100, 1344) + (factor * light_magic_damage) + (factor * attack_power)
            --AddSpecialEffectTarget(arrow, target, "overhead")
            --UnitDamageTargetBJ(Paladin.hero, target, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_DIVINE)
            Paladin.hero:PhysicalDamage(target, damage)
            AddTarget(target, exclude_targets)
            target = GetTarget(target, exclude_targets)
            RemoveUnit(shield_unit)
            shield_unit = shield(target_loc)
            if target == 0 then break end
            i = i + 1
        end
        DestroyEffect(effect)
    end
    RemoveUnit(shield_unit)
    DestroyEffect(effect)
end

function Paladin.IsAvengersShield()
    return GetSpellAbilityId() == AVENGERS_SHIELD
end

function Paladin.InitAvengersShield()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsAvengersShield)
    event:AddAction(Paladin.AvengersShield)
end
