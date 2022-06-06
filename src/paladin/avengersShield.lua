
function Paladin.AvengersShield()
    local target = Unit(GetSpellTargetUnit())
    local light_magic_damage = 1
    local factor = 0.07
    --т.к. силы атаки так таковой нет, то считается она, как сила героя помноженная на 2
    local attack_power = GetHeroStr(GetTriggerUnit(), true) * 2

    local damage = 0
    local model_name = "Aegis.mdl"

    local exclude_targets = {}

    if not Paladin.hero:LoseMana{percent=26} then return end

    local function AddTarget(target_, exc)
        table.insert(exc, target_:GetUnit())
    end

    local function TargetTookDamage(target_, exc)
        for i = 1, #exc do
            if target_ == exc[i] then return true end
        end
        return false
    end

    local function GetTarget(target_, exc)
        local temp
        local group = GroupUnitsInRangeOfLocUnit(200, target_:GetLoc())
        for _ = 1, CountUnitsInGroup(group) do
            TriggerSleepAction(0.)
            temp = GroupPickRandomUnit(group)
            if not TargetTookDamage(temp, exc) and
                    not IsUnitAlly(temp, GetOwningPlayer(GetTriggerUnit())) then
                return Unit(temp)
            end
            GroupRemoveUnit(group, temp)
        end
        DestroyGroup(group)
        return 0
    end

    local i = 0
    local shield = UnitSpell(Paladin.hero:GetUnit())
    local effect = Effect(shield, model_name, 0.7)
    while i < 3 do
        TriggerSleepAction(0.)
        shield:MoveToUnit(target)
        if target:IsDied() then
            target = GetTarget(target, exclude_targets)
            if target == 0 then break end
            i = i + 1
        end
        if shield:NearTarget(target) then
            damage = GetRandomInt(1100, 1344) + (factor * light_magic_damage) + (factor * attack_power)
            Paladin.hero:DealPhysicalDamage(target, damage)
            AddTarget(target, exclude_targets)
            target = GetTarget(target, exclude_targets)
            if target == 0 then break end
            i = i + 1
        end
    end
    effect:Destroy()
    shield:Remove()
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