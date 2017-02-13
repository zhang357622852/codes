--[[

    单例---

--]]

GLOBAL_INSTANCE_SCENE = nil

GameScene = class("GameScene",function()return cc.Scene:create()end)

function GameScene.create()
    local scene = GameScene.new()   
    GLOBAL_INSTANCE_SCENE = scene

    scene:initInformation()
       
    return scene
end

function GameScene:getInstanceGameScene()
    return GLOBAL_INSTANCE_SCENE
end

function GameScene:ctor()
    
end

function GameScene:initInformation()
    
    self:initRequire()
    self:initAudio()
    
    math.randomseed(os.time())
    
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

--加载头文件
function GameScene:initRequire()   
    require "common.common"
    require "layer.layer"   
end

--加载通用音乐/音效
function  GameScene:initAudio()
    --音效
    cc.SimpleAudioEngine:getInstance():preloadEffect("audio/click_1.wav")
end



