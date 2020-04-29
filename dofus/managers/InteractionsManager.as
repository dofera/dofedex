class dofus.managers.InteractionsManager extends dofus.utils.ApiElement
{
	static var STATE_MOVE_SINGLE = 0;
	static var STATE_SELECT = 1;
	function InteractionsManager(var3, var4)
	{
		super();
		this.initialize(var3,var4);
	}
	function initialize(var2, var3)
	{
		super.initialize(var4);
		this._playerManager = var3;
	}
	function setState(var2)
	{
		if(var2)
		{
			this._state = dofus.managers.InteractionsManager.STATE_SELECT;
			this._playerManager.lastClickedCell = null;
		}
		else
		{
			this._state = dofus.managers.InteractionsManager.STATE_MOVE_SINGLE;
		}
	}
	function calculatePath(mapHandler, §\x14\x04§, §\x16\x19§, §\x18\x1b§, §\x19\r§, §\x1c\x18§, §\x14\x1b§)
	{
		var var9 = var8 != true?this._playerManager.data.cellNum:this._playerManager.data.lastCellNum;
		if(var3 == this._playerManager.data.cellNum || var8 == true && var3 == var9)
		{
			return false;
		}
		var var10 = mapHandler.getCellData(var3);
		var var11 = !var6?var10.spriteOnID != undefined?true:false:false;
		if(var11)
		{
			return false;
		}
		if(var10.movement == 0)
		{
			return false;
		}
		if(var10.movement == 1 && var5)
		{
			return false;
		}
		if((var var0 = this._state) !== dofus.managers.InteractionsManager.STATE_MOVE_SINGLE)
		{
			if(var0 === dofus.managers.InteractionsManager.STATE_SELECT)
			{
				if(var4)
				{
					this.api.gfx.select(this.convertToSimplePath(this.api.datacenter.Basics.interactionsManager_path),dofus.Constants.CELL_PATH_SELECT_COLOR);
					return this.api.datacenter.Basics.interactionsManager_path != null;
				}
				this.api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(mapHandler,var9,var3,{bAllDirections:false,nMaxLength:(!var5?500:this._playerManager.data.MP)});
				this.api.gfx.unSelect(true);
				this.api.gfx.select(this.convertToSimplePath(this.api.datacenter.Basics.interactionsManager_path),dofus.Constants.CELL_PATH_OVER_COLOR);
			}
			return false;
		}
		this.api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(mapHandler,var9,var3,{bAllDirections:var7,bIgnoreSprites:var6});
		if(this.api.datacenter.Basics.interactionsManager_path != null)
		{
			return true;
		}
		return false;
	}
	function convertToSimplePath(var2)
	{
		var var3 = new Array();
		§§enumerate(var2);
		while((var var0 = §§enumeration()) != null)
		{
			var3.push(var2[k].num);
		}
		return var3;
	}
}
