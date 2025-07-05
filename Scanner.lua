local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
  Title = "Vulnerability Scanner",
  Icon = "bug-play",
  Author = "Developed by Moligrafi | Version 0.01",
  Size = UDim2.fromOffset(580, 400),
  Transparent = true,
  Theme = "Dark",
  User = {
    Enabled = true
  },
  SideBarWidth = 200,
  HasOutline = true,
})
Window:EditOpenButton({
  Title = "Vulnerability Scanner",
  Icon = "bug-play",
  CornerRadius = UDim.new(0,16),
  StrokeThickness = 2,
  Color = ColorSequence.new(Color3.fromRGB(255, 125, 0), Color3.fromRGB(255, 0, 69)),
  Draggable = true
})
Window:SetToggleKey(Enum.KeyCode.H)

-- Locals
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Scan = game:GetService("ReplicatedStorage")
}

-- Functions
local function ScanModules()
  local Scripts = {}
  
  for _, script in pairs(Settings.Scan:GetDescendants()) do
    if script:IsA("ModuleScript") then
      local sucess, result = pcall(require, script)
      if sucess and typeof(result) == "table" then
        local IsValid = false
        
        local test = pcall(function()
          local key = "__temp_test"
          result[key] = true
          result[key] = nil
        end)
        
        if test then IsValid = true end
        
        if IsValid then
          table.insert(Scripts, script)
        end
      end
    end
  end
  
  return Scripts
end

-- Tabs
local Tabs = {
  Game = Window:Tab({ Title = "Game", Icon = "gamepad-2"}),
  Admin = Window:Tab({ Title = "Admin", Icon = "square-terminal"}),
  Remote = Window:Tab({ Title = "Remotes", Icon = "circle-power"}),
  Explorer = Window:Tab({ Title = "Explorer", Icon = "book-open-text"}),
  Script = Window:Tab({ Title = "Script", Icon = "scroll-text"}),
}
Window:SelectTab(1)

--[[
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Simple-Spy-Mobile-Script-Restored-22732"))()
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Keyless-mobile-dex-17888"))()
loadstring(game:HttpGet("https://gist.githubusercontent.com/dannythehacker/1781582ab545302f2b34afc4ec53e811/raw/ee5324771f017073fc30e640323ac2a9b3bfc550/dark%2520dex%2520v4"))()
setclipboard("Game: " .. game.GameId .. " | Place: " .. game.PlaceId)
]]--

-- Game
Tabs.Game:Section({ Title = "IDs" })
Tabs.Game:Button({
  Title = "Copy Game & Place ID",
  Desc = "Copies the current Game and Place ID to your clipboard.",
  Callback = function()
    setclipboard("Game: " .. game.GameId .. " | Place: " .. game.PlaceId)
  end
})
Tabs.Game:Code({
  Title = "Code source",
  Code = [[
    setclipboard("Game: " .. game.GameId .. " | Place: " .. game.PlaceId)
  ]]
})

-- Remote
Tabs.Remote:Section({ Title = "Remote Events" })
Tabs.Remote:Button({
  Title = "Load Simple Spy",
  Desc = "Launches the Simple Spy tool to monitor remote event traffic.",
  Callback = function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Simple-Spy-Mobile-Script-Restored-22732"))()
  end
})
Tabs.Remote:Code({
  Title = "Example of how to use remote events",
  Code = [[
    local args = {
      [1] = {
        ["player"] = game.Players.SuperNoob, -- Attacked player
        ["damage"] = math.huge -- Changed to inf damage
      }
    } -- ↑ Example args
    
    game:GetService("ReplicatedStorage").Remotes.HitPlayet:FireServer(unpack[args])
    -- ↑ Fire the remote event with the selected args
  ]]
})

-- Explorer
Tabs.Explorer:Section({ Title = "Mobile" })
Tabs.Explorer:Button({
  Title = "Load DEX [ Mobile ]",
  Desc = "Executes dex explorer.",
  Callback = function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Keyless-mobile-dex-17888"))()
  end
})
Tabs.Explorer:Section({ Title = "Desktop" })
Tabs.Explorer:Button({
  Title = "Load DEX [ Desktop ]",
  Desc = "Executes dex explorer.",
  Callback = function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/dannythehacker/1781582ab545302f2b34afc4ec53e811/raw/ee5324771f017073fc30e640323ac2a9b3bfc550/dark%2520dex%2520v4"))()
  end
})

-- Script
Tabs.Script:Section({ Title = "Module Script" })
Tabs.Script:Dropdown({
  Title = "Scan where?",
  Values = { "ReplicatedStorage", "Backpack", "Character" },
  Value = "ReplicatedStorage",
  Callback = function(option)
    if option == "ReplicatedStorage" then
      Settings.Scan = game:GetService("ReplicatedStorage")
    elseif option == "Backpack" then
      Settings.Scan = eu.Backpack
    elseif option == "Character" then
      Settings.Scan = eu.Character
    end
  end
})
Tabs.Script:Button({
  Title = "Scan Module Scripts",
  Desc = "Scans module scripts returning tables and print then on console.",
  Callback = function()
    local result = ScanModules()
    
    if #result == 0 then
      WindUI:Notify({
        Title = "Nothing found!",
        Content = "No vulnerabilities found in " .. Settings.Scan:GetFullName() .. ".",
        Icon = "bug-off",
        Duration = 5
      })
    else
      for _, script in pairs(ScanModules()) do
        print(script:GetFullName())
      end
      WindUI:Notify({
        Title = "Scan complete!",
        Content = "Valid modules printed to console.",
        Icon = "check",
        Duration = 5
      })
    end
  end
})
Tabs.Script:Code({
  Title = "Example use of module scripts",
  Code = [[
    local module = require(game:GetService("ReplicatedStorage").Modules.GunModule)
    -- ↑ Path to the module script containing a table
    
    module.Gun.Cooldown = 0 -- Changes a value of the table
    module.Gun.MaxAmmo = math.huge -- Inf Ammo
  ]]
})
