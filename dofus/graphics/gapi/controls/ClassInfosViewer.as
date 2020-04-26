class dofus.graphics.gapi.controls.ClassInfosViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ClassInfosViewer";
	function ClassInfosViewer()
	{
		super();
	}
	function __set__classID(loc2)
	{
		this._nClassID = loc2;
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
		var loc2 = 0;
		while(loc2 < 20)
		{
			this["_ctr" + loc2].addEventListener("over",this);
			this["_ctr" + loc2].addEventListener("out",this);
			this["_ctr" + loc2].addEventListener("click",this);
			loc2 = loc2 + 1;
		}
	}
	function layoutContent()
	{
		var loc2 = dofus.Constants.SPELLS_ICONS_PATH;
		var loc3 = this.api.lang.getClassText(this._nClassID).s;
		var loc4 = 0;
		while(loc4 < 20)
		{
			var loc5 = this["_ctr" + loc4];
			loc5.contentPath = loc2 + loc3[loc4] + ".swf";
			loc5.params = {spellID:loc3[loc4]};
			loc4 = loc4 + 1;
		}
		this._txtDescription.text = this.api.lang.getClassText(this._nClassID).d;
		this.showSpellInfos(loc3[0]);
	}
	function showSpellInfos(loc2)
	{
		var loc3 = this.api.kernel.CharactersManager.getSpellObjectFromData(loc2 + "~1~");
		if(loc3.name == undefined)
		{
			this._lblSpellName.text = "";
			this._lblSpellRange.text = "";
			this._lblSpellAP.text = "";
			this._txtSpellDescription.text = "";
			this._ldrSpellIcon.contentPath = "";
		}
		else if(this._lblSpellName.text != undefined)
		{
			this._lblSpellName.text = loc3.name;
			this._lblSpellRange.text = this.api.lang.getText("RANGEFULL") + " : " + loc3.rangeStr;
			this._lblSpellAP.text = this.api.lang.getText("ACTIONPOINTS") + " : " + loc3.apCost;
			this._txtSpellDescription.text = loc3.description + "\n" + loc3.descriptionNormalHit;
			this._ldrSpellIcon.contentPath = loc3.iconFile;
		}
	}
	function click(loc2)
	{
		this.showSpellInfos(loc2.target.params.spellID);
	}
}
