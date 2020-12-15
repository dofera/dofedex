class dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "ArtworkRotationItem";
	static var RED = [0,45,89,134,178];
	static var GREEN = [0,35,70,106,141];
	static var BLUE = [0,25,50,75,100];
	static var PERCENT = [100,75,50,25,0];
	function ArtworkRotationItem()
	{
		super();
		this._mcAlphaMask._visible = false;
	}
	function __set__sex(var2)
	{
		this._nSex = Number(var2);
		return this.__get__sex();
	}
	function __set__scale(var2)
	{
		this._nScale = Number(var2);
		return this.__get__scale();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.CLASS_NAME);
	}
	function loadArtwork(var2)
	{
		var var3 = dofus.Constants.GUILDS_BIG_PATH + var2 + this._nSex + ".swf";
		this._ldrArtwork.addEventListener("initialization",this);
		this._ldrArtwork.contentPath = var3;
		this._mcAlphaMask.cacheAsBitmap = true;
		this._mcAlphaMask._xscale = this._mcAlphaMask._yscale = 85;
		this._ldrArtwork.setMask(this._mcAlphaMask);
	}
	function colorize(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = false;
		}
		var nLen = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.RED.length;
		var cTmp = new Color(this._ldrArtwork);
		var oTmp = new Object();
		var nI = !var2?0:nLen - 1;
		if(!var3)
		{
			oTmp.ra = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
			oTmp.rb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.RED[nI];
			oTmp.ga = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
			oTmp.gb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.GREEN[nI];
			oTmp.ba = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
			oTmp.bb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.BLUE[nI];
			cTmp.setTransform(oTmp);
		}
		else
		{
			var nInc = !var2?1:-1;
			this.onEnterFrame = function()
			{
				oTmp.ra = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
				oTmp.rb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.RED[nI];
				oTmp.ga = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
				oTmp.gb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.GREEN[nI];
				oTmp.ba = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.PERCENT[nI];
				oTmp.bb = dofus.graphics.gapi.controls.artworkrotation.ArtworkRotationItem.BLUE[nI];
				cTmp.setTransform(oTmp);
				nI = nI + nInc;
				if(nI >= nLen || nI < 0)
				{
					this._oLastTransform = oTmp;
					delete this.onEnterFrame;
				}
			};
		}
	}
	function initialization(var2)
	{
		var2.clip._xscale = var2.clip._yscale = this._nScale;
	}
}
