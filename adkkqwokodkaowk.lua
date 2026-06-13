--V7
local TweenService  = game:GetService("TweenService")
local Players       = game:GetService("Players")
local Lighting      = game:GetService("Lighting")
local RunService    = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name           = "LoadingUI"
gui.ResetOnSpawn   = false
gui.IgnoreGuiInset = true
gui.DisplayOrder   = 999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent         = player:WaitForChild("PlayerGui")

-- =========================
-- BLUR
-- =========================
local blur = Instance.new("BlurEffect")
blur.Size   = 0
blur.Parent = Lighting
TweenService:Create(blur, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {Size = 32}):Play()

-- =========================
-- BACKGROUND
-- =========================
local bg = Instance.new("Frame")
bg.Size                   = UDim2.new(1, 0, 1, 0)
bg.Position               = UDim2.new(0, 0, 0, 0)
bg.BackgroundColor3       = Color3.fromRGB(180, 210, 235)
bg.BackgroundTransparency = 0.78
bg.BorderSizePixel        = 0
bg.ZIndex                 = 1
bg.Parent                 = gui

-- =========================
-- ICY BORDER
-- =========================
local icyBorders = {}

local function makeIceBorder(sizeX, sizeY, posX, posY)
    local f = Instance.new("Frame")
    f.Size                   = UDim2.new(sizeX, 0, sizeY, 0)
    f.Position               = UDim2.new(posX, 0, posY, 0)
    f.BackgroundColor3       = Color3.fromRGB(190, 225, 250)
    f.BackgroundTransparency = 0.45
    f.BorderSizePixel        = 0
    f.ZIndex                 = 2
    f.Parent                 = bg
    table.insert(icyBorders, {frame = f, baseTrans = 0.45})
end
makeIceBorder(0.025, 1,     0,     0)
makeIceBorder(0.025, 1,     0.975, 0)
makeIceBorder(1,     0.035, 0,     0)
makeIceBorder(1,     0.035, 0,     0.965)

-- =========================
-- ICY CRYSTAL SPIKES
-- =========================
local spikes = {}

local function makeSpike(posX, height, width, fromBottom)
    local spike = Instance.new("Frame")
    spike.Size                   = UDim2.new(0, width, 0, height)
    spike.AnchorPoint            = Vector2.new(0.5, fromBottom and 1 or 0)
    spike.Position               = UDim2.new(posX, 0, fromBottom and 1 or 0, 0)
    spike.BackgroundColor3       = Color3.fromRGB(210, 238, 255)
    spike.BackgroundTransparency = 0.35
    spike.BorderSizePixel        = 0
    spike.ZIndex                 = 3
    spike.Parent                 = bg
    table.insert(spikes, {frame = spike, baseTrans = 0.35})
end

local spikeData = {
    {0.05,55,10},{0.09,38,7},{0.13,70,12},{0.17,42,8},
    {0.22,60,9},{0.26,30,6},{0.31,50,10},{0.35,65,11},
    {0.39,35,7},{0.44,55,9},{0.48,45,8},{0.52,68,12},
    {0.56,38,7},{0.61,58,10},{0.65,44,8},{0.69,72,13},
    {0.73,33,6},{0.78,52,9},{0.82,40,7},{0.87,63,11},
    {0.91,35,6},{0.95,50,9},
}
for _, s in ipairs(spikeData) do
    makeSpike(s[1], s[2], s[3], false)
    makeSpike(s[1], math.floor(s[2]*0.7), s[3], true)
end

-- =========================
-- SNOW CANVAS
-- =========================
local snowCanvas = Instance.new("CanvasGroup")
snowCanvas.Size                   = UDim2.new(1, 0, 1, 0)
snowCanvas.BackgroundTransparency = 1
snowCanvas.BorderSizePixel        = 0
snowCanvas.ZIndex                 = 6
snowCanvas.Parent                 = bg

