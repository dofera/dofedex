class dofus.managers.TipsManager extends ank.utils.QueueEmbedMovieClip
{
	static var TIP_START_POPUP = 3;
	static var TIP_GAIN_LEVEL = 19;
	static var TIP_FIGHT_PLACEMENT = 5;
	static var TIP_FIGHT_START = 7;
	static var TIP_FIGHT_ENDMOVE = 8;
	static var TIP_FIGHT_ENDATTACK = 10;
	static var TIP_FIGHT_ENDFIGHT = 12;
	static var TIP_QUEST_WALKTHOUGH = 31;
	static var TIP_FINAL_COUNTDOWN = 34;
	static var INDICATOR_SHOWUP_TIME = 5;
	static var TRIGGER_TYPE_MAP = 1;
	static var TRIGGER_TYPE_GUI = 2;
	static var _sSelf = null;
	var _aIndicatorTimers = new Array();
	var _nIndicatorIndex = 0;
	function TipsManager(var2)
	{
		super();
		dofus.managers.TipsManager._sSelf = this;
		this.initialize(var3);
	}
	static function getInstance()
	{
		return dofus.managers.TipsManager._sSelf;
	}
	function initialize(var2)
	{
		this.api = var2;
		this._aTipsList = new Array();
		this.addToQueue({object:this,method:this.loadTipsStates});
	}
	function showNewTip(var2)
	{
		if(!this.getIsDisplayingFreshTips())
		{
			this.setHasBeenDisplayed(var2);
		}
		else if(!this.getHasBeenDisplayed(var2))
		{
			var var3 = dofus.graphics.gapi.controls.Helper.getCurrentHelper();
			if(var3 == null)
			{
				return undefined;
			}
			var3.onNewTip();
			this.addTipToList(var2);
			this.setHasBeenDisplayed(var2);
		}
	}
	function displayNextTips()
	{
		if(!this.hasNewTips())
		{
			return undefined;
		}
		var var2 = this.getTipToDisplay();
		this.showFloatingTips(var2);
		var var3 = dofus.graphics.gapi.controls.Helper.getCurrentHelper();
		if(var3 == null)
		{
			return undefined;
		}
		var3.onRemoveTip();
	}
	function hasNewTips()
	{
		return this._aTipsList.length > 0;
	}
	function resetDisplayedTipsList()
	{
		this._aTipsStates = new Array();
		this.saveTipsStates();
	}
	function pointGUI(var2, var3)
	{
		var var4 = this.api.ui.getUIComponent(var2);
		var var5 = var3[0];
		var var6 = var4[var5];
		var var7 = 1;
		while(var7 < var3.length)
		{
			var5 = String(var3[var7]);
			if(var6[var5] != undefined)
			{
				var6 = var6[var5];
				var7 = var7 + 1;
				continue;
			}
			break;
		}
		if(var6 == undefined)
		{
			return undefined;
		}
		var var8 = var6.getBounds();
		var var9 = var8.xMax - var8.xMin;
		var var10 = var8.yMax - var8.yMin;
		var var11 = var9 / 2 + var6._x + var8.xMin;
		var var12 = var10 / 2 + var6._y + var8.yMin;
		var var13 = {x:var11,y:var12};
		var6._parent.localToGlobal(var13);
		var11 = var13.x;
		var12 = var13.y;
		var var14 = Math.sqrt(Math.pow(var9,2) + Math.pow(var10,2)) / 2;
		this.api.ui.loadUIComponent("Indicator","Indicator" + this._nIndicatorIndex,{coordinates:[var11,var12],offset:var14},{bAlwaysOnTop:true});
		this._aIndicatorTimers[this._nIndicatorIndex] = _global.setInterval(this,"onIndicatorHide",dofus.managers.TipsManager.INDICATOR_SHOWUP_TIME * 1000,this._nIndicatorIndex++);
	}
	function pointCell(var2, var3, var4)
	{
		if(this.api.datacenter.Basics.aks_current_map_id == var2 || var2 == -1)
		{
			var var5 = this.api.gfx.mapHandler.getCellData(var3).mc;
			if(var5 == undefined)
			{
				return undefined;
			}
			var var6 = {x:var5._x,y:var5._y};
			var5._parent.localToGlobal(var6);
			var var7 = var6.x;
			var var8 = var6.y;
			this.api.ui.loadUIComponent("Indicator","Indicator" + this._nIndicatorIndex,{coordinates:[var7,var8],offset:var4,rotate:false},{bAlwaysOnTop:true});
			this._aIndicatorTimers[this._nIndicatorIndex] = _global.setInterval(this,"onIndicatorHide",dofus.managers.TipsManager.INDICATOR_SHOWUP_TIME * 1000,this._nIndicatorIndex++);
		}
		return undefined;
	}
	function pointSprite(var2, var3)
	{
		if(this.api.datacenter.Basics.aks_current_map_id == var2 || var2 == -1)
		{
			var var4 = this.api.gfx.spriteHandler.getSprites().getItems();
			§§enumerate(var4);
			while((var var0 = §§enumeration()) != null)
			{
				if(var4[k].gfxFile == dofus.Constants.CLIPS_PERSOS_PATH + var3 + ".swf")
				{
					var var5 = {x:var4[k].mc._x,y:var4[k].mc._y};
					var4[k].localToGlobal(var5);
					var var6 = var5.x;
					var var7 = var5.y;
					var var8 = var4[k].mc._height;
					this.api.ui.loadUIComponent("Indicator","Indicator" + this._nIndicatorIndex,{coordinates:[var6,var7],offset:var8,rotate:false},{bAlwaysOnTop:true});
					this._aIndicatorTimers[this._nIndicatorIndex] = _global.setInterval(this,"onIndicatorHide",dofus.managers.TipsManager.INDICATOR_SHOWUP_TIME * 1000,this._nIndicatorIndex++);
				}
			}
		}
		return undefined;
	}
	function pointPicto(var2, var3)
	{
		if(this.api.datacenter.Basics.aks_current_map_id == var2 || var2 == -1)
		{
			var var4 = this.api.gfx.mapHandler.getCellsData();
			§§enumerate(var4);
			while((var var0 = §§enumeration()) != null)
			{
				if(var4[k].layerObject1Num != undefined && (!_global.isNaN(var4[k].layerObject1Num) && var4[k].layerObject1Num > 0))
				{
					if(var4[k].layerObject1Num == var3)
					{
						this.pointCell(var2,var4[k].num,var4[k].mcObject1._height);
					}
				}
				if(var4[k].layerObject2Num != undefined && (!_global.isNaN(var4[k].layerObject2Num) && var4[k].layerObject2Num > 0))
				{
					if(var4[k].layerObject2Num == var3)
					{
						this.pointCell(var2,var4[k].num,var4[k].mcObject2._height);
					}
				}
			}
		}
		return undefined;
	}
	function getTipToDisplay()
	{
		var var2 = Number(this._aTipsList.pop());
		return var2;
	}
	function showFloatingTips(var2)
	{
		var var3 = this.api.kernel.OptionsManager.getOption("FloatingTipsCoord");
		var var4 = this.api.ui.loadUIComponent("FloatingTips","FloatingTips",{tip:var2,position:var3},{bStayIfPresent:true,bAlwaysOnTop:true});
	}
	function addTipToList(var2)
	{
		this._aTipsList.push(var2);
		this.saveTipsList();
	}
	function getHasBeenDisplayed(var2)
	{
		return this._aTipsStates[var2] == true;
	}
	function setHasBeenDisplayed(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = true;
		}
		if(this._aTipsStates[var2] != var3)
		{
			this._aTipsStates[var2] = var3;
			this.saveTipsStates();
		}
	}
	function getIsDisplayingFreshTips()
	{
		if(this.api.datacenter.Player.isAuthorized)
		{
			return false;
		}
		if(this.api.config.isExpo)
		{
			return true;
		}
		return this.api.kernel.OptionsManager.getOption("DisplayingFreshTips");
	}
	function setIsDisplayingFreshTips(var2)
	{
		this.api.kernel.OptionsManager.setOption("DisplayingFreshTips",var2);
	}
	function getTipsSharedObject()
	{
		if(this._soTips == undefined)
		{
			this._soTips = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_TIPS_NAME);
		}
		return this._soTips;
	}
	function loadTipsStates()
	{
		if(this.api.config.isExpo)
		{
			this._aTipsStates = new Array();
		}
		else
		{
			var var2 = this.getTipsSharedObject();
			this._aTipsStates = var2.data.TIPSSTATES;
			if(this._aTipsStates == undefined)
			{
				this._aTipsStates = new Array();
				var2.flush();
			}
		}
	}
	function saveTipsStates()
	{
		if(!this.api.config.isExpo)
		{
			var var2 = this.getTipsSharedObject();
			var2.data.TIPSSTATES = this._aTipsStates;
			var2.flush();
		}
	}
	function saveTipsList()
	{
		var var2 = this.getTipsSharedObject();
		var2.data.TIPSLIST = this._aTipsList;
		var2.flush();
	}
	function getInterfaceTriggers()
	{
		if(this._aInterfaceTriggers != undefined)
		{
			return this._aInterfaceTriggers;
		}
		var var2 = this.api.lang.getKnownledgeBaseTriggers();
		if(var2 == undefined)
		{
			return new Array();
		}
		this._aInterfaceTriggers = new Array();
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(var2[var3].t == dofus.managers.TipsManager.TRIGGER_TYPE_GUI)
			{
				this._aInterfaceTriggers["GUI" + var2[var3].v] = var2[var3].d;
			}
			var3 = var3 + 1;
		}
		return this._aInterfaceTriggers;
	}
	function getMapsTriggers()
	{
		if(this._aMapsTriggers != undefined)
		{
			return this._aMapsTriggers;
		}
		var var2 = this.api.lang.getKnownledgeBaseTriggers();
		if(var2 == undefined)
		{
			return new Array();
		}
		this._aMapsTriggers = new Array();
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(var2[var3].t == dofus.managers.TipsManager.TRIGGER_TYPE_MAP)
			{
				var var4 = var2[var3].v;
				var var5 = 0;
				while(var5 < var4.length)
				{
					if(this._aMapsTriggers["MAP" + var4[var5]] != undefined)
					{
						this._aMapsTriggers["MAP" + var4[var5]] = this._aMapsTriggers["MAP" + var4[var5]] + "|" + var2[var3].d;
					}
					else
					{
						this._aMapsTriggers["MAP" + var4[var5]] = var2[var3].d;
					}
					var5 = var5 + 1;
				}
			}
			var3 = var3 + 1;
		}
		return this._aMapsTriggers;
	}
	function onIndicatorHide(var2)
	{
		_global.clearInterval(this._aIndicatorTimers[var2]);
		this.api.ui.unloadUIComponent("Indicator" + var2);
	}
	function onNewMap(var2)
	{
		var var3 = String(this.getMapsTriggers()["MAP" + var2]);
		if(var3 != undefined && var3.length > 0)
		{
			var var4 = var3.split("|");
			var var5 = 0;
			while(var5 < var4.length)
			{
				if(var4[var5] != undefined && !_global.isNaN(var4[var5]))
				{
					this.showNewTip(Number(var4[var5]));
				}
				var5 = var5 + 1;
			}
		}
	}
	function onNewInterface(var2)
	{
		var var3 = this.getInterfaceTriggers()["GUI" + var2];
		if(var3 != undefined && !_global.isNaN(var3))
		{
			this.showNewTip(var3);
		}
	}
	function onLink(var2)
	{
		var var3 = var2.params.split(",");
		if((var var0 = var3[0]) !== "CellIndicator")
		{
			switch(null)
			{
				case "UiIndicator":
					var var7 = var3[1];
					var var8 = new Array();
					var var9 = 2;
					while(var9 < var3.length)
					{
						var8.push(var3[var9]);
						var9 = var9 + 1;
					}
					this.addToQueue({object:this,method:this.pointGUI,params:[var7,var8]});
					break;
				case "SpriteIndicator":
					var var10 = Number(var3[1]);
					var var11 = Number(var3[2]);
					this.addToQueue({object:this,method:this.pointSprite,params:[var10,var11]});
					break;
				case "PictoIndicator":
					var var12 = Number(var3[1]);
					var var13 = Number(var3[2]);
					this.addToQueue({object:this,method:this.pointPicto,params:[var12,var13]});
					break;
				case "PointCompass":
					var var14 = Number(var3[1]);
					var var15 = Number(var3[2]);
					this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.updateCompass,params:[var14,var15,true]});
					break;
				case "KnownledgeBase":
					var var16 = Number(var3[1]);
					this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["KnownledgeBase","KnownledgeBase",{article:var16}]});
			}
		}
		else
		{
			var var4 = Number(var3[1]);
			var var5 = Number(var3[2]);
			var var6 = Number(var3[3]);
			this.addToQueue({object:this,method:this.pointCell,params:[var4,var5,var6]});
		}
	}
}
