class dofus.managers.InteractionsManager extends dofus.utils.ApiElement
{
	static var STATE_MOVE_SINGLE = 0;
	static var STATE_SELECT = 1;
	function InteractionsManager(loc3, loc4)
	{
		super();
		this.initialize(loc3,loc4);
	}
	function initialize(loc2, loc3)
	{
		super.initialize(loc4);
		this._playerManager = loc3;
	}
	function setState(loc2)
	{
		if(loc2)
		{
			this._state = dofus.managers.InteractionsManager.STATE_SELECT;
			this._playerManager.lastClickedCell = null;
		}
		else
		{
			this._state = dofus.managers.InteractionsManager.STATE_MOVE_SINGLE;
		}
	}
	function calculatePath(mapHandler, §\x14\x06§, §\x16\x1a§, §\x18\x1c§, §\x19\x0e§, §\x1c\x18§, §\x14\x1c§)
	{
		var loc9 = loc8 != true?this._playerManager.data.cellNum:this._playerManager.data.lastCellNum;
		if(loc3 == this._playerManager.data.cellNum || loc8 == true && loc3 == loc9)
		{
			return false;
		}
		var loc10 = mapHandler.getCellData(loc3);
		var loc11 = !loc6?loc10.spriteOnID != undefined?true:false:false;
		if(loc11)
		{
			return false;
		}
		if(loc10.movement == 0)
		{
			return false;
		}
		if(loc10.movement == 1 && loc5)
		{
			return false;
		}
		if((var loc0 = this._state) !== dofus.managers.InteractionsManager.STATE_MOVE_SINGLE)
		{
			if(loc0 === dofus.managers.InteractionsManager.STATE_SELECT)
			{
				if(loc4)
				{
					this.api.gfx.select(this.convertToSimplePath(this.api.datacenter.Basics.interactionsManager_path),dofus.Constants.CELL_PATH_SELECT_COLOR);
					return this.api.datacenter.Basics.interactionsManager_path != null;
				}
				this.api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(mapHandler,loc9,loc3,{bAllDirections:false,nMaxLength:(!loc5?500:this._playerManager.data.MP)});
				this.api.gfx.unSelect(true);
				this.api.gfx.select(this.convertToSimplePath(this.api.datacenter.Basics.interactionsManager_path),dofus.Constants.CELL_PATH_OVER_COLOR);
			}
			return false;
		}
		this.api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(mapHandler,loc9,loc3,{bAllDirections:loc7,bIgnoreSprites:loc6});
		if(this.api.datacenter.Basics.interactionsManager_path != null)
		{
			return true;
		}
		return false;
	}
	function convertToSimplePath(loc2)
	{
		var loc3 = new Array();
		for(var k in loc2)
		{
			loc3.push(loc2[k].num);
		}
		return loc3;
	}
}
