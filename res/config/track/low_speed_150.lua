function data()
	local t = { }

	t.name = _("Low-speed tracks 150")
	t.desc = _("Specialized tracks for higher speeds. low 150")

	t.categories = 					{ "1435mm", _("Rusty_rail"), "150 km_h", }

	t.yearFrom = 1953
	t.yearTo = 0

	t.shapeWidth = 4.0
	t.shapeStep = 2.0
	t.shapeSleeperStep = 8/13

	t.ballastHeight = 0.3
	t.ballastCutOff = 0.1

	t.sleeperBase = t.ballastHeight
	t.sleeperLength = 0.20
	t.sleeperWidth = 2.27
	t.sleeperHeight = 0.0633
	t.sleeperCutOff = 0.006

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

	t.speedLimit = 150 / 3.6
	t.speedCoeffs = {0.9, 15.0,0.63 }

	t.ballastMaterial = "track/ballast.mtl"
	t.sleeperMaterial = "track/sleeper_low.mtl"
	t.railMaterial = "track/rail.mtl"
	t.catenaryMaterial = "track/catenary.mtl"
	t.tunnelWallMaterial = "track/tunnel_rail_ug.mtl"
	t.tunnelHullMaterial = "track/tunnel_hull.mtl"

	t.catenaryPoleModel = "railroad/nep_power_pole_2.mdl"
	t.catenaryMultiPoleModel = "railroad/nep_power_pole_1.mdl"
	t.catenaryMultiGirderModel = "railroad/nep_power_pole_1a.mdl"
	t.catenaryMultiInnerPoleModel = "railroad/nep_power_pole_1b.mdl"

	t.bumperModel = "railroad/tracks/nep_bumper_mid.mdl"
	t.switchSignalModel = "railroad/switch_box.mdl"

	t.fillGroundTex = "ballast_fill_stone.lua"
	t.borderGroundTex = "ballast.lua"

	t.railModel ="railroad/tracks/single_rail.mdl"
	t.sleeperModel = "railroad/tracks/single_sleeper_low_speed.mdl"
	t.trackStraightModel = {
		"railroad/tracks/2m_low_speed.mdl",
		"railroad/tracks/4m_low_speed.mdl",
		"railroad/tracks/8m_low_speed.mdl",
		"railroad/tracks/16m_low_speed.mdl",
	}
	
	t.cost = 150.0

	return t
end
