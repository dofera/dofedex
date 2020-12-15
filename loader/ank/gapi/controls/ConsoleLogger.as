class ank.gapi.controls.ConsoleLogger extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "ConsoleLogger";
	function ConsoleLogger()
	{
		super();
	}
	function __get__shadowy()
	{
		return this._bShadowy;
	}
	function __set__shadowy(var2)
	{
		this._bShadowy = var2;
		return this.__get__shadowy();
	}
	function log(var2, var3, var4)
	{
		var var5 = new Object();
		var5.text = var2;
		var5.hColor = var3 != undefined?var3:"#FFFFFF";
		var5.lColor = var4 != undefined?var4:"#999999";
		this._aLogs.push(var5);
		this.refreshLogs();
	}
	function clear()
	{
		this._aLogs = new Array();
		this.refreshLogs();
	}
	function init()
	{
		super.init(false,ank.gapi.controls.ConsoleLogger.CLASS_NAME);
	}
	function createChildren()
	{
		this.createTextField("_tText",10,0,0,this.__width,this.__height);
		this._tText.html = true;
		this._tText.text = "";
		this._tText.selectable = false;
		this._tText.multiline = true;
		this._tText.onSetFocus = function()
		{
			this._parent.onSetFocus();
		};
		this._tText.onKillFocus = function()
		{
			this._parent.onKillFocus();
		};
		if(this._bShadowy)
		{
			var var2 = new Array();
			var2.push(new flash.filters.DropShadowFilter(1,60,0,1,3,3,4,3,false,false,false));
			this._tText.filters = var2;
			this._tText.antiAliasType = "advanced";
		}
		this._aLogs = new Array();
	}
	function size()
	{
		super.size();
		this._tText._width = this.__width;
		this._tText._height = this.__height;
	}
	function draw()
	{
		var var2 = this.getStyle();
		this._tText.embedFonts = this.getStyle().embedfonts;
	}
	function refreshLogs()
	{
		var var2 = "";
		var var3 = this._aLogs.length - 1;
		var var5 = this.getStyle();
		var var6 = 0;
		while(var6 < var3)
		{
			var var4 = this._aLogs[var6];
			var2 = var2 + ("<p><font size=\'" + var5.size + "\' face=\'" + var5.font + "\' color=\'" + var4.lColor + "\'>" + var4.text + "</font></p>");
			var6 = var6 + 1;
		}
		var4 = this._aLogs[var3];
		if(var4 != undefined)
		{
			var2 = var2 + ("<p><font size=\'" + var5.size + "\' face=\'" + var5.font + "\' color=\'" + var4.hColor + "\'>" + var4.text + "</font></p>");
		}
		this._tText.htmlText = var2;
		this._tText.scroll = this._tText.maxscroll;
	}
	function onHref(var2)
	{
		this.dispatchEvent({type:"href",params:var2});
	}
	function onSetFocus()
	{
		getURL("FSCommand:" add "trapallkeys","false");
	}
	function onKillFocus()
	{
		getURL("FSCommand:" add "trapallkeys","true");
	}
}
