--[[

    初始图层
    
--]]

MainUI = class("MainUI", function() return BaseLayer.create() end)

function MainUI.create()
    local layer = MainUI.new()
    layer:initView()
    
    return layer   
end

function MainUI:ctor()
    self._type = "MainUI"
    self._index = 0
    self._menuLayer = {}
end

function MainUI:initView()
    
--    local downTitle = cc.Sprite:create("layer/init/zjm_xbg.png")
--    downTitle:setPosition(downTitle:getContentSize().width/2, downTitle:getContentSize().height/2)
--    self:addChild(downTitle, 10)
--    
--    --
--    local function callback(tag, item)
--        if tag ~= self._index then 
--            if self._menuLayer[self._index] then
--                self._menuLayer[self._index]:removeFromParent()
--                self._menuLayer[self._index] = nil
--            end
--        end
--        self._index = tag
--        
--        if tag == 1 then
--            if not self._menuLayer[1] then
--                local layer = HomePage.create()
--                layer:addto(self)
--                
--                self._menuLayer[1] = layer
--            end
--        elseif tag == 2 then
--            if not self._menuLayer[2] then
--                local layer = cc.Layer:create()
--                local bg = cc.Sprite:create("myRes/bg_2.png")
--                bg:setPosition(layer:getContentSize().width/2, layer:getContentSize().height/2)
--                layer:addChild(bg) 
--                self:addChild(layer)
--                self._menuLayer[2] = layer
--            end
--        elseif tag == 3 then
--            if not self._menuLayer[3] then
--                local layer = cc.Layer:create()
--                local bg = cc.Sprite:create("myRes/bg_3.png")
--                bg:setPosition(layer:getContentSize().width/2, layer:getContentSize().height/2)
--                layer:addChild(bg) 
--                self:addChild(layer)
--                self._menuLayer[3] = layer
--            end
--        elseif tag == 4 then
--            if not self._menuLayer[4] then
--                local layer = cc.Layer:create()
--                local bg = cc.Sprite:create("myRes/bg_4.png")
--                bg:setPosition(layer:getContentSize().width/2, layer:getContentSize().height/2)
--                layer:addChild(bg) 
--                self:addChild(layer)
--                self._menuLayer[4] = layer
--            end
--        elseif tag == 5 then
--            if not self._menuLayer[5] then
--                local layer = cc.Layer:create()
--                local bg = cc.Sprite:create("myRes/bg_5.png")
--                bg:setAnchorPoint(cc.p(0,0))
--                --bg:setPosition(layer:getContentSize().width/2, layer:getContentSize().height/2)
--                layer:addChild(bg) 
--                self:addChild(layer)
--                self._menuLayer[5] = layer
--            end
--        elseif tag == 6 then
--            if not self._menuLayer[6] then
--                local layer = cc.Layer:create()
--                local bg = cc.Sprite:create("myRes/bg_6.png")
--                bg:setPosition(layer:getContentSize().width/2, layer:getContentSize().height/2)
--                layer:addChild(bg) 
--                self:addChild(layer)
--                self._menuLayer[6] = layer
--            end
--        end
--    end
--
--    local path = {"layer/init/dfw_sz_1.png","layer/init/dfw_sz_2.png",
--        "layer/init/dfw_sz_3.png","layer/init/dfw_sz_4.png","layer/init/dfw_sz_5.png","layer/init/dfw_sz_6.png"}
--    local tab = TabBar.create(path, "layer/init/dfw_sz_7.png", 1)
--    tab:registerCallBack(callback)
--    self:addChild(tab, 10)
--    
--    callback(1)
    
    --关闭
    local isClick = true
    local function callback_rotation(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            printLog("````````````began````````")
--            if isClick then
--                printLog("````````````true````````")
--            else
--                printLog("````````````false````````")
--            end
            isClick = true
            sender:runAction(cc.Sequence:create(cc.DelayTime:create(0.07),cc.CallFunc:create(function() isClick = false end)))
            
        elseif eventType == ccui.TouchEventType.moved then
            --printLog("```````````moved`````````")
        elseif eventType == ccui.TouchEventType.ended then
            printLog("``````````ended``````````")
            --self:closeMainUI()
            if isClick then
                printLog("````````````true````````")
            else
                printLog("````````````false````````")
            end
            if isClick then
                local layer = test.create()
                layer:addto(nil,10)
            end
        elseif eventType == ccui.TouchEventType.canceled then
            printLog("````````````canceled````````")
        end
    end
    local function callback(sender,index)

    end

    local button = UIButton.create("myRes/an_15.png")
    button:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
    self:addChild(button, 10)
    button:addTouchEventListener(callback_rotation)
    button:addSprite("string/str_gb.png")
end

function MainUI:reshLabel()
	
end

function MainUI:closeMainUI()
    self:close()
end


