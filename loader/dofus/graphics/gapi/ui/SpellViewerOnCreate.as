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
	function __set__breed(§\t\x10§)
	{
		this._nBreed = var2;
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
			var var2 = 0;
			while(var2 < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
			{
				var var3 = this._parent["_ctr" + var2];
				var var4 = this._parent._mcPlacerSpell._x;
				var var5 = this._parent._mcPlacerSpell._y;
				var var6 = var4 + (var2 - (var2 <= 9?0:10)) * (var3.width + 5);
				var var7 = var5 + (5 + var3.height) * (var2 <= 9?0:1);
				aTarget["_ctr" + var2] = {x:var6,y:var7};
				var3.onEnterFrame = function()
				{
					this._x = this._x + (aTarget[this._name].x - this._x) / 2;
					this._y = this._y + (aTarget[this._name].y - this._y) / 2;
					this._alpha = this._alpha + (100 - this._alpha) / 2;
					if(Math.abs(this._x - aTarget[this._name].x) < 0.5 && (Math.abs(this._y - aTarget[this._name].y) < 0.5 && Math.abs(this._alpha - 100) < 0.5))
					{
						delete this.onEnterFrame;
					}
				};
				var2 = var2 + 1;
			}
			var ref = this._parent;
			var var8 = 0;
			this.onEnterFrame = function()
			{
				var var2 = (ref._mcPlacerAllSpell._y - ref._mcSpellDesc._y) / 2;
				ref._mcSpellDesc._y = ref._mcSpellDesc._y + var2;
				ref._mcWindowBg._y = ref._mcWindowBg._y + var2;
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
		var var2 = 0;
		while(var2 < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
		{
			var var3 = this["_ctr" + var2];
			var3.addEventListener("over",this);
			var3.addEventListener("out",this);
			var3.addEventListener("click",this);
			var3.addEventListener("onContentLoaded",this);
			var2 = var2 + 1;
		}
	}
	function initData()
	{
		var var2 = dofus.Constants.SPELLS_ICONS_PATH;
		var var3 = this.api.lang.getClassText(this._nBreed).s;
		var var4 = 0;
		while(var4 < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
		{
			var var5 = this["_ctr" + var4];
			var5.contentPath = var2 + var3[var4] + ".swf";
			var5.params = {spellID:var3[var4]};
			var5._alpha = var4 >= 3?0:100;
			var4 = var4 + 1;
		}
		this._mcSpellDesc._ldrSpellBig.addEventListener("complete",this);
		this.showSpellInfo(var3[0],1);
	}
	function showSpellInfo(§\x1e\x1d\r§, §\x04\x01§)
	{
		this._nSpellID = var2;
		var var4 = this.api.kernel.CharactersManager.getSpellObjectFromData(var2 + "~" + var3 + "~");
		if(!var4.isValid)
		{
			if(var3 != 1)
			{
				this.showSpellInfo(var2,1);
				return undefined;
			}
			var4 = undefined;
		}
		var var5 = 1;
		while(var5 < 7)
		{
			var var6 = this["_btnLevel" + var5];
			var6.selected = var5 == var3;
			var5 = var5 + 1;
		}
		if(var4.name == undefined)
		{
			this._mcSpellDesc._lblSpellName.text = "";
			this._mcSpellDesc._lblSpellRange.text = "";
			this._mcSpellDesc._lblSpellAP.text = "";
			this._mcSpellDesc._txtSpellDescription.text = "";
			this._mcSpellDesc._ldrSpellBig.contentPath = "";
			if(dofus.Constants.DOUBLEFRAMERATE && this._mcSpellDesc._ldrSpellBig.loaded)
			{
				var var7 = this.api.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
				this._mcSpellDesc._ldrSpellBig.content.gotoAndStop(var7);
			}
		}
		else if(this._mcSpellDesc._lblSpellName.text != undefined)
		{
			this._mcSpellDesc._lblSpellName.text = var4.name;
			this._mcSpellDesc._lblSpellRange.text = this.api.lang.getText("RANGEFULL") + " : " + var4.rangeStr;
			this._mcSpellDesc._lblSpellAP.text = this.api.lang.getText("ACTIONPOINTS") + " : " + var4.apCost;
			this._mcSpellDesc._txtSpellDescription.text = var4.description + "\n" + var4.descriptionNormalHit;
			this._mcSpellDesc._ldrSpellBig.contentPath = var4.iconFile;
		}
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target)
		{
			case this._bhClose:
			case this._btnClose:
				this.unloadThis();
				break;
			default:
				this.showSpellInfo(var2.target.params.spellID,1);
		}
	}
	function refreshSpellsPack()
	{
		if(!dofus.Constants.DOUBLEFRAMERATE)
		{
			return undefined;
		}
		var var2 = this.api.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
		var var3 = 0;
		while(var3 < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
		{
			var var4 = this["_ctr" + var3];
			var var5 = var4.content;
			var5.gotoAndStop(var2);
			var3 = var3 + 1;
		}
		var var6 = this._mcSpellDesc._ldrSpellBig;
		var6.content.gotoAndStop(var2);
	}
	function complete(§\x1e\x19\x18§)
	{
		if(!dofus.Constants.DOUBLEFRAMERATE)
		{
			return undefined;
		}
		var var3 = var2.clip;
		var var4 = this.api.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
		var3.gotoAndStop(var4);
	}
	function onContentLoaded(§\x1e\x19\x18§)
	{
		if(!dofus.Constants.DOUBLEFRAMERATE)
		{
			return undefined;
		}
		var var3 = var2.content;
		var var4 = this.api.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
		var3.gotoAndStop(var4);
	}
	function over(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target) !== this._btnClose)
		{
			var var3 = (dofus.datacenter.Spell)this.api.kernel.CharactersManager.getSpellObjectFromData(var2.target.params.spellID + "~1~");
			this.gapi.showTooltip(var3.name + ", " + this.api.lang.getText("REQUIRED_SPELL_LEVEL").toLowerCase() + ": " + var3.minPlayerLevel,var2.target,-20);
		}
		else
		{
			this.gapi.showTooltip(this.api.lang.getText("CLOSE"),var2.target,-20);
		}
	}
	function out(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
	}
}
