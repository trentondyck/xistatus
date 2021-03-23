_addon.name     = 'xistatus'
_addon.author   = 'Trent'
_addon.version  = '1.0'

-- Documentation: 
-- # Load the script on startup with 'lua load xistatus' in file:
-- C:\Program Files (x86)\Windower4\scripts\init.txt
-- visit the website: http://xistatus.chickenkiller.com/

http = require("socket.http")
ltn12 = require("ltn12")

character = windower.ffxi.get_player().name
linkshell = windower.ffxi.get_player().linkshell
fqdn = 'http://xistatus.chickenkiller.com'

local zones = {
	['0'] = "unknown",
	['1'] = "Phanauet Channel",
	['2'] = "Carpenters' Landing",
	['3'] = "Manaclipper",
	['4'] = "Bibiki Bay",
	['5'] = "Uleguerand Range",
	['6'] = "Bearclaw Pinnacle",
	['7'] = "Attohwa Chasm",
	['8'] = "Boneyard Gully",
	['9'] = "Pso'Xja",
	['10'] = "The Shrouded Maw",
	['11'] = "Oldton Movalpolos",
	['12'] = "Newton Movalpolos",
	['13'] = "Mine Shaft #2716",
	['14'] = "Hall of Transference",
	['15'] = "Abyssea - Konschtat",
	['16'] = "Promyvion - Holla",
	['17'] = "Spire of Holla",
	['18'] = "Promyvion - Dem",
	['19'] = "Spire of Dem",
	['20'] = "Promyvion - Mea",
	['21'] = "Spire of Mea",
	['22'] = "Promyvion - Vahzl",
	['23'] = "Spire of Vahzl",
	['24'] = "Lufaise Meadows",
	['25'] = "Misareaux Coast",
	['26'] = "Tavnazian Safehold",
	['27'] = "Phomiuna Aqueducts",
	['28'] = "Sacrarium",
	['29'] = "Riverne - Site #B01",
	['30'] = "Riverne - Site #A01",
	['31'] = "Monarch Linn",
	['32'] = "Sealion's Den",
	['33'] = "Al'Taieu",
	['34'] = "Grand Palace of Hu'Xzoi",
	['35'] = "The Garden of Ru'Hmet",
	['36'] = "Empyreal Paradox",
	['37'] = "Temenos",
	['38'] = "Apollyon",
	['39'] = "Dynamis - Valkurm",
	['40'] = "Dynamis - Buburimu",
	['41'] = "Dynamis - Qufim",
	['42'] = "Dynamis - Tavnazia",
	['43'] = "Diorama Abdhaljs-Ghelsba",
	['44'] = "Abdhaljs Isle-Purgonorgo",
	['45'] = "Abyssea - Tahrongi",
	['46'] = "Open sea route to Al Zahbi",
	['47'] = "Open sea route to Mhaura",
	['48'] = "Al Zahbi",
	['49'] = "none",
	['50'] = "Aht Urhgan Whitegate",
	['51'] = "Wajaom Woodlands",
	['52'] = "Bhaflau Thickets",
	['53'] = "Nashmau",
	['54'] = "Arrapago Reef",
	['55'] = "Ilrusi Atoll",
	['56'] = "Periqia",
	['57'] = "Talacca Cove",
	['58'] = "Silver Sea route to Nashmau",
	['59'] = "Silver Sea route to Al Zahbi",
	['60'] = "The Ashu Talif",
	['61'] = "Mount Zhayolm",
	['62'] = "Halvung",
	['63'] = "Lebros Cavern",
	['64'] = "Navukgo Execution Chamber",
	['65'] = "Mamook",
	['66'] = "Mamool Ja Training Grounds",
	['67'] = "Jade Sepulcher",
	['68'] = "Aydeewa Subterrane",
	['69'] = "Leujaoam Sanctum",
	['70'] = "Chocobo Circuit",
	['71'] = "The Colosseum",
	['72'] = "Alzadaal Undersea Ruins",
	['73'] = "Zhayolm Remnants",
	['74'] = "Arrapago Remnants",
	['75'] = "Bhaflau Remnants",
	['76'] = "Silver Sea Remnants",
	['77'] = "Nyzul Isle",
	['78'] = "Hazhalm Testing Grounds",
	['79'] = "Caedarva Mire",
	['80'] = "Southern San d'Oria [S]",
	['81'] = "East Ronfaure [S]",
	['82'] = "Jugner Forest [S]",
	['83'] = "Vunkerl Inlet [S]",
	['84'] = "Batallia Downs [S]",
	['85'] = "La Vaule [S]",
	['86'] = "Everbloom Hollow",
	['87'] = "Bastok Markets [S]",
	['88'] = "North Gustaberg [S]",
	['89'] = "Grauberg [S]",
	['90'] = "Pashhow Marshlands [S]",
	['91'] = "Rolanberry Fields [S]",
	['92'] = "Beadeaux [S]",
	['93'] = "Ruhotz Silvermines",
	['94'] = "Windurst Waters [S]",
	['95'] = "West Sarutabaruta [S]",
	['96'] = "Fort Karugo-Narugo [S]",
	['97'] = "Meriphataud Mountains [S]",
	['98'] = "Sauromugue Champaign [S]",
	['99'] = "Castle Oztroja [S]",
	['100'] = "West Ronfaure",
	['101'] = "East Ronfaure",
	['102'] = "La Theine Plateau",
	['103'] = "Valkurm Dunes",
	['104'] = "Jugner Forest",
	['105'] = "Batallia Downs",
	['106'] = "North Gustaberg",
	['107'] = "South Gustaberg",
	['108'] = "Konschtat Highlands",
	['109'] = "Pashhow Marshlands",
	['110'] = "Rolanberry Fields",
	['111'] = "Beaucedine Glacier",
	['112'] = "Xarcabard",
	['113'] = "Cape Teriggan",
	['114'] = "Eastern Altepa Desert",
	['115'] = "West Sarutabaruta",
	['116'] = "East Sarutabaruta",
	['117'] = "Tahrongi Canyon",
	['118'] = "Buburimu Peninsula",
	['119'] = "Meriphataud Mountains",
	['120'] = "Sauromugue Champaign",
	['121'] = "The Sanctuary of Zi'Tah",
	['122'] = "Ro'Maeve",
	['123'] = "Yuhtunga Jungle",
	['124'] = "Yhoator Jungle",
	['125'] = "Western Altepa Desert",
	['126'] = "Qufim Island",
	['127'] = "Behemoth's Dominion",
	['128'] = "Valley of Sorrows",
	['129'] = "Ghoyu's Reverie",
	['130'] = "Ru'Aun Gardens",
	['131'] = "Mordion Gaol",
	['132'] = "Abyssea - La Theine",
	['133'] = "UNKNOWN",
	['134'] = "Dynamis - Beaucedine",
	['135'] = "Dynamis - Xarcabard",
	['136'] = "Beaucedine Glacier [S]",
	['137'] = "Xarcabard [S]",
	['138'] = "Castle Zvahl Baileys [S]",
	['139'] = "Horlais Peak",
	['140'] = "Ghelsba Outpost",
	['141'] = "Fort Ghelsba",
	['142'] = "Yughott Grotto",
	['143'] = "Palborough Mines",
	['144'] = "Waughroon Shrine",
	['145'] = "Giddeus",
	['146'] = "Balga's Dais",
	['147'] = "Beadeaux",
	['148'] = "Qulun Dome",
	['149'] = "Davoi",
	['150'] = "Monastic Cavern",
	['151'] = "Castle Oztroja",
	['152'] = "Altar Room",
	['153'] = "The Boyahda Tree",
	['154'] = "Dragon's Aery",
	['155'] = "Castle Zvahl Keep [S]",
	['156'] = "Throne Room [S]",
	['157'] = "Middle Delkfutt's Tower",
	['158'] = "Upper Delkfutt's Tower",
	['159'] = "Temple of Uggalepih",
	['160'] = "Den of Rancor",
	['161'] = "Castle Zvahl Baileys",
	['162'] = "Castle Zvahl Keep",
	['163'] = "Sacrificial Chamber",
	['164'] = "Garlaige Citadel [S]",
	['165'] = "Throne Room",
	['166'] = "Ranguemont Pass",
	['167'] = "Bostaunieux Oubliette",
	['168'] = "Chamber of Oracles",
	['169'] = "Toraimarai Canal",
	['170'] = "Full Moon Fountain",
	['171'] = "Crawlers' Nest [S]",
	['172'] = "Zeruhn Mines",
	['173'] = "Korroloka Tunnel",
	['174'] = "Kuftal Tunnel",
	['175'] = "The Eldieme Necropolis [S]",
	['176'] = "Sea Serpent Grotto",
	['177'] = "Ve'Lugannon Palace",
	['178'] = "The Shrine of Ru'Avitau",
	['179'] = "Stellar Fulcrum",
	['180'] = "La'Loff Amphitheater",
	['181'] = "The Celestial Nexus",
	['182'] = "Walk of Echoes",
	['183'] = "Maquette Abdhaljs-Legion",
	['184'] = "Lower Delkfutt's Tower",
	['185'] = "Dynamis - San d'Oria",
	['186'] = "Dynamis - Bastok",
	['187'] = "Dynamis - Windurst",
	['188'] = "Dynamis - Jeuno",
	['189'] = "UNKNOWN",
	['190'] = "King Ranperre's Tomb",
	['191'] = "Dangruf Wadi",
	['192'] = "Inner Horutoto Ruins",
	['193'] = "Ordelle's Caves",
	['194'] = "Outer Horutoto Ruins",
	['195'] = "The Eldieme Necropolis",
	['196'] = "Gusgen Mines",
	['197'] = "Crawlers' Nest",
	['198'] = "Maze of Shakhrami",
	['199'] = "UNKNOWN",
	['200'] = "Garlaige Citadel",
	['201'] = "Cloister of Gales",
	['202'] = "Cloister of Storms",
	['203'] = "Cloister of Frost",
	['204'] = "Fei'Yin",
	['205'] = "Ifrit's Cauldron",
	['206'] = "Qu'Bia Arena",
	['207'] = "Cloister of Flames",
	['208'] = "Quicksand Caves",
	['209'] = "Cloister of Tremors",
	['210'] = "UNKNOWN",
	['211'] = "Cloister of Tides",
	['212'] = "Gustav Tunnel",
	['213'] = "Labyrinth of Onzozo",
	['214'] = "UNKNOWN",
	['215'] = "Abyssea - Attohwa",
	['216'] = "Abyssea - Misareaux",
	['217'] = "Abyssea - Vunkerl",
	['218'] = "Abyssea - Altepa",
	['219'] = "UNKNOWN",
	['220'] = "Ship bound for Selbina",
	['221'] = "Ship bound for Mhaura",
	['222'] = "Provenance",
	['223'] = "San d'Oria-Jeuno Airship",
	['224'] = "Bastok-Jeuno Airship",
	['225'] = "Windurst-Jeuno Airship",
	['226'] = "Kazham-Jeuno Airship",
	['227'] = "Ship bound for Selbina",
	['228'] = "Ship bound for Mhaura",
	['229'] = "UNKNOWN",
	['230'] = "Southern San d'Oria",
	['231'] = "Northern San d'Oria",
	['232'] = "Port San d'Oria",
	['233'] = "Chateau d'Oraguille",
	['234'] = "Bastok Mines",
	['235'] = "Bastok Markets",
	['236'] = "Port Bastok",
	['237'] = "Metalworks",
	['238'] = "Windurst Waters",
	['239'] = "Windurst Walls",
	['240'] = "Port Windurst",
	['241'] = "Windurst Woods",
	['242'] = "Heavens Tower",
	['243'] = "Ru'Lude Gardens",
	['244'] = "Upper Jeuno",
	['245'] = "Lower Jeuno",
	['246'] = "Port Jeuno",
	['247'] = "Rabao",
	['248'] = "Selbina",
	['249'] = "Mhaura",
	['250'] = "Kazham",
	['251'] = "Hall of the Gods",
	['252'] = "Norg",
	['253'] = "Abyssea - Uleguerand",
	['254'] = "Abyssea - Grauberg",
	['255'] = "Abyssea - Empyreal Paradox",
	['256'] = "Western Adoulin",
	['257'] = "Eastern Adoulin",
	['258'] = "Rala Waterways",
	['259'] = "Rala Waterways [U]",
	['260'] = "Yahse Hunting Grounds",
	['261'] = "Ceizak Battlegrounds",
	['262'] = "Foret de Hennetiel",
	['263'] = "Yorcia Weald",
	['264'] = "Yorcia Weald [U]",
	['265'] = "Morimar Basalt Fields",
	['266'] = "Marjami Ravine",
	['267'] = "Kamihr Drifts",
	['268'] = "Sih Gates",
	['269'] = "Moh Gates",
	['270'] = "Cirdas Caverns",
	['271'] = "Cirdas Caverns [U]",
	['272'] = "Dho Gates",
	['273'] = "Woh Gates",
	['274'] = "Outer Ra'Kaznar",
	['275'] = "Outer Ra'Kaznar [U]",
	['276'] = "Ra'Kaznar Inner Court",
	['277'] = "Ra'Kaznar Turris",
	['278'] = "UNKNOWN",
	['279'] = "UNKNOWN",
	['280'] = "Mog Garden",
	['281'] = "Leafallia",
	['282'] = "Mount Kamihr",
	['283'] = "Silver Knife",
	['284'] = "Celennia Memorial Library",
	['285'] = "Feretory",
	['286'] = "UNKNOWN",
	['287'] = "UNKNOWN",
	['288'] = "Escha - Zi'Tah",
	['289'] = "Escha - Ru'Aun",
	['290'] = "Desuetia - Empyreal Paradox",
	['291'] = "Reisenjima",
	['292'] = "Reisenjima Henge",
	['293'] = "Reisenjima Sanctorium",
	['294'] = "Dynamis - San d'Oria [D]",
	['295'] = "Dynamis - Bastok [D]",
	['296'] = "Dynamis - Windurst [D]",
	['297'] = "Dynamis - Jeuno [D]",
}

