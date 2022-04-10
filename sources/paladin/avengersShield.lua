
function AvengersShield()
    local target = GetSpellTargetUnit()
    local light_magic_damage = 1
    local factor = 0.07
    --т.к. силы атаки так таковой нет, считается она, как сила героя помноженная на 2
    local attack_power = GetHeroStr(GetTriggerUnit(), true) * 2

    local pal_loc = GetUnitLoc(GetTriggerUnit())
    local target_loc
    local target_point

    local damage = 0
    local dd_loc
    local dd_point
    local dd_unit
    local modelName = "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl"
    --local arrow = "Abilities\\Spells\\Other\\Aneu\\AneuCaster.mdl"
    local model

    local exclude_targets = {}

    local function AtPoint(target_point_, unit_point_)
        local inaccuracy = 50.
        if math.abs(target_point_.X - unit_point_.X) <= inaccuracy and
                math.abs(target_point_.Y - unit_point_.Y) <= inaccuracy then
            return true
        end
        return false
    end

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
                    not IsUnitAlly(temp, GetOwningPlayer(PALADIN)) then
                return temp
            end
            GroupRemoveUnit(group, temp)
        end
        DestroyGroup(group)
        return 0
    end

    local function shield(location)
        local temp = Unit:new(GetTriggerPlayer(), DYNAMIC_DUMMY, location)
        SetUnitMoveSpeed(temp, 500.)
        return temp
    end

    local i = 0
    dd_unit = shield(pal_loc)
    while i < 3 do
        model = AddSpecialEffectLoc(modelName, GetUnitLoc(dd_unit))
        BlzSetSpecialEffectScale(model, 0.3)
        --находим положения цели
        target_loc = GetUnitLoc(target)
        target_point = Point:new(GetLocationX(target_loc), GetLocationY(target_loc))
        --направляем юнита к месту цели
        IssuePointOrderLoc(dd_unit, "move", target_loc)
        TriggerSleepAction(0.3)
        dd_loc = GetUnitLoc(dd_unit)
        dd_point = Point:new(GetLocationX(dd_loc), GetLocationY(dd_loc))
        if GetDyingUnit() == target then
            target = GetTarget(target, exclude_targets)
            KillUnit(dd_unit)
            dd_unit = shield(target_loc)
            if target == 0 then break end
            i = i + 1
        end
        if AtPoint(target_point, dd_point) then
            damage = GetRandomInt(1100, 1344) + (factor * light_magic_damage) + (factor * attack_power)
            --AddSpecialEffectTarget(arrow, target, "overhead")
            UnitDamageTargetBJ(PALADIN, target, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_DIVINE)
            AddTarget(target, exclude_targets)
            target = GetTarget(target, exclude_targets)
            RemoveUnit(dd_unit)
            dd_unit = shield(target_loc)
            if target == 0 then break end
            i = i + 1
        end
        DestroyEffect(model)
    end
    RemoveUnit(dd_unit)
    DestroyEffect(model)
end

function IsAvengersShield()
    return GetSpellAbilityId() == AVENGERS_SHIELD
end

function Init_AvengersShield()
    local event = EventsPlayer(Player(0))
    event:RegisterUnitSpellCast()
    event:AddCondition(IsAvengersShield)
    event:AddAction(AvengersShield)
end
