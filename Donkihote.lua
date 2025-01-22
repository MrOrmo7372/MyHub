print("THIS IS THE START OF THE SCRIPT")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vote_Start = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("vote_start")
local Set_Game_Finish_Vote = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("set_game_finished_vote")
local Spawn_Unit = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("spawn_unit")

local MoneyChange_POPUP_UI = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("spawn_units").Lives.Frame.Resource.Money --/Money Change Frame (MoneyChange)

local MoneyPlayerText = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("spawn_units").Lives.Frame.Resource.Money.text
local ResultsUI = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ResultsUI")
local FileName_User = "MrHubConfig_" .. game.Players.LocalPlayer.Name .. "_User"

local CheckPOPUP = Instance.new("BoolValue")
CheckPOPUP.Name = "CheckPopUp"
CheckPOPUP.Value = false
CheckPOPUP.Parent = game.Players.LocalPlayer

local CheckPOPUP_Upgrade = Instance.new("BoolValue")
CheckPOPUP_Upgrade.Name = "CheckPopUp_Upgrade"
CheckPOPUP_Upgrade.Value = false
CheckPOPUP_Upgrade.Parent = game.Players.LocalPlayer

--------------------------------------------------------------------------------Info AA
--game.Players.LocalPlayer:WaitForChild("PlayerGui").spawn_units.lives.Frame.Units /unit = [number].Main.View.WorldModel.[name_unit]
---------------------------------------------------------------------------------------

local Unit_Table = {
   luffy_christmas
}

--local UnitsEquip_Player = game.Players.LocalPlayer:WaitForChild("PlayerGui").spawn_units.lives.Frame.Units

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MrHub AA V0.0059 Beta",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Waiting AA Script (MrHub V0.0059)",
   LoadingSubtitle = "by MrHub",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = FileName_User, -- Create a custom folder for your hub/game
      FileName = "MrHub"
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
local StillCheck = Window:CreateTab("Still Check", "badge-alert")
local FarmGems = Window:CreateTab("FarmGems", "book-dashed")
local MarcoZone = Window:CreateTab("Marco Zone", "gamepad-2")

local MarcoFolder = "MrHub_Marco"

local Fullpath = FileName_User .. "/" .. MarcoFolder
if not isfolder(Fullpath) then
    makefolder(Fullpath)
    print("Created folder:", Fullpath)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------ALL VALUE LOADING WORKING
local Auto_Start_L = false
local Auto_Retry_L = false

function StartGame()
   local auto_start = Vote_Start:InvokeServer()
end

function RetryGame()
   local auto_retry = Set_Game_Finish_Vote:InvokeServer("replay")
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------MARCO ZONE

-- Danh sách tên event cần theo dõi (bạn có thể thêm vào nếu cần)
local TargetEventNames = {
    "spawn_unit",
    "upgrade_unit_ingame"
}

local TABLE_EVENT_PLACE = {
   Event_Type = nil,
   Cost_Money = nil,
   Unit_Type = nil,
   CFramePosition = nil
}

local TABLE_EVENT_UPGRADE = {
   Event_Type = nil,
   Cost_Money = nil,
   Unit_Upgrade_CFrame = nil
}

local MARCO_TABLE = {}

local STEP = 1
local Record_Marco_BOOLEAN = false -- Đặt giá trị mặc định cho chế độ ghi macro

local DontCareMoney_POPUP = {}
for index, Gui in pairs(MoneyChange_POPUP_UI:GetChildren()) do
   if Gui.Name == "MoneyChange" and Gui:IsA("Frame") then
      table.insert(DontCareMoney_POPUP, Gui)
      print("DESTROY TARGET")
   end
end

function CheckTableMoney_POPUP(TableGuiMoney, Target)
   for index, GuiTable in pairs(TableGuiMoney) do
      if GuiTable == Target then
         return true
      end
   end
   return false
end

