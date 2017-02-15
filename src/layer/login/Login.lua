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
end

function Login:initView()
    local function callback_rotation(sender, eventType)
        if eventType == ccui.TouchEventType.ended then                 
            local layer = MainUI.create()
            layer:addto(GLOBAL_INSTANCE_SCENE)
        end
    end

    local bt = UIButton.create("myRes/an_15.png")
    bt:setPosition(self:getContentSize().width/2, 100)
    self:addChild(bt)
    bt:addTouchEventListener(callback_rotation) 
    bt:addLabel("进入游戏")
end

function Login:closeLogin()
	self:close()
end

