ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('esx_phone:registerNumber', 'weazelnews', _U('alert_weazelnews'), true, true)
TriggerEvent('esx_society:registerSociety', 'weazelnews', 'weazelnews', 'society_weazelnews', 'society_weazelnews', 'society_weazelnews', {type = 'private'})

RegisterNetEvent('KWeazel_news:getStockItem')
AddEventHandler('KWeazel_news:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weazelnews', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification(_U('have_withdrawn', count, inventoryItem.label))
			else
				xPlayer.showNotification(_U('quantity_invalid'))
			end
		else
			xPlayer.showNotification(_U('quantity_invalid'))
		end
	end)
end)


RegisterServerEvent('KWeazel_news:putStockItems')
AddEventHandler('KWeazel_news:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weazelnews', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('KWeazel_news:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weazelnews', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('KWeazel_news:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

RegisterServerEvent('KWeazel_news:message')
AddEventHandler('KWeazel_news:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterServerEvent('KWeazel_news:annoncerecrutementW')
AddEventHandler('KWeazel_news:annoncerecrutementW', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Weazel News', '~b~Annonce', '~y~Recrutement en cours, rendez-vous à l\'entreprise !', 'CHAR_LIFEINVADER', 8)

    end
end)


RegisterNetEvent('Cam:ToggleCam')
AddEventHandler('Cam:ToggleCam', function()
    local src = source
    TriggerClientEvent("Cam:ToggleCam", src)
end)

RegisterNetEvent('Mic:ToggleBMic')
AddEventHandler('Mic:ToggleBMic', function()
    local src = source
    TriggerClientEvent("Mic:ToggleBMic", src)
end)

RegisterNetEvent('Mic:ToggleMic')
AddEventHandler('Mic:ToggleMic', function()
    local src = source
    TriggerClientEvent("Mic:ToggleMic", src)
end)