function CheckMoney_POPUP_GUI()
   for index, Gui in pairs(MoneyChange_POPUP_UI:GetChildren()) do
      if Gui:IsA("Frame") and Gui.Name == "MoneyChange" and not CheckTableMoney_POPUP(DontCareMoney_POPUP, Gui) then
         Gui:FindFirstChild("text").Text:GetPropertyChangedSignal("Visible"):Connect(function()
            local textObject = Gui:FindFirstChild("text")
            if textObject and textObject:IsA("TextLabel") then
               table.insert(DontCareMoney_POPUP, Gui)
               local GuiMoney = textObject.Text
               if tonumber(GuiMoney) < 0 then
                  return math.abs(tonumber(GuiMoney))
               end
            end
         end)
      end
   end
end



local RecordMarco_Button = MarcoZone:CreateToggle({
   Name = "Record Marco",
   CurrentValue = false,
   Flag = "Record_Marco",
   Callback = function(Value)
         Record_Marco_BOOLEAN = Value
   end,
})


local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = function(self, ...)
    local method = getnamecallmethod()

    if (method == "InvokeServer" or method == "FireServer") and Record_Marco_BOOLEAN == true then
        -- Kiểm tra nếu sự kiện nằm trong danh sách theo dõi
        if table.find(TargetEventNames, self.Name) then
            if self.Name == "spawn_unit" then
               print("Intercepted event:", self.Name)
               local args = {...}
               CheckPOPUP.Value = true
         
               -- Ghi nhận dữ liệu macro
               TABLE_EVENT_PLACE.Event_Type = self.Name
               --TABLE_EVENT_PLACE.Cost_Money = Money_Use
               TABLE_EVENT_PLACE.Unit_Type = args[1]
               TABLE_EVENT_PLACE.CFramePosition = args[2]

               table.insert(MARCO_TABLE, STEP, TABLE_EVENT_PLACE)
               STEP += 1

               -- Reset dữ liệu
               TABLE_EVENT_PLACE = {
                   Event_Type = nil,
                   Unit_Type = nil,
                   CFramePosition = nil
               }
            elseif self.Name == "upgrade_unit_ingame" then
               print("Upgrade unit:", self.Name)
               local args = {...}
               CheckPOPUP_Upgrade.Value = true

               local HumanoidRootPart_targetCFRAME = args[1].HumanoidRootPart.CFrame
               TABLE_EVENT_UPGRADE.Event_Type = self.Name
               --TABLE_EVENT_UPGRADE.Cost_Money = Money_Use
               TABLE_EVENT_UPGRADE.Unit_Upgrade_CFrame = HumanoidRootPart_targetCFRAME

               table.insert(MARCO_TABLE, STEP, TABLE_EVENT_UPGRADE)
               STEP += 1
            end
        end
    end

    -- Gọi phương thức gốc
    return oldNamecall(self, ...)
end

setreadonly(mt, true)

CheckPOPUP.Changed:Connect(function()
   if CheckPOPUP.Value == true then
      MoneyChange_POPUP_UI.ChildAdded:Wait()
      local Money = CheckMoney_POPUP_GUI()
      MARCO_TABLE[STEP - 1].Cost_Money = Money
      print(MARCO_TABLE[STEP - 1].Event_Type)
      print(MARCO_TABLE[STEP - 1].Cost_Money)
      print(MARCO_TABLE[STEP - 1].Unit_Type)
      print(MARCO_TABLE[STEP - 1].CFramePosition)
      CheckPOPUP.Value = false
   end
end)

CheckPOPUP_Upgrade.Changed:Connect(function()
   if CheckPOPUP_Upgrade.Value == true then
      MoneyChange_POPUP_UI.ChildAdded:Wait()
      local Money = CheckMoney_POPUP_GUI()
      MARCO_TABLE[STEP - 1].Cost_Money = Money
      print(MARCO_TABLE[STEP - 1].Event_Type)
      print(MARCO_TABLE[STEP - 1].Cost_Money)
      print(MARCO_TABLE[STEP - 1].Unit_Upgrade_CFrame)
      CheckPOPUP_Upgrade.Value = false
   end
end)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------AUTO FARM ZONE

