function data()
return {
	en = {
		["nep_temperate.lua"] = "NEP at noon",
		["nep_temperate_less_blue.lua"] = "NEP at noon, less blue in shadows",
		["nep_um_6.lua"] = "NEP early in the morning",
		
		 makeWhitePolesGreen_name = "Replace white catenary poles with green",
		 makeLzbBetonPolesWhite_name = "Replace concrete catenary poles with white(green)",
		 makeLzbBetonPolesWhite_TT = "Replace concrete catenary poles with white(green) \n(for LZB with sleepers)",
		 renderDistance_TT = [[
Ingame Render Distance.
The value is for geometry = high
Medium uses 50% of the value, low 25%
If you want to use Further Render Distance, load after this!]],
		 environment_TT = [[
Choose the Environment.
The dedicated NEP environment should be deactivated (-) only if the NEP shaders are disabled.
Tip: You can change the environment ingame with debug settings (AltGr+D)]],
		darkOverlay_TT = [[To avoid eye cancer, this option should stay on unless you disable the NEP shaders]],
		improveLayerConfig_TT = [[More color levels, good/bad colors are red-yellow-green.
Deactivate if you want to use other config mods.]],
		
		mod_desc = [[
Add-on mod for NEP (Natural Environment Professional) with extensions/improvements

The Addon must be loaded after the NEP base mod!

This mod adds some optimizations to NEP (currently compatible with NEP 2.3). There are also instructions on how to use only certain sub-features of NEP. Finally, a few words on performance issues.

Features:
- Additional tracks with speeds: 130, 150, 220 km/h
- Additional track modules: 80, 300 km/h
- Finer adjustment of render distance
- New option: Replace white poles with green ones
- New option: Replace concrete poles with classic poles for LZB tracks (block track excluded)
- Fix of water reflection for water textures (Relozu)
- Change the availability of the 600kmh track to 2050, so that the colors in the speed layer are not distorted
- Optimizations in the config, colors, do not overwrite more than necessary
- General mod compatibility improved
- Mod search with "NEP" possible

Installation
- Unpack the NEP Addon in the local/mods folder
- Copy the file "new_mod.lua_forNEP2.3.lua" from the Addon folder into the NEP folder "unixroot_natural_environment_pro_tpf2_2"
- There, rename the "mod.lua" to "mod-original.lua"
- Rename the "new_mod.lua_forNEP2.3.lua" to "mod.lua"
- From now on, NEP should only be loaded together with the Addon! 

Uninstallation
- Delete the mod.lua in the NEP folder "unixroot_natural_environment_pro_tpf2_2"
- Restore the original mod.lua by renaming "mod-original.lua"
- Remove the folder of this mod


Instructions for deactivating NEP sub-features
NEP adds different types of content to the game (tracks, textures, shaders) but some players only want to use certain parts of it. Below I put together step-by-step instructions that make it possible to deactivate certain functionalities of NEP. This is only possible in this way (not via mod option). In principle, the tutorials can also be used without the NEP Addon.

All steps are reversible. However, removing resources leads to problems with existing savegames (if used there) and should therefore generally only be used for new saves. If you have existing savegames using NEP content, maybe create 2 versions of the NEP mod folder.

Deactivate shaders
The NEP replaces the shaders in order to adapt the visualization to its own environment, skybox, lighting effects etc. In combination with the environment, this results in a more realistic look in contrast to the vanilla look. If desired, this can be switched off at any time (and vice versa).
- Rename the folder "unixroot_natural_environment_pro_tpf2_2/res/shaders2" to "shaders2#dummy"
- Rename the folder "vt_natural_environment_pro_addon_1/res/shaders2" to "shaders2#dummy"
- If you want to restore the vanilla look completely, set the environment to "-" (mod option)
- If desired, you can now also make the overlays bright (mod option)

Deactivate ground textures
The NEP replaces some of the vanilla ground textures, changing the appearance of grass, fields and other textures. New ground textures are also added (painting tool). Since files from ground_texture and grass also access the new ground textures, these must also be deactivated. The NEP tracks access the changed ballast, which is why the ballast looks different here.
- Go to the NEP base folder (unixroot_natural_environment_pro_tpf2_2)
- Rename the folder "res/config/terrain_material" to "terrain_material#dummy"
- Rename the folder "res/config/grass" to "grass#dummy"
- Rename the folder "res/config/ground_texture" to "ground_texture#dummy"
- Create a new folder "ground_texture" here and add the file "res/config/ground_texture/ballast_fill_stone.lua" from the TPF2 base folder and rename it to "ballast_fill_stone_alternativ.lua"
- Rename the file "res/construction/industry/extension/field.con" to "field.con1"
- Rename the folder "res/textures/terrain" to "terrain#dummy"
- Create a new folder "terrain" and copy the 5 files (for tracks) from the #dummy folder into it:
ballast_albedo_new.dds
ballast_metal_gloss_ao_new.dds
ballast_nrml_new.dds
alternative/ballast_albedo_new.dds
material/ballast.tga
Warning: In savegames with NEP, vanilla textures will be restored accordingly, but any painting with NEP specific textures will be lost.

Deactivate tracks
The NEP adds a number of tracks and at the same time overwrites the vanilla tracks (standard.lua, high_speed.lua). In addition, some track models/materials are overwritten, so that other track mods might be affected. The catenary masts are not overwritten.
This is the main reason why removing NEP as a whole can be problematic. Theoretically, you must first convert all tracks to standard (120), high speed (160) or other track mods.
- Go to the NEP base folder (unixroot_natural_environment_pro_tpf2_2)
- Rename the folder "res/config/track" to "track#dummy"
- Rename the folder "res/construction/station" to "station#dummy"
- Rename the "res/models/model/railroad/tracks" folder to "tracks#dummy"
- In the folder "res/models/material/track" rename the files ballast.mtl, catenary.mtl, rail.mtl, sleeper.mtl, sleeper_concrete.mtl to *.mtl1
- Rename the folder "res/textures/tracks" to "tracks#dummy"
- Rename the folder "res/textures/ui/tracks" to "tracks#dummy"
- Go to the Addon folder (vt_natural_environment_pro_addon_1)
- Rename the folder "res/config/track" to "track#dummy"
- Rename the folder "res/textures/ui/tracks" to "tracks#dummy"
- Open the mod.lua, search for "tracks_disabled" and write there "local tracks_disabled = true" 
Warning: Only recommended for new savegames. Existing saves with NEP tracks will no longer be playable or will be replaced with dummy tracks. 

Deactivate signals
In the folder "res/models/model/railroad" rename the 6 files
grimes_hlsignal_hl10.mdl
grimes_hlsignal_hp1.mdl
grimes_signal_hp1b.mdl
grimes_pre-signal_vr1.mdl
signal_path_a.mdl
signal_path_c.mdl
to *.mdl1 to make them ineffective.
Warning: May lead to missing models/signals in savegames where NEP was used.


Performance impacts of NEP
- Render distance: Higher viewing distances require more computing power, especially on very large maps. At least this can adjusted via mod option. The impact should not be too great, unless there are models with poorly optimized lods on the map. In addition, the terrain rendering seems to use high load on older graphics cards.
- Shader + Environment: Performance impact is probably very low.
- New textures: Replacing textures does not change the performance at first. However, the additional ground textures require more graphics memory. There is a limit (255) for activated ground textures in the game.
- Tracks: As I found out, the lods of track sleepers and catenary masts are not optimal. When many tracks are displayed this leads to a high number of tris (see Draw Calls window).

]]
	},
	de = {
		["nep_temperate.lua"] = "NEP zur Mittagszeit",
		["nep_temperate_less_blue.lua"] = "NEP zur Mittagszeit, weniger Blau in den Schatten",
		["nep_um_6.lua"] = "NEP früh am Morgen",
		
		["Render Distance"] = "Sichtweite (Render Distanz)",
		["Improve Overlay Config"] = "Overlay config verbessern",
		["Make white overlay dark"] = "Weißes Overlay dunkel machen",
		["Select tracktypes"] = "Verfügbare Gleise auswählen",
		["Rusty tracks only"] = ("Nur rostige Schwellen und Gleisbett"),
		["Rusty tracks only with speedlimmits"] = ("Nur rostige Schwellen und Gleisbett mit zusätzlichen Gleisgeschwindigkeiten"),
		["New tracks only"] = ("Nur neuwertige Schwellen und Gleisbett"),
		["New tracks only with speedlimmits"] = ("Nur neuwertige Schwellen und Gleisbett mit zusätzlichen Gleisgeschwindigkeiten"),
		["New and rusty tracks"] = ("Rostige und neuwertige Schwellen und Gleisbett"),
		["New and rusty tracks with speedlimmits"] = ("Rostige und neuwertige Schwellen und Gleisbett mit zusätzlichen Gleisgeschwindigkeiten"),
		["Rusty_rail"] = ("Rostige Schwellen und Gleisbett"),
		["new_rails"] = ("Neuwertige Schwellen und Gleisbett"),
		
		makeWhitePolesGreen_name = "Weiße Masten durch grüne ersetzen",
		makeLzbBetonPolesWhite_name = "Betonmasten durch weiße(grüne) Masten ersetzen",
		makeLzbBetonPolesWhite_TT = "Betonmasten durch weiße(grüne) Masten ersetzen \n(bei LZB, Feste Fahrbahn ausgenommen)",
		renderDistance_TT = [[
Sichtweite im Spiel.
Der Wert gilt für Geometrie = Hoch
Mittel erzeugt 50% des Werts, Niedrig 25%
Wenn du Further Render Distance nutzen willst, nach NEP laden!]],
		environment_TT = [[
Wähle die Environment (Umgebung).
Die spezielle NEP Umgebung sollte nur deaktiviert werden (-) wenn die NEP Shader abgeschaltet sind.
Tipp: Man kann die Environment während des Spiels mit den Debug Settings ändern (AltGr+D)]],
		darkOverlay_TT = [[Um Augenkrebs zu vermeiden, sollte diese Option eingeschaltet bleiben, außer man deaktiviert die NEP shader]],
		improveLayerConfig_TT = [[Mehr Farbstufen, Good/Bad Farben sind Rot-Gelb-Grün.
Deaktivieren wenn du andere config Mods nutzen willst.]],
		
		mod_desc = [[
Add-on Mod für NEP (Natural Environment Professional) mit Erweiterungen/Verbesserungen

Das Addon muss nach der NEP Basis Mod geladen werden!

Diese Mod fügt einige Optimierungen zu NEP hinzu (derzeit kompatibel zu NEP 2.3). Außerdem finden sich Anleitungen, wie man nur bestimmte Teilfunktionen von NEP nutzen kann. Abschließend ein paar Worte zu Performance Fragen.

Features:
- Zusätzliche Gleise mit Geschwindigkeiten: 130, 150, 220 km/h
- Zusätzliche Gleismodule: 80, 300 km/h
- Feinere Einstellung der Renderdistanz (Sichtweite)
- Neue Option: Weiße Masten durch grüne ersetzen
- Neue Option: Bei LZB Gleisen Betonmasten durch klassische Masten ersetzen (Feste Fahrbahn ausgenommen)
- Fix von Wasser Reflexion bei Wassertexturen (Relozu)
- Ändert das Erscheinungsdatum des 600kmh Gleis auf 2050, damit die Farben im Geschwindigkeitslayer nicht so verzerrt werden
- Optimierungen in der config, Farben, überschreibe nicht mehr als nötig
- Allgemeine Mod Kompatibilität verbessert
- Mod Suche mit "NEP" möglich

Installation
- Das NEP Addon im local/mods Ordner entpacken
- Kopiere die Datei "new_mod.lua_forNEP2.3.lua" aus dem Ordner des Addon in den Dateiordner von NEP "unixroot_natural_environment_pro_tpf2_2"
- Benenne die dortige "mod.lua" um in "mod-original.lua"
- Benenne die neue "new_mod.lua_forNEP2.3.lua" um in "mod.lua"
- NEP sollte ab dann nur noch zusammen mit Addon geladen werden! 

Deinstallation
- Im NEP Ordner "unixroot_natural_environment_pro_tpf2_2" die mod.lua löschen
- Die originale mod.lua wiederherstellen durch umbennen von "mod-original.lua"
- Den Ordner dieser Mod löschen


Anleitungen zum Deaktivieren von NEP Teilfunktionen
NEP fügt viele verschiedene Inhalte zum Spiel hinzu (Gleise, Texturen, Shader) aber manche Spieler möchten nur bestimmte Teile davon nutzen. Nachfolgend stelle ich Schritt-für-Schritt Anleitungen zusammen, mit denen es möglich ist, einzelne Funktionen von NEP zu deaktivieren. Dies ist leider nur so und nicht einfacher (per Modoption) möglich. Die Tutorials sind prinzipiell auch ohne NEP Addon anwendbar.

Die Schritte sind alle reversibel gestaltet. Allerdings führt das Entfernen von Resourcen zu Problemen mit älteren Spielständen (wenn dort verwendet) und sollte daher tendenziell nur für neue Karten eingesetzt werden. Hat man seperat andere Spielstände mit NEP Inhalten, lohnt es sich evtl. 2 Varianten des NEP Ordners zu haben.

Shader deaktivieren
Der NEP ersetzt die Shader, um die Darstellung auf die eigene Environment, Skybox, Lichtteffekte... anzupassen. In Verbindung mit der Environment ergibt sich der realistischere Look im Gegensatz zur Vanilla Darstellung. Wenn gewünscht, kann man diesen jederzeit abschalten (und umgekehrt).
- Den Ordner "unixroot_natural_environment_pro_tpf2_2/res/shaders2" umbennen in "shaders2#dummy"
- Den Ordner "vt_natural_environment_pro_addon_1/res/shaders2" umbennen in "shaders2#dummy"
- Will man den kompletten Vanilla Look zurück, sollte man das Environment auf "-" stellen (Modoption)
- Falls gewünscht, kann man jetzt auch das Overlay wieder hell machen (Modoption)

Bodentexturen deaktivieren
Der NEP ersetzt einige der Vanilla Bodentexturen und ändert damit das Aussehen von Gras, Feldern und anderen Texturen. Außerdem werden neue Bodentexturen hinzugefügt (Mal-Tools). Da auch Dateien aus ground_texture und grass auf die neuen Bodentexturen zugreifen, müssen diese mit deaktiviert werden. Die NEP Gleise greifen auf den geänderten Schotter zu, weswegen hier die Schotterdarstellung anders aussieht.
- Gehe in den NEP Basis Ordner (unixroot_natural_environment_pro_tpf2_2)
- Den Ordner "res/config/terrain_material" umbennen in "terrain_material#dummy"
- Den Ordner "res/config/grass" umbennen in "grass#dummy"
- Den Ordner "res/config/ground_texture" umbennen in "ground_texture#dummy"
- Erstelle hier einen neuen Ordner "ground_texture" und füge dort aus dem TPF2 Basis Ordner die Datei "res/config/ground_texture/ballast_fill_stone.lua" ein und bennene sie um in "ballast_fill_stone_alternativ.lua"
- Die Datei "res/construction/industry/extension/field.con" umbennen in "field.con1"
- Den Ordner "res/textures/terrain" umbennen in "terrain#dummy"
- Erstelle hier einen neuen Ordner "terrain" und kopiere hierhin von dem #dummy Ordner die 5 Dateien (für die Gleise):
ballast_albedo_new.dds
ballast_metal_gloss_ao_new.dds
ballast_nrml_new.dds
alternativ/ballast_albedo_new.dds
material/ballast.tga
Achtung: In Spielständen mit NEP werden Vanilla Texturen zwar wieder entsprechend zurück ausgetauscht, aber evtl. Bemalung mit NEP exklusiven Texturen geht verloren.

Gleise deaktivieren
Der NEP fügt eine Reihe von Gleisen hinzu und überschreibt gleichzeitig die Vanillagleise (standard.lua, high_speed.lua). Außerdem werden einige Gleismodelle/-materialien überschrieben, sodass auch andere Gleismods betroffen sein können. Die Oberleitungsmasten hingegen wird nicht überschrieben.
Dies ist der Hauptgrund, warum ein Entfernen von NEP insgesamt problematisch sein kann. Theoretisch muss man zuvor alle Gleise in Standard (120), Hochgeschwindigkeit (160) oder andere Gleismods umwandeln.
- Gehe in den NEP Basis Ordner (unixroot_natural_environment_pro_tpf2_2)
- Den Ordner "res/config/track" umbennen in "track#dummy"
- Den Ordner "res/construction/station" umbennen in "station#dummy"
- Den Ordner "res/models/model/railroad/tracks" umbennen in "tracks#dummy"
- Im Ordner "res/models/material/track" die Dateien ballast.mtl, catenary.mtl, rail.mtl, sleeper.mtl, sleeper_concrete.mtl umbennen in *.mtl1
- Den Ordner "res/textures/tracks" umbennen in "tracks#dummy"
- Den Ordner "res/textures/ui/tracks" umbennen in "tracks#dummy"
- Gehe in den Addon Ordner (vt_natural_environment_pro_addon_1)
- Den Ordner "res/config/track" umbennen in "track#dummy"
- Den Ordner "res/textures/ui/tracks" umbennen in "tracks#dummy"
- Öffne die mod.lua, suche nach "tracks_disabled" und schreibe dort "local tracks_disabled = true"
Achtung: Nur für neue Spielstände empfohlen. Bestehende Spielstände mit NEP Gleisen sind danach nicht mehr spielbar oder werden mit dummy Gleisen ersetzt. 

Signale deaktivieren
Im Ordner "res/models/model/railroad" die 6 Dateien
grimes_hlsignal_hl10.mdl
grimes_hlsignal_hp1.mdl
grimes_signal_hp1b.mdl
grimes_vorsignal_vr1.mdl
signal_path_a.mdl
signal_path_c.mdl
durch Umbenennen in *.mdl1 unwirksam machen.
Achtung: Kann zu fehlenden Modellen/Signalen führen in Spielständen wo NEP genutzt wurde.


Performance Auswirkungen von NEP
- Render Distanz: Höhere Sichtweiten erfordern gerade auf sehr großen Karten mehr Rechenleistung, was aber immerhin per Modoption eingestellt werden kann. Theoretisch sollte der Einfluss nicht zu groß sein, es sei denn es sind Modelle mit schlecht optimierten Lods auf der Karte vorhanden. Außerdem erzeugt auf älteren Grafikkarten wohl die Terrain Darstellung hohe Last.
- Shader + Environment: Performance Einfluss ist wahrscheinlich sehr gering.
- Neue Texturen: Das Austauschen von Texturen ändert erstmal nicht die Leistung. Allerdings erfordern die zusätzlichen Bodentexturen mehr Grafikspeicher. Es gibt ein Limit (255) für aktivierte Bodentexturen im Spiel.
- Gleise: Wie ich rausgefunden habe, sind die Lods bei den Gleisschwellen und Oberleitungsmasten nicht optimal, sodass es bei Darstellung von vielen Gleisen zu einer hohen Zahl von Tris kommt (siehe Draw Calls Fenster).

]]
	},
}
end