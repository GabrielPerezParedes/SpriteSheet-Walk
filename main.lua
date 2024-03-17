-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Tu código aquí
cw = display.contentWidth
ch = display.contentHeight

fondo = display.newImageRect("NewHome.png", cw, ch)
fondo.x = cw/2; fondo.y = ch/2

local options2 = {
    width = 102,
    height = 152,
    numFrames = 16
}

local isUsingSprite1 = true  -- Inicialmente usando sprite.png

local moveSprite = graphics.newImageSheet("sprite.png", options2)

local sequence2 = {
    {
        name = "mR",
        frames = {13, 14, 15, 16},
        time = 300,
        loopCount = 1
    },
    {
        name = "mL",
        frames = {9, 10, 11, 12},
        time = 300,
        loopCount = 1
    },
    {
        name = "mD",
        frames = {1, 2, 3, 4},
        time = 300,
        loopCount = 1
    },
    {
        name = "mU",
        frames = {5, 6, 7, 8},
        time = 300,
        loopCount = 1
    }
}

local human = display.newSprite(moveSprite, sequence2)
human:translate( cw/2, ch/1.6 )
human.xScale= 0.35; human.yScale = 0.35

-- DEFINIMOS LOS PADS
local pad_up = display.newImageRect("a_up.png", 45, 45 )
pad_up.x = 60; pad_up.y = ch - 60
pad_up.anchorY = 1
pad_up.xScale = 0.8; pad_up.yScale = 0.8
pad_up:setFillColor(1,1,1)

local pad_down = display.newImageRect("a_down.png", 45, 45 )
pad_down.x = 60; pad_down.y = ch
pad_down.anchorY = 1
pad_down.xScale = 0.9; pad_down.yScale = 0.9
pad_down:setFillColor(1,1,1)

local pad_left = display.newImageRect("a_left.png", 40, 40 )
pad_left.x = 30; pad_left.y = ch - 30
pad_left.anchorY = 1
pad_left.xScale = 0.9; pad_left.yScale = 0.9
pad_left:setFillColor(1,1,1)

local pad_right = display.newImageRect("a_right.png", 40, 40 )
pad_right.x = 90; pad_right.y = ch - 30
pad_right.anchorY = 1
pad_right.xScale = 0.9; pad_right.yScale = 0.9
pad_right:setFillColor(1,1,1)

-- Botón para cambiar el sprite
local btn_changeSprite = display.newImageRect("a_red.png", 45, 45)
btn_changeSprite.x = cw - 60  -- Esto posiciona el botón horizontalmente.
btn_changeSprite.y = ch - 60  -- Ajusta esto para mover el botón más abajo.
btn_changeSprite.xScale = 0.8; btn_changeSprite.yScale = 0.8

-- Funciones para mover el personaje
function move_up(event)
    if event.phase == "ended" then
        desface = human.y - 25
        human:setSequence("mU")
        human:play()
        transition.to(human, {y=desface, time = 300})
    end
    return true
end

function move_down(event)
    if event.phase == "ended" then
        desface = human.y + 25
        human:setSequence("mD")
        human:play()
        transition.to(human, {y=desface, time = 300})
    end
    return true
end

function move_left(event)
    if event.phase == "ended" then
        desface = human.x - 25
        human:setSequence("mL")
        human:play()
        transition.to(human, {x=desface, time = 300})
    end
    return true
end

function move_right(event)
    if event.phase == "ended" then
        desface = human.x + 25
        human:setSequence("mR")
        human:play()
        transition.to(human, {x=desface, time = 300})
    end
    return true
end

-- Event listeners para los pads
pad_up:addEventListener("touch", move_up)
pad_down:addEventListener("touch", move_down)
pad_left:addEventListener("touch", move_left)
pad_right:addEventListener("touch", move_right)

local function onChangeSprite(event)
    if event.phase == "ended" then
        -- Eliminar el sprite actual
        if human then
            human:removeSelf()
            human = nil
        end

        -- Determinar cuál sprite cargar
        local spriteFile
        if isUsingSprite1 then
            spriteFile = "sprite2.png"
        else
            spriteFile = "sprite.png"
        end
        isUsingSprite1 = not isUsingSprite1  -- Alternar la variable

        -- Crear una nueva hoja de sprites con el sprite seleccionado
        local newSpriteSheet = graphics.newImageSheet(spriteFile, options2)
        
        -- Crear un nuevo sprite con la nueva hoja de sprites
        human = display.newSprite(newSpriteSheet, sequence2)
        human:translate(cw/2, ch/1.6)
        human.xScale= 0.35; human.yScale = 0.35
        human:setSequence("mR") -- Asegúrate de configurar la secuencia inicial deseada
        human:play()

        -- Agregar nuevamente los listeners si son necesarios aquí
        -- Por ejemplo: human:addEventListener("touch", moveHuman)
    end
    return true
end


-- Añadir el listener al botón de cambio de sprite
btn_changeSprite:addEventListener("touch", onChangeSprite)

-- Inicialización y pruebas de debug
human:setSequence("mL")
human:play()
print("frame: " .. human.frame)
print("Is Playing: " .. tostring(human.isPlaying))
print("# de frames: " .. human.numFrames)
print("sequence: " .. human.sequence)
print("timeScale: " .. human.timeScale)
