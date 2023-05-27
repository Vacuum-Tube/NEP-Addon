local ParamBuilder = require "parambuilder_v1_2"

local param_renderDistance = ParamBuilder.Slider("NEP_renderDistance",
	_("Render Distance"),
	ParamBuilder.range(5, 50, 1),
	15,
	_("renderDistance_TT"),
	"%d km"
)
local param_environment = ParamBuilder.Combobox("NEP_environment",
	"Environment",  -- translated anyway?
	{	"-",
		"nep_temperate.lua",
		"nep_temperate_less_blue.lua",
		"nep_um_6.lua",
	},
	1,
	_("environment_TT"),
	_  --  <-- use the translator function for ParamBuilder to format the strings
)
local param_darkOverlay = ParamBuilder.Checkbox("NEP_darkOverlay",
	_("Make white overlay dark"),
	true,
	_("darkOverlay_TT")
)
local param_improveLayerConfig = ParamBuilder.Checkbox("NEP_improveLayerConfig",
	_("Improve Overlay Config"),
	true,
	_("improveLayerConfig_TT")
)
local param_tracksRustyNew = ParamBuilder.Combobox("NEP_tracksRustyNew",
	_("Track Types"),
	{ _("Rusty tracks only"), _("New tracks only"), _("New and rusty tracks") }
)
local param_tracksAddSpeeds = ParamBuilder.Checkbox("NEP_tracksAddSpeeds",
	_("Track Types: Additional Speedlimits"),
	false,
	_("tracksAddSpeeds_TT")
)
local param_WhitePolesGreen = ParamBuilder.Checkbox("NEP_makeWhitePolesGreen",
	_("makeWhitePolesGreen_name"),
	false
)
local param_LzbBetonPolesWhite = ParamBuilder.Checkbox("NEP_makeLzbBetonPolesWhite",
	_("makeLzbBetonPolesWhite_name"),
	false,
	_("makeLzbBetonPolesWhite_TT")
)


