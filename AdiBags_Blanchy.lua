-------------------------------------------------------------------------------
-- AdiBags Sinrunner Blanchy By Crackpot (US, Arthas)
-------------------------------------------------------------------------------

local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local L = addon.L
local tooltip

local function tooltipInit()
	local tip, leftside = CreateFrame("GameTooltip"), {}
	for i = 1, 6 do
		local left, right = tip:CreateFontString(), tip:CreateFontString()
		left:SetFontObject(GameFontNormal)
		right:SetFontObject(GameFontNormal)
		tip:AddFontStrings(left, right)
		leftside[i] = left
	end
	tip.leftside = leftside
	return tip
end

local setFilter = AdiBags:RegisterFilter("Sinrunner Blanchy", 98, "ABEvent-1.0")
setFilter.uiName = L["Sinrunner Blanchy"]
setFilter.uiDesc = L["Items for getting the Blanchy mount."]

function setFilter:OnInitialize()
	self.blanchyItems = {
		[182581] = true,	-- Handful of Oats
		[182585] = true,	-- Grooming Brush
		[182595] = true,	-- Sturdy Horseshoe
		[182599] = true,	-- Bucket of Clean Water
		[182620] = true,	-- Empty Water Bucket
		[182597] = true,	-- Comfortable Saddle Blanket
		[179271] = true,	-- Dredhollow Apple
	}
end

function setFilter:Update()
	self:SendMessage("AdiBags_FiltersChanged")
end

function setFilter:OnEnable()
	AdiBags:UpdateFilters()
end

function setFilter:OnDisable()
	AdiBags:UpdateFilters()
end

function setFilter:Filter(slotData)
	if self.blanchyItems[tonumber(slotData.itemId)] then
		return L["Sinrunner Blanchy"]
	end

	tooltip = tooltip or tooltipInit()
	tooltip:SetOwner(UIParent,"ANCHOR_NONE")
	tooltip:ClearLines()

	if slotData.bag == BANK_CONTAINER then
		tooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(slotData.slot, nil))
	else
		tooltip:SetBagItem(slotData.bag, slotData.slot)
	end

	tooltip:Hide()
end
