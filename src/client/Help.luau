return function(ScreenManager, ScreenGui: ScreenGui, Data: {})
    local TextBox:TextBox = ScreenGui.TextBox

    local function OnFocusLost(EnterPressed)
        local Text = TextBox.Text
        if Text == "" then return end

        if EnterPressed then
            local FrameDraft = ScreenGui.FrameDraft:Clone()
            FrameDraft.Title.Text = Text
            FrameDraft.Visible = true
            FrameDraft.Parent = ScreenGui.ScrollingFrame.CustomerFrame
            table.insert(ScreenManager.HelpMessages, Text)
            TextBox.Text = ""
        end
    end

    TextBox.FocusLost:Connect(OnFocusLost)
end