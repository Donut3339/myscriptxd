--[[
    To-do:
    - Delete & Upgrade pet (after teleport thing)
]]

if game:GetService'CoreGui':FindFirstChild'SRSGui' then
    game:GetService'CoreGui'.SRSGui:Destroy();
end

local Library = loadstring(game:HttpGet("http://impulse-hub.xyz/library",true))()

local charset = {}
for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end
function RandomCharacters(length)
  if length > 0 then
    return RandomCharacters(length - 1) .. charset[math.random(1, #charset)]
  else
    return ""
  end
end

if game.PlaceId == 5293755937 then
    game:service'StarterGui':SetCore("SendNotification", {
        Title = RandomCharacters(math.random(5, 5));
        Text = "> GUI Loaded! <";
    })
else
    return
end

local Initialize = Library:Init(game:GetService("CoreGui"), "SRSGui")
-- Window 1 --

local w1 = Initialize:AddTab(RandomCharacters(math.random(5, 5)))
local FarmingTab = w1:AddSection("Farm", false)
local PetTab = w1:AddSection("Pets", false)
local MiscTab = w1:AddSection("Misc", false)

-- Window 1 --

-- Includes --
local RS = game:service'ReplicatedStorage';
local Players = game:service'Players';

local LocalP = Players.LocalPlayer
local Char = LocalP.Character
local Remotes = RS.Remotes

local BarText = string.split(LocalP.PlayerGui.MainUI.RebirthUI.UI.RebirthThing.Display.Text, "/")
local CurrentBar = tonumber(BarText[1])
local MaxBar = tonumber(BarText[2])

function AddSpeed() Remotes.AddSpeed:FireServer() end
function Rebirth() Remotes.Rebirth:FireServer() end

-- Includes --

local Speed = FarmingTab:AddToggle("fspeed", "Auto-Speed", false, function(value)
    getgenv().farmspeed = value
    while getgenv().farmspeed and wait(.0000000000001) do 
        repeat wait(.5)
            wait(.4)
            wait(.5)
            wait(.3)
            wait(.4)
            wait(.3)
            wait(.5)
            wait(.3)
            wait(.4)
            wait(.3)
            for i = 1, 2400 do
                AddSpeed() 
            end
        until getgenv().farmspeed == false
    end
end)

local Rebirth = FarmingTab:AddToggle("frebirth", "Auto-Rebirth", false, function(value)
    getgenv().rebirth = value
    while getgenv().rebirth and wait(.1) do 
        repeat wait(.2)
            if CurrentBar >= MaxBar or CurrentBar <= MaxBar then 
                Rebirth()
            end 
        until getgenv().rebirth == false
    end
end)

local Orbs = FarmingTab:AddToggle("forbs", "Auto-Orbs", false, function(value)
    getgenv().orbs = value
    while getgenv().orbs and wait(.1) do
        repeat
            for _,orbs in pairs(workspace.OrbSpawns:GetChildren()) do
                if orbs:FindFirstChild("TouchInterest") and orbs.Name == "Orb" then
                    wait(.3)
                    orbs.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0) 
                end
            end
        until getgenv().orbs == false
    end
end)

local Rings = FarmingTab:AddToggle("frings", "Auto-Rings", false, function(value)
    getgenv().rings = value
    while getgenv().rings and wait(.1) do
        repeat
            for _,rings in pairs(workspace.OrbSpawns:GetChildren()) do
                if rings:FindFirstChild("TouchInterest") and rings.Name == "Ring" then
                    wait(.3)
                    rings.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0) 
                end
            end
        until getgenv().rings == false
    end
end)

local Race = FarmingTab:AddToggle("frace", "Auto-WinRace", false, function(value)
    getgenv().race = value
    while getgenv().race and wait(.6) do
        repeat
            Remotes.RaceTrigger:FireServer()
            for i,v in pairs(workspace:GetChildren()) do
                if v:FindFirstChild("TouchInterest") then
                    if v.Name == "RaceEnd" then
                        pcall(function()
                            Char.Humanoid:ChangeState(11)
                        end)

                        pcall(function()
                            Char.HumanoidRootPart.CFrame = v.CFrame
                        end)
                    end
                end
            end
            Remotes.RaceResults:FireServer()
            wait(.2)
        until getgenv().race == false
    end
end)

pets = {}

for i,v in pairs(LocalP.PlayerGui.MainUI.PetUI.SelectionPanel.ScrollingFrame:GetChildren()) do
    if v:FindFirstChild("NamePetThing") then
        if v.NamePetThing.Text == "NAME" then
        else
            PetName = v.NamePetThing.Text
            table.insert(pets, PetName)
        end
    end
end 

