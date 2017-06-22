local Book_Of_Jokes = RegisterMod( "Book_Of_Jokes",1 )
local book_of_jokes_item = Isaac.GetItemIdByName("Book of Jokes")
local debug_text = "This should display"

local itempool = {
    [0] = PickupVariant.PICKUP_CHEST;
    [1] = PickupVariant.PICKUP_ETERNALCHEST;
    [2] = PickupVariant.PICKUP_LOCKEDCHEST;
    [3] = PickupVariant.PICKUP_REDCHEST;
    [4] = PickupVariant.PICKUP_TRINKET;
  }

function Book_Of_Jokes:render()
	--Isaac.RenderText(debug_text, 100, 100, 255, 0, 0, 255)
end

function Book_Of_Jokes:use_book_of_jokes() --could add in more such as give enimies spectral tears/makes one a champion ect...
	local player = Isaac.GetPlayer(0); --Could also add in double items on ground. Teleport to devil/angel room?
  local entities = Isaac.GetRoomEntities();
	local jokeNumber = math.random(0,9);
	debug_text = jokeNumber;
  --Have luck contribute to the odds?
	if(jokeNumber >= 0 and jokeNumber <= 5) then
		debug_text = jokeNumber;
    player:UsePill(PillEffect.PILLEFFECT_IM_EXCITED, PillColor.PILL_NULL);
    --player:UsePill(PillEffect.PILLEFFECT_ADDICTED, PillColor.PILL_NULL
	elseif(jokeNumber >=6 and jokeNumber < 9) then
		for i = 1, #entities do
			if entities[ i ]:IsVulnerableEnemy( ) then
			  		debug_text = "Worked"
			  		entities[ i ]:AddConfusion(EntityRef(player), 500, true);
			end
		end
	else
		for i = 1, #entities do
			if(entities[i]:IsVulnerableEnemy() and not entities[i]:IsBoss()) then
				entities[i]:AddEntityFlags(EntityFlag.FLAG_FRIENDLY);
				--Create an item pool to spawn item(s) from.
			end
		end
    local itempoolNum = math.random(0,5);
    debug_text = itempoolNum;
    --The if statements are if you want to add a different variant. That could also be randomized if wanted...
    if(itempoolNum == 0) then
      Isaac.Spawn(EntityType.ENTITY_PICKUP, itempool[itempoolNum], 0, Isaac.GetFreeNearPosition(Game():GetRoom():GetCenterPos(),1), Vector(0,0), player);
    elseif(itempoolNum == 1) then
      Isaac.Spawn(EntityType.ENTITY_PICKUP, itempool[itempoolNum], 0, Isaac.GetFreeNearPosition(Game():GetRoom():GetCenterPos(),1), Vector(0,0), player);
    elseif(itempoolNum == 2) then
      Isaac.Spawn(EntityType.ENTITY_PICKUP, itempool[itempoolNum], 0, Isaac.GetFreeNearPosition(Game():GetRoom():GetCenterPos(),1), Vector(0,0), player);
    elseif(itempoolNum == 3) then
     Isaac.Spawn(EntityType.ENTITY_PICKUP, itempool[itempoolNum], 0, Isaac.GetFreeNearPosition(Game():GetRoom():GetCenterPos(),1), Vector(0,0), player);
    elseif(itempoolNum == 4) then
      Isaac.Spawn(EntityType.ENTITY_PICKUP, itempool[itempoolNum], 0, Isaac.GetFreeNearPosition(Game():GetRoom():GetCenterPos(),1), Vector(0,0), player);
    else
     Isaac.Spawn(EntityType.ENTITY_PICKUP, itempool[itempoolNum], 0, Isaac.GetFreeNearPosition(Game():GetRoom():GetCenterPos(),1), Vector(0,0), player);
    end 
	end
			
end

Book_Of_Jokes:AddCallback(ModCallbacks.MC_POST_RENDER, Book_Of_Jokes.render)
Book_Of_Jokes:AddCallback( ModCallbacks.MC_USE_ITEM, Book_Of_Jokes.use_book_of_jokes, book_of_jokes_item )
