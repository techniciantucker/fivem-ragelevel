GUI = {}
Menu = {}

GUI.maxVisOptions = 22
GUI.titleText = {250, 250, 250, 250, 4}
GUI.titleRect = {0, 82, 165, 255}
GUI.optionText = {255, 255, 255, 255, 6}
GUI.optionRect = {40,40,40, 200}
GUI.scroller = {0, 128, 255, 255}

local menuX = 0.850
local selectPressed = false
local leftPressed = false
local rightPressed = false
currentOption = 1
local optionCount = 0

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

function GUI.Text(text, color, position, size, center)
	SetTextCentre(center)
	SetTextColour(color[1], color[2], color[3], color[4])
	SetTextFont(color[5])
	SetTextScale(size[1], size[2])
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(position[1], position[2])
end

function GUI.Rect(color, position, size)
	DrawRect(position[1], position[2], size[1], size[2], color[1], color[2], color[3], color[4])
end

function Menu.Title(title)
	GUI.Text(title, GUI.titleText, {menuX, 0.090}, {0.85, 0.85}, true)
	GUI.Rect(GUI.titleRect, {menuX, 0.1175}, {0.23, 0.085})
end

function Menu.Option(option, select)
	optionCount = optionCount + 1

	local thisOption = nil
	if(currentOption == optionCount) then
		thisOption = true
	else
		thisOption = false
	end

	if not select then
		if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
			GUI.Text(option, GUI.optionText, {menuX - 0.111, optionCount * 0.035 + 0.125},  {0.5, 0.5 }, false)
			GUI.Rect(GUI.optionRect, { menuX, optionCount * 0.035 + 0.1415 }, { 0.23, 0.035 })
			if(thisOption) then
				GUI.Rect(GUI.scroller, { menuX, optionCount * 0.035 + 0.1415 }, { 0.23, 0.035 })
			end
		elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
			GUI.Text(option, GUI.optionText, { menuX - 0.111, optionCount - (currentOption - GUI.maxVisOptions) * 0.035 + 0.125 }, { 0.5, 0.5 }, false);
			GUI.Rect(GUI.optionRect, { menuX, optionCount - (currentOption - GUI.maxVisOptions) * 0.035+0.1415 }, { 0.23, 0.035 });
			if(thisOption) then
				GUI.Rect(GUI.scroller, { menuX, optionCount - (currentOption - GUI.maxVisOptions) * 0.035 + 0.1415 }, { 0.23, 0.035 })
			end
		end
	else
		if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
			GUI.Text(option, {255, 255, 255, 255, 6}, {menuX, optionCount * 0.035 + 0.125},  {0.5, 0.5 }, true)
			GUI.Rect(GUI.optionRect, { menuX, optionCount * 0.035 + 0.1415 }, { 0.23, 0.035 })
			if(thisOption) then
				GUI.Text(option, {255, 255, 255, 255, 6}, {menuX, optionCount * 0.035 + 0.125},  {0.5, 0.5 }, true)
				GUI.Rect({0, 128, 255, 255}, { menuX, optionCount * 0.035 + 0.1415 }, { 0.23, 0.035 })
			end
		elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
			GUI.Text(option, {255, 255, 255, 255, 6}, { menuX, optionCount - (currentOption - GUI.maxVisOptions) * 0.035 + 0.125 }, { 0.5, 0.5 }, true);
			GUI.Rect(GUI.optionRect, { menuX, optionCount - (currentOption - GUI.maxVisOptions) * 0.035+0.1415 }, { 0.23, 0.035 });
			if(thisOption) then
				GUI.Rect(GUI.scroller, { menuX, optionCount - (currentOption - GUI.maxVisOptions) * 0.035 + 0.1415 }, { 0.23, 0.035 })
			end
		end
	end

	if (optionCount == currentOption and selectPressed) then
		return true
	end

	return false
end

