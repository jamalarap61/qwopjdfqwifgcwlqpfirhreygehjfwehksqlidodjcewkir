-- Load Library
local Library, SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/jamalarap61/Mslspakwnendlsowjnssoaknana/refs/heads/main/wnsoaowknswlwksnwmk.lua"))()


function gradient(text, startColor, endColor)
    local result = ""
    local length = #text

    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)

        local char = text:sub(i, i)
        result = result .. "<font color=\"rgb(" .. r ..", " .. g .. ", " .. b .. ")\">" .. char .. "</font>"
    end

    return result
end


local Window = Library:CreateWindow({
    Title = "ZeroImpact | Grow A Garden 2 ",
    Size = UDim2.new(0, 480, 0, 300), 
    TabWidth = 120,
    Theme = "LimitHub",    
    Acrylic = false
})
local ConfigLod = "ZeroImpact/GAG2/config/GAG2.json"


function NotifyHub(text) 
Library:Notify({
Title = "ZeroImpact", 
Content = text,
Duration = 5,
})
end

local Home = Window:AddTab({Title = "Home", Icon = "home"})
local Garden = Window:AddTab({Title = "Garden",Icon = "leaf"})




Window:SelectTab(1) 

local menu1 = Garden:AddSection("Auto Collect Fruits")
local menu1jln = false
menu1:AddToggle("Auto_Collect_fruits",{
Title = "Auto Collect Fruits",
Description = "All Fruits",
Default = false,
Callback = function(Value)
if Value then
if menu1jln then return end
menu1jln = true
spawn(function()
while menu1jln do
    local player = game.Players.LocalPlayer
local gardens = workspace:WaitForChild("Gardens")

local myPlot

-- cari plot berdasarkan NAMA
for _, plot in pairs(gardens:GetChildren()) do
    if plot:GetAttribute("Owner") == player.Name then
        myPlot = plot
        break
    end
end

if not myPlot then return end

-- lanjut ke Plants
local plantsFolder = myPlot:FindFirstChild("Plants")
if not plantsFolder then return end

for _, plant in pairs(plantsFolder:GetChildren()) do
    local fruitsFolder = plant:FindFirstChild("Fruits")
    if not fruitsFolder then continue end

    for _, fruit in pairs(fruitsFolder:GetChildren()) do
        if fruit:IsA("Model") then
            
            local harvestPart = fruit:FindFirstChild("HarvestPart")
            if harvestPart then
                
                local prompt = harvestPart:FindFirstChildWhichIsA("ProximityPrompt")
                if prompt then
                    fireproximityprompt(prompt)
                end

            end
        end
    end
end
task.wait(0.5)
end
end)
else
menu1jln = false
end
end
end
})

local menu2 = Garden:AddSection("Auto Sell Inventory")
local menu2jln = false
menu2:AddToggle("Auto_Sell_Inventory",{
Title = "Auto Sell Inventory",
Description = "Sell All Inventory",
Default = false,
Callback = function(Value)
if Value then
if menu2jln then return end
menu2jln = true
spawn(function()
while menu2jln do
    local args = {
    buffer.fromstring("\153\000\020")
}
game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Packet"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
task.wait(1)
end
end)
else
menu2jln = false
end
end
end
})

