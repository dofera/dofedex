class dofus.graphics.gapi.ui.gifts.GiftsSprite extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Gifts";
	function GiftsSprite()
	{
		super();
	}
	function __set__data(§\x1e\x1a\x02§)
	{
		this._oData = var2;
		if(this.initialized)
		{
			this.addToQueue({object:this,method:this.updateData});
		}
		return this.__get__data();
	}
	function __get__data()
	{
		return this._oData;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.gifts.GiftsSprite.CLASS_NAME);
	}
	function createChildren()
	{
		this._mcSelect._visible = false;
		this._mcSelect.stop();
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._ldrSprite.addEventListener("initialization",this);
		this._btnBack.addEventListener("click",this);
		this._btnBack.addEventListener("over",this);
		this._btnBack.addEventListener("out",this);
	}
	function updateData()
	{
		if(this._oData != undefined)
		{
			this._lblName.text = this._oData.name;
			this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + this._oData.Level;
			this._ldrSprite.contentPath = this._oData.gfxFile;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._ldrSprite.contentPath = "";
		}
	}
	function initialization(§\x1e\x19\x18§)
	{
		var var3 = var2.clip;
		this.gapi.api.colors.addSprite(var3,this._oData);
		var3.attachMovie("staticF","mcAnim",10);
	}
	function click(§\x1e\x19\x18§)
	{
		if(this._bEnabled)
		{
			this.dispatchEvent({type:"onSpriteSelected",data:this._oData});
		}
	}
	function over(§\x1e\x19\x18§)
	{
		if(this._bEnabled)
		{
			this._mcSelect._visible = true;
			this._mcSelect.play();
		}
	}
	function out(§\x1e\x19\x18§)
	{
		if(this._bEnabled)
		{
			this._mcSelect._visible = false;
			this._mcSelect.stop();
		}
	}
}
