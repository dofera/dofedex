class dofus.graphics.gapi.ui.mountstorage.MountStorageMountItem extends ank.gapi.core.UIBasicComponent
{
	function MountStorageMountItem()
	{
		super();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._lbl.text = loc4.name;
			this._oItem = (dofus.datacenter.Mount)loc4;
			if(this._oItem.newBorn)
			{
				this._ldrNewMount.contentPath = "OeufCasse";
			}
			else
			{
				this._ldrNewMount.contentPath = "";
			}
			this._ldrIcon.contentPath = dofus.Constants.GUILDS_MINI_PATH + loc4.gfxID + ".swf";
			this._mcSexMan._visible = !loc4.sex;
			this._mcSexWoman._visible = !this._mcSexMan._visible;
		}
		else if(this._lbl.text != undefined)
		{
			this._lbl.text = "";
			this._ldrIcon.contentPath = "";
			this._ldrNewMount.contentPath = "";
			this._mcSexMan._visible = false;
			this._mcSexWoman._visible = false;
		}
	}
	function init()
	{
		super.init(false);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.arrange();
	}
	function addListeners()
	{
		this._ldrIcon.addEventListener("complete",this);
	}
	function size()
	{
		super.size();
		this.addToQueue({object:this,method:this.arrange});
	}
	function arrange()
	{
		this._lbl.setSize(this.__width,this.__height);
	}
	function applyRideColor(loc2, loc3)
	{
		var loc4 = this._oItem["color" + loc3];
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
		var ref = this;
		this._ldrIcon.content.applyRideColor = function(loc2, loc3)
		{
			ref.applyRideColor(loc2,loc3);
		};
	}
}