local PetList = PetTab:AddScrolling("Pet", pets, "N/A", false, true, function(v)
    SelectedPet = v
    for i,v in pairs(LocalP.PlayerGui.MainUI.PetUI.SelectionPanel.ScrollingFrame:GetChildren()) do
        if v:FindFirstChild("NamePetThing") then
            if v.NamePetThing.Text == "NAME" then
            else
		        table.remove(pets)
                PetName = v.NamePetThing.Text
                table.insert(pets, PetName)
            end
        end
    end 
end)

local PetValue = PetTab:AddSlider("fpetvalue", "Pet Value", {min = 5, max = 100, def = 5}, function(value)
    if SelectedPet == nil then return end
    if value == nil then return 1 end
    PetValues = value
end)

local EquipPet = PetTab:AddButton("fpetequip", "Equip Pet", false, function()
    if SelectedPet == nil then return end
    if PetValues == nil then return end
    for i= 1, tonumber(PetValues) do
        wait(.1)
        Remotes.PetEquip:FireServer(SelectedPet)
    end
end)

local EquipAllPet = PetTab:AddButton("fequipallpet", "Equip All Pet", false, function()
    if PetValues == nil then return end
    for i= 1, tonumber(PetValues) do
        wait(.1)
        for i,v in pairs(LocalP.PlayerGui.MainUI.PetUI.SelectionPanel.ScrollingFrame:GetChildren()) do
            if v:FindFirstChild("NamePetThing") then
                if v.NamePetThing.Text == "NAME" then
                else
                    wait(.1)
                    Pets1 = v.NamePetThing.Text
                    Remotes.PetEquip:FireServer(Pets1)
                end
            end
        end
    end
end)


local UnequipPet = PetTab:AddButton("fpetunequip", "Unequip Pet", false, function()
    if SelectedPet == nil then return end
    if PetValues == nil then return end
    for i= 1, tonumber(PetValues) do
        wait(.1)
        Remotes.PetUnequip:FireServer(SelectedPet)
    end
end)

local UnequipAllPet = PetTab:AddButton("funequipallpet", "Unequip All Pet", false, function()
    if PetValues == nil then return end
    for i= 1, tonumber(PetValues) do
        wait(.1)
        for i,v in pairs(LocalP.PlayerGui.MainUI.PetUI.SelectionPanel.ScrollingFrame:GetChildren()) do
            if v:FindFirstChild("NamePetThing") then
                if v.NamePetThing.Text == "NAME" then
                else
                    wait(.1)
                    Pets2 = v.NamePetThing.Text
                    Remotes.PetUnequip:FireServer(Pets2)
                end
            end
        end
    end
end)

local InfStorage = MiscTab:AddButton("finfstorage", "Inf Pet Storage", false, function()
    LocalP.InvSpace.Value = 9e+18
end)

local InfEquip = MiscTab:AddButton("finfequip", "Inf Pet Equipped", false, function()
    LocalP.PetSlot.Value = 9e+18
end)

local UnlockWorld = MiscTab:AddButton("funlockallworld", "Unlock All World", false, function()
    for i,v in pairs(workspace:GetDescendants()) do
        if v:FindFirstChild("TouchInterest") then
            if v.ClassName == "MeshPart" or v.ClassName == "Part" or v.Name == "Spawn" or v.Name == "VIP" then
            else
                pcall(function()
                    Char.Humanoid:ChangeState(11)
                end)
    
                pcall(function()
                    wait(.1)
                    Char.HumanoidRootPart.CFrame = v.CFrame
                end)
            end
        end
    end
end)

-- Windows 2 --
local w2 = Initialize:AddTab(RandomCharacters(math.random(5, 5)))
local tpTab = w2:AddSection("Teleports", false)

worldListA = {}
eggListA = {}

for i,v in pairs(workspace.Teleports:GetChildren()) do
    if v.ClassName == "Part" or not v.ClassName == "SpawnLocation" then
        local getWorlds = v.Name
        table.insert(worldListA, getWorlds)
    end
end

for i2,v2 in pairs(workspace:GetDescendants()) do
    if v2.ClassName == "MeshPart" then
        if v2:FindFirstChild("BillboardGui") or v2.ClassName == "BillboardGui" then
            if v2.Name == "Meshes/Question Mark" then
            else
                if v2:FindFirstChild("Type") or v2.ClassName == "StringValue" then
                    local EggTypeName = v2.Type.Value
                    table.insert(eggListA, EggTypeName)
                end
            end
        end
    end
end

