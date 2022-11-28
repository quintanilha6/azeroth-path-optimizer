--------------------------------------
-- Namespaces
--------------------------------------
local _, core = ...;
core.Config = {}; -- adds Config table to addon namespace

local Config = core.Config;
local UIConfig;

--------------------------------------
-- Defaults (usually a database!)
--------------------------------------
local defaults = {
	theme = {
		r = 0, 
		g = 0.8, -- 204/255
		b = 1,
		hex = "00ccff"
	}
}

--------------------------------------
-- Config functions
--------------------------------------
function Config:Toggle()
	local menu = UIConfig or Config:CreateMenu();
	menu:SetShown(not menu:IsShown());
end

function Config:GetThemeColor()
	local c = defaults.theme;
	return c.r, c.g, c.b, c.hex;
end

function Config:CreateButton(point, relativeFrame, relativePoint, yOffset, text)
	local btn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
	btn:SetPoint(point, relativeFrame, relativePoint, 0, yOffset);
	btn:SetSize(140, 40);
	btn:SetText(text);
	btn:SetNormalFontObject("GameFontNormalLarge");
	btn:SetHighlightFontObject("GameFontHighlightLarge");
	return btn;
end

function Config:CreateMenu()
	UIConfig = CreateFrame("Frame", "AzerothPathOptimizerConfig", UIParent, "BasicFrameTemplateWithInset");
	UIConfig:SetSize(260, 360);
	UIConfig:SetPoint("CENTER"); -- Doesn't need to be ("CENTER", UIParent, "CENTER")

	UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	UIConfig.title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 0);
	UIConfig.title:SetText("Azeroth Path Optimizer");

	----------------------------------
	-- Buttons
	----------------------------------
	-- Calculate Button:
	UIConfig.saveBtn = self:CreateButton("CENTER", UIConfig, "TOP", -70, "Calculate OP");
	
	UIConfig:Hide();
	return UIConfig;
end