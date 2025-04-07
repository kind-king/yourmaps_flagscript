-- yourmaps_flags - Server.lua you can adapt to your server needs

-- Framework APIs
local VorpCore = {}
local VorpInv = {}
local redemrpInventoryData = {}

-- Setup framework APIs
CreateThread(function()
    Wait(2000)
    local fw = string.upper(Config.framework)

    if fw == "VORP" then
        -- Get VORP Core and Inventory APIs
        VorpCore = exports.vorp_core:GetCore()

        VorpInv = exports.vorp_inventory:vorp_inventoryApi()

    elseif fw == "REDEMRP" then
        -- Load REDEMRP Inventory Data
        TriggerEvent("redemrp_inventory:getData", function(call)
            redemrpInventoryData = call
        end)
    end
end)

-- Display tip (supports both frameworks)
local function displayUserText(text, source)
    local fw = string.upper(Config.framework)

    if fw == "REDEMRP" and Config.nativeText == false then
        TriggerClientEvent("redem_roleplay:Tip", source, text, Config.timeDisplay)
    else
        TriggerClientEvent('vorp:Tip', source, text, Config.timeDisplay)
    end
end

-- Handle Flag Use logic for both frameworks
local function handleFlagUse(source, DEFAULT_TYPE)
    local fw = string.upper(Config.framework)

    if fw == "REDEMRP" then
        TriggerEvent('redemrp:getPlayerFromId', source, function(user)
            local itemFound, type = true, DEFAULT_TYPE

            if Config.itemRequired then
                itemFound = false
                for _, item in ipairs(Config.items) do
                    if redemrpInventoryData.getItemData(item.name) and redemrpInventoryData.getItem(source, item.name).ItemAmount > 0 then
                        itemFound = true
                        type = item.type
                        break
                    end
                end
            end

            local jobFound = not Config.joblock
            if Config.joblock then
                for _, job in ipairs(Config.jobs) do
                    if user.getJob() == job then
                        jobFound = true
                        break
                    end
                end
            end

            if itemFound and jobFound then
                TriggerClientEvent('yourmaps_flags_UseFlag', source, type)
            end
        end)

    elseif fw == "VORP" then
        local User = VorpCore.getUser(source)
        if not User then return end
        local Character = User.getUsedCharacter

        local itemFound, type = true, DEFAULT_TYPE
        if Config.itemRequired then
            itemFound = false
            for _, item in ipairs(Config.items) do
                if VorpInv.getItemCount(source, item.name) > 0 then
                    itemFound = true
                    type = item.type
                    break
                end
            end
        end

        local jobFound = not Config.joblock
        if Config.joblock then
            for _, job in ipairs(Config.jobs) do
                if Character.job == job then
                    jobFound = true
                    break
                end
            end
        end

        if itemFound and jobFound then
            TriggerClientEvent('yourmaps_flags_UseFlag', source, type)
        end
    end
end

-- Register usable items (for both frameworks)
CreateThread(function()
    Wait(2000)
    for _, item in ipairs(Config.items) do
        local fw = string.upper(Config.framework)

        if fw == "REDEMRP" then
            -- REDEMRP Usable Item Registration
            RegisterServerEvent("RegisterUsableItem:" .. item.name)
            AddEventHandler("RegisterUsableItem:" .. item.name, function(source)
                TriggerEvent("redemrp:getPlayerFromId", source, function(user)
                    local itemFound = false
                    local type = item.type or Config.defaultFlagType

                    if redemrpInventoryData.getItemData(item.name) and redemrpInventoryData.getItem(source, item.name).ItemAmount > 0 then
                        itemFound = true
                    end

                    local jobFound = not Config.joblock
                    if Config.joblock then
                        for _, job in ipairs(Config.jobs) do
                            if user.getJob() == job then
                                jobFound = true
                                break
                            end
                        end
                    end

                    if itemFound and jobFound then
                        TriggerClientEvent("yourmaps_flags_UseFlag", source, type)
                    elseif Config.debug then
                        print("[REDEMRP FLAG USE FAILED]", item.name, itemFound, jobFound)
                    end
                end)
            end)

        elseif fw == "VORP" then
            -- VORP Usable Item Registration
            VorpInv.RegisterUsableItem(item.name, function(data)
                local source = data.source
                local itemId = data.item.mainid
                exports.vorp_inventory:closeInventory(source)

                local User = VorpCore.getUser(source)
                if not User then return print("USER NOT FOUND") end
                local Character = User.getUsedCharacter
                local itemFound = VorpInv.getItemCount(source, item.name) > 0
                local type = item.type or Config.defaultFlagType

                local jobFound = not Config.joblock
                if Config.joblock then
                    for _, job in ipairs(Config.jobs) do
                        if Character.job == job then
                            jobFound = true
                            break
                        end
                    end
                end

                if itemFound and jobFound then
                    TriggerClientEvent("yourmaps_flags_UseFlag", source, type)
                elseif Config.debug then
                    print("[VORP FLAG USE FAILED]", item.name, itemFound, jobFound)
                end
            end)
        else
            print("UNKNOWN FRAMEWORK", fw)
        end
    end
end)


-- Flag use event from client
RegisterServerEvent("yourmaps_flags:UseFlag")
AddEventHandler("yourmaps_flags:UseFlag", function(DEFAULT_TYPE)
    local source = source
    if Config.debug then
        print("[FLAG_USE]", source, DEFAULT_TYPE)
    end
    handleFlagUse(source, DEFAULT_TYPE)
end)


-- Slash commands for testing
CreateThread(function()
    if Config.slashCommands then
        RegisterCommand(Config.flagdrop, function(source)
            TriggerClientEvent('yourmaps_flags:DropFlag', source)
        end, false)

        RegisterCommand(Config.flagpickup, function(source)
            TriggerClientEvent('yourmaps_flags:PickupFlag', source)
        end, false)

        RegisterCommand(Config.flagdelete, function(source)
            TriggerClientEvent('yourmaps_flags:DelFlag', source)
        end, false)
    end
end)
