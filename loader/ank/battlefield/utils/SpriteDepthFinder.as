class ank.battlefield.utils.SpriteDepthFinder
{
	function SpriteDepthFinder()
	{
	}
	static function getFreeDepthOnCell(mapHandler, §\x1e\x18\x01§, §\b\x02§, bGhostView)
	{
		if(var4 < 0)
		{
			ank.utils.Logger.err("[getFreeDepthOnCell] La cellule ne doit pas être < 0.");
			var4 = 0;
		}
		if(var4 > mapHandler.getCellCount())
		{
			ank.utils.Logger.err("[getFreeDepthOnCell] La cellule ne doit pas être > " + mapHandler.getCellCount());
			var4 = 0;
		}
		var var6 = mapHandler.getCellData(var4).allSpritesOn;
		var var7 = new Object();
		for(var7[var3.getItemAt(k).mc.getDepth()] in var6)
		{
		}
		var var8 = var4 * 100 + ank.battlefield.Constants.FIRST_SPRITE_DEPTH_ON_CELL + (!bGhostView?0:ank.battlefield.Constants.MAX_DEPTH_IN_MAP);
		var var9 = 0;
		while(var9 < ank.battlefield.Constants.MAX_SPRITES_ON_CELL)
		{
			if(var7[var8 + var9] != true)
			{
				break;
			}
			var9 = var9 + 1;
		}
		if(var9 == ank.battlefield.Constants.MAX_SPRITES_ON_CELL - 1 && var7[var8 + var9] == true)
		{
			ank.utils.Logger.err("[getFreeDepthOnCell] plus de place sur cette cellule");
		}
		return var8 + var9;
	}
}
