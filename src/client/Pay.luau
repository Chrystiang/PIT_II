return function(ScreenManager, ScreenGui: ScreenGui, Data: {})
    ScreenGui.Price.Text = "R$"..ScreenManager:GetTotalPrice()
    task.delay(math.random(10, 20), function()
        ScreenManager:ShowScreen("Purchased")
     end)
end