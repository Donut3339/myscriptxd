--[[
    Tatakai v1.0
    By Jexytd#3339 or QuadSquad (@v3rmillion)
]]

-- Destroy GUI already exist --
if game:service'CoreGui':FindFirstChild("FinityUI") then game:service'CoreGui':FindFirstChild("FinityUI"):Destroy() end

-- Send a notifications if player on the game --
if game.PlaceId == 5201039691 then
   game:service'StarterGui':SetCore("SendNotification", {
       Title = "Discord Server";
       Text = "> https://discord.gg/CAaejX3 <";
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

-- NoCollide some part --
local Parts = {"Map", "Test Items", "Others", "Items", "Quests", "Trainers"}

function NoCollide(_, Part)
    if Part:IsA("Part") or Part:IsA("MeshPart") or Part:IsA("UnionOperation") or Part:IsA("WedgePart") then
        Part.CanCollide = false    
    end
end

for _, Name in pairs(Parts) do
    table.foreach(game:GetService("Workspace")[Name]:GetDescendants(), NoCollide) 
end

-- Global Variable --
FMoney = false
Speed = 50

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
s2:Cheat("Label", "Discord Server (https://discord.gg/CAaejX3)")

--[[
    Category 1 / Main
]]

-- Main Sector --
local s1 = c1:Sector("Farming")
local s2 = c1:Sector("Misc")

-- TP Speed Textbox --
local tpSpeed = s1:Cheat("Textbox", "TP Speed", function(value)
    SpeedV = value
end, {placeholder = "Value"})

-- Farming Money --
function GetQuest()
    GQuest = true
    while GQuest do
        game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer()
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(tonumber(os.time() * 2), tostring(tonumber(os.time() * 2 * 3)), {[1] = "Quest"})
        if LocalP.Character:FindFirstChild("Quest") then
            local Quest = LocalP.Character.Quest.PlayerQuest
            Passed = true
            if Quest.Value:find("Poster") or Quest.Value:find("Delivery") then
                if Quest.Value:find("Poster") then
                    Quest.Parent.Objective.Value = Quest.Parent.Req.Value
                    Passed = false
                elseif Quest.Parent.Location.Value == 1 then
                    Quest.Parent.Objective.Value = true
                    Passed = false
                end
            end
            if Passed then
                GQuest = false
            else
                Quest.Parent:remove()
            end
        end
    end
    return game.Workspace.Quests.QuestLocations[LocalP.Character.Quest.PlayerQuest.Value][LocalP.Character.Quest.Location.Value]
end

local fMoney = s1:Cheat("CheckBox", "Money", function(state)
    FMoney = state
    while FMoney do
        if FMoney and not FMoney ~= true then
            local Target = GetQuest()
            if LocalP.Character and LocalP.Character:FindFirstChild("Quest") then
                local aTween = game:service'TweenService':Create(LocalP.Character.HumanoidRootPart, TweenInfo.new(LocalP:DistanceFromCharacter(Target.Position) / SpeedV, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = Target.CFrame})
                aTween:Play()
                wait(LocalP:DistanceFromCharacter(Target.Position)/SpeedV + 0)
                wait()
                firetouchinterest(LocalP.Character.HumanoidRootPart, Target, 0)
                firetouchinterest(LocalP.Character.HumanoidRootPart, Target, 1)
            end
        end
        wait()
    end
end)

--[[
    Sector 2 / Misc
]]

-- Destroy Gui Button
local disabled = s2:Cheat("Button", "Destroy Gui", function()
    if game:service'CoreGui':FindFirstChild("FinityUI") then game:service'CoreGui':FindFirstChild("FinityUI"):Destroy() end
    return
 end, {text = "Destroy Gui"})

-- Utilities --
while wait() do
    -- Remove animation from character
    if LocalP.Character.Humanoid:FindFirstChild("Animator") then
        LocalP.Character.Humanoid:WaitForChild("Animator"):remove()
        LocalP.Character:WaitForChild("Animate").Disabled = true
    end

    -- Remove Accessory, Shirt, Pants, etc --
    if LocalP.Character:FindFirstChildOfClass("Shirt") or LocalP.Character:FindFirstChildOfClass("Pants") then
        for i,v in pairs(game:service'Players'.LocalPlayer.Character:GetDescendants()) do
            if v.ClassName == "Accessory" or v.Name == "Shirt" or v.Name == "Pants" or v:IsA("SpecialMesh") or v:IsA("Texture") or v:IsA("WeldConstraint") then
                v:Destroy()
            end
        end
    end

    if SpeedV == nil or SpeedV == "" then SpeedV = Speed else Speed = SpeedV end
    if not game:service'CoreGui':FindFirstChild("FinityUI") then return end
end