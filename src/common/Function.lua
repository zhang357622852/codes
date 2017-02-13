
--以log的模式打印
local _print = print
function printLog(...)
    if WM_LUA_DEBUG >= 3 then
        local arg = {...}
        local sLog = "LOG:"
        for i,v in pairs(arg) do
            sLog = sLog .. tostring(v) .. "\t"
        end

        _print(sLog)
    end
end

--以警告的模式打印
function printWarn(...)
    if WM_LUA_DEBUG >= 2 then
        local arg = {...}
        local sLog = "WARN:"
        for i,v in pairs(arg) do
            sLog = sLog .. tostring(v) .. "\t"
        end
        _print(sLog)
    end
end

--以错误的模式打印
function printError(...)
    if WM_LUA_DEBUG >= 1 then
        local arg = {...}
        local sLog = "ERROR:"
        for i,v in pairs(arg) do
            sLog = sLog .. tostring(v) .. "\t"
        end
        _print(sLog)
    end
end

--打印表
function printTable(tab,index)
    index = index or 0
    local cur = ""
    for k= 1,index do
        cur = cur .."    "
    end
    for i,v in pairs(tab) do
        if type(v) == "table" then
            _print(cur..i.." = ")
            _print(cur.."{")
            printTable(v,index+1)
            _print(cur.."}")
        else
            if type(v) == "boolean" then
                if v then
                    v = "true"
                else
                    v = "false"
                end
            end

            if type(v) == "function" then
                v = tostring(v)
            end

            if i ~= "ifDataIn" then
                _print(cur..i.." = ".. v)
            end
        end
    end
end

--重写print 函数 为不可用
--屏蔽print,改写为printLog的原因是:等项目发布时，需要关闭打印，
function print(...)
    _print(...) --为啥要加这个，error才会调用?
    error("USE 'printLog/printWarn/printError/printTable' INSTEAD OF print function",2)
end

-------------------------
--@function: 通过string类型的type得到layer的对象
function getOneLayerFromType(type)   
    for k, v in pairs(GAME_GLOBAL_LAYERS) do
        if k and v and k._type==type then
            return k
        end
    end    
end

--shader:变灰
function setSpriteGray(sprite)
    if sprite == nil then
        return
    end
    local state = cc.GLProgramState:getOrCreateWithGLProgramName("Gray")
    if state == nil then
        --lewislualog("create new shader")
        local glprogram = cc.GLProgram:createWithFilenames("shader/Gray.vsh", "shader/Gray.fsh")
        cc.GLProgramCache:getInstance():addGLProgram(glprogram, "Gray")
        state = cc.GLProgramState:getOrCreateWithGLProgram(glprogram)
    end
    sprite:setGLProgramState(state)
end 

--shader:正常
function setSpriteNormal(sprite)
    if sprite == nil then
        return
    end
    --ShaderPositionTextureColorAlphaTest_NoMV --ShaderPositionTextureColor_noMVP
    local glprogram = cc.GLProgramCache:getInstance():getGLProgram("ShaderPositionTextureColor_noMVP")
    local state = cc.GLProgramState:getOrCreateWithGLProgram(glprogram)
    sprite:setGLProgramState(state)
end

--shader:ice
function setSpriteIce(sprite)
    if sprite == nil then
        return
    end
    local state = cc.GLProgramState:getOrCreateWithGLProgramName("Ice")
    if state == nil then
        local glprogram = cc.GLProgram:createWithFilenames("shader/Ice.vsh", "shader/Ice.fsh")
        cc.GLProgramCache:getInstance():addGLProgram(glprogram, "Ice")
        state = cc.GLProgramState:getOrCreateWithGLProgram(glprogram)
    end
    sprite:setGLProgramState(state)
end



