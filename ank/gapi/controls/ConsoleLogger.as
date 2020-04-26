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
	function __set__shadowy(loc2)
	{
		this._bShadowy = loc2;
		return this.__get__shadowy();
	}
	function log(loc2, loc3, loc4)
	{
		var loc5 = new Object();
		loc5.text = loc2;
		loc5.hColor = loc3 != undefined?loc3:"#FFFFFF";
		loc5.lColor = loc4 != undefined?loc4:"#999999";
		this._aLogs.push(loc5);
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
			var loc2 = new Array();
			loc2.push(new flash.filters.DropShadowFilter(1,60,0,1,3,3,4,3,false,false,false));
			this._tText.filters = loc2;
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
		var loc2 = this.getStyle();
		this._tText.embedFonts = this.getStyle().embedfonts;
	}
	function refreshLogs()
	{
		var loc2 = "";
		var loc3 = this._aLogs.length - 1;
		var loc5 = this.getStyle();
		var loc6 = 0;
		while(loc6 < loc3)
		{
			var loc4 = this._aLogs[loc6];
			loc2 = loc2 + ("<p><font size=\'" + loc5.size + "\' face=\'" + loc5.font + "\' color=\'" + loc4.lColor + "\'>" + loc4.text + "</font></p>");
			loc6 = loc6 + 1;
		}
		loc4 = this._aLogs[loc3];
		if(loc4 != undefined)
		{
			loc2 = loc2 + ("<p><font size=\'" + loc5.size + "\' face=\'" + loc5.font + "\' color=\'" + loc4.hColor + "\'>" + loc4.text + "</font></p>");
		}
		this._tText.htmlText = loc2;
		this._tText.scroll = this._tText.maxscroll;
	}
	function onHref(loc2)
	{
		this.dispatchEvent({type:"href",params:loc2});
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
