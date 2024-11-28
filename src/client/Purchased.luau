return function(ScreenManager, ScreenGui: ScreenGui, Data: {})
    local Purchased = {
        Date = DateTime.now().UnixTimestamp,
        Total = ScreenManager:GetTotalPrice(),
        Items = ScreenManager.Cart,
        Review = 3
    }

    if next(Purchased.Items) then
        table.insert(ScreenManager.Purchases, 1, Purchased)
        ScreenManager.Cart = {}
    end

    ScreenGui.HomeButton.Activated:Once(function()
        ScreenManager:ShowScreen("Home")
    end)
 end
