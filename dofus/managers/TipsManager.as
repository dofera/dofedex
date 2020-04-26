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
	function TipsManager(loc3)
	{
		super();
		dofus.managers.TipsManager._sSelf = this;
		this.initialize(loc3);
	}
	static function getInstance()
	{
		return dofus.managers.TipsManager._sSelf;
	}
	function initialize(loc2)
	{
		this.api = loc2;
		this._aTipsList = new Array();
		this.addToQueue({object:this,method:this.loadTipsStates});
	}
	function showNewTip(loc2)
	{
		if(!this.getIsDisplayingFreshTips())
		{
			this.setHasBeenDisplayed(loc2);
		}
		else if(!this.getHasBeenDisplayed(loc2))
		{
			var loc3 = dofus.graphics.gapi.controls.Helper.getCurrentHelper();
			if(loc3 == null)
			{
				return undefined;
			}
			loc3.onNewTip();
			this.addTipToList(loc2);
			this.setHasBeenDisplayed(loc2);
		}
	}
	function displayNextTips()
	{
		if(!this.hasNewTips())
		{
			return undefined;
		}
		var loc2 = this.getTipToDisplay();
		this.showFloatingTips(loc2);
		var loc3 = dofus.graphics.gapi.controls.Helper.getCurrentHelper();
		if(loc3 == null)
		{
			return undefined;
		}
		loc3.onRemoveTip();
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
	function pointGUI(loc2, loc3)
	{
		var loc4 = this.api.ui.getUIComponent(loc2);
		var loc5 = loc3[0];
		var loc6 = loc4[loc5];
		var loc7 = 1;
		while(loc7 < loc3.length)
		{
			loc5 = String(loc3[loc7]);
			if(loc6[loc5] != undefined)
			{
				loc6 = loc6[loc5];
				loc7 = loc7 + 1;
				continue;
			}
			break;
		}
		if(loc6 == undefined)
		{
			return undefined;
		}
		var loc8 = loc6.getBounds();
		var loc9 = loc8.xMax - loc8.xMin;
		var loc10 = loc8.yMax - loc8.yMin;
		var loc11 = loc9 / 2 + loc6._x + loc8.xMin;
		var loc12 = loc10 / 2 + loc6._y + loc8.yMin;
		var loc13 = {x:loc11,y:loc12};
		loc6._parent.localToGlobal(loc13);
		loc11 = loc13.x;
		loc12 = loc13.y;
		var loc14 = Math.sqrt(Math.pow(loc9,2) + Math.pow(loc10,2)) / 2;
		this.api.ui.loadUIComponent("Indicator","Indicator" + this._nIndicatorIndex,{coordinates:[loc11,loc12],offset:loc14},{bAlwaysOnTop:true});
		this._aIndicatorTimers[this._nIndicatorIndex] = _global.setInterval(this,"onIndicatorHide",dofus.managers.TipsManager.INDICATOR_SHOWUP_TIME * 1000,this._nIndicatorIndex++);
	}
	function pointCell(loc2, loc3, loc4)
	{
		if(this.api.datacenter.Basics.aks_current_map_id == loc2 || loc2 == -1)
		{
			var loc5 = this.api.gfx.mapHandler.getCellData(loc3).mc;
			if(loc5 == undefined)
			{
				return undefined;
			}
			var loc6 = {x:loc5._x,y:loc5._y};
			loc5._parent.localToGlobal(loc6);
			var loc7 = loc6.x;
			var loc8 = loc6.y;
			this.api.ui.loadUIComponent("Indicator","Indicator" + this._nIndicatorIndex,{coordinates:[loc7,loc8],offset:loc4,rotate:false},{bAlwaysOnTop:true});
			this._aIndicatorTimers[this._nIndicatorIndex] = _global.setInterval(this,"onIndicatorHide",dofus.managers.TipsManager.INDICATOR_SHOWUP_TIME * 1000,this._nIndicatorIndex++);
		}
		return undefined;
	}
	function pointSprite(loc2, loc3)
	{
		if(this.api.datacenter.Basics.aks_current_map_id == loc2 || loc2 == -1)
		{
			var loc4 = this.api.gfx.spriteHandler.getSprites().getItems();
			§§enumerate(loc4);
			while((var loc0 = §§enumeration()) != null)
			{
				if(loc4[k].gfxFile == dofus.Constants.CLIPS_PERSOS_PATH + loc3 + ".swf")
				{
					var loc5 = {x:loc4[k].mc._x,y:loc4[k].mc._y};
					loc4[k].localToGlobal(loc5);
					var loc6 = loc5.x;
					var loc7 = loc5.y;
					var loc8 = loc4[k].mc._height;
					this.api.ui.loadUIComponent("Indicator","Indicator" + this._nIndicatorIndex,{coordinates:[loc6,loc7],offset:loc8,rotate:false},{bAlwaysOnTop:true});
					this._aIndicatorTimers[this._nIndicatorIndex] = _global.setInterval(this,"onIndicatorHide",dofus.managers.TipsManager.INDICATOR_SHOWUP_TIME * 1000,this._nIndicatorIndex++);
				}
			}
		}
		return undefined;
	}
	function pointPicto(loc2, loc3)
	{
		if(this.api.datacenter.Basics.aks_current_map_id == loc2 || loc2 == -1)
		{
			var loc4 = this.api.gfx.mapHandler.getCellsData();
			for(var k in loc4)
			{
				if(loc4[k].layerObject1Num != undefined && (!_global.isNaN(loc4[k].layerObject1Num) && loc4[k].layerObject1Num > 0))
				{
					if(loc4[k].layerObject1Num == loc3)
					{
						this.pointCell(loc2,loc4[k].num,loc4[k].mcObject1._height);
					}
				}
				if(loc4[k].layerObject2Num != undefined && (!_global.isNaN(loc4[k].layerObject2Num) && loc4[k].layerObject2Num > 0))
				{
					if(loc4[k].layerObject2Num == loc3)
					{
						this.pointCell(loc2,loc4[k].num,loc4[k].mcObject2._height);
					}
				}
			}
		}
		return undefined;
	}
	function getTipToDisplay()
	{
		var loc2 = Number(this._aTipsList.pop());
		return loc2;
	}
	function showFloatingTips(loc2)
	{
		var loc3 = this.api.kernel.OptionsManager.getOption("FloatingTipsCoord");
		var loc4 = this.api.ui.loadUIComponent("FloatingTips","FloatingTips",{tip:loc2,position:loc3},{bStayIfPresent:true,bAlwaysOnTop:true});
	}
	function addTipToList(loc2)
	{
		this._aTipsList.push(loc2);
		this.saveTipsList();
	}
	function getHasBeenDisplayed(loc2)
	{
		return this._aTipsStates[loc2] == true;
	}
	function setHasBeenDisplayed(loc2, loc3)
	{
		if(loc3 == undefined)
		{
			loc3 = true;
		}
		if(this._aTipsStates[loc2] != loc3)
		{
			this._aTipsStates[loc2] = loc3;
			this.saveTipsStates();
		}
	}
	function getIsDisplayingFreshTips()
	{
		if(this.api.config.isExpo)
		{
			return true;
		}
		return this.api.kernel.OptionsManager.getOption("DisplayingFreshTips");
	}
	function setIsDisplayingFreshTips(loc2)
	{
		this.api.kernel.OptionsManager.setOption("DisplayingFreshTips",loc2);
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
			var loc2 = this.getTipsSharedObject();
			this._aTipsStates = loc2.data.TIPSSTATES;
			if(this._aTipsStates == undefined)
			{
				this._aTipsStates = new Array();
				loc2.flush();
			}
		}
	}
	function saveTipsStates()
	{
		if(!this.api.config.isExpo)
		{
			var loc2 = this.getTipsSharedObject();
			loc2.data.TIPSSTATES = this._aTipsStates;
			loc2.flush();
		}
	}
	function saveTipsList()
	{
		var loc2 = this.getTipsSharedObject();
		loc2.data.TIPSLIST = this._aTipsList;
		loc2.flush();
	}
	function getInterfaceTriggers()
	{
		if(this._aInterfaceTriggers != undefined)
		{
			return this._aInterfaceTriggers;
		}
		var loc2 = this.api.lang.getKnownledgeBaseTriggers();
		if(loc2 == undefined)
		{
			return new Array();
		}
		this._aInterfaceTriggers = new Array();
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			if(loc2[loc3].t == dofus.managers.TipsManager.TRIGGER_TYPE_GUI)
			{
				this._aInterfaceTriggers["GUI" + loc2[loc3].v] = loc2[loc3].d;
			}
			loc3 = loc3 + 1;
		}
		return this._aInterfaceTriggers;
	}
	function getMapsTriggers()
	{
		if(this._aMapsTriggers != undefined)
		{
			return this._aMapsTriggers;
		}
		var loc2 = this.api.lang.getKnownledgeBaseTriggers();
		if(loc2 == undefined)
		{
			return new Array();
		}
		this._aMapsTriggers = new Array();
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			if(loc2[loc3].t == dofus.managers.TipsManager.TRIGGER_TYPE_MAP)
			{
				var loc4 = loc2[loc3].v;
				var loc5 = 0;
				while(loc5 < loc4.length)
				{
					if(this._aMapsTriggers["MAP" + loc4[loc5]] != undefined)
					{
						this._aMapsTriggers["MAP" + loc4[loc5]] = this._aMapsTriggers["MAP" + loc4[loc5]] + "|" + loc2[loc3].d;
					}
					else
					{
						this._aMapsTriggers["MAP" + loc4[loc5]] = loc2[loc3].d;
					}
					loc5 = loc5 + 1;
				}
			}
			loc3 = loc3 + 1;
		}
		return this._aMapsTriggers;
	}
	function onIndicatorHide(loc2)
	{
		_global.clearInterval(this._aIndicatorTimers[loc2]);
		this.api.ui.unloadUIComponent("Indicator" + loc2);
	}
	function onNewMap(loc2)
	{
		var loc3 = String(this.getMapsTriggers()["MAP" + loc2]);
		if(loc3 != undefined && loc3.length > 0)
		{
			var loc4 = loc3.split("|");
			var loc5 = 0;
			while(loc5 < loc4.length)
			{
				if(loc4[loc5] != undefined && !_global.isNaN(loc4[loc5]))
				{
					this.showNewTip(Number(loc4[loc5]));
				}
				loc5 = loc5 + 1;
			}
		}
	}
	function onNewInterface(loc2)
	{
		var loc3 = this.getInterfaceTriggers()["GUI" + loc2];
		if(loc3 != undefined && !_global.isNaN(loc3))
		{
			this.showNewTip(loc3);
		}
	}
	function onLink(loc2)
	{
		var loc3 = loc2.params.split(",");
		if((var loc0 = loc3[0]) !== "CellIndicator")
		{
			switch(null)
			{
				case "UiIndicator":
					var loc7 = loc3[1];
					var loc8 = new Array();
					var loc9 = 2;
					while(loc9 < loc3.length)
					{
						loc8.push(loc3[loc9]);
						loc9 = loc9 + 1;
					}
					this.addToQueue({object:this,method:this.pointGUI,params:[loc7,loc8]});
					break;
				case "SpriteIndicator":
					var loc10 = Number(loc3[1]);
					var loc11 = Number(loc3[2]);
					this.addToQueue({object:this,method:this.pointSprite,params:[loc10,loc11]});
					break;
				case "PictoIndicator":
					var loc12 = Number(loc3[1]);
					var loc13 = Number(loc3[2]);
					this.addToQueue({object:this,method:this.pointPicto,params:[loc12,loc13]});
					break;
				case "PointCompass":
					var loc14 = Number(loc3[1]);
					var loc15 = Number(loc3[2]);
					this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.updateCompass,params:[loc14,loc15,true]});
					break;
				default:
					if(loc0 !== "KnownledgeBase")
					{
						break;
					}
					var loc16 = Number(loc3[1]);
					this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["KnownledgeBase","KnownledgeBase",{article:loc16}]});
					break;
			}
		}
		else
		{
			var loc4 = Number(loc3[1]);
			var loc5 = Number(loc3[2]);
			var loc6 = Number(loc3[3]);
			this.addToQueue({object:this,method:this.pointCell,params:[loc4,loc5,loc6]});
		}
	}
}
