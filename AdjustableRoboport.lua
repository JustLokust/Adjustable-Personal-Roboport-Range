--==================================
--                  Custom Functions
--==================================
function VisualizeRange(player)
	local armor = player.get_inventory(defines.inventory.character_armor)
    local equipment = armor[1].grid.equipment
    local area = 0
    local radius
    
    --Need to calculate construction radius. construction radius from player is not current
	for index = 1, table.maxn(equipment) do
        
        --Count the area of the construction range in tiles
        if equipment[index].name == "personal-roboport-equipment-R10" or
           equipment[index].name == "personal-roboport-mk2-equipment-R10" then
           area = area + 100
        end 
        
        --Count the area of the construction range in tiles
        if equipment[index].name == "personal-roboport-equipment-R20" or
           equipment[index].name == "personal-roboport-mk2-equipment-R20" then
           area = area + 400
        end 
        
        --Count the area of the construction range in tiles
        if  equipment[index].name == "personal-roboport-equipment" or
            equipment[index].name == "personal-roboport-mk2-equipment-R30" then
           area = area + 900
        end 
        
        --Count the area of the construction range in tiles
        if equipment[index].name == "personal-roboport-mk2-equipment" then
           area = area + 1600
        end 
    end
    
    radius = math.sqrt(area)
    
    --round the number up if greater than .5
    local whole, decimal = math.modf(radius)
    if decimal > 0.5 then 
        radius = math.ceil(radius) / 2
    else
        radius = whole / 2
    end
    
    --Only make new object if it hasn't already been created
    if global.RectangleObj == nil or not rendering.is_valid(global.RectangleObj) then
        
        global.RectangleObj = rendering.draw_rectangle({
                                                                          surface= player.surface,
                                                                          time_to_live=30,
                                                                          filled = true,
                                                                          draw_on_ground = true,
                                                                          color = {r=0.075,g=0.15,b=0,a=0.25},
                                                                          left_top = player.character, 
                                                                          left_top_offset = {-radius,-radius},
                                                                          right_bottom = player.character, 
                                                                          right_bottom_offset = {radius,radius} 
                                                                          })
    elseif rendering.is_valid(global.RectangleObj) then
        rendering.set_left_top(global.RectangleObj, player.character, {-radius,-radius})
        rendering.set_right_bottom(global.RectangleObj, player.character, {radius,radius})
        rendering.set_time_to_live(global.RectangleObj, 30)
    end
end

function GetTotalRange(equipmentGrid)
	local totalRange = false
	for index = 1, table.maxn(equipmentGrid.equipment) 
	do
		
		--Check equipment for roboport
		if (equipmentGrid.equipment[index].name == "personal-roboport-equipment") then
			--Add to robocount
			if (totalRange == false) then
				totalRange = 30
			else
				totalRange = totalRange + 30
			end
		end
		
		--Check equipment for roboport R10
		if (equipmentGrid.equipment[index].name == "personal-roboport-equipment-R10") then
			--Add to robocount
			if (totalRange == false) then
				totalRange = 10
			else
				totalRange = totalRange + 10
			end
		end
		
		--Check equipment for roboport R20
		if (equipmentGrid.equipment[index].name == "personal-roboport-equipment-R20") then
			--Add to robocount
			if (totalRange == false) then
				totalRange = 20
			else
				totalRange = totalRange + 20
			end
			
		end
		
		--Check equipment for roboport mk2 
		if (equipmentGrid.equipment[index].name == "personal-roboport-mk2-equipment") then
			--Add to robocount
			if (totalRange == false) then
				totalRange = 40
			else
				totalRange = totalRange + 40
			end
		end
		
				--Check equipment for roboport mk2 R10
		if (equipmentGrid.equipment[index].name == "personal-roboport-mk2-equipment-R10") then
			--Add to robocount
			if (totalRange == false) then
				totalRange = 10
			else
				totalRange = totalRange + 10
			end
		end
		
				--Check equipment for roboport mk2 R20
		if (equipmentGrid.equipment[index].name == "personal-roboport-mk2-equipment-R20") then
			--Add to robocount
			if (totalRange == false) then
				totalRange = 20
			else
				totalRange = totalRange + 20
			end
		end
		
				--Check equipment for roboport mk2 R30
		if (equipmentGrid.equipment[index].name == "personal-roboport-mk2-equipment-R30") then
			--Add to robocount
			if (totalRange == false) then
				totalRange = 30
			else
				totalRange = totalRange + 30
			end
		end
		
	end
	
	if not (totalRange == false) then
		return totalRange
	else
		return 0
	end
	
end

