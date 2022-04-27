
DEATH_AND_DECAY_EXIST = false

function DeathAndDecay()
    local model = "Abilities\\Spells\\Items\\VampiricPotion\\VampPotionCaster.mdl"
    local effect
    if DEATH_AND_DECAY_EXIST then
        local loc = GetUnitLoc(GetAttacker())
        effect = AddSpecialEffectLoc(model, loc)
        print(IssuePointOrderLoc(LADY_DEATHWHISPER, "acidbomb", loc))
        UnitDamagePointLoc(LADY_DEATHWHISPER, 0, 300, loc, 450., ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)

        TriggerSleepAction(12.)
        DEATH_AND_DECAY_EXIST = false
        DestroyEffect(effect)
    end
end

function DeathAndDecayExist()
    if not DEATH_AND_DECAY_EXIST then
        DEATH_AND_DECAY_EXIST = true
        return true
    end
    return false
end

function Init_DeathAndDecay()
    local event = EventsUnit(LADY_DEATHWHISPER)
    event:RegisterAttacked()
    event:AddCondition(DeathAndDecayExist)
    event:AddAction(DeathAndDecay)
end
