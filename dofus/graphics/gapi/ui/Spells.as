class dofus.graphics.gapi.ui.Spells extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Spells";
	static var TAB_LIST = ["Guild","Water","Fire","Earth","Air"];
	static var TAB_TITLE_LIST = ["SPELL_TAB_GUILD_TITLE","SPELL_TAB_WATER_TITLE","SPELL_TAB_FIRE_TITLE","SPELL_TAB_EARTH_TITLE","SPELL_TAB_AIR_TITLE"];
	function Spells()
	{
		super();
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
		var loc2 = new ank.utils.();
		loc2.push({label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),type:-2});
		loc2.push({label:this.api.lang.getText("SPELL_TAB_GUILD"),type:0});
		loc2.push({label:this.api.lang.getText("SPELL_TAB_WATER"),type:1});
		loc2.push({label:this.api.lang.getText("SPELL_TAB_FIRE"),type:2});
		loc2.push({label:this.api.lang.getText("SPELL_TAB_EARTH"),type:3});
		loc2.push({label:this.api.lang.getText("SPELL_TAB_AIR"),type:4});
		this._cbType.dataProvider = loc2;
		this._cbType.selectedIndex = 1;
	}
	function updateSpells()
	{
		var loc2 = this.api.datacenter.Player.Spells;
		var loc3 = new ank.utils.();
		for(var k in loc2)
		{
			var loc4 = loc2[k];
			if(loc4.classID != -1 && (loc4.classID == this._nSelectedSpellType || this._nSelectedSpellType == -2))
			{
				loc3.push(loc4);
			}
		}
		if(this.api.kernel.OptionsManager.getOption("SeeAllSpell") && this.api.datacenter.Basics.canUseSeeAllSpell)
		{
			var loc5 = this.api.lang.getClassText(this.api.datacenter.Player.Guild).s;
			var loc6 = 0;
			while(loc6 < loc5.length)
			{
				var loc7 = loc5[loc6];
				var loc8 = false;
				var loc9 = 0;
				while(loc9 < loc3.length && !loc8)
				{
					loc8 = loc3[loc9].ID == loc7;
					loc9 = loc9 + 1;
				}
				var loc10 = new dofus.datacenter.(loc7,1);
				if(!loc8 && (loc10.classID == this._nSelectedSpellType || this._nSelectedSpellType == -2))
				{
					loc3.push(loc10);
				}
				loc6 = loc6 + 1;
			}
		}
		loc3.sortOn("_minPlayerLevel",Array.NUMERIC);
		this._dgSpells.dataProvider = loc3;
	}
	function updateBonus(loc2)
	{
		this._lblBonus.text = loc2 != undefined?String(loc2):String(this.api.datacenter.Player.BonusPointsSpell);
		this.updateSpells();
	}
	function hideSpellBoostViewer(loc2, loc3)
	{
		this._sbvSpellBoostViewer._visible = !loc2;
		if(loc3 != undefined)
		{
			this._sbvSpellBoostViewer.spell = loc3;
		}
	}
	function showDetails(loc2)
	{
		this._sfivSpellFullInfosViewer.removeMovieClip();
		if(loc2)
		{
			this.attachMovie("SpellFullInfosViewer","_sfivSpellFullInfosViewer",this.getNextHighestDepth(),{_x:this._mcSpellFullInfosPlacer._x,_y:this._mcSpellFullInfosPlacer._y});
			this._sfivSpellFullInfosViewer.addEventListener("close",this);
		}
	}
	function boostSpell(loc2)
	{
		this.api.sounds.events.onSpellsBoostButtonClick();
		if(this.canBoost(loc2) != undefined)
		{
			var loc3 = new dofus.datacenter.(loc2.ID,loc2.level + 1);
			if(this.api.datacenter.Player.Level < loc3.minPlayerLevel)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("LEVEL_NEED_TO_BOOST",[loc3.minPlayerLevel]),"ERROR_BOX");
				return false;
			}
			this.hideSpellBoostViewer(true);
			this.api.network.Spells.boost(loc2.ID);
			this._sfivSpellFullInfosViewer.spell = loc3;
			return true;
		}
		return false;
	}
	function getCostForBoost(loc2)
	{
		return loc2.level >= loc2.maxLevel?-1:dofus.Constants.SPELL_BOOST_BONUS[loc2.level];
	}
	function canBoost(loc2)
	{
		if(loc2 != undefined)
		{
			if(this.getCostForBoost(loc2) > this.api.datacenter.Player.BonusPointsSpell)
			{
				return false;
			}
			if(loc2.level < loc2.maxLevel)
			{
				return true;
			}
		}
		return false;
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target._name) === "_btnClose")
		{
			this.callClose();
		}
	}
	function itemDrag(loc2)
	{
		if(loc2.row.item == undefined)
		{
			return undefined;
		}
		if(this.api.datacenter.Player.Level < loc2.row.item._minPlayerLevel)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		this.gapi.setCursor(loc2.row.item);
	}
	function itemRollOver(loc2)
	{
	}
	function itemRollOut(loc2)
	{
	}
	function itemSelected(loc2)
	{
		switch(loc2.target)
		{
			case this._dgSpells:
				if(loc2.row.item != undefined)
				{
					if(this._sfivSpellFullInfosViewer.spell.ID != loc2.row.item.ID)
					{
						this.showDetails(true);
						this._sfivSpellFullInfosViewer.spell = loc2.row.item;
					}
					else
					{
						this.showDetails(false);
					}
				}
				break;
			case this._cbType:
				this._nSelectedSpellType = loc2.target.selectedItem.type;
				this.updateSpells();
		}
	}
	function bonusSpellsChanged(loc2)
	{
		this.updateBonus(loc2.value);
	}
	function close(loc2)
	{
		this.showDetails(false);
	}
	function modelChanged(loc2)
	{
		switch(loc2.eventName)
		{
			case "updateOne":
			case "updateAll":
		}
		this.updateSpells();
		this.hideSpellBoostViewer(true);
	}
}
