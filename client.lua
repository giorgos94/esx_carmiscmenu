-- Getting the ESX library (Basically all the ESX commands etc.)
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

    -- C O N F I G --
    interactionDistance = 3.5 --The radius you have to be in to interact with the vehicle.
    lockDistance = 25 --The radius you have to be in to lock your vehicle.
    
    --  V A R I A B L E S --
    engineoff = false
    saved = false
    controlsave_bool = false
    IsEngineOn = true
    areWindowsOn = false


-- Register the "/menu" command

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(3)
            
			if IsControlJustReleased(0, 57) and IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
				OpenCarMenu()
			end
			
		end
    end)
    


function OpenCarMenu()

    local elements = {
        {label = 'Engine', value = 'engine'},
        {label = 'Seats', value = 'seats'},
        {label = 'Doors', value = 'doors'},
        {label = 'Windows', value = 'windows'}
    }

    -- Making sure that all menus close before opening a new one
    ESX.UI.Menu.CloseAll()

    -- Opening the new menu
    ESX.UI.Menu.Open(
        'default', -- Type. Always 'default' no matter what.
        GetCurrentResourceName(), -- Namespace. Best to always use "GetCurrentResourceName()" to have something unique.
        'carMenu', -- Name. Choose whatever you want.
        {
            title = 'Car Misc',
            align = 'right',
            elements = elements
        },
        function(data, menu)
            if data.current.value == 'doors' then
                OpenDoorsMenu()
            elseif data.current.value == 'engine' then
                local player = GetPlayerPed(-1)
	
                if (IsPedSittingInAnyVehicle(player)) then 
                    local vehicle = GetVehiclePedIsIn(player,false)
                    
                    if IsEngineOn == true then
                        IsEngineOn = false
                        SetVehicleEngineOn(vehicle,false,false,false)
                    else
                        IsEngineOn = true
                        SetVehicleUndriveable(vehicle,false)
                        SetVehicleEngineOn(vehicle,true,false,false)
                    end
                    
                    while (IsEngineOn == false) do
                        SetVehicleUndriveable(vehicle,true)
                        Citizen.Wait(0)
                    end
                end
            elseif data.current.value == 'seats' then
                OpenSeatsMenu()

            elseif data.current.value == 'windows' then
                openWindowsMenu()
            end
        end,
        -- This part closes the menu on backspace
        function(data, menu)
            ESX.UI.Menu.CloseAll()
        end
    )

end

