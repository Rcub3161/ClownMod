StartDebug();
local ExplosiveCigar = RegisterMod( "ExplosiveCigar",1 )
local item = Isaac.GetItemIdByName("Explosive Cigar")

local debug_text = "No item"
local hit_text = "not hit"
local hasExploded = false
local test_text = "collectable"
local speed_text = ""
local player_hit = false
local i = 1


function ExplosiveCigar:render()
	Isaac.RenderText(debug_text, 100, 100, 255, 0, 0, 255)
	Isaac.RenderText(hit_text, 150, 150, 255, 0, 0, 255)
	Isaac.RenderText(test_text, 200, 200, 255, 0, 0, 255)
	Isaac.RenderText(tostring(hasExploded), 300, 200, 255, 0, 0, 255)
end

function ExplosiveCigar:onDamage(entity, dmgAmt, dmgFlag, dmgSource, dmgCountDownFrames)
	local player = Isaac.GetPlayer(0)
	hit_text = entity.Type
	if entity.Type == EntityType.ENTITY_PLAYER then
		hit_text = "isaac only damaged"
		player_hit = true
		if player:HasCollectible(item) == true and hasExploded == false then
				speed_text = player.Position.X
        Game():BombExplosionEffects(player.Position, 4, player.TearFlags, Color(50, 50, 50, 50, 50, 50, 50), player, .5, true, false);
				--Isaac.Explode(player.Position, entity, 10)
				entity:BloodExplode();
				hit_text = "isaac damaged and has item"
				hasExploded = true
		else
			test_text = "No collectable found..."
		end
	end
end

function ExplosiveCigar:resetCigarExplosion()
	hasExploded = false
end

function ExplosiveCigar:item_effect(currentPlayer)
	local player = Isaac.GetPlayer(0)

	if player:HasCollectible(item) == true then
		debug_text = "Item got"
	else
		debug_text = "No item"
	end
	
end
--ExplosiveCigar:AddCallback(ModCallbacks.MC_POST_RENDER, ExplosiveCigar.render)
ExplosiveCigar:AddCallback(ModCallbacks.MC_POST_RENDER, ExplosiveCigar.test)

ExplosiveCigar:AddCallback( ModCallbacks.MC_ENTITY_TAKE_DMG, ExplosiveCigar.onDamage)
ExplosiveCigar:AddCallback(ModCallbacks.MC_POST_UPDATE, ExplosiveCigar.item_effect, EntityType.ENTITY_PLAYER)

ExplosiveCigar:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, ExplosiveCigar.resetCigarExplosion)
