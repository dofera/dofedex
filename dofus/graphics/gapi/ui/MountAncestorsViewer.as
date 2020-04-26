class dofus.graphics.gapi.ui.MountAncestorsViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MountAncestorsViewer";
	function MountAncestorsViewer()
	{
		super();
	}
	function __set__mount(loc2)
	{
		this._oMount = loc2;
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
		var loc2 = 0;
		while(loc2 < 15)
		{
			this["_ldr" + loc2].addEventListener("initialization",this);
			loc2 = loc2 + 1;
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
			var loc2 = new ank.utils.();
			for(var a in this._oMount.ancestors)
			{
				loc2[a] = this._oMount.ancestors[a];
			}
			loc2.push(this._oMount.modelID);
			var loc3 = 0;
			while(loc3 < loc2.length)
			{
				var loc4 = Number(loc2[loc3]);
				if(loc4 != 0)
				{
					var loc5 = new dofus.datacenter.Mount(loc4);
					var loc6 = (ank.gapi.controls.Loader)this["_ldr" + loc3];
					loc6.forceNextLoad();
					loc6.contentPath = loc5.gfxFile;
					var loc7 = new ank.battlefield.datacenter.("-1",undefined,"",0,0);
					loc7.mount = loc5;
					this.api.colors.addSprite(loc6,loc7);
					var loc8 = this.attachMovie("Rectangle","mcButton" + loc3,loc3);
					loc8._width = 75;
					loc8._height = 75;
					loc8._alpha = 0;
					loc8._x = loc6._x - 35;
					loc8._y = loc6._y - 60;
					loc8.mount = loc5;
					loc8.onRollOver = function()
					{
						this._parent.gapi.showTooltip(this.mount.modelName,this,-30,{bXLimit:true,bYLimit:false});
					};
					loc8.onRollOut = function()
					{
						this._parent.out();
					};
				}
				this["_mcUnknown" + loc3]._visible = loc4 == 0;
				loc3 = loc3 + 1;
			}
		}
	}
	function initialization(loc2)
	{
		var loc3 = loc2.target.content;
		loc3.attachMovie("staticR_front","anim_front",11);
		loc3.attachMovie("staticR_back","anim_back",10);
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target) === this._btnClose)
		{
			this.callClose();
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
