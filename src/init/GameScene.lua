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
    math.randomseed(os.time())
end

--加载头文件
function GameScene:initRequire()   
    require "common.common"
    require "config.config"
    require "layer.layer"   
end




