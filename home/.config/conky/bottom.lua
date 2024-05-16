function conky_main(event)
    if conky_window == nil then
        return
    end

    if event ~= nil and event.type == "button_up" then
        os.execute('alacritty --command btm --color=gruvbox --hide_time --disable_click &')
    end
end
