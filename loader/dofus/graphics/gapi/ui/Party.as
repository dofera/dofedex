class dofus.graphics.gapi.ui.Party extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Party";
	var _sLeaderID = "0";
	var _sFollowID = "0";
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
	function moveUI(var2)
	{
		this._btnOpenClose._y = this._btnOpenClose._y + var2;
		this._btnBlockJoinerExceptParty._y = this._btnBlockJoinerExceptParty._y + var2;
		this._mcInfo._y = this._mcInfo._y + var2;
		this._piMember0._y = this._piMember0._y + var2;
		this._piMember1._y = this._piMember1._y + var2;
		this._piMember2._y = this._piMember2._y + var2;
		this._piMember3._y = this._piMember3._y + var2;
		this._piMember4._y = this._piMember4._y + var2;
		this._piMember5._y = this._piMember5._y + var2;
		this._piMember6._y = this._piMember6._y + var2;
		this._piMember7._y = this._piMember7._y + var2;
	}
	function addMember(var2, var3)
	{
		this._aMembers.push(var2);
		if(var3)
		{
			this.updateData();
		}
	}
	function getMember(var2)
	{
		var var3 = this._aMembers.findFirstItem("id",var2);
		if(var3.index != -1)
		{
			return var3.item;
		}
		return null;
	}
	function getMemberById(var2)
	{
		var var3 = 0;
		while(var3 < dofus.Constants.MEMBERS_COUNT_IN_PARTY)
		{
			if(this._aMembers[var3].id == var2)
			{
				return this._aMembers[var3];
			}
			var3 = var3 + 1;
		}
		return null;
	}
	function removeMember(var2, var3)
	{
		var var4 = this._aMembers.findFirstItem("id",var2);
		if(this._sFollowID == var2)
		{
			this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1]);
			delete this._sFollowID;
		}
		if(var4.index != -1)
		{
			this._aMembers.removeItems(var4.index,1);
		}
		if(var3)
		{
			this.updateData();
		}
	}
	function refresh()
	{
		this.addToQueue({object:this,method:this.updateData});
	}
	function setLeader(var2)
	{
		this._sLeaderID = var2;
		this.updateData();
		if(var2 == undefined)
		{
			this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[0]);
		}
	}
	function setFollow(var2)
	{
		this._sFollowID = var2;
		this.updateData();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Party.CLASS_NAME);
		this._aMembers = new ank.utils.();
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
	function updateData(var2)
	{
		var var3 = 0;
		this._nLvlTotal = 0;
		this._nProspectionTotal = 0;
		var var5 = false;
		if(this._aMembers.length != 0)
		{
			var var6 = 0;
			while(var6 < dofus.Constants.MEMBERS_COUNT_IN_PARTY)
			{
				var var7 = this._aMembers[var6];
				var3;
				var var8 = this["_piMember" + var3++];
				if(var2 && var2.id == var7.id)
				{
					var7 = var2;
					this._aMembers[var6] = var2;
				}
				var8.setData(var7);
				var8.isFollowing = var7.id == this._sFollowID;
				var8.isLeader = var7.id == this._sLeaderID;
				if(var8.isInGroup)
				{
					this._nLvlTotal = this._nLvlTotal + var7.level;
					this._nProspectionTotal = this._nProspectionTotal + var7.prospection;
				}
				var6 = var6 + 1;
			}
			var var9 = true;
			while(var9)
			{
				var9 = false;
				var var10 = 0;
				while(var10 < dofus.Constants.MEMBERS_COUNT_IN_PARTY)
				{
					if(this._aMembers[var10 + 1] != undefined && this._aMembers[var10].initiative < this._aMembers[var10 + 1].initiative)
					{
						var var11 = this._aMembers[var10];
						this._aMembers[var10] = this._aMembers[var10 + 1];
						this._aMembers[var10 + 1] = var11;
						var9 = true;
					}
					var var12 = this["_piMember" + var10];
					var12._visible = !this._btnOpenClose.selected;
					var12.setData(this._aMembers[var10]);
					var12.isFollowing = this._aMembers[var10].id == this._sFollowID;
					var12.isLeader = this._aMembers[var10].id == this._sLeaderID;
					if(var12.isInGroup)
					{
						var var4 = var12;
					}
					var10 = var10 + 1;
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
	function click(var2)
	{
		if((var var0 = var2.target) !== this._btnBlockJoinerExceptParty)
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
			var var3 = !this.api.kernel.OptionsManager.getOption("FightGroupAutoLock");
			this.api.kernel.OptionsManager.setOption("FightGroupAutoLock",var3);
		}
	}
	function over(var2)
	{
		switch(var2.target)
		{
			case this._btnOpenClose:
				this.gapi.showTooltip(this.api.lang.getText("PARTY_OPEN_CLOSE"),var2.target,20);
				break;
			case this._mcInfo:
				this.gapi.showTooltip("<b>" + this.api.lang.getText("INFORMATIONS") + "</b>\n" + this.api.lang.getText("TOTAL_LEVEL") + " : " + this._nLvlTotal + "\n" + this.api.lang.getText("TOTAL_DISCERNMENT") + " : " + this._nProspectionTotal,var2.target,20);
				break;
			case this._btnBlockJoinerExceptParty:
				this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_BLOCKJOINEREXCEPTPARTY"),var2.target,20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
}
