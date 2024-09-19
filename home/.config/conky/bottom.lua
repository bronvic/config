function conky_main(event)
    if event ~= nil and event.type == "button_up" then
        os.execute('alacritty --command btm --theme=gruvbox --hide_time --disable_click &')
    end
end
