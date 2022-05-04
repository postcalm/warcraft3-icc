
function LadyDeathwhisper.ShadowBolt()
    TriggerSleepAction(10.)
    local enemy = GetUnitInArea(GroupHeroesInArea(gg_rct_areaLD, GetOwningPlayer(GetAttacker())))
    local enemy_loc
    local enemy_point
    local sb
    local sb_loc
    local sb_point

    local model_name = "Abilities\\Spells\\Other\\BlackArrow\\BlackArrowMissile.mdl"
    local effect

    local function shadow_bolt()
        local temp = Unit(GetTriggerPlayer(),
                          SPELL_DUMMY,
                          GetUnitLoc(GetTriggerUnit()),
                          GetUnitFacing(GetTriggerUnit())):GetUnit()
        SetUnitMoveSpeed(temp, 500.)
        return temp
    end

    sb = shadow_bolt()
    while true do
        effect = AddSpecialEffectTarget(model_name, sb, "overhead")
        BlzSetSpecialEffectScale(effect, 0.5)
        enemy_loc = GetUnitLoc(enemy)
        enemy_point = Point:new(GetLocationX(enemy_loc), GetLocationY(enemy_loc))
        IssuePointOrderLoc(sb, "move", enemy_loc)
        TriggerSleepAction(0.)
        sb_loc = GetUnitLoc(sb)
        sb_point = Point:new(GetLocationX(sb_loc), GetLocationY(sb_loc))
        if enemy_point:atPoint(sb_point) then
            local damage = GetRandomReal(9200., 12000.)
            LadyDeathwhisper.unit:DealMagicDamage(enemy, damage)
            DestroyEffect(effect)
            RemoveUnit(sb)
            break
        end
        DestroyEffect(effect)
    end
    RemoveUnit(sb)
end

function LadyDeathwhisper.SBCheckPhase()
    if LadyDeathwhisper.phase == 1 then
        return true
    end
    return false
end

function LadyDeathwhisper.InitShadowBolt()
    local event = EventsUnit(LadyDeathwhisper.unit:GetUnit())
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.SBCheckPhase)
    event:AddAction(LadyDeathwhisper.ShadowBolt)
end

