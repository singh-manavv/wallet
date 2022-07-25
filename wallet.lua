local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('wallet' , function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local bankamount = Player.PlayerData.money.bank
    local cashamount = Player.PlayerData.money.cash
    TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
    TriggerClientEvent('hud:client:ShowAccounts', source, 'bank', bankamount)
end)