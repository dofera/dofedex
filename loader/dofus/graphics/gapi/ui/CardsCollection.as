class dofus.graphics.gapi.ui.CardsCollection extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "CardsCollection";
	function CardsCollection()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.CardsCollection.CLASS_NAME);
	}
	function destroy()
	{
		this.gapi.hideTooltip();
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function initTexts()
	{
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		var var2 = 1;
		while(var2 <= 9)
		{
			var var3 = this["_ctr" + var2];
			var3.addEventListener("click",this);
			var3.addEventListener("over",this);
			var3.addEventListener("out",this);
			var2 = var2 + 1;
		}
	}
	function initData()
	{
		this._ctr1.contentData = {iconFile:"Card",params:{name:"La carte",background:0,gfxFile:dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
		this._ctr2.contentData = {iconFile:"Card",params:{name:"Une autre carte",background:1,gfxFile:dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
		this._ctr3.contentData = {iconFile:"Card",params:{name:"Le monstre",background:2,gfxFile:dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
		this._ctr4.contentData = {iconFile:"Card",params:{name:"Lee",background:3,gfxFile:dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
		this._ctr5.contentData = {iconFile:"Card",params:{name:"Gross",background:4,gfxFile:dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
		this._ctr6.contentData = {iconFile:"Card",params:{name:Monster,background:5,gfxFile:dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}};
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
				this.callClose();
				break;
			default:
				switch(null)
				{
					case "_ctr2":
					case "_ctr3":
					case "_ctr4":
					case "_ctr5":
					case "_ctr6":
					case "_ctr7":
					case "_ctr8":
					case "_ctr9":
				}
				break;
			case "_ctr1":
				var var3 = var2.target.contentData;
				if(var3 != undefined)
				{
					this._ctrMain.forceNextLoad();
					this._ctrMain.contentData = var3;
					break;
				}
		}
	}
}
