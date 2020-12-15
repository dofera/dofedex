class dofus.graphics.gapi.ui.StringCourse extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "StringCourse";
	function StringCourse()
	{
		super();
	}
	function __set__name(var2)
	{
		this._sName = var2;
		return this.__get__name();
	}
	function __set__level(var2)
	{
		this._sLevel = var2;
		return this.__get__level();
	}
	function __set__gfx(var2)
	{
		this._sGfx = var2;
		return this.__get__gfx();
	}
	function __set__colors(var2)
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
	function applyColor(var2, var3)
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
	function complete(var2)
	{
		this._lblName.text = this._sName;
		this._lblLevel.text = this._sLevel;
		var ref = this;
		this._ldrStringCourse.content.stringCourseColor = function(var2, var3)
		{
			ref.applyColor(var2,var3);
		};
		this._mcAnim.play();
	}
	function error(var2)
	{
		this.unloadThis();
	}
}
