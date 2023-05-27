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
Medium is 50% of the value, low is 25%
If you want to use Further Render Distance, load after this!]],
		 environment_TT = [[
Choose the Environment.
It should be deactivated only if the NEP shaders are disabled.
Tip: You can change the environment ingame with debug settings (AltGr+D)]],
		darkOverlay_TT = [[To avoid eye cancer, this option should stay on unless you disable the NEP shaders]],
		improveLayerConfig_TT = [[More color levels, good/bad colors are red-yellow-green.
Deactivate if you want to use other config mods.]],
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
		makeLzbBetonPolesWhite_TT = "Betonmasten durch weiße(grüne) Masten ersetzen \n(bei LZB ohne Feste Fahrbahn)",
		renderDistance_TT = [[
Sichtweite im Spiel.
Der Wert gilt für Geometrie = Hoch
Mittel ist 50% des Werts, Niedrig 25%
Wenn du Further Render Distance nutzen willst, nach NEP laden!]],
		environment_TT = [[
Wähle die Environment (Umgebung).
Sollte nur deaktiviert werden wenn die NEP shader abgeschaltet sind.
Tipp: Man kann die Environment im Spiel mit den Debug Settings ändern (AltGr+D)]],
		darkOverlay_TT = [[Um Augenkrebs zu vermeiden, sollte diese Option eingeschaltet bleiben, außer man deaktiviert die NEP shader]],
		improveLayerConfig_TT = [[Mehr Farbstufen, Good/Bad Farben sind Rot-Gelb-Grün.
Deaktivieren wenn du andere config Mods nutzen willst.]],
		
		mod_desc = [[
Addon Mod für NEP (Natural Environment Professional)

Diese Mod fügt ein paar Optimierungen zu NEP hinzu. Außerdem finden sich Anleitungen, wie man für sich nur bestimmte Teile des NEP nutzen kann. Abschließend ein paar Worte zu Performance Fragen.

Diese Mod muss nach der NEP Basismod geladen werden!

Features:
- Neue Gleise mit Geschwindigkeiten: 130, 150, 220 km/h
- Feinere Einstellung der Render Distanz (Sichtweite)
- Neue Option: Weiße Masten durch grüne ersetzen
- Neue Option: Bei LZB Gleisen mit Schwellen Betonmasten durch weiße/grüne Masten ersetzen
- Relozu Wassertexturen Fix
- Ändert das Erscheinungsdatum des 600kmh Gleis auf 2050, damit die Farben im Geschwindigkeitslayer nicht so verzerrt werden
- Optimierungen in der config, Farben, überschreibe nicht mehr als nötig
- Allgemeine Mod Kompatibilität verbessert
- Mod Suche mit "NEP" möglich

Installation
- Kopiere die Datei "new_mod.lua_forNEP2.3.lua" in den Dateiordner von NEP "unixroot_natural_environment_pro_tpf2_2"
- Benenne die dortige "mod.lua" um in "mod-original.lua"
- Benenne die neue "new_mod.lua_forNEP2.3.lua" um in "mod.lua"
- Dies muss nach einem NEP Update wiederholt werden
- NEP sollte ab dann nur noch zusammen mit dem Addon geladen werden, ansonsten die originale mod.lua wiederherstellen


Anleitungen zum Deaktivieren von Teilen des NEP (nicht per Modoption möglich)

NEP Shader deaktivieren
Der NEP ersetzt die Shader um die Darstellung auf die eigene Environment, Skybox, Lichtteffekte... anzupassen. In Verbindung mit der Environment ergibt sich der realistischere Look im Gegensatz zur Vanilla Darstellung. Wenn gewünscht, kann man diesen jederzeit abschalten.
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
- Erstelle hier einen neuen Ordner "ground_texture" und füge dort aus dem Basisspiel-Ordner die Datei "res/config/ground_texture/ballast_fill_stone.lua" ein und bennene sie um in "ballast_fill_stone_alternativ.lua"
- Die Datei "res/construction/industry/extension/field.con" umbennen in "field.con1"
- Den Ordner "res/textures/terrain" umbennen in "terrain#dummy"
- Erstelle hier einen neuen Ordner "terrain" und kopiere hierhin von dem #dummy Ordner die 5 Dateien (für die Gleise)
ballast_albedo_new.dds
ballast_metal_gloss_ao_new.dds
ballast_nrml_new.dds
alternativ/ballast_albedo_new.dds
material/ballast.tga
Achtung: In Spielständen mit NEP werden Vanilla Texturen zwar wieder entsprechend zurück ausgetauscht, aber evtl. Bemalung mit NEP exklusiven Texturen geht verloren.

Gleise deaktivieren
Der NEP fügt eine Reihe von Gleisen hinzu und überschreibt gleichzeitig die Vanillagleise (standard, high_speed). Außerdem werden einige Gleismodelle/-materialien überschrieben, sodass auch andere Gleismods betroffen sein können. Die Oberleitungsmasten hingegen wird nicht überschrieben.
Dies ist der Hauptgrund, warum ein Entfernen von NEP problematisch sein kann. Theoretisch muss man zuvor alle Gleise in Standard (120) oder Hochgeschwindigkeit (160) umwandeln.
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
Achtung: Nur für neue Spielstände empfohlen. Andere Spielstände mit NEP Gleisen danach nicht mehr spielbar. Hat man seperat andere Spielstände mit NEP Gleisen, lohnt es sich evtl. 2 Varianten des NEP Ordners zu haben.

Signale deaktivieren
Im Ordner "res/models/model/railroad" die 6 Dateien
grimes_hlsignal_hl10.mdl
grimes_hlsignal_hp1.mdl
grimes_signal_hp1b.mdl
grimes_vorsignal_vr1.mdl
signal_path_a.mdl
signal_path_c.mdl
durch Umbenennen in *.mdl1 unwirksam machen.
Achtung: Kann zu fehlenden Modellen/Signalen führen in Spielständen wo NEP bereits aktiviert wurde.


Performance Auswirkungen von NEP
- Render Distanz: Die erhöhte Sichtweite erfordert gerade auf sehr großen Karten mehr Rechenleistung. Theoretisch sollte der Einfluss nicht zu groß sein, es sei denn es sind schlecht optimierte Lods auf der Karte vorhanden. Außerdem macht wohl die Terrain Darstellung auf älteren Grafikkarten Probleme.
- Shader + Environment: Performance Änderung ist wahrscheinlich sehr gering
- Neue Texturen: Das Austauschen von Texturen ändert erstmal nicht die Leistung. Allerdings erfordern die zusätzlichen Bodentexturen mehr Grafikspeicher. Es gibt ein Limit (255) für aktivierte Bodentexturen im Spiel.
- Gleise: Wie ich rausgefunden habe, fehlen bei manchen Gleisen die Optimierung der Lods, sodass es bei Darstellung von vielen Gleisen zu einer hohen Zahl von Tris kommt (beobachten im Draw Calls Fenster).

]]
	},
}
end