function GetMaxRange(equipmentGrid)
	local equipment = equipmentGrid.equipment
	local totalRange = 0

	for index = 1, table.maxn(equipment)
	do
		if not (string.find(equipment[index].name, "roboport") == nil) then
			if not (string.find(equipment[index].name, "mk2") == nil) then
				totalRange = totalRange + 40
			else
				totalRange = totalRange + 30
			end--end if
		end--end if
	end--end for
	
	return totalRange
end

local function IsAdjusted(armor)
	
	if (GetTotalRange(armor) == global.RequestedRange.current) then 
		return true
	else
		return false 
	end

end

local function GetRoboportRangeCode(roboportName)
	if (roboportName == "personal-roboport-equipment-R0") then
		return 100
	elseif (roboportName == "personal-roboport-equipment-R10") then
		return 110
	elseif (roboportName == "personal-roboport-equipment-R20") then
		return 120
	elseif (roboportName == "personal-roboport-equipment") then 
		return 130
	elseif (roboportName == "personal-roboport-mk2-equipment-R0") then
		return 200
	elseif (roboportName == "personal-roboport-mk2-equipment-R10") then
		return 210
	elseif (roboportName == "personal-roboport-mk2-equipment-R20") then
		return 220
	elseif (roboportName == "personal-roboport-mk2-equipment-R30") then
		return 230
	elseif (roboportName == "personal-roboport-mk2-equipment") then
		return 240
	else
		return nil
	end
end

local function GetRoboportNameFromRangeCode(roboportName)
	if (roboportName == 100) then
		return "personal-roboport-equipment-R0"
	elseif (roboportName == 110) then
		return "personal-roboport-equipment-R10"
	elseif (roboportName == 120) then
		return "personal-roboport-equipment-R20"
	elseif (roboportName == 130) then 
		return "personal-roboport-equipment"
	elseif (roboportName == 200) then
		return "personal-roboport-mk2-equipment-R0"
	elseif (roboportName == 210) then
		return "personal-roboport-mk2-equipment-R10"
	elseif (roboportName == 220) then
		return "personal-roboport-mk2-equipment-R20"
	elseif (roboportName == 230) then
		return "personal-roboport-mk2-equipment-R30"
	elseif (roboportName == 240) then
		return "personal-roboport-mk2-equipment"
	else
		return nil
	end
end

local function swapRoboport(armorGrid, newRoboport)
	--newRoboport contains the name of the new roboport and the
	--position of the roboport to be removed. The position is also
	--the position to place the new roboport
	local setRoboEnergy = armorGrid.get(newRoboport.position).energy
	armorGrid.take{position=newRoboport.position}
	armorGrid.put(newRoboport)
	armorGrid.get(newRoboport.position).energy = setRoboEnergy
end

--Directly changes the table data rather than returning the value
local function AdjustRoboportName(armor, namePosition)
    
    --are we working with MK2
    if not (string.find(namePosition.name, "mk2") == nil) then
        
        --Check if we are increase the roboport range or decreasing it
        if (GetTotalRange(armor) < global.RequestedRange.current) then
            
            local rangeDifference = global.RequestedRange.current - GetTotalRange(armor)
            local AvailIncreaseInRange = 240 - GetRoboportRangeCode(namePosition.name)
            
            --If the difference in range is greater than that max range of mk2 than just set it to max
            --If the difference in range is greater or equal than the amount that can be added to mk2 port set it to max
            if rangeDifference >= 40 or rangeDifference >= AvailIncreaseInRange then 
                
                namePosition.name = "personal-roboport-mk2-equipment"
            
            else
                namePosition.name = GetRoboportNameFromRangeCode(GetRoboportRangeCode(namePosition.name) + rangeDifference)
            end
            
        else
            
            local rangeDifference =  GetTotalRange(armor) - global.RequestedRange.current
            local AvailDecreaseInRange = GetRoboportRangeCode(namePosition.name) - 200
            
            --Determine when the port will be at zero
            if rangeDifference >= 40 or rangeDifference >= AvailDecreaseInRange then
                
                namePosition.name = "personal-roboport-mk2-equipment-R0"
                
            else
                
                namePosition.name = GetRoboportNameFromRangeCode(GetRoboportRangeCode(namePosition.name) - rangeDifference)
            end
        end
        
    --we working with mk1
    else
        
        --Check if we are increase the roboport range or decreasing it
        if (GetTotalRange(armor) < global.RequestedRange.current) then
            
            local rangeDifference = global.RequestedRange.current - GetTotalRange(armor)
            local AvailIncreaseInRange = 130 - GetRoboportRangeCode(namePosition.name)
            
            --If the difference in range is greater than that max range of mk1 than just set it to max
            --If the difference in range is greater or equal than the amount that can be added to mk1 port set it to max
            if rangeDifference >= 30 or rangeDifference >= AvailIncreaseInRange then 
                
                namePosition.name = "personal-roboport-equipment"
            
            else
                namePosition.name = GetRoboportNameFromRangeCode(GetRoboportRangeCode(namePosition.name) + rangeDifference)
            end
            
        else
            
            local rangeDifference =  GetTotalRange(armor) - global.RequestedRange.current
            local AvailDecreaseInRange = GetRoboportRangeCode(namePosition.name) - 100
            
            --Determine when the port will be at zero
            if rangeDifference >= 30 or rangeDifference >= AvailDecreaseInRange then
                
                namePosition.name = "personal-roboport-equipment-R0"
                
            else
                
                namePosition.name = GetRoboportNameFromRangeCode(GetRoboportRangeCode(namePosition.name) - rangeDifference)
            end
        end
    end
