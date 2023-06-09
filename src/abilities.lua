-- Copyright (c) meiso

------------------------------Paladin------------------------------

avengers_shield = Ability {
    ability = AVENGERS_SHIELD,
    tooltip = "Щит мстителя",
    key = "C",
    text = "Бросает в противника священный щит, наносящий ему урон от светлой магии. " ..
            "Щит затем перескакивает на других находящихся поблизости противников. " ..
            "Способен воздействовать на 3 цели.",
    icon = "ReplaceableTextures/CommandButtons/avengers_shield.tga"
}

blessing_of_kings = Ability {
    ability = BLESSING_OF_KINGS,
    tooltip = "Благословение королей",
    key = "Q",
    text = "Благословляет дружественную цель, повышая все ее характеристики на 10% на 10 мин.",
    icon = "ReplaceableTextures/CommandButtons/blessing_of_kings.tga",
    buff_desc = "Все характеристики повышены на 10%."
}

blessing_of_might = Ability {
    ability = BLESSING_OF_MIGHT,
    tooltip = "Благословение могущества",
    key = "W",
    text = "Благословляет дружественную цель, увеличивая силу атаки на 550. Эффект длится 10 мин.",
    icon = "ReplaceableTextures/CommandButtons/blessing_of_might.tga",
    buff_desc = "Сила атаки увеличена на 550."
}

blessing_of_wisdom = Ability {
    ability = BLESSING_OF_WISDOM,
    tooltip = "Благословение мудрости",
    key = "E",
    text = "Благословляет дружественную цель, восполняя ей 92 ед. маны раз в 5 секунд в течение 10 мин.",
    icon = "ReplaceableTextures/CommandButtons/blessing_of_wisdom.tga",
    buff_desc = "Восполнение 92 ед. маны раз в 5 сек."
}

blessing_of_sanctuary = Ability {
    ability = BLESSING_OF_SANCTUARY,
    tooltip = "Благословение неприкосновенности",
    key = "R",
    text = "Благословляет дружественную цель, уменьшая любой наносимый ей урон на 3% и " ..
            "повышая ее силу и выносливость на 10%. Эффект длится 10 мин.",
    icon = "ReplaceableTextures/CommandButtons/blessing_of_sanctuary.tga",
    buff_desc = "Получаемый урон снижен на 3%, сила и выносливость повышены на 10%. Если вы парируете, " ..
            "блокируете атаку или уклоняетесь от нее, вы восполняете 2% от максимального запаса маны."
}

consecration = Ability {
    ability = CONSECRATION,
    tooltip = "Освящение",
    key = "R",
    text = "Освящает участок земли, на котором стоит паладин, " ..
            "нанося урон от светлой магии в течение 8 сек., противникам, которые находятся на этом участке",
    icon = "ReplaceableTextures/CommandButtons/consecration.tga"
}

judgement_of_light_tr = Ability {
    ability = JUDGEMENT_OF_LIGHT_TR,
    tooltip = "Правосудие света",
    key = "D",
    text = "Высвобождает энергию печати и обрушивает ее на противника, после чего в течение 20 сек. " ..
            "после чего каждая атака против него может восстановить 2%% от максимального запаса здоровья атакующего.",
    icon = "ReplaceableTextures/CommandButtons/judgement_of_light.tga",
    buff_desc = "Атакуя цель, противник может восстановить здоровье."
}

judgement_of_wisdom_tr = Ability {
    ability = JUDGEMENT_OF_WISDOM_TR,
    tooltip = "Правосудие мудрости",
    key = "F",
    text = "Высвобождает энергию печати и обрушивает ее на противника, после чего в течение 20 сек. " ..
            "после чего каждая атака против него может восстановить 2%% базового запаса маны атакующего.",
    icon = "ReplaceableTextures/CommandButtons/judgement_of_wisdom.tga",
    buff_desc = "Атаки и заклинания, направленные против цели, могут восстановить немного маны атакующему."
}

shield_of_righteousness = Ability {
    ability = SHIELD_OF_RIGHTEOUSNESS,
    tooltip = "Щит праведности",
    key = "W",
    text = "Мощный удар щитом, наносящий урон от светлой магии. " ..
            "Величина урона рассчитывается исходя из показателя блока и увеличивается на 520 ед. дополнительно.",
    icon = "ReplaceableTextures/CommandButtons/shield_of_righteousness.tga"
}

------------------------------Priest------------------------------

