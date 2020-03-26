class dofus.utils.DofusConfiguration
{
   var _bIsStreaming = false;
   function DofusConfiguration()
   {
      if(_global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME] == undefined)
      {
         _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME] = ank.utils.SharedObjectFix.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
      }
   }
   function __set__dataServers(aHosts)
   {
      this._aDataServers = aHosts;
      return this.__get__dataServers();
   }
   function __get__dataServers()
   {
      return this._aDataServers;
   }
   function __set__language(sLanguage)
   {
      var _loc3_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
      _loc3_.data.language = sLanguage;
      _loc3_.flush();
      return this.__get__language();
   }
   function __get__language()
   {
      var _loc2_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.language;
      if(_loc2_ == undefined || (_loc2_ == "undefined" || _root.htmlLang != undefined))
      {
         if(_root.htmlLang != undefined)
         {
            var _loc3_ = _root.htmlLang;
         }
         else
         {
            _loc3_ = System.capabilities.language;
         }
         switch(_loc3_)
         {
            case "fr":
            case "en":
            case "de":
            case "pt":
            case "ru":
            case "nl":
            case "es":
            case "it":
               return _loc3_;
            default:
               return "en";
         }
      }
      else
      {
         return _loc2_.toLowerCase();
      }
   }
   function __set__languages(aLanguages)
   {
      this._aLanguages = aLanguages;
      return this.__get__languages();
   }
   function __get__languages()
   {
      var _loc2_ = new Array();
      if(this._aXmlLanguages != undefined)
      {
         var _loc3_ = 0;
         while(_loc3_ < this._aXmlLanguages.length)
         {
            _loc2_.push(this._aXmlLanguages[_loc3_]);
            _loc3_ = _loc3_ + 1;
         }
      }
      if(this._aLanguages != undefined)
      {
         var _loc4_ = 0;
         while(_loc4_ < this._aLanguages.length)
         {
            var _loc5_ = false;
            var _loc6_ = 0;
            while(_loc6_ < this._aXmlLanguages.length)
            {
               if(this._aXmlLanguages[_loc6_] == this._aLanguages[_loc4_])
               {
                  _loc5_ = true;
               }
               _loc6_ = _loc6_ + 1;
            }
            if(!_loc5_)
            {
               _loc2_.push(this._aLanguages[_loc4_]);
            }
            _loc4_ = _loc4_ + 1;
         }
      }
      return _loc2_;
   }
   function __set__xmlLanguages(a)
   {
      this._aXmlLanguages = a;
      return this.__get__xmlLanguages();
   }
   function __get__xmlLanguages()
   {
      return this._aXmlLanguages;
   }
   function __set__skipLanguageVerification(b)
   {
      this._bSkipLanguageVerification = b;
      return this.__get__skipLanguageVerification();
   }
   function __get__skipLanguageVerification()
   {
      return this._bSkipLanguageVerification;
   }
   function __set__cacheAsBitmap(aCache)
   {
      this._aCacheAsBitmap = aCache;
      return this.__get__cacheAsBitmap();
   }
   function __get__cacheAsBitmap()
   {
      return this._aCacheAsBitmap;
   }
   function __set__isExpo(bExpo)
   {
      this._bIsExpo = bExpo;
      return this.__get__isExpo();
   }
   function __get__isExpo()
   {
      return this._bIsExpo;
   }
   function __set__isStreaming(bStreaming)
   {
      this._bIsStreaming = bStreaming;
      return this.__get__isStreaming();
   }
   function __get__isStreaming()
   {
      return this._bIsStreaming;
   }
   function __set__streamingMethod(sName)
   {
      this._sStreamingMethod = sName;
      return this.__get__streamingMethod();
   }
   function __get__streamingMethod()
   {
      return this._sStreamingMethod;
   }
   function __get__isLinux()
   {
      return String(System.capabilities.version).indexOf("LNX") > -1;
   }
   function __get__isWindows()
   {
      return String(System.capabilities.version).indexOf("WIN") > -1;
   }
   function __get__isMac()
   {
      return String(System.capabilities.version).indexOf("MAC") > -1;
   }
   function getCustomIP(nServerID)
   {
      return this.customServersIP[nServerID];
   }
}
