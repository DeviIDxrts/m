local ATMTab = Window:CreateTab("ATM", nil)
local player = game:GetService("Players").LocalPlayer
local amt = 0
local cashDisplay
cashDisplay = ATMTab:CreateParagraph({
    Title = "Bank",
    Content = "Loading..."
})
task.spawn(function()
    local bankData = player:WaitForChild("BankData", 5)
    if not bankData then
        cashDisplay:Set({ Title = "Bank", Content = "Bank: N/A" })
        return
    end

    local depositedValue = bankData:WaitForChild("DepositedValue", 5)
    if not depositedValue then
        cashDisplay:Set({ Title = "Bank", Content = "Bank: N/A" })
        return
    end
    depositedValue:GetPropertyChangedSignal("Value"):Connect(function()
        cashDisplay:Set({
            Title = "Bank",
            Content = "Cash: $" .. tostring(player.leaderstats.Cash.Value) .. " | Bank: $" .. tostring(depositedValue.Value)
        })
    end)

    cashDisplay:Set({
        Title = "Bank",
        Content = "Cash: $" .. tostring(player.leaderstats.Cash.Value) .. " | Bank: $" .. tostring(depositedValue.Value)
    })
end)
ATMTab:CreateInput({
    Name = "Cash Amount",
    PlaceholderText = "Enter amount",
    RemoveTextAfterFocusLost = false,
    Callback = function(v)
        amt = tonumber(v) or 0
        Rayfield:Notify({
            Title = "ATM",
            Content = "Amount set to " .. amt,
            Duration = 3.5,
            Image = 4483362458
        })
    end
})
ATMTab:CreateButton({
    Name = "Withdraw",
    Callback = function()
        if amt > 0 then
            game.ReplicatedStorage.ATMEvent:FireServer(amt, "withdraw")
            Rayfield:Notify({
                Title = "ATM",
                Content = "Withdrew " .. amt,
                Duration = 3.5,
                Image = 4483362458
            })
        end
    end
})
ATMTab:CreateButton({
    Name = "Deposit",
    Callback = function()
        if amt > 0 then
            game.ReplicatedStorage.ATMEvent:FireServer(amt, "deposit")
            Rayfield:Notify({
                Title = "ATM",
                Content = "Deposited " .. amt,
                Duration = 3.5,
                Image = 4483362458
            })
        end
    end
})
ATMTab:CreateButton({
    Name = "Deposit All (Safe)",
    Callback = function()
        local stats = player:WaitForChild("leaderstats"):WaitForChild("Cash")
        local startingCash = stats.Value
        local totalDeposited = 0
        local depositInProgress = false  
        if startingCash <= 0 then
            Rayfield:Notify({
                Title = "ATM",
                Content = "You have no cash to deposit.",
                Duration = 3.5,
                Image = 4483362458
            })
            return
        end
        local function depositLoop()
            if depositInProgress then
                return
            end
            depositInProgress = true  
            while true do
                local value = stats.Value
                if value <= 0 then
                    break
                end
                local depositAmount = math.min(1000, value)
                game.ReplicatedStorage.ATMEvent:FireServer(depositAmount, "deposit")
            
                totalDeposited = totalDeposited + depositAmount
                cashDisplay:Set({
                    Title = "Bank",
                    Content = "In Progress..."
                })
                wait(0.1) 
            end
            Rayfield:Notify({
                Title = "ATM",
                Content = "Deposited all: $" .. tostring(startingCash),
                Duration = 3.5,
                Image = 4483362458
            })

            depositInProgress = false  
        end
        depositLoop()
    end
})
