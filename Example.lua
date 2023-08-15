--> Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--> Overhead Object
local OverheadObject = ReplicatedStorage:WaitForChild("Overhead")

--> Gradients
local GradientsFolder = ReplicatedStorage:WaitForChild("Gradients")

--> Packages
local Packages = script:WaitForChild("Packages")
local Class = require(Packages:WaitForChild("class"))

--> Create Class
local Overhead = Class("Overhead")

--> Methods
function Overhead:__init(player)
	self.Overhead = OverheadObject:Clone()
	
	local Character = player.Character
	
	self.Overhead.Parent = Character
	self.Overhead.Adornee = Character:FindFirstChild("Head")
	
	local UsernameString = ""
	
	if player.Name == player.DisplayName then
		UsernameString = player.Name
	else
		UsernameString = string.format("%s(@%s)", player.DisplayName, player.Name)
	end
	
	self.Overhead.Main.Username.Text = UsernameString
	self.Overhead.Main.LevelUI.Label.Text = string.format("LEVEL: %s", tostring(player:GetAttribute("Level")))
end

function Overhead:ApplyGradient(player, GradientName)
	local Overhead = self.Overhead
	
	if GradientsFolder:FindFirstChild(GradientName) then
		local Gradient = GradientsFolder:FindFirstChild(GradientName):Clone()
		
		Gradient.Parent = Overhead.Main.Username
		Gradient:Clone().Parent = Overhead.Main.Rank
	end
end

function Overhead:UpdateStats(player)
	local Overhead = self.Overhead
	
	if (player:GetAttribute("SwordFight") == nil) or (player:GetAttribute("SwordFight") ~= nil and player:GetAttribute("SwordFight") == false) then
		Overhead.Main.LevelUI.Label.Text = string.format("LEVEL: %s", tostring(player:GetAttribute("Level")))
	elseif (player:GetAttribute("SwordFight") ~= nil and player:GetAttribute("SwordFight") == true) then
		Overhead.Main.LevelUI.Label.Text = string.format("KILLS: %s", tostring(player:GetAttribute("Kills")))
	end
end

--> Return Class
return Overhead
