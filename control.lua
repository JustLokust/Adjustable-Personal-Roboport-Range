--*****************************
--Incompatibility notes:
--If a mod changes roboports or requests the roboports from equipped armor grid

--*****************************

--Define Globals
global.RequestedRange = {current=false, old=false}
global.MaxRange = false
global.TurnOffConstruction = false
global.EquipedArmorGrid = false

require "AdjustableRoboport"

--==================================
--                       Event Calls
--==================================
script.on_init(function()
	if (game.players[1]) then
		local pData = game.players[1]
		local armor = pData.get_inventory(defines.inventory.character_armor)
	
		if not (armor.is_empty()) and armor[1].grid then
			global.RequestedRange.current = GetTotalRange(armor[1].grid)
			global.RequestedRange.old = GetTotalRange(armor[1].grid)
			global.MaxRange = GetTotalRange(armor[1].grid)
			global.TurnOffConstruction = false
			global.EquipedArmorGrid = armor[1].grid
		end
	end
end)

--Key ']' was pressed
script.on_event("AdjRobo-Increment", function(e)
   local pData = game.players[e.player_index]
   local armor = pData.get_inventory(defines.inventory.character_armor)
   
	if not (armor.is_empty()) and armor[1].grid then
		if (global.TurnOffConstruction == false) then 
   
			if (global.RequestedRange.current ~= global.MaxRange) then
				
				global.RequestedRange.current = global.RequestedRange.current + 10
				
				--Re-adjust the armor to account for new range
				AdjustRoboportRange(armor[1].grid)
			else
				pData.create_local_flying_text{text = "Max Range", position = pData.position}
				VisualizeRange(pData)
			end
		else
			pData.play_sound{path = "utility/cannot_build"}
			pData.create_local_flying_text{text = "Roboport Disabled, ctr+'[' to toggle.", position = pData.position}
		end
	end
end)

--Key '[' was pressed
script.on_event("AdjRobo-Decrement", function(e)
   local pData = game.players[e.player_index]
   local armor = pData.get_inventory(defines.inventory.character_armor)
  
  	if not (armor.is_empty()) and armor[1].grid then
		if (global.TurnOffConstruction == false) then
		
			if (global.RequestedRange.current >= 20) and not armor.is_empty() then
				global.RequestedRange.current = global.RequestedRange.current - 10
				
				--Re-adjust the armor to account for new range
			    AdjustRoboportRange(armor[1].grid)
			end
		else
			pData.play_sound{path = "utility/cannot_build"}
			pData.create_local_flying_text{text = "Roboport Disabled, ctr+'[' to toggle.", position = pData.position}
		end
	end
end)

--Key SHIFT + '[' was pressed
script.on_event("AdjRobo-DisableRoboport", function(e)
	local pData = game.players[e.player_index]
	local armor = pData.get_inventory(defines.inventory.character_armor)

	if not (armor.is_empty()) and armor[1].grid then

		if (global.TurnOffConstruction == true) then
			global.RequestedRange.current = global.RequestedRange.old
			AdjustRoboportRange(armor[1].grid)
			global.TurnOffConstruction = false
		else
			global.RequestedRange.old = global.RequestedRange.current
			global.RequestedRange.current = 0
			AdjustRoboportRange(armor[1].grid)
			global.TurnOffConstruction = true
		end
	end
end)

--Key SHIFT + ']' was pressed
script.on_event("AdjRobo-MaxRange", function(e)
	local pData = game.players[e.player_index]
	local armor = pData.get_inventory(defines.inventory.character_armor)

	if not (armor.is_empty()) and armor[1].grid then
		if (global.RequestedRange.current == global.MaxRange) then
			global.RequestedRange.current = global.RequestedRange.old
		else
			global.RequestedRange.old = global.RequestedRange.current
			global.RequestedRange.current = global.MaxRange
		end
		global.TurnOffConstruction = false
		AdjustRoboportRange(armor[1].grid)
	end
	
end)

