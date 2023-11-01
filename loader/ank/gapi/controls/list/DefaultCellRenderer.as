class ank.gapi.controls.list.DefaultCellRenderer extends ank.gapi.core.UIBasicComponent
{
	function DefaultCellRenderer()
	{
		super();
	}
	function setState(var2)
	{
	}
	function setValue(var2, var3, var4)
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