-- =========================
-- SNOWFLAKE BUILDER
-- =========================
local function makeSnowflake(posX, posY, size, transparency)
    local container = Instance.new("Frame")
    container.Size                   = UDim2.new(0, size, 0, size)
    container.AnchorPoint            = Vector2.new(0.5, 0.5)
    container.Position               = UDim2.new(posX, 0, posY, 0)
    container.BackgroundTransparency = 1
    container.BorderSizePixel        = 0
    container.ZIndex                 = 6
    container.Parent                 = snowCanvas

    local armThick    = math.max(1, math.floor(size * 0.10))
    local armLen      = size
    local branchLen   = math.floor(size * 0.30)
    local branchThick = math.max(1, math.floor(armThick * 0.8))
    local color       = Color3.fromRGB(220, 240, 255)

    local function makeArm(rot)
        local arm = Instance.new("Frame")
        arm.Size                   = UDim2.new(0, armLen, 0, armThick)
        arm.AnchorPoint            = Vector2.new(0.5, 0.5)
        arm.Position               = UDim2.new(0.5, 0, 0.5, 0)
        arm.BackgroundColor3       = color
        arm.BackgroundTransparency = transparency
        arm.BorderSizePixel        = 0
        arm.Rotation               = rot
        arm.ZIndex                 = 6
        arm.Parent                 = container

        local offsets = {
            {0.18, 1, 0.5,  45}, {0.18, 1, 0.5, -45},
            {0.82, 0, 0.5,  45}, {0.82, 0, 0.5, -45},
        }
        for _, o in ipairs(offsets) do
            local b = Instance.new("Frame")
            b.Size                   = UDim2.new(0, branchLen, 0, branchThick)
            b.AnchorPoint            = Vector2.new(o[2], o[3])
            b.Position               = UDim2.new(o[1], 0, 0.5, 0)
            b.BackgroundColor3       = color
            b.BackgroundTransparency = transparency + 0.1
            b.BorderSizePixel        = 0
            b.Rotation               = rot + o[4]
            b.ZIndex                 = 6
            b.Parent                 = container
        end
    end

    makeArm(0)
    makeArm(60)
    makeArm(120)

    local center = Instance.new("Frame")
    center.Size                   = UDim2.new(0, armThick*2, 0, armThick*2)
    center.AnchorPoint            = Vector2.new(0.5, 0.5)
    center.Position               = UDim2.new(0.5, 0, 0.5, 0)
    center.BackgroundColor3       = Color3.fromRGB(240, 250, 255)
    center.BackgroundTransparency = transparency
    center.BorderSizePixel        = 0
    center.ZIndex                 = 7
    center.Parent                 = container

    local uic = Instance.new("UICorner")
    uic.CornerRadius = UDim.new(1, 0)
    uic.Parent       = center

    return container
end

-- =========================
-- SPAWN SNOWFLAKES
-- =========================
local snowflakes = {}

local function spawnSnowflake(randomY)
    local size  = math.random(14, 36)
    local trans = math.random(30, 65) / 100
    local posX  = math.random(3, 97) / 100
    local posY  = randomY and (math.random(0, 100) / 100) or (math.random(-8, -2) / 100)

    local flakeFrame = makeSnowflake(posX, posY, size, trans)

    table.insert(snowflakes, {
        frame  = flakeFrame,
        posY   = posY,
        posX   = posX,
        speed  = math.random(8, 22) / 100,
        drift  = math.random(-6, 6) / 1000,
        wobble = math.random(0, 628) / 100,
        spin   = math.random(-30, 30),
        rot    = math.random(0, 360),
    })
end

for _ = 1, 45 do
    spawnSnowflake(true)
end

-- =========================
-- SNOW LOOP
-- =========================
local isRunning = true
local connection
connection = RunService.Heartbeat:Connect(function(dt)
    if not isRunning then
        connection:Disconnect()
        return
    end
    for _, sf in ipairs(snowflakes) do
        sf.wobble = sf.wobble + dt * 1.5
        sf.posY   = sf.posY + sf.speed * dt
        sf.posX   = sf.posX + sf.drift + math.sin(sf.wobble) * 0.0006
        sf.rot    = sf.rot + sf.spin * dt

        if sf.posY > 1.06 then
            sf.posY = -0.06
            sf.posX = math.random(3, 97) / 100
        end
        if sf.posX > 1.02 then sf.posX = -0.02 end
        if sf.posX < -0.02 then sf.posX = 1.02 end

        sf.frame.Position = UDim2.new(sf.posX, 0, sf.posY, 0)
        sf.frame.Rotation = sf.rot
    end
end)

-- =========================
-- FLASH FRAME
-- =========================
local flashFrame = Instance.new("Frame")
flashFrame.Size                   = UDim2.new(1, 0, 1, 0)
flashFrame.BackgroundColor3       = Color3.fromRGB(220, 240, 255)
flashFrame.BackgroundTransparency = 1
flashFrame.BorderSizePixel        = 0
flashFrame.ZIndex                 = 10
flashFrame.Parent                 = bg

-- =========================
-- GARIS ATAS & BAWAH
-- =========================
local lineTop = Instance.new("Frame")
lineTop.Size                   = UDim2.new(0, 0, 0, 1)
lineTop.AnchorPoint            = Vector2.new(0.5, 0.5)
lineTop.Position               = UDim2.new(0.5, 0, 0.44, 0)
lineTop.BackgroundColor3       = Color3.fromRGB(200, 230, 255)
lineTop.BackgroundTransparency = 0.1
lineTop.BorderSizePixel        = 0
lineTop.ZIndex                 = 4
lineTop.Parent                 = bg

