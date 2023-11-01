class dofus.graphics.gapi.controls.BannerSpriteInfos extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BannerSpriteInfos";
	function BannerSpriteInfos()
	{
		super();
	}
	function __set__data(var2)
	{
		this._oSprite = var2;
		return this.__get__data();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.BannerSpriteInfos.CLASS_NAME);
	}
	function update(var2)
	{
		this.data = var2;
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initData});
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initData});
	}
	function addListeners()
	{
		this._ldrSprite.addEventListener("initialization",this);
		this._ldrSprite.addEventListener("complete",this);
	}
	function initTexts()
	{
		this._lblRes.text = this.api.lang.getText("RESISTANCES");
	}
	function initData()
	{
		this._lblName.text = this._oSprite.name;
		this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + this._oSprite.Level;
		this._lblLP.text = !_global.isNaN(this._oSprite.LP)?this._oSprite.LP:"";
		this._lblAP.text = !_global.isNaN(this._oSprite.AP)?String(Math.max(0,this._oSprite.AP)):"";
		this._lblMP.text = !_global.isNaN(this._oSprite.MP)?String(Math.max(0,this._oSprite.MP)):"";
		this._lblAverageDamages.text = this._oSprite.averageDamages;
		this._ldrSprite.contentPath = this._oSprite.artworkFile;
		var var2 = this._oSprite.resistances;
		this._lblNeutral.text = var2[0] != undefined?var2[0] + "%":"0%";
		this._lblEarth.text = var2[1] != undefined?var2[1] + "%":"0%";
		this._lblFire.text = var2[2] != undefined?var2[2] + "%":"0%";
		this._lblWater.text = var2[3] != undefined?var2[3] + "%":"0%";
		this._lblAir.text = var2[4] != undefined?var2[4] + "%":"0%";
		this._lblDodgeAP.text = var2[5] != undefined?var2[5] + "%":"0%";
		this._lblDodgeMP.text = var2[6] != undefined?var2[6] + "%":"0%";
	}
	function applyColor(var2, var3)
	{
		var var4 = 0;
		switch(var3)
		{
			case 1:
				var4 = this._oSprite.color1;
				break;
			case 2:
				var4 = this._oSprite.color2;
				break;
			default:
				if(var0 !== 3)
				{
					break;
				}
				var4 = this._oSprite.color3;
				break;
		}
		if(var4 == -1 || var4 == undefined)
		{
			return undefined;
		}
		var var5 = (var4 & 16711680) >> 16;
		var var6 = (var4 & 65280) >> 8;
		var var7 = var4 & 255;
		var var8 = new Color(var2);
		var var9 = new Object();
		var9 = {ra:0,ga:0,ba:0,rb:var5,gb:var6,bb:var7};
		var8.setTransform(var9);
	}
	function initialization(var2)
	{
		var var3 = var2.target.content;
		var var4 = var3._mcMask;
		var3._x = - var4._x;
		var3._y = - var4._y;
		this._ldrSprite._xscale = 10000 / var4._xscale;
		this._ldrSprite._yscale = 10000 / var4._yscale;
	}
	function complete(var2)
	{
		var ref = this;
		this._ldrSprite.content.stringCourseColor = function(var2, var3)
		{
			ref.applyColor(var2,var3);
		};
	}
}
