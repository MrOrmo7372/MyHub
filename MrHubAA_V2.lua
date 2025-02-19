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
--ALL FUNCTION AND IT LOCAL ATTACHED
--#################################################################################################################################################################################################################################################################
local Auto_Start_Boolean = false
local DB_AUTO_START = true
function Auto_Start_Fucntion()
	local Auto_Start_Call = Vote_Start:InvokeServer()
end

local Auto_Replay_Boolean = false
local DB_AUTO_REPLAY = true
function Auto_Replay_Function()
	task.wait()
	local Auto_Replay_Call = Set_Game_Finish_Vote:InvokeServer("replay")
end

local Record_Marco_BOOLEAN = false
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
		if Auto_Start_Boolean --[[OTHER/]] and DB_AUTO_START --[[FORCED/]] and game.PlaceId ~= AA_ID then
			Auto_Start_Fucntion()
			DB_AUTO_START = false
		end
	end,
})

local Auto_Retry_Toggle = AutoFarm:CreateToggle({
	Name = "Auto Retry",
	CurrentValue = false,
	Flag = "Auto_Retry", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Auto_Replay_Value)
	--The function that takes place when the toggle is pressed
	--The variable (Value) is a boolean on whether the toggle is true or false
		Auto_Replay_Boolean = Auto_Replay_Value
		if Auto_Replay_Boolean --[[OTHER/]] and DB_AUTO_REPLAY --[[FORCED/]] and ResultsUI.Enabled then
			Auto_Replay_Function()
			DB_AUTO_REPLAY = false
		end
	end,
})

local Start_Record = Marco:CreateToggle({
	Name = "Start Record",
	CurrentValue = false,
	Flag = "Start_Record", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Start_Record_Value)
	-- The function that takes place when the toggle is pressed
	-- The variable (Value) is a boolean on whether the toggle is true or false
		Record_Marco_BOOLEAN = Start_Record_Value
	end,
})
--#################################################################################################################################################################################################################################################################
--LOAD SAVE CONFIG SCRIPT MENU
--#################################################################################################################################################################################################################################################################
Rayfield:LoadConfiguration()
--#################################################################################################################################################################################################################################################################
--SOME CONDITION ACTIVE FUNCTION
--#################################################################################################################################################################################################################################################################
local MARCO_TABLE = {}

local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNamecall = mt.__namecall

mt.__namecall = function(self, ...)
	local method = getnamecallmethod()
	local args = {...}
	local remoteName = self.Name

	if table.find(TargetEventNames, remoteName) and (method == "FireServer" or method == "InvokeServer") then
		local success, result = pcall(oldNamecall, self, ...)
        
        -- Chỉ ghi lại khi request thành công và có đủ tiền
		if success then
			if Record_Marco_BOOLEAN == true then
				if method == "InvokeServer" and remoteName == "spawn_unit" then
					if result == true then -- Giả định server trả về true khi thành công
						MARCO_TABLE[NumberString(Steps)] = {
							Event_Type = remoteName,
							Money_Cost = 0,
							Unit_Type = args[1],
							Cframe = tostring(args[2]),
						}
						print("Remote Name Is: ", MARCO_TABLE[NumberString(Steps)].Event_Type)
						print("Unit Type Is: ", MARCO_TABLE[NumberString(Steps)].Unit_Type)
						print("CFrame Is: ", MARCO_TABLE[NumberString(Steps)].Cframe)
						print("How Many Table Now: ", #MARCO_TABLE)
						Steps += 1
					end
				elseif method == "InvokeServer" and remoteName == "upgrade_unit_ingame" then
					if result == true then -- Giả định server trả về true khi thành công
						MARCO_TABLE[NumberString(Steps)] = {
							Event_Type = remoteName,
							Money_Cost = 0,
							Cframe = tostring(args[1].HumanoidRootPart.CFrame),
						}
						print("Remote Name Is: ", MARCO_TABLE[NumberString(Steps)].Event_Type)
						print("CFrame Is: ", MARCO_TABLE[NumberString(Steps)].Cframe)
						Steps += 1
					end
				end
			end
		end
		return result
	end

	return oldNamecall(self, ...)
end

setreadonly(mt, true)

ResultsUI:GetPropertyChangedSignal("Enabled"):Connect(function()
	if Auto_Replay_Boolean --[[OTHER/]] and DB_AUTO_REPLAY --[[FORCED/]] and ResultsUI.Enabled then
		Auto_Replay_Function()
		DB_AUTO_REPLAY = false
	end
end)
























































































































































































































































































































































































































