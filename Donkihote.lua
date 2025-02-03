local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vote_Start = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("vote_start")
local Set_Game_Finish_Vote = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("set_game_finished_vote")
local Spawn_Unit = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("spawn_unit")

local MoneyChange_POPUP_UI = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("spawn_units").Lives.Frame.Resource.Money --/Money Change Frame (MoneyChange)

local MoneyPlayerText = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("spawn_units").Lives.Frame.Resource.Money.text
local ResultsUI = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ResultsUI")
local FileName_User = "MrHubConfig_" .. game.Players.LocalPlayer.Name .. "_User"

--------------------------------------------------------------------------------Info AA
--game.Players.LocalPlayer:WaitForChild("PlayerGui").spawn_units.lives.Frame.Units /unit = [number].Main.View.WorldModel.[name_unit]
---------------------------------------------------------------------------------------

--local UnitsEquip_Player = game.Players.LocalPlayer:WaitForChild("PlayerGui").spawn_units.lives.Frame.Units

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MrHub AA V0.0066 Beta",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Waiting AA Script (MrHub V0.0066)",
   LoadingSubtitle = "by MrHub",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
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

------------------------------------------------------------------------------------------------------------------------------------------------------------------------ALL VALUE LOADING WORKING
local Auto_Start_L = false
local Auto_Retry_L = false
local Remove_Lag = false
local BlackScreen = false

function StartGame()
   local auto_start = Vote_Start:InvokeServer()
end

function RetryGame()
   local auto_retry = Set_Game_Finish_Vote:InvokeServer("replay")
end

function RemoveLag()
   local Map = game.Workspace:WaitForChild("_map")
   if Map then
      Map:Destroy()
   end

   for _, obj in pairs(game.Lighting:GetChildren()) do
      obj:Destroy()
   end
   
   game.Lighting.Ambient = Color3.fromRGB(255, 255, 255) -- Giữ ánh sáng đơn giản
   game.Lighting.Brightness = 1
   game.Lighting.GlobalShadows = false
   game.Lighting.FogEnd = 1000000 -- Xóa sương mù nếu có

   -- Kiểm tra xem thư mục _Terrain có tồn tại không
   local terrainFolder = game.Workspace:WaitForChild("_terrain")
   if not terrainFolder then
      return
   end

   -- Duyệt tất cả Part và Model trong _Terrain
   for _, obj in pairs(terrainFolder:GetDescendants()) do
      if obj:IsA("Decal") or obj:IsA("Texture") then
         obj:Destroy() -- Xóa tất cả Texture & Decal
      elseif obj:IsA("Part") or obj:IsA("MeshPart") then
         obj.Material = Enum.Material.SmoothPlastic -- Đổi Material về vật liệu nhẹ nhất
      end
   end
end

function Black_Screen()
   game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
   game:GetService("RunService"):Set3dRenderingEnabled(false)
   
   local player = game.Players.LocalPlayer
   local gui = Instance.new("ScreenGui")
   gui.Parent = player:FindFirstChild("PlayerGui") or Instance.new("PlayerGui", player)
   
   -- Tạo Background đen
   local blackBackground = Instance.new("Frame")
   blackBackground.Size = UDim2.new(10, 0, 10, 0) -- Full màn hình
   blackBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Màu đen
   blackBackground.BorderSizePixel = 0
   blackBackground.Parent = gui

   -- Tạo Text hiển thị số Gems
   local gemsText = Instance.new("TextLabel")
   gemsText.Size = UDim2.new(0.3, 0, 0.1, 0) -- Kích thước
   gemsText.Position = UDim2.new(0.35, 0, 0.45, 0) -- Canh giữa màn hình
   gemsText.BackgroundTransparency = 1 -- Trong suốt
   gemsText.TextColor3 = Color3.fromRGB(255, 255, 255) -- Màu chữ trắng
   gemsText.TextScaled = true
   gemsText.Font = Enum.Font.SourceSansBold
   gemsText.Parent = gui

   gemsText.Text = game.Players.LocalPlayer:WaitForChild("_stats"):WaitForChild("gem_amount").Value
end

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

local Remove_LAG = AutoFarm:CreateToggle({
   Name = "Remove Lag",
   CurrentValue = false,
   Flag = "Remove_Lag",
   Callback = function(Value)
         Remove_Lag = Value
   end,
})

local Black_SCREEN = AutoFarm:CreateToggle({
   Name = "Black Screen",
   CurrentValue = false,
   Flag = "Black_Screen",
   Callback = function(Value)
         BlackScreen = Value
   end,
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------------STILL CHECK ZONE

--local PrintMoneyPlayer = StillCheck:CreateButton({
   --Name = "Print Money Player",
   --Callback = function()
   -- The function that takes place when the button is pressed
         --if game.PlaceId ~= 8304191830 then
            --print(MoneyPlayerText.Text)
         --end
   --end,
--})

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

if Remove_Lag == true and game.PlaceId ~= 8304191830 then
   RemoveLag()
end

if BlackScreen == true and game.PlaceId ~= 8304191830 then
   Black_Screen()
end

MoneyPlayerText:GetPropertyChangedSignal("Text"):Connect(function()
   if Sakura_FarmGems == true and Allow_Place == true and Sakura_Unit < 4 and game.PlaceId ~= 8304191830 then
      Sakura_Farm()
   end
end)
