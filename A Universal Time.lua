--[[
    A Universal Time v1.0
    By Jexytd or QuadSquad (@v3rmillion)
]]

-- Destroy GUI already exist --
if game:service'CoreGui':FindFirstChild("FinityUI") then game:service'CoreGui':FindFirstChild("FinityUI"):Destroy() end

-- Send a notifications if player on the game --
if game.PlaceId == 5130598377 then
    game:service'StarterGui':SetCore("SendNotification", {
        Title = "Discord Server";
        Text = "> https://discord.gg/K4waTHQ <";
    })
    game:service'StarterGui':SetCore("SendNotification", {
        Title = "Notification";
        Text = "> GUI Loaded! <";
    })
else
    game:service'StarterGui':SetCore("SendNotification", {
        Title = "Notification";
        Text = "GUI not loaded! you are on wrong game lmao";
    })
    return 
end

-- Remove seat chair lol --
for _,gay in pairs(workspace:GetDescendants()) do
    if gay:IsA("Model") and gay:FindFirstChildOfClass("Seat") then
        gay:Destroy()
    end
end

-- Global Variable --
TpAllItem = false
AntiTS = false
SellArrow = false
SellRoka = false
SellReqArrow = false
wSpeed = false
jPower = false
CollectMoney = false
tweenSpeed = 2

-- Local Variable --
local Players = game:service'Players'
local LocalP = Players.LocalPlayer

-- FinityUI Lib --
local Finity = loadstring(game:HttpGet("http://finity.vip/scripts/finity_lib.lua"))()
local FinityWindow = Finity.new(true) -- 'true' dark 'false' white
FinityWindow.ChangeToggleKey(Enum.KeyCode.Insert)

-- Categories --
local c1 = FinityWindow:Category("Main")
local c999 = FinityWindow:Category("Credits")

-- Credits Sector --
local s1 = c999:Sector("Finity Library Creator")
local s2 = c999:Sector("Script Creator")

-- Credits --
s1:Cheat("Label", "detourious (v3rmillion)")
s1:Cheat("Label", "deto#7612 (discord)")
s2:Cheat("Label", "QuadSquad (v3rmillion)")
s2:Cheat("Label", "Jexytd#3339 (discord)")
s2:Cheat("Label", "Discord Server (https://discord.gg/K4waTHQ)")

-- Main Sector --
local s1 = c1:Sector("AutoFarm")
local s2 = c1:Sector("Misc")
local s3 = c1:Sector("Local")

-- Items Dropdown --
local items = s1:Cheat("Dropdown", "Item", function(currentOption)
    ItemsSelect = currentOption
    wait()
    updateItemList()
end, {options = {}, default = ""})

-- Remove value duplicated in table/array --
function removeDuplicates(arr)
    local newArray = {}
    local checkerTbl = {}
    for _, element in ipairs(arr) do
        if not checkerTbl[element] then -- if there is not yet a value at the index of element, then it will be nil, which will operate like false in an if statement
            checkerTbl[element] = true
            table.insert(newArray, element)
        end
    end
    return newArray
end

-- Get Mobs and then insert to table/array --
itemA = {}
for _,tool in pairs(workspace.Items:GetChildren()) do
    if tool:IsA("Tool") then
        table.insert(itemA, tool.Name)
    end
end

itemB = removeDuplicates(itemA)
for i = 1, #itemB do
    items:AddOption(itemB[i])
end

function updateItemList()
    for i = 1, #itemB do
        items:RemoveOption(itemB[i])
    end
    wait()
    itemA = {}
    for _,tool in pairs(workspace.Items:GetChildren()) do
        if tool:IsA("Tool") then
            table.insert(itemA, tool.Name)
        end
    end

    itemB = removeDuplicates(itemA)
    for i2 = 1, #itemB do
        items:AddOption(itemB[i2])
    end
end

-- TP Speed Textbox --
local tpspeed = s1:Cheat("Textbox", "Speed TP", function(value)
    tweenSpeed = tonumber(value)
end, {placeholder = "Value"})

-- Teleport Button --
local teleport = s1:Cheat("Button", "Teleport", function()
    local Char = LocalP.Character
    for i,v in pairs(workspace.Items:GetChildren()) do
        if v:IsA("Tool") and v.Name == ItemsSelect then
            local tInfo = TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear)
            Char.Humanoid:ChangeState(11)
            game:service'TweenService':Create(Char.HumanoidRootPart, tInfo, {CFrame = v.Handle.CFrame + Vector3.new(0, 1, 0)}):Play()
            wait(v.Handle.Position + Vector3.new(0, 1, 0) / tweenSpeed)
        end
    end
end, {text = "Teleport"})

