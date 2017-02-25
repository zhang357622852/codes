--[[
    一个透明图层，并且屏蔽下层的消息，点击非图片区域会关闭此图层
    
    --注意:
        close()函数是最基础的关闭图层方式,如果想要在关闭前做一些操作,1.重写close() 2.再写一个关闭函数，最后一步调用self:close()
--]]

BaseLayer = class("BaseLayer", function() return cc.Layer:create() end)

function BaseLayer.create()
    local layer = BaseLayer.new()
    
    return layer
end

function BaseLayer:ctor()
    self:setContentSize(cc.size(GAME_GLOBAL_SCREE_WIDTH, GAME_GLOBAL_SCREE_HEGHT))
    self:setAnchorPoint(cc.p(0, 0))
    self._shield = true --屏蔽下层消息
    self._mask = true --遮罩
    self._keyboard_back = true --电脑上键盘返回/安卓上返回键 ->退出当前图层
    self._maskStr = "common/cm_opacity.png"
    GAME_GLOBAL_LAYERS[self] = true
end

function BaseLayer:addto(parent, zorder, tag)    
    local zorder, tag = zorder or 0, tag or 0
    
    if not parent then
        parent = cc.Director:getInstance():getRunningScene()
    end
    parent:addChild(self, zorder, tag)
    
    if self._shield then--屏蔽下层消息
        local node = cc.Node:create()
        node:setContentSize(GAME_GLOBAL_SCREE_WIDTH, GAME_GLOBAL_SCREE_HEGHT)
        node:setAnchorPoint(cc.p(0, 0))

        local menuItem = cc.MenuItemSprite:create(node, node, node)

        local menu = cc.Menu:create(menuItem)
        menu:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
        menu:setContentSize(GAME_GLOBAL_SCREE_WIDTH, GAME_GLOBAL_SCREE_HEGHT)
        self:addChild(menu, -10000)
   
        if self._mask then --蒙版
            local scale9 = ccui.Scale9Sprite:create(self._maskStr)
            scale9:setContentSize(GAME_GLOBAL_SCREE_WIDTH, GAME_GLOBAL_SCREE_HEGHT)
            scale9:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
            node:addChild(scale9)
        end
    end
    
    --printLog(string.format("--------------create %s'layer--------------",self._type))
    if self._keyboard_back then
        GAME_GLOBAL_BACK_LAYERS[#GAME_GLOBAL_BACK_LAYERS+1] = self
    end
    
end

function BaseLayer:setShield(isShield)
    self._shield = isShield
end

function BaseLayer:setKeyBoardBack(isKeyBoardBack)
    self._keyboard_back = isKeyBoardBack
end

function BaseLayer:setMask(isMask)
    self._mask = isMask
end

--设置遮罩蒙版的图片
function BaseLayer:setMaskStr(path)
    self._maskStr = path
end

--点击非图片区域会关闭此图层   
--注意：
-- 1.安全区域层的模板node的锚点是cc.p(0.5, 0.5),如果不是此锚点，需重新计算--这里为了不写太多的if-elseif的句子，如果有需求多的话再增加
function BaseLayer:registerWithSafeArea(node)
    if self._closeArea then
        printLog("you have recently registered a SafeArea")
    else
        self._closeArea = true
        local layer = cc.Layer:create()
        layer:setContentSize(node:getBoundingBox().width, node:getBoundingBox().height) --要考虑到这个节点可能被缩放了
        layer:setAnchorPoint(cc.p(0, 0))       
        layer:setPosition(node:getPositionX()-node:getBoundingBox().width/2, node:getPositionY()-node:getBoundingBox().height/2)
        self:addChild(layer,-9999)

        local function onTouchBegan(touch, event)
            local pos = touch:getLocation()
            local box = layer:getBoundingBox()

            if cc.rectContainsPoint(box, pos) then
                return false
            else
                return true
            end
        end

        local function onTouchEnded(touch, event)
            local str = "close"..self._type
            if self[str] then
                self[str](self)
            else
                error(string.format("----------------the Layer have not close%s function----------",self._type),2)
            end
        end

        local listener = cc.EventListenerTouchOneByOne:create()
        listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
        listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)

        local disp = layer:getEventDispatcher()
        disp:addEventListenerWithSceneGraphPriority(listener, layer)
    end     
end

--以注册此函数的图层为基底图层
--以这种方式退出当前图层，只能调用closeName()
--键盘上的ESC对应安卓返回键 键值:6
function BaseLayer:registerKeyBoardReleased()
    --keycode是键值,但是与cc.KeyCode.KEY_1不对应 然而ESC键值又对应?
    local function keyboard(keycode,event)   
        if keycode == cc.KeyCode.KEY_ESCAPE then
            local layer = GAME_GLOBAL_BACK_LAYERS[#GAME_GLOBAL_BACK_LAYERS]
            if not layer or layer == self then
                --退出游戏
                local layer = ToolTip.create(1)
                layer:setCallBack2(function() cc.Director:getInstance():endToLua() end)
            else
                local str = "close"..layer._type
                if layer[str] then
                    printLog(string.format("--------------------keyboard'way close%s--------------",layer._type))
                    table.remove(GAME_GLOBAL_BACK_LAYERS,#GAME_GLOBAL_BACK_LAYERS)
                    layer[str](layer)
                else
                    error(string.format("----------------the Layer have not close%s function----------",layer._type),2)
                end
            end
        end
    end
    local listener =  cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(keyboard,cc.Handler.EVENT_KEYBOARD_RELEASED)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener,self)
end

function BaseLayer:close()
    GAME_GLOBAL_LAYERS[self] = nil
    for i,v in ipairs(GAME_GLOBAL_BACK_LAYERS) do
        if self == v then    
            table.remove(GAME_GLOBAL_BACK_LAYERS,i)
            break
        end
    end
    --printLog(string.format("--------------------close %s'layer--------------",self._type))
    self:removeFromParent()
    self = nil
end