function Menu.OptionData(option, text)
	Menu.Option(option, false)

	if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		GUI.Text(NumberFormat(text), GUI.optionText, { menuX + 0.085, optionCount * 0.035 + 0.125 }, { 0.5, 0.5 }, true)
	elseif(optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		GUI.Text(NumberFormat(text), GUI.optionText, { menuX + 0.085, optionCount - (currentOption - GUI.maxVisOptions) * 0.035 + 0.125 }, { 0.5, 0.5 }, true)
	end

	if (optionCount == currentOption and selectPressed) then
		return true
	end

	return false
end

function NumberFormat(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return "$"..formatted
end

function Menu.Bool(option, bool, cb)
	Menu.Option(option, false)

	if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		if(bool) then
			GUI.Text("~g~ON", GUI.optionText, { menuX + 0.068, optionCount * 0.035 + 0.125 }, { 0.5, 0.5 }, true)
		else
			GUI.Text("~r~OFF", GUI.optionText, { menuX + 0.068, optionCount * 0.035 + 0.125 }, { 0.5, 0.5 }, true)
		end
	elseif(optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		if(bool) then
			GUI.Text("~g~ON", GUI.optionText, { menuX + 0.068, optionCount - (currentOption - GUI.maxVisOptions) * 0.035 + 0.125 }, { 0.5, 0.5 }, true)
		else
			GUI.Text("~r~OFF", GUI.optionText, { menuX + 0.068, optionCount - (currentOption - GUI.maxVisOptions) * 0.035 + 0.125 }, { 0.5, 0.5 }, true)
		end
	end

	if (optionCount == currentOption and selectPressed) then
		cb(not bool)
		return true
	end

	return false
end

function Menu.Int(option, int, min, max, cb)
	Menu.Option(option, false);

	if (optionCount == currentOption) then
		if (leftPressed) then
			if(int > min) then int = int - 1 else int = max end-- : _int = max;
		end
		if (rightPressed) then
			if(int < max) then int = int + 1 else int = min end
		end
	end

	if (currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		GUI.Text(tostring(int), GUI.optionText, { menuX + 0.068, optionCount * 0.035 + 0.125 }, { 0.5, 0.5 }, true)
	elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		GUI.Text(tostring(int), GUI.optionText, { menuX + 0.068, optionCount - (currentOption - maxVisOptions) * 0.035 + 0.125 }, { 0.5, 0.5 }, true)
	end

	if (optionCount == currentOption and selectPressed) then cb(int) return true
	elseif (optionCount == currentOption and leftPressed) then cb(int) return true
	elseif (optionCount == currentOption and rightPressed) then cb(int) return true end

	return false
end

function Menu.StringArray(option, array, position, cb)

	Menu.Option(option, false);

	if (optionCount == currentOption) then
		local max = tablelength(array)
		local min = 1
		if (leftPressed) then
			if(position >= min) then position = position - 1 else position = max end
		end
		if (rightPressed) then
			if(position < max) then position = position + 1 else position = min end
		end
	end

	if (currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		GUI.Text(array[position], GUI.optionText, { menuX + 0.068, optionCount * 0.035 + 0.125 }, { 0.5, 0.5 }, true)
	elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		GUI.Text(array[position], GUI.optionText, { menuX + 0.068, optionCount - (currentOption - GUI.maxVisOptions) * 0.035 + 0.125 }, { 0.5, 0.5 }, true)
	end

	if (optionCount == currentOption and selectPressed) then cb(position) return true
	elseif (optionCount == currentOption and leftPressed) then cb(position) return true
	elseif (optionCount == currentOption and rightPressed) then cb(position) return true end

	return false
end

function Menu.updateSelection()
	selectPressed = false;
	leftPressed = false;
	rightPressed = false;

	if IsControlJustPressed(1, 173)  then
		if(currentOption < optionCount) then
			currentOption = currentOption + 1
		else
			currentOption = 1
		end
	elseif IsControlJustPressed(1, 172) then
		if(currentOption > 1) then
			currentOption = currentOption - 1
		else
			currentOption = optionCount
		end
	elseif IsControlJustPressed(1, 174) then
		leftPressed = true
	elseif IsControlJustPressed(1, 175) then
		rightPressed = true
	elseif IsControlJustPressed(1, 176)  then
		selectPressed = true
	end
	optionCount = 0
end
