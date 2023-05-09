-- Copyright (c) meiso

avengers_shield = Ability(
        AVENGERS_SHIELD,
        "Щит мстителя (C)",
        "Бросает в противника священный щит, наносящий ему урон от светлой магии. " ..
                "Щит затем перескакивает на других находящихся поблизости противников. " ..
                "Способен воздействовать на 3 цели.",
        "ReplaceableTextures/CommandButtons/avengers_shield.tga"
)

blessing_of_kings = Ability(
        BLESSING_OF_KINGS,
        "Благословение королей (Z)",
        "Благословляет дружественную цель, повышая все ее характеристики на 10% на 10 мин.",
        "ReplaceableTextures/CommandButtons/blessing_of_kings.tga"
)

blessing_of_might = Ability(
        BLESSING_OF_MIGHT,
        "Благословение могущества (V)",
        "Благословляет дружественную цель, увеличивая силу атаки на 550. Эффект длится 10 мин.",
        "ReplaceableTextures/CommandButtons/blessing_of_might.tga"
)

blessing_of_wisdom = Ability(
        BLESSING_OF_WISDOM,
        "Благословение мудрости (C)",
        "Благословляет дружественную цель, восполняя ей 92 ед. маны раз в 5 секунд в течение 10 мин.",
        "ReplaceableTextures/CommandButtons/blessing_of_wisdom.tga"
)

blessing_of_sanctuary = Ability(
        BLESSING_OF_SANCTUARY,
        "Благословение неприкосновенности (X)",
        "Благословляет дружественную цель, уменьшая любой наносимый ей урон на 3% и " ..
                "повышая ее силу и выносливость на 10%. Эффект длится 10 мин.",
        "ReplaceableTextures/CommandButtons/blessing_of_sanctuary.tga"
)

-------------------------------------------

flash_heal = Ability(
        FLASH_HEAL,
        "Быстрое исцеление (Q)",
        "Восстанавливает 1887 - 2193 ед. здоровья союзнику.",
        "ReplaceableTextures/CommandButtons/flash_heal.tga"
)

renew = Ability(
        RENEW,
        "Обновление (E)",
        "Восстанавливает цели 1400 ед. здоровья в течение 15 сек.",
        "ReplaceableTextures/CommandButtons/renew.tga"
)

power_word_shield = Ability(
        POWER_WORD_SHIELD,
        "Слово силы: Щит (S)",
        "Вытягивает частичку души союзника и создает из нее щит, способный поглотить 2230 ед. урона. " ..
                "Время действия – 30 сек.. Пока персонаж защищен, произнесение им заклинаний не может быть прервано " ..
                "получением урона. Повторно наложить щит можно только через 15 сек.",
        "ReplaceableTextures/CommandButtons/power_word_shield.tga"
)

weakened_soul = Ability(
        "",
        "Ослабленная душа",
        "Душа цели ослаблена заклинанием 'Слово силы: Щит' и не может быть повторно защищена в течение 15 сек.",
        "ReplaceableTextures/CommandButtons/weakened_soul.tga"
)

guardian_spirit = Ability(
        GUARDIAN_SPIRIT,
        "Оберегающий дух (R)",
        "Призывает оберегающего духа для охраны дружественной цели. " ..
                "Дух улучшает действие всех эффектов исцеления на выбранного союзника на 40% и спасает его от смерти, " ..
                "жертвуя собой. Смерть духа прекращает действие эффекта улучшенного исцеления, но восстанавливает цели " ..
                "50% ее максимального запаса здоровья. Время действия – 10 сек.",
        "ReplaceableTextures/CommandButtons/guardian_spirit.tga"
)

prayer_of_mending = Ability(
        PRAYER_OF_MENDING,
        "Молитва восстановления (D)",
        "Молитва оберегает союзника и восстанавливает ему 1043 ед. здоровья при следующем " ..
                "получении урона. После исцеления заклинание переходит к другому участнику рейда в пределах 20 м. " ..
                "Молитва может совершать переход 5 раз и длится 30 сек.. после смены цели. Это заклинание можно накладывать " ..
                "только на одну цель одновременно.",
        "ReplaceableTextures/CommandButtons/prayer_of_mending.tga"
)

circle_of_healing = Ability(
        CIRCLE_OF_HEALING,
        "Круг исцеления (W)",
        "Восстанавливает 958 - 1058 ед. здоровья участникам группы или рейда," ..
                "находящимся в радиусе 15 м от выбранной цели. Может излечить до 5 персонажей.",
        "ReplaceableTextures/CommandButtons/circle_of_healing.tga"
)
