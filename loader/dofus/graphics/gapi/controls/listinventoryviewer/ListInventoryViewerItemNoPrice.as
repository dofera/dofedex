class dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItemNoPrice extends ank.gapi.core.UIBasicComponent
{
	function ListInventoryViewerItemNoPrice()
	{
		super();
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			this._lblName.text = !var2?"":(var4.Quantity <= 1?"":"x" + var4.Quantity + " ") + var4.name;
			this._ldrIcon.contentPath = !var2?"":var4.iconFile;
			this._ldrIcon.contentParams = var4.params;
			this._lblName.styleName = var4.style != ""?var4.style + "LeftSmallLabel":"BrownLeftSmallLabel";
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._ldrIcon.contentPath = "";
		}
	}
	function init()
	{
		super.init(false);
	}
	function createChildren()
	{
		this.arrange();
	}
	function size()
	{
		super.size();
		this.addToQueue({object:this,method:this.arrange});
	}
	function arrange()
	{
		this._lblName.setSize(this.__width - 20,this.__height);
	}
}
