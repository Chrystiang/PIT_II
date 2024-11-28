return function(ScreenManager, ScreenGui: ScreenGui, Data: {})
   local ScrollingFrame = ScreenGui.ScrollingFrame
   
   for _, Child in ScrollingFrame:GetChildren() do
        if Child:IsA("UIComponent") then continue end
        Child:Destroy()
   end

   for Index, CupcakeData: {} in Data.CupcakeList do
        local FrameDraft = ScreenGui.FrameDraft:Clone()
        FrameDraft.Icon.Image = CupcakeData.Icon
        FrameDraft.Title.Text = CupcakeData.Name
        FrameDraft.Frame.Price.Text = "R$"..CupcakeData.Price
        FrameDraft.Frame.Description.Text = CupcakeData.Description
        FrameDraft.Visible = true
        FrameDraft.Parent = ScrollingFrame

        local SelectedAmount = 0

        local Buttons = FrameDraft.Frame.ButtonsFrame
        local function UpdateItemAmount(Amount)
            SelectedAmount += Amount
            SelectedAmount = math.clamp(SelectedAmount, 0, math.huge)

            Buttons.Amount.Text = SelectedAmount
            
            ScreenManager:UpdateCart(Index, SelectedAmount)
        end

        Buttons.Increase.Activated:Connect(function()
            UpdateItemAmount(1)
        end)

        Buttons.Decrease.Activated:Connect(function()
            UpdateItemAmount(-1)
        end)
   end

    ScreenGui.BuyButton.Activated:Once(function()
        if ScreenManager:GetTotalPrice() <= 0 then return end
        ScreenManager:ShowScreen("Purchased")
    end)
end