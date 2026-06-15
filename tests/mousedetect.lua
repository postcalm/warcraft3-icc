---@author meiso

local mouseX, mouseY = 0, 0
local playerIndex = GetConvertedPlayerId(GetLocalPlayer()) -- ID локального игрока

-- Обработчик наведения курсора на фрейм
function OnFrameMouseEnter()
    local frame = BlzGetTriggerFrame()
    -- Получаем координаты фрейма (примерные координаты мыши)
    mouseX = BlzFrameGetAbsPointX(frame, FRAMEPOINT_CENTER)
    mouseY = BlzFrameGetAbsPointY(frame, FRAMEPOINT_CENTER)
    print("Mouse moved: X=" .. mouseX .. ", Y=" .. mouseY)
end

-- Инициализация сетки фреймов
function InitFrameMouseTracking()
    local gridTrigger = CreateTrigger()
    local parentFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local frameWidth, frameHeight = 0.02, 0.02 -- Размер одного фрейма (в относительных координатах UI)
    local cols, rows = 40, 30 -- Количество столбцов и строк

    for i = 0, cols - 1 do
        for j = 0, rows - 1 do
            -- Создаём невидимый фрейм
            local frame = BlzCreateFrameByType("FRAME", "MouseTrackerFrame", parentFrame, "", 0)
            BlzFrameSetSize(frame, frameWidth, frameHeight)
            BlzFrameSetAbsPoint(frame, FRAMEPOINT_BOTTOMLEFT, frameWidth * i, frameHeight * j)
            BlzFrameSetAlpha(frame, 0) -- Полностью прозрачный

            -- Регистрируем событие наведения курсора
            BlzTriggerRegisterFrameEvent(gridTrigger, frame, FRAMEEVENT_MOUSE_ENTER)
        end
    end

    BlzTriggerAddAction(gridTrigger, OnFrameMouseEnter)
    print("Frame-based mouse tracking initialized.")
end

-- Запускаем отслеживание
--InitFrameMouseTracking()
