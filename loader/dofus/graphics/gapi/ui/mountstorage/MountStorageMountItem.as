class dofus.graphics.gapi.ui.mountstorage.MountStorageMountItem extends ank.gapi.core.UIBasicComponent
{
	function MountStorageMountItem()
	{
		super();
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			this._lbl.text = var4.name;
			this._oItem = (dofus.datacenter.Mount)var4;
			if(this._oItem.newBorn)
			{
				this._ldrNewMount.contentPath = "OeufCasse";
			}
			else
			{
				this._ldrNewMount.contentPath = "";
			}
			this._ldrIcon.contentPath = dofus.Constants.GUILDS_MINI_PATH + var4.gfxID + ".swf";
			this._mcSexMan._visible = !var4.sex;
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
	function applyRideColor(var2, var3)
	{
		var var4 = this._oItem["color" + var3];
		if(var4 == -1 || var4 == undefined)
		{
			return undefined;
		}
		var var5 = (var4 & 16711680) >> 16;
		var var6 = (var4 & 65280) >> 8;
		var var7 = var4 & 255;
		var var8 = new Color(var2);
		var var9 = new Object();
		var9 = {ra:0,ga:0,ba:0,rb:var5,gb:var6,bb:var7};
		var8.setTransform(var9);
	}
	function complete(var2)
	{
		var ref = this;
		this._ldrIcon.content.applyRideColor = function(var2, var3)
		{
			ref.applyRideColor(var2,var3);
		};
	}
}
