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
	function __set__value(loc2)
	{
		this._nValue = loc2;
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
		var ref = this;
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
			var loc2 = this.getStarsColor();
			var loc3 = 0;
			while(loc3 < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
			{
				var loc4 = this["_mcStar" + loc3].fill;
				if(loc2[loc3] > -1)
				{
					var loc5 = new Color(loc4);
					loc5.setRGB(loc2[loc3]);
				}
				else
				{
					loc4._alpha = 0;
				}
				loc3 = loc3 + 1;
			}
		}
		else
		{
			var loc6 = 0;
			while(loc6 < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
			{
				this["_mcStar" + loc6].fill._alpha = 0;
				loc6 = loc6 + 1;
			}
		}
	}
	function getStarsColor()
	{
		var loc2 = new Array();
		var loc3 = 0;
		while(loc3 < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
		{
			var loc4 = Math.floor(this._nValue / 100) + (this._nValue - Math.floor(this._nValue / 100) * 100 <= loc3 * (100 / dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)?0:1);
			loc2[loc3] = dofus.graphics.gapi.controls.StarsDisplayer.STARS_COLORS[Math.min(loc4,dofus.graphics.gapi.controls.StarsDisplayer.STARS_COLORS.length - 1)];
			loc3 = loc3 + 1;
		}
		return loc2;
	}
}
