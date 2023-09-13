local config = {
	square = {
		enabled = true;
		r = 55;
		g = 255;
		b = 155;
		a = 50;

		size = 10;
	};
	
	line = {
		enabled = true;
		r = 55;
		g = 255;
		b = 55;
		a = 155;

		flags = true; -- flags may decrease performance
		flag_size = 5;
	};

	-- 0.5 to 8, determines the size of the segments traced, lower values = worse performance (default 2.5)
	measure_segment_size = 2.5;
};



-- Boring shit ahead!
local ItemDefinitions = (function()
	local definitions = {
		[222]	= 11;		--Mad Milk                                      tf_weapon_jar_milk
		[812]	= 12;		--The Flying Guillotine                         tf_weapon_cleaver
		[833]	= 12;		--The Flying Guillotine (Genuine)               tf_weapon_cleaver
		[1121]	= 11;		--Mutated Milk                                  tf_weapon_jar_milk

		[18]	= -1;		--Rocket Launcher                               tf_weapon_rocketlauncher
		[205]	= -1;		--Rocket Launcher (Renamed/Strange)             tf_weapon_rocketlauncher
		[127]	= -1;		--The Direct Hit                                tf_weapon_rocketlauncher_directhit
		[228]	= -1;		--The Black Box                                 tf_weapon_rocketlauncher
		[237]	= -1;		--Rocket Jumper                                 tf_weapon_rocketlauncher
		[414]	= -1;		--The Liberty Launcher                          tf_weapon_rocketlauncher
		[441]	= -1;		--The Cow Mangler 5000                          tf_weapon_particle_cannon	
		[513]	= -1;		--The Original                                  tf_weapon_rocketlauncher
		[658]	= -1;		--Festive Rocket Launcher                       tf_weapon_rocketlauncher
		[730]	= -1;		--The Beggar's Bazooka                          tf_weapon_rocketlauncher
		[800]	= -1;		--Silver Botkiller Rocket Launcher Mk.I         tf_weapon_rocketlauncher
		[809]	= -1;		--Gold Botkiller Rocket Launcher Mk.I           tf_weapon_rocketlauncher
		[889]	= -1;		--Rust Botkiller Rocket Launcher Mk.I           tf_weapon_rocketlauncher
		[898]	= -1;		--Blood Botkiller Rocket Launcher Mk.I          tf_weapon_rocketlauncher
		[907]	= -1;		--Carbonado Botkiller Rocket Launcher Mk.I      tf_weapon_rocketlauncher
		[916]	= -1;		--Diamond Botkiller Rocket Launcher Mk.I        tf_weapon_rocketlauncher
		[965]	= -1;		--Silver Botkiller Rocket Launcher Mk.II        tf_weapon_rocketlauncher
		[974]	= -1;		--Gold Botkiller Rocket Launcher Mk.II          tf_weapon_rocketlauncher
		[1085]	= -1;		--Festive Black Box                             tf_weapon_rocketlauncher
		[1104]	= -1;		--The Air Strike                                tf_weapon_rocketlauncher_airstrike
		[15006]	= -1;		--Woodland Warrior                              tf_weapon_rocketlauncher
		[15014]	= -1;		--Sand Cannon                                   tf_weapon_rocketlauncher
		[15028]	= -1;		--American Pastoral                             tf_weapon_rocketlauncher
		[15043]	= -1;		--Smalltown Bringdown                           tf_weapon_rocketlauncher
		[15052]	= -1;		--Shell Shocker                                 tf_weapon_rocketlauncher
		[15057]	= -1;		--Aqua Marine                                   tf_weapon_rocketlauncher
		[15081]	= -1;		--Autumn                                        tf_weapon_rocketlauncher
		[15104]	= -1;		--Blue Mew                                      tf_weapon_rocketlauncher
		[15105]	= -1;		--Brain Candy                                   tf_weapon_rocketlauncher
		[15129]	= -1;		--Coffin Nail                                   tf_weapon_rocketlauncher
		[15130]	= -1;		--High Roller's                                 tf_weapon_rocketlauncher
		[15150]	= -1;		--Warhawk                                       tf_weapon_rocketlauncher

		[442]	= -1;		--The Righteous Bison                           tf_weapon_raygun

		[1178]	= -1;		--Dragon's Fury                                 tf_weapon_rocketlauncher_fireball

		[39]	= 8;		--The Flare Gun                                 tf_weapon_flaregun
		[351]	= 8;		--The Detonator                                 tf_weapon_flaregun
		[595]	= 8;		--The Manmelter                                 tf_weapon_flaregun_revenge
		[740]	= 8;		--The Scorch Shot                               tf_weapon_flaregun
		[1180]	= 0;		--Gas Passer                                    tf_weapon_jar_gas

		[19]	= 5;		--Grenade Launcher                              tf_weapon_grenadelauncher
		[206]	= 5;		--Grenade Launcher (Renamed/Strange)            tf_weapon_grenadelauncher
		[308]	= 5;		--The Loch-n-Load                               tf_weapon_grenadelauncher
		[996]	= 6;		--The Loose Cannon                              tf_weapon_cannon
		[1007]	= 5;		--Festive Grenade Launcher                      tf_weapon_grenadelauncher
		[1151]	= 4;		--The Iron Bomber                               tf_weapon_grenadelauncher
		[15077]	= 5;		--Autumn                                        tf_weapon_grenadelauncher
		[15079]	= 5;		--Macabre Web                                   tf_weapon_grenadelauncher
		[15091]	= 5;		--Rainbow                                       tf_weapon_grenadelauncher
		[15092]	= 5;		--Sweet Dreams                                  tf_weapon_grenadelauncher
		[15116]	= 5;		--Coffin Nail                                   tf_weapon_grenadelauncher
		[15117]	= 5;		--Top Shelf                                     tf_weapon_grenadelauncher
		[15142]	= 5;		--Warhawk                                       tf_weapon_grenadelauncher
		[15158]	= 5;		--Butcher Bird                                  tf_weapon_grenadelauncher

		[20]	= 1;		--Stickybomb Launcher                           tf_weapon_pipebomblauncher
		[207]	= 1;		--Stickybomb Launcher (Renamed/Strange)         tf_weapon_pipebomblauncher
		[130]	= 3;		--The Scottish Resistance                       tf_weapon_pipebomblauncher
		[265]	= 3;		--Sticky Jumper                                 tf_weapon_pipebomblauncher
		[661]	= 1;		--Festive Stickybomb Launcher                   tf_weapon_pipebomblauncher
		[797]	= 1;		--Silver Botkiller Stickybomb Launcher Mk.I     tf_weapon_pipebomblauncher
		[806]	= 1;		--Gold Botkiller Stickybomb Launcher Mk.I       tf_weapon_pipebomblauncher
		[886]	= 1;		--Rust Botkiller Stickybomb Launcher Mk.I       tf_weapon_pipebomblauncher
		[895]	= 1;		--Blood Botkiller Stickybomb Launcher Mk.I      tf_weapon_pipebomblauncher
		[904]	= 1;		--Carbonado Botkiller Stickybomb Launcher Mk.I  tf_weapon_pipebomblauncher
		[913]	= 1;		--Diamond Botkiller Stickybomb Launcher Mk.I    tf_weapon_pipebomblauncher
		[962]	= 1;		--Silver Botkiller Stickybomb Launcher Mk.II    tf_weapon_pipebomblauncher
		[971]	= 1;		--Gold Botkiller Stickybomb Launcher Mk.II      tf_weapon_pipebomblauncher
		[1150]	= 2;		--The Quickiebomb Launcher                      tf_weapon_pipebomblauncher
		[15009]	= 1;		--Sudden Flurry                                 tf_weapon_pipebomblauncher
		[15012]	= 1;		--Carpet Bomber                                 tf_weapon_pipebomblauncher
		[15024]	= 1;		--Blasted Bombardier                            tf_weapon_pipebomblauncher
		[15038]	= 1;		--Rooftop Wrangler                              tf_weapon_pipebomblauncher
		[15045]	= 1;		--Liquid Asset                                  tf_weapon_pipebomblauncher
		[15048]	= 1;		--Pink Elephant                                 tf_weapon_pipebomblauncher
		[15082]	= 1;		--Autumn                                        tf_weapon_pipebomblauncher
		[15083]	= 1;		--Pumpkin Patch                                 tf_weapon_pipebomblauncher
		[15084]	= 1;		--Macabre Web                                   tf_weapon_pipebomblauncher
		[15113]	= 1;		--Sweet Dreams                                  tf_weapon_pipebomblauncher
		[15137]	= 1;		--Coffin Nail                                   tf_weapon_pipebomblauncher
		[15138]	= 1;		--Dressed to Kill                               tf_weapon_pipebomblauncher
		[15155]	= 1;		--Blitzkrieg                                    tf_weapon_pipebomblauncher

		[588]	= -1;		--The Pomson 6000                               tf_weapon_drg_pomson
		[997]	= 9;		--The Rescue Ranger                             tf_weapon_shotgun_building_rescue

		[17]	= 10;		--Syringe Gun                                   tf_weapon_syringegun_medic
		[204]	= 10;		--Syringe Gun (Renamed/Strange)                 tf_weapon_syringegun_medic
		[36]	= 10;		--The Blutsauger                                tf_weapon_syringegun_medic
		[305]	= 9;		--Crusader's Crossbow                           tf_weapon_crossbow
		[412]	= 10;		--The Overdose                                  tf_weapon_syringegun_medic
		[1079]	= 9;		--Festive Crusader's Crossbow                   tf_weapon_crossbow

		[56]	= 7;		--The Huntsman                                  tf_weapon_compound_bow
		[1005]	= 7;		--Festive Huntsman                              tf_weapon_compound_bow
		[1092]	= 7;		--The Fortified Compound                        tf_weapon_compound_bow

		[58]	= 11;		--Jarate                                        tf_weapon_jar
		[1083]	= 11;		--Festive Jarate                                tf_weapon_jar
		[1105]	= 11;		--The Self-Aware Beauty Mark                    tf_weapon_jar
	};

	local definitions_fast = {};

	local size = 0;
	for i, _ in pairs(definitions) do
		size = math.max(size, i);
	end

	for i = 1, size do
		table.insert(definitions_fast, definitions[i] or false)
	end

	-- Its faster to index this table filled with shit than if we just indexed the definitions table
	return definitions_fast;
end)();


