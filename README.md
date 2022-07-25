# wallet
Wallet script for QBCore Framework
## This is just a wallet script for qbcore which can be used to see cash and bank balance of the player .


## Add this line to your Shared/items.lua in QBCore -->
```
['wallet']	= {['name'] = 'wallet',	['label'] = 'Wallet',	['weight'] = 0, 	['type'] = 'item', 	['image'] = 'wallet.png',	['unique'] = true, ['useable'] = true,	['shouldClose'] = true, ['combinable'] = nil, 	['description'] = 'Your Wallet '}
```

## Add this in qb-inventory/html/js/app.js inside FormatItemInfo after idcard in qb-inventory -->
```
else if (itemData.name == "wallet") {
        var gender = "Man";
        if (itemData.info.gender == 1) {
            gender = "Woman";
        }
        $(".item-info-title").html("<p>" + itemData.label + "</p>");
        $(".item-info-description").html(
        "<p><strong>CSN: </strong><span>" +
        itemData.info.citizenid +
        "</span></p><p><strong>First Name: </strong><span>" +
        itemData.info.firstname +
        "</span></p><p><strong>Last Name: </strong><span>" +
        itemData.info.lastname +
        "</span></p>"
    );
}
```

##  Add this in giveitem command inside qb-inventory after id card -->
```
if itemData["name"] == "id_card" then
	info.citizenid = Player.PlayerData.citizenid
	info.firstname = Player.PlayerData.charinfo.firstname
	info.lastname = Player.PlayerData.charinfo.lastname
	info.birthdate = Player.PlayerData.charinfo.birthdate
	info.gender = Player.PlayerData.charinfo.gender
	info.nationality = Player.PlayerData.charinfo.nationality
elseif itemData["name"] == "wallet" then
	info.citizenid = Player.PlayerData.citizenid
	info.firstname = Player.PlayerData.charinfo.firstname
	info.lastname = Player.PlayerData.charinfo.lastname
```

##  Replace this for itemshop in qb-inventory/server/main.lua -->
```
elseif QBCore.Shared.SplitStr(shopType, "_")[1] == "Itemshop" then
	local info = {}
	if Player.Functions.RemoveMoney("cash", price, "itemshop-bought-item") then
         if QBCore.Shared.SplitStr(itemData.name, "_")[1] == "weapon" then
            itemData.info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
        end
		if QBCore.Shared.SplitStr(itemData.name, "_")[1] == "wallet" then
			info.citizenid = Player.PlayerData.citizenid
			info.firstname = Player.PlayerData.charinfo.firstname
			info.lastname = Player.PlayerData.charinfo.lastname
			Player.Functions.AddItem(itemData.name, fromAmount, toSlot, info)
		else
		    Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
		end
		TriggerClientEvent('qb-shops:client:UpdateShop', src, QBCore.Shared.SplitStr(shopType, "_")[2], itemData, fromAmount)
		TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
		TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green", "**"..GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $"..price)
		elseif bankBalance >= price then
			Player.Functions.RemoveMoney("bank", price, "itemshop-bought-item")
        if QBCore.Shared.SplitStr(itemData.name, "_")[1] == "weapon" then
                itemData.info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
        end
		if QBCore.Shared.SplitStr(itemData.name, "_")[1] == "wallet" then
			info.citizenid = Player.PlayerData.citizenid
			info.firstname = Player.PlayerData.charinfo.firstname
			info.lastname = Player.PlayerData.charinfo.lastname
			Player.Functions.AddItem(itemData.name, fromAmount, toSlot, info)
		else
		    Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
		end
		TriggerClientEvent('qb-shops:client:UpdateShop', src, QBCore.Shared.SplitStr(shopType, "_")[2], itemData, fromAmount)
		TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
		TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green", "**"..GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $"..price)
	else
		TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash..", "error")
	end
```
