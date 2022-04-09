
local numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
local tabuleiroWidth = display.contentWidth * 0.8
local tabuleiroHeight = display.contentHeight * 0.6
local pieceWidth = tabuleiroWidth/4
local pieceHeight = tabuleiroHeight/4
local firstContainerPosX = display.contentCenterX - 0.30 * display.contentWidth
local firstContainerPosY = display.contentCenterY - 0.225*display.contentHeight
local positionContinerX = firstContainerPosX
local positionContinerY = firstContainerPosY
local position = 1
local textos = {}
local rects = {}

local util = {numbers, pieceWidth, pieceHeight}
util.pieceWidth = pieceWidth
util.pieceHeight = pieceHeight

function count_inversions()
    inversions = 0
    for i=1, #textos do
        for j=i, #textos do
            if textos[j] < textos[i] then
                inversions = inversions+1
            end
        end
    end
    return inversions
end

function util.indexOf(a, value)
    for i=1, #a do
        if a[i] == value then
            return i
        end
    end
    return nil
end

function util.shuffle()
    local array = numbers
    for i = #array, 2, -1 do
        local j = math.random(i)
        array[i], array[j] = array[j], array[i]
      end
    textos = array
end

function util.getRects()
    for i = 1, 15, 1 do
        -- rects[i] = display.newRect(0, 0, pieceWidth,pieceHeight);
        -- rects[i].stroke = {0.3, 0.2, 0.2}
        -- rects[i].strokeWidth = 3
        rects[i] = display.newImageRect("tile-blue.jpg",pieceWidth,pieceHeight)
    end
end

function util.getItems()
    util:shuffle()
    inv = count_inversions()
    if inv % 2 ~= 0 then
        aux = textos[1]
        textos[1] = textos[2]
        textos[2] = aux
    end
    inv = count_inversions()
    util:getRects()
    local containers = {}
    local text = ''
    for i = 1, #rects do
        local cont = display.newContainer(pieceWidth, pieceHeight)
        -- text = display.newText(textos[i], 0, 0, 0, 0)
        text = display.newText(textos[i], 0, 0, native.systemFontBold, 20)
        text:setFillColor(1)
        cont:insert(rects[i], true)
        cont:insert(text, true)
        cont.value = textos[i]
        cont.id = i
        containers[i] = cont
        containers[i]:translate(positionContinerX, positionContinerY)
        if position == 4 then
            position = 1
            positionContinerX = firstContainerPosX
            positionContinerY = positionContinerY + pieceHeight
        else
            position = position + 1
            positionContinerX = positionContinerX + pieceWidth
        end
    end
    positionContinerX = firstContainerPosX
    positionContinerY = firstContainerPosY
    position = 1
    return containers
end

return util