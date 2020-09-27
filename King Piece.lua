--[[
    King Piece v1.0
    By Jexytd or QuadSquad (@v3rmillion)
]]

-- Destroy GUI already exist --
if game:service'CoreGui':FindFirstChild("FinityUI") then game:service'CoreGui':FindFirstChild("FinityUI"):Destroy() end

-- Send a notifications if player on the game --
if game.PlaceId == 4520749081 then
    game:service'StarterGui':SetCore("SendNotification", {
        Title = "Discord Server";
        Text = "> https://discord.gg/fGHVnPN <";
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

-- Local Variable --
local Players = game:service'Players'
local LocalP = Players.LocalPlayer

-- Global Variable --
Enabled = false
Disabled = false
TpDF = false
Distance = -12
SkillZ = false
SkillX = false
SkillC = false
SkillV = false
SkillB = false

-- NoClip --
Stepped = game:service'RunService'.RenderStepped:Connect(function()
    if Enabled then
        LocalP.Character.Humanoid:ChangeState(11)
    end
    if Disabled then
        Stepped:Disconnect()
    end
end)

-- FinityUI Lib --
local Finity = loadstring(game:HttpGet("https://pastebin.com/raw/KFBs02vs"))()
local FinityWindow = Finity.new(true, "Jexytd Hub") -- 'true' dark 'false' white
FinityWindow.ChangeToggleKey(Enum.KeyCode.Insert)

-- Categories --
local c1 = FinityWindow:Category("Main")
local c2 = FinityWindow:Category("Teleports")
local c999 = FinityWindow:Category("Credits")

-- Credits Sector --
local s1 = c999:Sector("Finity Library Creator")
local s2 = c999:Sector("Script Creator")

-- Credits --
s1:Cheat("Label", "detourious (v3rmillion)")
s1:Cheat("Label", "deto#7612 (discord)")
s2:Cheat("Label", "QuadSquad (v3rmillion)")
s2:Cheat("Label", "Jexytd#3339 (discord)")
s2:Cheat("Label", "Discord Server (discord.gg/fGHVnPN)")

-- Main Sector --
local s1 = c1:Sector("AutoFarm")
local s2 = c1:Sector("Misc")

-- Mobs Dropdown --
local mobs = s1:Cheat("Dropdown", "Mobs", function(SelectedOption)
    SelectedMob = SelectedOption
end, {options = {}, default = ""})

-- Remove value duplicated in table/array --
local function removeDuplicates(arr)
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
mobA = {}
for _,mob in pairs(game:service'ReplicatedStorage'["MOB"]:GetChildren()) do
    if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
        table.insert(mobA, mob.Name)
    end
end

mobB = removeDuplicates(mobA)
for i = 1, #mobB do
    mobs:AddOption(mobB[i])
end

-- Tool's Dropdown --
local weapon = s1:Cheat("Dropdown", "Weapon", function(SelectedOption)
    SelectedWeapon = SelectedOption
end, {options = {}, default = ""})
for i,v in ipairs(LocalP.Backpack:GetChildren()) do
    if v:IsA("Tool") then
        weapon:AddOption(v.Name)
    end
end
for i2,v2 in pairs(LocalP.Character:GetChildren()) do
    if v2:IsA("Tool") then
        weapon:AddOption(v2.Name)
    end
end

-- Distance Textbox --
local distances = s1:Cheat("Textbox", "Distance", function(value)
    valDist = value
end, {placeholder = "Distance"})

-- Enabled Checkbox --
local enabled = s1:Cheat("Checkbox", "Enabled", function(state)
    Enabled = state
    while Enabled do
        if Enabled and not Disabled then
            for i,v in pairs(game:service'ReplicatedStorage'["MOB"]:GetChildren()) do
                if Enabled and not Disabled and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == SelectedMob then
                     if Enabled and not Disabled then
                        repeat
                            pcall(function()
                                LocalP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, Distance, 0)
                            end)
                            wait()
                            pcall(function()
                                if LocalP:FindFirstChild("Backpack"):FindFirstChild(SelectedWeapon) then
                                    local tool = LocalP:WaitForChild("Backpack"):FindFirstChild(SelectedWeapon)
                                    wait(.4)
                                    LocalP.Character.Humanoid:EquipTool(tool)
                                end
                                if LocalP.Character:FindFirstChildOfClass("Tool").Equipped then
                                    local tool = LocalP.Character:FindFirstChildOfClass("Tool")
                                    if tool:FindFirstChildOfClass("RemoteEvent") then
                                        for _,event in pairs(tool:GetChildren()) do
                                            if event:IsA("RemoteEvent") then
                                                if SkillZ and event.Name == "Z" then
                                                    wait(1)
                                                    event:FireServer(v.HumanoidRootPart.Position, false)
                                                    event:FireServer(v.HumanoidRootPart.Position, true)
                                                end
                                                if SkillX and event.Name == "X" then
                                                    wait(1)
                                                    event:FireServer(v.HumanoidRootPart.Position)
                                                end
                                                if SkillC and event.Name == "C" then
                                                    wait(1)
                                                    event:FireServer(v.HumanoidRootPart.Position, false)
                                                    event:FireServer(v.HumanoidRootPart.Position, true)
                                                end
                                                if SkillV and event.Name == "V" then
                                                    wait(1)
                                                    event:FireServer(LocalP.Character.HumanoidRootPart.Position)
                                                end
                                                if SkillB and event.Name == "B" then
                                                    wait(1)
                                                    event:FireServer(LocalP.Character.HumanoidRootPart.Position)
                                                end
                                            end
                                        end
                                    end
                                end
                            end)
                        until Disabled or not Enabled or not v.Parent or v.Humanoid.Health <= 0
                    end
                end
            end
        end
    end
end)

-- AutoSkillZ Checkbox --
local z = s1:Cheat("Checkbox", "Z", function(state)
    SkillZ = state
end)

-- AutoSkillX Checkbox --
local x = s1:Cheat("Checkbox", "X", function(state)
    SkillX = state
end)

-- AutoSkillC Checkbox --
local c = s1:Cheat("Checkbox", "C", function(state)
    SkillC = state
end)

-- AutoSkillV Checkbox --
local v = s1:Cheat("Checkbox", "V", function(state)
    SkillV = state
end)

-- AutoSkillB Checkbox --
local b = s1:Cheat("Checkbox", "B", function(state)
    SkillB = state
end)

-- Devil Fruit TP --
local tpdf = s2:Cheat("Checkbox", "TP Devil Fruit", function(state)
    TpDF = state
    while TPDF and wait() do
        --if workspace:FindFirstChildOfClass("Tool").ChildAdded then
        for i,v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool") then
                local toolPart = v.Handle.CFrame
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = toolPart + Vector3.new(0, 1, 0)
            end
        end
        --end
    end
end)

-- Destroy Gui Button
local disabled = s2:Cheat("Button", "Destroy Gui", function()
    Disabled = true
    Enabled = false
    if Disabled then
        if game:service'CoreGui':FindFirstChild("FinityUI") then game:service'CoreGui':FindFirstChild("FinityUI"):Destroy() end
        return
    end
end, {text = "Destroy Gui"})

-- Teleports Sector --
local s1 = c2:Sector("Spawnpoint")
local s2 = c2:Sector("Other")

-- Spawn Dropdown --
local spawns = s1:Cheat("Dropdown", "Spawn", function(currentOption)
    reeSpawnpoint = currentOption
end, {options = {}, default = ""})
for _,part in pairs(workspace:GetChildren()) do
    if part:IsA("Part") and part.CanCollide == false and string.find(part.Name, "Spawn%d") then
        spawns:AddOption(part.Name)
    end
end

-- Other Dropdown --
local others = s2:Cheat("Dropdown", "Other", function(currentOption)
    reeOthers = currentOption
end, {options = {"DF Shop 1", "Katana", "Soru", "Gear 4", "Bisento", "Shark Blade", "Half Robot", "Buso Haki", "Pipe", "DF Shop 2", "Ken Haki", "Remove Fruit"}, default = ""}) 

-- Teleport Button --
local tpspawn = s1:Cheat("Button", "Teleport", function()
    for _,part in pairs(workspace:GetChildren()) do
        if part:IsA("Part") and part.Name == reeSpawnpoint then
            LocalP.Character.Humanoid:ChangeState(11)
            LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 2, 0)
        end
    end
end, {text = "Teleport"})

