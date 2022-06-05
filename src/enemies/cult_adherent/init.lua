
function CultAdherent.Init(location, face)
    CultAdherent.summoned = true

    CultAdherent.unit = Unit(LICH_KING, CULT_ADHERENT, location, face)

    CultAdherent.unit:SetBaseDamage(940)
    CultAdherent.unit:SetMaxLife(100000, true)
    CultAdherent.unit:SetMaxMana(200000, true)

end
