class dofus.graphics.gapi.controls.Chat extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Chat";
	static var OPEN_OFFSET = 350;
	var _bOpened = false;
	function Chat()
	{
		super();
	}
	function __get__filters()
	{
		return new Array(this._btnFilter0.selected,this._btnFilter1.selected,this._btnFilter2.selected,this._btnFilter3.selected,this._btnFilter4.selected,this._btnFilter5.selected,this._btnFilter6.selected,this._btnFilter7.selected,this._btnFilter8.selected);
	}
	function __get__selectable()
	{
		return this._txtChat.selectable;
	}
	function __set__selectable(loc2)
	{
		this._txtChat.selectable = loc2;
		return this.__get__selectable();
	}
	function open(loc2)
	{
		if(loc2 == !this._bOpened)
		{
			return undefined;
		}
		this._btnOpenClose.selected = !loc2;
		if(loc2)
		{
			var loc3 = -1;
		}
		else
		{
			loc3 = 1;
		}
		this._txtChat.setSize(this._txtChat.width,this._txtChat.height + loc3 * dofus.graphics.gapi.controls.Chat.OPEN_OFFSET);
		this._y = this._y - loc3 * dofus.graphics.gapi.controls.Chat.OPEN_OFFSET;
		this._bOpened = !loc2;
	}
	function setText(loc2)
	{
		this._txtChat.text = loc2;
	}
	function updateSmileysEmotes()
	{
		this._sSmileys.update();
	}
	function hideSmileys(loc2)
	{
		this._sSmileys._visible = !loc2;
		this._bSmileysOpened = !loc2;
	}
	function showSitDown(loc2)
	{
		this._btnSitDown._visible = loc2;
	}
	function selectFilter(loc2, loc3)
	{
		this["_btnFilter" + loc2].selected = loc3;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.Chat.CLASS_NAME);
		this.api.kernel.ChatManager.updateRigth();
	}
	function createChildren()
	{
		var loc2 = this.api.lang.getConfigText("CHAT_FILTERS");
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			if(loc2[loc3] != 1)
			{
				this["_btnFilter" + (loc3 + 1)]._visible = false;
			}
			loc3 = loc3 + 1;
		}
		this.addToQueue({object:this,method:this.addListeners});
		this.hideSmileys(true);
	}
	function addListeners()
	{
		this._btnOpenClose.addEventListener("click",this);
		this._btnSmileys.addEventListener("click",this);
		this._btnFilter0.addEventListener("click",this);
		this._btnFilter1.addEventListener("click",this);
		this._btnFilter2.addEventListener("click",this);
		this._btnFilter3.addEventListener("click",this);
		this._btnFilter4.addEventListener("click",this);
		this._btnFilter5.addEventListener("click",this);
		this._btnFilter6.addEventListener("click",this);
		this._btnFilter7.addEventListener("click",this);
		this._btnFilter8.addEventListener("click",this);
		this._btnSitDown.addEventListener("click",this);
		this._btnOpenClose.addEventListener("over",this);
		this._btnSmileys.addEventListener("over",this);
		this._btnFilter0.addEventListener("over",this);
		this._btnFilter1.addEventListener("over",this);
		this._btnFilter2.addEventListener("over",this);
		this._btnFilter3.addEventListener("over",this);
		this._btnFilter4.addEventListener("over",this);
		this._btnFilter5.addEventListener("over",this);
		this._btnFilter6.addEventListener("over",this);
		this._btnFilter7.addEventListener("over",this);
		this._btnFilter8.addEventListener("over",this);
		this._btnSitDown.addEventListener("over",this);
		this._btnOpenClose.addEventListener("out",this);
		this._btnSmileys.addEventListener("out",this);
		this._btnFilter0.addEventListener("out",this);
		this._btnFilter1.addEventListener("out",this);
		this._btnFilter2.addEventListener("out",this);
		this._btnFilter3.addEventListener("out",this);
		this._btnFilter4.addEventListener("out",this);
		this._btnFilter5.addEventListener("out",this);
		this._btnFilter6.addEventListener("out",this);
		this._btnFilter7.addEventListener("out",this);
		this._btnFilter8.addEventListener("out",this);
		this._btnSitDown.addEventListener("out",this);
		this._sSmileys.addEventListener("selectSmiley",this);
		this._sSmileys.addEventListener("selectEmote",this);
		this._txtChat.addEventListener("href",this);
		var loc2 = this._btnFilter0;
		var loc3 = 0;
		while(loc2 != undefined)
		{
			loc2.selected = this.api.datacenter.Basics.chat_type_visible[loc3] == true;
			this.api.kernel.ChatManager.setTypeVisible(loc3,loc2.selected);
			loc3 = loc3 + 1;
			loc2 = this["_btnFilter" + loc3];
		}
		this.api.kernel.ChatManager.setTypeVisible(1,true);
		this.api.kernel.ChatManager.refresh();
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnSitDown":
				this.api.sounds.events.onBannerChatButtonClick();
				var loc3 = this.api.lang.getEmoteID("sit");
				if(loc3 != undefined)
				{
					this.api.network.Emotes.useEmote(loc3);
				}
				break;
			case "_btnSmileys":
				this.api.sounds.events.onBannerChatButtonClick();
				this.hideSmileys(this._bSmileysOpened);
				break;
			default:
				if(loc0 !== "_btnOpenClose")
				{
					this.dispatchEvent({type:"filterChanged",filter:Number(loc2.target._name.substr(10)),selected:loc2.target.selected});
					break;
				}
				this.api.sounds.events.onBannerChatButtonClick();
				this.open(!loc2.target.selected);
				break;
		}
	}
	function over(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnSmileys":
				this.gapi.showTooltip(this.api.lang.getText("CHAT_SHOW_SMILEYS"),loc2.target,-20,{bXLimit:true,bYLimit:false});
				break;
			case "_btnOpenClose":
				this.gapi.showTooltip(this.api.lang.getText("CHAT_SHOW_MORE"),loc2.target,-33,{bXLimit:true,bYLimit:false});
				break;
			case "_btnSitDown":
				this.gapi.showTooltip(this.api.lang.getText("SITDOWN_TOOLTIP"),loc2.target,-46,{bXLimit:true,bYLimit:false});
				break;
			default:
				var loc3 = Number(loc2.target._name.substr(10));
				this.gapi.showTooltip(this.api.lang.getText("CHAT_TYPE" + loc3),loc2.target,-20,{bXLimit:true,bYLimit:true});
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
	function selectSmiley(loc2)
	{
		if(!this.api.datacenter.Player.data.isInMove)
		{
			this.dispatchEvent(loc2);
			if(this.api.kernel.OptionsManager.getOption("AutoHideSmileys"))
			{
				this.hideSmileys(true);
				this._btnSmileys.selected = false;
			}
		}
	}
	function selectEmote(loc2)
	{
		if(!this.api.datacenter.Player.data.isInMove)
		{
			this.dispatchEvent(loc2);
			if(this.api.kernel.OptionsManager.getOption("AutoHideSmileys"))
			{
				this.hideSmileys(true);
			}
			this._btnSmileys.selected = false;
		}
	}
	function href(loc2)
	{
		this.dispatchEvent(loc2);
	}
}
