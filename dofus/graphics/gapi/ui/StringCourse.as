class dofus.graphics.gapi.ui.StringCourse extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "StringCourse";
	function StringCourse()
	{
		super();
	}
	function __set__name(loc2)
	{
		this._sName = loc2;
		return this.__get__name();
	}
	function __set__level(loc2)
	{
		this._sLevel = loc2;
		return this.__get__level();
	}
	function __set__gfx(loc2)
	{
		this._sGfx = loc2;
		return this.__get__gfx();
	}
	function __set__colors(loc2)
	{
		this._colors = loc2;
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
	function applyColor(loc2, loc3)
	{
		var loc4 = this._colors[loc3];
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
	function complete(loc2)
	{
		this._lblName.text = this._sName;
		this._lblLevel.text = this._sLevel;
		var ref = this;
		this._ldrStringCourse.content.stringCourseColor = function(loc2, loc3)
		{
			ref.applyColor(loc2,loc3);
		};
		this._mcAnim.play();
	}
	function error(loc2)
	{
		this.unloadThis();
	}
}
