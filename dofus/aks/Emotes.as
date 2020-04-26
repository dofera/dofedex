class dofus.aks.Emotes extends dofus.aks.Handler
{
	function Emotes(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function useEmote(loc2)
	{
		if(this.api.datacenter.Game.isFight)
		{
			return undefined;
		}
		if(getTimer() - this.api.datacenter.Basics.aks_emote_lastActionTime < dofus.Constants.CLICK_MIN_DELAY)
		{
			return undefined;
		}
		this.api.datacenter.Basics.aks_emote_lastActionTime = getTimer();
		this.aks.send("eU" + loc2,true);
	}
	function setDirection(loc2)
	{
		this.aks.send("eD" + loc2,true);
	}
	function onUse(loc2, loc3)
	{
		if(this.api.datacenter.Game.isFight)
		{
			return undefined;
		}
		if(!loc2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_USE_EMOTE"),"ERROR_CHAT");
			return undefined;
		}
		var loc4 = loc3.split("|");
		var loc5 = loc4[0];
		var loc6 = Number(loc4[1]);
		var loc7 = Number(loc4[2]);
		var loc8 = !_global.isNaN(loc6)?"emote" + loc6:"static";
		this.api.gfx.convertHeightToFourSpriteDirection(loc5);
		if(_global.isNaN(loc7) && _global.isNaN(loc6))
		{
			this.api.gfx.setForcedSpriteAnim(loc5,loc8);
		}
		else
		{
			this.api.gfx.setSpriteTimerAnim(loc5,loc8,true,loc7);
		}
	}
	function onList(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = this.api.datacenter.Player;
		loc6.clearEmotes();
		var loc7 = 0;
		while(loc7 < 32)
		{
			if((loc4 >> loc7 & 1) == 1)
			{
				if(this.api.lang.getEmoteText(loc7 + 1) != undefined)
				{
					loc6.addEmote(loc7 + 1);
				}
			}
			loc7 = loc7 + 1;
		}
		var loc8 = 0;
		while(loc8 < 32)
		{
			if((loc5 >> loc8 & 1) == 1)
			{
				if(this.api.lang.getEmoteText(loc8 + 1) != undefined)
				{
					loc6.addEmote(loc8 + 1);
				}
			}
			loc8 = loc8 + 1;
		}
		this.refresh();
	}
	function onAdd(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1] == "0";
		if(!loc5)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("NEW_EMOTE",[this.api.lang.getEmoteText(loc4).n]),"INFO_CHAT");
		}
		this.refresh();
	}
	function onRemove(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1] == "0";
		if(!loc5)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("REMOVE_EMOTE",[this.api.lang.getEmoteText(loc4).n]),"INFO_CHAT");
		}
		this.refresh();
	}
	function onDirection(loc2)
	{
		if(this.api.datacenter.Game.isFight)
		{
			return undefined;
		}
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = Number(loc3[1]);
		var loc6 = this.api.gfx.getSprite(loc4).animation;
		this.api.gfx.setSpriteDirection(loc4,loc5);
		this.api.gfx.setSpriteAnim(loc4,loc6);
	}
	function refresh()
	{
		this.api.ui.getUIComponent("Banner").updateSmileysEmotes();
		this.api.ui.getUIComponent("Banner").showSmileysEmotesPanel(true);
	}
}
