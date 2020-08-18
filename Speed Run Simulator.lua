--[[
    To-do:
    - Unlock world
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
        wait(0.99)
        wait(0.99)
        wait(0.99)
        wait(0.88)
        wait(0.88)
        wait(0.55)
        for i = 1, 3000 do
            AddSpeed() 
        end
    end
end)

local Rebirth = FarmingTab:AddToggle("frebirth", "Auto-Rebirth", false, function(value)
    getgenv().rebirth = value
    while getgenv().rebirth and wait(0.4) do 
        wait(.2)
        if CurrentBar >= MaxBar or CurrentBar <= MaxBar then 
            Rebirth()
        end 
    end
end)

local Orbs = FarmingTab:AddToggle("forbs", "Auto-Orbs", false, function(value)
    getgenv().orbs = value
    while getgenv().orbs and wait(0.4) do 
        for _,orbs in pairs(workspace.OrbSpawns:GetChildren()) do
            if orbs:FindFirstChild("TouchInterest") and orbs.Name == "Orb" then
                wait(.3)
                orbs.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0) 
            end
        end
    end
end)

local Rings = FarmingTab:AddToggle("frings", "Auto-Rings", false, function(value)
    getgenv().rings = value
    while getgenv().rings and wait(0.4) do 
        for _,rings in pairs(workspace.OrbSpawns:GetChildren()) do
            if rings:FindFirstChild("TouchInterest") and rings.Name == "Ring" then
                wait(.3)
                rings.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0) 
            end
        end
    end
end)

local Race = FarmingTab:AddToggle("frace", "Auto-WinRace", false, function(value)
    getgenv().race = value
    while getgenv().race and wait(.7) do
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

--[[
local UnlockWorld = MiscTab:AddButton("funlockallworld", "Unlock All World", false, function()
    function Tp(...) Char.HumanoidRootPart.CFrame = ... end
    for i,v in pairs(workspace:GetDescendants()) do
        if v:FindFirstChild("TouchInterest") and v:FindFirstChild("Script") and v:FindFirstChildOfClass("PointLight") then
            while true do
                wait(.1)
                Char.Humanoid:ChangeState(11)
                Tp(v.CFrame)
            end
        end
    end
end)
]]--

-- Window2 --
local w2 = Initialize:AddTab(RandomCharacters(math.random(5, 5)))
local KeybindTab = w2:AddSection("Keybind", false)
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