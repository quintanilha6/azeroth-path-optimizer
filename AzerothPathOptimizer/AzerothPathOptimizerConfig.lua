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

function Config:CreateButton(point, relativeFrame, relativePoint, xOffset, yOffset, text)
	local btn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
	btn:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset);
	btn:SetSize(100, 30);
	btn:SetText(text);
	btn:SetNormalFontObject("GameFontNormalSmall");
	btn:SetHighlightFontObject("GameFontHighlightSmall");
	return btn;
end

function Config:CreateMenu()
	UIConfig = CreateFrame("Frame", "AzerothPathOptimizerConfig", UIParent, "BasicFrameTemplateWithInset");
	UIConfig:SetSize(460, 360);
	UIConfig:SetPoint("CENTER"); -- Doesn't need to be ("CENTER", UIParent, "CENTER")

	UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	UIConfig.title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 0);
	UIConfig.title:SetText("Azeroth Path Optimizer");

	----------------------------------
	-- Buttons
	----------------------------------
	-- Calculate Optimal Path Button:
	UIConfig.saveBtn = self:CreateButton("RIGHT", UIConfig, "TOP", 0, -50, "Calculate OP");

	-- Reset Button:	
	UIConfig.resetBtn = self:CreateButton("CENTER", UIConfig.saveBtn, "CENTER", 100, 0, "Reset");
	
	UIConfig:Hide();
	return UIConfig;
end