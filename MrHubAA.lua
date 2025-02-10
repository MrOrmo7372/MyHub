--###############################################################################################################################################################################################################################################################-Load Local Info
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = game.Players.LocalPlayer

local AA_ID = 8304191830

local Client_to_Server_File_Location = ReplicatedStorage:WaitForChild("endpoints"):WaitForChild("client_to_server")
   local Vote_Start = Client_to_Server_File_Location:WaitForChild("vote_start")
   local Spawn_Unit = Client_to_Server_File_Location:WaitForChild("spawn_unit")
   local Set_Game_Finish_Vote = Client_to_Server_File_Location:WaitForChild("set_game_finished_vote")

local PlayerGui = Player:WaitForChild("PlayerGui")
   local ResultsUI = PlayerGui:WaitForChild("ResultsUI")

local FileName_User = "MrHub_" .. game.Players.LocalPlayer.Name .. "_User"
local MarcoFile = FileName_User .. "/" .. "Marco"
if not isfolder(MarcoFile) then
    makefolder(MarcoFile)
end
--###############################################################################################################################################################################################################################################################-End Local Info
--###############################################################################################################################################################################################################################################################-Load Install Setting Game Player
local Auto_Start_Player = Instance.new("BoolValue")
Auto_Start_Player.Name = "Auto_Start_Player"
Auto_Start_Player.Value = false
Auto_Start_Player.Parent = Player

local Auto_Retry_Player = Instance.new("BoolValue")
Auto_Retry_Player.Name = "Auto_Retry_Player"
Auto_Retry_Player.Value = false
Auto_Retry_Player.Parent = Player

local Auto_Start_Local = Player:WaitForChild("Auto_Start_Player")
local Auto_Retry_Local = Player:WaitForChild("Auto_Retry_Player")
--###############################################################################################################################################################################################################################################################-End Install Setting Game Player
--###############################################################################################################################################################################################################################################################-Load RayScript
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Anime Adventure Script (v0.2)",
   Icon = "slack", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Anime Adventure Script (v0.2)",
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
--###############################################################################################################################################################################################################################################################-End RayScript
--###############################################################################################################################################################################################################################################################-Load Menu
local AutoFarm = Window:CreateTab("Auto Farm", "apple")
local StillCheck = Window:CreateTab("Still Check", "badge-alert")
local Marco = Window:CreateTab("Marco", "bot")
--###############################################################################################################################################################################################################################################################-End Menu
--###############################################################################################################################################################################################################################################################-Load All Local Setting
local Auto_Start_Boolean = false
local Auto_Retry_Boolean = false
--###############################################################################################################################################################################################################################################################-End All Local Setting
--###############################################################################################################################################################################################################################################################-Load All Function
function Auto_Start_Fucntion()
   if Auto_Start_Local.Value == false then
      local Auto_Start_Call = Vote_Start:InvokeServer()
      Auto_Start_Local.Value = true
   end
end

function Auto_Retry_Function()
   local Auto_Retry_Call = Set_Game_Finish_Vote:InvokeServer("replay")
   Auto_Retry_Local = true
end
--###############################################################################################################################################################################################################################################################-End All Function
--###############################################################################################################################################################################################################################################################-Load All Menu
local Auto_Start_Toggle = AutoFarm:CreateToggle({
   Name = "Auto Start",
   CurrentValue = false,
   Flag = "Auto_Start", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Auto_Start_Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         Auto_Start_Boolean = Auto_Start_Value
         if Auto_Start_Boolean == true and game.PlaceId ~= AA_ID then
            Auto_Start_Fucntion()
         end
   end,
})

local Auto_Retry_Toggle = AutoFarm:CreateToggle({
   Name = "Auto Retry",
   CurrentValue = false,
   Flag = "Auto_Retry", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Auto_Retry_Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         Auto_Retry_Boolean = Auto_Retry_Value
         if Auto_Retry_Local == false and ResultsUI.Visible == true then
            Auto_Retry_Function()
         end
   end,
})
--###############################################################################################################################################################################################################################################################-End All Menu
--###############################################################################################################################################################################################################################################################-Load MARCO ZONE
local TargetEventNames = {"spawn_unit"}
local MARCO_TABLE = {}
local Curret_Marco = {}
local Record_Marco_BOOLEAN = true -- Giả sử biến này được điều khiển bởi GUI
local Steps = 1

-- Hàm chuyển đổi CFrame sang định dạng có thể serialize
local function serializeCFrame(cf)
    return {
        Position = {cf.X, cf.Y, cf.Z},
        Rotation = {
            cf.RightVector.X, cf.RightVector.Y, cf.RightVector.Z,
            cf.UpVector.X, cf.UpVector.Y, cf.UpVector.Z,
            cf.LookVector.X, cf.LookVector.Y, cf.LookVector.Z
        }
    }
end

-- Hàm lưu dữ liệu với kiểm tra trùng lặp
local function saveMacroData()
    if #MARCO_TABLE == 0 then return end
   
    local jsonData = HttpService:JSONEncode(MARCO_TABLE)
    local TARGET = MarcoFile .. "/" .. "unit_macro.json"
    writefile(TARGET, jsonData)
    print("Đã lưu macro vào unit_macro.json với", #MARCO_TABLE, "bước")
end

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
            if method == "InvokeServer" then
                if result == true then -- Giả định server trả về true khi thành công
                    Curret_Marco = {
                       Event_Type = remoteName,
                       Unit_Type = args[1],
                       CFrame = serializeCFrame(args[2]),
                    }
                    table.insert(MARCO_TABLE, Steps, Curret_Marco)
                    saveMacroData()
                    Steps += 1
                end
            else -- FireServer
                local unitData = {
                    Event_Type = remoteName,
                    Unit_Type = args[1],
                    CFrame = serializeCFrame(args[2]),
                }
                table.insert(MARCO_TABLE, unitData)
                print("Đã ghi lại đợt đặt Unit:", unitData.Unit_Type)
            end
        end

        return result
    end

    return oldNamecall(self, ...)
end

setreadonly(mt, true)

-- Ví dụ sử dụng:
-- saveMacroData() -- Gọi khi cần lưu dữ liệu
--###############################################################################################################################################################################################################################################################-End MARCO ZONE


Rayfield:LoadConfiguration()


--###############################################################################################################################################################################################################################################################-Load All Condition
if Auto_Start_Boolean == true and game.PlaceId ~= AA_ID then
   Auto_Start_Fucntion()
end

ResultsUI:GetPropertyChangedSignal("Enabled"):Connect(function()
   if Auto_Retry_Boolean == true and Auto_Retry_Local == false and game.PlaceId ~= AA_ID then
      Auto_Retry_Function()
   end
end)
--###############################################################################################################################################################################################################################################################-End All Condition