function OpenDoorsMenu()

        local elements = {
            {label = 'Front Left', value = 'frontleft'},
            {label = 'Front Right', value = 'frontright'},
            {label = 'Rear Left', value = 'rearleft'},
            {label = 'Rear Right', value = 'rearright'},
            {label = 'Trunk', value = 'trunk'},
            {label = 'Hood', value = 'hood'},
            {label = '<-Back->', value = 'back'}
        }

        ESX.UI.Menu.CloseAll()

        ESX.UI.Menu.Open(
            'default', -- Type. Always 'default' no matter what.
            GetCurrentResourceName(), -- Namespace. Best to always use "GetCurrentResourceName()" to have something unique.
            'doorsmenu', -- Name. Choose whatever you want.
            {
                title = 'Doors Menu',
                align = 'right',
                elements = elements
            },
            function(data, menu)
                if data.current.value == 'frontleft' then
                    local player = GetPlayerPed(-1)
                    --if controlsave_bool == true then
                    --    vehicle = saveVehicle
                  --  else
                        vehicle = GetVehiclePedIsIn(player,true)
                    local isopen = GetVehicleDoorAngleRatio(vehicle,0)
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                    
                    if distanceToVeh <= interactionDistance then
                        if (isopen == 0) then
                        SetVehicleDoorOpen(vehicle,0,0,0)
                        else
                        SetVehicleDoorShut(vehicle,0,0)
                        end
                    else
                        ShowNotification("~r~You must be near your vehicle to do that.")
                    end
                elseif data.current.value == 'frontright' then
                    local player = GetPlayerPed(-1)
                   -- if controlsave_bool == true then
                    --    vehicle = saveVehicle
                    --else
                        vehicle = GetVehiclePedIsIn(player,true)
                    local isopen = GetVehicleDoorAngleRatio(vehicle,1)
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                    
                    if distanceToVeh <= interactionDistance then
                        if (isopen == 0) then
                        SetVehicleDoorOpen(vehicle,1,0,0)
                        else
                        SetVehicleDoorShut(vehicle,1,0)
                        end
                    else
                        ShowNotification("~r~You must be near your vehicle to do that.")
                    end
                elseif data.current.value == 'rearleft' then
                    local player = GetPlayerPed(-1)
                  --  if controlsave_bool == true then
                  --      vehicle = saveVehicle
                 --   else
                        vehicle = GetVehiclePedIsIn(player,true)
                    local isopen = GetVehicleDoorAngleRatio(vehicle,2)
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                    
                    if distanceToVeh <= interactionDistance then
                        if (isopen == 0) then
                        SetVehicleDoorOpen(vehicle,2,0,0)
                        else
                        SetVehicleDoorShut(vehicle,2,0)
                        end
                    else
                        ShowNotification("~r~You must be near your vehicle to do that.")
                    end
                elseif data.current.value == 'rearright' then
                    local player = GetPlayerPed(-1)
                   -- if controlsave_bool == true then
                   --     vehicle = saveVehicle
                   -- else
                        vehicle = GetVehiclePedIsIn(player,true)
                    local isopen = GetVehicleDoorAngleRatio(vehicle,3)
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                    
                    if distanceToVeh <= interactionDistance then
                        if (isopen == 0) then
                        SetVehicleDoorOpen(vehicle,3,0,0)
                        else
                        SetVehicleDoorShut(vehicle,3,0)
                        end
                    else
                        ShowNotification("~r~You must be near your vehicle to do that.")
                    end
                elseif data.current.value == 'trunk' then
                    local player = GetPlayerPed(-1)
                 --   if controlsave_bool == true then
                    --    vehicle = saveVehicle
                  --  else
                        vehicle = GetVehiclePedIsIn(player,true)
                    
                    local isopen = GetVehicleDoorAngleRatio(vehicle,5)
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                    
                    if distanceToVeh <= interactionDistance then
                        if (isopen == 0) then
                        SetVehicleDoorOpen(vehicle,5,0,0)
                        else
                        SetVehicleDoorShut(vehicle,5,0)
                        end
                    else
                        ShowNotification("~r~You must be near your vehicle to do that.")
                    end
                elseif data.current.value == 'hood' then
                    local player = GetPlayerPed(-1)
                 --   if controlsave_bool == true then
                  --      vehicle = saveVehicle
                   -- else
                        vehicle = GetVehiclePedIsIn(player,true)
                        
                        local isopen = GetVehicleDoorAngleRatio(vehicle,4)
                        local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                        
                        if distanceToVeh <= interactionDistance then
                            if (isopen == 0) then
                            SetVehicleDoorOpen(vehicle,4,0,0)
                            else
                            SetVehicleDoorShut(vehicle,4,0)
                            end
                        else
                            ShowNotification("~r~You must be near your vehicle to do that.")
                        end
                    elseif data.current.value == 'back' then
                        ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'doorsmenu')
                        OpenCarMenu()
                end
            end,
            -- This part closes the menu on backspace
            function(data, menu)
                ESX.UI.Menu.CloseAll()
            end
        )




end


function OpenSeatsMenu()

    local elements = {
        {label = 'Driver', value = 'driver'},
        {label = 'Passenger', value = 'passenger'},
        {label = 'Left Rear', value = 'leftrear'},
        {label = 'Right Rear', value = 'rightrear'},
        {label = '<-Back->', value = 'back'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', -- Type. Always 'default' no matter what.
        GetCurrentResourceName(), -- Namespace. Best to always use "GetCurrentResourceName()" to have something unique.
        'seatMenu', -- Name. Choose whatever you want.
        {
            title = 'Seat Menu',
            align = 'right',
            elements = elements
        },

        function(data, menu)
            if data.current.value == 'driver' then
                local player = GetPlayerPed(-1)
                if (IsPedSittingInAnyVehicle(player)) then
                vehicle = GetVehiclePedIsIn(player,true)
                SetPedIntoVehicle(player, vehicle, -1)
                end
            elseif data.current.value == 'passenger' then
                local player = GetPlayerPed(-1)
                if (IsPedSittingInAnyVehicle(player)) then
                vehicle = GetVehiclePedIsIn(player,true)
                SetPedIntoVehicle(player, vehicle, 0)
                end
            elseif data.current.value == 'leftrear' then
                local player = GetPlayerPed(-1)
                if (IsPedSittingInAnyVehicle(player)) then
                vehicle = GetVehiclePedIsIn(player,true)
                SetPedIntoVehicle(player, vehicle, 1)
                end
            elseif data.current.value == 'rightrear' then
                local player = GetPlayerPed(-1)
                if (IsPedSittingInAnyVehicle(player)) then
                vehicle = GetVehiclePedIsIn(player,true)
                SetPedIntoVehicle(player, vehicle, 2)
                end
            elseif data.current.value == 'back' then
                ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'seatMenu')
                OpenCarMenu()
            end
        end,

        function(data, menu)
            ESX.UI.Menu.CloseAll()
        end
            )