function data()
return {
	info = {
		name = "NEP Addon (for Natural Environment Professional)",
		description = _("mod_desc"),
		minorVersion = 0,
		severityAdd = "NONE",
		severityRemove = "WARNING",
		-- tfnetId = ,
		tags = {"Europe", "Shader", "Track", "Misc",},
		authors = {
			{
				name = "VacuumTube",
				role = "CREATOR",
				tfnetId = 29264,
			},
		},
		-- url = "",
		modid = "vt_natural_environment_pro_addon_1",
		dependencies = {"unixroot_natural_environment_pro_tpf2_2"},
		requiredModsAnyLoadOrder = false,
		requiredMods = {
			{
				modId= "unixroot_natural_environment_pro_tpf2_2", 
				tfnetId = 5942, 
				url = "https://www.transportfever.net/filebase/index.php?entry/5942-natural-environment-professional-2/", 
			},
		},
		params = {
			param_renderDistance.params,
			param_environment.params,
			{
                key = "tracktypes",
                name = _("Select tracktypes"),
                uiType = "COMBOBOX",
                values = { _("Rusty tracks only"),_("Rusty tracks only with speedlimmits"),_("New tracks only"),_("New tracks only with speedlimmits"),_("New and rusty tracks"),_("New and rusty tracks with speedlimmits") },
                -- tooltip = _("tracktypes_TT"),
                defaultIndex = 0,
            },
			-- param_tracksRustyNew.params,
			-- param_tracksAddSpeeds.params,
			param_WhitePolesGreen.params,
			param_LzbBetonPolesWhite.params,
			param_darkOverlay.params,
			param_improveLayerConfig.params,
		},
	},
	runFn = function (settings, modParams)
		
		local params = modParams[getCurrentModId()]
		
		local renderDistance = param_renderDistance.getValue(params)*1000  -- [m]
		game.config.settings.geometryQualityOptions[1].viewNearFar[2] = renderDistance/4  -- Low
		game.config.settings.geometryQualityOptions[2].viewNearFar[2] = renderDistance/2  -- Medium
		game.config.settings.geometryQualityOptions[3].viewNearFar[2] = renderDistance  -- High
		game.config.settings.geometryQualityOptions[4].viewNearFar[2] = renderDistance*2  -- Camera tool
		game.config.settings.geometryQualityOptions[5].viewNearFar[2] = renderDistance/2  -- Cockpit view
		
		if param_environment.getIndex(params)>0 then
			game.config.environment = param_environment.getValue(params)
		end
		
		if param_LzbBetonPolesWhite.getBool(params) then
			addModifier("loadTrack", function(fileName, data)
				if not fileName:find("block") then  -- nur bei LZB mit Schwellen, nicht bei Feste Fahrbahn
					if data.catenaryPoleModel == "railroad/nep_power_pole_2_beton.mdl" then
						data.catenaryPoleModel = "railroad/nep_power_pole_2_grau.mdl"
					end
					if data.catenaryMultiPoleModel == "railroad/nep_power_pole_1_beton.mdl" then
						data.catenaryMultiPoleModel = "railroad/nep_power_pole_1_grau.mdl"
					end
					if data.catenaryMultiInnerPoleModel == "railroad/nep_power_pole_1b_beton.mdl" then
						data.catenaryMultiInnerPoleModel = "railroad/nep_power_pole_1b_grau.mdl"  -- wird erst mit grau ersetzt - wenn NEP_makeWhitePolesGreen aktiv ist, werden diese anschließend noch durch grün ersetzt
					end
				end
				return data
			end)
		end
		
		if param_WhitePolesGreen.getBool(params) then
			addModifier("loadTrack", function(fileName, data)
				if data.catenaryPoleModel == "railroad/nep_power_pole_2_grau.mdl" then
					data.catenaryPoleModel = "railroad/nep_power_pole_2.mdl"
				end
				if data.catenaryMultiPoleModel == "railroad/nep_power_pole_1_grau.mdl" then
					data.catenaryMultiPoleModel = "railroad/nep_power_pole_1.mdl"
				end
				if data.catenaryMultiInnerPoleModel == "railroad/nep_power_pole_1b_grau.mdl" then
					data.catenaryMultiInnerPoleModel = "railroad/nep_power_pole_1b.mdl"
				end
				return data
			end)
		end
		
		addModifier("loadTrack", function(fileName, data)
			if fileName:ends("high_speed_block_lzb.lua") and data.speedLimit > 350 / 3.6 then
				data.yearFrom = 2050  -- useful for those who dont need 600kmh track because speed layer colors are influenced
			end
			return data
		end)
		
		
		assert(game.config.gui.layers, "Config Error detected, remove broken mods messing around with the game config !")
		if param_improveLayerConfig.getBool(params) then
			game.config.gui.layers.contourLines.numLevels = 12
			game.config.gui.layers.trackSpeedLimits.numLevels = 9
			game.config.gui.layers.destinations.numTransportLevels = 9
			game.config.gui.layers.cargo.numTransportLevels = 9
			game.config.gui.layers.cargo.numBuildingLevels = 9
			game.config.gui.layers.stations.numLevels = 9
			game.config.gui.layers.streetTraffic.numLevels = 9 
			game.config.gui.layers.trackSpeedLimits.speedLimitColors = { { 0.95, 0.15, 0.15, 1}, { 0.95, 0.9, 0.15, 1 }, { 0, 0.7, 0.25, 1 }, }  -- red, yellow, green
			game.config.gui.layers.stations.stationColors = { { 0.95, 0.15, 0.15, 1}, { 0.95, 0.9, 0.15, 1 }, { 0, 0.7, 0.25, 1 }, }
			game.config.gui.layers.streetTraffic.trafficColors = { { 0.95, 0.15, 0.15, 1}, { 0.95, 0.9, 0.15, 1 }, { 0, 0.7, 0.25, 1 }, }
		end
		if param_darkOverlay.getBool(params) then
			game.config.gui.layers.defaultColors.baseTerrainColor = { 0.2, 0.2, 0.2, 1 }
			game.config.gui.layers.defaultColors.baseWaterColorFactors = { 0.2, 0.2, 0.2, 1 }
			game.config.gui.layers.contourLines.baseEntityColor = { 0.3, 0.3, 0.3, 1 }
			game.config.gui.layers.navigableWaters.baseEntityColor = { 0.3, 0.3, 0.3, 1 }
			game.config.gui.layers.landUse.baseEntityColor = { 0.3, 0.3, 0.3, 1 }
			game.config.gui.layers.trackSpeedLimits.baseEntityColor = { 0.3, 0.3, 0.3, 1 }
			game.config.gui.layers.destinations.baseEntityColor = { 0.3, 0.3, 0.3, 1 }
			game.config.gui.layers.cargo.baseEntityColor = { 0.3, 0.3, 0.3, 1 }
			game.config.gui.layers.stations.baseEntityColor = { 0.3, 0.3, 0.3, 1 }
			game.config.gui.layers.streetTraffic.baseEntityColor = { 0.3, 0.3, 0.3, 1 }
			game.config.gui.layers.emissions.baseEntityColor = { 0.3, 0.3, 0.3, 1 }
			game.config.gui.layers.contourLines.baseTerrainColor = { 0.2, 0.2, 0.2, 1 }
			game.config.gui.layers.contourLines.terrainMinColor = { 1.0, 1.0, 1.0, -1 }
			game.config.gui.layers.contourLines.terrainMaxColor = { 0.53, 0.0, 0.17, -10 }
			game.config.gui.layers.contourLines.waterColor = { 0, 0.2, 0.6, 1 }
			game.config.gui.layers.contourLines.contours = {
				{ id = "majorContour", name = _("Major contour (100 m)"), color = { .75, .75, .75, .5 }, level = 100, width = 3, fadeDist = -1 },
				{ id = "minorContour", name = _("Minor contour (50 m)"), color = { .75, .75, .75, .5 }, level = 50, width = 2, fadeDist = -1 },
				{ id = "intermediateContour", name = _("Intermediate contour (10 m)"), color = { .6, .75, 1.0, .5 }, level = 10, width = 1, fadeDist = 4000 },
				{ id = "detailContour", name = _("Detail contour (2 m)"), color = { .6, .75, 1.0, .5 }, level = 2, width = .75, fadeDist = 500 }
			}
			game.config.gui.layers.navigableWaters.navigableWaterColor = { 0.05, 0.4, 0, 1 }
			game.config.gui.layers.navigableWaters.baseWaterColor = { 0, 0.2, 0.3, -0.85}
			game.config.gui.layers.landUse.residentialColors = { { 0.4, 0.55, 0.3, 1 }, { 0.15, 0.55, 0, 1 }, }
			game.config.gui.layers.landUse.commercialColors = { { 0.33, 0.45, 0.55, 1 }, { 0, 0.3, 0.55, 1 }, }
			game.config.gui.layers.landUse.industrialColors = { { 0.55, 0.5, 0.33, 1 }, { 0.55, 0.5, 0, 1 }, }
			game.config.gui.layers.destinations.residentialColor = { 0.2, 0.2, 0.2, 1 }  -- color more distracting than useful
			-- game.config.gui.layers.destinations.destinationColor = { 0.8, 0.3, 0.3, 1 }  -- not working?
			-- game.config.gui.layers.destinations.publicTransportColors = { { 0, 0.56, 0.90, 1 }, { 0.50, 0.80, 1, 1 } }
			-- game.config.gui.layers.destinations.privateTransportColors = { {0, 0.4, 0, 1}, { 1, 0, 0, 1} }  -- default colors better
			game.config.gui.layers.cargo.transportColors = { { 0.7, 0.85, 0.7, 1 }, { 0, 0.75, 0, 1 }, }
			game.config.gui.layers.cargo.commercialColors = { { 0.33, 0.45, 0.55, 1.0 }, { 0, 0.3, 0.55, 1.0 }, }
			game.config.gui.layers.cargo.industrialColors = { { 0.55, 0.5, 0.33, 1.0 }, { 0.55, 0.5, 0, 1.0 }, }
			-- game.config.gui.layers.emissions.baseTerrainColor = { 0.2, 0.2, 0.2, 1 }
			game.config.gui.layers.emissions.residentialColor = { 0.2, 0.4, 0.1, 1 }
			game.config.gui.layers.emissions.emissionColors = { { 0.2, 0.2, 0.2, 1 }, { 1, 0, 0, 1 } }
		end
		
		natural_environment_pro_addon = {}
	end,
	postRunFn = function (settings, modParams)
		assert(natural_environment_pro, "NEP original mod not loaded before Addon !")		
		
		--  ############################
		local tracks_disabled = false  --  <-- change this to "true" to skip the following track filtering script (if you removed the track folder from NEP)
		if tracks_disabled then
			return
		end
		
		
		-- Fuegt alternative hinzu fuer neue Gleise
		local makeAlternativ = function(list)
			local result = {}
			for k, item in ipairs(list) do
				result[k] = "alternativ/"..item
			end
			return result
		end

		-- Erstellt eine Modul Liste aus Basisnamen
		local buildPlattformModuleList = function(names)
			local result = {}
			for _, name in ipairs(names) do
				result[#result+1] = "platform_"..name..".module"
				result[#result+1] = "platform_"..name.."_catenary.module"
			end
			return result
		end

		-- Erstellt eine Modul Liste aus Basisnamen und Geschwindigkeitsliste
		local buildPlattformModuleSpeedList = function(names, moduleSpeeds)
			local result = {}
			for _, name in ipairs(names) do
				for _, speed in ipairs(moduleSpeeds[name]) do
					result[#result+1] = "platform_"..name.."_"..speed..".module"
					result[#result+1] = "platform_"..name.."_catenary_"..speed..".module"
				end
			end
			return result
		end



		-- Tracktype filter:
		local disableRusty = {
			"high_speed.lua",
			"high_speed_block_lzb.lua",
			"high_speed_gedreht.lua",
			"high_speed_lzb.lua",
			"high_speed_lzb_gedreht.lua",
			"low_speed.lua",
			"low_speed_gedreht.lua",
			"standard.lua",
			"standard_gedreht.lua",
		} 

		local disableRusty_speedlimmits = {
			"standard_10.lua",
			"standard_20.lua",
			"standard_30.lua",
			"standard_40.lua",
			"standard_50.lua",
			"standard_60.lua",
			"standard_70.lua",
			"standard_80.lua",
			"standard_90.lua",
			"standard_100.lua",
			"standard_110.lua",
			"low_speed_10.lua",
			"low_speed_20.lua",
			"low_speed_30.lua",
			"low_speed_40.lua",
			"low_speed_50.lua",
			"low_speed_60.lua",
			"low_speed_70.lua",
			"low_speed_80.lua",
			"low_speed_90.lua",
			"low_speed_100.lua",
			"low_speed_110.lua",
			"low_speed_120.lua",
			"low_speed_130.lua",
			"low_speed_150.lua",
			"low_speed_160.lua",
			"high_speed_10.lua",
			"high_speed_20.lua",
			"high_speed_30.lua",
			"high_speed_40.lua",
			"high_speed_50.lua",
			"high_speed_60.lua",
			"high_speed_70.lua",
			"high_speed_80.lua",
			"high_speed_90.lua",
			"high_speed_100.lua",
			"high_speed_110.lua",
			"high_speed_120.lua",
			"high_speed_130.lua",
			"high_speed_140.lua",
			"high_speed_150.lua",
			"high_speed_lzb_10.lua",
			"high_speed_lzb_20.lua",
			"high_speed_lzb_30.lua",
			"high_speed_lzb_40.lua",
			"high_speed_lzb_50.lua",
			"high_speed_lzb_60.lua",
			"high_speed_lzb_70.lua",
			"high_speed_lzb_80.lua",
			"high_speed_lzb_90.lua",
			"high_speed_lzb_100.lua",
			"high_speed_lzb_110.lua",
			"high_speed_lzb_120.lua",
			"high_speed_lzb_130.lua",
			"high_speed_lzb_140.lua",
			"high_speed_lzb_150.lua",
			"high_speed_lzb_160.lua",
			"high_speed_lzb_180.lua",
			"high_speed_lzb_200.lua",
			"high_speed_lzb_220.lua",
			"high_speed_lzb_250.lua",
			"high_speed_block_lzb_120.lua",
			"high_speed_block_lzb_140.lua",
			"high_speed_block_lzb_160.lua",
			"high_speed_block_lzb_180.lua",
			"high_speed_block_lzb_200.lua",
			"high_speed_block_lzb_250.lua",
			"high_speed_block_lzb_300.lua",
			"standard_gedreht_10.lua",
			"standard_gedreht_20.lua",
			"standard_gedreht_30.lua",
			"standard_gedreht_40.lua",
			"standard_gedreht_60.lua",
			"low_speed_gedreht_10.lua",
			"low_speed_gedreht_20.lua",
			"low_speed_gedreht_30.lua",
			"low_speed_gedreht_40.lua",
			"low_speed_gedreht_60.lua",
			"low_speed_gedreht_120.lua",
			"high_speed_gedreht_10.lua",
			"high_speed_gedreht_20.lua",
			"high_speed_gedreht_30.lua",
			"high_speed_gedreht_40.lua",
			"high_speed_gedreht_60.lua",
			"high_speed_gedreht_120.lua",
			"high_speed_gedreht_140.lua",
			"high_speed_lzb_gedreht_10.lua",
			"high_speed_lzb_gedreht_20.lua",
			"high_speed_lzb_gedreht_30.lua",
			"high_speed_lzb_gedreht_40.lua",
			"high_speed_lzb_gedreht_60.lua",
			"high_speed_lzb_gedreht_120.lua",
			"high_speed_lzb_gedreht_140.lua",
			"high_speed_lzb_gedreht_160.lua",
			"high_speed_lzb_gedreht_200.lua",  --  <-- fix Texture resolve error high_speed_lzb_gedreht_200_module
		}

		local generelldisable_speedlimmits = {
			"high_speed_lzb_10.lua",
			"high_speed_lzb_20.lua",
			"high_speed_lzb_30.lua",
			"high_speed_lzb_40.lua",
			"high_speed_lzb_50.lua",
			"high_speed_lzb_60.lua",
		}

		local disableNew = makeAlternativ(disableRusty)
		local disableNew_speedlimmits = makeAlternativ(disableRusty_speedlimmits)

		-- Eigene Module und Geschwindigkeiten
		local moduleBaseNames = {"track", "low_speed_track", "high_speed_track", "high_speed_track_lzb" }
		local moduleSpeeds = {
			["track"] = { 10,20,30,40,60 },
			["low_speed_track"] = { 10,20,30,40,60,120 },
			["high_speed_track"] = { 10,20,30,40,60,120,140 },
			["high_speed_track_lzb"] = { 10,20,30,40,60,120,140,160 },
		}

		local modulesRusty = buildPlattformModuleList(moduleBaseNames)
		local modulesRusty_speedlimmits = buildPlattformModuleSpeedList(moduleBaseNames, moduleSpeeds)

		local moduleNew = makeAlternativ(modulesRusty)
		local moduleNew_speedlimmits = makeAlternativ(modulesRusty_speedlimmits)


		-- Alle UG Module dieser Gleise abschalten:
		local filterUGModules = {
			disableRusty, disableRusty_speedlimmits, disableNew, disableNew_speedlimmits
		}



		-- trackTypeSetting zu Filterlisten
		local trackTypeSetting2filterlists = {
			{ disableNew, disableNew_speedlimmits, disableRusty_speedlimmits, generelldisable_speedlimmits },
			{ disableNew, disableNew_speedlimmits, generelldisable_speedlimmits },
			{ disableRusty, disableNew_speedlimmits, disableRusty_speedlimmits, generelldisable_speedlimmits },
			{ disableRusty, disableRusty_speedlimmits, generelldisable_speedlimmits },
			{ disableNew_speedlimmits, disableRusty_speedlimmits, generelldisable_speedlimmits },
			{ }
		}

		-- trackTypeSetting zu Module Filterlisten
		local trackTypeSetting2ModuleFilterlists = {
			{ moduleNew, moduleNew_speedlimmits, modulesRusty_speedlimmits },
			{ moduleNew, moduleNew_speedlimmits },
			{ modulesRusty, moduleNew_speedlimmits, modulesRusty_speedlimmits },
			{ modulesRusty, modulesRusty_speedlimmits },
			{ moduleNew_speedlimmits, modulesRusty_speedlimmits },
			{ }
		}


		local trackTypeSetting = 0    --default aus params tracktypes defaultIndex von oben
		-- Gibt es eine valide Nutzer Einstellung zurück
		if modParams[getCurrentModId()] ~= nil then
			local params = modParams[getCurrentModId()]
			if (params.tracktypes ~= nil) then
				if (params.tracktypes < #trackTypeSetting2filterlists) then
					trackTypeSetting = params.tracktypes
				else
					print("Error tracktype setting for NEP")
				end
			end
		end

		local nepdebug = true

		-- Wende die Einstellung fuer tracktype filter an:
		local filterlists = trackTypeSetting2filterlists[trackTypeSetting + 1]
		for key, filterlist in ipairs(filterlists) do
			for _, trackFileName in ipairs(filterlist) do
				local trackIndex = api.res.trackTypeRep.find(trackFileName)
				if (nepdebug) then 
					print("NEP Filtering:  "..trackFileName)
				end
				-- if (trackIndex > -1) then
					api.res.trackTypeRep.setVisible(trackIndex, false)
				-- end
			end
		end

		-- Schalte alle UG Gleis Module ab:
		for key, filterlist in ipairs(filterUGModules) do
			for _, trackFileName in ipairs(filterlist) do
				if trackFileName ~= "standard.lua" and trackFileName ~= "high_speed.lua" then  
					local moduleName = "trainstation_"..trackFileName
					local moduleIndex = api.res.moduleRep.find(moduleName)
					-- if (moduleIndex > -1) then
					if (nepdebug) then 
						print("NEP Filtering UG Module:  "..moduleName)
					end
					api.res.moduleRep.setVisible(moduleIndex, false)
					local moduleIndexCat = api.res.moduleRep.find(moduleName.."catenary")
					-- if (moduleIndexCat > -1) then
						if (nepdebug) then 
							print("NEP Filtering UG Module:  "..moduleName.."catenary")
						end
						api.res.moduleRep.setVisible(moduleIndexCat, false)
					-- end
				end
			end
		end

		local filterlistsModule = trackTypeSetting2ModuleFilterlists[trackTypeSetting + 1]
		for key, filterlist in ipairs(filterlistsModule) do
			local path = "station/rail/modular_station/"
			for _, moduleName in ipairs(filterlist) do
				local moduleIndex = api.res.moduleRep.find(path..moduleName)
				-- if (moduleIndex > -1) then
					if (nepdebug) then 
						print("NEP Filtering Module:  "..moduleName)
					end
					api.res.moduleRep.setVisible(moduleIndex, false)
				-- end
			end
		end
		
	end,
}
end