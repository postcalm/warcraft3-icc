
function CultAdherent.Init(location, face)
    --определяем кого суммонить
    local adherent = CULT_ADHERENT
    if CultAdherent.morphed then adherent = CULT_ADHERENT_MORPH end

    --если уже призван - уберём
    if CultAdherent.unit then
        CultAdherent.unit:Remove()
    end

    CultAdherent.unit = Unit(LICH_KING, adherent, location, face)

    if CultAdherent.summoned then
        CultAdherent.unit:SetBaseDamage(940)
    end
    if CultAdherent.morphed then
        CultAdherent.unit:SetBaseDamage(1254)
    end

    CultAdherent.unit:SetMaxLife(51720, true)
    CultAdherent.unit:SetMaxMana(65250, true)
end
