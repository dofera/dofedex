class dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItem extends ank.gapi.core.UIBasicComponent
{
	function ListInventoryViewerItem()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._lblPrice.text = !loc2?"":new ank.utils.(loc4.price).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
			var loc5 = this._lblPrice.textWidth;
			this._lblName.text = !loc2?"":(loc4.Quantity <= 1?"":"x" + loc4.Quantity + " ") + loc4.name;
			this._lblName.setSize(this.__width - loc5 - 30,this.__height);
			this._lblName.styleName = loc4.style != ""?loc4.style + "LeftSmallLabel":"BrownLeftSmallLabel";
			this._ldrIcon.contentPath = !loc2?"":loc4.iconFile;
			this._ldrIcon.contentParams = loc4.params;
		}
		else if(this._lblPrice.text != undefined)
		{
			this._lblPrice.text = "";
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
		this._lblName.setSize(this.__width - 50,this.__height);
		this._lblPrice.setSize(this.__width - 20,this.__height);
	}
}
