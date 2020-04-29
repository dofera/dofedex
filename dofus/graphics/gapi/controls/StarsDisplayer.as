class dofus.graphics.gapi.controls.StarsDisplayer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "StarsDisplayer";
	static var STARS_COUNT = 5;
	static var STARS_COLORS = [-1,16777011,16750848,39168,39372,6697728,2236962,16711680,65280,16777215,16711935];
	function StarsDisplayer()
	{
		super();
	}
	function __get__value()
	{
		return this._nValue;
	}
	function __set__value(var2)
	{
		this._nValue = var2;
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__value();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.StarsDisplayer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.addListeners});
	}
	function initData()
	{
		this.updateData();
	}
	function addListeners()
	{
		this._mcMask.onRollOut = function()
		{
			ref.dispatchEvent({type:"out"});
		};
		this._mcMask.onRollOver = function()
		{
			ref.dispatchEvent({type:"over"});
		};
		this._mcMask.onRelease = function()
		{
			ref.dispatchEvent({type:"click"});
		};
	}
	function updateData()
	{
		if(this._nValue != undefined && (this._nValue > 0 && !_global.isNaN(this._nValue)))
		{
			var var2 = this.getStarsColor();
			var var3 = 0;
			while(var3 < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
			{
				var var4 = this["_mcStar" + var3].fill;
				if(var2[var3] > -1)
				{
					var var5 = new Color(var4);
					var5.setRGB(var2[var3]);
				}
				else
				{
					var4._alpha = 0;
				}
				var3 = var3 + 1;
			}
		}
		else
		{
			var var6 = 0;
			while(var6 < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
			{
				this["_mcStar" + var6].fill._alpha = 0;
				var6 = var6 + 1;
			}
		}
	}
	function getStarsColor()
	{
		var var2 = new Array();
		var var3 = 0;
		while(var3 < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
		{
			var var4 = Math.floor(this._nValue / 100) + (this._nValue - Math.floor(this._nValue / 100) * 100 <= var3 * (100 / dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)?0:1);
			var2[var3] = dofus.graphics.gapi.controls.StarsDisplayer.STARS_COLORS[Math.min(var4,dofus.graphics.gapi.controls.StarsDisplayer.STARS_COLORS.length - 1)];
			var3 = var3 + 1;
		}
		return var2;
	}
}
