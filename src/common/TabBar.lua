--[[
    标签条
--]]

TabBar = class("TabBar", function() return cc.Layer:create() end)

--itemTable: {"pic1.png", "pic2.png", ·····}  lightPic:高亮背景图 defaultPos:默认选择item dis:间隔距离
function TabBar.create(itemTable, lightPic, defaultPos, dis)
    local layer = TabBar.new(defaultPos)
    layer:initView(itemTable, lightPic, defaultPos, dis)
    
    return layer
end

local _callback = nil --这个变量的作用域？？
local itemsLight = {}

function TabBar:ctor(defaultPos)
    self._index = defaultPos or 1
end

function TabBar:initView(itemTable, lightPic, defaultPos, dis)
    
    local menu = cc.Menu:create()
    menu:setPosition(0, 0) --注意点1:如果没有给menu设置做坐标，它会自动设置在屏幕中心,锚点(0,0)
    self:addChild(menu)
    
    local dis = dis or 0
    local x = dis
    for i=1, #itemTable do
        local norSp = cc.Sprite:create(itemTable[i])
        local selSp = cc.Sprite:create(itemTable[i])
        selSp:setScale(1.1)
        
        local item = cc.MenuItemSprite:create(norSp, selSp)
        item:setPosition(x+item:getContentSize().width/2, item:getContentSize().height/2)
        x = x + item:getContentSize().width + dis      
        menu:addChild(item, 1, i) --注意点2：这里要设置tag,selectItem(tag, item)中的tag就是从这里来的
        item:registerScriptTapHandler(self.selectItem)
        
        norSp:setAnchorPoint(cc.p(0.5, 0.5)) --注意点3:精灵必须设置锚点(0.5,0.5)，因为为了避免以左下角放大的效果， 正确的是以中心为锚点放大,精灵添加高MenuItem中，锚点被重置为(0,0)
        norSp:setPosition(item:getContentSize().width/2, item:getContentSize().height/2)
        selSp:setAnchorPoint(cc.p(0.5, 0.5))
        selSp:setPosition(item:getContentSize().width/2, item:getContentSize().height/2)
        
        local lightSp = cc.Sprite:create(lightPic)
        lightSp:setPosition(item:getContentSize().width/2, item:getContentSize().height/2)
        item:addChild(lightSp)
        itemsLight[i] = lightSp
        if self._index == i then
            lightSp:setVisible(true)
        else
            lightSp:setVisible(false)        
        end
    end
    
end

function TabBar:registerCallBack(callback)
    _callback = callback
end

function TabBar.selectItem(tag, item)
    for k,v in pairs(itemsLight) do
        if k == tag then
            v:setVisible(true)
        else
            v:setVisible(false)
        end
    end
    Toast3.create("主界面"..tag)
    if _callback then
        _callback(tag, item)
    end
end
