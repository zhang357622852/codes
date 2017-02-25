--[[
            音频管理
            --这里使用新的音频库AudioEngine取代SimpleAudioEngine 因为旧的音频播放音效时，无法再播完后支持回调函数，造成音效重叠播放
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


function playMusic(name)
--    if isMusic then
--        audio:playBackgroundMusic(musicFiles[name],true) --playMusic(musicFiles[name],true) 
--    else
--        audio:stopBackgroundMusic()
--    end
    ccexp.AudioEngine:play2d(musicFiles[name],true)
end

---音效
local rffectFiles =
    {
        "audio/click_1.wav"
    }

--预加载音效
for k,v in pairs(rffectFiles) do
    audio:preloadEffect(v)
end

