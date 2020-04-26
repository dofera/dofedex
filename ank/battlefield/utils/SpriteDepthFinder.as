class ank.battlefield.utils.SpriteDepthFinder
{
	function SpriteDepthFinder()
	{
	}
	static function getFreeDepthOnCell(mapHandler, §\x1e\x19\t§, §\b\x1a§, bGhostView)
	{
		if(loc4 < 0)
		{
			ank.utils.Logger.err("[getFreeDepthOnCell] La cellule ne doit pas être < 0.");
			loc4 = 0;
		}
		if(loc4 > mapHandler.getCellCount())
		{
			ank.utils.Logger.err("[getFreeDepthOnCell] La cellule ne doit pas être > " + mapHandler.getCellCount());
			loc4 = 0;
		}
		var loc6 = mapHandler.getCellData(loc4).allSpritesOn;
		var loc7 = new Object();
		for(var k in loc6)
		{
			loc7[loc3.getItemAt(k).mc.getDepth()] = true;
		}
		var loc8 = loc4 * 100 + ank.battlefield.Constants.FIRST_SPRITE_DEPTH_ON_CELL + (!bGhostView?0:ank.battlefield.Constants.MAX_DEPTH_IN_MAP);
		var loc9 = 0;
		while(loc9 < ank.battlefield.Constants.MAX_SPRITES_ON_CELL)
		{
			if(loc7[loc8 + loc9] != true)
			{
				break;
			}
			loc9 = loc9 + 1;
		}
		if(loc9 == ank.battlefield.Constants.MAX_SPRITES_ON_CELL - 1 && loc7[loc8 + loc9] == true)
		{
			ank.utils.Logger.err("[getFreeDepthOnCell] plus de place sur cette cellule");
		}
		return loc8 + loc9;
	}
}
