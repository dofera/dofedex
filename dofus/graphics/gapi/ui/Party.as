class dofus.graphics.gapi.ui.Party extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Party";
	var §§constant(11) = §§constant(108);
	var §§constant(13) = §§constant(108);
	function Party()
	{
		super();
	}
	function __get__leaderID()
	{
		return this._sLeaderID;
	}
	function __get__followID()
	{
		return this._sFollowID;
	}
	function moveUI(loc2)
	{
		this._btnOpenClose._y = this._btnOpenClose._y + loc2;
		this._btnBlockJoinerExceptParty._y = this._btnBlockJoinerExceptParty._y + loc2;
		this._mcInfo._y = this._mcInfo._y + loc2;
		this._piMember0._y = this._piMember0._y + loc2;
		this._piMember1._y = this._piMember1._y + loc2;
		this._piMember2._y = this._piMember2._y + loc2;
		this._piMember3._y = this._piMember3._y + loc2;
		this._piMember4._y = this._piMember4._y + loc2;
		this._piMember5._y = this._piMember5._y + loc2;
		this._piMember6._y = this._piMember6._y + loc2;
		this._piMember7._y = this._piMember7._y + loc2;
	}
	function addMember(loc2, loc3)
	{
		this._aMembers.push(loc2);
		if(loc3)
		{
			this.updateData();
		}
	}
	function getMember(loc2)
	{
		var loc3 = this._aMembers.findFirstItem("id",loc2);
		if(loc3.index != -1)
		{
			return loc3.item;
		}
		return null;
	}
	function getMemberById(loc2)
	{
		var loc3 = 0;
		while(loc3 < dofus.Constants.MEMBERS_COUNT_IN_PARTY)
		{
			if(this._aMembers[loc3].id == loc2)
			{
				return this._aMembers[loc3];
			}
			loc3 = loc3 + 1;
		}
		return null;
	}
	function removeMember(loc2, loc3)
	{
		var loc4 = this._aMembers.findFirstItem("id",loc2);
		if(this._sFollowID == loc2)
		{
			this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1]);
			delete this._sFollowID;
		}
		if(loc4.index != -1)
		{
			this._aMembers.removeItems(loc4.index,1);
		}
		if(loc3)
		{
			this.updateData();
		}
	}
	function refresh()
	{
		this.addToQueue({object:this,method:this.updateData});
	}
	function setLeader(loc2)
	{
		this._sLeaderID = loc2;
		this.updateData();
		if(loc2 == undefined)
		{
			this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[0]);
		}
	}
	function setFollow(loc2)
	{
		this._sFollowID = loc2;
		this.updateData();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Party.CLASS_NAME);
		this._aMembers = new ank.utils.();
	}
	function destroy()
	{
		this.gapi.hideTooltip();
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.updateData});
		this.addToQueue({object:this,method:this.initOption});
		if(this.api.ui.getUIComponent("Timeline") != undefined && dofus.graphics.gapi.ui.Timeline.isTimelineUpPosition)
		{
			this.moveUI(dofus.graphics.gapi.ui.Timeline.UI_PARTY_MOVE_DISTANCE);
		}
	}
	function addListeners()
	{
		this._btnOpenClose.addEventListener("click",this);
		this._btnOpenClose.addEventListener("over",this);
		this._btnOpenClose.addEventListener("out",this);
		this._btnBlockJoinerExceptParty.addEventListener("click",this);
		this._btnBlockJoinerExceptParty.addEventListener("over",this);
		this._btnBlockJoinerExceptParty.addEventListener("out",this);
	}
	function initOption()
	{
		this._btnBlockJoinerExceptParty.selected = this.api.kernel.OptionsManager.getOption("FightGroupAutoLock");
	}
	function updateData(loc2)
	{
		var loc3 = 0;
		this._nLvlTotal = 0;
		this._nProspectionTotal = 0;
		var loc5 = false;
		if(this._aMembers.length != 0)
		{
			var loc6 = 0;
			while(loc6 < dofus.Constants.MEMBERS_COUNT_IN_PARTY)
			{
				var loc7 = this._aMembers[loc6];
				loc3;
				var loc8 = this["_piMember" + loc3++];
				if(loc2 && loc2.id == loc7.id)
				{
					loc7 = loc2;
					this._aMembers[loc6] = loc2;
				}
				loc8.setData(loc7);
				loc8.isFollowing = loc7.id == this._sFollowID;
				if(loc8.isInGroup)
				{
					this._nLvlTotal = this._nLvlTotal + loc7.level;
					this._nProspectionTotal = this._nProspectionTotal + loc7.prospection;
				}
				loc6 = loc6 + 1;
			}
			var loc9 = true;
			while(loc9)
			{
				loc9 = false;
				var loc10 = 0;
				while(loc10 < dofus.Constants.MEMBERS_COUNT_IN_PARTY)
				{
					if(this._aMembers[loc10 + 1] != undefined && this._aMembers[loc10].initiative < this._aMembers[loc10 + 1].initiative)
					{
						var loc11 = this._aMembers[loc10];
						this._aMembers[loc10] = this._aMembers[loc10 + 1];
						this._aMembers[loc10 + 1] = loc11;
						loc9 = true;
					}
					var loc12 = this["_piMember" + loc10];
					loc12._visible = !this._btnOpenClose.selected;
					loc12.setData(this._aMembers[loc10]);
					loc12.isFollowing = this._aMembers[loc10].id == this._sFollowID;
					if(loc12.isInGroup)
					{
						var loc4 = loc12;
					}
					loc10 = loc10 + 1;
				}
			}
		}
		var ref = this;
		this._mcInfo.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcInfo.onRollOut = function()
		{
			ref.out({target:this});
		};
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target) !== this._btnBlockJoinerExceptParty)
		{
			this._piMember0._visible = !this._btnOpenClose.selected;
			this._piMember1._visible = !this._btnOpenClose.selected;
			this._piMember2._visible = !this._btnOpenClose.selected;
			this._piMember3._visible = !this._btnOpenClose.selected;
			this._piMember4._visible = !this._btnOpenClose.selected;
			this._piMember5._visible = !this._btnOpenClose.selected;
			this._piMember6._visible = !this._btnOpenClose.selected;
			this._piMember7._visible = !this._btnOpenClose.selected;
			this._mcInfo._visible = !this._btnOpenClose.selected;
		}
		else
		{
			var loc3 = !this.api.kernel.OptionsManager.getOption("FightGroupAutoLock");
			this.api.kernel.OptionsManager.setOption("FightGroupAutoLock",loc3);
		}
	}
	function over(loc2)
	{
		switch(loc2.target)
		{
			case this._btnOpenClose:
				this.gapi.showTooltip(this.api.lang.getText("PARTY_OPEN_CLOSE"),loc2.target,20);
				break;
			case this._mcInfo:
			default:
				this.gapi.showTooltip("<b>" + this.api.lang.getText("INFORMATIONS") + "</b>\n" + this.api.lang.getText("TOTAL_LEVEL") + " : " + this._nLvlTotal + "\n" + this.api.lang.getText("TOTAL_DISCERNMENT") + " : " + this._nProspectionTotal,loc2.target,20);
				break;
			case this._btnBlockJoinerExceptParty:
				this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_BLOCKJOINEREXCEPTPARTY"),loc2.target,20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
