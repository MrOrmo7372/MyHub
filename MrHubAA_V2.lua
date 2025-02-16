
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = game.Players.LocalPlayer
local AA_ID = 8304191830
local Not_Target = {}

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

for _, RemoveTarget in ipairs(MoneyChange_POPUP_UI:GetChildren()) do
   table.insert(Not_Target, RemoveTarget)
end

local FileName_User = "MrHub_" .. game.Players.LocalPlayer.Name .. "_User"
local MarcoFile = FileName_User .. "/" .. "Marco"
if not isfolder(MarcoFile) then
    makefolder(MarcoFile)
end

local Create_Player_Value = loadstring([[
    local Create_Player_Value = {}

    function Create_Player_Value.Create_Bool_Value(name)
        local Create_Bool_Value = Instance.new("BoolValue")
        Create_Bool_Value.Name = name
        Create_Bool_Value.Value = false
        Create_Bool_Value.Parent = Player
        return Create_Bool_Value
    end

    function Create_Player_Value.Create_Int_Value(name)
        local Create_Int_Value = Instance.new("BoolValue")
        Create_Int_Value.Name = name
        Create_Int_Value.Value = 0
        Create_Int_Value.Parent = Player
        return Create_Int_Value
    end
    
    return Create_Player_Value
]])() -- Chạy loadstring để tạo module

local Auto_Start_Player = Create_Player_Value.Create_Bool_Value("Auto_Start_Player")
local Auto_Retry_Player = Create_Player_Value.Create_Bool_Value("Auto_Retry_Player")
