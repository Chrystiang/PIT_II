return function(ScreenManager, ScreenGui: ScreenGui, Data: {})
    ScreenGui.MenuButton.Activated:Once(function()
        ScreenManager:ShowScreen("Menu")
    end)

    ScreenGui.HistoryButton.Activated:Once(function()
        ScreenManager:ShowScreen("History")
    end)
end