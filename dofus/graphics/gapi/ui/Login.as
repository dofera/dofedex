class dofus.graphics.gapi.ui.Login extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Login";
	var _bHideNext = false;
	var _nLastRegisterTime = 0;
	function Login()
	{
		super();
		this._mcGoToStatus._visible = false;
		this._lblGoToStatus._visible = false;
		this._mcNoGiftsBanner._visible = false;
		this.fillCommunityID();
	}
	function __set__language(loc2)
	{
		this._sLanguage = loc2;
		return this.__get__language();
	}
	function autoLogin(loc2, loc3)
	{
		if(loc2 != undefined && (loc3 != undefined && (loc2 != null && (loc3 != null && (loc2 != "null" && (loc3 != "null" && (loc2 != "" && loc3 != "")))))))
		{
			this._tiAccount.text = loc2;
			this._tiPassword.text = loc3;
			if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
			{
				this.getURL("JavaScript:WriteLog(\'AutoLogin;" + loc2 + "/" + loc3 + "\')");
			}
			delete _root.htmlLogin;
			delete _root.htmlPassword;
			this.click({target:this._btnOK});
		}
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Login.CLASS_NAME);
	}
	function createChildren()
	{
		this.api.datacenter.Basics.inGame = false;
		this._cbPorts._visible = false;
		this._lblRememberMe._visible = false;
		this._btnRememberMe._visible = false;
		this._mcAdvancedBackground._visible = false;
		this._btnTestServer._visible = dofus.Constants.TEST;
		if(!dofus.Constants.TEST && !dofus.Constants.ALPHA)
		{
			this._lblTestServer._visible = false;
			this._lblTestServerInfo._visible = false;
			this._mcBackgroundHidder._visible = false;
		}
		this._mcBanner.gotoAndStop(random(5) + 1);
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initInput});
		this.addToQueue({object:this,method:this.loadFlags});
		this.addToQueue({object:this,method:this.initLanguages});
		this.addToQueue({object:this,method:this.constructPortsList});
		this.addToQueue({object:this,method:this.initSavedAccount});
		this.hideServerStatus();
		this._siServerStatus = new dofus.datacenter.ServerInformations();
		this._siServerStatus.addEventListener("onData",this);
		this._siServerStatus.addEventListener("onLoadError",this);
		this._siServerStatus.load();
		this.showLastAlertButton(false);
		this._xAlert = new XML();
		this._xAlert.ignoreWhite = true;
		var _owner = this;
		this._xAlert.onLoad = function(loc2)
		{
			_owner.onAlertLoad(loc2);
		};
		var loc2 = this.api.lang.getConfigText("ALERTY_LINK");
		if(loc2 != "")
		{
			this._xAlert.load(loc2);
		}
		this._mcServersStateHighlight._visible = false;
		this._mcServersStateHighlight.gotoAndStop(1);
		this._mcEvolutionsHighlight._visible = false;
		this._mcEvolutionsHighlight.gotoAndStop(1);
		this.addToQueue({object:this,method:this.autoLogin,params:[_root.htmlLogin,_root.htmlPassword]});
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'LoginScreen\')");
		}
	}
	function initSavedAccount()
	{
		this._btnRememberMe.selected = this.api.kernel.OptionsManager.getOption("RememberAccountName");
		if(!dofus.Constants.DEBUG && this.api.kernel.OptionsManager.getOption("RememberAccountName"))
		{
			this._tiAccount.text = this.api.kernel.OptionsManager.getOption("LastAccountNameUsed");
			this._tiPassword.setFocus();
		}
	}
	function initPayingCommunity()
	{
		var loc2 = this.api.lang.getConfigText("FREE_COMMUNITIES");
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			if(loc2[loc3] == this.api.datacenter.Basics.aks_community_id)
			{
				this._btnMembers._visible = false;
				this._mcMembersBackground._visible = false;
				this.api.datacenter.Basics.aks_is_free_community = true;
				return undefined;
			}
			loc3 = loc3 + 1;
		}
		this.api.datacenter.Basics.aks_is_free_community = dofus.Constants.BETAVERSION <= 0?false:true;
	}
	function loadNews()
	{
		var loc2 = new ank.utils.rss.();
		loc2.addEventListener("onRSSLoadError",this);
		loc2.addEventListener("onBadRSSFile",this);
		loc2.addEventListener("onRSSLoaded",this);
		var loc3 = this.api.lang.getConfigText("RSS_LINK");
		if(loc3 != "")
		{
			loc2.load(loc3);
		}
	}
	function loadGifts()
	{
		var loc2 = new LoadVars();
		loc2.owner = this;
		loc2.onLoad = function(loc2)
		{
			this.owner.onGifts(this,loc2);
		};
		if(dofus.Constants.DOUBLEFRAMERATE)
		{
			loc2.load(this.api.lang.getConfigText("GIFTS_LINK_DOUBLEFRAMERATE"));
		}
		else
		{
			loc2.load(this.api.lang.getConfigText("GIFTS_LINK"));
		}
	}
	function loadFlags()
	{
		var ref = this;
		var loc5 = _global.CONFIG.languages;
		var loc6 = 0;
		while(loc6 < loc5.length)
		{
			var loc7 = loc5[loc6];
			var loc8 = this.attachMovie("UI_LoginLanguage" + loc7.toUpperCase(),"_mcFlag" + loc7.toUpperCase(),this.getNextHighestDepth());
			if(loc2 == undefined)
			{
				var loc4 = (this._mcBgFlags._width - loc5.length * loc8._width) / (loc5.length + 1);
				var loc2 = this._mcBgFlags._x + loc4;
				var loc3 = this._mcBgFlags._y + (this._mcBgFlags._height - loc8._height) / 2;
			}
			loc8._x = loc2;
			loc8._y = loc3;
			loc8._visible = false;
			loc8.onRelease = function()
			{
				ref.click({target:this,ref:ref});
			};
			loc8.onRollOver = function()
			{
				ref.over({target:this,ref:ref});
			};
			loc8.onRollOut = function()
			{
				ref.out({target:this,ref:ref});
			};
			var loc9 = this.attachMovie("UI_Login_flagsMask","_mcMask" + loc7.toUpperCase(),this.getNextHighestDepth());
			loc9._x = loc2;
			loc9._y = loc3;
			loc9._visible = true;
			loc2 = loc2 + (loc4 + loc8._width);
			loc6 = loc6 + 1;
		}
	}
	function addListeners()
	{
		this._btnShowLastAlert.addEventListener("click",this);
		var ref = this;
		this._btnDownload.addEventListener("click",this);
		this._btnOK.addEventListener("click",this);
		this._btnCopyrights.addEventListener("click",this);
		this._btnDetails.addEventListener("click",this);
		this._btnMembers.addEventListener("click",this);
		this._btnEvolutions.addEventListener("click",this);
		this._btnServersState.addEventListener("click",this);
		this._btnTestServer.addEventListener("click",this);
		this._btnForget.addEventListener("click",this);
		this._btnBackToNews.addEventListener("click",this);
		this._btnRememberMe.addEventListener("click",this);
		this._mcGoToStatus.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcSubscribe.onPress = function()
		{
			ref.click({target:this});
		};
		this._cbPorts.addEventListener("itemSelected",this);
		this._lstNews.addEventListener("itemSelected",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		this.disableMyFlag();
	}
	function initTexts()
	{
		this._lblAccount.text = this.api.lang.getText("LOGIN_ACCOUNT");
		this._lblPassword.text = this.api.lang.getText("LOGIN_PASSWORD");
		var loc2 = dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + (dofus.Constants.BETAVERSION <= 0?"":" BETA " + dofus.Constants.BETAVERSION);
		var loc3 = String(this.api.lang.getLangVersion());
		this._lblCopyright.text = this.api.lang.getText("COPYRIGHT") + " (" + loc2 + " - " + loc3 + ")";
		this._lblForget.text = this.api.lang.getText("LOGIN_FORGET");
		this._lblDetails.text = this.api.lang.getText("ADVANCED_LOGIN") + " >>";
		this._lblSubscribe.text = this.api.lang.getText("LOGIN_SUBSCRIBE");
		this._btnDownload.label = this.api.lang.getText("LOGIN_DOWNLOAD");
		this._btnMembers.label = this.api.lang.getText("LOGIN_MEMBERS");
		this._btnEvolutions.label = this.api.lang.getText("EVOLUTIONS");
		this._btnServersState.label = this.api.lang.getText("SERVERS_STATES");
		this._btnTestServer.label = dofus.Constants.TEST != true?this.api.lang.getText("TEST_SERVER_ACCESS"):this.api.lang.getText("NORMAL_SERVER_ACCESS");
		if(dofus.Constants.ALPHA)
		{
			this._lblTestServer.text = this.api.lang.getText("ALPHA_BUILD_ALERT");
			this._lblTestServerInfo.text = this.api.lang.getText("ALPHA_BUILD_INFO");
			this._lblTestServerInfo.styleName = "GreenNormalCenterBoldLabel";
		}
		else
		{
			this._lblTestServer.text = this.api.lang.getText("TEST_SERVER_ALERT");
			this._lblTestServerInfo.text = this.api.lang.getText("TEST_SERVER_INFO");
			this._lblTestServerInfo.styleName = "WhiteNormalCenterBoldLabel";
		}
		this._lblServerStatusTitle.text = this.api.lang.getText("SERVERS_STATES");
		this._btnBackToNews.label = this.api.lang.getText("BACK_TO_NEWS");
		this._lblGoToStatus.text = this.api.lang.getText("GO_TO_STATUS");
		this._lblRememberMe.text = this.api.lang.getText("REMEMBER_ME");
		if(_global.CONFIG.isStreaming)
		{
			this._lblAccount.text = this.api.lang.getText("STREAMING_LOGIN_ACCOUNT");
			this._lblRememberMe.text = this.api.lang.getText("STREAMING_REMEMBER_ME");
		}
		var ref = this;
		this._mcNoGiftsBanner._mcPurple.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcNoGiftsBanner._mcPurple.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcNoGiftsBanner._mcEmerald.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcNoGiftsBanner._mcEmerald.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcNoGiftsBanner._mcTurquoise.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcNoGiftsBanner._mcTurquoise.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcNoGiftsBanner._mcEbony.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcNoGiftsBanner._mcEbony.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcNoGiftsBanner._mcIvory.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcNoGiftsBanner._mcIvory.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcNoGiftsBanner._mcOchre.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcNoGiftsBanner._mcOchre.onRollOut = function()
		{
			ref.out({target:this});
		};
		if(this.api.config.isStreaming)
		{
			this._lblDetails._visible = false;
			this._btnDetails._visible = false;
			this._btnRememberMe._x = this._phRememberMe._x + this._btnRememberMe._x - this._lblRememberMe._x;
			this._btnRememberMe._y = this._phRememberMe._y + this._btnRememberMe._y - this._lblRememberMe._y;
			this._lblRememberMe._x = this._phRememberMe._x;
			this._lblRememberMe._y = this._phRememberMe._y;
			this._lblRememberMe._visible = true;
			this._btnRememberMe._visible = true;
		}
	}
	function initInput()
	{
		this._tiAccount.tabIndex = 1;
		this._tiPassword.tabIndex = 2;
		this._btnOK.tabIndex = 3;
		this._tiPassword.password = true;
		var loc2 = false;
		if(dofus.Constants.DEBUG)
		{
			this._tiAccount.restrict = "\\-a-zA-Z0-9|@.";
			this._tiAccount.maxChars = 41;
			var loc3 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).data.loginInfos;
			if(loc3 != undefined)
			{
				this._tiAccount.text = loc3.account;
				this._tiPassword.text = loc3.password;
				loc2 = true;
			}
		}
		else
		{
			this._tiAccount.restrict = "\\-a-zA-Z0-9@.";
			this._tiAccount.maxChars = 20;
		}
		if(!loc2)
		{
			this._tiAccount.setFocus();
		}
		this._mcCaution._visible = !_global.CONFIG.isStreaming;
	}
	function initLanguages()
	{
		var loc2 = new ank.utils.();
		var loc3 = _global.CONFIG.languages;
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			this["_mcFlag" + String(loc3[loc4]).toUpperCase()]._visible = true;
			loc4 = loc4 + 1;
		}
	}
	function showAlert(loc2)
	{
		while(loc2 != undefined)
		{
			var loc3 = loc3 + loc2.toString();
			loc2 = loc2.nextSibling;
		}
		var loc4 = this.gapi.loadUIComponent("AskAlertServer","AskAlertServer",{title:this.api.lang.getText("SERVER_ALERT"),text:loc3,hideNext:this._bHideNext});
		loc4.addEventListener("close",this);
	}
	function fillCommunityID()
	{
		var loc2 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.communityID;
		var loc3 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.detectedCountry;
		if(_root.htmlLang != undefined)
		{
			loc2 = this.getCommunityFromCountry(_root.htmlLang);
			loc3 = _root.htmlLang;
		}
		if(loc2 != undefined && (!_global.isNaN(loc2) && loc2 > -1))
		{
			this.api.datacenter.Basics.aks_community_id = loc2;
			this.api.datacenter.Basics.aks_detected_country = loc3;
			this.updateFromCommunity();
		}
		else
		{
			var loc4 = this.api.lang.getConfigText("DEFAULT_COMMUNITY");
			var loc5 = loc4.split(",");
			if(loc5[0] == "??" || (loc5[1] == "?" || (loc5 == undefined || (loc5[0] == undefined || (loc5[1] == undefined || _global.isNaN(loc5[1]))))))
			{
				var ref = this;
				this._lvCountry = new LoadVars();
				this._lvCountry.onLoad = function(loc2)
				{
					ref.onCountryLoad(loc2);
				};
				this._lvCountry.load(this.api.lang.getConfigText("IP2COUNTRY_LINK"));
			}
			else
			{
				this.api.datacenter.Basics.aks_community_id = Number(loc5[1]);
				this.api.datacenter.Basics.aks_detected_country = loc5[0];
				this.updateFromCommunity();
			}
		}
	}
	function updateFromCommunity()
	{
		this.addToQueue({object:this,method:this.loadNews});
		this.addToQueue({object:this,method:this.loadGifts});
		this.saveCommunityAndCountry();
		this.initPayingCommunity();
		if(_global.CONFIG.isStreaming)
		{
			this._btnMembers._visible = false;
			this._mcMembersBackground._visible = false;
			this.api.datacenter.Basics.aks_is_free_community = true;
		}
		this.disableMyFlag();
	}
	function disableMyFlag()
	{
		if(this.api.datacenter.Basics.aks_community_id == undefined || _global.isNaN(this.api.datacenter.Basics.aks_community_id))
		{
			return undefined;
		}
		if((var loc0 = this.api.datacenter.Basics.aks_community_id) !== 0)
		{
			switch(null)
			{
				case 1:
					this._mcFlagUK.onRelease = undefined;
					this._mcFlagUK.onRollOver = undefined;
					this._mcFlagUK.onRollOut = undefined;
					break;
				case 2:
					this._mcFlagEN.onRelease = undefined;
					this._mcFlagEN.onRollOver = undefined;
					this._mcFlagEN.onRollOut = undefined;
					break;
				case 3:
					this._mcFlagDE.onRelease = undefined;
					this._mcFlagDE.onRollOver = undefined;
					this._mcFlagDE.onRollOut = undefined;
					break;
				case 4:
					this._mcFlagES.onRelease = undefined;
					this._mcFlagES.onRollOver = undefined;
					this._mcFlagES.onRollOut = undefined;
					break;
				case 5:
					this._mcFlagRU.onRelease = undefined;
					this._mcFlagRU.onRollOver = undefined;
					this._mcFlagRU.onRollOut = undefined;
					break;
				default:
					switch(null)
					{
						case 6:
							this._mcFlagPT.onRelease = undefined;
							this._mcFlagPT.onRollOver = undefined;
							this._mcFlagPT.onRollOut = undefined;
							break;
						case 7:
							this._mcFlagNL.onRelease = undefined;
							this._mcFlagNL.onRollOver = undefined;
							this._mcFlagNL.onRollOut = undefined;
							break;
						case 9:
							this._mcFlagIT.onRelease = undefined;
							this._mcFlagIT.onRollOver = undefined;
							this._mcFlagIT.onRollOut = undefined;
					}
			}
		}
		else
		{
			this._mcFlagFR.onRelease = undefined;
			this._mcFlagFR.onRollOver = undefined;
			this._mcFlagFR.onRollOut = undefined;
		}
	}
	function saveCommunityAndCountry()
	{
		_global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.communityID = this.api.datacenter.Basics.aks_community_id;
		_global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.detectedCountry = this.api.datacenter.Basics.aks_detected_country;
	}
	function showServerStatus()
	{
		this._mcBgServerStatus._visible = true;
		this._mcServerStateBackground._visible = true;
		this._lblServerStatusTitle._visible = true;
		this._taServerStatus._visible = true;
		this._btnBackToNews._visible = true;
		this._lstNews._visible = false;
		this._mcGoToStatus._visible = false;
		this._lblGoToStatus._visible = false;
	}
	function hideServerStatus()
	{
		this._mcBgServerStatus._visible = false;
		this._mcServerStateBackground._visible = false;
		this._lblServerStatusTitle._visible = false;
		this._taServerStatus._visible = false;
		this._btnBackToNews._visible = false;
		this._lstNews._visible = true;
		if(this._bGoToStatusIsShown)
		{
			this.showGoToStatus();
		}
	}
	function showGoToStatus()
	{
		if(!this.api.lang.getConfigText("ENABLE_SERVER_STATUS"))
		{
			return undefined;
		}
		this._bGoToStatusIsShown = true;
		this._mcGoToStatus._visible = true;
		this._lblGoToStatus._visible = true;
	}
	function hideGoToStatus()
	{
		this._bGoToStatusIsShown = false;
		this._mcGoToStatus._visible = false;
		this._lblGoToStatus._visible = false;
	}
	function showLastAlertButton(loc2)
	{
		this._btnShowLastAlert._visible = loc2;
		this._mcCaution._visible = loc2;
	}
	function switchLanguage(loc2)
	{
		this.api.config.language = loc2;
		this.api.kernel.clearCache();
	}
	function constructPortsList()
	{
		var loc2 = this.api.lang.getConfigText("SERVER_PORT");
		var loc3 = new ank.utils.();
		var loc4 = 0;
		while(loc4 < loc2.length)
		{
			if(!this.api.config.isStreaming || Number(loc2[loc4]) > 1024)
			{
				loc3.push({label:this.api.lang.getText("SERVER_PORT") + " : " + loc2[loc4],data:loc2[loc4]});
			}
			loc4 = loc4 + 1;
		}
		this._cbPorts.dataProvider = loc3;
		if(!this.api.config.isStreaming || Number(loc2[this.api.kernel.OptionsManager.getOption("ServerPortIndex")]) > 1024)
		{
			this._cbPorts.selectedIndex = this.api.kernel.OptionsManager.getOption("ServerPortIndex");
			this._nServerPort = loc2[this.api.kernel.OptionsManager.getOption("ServerPortIndex")];
		}
		else
		{
			var loc5 = -1;
			var loc6 = 0;
			while(loc6 < loc2.length)
			{
				if(Number(loc2[loc6]) > 1024)
				{
					loc5 = loc6;
				}
				loc6 = loc6 + 1;
			}
			if(loc5 < 0)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_NO_PORT_AVAILABLE_BEYOND_1024"),"ERROR_BOX");
				return undefined;
			}
			this._cbPorts.selectedIndex = loc5;
			this._nServerPort = loc2[loc5];
			this.api.kernel.OptionsManager.setOption("ServerPortIndex",loc5);
		}
	}
	function getCommunityFromCountry(loc2)
	{
		var loc3 = this.api.lang.getServerCommunities();
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = loc3[loc4].c;
			var loc6 = 0;
			while(loc6 < loc5.length)
			{
				if(loc5[loc6] == loc2)
				{
					return loc3[loc4].i;
				}
				loc6 = loc6 + 1;
			}
			loc4 = loc4 + 1;
		}
		return -1;
	}
	function onShortcut(loc2)
	{
		var loc3 = this.api.ui.getUIComponent("ChooseNickName");
		var loc4 = this.api.ui.getUIComponent("AskOkOnLogin");
		if(loc2 == "ACCEPT_CURRENT_DIALOG" && (Selection.getFocus() != undefined && (loc3 == undefined && loc4 == undefined || loc3 == null && loc4 == null)))
		{
			this.onLogin(this._tiAccount.text,this._tiPassword.text);
			return false;
		}
		return true;
	}
	function onAlertLoad(loc2)
	{
		if(loc2)
		{
			this._sAlertID = this._xAlert.firstChild.attributes.id;
			var loc3 = String(this._xAlert.firstChild.attributes.ignoreVersion).split("|");
			this._bHideNext = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).data.lastAlertID == this._sAlertID;
			if(!this._bHideNext)
			{
				var loc4 = dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
				var loc5 = true;
				var loc6 = 0;
				while(loc6 < loc3.length)
				{
					if(loc3[loc6] == loc4 || loc3[loc6] == "*")
					{
						loc5 = false;
					}
					loc6 = loc6 + 1;
				}
				if(loc5)
				{
					this.addToQueue({object:this,method:this.showAlert,params:[this._xAlert.firstChild.firstChild]});
				}
			}
			this.showLastAlertButton(true);
		}
	}
	function itemSelected(loc2)
	{
		switch(loc2.target._name)
		{
			case "_cbPorts":
				var loc3 = this._cbPorts.selectedItem;
				this._nServerPort = loc3.data;
				this.api.kernel.OptionsManager.setOption("ServerPortIndex",this._cbPorts.selectedIndex);
				break;
			case "_lstNews":
				var loc4 = (ank.utils.rss.RSSItem)loc2.row.item;
				this.getURL(loc4.getLink(),"_blank");
		}
	}
	function onLogin(loc2, loc3)
	{
		if(!dofus.Constants.DEBUG && this._tiPassword.text != undefined)
		{
			this._tiPassword.text = "";
		}
		if(loc2 == undefined)
		{
			return undefined;
		}
		if(loc3 == undefined)
		{
			return undefined;
		}
		if(loc2.length == 0)
		{
			return undefined;
		}
		if(loc3.length == 0)
		{
			return undefined;
		}
		if(dofus.Constants.DEBUG)
		{
			var loc4 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
			loc4.data.loginInfos = {account:loc2,password:loc3};
			loc4.close();
		}
		else if(this.api.kernel.OptionsManager.getOption("RememberAccountName"))
		{
			this.api.kernel.OptionsManager.setOption("LastAccountNameUsed",loc2);
		}
		this.api.datacenter.Player.login = loc2;
		this.api.datacenter.Player.password = loc3;
		if(this._nServerPort == undefined)
		{
			this._nServerPort = this.api.lang.getConfigText("SERVER_PORT")[0];
		}
		if(_global.CONFIG.connexionServer != undefined)
		{
			this._nServerPort = _global.CONFIG.connexionServer.port;
			this._sServerIP = _global.CONFIG.connexionServer.ip;
		}
		if(this._sServerIP == undefined)
		{
			var loc5 = this.api.lang.getConfigText("SERVER_NAME");
			var loc6 = new ank.utils.();
			var loc7 = Math.floor(Math.random() * loc5.length);
			var loc8 = 0;
			while(loc8 < loc5.length)
			{
				loc6.push(loc5[(loc7 + loc8) % loc5.length]);
				loc8 = loc8 + 1;
			}
			this.api.datacenter.Basics.aks_connection_server = loc6;
			this._sServerIP = String(loc6.shift());
		}
		this.api.datacenter.Basics.aks_connection_server_port = this._nServerPort;
		_global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.lastServerName = this._sServerName;
		if(dofus.Constants.DEBUG)
		{
			this._lblConnect.text = this._sServerIP + " : " + this._nServerPort;
		}
		if(this._sServerIP == undefined || this._nServerPort == undefined)
		{
			var loc9 = this.api.lang.getText("NO_SERVER_ADDRESS");
			this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"),loc9 != undefined?loc9:"Erreur interne\nContacte l\'équipe Dofus","ERROR_BOX",{name:"OnLogin"});
		}
		else
		{
			this.api.network.connect(this._sServerIP,this._nServerPort);
			this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("CONNECTING")},{bAlwaysOnTop:true,bForceLoad:true});
		}
	}
	function close(loc2)
	{
		this._bHideNext = loc2.hideNext;
		var loc3 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
		loc3.data.lastAlertID = !loc2.hideNext?undefined:this._sAlertID;
		loc3.flush();
		this._tiAccount.tabEnabled = true;
		this._tiPassword.tabEnabled = true;
		this._btnOK.tabEnabled = true;
	}
	function click(loc2)
	{
		loop0:
		switch(loc2.target._name)
		{
			case "_btnShowLastAlert":
				this.showAlert(this._xAlert.firstChild.firstChild);
				break;
			case "_btnDownload":
				this.getURL(this.api.lang.getConfigText("DOWNLOAD_LINK"),"_blank");
				break;
			default:
				switch(null)
				{
					case "_btnCopyrights":
						this.getURL(this.api.lang.getConfigText("ANKAMA_LINK"),"_blank");
						break loop0;
					case "_btnOK":
						this.onLogin(this._tiAccount.text,this._tiPassword.text);
						break loop0;
					case "_mcSubscribe":
						if(getTimer() - this._nLastRegisterTime < 1000)
						{
							return undefined;
						}
						this._nLastRegisterTime = getTimer();
						if(this.api.lang.getConfigText("REGISTER_INGAME"))
						{
							this._tiAccount.tabEnabled = false;
							this._tiPassword.tabEnabled = false;
							this._btnOK.tabEnabled = false;
							var loc3 = this.gapi.loadUIComponent("Register","Register");
							var loc4 = (dofus.graphics.gapi.ui.Register)loc3;
							loc4.addEventListener("close",this);
						}
						else if(this.api.config.isStreaming)
						{
							this.getURL("javascript:openLink(\'" + this.api.lang.getConfigText("REGISTER_POPUP_LINK") + "\')");
						}
						else
						{
							this.getURL(this.api.lang.getConfigText("REGISTER_POPUP_LINK"),"_blank");
						}
						break loop0;
					case "_btnForget":
						if(!this.api.config.isStreaming)
						{
							this.getURL(this.api.lang.getConfigText("FORGET_LINK"),"_blank");
						}
						else
						{
							this.getURL("javascript:OpenPopUpRecoverPassword()");
						}
						break loop0;
					case "_btnMembers":
						this.getURL(this.api.lang.getConfigText("MEMBERS_LINK"),"_blank");
						break loop0;
					default:
						switch(null)
						{
							case "_btnDetails":
								if(this._btnDetails.selected)
								{
									this._aOldFlagsState = [this._mcFlagFR._visible,this._mcFlagEN._visible,this._mcFlagUK._visible,this._mcFlagDE._visible,this._mcFlagES._visible,this._mcFlagRU._visible,this._mcFlagPT._visible,this._mcFlagNL._visible,false,this._mcFlagIT._visible];
									this._mcFlagFR._visible = false;
									this._mcFlagEN._visible = false;
									this._mcFlagUK._visible = false;
									this._mcFlagDE._visible = false;
									this._mcFlagES._visible = false;
									this._mcFlagRU._visible = false;
									this._mcFlagPT._visible = false;
									this._mcFlagNL._visible = false;
									this._mcFlagIT._visible = false;
									this._mcMaskFR._visible = false;
									this._mcMaskEN._visible = false;
									this._mcMaskUK._visible = false;
									this._mcMaskDE._visible = false;
									this._mcMaskES._visible = false;
									this._mcMaskRU._visible = false;
									this._mcMaskPT._visible = false;
									this._mcMaskNL._visible = false;
									this._mcMaskIT._visible = false;
								}
								else
								{
									this._mcFlagFR._visible = this._aOldFlagsState[0] === true;
									this._mcFlagEN._visible = this._aOldFlagsState[1] === true;
									this._mcFlagUK._visible = this._aOldFlagsState[2] === true;
									this._mcFlagDE._visible = this._aOldFlagsState[3] === true;
									this._mcFlagES._visible = this._aOldFlagsState[4] === true;
									this._mcFlagRU._visible = this._aOldFlagsState[5] === true;
									this._mcFlagPT._visible = this._aOldFlagsState[6] === true;
									this._mcFlagNL._visible = this._aOldFlagsState[7] === true;
									this._mcFlagIT._visible = this._aOldFlagsState[9] === true;
									this._mcMaskFR._visible = this.api.datacenter.Basics.aks_community_id != 0;
									this._mcMaskEN._visible = this.api.datacenter.Basics.aks_community_id != 2;
									this._mcMaskUK._visible = this.api.datacenter.Basics.aks_community_id != 1;
									this._mcMaskDE._visible = this.api.datacenter.Basics.aks_community_id != 3;
									this._mcMaskES._visible = this.api.datacenter.Basics.aks_community_id != 4;
									this._mcMaskRU._visible = this.api.datacenter.Basics.aks_community_id != 5;
									this._mcMaskPT._visible = this.api.datacenter.Basics.aks_community_id != 6;
									this._mcMaskNL._visible = this.api.datacenter.Basics.aks_community_id != 7;
									this._mcMaskIT._visible = this.api.datacenter.Basics.aks_community_id != 9;
								}
								this._mcAdvancedBack._y = this._mcAdvancedBack._y + (!this._btnDetails.selected?-30:30);
								this._lblRememberMe._visible = this._btnDetails.selected;
								this._btnRememberMe._visible = this._btnDetails.selected;
								this._mcAdvancedBackground._visible = this._btnDetails.selected;
								this._cbPorts._visible = this._btnDetails.selected;
								this._btnTestServer._visible = !dofus.Constants.TEST?this._btnDetails.selected && (this.api.lang.getConfigText("TEST_SERVER_ACCESS") && !this.api.config.isStreaming):true;
								this._lblDetails.text = !this._btnDetails.selected?this.api.lang.getText("ADVANCED_LOGIN") + " >>":"<< " + this.api.lang.getText("ADVANCED_LOGIN");
								break loop0;
							case "_btnEvolutions":
								var loc5 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
								loc5.data.forumEvolutions = this._nForumEvolutionsPostCount;
								loc5.flush();
								this._mcEvolutionsHighlight._visible = false;
								this._mcEvolutionsHighlight.gotoAndStop(1);
								this.getURL(this.api.lang.getConfigText("FORUM_EVOLUTIONS_LAST_POST"),"_blank");
								break loop0;
							case "_btnServersState":
								var loc6 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
								loc6.data.forumServersState = this._nForumServersStatePostCount;
								loc6.flush();
								this._mcServersStateHighlight._visible = false;
								this._mcServersStateHighlight.gotoAndStop(1);
								this.getURL(this.api.lang.getConfigText("FORUM_SERVERS_STATE_LAST_POST"),"_blank");
								break loop0;
							case "_btnTestServer":
								dofus.Constants.TEST = !dofus.Constants.TEST;
								this._visible = false;
								_root._loader.reboot();
								break loop0;
							case "_btnBackToNews":
								this.hideServerStatus();
								break loop0;
							default:
								switch(null)
								{
									case "_mcGoToStatus":
										this.showServerStatus();
										break loop0;
									case "_btnRememberMe":
										this.api.kernel.OptionsManager.setOption("RememberAccountName",loc2.target.selected);
										break loop0;
									default:
										if(String(loc2.target._name).substring(0,7) == "_mcFlag")
										{
											var loc7 = String(loc2.target._name).substr(7,2).toLowerCase();
											if(this.api.config.isStreaming)
											{
												getURL("FSCommand:" add "language",loc7);
											}
											else
											{
												switch(loc7)
												{
													case "en":
														this.switchLanguage("en");
														this.api.datacenter.Basics.aks_detected_country = loc7.toUpperCase();
														this.api.datacenter.Basics.aks_community_id = 2;
														this.saveCommunityAndCountry();
														break;
													case "uk":
														this.switchLanguage("en");
														this.api.datacenter.Basics.aks_detected_country = "UK";
														this.api.datacenter.Basics.aks_community_id = 1;
														this.saveCommunityAndCountry();
														break;
													default:
														this.switchLanguage(loc7);
														this.api.datacenter.Basics.aks_detected_country = loc7.toUpperCase();
														this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(loc7.toUpperCase());
														this.saveCommunityAndCountry();
												}
											}
											break loop0;
										}
										var loc8 = loc2.target.params.url;
										if(loc8 != undefined && loc8 != "")
										{
											this.getURL(loc8,"_blank");
											break loop0;
										}
										break loop0;
								}
						}
				}
		}
	}
	function onRSSLoadError(loc2)
	{
		ank.utils.Logger.err("Impossible de charger le fichier RSS");
	}
	function onBadRSSFile(loc2)
	{
		ank.utils.Logger.err("Fichier RSS invalide");
	}
	function onRSSLoaded(loc2)
	{
		var loc3 = (ank.utils.rss.RSSLoader)loc2.target;
		var loc4 = new ank.utils.();
		loc4.createFromArray(loc3.getChannels()[0].getItems());
		this._lstNews.dataProvider = loc4;
	}
	function onGifts(loc2, loc3)
	{
		var loc4 = 0;
		if(loc3 && !_global.CONFIG.isStreaming)
		{
			var loc5 = this.createEmptyMovieClip("_mcMaskGift",this.getNextHighestDepth());
			with(loc5)
			{
				beginFill(0,100)
				moveTo(43,400)
				lineTo(703,400)
				lineTo(703,500)
				lineTo(43,500)
				lineTo(43,400)
				
			};
			this._mcGifts.setMask(loc5);
			loc4 = Number(loc2.c);
			this._aGiftsURLs = new ank.utils.();
			var loc6 = 1;
			while(loc6 <= loc4)
			{
				var loc7 = (ank.gapi.controls.Button)this._mcGifts.attachMovie("Button","btn" + loc6,loc6,{_x:(loc6 - 1) * 131,_width:110,_height:92,backgroundDown:"ButtonTransparentUp",backgroundUp:"ButtonTransparentUp",styleName:"none"});
				loc7.addEventListener("over",this);
				loc7.addEventListener("out",this);
				loc7.addEventListener("click",this);
				loc7.params = {description:loc2["d" + loc6],url:loc2["u" + loc6]};
				this._aGiftsURLs.push({id:loc6,url:loc2["g" + loc6]});
				var loc8 = (ank.gapi.controls.Loader)this._mcGifts.attachMovie("Loader","ldr" + loc6,loc6 + 100,{_x:(loc6 - 1) * 131,_width:110,_height:92});
				loc8.addEventListener("error",this);
				loc8.contentPath = dofus.Constants.GIFTS_PATH + loc2["g" + loc6];
				loc6 = loc6 + 1;
			}
			if(loc4 > 5)
			{
				this._mcArrowRight.gotoAndPlay("on");
			}
		}
		if(loc4 == 0 || !loc3)
		{
			this._mcArrowLeft._visible = false;
			this._mcArrowRight._visible = false;
			this._mcNoGiftsBanner._visible = true;
		}
	}
	function onEnterFrame()
	{
		if(this._ymouse > 400 && this._ymouse < 500)
		{
			var loc2 = 742 / 2 - this._xmouse;
			if(Math.abs(loc2) > 300)
			{
				var loc3 = this._mcGifts._x + loc2 / 40;
				if(loc2 > 0)
				{
					if(loc3 > 55)
					{
						this._mcGifts._x = 55;
						this._mcArrowLeft.gotoAndStop("off");
						if(this._mcArrowRight._currentframe == 1)
						{
							this._mcArrowRight.gotoAndPlay("on");
						}
					}
					else
					{
						this._mcGifts._x = loc3;
						if(this._mcArrowLeft._currentframe == 1)
						{
							this._mcArrowLeft.gotoAndPlay("on");
						}
						if(this._mcArrowRight._currentframe == 1)
						{
							this._mcArrowRight.gotoAndPlay("on");
						}
					}
				}
				else if(loc3 + this._mcGifts._width < 690)
				{
					this._mcGifts._x = 690 - this._mcGifts._width;
					this._mcArrowRight.gotoAndStop("off");
					if(this._mcArrowLeft._currentframe == 1)
					{
						this._mcArrowLeft.gotoAndPlay("on");
					}
				}
				else
				{
					this._mcGifts._x = loc3;
					if(this._mcArrowLeft._currentframe == 1)
					{
						this._mcArrowLeft.gotoAndPlay("on");
					}
					if(this._mcArrowRight._currentframe == 1)
					{
						this._mcArrowRight.gotoAndPlay("on");
					}
				}
			}
		}
	}
	function over(loc2)
	{
		loop0:
		switch(loc2.target._name)
		{
			case "_mcPurple":
				this.gapi.showTooltip(this.api.lang.getText("PURPLE_DOFUS"),loc2.target,-50);
				break;
			case "_mcEmerald":
				this.gapi.showTooltip(this.api.lang.getText("EMERALD_DOFUS"),loc2.target,-50);
				break;
			case "_mcTurquoise":
				this.gapi.showTooltip(this.api.lang.getText("TURQUOISE_DOFUS"),loc2.target,-50);
				break;
			default:
				switch(null)
				{
					case "_mcEbony":
						this.gapi.showTooltip(this.api.lang.getText("EBONY_DOFUS"),loc2.target,-50);
						break loop0;
					case "_mcIvory":
						this.gapi.showTooltip(this.api.lang.getText("IVORY_DOFUS"),loc2.target,-50);
						break loop0;
					case "_mcOchre":
						this.gapi.showTooltip(this.api.lang.getText("OCHRE_DOFUS"),loc2.target,-50);
						break loop0;
					default:
						if(String(loc2.target._name).substring(0,7) == "_mcFlag")
						{
							var loc3 = String(loc2.target._name).substr(7,2);
							var loc4 = this.api.lang.getText("LANGUAGE_" + loc3);
							this.gapi.showTooltip(loc4,this["_mcMask" + loc3],-20);
							break loop0;
						}
						this.gapi.showTooltip(loc2.target.params.description,loc2.target,-40);
						break loop0;
				}
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
	function onEvolutionsPostCount(loc2)
	{
		var loc3 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
		this._nForumEvolutionsPostCount = Number(loc2.c);
		var loc4 = loc3.data.forumEvolutions;
		if(this._nForumEvolutionsPostCount > loc4 || loc4 == undefined)
		{
			this._mcEvolutionsHighlight._visible = true;
			this._mcEvolutionsHighlight.play();
		}
	}
	function onServersStatePostCount(loc2)
	{
		var loc3 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
		this._nForumServersStatePostCount = Number(loc2.c);
		var loc4 = loc3.data.forumServersState;
		if(this._nForumServersStatePostCount > loc4 || loc4 == undefined)
		{
			this._mcServersStateHighlight._visible = true;
			this._mcServersStateHighlight.play();
		}
	}
	function onData()
	{
		var loc2 = "<font color=\"#EBE3CB\">";
		var loc3 = 0;
		while(loc3 < this._siServerStatus.problems.length)
		{
			var loc4 = this._siServerStatus.problems[loc3];
			loc2 = loc2 + (loc4.date + "\n");
			loc2 = loc2 + (" <b>" + loc4.type + "</b>\n");
			loc2 = loc2 + (" <i>" + this.api.lang.getText("STATE_WORD") + "</i>: " + loc4.status + "\n");
			loc2 = loc2 + (" <i>" + this.api.lang.getText("INVOLVED_SERVERS") + "</i>: " + loc4.servers.join(", ") + "\n");
			loc2 = loc2 + (" <i>" + this.api.lang.getText("HISTORY_WORD") + "</i>:\n");
			var loc5 = 0;
			while(loc5 < loc4.history.length)
			{
				loc2 = loc2 + ("  <b>" + loc4.history[loc5].hour + "</b>");
				if(loc4.history[loc5].title != "undefined")
				{
					loc2 = loc2 + (" : " + loc4.history[loc5].title + "\n   ");
				}
				else
				{
					loc2 = loc2 + " - ";
				}
				if(loc4.history[loc5].content != undefined)
				{
					loc2 = loc2 + loc4.history[loc5].content;
					if(!loc4.history[loc5].translated)
					{
						loc2 = loc2 + this.api.lang.getText("TRANSLATION_IN_PROGRESS");
					}
				}
				loc2 = loc2 + "\n";
				loc5 = loc5 + 1;
			}
			loc2 = loc2 + "\n";
			loc3 = loc3 + 1;
		}
		loc2 = loc2 + "</font>";
		this._taServerStatus.text = loc2;
		if(this._siServerStatus.isOnFocus)
		{
			this.showServerStatus();
			this._bGoToStatusIsShown = true;
		}
		else if(this._siServerStatus.problems.length > 0)
		{
			this.showGoToStatus();
		}
		else
		{
			this.hideGoToStatus();
		}
	}
	function error(loc2)
	{
		var loc3 = loc2.target._name.substr(3);
		var loc4 = this._aGiftsURLs.findFirstItem("id",loc3).item.url;
		this._mcGifts["ldr" + loc3].removeEventListener("error",this);
		this._mcGifts["ldr" + loc3].contentPath = loc4;
	}
	function onCountryLoad(loc2)
	{
		var loc3 = this._lvCountry.c;
		if(loc2 && loc3.length > 0)
		{
			this.api.datacenter.Basics.aks_detected_country = loc3;
			this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(loc3);
		}
		else
		{
			this.api.datacenter.Basics.aks_detected_country = this.api.config.language.toUpperCase();
			this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(this.api.datacenter.Basics.aks_detected_country);
		}
		this.updateFromCommunity();
	}
}
