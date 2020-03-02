function sendForbiddenMessage(message)
	TriggerEvent("chatMessage", "", {0, 0, 0}, "^1" .. message)
end

function _DeleteEntity(entity)
	--SetEntityAsNoLongerNeeded(Citizen.PointerValueIntInitialized(entity))
	--SetEntityAsNoLongerNeeded(entity)
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
	--Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity) )

end