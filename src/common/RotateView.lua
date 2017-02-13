--[[
    旋转视图
    目前是六个位置
--]]

RotateView = class("RotateView", function() return cc.Layer:create() end)

function RotateView.create()
    local layer = RotateView.new()
    
    return layer
end

function RotateView:ctor()
    self._items = {}
    self._index = 1
    self:setContentSize(cc.size(GAME_GLOBAL_SCREE_WIDTH, 300))
    self._pos = 
    {
            cc.p(self:getContentSize().width/2, self:getContentSize().height/2-170),
            cc.p(self:getContentSize().width/2-250, self:getContentSize().height/2-90),
            cc.p(self:getContentSize().width/2-170, self:getContentSize().height/2+50),
            cc.p(self:getContentSize().width/2, self:getContentSize().height/2+100),
            cc.p(self:getContentSize().width/2+170, self:getContentSize().height/2+50),
            cc.p(self:getContentSize().width/2+250, self:getContentSize().height/2-90)
    }
end

function RotateView:pushBackCustomItem(item)
    if not self._isRegisterTouchEvent then
        self:registerTouchEvent()
        self._isRegisterTouchEvent = true
        
        local xian = cc.Sprite:create("myRes/yyhd_xian1.png")
        xian:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
        self:addChild(xian)
    end
    
    self._items[#self._items+1] = item
    --六芒星 逆时针
    if #self._items == 1 then 
        item:setPosition(self._pos[1])
        self:addChild(item, 4)
    elseif #self._items == 2 then
        item:setPosition(self._pos[2])
        item:setScale(0.85)
        self:addChild(item, 3)
    elseif #self._items == 3 then
        item:setPosition(self._pos[3])
        item:setScale(0.7)
        self:addChild(item, 2)
    elseif #self._items == 4 then
        item:setPosition(self._pos[4])
        item:setScale(0.55)
        self:addChild(item, 1)
    elseif #self._items == 5 then
        item:setPosition(self._pos[5])
        item:setScale(0.7)
        self:addChild(item, 2)
    elseif #self._items == 6 then
        item:setPosition(self._pos[6])
        item:setScale(0.85)
        self:addChild(item, 3)
    end
    
end

function RotateView:moveView(isLeft)
    if self._isMove then
        return
    end
    
    self._isMove = true
    local function callback()  
        self._isMove = false
    end
       
    if isLeft then
        for i=1, #self._items do
            local next = (i+1)%7
            if next == 0 then
                next = 1
            end
            if i == 6 then
                local seq = cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(0.3, cc.p(self._items[next]:getPosition())), 
                    cc.ScaleTo:create(0.3, self._items[next]:getScale())), cc.CallFunc:create(callback))
                self._items[i]:runAction(seq)
            else
                self._items[i]:runAction(cc.Spawn:create(cc.MoveTo:create(0.3, cc.p(self._items[next]:getPosition())), 
                    cc.ScaleTo:create(0.3, self._items[next]:getScale())))
            end
        end
        self._index = self._index - 1 
        if self._index == 0 then
            self._index = 6
        end
    else
        for i=1, #self._items do
            local last = i-1
            if last == 0 then
                last = 6
            end
            if i == 6 then
                local seq = cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(0.3, cc.p(self._items[last]:getPosition())), 
                    cc.ScaleTo:create(0.3, self._items[last]:getScale())), cc.CallFunc:create(callback))
                self._items[i]:runAction(seq)
            else
                self._items[i]:runAction(cc.Spawn:create(cc.MoveTo:create(0.3, cc.p(self._items[last]:getPosition())), 
                    cc.ScaleTo:create(0.3, self._items[last]:getScale())))
            end
        end
        self._index = (self._index+1)%7 
        if self._index == 0 then
            self._index = 1
        end
    end
    
    print("```````````访问`````````"..self._index)
end

function RotateView:registerTouchEvent()

    local begainPos = nil

    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        local box = self:getBoundingBox()
        local pos = self:convertToWorldSpace(cc.p(0, 0))
        box.x = pos.x
        box.y = pos.y
        if cc.rectContainsPoint(box, location) then
            begainPos = location
            
--            for i,v in pairs(self._items) do
--                local box = v:getBoundingBox()
--                local pos = v:convertToWorldSpace(cc.p(0, 0))
--                box.x = pos.x
--                box.y = pos.y
--                if cc.rectContainsPoint(box, location) then
--                    local sel = v:getScale()
--                    --v:runAction(cc.Sequence:create(cc.ScaleTo:create(0.15, sel*1.1), cc.ScaleTo:create(0.15, sel)))
--                    break
--                end
--            end
            return true
        end
        
    	return false
    end
    
    local function onTouchMoved(touch, event)
        local location = touch:getLocation()
        local dis = location.x - begainPos.x
        --print("```````````````````````````"..dis)
        
        if dis > 50 then --向右
            --begainPos = location
            self:moveView(false)
        elseif dis < -50 then --向左
            --begainPos = location
            self:moveView(true)
        else
            
        end
    end
    
    local function onTouchEnded(touch, event)
    end
    
    local function onTouchCancelled(touch, event)
        onTouchEnded(touch, event)
    end
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    listener:registerScriptHandler(onTouchCancelled,cc.Handler.EVENT_TOUCH_CANCELLED)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
end
