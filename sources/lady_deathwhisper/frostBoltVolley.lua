
function LadyDeathwhisper.FrostBoltVolley()
    TriggerSleepAction(10.)
    local enemy --= GetUnitInArea(GroupHeroesInArea(gg_rct_areaLD, GetOwningPlayer(GetAttacker())))
    local enemy_loc
    local enemy_point
    local enemy_movespeed = GetUnitMoveSpeed(enemy)
    local fb
    local fb_loc
    local fb_point
    local fbv

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

    local function frostbolt()
        fb = frost_bolt()
        while true do
            enemy = GetEnumUnit()
            effect = AddSpecialEffectTarget(model_name, fb, "overhead")
            BlzSetSpecialEffectScale(effect, 0.5)
            enemy_loc = GetUnitLoc(enemy)
            enemy_point = Point:new(GetLocationX(enemy_loc), GetLocationY(enemy_loc))
            IssuePointOrderLoc(fb, "move", enemy_loc)
            TriggerSleepAction(0.)
            fb_loc = GetUnitLoc(fb)
            fb_point = Point:new(GetLocationX(fb_loc), GetLocationY(fb_loc))
            if enemy_point:atPoint(fb_point) then
                local damage = GetRandomReal(10000., 12000.)
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

    ForGroup(GetUnitsInRangeOfLocAll(512, GetUnitLoc(LadyDeathwhisper.unit:GetUnit())), frostbolt)
end

function LadyDeathwhisper.FBVCheckPhase()
    if LadyDeathwhisper.phase == 1 then
        return true
    end
    return false
end

function LadyDeathwhisper.InitFrostBoltVolley()
    local event = EventsUnit(LadyDeathwhisper.unit:GetUnit())
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.FBVCheckPhase)
    event:AddAction(LadyDeathwhisper.FrostBoltVolley)
end