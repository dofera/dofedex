class ank.gapi.controls.list.DefaultCellRenderer extends ank.gapi.core.UIBasicComponent
{
	function DefaultCellRenderer()
	{
		super();
	}
	function setState(loc2)
	{
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._lblText.text = loc3;
		}
		else if(this._lblText.text != undefined)
		{
			this._lblText.text = "";
		}
	}
	function init()
	{
		super.init(false);
	}
	function createChildren()
	{
		this.attachMovie("Label","_lblText",10,{styleName:this.getStyle().defaultstyle});
	}
	function size()
	{
		super.size();
		this._lblText.setSize(this.__width,this.__height);
	}
	function draw()
	{
		var loc2 = this.getStyle();
		this._lblText.styleName = loc2.defaultstyle;
	}
}
