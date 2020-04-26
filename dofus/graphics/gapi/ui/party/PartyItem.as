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
	function __set__isFollowing(loc2)
	{
		this._bIsFollowing = loc2;
		this._mcFollow._visible = loc2;
		return this.__get__isFollowing();
	}
	function __get__isInGroup(loc2)
	{
		return this._bIsInGroup;
	}
	function setHealth(oSprite)
	{
		if(oSprite.life == undefined)
		{
			return undefined;
		}
		var loc3 = oSprite.life.split(",");
		this._mcHealth._yscale = loc3[0] / loc3[1] * 100;
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
		var loc3 = true;
		if(this._oSprite.accessories && (oSprite.accessories.length == this._oSprite.accessories.length && oSprite.id == this._oSprite.id))
		{
			var loc4 = this._oSprite.accessories;
			var loc5 = oSprite.accessories;
			var loc6 = new Array();
			var loc7 = new Array();
			for(var i in loc4)
			{
				loc6.push(loc4[i].unicID);
			}
			for(var i in loc5)
			{
				loc7.push(loc5[i].unicID);
			}
			loc6.sort();
			loc7.sort();
			loc3 = !loc6 || loc6.join(",") != loc7.join(",");
		}
		return loc3;
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
	function initialization(loc2)
	{
		var loc3 = loc2.target.content;
		loc3.attachMovie("staticR","anim",10);
		loc3._xscale = -65;
		loc3._yscale = 65;
	}
	function over(loc2)
	{
		var loc3 = this._oSprite.life.split(",");
		this._mcHealth._yscale = loc3[0] / loc3[1] * 100;
		this.gapi.showTooltip(this._oSprite.name + "\n" + this.api.lang.getText("LEVEL") + " : " + this._oSprite.level + "\n" + this.api.lang.getText("LIFEPOINTS") + " : " + loc3[0] + " / " + loc3[1],loc2.target,30);
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
	function click(loc2)
	{
		this.api.kernel.GameManager.showPlayerPopupMenu(undefined,this._oSprite.name,this);
	}
	function addPartyMenuItems(loc2)
	{
		loc2.addStaticItem(this.api.lang.getText("PARTY"));
		loc2.addItem(this.api.lang.getText("PARTY_WHERE"),this,this.partyWhere,[]);
		if(this._oSprite.id == this.api.datacenter.Player.ID)
		{
			loc2.addItem(this.api.lang.getText("LEAVE_PARTY"),this.api.network.Party,this.api.network.Party.leave,[]);
			if(this.isLocalPlayerLeader())
			{
				if(this._bIsFollowing)
				{
					loc2.addItem(this.api.lang.getText("PARTY_STOP_FOLLOW_ME_ALL"),this.api.network.Party,this.api.network.Party.followAll,[true,this._oSprite.id]);
				}
				else
				{
					loc2.addItem(this.api.lang.getText("PARTY_FOLLOW_ME_ALL"),this.api.network.Party,this.api.network.Party.followAll,[false,this._oSprite.id]);
				}
			}
		}
		else
		{
			if(this.isLocalPlayer)
			{
				if(this._bIsFollowing)
				{
					loc2.addItem(this.api.lang.getText("STOP_FOLLOW"),this.api.network.Party,this.api.network.Party.follow,[true,this._oSprite.id]);
				}
				else
				{
					loc2.addItem(this.api.lang.getText("FOLLOW"),this.api.network.Party,this.api.network.Party.follow,[false,this._oSprite.id]);
				}
			}
			if(this.isLocalPlayerLeader())
			{
				if(this._bIsFollowing)
				{
					loc2.addItem(this.api.lang.getText("PARTY_STOP_FOLLOW_HIM_ALL"),this.api.network.Party,this.api.network.Party.followAll,[true,this._oSprite.id]);
				}
				else
				{
					loc2.addItem(this.api.lang.getText("PARTY_FOLLOW_HIM_ALL"),this.api.network.Party,this.api.network.Party.followAll,[false,this._oSprite.id]);
				}
				loc2.addItem(this.api.lang.getText("KICK_FROM_PARTY"),this.api.network.Party,this.api.network.Party.leave,[this._oSprite.id]);
			}
		}
	}
}
