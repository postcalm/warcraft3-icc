
function LadyDeathwhisper.ShadowBolt()
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
                          GetUnitFacing(GetTriggerUnit()))
        SetUnitMoveSpeed(temp, 500.)
        return temp
    end

    sb = shadow_bolt()
    while true do
        effect = AddSpecialEffectTarget(model_name, sb, "overhead")
        BlzSetSpecialEffectScale(effect, 0.3)
        enemy_loc = GetUnitLoc(enemy)
        enemy_point = Point:new(GetLocationX(enemy_loc), GetLocationY(enemy_loc))
        IssuePointOrderLoc(sb, "move", enemy_loc)
        TriggerSleepAction(0.3)
        sb_loc = GetUnitLoc(sb)
        sb_point = Point:new(GetLocationX(sb_loc), GetLocationY(sb_loc))
        if enemy_point:atPoint(sb_point) then
            local damage = GetRandomReal(9200., 12000.)
            --TODO: разобраться с типами урона
            UnitDamageTarget(LADY_DEATHWHISPER, enemy, damage, true, false,
                             ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            DestroyEffect(effect)
            RemoveUnit(sb)
            break
        end
        DestroyEffect(effect)
    end
    RemoveUnit(sb)
end

function LadyDeathwhisper.InitShadowBolt()
    local event = EventsUnit(LadyDeathwhisper.unit)
    event:RegisterAttacked()
    event:AddAction(LadyDeathwhisper.ShadowBolt)
end