local TeleportWorlds = tpTab:AddDropdown("Worlds", worldListA, false, function(v)
    for i2,v2 in pairs(workspace.Teleports:GetChildren()) do
        if v2.ClassName == "Part" or not v2.ClassName == "SpawnLocation" then
            if v == worldListA[1] then
                if v2.Name == worldListA[1] then
                    pcall(function()
                        Char.Humanoid:ChangeState(11)
                    end)

                    pcall(function()
                        wait(.1)
                        Char.HumanoidRootPart.CFrame = v2.CFrame
                    end)
                end
            elseif v == worldListA[2] then
                if v2.Name == worldListA[2] then
                    pcall(function()
                        Char.Humanoid:ChangeState(11)
                    end)

                    pcall(function()
                        wait(.1)
                        Char.HumanoidRootPart.CFrame = v2.CFrame
                    end)
                end
            elseif v == worldListA[3] then
                if v2.Name == worldListA[3] then
                    pcall(function()
                        Char.Humanoid:ChangeState(11)
                    end)

                    pcall(function()
                        wait(.1)
                        Char.HumanoidRootPart.CFrame = v2.CFrame
                    end)
                end
            elseif v == worldListA[4] then
                if v2.Name == worldListA[4] then
                    pcall(function()
                        Char.Humanoid:ChangeState(11)
                    end)

                    pcall(function()
                        wait(.1)
                        Char.HumanoidRootPart.CFrame = v2.CFrame
                    end)
                end
            elseif v == worldListA[5] then
                if v2.Name == worldListA[5] then
                    pcall(function()
                        Char.Humanoid:ChangeState(11)
                    end)

                    pcall(function()
                        wait(.1)
                        Char.HumanoidRootPart.CFrame = v2.CFrame
                    end)
                end
            elseif v == worldListA[6] then
                if v2.Name == worldListA[6] then
                    pcall(function()
                        Char.Humanoid:ChangeState(11)
                    end)

                    pcall(function()
                        wait(.1)
                        Char.HumanoidRootPart.CFrame = v2.CFrame
                    end)
                end
            elseif v == worldListA[7] then
                if v2.Name == worldListA[7] then
                    pcall(function()
                        Char.Humanoid:ChangeState(11)
                    end)

                    pcall(function()
                        wait(.1)
                        Char.HumanoidRootPart.CFrame = v2.CFrame
                    end)
                end
            elseif v == worldListA[8] then
                if v2.Name == worldListA[8] then
                    pcall(function()
                        Char.Humanoid:ChangeState(11)
                    end)

                    pcall(function()
                        wait(.1)
                        Char.HumanoidRootPart.CFrame = v2.CFrame
                    end)
                end
            end
        end
    end
end)

local TeleportEggs = tpTab:AddDropdown("Eggs", eggListA, false, function(v)
    for i2,v2 in pairs(workspace:GetDescendants()) do
        if v2.ClassName == "MeshPart" then
            if v2:FindFirstChild("BillboardGui") or v2.ClassName == "BillboardGui" then
                if v2.Name == "Meshes/Question Mark" then
                else
                    if v2:FindFirstChild("Type") or v2.ClassName == "StringValue" then
                        if v == eggListA[1] then
                            if v2.Type.Value == eggListA[1] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        elseif v == eggListA[2] then
                            if v2.Type.Value == eggListA[2] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        elseif v == eggListA[3] then
                            if v2.Type.Value == eggListA[3] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        elseif v == eggListA[4] then
                            if v2.Type.Value == eggListA[4] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        elseif v == eggListA[5] then
                            if v2.Type.Value == eggListA[5] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        elseif v == eggListA[6] then
                            if v2.Type.Value == eggListA[6] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        elseif v == eggListA[7] then
                            if v2.Type.Value == eggListA[7] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        elseif v == eggListA[8] then
                            if v2.Type.Value == eggListA[8] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        elseif v == eggListA[9] then
                            if v2.Type.Value == eggListA[9] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        elseif v == eggListA[10] then
                            if v2.Type.Value == eggListA[10] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        elseif v == eggListA[11] then
                            if v2.Type.Value == eggListA[11] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        elseif v == eggListA[12] then
                            if v2.Type.Value == eggListA[12] then
                                pcall(function()
                                    Char.Humanoid:ChangeState(11)
                                end)

                                pcall(function()
                                    wait(.1)
                                    Char.HumanoidRootPart.CFrame = v2.CFrame
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- settings --
local settings = Initialize:AddTab(RandomCharacters(math.random(5, 5)))
local KeybindTab = settings:AddSection("Keybind", false)
local openClose = KeybindTab:AddTextLabel("fopenclose", "Open/Close : Insert", false)
local UIS = game:service"UserInputService"

UIS.InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.Insert then
        if game:service'CoreGui':FindFirstChild'SRSGui' then
            if game:service'CoreGui'.SRSGui.Enabled == true then
                game:service'CoreGui'.SRSGui.Enabled = false;
            elseif game:service'CoreGui'.SRSGui.Enabled == false then
                game:service'CoreGui'.SRSGui.Enabled = true;
            end
        end
    end
end)