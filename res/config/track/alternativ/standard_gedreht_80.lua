function data()
	local t = { }

	t.name = _("Standard tracks 80")
	t.desc = _("Standard tracks with limited speed capabilities. 80")

	t.categories = 					{ _("new_rails"),"1435mm", "80 km_h", } --{ _("new_rails"),"1435mm", }

	t.yearFrom = -1
	t.yearTo = -1

	t.shapeWidth = 4.0
	t.shapeStep = 2.0
	t.shapeSleeperStep = 8/13

	t.ballastHeight = .3
	t.ballastCutOff = .1

	t.sleeperBase = t.ballastHeight
	t.sleeperLength = .26
	t.sleeperWidth = 2.6
	t.sleeperHeight = .054
	t.sleeperCutOff = .005

	t.railTrackWidth = 1.435
	t.railBase = t.sleeperBase + t.sleeperHeight
	t.railHeight = 0.16
	--t.railWidth = 0.0745
t.railWidth = 0.07
	t.railCutOff = 0.012
    
    t.embankmentSlopeLow = 0.75
    t.embankmentSlopeHigh = 2.5

	t.catenaryBase = 5.917 + t.railBase + t.railHeight
	t.catenaryHeight = 1.35
t.catenaryPoleDistance = 24.0
	t.catenaryMaxPoleDistanceFactor = 3.33
	t.catenaryMinPoleDistanceFactor = 0.9

	t.trackDistance = 5.0

	t.minCurveRadius = 44.0
	t.minCurveRadiusBuild = 180

	t.speedLimit = 80.0  / 3.6 -- 120.0 / 3.6
	t.speedCoeffs = { .85, 30.0, .6 }		-- curve speed limit = a * (radius + b) ^ c

	t.ballastMaterial = "track/alternativ/ballast.mtl"
	t.sleeperMaterial = "track/alternativ/sleeper.mtl"
	t.railMaterial = "track/rail.mtl"
	t.catenaryMaterial = "track/catenary.mtl"
	t.tunnelWallMaterial = "track/tunnel_rail_ug.mtl"
	t.tunnelHullMaterial = "track/tunnel_hull.mtl"

	t.catenaryPoleModel = "railroad/nep_power_pole_2_gedreht.mdl"
	t.catenaryMultiPoleModel = "railroad/nep_power_pole_1.mdl"
	t.catenaryMultiGirderModel = "railroad/nep_power_pole_1a.mdl"
	t.catenaryMultiInnerPoleModel = "railroad/nep_power_pole_1b.mdl"

	t.bumperModel = "railroad/tracks/nep_bumper_old.mdl"
	t.switchSignalModel = "railroad/1435_weichenlaterne.mdl"

	t.fillGroundTex = "ballast_fill_stone_alternativ.lua"
	t.borderGroundTex = "ballast.lua"
	
	t.railModel ="railroad/tracks/single_rail.mdl"
	t.sleeperModel = "railroad/tracks/alternativ/single_sleeper_base.mdl"
	t.trackStraightModel = {
		"railroad/tracks/alternativ/2m_base.mdl",
		"railroad/tracks/alternativ/4m_base.mdl",
		"railroad/tracks/alternativ/8m_base.mdl",
		"railroad/tracks/alternativ/16m_base.mdl",
	}

	t.cost = 75.0

	return t
end
