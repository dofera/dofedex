class dofus.graphics.gapi.controls.Timeline extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Timeline";
	static var ITEM_WIDTH = 34;
	static var ITEM_SUMMONED_HEIGHT_DELTA = 2;
	static var ITEM_SUMMONED_WIDTH = 28;
	static var HIDE_COLOR = 4473924;
	var _currentDisplayIndex = 0;
	var _itemsList = new Array();
	var _previousCharacList = new Array();
	var _depth = 0;
	var _bOpened = true;
	function Timeline()
	{
		super();
	}
	function __set__opened(loc2)
	{
		this._bOpened = loc2;
		this.layout_mc._visible = loc2;
		return this.__get__opened();
	}
	function __get__opened()
	{
		return this._bOpened;
	}
	function update()
	{
		this.generate();
	}
	function nextTurn(loc2, loc3)
	{
		if(loc3 = undefined)
		{
			loc3 = false;
		}
		var loc4 = this.layout_mc.items_mc["item" + loc2];
		if(loc4 == undefined)
		{
			return undefined;
		}
		this.layout_mc.pointer_mc._visible = true;
		this.stopChrono();
		this._vcChrono = loc4.chrono;
		if(loc3)
		{
			this.layout_mc.pointer_mc.move(loc4._x,0);
			this.layout_mc.pointer_mc._xscale = loc4._xscale;
			this.layout_mc.pointer_mc._yscale = loc4._yscale;
		}
		else
		{
			this.layout_mc.pointer_mc.moveTween(loc4._x,loc4._xscale);
		}
		this.layout_mc.pointer_mc._y = !loc4._oData.isSummoned?0:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_HEIGHT_DELTA;
		this._currentDisplayIndex = loc2;
	}
	function hideItem(loc2)
	{
		var loc3 = this.layout_mc.items_mc["item" + loc2];
		var loc4 = new Color(loc3.sprite);
		loc4.setRGB(dofus.graphics.gapi.controls.Timeline.HIDE_COLOR);
	}
	function showItem(loc2)
	{
		var loc3 = this.layout_mc.items_mc["item" + loc2];
		var loc4 = new Color(loc3.sprite);
		loc4.setTransform({ra:100,ga:100,ba:100,rb:0,gb:0,bb:0});
	}
	function startChrono(loc2)
	{
		this._vcChrono.startTimer(loc2);
	}
	function stopChrono()
	{
		this._vcChrono.stopTimer();
	}
	function updateCharacters()
	{
		var loc2 = this.api.datacenter;
		var loc3 = new Array();
		var loc4 = 0;
		while(loc4 < this._aTs.length)
		{
			loc3.push(loc2.Sprites.getItemAt(this._aTs[loc4]));
			loc4 = loc4 + 1;
		}
		var loc5 = loc3.length;
		loc4 = 0;
		while(loc4 < loc5)
		{
			var loc7 = loc3[loc4];
			var loc6 = loc7.id;
			this.layout_mc.items_mc["item" + loc6].data = loc7;
			loc4 = loc4 + 1;
		}
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.Timeline.CLASS_NAME);
	}
	function createChildren()
	{
		this.createEmptyMovieClip("layout_mc",10);
		this.layout_mc.createEmptyMovieClip("SummonedLayout",9);
		var loc2 = this.layout_mc.attachMovie("TimelinePointer","pointer_mc",10);
		loc2._visible = false;
		this.generate();
	}
	function generate(loc2)
	{
		var loc3 = this.api.datacenter;
		if(loc2 == undefined)
		{
			loc2 = loc3.Game.turnSequence;
		}
		this._aTs = loc2;
		var loc4 = new Array();
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			loc4.push(loc3.Sprites.getItemAt(loc2[loc5]));
			loc5 = loc5 + 1;
		}
		var loc6 = loc4.length;
		if(this.layout_mc.items_mc == undefined)
		{
			this.layout_mc.createEmptyMovieClip("items_mc",20);
		}
		var loc7 = 20;
		loc5 = 0;
		while(loc5 < loc6)
		{
			var loc8 = loc4[loc5];
			loc7 = loc7 + (!loc8.isSummoned?dofus.graphics.gapi.controls.Timeline.ITEM_WIDTH:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_WIDTH);
			loc5 = loc5 + 1;
		}
		for(var k in this._previousCharacList)
		{
			var loc9 = this._previousCharacList[k].id;
			var loc10 = false;
			for(var kk in loc4)
			{
				var loc11 = loc4[kk].id;
				if(loc9 == loc11)
				{
					loc10 = true;
				}
			}
			if(!loc10)
			{
				this.layout_mc.items_mc["item" + loc9].removeMovieClip();
			}
		}
		var loc13 = - loc7;
		loc5 = 0;
		while(loc5 < loc6)
		{
			var loc16 = loc4[loc5];
			var loc12 = loc16.id;
			var loc17 = this.layout_mc.items_mc["item" + loc12];
			if(loc17 == undefined)
			{
				loc17 = this.layout_mc.items_mc.attachMovie("TimelineItem","item" + loc12,this._depth++,{index:loc5,data:loc16,api:this.api,gapi:this.gapi});
			}
			if(loc16.isSummoned)
			{
				loc17._xscale = 80;
				loc17._yscale = 80;
			}
			loc17._x = loc13;
			loc17._y = !loc16.isSummoned?0:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_HEIGHT_DELTA;
			if(!loc16.isSummoned)
			{
				var loc14 = loc17;
				this.layout_mc.SummonedLayout["TISB" + loc17.index].removeMovieClip();
			}
			else
			{
				var loc18 = this.layout_mc.SummonedLayout["TISB" + loc14.index];
				if(loc18 == undefined)
				{
					loc18 = this.layout_mc.SummonedLayout.attachMovie("TimelineItemSummonedBg","TISB" + loc14.index,loc14.index);
				}
				loc18._x = loc14._x;
				loc18._mcBody._width = loc17._x - loc14._x + loc17._width + 1;
				loc18._mcEnd._x = loc18._mcBody._width;
			}
			loc13 = loc13 + (!loc16.isSummoned?dofus.graphics.gapi.controls.Timeline.ITEM_WIDTH:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_WIDTH);
			var loc15 = loc17;
			loc5 = loc5 + 1;
		}
		this.nextTurn(this._currentDisplayIndex,true);
		this._previousCharacList = loc4;
	}
}