end

function openWindowsMenu()
    local elements = {
        {label = 'Driver', value = 'driverw'},
        {label = 'Passenger', value = 'passengerw'},
        {label = 'Left Rear', value = 'leftrearw'},
        {label = 'Right Rear', value = 'rightrearw'},
        {label = '<-Back->', value = 'back'}
    }
    -- Making sure that all menus close before opening a new one
    ESX.UI.Menu.CloseAll()
    -- Opening the new menu
    ESX.UI.Menu.Open(
        'default', -- Type. Always 'default' no matter what.
        GetCurrentResourceName(), -- Namespace. Best to always use "GetCurrentResourceName()" to have something unique.
        'windowsMenu', -- Name. Choose whatever you want.
        {
            title = 'Text at the top',
            align = 'right',
            elements = elements
        },
        function(data, menu)
            if data.current.value == 'driverw' then	
                if (IsPedSittingInAnyVehicle(player)) then 
                    local vehicle = GetVehiclePedIsIn(player,false)
                    if areWindowsOn == true then
                        areWindowsOn = false
                        RollDownWindow(vehicle, 0)
                    else
                        areWindowsOn = true
                        RollUpWindow(vehicle,0)
                    end
                    end


            elseif data.current.value == 'passengerw' then
                if (IsPedSittingInAnyVehicle(player)) then 
                    local vehicle = GetVehiclePedIsIn(player,false)
                    if areWindowsOn == true then
                        areWindowsOn = false
                        RollDownWindow(vehicle, 1)
                    else
                        areWindowsOn = true
                        RollUpWindow(vehicle,1)
                    end
                    end
                elseif data.current.value == 'leftrearw' then
                    if (IsPedSittingInAnyVehicle(player)) then 
                        local vehicle = GetVehiclePedIsIn(player,false)
                        if areWindowsOn == true then
                            areWindowsOn = false
                            RollDownWindow(vehicle, 2)
                        else
                            areWindowsOn = true
                            RollUpWindow(vehicle,2)
                    end
                end
                elseif data.current.value == 'rightrearw' then
                        if (IsPedSittingInAnyVehicle(player)) then 
                            local vehicle = GetVehiclePedIsIn(player,false)
                            if areWindowsOn == true then
                                areWindowsOn = false
                                RollDownWindow(vehicle, 3)
                            else
                                areWindowsOn = true
                                RollUpWindow(vehicle,3)
                        end
                    end
                elseif data.current.value == 'back' then
			        ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'windowsMenu')
                    OpenCarMenu()
				end


            
            
        end,



            function(data, menu)
                ESX.UI.Menu.CloseAll()
        end
        )

end
            elements = elements
        },
        function(data, menu)
            if data.current.value == 'doors' then
                OpenDoorsMenu()
            elseif data.current.value == 'engine' then
                local player = GetPlayerPed(-1)
	
                if (IsPedSittingInAnyVehicle(player)) then 
                    local vehicle = GetVehiclePedIsIn(player,false)
                    
                    if IsEngineOn == true then
                        IsEngineOn = false
                        SetVehicleEngineOn(vehicle,false,false,false)
                    else
                        IsEngineOn = true
                        SetVehicleUndriveable(vehicle,false)
                        SetVehicleEngineOn(vehicle,true,false,false)
                    end
                    
                    while (IsEngineOn == false) do
                        SetVehicleUndriveable(vehicle,true)
                        Citizen.Wait(0)
                    end
                end
            elseif data.current.value == 'seats' then
                OpenSeatsMenu()

            elseif data.current.value == 'windows' then
                openWindowsMenu()
            end
        end,
        -- This part closes the menu on backspace
        function(data, menu)
            ESX.UI.Menu.CloseAll()
        end
    )

end

