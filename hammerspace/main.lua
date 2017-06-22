local HammerSpace = RegisterMod( "HammerSpace",1 )

local debug_text = "This should display"
local spacePressed = false;
local testText = tostring(spacePressed);
local stringTest = "not set";
local entityTest = "pickup text";
local pickupPosText = "distance: "
local playerPosText = "distance: "
local totalDistText = "distance: "
local countItems = "no space pressed"
local itemsAbsorbed = {}
local spitout = true;
function HammerSpace:render()
	Isaac.RenderText(debug_text, 100, 100, 255, 0, 0, 255)
  Isaac.RenderText(testText, 150, 150, 255, 0, 0, 255)
  Isaac.RenderText(countItems, 150, 100, 255, 0, 0, 255)
  Isaac.RenderText(stringTest, 200, 100, 255, 0, 0, 255)
  Isaac.RenderText(entityTest, 250, 100, 255, 0, 0, 255)
  Isaac.RenderText(pickupPosText, 250, 150, 255, 0, 0, 255)
  Isaac.RenderText(playerPosText, 250, 200, 255, 0, 0, 255)
  Isaac.RenderText(totalDistText, 250, 250, 255, 0, 0, 255)



	local player = Isaac.GetPlayer(0);
	debug_text = player:GetMovementDirection();

end

function HammerSpace:AbsorbItems(player)
  if(spacePressed == true) then
    if(spitout == false) then
         stringTest = "tru";
    --player:GetSprite():Play("LiftItem",true)
  local entities = Isaac.GetRoomEntities();
    for i = 1, #entities do
      if (entities[i].Type == EntityType.ENTITY_PICKUP) then
        entityTest = "found an entity with type of pickup";
        local pickupPos = entities[i].Position;
        local pickupPosX = pickupPos.X;
        local pickupPosY = pickupPos.Y;
        pickupPosText= "pickupPos X:" .. tostring(pickupPosX) .. " pickupPos Y:" .. tostring(pickupPosY); 
				local playerPos = player.Position;
				local playerPosX = player.Position.X;
        local playerPosY = player.Position.Y;
        playerPosText= "playerPos X:" .. tostring(playerPosX) .. " playerPos Y:" .. tostring(playerPosY); 
        local distBetween = pickupPos.Distance(pickupPos, playerPos);
        totalDistText = "distance: " .. tostring(distBetween);
        --Perhaps make this instead of distance <= 27 make dis < player.size and entity[i].size?
        if(distBetween <= 27 and not entities[i]:IsDead()) then
          newTest = "picked up";
          itemsAbsorbed[#itemsAbsorbed + 1] = entities[i];
          --itemsAbsorbed:insert(itemsAbsorbed, entities[i]);
          entities[i]:GetSprite():Play("Collect", false)
          --itemsAbsorbed[i] = entities[i];
          entities[i]:Die();
        end
      end
    end
  else
        for i = 1, #itemsAbsorbed do
          Isaac.Spawn(itemsAbsorbed[i].Type, itemsAbsorbed[i].Variant, itemsAbsorbed[i].SubType, Isaac.GetFreeNearPosition(Game():GetRoom():GetCenterPos(),1), Vector(0,0), player); 
        end
        itemsAbsorbed = {};
    end
 
  else --spacePressed = false
    stringTest = "Fal";
    entityTest = "Fal";
    countItems = #itemsAbsorbed
  end
end

function HammerSpace:TestFunction()
	local player = Isaac.GetPlayer(0);
	if(spacePressed == true) then
		spacePressed = false;
		testText = tostring(spacePressed);
		player:PlayExtraAnimation("HideItem");
	else
    if(spitout == false) then
      spitout = true;
    else
      spitout = false;
    end
		player:PlayExtraAnimation("LiftItem");
		spacePressed = true;
		testText = tostring(spacePressed);
	end
end
--local player = Isaac.GetPlayer(0);
	--player:PlayExtraAnimation("UseItem");
--HammerSpace:AddCallback(ModCallbacks.MC_POST_RENDER, HammerSpace.render)
HammerSpace:AddCallback(ModCallbacks.MC_USE_ITEM, HammerSpace.TestFunction)
HammerSpace:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, HammerSpace.AbsorbItems)

--HammerSpace:AddCallback(ModCallbacks.MC_POST_UPDATE, HammerSpace.AbsorbItems)