class ank.gapi.controls.list.DefaultCellRenderer extends ank.gapi.core.UIBasicComponent
{
	function DefaultCellRenderer()
	{
		super();
	}
	function setState(§\x1e\r\x16§)
	{
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		if(var2)
		{
			this._lblText.text = var3;
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
		var var2 = this.getStyle();
		this._lblText.styleName = var2.defaultstyle;
	}
}
