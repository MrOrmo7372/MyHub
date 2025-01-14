local Vote_Start = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("vote_start")

local VoteTime = 0

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

------------------------------------------------------------all FlagsConfig
AutoStartGameCF = OrionLib.Flags["AutoStartGame_Toggle"]

if AutoStartGameCF then
  local savedValue = AutoStartGameCF.Value
  print("Loaded value for AutoStart:", savedValue)
end
---------------------------------------------------------------------------

local Window = OrionLib:MakeWindow({
    Name = "MrHub", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "MrHubConfig",
})

local Tab = Window:MakeTab({
  Name = "Farm",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false,
})

Tab:AddButton({
  Name = "AutoStart_IsTrueOrNot",
  Callback = function()
    print(AutoStartGameCF)
  end
})

Tab:AddToggle({
  Name = "AutoStart",
  Default = AutoStartGameCF or false,
  Save = true, -- Lưu giá trị vào file config
  Flag = "AutoStartGame_Toggle", -- Đặt flag cho toggle
  Callback = function(Value)
    AutoStartGameCF.Value = Value
    if AutoStartGameCF == true and VoteTime < 1 then
      VoteTime += 1
      -- Gọi hàm từ server
      local result = Vote_Start:InvokeServer()
    end
  end
})

-------------------------------------------------------------------------------------------------Load Config
if AutoStartGameCF then
  local savedValue = AutoStartGameCF.Value
  print("Loaded value for AutoStart:", savedValue)
end

if AutoStartGameCF == true then
  AutoStart:Set(true)
end
------------------------------------------------------------------------------------------------------------

OrionLib:Init()
