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
	function __set__dataServers(loc2)
	{
		this._aDataServers = loc2;
		return this.__get__dataServers();
	}
	function __get__dataServers()
	{
		return this._aDataServers;
	}
	function __set__language(loc2)
	{
		var loc3 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
		loc3.data.language = loc2;
		loc3.flush();
		return this.__get__language();
	}
	function __get__language()
	{
		var loc2 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.language;
		if(loc2 == undefined || (loc2 == "undefined" || _root.htmlLang != undefined))
		{
			if(_root.htmlLang != undefined)
			{
				var loc3 = _root.htmlLang;
			}
			else
			{
				loc3 = System.capabilities.language;
			}
			if((var loc0 = loc3) !== "fr")
			{
				loop0:
				switch(null)
				{
					default:
						switch(null)
						{
							case "nl":
							case "es":
							case "it":
								break loop0;
							default:
								return "en";
						}
					case "en":
					case "de":
					case "pt":
					case "ru":
				}
			}
			return loc3;
		}
		return loc2.toLowerCase();
	}
	function __set__languages(loc2)
	{
		this._aLanguages = loc2;
		return this.__get__languages();
	}
	function __get__languages()
	{
		var loc2 = new Array();
		if(this._aXmlLanguages != undefined)
		{
			var loc3 = 0;
			while(loc3 < this._aXmlLanguages.length)
			{
				loc2.push(this._aXmlLanguages[loc3]);
				loc3 = loc3 + 1;
			}
		}
		if(this._aLanguages != undefined)
		{
			var loc4 = 0;
			while(loc4 < this._aLanguages.length)
			{
				var loc5 = false;
				var loc6 = 0;
				while(loc6 < this._aXmlLanguages.length)
				{
					if(this._aXmlLanguages[loc6] == this._aLanguages[loc4])
					{
						loc5 = true;
					}
					loc6 = loc6 + 1;
				}
				if(!loc5)
				{
					loc2.push(this._aLanguages[loc4]);
				}
				loc4 = loc4 + 1;
			}
		}
		return loc2;
	}
	function __set__xmlLanguages(loc2)
	{
		this._aXmlLanguages = loc2;
		return this.__get__xmlLanguages();
	}
	function __get__xmlLanguages()
	{
		return this._aXmlLanguages;
	}
	function __set__skipLanguageVerification(loc2)
	{
		this._bSkipLanguageVerification = loc2;
		return this.__get__skipLanguageVerification();
	}
	function __get__skipLanguageVerification()
	{
		return this._bSkipLanguageVerification;
	}
	function __set__cacheAsBitmap(loc2)
	{
		this._aCacheAsBitmap = loc2;
		return this.__get__cacheAsBitmap();
	}
	function __get__cacheAsBitmap()
	{
		return this._aCacheAsBitmap;
	}
	function __set__isExpo(loc2)
	{
		this._bIsExpo = loc2;
		return this.__get__isExpo();
	}
	function __get__isExpo()
	{
		return this._bIsExpo;
	}
	function __set__isStreaming(loc2)
	{
		this._bIsStreaming = loc2;
		return this.__get__isStreaming();
	}
	function __get__isStreaming()
	{
		return this._bIsStreaming;
	}
	function __set__streamingMethod(loc2)
	{
		this._sStreamingMethod = loc2;
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
	function getCustomIP(loc2)
	{
		return this.customServersIP[loc2];
	}
}
