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
   function __set__language(sLanguage)
   {
      this._sLanguage = sLanguage;
      return this.__get__language();
   }
   function autoLogin(sLogin, sPass)
   {
      if(sLogin != undefined && (sPass != undefined && (sLogin != null && (sPass != null && (sLogin != "null" && (sPass != "null" && (sLogin != "" && sPass != "")))))))
      {
         this._tiAccount.text = sLogin;
         this._tiPassword.text = sPass;
         if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
         {
            this.getURL("JavaScript:WriteLog(\'AutoLogin;" + sLogin + "/" + sPass + "\')");
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
      this._xAlert.onLoad = function(bSuccess)
      {
         _owner.onAlertLoad(bSuccess);
      };
      this._xAlert.load(this.api.lang.getConfigText("ALERTY_LINK"));
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
      var _loc2_ = this.api.lang.getConfigText("FREE_COMMUNITIES");
      var _loc3_ = 0;
      while(_loc3_ < _loc2_.length)
      {
         if(_loc2_[_loc3_] == this.api.datacenter.Basics.aks_community_id)
         {
            this._btnMembers._visible = false;
            this._mcMembersBackground._visible = false;
            this.api.datacenter.Basics.aks_is_free_community = true;
            return undefined;
         }
         _loc3_ = _loc3_ + 1;
      }
      this.api.datacenter.Basics.aks_is_free_community = dofus.Constants.BETAVERSION <= 0?false:true;
   }
   function loadNews()
   {
      var _loc2_ = new ank.utils.rss.RSSLoader();
      _loc2_.addEventListener("onRSSLoadError",this);
      _loc2_.addEventListener("onBadRSSFile",this);
      _loc2_.addEventListener("onRSSLoaded",this);
      _loc2_.load(this.api.lang.getConfigText("RSS_LINK"));
   }
   function loadGifts()
   {
      var _loc2_ = new LoadVars();
      _loc2_.owner = this;
      _loc2_.onLoad = function(bSuccess)
      {
         this.owner.onGifts(this,bSuccess);
      };
      if(_global.doubleFramerate)
      {
         _loc2_.load(this.api.lang.getConfigText("GIFTS_LINK_DOUBLEFRAMERATE"));
      }
      else
      {
         _loc2_.load(this.api.lang.getConfigText("GIFTS_LINK"));
      }
   }
   function loadFlags()
   {
      var ref = this;
      var _loc5_ = _global.CONFIG.languages;
      var _loc6_ = 0;
      while(_loc6_ < _loc5_.length)
      {
         var _loc7_ = _loc5_[_loc6_];
         var _loc8_ = this.attachMovie("UI_LoginLanguage" + _loc7_.toUpperCase(),"_mcFlag" + _loc7_.toUpperCase(),this.getNextHighestDepth());
         if(_loc2_ == undefined)
         {
            var _loc4_ = (this._mcBgFlags._width - _loc5_.length * _loc8_._width) / (_loc5_.length + 1);
            var _loc2_ = this._mcBgFlags._x + _loc4_;
            var _loc3_ = this._mcBgFlags._y + (this._mcBgFlags._height - _loc8_._height) / 2;
         }
         _loc8_._x = _loc2_;
         _loc8_._y = _loc3_;
         _loc8_._visible = false;
         _loc8_.onRelease = function()
         {
            ref.click({target:this,ref:ref});
         };
         _loc8_.onRollOver = function()
         {
            ref.over({target:this,ref:ref});
         };
         _loc8_.onRollOut = function()
         {
            ref.out({target:this,ref:ref});
         };
         var _loc9_ = this.attachMovie("UI_Login_flagsMask","_mcMask" + _loc7_.toUpperCase(),this.getNextHighestDepth());
         _loc9_._x = _loc2_;
         _loc9_._y = _loc3_;
         _loc9_._visible = true;
         _loc2_ = _loc2_ + (_loc4_ + _loc8_._width);
         _loc6_ = _loc6_ + 1;
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
      var _loc2_ = dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + (dofus.Constants.BETAVERSION <= 0?"":" BETA " + dofus.Constants.BETAVERSION);
      var _loc3_ = String(this.api.lang.getLangVersion());
      this._lblCopyright.text = this.api.lang.getText("COPYRIGHT") + " (" + _loc2_ + " - " + _loc3_ + ")";
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
      var _loc2_ = false;
      if(dofus.Constants.DEBUG)
      {
         this._tiAccount.restrict = "\\-a-zA-Z0-9|";
         this._tiAccount.maxChars = 41;
         var _loc3_ = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).data.loginInfos;
         if(_loc3_ != undefined)
         {
            this._tiAccount.text = _loc3_.account;
            this._tiPassword.text = _loc3_.password;
            _loc2_ = true;
         }
      }
      else
      {
         this._tiAccount.restrict = "\\-a-zA-Z0-9";
         this._tiAccount.maxChars = 20;
      }
      if(!_loc2_)
      {
         this._tiAccount.setFocus();
      }
      this._mcCaution._visible = !_global.CONFIG.isStreaming;
   }
   function initLanguages()
   {
      var _loc2_ = new ank.utils.ExtendedArray();
      var _loc3_ = _global.CONFIG.languages;
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         this["_mcFlag" + String(_loc3_[_loc4_]).toUpperCase()]._visible = true;
         _loc4_ = _loc4_ + 1;
      }
   }
   function showAlert(xNode)
   {
      while(xNode != undefined)
      {
         var _loc3_ = _loc3_ + xNode.toString();
         xNode = xNode.nextSibling;
      }
      var _loc4_ = this.gapi.loadUIComponent("AskAlertServer","AskAlertServer",{title:this.api.lang.getText("SERVER_ALERT"),text:_loc3_,hideNext:this._bHideNext});
      _loc4_.addEventListener("close",this);
   }
   function fillCommunityID()
   {
      var _loc2_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.communityID;
      var _loc3_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.detectedCountry;
      if(_root.htmlLang != undefined)
      {
         _loc2_ = this.getCommunityFromCountry(_root.htmlLang);
         _loc3_ = _root.htmlLang;
      }
      if(_loc2_ != undefined && (!_global.isNaN(_loc2_) && _loc2_ > -1))
      {
         this.api.datacenter.Basics.aks_community_id = _loc2_;
         this.api.datacenter.Basics.aks_detected_country = _loc3_;
         this.updateFromCommunity();
      }
      else
      {
         var _loc4_ = this.api.lang.getConfigText("DEFAULT_COMMUNITY");
         var _loc5_ = _loc4_.split(",");
         if(_loc5_[0] == "??" || (_loc5_[1] == "?" || (_loc5_ == undefined || (_loc5_[0] == undefined || (_loc5_[1] == undefined || _global.isNaN(_loc5_[1]))))))
         {
            var ref = this;
            this._lvCountry = new LoadVars();
            this._lvCountry.onLoad = function(bSuccess)
            {
               ref.onCountryLoad(bSuccess);
            };
            this._lvCountry.load(this.api.lang.getConfigText("IP2COUNTRY_LINK"));
         }
         else
         {
            this.api.datacenter.Basics.aks_community_id = Number(_loc5_[1]);
            this.api.datacenter.Basics.aks_detected_country = _loc5_[0];
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
   function showLastAlertButton(bShow)
   {
      this._btnShowLastAlert._visible = bShow;
      this._mcCaution._visible = bShow;
   }
   function switchLanguage(sLanguage)
   {
      this.api.config.language = sLanguage;
      this.api.kernel.clearCache();
   }
   function constructPortsList()
   {
      var _loc2_ = this.api.lang.getConfigText("SERVER_PORT");
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = 0;
      while(_loc4_ < _loc2_.length)
      {
         if(!this.api.config.isStreaming || Number(_loc2_[_loc4_]) > 1024)
         {
            _loc3_.push({label:this.api.lang.getText("SERVER_PORT") + " : " + _loc2_[_loc4_],data:_loc2_[_loc4_]});
         }
         _loc4_ = _loc4_ + 1;
      }
      this._cbPorts.dataProvider = _loc3_;
      if(!this.api.config.isStreaming || Number(_loc2_[this.api.kernel.OptionsManager.getOption("ServerPortIndex")]) > 1024)
      {
         this._cbPorts.selectedIndex = this.api.kernel.OptionsManager.getOption("ServerPortIndex");
         this._nServerPort = _loc2_[this.api.kernel.OptionsManager.getOption("ServerPortIndex")];
      }
      else
      {
         var _loc5_ = -1;
         var _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            if(Number(_loc2_[_loc6_]) > 1024)
            {
               _loc5_ = _loc6_;
            }
            _loc6_ = _loc6_ + 1;
         }
         if(_loc5_ < 0)
         {
            this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_NO_PORT_AVAILABLE_BEYOND_1024"),"ERROR_BOX");
            return undefined;
         }
         this._cbPorts.selectedIndex = _loc5_;
         this._nServerPort = _loc2_[_loc5_];
         this.api.kernel.OptionsManager.setOption("ServerPortIndex",_loc5_);
      }
   }
   function getCommunityFromCountry(sCountry)
   {
      var _loc3_ = this.api.lang.getServerCommunities();
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = _loc3_[_loc4_].c;
         var _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc5_[_loc6_] == sCountry)
            {
               return _loc3_[_loc4_].i;
            }
            _loc6_ = _loc6_ + 1;
         }
         _loc4_ = _loc4_ + 1;
      }
      return -1;
   }
   function onShortcut(sShortcut)
   {
      var _loc3_ = this.api.ui.getUIComponent("ChooseNickName");
      var _loc4_ = this.api.ui.getUIComponent("AskOkOnLogin");
      if(sShortcut == "ACCEPT_CURRENT_DIALOG" && (Selection.getFocus() != undefined && (_loc3_ == undefined && _loc4_ == undefined || _loc3_ == null && _loc4_ == null)))
      {
         this.onLogin(this._tiAccount.text,this._tiPassword.text);
         return false;
      }
      return true;
   }
   function onAlertLoad(bSuccess)
   {
      if(bSuccess)
      {
         this._sAlertID = this._xAlert.firstChild.attributes.id;
         var _loc3_ = String(this._xAlert.firstChild.attributes.ignoreVersion).split("|");
         this._bHideNext = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).data.lastAlertID == this._sAlertID;
         if(!this._bHideNext)
         {
            var _loc4_ = dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
            var _loc5_ = true;
            var _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               if(_loc3_[_loc6_] == _loc4_ || _loc3_[_loc6_] == "*")
               {
                  _loc5_ = false;
               }
               _loc6_ = _loc6_ + 1;
            }
            if(_loc5_)
            {
               this.addToQueue({object:this,method:this.showAlert,params:[this._xAlert.firstChild.firstChild]});
            }
         }
         this.showLastAlertButton(true);
      }
   }
   function itemSelected(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_cbPorts":
            var _loc3_ = this._cbPorts.selectedItem;
            this._nServerPort = _loc3_.data;
            this.api.kernel.OptionsManager.setOption("ServerPortIndex",this._cbPorts.selectedIndex);
            break;
         case "_lstNews":
            var _loc4_ = (ank.utils.rss.RSSItem)oEvent.row.item;
            this.getURL(_loc4_.getLink(),"_blank");
      }
   }
   function onLogin(sLogin, sPassword)
   {
      if(!dofus.Constants.DEBUG && this._tiPassword.text != undefined)
      {
         this._tiPassword.text = "";
      }
      if(sLogin == undefined)
      {
         return undefined;
      }
      if(sPassword == undefined)
      {
         return undefined;
      }
      if(sLogin.length == 0)
      {
         return undefined;
      }
      if(sPassword.length == 0)
      {
         return undefined;
      }
      if(dofus.Constants.DEBUG)
      {
         var _loc4_ = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
         _loc4_.data.loginInfos = {account:sLogin,password:sPassword};
         _loc4_.close();
      }
      else if(this.api.kernel.OptionsManager.getOption("RememberAccountName"))
      {
         this.api.kernel.OptionsManager.setOption("LastAccountNameUsed",sLogin);
      }
      this.api.datacenter.Player.login = sLogin;
      this.api.datacenter.Player.password = sPassword;
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
         var _loc5_ = this.api.lang.getConfigText("SERVER_NAME");
         var _loc6_ = new ank.utils.ExtendedArray();
         var _loc7_ = Math.floor(Math.random() * _loc5_.length);
         var _loc8_ = 0;
         while(_loc8_ < _loc5_.length)
         {
            _loc6_.push(_loc5_[(_loc7_ + _loc8_) % _loc5_.length]);
            _loc8_ = _loc8_ + 1;
         }
         this.api.datacenter.Basics.aks_connection_server = _loc6_;
         this._sServerIP = String(_loc6_.shift());
      }
      this.api.datacenter.Basics.aks_connection_server_port = this._nServerPort;
      _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.lastServerName = this._sServerName;
      if(dofus.Constants.DEBUG)
      {
         this._lblConnect.text = this._sServerIP + " : " + this._nServerPort;
      }
      if(this._sServerIP == undefined || this._nServerPort == undefined)
      {
         var _loc9_ = this.api.lang.getText("NO_SERVER_ADDRESS");
         this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"),_loc9_ != undefined?_loc9_:"Erreur interne\nContacte l\'équipe Dofus","ERROR_BOX",{name:"OnLogin"});
      }
      else
      {
         this.api.network.connect(this._sServerIP,this._nServerPort);
         this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("CONNECTING")},{bAlwaysOnTop:true,bForceLoad:true});
      }
   }
   function close(oEvent)
   {
      this._bHideNext = oEvent.hideNext;
      var _loc3_ = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
      _loc3_.data.lastAlertID = !oEvent.hideNext?undefined:this._sAlertID;
      _loc3_.flush();
      this._tiAccount.tabEnabled = true;
      this._tiPassword.tabEnabled = true;
      this._btnOK.tabEnabled = true;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
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
         case "_btnOK":
            this.onLogin(this._tiAccount.text,this._tiPassword.text);
            break;
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
               var _loc3_ = this.gapi.loadUIComponent("Register","Register");
               var _loc4_ = (dofus.graphics.gapi.ui.Register)_loc3_;
               _loc4_.addEventListener("close",this);
            }
            else if(this.api.config.isStreaming)
            {
               this.getURL("javascript:openLink(\'" + this.api.lang.getConfigText("REGISTER_POPUP_LINK") + "\')");
            }
            else
            {
               this.getURL(this.api.lang.getConfigText("REGISTER_POPUP_LINK"),"_blank");
            }
            break;
         case "_btnForget":
            if(!this.api.config.isStreaming)
            {
               this.getURL(this.api.lang.getConfigText("FORGET_LINK"),"_blank");
            }
            else
            {
               this.getURL("javascript:OpenPopUpRecoverPassword()");
            }
            break;
         case "_btnMembers":
            this.getURL(this.api.lang.getConfigText("MEMBERS_LINK"),"_blank");
            break;
         case "_btnDetails":
            if(this._btnDetails.selected)
            {
               this._aOldFlagsState = [this._mcFlagFR._visible,this._mcFlagEN._visible,this._mcFlagUK._visible,this._mcFlagDE._visible,this._mcFlagES._visible,this._mcFlagRU._visible,this._mcFlagPT._visible,this._mcFlagNL._visible,false,this._mcFlagIT];
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
            break;
         case "_btnEvolutions":
            var _loc5_ = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
            _loc5_.data.forumEvolutions = this._nForumEvolutionsPostCount;
            _loc5_.flush();
            this._mcEvolutionsHighlight._visible = false;
            this._mcEvolutionsHighlight.gotoAndStop(1);
            this.getURL(this.api.lang.getConfigText("FORUM_EVOLUTIONS_LAST_POST"),"_blank");
            break;
         case "_btnServersState":
            var _loc6_ = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
            _loc6_.data.forumServersState = this._nForumServersStatePostCount;
            _loc6_.flush();
            this._mcServersStateHighlight._visible = false;
            this._mcServersStateHighlight.gotoAndStop(1);
            this.getURL(this.api.lang.getConfigText("FORUM_SERVERS_STATE_LAST_POST"),"_blank");
            break;
         case "_btnTestServer":
            dofus.Constants.TEST = !dofus.Constants.TEST;
            this._visible = false;
            _level0._loader.reboot();
            break;
         case "_btnBackToNews":
            this.hideServerStatus();
            break;
         case "_mcGoToStatus":
            this.showServerStatus();
            break;
         case "_btnRememberMe":
            this.api.kernel.OptionsManager.setOption("RememberAccountName",oEvent.target.selected);
            break;
         default:
            if(String(oEvent.target._name).substring(0,7) == "_mcFlag")
            {
               var _loc7_ = String(oEvent.target._name).substr(7,2).toLowerCase();
               if(this.api.config.isStreaming)
               {
                  getURL("FSCommand:" add "language",_loc7_);
               }
               else
               {
                  switch(_loc7_)
                  {
                     case "en":
                        this.switchLanguage("en");
                        this.api.datacenter.Basics.aks_detected_country = _loc7_.toUpperCase();
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
                        this.switchLanguage(_loc7_);
                        this.api.datacenter.Basics.aks_detected_country = _loc7_.toUpperCase();
                        this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(_loc7_.toUpperCase());
                        this.saveCommunityAndCountry();
                  }
               }
            }
            else
            {
               var _loc8_ = oEvent.target.params.url;
               if(_loc8_ != undefined && _loc8_ != "")
               {
                  this.getURL(_loc8_,"_blank");
               }
            }
      }
   }
   function onRSSLoadError(oEvent)
   {
      ank.utils.Logger.err("Impossible de charger le fichier RSS");
   }
   function onBadRSSFile(oEvent)
   {
      ank.utils.Logger.err("Fichier RSS invalide");
   }
   function onRSSLoaded(oEvent)
   {
      var _loc3_ = (ank.utils.rss.RSSLoader)oEvent.target;
      var _loc4_ = new ank.utils.ExtendedArray();
      _loc4_.createFromArray(_loc3_.getChannels()[0].getItems());
      this._lstNews.dataProvider = _loc4_;
   }
   function onGifts(oLoadVars, bSuccess)
   {
      var _loc4_ = 0;
      if(bSuccess && !_global.CONFIG.isStreaming)
      {
         var _loc5_ = this.createEmptyMovieClip("_mcMaskGift",this.getNextHighestDepth());
         with(_loc5_)
         {
            beginFill(0,100)
            moveTo(43,400)
            lineTo(703,400)
            lineTo(703,500)
            lineTo(43,500)
            lineTo(43,400)
            
         };
         this._mcGifts.setMask(_loc5_);
         _loc4_ = Number(oLoadVars.c);
         this._aGiftsURLs = new ank.utils.ExtendedArray();
         var _loc6_ = 1;
         while(_loc6_ <= _loc4_)
         {
            var _loc7_ = (ank.gapi.controls.Button)this._mcGifts.attachMovie("Button","btn" + _loc6_,_loc6_,{_x:(_loc6_ - 1) * 131,_width:110,_height:92,backgroundDown:"ButtonTransparentUp",backgroundUp:"ButtonTransparentUp",styleName:"none"});
            _loc7_.addEventListener("over",this);
            _loc7_.addEventListener("out",this);
            _loc7_.addEventListener("click",this);
            _loc7_.params = {description:oLoadVars["d" + _loc6_],url:oLoadVars["u" + _loc6_]};
            this._aGiftsURLs.push({id:_loc6_,url:oLoadVars["g" + _loc6_]});
            var _loc8_ = (ank.gapi.controls.Loader)this._mcGifts.attachMovie("Loader","ldr" + _loc6_,_loc6_ + 100,{_x:(_loc6_ - 1) * 131,_width:110,_height:92});
            _loc8_.addEventListener("error",this);
            _loc8_.contentPath = dofus.Constants.GIFTS_PATH + oLoadVars["g" + _loc6_];
            _loc6_ = _loc6_ + 1;
         }
         if(_loc4_ > 5)
         {
            this._mcArrowRight.gotoAndPlay("on");
         }
      }
      if(_loc4_ == 0 || !bSuccess)
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
         var _loc2_ = 742 / 2 - this._xmouse;
         if(Math.abs(_loc2_) > 300)
         {
            var _loc3_ = this._mcGifts._x + _loc2_ / 40;
            if(_loc2_ > 0)
            {
               if(_loc3_ > 55)
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
                  this._mcGifts._x = _loc3_;
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
            else if(_loc3_ + this._mcGifts._width < 690)
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
               this._mcGifts._x = _loc3_;
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
   function over(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_mcPurple":
            this.gapi.showTooltip(this.api.lang.getText("PURPLE_DOFUS"),oEvent.target,-50);
            break;
         case "_mcEmerald":
            this.gapi.showTooltip(this.api.lang.getText("EMERALD_DOFUS"),oEvent.target,-50);
            break;
         case "_mcTurquoise":
            this.gapi.showTooltip(this.api.lang.getText("TURQUOISE_DOFUS"),oEvent.target,-50);
            break;
         case "_mcEbony":
            this.gapi.showTooltip(this.api.lang.getText("EBONY_DOFUS"),oEvent.target,-50);
            break;
         case "_mcIvory":
            this.gapi.showTooltip(this.api.lang.getText("IVORY_DOFUS"),oEvent.target,-50);
            break;
         case "_mcOchre":
            this.gapi.showTooltip(this.api.lang.getText("OCHRE_DOFUS"),oEvent.target,-50);
            break;
         default:
            if(String(oEvent.target._name).substring(0,7) == "_mcFlag")
            {
               var _loc3_ = String(oEvent.target._name).substr(7,2);
               var _loc4_ = this.api.lang.getText("LANGUAGE_" + _loc3_);
               this.gapi.showTooltip(_loc4_,this["_mcMask" + _loc3_],-20);
            }
            else
            {
               this.gapi.showTooltip(oEvent.target.params.description,oEvent.target,-40);
            }
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function onEvolutionsPostCount(oLoadVars)
   {
      var _loc3_ = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
      this._nForumEvolutionsPostCount = Number(oLoadVars.c);
      var _loc4_ = _loc3_.data.forumEvolutions;
      if(this._nForumEvolutionsPostCount > _loc4_ || _loc4_ == undefined)
      {
         this._mcEvolutionsHighlight._visible = true;
         this._mcEvolutionsHighlight.play();
      }
   }
   function onServersStatePostCount(oLoadVars)
   {
      var _loc3_ = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
      this._nForumServersStatePostCount = Number(oLoadVars.c);
      var _loc4_ = _loc3_.data.forumServersState;
      if(this._nForumServersStatePostCount > _loc4_ || _loc4_ == undefined)
      {
         this._mcServersStateHighlight._visible = true;
         this._mcServersStateHighlight.play();
      }
   }
   function onData()
   {
      var _loc2_ = "<font color=\"#EBE3CB\">";
      var _loc3_ = 0;
      while(_loc3_ < this._siServerStatus.problems.length)
      {
         var _loc4_ = this._siServerStatus.problems[_loc3_];
         _loc2_ = _loc2_ + (_loc4_.date + "\n");
         _loc2_ = _loc2_ + (" <b>" + _loc4_.type + "</b>\n");
         _loc2_ = _loc2_ + (" <i>" + this.api.lang.getText("STATE_WORD") + "</i>: " + _loc4_.status + "\n");
         _loc2_ = _loc2_ + (" <i>" + this.api.lang.getText("INVOLVED_SERVERS") + "</i>: " + _loc4_.servers.join(", ") + "\n");
         _loc2_ = _loc2_ + (" <i>" + this.api.lang.getText("HISTORY_WORD") + "</i>:\n");
         var _loc5_ = 0;
         while(_loc5_ < _loc4_.history.length)
         {
            _loc2_ = _loc2_ + ("  <b>" + _loc4_.history[_loc5_].hour + "</b>");
            if(_loc4_.history[_loc5_].title != "undefined")
            {
               _loc2_ = _loc2_ + (" : " + _loc4_.history[_loc5_].title + "\n   ");
            }
            else
            {
               _loc2_ = _loc2_ + " - ";
            }
            if(_loc4_.history[_loc5_].content != undefined)
            {
               _loc2_ = _loc2_ + _loc4_.history[_loc5_].content;
               if(!_loc4_.history[_loc5_].translated)
               {
                  _loc2_ = _loc2_ + this.api.lang.getText("TRANSLATION_IN_PROGRESS");
               }
            }
            _loc2_ = _loc2_ + "\n";
            _loc5_ = _loc5_ + 1;
         }
         _loc2_ = _loc2_ + "\n";
         _loc3_ = _loc3_ + 1;
      }
      _loc2_ = _loc2_ + "</font>";
      this._taServerStatus.text = _loc2_;
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
   function error(oEvent)
   {
      var _loc3_ = oEvent.target._name.substr(3);
      var _loc4_ = this._aGiftsURLs.findFirstItem("id",_loc3_).item.url;
      this._mcGifts["ldr" + _loc3_].removeEventListener("error",this);
      this._mcGifts["ldr" + _loc3_].contentPath = _loc4_;
   }
   function onCountryLoad(bSuccess)
   {
      var _loc3_ = this._lvCountry.c;
      if(bSuccess && _loc3_.length > 0)
      {
         this.api.datacenter.Basics.aks_detected_country = _loc3_;
         this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(_loc3_);
      }
      else
      {
         this.api.datacenter.Basics.aks_detected_country = this.api.config.language.toUpperCase();
         this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(this.api.datacenter.Basics.aks_detected_country);
      }
      this.updateFromCommunity();
   }
}