local AutoStart = AutoFarm:CreateToggle({
   Name = "Auto Start",
   CurrentValue = false,
   Flag = "Auto_Start",
   Callback = function(Value)
         Auto_Start_L = Value
   end,
})

local AutoRetry = AutoFarm:CreateToggle({
   Name = "Auto Retry",
   CurrentValue = false,
   Flag = "Auto_Retry",
   Callback = function(Value)
         Auto_Retry_L = Value
   end,
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------------STILL CHECK ZONE

local PrintMoneyPlayer = StillCheck:CreateButton({
   Name = "Print Money Player",
   Callback = function()
   -- The function that takes place when the button is pressed
         if game.PlaceId ~= 8304191830 then
            print(MoneyPlayerText.Text)
         end
   end,
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------------FARM GEMS ZONE
local Sakura_FarmGems = false
local Allow_Place = true
local Sakura_Unit = 1

local Sakura_Table = {
   [1] = {"{27b582bb-e814-4847-a519-ed1d9062c748}", CFrame.new(-2967.56396, 33.7417984, -715.313049, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
   [2] = {"{27b582bb-e814-4847-a519-ed1d9062c748}", CFrame.new(-2967.56396, 33.7417984, -712.313049, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
   [3] = {"{27b582bb-e814-4847-a519-ed1d9062c748}", CFrame.new(-2967.56396, 33.7417984, -709.313049, 1, 0, 0, 0, 1, 0, 0, 0, 1)}
}

function Sakura_Farm()
   Allow_Place = false
   local Money = tonumber(MoneyPlayerText.Text)
   if Money >= 600 and Sakura_Unit < 4 then
      Spawn_Unit:InvokeServer(Sakura_Table[Sakura_Unit][1], Sakura_Table[Sakura_Unit][2])
      local Money = tonumber(MoneyPlayerText.Text)
      Sakura_Unit += 1
      task.wait(0.5)
      if Money >= 600 and Sakura_Unit < 4 then
         Spawn_Unit:InvokeServer(Sakura_Table[Sakura_Unit][1], Sakura_Table[Sakura_Unit][2])
         local Money = tonumber(MoneyPlayerText.Text)
         Sakura_Unit += 1
         task.wait(0.5)
         if Money >= 600 and Sakura_Unit < 4 then
            Spawn_Unit:InvokeServer(Sakura_Table[Sakura_Unit][1], Sakura_Table[Sakura_Unit][2])
            local Money = tonumber(MoneyPlayerText.Text)
            Sakura_Unit += 1
            task.wait(0.5)
         else
            Allow_Place = true
         end
      else
         Allow_Place = true
      end
   else
      Allow_Place = true
   end
end

local ToggleFarmGems = FarmGems:CreateToggle({
   Name = "Auto Farm Gems",
   CurrentValue = false,
   Flag = "Auto_Farm_Gems",
   Callback = function(Value)
         Sakura_FarmGems = Value
   end,
})

local Info_AutoFarmGems = FarmGems:CreateParagraph({
      Title = "How To Use This AutoFarm Gems", 
      Content = "Equip Sakura and Join INF Attack On Titan, Turn On AutoRetry And AutoStart, Enjoy!"
})

local DangerInfo_AutoFarmGems = FarmGems:CreateParagraph({
      Title = "ONLY TURN ON AUTOSTART, AUTORETRY AND AUTOFARMGEMS", 
      Content = ""
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Rayfield:LoadConfiguration()

if Auto_Start_L == true and game.PlaceId ~= 8304191830 then
   StartGame()
end

ResultsUI:GetPropertyChangedSignal("Enabled"):Connect(function()
   if Auto_Retry_L == true then
      RetryGame()
   end
end)

MoneyPlayerText:GetPropertyChangedSignal("Text"):Connect(function()
   if Sakura_FarmGems == true and Allow_Place == true and Sakura_Unit < 4 and game.PlaceId ~= 8304191830 then
      Sakura_Farm()
   end
end)
