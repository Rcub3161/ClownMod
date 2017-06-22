local FireFighter = RegisterMod( "FireFighter",1 )
local fireFighterItem = Isaac.GetItemIdByName("Fire Fighter")

local debug_text = "This should display";
local randomNumber = "num generated is: ";
local playerShotSpeed = "Shot speed: "
local statsNeedToBeAdded = false;
local didDestroyFire = false;


local statAddShotSpeed = 0;
local statAddDamage = 0;
local statAddFireDelay = 0;
local statAddRange = 0;
local statAddSpeed = 0;
local statAddLuck = 0;



function FireFighter:render()
	Isaac.RenderText(debug_text, 100, 100, 255, 0, 0, 255)
  	Isaac.RenderText(playerShotSpeed, 100, 150, 255, 0, 0, 255)
    player = Isaac.GetPlayer(0);
    currentShotSpeed = player.ShotSpeed
	Isaac.RenderText(tostring(player.Luck), 100, 200, 255, 0, 0, 255)
end

function FireFighter:Test()
  local entities = Isaac.GetRoomEntities();
  local player = Isaac.GetPlayer(0);
  for i = 1, #entities do
    if(entities[i].Type == EntityType.ENTITY_FIREPLACE and entities[i].HitPoints == 1) then
      local firestate = entities[i]:ToNPC();
      --Get the state then change it. you dope.
      if(firestate.State == NpcState.STATE_IDLE and player:HasCollectible(fireFighterItem)) then
        statsNeedToBeAdded = true;
        firestate.State = NpcState.STATE_UNIQUE_DEATH;
        entities[i].HitPoints = 0;
        local cacheToAddTo = math.random(1,6);
        playerShotSpeed = "Cache to add to " .. cacheToAddTo;
        --cacheToAddTo = 6;
        if(cacheToAddTo == 1) then
          player:AddCacheFlags(CacheFlag.CACHE_DAMAGE);
        elseif(cacheToAddTo == 2) then
          --player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY);
        elseif(cacheToAddTo == 3) then
          player:AddCacheFlags(CacheFlag.CACHE_SHOTSPEED);
        elseif(cacheToAddTo == 4) then
          player:AddCacheFlags(CacheFlag.CACHE_RANGE);
        elseif(cacheToAddTo == 5) then
          player:AddCacheFlags(CacheFlag.CACHE_SPEED);
        elseif(cacheToAddTo == 6) then
          player:AddCacheFlags(CacheFlag.CACHE_LUCK);
        end
        player:EvaluateItems();
      end
    end
  end
end

function FireFighter:cacheUpdate(playr, cache)
  local player = Isaac.GetPlayer(0);
  if (player:HasCollectible(fireFighterItem) == false) then return end;
  
  if(player:HasCollectible(fireFighterItem) == true and statsNeedToBeAdded == true) then
    statsNeedToBeAdded = statAddLuck;
    local randNum = math.random(1,10)
    randomNumber = randNum;
    if(cache == CacheFlag.CACHE_DAMAGE) then
      statAddDamage = statAddDamage + (randNum * .01)
      player.Damage = player.Damage + statAddDamage;
    elseif(cache == CacheFlag.CACHE_FIREDELAY) then
      statAddFireDelay = statAddFireDelay + (randNum * .01)
      player.FireDelay = player.MoveSpeed + statAddFireDelay;
    elseif(cache == CacheFlag.CACHE_SHOTSPEED) then
      statAddShotSpeed = statAddShotSpeed + (randNum * .01)
      player.ShotSpeed = player.ShotSpeed + statAddShotSpeed;

    elseif(cache == CacheFlag.CACHE_RANGE) then

    elseif(cache == CacheFlag.CACHE_SPEED) then
      statAddSpeed = statAddSpeed + (randNum * .01)
      player.MoveSpeed = player.MoveSpeed + statAddSpeed;
    elseif(cache == CacheFlag.CACHE_LUCK) then
      statAddLuck = statAddLuck + (randNum * .01)
      player.Luck = player.Luck + statAddLuck;
    end
  else
     --debug_text = "before adding luck"
    if(cache == CacheFlag.CACHE_DAMAGE) then
      player.Damage = player.Damage + statAddDamage;
    elseif(cache == CacheFlag.CACHE_FIREDELAY) then
      player.FireDelay = player.FireDelay + statAddFireDelay;
    elseif(cache == CacheFlag.CACHE_SHOTSPEED) then
      player.ShotSpeed = player.ShotSpeed + statAddShotSpeed;

    elseif(cache == CacheFlag.CACHE_RANGE) then

    elseif(cache == CacheFlag.CACHE_SPEED) then
      player.MoveSpeed = player.MoveSpeed + statAddSpeed;
    elseif(cache == CacheFlag.CACHE_LUCK) then
      player.Luck = player.Luck + statAddLuck;
    end
  end
 
end


FireFighter:AddCallback(ModCallbacks.MC_POST_RENDER, FireFighter.render)
FireFighter:AddCallback(ModCallbacks.MC_POST_UPDATE, FireFighter.Test)
FireFighter:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, FireFighter.cacheUpdate)

