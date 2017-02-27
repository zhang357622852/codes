--[[
    音频管理
    --这里使用的还是SimpleAudioEngine
    --没有使用新的音频引擎AudioEngine，好像在android上是有问题的,只能等使用高版本的，再研究下
--]]

module("Audio",package.seeall)

local isMusic = true --音乐开关
local isEffect = true --音效开关
local audio = cc.SimpleAudioEngine:getInstance()

---音乐
local musicFiles =
{
        login_music="audio/login_bg.mp3"
}
--预加载音乐
for k,v in pairs(musicFiles) do
    audio:preloadMusic(v)
    printLog("this is preloadMusic: "..v)
end

function playMusic(name,isLoop)  
    if isMusic then
        local isLoop = isLoop or false
        local filename = musicFiles[name] or musicFiles["login_music"]
        audio:playMusic(filename,isLoop)
    end
end

function pauseMusic()
    audio:pauseMusic()
end

function resumeMusic()
    audio:resumeMusic()
end

function stopMusic(isReleaseData)
    local isReleaseData = isReleaseData or false
    audio:stopMusic(isReleaseData)
end

---音效
local effectFiles =
    {
        button_1 = "audio/click_1.wav"
    }
    
--预加载音效
for k,v in pairs(effectFiles) do
    audio:preloadEffect(v)
    printLog("this is preloadEffect: "..v)
end

function playEffect(name, isLoop)
    if isEffect then
        local isLoop = isLoop or false
        local filename = effectFiles[name] or effectFiles["button_1"]
        audio:playEffect(filename,isLoop)
    end
end

function stopAllEffects()
    audio:stopAllEffects()
end





