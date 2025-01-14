local Vote_Start = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("vote_start")

local VoteTime = 0

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

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
    print(OrionLib.Flags["AutoStartGame_Toggle"])
  end
})

Tab:AddToggle({
  Name = "AutoStart",
  Default = OrionLib.Flags["AutoStartGame_Toggle"].value or false,
  Save = true, -- Lưu giá trị vào file config
  Flag = "AutoStartGame_Toggle", -- Đặt flag cho toggle
  Callback = function(Value)
    OrionLib.Flags["AutoStartGame_Toggle"].Value = Value
    if OrionLib.Flags["AutoStartGame_Toggle"].Value == true and VoteTime < 1 then
      VoteTime += 1
      -- Gọi hàm từ server
      local result = Vote_Start:InvokeServer()
    end
  end
})

-------------------------------------------------------------------------------------------------Load Config
if OrionLib.Flags["AutoStartGame_Toggle"] then
  local savedValue = OrionLib.Flags["AutoStartGame_Toggle"].Value
  print("Loaded value for AutoStart:", savedValue)
end

if OrionLib.Flags["AutoStartGame_Toggle"].Value == true then
  AutoStart:Set(true)
else
  AutoStart:Set(false)
end
------------------------------------------------------------------------------------------------------------

OrionLib:Init()
