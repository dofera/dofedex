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
	function __set__selectable(var2)
	{
		this._txtChat.selectable = var2;
		return this.__get__selectable();
	}
	function open(var2)
	{
		if(var2 == !this._bOpened)
		{
			return undefined;
		}
		this._btnOpenClose.selected = !var2;
		if(var2)
		{
			var var3 = -1;
		}
		else
		{
			var3 = 1;
		}
		this._txtChat.setSize(this._txtChat.width,this._txtChat.height + var3 * dofus.graphics.gapi.controls.Chat.OPEN_OFFSET);
		this._y = this._y - var3 * dofus.graphics.gapi.controls.Chat.OPEN_OFFSET;
		this._bOpened = !var2;
	}
	function setText(var2)
	{
		this._txtChat.text = var2;
	}
	function updateSmileysEmotes()
	{
		this._sSmileys.update();
	}
	function hideSmileys(var2)
	{
		this._sSmileys._visible = !var2;
		this._bSmileysOpened = !var2;
	}
	function showSitDown(var2)
	{
		this._btnSitDown._visible = var2;
	}
	function selectFilter(var2, var3)
	{
		this["_btnFilter" + var2].selected = var3;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.Chat.CLASS_NAME);
		this.api.kernel.ChatManager.updateRigth();
	}
	function createChildren()
	{
		var var2 = this.api.lang.getConfigText("CHAT_FILTERS");
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(var2[var3] != 1)
			{
				this["_btnFilter" + (var3 + 1)]._visible = false;
			}
			var3 = var3 + 1;
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
		var var2 = this._btnFilter0;
		var var3 = 0;
		while(var2 != undefined)
		{
			var2.selected = this.api.datacenter.Basics.chat_type_visible[var3] == true;
			this.api.kernel.ChatManager.setTypeVisible(var3,var2.selected);
			var3 = var3 + 1;
			var2 = this["_btnFilter" + var3];
		}
		this.api.kernel.ChatManager.setTypeVisible(1,true);
		this.api.kernel.ChatManager.refresh();
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnSitDown":
				this.api.sounds.events.onBannerChatButtonClick();
				var var3 = this.api.lang.getEmoteID("sit");
				if(var3 != undefined)
				{
					this.api.network.Emotes.useEmote(var3);
				}
				break;
			case "_btnSmileys":
				this.api.sounds.events.onBannerChatButtonClick();
				this.hideSmileys(this._bSmileysOpened);
				break;
			case "_btnOpenClose":
				this.api.sounds.events.onBannerChatButtonClick();
				this.open(!var2.target.selected);
				break;
			default:
				this.dispatchEvent({type:"filterChanged",filter:Number(var2.target._name.substr(10)),selected:var2.target.selected});
		}
	}
	function over(var2)
	{
		switch(var2.target._name)
		{
			case "_btnSmileys":
				this.gapi.showTooltip(this.api.lang.getText("CHAT_SHOW_SMILEYS"),var2.target,-20,{bXLimit:true,bYLimit:false});
				break;
			case "_btnOpenClose":
				this.gapi.showTooltip(this.api.lang.getText("CHAT_SHOW_MORE"),var2.target,-33,{bXLimit:true,bYLimit:false});
				break;
			default:
				if(var0 !== "_btnSitDown")
				{
					var var3 = Number(var2.target._name.substr(10));
					this.gapi.showTooltip(this.api.lang.getText("CHAT_TYPE" + var3),var2.target,-20,{bXLimit:true,bYLimit:true});
					break;
				}
				this.gapi.showTooltip(this.api.lang.getText("SITDOWN_TOOLTIP"),var2.target,-46,{bXLimit:true,bYLimit:false});
				break;
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function selectSmiley(var2)
	{
		if(!this.api.datacenter.Player.data.isInMove)
		{
			this.dispatchEvent(var2);
			if(this.api.kernel.OptionsManager.getOption("AutoHideSmileys"))
			{
				this.hideSmileys(true);
				this._btnSmileys.selected = false;
			}
		}
	}
	function selectEmote(var2)
	{
		if(!this.api.datacenter.Player.data.isInMove)
		{
			this.dispatchEvent(var2);
			if(this.api.kernel.OptionsManager.getOption("AutoHideSmileys"))
			{
				this.hideSmileys(true);
			}
			this._btnSmileys.selected = false;
		}
	}
	function href(var2)
	{
		this.dispatchEvent(var2);
	}
}
