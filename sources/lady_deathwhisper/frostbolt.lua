
function LadyDeathwhisper.FrostBolt()
    TriggerSleepAction(10.)
    local enemy = GetUnitInArea(GroupHeroesInArea(gg_rct_areaLD, GetOwningPlayer(GetAttacker())))
    local enemy_loc
    local enemy_point
    local enemy_movespeed = GetUnitMoveSpeed(enemy)
    local fb
    local fb_loc
    local fb_point

    local model_name = "Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl"
    local effect

    local function frost_bolt()
        local temp = Unit(GetTriggerPlayer(),
                          SPELL_DUMMY,
                          GetUnitLoc(GetTriggerUnit()),
                          GetUnitFacing(GetTriggerUnit())):GetUnit()
        SetUnitMoveSpeed(temp, 500.)
        return temp
    end
    
    local function recover_movespeed()
        SetUnitMoveSpeed(enemy, enemy_movespeed)
        DestroyTimer(GetExpiredTimer())
    end

    fb = frost_bolt()
    while true do
        effect = AddSpecialEffectTarget(model_name, fb, "overhead")
        BlzSetSpecialEffectScale(effect, 0.5)
        enemy_loc = GetUnitLoc(enemy)
        enemy_point = Point:new(GetLocationX(enemy_loc), GetLocationY(enemy_loc))
        IssuePointOrderLoc(fb, "move", enemy_loc)
        TriggerSleepAction(0.)
        fb_loc = GetUnitLoc(fb)
        fb_point = Point:new(GetLocationX(fb_loc), GetLocationY(fb_loc))
        if enemy_point:atPoint(fb_point) then
            local damage = GetRandomReal(45000., 47000.)
            LadyDeathwhisper.unit:DealMagicDamage(enemy, damage)
            SetUnitMoveSpeed(enemy, enemy_movespeed / 2)
            local timer = CreateTimer()
            TimerStart(timer, 7, false, recover_movespeed)
            DestroyEffect(effect)
            RemoveUnit(fb)
            break
        end
        DestroyEffect(effect)
    end
    RemoveUnit(fb)
end

function LadyDeathwhisper.FBCheckPhase()
    if LadyDeathwhisper.phase == 2 then
        return true
    end
    return false
end

function LadyDeathwhisper.InitFrostBolt()
    local event = EventsUnit(LadyDeathwhisper.unit:GetUnit())
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.FBCheckPhase)
    event:AddAction(LadyDeathwhisper.FrostBolt)
end