-- Teleport All Item Checkbox --
local tpallitems = s1:Cheat("Checkbox", "Tp All Items", function(state)
    local Char = LocalP.Character
    TpAllItem = state
    while TpAllItem do
        for i,v in pairs(workspace.Items:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChildOfClass("MeshPart") then
                local tInfo = TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                local Tween = game:service'TweenService':Create(Char.HumanoidRootPart, tInfo, {CFrame = v.Handle.CFrame})
                Tween:Play()
                Tween.Completed:Wait(LocalP:DistanceFromCharacter(v.Handle.Position))
            end
        end
    end
end)

-- Collect Money Checkbox --
local collectmoney = s1:Cheat("Checkbox", "Collect Money", function(state)
    local Char = LocalP.Character
    CollectMoney = state
    while CollectMoney and wait() do
        if Char and Char:FindFirstChildOfClass("Tool") then
            local tool = Char:FindFirstChildOfClass("Tool")
            if tool.Name == "Money" and tool.Equipped then
                tool:Activate()
            end
        elseif LocalP:FindFirstChild("Backpack"):FindFirstChild("Money") then
            local tool = LocalP:WaitForChild("Backpack"):FindFirstChild(Money)
            LocalP.Character.Humanoid:EquipTool(tool)
            tool:Activate()
        end
    end
end)

-- AutoSellArrow Checkbox --
local asellarrow = s1:Cheat("Checkbox", "Auto-Sell Arrow", function(state)
    local Char = LocalP.Character
    SellArrow = state
    while SellArrow and wait(.1) do
        if LocalP:FindFirstChild("Backpack").ChildAdded and LocalP.Backpack:FindFirstChild("Arrow") then
            game:GetService("ReplicatedStorage").newremotes.SellItem:FireServer("Arrow")
        end
    end
end)

-- AutoSellRokaka Checkbox --
local asellroka = s1:Cheat("Checkbox", "Auto-Sell Rokaka", function(state)
    local Char = LocalP.Character
    SellRoka = state
    while SellRoka and wait(.1) do
        if LocalP:FindFirstChild("Backpack").ChildAdded and LocalP.Backpack:FindFirstChild("Rokakaka Fruit") then
            game:GetService("ReplicatedStorage").newremotes.SellItem:FireServer("Rokakaka Fruit")
        end
    end
end)

-- AutoSellReqArrow Checkbox --
local asellreqarrow = s1:Cheat("Checkbox", "Auto-Sell ReqArrow", function(state)
    local Char = LocalP.Character
    SellReqArrow = state
    while SellReqArrow and wait(.1) do
        if LocalP:FindFirstChild("Backpack").ChildAdded and LocalP.Backpack:FindFirstChild("Requiem Arrow") then
            game:GetService("ReplicatedStorage").newremotes.SellItem:FireServer("Requiem Arrow")
        end
    end
end)

-- Destroy Gui Button
local disabled = s2:Cheat("Button", "Destroy Gui", function()
    if game:service'CoreGui':FindFirstChild("FinityUI") then game:service'CoreGui':FindFirstChild("FinityUI"):Destroy() end
    return
end, {text = "Destroy Gui"})

--[[
    Sector 3 / Local Sector
]]

-- Walkspeed value slider --
local wsVal = s3:Cheat("Slider", "Walkspeed Value", function(Value)
	speedVal = Value
end, {min = 16, max = 200, suffix = ""})

-- Jumppower value slider --
local jpVal = s3:Cheat("Slider", "JumpPower Value", function(Value)
	jpValue = Value
end, {min = 16, max = 200, suffix = ""})

-- WalkSpeed Checkbox --
local ws = s3:Cheat("Checkbox", "Walkspeed", function(state)
    wSpeed = state
    if wSpeed then
        if speedVal == nil then speedVal = 30 end
        LocalP.Character.Humanoid.WalkSpeed = speedVal 
    else 
        LocalP.Character.Humanoid.WalkSpeed = 16  
    end
end)

-- JumpPower Checkbox --
local ws = s3:Cheat("Checkbox", "JumpPower", function(state)
    jPower = state
    if jPower then
        if jpValue == nil then jpValue = 30 end
        LocalP.Character.Humanoid.JumpPower = jpValue 
    else 
        LocalP.Character.Humanoid.JumpPower = 50 
    end
end)

-- Anti TS Checkbox --
local antits = s3:Cheat("Checkbox", "Anti-TS", function(state)
    AntiTS = state
    while AntiTS and wait() do
        if game:service'Lighting':FindFirstChild("TSing").Changed then
            game:service'Lighting':FindFirstChild("TSing").Value = false
        end
    end
end)

-- yeet
while true and wait() do
    if not game:service'CoreGui':FindFirstChild("FinityUI") then
        return
    end
end