local vecLineCords = {};
local vecFlagCords = {};
local vecImpactCords = {};

local physicsEnvironment = physics.CreateEnvironment();
physicsEnvironment:SetGravity( Vector3( 0, 0, -800 ) )
physicsEnvironment:SetAirDensity( 2.0 )
physicsEnvironment:SetSimulationTimestep(1/66)


local physicsObjects = {};

local GetPhysicsObject = (function()
	local caseLast = 1;

	return function(case)
		if case ~= caseLast then
			physicsObjects[caseLast]:Sleep()
			physicsObjects[case]:Wake()

			caseLast = case;
		end

		return physicsObjects[case]
	end
end)()

local white_texture = draw.CreateTextureRGBA(string.char(
	0xff, 0xff, 0xff, config.square.a,
	0xff, 0xff, 0xff, config.square.a,
	0xff, 0xff, 0xff, config.square.a,
	0xff, 0xff, 0xff, config.square.a
), 2, 2);

local drawPolygon = (function()
	local v1x, v1y = 0, 0;
	local function cross(a, b)
		return (b[1] - a[1]) * (v1y - a[2]) - (b[2] - a[2]) * (v1x - a[1])
	end

	local TexturedPolygon = draw.TexturedPolygon;

	return function(vertices)
		local cords, reverse_cords = {}, {};
		local sizeof = #vertices;
		local sum = 0;

		v1x, v1y = vertices[1][1], vertices[1][2];
		for i, pos in pairs(vertices) do
			local convertedTbl = {pos[1], pos[2], 0, 0};

			cords[i], reverse_cords[sizeof - i + 1] = convertedTbl, convertedTbl;

			sum = sum + cross(pos, vertices[(i % sizeof) + 1]);
		end


		TexturedPolygon(white_texture, (sum < 0) and reverse_cords or cords, true)
	end
end)();

