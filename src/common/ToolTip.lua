--[[
    提示框
--]]

ToolTip = class("ToolTip", function() return BaseLayer:create() end)

function ToolTip.create(id)
    local layer = ToolTip.new(id)
    layer:initView(id)

    return layer
end

function ToolTip:ctor()
    self._type = "ToolTip"
end

function ToolTip:initView(id)
    local id = id or 1
    local cfg = CfgToolTip.content[id]
    
    local layerbg = ccui.Scale9Sprite:create("common/ty_k_1.png",cc.rect(0,0,80,80),cc.rect(39,39,2,2))
    layerbg:setContentSize(cc.size(652,458))
    layerbg:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
    self:addChild(layerbg)   

    local bg = ccui.Scale9Sprite:create("common/ty_k_2.png")
    bg:setContentSize(cc.size(616,230))
    bg:setPosition(layerbg:getContentSize().width/2, layerbg:getContentSize().height/2+25)
    layerbg:addChild(bg)

    local contbg = ccui.Scale9Sprite:create("common/ty_k_4.png")
    contbg:setContentSize(cc.size(588,162))
    contbg:setPosition(bg:getContentSize().width/2, bg:getContentSize().height/2)
    bg:addChild(contbg)

    local sprite3 = cc.Sprite:create("common/pf_k_1.png")     
    sprite3:setPosition(layerbg:getContentSize().width/2, layerbg:getContentSize().height-10)
    layerbg:addChild(sprite3)

    local label = cc.Label:createWithSystemFont(cfg.title, "Arial", 30) --title
    label:setColor(cc.c3b(125,86,49))
    label:setPosition(sprite3:getContentSize().width/2,sprite3:getContentSize().height/2-2)
    sprite3:addChild(label)

    local lbcontent = cc.Label:createWithSystemFont(cfg.content,"Arial",26) --content
    lbcontent:setColor(cc.c3b(146,111,71))
    lbcontent:setPosition(contbg:getContentSize().width/2,contbg:getContentSize().height/2)
    contbg:addChild(lbcontent)

    local function button1_select(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            if self._callback1 then
                self._callback1()
            else
                self:closeToolTip()
            end
        end
    end
    local button1 = UIButton.create("button/an_2.png")
    button1:setPosition(layerbg:getContentSize().width/2-130,65)
    button1:addTouchEventListener(button1_select)
    button1:addLabel(cfg.str1)
    layerbg:addChild(button1)

    local function button2_select(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            if self._callback2 then
                self._callback2()
            end
        end
    end
    local button2 = UIButton.create("button/an_1.png")
    button2:setPosition(layerbg:getContentSize().width/2+130,65)
    button2:addTouchEventListener(button2_select)
    button2:addLabel(cfg.str2)
    layerbg:addChild(button2)

    self:addto(nil,GAME_GLOBAL_TOAST_ZORDER,0)
end

function ToolTip:setCallBack1(callback)
    self._callback1 = callback
end

function ToolTip:setCallBack2(callback)
    self._callback2 = callback
end

function ToolTip:closeToolTip()
    self:close()
end


