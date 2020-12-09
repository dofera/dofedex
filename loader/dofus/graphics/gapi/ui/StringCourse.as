class dofus.graphics.gapi.ui.StringCourse extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "StringCourse";
	function StringCourse()
	{
		super();
	}
	function __set__name(§\x1e\x10\x06§)
	{
		this._sName = var2;
		return this.__get__name();
	}
	function __set__level(§\x1e\x10\x1c§)
	{
		this._sLevel = var2;
		return this.__get__level();
	}
	function __set__gfx(§\x1e\x12\r§)
	{
		this._sGfx = var2;
		return this.__get__gfx();
	}
	function __set__colors(§\f§)
	{
		this._colors = var2;
		return this.__get__colors();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.StringCourse.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.loadContent});
	}
	function loadContent()
	{
		this._ldrStringCourse.addEventListener("error",this);
		this._ldrStringCourse.addEventListener("complete",this);
		this._ldrStringCourse.contentPath = this._sGfx;
	}
	function unloadContent()
	{
		this._ldrStringCourse.contentPath = "";
		this._lblName.text = "";
		this._lblLevel.text = "";
	}
	function applyColor(§\x0b\r§, §\x1e\t\x10§)
	{
		var var4 = this._colors[var3];
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
	function complete(§\x1e\x19\x18§)
	{
		this._lblName.text = this._sName;
		this._lblLevel.text = this._sLevel;
		var ref = this;
		this._ldrStringCourse.content.stringCourseColor = function(§\x0b\r§, §\x1e\t\x14§)
		{
			ref.applyColor(var2,var3);
		};
		this._mcAnim.play();
	}
	function error(§\x1e\x19\x18§)
	{
		this.unloadThis();
	}
}
