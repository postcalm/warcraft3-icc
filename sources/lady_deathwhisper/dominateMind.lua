
--TODO: избавиться от глобалок
DOMINATE_MIND_EXIST = false

function DominateMind()
    --TODO: исправить на нормальную реализацию
    local target = GetAttacker()
    local prev_owner = GetOwningPlayer(target)
    if DOMINATE_MIND_EXIST then
        SetUnitOwner(target, LICH_KING, true)
        TriggerSleepAction(5.)
        SetUnitOwner(target, prev_owner, true)
        TriggerSleepAction(20.)
        DOMINATE_MIND_EXIST = false
    end
end

function DominateMindExist()
    if not DOMINATE_MIND_EXIST then
        DOMINATE_MIND_EXIST = true
        return DOMINATE_MIND_EXIST
    end
    return false
end

function Init_DominateMind()
    local event = EventsUnit(LADY_DEATHWHISPER)
    event:RegisterAttacked()
    event:AddCondition(DominateMindExist)
    event:AddAction(DominateMind)
end