function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	if raw then return s end
	s = string.gsub(s, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

hostname = os.capture("hostname", false)

function linkshellCreate(zone, status)

	-- GET /api/linkshell-detail/linkshell/ HTTP/1.0 200 5445
	url = fqdn.."/api/linkshell-detail/"..linkshell.."/"
	linkshell_id = get(url)

	if tostring(linkshell_id) == "0" then
		local url = fqdn.."/api/linkshell-create/"
		local body = '{ "text": "'..linkshell..'" }'
		linkshell_id = post(url, body)
	end

	-- now we know linkshell exists. lets check if member exists, and belongs to that linkshell
	local url = fqdn.."/api/member-detail/"..character.."/"
	member_id = get(url)
	
	if tostring(member_id) == "0" then
		local url = fqdn.."/api/member-create-or-update/"
		local body = '{ "status": '..tostring(status)..', "zone": "'..zone..'", "character": "'..character..'", "hostname": "'..hostname..'", "linkshell": '..linkshell_id..'}'
		post(url, body)
	else
		memberUpdate(zone, status)
	end
end


function memberUpdate(zone, status)
	if zone ~= nil then
		local url = fqdn.."/api/member-create-or-update/"
		local body = '{ "status": '..tostring(status)..', "zone": "'..zone..'", "character": "'..character..'", "hostname": "'..hostname..'"}'
		linkshell_id = post(url, body)
	end
end

function post(url, body)

	local respbody = {} -- for the response body
	local result, respcode, respheaders, respstatus = http.request {
		url = url,
		method = "POST",
		source = ltn12.source.string(body),
		headers = {
			["content-type"] = "application/json",
			["content-length"] = tostring(#body)
		},
		sink = ltn12.sink.table(respbody)
	}

	respbody = table.concat(respbody)
	return respbody
end

function get(url)
	local body, code, headers, status = http.request(url)
	return body
end

windower.register_event('logout', function()
	status = false
	zone_name = "None"
	memberUpdate(zone_name, status)
end)

windower.register_event('zone change', function()
	status = true
	zone_id = windower.ffxi.get_info().zone
	local zone_name = "UNKNOWN"
	for key, value in pairs(zones) do
		if key == tostring(zone_id) then
			zone_name = value
		end
	end
	memberUpdate(zone_name, status)
end)

windower.register_event('load', function()
	status = true
	zone_id = windower.ffxi.get_info().zone
	local zone_name = "UNKNOWN"

	for key, value in pairs(zones) do
		if key == tostring(zone_id) then
			zone_name = value
		end
	end
	linkshellCreate(zone_name, status)
end)

