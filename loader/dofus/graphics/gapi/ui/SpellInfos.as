class dofus.graphics.gapi.ui.SpellInfos extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "SpellInfos";
	function SpellInfos()
	{
		super();
	}
	function __set__spell(var2)
	{
		if(var2 == this._oSpell)
		{
			return undefined;
		}
		this.addToQueue({object:this,method:function(var2)
		{
			this._oSpell = var2;
			if(this.initialized)
			{
				this.initData();
			}
		},params:[var2]});
		return this.__get__spell();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.SpellInfos.CLASS_NAME);
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function addListeners()
	{
		this._bghBackground.addEventListener("click",this);
		this._sfivSpellFullInfosViewer.addEventListener("close",this);
	}
	function initData()
	{
		if(this._oSpell != undefined)
		{
			this._sfivSpellFullInfosViewer.spell = this._oSpell;
		}
	}
	function click(var2)
	{
		this.unloadThis();
	}
	function close(var2)
	{
		this.unloadThis();
	}
}
