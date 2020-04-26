class dofus.graphics.gapi.controls.Smileys extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Smileys";
	function Smileys()
	{
		super();
	}
	function update()
	{
		this.initData();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.Smileys.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function addListeners()
	{
		this._cgSmileys.addEventListener("selectItem",this);
		this._cgEmotes.addEventListener("selectItem",this);
		this._cgEmotes.addEventListener("overItem",this);
		this._cgEmotes.addEventListener("outItem",this);
		this._ldrStreaming.addEventListener("initialization",this);
	}
	function initData()
	{
		var loc2 = new ank.utils.();
		if(this.api.config.isStreaming)
		{
			this._ldrStreaming.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "all.swf";
		}
		else
		{
			var loc3 = 1;
			while(loc3 <= 15)
			{
				var loc4 = new Object();
				loc4.iconFile = dofus.Constants.SMILEYS_ICONS_PATH + loc3 + ".swf";
				loc4.index = loc3;
				loc2.push(loc4);
				loc3 = loc3 + 1;
			}
			this._cgSmileys.dataProvider = loc2;
		}
		var loc5 = new ank.utils.();
		var loc6 = this.api.datacenter.Player.Emotes.getItems();
		for(var k in loc6)
		{
			var loc7 = new Object();
			var loc8 = Number(k);
			loc7.iconFile = dofus.Constants.EMOTES_ICONS_PATH + loc8 + ".swf";
			loc7.index = loc8;
			loc5.push(loc7);
			loc5.sortOn("index",Array.NUMERIC);
		}
		this._cgEmotes.dataProvider = loc5;
	}
	function attachSmileys()
	{
		var loc2 = 0;
		var loc3 = 0;
		var loc4 = 16;
		var loc5 = 4;
		var loc7 = 1;
		while(loc7 <= 15)
		{
			var loc8 = this._ldrStreaming.content.attachMovie(String(loc7),"smiley" + loc7,loc7);
			if(loc8._width > loc8._height)
			{
				var loc6 = loc8._height / loc8._width;
				loc8._height = loc6 * loc4;
				loc8._width = loc4;
			}
			else
			{
				loc6 = loc8._width / loc8._height;
				loc8._width = loc6 * loc4;
				loc8._height = loc4;
			}
			loc8._x = loc2 * (loc4 + loc5);
			loc8._y = loc3 * (loc4 + loc5);
			loc8.contentData = {index:loc7};
			loc8.onRelease = function()
			{
				ref.selectItem({target:this,owner:{_name:"_cgSmileys"}});
			};
			loc8.onRollOver = function()
			{
				this._parent.attachMovie("over","over",-1);
				this._parent.over._x = this._x;
				this._parent.over._y = this._y;
			};
			loc8.onReleaseOutside = loc8.onRollOut = function()
			{
				this._parent.createEmptyMovieClip("over",-1);
			};
			loc2 = loc2 + 1;
			if(loc2 == 5)
			{
				loc2 = 0;
				loc3 = loc3 + 1;
			}
			loc7 = loc7 + 1;
		}
	}
	function initialization(loc2)
	{
		this.attachSmileys();
	}
	function selectItem(loc2)
	{
		var loc3 = loc2.target.contentData;
		if(loc3 == undefined)
		{
			return undefined;
		}
		switch(loc2.owner._name)
		{
			case "_cgSmileys":
				this.dispatchEvent({type:"selectSmiley",index:loc3.index});
				break;
			case "_cgEmotes":
				this.dispatchEvent({type:"selectEmote",index:loc3.index});
		}
	}
	function overItem(loc2)
	{
		var loc3 = loc2.target.contentData;
		if(loc3 != undefined)
		{
			var loc4 = this.api.lang.getEmoteText(loc3.index);
			var loc5 = loc4.n;
			var loc6 = loc4.s == undefined?"":" (/" + loc4.s + ")";
			this.gapi.showTooltip(loc5 + loc6,loc2.target,-20);
		}
	}
	function outItem(loc2)
	{
		this.gapi.hideTooltip();
	}
}
