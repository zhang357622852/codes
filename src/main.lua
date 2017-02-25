
cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")

-- CC_USE_DEPRECATED_API = true
require "cocos.init"
require "init.init"

-- cclog
local cclog = function(...)
    print(string.format(...))
end

--for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    --cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    --cclog(debug.traceback())
    --cclog("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    -- initialize director
    local director = cc.Director:getInstance()

    --turn on display FPS
    director:setDisplayStats(true)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)
    
    --分辨率适配
    local designResolutionSizeX = 1280
    local designResolutionSizeY = 720
    local designResolutionSizeType = 3
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(designResolutionSizeX, designResolutionSizeY, designResolutionSizeType)
    
    --create scene 
    local gameScene = GameScene.create()
    
    if cc.Director:getInstance():getRunningScene() then
        --引擎会初始化一个场景,cc.Director:getInstance():getRunningScene()一开始得到的是初始的场景,后面再调用时，才是自定义的场景
        cc.Director:getInstance():replaceScene(gameScene)
    else
        cc.Director:getInstance():runWithScene(gameScene)
    end
    
    local layer = Logo.create(1)
    layer:addto(gameScene)  

end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    --error(msg)
end