function OpenDoorsMenu()

        local elements = {
            {label = 'Front Left', value = 'frontleft'},
            {label = 'Front Right', value = 'frontright'},
            {label = 'Rear Left', value = 'rearleft'},
            {label = 'Rear Right', value = 'rearright'},
            {label = 'Trunk', value = 'trunk'},
            {label = 'Hood', value = 'hood'},
            {label = '<-Back->', value = 'back'}
        }

        ESX.UI.Menu.CloseAll()

        ESX.UI.Menu.Open(
            'default', -- Type. Always 'default' no matter what.
            GetCurrentResourceName(), -- Namespace. Best to always use "GetCurrentResourceName()" to have something unique.
            'doorsmenu', -- Name. Choose whatever you want.
            {
                title = 'Doors Menu',
                align = 'right',
                elements = elements
            },
            function(data, menu)
                if data.current.value == 'frontleft' then
                    local player = GetPlayerPed(-1)
                    --if controlsave_bool == true then
                    --    vehicle = saveVehicle
                  --  else
                        vehicle = GetVehiclePedIsIn(player,true)
                    local isopen = GetVehicleDoorAngleRatio(vehicle,0)
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                    
                    if distanceToVeh <= interactionDistance then
                        if (isopen == 0) then
                        SetVehicleDoorOpen(vehicle,0,0,0)
                        else
                        SetVehicleDoorShut(vehicle,0,0)
                        end
                    else
                        ShowNotification("~r~You must be near your vehicle to do that.")
                    end
                elseif data.current.value == 'frontright' then
                    local player = GetPlayerPed(-1)
                   -- if controlsave_bool == true then
                    --    vehicle = saveVehicle
                    --else
                        vehicle = GetVehiclePedIsIn(player,true)
                    local isopen = GetVehicleDoorAngleRatio(vehicle,1)
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                    
                    if distanceToVeh <= interactionDistance then
                        if (isopen == 0) then
                        SetVehicleDoorOpen(vehicle,1,0,0)
                        else
                        SetVehicleDoorShut(vehicle,1,0)
                        end
                    else
                        ShowNotification("~r~You must be near your vehicle to do that.")
                    end
                elseif data.current.value == 'rearleft' then
                    local player = GetPlayerPed(-1)
                  --  if controlsave_bool == true then
                  --      vehicle = saveVehicle
                 --   else
                        vehicle = GetVehiclePedIsIn(player,true)
                    local isopen = GetVehicleDoorAngleRatio(vehicle,2)
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                    
                    if distanceToVeh <= interactionDistance then
                        if (isopen == 0) then
                        SetVehicleDoorOpen(vehicle,2,0,0)
                        else
                        SetVehicleDoorShut(vehicle,2,0)
                        end
                    else
                        ShowNotification("~r~You must be near your vehicle to do that.")
                    end
                elseif data.current.value == 'rearright' then
                    local player = GetPlayerPed(-1)
                   -- if controlsave_bool == true then
                   --     vehicle = saveVehicle
                   -- else
                        vehicle = GetVehiclePedIsIn(player,true)
                    local isopen = GetVehicleDoorAngleRatio(vehicle,3)
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                    
                    if distanceToVeh <= interactionDistance then
                        if (isopen == 0) then
                        SetVehicleDoorOpen(vehicle,3,0,0)
                        else
                        SetVehicleDoorShut(vehicle,3,0)
                        end
                    else
                        ShowNotification("~r~You must be near your vehicle to do that.")
                    end
                elseif data.current.value == 'trunk' then
                    local player = GetPlayerPed(-1)
                 --   if controlsave_bool == true then
                    --    vehicle = saveVehicle
                  --  else
                        vehicle = GetVehiclePedIsIn(player,true)
                    
                    local isopen = GetVehicleDoorAngleRatio(vehicle,5)
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                    
                    if distanceToVeh <= interactionDistance then
                        if (isopen == 0) then
                        SetVehicleDoorOpen(vehicle,5,0,0)
                        else
                        SetVehicleDoorShut(vehicle,5,0)
                        end
                    else
                        ShowNotification("~r~You must be near your vehicle to do that.")
                    end
                elseif data.current.value == 'hood' then
                    local player = GetPlayerPed(-1)
                 --   if controlsave_bool == true then
                  --      vehicle = saveVehicle
                   -- else
                        vehicle = GetVehiclePedIsIn(player,true)
                        
                        local isopen = GetVehicleDoorAngleRatio(vehicle,4)
                        local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
                        
                        if distanceToVeh <= interactionDistance then
                            if (isopen == 0) then
                            SetVehicleDoorOpen(vehicle,4,0,0)
                            else
                            SetVehicleDoorShut(vehicle,4,0)
                            end
                        else
                            ShowNotification("~r~You must be near your vehicle to do that.")
                        end
                    elseif data.current.value == 'back' then
                        ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'doorsmenu')
                        OpenCarMenu()
                end
            end,
            -- This part closes the menu on backspace
            function(data, menu)
                ESX.UI.Menu.CloseAll()
            end
        )




end