flash_heal = Ability {
    ability = FLASH_HEAL,
    tooltip = "Быстрое исцеление",
    key = "Q",
    text = "Восстанавливает 1887 - 2193 ед. здоровья союзнику.",
    icon = "ReplaceableTextures/CommandButtons/flash_heal.tga"
}

renew = Ability {
    ability = RENEW,
    tooltip = "Обновление",
    key = "E",
    text = "Восстанавливает цели 1400 ед. здоровья в течение 15 сек.",
    icon = "ReplaceableTextures/CommandButtons/renew.tga",
    buff_desc = "Восстановление 280 ед. здоровья раз в 3 с."
}

power_word_shield = Ability {
    ability = POWER_WORD_SHIELD,
    tooltip = "Слово силы: Щит",
    key = "S",
    text = "Вытягивает частичку души союзника и создает из нее щит, способный поглотить 2230 ед. урона. " ..
            "Время действия – 30 сек.. Пока персонаж защищен, произнесение им заклинаний не может быть прервано " ..
            "получением урона. Повторно наложить щит можно только через 15 сек.",
    icon = "ReplaceableTextures/CommandButtons/power_word_shield.tga",
    buff_desc = "Поглощение урона."
}

weakened_soul = Ability {
    ability = "",
    tooltip = "Ослабленная душа",
    key = "Q",
    text = "Персонаж не может быть целью заклинания 'Слово Силы: Щит'.",
    icon = "ReplaceableTextures/CommandButtons/weakened_soul.tga"
}

guardian_spirit = Ability {
    ability = GUARDIAN_SPIRIT,
    tooltip = "Оберегающий дух",
    key = "R",
    text = "Призывает оберегающего духа для охраны дружественной цели. " ..
            "Дух улучшает действие всех эффектов исцеления на выбранного союзника на 40% и спасает его от смерти, " ..
            "жертвуя собой. Смерть духа прекращает действие эффекта улучшенного исцеления, но восстанавливает цели " ..
            "50% ее максимального запаса здоровья. Время действия – 10 сек.",
    icon = "ReplaceableTextures/CommandButtons/guardian_spirit.tga",
    buff_desc = "Получаемое исцеление увеличено на 40%. Предотвращает один смертельный удар."
}

prayer_of_mending = Ability {
    ability = PRAYER_OF_MENDING,
    tooltip = "Молитва восстановления",
    key = "D",
    text = "Молитва оберегает союзника и восстанавливает ему 1043 ед. здоровья при следующем " ..
            "получении урона. После исцеления заклинание переходит к другому участнику рейда в пределах 20 м. " ..
            "Молитва может совершать переход 5 раз и длится 30 сек.. после смены цели. Это заклинание можно накладывать " ..
            "только на одну цель одновременно.",
    icon = "ReplaceableTextures/CommandButtons/prayer_of_mending.tga",
    buff_desc = "Восстанавливает 1043 ед. здоровья при последующем получении урона."
}

circle_of_healing = Ability {
    ability = CIRCLE_OF_HEALING,
    tooltip = "Круг исцеления",
    key = "W",
    text = "Восстанавливает 958 - 1058 ед. здоровья участникам группы или рейда," ..
            "находящимся в радиусе 15 м от выбранной цели. Может излечить до 5 персонажей.",
    icon = "ReplaceableTextures/CommandButtons/circle_of_healing.tga"
}

power_word_fortitude = Ability {
    ability = POWER_WORD_FORTITUDE,
    tooltip = "Молитва стойкости",
    key = "Q",
    text = "Повышает выносливость всех участников группы или рейда на 165 ед. на 1 ч.",
    icon = "ReplaceableTextures/CommandButtons/prayer_of_mending.tga",
    buff_desc = "Выносливость повышена на 165."
}

inner_fire = Ability {
    ability = INNER_FIRE,
    tooltip = "Внутренний огонь",
    key = "W",
    text = "Наполняет заклинателя священной энергией, которая усиливает его броню на 2440 ед. " ..
            "и силу заклинаний на 120. Каждая полученная жрецом атака снимает один заряд щита. " ..
            "Заклинание действует 30 мин. или пока не будут сняты 20 зарядов.",
    icon = "ReplaceableTextures/CommandButtons/BTNInnerFire.blp",
    buff_desc = "Броня усилена на 2440, а сила заклинаний увеличена на 120."
}

------------------------------XXXXXXX------------------------------
