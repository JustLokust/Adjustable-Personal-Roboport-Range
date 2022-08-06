require("prototypes.equipment")
require("prototypes.item")

local IncrementKey = 
{
	type = "custom-input",
	name = "AdjRobo-Increment",
	key_sequence = "]",
	consuming = "none",
}

local MinRangeKey = 
{
	type = "custom-input",
	name = "AdjRobo-MinRange",
	key_sequence = "SHIFT + [",
	consuming = "none",
}

local MaxRangeKey = 
{
	type = "custom-input",
	name = "AdjRobo-MaxRange",
	key_sequence = "SHIFT + ]",
	consuming = "none",
}

local DecrementKey = 
{
	type = "custom-input",
	name = "AdjRobo-Decrement",
	key_sequence = "[",
	consuming = "none",
}

local DisableRoboportKey = 
{
	type = "custom-input",
	name = "AdjRobo-DisableRoboport",
	key_sequence = "CONTROL + [",
	consuming = "none",
}

data:extend({DecrementKey, IncrementKey, DisableRoboportKey, MinRangeKey, MaxRangeKey})