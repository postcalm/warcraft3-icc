-- Copyright (c) meiso

function Paladin.AvengersShield()
    local target = Unit(GetSpellTargetUnit())
    local light_magic_damage = 1
    local factor = 0.07
    --т.к. силы атаки так таковой нет, то считается она, как сила героя помноженная на 2
    local attack_power = GetHeroStr(GetTriggerUnit(), true) * AP

    local damage = 0
    local model_name = "Aegis.mdl"

    local exclude_targets = {}

    local function AddTarget(target_, exc)
        table.insert(exc, target_:GetId())
    end

    local function TargetTookDamage(target_, exc)
        for i = 1, #exc do
            if target_ == exc[i] then
                return true
            end
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
    local shield = UnitSpell(Paladin.hero:GetId())
    local effect = Effect(shield, model_name, "overhead")
    while i < 3 do
        TriggerSleepAction(0.)
        shield:MoveToUnit(target)
        if target:IsDied() then
            target = GetTarget(target, exclude_targets)
            if target == 0 then
                break
            end
            i = i + 1
        end
        if shield:NearTarget(target) then
            damage = R2I(GetRandomInt(1100, 1344) + (factor * light_magic_damage) + (factor * attack_power))
            Paladin.hero:DealPhysicalDamage(target, damage)
            TextTag(damage, target):Preset("spell")
            AddTarget(target, exclude_targets)
            target = GetTarget(target, exclude_targets)
            if target == 0 then
                break
            end
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
    Ability(AVENGERS_SHIELD, avengers_shield_tooltip, avengers_shield_desc)
    Paladin.hero:SetAbilityManacost(AVENGERS_SHIELD, 26)
    Paladin.hero:SetAbilityCooldown(AVENGERS_SHIELD, 30.)
    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsAvengersShield)
    event:AddAction(Paladin.AvengersShield)
end
