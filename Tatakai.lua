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

spawn(function()
    while wait() do
        local Quest = game.Players.LocalPlayer.Character:FindFirstChild("Quest")
        if Quest then
            if Quest.Objective.Value then
                Quest:remove()
            end
        end
        if game.Players.LocalPlayer.Character:FindFirstChild("QuestCD") then
            game.Players.LocalPlayer.Character:FindFirstChild("QuestCD"):remove()
        end
    end
end)

-- Global Variable --
FMoney = false
FBag = false
Speed = 50
Bag = 1

-- Local Variable --
local Players = game:service'Players'
local LocalP = Players.LocalPlayer

local BankGui = LocalP.PlayerGui.MainGui:WaitForChild("Bank")
local Hunger = BankGui.Parent["Hunger"]["Clipping"]
local Ramen = game.Workspace.Items:FindFirstChild("Ramen")
local GloveShop = game:GetService("Workspace").Items.Gloves

-- FinityUI Lib --
local Finity = loadstring(game:HttpGet("https://pastebin.com/raw/KFBs02vs"))()
local FinityWindow = Finity.new(true, "Jexytd Hub") -- 'true' dark 'false' white
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

-- Teleport Speed Slider --
local tpspeed = s1:Cheat("Textbox", "Tp Speed", function(value)
	SpeedV = value
end, {placeholder = "Value"})

-- Teleport Distance Slider --
local tpdist = s1:Cheat("Dropdown", "Bags", function(option)
	Bag = tonumber(option)
end, {options = {"1", "2", "3", "4"}, default = "1"})

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

-- Punching Bags --
function GetGlove()
    for _,v in pairs(game.Workspace:GetChildren()) do
        if v.Name == "RightGloves" then
            if v:WaitForChild("WeldConstraint").Part0 == LocalP.Character:WaitForChild("Right Arm") then
                return v
            end
        end
    end
    return false
end

local Planked = false
function Plank()
    Body_Axis_Rotation = 100
    _=wait
    AnimationId="181525546"
    A=Instance.new("Animation")
    A.AnimationId="rbxassetid://"..AnimationId
    k=game:GetService("Workspace")[game:GetService("Players").LocalPlayer.Name]:FindFirstChild("Humanoid"):LoadAnimation(A)
    k:Play()
    k:AdjustSpeed(1.5)
    _(Body_Axis_Rotation*.010625)
    k:AdjustSpeed(0)
    pcall(function()
        for i,v in pairs(player.Character:GetDescendants()) do
            if v.ClassName == "Accessory" or v.Name == "Shirt" or v.Name == "Pants" or v:IsA("SpecialMesh") or v:IsA("Texture") or v:IsA("WeldConstraint") then
                v:Destroy()
            end
        end
    end)
    Planked = true
end

local fbag = s1:Cheat("Checkbox", "Auto Punching Bags", function(state)
    FBag = state
    while FBag do
        if FBag and not FBag == false then
            Glove = GetGlove()
            LocalP.Character.Humanoid:UnequipTools()
            if LocalP.Character and Glove then
                BagPart = game:GetService("Workspace")["Punching Bags"]:GetChildren()[Bag]["HumanoidRootPart"]
                Combat = LocalP.Backpack:FindFirstChild("Combat")
                if Hunger.AbsoluteSize.X < 25 then
                    local aTween = game:service'TweenService':Create(LocalP.Character.HumanoidRootPart, TweenInfo.new(LocalP:DistanceFromCharacter(Ramen.Position)/SpeedV, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = Ramen.CFrame})
                    aTween:Play()
                    wait(LocalP:DistanceFromCharacter(Ramen.Position)/SpeedV + 0)
                    while Hunger.AbsoluteSize.X < 200 do wait()
                        if not LocalP.Backpack:FindFirstChild("Ramen") then wait()
                            fireclickdetector(Ramen.ClickDetector)
                        end
                        if LocalP:FindFirstChild("Backpack") and LocalP.Backpack:FindFirstChild("Ramen") then wait()
                            LocalP.Character.Humanoid:EquipTool(LocalP.Backpack:FindFirstChild("Ramen"))
                        end
                        if LocalP.Character and LocalP.Character:FindFirstChild("Ramen") then wait()
                            LocalP.Character:FindFirstChild("Ramen"):Activate()
                        end
                    end
                end
                if Glove.Parent then
                    if (LocalP.Character.Humanoid.Health / (LocalP.character.Humanoid.MaxHealth / 100)) <= 25 then
                        while (LocalP.Character.Humanoid.Health / (LocalP.character.Humanoid.MaxHealth / 100)) <= 25 do
                            local aTween = game:service'TweenService':Create(LocalP.Character.HumanoidRootPart, TweenInfo.new(LocalP:DistanceFromCharacter(BagPart.Position + Vector3.new(0, -5, 0))/SpeedV, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = BagPart.CFrame + Vector3.new(0, -5, 0)})
                            aTween:Play()
                            wait(LocalP:DistanceFromCharacter(BagPart.Position + Vector3.new(0, -5, 0))/SpeedV + 0.1)
                        end
                    end
                    if LocalP:FindFirstChild("Backpack") and LocalP.Backpack:FindFirstChild("Combat") then
                        LocalP.Character.Humanoid:EquipTool(Combat)
                        local aTween = game:service'TweenService':Create(LocalP.Character.HumanoidRootPart, TweenInfo.new(LocalP:DistanceFromCharacter(BagPart.Position + Vector3.new(0, -3, 0))/SpeedV, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = BagPart.CFrame + Vector3.new(0, -3, 0)})
                        aTween:Play()
                        aTween.Completed:Wait(LocalP:DistanceFromCharacter(BagPart.Position + Vector3.new(0, -3, 0))/SpeedV)
                    end
                    if LocalP.Character and LocalP.Character:FindFirstChild("Combat") or Combat.Parent == LocalP.Character then
                        Combat:Activate()
                    end
                end
            else
                while not GetGlove() do wait()
                    local aTween = game:service'TweenService':Create(LocalP.Character.HumanoidRootPart, TweenInfo.new(LocalP:DistanceFromCharacter(GloveShop.Position + Vector3.new(0, -2, 0))/SpeedV, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = GloveShop.CFrame + Vector3.new(0, -2, 0)})
                    aTween:Play()
                    wait(LocalP:DistanceFromCharacter(GloveShop.Position + Vector3.new(0, -2, 0))/SpeedV + 0)
                    while not LocalP.Backpack:FindFirstChild("Gloves") do wait()
                        fireclickdetector(GloveShop.ClickDetector)
                    end
                    while LocalP.Backpack:FindFirstChild("Gloves") do wait()
                        LocalP.Character.Humanoid:EquipTool(LocalP.Backpack:FindFirstChild("Gloves"))
                    end
                    while not GetGlove() do wait()
                        LocalP.Character:FindFirstChild("Gloves"):Activate()
                    end
                end
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
    if not Planked then
        for i =1, 2 do
            Plank()
        end
    end
    -- Remove animation from character
    if LocalP.Character.Humanoid:FindFirstChild("Animator") then
        LocalP.Character.Humanoid:WaitForChild("Animator"):remove()
        LocalP.Character:WaitForChild("Animate").Disabled = true
    end

    if SpeedV == nil or SpeedV == "" then SpeedV = Speed else Speed = SpeedV end
    if not game:service'CoreGui':FindFirstChild("FinityUI") then return end
end