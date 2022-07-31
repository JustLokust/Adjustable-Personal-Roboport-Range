--==================================
--         MK1 Roboports
--==================================
local Robo1R0 = table.deepcopy(data.raw.item["personal-roboport-equipment"]);
Robo1R0.name = "personal-roboport-equipment-R0";
Robo1R0.placed_as_equipment_result = "personal-roboport-equipment-R0";

local Robo1R10 = table.deepcopy(data.raw.item["personal-roboport-equipment"]);
Robo1R10.name = "personal-roboport-equipment-R10";
Robo1R10.placed_as_equipment_result = "personal-roboport-equipment-R10";

local Robo1R20 = table.deepcopy(data.raw.item["personal-roboport-equipment"]);
Robo1R20.name = "personal-roboport-equipment-R20";
Robo1R20.placed_as_equipment_result = "personal-roboport-equipment-R20";

--==================================
--         MK2 Roboports
--==================================
local Robo2R0 = table.deepcopy(data.raw.item["personal-roboport-mk2-equipment"]);
Robo2R0.name = "personal-roboport-mk2-equipment-R0";
Robo2R0.placed_as_equipment_result = "personal-roboport-mk2-equipment-R0";

local Robo2R10 = table.deepcopy(data.raw.item["personal-roboport-mk2-equipment"]);
Robo2R10.name = "personal-roboport-mk2-equipment-R10";
Robo2R10.placed_as_equipment_result = "personal-roboport-mk2-equipment-R10";

local Robo2R20 = table.deepcopy(data.raw.item["personal-roboport-mk2-equipment"]);
Robo2R20.name = "personal-roboport-mk2-equipment-R20";
Robo2R20.placed_as_equipment_result = "personal-roboport-mk2-equipment-R20";

local Robo2R30 = table.deepcopy(data.raw.item["personal-roboport-mk2-equipment"]);
Robo2R30.name = "personal-roboport-mk2-equipment-R30";
Robo2R30.placed_as_equipment_result = "personal-roboport-mk2-equipment-R30";

data:extend{Robo1R0, Robo1R10, Robo1R20, Robo2R0, Robo2R10, Robo2R20, Robo2R30};