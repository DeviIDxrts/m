local GunsTab = Window:CreateTab("Guns", nil)
local function manipulate(Name, Value, Weapon)
    if Weapon and Value and Name then
        setreadonly(require(game:GetService("Players").LocalPlayer.Character[Weapon].Setting["1"]), false)
        local setting = require(game:GetService("Players").LocalPlayer.Character[Weapon].Setting["1"])
        setting[Name] = Value
        setreadonly(require(game:GetService("Players").LocalPlayer.Character[Weapon].Setting["1"]), true)
    end
end
GunsTab:CreateButton({
    Name = "Infinite Ammo",
    Callback = function()
        local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("Setting") then
            local toolName = tool.Name
            manipulate("Ammo", math.huge, toolName)
            manipulate("AmmoPerMag", math.huge, toolName)
            manipulate("AmmoCost", 0, toolName)
            Rayfield:Notify({
                Title = "Infinite Ammo",
                Content = "Enabled!",
                Duration = 3.5,
                Image = 4483362458
            })
        end
    end
})
GunsTab:CreateButton({
    Name = "Fast Gun",
    Callback = function()
        local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
         if tool and tool:FindFirstChild("Setting") then
         local toolName = tool.Name
         manipulate("FireRate", 0.14, toolName)
         manipulate("BulletSpeed", 9e97, toolName) 
         Rayfield:Notify({Title="Rapid Fire", Content="Enabled!", Duration=3.5, Image=4483362458})
      end
   end
})
GunsTab:CreateButton({
   Name = "Auto Fire",
   Callback = function()
      local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
      if tool and tool:FindFirstChild("Setting") then
         local toolName = tool.Name
         manipulate("Auto", true, toolName)
         Rayfield:Notify({Title="Auto Fire", Content="Enabled!", Duration=3.5, Image=4483362458})
      end
   end
})
GunsTab:CreateButton({
   Name = "Fast Equip",
   Callback = function()
      local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
      if tool and tool:FindFirstChild("Setting") then
         local toolName = tool.Name
         manipulate("EquipTime", 0, toolName)
         Rayfield:Notify({Title="Instant Equip", Content="Enabled!", Duration=3.5, Image=4483362458})
      end
   end
})
