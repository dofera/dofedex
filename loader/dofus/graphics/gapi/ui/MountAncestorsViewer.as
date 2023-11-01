class dofus.graphics.gapi.ui.MountAncestorsViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MountAncestorsViewer";
	function MountAncestorsViewer()
	{
		super();
	}
	function __set__mount(var2)
	{
		this._oMount = var2;
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__mount();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.MountAncestorsViewer.CLASS_NAME);
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.updateData});
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		var var2 = 0;
		while(var2 < 15)
		{
			this["_ldr" + var2].addEventListener("initialization",this);
			var2 = var2 + 1;
		}
	}
	function initTexts()
	{
	}
	function updateData()
	{
		if(this._oMount != undefined)
		{
			this._lblMountName.text = this._oMount.name;
			var var2 = new ank.utils.();
			for(var a in this._oMount.ancestors)
			{
				var2[a] = this._oMount.ancestors[a];
			}
			var2.push(this._oMount.modelID);
			var var3 = 0;
			while(var3 < var2.length)
			{
				var var4 = Number(var2[var3]);
				if(var4 != 0)
				{
					var var5 = new dofus.datacenter.Mount(var4);
					var var6 = (ank.gapi.controls.Loader)this["_ldr" + var3];
					var6.forceNextLoad();
					var6.contentPath = var5.gfxFile;
					var var7 = new ank.battlefield.datacenter.("-1",undefined,"",0,0);
					var7.mount = var5;
					this.api.colors.addSprite(var6,var7);
					var var8 = this.attachMovie("Rectangle","mcButton" + var3,var3);
					var8._width = 75;
					var8._height = 75;
					var8._alpha = 0;
					var8._x = var6._x - 35;
					var8._y = var6._y - 60;
					var8.mount = var5;
					var8.onRollOver = function()
					{
						this._parent.gapi.showTooltip(this.mount.modelName,this,-30,{bXLimit:true,bYLimit:false});
					};
					var8.onRollOut = function()
					{
						this._parent.out();
					};
				}
				this["_mcUnknown" + var3]._visible = var4 == 0;
				var3 = var3 + 1;
			}
		}
	}
	function initialization(var2)
	{
		var var3 = var2.target.content;
		var3.attachMovie("staticR_front","anim_front",11);
		var3.attachMovie("staticR_back","anim_back",10);
	}
	function click(var2)
	{
		if((var var0 = var2.target) === this._btnClose)
		{
			this.callClose();
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
}