-- Teleport Button --
local tpothers = s2:Cheat("Button", "Teleport", function()
    if reeOthers == "DF Shop 1" then
        local Spawnpoints = "Spawn1"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "DFruitShop" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    elseif reeOthers == "Katana" then
        local Spawnpoints = "Spawn1"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "SwordShop" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    elseif reeOthers == "Soru" then
        local Spawnpoints = "Spawn3"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "SoruShop" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    elseif reeOthers == "Gear 4" then
        local Spawnpoints = "Spawn4"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "ShopGear4" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    elseif reeOthers == "Bisento" then
        local Spawnpoints = "Spawn5"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "SwordShop" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    elseif reeOthers == "Shark Blade" then
        local Spawnpoints = "Spawn6"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "SwordShop" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    elseif reeOthers == "Half Robot" then
        local Spawnpoints = "Spawn6"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "CyborgShop" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    elseif reeOthers == "Buso Haki" then
        local Spawnpoints = "Spawn8"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "BusoShop" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    elseif reeOthers == "Pipe" then
        local Spawnpoints = "Spawn8"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "SwordShop" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    elseif reeOthers == "DF Shop 2" then
        local Spawnpoints = "Spawn8"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "DFruitShop" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    elseif reeOthers == "Ken Haki" then
        local Spawnpoints = "Spawn9"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "KenShop" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    elseif reeOthers == "Remove Fruit" then
        local Spawnpoints = "Spawn9"
        for _,part in pairs(workspace:GetChildren()) do
            if part:IsA("Part") and part.Name == Spawnpoints then
                LocalP.Character.Humanoid:ChangeState(11)
                LocalP.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 0, 3)
                wait(.6)
                for i2,v2 in pairs(workspace.AntiTPNPC:GetChildren()) do
                    if v2:IsA("Model") and v2:FindFirstChild("HumanoidRootPart") and v2.Name == "ShopRemoveFruit" then
                        local root = v2.HumanoidRootPart.CFrame
                        LocalP.Character.Humanoid:ChangeState(11)
                        LocalP.Character.HumanoidRootPart.CFrame = root + Vector3.new(0, 0, 3)
                    end
                end
            end
        end
    end
end, {text = "Teleport"})

-- Remove sea water damage & Remove effects game like Dash, Skill Effect, etc --
while true and wait() do
    if LocalP.Backpack:FindFirstChild("SwimScript") then
        LocalP.Backpack:FindFirstChild("SwimScript"):Destroy()
    end
    if workspace.Effects.ChildAdded then
        for i,v in pairs(workspace.Effects:GetChildren()) do
            v:Destroy()
        end
    end
    if valDist == nil or valDist == "" then 
        valDist = Distance
    else 
        Distance = valDist
    end
end