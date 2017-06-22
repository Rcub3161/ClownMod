local cleverdisguise = RegisterMod( "Clever Disguise", 1);
local cleverdisguise_item = Isaac.GetItemIdByName( "Clever Disguise" )

local debug_text = "This should display"

function cleverdisguise:render()
    Isaac.RenderText(debug_text, 100, 100, 255, 0, 0, 255)
end

function cleverdisguise:use_disguise( )
  local player = Isaac.GetPlayer(0)
  local entities = Isaac.GetRoomEntities( )
  for i = 1, #entities do
    if entities[ i ]:IsVulnerableEnemy( ) then
	if not entities[i]:IsBoss() then
      debug_text = "Worked"
      entities[ i ]:AddCharmed(500)
			end
		end
	end
end

--cleverdisguise:AddCallback(ModCallbacks.MC_POST_RENDER, cleverdisguise.render)
cleverdisguise:AddCallback( ModCallbacks.MC_USE_ITEM, cleverdisguise.use_disguise, cleverdisguise_item )
