--[[
    logo
--]]

Logo = class("Logo", function() return BaseLayer:create() end)

--type: 1:logo是一张图片  2:logo是一个视频(点击屏幕，直接跳过,目前还没做)
function Logo.create(type)
    local layer = Logo.new()
    layer:initView(type)

    return layer
end

function Logo:ctor()
    self._type = "Logo"
end

function Logo:initView(type)
    if type == 1 then
        local sprite = cc.Sprite:create("ui/login/logo.png")
        sprite:setPosition(self:getContentSize().width/2,self:getContentSize().height/2)
        sprite:setOpacity(0)
        self:addChild(sprite)
        local function callback()
            self:gotoLogin()
        end
        
        local action1 = cc.FadeIn:create(1)
        local action2 = cc.DelayTime:create(1)
        local action3 = cc.FadeOut:create(1)
        local action4 = cc.CallFunc:create(callback)
        
        local action = cc.Sequence:create(action1,action2,action3,action4)
        sprite:runAction(action)
    else
        local targetPlatform = cc.Application:getInstance():getTargetPlatform()
        if targetPlatform == cc.PLATFORM_OS_ANDROID or targetPlatform == cc.PLATFORM_OS_IPHONE then --只要android和ios上起作用
            local function onVideoEventCallback(sener, eventType)
                if eventType == ccexp.VideoPlayerEvent.PLAYING then
                    Toast3.create("PLAYING")
                elseif eventType == ccexp.VideoPlayerEvent.PAUSED then
                    Toast3.create("PAUSED")
                elseif eventType == ccexp.VideoPlayerEvent.STOPPED then
                    Toast3.create("STOPPED")
                elseif eventType == ccexp.VideoPlayerEvent.COMPLETED then
                    Toast3.create("COMPLETED")
                    self:gotoLogin()
                end
                
            end
            
            local videoPlayer = ccexp.VideoPlayer:create()
            videoPlayer:setPosition(self:getContentSize().width/2,self:getContentSize().height/2)
            videoPlayer:setAnchorPoint(cc.p(0.5, 0.5))
            videoPlayer:setContentSize(self:getContentSize())
            videoPlayer:addEventListener(onVideoEventCallback)
            self:addChild(videoPlayer)
            videoPlayer:setFileName("res/video/cocosvideo.mp4") --路径要绝对路径
            videoPlayer:setFullScreenEnabled(true)
            videoPlayer:play()
        else
            local sprite = cc.Sprite:create("ui/login/logo.png")
            sprite:setPosition(self:getContentSize().width/2,self:getContentSize().height/2)
            self:addChild(sprite)
            local function callback()
                self:gotoLogin()
            end
        
            local action1 = cc.FadeOut:create(1)
            local action2 = cc.CallFunc:create(callback)
            local action = cc.Sequence:create(action1,action2)
            sprite:runAction(action)
        end
    end
end

function Logo:gotoLogin()
    local layer = Login.create()
    layer:addto(GLOBAL_INSTANCE_SCENE)
end

function Logo:closeLogo()
	self:close()
end
