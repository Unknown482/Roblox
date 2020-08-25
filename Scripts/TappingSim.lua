local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Unknown482/Roblox/master/UI/Unknown482_V5.lua", true))()
local Functions = require(game:GetService("Workspace").Lib.ClickGame.ClickGame)
local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local w = library:CreateWindow("Tapping Sim")
local Utilitys = w:Folder('Utilitys')
Utilitys:Toggle('Auto Tap', {flag = "Tap"})
Utilitys:Toggle('Auto Mega Tap', {flag = "MegaTap"})
local Upgrades = w:Folder('Upgrades')
Upgrades:Box('Rebirth Count', {flag = "RebirthCount";})
Upgrades:Toggle('Auto Rebirth', {flag = "Rebirth"})
local Pets = w:Folder('Pets')
Pets:Toggle('Auto Merge Pets', {flag = "AutoMerge"})
Pets:Toggle('Auto Equip Pets', {flag = "AutoEquip"})
Pets:Toggle("Max Secret Upgrade", {flag = "Secret"})
Pets:Toggle('Auto Open Eggs', {flag = "AutoOpen"})
local d = Pets:Dropdown("Pet Shops", {flag = "Shop"; list = game:GetService("Workspace").Lib.PetShops.PetShopSettings:GetChildren();})
function ConvertToNum(str)
    if not tonumber(str) then
        local nums = str:gsub('[^%-%d%.]', '')
        local char = string.lower(str:gsub('[%d%.]', ''))
        if char == 'k' then
            return tonumber(nums) * 1e3
        end
        if char == 'm' then
            return tonumber(nums) * 1e6
        end
        if char == 'b' then
            return tonumber(nums) * 1e9
        end
        if char == 't' then
            return tonumber(nums) * 1e12
        end
        if char == 'qa' then
            return tonumber(nums) * 1e15
        end
        if char == 'qi' then
            return tonumber(nums) * 1e18
        end
        if char == 'sx' then
            return tonumber(nums) * 1e21
        end
        if char == 'sp' then
            return tonumber(nums) * 1e24
        end
        if char == 'oc' then
            return tonumber(nums) * 1e27
        end
        if char == 'no' then
            return tonumber(nums) * 1e30
        end
        if char == 'dc' then
            return tonumber(nums) * 1e33
        end
        if char == 'ud' then
            return tonumber(nums) * 1e36
        end
        if char == 'dd' then
            return tonumber(nums) * 1e39
        end
        if char == 'td' then
            return tonumber(nums) * 1e42
        end
        if char == 'qad' then
            return tonumber(nums) * 1e45
        end
        if char == 'qid' then
            return tonumber(nums) * 1e48
        end
        if char == 'sxd' then
            return tonumber(nums) * 1e51
        end
        if char == 'spd' then
            return tonumber(nums) * 1e54
        end
        if char == 'ocd' then
            return tonumber(nums) * 1e57
        end
        if char == 'nod' then
            return tonumber(nums) * 1e60
        end
        if char == 'nod' then
            return tonumber(nums) * 1e63
        end
        if char == 'vg' then
            return tonumber(nums) * 1e66
        end
        if char == 'uvg' then
            return tonumber(nums) * 1e69
        end
        if char == 'dvg' then
            return tonumber(nums) * 1e72
        end
    else
        return tonumber(str)
    end
end
spawn(function()
    while wait() do
        if w.flags.Tap then
            ReplicatedStorage.PlayerClick:FireServer()
        end
    end
end)
spawn(function()
    while wait(0.5) do
        if w.flags.Rebirth then
            local CanAfford, val = Functions:CanAffordRebirthCost(ConvertToNum(w.flags.RebirthCount))
            if CanAfford then
                ReplicatedStorage.PlayerRebirth:FireServer(ConvertToNum(w.flags.RebirthCount))
            end
        end
    end
end)
spawn(function()
    while wait(0.5) do
        if w.flags.AutoMerge then
            ReplicatedStorage.MergeAllPets:InvokeServer()
        end
    end
end)
spawn(function()
    while wait(0.5) do
        if w.flags.AutoEquip then
            ReplicatedStorage.EquipBestPets:InvokeServer()
        end
    end
end)
spawn(function()
    while wait(0.5) do
        if w.flags.AutoOpen then
            ReplicatedStorage.PetStoreRoll:InvokeServer(w.flags.Shop, 3)
        end
    end
end)
spawn(function()
    while wait(10) do
        if w.flags.Secret then
            ReplicatedStorage.IngameStoreBuyProductMax:InvokeServer("Upgrades", "UpgradeSecretPet")
        end
    end
end)
spawn(function()
    while wait() do
        if w.flags.MegaTap then
             ReplicatedStorage.TapSplosion:InvokeServer()
			for i,v in pairs (game.Workspace:GetChildren()) do
				wait()
				if v:IsA("Model") and v.Name == "TapSplosion" then
					if v.PrimaryPart and Player.Character.PrimaryPart then
						local Old = Player.Character.PrimaryPart.CFrame
						v.PrimaryPart.CanCollide = false
						Player.Character.PrimaryPart.CFrame = v.PrimaryPart.CFrame
						wait(1)
						Player.Character.PrimaryPart.CFrame = Old
					end
				end
			end
        end
    end
end)
