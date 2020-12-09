class dofus.graphics.gapi.controls.ClassInfosViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ClassInfosViewer";
	function ClassInfosViewer()
	{
		super();
	}
	function __set__classID(§\x07\x0f§)
	{
		this._nClassID = var2;
		this.addToQueue({object:this,method:this.layoutContent});
		return this.__get__classID();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ClassInfosViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
	}
	function initTexts()
	{
		this._lblClassSpells.text = this.api.lang.getText("CLASS_SPELLS");
	}
	function addListeners()
	{
		var var2 = 0;
		while(var2 < 20)
		{
			this["_ctr" + var2].addEventListener("over",this);
			this["_ctr" + var2].addEventListener("out",this);
			this["_ctr" + var2].addEventListener("click",this);
			var2 = var2 + 1;
		}
	}
	function layoutContent()
	{
		var var2 = dofus.Constants.SPELLS_ICONS_PATH;
		var var3 = this.api.lang.getClassText(this._nClassID).s;
		var var4 = 0;
		while(var4 < 20)
		{
			var var5 = this["_ctr" + var4];
			var5.contentPath = var2 + var3[var4] + ".swf";
			var5.params = {spellID:var3[var4]};
			var4 = var4 + 1;
		}
		this._txtDescription.text = this.api.lang.getClassText(this._nClassID).d;
		this.showSpellInfos(var3[0]);
	}
	function showSpellInfos(§\x1e\x1d\r§)
	{
		var var3 = this.api.kernel.CharactersManager.getSpellObjectFromData(var2 + "~1~");
		if(var3.name == undefined)
		{
			this._lblSpellName.text = "";
			this._lblSpellRange.text = "";
			this._lblSpellAP.text = "";
			this._txtSpellDescription.text = "";
			this._ldrSpellIcon.contentPath = "";
		}
		else if(this._lblSpellName.text != undefined)
		{
			this._lblSpellName.text = var3.name;
			this._lblSpellRange.text = this.api.lang.getText("RANGEFULL") + " : " + var3.rangeStr;
			this._lblSpellAP.text = this.api.lang.getText("ACTIONPOINTS") + " : " + var3.apCost;
			this._txtSpellDescription.text = var3.description + "\n" + var3.descriptionNormalHit;
			this._ldrSpellIcon.contentPath = var3.iconFile;
		}
	}
	function click(§\x1e\x19\x18§)
	{
		this.showSpellInfos(var2.target.params.spellID);
	}
}
