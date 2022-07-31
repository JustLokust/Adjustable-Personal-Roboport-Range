--==================================
--         MK1 roboports
--==================================
local Robo1R0 = table.deepcopy(data.raw["roboport-equipment"]["personal-roboport-equipment"]);
Robo1R0.construction_radius = 0;
Robo1R0.name = "personal-roboport-equipment-R0";

local Robo1R10 = table.deepcopy(data.raw["roboport-equipment"]["personal-roboport-equipment"]);
Robo1R10.construction_radius = 5;
Robo1R10.name = "personal-roboport-equipment-R10";

local Robo1R20 = table.deepcopy(data.raw["roboport-equipment"]["personal-roboport-equipment"]);
Robo1R20.construction_radius = 10;
Robo1R20.name = "personal-roboport-equipment-R20";

--==================================
--         MK2 roboports
--==================================
local Robo2R0 = table.deepcopy(data.raw["roboport-equipment"]["personal-roboport-mk2-equipment"]);
Robo2R0.construction_radius = 0;
Robo2R0.name = "personal-roboport-mk2-equipment-R0";

local Robo2R10 = table.deepcopy(data.raw["roboport-equipment"]["personal-roboport-mk2-equipment"]);
Robo2R10.construction_radius = 5;
Robo2R10.name = "personal-roboport-mk2-equipment-R10";

local Robo2R20 = table.deepcopy(data.raw["roboport-equipment"]["personal-roboport-mk2-equipment"]);
Robo2R20.construction_radius = 10;
Robo2R20.name = "personal-roboport-mk2-equipment-R20";

local Robo2R30 = table.deepcopy(data.raw["roboport-equipment"]["personal-roboport-mk2-equipment"]);
Robo2R30.construction_radius = 15;
Robo2R30.name = "personal-roboport-mk2-equipment-R30";

data:extend{Robo1R0, Robo1R10, Robo1R20, Robo2R0, Robo2R10, Robo2R20, Robo2R30};