local function clamp(a,b,c) return (a<b) and b or (a>c) and c or a; end

local GetProjectileInformation = (function()
	local vecOffsets = {
		Vector3(16, 8, -6),
		Vector3(23.5, -8, -3),
		Vector3(23.5, 12, -3),
		Vector3(16, 6, -8)
	};

	local vecMaxs = {
		Vector3(0, 0, 0),
		Vector3(1, 1, 1),
		Vector3(2, 2, 2),
		Vector3(3, 3, 3)
	};


	return function(ent, is_ducking, case, index, id)
		local m_flChargeBeginTime =  (ent:GetPropFloat("PipebombLauncherLocalData", "m_flChargeBeginTime") or 0);

		if m_flChargeBeginTime ~= 0 then
			m_flChargeBeginTime = globals.CurTime() - m_flChargeBeginTime;
		end

		if case == -1 then -- RocketLauncher, DragonsFury, Pomson, Bison
			local vecOffset, vecThisMaxs, velForward = Vector3(23.5, -8, is_ducking and 8 or -3), vecMaxs[2], 0;
			
			if id == 22 or id == 65 then
				vecOffset.y = (index == 513) and 0 or 12;
				vecThisMaxs = vecMaxs[1];
				velForward = (id == 65) and 2000 or (index == 414) and 1550 or 1100

			elseif id == 109 then
				vecOffset.y, vecOffset.z = 6, -3;

			else
				velForward = 1200;

			end
			
			return vecOffset, velForward, 0, vecThisMaxs, 0

		elseif case == 1 then -- StickyBomb
			return vecOffsets[1], 900 + clamp(m_flChargeBeginTime / 4, 0, 1) * 1500, 200, vecMaxs[3], 0
		
		elseif case == 2 then -- QuickieBomb
			return vecOffsets[1], 900 + clamp(m_flChargeBeginTime / 1.2, 0, 1) * 1500, 200, vecMaxs[3], 0

		elseif case == 3 then -- ScottishResistance, StickyJumper
			return vecOffsets[1], 900 + clamp(m_flChargeBeginTime / 4, 0, 1) * 1500, 200, vecMaxs[3], 0

		elseif case == 4 then -- TheIronBomber
			return vecOffsets[1], 1200, 200, vecMaxs[3], 400, 0.45

		elseif case == 5 then -- GrenadeLauncher, LochnLoad
			return vecOffsets[1], (index == 308) and 1500 or 1200, 200, vecMaxs[3], 400, (index == 308) and 0.225 or 0.45

		elseif case == 6 then -- LooseCannon
			return vecOffsets[1], 1440, 200, vecMaxs[3], 560, 0.5
		
		elseif case == 7 then -- Huntsman
			return vecOffsets[2], 1800 + clamp(m_flChargeBeginTime, 0, 1) * 800, 0, vecMaxs[2], 200 - clamp(m_flChargeBeginTime, 0, 1) * 160

		elseif case == 8 then -- FlareGuns
			return Vector3(23.5, 12, is_ducking and 8 or -3), 2000, 0, vecMaxs[1], 120

		elseif case == 9 then -- CrusadersCrossbow, RescueRanger
			return vecOffsets[2], 2400, 0, (index == 997) and vecMaxs[2] or vecMaxs[4], 80

		elseif case == 10 then -- SyringeGuns
			return vecOffsets[4], 1000, 0, vecMaxs[2], 120
		
		elseif case == 11 then -- Jarate, MadMilk
			return Vector3(23.5, 8, -3), 1000, 200, vecMaxs[4], 450

		elseif case == 12 then -- FlyingGuillotine
			return  Vector3(23.5, 8, -3), 3000, 300, vecMaxs[3], 900, 1.3

		end
	end
end)();