script.on_event(defines.events.on_player_placed_equipment, function(e)
	local pData = game.players[e.player_index]
	local armor = pData.get_inventory(defines.inventory.character_armor)

	if not (armor.is_empty()) then
		--check if this equipment was added to equipped armor
		if (e.grid == armor[1].grid) then
			--Check for vanilla mk2 or mk1 roboport was added to grid
			if (e.equipment.name == "personal-roboport-mk2-equipment") or
				(e.equipment.name == "personal-roboport-equipment") then
				
                --When the current range is 0, due to no previous roboports equipped, adjust 
                --the current range to match new MAXRange
                if global.MaxRange == 0 then
                    
                    global.MaxRange = GetMaxRange(e.grid)
                    
                    global.RequestedRange.current = global.MaxRange
                    global.RequestedRange.old = global.MaxRange
                    
                    AdjustRoboportRange(armor[1].grid, true)
                                  
                 --All checks have been completed by this point. Adjust the range to match
                 --current and set new MaxRange
                else
                    global.MaxRange = GetMaxRange(e.grid)
                    
                     AdjustRoboportRange(armor[1].grid, true)
                end
			end
			
		end
	end
end)

script.on_event(defines.events.on_player_removed_equipment, function(e)
	local pData = game.players[e.player_index]
	local armor = pData.get_inventory(defines.inventory.character_armor)
												
	if not (armor.is_empty()) then
		--check if this equipment was removed from equipped armor
		if (e.grid == armor[1].grid) then
				if ("personal-roboport-mk2-equipment" == e.equipment)  or
				   ("personal-roboport-equipment" == e.equipment) then
				   
					--change the MaxRange to account for one less roboport
					global.MaxRange = GetMaxRange(e.grid)
					
					--RequestedRange can't be higher than the MaxRange
					if (global.RequestedRange.current > global.MaxRange) then
						global.RequestedRange.current = global.MaxRange
					end
					
					--RequestedRange can't be higher than the MaxRange
					if (global.RequestedRange.old > global.MaxRange) then
						global.RequestedRange.old = global.MaxRange
					end
					
					--check player's main inventory for custom roboports and swap them for vanilla
					CleanCustomRoboports(pData.get_main_inventory())
					
                     AdjustRoboportRange(armor[1].grid, true)
                    
				end--end if	
		end--end if
	end--end if
end)

script.on_event(defines.events.on_player_armor_inventory_changed, function(e)
	local pData = game.players[e.player_index]
	local armor = pData.get_inventory(defines.inventory.character_armor)
		
	if (not (armor.is_empty())) and armor[1].grid then
		--Few possibilities:
		--1) The armor was swapped for a different armor
		--2) Armor was placed into a previously empty armor slot
		--3) Armor was destroyed in some way. 
		--		a) Ingrendent in upgraded armor
		--		b) Some mod change the armor (Looking at you Jetpack mod)

		--MaxRange needs to be updated for new armor configuration
		global.MaxRange = GetMaxRange(armor[1].grid)
		
		--Check to make sure the requested old was initialized. If so then make sure 
		--to update the old range to reflect new Max range
		if (global.RequestedRange.old == false) or (global.RequestedRange.old > global.MaxRange) then
			global.RequestedRange.old = global.MaxRange
		end
		
		--If TurnOffConstruction is false then the RequestedRange.current must be set to MaxRange
		--If the current was never set than it must be set now
		if (global.RequestedRange.current == false) or
			((global.TurnOffConstruction == false) and (global.RequestedRange.current > global.MaxRange)) then
			
			global.RequestedRange.current = global.MaxRange
            
        --If previous armor had no roboports then update current to max range of new armor
        elseif global.TurnOffConstruction == false and global.RequestedRange.current == 0 and global.MaxRange > 0 then
            
            global.RequestedRange.current = global.MaxRange
		end
		
		AdjustRoboportRange(armor[1].grid, true)

		--Clean the armor that was swapped out. It is still stored by reference in EquipedArmorGrid
		if not (global.EquipedArmorGrid == false) then UndoAdjustRoboportRange(global.EquipedArmorGrid) end
		
		--Set the new equipped armor reference for next armor swap
		global.EquipedArmorGrid = armor[1].grid
	else
		--Armor was removed from the armor slot by selecting the armor and now its in the cursor
		if (pData.cursor_stack.is_armor) and pData.cursor_stack.grid then
			UndoAdjustRoboportRange(pData.cursor_stack.grid)
			global.EquipedArmorGrid = false
		end
		
		--The armor was shift clicked to remove. Clean up
		if not (global.EquipedArmorGrid == false) then
			UndoAdjustRoboportRange(global.EquipedArmorGrid)
			global.EquipedArmorGrid = false
		end

		
	end
	
end)

remote.add_interface("AdjustRoboportRange", {AdjustRange = AdjustRoboportRange})