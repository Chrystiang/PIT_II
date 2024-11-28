return function(ScreenManager, ScreenGui: ScreenGui, Data: {})
    local Purchased = {
        Date = DateTime.now().UnixTimestamp,
        Total = ScreenManager:GetTotalPrice(),
        Items = ScreenManager.Cart,
        Review = 0
    }

    table.insert(ScreenManager.Purchases, 1, Purchased)
    ScreenManager.Cart = {}

    ScreenGui.HomeButton.Activated:Once(function()
        ScreenManager:ShowScreen("Home")
    end)
 end