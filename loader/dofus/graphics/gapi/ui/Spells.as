class dofus.graphics.gapi.ui.Spells extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Spells";
	static var TAB_LIST = ["Guild","Water","Fire","Earth","Air"];
	static var TAB_TITLE_LIST = ["SPELL_TAB_GUILD_TITLE","SPELL_TAB_WATER_TITLE","SPELL_TAB_FIRE_TITLE","SPELL_TAB_EARTH_TITLE","SPELL_TAB_AIR_TITLE"];
	function Spells()
	{
		super();
	}
	function __get__spellFullInfosViewer()
	{
		return this._sfivSpellFullInfosViewer;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Spells.CLASS_NAME);
		this.gapi.getUIComponent("Banner").shortcuts.setCurrentTab("Spells");
	}
	function destroy()
	{
		this.gapi.hideTooltip();
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this._nSelectedSpellType = 0;
		this._mcSpellFullInfosPlacer._visible = false;
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
		this.hideSpellBoostViewer(true);
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._dgSpells.addEventListener("itemRollOver",this);
		this._dgSpells.addEventListener("itemRollOut",this);
		this._dgSpells.addEventListener("itemDrag",this);
		this._dgSpells.addEventListener("itemSelected",this);
		this._cbType.addEventListener("itemSelected",this);
		this.api.datacenter.Player.addEventListener("bonusSpellsChanged",this);
		this.api.datacenter.Player.Spells.addEventListener("modelChanged",this);
	}
	function initData()
	{
		this.updateBonus();
	}
	function initTexts()
	{
		this._winBackground.title = this.api.lang.getText("YOUR_SPELLS");
		this._dgSpells.columnsNames = [this.api.lang.getText("NAME_BIG"),this.api.lang.getText("LEVEL")];
		this._lblBonusTitle.text = this.api.lang.getText("SPELL_BOOST_POINT");
		this._lblSpellType.text = this.api.lang.getText("SPELL_TYPE");
		var var2 = new ank.utils.();
		var2.push({label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),type:-2});
		var2.push({label:this.api.lang.getText("SPELL_TAB_GUILD"),type:0});
		var2.push({label:this.api.lang.getText("SPELL_TAB_WATER"),type:1});
		var2.push({label:this.api.lang.getText("SPELL_TAB_FIRE"),type:2});
		var2.push({label:this.api.lang.getText("SPELL_TAB_EARTH"),type:3});
		var2.push({label:this.api.lang.getText("SPELL_TAB_AIR"),type:4});
		this._cbType.dataProvider = var2;
		this._cbType.selectedIndex = 1;
	}
	function updateSpells()
	{
		var var2 = this.api.datacenter.Player.Spells;
		var var3 = new ank.utils.();
		for(var k in var2)
		{
			var var4 = var2[k];
			if(var4.classID != -1 && (var4.classID == this._nSelectedSpellType || this._nSelectedSpellType == -2))
			{
				var3.push(var4);
			}
		}
		if(this.api.kernel.OptionsManager.getOption("SeeAllSpell") && this.api.datacenter.Basics.canUseSeeAllSpell)
		{
			var var5 = this.api.lang.getClassText(this.api.datacenter.Player.Guild).s;
			var var6 = 0;
			while(var6 < var5.length)
			{
				var var7 = var5[var6];
				var var8 = false;
				var var9 = 0;
				while(var9 < var3.length && !var8)
				{
					var8 = var3[var9].ID == var7;
					var9 = var9 + 1;
				}
				var var10 = new dofus.datacenter.(var7,1);
				if(!var8 && (var10.classID == this._nSelectedSpellType || this._nSelectedSpellType == -2))
				{
					var3.push(var10);
				}
				var6 = var6 + 1;
			}
		}
		var3.sortOn("_minPlayerLevel",Array.NUMERIC);
		this._dgSpells.dataProvider = var3;
	}
	function updateBonus(var2)
	{
		this._lblBonus.text = var2 != undefined?String(var2):String(this.api.datacenter.Player.BonusPointsSpell);
		this.updateSpells();
	}
	function hideSpellBoostViewer(var2, var3)
	{
		this._sbvSpellBoostViewer._visible = !var2;
		if(var3 != undefined)
		{
			this._sbvSpellBoostViewer.spell = var3;
		}
	}
	function showDetails(var2)
	{
		this._sfivSpellFullInfosViewer.removeMovieClip();
		if(var2)
		{
			this.attachMovie("SpellFullInfosViewer","_sfivSpellFullInfosViewer",this.getNextHighestDepth(),{_x:this._mcSpellFullInfosPlacer._x,_y:this._mcSpellFullInfosPlacer._y});
			this._sfivSpellFullInfosViewer.addEventListener("close",this);
		}
	}
	function boostSpell(var2)
	{
		this.api.sounds.events.onSpellsBoostButtonClick();
		if(this.canBoost(var2) != undefined)
		{
			var var3 = new dofus.datacenter.(var2.ID,var2.level + 1);
			if(this.api.datacenter.Player.Level < var3.minPlayerLevel)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("LEVEL_NEED_TO_BOOST",[var3.minPlayerLevel]),"ERROR_BOX");
				return false;
			}
			this.hideSpellBoostViewer(true);
			this.api.network.Spells.boost(var2.ID);
			this._sfivSpellFullInfosViewer.spell = var3;
			return true;
		}
		return false;
	}
	function getCostForBoost(var2)
	{
		return var2.level >= var2.maxLevel?-1:dofus.Constants.SPELL_BOOST_BONUS[var2.level];
	}
	function canBoost(var2)
	{
		if(var2 != undefined)
		{
			if(this.getCostForBoost(var2) > this.api.datacenter.Player.BonusPointsSpell)
			{
				return false;
			}
			if(var2.level < var2.maxLevel)
			{
				return true;
			}
		}
		return false;
	}
	function click(var2)
	{
		if((var var0 = var2.target._name) === "_btnClose")
		{
			this.callClose();
		}
	}
	function itemDrag(var2)
	{
		if(var2.row.item == undefined)
		{
			return undefined;
		}
		if(this.api.datacenter.Player.Level < var2.row.item._minPlayerLevel)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		this.gapi.setCursor(var2.row.item,undefined,true);
	}
	function itemRollOver(var2)
	{
	}
	function itemRollOut(var2)
	{
	}
	function itemSelected(var2)
	{
		switch(var2.target)
		{
			case this._dgSpells:
				if(var2.row.item != undefined)
				{
					if(this._sfivSpellFullInfosViewer.spell.ID != var2.row.item.ID)
					{
						this.showDetails(true);
						this._sfivSpellFullInfosViewer.spell = var2.row.item;
					}
					else
					{
						this.showDetails(false);
					}
				}
				break;
			case this._cbType:
				this._nSelectedSpellType = var2.target.selectedItem.type;
				this.updateSpells();
		}
	}
	function bonusSpellsChanged(var2)
	{
		this.updateBonus(var2.value);
	}
	function close(var2)
	{
		this.showDetails(false);
	}
	function modelChanged(var2)
	{
		switch(var2.eventName)
		{
			case "updateOne":
			case "updateAll":
		}
		this.updateSpells();
		this.hideSpellBoostViewer(true);
	}
}
