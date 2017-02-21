--[[

    初始图层
    
--]]

Main = class("Main", function() return BaseLayer.create() end)

function Main.create()
    local layer = Main.new()
    layer:initView()
    
    return layer   
end

function Main:ctor()
    self._type = "Main"
    self._index = 0
    self._menuLayer = {}
end

function Main:initView()

    --关闭
    local function callback_rotation(sender, eventType)
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        elseif eventType == ccui.TouchEventType.ended then
            local layer = test.create()
            layer:addto(nil,10)
        elseif eventType == ccui.TouchEventType.canceled then
        end
    end

    local button = UIButton.create("myRes/an_15.png")
    button:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
    self:addChild(button, 10)
    button:addTouchEventListener(callback_rotation)
    button:addSprite("string/str_gb.png")
    
    
    self:registerKeyBoardReleased()

    
end

function Main:closeMainUI()
    self:close()
end


