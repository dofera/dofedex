class dofus.aks.Emotes extends dofus.aks.Handler
{
	function Emotes(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function useEmote(§\x06\x05§)
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
		this.aks.send("eU" + var2,true);
	}
	function setDirection(§\x06\x14§)
	{
		this.aks.send("eD" + var2,true);
	}
	function onUse(§\x14\x1b§, §\x1e\x12\x1a§)
	{
		if(this.api.datacenter.Game.isFight)
		{
			return undefined;
		}
		if(!var2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_USE_EMOTE"),"ERROR_CHAT");
			return undefined;
		}
		var var4 = var3.split("|");
		var var5 = var4[0];
		var var6 = Number(var4[1]);
		var var7 = Number(var4[2]);
		if(var6 != 1 && !this.api.electron.isWindowFocused)
		{
			return undefined;
		}
		var var8 = !_global.isNaN(var6)?"emote" + var6:"static";
		this.api.gfx.convertHeightToFourSpriteDirection(var5);
		if(_global.isNaN(var7) && _global.isNaN(var6))
		{
			this.api.gfx.setForcedSpriteAnim(var5,var8);
		}
		else
		{
			this.api.gfx.setSpriteTimerAnim(var5,var8,true,var7);
		}
	}
	function onList(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = this.api.datacenter.Player;
		var6.clearEmotes();
		var var7 = 0;
		while(var7 < 32)
		{
			if((var4 >> var7 & 1) == 1)
			{
				if(this.api.lang.getEmoteText(var7 + 1) != undefined)
				{
					var6.addEmote(var7 + 1);
				}
			}
			var7 = var7 + 1;
		}
		var var8 = 0;
		while(var8 < 32)
		{
			if((var5 >> var8 & 1) == 1)
			{
				if(this.api.lang.getEmoteText(var8 + 1) != undefined)
				{
					var6.addEmote(var8 + 1);
				}
			}
			var8 = var8 + 1;
		}
		this.refresh();
	}
	function onAdd(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = var3[1] == "0";
		if(!var5)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("NEW_EMOTE",[this.api.lang.getEmoteText(var4).n]),"INFO_CHAT");
		}
		this.refresh();
	}
	function onRemove(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = var3[1] == "0";
		if(!var5)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("REMOVE_EMOTE",[this.api.lang.getEmoteText(var4).n]),"INFO_CHAT");
		}
		this.refresh();
	}
	function onDirection(§\x1e\x12\x1a§)
	{
		if(this.api.datacenter.Game.isFight)
		{
			return undefined;
		}
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = Number(var3[1]);
		var var6 = this.api.gfx.getSprite(var4).animation;
		this.api.gfx.setSpriteDirection(var4,var5);
		this.api.gfx.setSpriteAnim(var4,var6);
	}
	function refresh()
	{
		this.api.ui.getUIComponent("Banner").updateSmileysEmotes();
		this.api.ui.getUIComponent("Banner").showSmileysEmotesPanel(true);
	}
}
