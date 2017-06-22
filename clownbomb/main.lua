local ClownBombMod = RegisterMod( "ClownBombMod",1 )
local ClownBombType = Isaac.GetEntityTypeByName("ClownBomb")


local debug_text = "This should display"
local test_bool = false

function ClownBombMod:render()
	--Isaac.RenderText(debug_text, 100, 100, 255, 0, 0, 255)
end


--This function here does the animation and explosion for the clown bomb.
function ClownBombMod:animate(clownbomb)
	player = Isaac.GetPlayer(0);
	sprite = clownbomb:GetSprite();
	if(sprite:IsFinished("Appear")) then	--this if statement will wait for the sprite to finish playing the appear animation.
		debug_text = "Finished playing";
		clownbomb.State = NpcState.STATE_INIT;
		if(clownbomb.State == NpcState.STATE_INIT) then
			sprite:Play("Pluse"); --now it plays the pluse animation (I spelt that wrong)
			debug_text = "playing new animation"
			clownbomb.State = NpcState.STATE_ATTACK;
		end
	end
	if(sprite:IsFinished("Pluse")) then --will wait for the sprite to finish playing the pluse animation
		sprite:Play("Explode"); -- will play the explode animation
	end
	if(sprite:IsFinished("Explode")) then --will wait for the explode animation to finish
		Isaac.Explode(clownbomb.Position, clownbomb, 5); --causes an explosion at the location of the bomb
		clownbomb:Remove(); -- removes the bomb from sight.
		
		debug_text = "Entity Killed";
	end
end



ClownBombMod:AddCallback(ModCallbacks.MC_POST_RENDER, ClownBombMod.render)
ClownBombMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, ClownBombMod.animate, ClownBombType)