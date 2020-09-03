--[[
    King Piece v1.0
    By Jexytd or QuadSquad (@v3rmillion)
]]

-- Destroy GUI already exist --
if game:service'CoreGui':FindFirstChild("FinityUI") then game:service'CoreGui':FindFirstChild("FinityUI"):Destroy() end

-- Global Variable --
Enabled = false
Disabled = false
sc = false
SkillZ = false
SkillX = false
SkillC = false
SkillV = false
SkillB = false

-- Local Variable --
local RunService = game:service'RunService'
local Players = game:service'Players'
local LocalP = Players.LocalPlayer
local Char = LocalP.Character

-- NoClip --
Stepped = RunService.RenderStepped:Connect(function()
    if Enabled then
        Char.Humanoid:ChangeState(11)
    end
    if Disabled then
        Stepped:Disconnect()
    end
end)

-- FinityUI Lib --
local Finity = loadstring(game:HttpGet("http://finity.vip/scripts/finity_lib.lua"))()
local FinityWindow = Finity.new(true) -- 'true' dark 'false' white
FinityWindow.ChangeToggleKey(Enum.KeyCode.Insert)

-- Categories --
local c1 = FinityWindow:Category("Main")
local c2 = FinityWindow:Category("Credits")

-- Credits Sector --
local s1 = c2:Sector("Finity Library Creator")
local s2 = c2:Sector("Script Creator")

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
for _,mob in pairs(game:service'ReplicatedStorage'["MOB"]:GetChildren()) do
    if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
        mobs:AddOption(mob.Name)
    end
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
for i2,v2 in pairs(Char:GetChildren()) do
    if v2:IsA("Tool") then
        weapon:AddOption(v2.Name)
    end
end

-- Enabled Checkbox --
local enabled = s1:Cheat("Checkbox", "Enabled", function(state)
    Enabled = state
    while Enabled do
        if Enabled and not Disabled then
            for i,v in pairs(game:service'ReplicatedStorage'["MOB"]:GetChildren()) do
                if Enabled and not Disabled and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                     if Enabled and not Disabled and v.Name == SelectedMob then
                        repeat
                            pcall(function()
                                Char.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, -12, 0)
                            end)
                            wait()
                            pcall(function()
                                if LocalP:FindFirstChild("SwimScript") then
                                    LocalP.Backpack:FindFirstChild("SwimScript"):Destroy()
                                end
                                if LocalP:FindFirstChild("Backpack"):FindFirstChild(SelectedWeapon) then
                                    local tool = LocalP:WaitForChild("Backpack"):FindFirstChild(SelectedWeapon)
                                    wait(.4)
                                    Char.Humanoid:EquipTool(tool)
                                end
                                if Char:FindFirstChildOfClass("Tool").Equipped then
                                    local tool = Char:FindFirstChildOfClass("Tool")
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
                                                    event:FireServer(Char.HumanoidRootPart.Position)
                                                end
                                                if SkillB and event.Name == "B" then
                                                    wait(1)
                                                    event:FireServer(Char.HumanoidRootPart.Position)
                                                end
                                            end
                                        end
                                    end
                                end
                            end)
                        until Disabled or not Enabled or not v.Parent or v.Humanoid.Health <= 0
                        if Char.Humanoid.Health < 59 then
                            Char.Humanoid:ChangeState(11)
                            Char.HumanoidRootPart.CFrame = CFrame.new(0, 2000, 0)
                        end
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
    if workspace:FindFirstChildOfClass("Tool") then
        for i,v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                if v.ClassName == "Part" then
                    Char.HumanoidRootPart.CFrame = v:FindFirstChildOfClass("Part").Position
                    game:service'StarterGui':SetCore('ChatMakeSystemMessage', {
                        Text = 'You just found a ' .. v.Parent .. '!';
                        Color = Color3.new(0, 255 / 255, 255 / 255); 
                        Font = Enum.Font.SourceSansBold;
                    })
                end
            end
        end
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