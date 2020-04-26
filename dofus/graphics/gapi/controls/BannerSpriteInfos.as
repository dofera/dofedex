class dofus.graphics.gapi.controls.BannerSpriteInfos extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BannerSpriteInfos";
	function BannerSpriteInfos()
	{
		super();
	}
	function __set__data(loc2)
	{
		this._oSprite = loc2;
		return this.__get__data();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.BannerSpriteInfos.CLASS_NAME);
	}
	function update(loc2)
	{
		this.data = loc2;
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
		var loc2 = this._oSprite.resistances;
		this._lblNeutral.text = loc2[0] != undefined?loc2[0] + "%":"0%";
		this._lblEarth.text = loc2[1] != undefined?loc2[1] + "%":"0%";
		this._lblFire.text = loc2[2] != undefined?loc2[2] + "%":"0%";
		this._lblWater.text = loc2[3] != undefined?loc2[3] + "%":"0%";
		this._lblAir.text = loc2[4] != undefined?loc2[4] + "%":"0%";
		this._lblDodgeAP.text = loc2[5] != undefined?loc2[5] + "%":"0%";
		this._lblDodgeMP.text = loc2[6] != undefined?loc2[6] + "%":"0%";
	}
	function applyColor(loc2, loc3)
	{
		var loc4 = 0;
		switch(loc3)
		{
			case 1:
				loc4 = this._oSprite.color1;
				break;
			case 2:
				loc4 = this._oSprite.color2;
				break;
			default:
				if(loc0 !== 3)
				{
					break;
				}
				loc4 = this._oSprite.color3;
				break;
		}
		if(loc4 == -1 || loc4 == undefined)
		{
			return undefined;
		}
		var loc5 = (loc4 & 16711680) >> 16;
		var loc6 = (loc4 & 65280) >> 8;
		var loc7 = loc4 & 255;
		var loc8 = new Color(loc2);
		var loc9 = new Object();
		loc9 = {ra:0,ga:0,ba:0,rb:loc5,gb:loc6,bb:loc7};
		loc8.setTransform(loc9);
	}
	function initialization(loc2)
	{
		var loc3 = loc2.target.content;
		var loc4 = loc3._mcMask;
		loc3._x = - loc4._x;
		loc3._y = - loc4._y;
		this._ldrSprite._xscale = 10000 / loc4._xscale;
		this._ldrSprite._yscale = 10000 / loc4._yscale;
	}
	function complete(loc2)
	{
		var ref = this;
		this._ldrSprite.content.stringCourseColor = function(loc2, loc3)
		{
			ref.applyColor(loc2,loc3);
		};
	}
}
