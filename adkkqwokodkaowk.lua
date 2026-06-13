local TweenService = game:GetService("TweenService")
local Players      = game:GetService("Players")
local Lighting     = game:GetService("Lighting")

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
-- BACKGROUND — transparan + tint biru es
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
-- GARIS ATAS
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

-- =========================
-- GARIS BAWAH
-- =========================
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
    for _ = 1, 4 do
        for _, d in ipairs(dotStates) do
            sub.Text = d
            task.wait(0.28)
        end
    end

    -- 6) Fade out
    local fadeInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

    TweenService:Create(label,      fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(sub,        fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(lineTop,    fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(lineBottom, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(bg,         fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(blur,       TweenInfo.new(0.6), {Size = 0}):Play()

    task.wait(0.7)
    gui:Destroy()
    blur:Destroy()
end)