function OpenSeatsMenu()

    local elements = {
        {label = 'Driver', value = 'driver'},
        {label = 'Passenger', value = 'passenger'},
        {label = 'Left Rear', value = 'leftrear'},
        {label = 'Right Rear', value = 'rightrear'},
        {label = '<-Back->', value = 'back'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', -- Type. Always 'default' no matter what.
        GetCurrentResourceName(), -- Namespace. Best to always use "GetCurrentResourceName()" to have something unique.
        'seatMenu', -- Name. Choose whatever you want.
        {
            title = 'Seat Menu',
            align = 'right',
            elements = elements
        },

        function(data, menu)
            if data.current.value == 'driver' then
                local player = GetPlayerPed(-1)
                if (IsPedSittingInAnyVehicle(player)) then
                vehicle = GetVehiclePedIsIn(player,true)
                SetPedIntoVehicle(player, vehicle, -1)
                end
            elseif data.current.value == 'passenger' then
                local player = GetPlayerPed(-1)
                if (IsPedSittingInAnyVehicle(player)) then
                vehicle = GetVehiclePedIsIn(player,true)
                SetPedIntoVehicle(player, vehicle, 0)
                end
            elseif data.current.value == 'leftrear' then
                local player = GetPlayerPed(-1)
                if (IsPedSittingInAnyVehicle(player)) then
                vehicle = GetVehiclePedIsIn(player,true)
                SetPedIntoVehicle(player, vehicle, 1)
                end
            elseif data.current.value == 'rightrear' then
                local player = GetPlayerPed(-1)
                if (IsPedSittingInAnyVehicle(player)) then
                vehicle = GetVehiclePedIsIn(player,true)
                SetPedIntoVehicle(player, vehicle, 2)
                end
            elseif data.current.value == 'back' then
                ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'seatMenu')
                OpenCarMenu()
            end
        end,

        function(data, menu)
            ESX.UI.Menu.CloseAll()
        end
            )

end

function openWindowsMenu()
    local elements = {
        {label = 'Driver', value = 'driverw'},
        {label = 'Passenger', value = 'passengerw'},
        {label = 'Left Rear', value = 'leftrearw'},
        {label = 'Right Rear', value = 'rightrearw'},
        {label = '<-Back->', value = 'back'}
    }
    -- Making sure that all menus close before opening a new one
    ESX.UI.Menu.CloseAll()
    -- Opening the new menu
    ESX.UI.Menu.Open(
        'default', -- Type. Always 'default' no matter what.
        GetCurrentResourceName(), -- Namespace. Best to always use "GetCurrentResourceName()" to have something unique.
        'windowsMenu', -- Name. Choose whatever you want.
        {
            title = 'Text at the top',
            align = 'right',
            elements = elements
        },
        function(data, menu)
            if data.current.value == 'driverw' then	
                if (IsPedSittingInAnyVehicle(player)) then 
                    local vehicle = GetVehiclePedIsIn(player,false)
                    if areWindowsOn == true then
                        areWindowsOn = false
                        RollDownWindow(vehicle, 0)
                    else
                        areWindowsOn = true
                        RollUpWindow(vehicle,0)
                    end
                    end


            elseif data.current.value == 'passengerw' then
                if (IsPedSittingInAnyVehicle(player)) then 
                    local vehicle = GetVehiclePedIsIn(player,false)
                    if areWindowsOn == true then
                        areWindowsOn = false
                        RollDownWindow(vehicle, 1)
                    else
                        areWindowsOn = true
                        RollUpWindow(vehicle,1)
                    end
                    end
                elseif data.current.value == 'leftrearw' then
                    if (IsPedSittingInAnyVehicle(player)) then 
                        local vehicle = GetVehiclePedIsIn(player,false)
                        if areWindowsOn == true then
                            areWindowsOn = false
                            RollDownWindow(vehicle, 2)
                        else
                            areWindowsOn = true
                            RollUpWindow(vehicle,2)
                    end
                end
                elseif data.current.value == 'rightrearw' then
                        if (IsPedSittingInAnyVehicle(player)) then 
                            local vehicle = GetVehiclePedIsIn(player,false)
                            if areWindowsOn == true then
                                areWindowsOn = false
                                RollDownWindow(vehicle, 3)
                            else
                                areWindowsOn = true
                                RollUpWindow(vehicle,3)
                        end
                    end
                elseif data.current.value == 'back' then
			        ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'windowsMenu')
                    OpenCarMenu()
				end


            
            
        end,



            function(data, menu)
                ESX.UI.Menu.CloseAll()
        end
        )

end
