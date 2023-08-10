local delta_time = 1/66

local pLocal = nil;
local pWeapon = nil;

local projectile_line_cords = {};
local projectile_impact_cords = {};

local white_texture = draw.CreateTextureRGBA(string.char(
	0xff, 0xff, 0xff, 0x32,
	0xff, 0xff, 0xff, 0x32,
	0xff, 0xff, 0xff, 0x32,
	0xff, 0xff, 0xff, 0x32
), 2, 2);


local function drawPolygon(vertices)
	local cords = {};

	for i, pos in pairs(vertices) do
		cords[i] = {pos[1], pos[2], 0, 0};
	end

	draw.TexturedPolygon(white_texture, cords, true)
end

local function clamp(a,b,c) return (a<b) and b or (a>c) and c or a; end

local function SetRainbowColor()
	local value = globals.CurTime()*math.pi;

	draw.Color(math.floor(math.sin(value)*126 + 127), math.floor(math.sin(value + 2.1)*126 + 127), math.floor(math.sin(value + 4.2)*126 + 127), 255)
end

local TraceHullProjectile = (function()
	local min = Vector3(-4, -4, -4);
	local max = Vector3(4, 4, 4);
	local func = engine.TraceHull;

	return function(from, to)
		return func(from, to, min, max, MASK_SHOT_HULL)
	end
end)()

local GetProjectileWeaponInfo = (function()
	local definitions = {
		[19]    = 1;
		[206]   = 1;
		[1007]  = 1;
		[1151]  = 1;
		[15077] = 1;
		[15079] = 1;
		[15091] = 1;
		[15092] = 1;
		[15116] = 1;
		[15117] = 1;
		[15142] = 1;
		[15158] = 1;
		
		[996]   = 2;

		[308]   = 3;

		[997]   = 4;
		[1079]  = 4;
		[305]   = 4;

		[351]   = 5;
		[39]    = 5;
		[1081]  = 5;
		[740]   = 5;

		[17]    = 6;
		[204]   = 6;
		[36]    = 6;
		[412]   = 6;

		[56]    = 7;
		[1005]  = 7;
		[1092]  = 7;

		[20]    = 8;
		[207]   = 8;
		[661]   = 8;
		[130]   = 8;

		[1150]  = 9;
	};

	local offset_vectors = {
		[1] = Vector3(16, 8, -6);
		[2] = Vector3(23.5, -8, -3);
		[3] = Vector3(23.5, 12, -3);
		[4] = Vector3(16, 6, -8);
	};

	return function(wep)
		local projectile_case = definitions[wep:GetPropInt("m_iItemDefinitionIndex")];
		local m_flChargeBeginTime =  (pWeapon:GetPropFloat("PipebombLauncherLocalData", "m_flChargeBeginTime") or 0);

		if m_flChargeBeginTime ~= 0 then
			m_flChargeBeginTime = globals.CurTime() - m_flChargeBeginTime;
		end

		if projectile_case == 1 then -- GrenadeLauncher
			return 1216, 0.5, offset_vectors[1], 200, 0.45

		elseif projectile_case == 2 then -- LooseCannon
			return 1453.9, 0.7, offset_vectors[1], 200, 0.5

		elseif projectile_case == 3 then -- LochnLoad
			return 1500, 0.5, offset_vectors[1], 200, 0.225

		elseif projectile_case == 4 then -- CrusadersCrossbow
			return 2400, 0.1, offset_vectors[2], 0, 0

		elseif projectile_case == 5 then -- FlareGun
			return 2000, 0.15, offset_vectors[3], 0, 0

		elseif projectile_case == 6 then -- SyringeGun
			return 1000, 0.15, offset_vectors[4], 0, 0

		elseif projectile_case == 7 then -- Huntsman
			return 1800 + clamp(m_flChargeBeginTime, 0, 1) * 800, 0.2 - clamp(m_flChargeBeginTime, 0, 1) * 0.15, offset_vectors[2], 0, 0

		elseif projectile_case == 8 then -- StickyBomb
			return 900 + clamp(m_flChargeBeginTime / 4, 0, 1) * 1500, 0.5, offset_vectors[1], 200, 0.275

		elseif projectile_case == 9 then -- QuickieBomb
			return 900 + clamp(m_flChargeBeginTime / 1.2, 0, 1) * 1500, 0.5, offset_vectors[1], 200, 0.275
		end

		-- fuck it, error case
		return 0, 0, Vector3(0, 0, 0), 0, 0
	end
end)()


local CalculateNewPosition = (function()
	local exp = math.exp;
	local Scalar = 0;
	local Change = Vector3(0, 0, 0);

	

	-- Im just going to assume everything is a ball, why you ask? fuck you, thats why.
	return function(initPosition, initVelocity, Gravity, Drag, Time)
		Scalar = (Drag == 0) and Time or ((1 - exp(-Drag * Time)) / Drag);

		Change.x = initVelocity.x * Scalar;
		Change.y = initVelocity.y * Scalar;
		Change.z = (initVelocity.z - Gravity * Time) * Scalar

		return initPosition + Change;
	end
end)()



