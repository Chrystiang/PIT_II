return function(ScreenManager, ScreenGui: ScreenGui, Data: {})
    local ScrollingFrame = ScreenGui.ScrollingFrame
    
    for _, Child in ScrollingFrame:GetChildren() do
         if Child:IsA("UIComponent") then continue end
         Child:Destroy()
    end
 
    for Index, PurchaseData: {} in ScreenManager.Purchases do
         local FrameDraft = ScreenGui.FrameDraft:Clone()

         for CupcakeID: string, Amount: number in PurchaseData.Items do
            local CupcakeIconFrame: ImageLabel = FrameDraft.CupcakeIcon:Clone()
            CupcakeIconFrame.Image = Data.CupcakeList[tonumber(CupcakeID)].Icon
            CupcakeIconFrame.Amount.Text = "x"..Amount 
            CupcakeIconFrame.Visible = true
            CupcakeIconFrame.Parent = FrameDraft.Icons
         end

         FrameDraft.Price.Text = "R$"..PurchaseData.Total
         FrameDraft.Date.Text = DateTime.fromUnixTimestamp(PurchaseData.Date):FormatLocalTime("L", "pt-br")
         FrameDraft.Visible = true
         FrameDraft.Parent = ScrollingFrame
    end
 end