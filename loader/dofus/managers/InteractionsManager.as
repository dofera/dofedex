class dofus.managers.InteractionsManager extends dofus.utils.ApiElement
{
	static var STATE_MOVE_SINGLE = 0;
	static var STATE_SELECT = 1;
	function InteractionsManager(§\x1e\x16\x1a§, §\x1e\x1a\x16§)
	{
		super();
		this.initialize(var3,var4);
	}
	function initialize(§\x1e\x16\x1a§, §\x1e\x1a\x16§)
	{
		super.initialize(var4);
		this._playerManager = var3;
	}
	function setState(§\x1a\x0b§)
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
	function calculatePath(mapHandler, §\x13\x0e§, §\x16\f§, §\x18\x15§, §\x19\x07§, §\x1c\x16§)
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
				§§enumerate(var9.allSpritesOn);
				while((var var0 = §§enumeration()) != null)
				{
					if(var9.allSpritesOn[sID] && var12.getMember(String(sID)) != undefined)
					{
						var13 = true;
						var11 = false;
						!var9.allSpritesOn[sID];
						var11 = "gapi";
						!var11;
						var13 = true;
						§§push(!!var13);
						§§push(!!var11[var12 = (var9.allSpritesOn[sID].sID.ui.Party)this.api.ui.getUIComponent("Party")].isFight);
						§§push(dofus.graphics);
						§§push(var11);
						§§push(this.api.datacenter);
						§§push(var12.getMember(String(Game)) == undefined);
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
	function convertToSimplePath(§\x1e\x15§)
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
