function data()
return {
    info = {
        minorVersion = 3,
        severityAdd = "NONE",
        severityRemove = "NONE", 
        name = "Natural Environment Professional (NEP)",
        description = "This is the original Mod. \n\nLoad before NEP Addon! \n\nDo not use this mod alone anymore. First, swap the mod.lua again.",
        tags = { "Europe", "Shader" ,"Track"},
        authors = {
            {
                name = 'UnixRoot',
                role = 'CREATOR',
                text = 'Texturen, Idee',
            },{
                name = 'Grimes',
                role = 'CREATOR',
                text = '3D, Texturen, Idee',
            },{
                name = 'Yoshi',
                role = 'CREATOR',
                text = 'Script',
            },{
                name = 'eis_os',
                role = 'CREATOR',
                text = 'Script',
            },
        },
		url = "https://www.transportfever.net/filebase/entry/5942-natural-environment-professional-2/",
        -- params = {
            -- {
                -- key = "renderDistance",
                -- name = _("Render Distance"),
                -- uiType = "SLIDER",
                -- values = { _("10km"), _("20km"), _("30km"), _("40km"), _("50km"),},
                -- tooltip = _("Choose the render distance."),
                -- defaultIndex = 2,
            -- },{
                -- key = "environment",
                -- name = _("Environment"),
                -- uiType = "COMBOBOX",
                -- values = { _("standard_nep"),_("less_blue_nep"),_("nep_um_6") },
                -- tooltip = _("skybox_tooltip"),
                -- defaultIndex = 0,
            -- },{
                -- key = "tracktypes",
                -- name = _("Select tracktypes"),
                -- uiType = "COMBOBOX",
                -- values = { _("Rusty tracks only"),_("Rusty tracks only with speedlimmits"),_("New tracks only"),_("New tracks only with speedlimmits"),_("New and rusty tracks"),_("New and rusty tracks with speedlimmits") },
                -- tooltip = _("tracks_tooltip"),
                -- defaultIndex = 0,
            -- },
        -- }
    },
    runFn = function (settings, modParams)
		
	end,
	postRunFn = function (settings, modParams)
		assert(natural_environment_pro_addon, "NEP original mod loaded without Addon! Before using NEP alone, swap to the original mod.lua first!")
		assert(not natural_environment_pro, "NEP already loaded !")
		natural_environment_pro = {}
	end,
}
end