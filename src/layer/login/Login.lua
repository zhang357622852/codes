--[[
	登入界面
--]]

Login = class("Login", function() return BaseLayer:create() end)

function Login.create()
    local layer = Login.new()
    layer:initView()

    return layer
end

function Login:ctor()
    self._type = "Login"
   
    local layer = getOneLayerFromType("Logo")
    if layer then
        layer:close()
    end
    self:registerKeyBoardReleased()
end

function Login:initView()
    Audio.playMusic("login_music",true)
    
    local visiblesize = cc.Director:getInstance():getVisibleSize()
    local winsize = cc.Director:getInstance():getWinSize()
    
    local label = cc.Label:createWithTTF("visiblesize.width: "..visiblesize.width,GAME_LABEL_FONT,32)
    label:setPosition(visiblesize.width/2,self:getContentSize().height/2+200)
    self:addChild(label)
    
    local label = cc.Label:createWithTTF("visiblesize.height: "..visiblesize.height,GAME_LABEL_FONT,32)
    label:setPosition(visiblesize.width/2,self:getContentSize().height/2+150)
    self:addChild(label)
    
    local label = cc.Label:createWithTTF("self:getContentSize().width: "..self:getContentSize().width,GAME_LABEL_FONT,32)
    label:setPosition(self:getContentSize().width/2,self:getContentSize().height/2+100)
    self:addChild(label)
    
    local label = cc.Label:createWithTTF("self:getContentSize().height: "..self:getContentSize().height,GAME_LABEL_FONT,32)
    label:setPosition(self:getContentSize().width/2,self:getContentSize().height/2+50)
    self:addChild(label)
    
    local label = cc.Label:createWithTTF("winsize.width: "..winsize.width,GAME_LABEL_FONT,32)
    label:setPosition(winsize.width/2,self:getContentSize().height/2)
    self:addChild(label)
    
    local label = cc.Label:createWithTTF("winsize.height: "..winsize.height,GAME_LABEL_FONT,32)
    label:setPosition(winsize.width/2,self:getContentSize().height/2-50)
    self:addChild(label)
    
    
    local function callback_rotation(sender, eventType)
        if eventType == ccui.TouchEventType.ended then                 
            local layer = Main.create()
            layer:addto(nil)
            self:closeLogin()
        end
    end

    local bt = UIButton.create("button/an_2.png")
    bt:setPosition(self:getContentSize().width/2, 100)
    self:addChild(bt)
    bt:addTouchEventListener(callback_rotation) 
    bt:addLabel(GameString.WM_OTHER_INTER)
end

function Login:closeLogin()
	self:close()
end

