
function AtPoint(target_point, unit_point)
    local inaccuracy = 50.
    if math.abs(target_point.X - unit_point.X) <= inaccuracy and
            math.abs(target_point.Y - unit_point.Y) <= inaccuracy then
        return true
    end
    return false
end

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
    local dd_unit = Unit:new(GetTriggerPlayer(), DYNAMIC_DUMMY, pal_loc)
    SetUnitMoveSpeed(dd_unit, 500.)

    local exclude_targets = {}

    function AddTarget()
        table.insert(exclude_targets, target)
    end

    function TargetTookDamage()
        for i = 1, #exclude_targets do
            if target == exclude_targets[i] then return true
            else return false end
        end
    end

    function GetTarget()
        while true do
            target = GetUnitInArea(GroupUnitsInRangeOfLocUnit(200, GetUnitLoc(target)))
            if not TargetTookDamage() then
                return target
            end
        end
    end

    local i = 0
    while i ~= 3 do
        --находим положения цели
        target_loc = GetUnitLoc(target)
        target_point = Point:new(GetLocationX(target_loc), GetLocationY(target_loc))
        --направляем юнита к месту цели
        IssuePointOrderLoc(dd_unit, "move", target_loc)
        TriggerSleepAction(0.)
        dd_loc = GetUnitLoc(dd_unit)
        dd_point = Point:new(GetLocationX(dd_loc), GetLocationY(dd_loc))
        if AtPoint(target_point, dd_point) or GetDyingUnit() == target then
            damage = GetRandomInt(11000, 13440) + (factor * light_magic_damage) + (factor * attack_power)
            AddTarget()
            UnitDamageTargetBJ(PALADIN, target, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_DIVINE)
            target = GetTarget()
            i = i + 1
        end
    end
    KillUnit(dd_unit)
end

function IsAvengersShield()
    return GetSpellAbilityId() == AVENGERS_SHIELD
end

function Init_AvengersShield()
    local trigger_ability = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_ability, Condition(IsAvengersShield))
    TriggerAddAction(trigger_ability, AvengersShield)
end
