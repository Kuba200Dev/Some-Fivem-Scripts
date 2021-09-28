-----------------------------------------------------------------------------------------------------------------------
-------------Skrypt stworzony przez Kuba200#2512 dla ScrapRoleplay "jebać pascolda bo robi mi loda (-------------------
-----------------------------------------------------------------------------------------------------------------------

ESX = nil

onDuty = false
hasCar = false
working = false
hasWashed = false
hasBox = false
local done, AmountPayout = 0, 0
local Plate = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

-- START PRACY
Citizen.CreateThread(function()
    while true do

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local InVehicle = IsPedInAnyVehicle(ped, false)
        local sleep = 500

        if PlayerData.job ~= nil and PlayerData.job.grade_name == 'fruitpicker' then
            if not onDuty then
                if (GetDistanceBetweenCoords(pos, Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z, true) < 10) then
                    sleep = 6
                    DrawMarker(2, Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos, Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z, true) < 1.5) then
                        sleep = 6
                        DrawText3D(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z + 0.4, '~g~[E]~s~ - Przebierz się w robocze ciuchy')
                        if IsControlJustPressed(0, Keys["E"]) then
                            if not InVehicle then
                                exports.rprogress:Custom({
                                    Duration = 2500,
                                    Label = "Zmieniasz ubrania...",
                                    Animation = {
                                        scenario = "WORLD_HUMAN_COP_IDLES",
                                        animationDictionary = "idle_a",
                                    },
                                    DisableControls = {
                                        Mouse = false,
                                        Player = true,
                                        Vehicle = true
                                    }
                                })
                                Citizen.Wait(2500)
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes.male)
                                elseif skin.sex == 1 then
                                    TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes.female)
                                end
                                exports['pnpNotify']:Alert("Sadownik", "Zacząłeś prace", 5000, 'info')
                                onDuty = true
                                blips()
                                end)
                            else
                                exports['pnpNotify']:Alert("Sadownik", "Wyjdź z pojazdu", 5000, 'info')
                            end
                        end
                    end
                end
            elseif onDuty then
                if (GetDistanceBetweenCoords(pos, Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z, true) < 10) then
                    sleep = 6
                    DrawMarker(2, Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos, Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z, true) < 1.5) then
                        sleep = 6
                        DrawText3D(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z + 0.4, '~r~[E]~s~ - Przebierz się w normalne ciuchy')
                        if IsControlJustPressed(0, Keys["E"]) then
                            if not InVehicle then
                                exports.rprogress:Custom({
                                    Duration = 2500,
                                    Label = "Zmieniasz ubrania...",
                                    Animation = {
                                        scenario = "WORLD_HUMAN_COP_IDLES", -- https://pastebin.com/6mrYTdQv
                                        animationDictionary = "idle_a", -- https://alexguirre.github.io/animations-list/
                                    },
                                    DisableControls = {
                                        Mouse = false,
                                        Player = true,
                                        Vehicle = true
                                    }
                                })
                                Citizen.Wait(2500)
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                exports['pnpNotify']:Alert("Sadownik", "Skończyłeś pracę!", 5000, 'info')
                                onDuty = false
                                working = false
                                hasWashed = false
                                hasBox = false
                                hasCar = false
                                done = 0
                                AmountPayout = 0
                                RemoveBlip(blip1)
                                RemoveBlip(blip2)
                                RemoveBlip(blip3)
                                for i, v in ipairs(Config.OrangeSpots) do
                                    RemoveBlip(v.blip)
                                    v.taked = true
                                end
                                for i, v in ipairs(Config.AppleSpots) do
                                    RemoveBlip(v.blip)
                                    v.taked = true
                                end
                                for i, v in ipairs(Config.StrawberrySpots) do
                                    RemoveBlip(v.blip)
                                    v.taked = true
                                end
                                end)
                            else
                                exports['pnpNotify']:Alert("Sadownik", "Wyjdź z pojazdu", 5000, 'info')
                            end
                        end
                    end
                end
            end
        end
    Citizen.Wait(sleep)
    end
