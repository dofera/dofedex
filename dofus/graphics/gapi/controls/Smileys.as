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
		var var2 = new ank.utils.();
		if(this.api.config.isStreaming)
		{
			this._ldrStreaming.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "all.swf";
		}
		else
		{
			var var3 = 1;
			while(var3 <= 15)
			{
				var var4 = new Object();
				var4.iconFile = dofus.Constants.SMILEYS_ICONS_PATH + var3 + ".swf";
				var4.index = var3;
				var2.push(var4);
				var3 = var3 + 1;
			}
			this._cgSmileys.dataProvider = var2;
		}
		var var5 = new ank.utils.();
		var var6 = this.api.datacenter.Player.Emotes.getItems();
		for(var k in var6)
		{
			var var7 = new Object();
			var var8 = Number(k);
			var7.iconFile = dofus.Constants.EMOTES_ICONS_PATH + var8 + ".swf";
			var7.index = var8;
			var5.push(var7);
			var5.sortOn("index",Array.NUMERIC);
		}
		this._cgEmotes.dataProvider = var5;
	}
	function attachSmileys()
	{
		var var2 = 0;
		var var3 = 0;
		var var4 = 16;
		var var5 = 4;
		var var7 = 1;
		while(var7 <= 15)
		{
			var var8 = this._ldrStreaming.content.attachMovie(String(var7),"smiley" + var7,var7);
			if(var8._width > var8._height)
			{
				var var6 = var8._height / var8._width;
				var8._height = var6 * var4;
				var8._width = var4;
			}
			else
			{
				var6 = var8._width / var8._height;
				var8._width = var6 * var4;
				var8._height = var4;
			}
			var8._x = var2 * (var4 + var5);
			var8._y = var3 * (var4 + var5);
			var8.contentData = {index:var7};
			var ref = this;
			var8.onRelease = function()
			{
				ref.selectItem({target:this,owner:{_name:"_cgSmileys"}});
			};
			var8.onRollOver = function()
			{
				this._parent.attachMovie("over","over",-1);
				this._parent.over._x = this._x;
				this._parent.over._y = this._y;
			};
			var8.onReleaseOutside = var8.onRollOut = function()
			{
				this._parent.createEmptyMovieClip("over",-1);
			};
			var2 = var2 + 1;
			if(var2 == 5)
			{
				var2 = 0;
				var3 = var3 + 1;
			}
			var7 = var7 + 1;
		}
	}
	function initialization(var2)
	{
		this.attachSmileys();
	}
	function selectItem(var2)
	{
		var var3 = var2.target.contentData;
		if(var3 == undefined)
		{
			return undefined;
		}
		switch(var2.owner._name)
		{
			case "_cgSmileys":
				this.dispatchEvent({type:"selectSmiley",index:var3.index});
				break;
			case "_cgEmotes":
				this.dispatchEvent({type:"selectEmote",index:var3.index});
		}
	}
	function overItem(var2)
	{
		var var3 = var2.target.contentData;
		if(var3 != undefined)
		{
			var var4 = this.api.lang.getEmoteText(var3.index);
			var var5 = var4.n;
			var var6 = var4.s == undefined?"":" (/" + var4.s + ")";
			this.gapi.showTooltip(var5 + var6,var2.target,-20);
		}
	}
	function outItem(var2)
	{
		this.gapi.hideTooltip();
	}
}
