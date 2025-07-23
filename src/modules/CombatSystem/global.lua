---@author meiso

--- Система глобального слежения за активным боем
GlobalCombatSystem = {
    active = false,
}

-- TODO: убедиться что не требуется вешать доп проверку на активный бой
-- TODO: а то мало ли не по синкается этот модуль с системой агро
--- Инициализация системы
function GlobalCombatSystem.Init()
    local timer = Timer(2.)
    timer:EnablePeriodic()
    timer:SetFunc(GlobalCombatSystem._process)
    timer:Start()
end

function GlobalCombatSystem._process()
    -- смотрим у кого активен бой и активируем, если хоть кто-то в бою
    local check = false
    for _, hero in Session.all_selected_heroes:Pairs() do
        if hero:IsAlive() then
            check = check or hero.agro.combat
        end
        GlobalCombatSystem.active = check
    end
    -- всем остальным выставляем то же значение
    for _, hero in Session.all_selected_heroes:Pairs() do
        hero.agro.combat = GlobalCombatSystem.active
    end
end