local TraceHull = engine.TraceHull;
local exp = math.exp;
local squareFlatSize = math.cos(math.pi / 4) * config.square.size;
local interval = clamp(config.measure_segment_size, 0.5, 8) / 66;
local vecNewPosition = Vector3(0, 0, 0);
callbacks.Register("CreateMove", "LoadPhysicsObjects", function()
	callbacks.Unregister("CreateMove", "LoadPhysicsObjects")

	if #physicsObjects > 0 then
		print("Holy shit its still alive... debug this! (311)")
		return
	end

	physicsObjects = (function()
		local tbl = {};

		local function new(path)
			local solid, collisionModel = physics.ParseModelByName(path);
			tbl[#tbl + 1] = physicsEnvironment:CreatePolyObject(collisionModel, solid:GetSurfacePropName(), solid:GetObjectParameters());
		end
																								--Grouped together when they have same solid object parameters

		new("models/weapons/w_models/w_stickybomb.mdl")											--Stickybomb
		new("models/workshop/weapons/c_models/c_kingmaker_sticky/w_kingmaker_stickybomb.mdl")	--QuickieBomb
		new("models/weapons/w_models/w_stickybomb_d.mdl")										--ScottishResistance, StickyJumper
		
		tbl[1]:Wake()

		return tbl
	end)();
	
	-- Only make the function run the flag code if we have flags enabled
	if config.line.flags then
		
		local numFallbackFlagDist = interval * 1320;
		callbacks.Register("CreateMove", function(cmd)
			vecLineCords, vecFlagCords, vecImpactCords = {}, {}, {};

			local pLocal = entities.GetLocalPlayer();
			if not pLocal or pLocal:InCond(7) then return end
	
			local pWeapon = pLocal:GetPropEntity("m_hActiveWeapon");
			if not pWeapon or (pWeapon:GetWeaponProjectileType() or 0) < 2 then return end

			

			local m_iItemDefinitionIndex = pWeapon:GetPropInt("m_iItemDefinitionIndex");
			local caseItemDefinition = ItemDefinitions[m_iItemDefinitionIndex] or 0;
			if caseItemDefinition == 0 then return end

			local vecOffset, velForward, velUpward, vecMaxs, Gravity, Drag = GetProjectileInformation(pWeapon, (pLocal:GetPropInt("m_fFlags") & FL_DUCKING) == 2, caseItemDefinition, m_iItemDefinitionIndex, pWeapon:GetWeaponID());
			local vecMins = -vecMaxs;

			local vecPosition, angForward = pLocal:GetAbsOrigin() + pLocal:GetPropVector("localdata", "m_vecViewOffset[0]"), engine.GetViewAngles();

			-- Ghetto way of making sure our projectile isnt spawning in a wall
			local results = TraceHull(vecPosition, vecPosition + (angForward:Forward() * vecOffset.x) + (angForward:Right() * (vecOffset.y * (pWeapon:IsViewModelFlipped() and -1 or 1))) + (angForward:Up() * vecOffset.z), vecMins, vecMaxs, 100679691);
			if results.fraction ~= 1 then return end

			vecPosition = results.endpos;

			-- Fix for weapons that attempt to center the projectile shot based on how far whatever the player is looking at.
			if caseItemDefinition == -1 or (caseItemDefinition >= 7 and caseItemDefinition < 11) and velForward ~= 0 then
				local traceResult = engine.TraceLine(results.startpos, results.startpos + (angForward:Forward() * 2000), 100679691);
				angForward = (((traceResult.fraction <= 0.1) and (results.startpos + (angForward:Forward() * 2000)) or traceResult.endpos) - vecPosition):Angles();
			end
			
			-- Our velocity must be in the corrected direction
			local vecVelocity = (angForward:Forward() * velForward) + (angForward:Up() * velUpward);
			local vecLeft = angForward:Right() * -config.line.flag_size;



			vecLineCords[1] = vecPosition;
			vecFlagCords[1] = vecPosition + vecLeft;

			-- this shit just moves in a straight line, im not going to simulate it...
			if caseItemDefinition == -1 then
				results = TraceHull(vecPosition, vecPosition + (angForward:Forward() * 10000), vecMins, vecMaxs, 100679691);

				if results.startsolid then return end
				
				local numLines = math.floor((results.endpos - results.startpos):Length() / numFallbackFlagDist);
				local vecVelForward = angForward:Forward();
				
				for i = 1, numLines do
					vecLineCords[i + 1] = vecVelForward * (i * numFallbackFlagDist) + vecPosition;
					vecFlagCords[i + 1] = vecLineCords[i + 1] + vecLeft;
				end

				vecLineCords[numLines + 2] = results.endpos;
				vecFlagCords[numLines + 2] = results.endpos + vecLeft;

			elseif caseItemDefinition > 3 then
		
				local numPoints = 1;
				for i = 0.01515, 5, interval do
					local timeScalar = (not Drag) and i or ((1 - exp(-Drag * i)) / Drag);

					vecNewPosition.x = vecVelocity.x * timeScalar + vecPosition.x;
					vecNewPosition.y = vecVelocity.y * timeScalar + vecPosition.y;
					vecNewPosition.z = (vecVelocity.z - Gravity * i) * timeScalar + vecPosition.z;

					results = TraceHull(results.endpos, vecNewPosition, vecMins, vecMaxs, 100679691);

					numPoints = numPoints + 1;
					vecLineCords[numPoints] = results.endpos;
					vecFlagCords[numPoints] = results.endpos + vecLeft;

					if results.fraction ~= 1 then break end
				end
		
			else
				local simulatedObject = GetPhysicsObject(caseItemDefinition);

				simulatedObject:SetPosition(results.endpos, angForward, true)
				simulatedObject:SetVelocity(vecVelocity, Vector3(0, 0, 0))

				for i = 2, 330 do
					results = TraceHull(results.endpos, simulatedObject:GetPosition(), vecMins, vecMaxs, 100679691);

					vecLineCords[i] = results.endpos;
					vecFlagCords[i] = results.endpos + vecLeft;

					if results.fraction ~= 1 then break end

					physicsEnvironment:Simulate(interval)
				end

				physicsEnvironment:ResetSimulationClock()
			end

			if not results or not config.square.enabled then return end

			local plane, origin = results.plane, results.endpos;
			if math.abs(plane.z) >= 0.99 then
				vecImpactCords = {
					origin + Vector3(squareFlatSize, squareFlatSize, 0),
					origin + Vector3(squareFlatSize, -squareFlatSize, 0),
					origin + Vector3(-squareFlatSize, -squareFlatSize, 0),
					origin + Vector3(-squareFlatSize, squareFlatSize, 0)
				};

				return
			end

			local right = Vector3(-plane.y, plane.x, 0);
			local up = Vector3(plane.z * right.y, -plane.z * right.x, (plane.y * right.x) - (plane.x * right.y));

			local radius = config.square.size / math.cos(math.asin(plane.z))

			for i = 1, 4 do
				local ang = i * math.pi / 2 + 0.785398163;
				vecImpactCords[i] = origin + (right * (radius * math.cos(ang))) + (up * (radius * math.sin(ang)));
			end
		end)

	else
		callbacks.Register("CreateMove", function(cmd)
			vecLineCords, vecImpactCords = {}, {};

			local pLocal = entities.GetLocalPlayer();
			if not pLocal or pLocal:InCond(7) then return end
	
			local pWeapon = pLocal:GetPropEntity("m_hActiveWeapon");
			if not pWeapon or (pWeapon:GetWeaponProjectileType() or 0) < 2 then return end



			local m_iItemDefinitionIndex = pWeapon:GetPropInt("m_iItemDefinitionIndex");
			local caseItemDefinition = ItemDefinitions[m_iItemDefinitionIndex] or 0;
			if caseItemDefinition == 0 then return end

			local vecOffset, velForward, velUpward, vecMaxs, Gravity, Drag = GetProjectileInformation(pWeapon, (pLocal:GetPropInt("m_fFlags") & FL_DUCKING) == 2, caseItemDefinition, m_iItemDefinitionIndex, pWeapon:GetWeaponID());
			local vecMins = -vecMaxs;

			local vecPosition, angForward = pLocal:GetAbsOrigin() + pLocal:GetPropVector("localdata", "m_vecViewOffset[0]"), engine.GetViewAngles();

			-- Ghetto way of making sure our projectile isnt spawning in a wall
			local results = TraceHull(vecPosition, vecPosition + (angForward:Forward() * vecOffset.x) + (angForward:Right() * (vecOffset.y * (pWeapon:IsViewModelFlipped() and -1 or 1))) + (angForward:Up() * vecOffset.z), vecMins, vecMaxs, 100679691);
			if results.fraction ~= 1 then return end

			vecPosition = results.endpos;

			-- Fix for weapons that attempt to center the projectile shot based on how far whatever the player is looking at.
			if caseItemDefinition == -1 or (caseItemDefinition >= 7 and caseItemDefinition < 11) and velForward ~= 0 then
				local traceResult = engine.TraceLine(results.startpos, results.startpos + (angForward:Forward() * 2000), 100679691);
				angForward = (((traceResult.fraction <= 0.1) and (results.startpos + (angForward:Forward() * 2000)) or traceResult.endpos) - vecPosition):Angles();
			end
			
			-- Our velocity must be in the corrected direction
			local vecVelocity = (angForward:Forward() * velForward) + (angForward:Up() * velUpward);



			vecLineCords[1] = vecPosition;

			-- this shit just moves in a straight line, im not going to simulate it...
			if caseItemDefinition == -1 then
				results = TraceHull(vecPosition, vecPosition + (vecVelocity * 10), vecMins, vecMaxs, 100679691);

				if results.startsolid then return end
		
				vecLineCords[2] = results.endpos;

			elseif caseItemDefinition > 3 then
		
				local numPoints = 1;
				for i = 0.01515, 5, interval do
					local timeScalar = (not Drag) and i or ((1 - exp(-Drag * i)) / Drag);

					vecNewPosition.x = vecVelocity.x * timeScalar + vecPosition.x;
					vecNewPosition.y = vecVelocity.y * timeScalar + vecPosition.y;
					vecNewPosition.z = (vecVelocity.z - Gravity * i) * timeScalar + vecPosition.z;

					results = TraceHull(results.endpos, vecNewPosition, vecMins, vecMaxs, 100679691);

					numPoints = numPoints + 1;
					vecLineCords[numPoints] = results.endpos;

					if results.fraction ~= 1 then break end
				end
		
			else
				local simulatedObject = GetPhysicsObject(caseItemDefinition);

				simulatedObject:SetPosition(results.endpos, angForward, true)
				simulatedObject:SetVelocity(vecVelocity, Vector3(0, 0, 0))

				for i = 2, 330 do
					results = TraceHull(results.endpos, simulatedObject:GetPosition(), vecMins, vecMaxs, 100679691);

					vecLineCords[i] = results.endpos;

					if results.fraction ~= 1 then break end

					physicsEnvironment:Simulate(interval)
				end

				physicsEnvironment:ResetSimulationClock()
			end

			if not results or not config.square.enabled then return end

			local plane, origin = results.plane, results.endpos;
			if math.abs(plane.z) >= 0.99 then
				vecImpactCords = {
					origin + Vector3(squareFlatSize, squareFlatSize, 0),
					origin + Vector3(squareFlatSize, -squareFlatSize, 0),
					origin + Vector3(-squareFlatSize, -squareFlatSize, 0),
					origin + Vector3(-squareFlatSize, squareFlatSize, 0)
				};

				return
			end

			local right = Vector3(-plane.y, plane.x, 0);
			local up = Vector3(plane.z * right.y, -plane.z * right.x, (plane.y * right.x) - (plane.x * right.y));

			local radius = config.square.size / math.cos(math.asin(plane.z))

			for i = 1, 4 do
				local ang = i * math.pi / 2 + 0.785398163;
				vecImpactCords[i] = origin + (right * (radius * math.cos(ang))) + (up * (radius * math.sin(ang)));
			end
		end)	
	end
end)



local drawLine, WorldToScreen = draw.Line, client.WorldToScreen;
-- Only make the function run the flag code if we have flags enabled
if config.line.flags then
	callbacks.Register("Draw", function()
		local pLocal = entities.GetLocalPlayer();
		if not pLocal or not pLocal:IsAlive() then return end

		local sizeof = #vecLineCords;
		local lastScreenPos = nil;

		if sizeof == 0 then return end

	
		-- Little square
		if #vecImpactCords ~= 0 then
			local positions = {};
			local is_error = false;

			for i = 1, 4 do
				positions[i] = WorldToScreen(vecImpactCords[i]);
			
				if not positions[i] then
					is_error = true;
					break
				end
			
			end
		
			if not is_error then
				draw.Color(config.square.r, config.square.g, config.square.b, 255)
				drawPolygon(positions)


				lastScreenPos = positions[4];
				for i = 1, 4 do
					local newScreenPos = WorldToScreen(vecImpactCords[i]);

					drawLine(lastScreenPos[1], lastScreenPos[2], newScreenPos[1], newScreenPos[2])

					lastScreenPos = newScreenPos;
				end
			end
		end
	


		if sizeof == 1 or not config.line.enabled then return end


		-- Line
		lastScreenPos = WorldToScreen(vecLineCords[1]);
		draw.Color(config.line.r, config.line.g, config.line.b, config.line.a)
		for i = 2, sizeof do
			local newScreenPos = WorldToScreen(vecLineCords[i]);

			if newScreenPos then
				if lastScreenPos then
					drawLine(lastScreenPos[1], lastScreenPos[2], newScreenPos[1], newScreenPos[2])
				end
			
				local flagPos = WorldToScreen(vecFlagCords[i]);
				if flagPos then
					drawLine(flagPos[1], flagPos[2], newScreenPos[1], newScreenPos[2])
				end
			end

			lastScreenPos = newScreenPos;
		end
	end)
else
	callbacks.Register("Draw", function()
		local pLocal = entities.GetLocalPlayer();
		if not pLocal or not pLocal:IsAlive() then return end

		local sizeof = #vecLineCords;
		local lastScreenPos = nil;

		if sizeof == 0 then return end

	
		-- Little square
		if #vecImpactCords ~= 0 then
			local positions = {};
			local is_error = false;

			for i = 1, 4 do
				positions[i] = WorldToScreen(vecImpactCords[i]);
			
				if not positions[i] then
					is_error = true;
					break
				end
			
			end
		
			if not is_error then
				draw.Color(config.square.r, config.square.g, config.square.b, 255)
				drawPolygon(positions)


				lastScreenPos = positions[4];
				for i = 1, 4 do
					local newScreenPos = WorldToScreen(vecImpactCords[i]);

					drawLine(lastScreenPos[1], lastScreenPos[2], newScreenPos[1], newScreenPos[2])

					lastScreenPos = newScreenPos;
				end
			end
		end
	


		if sizeof == 1 or not config.line.enabled then return end


		-- Line
		lastScreenPos = WorldToScreen(vecLineCords[1]);
		draw.Color(config.line.r, config.line.g, config.line.b, config.line.a)
		for i = 2, sizeof do
			local newScreenPos = WorldToScreen(vecLineCords[i]);

			if newScreenPos and lastScreenPos then
				drawLine(lastScreenPos[1], lastScreenPos[2], newScreenPos[1], newScreenPos[2])
			end

			lastScreenPos = newScreenPos;
		end
	end)
end



callbacks.Register("Unload", function()
	for _, object in pairs(physicsObjects) do
		physicsEnvironment:DestroyObject(object)
	end
	physics.DestroyEnvironment(physicsEnvironment)

	draw.DeleteTexture(white_texture)
end)
