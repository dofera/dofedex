class dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItemNoPrice extends ank.gapi.core.UIBasicComponent
{
	function ListInventoryViewerItemNoPrice()
	{
		super();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._lblName.text = !loc2?"":(loc4.Quantity <= 1?"":"x" + loc4.Quantity + " ") + loc4.name;
			this._ldrIcon.contentPath = !loc2?"":loc4.iconFile;
			this._ldrIcon.contentParams = loc4.params;
			this._lblName.styleName = loc4.style != ""?loc4.style + "LeftSmallLabel":"BrownLeftSmallLabel";
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
