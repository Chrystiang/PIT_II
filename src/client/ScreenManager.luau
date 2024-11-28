local PlayerGui     = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local Shared        = game:GetService("ReplicatedStorage").Shared
local CupcakeList   = require(Shared.CupcakeList)

--// UI
local Screens: ScreenGui    = PlayerGui:WaitForChild("Screens")
local Background: ScreenGui = PlayerGui:WaitForChild("Background")
local BackButton: GuiButton = Background.BackButton
local HelpButton: GuiButton = Background.HelpButton

local Module = {
    ScreenHistory = {},
    Cart = {},
    HelpMessages = {},
    Purchases = {
        {
            ["Date"] = 1732734209,
            ["Items"] =  {
               ["1"] = 2,
               ["2"] = 4
            },
            ["Total"] = 44,
            Review = 0,
         }
    },
    HiddenBackButtonScreens = {
        "Home",
        "Purchased",
        "Pay"
    }
}

Module.ShowScreen = function(self, ScreenName: string, Arguments: {}|number)
    for _, Screen: ScreenGui in Screens:GetChildren() do
        Screen.Enabled = Screen.Name == ScreenName
        if ScreenName == Screen.Name then
            if self.ScreenHistory[#self.ScreenHistory] ~= Screen then 
                table.insert(self.ScreenHistory, Screen)
            end

            local ScreenScript = require(script.Parent:FindFirstChild(Screen.Name))
            ScreenScript(self, Screen, {
                CupcakeList = CupcakeList,
                Arguments = Arguments,
            })
        end 
    end

    BackButton.Visible = not table.find(self.HiddenBackButtonScreens, ScreenName)
    HelpButton.Visible = ScreenName ~= "Help" and ScreenName ~= "Pay"
end

Module.GetTotalPrice = function(self): number
    local TotalPrice = 0
    for Index: string, Amount: number in self.Cart do
        TotalPrice += CupcakeList[tonumber(Index)].Price * Amount
    end

    return TotalPrice
end

Module.UpdateCart = function(self, CupcakeID, Amount)
    self.Cart[tostring(CupcakeID)] = Amount
    if Amount == 0 then
        self.Cart[tostring(CupcakeID)] = nil
    end
    
    Screens.Menu.BuyButton.TotalPrice.Text = "R$"..self:GetTotalPrice()
end

BackButton.Activated:Connect(function()
    local ScreenHistory = Module.ScreenHistory
    if #ScreenHistory <= 1 then return Module:ShowScreen("Home") end

    table.remove(ScreenHistory, #ScreenHistory)
    Module:ShowScreen(ScreenHistory[#ScreenHistory].Name)
end)

HelpButton.Activated:Connect(function()
    Module:ShowScreen("Help")
end)

return Module