callbacks.Register("CreateMove", function(cmd)
	pLocal = entities.GetLocalPlayer();
	if not pLocal then projectile_line_cords, projectile_impact_cords = {}, {}; return end
	
	pWeapon = pLocal:GetPropEntity("m_hActiveWeapon");
	if not pWeapon then projectile_line_cords, projectile_impact_cords = {}, {}; return end
	if not pWeapon:GetWeaponProjectileType() then projectile_line_cords, projectile_impact_cords = {}, {}; return end

	local projSpeed, projGravity, projOffset, projUpVelocity, projDrag = GetProjectileWeaponInfo(pWeapon);
	if projSpeed == 0 then projectile_line_cords, projectile_impact_cords = {}, {}; return end

	

	delta_time = globals.TickInterval();

	local aimAngle = engine.GetViewAngles();
	local initPosition = pLocal:GetAbsOrigin() + pLocal:GetPropVector("localdata", "m_vecViewOffset[0]") + (pLocal:EstimateAbsVelocity() * delta_time) + (aimAngle:Forward() * projOffset.x) + (aimAngle:Right() * projOffset.y * (pWeapon:IsViewModelFlipped() and -1 or 1)) + (aimAngle:Up() * projOffset.z);
	local initVelocity = aimAngle:Forward() * projSpeed + aimAngle:Up() * projUpVelocity;
	local Gravity = 800 * projGravity;
	local position = initPosition;
	local results = nil;



	projectile_line_cords = {position};
	for i = delta_time, 5, delta_time * 5 do
		results = TraceHullProjectile(position, CalculateNewPosition(initPosition, initVelocity, Gravity, projDrag, i));
		
		position = results.endpos;
		table.insert(projectile_line_cords, position)

		if results.fraction ~= 1 then
			break
		end
	end



	if results then
		local plane = results.plane;
		local origin = results.endpos;

		if plane.z >= 0.99 then
			projectile_impact_cords = {
				origin + Vector3(7.0710678100586, 7.0710678100586, 0),
				origin + Vector3(7.0710678100586, -7.0710678100586, 0),
				origin + Vector3(-7.0710678100586, -7.0710678100586, 0),
				origin + Vector3(-7.0710678100586, 7.0710678100586, 0)
			};

			return

		elseif plane.z <= -0.99 then
			projectile_impact_cords = {
				origin + Vector3(-7.0710678100586, 7.0710678100586, 0),
				origin + Vector3(-7.0710678100586, -7.0710678100586, 0),
				origin + Vector3(7.0710678100586, -7.0710678100586, 0),
				origin + Vector3(7.0710678100586, 7.0710678100586, 0)
			};

			return
		end

		local right = Vector3(-plane.y, plane.x, 0);
		local up = Vector3(plane.z * right.y, -plane.z * right.x, (plane.y * right.x) - (plane.x * right.y));

		local radius = 10 / math.cos(math.asin(plane.z))

		for i = 1, 4 do
			local ang = i * math.pi / 2 + 0.785398163;
			projectile_impact_cords[i] = origin + (right * (radius * math.cos(ang))) + (up * (radius * math.sin(ang)));
		end
	
	else
		projectile_impact_cords = {};

	end
end)



callbacks.Register("Draw", function()
	local wts = client.WorldToScreen;
	local sizeof = #projectile_line_cords;
	local lastScreenPos = nil;


	if sizeof == 0 then
		return
	end

	
	-- Little square
	if #projectile_impact_cords ~= 0 then
		local positions = {};
		local is_error = false;

		for i = 1, 4 do
			positions[i] = wts(projectile_impact_cords[i]);
			
			if not positions[i] then
				is_error = true;
				break
			end
			
		end
		
		if not is_error then
			SetRainbowColor()
			drawPolygon(positions)


			lastScreenPos = positions[4];
			for i = 1, 4 do
				local newScreenPos = wts(projectile_impact_cords[i]);

				draw.Line(lastScreenPos[1], lastScreenPos[2], newScreenPos[1], newScreenPos[2])

				lastScreenPos = newScreenPos;
			end
		end
	end
	


	if sizeof == 1 then
		return
	end


	-- Line
	lastScreenPos = wts(projectile_line_cords[1]);
	draw.Color(255, 255, 255, 255)
	for i = 2, sizeof do
		local newScreenPos = wts(projectile_line_cords[i]);

		if newScreenPos and lastScreenPos then
			draw.Line(lastScreenPos[1], lastScreenPos[2], newScreenPos[1], newScreenPos[2])
		end

		lastScreenPos = newScreenPos;
	end
end)



callbacks.Register("Unload", function()
	draw.DeleteTexture(white_texture)
end)