end)

-- DEOPZYT AUTKA
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local InVehicle = IsPedInAnyVehicle(ped, false)

        if PlayerData.job ~= nil and PlayerData.job.grade_name == 'fruitpicker' then
            if onDuty then
                if (GetDistanceBetweenCoords(pos, Config.Locations["cardeposit"].coords.x, Config.Locations["cardeposit"].coords.y, Config.Locations["cardeposit"].coords.z, true) < 10) then
                    sleep = 6
                    DrawMarker(2, Config.Locations["cardeposit"].coords.x, Config.Locations["cardeposit"].coords.y, Config.Locations["cardeposit"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos, Config.Locations["cardeposit"].coords.x, Config.Locations["cardeposit"].coords.y, Config.Locations["cardeposit"].coords.z, true) < 2.5) then
                        sleep = 6
                        if InVehicle then
                            sleep = 6
                            DrawText3D(Config.Locations["cardeposit"].coords.x, Config.Locations["cardeposit"].coords.y, Config.Locations["cardeposit"].coords.z + 0.4, '~r~[E]~s~ - Zwróć pojazd')
                            if IsControlJustReleased(0, Keys["E"]) then
                                if hasCar then
                                    DepositBack()
                                    exports['pnpNotify']:Alert("Sadownik", "Dostałeś " ..Config.DepositPrice.. "$ za zwrot pojazdu", 5000, 'info')
                                    working = false
                                    hasCar = false
                                    Plate = nil
                                    TriggerServerEvent('kuba200-fruitpicker:depositBack', source)
                                    for i, v in ipairs(Config.OrangeSpots) do
                                        RemoveBlip(v.blip)
                                        v.taked = true
                                    end
                                    for i, v in ipairs(Config.AppleSpots) do
                                        RemoveBlip(v.blip)
                                        v.taked = true
                                    end
                                    for i, v in ipairs(Config.StrawberrySpots) do
                                        RemoveBlip(v.blip)
                                        v.taked = true
                                    end
                                else
                                    exports['pnpNotify']:Alert("Sadownik", "Nie zapłaciłeś depozytu za ten pojazd !", 5000, 'info')
                                end
                            end
                        elseif not InVehicle then
                            sleep = 6
                            DrawText3D(Config.Locations["cardeposit"].coords.x, Config.Locations["cardeposit"].coords.y, Config.Locations["cardeposit"].coords.z + 0.4, '~g~[E]~s~ - Wyciągnij auto')
                            if IsControlJustReleased(0, Keys["E"]) then
                                ESX.TriggerServerCallback('kuba200-fruitpicker:checkMoney', function(hasMoney)
                                if hasMoney then
                                    ESX.Game.SpawnVehicle(Config.CarModelName, vector3(Config.Locations["cardeposit"].coords.x, Config.Locations["cardeposit"].coords.y, Config.Locations["cardeposit"].coords.z), Config.Locations["cardeposit"].coords.h, function(vehicle)
                                    SetVehicleNumberPlateText(vehicle, "FRT"..tostring(math.random(1000, 9999)))
                                    TaskWarpPedIntoVehicle(ped, vehicle, -1)
                                    SetVehicleEngineOn(vehicle, true, true)
                                    exports['pnpNotify']:Alert("Sadownik", "Zapłaciłeś " ..Config.DepositPrice.. "$ Za wyciągniecie pojazdu", 5000, 'info')
                                    Plate = GetVehicleNumberPlateText(vehicle)
                                    hasCar = true
                                    working = true
                                    BlipsWorking()
                                    for i, v in ipairs(Config.OrangeSpots) do
                                        v.taked = false
                                    end
                                    for i, v in ipairs(Config.AppleSpots) do
                                        v.taked = false
                                    end
                                    for i, v in ipairs(Config.StrawberrySpots) do
                                        v.taked = false
                                    end
                                    end)
                                else
                                    exports['pnpNotify']:Alert("Sadownik", "Nie masz wystarczającej ilości pieniędzy !", 5000, 'info')
                                end
                                end)
                            end
                        end
                    end
                end
            end
                    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                    local x,y,z = table.unpack(GetEntityCoords(ped))
                    local animbasket = "anim@heists@box_carry@"
                    local object = 'prop_fruit_basket'
                if working then
                    if not InVehicle then
                        if Plate == GetVehicleNumberPlateText(vehicle) then
                            sleep = 6
                            local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -1.5, 0)
                                if not hasBox then
                                    if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 1.5 then
                                        sleep = 6
                                        DrawText3D(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~g~[G]~s~ Wyciągnij kosz")
                                        if IsControlJustReleased(0, Keys["G"]) then
                                            sleep = 20
                                            TaskPlayAnim(ped, animbasket, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0)
                                            basket = CreateObject(GetHashKey(object), pos.x, pos.y, pos.z,  true,  true, true)
                                            AttachEntityToEntity(basket, ped, GetPedBoneIndex(ped, 28422), 0.22+0.05, -0.3+0.25, 0.0+0.16, 160.0, 90.0, 125.0, true, true, false, true, 1, true)
                                            hasBox = true
                                        end
                                    end
                                elseif hasBox then
                                    sleep = 3
                                    DisableControlAction(0,23,true) -- WYŁĄCZ WYJŚCIE/WEJŚCIE DO POJAZDU
                                    sleep = 6
                                    if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 1.5 then
                                        sleep = 6
                                        DrawText3D(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~r~[G]~s~ Włóż do kosza")
                                        if IsControlJustReleased(0, Keys["G"]) then
                                            sleep = 20
                                            ClearPedTasks(GetPlayerPed(-1))
                                            TaskPlayAnim(ped, animbasket, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0)
                                            DeleteEntity(basket)
                                            hasBox = false
                                        end
                                    end
                                end
                        end
                    end
                end
        end
        Citizen.Wait(sleep)
    end
end)

-- ROBOTA ES
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local InVehicle = IsPedInAnyVehicle(ped, false)
        local object = 'prop_fruit_basket'

        if PlayerData.job ~= nil and PlayerData.job.grade_name == 'fruitpicker' then
            if working then
                for i, v in ipairs(Config.OrangeSpots) do
                    if not v.taked then
                        if GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 3 then
                            sleep = 6
                            DrawText3D(v.x, v.y, v.z + 0.4, '~g~[E]~s~ - Podnieś pomarańcze')
                            if IsControlJustPressed(0, Keys["E"]) then
                                if not InVehicle then
                                    if hasBox then
                                        ESX.Streaming.RequestAnimDict('amb@prop_human_movie_bulb@idle_a', function()
                                            TaskPlayAnim(PlayerPedId(), 'amb@prop_human_movie_bulb@idle_a', 'idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                        end)
                                        exports.rprogress:Custom({
                                            Duration = 5500,
                                            Label = "Picking oranges...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(5500)
                                        ClearPedTasks(ped)
                                        done = done + 1
                                        v.taked = true
                                        RemoveBlip(v.blip)
                                        if done == 12 then
                                            exports['pnpNotify']:Alert("Sadownik", "Zebrałeś wszystkie owoce z sadu, teraz je umyj", 5000, 'info')
                                            
                                            SetNewWaypoint(Config.Locations["transformfruit"].coords.x, Config.Locations["transformfruit"].coords.y, Config.Locations["transformfruit"].coords.z)
                                        end
                                    else
                                        exports['pnpNotify']:Alert("Sadownik", "Nie masz koszyka", 5000, 'info')
                                    end
                                else
                                    exports['pnpNotify']:Alert("Sadownik", "Opuść Pojazd!", 5000, 'info')
                                end
                            end
                        end
                    end
                end
                for i, v in ipairs(Config.AppleSpots) do
                    if not v.taked then
                        if GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 3 then
                            sleep = 6
                            DrawText3D(v.x, v.y, v.z + 0.4, '~g~[E]~s~ - Podnieś jabłka')
                            if IsControlJustPressed(0, Keys["E"]) then
                                if not InVehicle then
                                    if hasBox then
                                        ESX.Streaming.RequestAnimDict('amb@prop_human_movie_bulb@idle_a', function()
                                            TaskPlayAnim(PlayerPedId(), 'amb@prop_human_movie_bulb@idle_a', 'idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                        end)
                                        exports.rprogress:Custom({
                                            Duration = 5500,
                                            Label = "Zbierasz jabłka...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(5500)
                                        ClearPedTasks(ped)
                                        done = done + 1
                                        v.taked = true
                                        RemoveBlip(v.blip)
                                        if done == 12 then
                                            exports['pnpNotify']:Alert("Sadownik", "Zebrałeś wszystkie owoce z sadu, teraz je umyj", 5000, 'info')
                                            SetNewWaypoint(Config.Locations["transformfruit"].coords.x, Config.Locations["transformfruit"].coords.y, Config.Locations["transformfruit"].coords.z)
                                        end
                                    else
                                        exports['pnpNotify']:Alert("Sadownik", "Nie masz koszyka", 5000, 'info')
                                    end
                                else
                                    exports['pnpNotify']:Alert("Sadownik", "Opuść Pojazd", 5000, 'info')
                                end
                            end
                        end
                    end
                end
                for i, v in ipairs(Config.StrawberrySpots) do
                    if not v.taked then
                        if GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 3 then
                            sleep = 6
                            DrawText3D(v.x, v.y, v.z + 0.4, '~g~[E]~s~ - Podnieś truskawki')
                            if IsControlJustPressed(0, Keys["E"]) then
                                if not InVehicle then
                                    if hasBox then
                                        DeleteEntity(basket)
                                        ESX.Streaming.RequestAnimDict('amb@world_human_gardener_plant@male@enter', function()
                                            TaskPlayAnim(PlayerPedId(), 'amb@world_human_gardener_plant@male@enter', 'enter', 8.0, -8.0, -1, 2, 0, false, false, false)
                                        end)
                                        exports.rprogress:Custom({
                                            Duration = 5500,
                                            Label = "Podnoszenei truskawek...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(5500)
                                        basket = CreateObject(GetHashKey(object), pos.x, pos.y, pos.z,  true,  true, true)
                                        AttachEntityToEntity(basket, ped, GetPedBoneIndex(ped, 28422), 0.22+0.05, -0.3+0.25, 0.0+0.16, 160.0, 90.0, 125.0, true, true, false, true, 1, true)
                                        ClearPedTasks(ped)
                                        done = done + 1
                                        v.taked = true
                                        RemoveBlip(v.blip)
                                        if done == 12 then
                                            exports['pnpNotify']:Alert("Sadownik", "Zebrałeś wszystkie owoce z sadu, teraz je umyj", 5000, 'info')
                                            SetNewWaypoint(Config.Locations["transformfruit"].coords.x, Config.Locations["transformfruit"].coords.y, Config.Locations["transformfruit"].coords.z)
                                        end
                                    else
                                        exports['pnpNotify']:Alert("Sadownik", "Nie masz koszyka", 5000, 'info')
                                    end
                                else
                                    exports['pnpNotify']:Alert("Sadownik", "Opuść pojazd!", 5000, 'info')
                                end
                            end
                        end
                    end
                end
                sleep = 6
                if (GetDistanceBetweenCoords(pos, Config.Locations["transformfruit"].coords.x, Config.Locations["transformfruit"].coords.y, Config.Locations["transformfruit"].coords.z, true) < 10) then
                    sleep = 6
                    DrawMarker(2, Config.Locations["transformfruit"].coords.x, Config.Locations["transformfruit"].coords.y, Config.Locations["transformfruit"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos, Config.Locations["transformfruit"].coords.x, Config.Locations["transformfruit"].coords.y, Config.Locations["transformfruit"].coords.z, true) < 2.5) then
                        sleep = 6
                        DrawText3D(Config.Locations["transformfruit"].coords.x, Config.Locations["transformfruit"].coords.y, Config.Locations["transformfruit"].coords.z + 0.4, '~g~[E]~s~ - Myj owocki')
                        if IsControlJustPressed(0, Keys["E"]) then
                            if done == 12 then
                                if not InVehicle then
                                    if hasBox then
                                        if not hasWashed then
                                            DoScreenFadeOut(800)
                                            Citizen.Wait(800)
                                            exports.rprogress:Custom({
                                                Duration = 25000,
                                                Label = "Mycie owocków...",
                                                DisableControls = {
                                                    Mouse = false,
                                                    Player = true,
                                                    Vehicle = true
                                                }
                                            })
                                            Citizen.Wait(25000)
                                            hasWashed = true
                                            DoScreenFadeIn(800)
                                            Citizen.Wait(800)
                                            exports['pnpNotify']:Alert("Sadownik", "Twój owoc jest gotowy do sprzedaży, idź do sklepu ", 5000, 'info')
                                                
                                            SetNewWaypoint(Config.Locations["sellfruit"].coords.x, Config.Locations["sellfruit"].coords.y, Config.Locations["sellfruit"].coords.z)
                                        elseif hasWashed then
                                            exports['pnpNotify']:Alert("Sadownik", "Twój owoc jest już umyty ", 5000, 'info')
                                        end
                                    else
                                        exports['pnpNotify']:Alert("Sadownik", "Nie masz koszyka", 5000, 'info')
                                    end
                                else
                                    exports['pnpNotify']:Alert("Sadownik", "Opuść pojazd!", 5000, 'info')
                                end
                            else
                                exports['pnpNotify']:Alert("Sadownik", "Nie zebrałeś wszystkich owoców z sadu!", 5000, 'info')
                            end
                        end
                    end
                end
                sleep = 6
                if (GetDistanceBetweenCoords(pos, Config.Locations["sellfruit"].coords.x, Config.Locations["sellfruit"].coords.y, Config.Locations["sellfruit"].coords.z, true) < 10) then
                    sleep = 6
                    DrawMarker(2, Config.Locations["sellfruit"].coords.x, Config.Locations["sellfruit"].coords.y, Config.Locations["sellfruit"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos, Config.Locations["sellfruit"].coords.x, Config.Locations["sellfruit"].coords.y, Config.Locations["sellfruit"].coords.z, true) < 2.5) then
                        sleep = 6
                        DrawText3D(Config.Locations["sellfruit"].coords.x, Config.Locations["sellfruit"].coords.y, Config.Locations["sellfruit"].coords.z + 0.4, '~g~[E]~s~ - Sprzedaj owocki')
                        if IsControlJustPressed(0, Keys["E"]) then
                            if not InVehicle then
                                if hasBox then
                                    if hasWashed then
                                        ClearPedTasks(ped)
                                        TaskPlayAnim(ped, 'anim@heists@box_carry@', "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0)
                                        DeleteEntity(basket)
                                        ESX.Streaming.RequestAnimDict('mp_common', function()
                                            TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                        end)
                                        exports.rprogress:Custom({
                                            Duration = 4000,
                                            Label = "Sprzedawanie owocków...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(4000)
                                        ClearPedTasks(ped)
                                        AmountPayout = AmountPayout + 1
                                        TriggerServerEvent('kuba200-fruitpicker:Payout', AmountPayout)
                                        exports['pnpNotify']:Alert("Sadownik", "Zarobiłeś " ..Config.Payout.. "", 5000, 'info')

                                        done = 0
                                        AmountPayout = 0
                                        hasWashed = false
                                        hasBox = false
                                        for i, v in ipairs(Config.OrangeSpots) do
                                            v.taked = false
                                        end
                                        for i, v in ipairs(Config.AppleSpots) do
                                            v.taked = false
                                        end
                                        for i, v in ipairs(Config.StrawberrySpots) do
                                            v.taked = false
                                        end
                                        BlipsWorking()
                                    else
                                        exports['pnpNotify']:Alert("Sadownik", "Twoje owoce nie są umyte", 5000, 'info')
                                    end
                                else
                                    exports['pnpNotify']:Alert("Sadownik", "Nie masz koszyczka", 5000, 'info')
                                end
                            else
                                exports['pnpNotify']:Alert("Sadownik", "Wyjdź z autka", 5000, 'info')
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

-- GŁÓWNY BLIP
Citizen.CreateThread(function()
        local coordsm = Config.Locations["main"].coords
        local namem = Config.Locations["main"].label
        blip = AddBlipForCoord(coordsm.x, coordsm.y, coordsm.z)
        SetBlipSprite(blip, 285)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 51)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(namem)
        EndTextCommandSetBlipName(blip)
end)
-- BLIP DUTY
function blips()
        local coordsc = Config.Locations["cardeposit"].coords
        local namec = Config.Locations["cardeposit"].label
        blip1 = AddBlipForCoord(coordsc.x, coordsc.y, coordsc.z)
        SetBlipSprite(blip1, 285)
        SetBlipDisplay(blip1, 4)
        SetBlipScale(blip1, 0.6)
        SetBlipAsShortRange(blip1, true)
        SetBlipColour(blip1, 51)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(namec)
        EndTextCommandSetBlipName(blip1)

        local coordst = Config.Locations["transformfruit"].coords
        local namet = Config.Locations["transformfruit"].label
        blip2 = AddBlipForCoord(coordst.x, coordst.y, coordst.z)
        SetBlipSprite(blip2, 285)
        SetBlipDisplay(blip2, 4)
        SetBlipScale(blip2, 0.6)
        SetBlipAsShortRange(blip2, true)
        SetBlipColour(blip2, 51)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(namet)
        EndTextCommandSetBlipName(blip2)
        
        local sell = Config.Locations["sellfruit"].coords
        local names = Config.Locations["sellfruit"].label
        blip3 = AddBlipForCoord(sell.x, sell.y, sell.z)
        SetBlipSprite(blip3, 285)
        SetBlipDisplay(blip3, 4)
        SetBlipScale(blip3, 0.6)
        SetBlipAsShortRange(blip3, true)
        SetBlipColour(blip3, 51)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(names)
        EndTextCommandSetBlipName(blip3)
end

-- DZIAŁAJĄCE BLIPY
function BlipsWorking()
    for i, v in ipairs(Config.OrangeSpots) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 285)
        SetBlipDisplay(v.blip, 4)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        SetBlipColour(v.blip, 47)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Sad pomarańczy')
        EndTextCommandSetBlipName(v.blip)
    end

    for i, v in ipairs(Config.AppleSpots) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 285)
        SetBlipDisplay(v.blip, 4)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        SetBlipColour(v.blip, 69)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Sad jabłkowy')
        EndTextCommandSetBlipName(v.blip)
    end

    for i, v in ipairs(Config.StrawberrySpots) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 285)
        SetBlipDisplay(v.blip, 4)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        SetBlipColour(v.blip, 49)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Sad Truskawkowy')
        EndTextCommandSetBlipName(v.blip)
    end
end

function DepositBack()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    ESX.Game.DeleteVehicle(vehicle)
    hasCar = false
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-----------------------------------------------------------------------------------------------------------------------
-------------Skrypt stworzony przez Kuba200#2512 dla ScrapRoleplay "jebać pascolda bo robi mi loda (-------------------
-----------------------------------------------------------------------------------------------------------------------