local lineBottom = Instance.new("Frame")
lineBottom.Size                   = UDim2.new(0, 0, 0, 1)
lineBottom.AnchorPoint            = Vector2.new(0.5, 0.5)
lineBottom.Position               = UDim2.new(0.5, 0, 0.57, 0)
lineBottom.BackgroundColor3       = Color3.fromRGB(200, 230, 255)
lineBottom.BackgroundTransparency = 0.1
lineBottom.BorderSizePixel        = 0
lineBottom.ZIndex                 = 4
lineBottom.Parent                 = bg

-- =========================
-- MAIN TITLE
-- =========================
local label = Instance.new("TextLabel")
label.Size                   = UDim2.new(0.8, 0, 0.12, 0)
label.AnchorPoint            = Vector2.new(0.5, 0.5)
label.Position               = UDim2.new(0.5, 0, 0.5, 0)
label.BackgroundTransparency = 1
label.TextColor3             = Color3.fromRGB(230, 245, 255)
label.TextTransparency       = 0
label.Font                   = Enum.Font.GothamBold
label.TextSize               = 52
label.Text                   = ""
label.ZIndex                 = 5
label.Parent                 = bg

-- =========================
-- SUBTITLE
-- =========================
local sub = Instance.new("TextLabel")
sub.Size                   = UDim2.new(0.4, 0, 0.05, 0)
sub.AnchorPoint            = Vector2.new(0.5, 0.5)
sub.Position               = UDim2.new(0.5, 0, 0.62, 0)
sub.BackgroundTransparency = 1
sub.TextColor3             = Color3.fromRGB(180, 215, 240)
sub.TextTransparency       = 1
sub.Font                   = Enum.Font.Code
sub.TextSize               = 14
sub.Text                   = "LOADING..."
sub.ZIndex                 = 5
sub.Parent                 = bg

-- =========================
-- ANIMASI
-- =========================
task.spawn(function()

    -- 1) Typewriter
    local full = "ZERO  IMPACT"
    for i = 1, #full do
        label.Text = string.sub(full, 1, i)
        task.wait(0.08)
    end

    task.wait(0.1)

    -- 2) Flash impact
    flashFrame.BackgroundTransparency = 0.5
    TweenService:Create(flashFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()

    -- 3) Lines expand
    TweenService:Create(lineTop,    TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0.6, 0, 0, 1)}):Play()
    TweenService:Create(lineBottom, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0.6, 0, 0, 1)}):Play()

    -- 4) Subtitle muncul
    task.wait(0.3)
    TweenService:Create(sub, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    -- 5) Dot animation
    local dotStates = {"LOADING", "LOADING .", "LOADING . .", "LOADING . . ."}
    for _ = 1, 2 do
        for _, d in ipairs(dotStates) do
            sub.Text = d
            task.wait(0.28)
        end
    end

    -- 6) Fade out berlapis
    task.wait(0.4)
    isRunning = false

    local fadeText   = TweenInfo.new(1.0, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
    local fadeMid    = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
    local fadeBorder = TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
    local fadeBg     = TweenInfo.new(2.0, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
    local fadeBlur   = TweenInfo.new(2.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)

    -- teks duluan
    TweenService:Create(label, fadeText, {TextTransparency = 1}):Play()
    TweenService:Create(sub,   fadeText, {TextTransparency = 1}):Play()

    -- garis & salju
    TweenService:Create(lineTop,    fadeMid, {BackgroundTransparency = 1}):Play()
    TweenService:Create(lineBottom, fadeMid, {BackgroundTransparency = 1}):Play()
    TweenService:Create(snowCanvas, fadeMid, {GroupTransparency = 1}):Play()

    -- icy border
    for _, b in ipairs(icyBorders) do
        TweenService:Create(b.frame, fadeBorder, {BackgroundTransparency = 1}):Play()
    end

    -- spikes
    for _, s in ipairs(spikes) do
        TweenService:Create(s.frame, fadeBorder, {BackgroundTransparency = 1}):Play()
    end

    -- bg & blur terakhir
    TweenService:Create(bg,   fadeBg,   {BackgroundTransparency = 1}):Play()
    TweenService:Create(blur, fadeBlur, {Size = 0}):Play()

    task.wait(2.1)
    gui:Destroy()

    task.wait(0.8)
    blur:Destroy()
end)
