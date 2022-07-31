--==================================
--         MK1 Roboports
--==================================
local Robo1R0 = table.deepcopy(data.raw.recipe["personal-roboport-equipment"]);
Robo1R0.name = "personal-roboport-equipment-R0";
Robo1R0.result = "personal-roboport-equipment-R0";
Robo1R0.energy_required = 1;
Robo1R0.ingredients = {
    { "personal-roboport-equipment", 1 },
};

local Robo1R10 = table.deepcopy(data.raw.recipe["personal-roboport-equipment"]);
Robo1R10.name = "personal-roboport-equipment-R10";
Robo1R10.result = "personal-roboport-equipment-R10";
Robo1R10.energy_required = 1;
Robo1R10.ingredients = {
    { "personal-roboport-equipment", 1 },
};

local Robo1R20 = table.deepcopy(data.raw.recipe["personal-roboport-equipment"]);
Robo1R20.name = "personal-roboport-equipment-R20";
Robo1R20.result = "personal-roboport-equipment-R20";
Robo1R20.energy_required = 1;
Robo1R20.ingredients = {
    { "personal-roboport-equipment", 1 },
};

--==================================
--         MK2 Roboports
--==================================
local Robo2R0 = table.deepcopy(data.raw.recipe["personal-roboport-mk2-equipment"]);
Robo2R0.name = "personal-roboport-mk2-equipment-R0";
Robo2R0.result = "personal-roboport-mk2-equipment-R0";
Robo2R0.energy_required = 1;
Robo2R0.ingredients = {
    { "personal-roboport-mk2-equipment", 1 },
};

local Robo2R10 = table.deepcopy(data.raw.recipe["personal-roboport-mk2-equipment"]);
Robo2R10.name = "personal-roboport-mk2-equipment-R10";
Robo2R10.result = "personal-roboport-mk2-equipment-R10";
Robo2R10.energy_required = 1;
Robo2R10.ingredients = {
    { "personal-roboport-mk2-equipment", 1 },
};

local Robo2R20 = table.deepcopy(data.raw.recipe["personal-roboport-mk2-equipment"]);
Robo2R20.name = "personal-roboport-mk2-equipment-R20";
Robo2R20.result = "personal-roboport-mk2-equipment-R20";
Robo2R20.energy_required = 1;
Robo2R20.ingredients = {
    { "personal-roboport-mk2-equipment", 1 },
};

local Robo2R30 = table.deepcopy(data.raw.recipe["personal-roboport-mk2-equipment"]);
Robo2R30.name = "personal-roboport-mk2-equipment-R30";
Robo2R30.result = "personal-roboport-mk2-equipment-R30";
Robo2R30.energy_required = 1;
Robo2R30.ingredients = {
    { "personal-roboport-mk2-equipment", 1 },
};

data:extend{Robo1R0, Robo1R10, Robo1R20, Robo2R0, Robo2R10, Robo2R20, Robo2R30};