local Player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client_to_Server_File_Location = ReplicatedStorage:WaitForChild("endpoints"):WaitForChild("client_to_server")
	local Vote_Start = Client_to_Server_File_Location:WaitForChild("vote_start")
	local Spawn_Unit = Client_to_Server_File_Location:WaitForChild("spawn_unit")
	local upgrade_unit_ingame = Client_to_Server_File_Location:WaitForChild("upgrade_unit_ingame")
	local Set_Game_Finish_Vote = Client_to_Server_File_Location:WaitForChild("set_game_finished_vote")
	local use_active_attack = Client_to_Server_File_Location:WaitForChild("use_active_attack")

local PlayerGui = Player:WaitForChild("PlayerGui")
	local ResultsUI = PlayerGui:WaitForChild("ResultsUI")
	local MoneyChange_POPUP_UI = PlayerGui:WaitForChild("spawn_units").Lives.Frame.Resource.Money
	local MoneyPlayerText = PlayerGui:WaitForChild("spawn_units").Lives.Frame.Resource.Money.text
	local VoteStart = PlayerGui:WaitForChild("VoteStart")

local GameFinished = game.workspace:WaitForChild("_DATA").GameFinished

VoteStart:GetPropertyChangedSignal("Enabled"):Connect(function()
	print("call")
	local Auto_Replay_Call = Vote_Start:InvokeServer()
end)

GameFinished.Changed:Connect(function()
	local Auto_Retry_Call = Set_Game_Finish_Vote:InvokeServer("replay")
end)
--ResultsUI:GetPropertyChangedSignal("Enabled"):Connect(function()
	--local Auto_Retry_Call = Set_Game_Finish_Vote:InvokeServer("replay")
--end)