end

function AdjustRoboportRange(equipmentGrid, DontShowNewRange)
    
	if not IsAdjusted(equipmentGrid) then
        
        while (GetTotalRange(equipmentGrid) ~= global.RequestedRange.current) do
            
            local equipment = equipmentGrid.equipment
            local foundRoboports = {name=false, position=false}
            local listOfCustomRoboports = 0
            local listOfCustomMk2Roboports = 0
            local mk1Finds = 0
            local mk2Finds = 0
            local changeThisRoboport = {name=false, position=false}
            
            --define variable with roboport R0 only when we are adding range
            --define the variable without roboport R0 when we are subtracting range
            --otherwise it will create an infinite loop
            if (GetTotalRange(equipmentGrid) < global.RequestedRange.current) then
                    listOfCustomRoboports = {"personal-roboport-equipment-R0", "personal-roboport-equipment-R10", 
                                                    "personal-roboport-equipment-R20"}							   
                    listOfCustomMk2Roboports = {"personal-roboport-mk2-equipment-R0", "personal-roboport-mk2-equipment-R10", 
                                                            "personal-roboport-mk2-equipment-R20", "personal-roboport-mk2-equipment-R30"}
            else
                    listOfCustomRoboports = {"personal-roboport-equipment-R10", "personal-roboport-equipment-R20"}							   
                    listOfCustomMk2Roboports = {"personal-roboport-mk2-equipment-R10", "personal-roboport-mk2-equipment-R20", "personal-roboport-mk2-equipment-R30"}
            end--end if
                                                                
            --Looks for the custom mk2 roboports first
            for index = 1, table.maxn(equipment) do
                
                --Match the equipment name against a list of custom mk2 roboports
                for subIndex = 1, table.maxn(listOfCustomMk2Roboports) do
                    if (equipment[index].name == listOfCustomMk2Roboports[subIndex]) then
                        mk2Finds = mk2Finds + 1
                        foundRoboports[mk2Finds] = {name=equipment[index].name, position=equipment[index].position}
                    end--end if
                end--end for
            end--end for
    
            --Always change the mk2 armors first
            if (mk2Finds == 0) then
                --Looks for the custom mk1 roboports
                for index = 1, table.maxn(equipment) do
                    
                    --Match the equipment name against a list of custom mk1 roboports
                    for subIndex = 1, table.maxn(listOfCustomRoboports) do
                        if (equipment[index].name == listOfCustomRoboports[subIndex]) then
                            mk1Finds = mk1Finds + 1
                            foundRoboports[mk1Finds] = {name=equipment[index].name, position=equipment[index].position}
                        end --end if
                    end--end for
                end--end for
                
                if (mk1Finds > 0) then
                    --Find the smallest mk1 roboport
                    for index = 1, mk1Finds do
                        if (changeThisRoboport.name == false) then 
                            changeThisRoboport.name = foundRoboports[index].name
                            changeThisRoboport.position = foundRoboports[index].position
                        elseif (GetRoboportRangeCode(changeThisRoboport.name) > GetRoboportRangeCode(foundRoboports[index].name)) then
                            changeThisRoboport.name = foundRoboports[index].name
                            changeThisRoboport.position = foundRoboports[index].position
                        end--end if
                    end--end for
                end--end if
                
            else
                --Find the smallest mk2 roboport
                for index = 1, mk2Finds do
                    if (changeThisRoboport.name == false) then 
                        changeThisRoboport.name = foundRoboports[index].name
                        changeThisRoboport.position = foundRoboports[index].position
                    elseif (GetRoboportRangeCode(changeThisRoboport.name) > GetRoboportRangeCode(foundRoboports[index].name)) then
                        changeThisRoboport.name = foundRoboports[index].name
                        changeThisRoboport.position = foundRoboports[index].position
                    end--end if
                end--end for
                
            end--end if
            
            if (mk1Finds == 0 and mk2Finds == 0) then
                --Looks for the vanilla mk2 roboports first
                for index = 1, table.maxn(equipment) do
                    --find mk2 roboport
                    if (equipment[index].name == "personal-roboport-mk2-equipment") then
                        --At his point there is no custom roboports; doesn't matter which mk2 robot port
                        --abort the loop and use this one
                        changeThisRoboport = {name=equipment[index].name, position=equipment[index].position}
                        break
                    end--end if
                end--end for
                
                --if no vanilla mk2 roboports are found then check for vanilla mk1 roboports
            if (changeThisRoboport.name == false) then
                for index = 1, table.maxn(equipment) do
                    --find mk1 roboport
                    if (equipment[index].name == "personal-roboport-equipment") then
                        --At his point there is no custom roboports; doesn't matter which mk1 robotport
                        --abort the loop and use this one
                        changeThisRoboport = {name=equipment[index].name, position=equipment[index].position}
                        break
                    end--end if
                end--end for
                end--end if
            
            end--end if
            
            --makes sure that a roboport was found before continuing
            if not (changeThisRoboport.name) then
                return false
            end
            
            AdjustRoboportName(equipmentGrid, changeThisRoboport)
            
            if not (changeThisRoboport.name == nil) then
                --swap the roboports in armor inventory
                swapRoboport(equipmentGrid, changeThisRoboport)
            end--end if
            
        end--while loop
		
		--final check to see if equipmentGrid was proper adjusted to global.RequestedRange.current
		if (GetTotalRange(equipmentGrid) == global.RequestedRange.current) then
            if DontShowNewRange == nil then VisualizeRange(game.players[1]) end
			return true
		else
			return false
		end
        
	end--end if
