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
	function __set__language(var2)
	{
		this._sLanguage = var2;
		return this.__get__language();
	}
	function __set__canAutoLogOn(var2)
	{
		this._bCanAutoLogOn = var2;
		return this.__get__canAutoLogOn();
	}
	function isLoaded()
	{
		return this._bLoaded;
	}
	function onLoaded()
	{
		this._bLoaded = true;
	}
	function autoLogin(var2, var3)
	{
		if(var2 != undefined && (var3 != undefined && (var2 != null && (var3 != null && (var2 != "null" && (var3 != "null" && (var2 != "" && var3 != "")))))))
		{
			this._tiAccount.text = var2;
			this._tiPassword.text = var3;
			if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
			{
				this.getURL("JavaScript:WriteLog(\'AutoLogin;" + var2 + "/" + var3 + "\')");
			}
			delete _root.htmlLogin;
			delete _root.htmlPassword;
			this.click({target:this._btnOK});
			return undefined;
		}
	}
	function zaapAutoLogin(var2)
	{
		if(!this.usingZaapConnect())
		{
			return undefined;
		}
		if(!var2 && getTimer() - this._nLastRegisterTime < 1000)
		{
			return undefined;
		}
		this._nLastRegisterTime = getTimer();
		var var3 = dofus.ZaapConnect.getInstance().consumeAuthToken();
		if(var3 == undefined)
		{
			dofus.ZaapConnect.getInstance().renewAuthKey();
			return undefined;
		}
		var var4 = dofus.ZaapConnect.LOGIN_TOKEN_NAME;
		this.onLogin(var4,var3,true);
	}
	function refreshAutoLoginUi()
	{
		var var2 = this.usingZaapConnect();
		this._btnOK._visible = !var2;
		this._btnForget._visible = !var2;
		this._tiAccount._visible = !var2;
		this._tiPassword._visible = !var2;
		this._lblAccount._visible = !var2;
		this._lblPassword._visible = !var2;
		this._lblForget._visible = !var2;
		this._lblSubscribe._visible = !var2;
		this._mcSubscribe._visible = !var2;
		this._mcPasswordIdentification._visible = !var2;
		this._lblAutoconnect._visible = var2;
		this._mcAutoconnect._visible = var2;
		this._mcCaution._visible = !_global.CONFIG.isStreaming && !var2;
	}
	function usingZaapConnect()
	{
		if(!dofus.ZaapConnect.ENABLED)
		{
			return false;
		}
		var var2 = dofus.ZaapConnect.getInstance();
		return var2 != null && var2.getSessionToken() != null;
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
		if(this.api.lang.getConfigText("ENABLE_ALERTY_LINK"))
		{
			var var2 = this.api.lang.getConfigText("ALERTY_LINK");
			if(var2 != "")
			{
				this._xAlert = new XML();
				this._xAlert.ignoreWhite = true;
				var _owner = this;
				this._xAlert.onLoad = function(var2)
				{
					_owner.onAlertLoad(var2);
				};
				this._xAlert.load(var2);
			}
		}
		this._mcServersStateHighlight._visible = false;
		this._mcServersStateHighlight.gotoAndStop(1);
		this._mcEvolutionsHighlight._visible = false;
		this._mcEvolutionsHighlight.gotoAndStop(1);
		this.addToQueue({object:this,method:this.autoLogin,params:[_root.htmlLogin,_root.htmlPassword]});
		this.addToQueue({object:this,method:this.onLoaded,params:[]});
		if(this._xAlert == undefined)
		{
			this.addToQueue({object:this,method:this.onAlertLoad,params:[false]});
		}
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
		var var2 = this.api.lang.getConfigText("FREE_COMMUNITIES");
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(var2[var3] == this.api.datacenter.Basics.aks_community_id)
			{
				this._btnMembers._visible = false;
				this._mcMembersBackground._visible = false;
				this.api.datacenter.Basics.aks_is_free_community = true;
				return undefined;
			}
			var3 = var3 + 1;
		}
		this.api.datacenter.Basics.aks_is_free_community = dofus.Constants.BETAVERSION <= 0?false:true;
	}
	function loadNews()
	{
		if(this.api.lang.getConfigText("ENABLE_RSS_NEWS"))
		{
			var var2 = new ank.utils.rss.();
			var2.addEventListener("onRSSLoadError",this);
			var2.addEventListener("onBadRSSFile",this);
			var2.addEventListener("onRSSLoaded",this);
			var var3 = this.api.lang.getConfigText("RSS_LINK");
			if(var3 != "")
			{
				var2.load(var3);
			}
		}
	}
	function loadGifts()
	{
		if(!this.api.lang.getConfigText("ENABLE_GIFTS_LINK"))
		{
			this.onGifts(undefined,false);
			return undefined;
		}
		var var2 = new LoadVars();
		var2.owner = this;
		var2.onLoad = function(var2)
		{
			this.owner.onGifts(this,var2);
		};
		if(dofus.Constants.DOUBLEFRAMERATE)
		{
			var2.load(this.api.lang.getConfigText("GIFTS_LINK_DOUBLEFRAMERATE"));
		}
		else
		{
			var2.load(this.api.lang.getConfigText("GIFTS_LINK"));
		}
	}
	function loadFlags()
	{
		var ref = this;
		var var5 = _global.CONFIG.languages;
		var var6 = 0;
		while(var6 < var5.length)
		{
			var var7 = var5[var6];
			var var8 = this.attachMovie("UI_LoginLanguage" + var7.toUpperCase(),"_mcFlag" + var7.toUpperCase(),this.getNextHighestDepth());
			if(var2 == undefined)
			{
				var var4 = (this._mcBgFlags._width - var5.length * var8._width) / (var5.length + 1);
				var var2 = this._mcBgFlags._x + var4;
				var var3 = this._mcBgFlags._y + (this._mcBgFlags._height - var8._height) / 2;
			}
			var8._x = var2;
			var8._y = var3;
			var8._visible = false;
			var8.onRelease = function()
			{
				ref.click({target:this,ref:ref});
			};
			var8.onRollOver = function()
			{
				ref.over({target:this,ref:ref});
			};
			var8.onRollOut = function()
			{
				ref.out({target:this,ref:ref});
			};
			var var9 = this.attachMovie("UI_Login_flagsMask","_mcMask" + var7.toUpperCase(),this.getNextHighestDepth());
			var9._x = var2;
			var9._y = var3;
			var9._visible = true;
			var2 = var2 + (var4 + var8._width);
			var6 = var6 + 1;
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
		this._mcAutoconnect.onPress = function()
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
		var var2 = dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + (dofus.Constants.BETAVERSION <= 0?"":" BETA " + dofus.Constants.BETAVERSION);
		var var3 = String(this.api.lang.getLangVersion());
		this._lblCopyright.text = this.api.lang.getText("COPYRIGHT") + " (" + var2 + " - " + var3 + ")";
		this._lblForget.text = this.api.lang.getText("LOGIN_FORGET");
		this._lblDetails.text = this.api.lang.getText("ADVANCED_LOGIN") + " >>";
		this._lblAutoconnect.text = this.api.lang.getText("LOADER_AUTO_LOGIN");
		this._lblSubscribe.text = this.api.lang.getText("LOGIN_SUBSCRIBE");
		this.refreshAutoLoginUi();
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
		var var2 = false;
		if(dofus.Constants.DEBUG)
		{
			this._tiAccount.restrict = "\\-a-zA-Z0-9|@.";
			this._tiAccount.maxChars = 41;
			var var3 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).data.loginInfos;
			if(var3 != undefined)
			{
				this._tiAccount.text = var3.account;
				this._tiPassword.text = var3.password;
				var2 = true;
			}
		}
		else
		{
			this._tiAccount.restrict = "\\-a-zA-Z0-9@.";
			this._tiAccount.maxChars = 41;
		}
		if(!var2)
		{
			this._tiAccount.setFocus();
		}
	}
	function initLanguages()
	{
		var var2 = new ank.utils.();
		var var3 = _global.CONFIG.languages;
		var var4 = 0;
		while(var4 < var3.length)
		{
			this["_mcFlag" + String(var3[var4]).toUpperCase()]._visible = true;
			var4 = var4 + 1;
		}
	}
	function showAlert(var2)
	{
		while(var2 != undefined)
		{
			var var3 = var3 + var2.toString();
			var2 = var2.nextSibling;
		}
		var var4 = this.gapi.loadUIComponent("AskAlertServer","AskAlertServer",{title:this.api.lang.getText("SERVER_ALERT"),text:var3,hideNext:this._bHideNext});
		var4.addEventListener("close",this);
	}
	function fillCommunityID()
	{
		var var2 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.communityID;
		var var3 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.detectedCountry;
		if(_root.htmlLang != undefined)
		{
			var2 = this.getCommunityFromCountry(_root.htmlLang);
			var3 = _root.htmlLang;
		}
		if(var2 != undefined && (!_global.isNaN(var2) && var2 > -1))
		{
			this.api.datacenter.Basics.aks_community_id = var2;
			this.api.datacenter.Basics.aks_detected_country = var3;
			this.updateFromCommunity();
		}
		else
		{
			var var4 = this.api.lang.getConfigText("DEFAULT_COMMUNITY");
			var var5 = var4.split(",");
			if(var5[0] == "??" || (var5[1] == "?" || (var5 == undefined || (var5[0] == undefined || (var5[1] == undefined || _global.isNaN(var5[1]))))))
			{
				var ref = this;
				this._lvCountry = new LoadVars();
				this._lvCountry.onLoad = function(var2)
				{
					ref.onCountryLoad(var2);
				};
				this._lvCountry.load(this.api.lang.getConfigText("IP2COUNTRY_LINK"));
			}
			else
			{
				this.api.datacenter.Basics.aks_community_id = Number(var5[1]);
				this.api.datacenter.Basics.aks_detected_country = var5[0];
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
		switch(this.api.datacenter.Basics.aks_community_id)
		{
			case 0:
				this._mcFlagFR.onRelease = undefined;
				this._mcFlagFR.onRollOver = undefined;
				this._mcFlagFR.onRollOut = undefined;
				break;
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
			default:
				switch(null)
				{
					case 5:
						this._mcFlagRU.onRelease = undefined;
						this._mcFlagRU.onRollOver = undefined;
						this._mcFlagRU.onRollOut = undefined;
						break;
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
	function showLastAlertButton(var2)
	{
		if(this.usingZaapConnect() && var2)
		{
			return undefined;
		}
		this._btnShowLastAlert._visible = var2;
		this._mcCaution._visible = var2;
	}
	function switchLanguage(var2)
	{
		this.api.config.language = var2;
		this.api.kernel.clearCache();
	}
	function constructPortsList()
	{
		var var2 = this.api.lang.getConfigText("SERVER_PORT");
		var var3 = new ank.utils.();
		var var4 = 0;
		while(var4 < var2.length)
		{
			if(!this.api.config.isStreaming || Number(var2[var4]) > 1024)
			{
				var3.push({label:this.api.lang.getText("SERVER_PORT") + " : " + var2[var4],data:var2[var4]});
			}
			var4 = var4 + 1;
		}
		this._cbPorts.dataProvider = var3;
		if(!this.api.config.isStreaming || Number(var2[this.api.kernel.OptionsManager.getOption("ServerPortIndex")]) > 1024)
		{
			this._cbPorts.selectedIndex = this.api.kernel.OptionsManager.getOption("ServerPortIndex");
			this._nServerPort = var2[this.api.kernel.OptionsManager.getOption("ServerPortIndex")];
		}
		else
		{
			var var5 = -1;
			var var6 = 0;
			while(var6 < var2.length)
			{
				if(Number(var2[var6]) > 1024)
				{
					var5 = var6;
				}
				var6 = var6 + 1;
			}
			if(var5 < 0)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_NO_PORT_AVAILABLE_BEYOND_1024"),"ERROR_BOX");
				return undefined;
			}
			this._cbPorts.selectedIndex = var5;
			this._nServerPort = var2[var5];
			this.api.kernel.OptionsManager.setOption("ServerPortIndex",var5);
		}
	}
	function getCommunityFromCountry(var2)
	{
		var var3 = this.api.lang.getServerCommunities();
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = var3[var4].c;
			var var6 = 0;
			while(var6 < var5.length)
			{
				if(var5[var6] == var2)
				{
					return var3[var4].i;
				}
				var6 = var6 + 1;
			}
			var4 = var4 + 1;
		}
		return -1;
	}
	function onShortcut(var2)
	{
		var var3 = this.api.ui.getUIComponent("ChooseNickName");
		var var4 = this.api.ui.getUIComponent("AskOkOnLogin");
		if(var2 == "ACCEPT_CURRENT_DIALOG" && (Selection.getFocus() != undefined && (var3 == undefined && var4 == undefined || var3 == null && var4 == null)))
		{
			this.onLogin(this._tiAccount.text,this._tiPassword.text);
			return false;
		}
		return true;
	}
	function onAlertLoad(var2)
	{
		var var3 = false;
		if(var2)
		{
			this._sAlertID = this._xAlert.firstChild.attributes.id;
			var var4 = String(this._xAlert.firstChild.attributes.ignoreVersion).split("|");
			this._bHideNext = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).data.lastAlertID == this._sAlertID;
			if(!this._bHideNext)
			{
				var var5 = dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
				var var6 = true;
				var var7 = 0;
				while(var7 < var4.length)
				{
					if(var4[var7] == var5 || var4[var7] == "*")
					{
						var6 = false;
					}
					var7 = var7 + 1;
				}
				var3 = var6;
				if(var6)
				{
					this.addToQueue({object:this,method:this.showAlert,params:[this._xAlert.firstChild.firstChild]});
				}
			}
			this.showLastAlertButton(true);
		}
		if(!var3 && this._bCanAutoLogOn)
		{
			this.zaapAutoLogin(false);
		}
	}
	function itemSelected(var2)
	{
		switch(var2.target._name)
		{
			case "_cbPorts":
				var var3 = this._cbPorts.selectedItem;
				this._nServerPort = var3.data;
				this.api.kernel.OptionsManager.setOption("ServerPortIndex",this._cbPorts.selectedIndex);
				break;
			case "_lstNews":
				var var4 = (ank.utils.rss.RSSItem)var2.row.item;
				this.getURL(var4.getLink(),"_blank");
		}
	}
	function onLogin(var2, var3, var4)
	{
		if(!dofus.Constants.DEBUG && this._tiPassword.text != undefined)
		{
			this._tiPassword.text = "";
		}
		if(var2 == undefined)
		{
			return undefined;
		}
		if(var3 == undefined)
		{
			return undefined;
		}
		if(var2.length == 0)
		{
			return undefined;
		}
		if(var3.length == 0)
		{
			return undefined;
		}
		if(!var4)
		{
			if(dofus.Constants.DEBUG)
			{
				var var5 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
				var5.data.loginInfos = {account:var2,password:var3};
				var5.close();
			}
			else if(this.api.kernel.OptionsManager.getOption("RememberAccountName"))
			{
				this.api.kernel.OptionsManager.setOption("LastAccountNameUsed",var2);
			}
		}
		this.api.datacenter.Player.login = var2;
		if(var4)
		{
			this.api.datacenter.Player.zaapToken = var3;
			this.api.datacenter.Player.password = undefined;
		}
		else
		{
			this.api.datacenter.Player.password = var3;
			this.api.datacenter.Player.zaapToken = undefined;
		}
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
			var var6 = this.api.lang.getConfigText("SERVER_NAME");
			var var7 = new ank.utils.();
			var var8 = Math.floor(Math.random() * var6.length);
			var var9 = 0;
			while(var9 < var6.length)
			{
				var7.push(var6[(var8 + var9) % var6.length]);
				var9 = var9 + 1;
			}
			this.api.datacenter.Basics.aks_connection_server = var7;
			this._sServerIP = String(var7.shift());
		}
		this.api.datacenter.Basics.aks_connection_server_port = this._nServerPort;
		_global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.lastServerName = this._sServerName;
		if(dofus.Constants.DEBUG)
		{
			this._lblConnect.text = this._sServerIP + " : " + this._nServerPort;
		}
		if(this._sServerIP == undefined || this._nServerPort == undefined)
		{
			var var10 = this.api.lang.getText("NO_SERVER_ADDRESS");
			this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"),var10 != undefined?var10:"Erreur interne\nContacte l\'équipe Dofus","ERROR_BOX",{name:"OnLogin"});
		}
		else
		{
			this.api.network.connect(this._sServerIP,this._nServerPort);
			this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("CONNECTING")},{bAlwaysOnTop:true,bForceLoad:true});
		}
	}
	function close(var2)
	{
		this._bHideNext = var2.hideNext;
		var var3 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
		var3.data.lastAlertID = !var2.hideNext?undefined:this._sAlertID;
		var3.flush();
		this._tiAccount.tabEnabled = true;
		this._tiPassword.tabEnabled = true;
		this._btnOK.tabEnabled = true;
	}
	function click(var2)
	{
		loop0:
		switch(var2.target._name)
		{
			case "_btnShowLastAlert":
				this.showAlert(this._xAlert.firstChild.firstChild);
				break;
			case "_btnDownload":
				this.getURL(this.api.lang.getConfigText("DOWNLOAD_LINK"),"_blank");
				break;
			case "_btnCopyrights":
				this.getURL(this.api.lang.getConfigText("ANKAMA_LINK"),"_blank");
				break;
			default:
				switch(null)
				{
					case "_btnOK":
						this.onLogin(this._tiAccount.text,this._tiPassword.text,false);
						break loop0;
					case "_mcAutoconnect":
						if(!this.usingZaapConnect())
						{
							this.refreshAutoLoginUi();
							return undefined;
						}
						this.zaapAutoLogin(false);
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
							var var3 = this.gapi.loadUIComponent("Register","Register");
							var var4 = (dofus.graphics.gapi.ui.Register)var3;
							var4.addEventListener("close",this);
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
								var var5 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
								var5.data.forumEvolutions = this._nForumEvolutionsPostCount;
								var5.flush();
								this._mcEvolutionsHighlight._visible = false;
								this._mcEvolutionsHighlight.gotoAndStop(1);
								this.getURL(this.api.lang.getConfigText("FORUM_EVOLUTIONS_LAST_POST"),"_blank");
								break loop0;
							case "_btnServersState":
								var var6 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
								var6.data.forumServersState = this._nForumServersStatePostCount;
								var6.flush();
								this._mcServersStateHighlight._visible = false;
								this._mcServersStateHighlight.gotoAndStop(1);
								this.getURL(this.api.lang.getConfigText("FORUM_SERVERS_STATE_LAST_POST"),"_blank");
								break loop0;
							case "_btnTestServer":
								dofus.Constants.TEST = !dofus.Constants.TEST;
								this._visible = false;
								_root._loader.reboot();
								break loop0;
							default:
								switch(null)
								{
									case "_btnBackToNews":
										this.hideServerStatus();
										break loop0;
									case "_mcGoToStatus":
										this.showServerStatus();
										break loop0;
									case "_btnRememberMe":
										this.api.kernel.OptionsManager.setOption("RememberAccountName",var2.target.selected);
										break loop0;
									default:
										if(String(var2.target._name).substring(0,7) == "_mcFlag")
										{
											var var7 = String(var2.target._name).substr(7,2).toLowerCase();
											if(this.api.config.isStreaming)
											{
												getURL("FSCommand:" add "language",var7);
											}
											else
											{
												switch(var7)
												{
													case "en":
														this.switchLanguage("en");
														this.api.datacenter.Basics.aks_detected_country = var7.toUpperCase();
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
														this.switchLanguage(var7);
														this.api.datacenter.Basics.aks_detected_country = var7.toUpperCase();
														this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(var7.toUpperCase());
														this.saveCommunityAndCountry();
												}
											}
											break loop0;
										}
										var var8 = var2.target.params.url;
										if(var8 != undefined && var8 != "")
										{
											this.getURL(var8,"_blank");
											break loop0;
										}
										break loop0;
								}
						}
				}
		}
	}
	function onRSSLoadError(var2)
	{
		ank.utils.Logger.err("Impossible de charger le fichier RSS");
	}
	function onBadRSSFile(var2)
	{
		ank.utils.Logger.err("Fichier RSS invalide");
	}
	function onRSSLoaded(var2)
	{
		var var3 = (ank.utils.rss.RSSLoader)var2.target;
		var var4 = new ank.utils.();
		var4.createFromArray(var3.getChannels()[0].getItems());
		this._lstNews.dataProvider = var4;
	}
	function onGifts(var2, var3)
	{
		var var4 = 0;
		if(var3 && !_global.CONFIG.isStreaming)
		{
			var var5 = this.createEmptyMovieClip("_mcMaskGift",this.getNextHighestDepth());
			with(var5)
			{
				beginFill(0,100)
				moveTo(43,400)
				lineTo(703,400)
				lineTo(703,500)
				lineTo(43,500)
				lineTo(43,400)
				
			};
			this._mcGifts.setMask(var5);
			var4 = Number(var2.c);
			this._aGiftsURLs = new ank.utils.();
			var var6 = 1;
			while(var6 <= var4)
			{
				var var7 = (ank.gapi.controls.Button)this._mcGifts.attachMovie("Button","btn" + var6,var6,{_x:(var6 - 1) * 131,_width:110,_height:92,backgroundDown:"ButtonTransparentUp",backgroundUp:"ButtonTransparentUp",styleName:"none"});
				var7.addEventListener("over",this);
				var7.addEventListener("out",this);
				var7.addEventListener("click",this);
				var7.params = {description:var2["d" + var6],url:var2["u" + var6]};
				this._aGiftsURLs.push({id:var6,url:var2["g" + var6]});
				var var8 = (ank.gapi.controls.Loader)this._mcGifts.attachMovie("Loader","ldr" + var6,var6 + 100,{_x:(var6 - 1) * 131,_width:110,_height:92});
				var8.addEventListener("error",this);
				var8.contentPath = dofus.Constants.GIFTS_PATH + var2["g" + var6];
				var6 = var6 + 1;
			}
			if(var4 > 5)
			{
				this._mcArrowRight.gotoAndPlay("on");
			}
		}
		if(var4 == 0 || !var3)
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
			var var2 = 742 / 2 - this._xmouse;
			if(Math.abs(var2) > 300)
			{
				var var3 = this._mcGifts._x + var2 / 40;
				if(var2 > 0)
				{
					if(var3 > 55)
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
						this._mcGifts._x = var3;
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
				else if(var3 + this._mcGifts._width < 690)
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
					this._mcGifts._x = var3;
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
	function over(var2)
	{
		loop0:
		switch(var2.target._name)
		{
			case "_mcPurple":
				this.gapi.showTooltip(this.api.lang.getText("PURPLE_DOFUS"),var2.target,-50);
				break;
			case "_mcEmerald":
				this.gapi.showTooltip(this.api.lang.getText("EMERALD_DOFUS"),var2.target,-50);
				break;
			default:
				switch(null)
				{
					case "_mcTurquoise":
						this.gapi.showTooltip(this.api.lang.getText("TURQUOISE_DOFUS"),var2.target,-50);
						break loop0;
					case "_mcEbony":
						this.gapi.showTooltip(this.api.lang.getText("EBONY_DOFUS"),var2.target,-50);
						break loop0;
					case "_mcIvory":
						this.gapi.showTooltip(this.api.lang.getText("IVORY_DOFUS"),var2.target,-50);
						break loop0;
					case "_mcOchre":
						this.gapi.showTooltip(this.api.lang.getText("OCHRE_DOFUS"),var2.target,-50);
						break loop0;
					default:
						if(String(var2.target._name).substring(0,7) == "_mcFlag")
						{
							var var3 = String(var2.target._name).substr(7,2);
							var var4 = this.api.lang.getText("LANGUAGE_" + var3);
							this.gapi.showTooltip(var4,this["_mcMask" + var3],-20);
							break loop0;
						}
						this.gapi.showTooltip(var2.target.params.description,var2.target,-40);
						break loop0;
				}
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function onEvolutionsPostCount(var2)
	{
		var var3 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
		this._nForumEvolutionsPostCount = Number(var2.c);
		var var4 = var3.data.forumEvolutions;
		if(this._nForumEvolutionsPostCount > var4 || var4 == undefined)
		{
			this._mcEvolutionsHighlight._visible = true;
			this._mcEvolutionsHighlight.play();
		}
	}
	function onServersStatePostCount(var2)
	{
		var var3 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
		this._nForumServersStatePostCount = Number(var2.c);
		var var4 = var3.data.forumServersState;
		if(this._nForumServersStatePostCount > var4 || var4 == undefined)
		{
			this._mcServersStateHighlight._visible = true;
			this._mcServersStateHighlight.play();
		}
	}
	function onData()
	{
		var var2 = "<font color=\"#EBE3CB\">";
		var var3 = 0;
		while(var3 < this._siServerStatus.problems.length)
		{
			var var4 = this._siServerStatus.problems[var3];
			var2 = var2 + (var4.date + "\n");
			var2 = var2 + (" <b>" + var4.type + "</b>\n");
			var2 = var2 + (" <i>" + this.api.lang.getText("STATE_WORD") + "</i>: " + var4.status + "\n");
			var2 = var2 + (" <i>" + this.api.lang.getText("INVOLVED_SERVERS") + "</i>: " + var4.servers.join(", ") + "\n");
			var2 = var2 + (" <i>" + this.api.lang.getText("HISTORY_WORD") + "</i>:\n");
			var var5 = 0;
			while(var5 < var4.history.length)
			{
				var2 = var2 + ("  <b>" + var4.history[var5].hour + "</b>");
				if(var4.history[var5].title != "undefined")
				{
					var2 = var2 + (" : " + var4.history[var5].title + "\n   ");
				}
				else
				{
					var2 = var2 + " - ";
				}
				if(var4.history[var5].content != undefined)
				{
					var2 = var2 + var4.history[var5].content;
					if(!var4.history[var5].translated)
					{
						var2 = var2 + this.api.lang.getText("TRANSLATION_IN_PROGRESS");
					}
				}
				var2 = var2 + "\n";
				var5 = var5 + 1;
			}
			var2 = var2 + "\n";
			var3 = var3 + 1;
		}
		var2 = var2 + "</font>";
		this._taServerStatus.text = var2;
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
	function error(var2)
	{
		var var3 = var2.target._name.substr(3);
		var var4 = this._aGiftsURLs.findFirstItem("id",var3).item.url;
		this._mcGifts["ldr" + var3].removeEventListener("error",this);
		this._mcGifts["ldr" + var3].contentPath = var4;
	}
	function onCountryLoad(var2)
	{
		var var3 = this._lvCountry.c;
		if(var2 && var3.length > 0)
		{
			this.api.datacenter.Basics.aks_detected_country = var3;
			this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(var3);
		}
		else
		{
			this.api.datacenter.Basics.aks_detected_country = this.api.config.language.toUpperCase();
			this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(this.api.datacenter.Basics.aks_detected_country);
		}
		this.updateFromCommunity();
	}
}
