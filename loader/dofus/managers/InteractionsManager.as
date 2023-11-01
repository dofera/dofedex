class dofus.managers.InteractionsManager extends dofus.utils.ApiElement
{
	static var STATE_MOVE_SINGLE = 0;
	static var STATE_SELECT = 1;
	function InteractionsManager(§\x1e\x16\x10§, oAPI)
	{
		super();
		this.initialize(var3,oAPI);
	}
	function initialize(§\x1e\x16\x10§, oAPI)
	{
		super.initialize(oAPI);
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
	function calculatePath(mapHandler, §\x13\t§, §\x16\x07§, §\x18\x10§, §\x19\x02§, §\x1c\x13§)
	{
		if(!var6)
		{
			this.api.gfx.mapHandler.resetEmptyCells();
		}
		var var8 = this._playerManager.data.cellNum;
		var var9 = mapHandler.getCellData(var3);
		var var10 = var9.spriteOnID;
		var var11 = !var6 && var10 != undefined;
		if(var11 && !this.api.datacenter.Game.isFight)
		{
			var var12 = (dofus.graphics.gapi.ui.Party)this.api.ui.getUIComponent("Party");
			var var13 = false;
			if(var12 != undefined)
			{
				for(var sID in var9.allSpritesOn)
				{
					if(var9.allSpritesOn[sID] && var12.getMember(String(sID)) != undefined)
					{
						var13 = true;
						break;
					}
				}
			}
			if(!var13)
			{
				var11 = false;
			}
		}
		if(var11)
		{
			return false;
		}
		if(var9.movement == 0)
		{
			return false;
		}
		if(var9.movement == 1 && var5)
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
				this.api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(this.api,mapHandler,var8,var3,{bAllDirections:false,nMaxLength:(!var5?500:this._playerManager.data.MP)});
				this.api.gfx.unSelect(true);
				this.api.gfx.select(this.convertToSimplePath(this.api.datacenter.Basics.interactionsManager_path),dofus.Constants.CELL_PATH_OVER_COLOR);
			}
			return false;
		}
		this.api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(this.api,mapHandler,var8,var3,{bAllDirections:var7,bIgnoreSprites:var6});
		if(this.api.datacenter.Basics.interactionsManager_path != null)
		{
			return true;
		}
		return false;
	}
	function convertToSimplePath(var2)
	{
		var var3 = new Array();
		for(var k in var2)
		{
			var3.push(var2[k].num);
		}
		return var3;
	}
}
