class dofus.graphics.gapi.ui.party.PartyItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	function PartyItem()
	{
		super();
	}
	function __set__data(oSprite)
	{
		this._oSprite = oSprite;
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__data();
	}
	function __set__isFollowing(§\x18\x14§)
	{
		this._bIsFollowing = var2;
		this._mcFollow._visible = var2;
		return this.__get__isFollowing();
	}
	function __set__isLeader(§\x18\x12§)
	{
		this._bIsLeader = var2;
		this._mcLeader._visible = var2;
		return this.__get__isLeader();
	}
	function __get__isLeader()
	{
		return this._bIsLeader;
	}
	function __get__isInGroup(§\x18\x13§)
	{
		return this._bIsInGroup;
	}
	function setHealth(oSprite)
	{
		if(oSprite.life == undefined)
		{
			return undefined;
		}
		var var3 = oSprite.life.split(",");
		this._mcHealth._yscale = var3[0] / var3[1] * 100;
		this._oSprite.life = oSprite.life;
	}
	function setData(oSprite)
	{
		if(this.doReload(oSprite))
		{
			this._oSprite = oSprite;
			if(this.initialized)
			{
				this.updateData();
			}
		}
		else
		{
			this.setHealth(oSprite);
		}
	}
	function doReload(oSprite)
	{
		var var3 = true;
		if(this._oSprite.accessories && (oSprite.accessories.length == this._oSprite.accessories.length && oSprite.id == this._oSprite.id))
		{
			var var4 = this._oSprite.accessories;
			var var5 = oSprite.accessories;
			var var6 = new Array();
			var var7 = new Array();
			§§enumerate(var4);
			while((var var0 = §§enumeration()) != null)
			{
				var6.push(var4[i].unicID);
			}
			§§enumerate(var5);
			while((var var0 = §§enumeration()) != null)
			{
				var7.push(var5[i].unicID);
			}
			var6.sort();
			var7.sort();
			var3 = !var6 || var6.join(",") != var7.join(",");
		}
		return var3;
	}
	function init()
	{
		super.init(false);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this._mcBack._visible = false;
		this._mcFollow._visible = false;
		this._mcHealth._visible = false;
		this._btn._visible = false;
	}
	function addListeners()
	{
		this._ldrSprite.addEventListener("initialization",this);
		this._btn.addEventListener("over",this);
		this._btn.addEventListener("out",this);
		this._btn.addEventListener("click",this);
	}
	function updateData()
	{
		if(this._oSprite != undefined)
		{
			this._ldrSprite.contentPath = this._oSprite.gfxFile != undefined?this._oSprite.gfxFile:"";
			this.api.colors.addSprite(this._ldrSprite,this._oSprite);
			this._mcBack._visible = true;
			this._btn.enabled = true;
			this._btn._visible = true;
			this._mcHealth._visible = true;
			this.setHealth(this._oSprite.life);
			this._bIsInGroup = true;
			this._visible = true;
		}
		else
		{
			this._ldrSprite.contentPath = "";
			this._mcBack._visible = false;
			this._mcFollow._visible = false;
			this._btn.enabled = false;
			this._btn._visible = false;
			this._mcHealth._visible = false;
			this._bIsInGroup = false;
			this._visible = false;
		}
	}
	function isLocalPlayerLeader()
	{
		return this._parent.leaderID == this.api.datacenter.Player.ID;
	}
	function isLocalPlayer()
	{
		return this._oSprite.id == this.api.datacenter.Player.ID;
	}
	function partyWhere()
	{
		this.api.network.Party.where();
		this.api.ui.loadUIAutoHideComponent("MapExplorer","MapExplorer");
	}
	function initialization(§\x1e\x19\x18§)
	{
		var var3 = var2.target.content;
		var3.attachMovie("staticR","anim",10);
		var3._xscale = -65;
		var3._yscale = 65;
	}
	function over(§\x1e\x19\x18§)
	{
		var var3 = this._oSprite.life.split(",");
		this._mcHealth._yscale = var3[0] / var3[1] * 100;
		this.gapi.showTooltip(this._oSprite.name + "\n" + this.api.lang.getText("LEVEL") + " : " + this._oSprite.level + "\n" + this.api.lang.getText("LIFEPOINTS") + " : " + var3[0] + " / " + var3[1],var2.target,30);
	}
	function out(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
	}
	function click(§\x1e\x19\x18§)
	{
		this.api.kernel.GameManager.showPlayerPopupMenu(undefined,this._oSprite.name,this);
	}
	function addPartyMenuItems(§\x1e\x16\x18§)
	{
		var2.addStaticItem(this.api.lang.getText("PARTY"));
		var2.addItem(this.api.lang.getText("PARTY_WHERE"),this,this.partyWhere,[]);
		if(this._oSprite.id == this.api.datacenter.Player.ID)
		{
			var2.addItem(this.api.lang.getText("LEAVE_PARTY"),this.api.network.Party,this.api.network.Party.leave,[]);
			if(this.isLocalPlayerLeader())
			{
				if(this._bIsFollowing)
				{
					var2.addItem(this.api.lang.getText("PARTY_STOP_FOLLOW_ME_ALL"),this.api.network.Party,this.api.network.Party.followAll,[true,this._oSprite.id]);
				}
				else
				{
					var2.addItem(this.api.lang.getText("PARTY_FOLLOW_ME_ALL"),this.api.network.Party,this.api.network.Party.followAll,[false,this._oSprite.id]);
				}
			}
		}
		else
		{
			if(this.isLocalPlayer)
			{
				if(this._bIsFollowing)
				{
					var2.addItem(this.api.lang.getText("STOP_FOLLOW"),this.api.network.Party,this.api.network.Party.follow,[true,this._oSprite.id]);
				}
				else
				{
					var2.addItem(this.api.lang.getText("FOLLOW"),this.api.network.Party,this.api.network.Party.follow,[false,this._oSprite.id]);
				}
			}
			if(this.isLocalPlayerLeader())
			{
				if(this._bIsFollowing)
				{
					var2.addItem(this.api.lang.getText("PARTY_STOP_FOLLOW_HIM_ALL"),this.api.network.Party,this.api.network.Party.followAll,[true,this._oSprite.id]);
				}
				else
				{
					var2.addItem(this.api.lang.getText("PARTY_FOLLOW_HIM_ALL"),this.api.network.Party,this.api.network.Party.followAll,[false,this._oSprite.id]);
				}
				var2.addItem(this.api.lang.getText("KICK_FROM_PARTY"),this.api.network.Party,this.api.network.Party.leave,[this._oSprite.id]);
			}
		}
	}
}
