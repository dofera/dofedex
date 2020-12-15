class dofus.graphics.gapi.controls.Emblem extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "Emblem";
	var _bShadow = false;
	function Emblem()
	{
		super();
	}
	function __set__shadow(var2)
	{
		this._bShadow = var2;
		return this.__get__shadow();
	}
	function __get__shadow()
	{
		return this._bShadow;
	}
	function __set__backID(var2)
	{
		if(var2 < 1 || var2 > dofus.Constants.EMBLEM_BACKS_COUNT)
		{
			var2 = 1;
		}
		this._sBackFile = dofus.Constants.EMBLEMS_BACK_PATH + var2 + ".swf";
		if(this.initialized)
		{
			this.layoutBack();
		}
		return this.__get__backID();
	}
	function __set__backColor(var2)
	{
		this._nBackColor = var2;
		if(this.initialized)
		{
			this.layoutBack();
		}
		return this.__get__backColor();
	}
	function __set__upID(var2)
	{
		if(var2 < 1 || var2 > dofus.Constants.EMBLEM_UPS_COUNT)
		{
			var2 = 1;
		}
		this._sUpFile = dofus.Constants.EMBLEMS_UP_PATH + var2 + ".swf";
		if(this.initialized)
		{
			this.layoutUp();
		}
		return this.__get__upID();
	}
	function __set__upColor(var2)
	{
		this._nUpColor = var2;
		if(this.initialized)
		{
			this.layoutUp();
		}
		return this.__get__upColor();
	}
	function __set__data(var2)
	{
		this._sBackFile = dofus.Constants.EMBLEMS_BACK_PATH + var2.backID + ".swf";
		this._nBackColor = var2.backColor;
		this._sUpFile = dofus.Constants.EMBLEMS_UP_PATH + var2.upID + ".swf";
		this._nUpColor = var2.upColor;
		if(this.initialized)
		{
			this.layoutBack();
			this.layoutUp();
		}
		return this.__get__data();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.Emblem.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.layoutContent});
	}
	function initScale()
	{
	}
	function addListeners()
	{
		this._ldrEmblemBack.addEventListener("initialization",this);
		this._ldrEmblemUp.addEventListener("initialization",this);
	}
	function layoutContent()
	{
		if(this._sBackFile != undefined)
		{
			if(this._bShadow)
			{
				this._ldrEmblemShadow.contentPath = this._sBackFile;
				var var2 = new Color(this._ldrEmblemShadow);
				var2.setRGB(16777215);
			}
			this._ldrEmblemShadow._visible = this._bShadow;
			this.layoutBack();
			this.layoutUp();
		}
	}
	function layoutBack()
	{
		if(this._ldrEmblemBack.contentPath == this._sBackFile)
		{
			this.applyBackColor();
		}
		else
		{
			this._ldrEmblemBack.contentPath = this._sBackFile;
		}
	}
	function layoutUp()
	{
		if(this._ldrEmblemUp.contentPath == this._sUpFile)
		{
			this.applyUpColor();
		}
		else
		{
			this._ldrEmblemUp.contentPath = this._sUpFile;
		}
	}
	function applyBackColor()
	{
		this.setMovieClipColor(this._ldrEmblemBack.content.back,this._nBackColor);
	}
	function applyUpColor()
	{
		this.setMovieClipColor(this._ldrEmblemUp.content,this._nUpColor);
	}
	function initialization(var2)
	{
		var var3 = var2.target;
		switch(var3._name)
		{
			case "_ldrEmblemBack":
				this.applyBackColor();
				break;
			case "_ldrEmblemUp":
				this.applyUpColor();
		}
	}
}
