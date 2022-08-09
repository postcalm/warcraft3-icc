require 'lfs' -- подключаем LuaFileSystem https://keplerproject.github.io/luafilesystem/manual.html
require 'utils/tools'

local param = {
    game_dirs  = { [[E:\Warcraft III\x86_64]], [[E:\Games\Warcraft III\x86_64]] }, -- папка с игрой
    map        = [[\ICC.w3x]], -- папка с картой
    test_map   = [[\Test.w3x]], -- карта для тестов
    customCode = [[\custom-code.lua]], -- файл, в который собирается весь код
    patcher    = [[\utils\custom-code-replacer.exe]], -- патчер для .wct
    files      = { -- порядок сборки файлов
        -- различные алиасы и тулсеты
        [[\common]],
        -- кастомные классы для работы с юнитами, эффектами и т.д.
        [[\classes]],
        -- система сохранений
        [[\libs\SaveSystem\init.lua]],
        [[\libs\SaveSystem\modules]],
        [[\libs\SaveSystem\userData.lua]],
        [[\libs\SaveSystem\heroData.lua]],
        [[\libs\SaveSystem\saveSystem.lua]],
        [[\libs\SaveSystem\heroes.lua]],
        [[\libs\SaveSystem\newHero.lua]],
        [[\libs\SaveSystem\saveHero.lua]],
        [[\libs\SaveSystem\loadHero.lua]],
        -- система экипировки
        [[\libs\EquipmentSystem]],
        -- система бафов/дебафов
        [[\libs\buffSystem.lua]],
        -- система отображения урона автоатак
        [[\libs\battleSystem.lua]],
        [[\libs\wrappers.lua]],
        -- исходники реализации боссов, героев и прочих существ
        [[\src\dummy]],
        [[\src\enemies]],
        [[\src\lord_marrowgar]],
        [[\src\lady_deathwhisper]],
        [[\src\paladin]],
        [[\src\priest]],
        -- точка входа
        [[\src\entry_point]],
        -- тесты
        [[\tests]],
    },
    tag        = [[--CUSTOM_CODE]], -- тэг для вставки кода
    current_dir    = lfs.currentdir() -- текущая папка проекта
}

function ReplaceInMap(map)
    -- заменяем код в war3map.lua
    local path    = param.current_dir .. map .. '\\war3map.lua'
    local war3map = io.open(path, 'r')
    local customCode    = io.open(param.current_dir .. param.customCode, 'r')
    local content = war3map:read('*a')
    war3map:close()
    war3map           = io.open(path, 'w+')
    local repl, count = string.gsub(content, param.tag .. '.*' .. param.tag, customCode:read('*a'))
    war3map:write(repl)
    war3map:close()
    customCode:close()

    -- патчим .wct
    local path_to_patcher = '"' .. param.current_dir .. param.patcher .. '"'
    local path_to_wct = '"' .. param.current_dir .. map .. '\\war3map.wct"'
    local path_to_custom = '"' .. param.current_dir .. param.customCode .. '"'
    os.execute('start "" ' .. path_to_patcher .. ' ' .. path_to_wct .. ' ' .. path_to_custom .. '')
end

-- подключаем нужные функции
dofile(param.current_dir .. [[\utils\lib\DirTree.lua]])
dofile(param.current_dir .. [[\utils\lib\FileContent.lua]])

-- собираем всё в один файл
local customCode = io.open(param.current_dir .. param.customCode, 'w+')
customCode:write(param.tag, '\n')
for i = 1, #param.files do
    local file = param.files[i]
    local path = param.current_dir .. file
    if file:match "[^.]+$" == 'lua' then
        WriteToFile(customCode, path)
    else
        for filepath, attr in DirTree(path) do
            if (attr.mode == 'file') then
                WriteToFile(customCode, filepath)
            end
        end
    end
end
customCode:write(param.tag)
customCode:close()

local skip_files = {"fdf.xml", "template.fdf"}
CopyFiles(param.current_dir .. [[\frames]],
          param.current_dir .. param.map,
          skip_files)
CopyFiles(param.current_dir .. [[\frames]],
          param.current_dir .. param.test_map,
          skip_files)

ReplaceInMap(param.map)
ReplaceInMap(param.test_map)

-- запускаем игру
if IsRunGame then
    os.execute('start  "" "' .. GetCatalog(param.game_dirs) .. '\\' .. 'Warcraft III.exe" -loadfile "' .. param.current_dir .. '\\' .. param.map .. '"')
end

-- запускаем редактор
if IsRunEditor then
    os.execute('start  "" "' .. GetCatalog(param.game_dirs) .. '\\' .. 'World Editor.exe" -loadfile "' .. param.current_dir .. '\\' .. param.map .. '"')
end

if IsTest then
    os.execute('start  "" "' .. GetCatalog(param.game_dirs) .. '\\' .. 'Warcraft III.exe" -loadfile "' .. param.current_dir .. '\\' .. param.test_map .. '"')
end

if EditTestMap then
    os.execute('start  "" "' .. GetCatalog(param.game_dirs) .. '\\' .. 'World Editor.exe" -loadfile "' .. param.current_dir .. '\\' .. param.test_map .. '"')
end
