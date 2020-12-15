class dofus.graphics.gapi.controls.ChooseServerSprite extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ChooseServerSprite";
	static var MAX_CHARS_DISPLAYED = 5;
	var _bSelected = false;
	var _bOver = false;
	function ChooseServerSprite()
	{
		super();
		this._lblNumChar._visible = false;
		this._mcNumChar._visible = false;
	}
	function __set__serverID(var2)
	{
		this._nServerID = var2;
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__serverID();
	}
	function __get__serverID()
	{
		return this._nServerID;
	}
	function __get__server()
	{
		var var2 = this.api.datacenter.Basics.aks_servers;
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(var2[var3].id == this._nServerID)
			{
				return var2[var3];
			}
			var3 = var3 + 1;
		}
		return undefined;
	}
	function __set__selected(var2)
	{
		this._bSelected = var2;
		this.updateSelected(!var2?this.getStyle().overcolor:this.getStyle().selectedcolor);
		return this.__get__selected();
	}
	function __get__selected()
	{
		return this._bSelected;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ChooseServerSprite.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.updateData});
	}
	function addListeners()
	{
		this._ldrSprite.addEventListener("initialization",this);
		this._ldrSprite.addEventListener("error",this);
		this._ctrServerState.addEventListener("over",this);
		this._ctrServerState.addEventListener("out",this);
		this._lblState.onRelease = function()
		{
			getURL(this._parent.api.lang.getConfigText("FORUM_SERVERS_STATE_LAST_POST"),"_blank");
		};
		this._ctrServerState.onRelease = function()
		{
			getURL(this._parent.api.lang.getConfigText("FORUM_SERVERS_STATE_LAST_POST"),"_blank");
		};
		this.api.datacenter.Basics.aks_servers.addEventListener("modelChanged",this);
	}
	function setEnabled()
	{
		if(this._bEnabled)
		{
			this._mcInteraction.onRelease = function()
			{
				this._parent.innerRelease();
			};
			this._mcInteraction.onRollOver = function()
			{
				this._parent.innerOver();
			};
			this._mcInteraction.onRollOut = this._mcInteraction.onReleaseOutside = function()
			{
				this._parent.innerOut();
			};
			this.setMovieClipTransform(this,{ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
		}
		else
		{
			delete this._mcInteraction.onRelease;
			delete this._mcInteraction.onRollOver;
			delete this._mcInteraction.onRollOut;
			delete this._mcInteraction.onReleaseOutside;
			this.setMovieClipTransform(this,this.getStyle().desabledtransform);
			this.selected = false;
		}
	}
	function updateData()
	{
		var var2 = this.server;
		var var3 = 0;
		while(var3 < dofus.graphics.gapi.controls.ChooseServerSprite.MAX_CHARS_DISPLAYED + 1)
		{
			this["Bonhomme" + var3].removeMovieClip();
			var3 = var3 + 1;
		}
		this._lblNumChar._visible = false;
		this._mcNumChar._visible = false;
		if(var2 != undefined)
		{
			this._lblName.text = var2.label;
			var var4 = var2.charactersCount;
			if(var4 <= dofus.graphics.gapi.controls.ChooseServerSprite.MAX_CHARS_DISPLAYED)
			{
				var var5 = 3;
				var var6 = (112 - var4 * (14.5 + var5)) / 2;
				var var7 = var6;
				var var8 = 165;
				var var9 = 0;
				while(var9 < var4)
				{
					var var10 = this.attachMovie("Bonhomme","Bonhomme" + var9,var9,{_x:var7,_y:var8});
					var7 = var7 + (var5 + 14.5);
					var9 = var9 + 1;
				}
			}
			else
			{
				this._lblNumChar._visible = true;
				this._mcNumChar._visible = true;
				this._lblNumChar.text = "x" + var4;
			}
			this._lblState.text = var2.stateStrShort;
			this._ldrSprite.forceReload = true;
			this._ldrSprite.contentPath = dofus.Constants.SERVER_SYMBOL_PATH + var2.id + ".swf";
			this.enabled = var2.state == dofus.datacenter.Server.SERVER_ONLINE;
			this._ctrServerState.contentPath = var2.state != dofus.datacenter.Server.SERVER_ONLINE?"NewCross":"NewValid";
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblState.text = "";
			this._ldrSprite.contentPath = "";
			this._ctrServerState.contentPath = "";
			this.enabled = false;
		}
	}
	function updateSelected(var2)
	{
		if(this._bSelected || this._bOver && this._bEnabled)
		{
			this._mcSelect.gotoAndPlay(1);
			this._mcSelect._visible = true;
		}
		else
		{
			this._mcSelect.stop();
			this._mcSelect._visible = false;
		}
	}
	function initialization(var2)
	{
		var var3 = var2.clip;
	}
	function error(var2)
	{
		this._ldrSprite.forceReload = true;
		this._ldrSprite.contentPath = dofus.Constants.SERVER_SYMBOL_PATH + "0.swf";
	}
	function innerRelease()
	{
		this.selected = true;
		this.dispatchEvent({type:"select",serverID:this._nServerID});
	}
	function innerOver()
	{
		this._bOver = true;
		this.updateSelected(!this._bSelected?this.getStyle().overcolor:this.getStyle().selectedcolor);
	}
	function innerOut()
	{
		this._bOver = false;
		this.updateSelected(this.getStyle().selectedcolor);
	}
	function over(var2)
	{
		if((var var0 = var2.target) === this._ctrServerState)
		{
			this.gapi.showTooltip(this.server.stateStr,_root._xmouse,_root._ymouse - 20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function modelChanged(var2)
	{
		this.updateData();
		this.dispatchEvent({type:"unselect"});
	}
}
