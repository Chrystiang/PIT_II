return function(ScreenManager, ScreenGui: ScreenGui, Data: {})
     local ScrollingFrame = ScreenGui.ScrollingFrame
    
     for _, Child in ScrollingFrame:GetChildren() do
          if Child:IsA("UIComponent") then continue end
          Child:Destroy()
     end
 
     for Index, PurchaseData: {} in ScreenManager.Purchases do
          local FrameDraft = ScreenGui.FrameDraft:Clone()
          local TotalScore = PurchaseData.Review

          for CupcakeID: string, Amount: number in PurchaseData.Items do
               local CupcakeIconFrame: ImageLabel = FrameDraft.CupcakeIcon:Clone()
               CupcakeIconFrame.Image = Data.CupcakeList[tonumber(CupcakeID)].Icon
               CupcakeIconFrame.Amount.Text = "x"..Amount 
               CupcakeIconFrame.Visible = true
               CupcakeIconFrame.Parent = FrameDraft.Icons
          end

          for _, Star: GuiButton in FrameDraft.Stars:GetChildren() do
               if not Star:IsA("GuiButton") then continue end
               local Score = tonumber(Star.Name)

               Star.TextTransparency = Score > TotalScore and 0.75 or 0

               Star.Activated:Connect(function()
                    PurchaseData.Review = Score
                    for i = 1, 5 do
                         FrameDraft.Stars[i].TextTransparency = Score >= i and 0 or 0.75
                    end
               end)
          end

          FrameDraft.Price.Text = "R$"..PurchaseData.Total
          FrameDraft.Date.Text = DateTime.fromUnixTimestamp(PurchaseData.Date):FormatLocalTime("L", "pt-br")
          FrameDraft.Visible = true
          FrameDraft.Parent = ScrollingFrame
     end
end