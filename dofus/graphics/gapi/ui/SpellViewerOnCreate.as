class dofus.graphics.gapi.ui.SpellViewerOnCreate extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "SpellViewerOnCreate";
	static var SPELLS_DISPLAYED = 20;
	function SpellViewerOnCreate()
	{
		super();
	}
	function __get__breed()
	{
		return this._nBreed;
	}
	function __set__breed(loc2)
	{
		this._nBreed = loc2;
		return this.__get__breed();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.SpellViewerOnCreate.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initText});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.addListeners});
	}
	function initText()
	{
		this._lblBreedSpells.text = this.api.lang.getText("CLASS_SPELLS");
		this._lblBreedName.text = this.api.lang.getClassText(this._nBreed).sn;
		this._lbViewSpell.text = this.api.lang.getText("SEE_ALL_SPELLS");
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnClose.addEventListener("over",this);
		this._btnClose.addEventListener("out",this);
		this._bhClose.addEventListener("click",this);
		this._mcWindowBg.onRelease = function()
		{
		};
		this._mcWindowBg.useHandCursor = false;
		this._mcViewAllSpell.onRelease = function()
		{
			var aTarget = new Object();
			var loc2 = 0;
			while(loc2 < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
			{
				var loc3 = this._parent["_ctr" + loc2];
				var loc4 = this._parent._mcPlacerSpell._x;
				var loc5 = this._parent._mcPlacerSpell._y;
				var loc6 = loc4 + (loc2 - (loc2 <= 9?0:10)) * (loc3.width + 5);
				var loc7 = loc5 + (5 + loc3.height) * (loc2 <= 9?0:1);
				aTarget["_ctr" + loc2] = {x:loc6,y:loc7};
				loc3.onEnterFrame = function()
				{
					this._x = this._x + (aTarget[this._name].x - this._x) / 2;
					this._y = this._y + (aTarget[this._name].y - this._y) / 2;
					this._alpha = this._alpha + (100 - this._alpha) / 2;
					if(Math.abs(this._x - aTarget[this._name].x) < 0.5 && (Math.abs(this._y - aTarget[this._name].y) < 0.5 && Math.abs(this._alpha - 100) < 0.5))
					{
						delete this.onEnterFrame;
					}
				};
				loc2 = loc2 + 1;
			}
			var ref = this._parent;
			var loc8 = 0;
			this.onEnterFrame = function()
			{
				var loc2 = (ref._mcPlacerAllSpell._y - ref._mcSpellDesc._y) / 2;
				ref._mcSpellDesc._y = ref._mcSpellDesc._y + loc2;
				ref._mcWindowBg._y = ref._mcWindowBg._y + loc2;
				if(Math.abs(ref._mcSpellDesc._y - ref._mcPlacerAllSpell._y) < 0.5)
				{
					ref._mcWindowBg._y = ref._mcWindowBg._y + (ref._mcPlacerAllSpell._y - ref._mcSpellDesc._y);
					ref._mcSpellDesc._y = ref._mcPlacerAllSpell._y;
					delete this.onEnterFrame;
				}
			};
			this._parent._mcBgViewAllSpell1._visible = false;
			this._parent._mcBgViewAllSpell2._visible = false;
			this._parent._lbViewSpell._visible = false;
			delete this.onRelease;
		};
		var loc2 = 0;
		while(loc2 < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
		{
			var loc3 = this["_ctr" + loc2];
			loc3.addEventListener("over",this);
			loc3.addEventListener("out",this);
			loc3.addEventListener("click",this);
			loc2 = loc2 + 1;
		}
	}
	function initData()
	{
		var loc2 = dofus.Constants.SPELLS_ICONS_PATH;
		var loc3 = this.api.lang.getClassText(this._nBreed).s;
		var loc4 = 0;
		while(loc4 < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
		{
			var loc5 = this["_ctr" + loc4];
			loc5.contentPath = loc2 + loc3[loc4] + ".swf";
			loc5.params = {spellID:loc3[loc4]};
			loc5._alpha = loc4 >= 3?0:100;
			loc4 = loc4 + 1;
		}
		this.showSpellInfo(loc3[0],1);
	}
	function showSpellInfo(loc2, loc3)
	{
		this._nSpellID = loc2;
		var loc4 = this.api.kernel.CharactersManager.getSpellObjectFromData(loc2 + "~" + loc3 + "~");
		if(!loc4.isValid)
		{
			if(loc3 != 1)
			{
				this.showSpellInfo(loc2,1);
				return undefined;
			}
			loc4 = undefined;
		}
		var loc5 = 1;
		while(loc5 < 7)
		{
			var loc6 = this["_btnLevel" + loc5];
			loc6.selected = loc5 == loc3;
			loc5 = loc5 + 1;
		}
		if(loc4.name == undefined)
		{
			this._mcSpellDesc._lblSpellName.text = "";
			this._mcSpellDesc._lblSpellRange.text = "";
			this._mcSpellDesc._lblSpellAP.text = "";
			this._mcSpellDesc._txtSpellDescription.text = "";
			this._mcSpellDesc._ldrSpellBig.contentPath = "";
		}
		else if(this._mcSpellDesc._lblSpellName.text != undefined)
		{
			this._mcSpellDesc._lblSpellName.text = loc4.name;
			this._mcSpellDesc._lblSpellRange.text = this.api.lang.getText("RANGEFULL") + " : " + loc4.rangeStr;
			this._mcSpellDesc._lblSpellAP.text = this.api.lang.getText("ACTIONPOINTS") + " : " + loc4.apCost;
			this._mcSpellDesc._txtSpellDescription.text = loc4.description + "\n" + loc4.descriptionNormalHit;
			this._mcSpellDesc._ldrSpellBig.contentPath = loc4.iconFile;
		}
	}
	function click(loc2)
	{
		switch(loc2.target)
		{
			case this._bhClose:
			case this._btnClose:
				this.unloadThis();
				break;
			default:
				this.showSpellInfo(loc2.target.params.spellID,1);
		}
	}
	function over(loc2)
	{
		if((var loc0 = loc2.target) !== this._btnClose)
		{
			var loc3 = (dofus.datacenter.Spell)this.api.kernel.CharactersManager.getSpellObjectFromData(loc2.target.params.spellID + "~1~");
			this.gapi.showTooltip(loc3.name + ", " + this.api.lang.getText("REQUIRED_SPELL_LEVEL").toLowerCase() + ": " + loc3.minPlayerLevel,loc2.target,-20);
		}
		else
		{
			this.gapi.showTooltip(this.api.lang.getText("CLOSE"),loc2.target,-20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
