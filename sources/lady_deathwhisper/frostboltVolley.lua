
function LadyDeathwhisper.FrostBoltVolley()
    TriggerSleepAction(5.)
    local model_name = "Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl"

    local function frostbolt(enemy)
        local fb = UnitSpell(LadyDeathwhisper.unit:GetUnit())
        local enemy_movespeed = enemy:GetMoveSpeed()
        local effect = Effect(fb, model_name, 0.7)
        while true do
            TriggerSleepAction(0.)
            fb:MoveToUnit(enemy)
            if fb:NearTarget(enemy) then
                --TODO: выставить правильный урон
                local damage = GetRandomInt(10., 12.)
                LadyDeathwhisper.unit:DealMagicDamage(enemy, damage)
                enemy:SetMoveSpeed(enemy_movespeed / 2)
                break
            end
        end
        effect:Destroy()
        fb:Remove()
    end

    -- проверяем, чтобы Лэди не считалась союзником
    local function checker()
        return LadyDeathwhisper.unit:IsEnemy(Unit(GetAttacker()))
    end

    local enemies = LadyDeathwhisper.unit:GetNearbyEnemies(500, checker)
    local count = CountUnitsInGroup(enemies)
    for _ = 1, count do
        local enemy = Unit(GroupPickRandomUnit(enemies))
        GroupRemoveUnit(enemies, enemy:GetUnit())
        if LadyDeathwhisper.unit:IsEnemy(enemy) then
            StartThread(frostbolt(enemy))
        end
    end
end

function LadyDeathwhisper.FBVCheckPhase()
    if LadyDeathwhisper.phase == 2 then
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