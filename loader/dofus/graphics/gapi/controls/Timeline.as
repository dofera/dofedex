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
	function __set__opened(var2)
	{
		this._bOpened = var2;
		this.layout_mc._visible = var2;
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
	function nextTurn(var2, var3)
	{
		if(var3 = undefined)
		{
			var3 = false;
		}
		var var4 = this.layout_mc.items_mc["item" + var2];
		if(var4 == undefined)
		{
			return undefined;
		}
		this.layout_mc.pointer_mc._visible = true;
		this.stopChrono();
		this._vcChrono = var4.chrono;
		if(var3)
		{
			this.layout_mc.pointer_mc.move(var4._x,0);
			this.layout_mc.pointer_mc._xscale = var4._xscale;
			this.layout_mc.pointer_mc._yscale = var4._yscale;
		}
		else
		{
			this.layout_mc.pointer_mc.moveTween(var4._x,var4._xscale);
		}
		this.layout_mc.pointer_mc._y = !var4._oData.isSummoned?0:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_HEIGHT_DELTA;
		this._currentDisplayIndex = var2;
	}
	function hideItem(var2)
	{
		var var3 = this.layout_mc.items_mc["item" + var2];
		var var4 = new Color(var3.sprite);
		var4.setRGB(dofus.graphics.gapi.controls.Timeline.HIDE_COLOR);
	}
	function showItem(var2)
	{
		var var3 = this.layout_mc.items_mc["item" + var2];
		var var4 = new Color(var3.sprite);
		var4.setTransform({ra:100,ga:100,ba:100,rb:0,gb:0,bb:0});
	}
	function startChrono(var2)
	{
		this._vcChrono.startTimer(var2);
	}
	function stopChrono()
	{
		this._vcChrono.stopTimer();
	}
	function updateCharacters()
	{
		var var2 = this.api.datacenter;
		var var3 = new Array();
		var var4 = 0;
		while(var4 < this._aTs.length)
		{
			var3.push(var2.Sprites.getItemAt(this._aTs[var4]));
			var4 = var4 + 1;
		}
		var var5 = var3.length;
		var4 = 0;
		while(var4 < var5)
		{
			var var7 = var3[var4];
			var var6 = var7.id;
			this.layout_mc.items_mc["item" + var6].data = var7;
			var4 = var4 + 1;
		}
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.Timeline.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.createEmptyMovieClip("layout_mc",10);
		this.layout_mc.createEmptyMovieClip("SummonedLayout",9);
		var var2 = this.layout_mc.attachMovie("TimelinePointer","pointer_mc",10);
		var2._visible = false;
		this.generate();
	}
	function addListeners()
	{
		this._btnOpenClose.onRelease = function()
		{
			this._parent.opened = !this._parent.opened;
		};
	}
	function generate(var2)
	{
		var var3 = this.api.datacenter;
		if(var2 == undefined)
		{
			var2 = var3.Game.turnSequence;
		}
		this._aTs = var2;
		var var4 = new Array();
		var var5 = 0;
		while(var5 < var2.length)
		{
			var4.push(var3.Sprites.getItemAt(var2[var5]));
			var5 = var5 + 1;
		}
		var var6 = var4.length;
		if(this.layout_mc.items_mc == undefined)
		{
			this.layout_mc.createEmptyMovieClip("items_mc",20);
		}
		var var7 = 20;
		var5 = 0;
		while(var5 < var6)
		{
			var var8 = var4[var5];
			var7 = var7 + (!var8.isSummoned?dofus.graphics.gapi.controls.Timeline.ITEM_WIDTH:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_WIDTH);
			var5 = var5 + 1;
		}
		for(var var9 in this._previousCharacList)
		{
			var var10 = false;
			for(var var11 in var4)
			{
				if(var9 == var11)
				{
					var10 = true;
				}
			}
			if(!var10)
			{
				this.layout_mc.items_mc["item" + var9].removeMovieClip();
			}
		}
		var var13 = - var7;
		var5 = 0;
		while(var5 < var6)
		{
			var var16 = var4[var5];
			var var12 = var16.id;
			var var17 = this.layout_mc.items_mc["item" + var12];
			if(var17 == undefined)
			{
				var17 = this.layout_mc.items_mc.attachMovie("TimelineItem","item" + var12,this._depth++,{index:var5,data:var16,api:this.api,gapi:this.gapi});
			}
			if(var16.isSummoned)
			{
				var17._xscale = 80;
				var17._yscale = 80;
			}
			var17._x = var13;
			var17._y = !var16.isSummoned?0:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_HEIGHT_DELTA;
			if(!var16.isSummoned)
			{
				var var14 = var17;
				this.layout_mc.SummonedLayout["TISB" + var17.index].removeMovieClip();
			}
			else
			{
				var var18 = this.layout_mc.SummonedLayout["TISB" + var14.index];
				if(var18 == undefined)
				{
					var18 = this.layout_mc.SummonedLayout.attachMovie("TimelineItemSummonedBg","TISB" + var14.index,var14.index);
				}
				var18._x = var14._x;
				var18._mcBody._width = var17._x - var14._x + var17._width + 1;
				var18._mcEnd._x = var18._mcBody._width;
			}
			var13 = var13 + (!var16.isSummoned?dofus.graphics.gapi.controls.Timeline.ITEM_WIDTH:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_WIDTH);
			var var15 = var17;
			var5 = var5 + 1;
		}
		this.nextTurn(this._currentDisplayIndex,true);
		this._previousCharacList = var4;
	}
}
