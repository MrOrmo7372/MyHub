--#################################################################################################################################################################################################################################################################
--ALL LOCAL SYSTEM
--#################################################################################################################################################################################################################################################################
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--#################################################################################################################################################################################################################################################################
--ALL LOCAL EVENT CLIENT_TO_SERVER
--#################################################################################################################################################################################################################################################################
local Client_to_Server_File_Location = ReplicatedStorage:WaitForChild("endpoints"):WaitForChild("client_to_server")
	local Vote_Start = Client_to_Server_File_Location:WaitForChild("vote_start")
	local Spawn_Unit = Client_to_Server_File_Location:WaitForChild("spawn_unit")
	local upgrade_unit_ingame = Client_to_Server_File_Location:WaitForChild("upgrade_unit_ingame")
	local Set_Game_Finish_Vote = Client_to_Server_File_Location:WaitForChild("set_game_finished_vote")
	local use_active_attack = Client_to_Server_File_Location:WaitForChild("use_active_attack")
--#################################################################################################################################################################################################################################################################
--LOCAL PLAYER
--#################################################################################################################################################################################################################################################################
local Player = game.Players.LocalPlayer
--#################################################################################################################################################################################################################################################################
--LOCAL ANIME ADVENTURE ID
--#################################################################################################################################################################################################################################################################
local AA_ID = 8304191830
--#################################################################################################################################################################################################################################################################
--LOCAL PLAYER GUI
--#################################################################################################################################################################################################################################################################
local PlayerGui = Player:WaitForChild("PlayerGui")
	local ResultsUI = PlayerGui:WaitForChild("ResultsUI")
	local MoneyChange_POPUP_UI = PlayerGui:WaitForChild("spawn_units").Lives.Frame.Resource.Money
	local MoneyPlayerText = PlayerGui:WaitForChild("spawn_units").Lives.Frame.Resource.Money.text
--#################################################################################################################################################################################################################################################################
--ISOLATION USELESS STARTER MONEY GUI
--#################################################################################################################################################################################################################################################################
local Not_Target = {}
for _, RemoveTarget in ipairs(MoneyChange_POPUP_UI:GetChildren()) do
	table.insert(Not_Target, RemoveTarget)
end
--#################################################################################################################################################################################################################################################################
--CREATE CONFIG FOLDER PLAYER
--#################################################################################################################################################################################################################################################################
local FileName_User = "MrHub_" .. game.Players.LocalPlayer.Name .. "_User"
local MarcoFile = FileName_User .. "/" .. "Marco"
if not isfolder(MarcoFile) then
	makefolder(MarcoFile)
end
--#################################################################################################################################################################################################################################################################
--SCRIPT MENU AND CONFIG SCRIPT AND SOME MENU TABS
--#################################################################################################################################################################################################################################################################
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
	local Window = Rayfield:CreateWindow({
	Name = "Anime Adventure Script (v0.1.5)",
	Icon = "slack", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
	LoadingTitle = "Anime Adventure Script (v0.1.5)",
	LoadingSubtitle = "by MrHub",
	Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

	ConfigurationSaving = {
		Enabled = true,
		FolderName = FileName_User, -- Create a custom folder for your hub/game
		FileName = "AA_Config"
	},

	Discord = {
		Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
		Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
		RememberJoins = true -- Set this to false to make them join the discord every time they load it up
	},

	KeySystem = false, -- Set this to true to use our key system
	KeySettings = {
		Title = "Untitled",
		Subtitle = "Key System",
		Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
		FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
})

local AutoFarm = Window:CreateTab("Auto Farm", "apple")
local AutoPlay = Window:CreateTab("Auto Play+", "mouse")
local Marco = Window:CreateTab("Marco", "bot")
--#################################################################################################################################################################################################################################################################
--ALL LOCAL TOOGLE SCRIPT IN GAME
--#################################################################################################################################################################################################################################################################
local Auto_Start_Boolean = false
local Auto_Retry_Boolean = false
--#################################################################################################################################################################################################################################################################
--ALL FUNCTION
--#################################################################################################################################################################################################################################################################
function Auto_Start_Fucntion()
	local Auto_Start_Call = Vote_Start:InvokeServer()
end

function Auto_Retry_Function()
	task.wait(2)
	local Auto_Retry_Call = Set_Game_Finish_Vote:InvokeServer("replay")
end
--#################################################################################################################################################################################################################################################################
--ALL TOOGLE AND OTHER BUTTON IN SCRIPT MENU
--#################################################################################################################################################################################################################################################################
local Auto_Start_Toggle = AutoFarm:CreateToggle({
	Name = "Auto Start",
	CurrentValue = false,
	Flag = "Auto_Start", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Auto_Start_Value)
	--The function that takes place when the toggle is pressed
	--The variable (Value) is a boolean on whether the toggle is true or false
		Auto_Start_Boolean = Auto_Start_Value
		if Auto_Start_Boolean == true --[[OTHER/]] and game.PlaceId ~= AA_ID then
			Auto_Start_Fucntion()
		end
	end,
})

local Auto_Retry_Toggle = AutoFarm:CreateToggle({
	Name = "Auto Retry",
	CurrentValue = false,
	Flag = "Auto_Retry", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Auto_Retry_Value)
	--The function that takes place when the toggle is pressed
	--The variable (Value) is a boolean on whether the toggle is true or false
		Auto_Retry_Boolean = Auto_Retry_Value
		if Auto_Retry_Boolean == true --[[OTHER/]] and ResultsUI.Enabled == true then
			Auto_Retry_Function()
		end
	end,
})
--#################################################################################################################################################################################################################################################################
--LOAD SAVE CONFIG SCRIPT MENU
--#################################################################################################################################################################################################################################################################
Rayfield:LoadConfiguration()
--#################################################################################################################################################################################################################################################################
--SOME CONDITION ACTIVE FUNCTION
--#################################################################################################################################################################################################################################################################




























































































































































































































































































































































































