end

function UndoAdjustRoboportRange(equipmentGrid)
	local pData = game.players[1]
	local equipment = equipmentGrid.equipment
	
	local listOfCustomRoboports = {"personal-roboport-equipment-R0", "personal-roboport-equipment-R10", 
											   "personal-roboport-equipment-R20"}							   
	local listOfCustomMk2Roboports = {"personal-roboport-mk2-equipment-R0", "personal-roboport-mk2-equipment-R10", 
													"personal-roboport-mk2-equipment-R20", "personal-roboport-mk2-equipment-R30"}
	
	--first replace all of the custom mk2 roboports
	for index = 1, table.maxn(equipment) do
		for subIndex = 1, table.maxn(listOfCustomMk2Roboports) do
			if (equipment[index].name == listOfCustomMk2Roboports[subIndex]) then
				swapRoboport(equipmentGrid, {name="personal-roboport-mk2-equipment", position=equipment[index].position})
				break
			end
		end
	end
	
	--Get new set of equipment after possibly removing custom mk2 roboports
	equipment = equipmentGrid.equipment
	
	--next replace all of the custom mk1 roboports
	for index = 1, table.maxn(equipment) do
		for subIndex = 1, table.maxn(listOfCustomRoboports) do
			if (equipment[index].name == listOfCustomRoboports[subIndex]) then
				swapRoboport(equipmentGrid, {name="personal-roboport-equipment", position=equipment[index].position})
				break
			end
		end
	end
	
end

function CleanCustomRoboports(inventory)
	local listOfCustomRoboports = {"personal-roboport-equipment-R0", "personal-roboport-equipment-R10", 
											   "personal-roboport-equipment-R20"}							   
	local listOfCustomMk2Roboports = {"personal-roboport-mk2-equipment-R0", "personal-roboport-mk2-equipment-R10", 
													"personal-roboport-mk2-equipment-R20", "personal-roboport-mk2-equipment-R30"}
	--Make sure LuaInventory object is valid
	if inventory.valid then 
		for index = 1, table.maxn(listOfCustomMk2Roboports)
		do
			local itemStack = false
			local itemStackIdex = false
			itemStack, itemStackIdex = inventory.find_item_stack(listOfCustomMk2Roboports[index])
			
			if (itemStack) then
				if itemStack.can_set_stack{name="personal-roboport-mk2-equipment", cout=itemStack.count} then
					itemStack.set_stack{name="personal-roboport-mk2-equipment", count=itemStack.count}
				end
			end
			
		end
		
		for index = 1, table.maxn(listOfCustomRoboports)
		do
			local itemStack = false
			local itemStackIdex = false
			itemStack, itemStackIdex = inventory.find_item_stack(listOfCustomRoboports[index])
			
			if (itemStack) then
				if itemStack.can_set_stack{name="personal-roboport-equipment", count=itemStack.count} then
					itemStack.set_stack{name="personal-roboport-equipment", count=itemStack.count}
				end
			end
			
		end
	end
end