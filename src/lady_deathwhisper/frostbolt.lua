-- Copyright (c) meiso

function LadyDeathwhisper.FrostBolt()
    --TriggerSleepAction(10.)
    local enemy = Unit(GetUnitInArea(GroupHeroesInArea(gg_rct_areaLD, GetOwningPlayer(GetAttacker()))))
    local enemy_movespeed = enemy:GetMoveSpeed()

    local model_name = "Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl"

    local fb = UnitSpell(LadyDeathwhisper.unit:GetId())
    local effect = Effect(fb, model_name)
    while true do
        TriggerSleepAction(0.)
        fb:MoveToUnit(enemy)
        if fb:NearTarget(enemy) then
            local damage = GetRandomInt(100., 120.)
            LadyDeathwhisper.unit:DealMagicDamage(enemy, damage)
            enemy:SetMoveSpeed(enemy_movespeed / 2)
            break
        end
    end
    effect:Destroy()
    fb:Remove()
end

function LadyDeathwhisper.FBCheckPhase()
    if LadyDeathwhisper.phase == 2 then
        return true
    end
    return false
end

function LadyDeathwhisper.InitFrostBolt()
    local event = EventsUnit(LadyDeathwhisper.unit)
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.FBCheckPhase)
    event:AddAction(LadyDeathwhisper.FrostBolt)
end

