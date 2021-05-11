--[[
 CNSR extention for VLC;
 Authors: EBT
--]]

local dlg2 = nil
stations = {
    { name = "Ophir the king", url = "http://somafm.com/startstream=groovesalad.pls" },
    { name = "Elder the lerner", url = "http://listen.di.fm/public3/chillout.pls" },
}

function descriptor()
    return { title = "cnsr" ;
             version = "0.1" ;
             author = "EBT" ;
             capabilities = {} }
	
end

-- Function triggered when the extension is activated
function activate()
	--1. this is new: 
	a = vlc.input.item():uri()
	i = string.find(a, ".[^.]*$")
	b = string.sub(a, 0, i)
	cnsr_name = b .. "cnsr"
	cnsr_file = io.open(cnsr_name,"r")
	--1. until here we dont know if it works!
	
	dlg2 = vlc.dialog("user options: select categories to censor")
	checkbox_1 = dlg2:add_check_box("violence",20,2,3,3)
	checkbox_2 = dlg2:add_check_box("verbal abuse",20,5,3,3)
	checkbox_3 = dlg2:add_check_box("nudity",20,8,3,3)
	checkbox_4 = dlg2:add_check_box("alcohol and drug consumption",20,11,3,3)
	button_apply = dlg2:add_button("apply categories to censor",click_play, 6, 10, 3, 3)
	--button_apply = dlg2:add_button(vlc.input.item():uri(),click_play, 6, 10, 3, 3)
    -- Add the radio stations
    -- for idx, details in ipairs(stations) do
        -- list:add_value(details.name, idx)
    -- end
    dlg2:show()
end

function click_play()
	type1= checkbox_1:get_checked()
	type2= checkbox_2:get_checked()
	type3= checkbox_3:get_checked()
	type4= checkbox_4:get_checked()
	close_dlg()
	if (type1==true) then
		local input = vlc.object.input()
		local current_time = vlc.var.get(input,"position")
		local duration = vlc.input.item():duration()
		vlc.var.set(input,"position",70/duration)
	end
	if (type2==true) then
		local input = vlc.object.input()
		local current_time = vlc.var.get(input,"position")
		local duration = vlc.input.item():duration()
		vlc.var.set(input,"position",700/duration)
	end
	if (type3==true) then
		local input = vlc.object.input()
		local current_time = vlc.var.get(input,"position")
		local duration = vlc.input.item():duration()
		vlc.var.set(input,"position",5000/duration)
	end
	if (type4==true) then
		local input = vlc.object.input()
		local current_time = vlc.var.get(input,"position")
		local duration = vlc.input.item():duration()
		vlc.var.set(input,"position",7000/duration)
	end
    
end

-- Function triggered when the extension is deactivated
function deactivate()
	if dlg2 then
		dlg2:hide()
	end
end

function close_dlg()
  if dlg2 ~= nil then 
    --~ dlg:delete() -- Throw an error
    dlg2:hide() 
  end
  
  dlg2 = nil
  collectgarbage() --~ !important	
end

function close()
    vlc.deactivate()
end